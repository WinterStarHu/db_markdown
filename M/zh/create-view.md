# 13.1.23 CREATE VIEW 语句_MySQL 8.0 参考手册

13.1.23 CREATE VIEW 语句_MySQL 8.0 参考手册
Skip to Main Content
Documentation
MySQL手册
MySQL企业版
工作台
InnoDB集群
MySQL NDB集群
连接器
Section Menu:
Documentation Home
MySQL 8.0 参考手册
前言和法律声明
第一章 一般信息
第 2 章安装和升级 MySQL
第 3 章教程
第 4 章 MySQL 程序
第 5 章 MySQL 服务器管理
第 6 章 安全
第 7 章备份与恢复
第8章优化
第9章语言结构
第 10 章字符集、排序规则、Unicode
第 11 章数据类型
第 12 章函数和运算符
第 13 章 SQL 语句
13.1 数据定义语句
13.1.1 原子数据定义语句支持1
13.1.2 ALTER DATABASE 语句1
13.1.3 ALTER EVENT 语句1
13.1.4 ALTER FUNCTION 语句1
13.1.5 ALTER INSTANCE 语句1
13.1.6 ALTER LOGFILE GROUP 语句1
13.1.7 ALTER PROCEDURE 语句1
13.1.8 ALTER SERVER 语句1
13.1.9 ALTER TABLE 语句1
13.1.10 ALTER TABLESPACE 语句1
13.1.11 ALTER VIEW 语句1
13.1.12 CREATE DATABASE 语句1
13.1.13 CREATE EVENT 语句1
13.1.14 CREATE FUNCTION 语句1
13.1.15 CREATE INDEX 语句1
13.1.16 CREATE LOGFILE GROUP 语句1
13.1.17 CREATE PROCEDURE 和 CREATE FUNCTION 语句1
13.1.18 CREATE SERVER 语句1
13.1.19 CREATE SPATIAL REFERENCE SYSTEM 语句1
13.1.20 CREATE TABLE 语句1
13.1.21 CREATE TABLESPACE 语句1
13.1.22 CREATE TRIGGER 语句1
13.1.23 CREATE VIEW 语句1
13.1.24 DROP DATABASE 语句1
13.1.25 DROP EVENT 语句1
13.1.26 DROP FUNCTION 语句1
13.1.27 DROP INDEX 语句1
13.1.28 DROP LOGFILE GROUP 语句1
13.1.29 DROP PROCEDURE 和 DROP FUNCTION 语句1
13.1.30 DROP SERVER 语句1
13.1.31 DROP SPATIAL REFERENCE SYSTEM 语句1
13.1.32 DROP TABLE 语句1
13.1.33 DROP TABLESPACE 语句1
13.1.34 DROP TRIGGER 语句1
13.1.35 DROP VIEW 语句1
13.1.36 RENAME TABLE 语句1
13.1.37 TRUNCATE TABLE 语句1
13.2 数据操作语句
13.3 事务和锁定语句
13.4 复制语句
13.5 准备好的语句
13.6 复合语句语法
13.7 数据库管理语句
13.8 效用语句
第14章MySQL数据字典
第 15 章 InnoDB 存储引擎
第 16 章替代存储引擎
第十七章复制
第十八章 组复制
第十九章MySQL Shell
第 20 章使用 MySQL 作为文档存储
第21章InnoDB Cluster
第 22 章 InnoDB 副本集
第 23 章 MySQL NDB Cluster 8.0
第24章分区
第25章存储对象
第 26 章 INFORMATION_SCHEMA 表
第 27 章 MySQL 性能模式
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 13 章 SQL 语句  / 13.1 数据定义语句  /
13.1.23 CREATE VIEW 语句
13.1.23 CREATE VIEW 语句
CREATE
[OR REPLACE]
[ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
[DEFINER = user]
[SQL SECURITY { DEFINER | INVOKER }]
VIEW view_name [(column_list)]
AS select_statement
[WITH [CASCADED | LOCAL] CHECK OPTION]
该语句创建一个新视图，或者如果给出子句则CREATE VIEW替换现有视图。OR
REPLACE如果视图不存在，
CREATE OR REPLACE
VIEW则与 相同CREATE
VIEW。如果视图确实存在，
CREATE OR REPLACE
VIEW则替换它。
有关视图使用限制的信息，请参阅
第 25.9 节，“视图限制”。
select_statement是
SELECT提供视图定义的语句
。（从视图中选择实际上是使用SELECT
语句select_statement进行选择。）可以从基表、其他视图中选择。从 MySQL 8.0.19 开始，SELECT语句可以使用
VALUES语句作为其来源，也可以替换为TABLE
语句，如
CREATE TABLE
... SELECT.
视图定义在创建时被“冻结”，并且不受随后对基础表定义的更改的影响。例如，如果视图定义为
SELECT *在表上，则以后添加到表中的新列不会成为视图的一部分，并且从表中删除的列会导致在从视图中进行选择时出错。
该ALGORITHM子句影响 MySQL 如何处理视图。DEFINERand
SQL SECURITY子句指定在视图调用时检查访问权限时要使用的安全上下文。WITH CHECK OPTION可以给出该子句以限制对视图引用的表中的行的插入或更新。这些子句将在本节后面描述。
该CREATE VIEW语句需要CREATE VIEW视图的权限，以及语句选择的每个列的一些权限
SELECT。对于SELECT语句中别处使用的列，您必须具有SELECT权限。如果OR REPLACE存在该子句，您还必须拥有DROP视图的权限。如果DEFINER存在该子句，则所需的权限取决于user
值，如第 25.6 节“存储对象访问控制”中所述。
引用视图时，将进行权限检查，如本节后面所述。
视图属于数据库。默认情况下，在默认数据库中创建一个新视图。要在给定数据库中显式创建视图，请使用db_name.view_name语法用数据库名称限定视图名称：
CREATE VIEW test.v AS SELECT * FROM t;
语句中未限定的表或视图名称
SELECT也相对于默认数据库进行解释。通过使用适当的数据库名称限定表或视图名称，视图可以引用其他数据库中的表或视图。
在数据库中，基表和视图共享相同的命名空间，因此基表和视图不能重名。
语句检索的列SELECT
可以是对表列的简单引用，也可以是使用函数、常量值、运算符等的表达式。
视图必须具有唯一的列名且不能重复，就像基表一样。默认情况下，SELECT语句检索的列名用于视图列名。要为视图列定义显式名称，请将可选
column_list子句指定为逗号分隔标识符列表。中的姓名数
column_list必须与
SELECT语句检索的列数相同。
可以从多种
SELECT语句创建视图。它可以引用基表或其他视图。它可以使用连接、
UNION查询和子查询。SELECT甚至不需要引用任何表格
：
CREATE VIEW v_today (today) AS SELECT CURRENT_DATE;
以下示例定义了一个视图，该视图从另一个表中选择两列以及根据这些列计算的表达式：
mysql> CREATE TABLE t (qty INT, price INT);
mysql> INSERT INTO t VALUES(3, 50);
mysql> CREATE VIEW v AS SELECT qty, price, qty*price AS value FROM t;
mysql> SELECT * FROM v;
+------+-------+-------+
| qty  | price | value |
+------+-------+-------+
|    3 |    50 |   150 |
+------+-------+-------+
视图定义受以下限制：
该SELECT语句不能引用系统变量或用户定义的变量。
在存储程序中，
SELECT语句不能引用程序参数或局部变量。
该SELECT语句不能引用准备好的语句参数。
定义中引用的任何表或视图都必须存在。如果在创建视图后删除定义引用的表或视图，则使用该视图会导致错误。要检查此类问题的视图定义，请使用该CHECK TABLE语句。
定义不能引用TEMPORARY
表，也不能创建TEMPORARY
视图。
您不能将触发器与视图相关联。
SELECT根据 64 个字符的最大列长度（而不是 256 个字符的最大别名长度）检查语句中
列名的
别名。
ORDER BY在视图定义中是允许的，但如果您使用具有自己的语句从视图中进行选择，则会忽略它ORDER BY。
对于定义中的其他选项或子句，将它们添加到引用视图的语句的选项或子句中，但效果未定义。例如，如果视图定义包含一个LIMIT子句，并且您使用具有自己的
LIMIT子句的语句从视图中进行选择，则不确定应用哪个限制。同样的原则适用于关键字后的选项，例如
ALL,DISTINCT或
SQL_SMALL_RESULT，
SELECT以及子句，例如INTO, FOR UPDATE,
FOR SHARE,LOCK IN SHARE
MODE和PROCEDURE。
如果您通过更改系统变量来更改查询处理环境，则可能会影响从视图获得的结果：
mysql> CREATE VIEW v (mycol) AS SELECT 'abc';
Query OK, 0 rows affected (0.01 sec)
mysql> SET sql_mode = '';
Query OK, 0 rows affected (0.00 sec)
mysql> SELECT "mycol" FROM v;
+-------+
| mycol |
+-------+
| mycol |
+-------+
1 row in set (0.01 sec)
mysql> SET sql_mode = 'ANSI_QUOTES';
Query OK, 0 rows affected (0.00 sec)
mysql> SELECT "mycol" FROM v;
+-------+
| mycol |
+-------+
| abc   |
+-------+
1 row in set (0.00 sec)DEFINER和子句确定
在SQL SECURITY
执行引用视图的语句时检查视图的访问权限时使用哪个 MySQL 帐户。有效的SQL SECURITY
特征值为DEFINER（默认值）和INVOKER。这些表明所需的权限必须分别由定义或调用视图的用户持有。
如果DEFINER存在该子句，则该
user值应该是指定为 、 或 的
MySQL
帐户
。允许的
值取决于您拥有的权限，如
第 25.6 节“存储对象访问控制”中所述。另请参阅该部分以获取有关视图安全性的其他信息。
'user_name'@'host_name'CURRENT_USERCURRENT_USER()user
如果DEFINER省略该子句，则默认定义者是执行该CREATE
VIEW语句的用户。这与明确指定相同
DEFINER = CURRENT_USER。
在视图定义中，该
CURRENT_USER函数默认返回视图的DEFINER值。对于使用SQL SECURITY INVOKER
特征定义的视图，CURRENT_USER
返回视图调用者的帐户。有关视图中用户审计的信息，请参阅
第 6.2.23 节，“基于 SQL 的帐户活动审计”。
SQL
SECURITY DEFINER在用特性
定义的存储例程中，CURRENT_USER返回例程的
DEFINER值。如果视图定义包含
DEFINER值 ，
这也会影响在此类例程中定义的视图CURRENT_USER。
MySQL 像这样检查视图权限：
在视图定义时，视图创建者必须具有使用视图访问的顶级对象所需的权限。例如，如果视图定义引用表列，则创建者必须对定义的选择列表中的每一列具有某些特权，并且对定义中
SELECT其他地方使用的每一列具有特权。如果定义引用存储函数，则只能检查调用该函数所需的权限。函数调用时所需的权限只能在函数执行时进行检查：对于不同的调用，可能会采用函数内的不同执行路径。
引用视图的用户必须具有适当的权限才能访问它（SELECT
从中进行选择、INSERT向其中插入等等。）
引用视图时，将根据视图帐户或调用者持有的特权检查视图访问的对象的特权DEFINER，具体取决于SQL SECURITY
特征是DEFINER还是
INVOKER。
如果对视图的引用导致存储函数的执行，则在函数内执行的语句的特权检查取决于函数SQL SECURITY
特征是DEFINER还是
INVOKER。如果安全特性为
DEFINER，则该函数以该DEFINER帐户的权限运行。如果特性是，则函数以视图的特性
INVOKER确定的权限运行。SQL
SECURITY
示例：视图可能依赖于存储函数，而该函数可能会调用其他存储例程。例如，以下视图调用存储函数f()：
CREATE VIEW v AS SELECT * FROM t WHERE t.id = f(t.name);
假设f()包含如下语句：
IF name IS NULL then
CALL p1();
ELSE
CALL p2();
END IF;f()执行的时候需要检查
里面执行语句需要的权限
f()。p1()这可能意味着或需要特权p2()，具体取决于f(). 这些权限必须在运行时检查，必须拥有权限的用户由SQL
SECURITY视图v和函数的值决定f()。
视图的DEFINER和SQL SECURITY
子句是标准 SQL 的扩展。在标准 SQL 中，视图是使用SQL SECURITY
DEFINER. 该标准规定，视图的定义者（与视图架构的所有者相同）获得视图的适用权限（例如，
SELECT）并可以授予这些权限。MySQL 没有模式“所有者”的概念，因此 MySQL 添加了一个子句来标识定义者。该DEFINER
条款是一个扩展，其目的是拥有标准所具有的内容；也就是说，谁定义了视图的永久记录。这就是为什么默认DEFINER值为视图创建者的帐户。
可选ALGORITHM子句是 MySQL 对标准 SQL 的扩展。它会影响 MySQL 处理视图的方式。ALGORITHM取三个值：
MERGE、TEMPTABLE或
UNDEFINED。有关更多信息，请参阅
第 25.5.2 节，“视图处理算法”，以及
第 8.2.2.4 节，“使用合并或实现优化派生表、视图引用和公用表表达式”。
一些视图是可更新的。也就是说，您可以在 、 或 等语句中使用它们UPDATE来
DELETE更新
INSERT基础表的内容。对于可更新的视图，视图中的行与基础表中的行之间必须存在一对一的关系。还有某些其他构造使视图不可更新。
视图中生成的列被认为是可更新的，因为它可以分配给它。但是，如果显式更新此类列，则唯一允许的值为
DEFAULT. 有关生成的列的信息，请参阅第 13.1.20.8 节，“CREATE TABLE 和生成的列”。
可以为可更新视图提供该子句，以防止插入或更新行，但子句
为真的
WITH CHECK OPTION行除外。WHEREselect_statement
在WITH CHECK OPTION可更新视图的子句中，LOCAL和CASCADED
关键字确定根据另一个视图定义视图时检查测试的范围。LOCAL
关键字将 only 限制为正在CHECK OPTION定义的视图。CASCADED导致对基础视图的检查也被评估。当两个关键字都没有给出时，默认为CASCADED.
有关可更新视图和WITH
CHECK OPTION子句的更多信息，请参阅
第 25.5.3 节，“可更新和可插入的视图”和
第 25.5.4 节，“视图 WITH CHECK OPTION 子句”。
© Mysql 中文网
