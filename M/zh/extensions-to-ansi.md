# 1.7.1 MySQL 对标准 SQL 的扩展_MySQL 8.0 参考手册

1.7.1 MySQL 对标准 SQL 的扩展_MySQL 8.0 参考手册
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
1.1 关于本手册
1.2 MySQL数据库管理系统概述
1.3 MySQL 8.0 的新特性
1.4 MySQL 8.0 中添加、弃用或删除的服务器和状态变量和选项
1.5 MySQL信息源
1.6 如何报告错误或问题
1.7 MySQL 标准合规性
1.7.1 MySQL 对标准 SQL 的扩展1
1.7.2 MySQL 与标准 SQL 的区别1
1.7.3 MySQL 如何处理约束1
1.8 学分
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
MySQL 8.0 参考手册  / 第一章 一般信息  / 1.7 MySQL 标准合规性  /
1.7.1 MySQL 对标准 SQL 的扩展
1.7.1 MySQL 对标准 SQL 的扩展
MySQL Server 支持一些您不可能在其他 SQL DBMS 中找到的扩展。请注意，如果您使用它们，您的代码很可能无法移植到其他 SQL 服务器。在某些情况下，您可以编写包含 MySQL 扩展但仍然可移植的代码，方法是使用以下形式的注释：
/*! MySQL-specific code */
在这种情况下，MySQL Server 会像处理任何其他 SQL 语句一样解析和执行注释中的代码，但其他 SQL 服务器应该忽略这些扩展。例如，MySQL 服务器识别STRAIGHT_JOIN以下语句中的关键字，但其他服务器不应该：
SELECT /*! STRAIGHT_JOIN */ col1 FROM table1,table2 WHERE ...
如果在该!
字符后加上版本号，则注释中的语法只有在MySQL版本大于或等于指定的版本号时才会执行。以下注释中的KEY_BLOCK_SIZE子句仅由 MySQL 5.1.10 或更高版本的服务器执行：
CREATE TABLE t1(a INT, KEY (a)) /*!50110 KEY_BLOCK_SIZE=1024 */;
以下描述列出了按类别组织的 MySQL 扩展。
磁盘上的数据组织
MySQL Server 将每个数据库映射到 MySQL 数据目录下的一个目录，并将数据库中的表映射到数据库目录中的文件名。因此，在具有区分大小写文件名的操作系统（例如大多数 Unix 系统）上的 MySQL Server 中，数据库和表名称区分大小写。请参阅
第 9.2.3 节，“标识符区分大小写”。
通用语言语法
默认情况下，字符串可以用
"以及括起来'。如果ANSI_QUOTES启用了 SQL 模式，则字符串只能由 括起来
'，服务器将被括起来的字符串解释"为标识符。
\是字符串中的转义字符。
db_name.tbl_name在 SQL 语句中，您可以使用语法
访问来自不同数据库的表
。一些 SQL 服务器提供相同的功能，但将其称为
User space. MySQL Server 不支持像这样的语句中使用的表空间：CREATE TABLE ralph.my_table ... IN
my_tablespace。
SQL语句语法
、ANALYZE TABLE、
CHECK TABLE和
语句
OPTIMIZE TABLE。
REPAIR TABLE
、CREATE DATABASE和
语句DROP DATABASE。
ALTER DATABASE请参阅第 13.1.12 节，“CREATE DATABASE 语句”、
第 13.1.24 节，“DROP DATABASE 语句”和
第 13.1.2 节，“ALTER DATABASE 语句”。
DO声明
。
EXPLAIN
SELECT获取查询优化器如何处理表的描述。
和FLUSH语句
RESET。
SET
声明
。
请参阅第 13.7.6.1 节，“变量赋值的 SET 语法”。
SHOW声明
。请参阅
第 13.7.7 节，“SHOW 语句”。许多特定于 MySQL 的
SHOW语句生成的信​​息可以通过使用
SELECT查询
以更标准的方式获得INFORMATION_SCHEMA。请参阅
第 26 章，INFORMATION_SCHEMA 表。
的使用LOAD DATA。在许多情况下，此语法与 Oracle 兼容
LOAD DATA。请参阅
第 13.2.7 节，“加载数据语句”。
的使用RENAME TABLE。请参阅
第 13.1.36 节，“RENAME TABLE 语句”。
使用 ofREPLACE而不是
DELETEplus
INSERT。请参阅
第 13.2.9 节，“REPLACE 语句”。
在
语句中
使用、
、
或
。在语句中使用多个、
、或
子句
。请参阅第 13.1.9 节，“ALTER TABLE 语句”。
CHANGE
col_nameDROP
col_nameDROP INDEXIGNORERENAMEALTER TABLEADDALTERDROPCHANGEALTER TABLE
索引名称的使用、列前缀上的索引以及语句中的INDEXor
KEY的使用。CREATE
TABLE请参阅
第 13.1.20 节，“CREATE TABLE 语句”。
使用TEMPORARY或IF NOT
EXISTS与CREATE
TABLE。
使用IF EXISTSwith
DROP TABLE和
DROP DATABASE。
使用单个
DROP TABLE语句删除多个表的能力。
and
语句
的ORDER BYand
LIMIT子句
。
UPDATEDELETE
INSERT INTO tbl_name
SET col_name = ...
句法。
and
语句
的DELAYED子句
。INSERTREPLACE、
、
和
语句
的LOW_PRIORITY子句
。INSERTREPLACEDELETEUPDATE在
语句中
使用INTO OUTFILEor 。请参阅
第 13.2.10 节，“SELECT 语句”。
INTO
DUMPFILESELECT
选项如STRAIGHT_JOINor
SQL_SMALL_RESULTin
SELECTstatements。
您不需要在
GROUP BY子句中命名所有选定的列。这为一些非常具体但非常正常的查询提供了更好的性能。请参阅
第 12.20 节，“聚合函数”。
您可以指定ASC和
DESCwith GROUP
BY，而不仅仅是 with ORDER BY。
:=使用赋值运算符
在语句中设置变量的能力
。请参阅
第 9.4 节，“用户定义的变量”。
数据类型
、和
数据类型MEDIUMINT，
以及各种和
数据类型。
SETENUMBLOBTEXT
、AUTO_INCREMENT、
BINARY、NULL和
数据类型属性
UNSIGNED。
ZEROFILL
函数和运算符
为了方便从其他 SQL 环境迁移的用户，MySQL Server 支持许多函数的别名。例如，所有字符串函数都支持标准 SQL 语法和 ODBC 语法。
MySQL Server 将
||and
&&
运算符理解为逻辑 OR 和 AND，就像在 C 编程语言中一样。在 MySQL 服务器中，
||和
OR是同义词，就像
&&
和一样AND。由于这种良好的语法，MySQL 服务器不支持
||用于字符串连接的标准 SQL 运算符；改用
CONCAT()。因为
CONCAT()接受任意数量的参数，所以很容易将
||运算符的使用转换为 MySQL 服务器。
使用where
有多个元素。
COUNT(DISTINCT
value_list)value_list
默认情况下，字符串比较不区分大小写，排序顺序由当前字符集的排序规则决定，这是utf8mb4默认情况。要改为执行区分大小写的比较，您应该使用该
BINARY属性声明您的列或使用
BINARY强制转换，这会导致使用底层字符代码值而不是词汇顺序进行比较。
运算符是的%
同义词
MOD()。也就是说，
相当于
.
支持 C 程序员并与 PostgreSQL 兼容。
N %
MMOD(N,M)%
, =,
<>,
<=,
<,
>=,
>,
<<,
>>,
<=>,
AND,
OR或
LIKE
运算符可用于语句中输出列列表（在 的左侧FROM）的SELECT表达式中。例如：
mysql> SELECT col1=1 AND col2=2 FROM my_table;
该LAST_INSERT_ID()
函数返回最近的
AUTO_INCREMENT值。请参阅
第 12.16 节，“信息功能”。
LIKE在数值上是允许的。
TheREGEXP和
NOT REGEXP扩展的正则表达式运算符。
CONCAT()或
CHAR()带有一个参数或两个以上的参数。（在 MySQL 服务器中，这些函数可以采用可变数量的参数。）
, BIT_COUNT(),
CASE,
ELT(),
FROM_DAYS(),
FORMAT(),
IF(),
MD5(),
PERIOD_ADD(),
PERIOD_DIFF()和
功能
TO_DAYS()。
WEEKDAY()
使用 ofTRIM()修剪子字符串。标准 SQL 仅支持删除单个字符。
GROUP BY函数
STD()、
BIT_OR()、
BIT_AND()、
BIT_XOR()和
GROUP_CONCAT()。
_ 请参阅
第 12.20 节，“聚合函数”。
© Mysql 中文网
