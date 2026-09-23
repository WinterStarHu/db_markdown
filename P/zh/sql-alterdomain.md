# ALTER DOMAIN

ALTER DOMAIN
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER DOMAINALTER DOMAIN —
更改域的定义
大纲
ALTER DOMAIN name
{ SET DEFAULT expression | DROP DEFAULT }
ALTER DOMAIN name
{ SET | DROP } NOT NULL
ALTER DOMAIN name
ADD domain_constraint [ NOT VALID ]
ALTER DOMAIN name
DROP CONSTRAINT [ IF EXISTS ] constraint_name [ RESTRICT | CASCADE ]
ALTER DOMAIN name
RENAME CONSTRAINT constraint_name TO new_constraint_name
ALTER DOMAIN name
VALIDATE CONSTRAINT constraint_name
ALTER DOMAIN name
OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
ALTER DOMAIN name
RENAME TO new_name
ALTER DOMAIN name
SET SCHEMA new_schema
其中 domain_constraint 是：
[ CONSTRAINT constraint_name ]
{ NOT NULL | CHECK (expression) }
描述
ALTER DOMAIN更改现有域的定义。有几种形式：
SET/DROP DEFAULT
这些形式设置或移除域的默认值。注意默认值只会应用到后续的
INSERT命令，它们不影响使用该域的已经
存在于表中的行。
SET/DROP NOT NULL
这些形式更改一个域是被标记为允许 NULL 值还是拒绝 NULL 值。只有当使用该
域的列不包含 NULL 值时才能SET NOT NULL。
ADD domain_constraint [ NOT VALID ]
此形式向域添加了一个新约束。
当向域添加新约束时，所有使用该域的列将根据新添加的约束进行检查。
通过使用NOT VALID选项添加新约束可以抑制这些检查；
稍后可以使用ALTER DOMAIN ... VALIDATE CONSTRAINT
使约束有效。新插入或更新的行始终会根据所有约束进行检查，
即使是标记为NOT VALID的约束。
NOT VALID仅适用于CHECK约束。
DROP CONSTRAINT [ IF EXISTS ]
这种形式删除一个域上的约束。如果指定了IF EXISTS并且
约束不存在，不会抛出错误。在这种情况下会转而发出一个通知。
RENAME CONSTRAINT
这种形式更改一个域上的约束的名称。
VALIDATE CONSTRAINT
这种形式验证一个之前作为NOT VALID添加的约束，也就是说
它验证该域类型的表列中所有值满足指定的约束。
OWNER
这种形式更改域的拥有者为指定用户。
RENAME
这种形式更改域的名称。
SET SCHEMA
这种形式更改域的模式。任何与该域关联的约束也会移动到新的模式中。
您必须拥有该域才能使用ALTER DOMAIN。
要更改域的模式，您还必须对新模式具有
CREATE权限。
要更改所有者，您必须能够SET ROLE为新的所有者角色，
并且该角色必须对域的模式具有CREATE权限。
（这些限制确保更改所有者不会执行您通过删除和重新创建域
无法完成的操作。然而，超级用户仍然可以更改任何域的所有权。）
参数
name
要修改的一个现有域的名称（可能是模式限定的）。
domain_constraint
用于该域的新域约束。
constraint_name
要删除或重命名的一个现有约束的名称。
NOT VALID
不为约束的合法性验证现有的存储数据。
CASCADE
自动删除依赖于该约束的对象，并且接着删除依赖于那些对象的
所有对象（见第 5.15 节）。
RESTRICT
如果有任何依赖对象则拒绝删除该约束。这是默认行为。
new_name
域的新名称。
new_constraint_name
约束的新名称。
new_owner
域的新拥有者的用户名。
new_schema
域的新模式。
注意事项
尽管ALTER DOMAIN ADD CONSTRAINT尝试验证现有存储的数据是否满足新约束，但此检查不是万无一失的，因为命令无法“see”新插入或更新但尚未提交的表行。
如果存在并发操作可能插入坏数据的危险，则处理方法是使用NOT VALID选项添加约束，提交该命令，等到所有事务在提交完成之前启动，然后发出ALTER DOMAIN VALIDATE CONSTRAINT以搜索违反约束的数据。
此方法是可靠的，因为一旦提交约束，所有新事务都保证针对域类型的新值强制执行约束。
当前，如果域或者任何衍生域被数据库中的任意表的一个容器类型
列（组合、数组、范围类型的列）使用，ALTER DOMAIN ADD CONSTRAINT、ALTER
DOMAIN VALIDATE CONSTRAINT和
ALTER DOMAIN SET NOT NULL将会失败。这些命令最终将
会被改进成能够对这类嵌套值进行约束验证。
示例
要把一个NOT NULL约束加到一个域：
ALTER DOMAIN zipcode SET NOT NULL;
要从一个域中移除一个NOT NULL约束：
ALTER DOMAIN zipcode DROP NOT NULL;
要把一个检查约束增加到一个域：
ALTER DOMAIN zipcode ADD CONSTRAINT zipchk CHECK (char_length(VALUE) = 5);
要从一个域移除检查约束：
ALTER DOMAIN zipcode DROP CONSTRAINT zipchk;
要重命名域上的检查约束：
ALTER DOMAIN zipcode RENAME CONSTRAINT zipchk TO zip_check;
要把域移动到不同的模式：
ALTER DOMAIN zipcode SET SCHEMA customers;
兼容性
ALTER DOMAIN 符合 SQL
标准，除了 OWNER、RENAME、SET SCHEMA
和 VALIDATE CONSTRAINT 变体，它们是
PostgreSQL 的扩展。 ADD CONSTRAINT
变体的 NOT VALID 子句也是一个
PostgreSQL 扩展。
另见CREATE DOMAIN, DROP DOMAIN上一页 上一级 下一页ALTER DEFAULT PRIVILEGES 起始页 ALTER EVENT TRIGGER
