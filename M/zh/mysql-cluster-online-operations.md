# 23.6.11 在 NDB Cluster 中使用 ALTER TABLE 进行在线操作_MySQL 8.0 参考手册

23.6.11 在 NDB Cluster 中使用 ALTER TABLE 进行在线操作_MySQL 8.0 参考手册
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
23.1 一般信息
23.2 NDB Cluster 概述
23.3 NDB Cluster 安装
23.4 NDB Cluster的配置
23.5 NDB 集群程序
23.6 NDB Cluster的管理
23.6.1 NDB Cluster Management Client 中的命令1
23.6.2 NDB Cluster 日志消息1
23.6.3 NDB Cluster 中生成的事件报告1
23.6.4 NDB Cluster 启动阶段总结1
23.6.5 执行 NDB Cluster 的滚动重启1
23.6.6 NDB Cluster 单用户模式1
23.6.7 在线添加 NDB Cluster 数据节点1
23.6.8 NDB Cluster 在线备份1
23.6.9 NDB Cluster 的 MySQL 服务器使用1
23.6.10 NDB Cluster 磁盘数据表1
23.6.11 在 NDB Cluster 中使用 ALTER TABLE 进行在线操作1
23.6.12 权限同步和 NDB_STORED_USER1
23.6.13 NDB Cluster 的文件系统加密1
23.6.14 NDB API 统计计数器和变量1
23.6.15 ndbinfo：NDB 集群信息数据库1
23.6.16 NDB Cluster 的 INFORMATION_SCHEMA 表1
23.6.17 NDB Cluster 和性能模式1
23.6.18 快速参考：NDB Cluster SQL 语句1
23.6.19 NDB Cluster 安全问题1
23.6.9 导入数据到MySQL集群1
23.7 NDB 集群复制
23.8 NDB Cluster 发行说明
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.6 NDB Cluster的管理  /
23.6.11 在 NDB Cluster 中使用 ALTER TABLE 进行在线操作
23.6.11 在 NDB Cluster 中使用 ALTER TABLE 进行在线操作
MySQL NDB Cluster 8.0 支持使用
ALTER
TABLE ... ALGORITHM=DEFAULT|INPLACE|COPY. NDB Cluster 处理COPY并INPLACE在接下来的几段中描述。
对于ALGORITHM=COPY，
mysqld NDB Cluster 处理程序执行以下操作：
告诉数据节点创建表的空副本，并对此副本进行所需的模式更改。
从原始表中读取行，并将它们写入副本。
告诉数据节点删除原始表，然后重命名副本。
我们有时将此称为“复制”或
“离线” ALTER TABLE。
DML 操作不允许与复制同时进行
ALTER TABLE。
发出复制语句
的mysqldALTER
TABLE需要元数据锁，但这仅对该mysqld有效。其他
NDB客户端可以在复制过程中修改行数据ALTER TABLE，从而导致不一致。
对于ALGORITHM=INPLACE，NDB Cluster 处理程序告诉数据节点进行所需的更改，并且不执行任何数据复制。
我们也将此称为“非复制”或
“在线” ALTER TABLE。
非复制ALTER TABLE允许并发 DML 操作。
ALGORITHM=INSTANTNDB 8.0 不支持。
无论使用何种算法，mysqld
在执行ALTER TABLE时都会使用全局模式锁 (GSL) ；这可以防止在集群中的这个或任何其他 SQL 节点上同时执行任何（其他）DDL 或备份。这通常没有问题，除非ALTER
TABLE需要很长时间。
笔记
NDB Cluster 的一些旧版本使用特定
NDB于在线ALTER
TABLE操作的语法。该语法已被删除。
在表的可变宽度列上添加和删除索引的操作
NDB在线发生。在线操作是不可复制的；也就是说，它们不需要重新创建索引。他们不会锁定被 NDB Cluster 中其他 API 节点访问的表（但请参阅
本节后面的 NDB 在线操作的限制）。NDB对于在具有多个 API 节点的 NDB 集群中进行的表更改，此类操作不需要单用户模式
；事务可以在在线 DDL 操作期间不间断地继续。
ALGORITHM=INPLACE可用于对表进行联机
ADD COLUMN、ADD INDEX
（包括CREATE INDEX语句）和
DROP INDEX操作
NDB。还支持在线重命名
NDB表（在 NDB 8.0 之前，无法在线重命名此类列）。
基于磁盘的列不能
NDB在线添加到表中。这意味着，如果您希望将内存中的列添加到
NDB使用表级
STORAGE DISK选项的表中，则必须将新列显式声明为使用基于内存的存储。例如——假设你已经创建了表空间——假设
ts1你创建表
t1如下：
mysql> CREATE TABLE t1 (
>     c1 INT NOT NULL PRIMARY KEY,
>     c2 VARCHAR(30)
>     )
>     TABLESPACE ts1 STORAGE DISK
>     ENGINE NDB;
Query OK, 0 rows affected (1.73 sec)
Records: 0  Duplicates: 0  Warnings: 0
您可以在线向该表添加一个新的内存中列，如下所示：
mysql> ALTER TABLE t1
>     ADD COLUMN c3 INT COLUMN_FORMAT DYNAMIC STORAGE MEMORY,
>     ALGORITHM=INPLACE;
Query OK, 0 rows affected (1.25 sec)
Records: 0  Duplicates: 0  Warnings: 0STORAGE MEMORY
如果省略
该选项，则此语句失败：mysql> ALTER TABLE t1
>     ADD COLUMN c4 INT COLUMN_FORMAT DYNAMIC,
>     ALGORITHM=INPLACE;
ERROR 1846 (0A000): ALGORITHM=INPLACE is not supported. Reason:
Adding column(s) or add/reorganize partition not supported online. Try
ALGORITHM=COPY.
如果省略该COLUMN_FORMAT DYNAMIC选项，则会自动采用动态列格式，但会发出警告，如下所示：
mysql> ALTER ONLINE TABLE t1 ADD COLUMN c4 INT STORAGE MEMORY;
Query OK, 0 rows affected, 1 warning (1.17 sec)
Records: 0  Duplicates: 0  Warnings: 0
mysql> SHOW WARNINGS\G
*************************** 1. row ***************************
Level: Warning
Code: 1478
Message: DYNAMIC column c4 with STORAGE DISK is not supported, column will
become FIXED
mysql> SHOW CREATE TABLE t1\G
*************************** 1. row ***************************
Table: t1
Create Table: CREATE TABLE `t1` (
`c1` int(11) NOT NULL,
`c2` varchar(30) DEFAULT NULL,
`c3` int(11) /*!50606 STORAGE MEMORY */ /*!50606 COLUMN_FORMAT DYNAMIC */ DEFAULT NULL,
`c4` int(11) /*!50606 STORAGE MEMORY */ DEFAULT NULL,
PRIMARY KEY (`c1`)
) /*!50606 TABLESPACE ts_1 STORAGE DISK */ ENGINE=ndbcluster DEFAULT CHARSET=latin1
1 row in set (0.03 sec)
笔记
和关键字仅在 NDB Cluster 中受支持STORAGE；
COLUMN_FORMAT在任何其他版本的 MySQL 中，尝试在CREATE
TABLEorALTER TABLE
语句中使用这些关键字中的任何一个都会导致错误。
也可以在表上ALTER TABLE ...
REORGANIZE PARTITION, ALGORITHM=INPLACE使用不带
选项的语句。这可用于在已在线添加到集群的新数据节点之间重新分发 NDB Cluster 数据。这不会
执行任何碎片整理，这需要一个or null
语句。有关更多信息，请参阅第 23.6.7 节，“在线添加 NDB Cluster 数据节点”。
partition_names INTO
(partition_definitions)NDBOPTIMIZE TABLEALTER TABLE
NDB在线操作的局限性
DROP COLUMN不支持
在线操作。
添加列或添加或删除索引的在线ALTER TABLE、
CREATE INDEX或
DROP INDEX语句受到以下限制：
给定的在线ALTER TABLE只能使用ADD COLUMN、ADD
INDEX或之一DROP INDEX。可以在一条语句中在线添加一个或多个列；在一条语句中只能在线创建或删除一个索引。
除了运行在线、、或
操作（或
或
语句）的
API 节点之外，被更改的表未针对 API 节点锁定
。但是，在执行联机操作时，该表会针对源自同一API 节点的
任何其他操作锁定。ALTER TABLE ADD
COLUMNADD INDEXDROP INDEXCREATE INDEXDROP INDEX
要更改的表必须有一个明确的主键；存储引擎创建的隐藏主键
NDB不足以实现此目的。
表使用的存储引擎不能在线更改。
表使用的表空间不能在线更改。
从 NDB 8.0.21 开始，明确禁止使用诸如此类的语句
。（缺陷 #99269，缺陷 #31180526）
ALTER TABLE
ndb_table ... ALGORITHM=INPLACE,
TABLESPACE=new_tablespace
当与 NDB Cluster 磁盘数据表一起使用时，无法在线更改列的存储类型（DISK
或MEMORY）。这意味着，当您以在线执行操作的方式添加或删除索引时，并且您希望更改列或列的存储类型，您必须
ALGORITHM=COPY在添加或删除索引的语句中使用.
在线添加的列不能使用
BLOBor
TEXT类型，必须满足以下条件：
列必须是动态的；也就是说，必须可以使用COLUMN_FORMAT DYNAMIC. 如果省略该COLUMN_FORMAT DYNAMIC选项，则会自动采用动态列格式。
这些列必须允许NULL值，并且除 外没有任何显式默认值
NULL。在线添加的列会自动创建为DEFAULT NULL，如下所示：
mysql> CREATE TABLE t2 (
>     c1 INT NOT NULL AUTO_INCREMENT PRIMARY KEY
>     ) ENGINE=NDB;
Query OK, 0 rows affected (1.44 sec)
mysql> ALTER TABLE t2
>     ADD COLUMN c2 INT,
>     ADD COLUMN c3 INT,
>     ALGORITHM=INPLACE;
Query OK, 0 rows affected, 2 warnings (0.93 sec)
mysql> SHOW CREATE TABLE t1\G
*************************** 1. row ***************************
Table: t1
Create Table: CREATE TABLE `t2` (
`c1` int(11) NOT NULL AUTO_INCREMENT,
`c2` int(11) DEFAULT NULL,
`c3` int(11) DEFAULT NULL,
PRIMARY KEY (`c1`)
) ENGINE=ndbcluster DEFAULT CHARSET=latin1
1 row in set (0.00 sec)
这些列必须添加到任何现有列之后。如果您尝试在任何现有列之前或使用FIRST关键字在线添加列，则该语句将失败并出现错误。
现有表格列无法在线重新排序。
对于表的在线ALTER TABLE操作NDB，当在线添加固定格式的列时，或者在线创建或删除索引时，固定格式的列将转换为动态列，如下所示（为了清楚起见，重复刚刚显示
的CREATE TABLE和语句）：ALTER
TABLEmysql> CREATE TABLE t2 (
>     c1 INT NOT NULL AUTO_INCREMENT PRIMARY KEY
>     ) ENGINE=NDB;
Query OK, 0 rows affected (1.44 sec)
mysql> ALTER TABLE t2
>     ADD COLUMN c2 INT,
>     ADD COLUMN c3 INT,
>     ALGORITHM=INPLACE;
Query OK, 0 rows affected, 2 warnings (0.93 sec)
mysql> SHOW WARNINGS;
*************************** 1. row ***************************
Level: Warning
Code: 1478
Message: Converted FIXED field 'c2' to DYNAMIC to enable online ADD COLUMN
*************************** 2. row ***************************
Level: Warning
Code: 1478
Message: Converted FIXED field 'c3' to DYNAMIC to enable online ADD COLUMN
2 rows in set (0.00 sec)
只有在线添加的列必须是动态的。现有的专栏不需要；这包括表的主键，也可能是FIXED，如下所示：
mysql> CREATE TABLE t3 (
>     c1 INT NOT NULL AUTO_INCREMENT PRIMARY KEY COLUMN_FORMAT FIXED
>     ) ENGINE=NDB;
Query OK, 0 rows affected (2.10 sec)
mysql> ALTER TABLE t3 ADD COLUMN c2 INT, ALGORITHM=INPLACE;
Query OK, 0 rows affected, 1 warning (0.78 sec)
Records: 0  Duplicates: 0  Warnings: 0
mysql> SHOW WARNINGS;
*************************** 1. row ***************************
Level: Warning
Code: 1478
Message: Converted FIXED field 'c2' to DYNAMIC to enable online ADD COLUMN
1 row in set (0.00 sec)
列不会通过重命名操作从列格式转换FIXED为
列格式。DYNAMIC有关更多信息COLUMN_FORMAT，请参阅
第 13.1.20 节，“CREATE TABLE 语句”。
使用的语句
支持KEY、CONSTRAINT和
IGNORE关键字
。
ALTER TABLEALGORITHM=INPLACE不允许MAX_ROWS使用在线
声明
设置为 0。ALTER TABLE您必须使用复制ALTER TABLE来执行此操作。（缺陷号 21960004）
© Mysql 中文网
