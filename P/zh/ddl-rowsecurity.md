# 5.9. 行级安全策略

5.9. 行级安全策略
版本：
纠错本页面
搜索
目录导航
❮
❯
5.9. 行级安全策略 #
除可以通过GRANT使用 SQL 标准的
特权系统之外，表还可以具有
行安全性策略，它针对每一个用户限制哪些行可以
被普通的查询返回或者可以被数据修改命令插入、更新或删除。这种
特性也被称为行级安全性。默认情况下，表不具有
任何策略，这样用户根据 SQL 特权系统具有对表的访问特权，对于
查询或更新来说其中所有的行都是平等的。
当在一个表上启用行安全性时（使用
ALTER TABLE ... ENABLE ROW LEVEL
SECURITY），所有对该表选择行或者修改行的普通访问都必须被一条
行安全性策略所允许（不过，表的拥有者通常不受行安全性策略的限制）。如果
表上不存在策略，将使用一条默认的否定策略，即所有的行都不可见或者不能
被修改。应用在整个表上的操作不受行安全性限制，例如TRUNCATE和
REFERENCES。
行安全性策略可以针对特定的命令、角色或者两者。一条策略可以被指定为
适用于ALL命令，或者SELECT、
INSERT、UPDATE、或者DELETE。
可以为一条给定策略分配多个角色，并且通常的角色成员关系和继承规则也适用。
要指定哪些行根据一条策略是可见的或者是可修改的，需要一个返回布尔结果
的表达式。对于每一行，在计算任何来自用户查询的条件或函数之前，先会计
算这个表达式（这条规则的唯一例外是leakproof函数，
它们被保证不会泄露信息，优化器可能会选择在行安全性检查之前应用这类
函数）。使该表达式不返回true的行将不会被处理。可以指定
独立的表达式来单独控制哪些行可见以及哪些行被允许修改。策略表达式会作
为查询的一部分运行并且带有运行该查询的用户的特权，但是安全性定义者函数
可以被用来访问对调用用户不可用的数据。
具有BYPASSRLS属性的超级用户和角色在访问一个表时总是
可以绕过行安全性系统。表拥有者通常也能绕过行安全性，不过表拥有者
可以选择用ALTER
TABLE ... FORCE ROW LEVEL SECURITY来服从行安全性。
启用和禁用行安全性以及向表增加策略是只有表拥有者具有的特权。
策略的创建可以使用CREATE POLICY命令，策略的修改
可以使用ALTER POLICY命令，而策略的删除可以使用
DROP POLICY命令。要为一个给定表启用或者禁用行
安全性，可以使用ALTER TABLE命令。
每一条策略都有名称并且可以为一个表定义多条策略。由于策略是表相
关的，一个表的每一条策略都必须有一个唯一的名称。不同的表可以拥有
相同名称的策略。
当多个策略适用于给定查询时，它们会使用
OR（对于宽松策略，这是默认值）或
AND（对于严格策略）进行组合。
OR 行为类似于给定角色拥有其成员
所有角色的权限。宽松策略与严格策略将在下面进一步讨论。
作为一个简单的例子，这里是如何在account关系上
创建一条策略以允许只有managers角色的成员能访问行，
并且只能访问他们账户的行：
CREATE TABLE accounts (manager text, company text, contact_email text);
ALTER TABLE accounts ENABLE ROW LEVEL SECURITY;
CREATE POLICY account_managers ON accounts TO managers
USING (manager = current_user);
上面的策略隐含地提供了一个与其USING子句相同的
WITH CHECK子句，以便约束适用于被一个命令选择的行（这样一个经理
不能SELECT、UPDATE或DELETE
属于其他经理的已有行）以及被一个命令修改的行（这样属于其他经理的行
不能通过INSERT或UPDATE创建）。
如果没有指定角色或者使用了特殊的用户名PUBLIC，
则该策略适用于系统上所有的用户。要允许所有用户访问users
表中属于他们自己的行，可以使用一条简单的策略：
CREATE POLICY user_policy ON users
USING (user_name = current_user);
这个例子的效果和前一个类似。
为了对增加到表中的行使用与可见行不同的策略，可以组合多条策略。这一对策略将允许所有用户查看users表中的所有行，但只能修改他们自己的行：
CREATE POLICY user_sel_policy ON users
FOR SELECT
USING (true);
CREATE POLICY user_mod_policy ON users
USING (user_name = current_user);
在一个SELECT命令中，这两条规则被用OR组合在一起，最终的效应就是所有的行都能被选择。在其他命令类型中，只有第二条策略适用，这样其效果就和以前相同。
也可以用ALTER TABLE命令禁用行安全性。禁用行安全性
不会移除定义在表上的任何策略，它们只是被简单地忽略。然后该表中的所有
行都是可见的并且可修改，服从于标准的 SQL 特权系统。
下面是一个较大的例子，它展示了这种特性如何被用于生产环境。表
passwd模拟了一个 Unix 口令文件：
-- 简单的口令文件例子
CREATE TABLE passwd (
user_name             text UNIQUE NOT NULL,
pwhash                text,
uid                   int  PRIMARY KEY,
gid                   int  NOT NULL,
real_name             text NOT NULL,
home_phone            text,
extra_info            text,
home_dir              text NOT NULL,
shell                 text NOT NULL
);
CREATE ROLE admin;  -- 管理员
CREATE ROLE bob;    -- 普通用户
CREATE ROLE alice;  -- 普通用户
-- 填充表
INSERT INTO passwd VALUES
('admin','xxx',0,0,'Admin','111-222-3333',null,'/root','/bin/dash');
INSERT INTO passwd VALUES
('bob','xxx',1,1,'Bob','123-456-7890',null,'/home/bob','/bin/zsh');
INSERT INTO passwd VALUES
('alice','xxx',2,1,'Alice','098-765-4321',null,'/home/alice','/bin/zsh');
-- 确保在表上启用行级安全性
ALTER TABLE passwd ENABLE ROW LEVEL SECURITY;
-- 创建策略
-- 管理员能看见所有行并且增加任意行
CREATE POLICY admin_all ON passwd TO admin USING (true) WITH CHECK (true);
-- 普通用户可以看见所有行
CREATE POLICY all_view ON passwd FOR SELECT USING (true);
-- 普通用户可以更新它们自己的记录，但是限制普通用户可用的 shell
CREATE POLICY user_mod ON passwd FOR UPDATE
USING (current_user = user_name)
WITH CHECK (
current_user = user_name AND
shell IN ('/bin/bash','/bin/sh','/bin/dash','/bin/zsh','/bin/tcsh')
);
-- 允许管理员有所有普通权限
GRANT SELECT, INSERT, UPDATE, DELETE ON passwd TO admin;
-- 用户只在公共列上得到选择访问
GRANT SELECT
(user_name, uid, gid, real_name, home_phone, extra_info, home_dir, shell)
ON passwd TO public;
-- 允许用户更新特定列
GRANT UPDATE
(pwhash, real_name, home_phone, extra_info, shell)
ON passwd TO public;
对于任意安全性设置来说，重要的是测试并确保系统的行为符合预期。
使用上述的例子，下面展示了权限系统工作正确：
-- admin can view all rows and fields
postgres=> set role admin;
SET
postgres=> table passwd;
user_name | pwhash | uid | gid | real_name |  home_phone  | extra_info | home_dir    |   shell
-----------+--------+-----+-----+-----------+--------------+------------+-------------+-----------
admin     | xxx    |   0 |   0 | Admin     | 111-222-3333 |            | /root       | /bin/dash
bob       | xxx    |   1 |   1 | Bob       | 123-456-7890 |            | /home/bob   | /bin/zsh
alice     | xxx    |   2 |   1 | Alice     | 098-765-4321 |            | /home/alice | /bin/zsh
(3 rows)
-- Test what Alice is able to do
postgres=> set role alice;
SET
postgres=> table passwd;
ERROR:  permission denied for table passwd
postgres=> select user_name,real_name,home_phone,extra_info,home_dir,shell from passwd;
user_name | real_name |  home_phone  | extra_info | home_dir    |   shell
-----------+-----------+--------------+------------+-------------+-----------
admin     | Admin     | 111-222-3333 |            | /root       | /bin/dash
bob       | Bob       | 123-456-7890 |            | /home/bob   | /bin/zsh
alice     | Alice     | 098-765-4321 |            | /home/alice | /bin/zsh
(3 rows)
postgres=> update passwd set user_name = 'joe';
ERROR:  permission denied for table passwd
-- Alice is allowed to change her own real_name, but no others
postgres=> update passwd set real_name = 'Alice Doe';
UPDATE 1
postgres=> update passwd set real_name = 'John Doe' where user_name = 'admin';
UPDATE 0
postgres=> update passwd set shell = '/bin/xx';
ERROR:  new row violates WITH CHECK OPTION for "passwd"
postgres=> delete from passwd;
ERROR:  permission denied for table passwd
postgres=> insert into passwd (user_name) values ('xxx');
ERROR:  permission denied for table passwd
-- Alice can change her own password; RLS silently prevents updating other rows
postgres=> update passwd set pwhash = 'abc';
UPDATE 1
目前为止所有构建的策略都是宽容性策略，也就是当多条策略都适用时会被适用“OR”布尔操作符组合在一起。而宽容性策略可以被用来仅允许在预计情况中对行的访问，这比将宽容性策略与限制性策略（记录必须通过这类策略并且它们会被“AND”布尔操作符组合起来）组合在一起更简单。在上面的例子之上，我们增加一条限制性策略要求通过一个本地Unix套接字连接过来的管理员访问passwd表的记录：
CREATE POLICY admin_local_only ON passwd AS RESTRICTIVE TO admin
USING (pg_catalog.inet_client_addr() IS NULL);
然后，由于这条限制性政策的存在，我们可以看到从网络连接进来的管理员将无法看到任何记录：
=> SELECT current_user;
current_user
--------------
admin
(1 row)
=> select inet_client_addr();
inet_client_addr
------------------
127.0.0.1
(1 row)
=> TABLE passwd;
user_name | pwhash | uid | gid | real_name | home_phone | extra_info | home_dir | shell
-----------+--------+-----+-----+-----------+------------+------------+----------+-------
(0 rows)
=> UPDATE passwd set pwhash = NULL;
UPDATE 0
参照完整性检查（例如唯一或主键约束和外键引用）总是会绕过行级安全性以
保证数据完整性得到维护。在开发模式和行级策略时必须小心避免
“隐通道”通过这类参照完整性检查泄露信息。
在某些环境中确保行安全性没有被应用很重要。例如，在做备份时，如果
行安全性悄悄地导致某些行被从备份中忽略掉，这会是灾难性的。在这类
情况下，你可以设置row_security配置参数为
off。这本身不会绕过行安全性，它所做的是如果任何查询的结果会
被一条策略过滤掉，就会抛出一个错误。然后错误的原因就可以被找到并且
修复。
在上面的例子中，策略表达式只考虑了要被访问的行中的当前值。这是最简
单并且表现最好的情况。如果可能，最好设计行安全性应用以这种方式工作。
如果需要参考其他行或者其他表来做出策略的决定，可以在策略表达式中通过
使用子-SELECT或者包含SELECT的函数
来实现。不过要注意这类访问可能会导致竞争条件，在不小心的情况下这可能
会导致信息泄露。作为一个例子，考虑下面的表设计：
--- 特权组的定义
CREATE TABLE groups (group_id int PRIMARY KEY,
group_name text NOT NULL);
INSERT INTO groups VALUES
(1, 'low'),
(2, 'medium'),
(5, 'high');
GRANT ALL ON groups TO alice;  --- alice 是管理员
GRANT SELECT ON groups TO public;
--- 用户的特权级别的定义
CREATE TABLE users (user_name text PRIMARY KEY,
group_id int NOT NULL REFERENCES groups);
INSERT INTO users VALUES
('alice', 5),
('bob', 2),
('mallory', 2);
GRANT ALL ON users TO alice;
GRANT SELECT ON users TO public;
--- 保存要被保护的信息的表
CREATE TABLE information (info text,
group_id int NOT NULL REFERENCES groups);
INSERT INTO information VALUES
('barely secret', 1),
('slightly secret', 2),
('very secret', 5);
ALTER TABLE information ENABLE ROW LEVEL SECURITY;
--- 对于安全性 group_id 大于等于一行的 group_id 的用户，
--- 这一行应该是可见的/可更新的
CREATE POLICY fp_s ON information FOR SELECT
USING (group_id <= (SELECT group_id FROM users WHERE user_name = current_user));
CREATE POLICY fp_u ON information FOR UPDATE
USING (group_id <= (SELECT group_id FROM users WHERE user_name = current_user));
--- 我们只依赖于行级安全性来保护信息表
GRANT ALL ON information TO public;
现在假设alice希望更改“稍微秘密”
的信息，但是觉得mallory不应该看到该行中的新
内容，因此她这样做：
BEGIN;
UPDATE users SET group_id = 1 WHERE user_name = 'mallory';
UPDATE information SET info = 'secret from mallory' WHERE group_id = 2;
COMMIT;
这看起来是安全的，没有窗口可供mallory看到
“对 mallory 保密”的字符串。不过，这里有一种
竞争条件。如果mallory正在并行地做：
SELECT * FROM information WHERE group_id = 2 FOR UPDATE;
并且她的事务处于READ COMMITTED模式，她就可能看到
“对 mallory 保密”的东西。如果她的事务在alice
做完之后就到达information行，这就会发生。它会阻塞等待
alice的事务提交，然后拜FOR UPDATE子句所赐
取得更新后的行内容。不过，对于来自users的隐式
SELECT，它不会取得一个已更新的行，
因为子-SELECT没有FOR UPDATE，相反
会使用查询开始时取得的快照读取users行。因此，
策略表达式会测试mallory的特权级别的旧值并且允许她看到
被更新的行。
有多种方法能解决这个问题。一种简单的答案是在行安全性策略中的
子-SELECT里使用SELECT ... FOR SHARE。
不过，这要求在被引用表（这里是users）上授予
UPDATE特权给受影响的用户，这可能不是我们想要的（
但是另一条行安全性策略可能被应用来阻止它们实际使用这个特权，或者
子-SELECT可能被嵌入到一个安全性定义者函数中）。
还有，在被引用的表上过多并发地使用行共享锁可能会导致性能问题，
特别是表更新比较频繁时。另一种解决方案（如果被引用表上的更新
不频繁就可以行）是在更新被引用表时对它取一个ACCESS EXCLUSIVE锁，
这样就没有并发事务能够检查旧的行值了。或者我们可以在提交对被引用表的更新
之后、在做依赖于新安全性情况的更改之前等待所有并发事务结束。
更多细节请见CREATE POLICY
和ALTER TABLE。
上一页 上一级 下一页5.8. 权限 起始页 5.10. 模式
