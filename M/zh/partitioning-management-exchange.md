# 24.3.3 与表交换分区和子分区_MySQL 8.0 参考手册

24.3.3 与表交换分区和子分区_MySQL 8.0 参考手册
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
第24章分区
24.1 MySQL分区概述
24.2 分区类型
24.3 分区管理
24.3.1 RANGE 和 LIST 分区的管理1
24.3.2 HASH和KEY分区的管理1
24.3.3 与表交换分区和子分区1
24.3.4 分区维护1
24.3.5 获取分区信息1
24.4 分区修剪
24.5 分区选择
24.6 分区的约束和限制
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
MySQL 8.0 参考手册  / 第24章分区  / 24.3 分区管理  /
24.3.3 与表交换分区和子分区
24.3.3 与表交换分区和子分区
在 MySQL 8.0 中，可以使用 将表分区或子分区与表交换，其中
是分区表，
是要与未分区表交换的分区或子
分区，前提是以下语句为真：
ALTER
TABLE pt EXCHANGE PARTITION
p WITH TABLE
ntptpptnt
表nt本身没有分区。
表nt不是临时表。
pt表的
结构nt在其他方面是相同的。
表nt不包含外键引用，并且没有其他表具有引用 的任何外键nt。
中没有行nt位于 的分区定义边界之外
p。如果使用，则此条件不适用WITHOUT VALIDATION。
两个表必须使用相同的字符集和排序规则。
对于InnoDB表，两个表必须使用相同的行格式。要确定
InnoDB表的行格式，请查询
INFORMATION_SCHEMA.INNODB_TABLES.
的任何分区级MAX_ROWS设置
p都必须与为
MAX_ROWS设置的表级值
相同nt。的任何分区级
MIN_ROWS设置的设置p
也必须与为 设置的任何表级
MIN_ROWS值
相同nt。
无论是否
pt有明确的表级
MAX_ROWS或MIN_ROWS
选项有效，这在任何一种情况下都是如此。
两个表和
之间
的AVG_ROW_LENGTH不能不同。
ptnt
pt没有任何使用该DATA DIRECTORY选项的分区。InnoDBMySQL 8.0.14 及更高版本中的表
取消了此限制。
INDEX DIRECTORY表和要与之交换的分区之间不能不同。
TABLESPACE任何一个表中都不能使用
表或分区选项。
除了语句通常需要的 、 和 权限ALTER外
INSERT，
您还必须具有
执行
.
CREATEALTER TABLEDROPALTER TABLE ...
EXCHANGE PARTITION
您还应该注意以下影响
ALTER TABLE ...
EXCHANGE PARTITION：
执行ALTER
TABLE ... EXCHANGE PARTITION不会在分区表或要交换的表上调用任何触发器。
交换表中的任何AUTO_INCREMENT列都被重置。
关键字与 一起使用IGNORE时无效ALTER TABLE ... EXCHANGE
PARTITION。
此处显示了for 的语法
ALTER TABLE ...
EXCHANGE PARTITION，其中
pt是分区表，
p是要交换的分区（或子分区），是要交换nt的非分区表
p：
ALTER TABLE pt
EXCHANGE PARTITION p
WITH TABLE nt;
或者，您可以附加WITH VALIDATIONor
WITHOUT VALIDATION。WITHOUT
VALIDATION指定
时，该ALTER TABLE ...
EXCHANGE PARTITION操作在将分区交换为非分区表时不会执行任何逐行验证，从而允许数据库管理员承担确保行在分区定义边界内的责任。WITH VALIDATION
是默认值。
一个且只有一个分区或子分区可以在单个
ALTER TABLE
EXCHANGE PARTITION语句中与一个且只有一个非分区表交换。要交换多个分区或子分区，请使用多个
ALTER TABLE
EXCHANGE PARTITION语句。EXCHANGE
PARTITION不得与其他
ALTER TABLE选项结合使用。分区表使用的分区和（如果适用）子分区可以是 MySQL 8.0 支持的任何类型。
与非分区表交换分区
假设e已使用以下 SQL 语句创建并填充分区表：
CREATE TABLE e (
id INT NOT NULL,
fname VARCHAR(30),
lname VARCHAR(30)
)
PARTITION BY RANGE (id) (
PARTITION p0 VALUES LESS THAN (50),
PARTITION p1 VALUES LESS THAN (100),
PARTITION p2 VALUES LESS THAN (150),
PARTITION p3 VALUES LESS THAN (MAXVALUE)
);
INSERT INTO e VALUES
(1669, "Jim", "Smith"),
(337, "Mary", "Jones"),
(16, "Frank", "White"),
(2005, "Linda", "Black");e
现在我们创建一个named
的非分区副本e2。这可以使用
mysql客户端来完成，如下所示：
mysql> CREATE TABLE e2 LIKE e;
Query OK, 0 rows affected (0.04 sec)
mysql> ALTER TABLE e2 REMOVE PARTITIONING;
Query OK, 0 rows affected (0.07 sec)
Records: 0  Duplicates: 0  Warnings: 0
您可以通过查询表来查看表中哪些分区e
包含行
INFORMATION_SCHEMA.PARTITIONS
，如下所示：
mysql> SELECT PARTITION_NAME, TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_NAME = 'e';
+----------------+------------+
| PARTITION_NAME | TABLE_ROWS |
+----------------+------------+
| p0             |          1 |
| p1             |          0 |
| p2             |          0 |
| p3             |          3 |
+----------------+------------+
2 rows in set (0.00 sec)
笔记
对于分区表，表列中
InnoDB给出的行数
只是 SQL 优化中使用的估计值，并不总是准确的。
TABLE_ROWSINFORMATION_SCHEMA.PARTITIONS
p0要将表中
的
分区e与表交换e2，您可以使用
ALTER
TABLE，如下所示：
mysql> ALTER TABLE e EXCHANGE PARTITION p0 WITH TABLE e2;
Query OK, 0 rows affected (0.04 sec)
更准确地说，刚刚发出的语句导致分区中找到的任何行与表中找到的行交换。INFORMATION_SCHEMA.PARTITIONS
您可以像以前一样通过查询表来观察这是如何发生的
。之前在分区p0中找到的表行不再存在：
mysql> SELECT PARTITION_NAME, TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_NAME = 'e';
+----------------+------------+
| PARTITION_NAME | TABLE_ROWS |
+----------------+------------+
| p0             |          0 |
| p1             |          0 |
| p2             |          0 |
| p3             |          3 |
+----------------+------------+
4 rows in set (0.00 sec)
如果你查询表e2，你可以看到
现在可以在那里找到
“丢失”的行：mysql> SELECT * FROM e2;
+----+-------+-------+
| id | fname | lname |
+----+-------+-------+
| 16 | Frank | White |
+----+-------+-------+
1 row in set (0.00 sec)
要与分区交换的表不一定非得是空的。为了演示这一点，我们首先向表中插入一个新行，通过选择一个小于 50 的列值
e确保该行存储在分区中，然后通过查询表来验证这一点：
p0idPARTITIONSmysql> INSERT INTO e VALUES (41, "Michael", "Green");
Query OK, 1 row affected (0.05 sec)
mysql> SELECT PARTITION_NAME, TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_NAME = 'e';
+----------------+------------+
| PARTITION_NAME | TABLE_ROWS |
+----------------+------------+
| p0             |          1 |
| p1             |          0 |
| p2             |          0 |
| p3             |          3 |
+----------------+------------+
4 rows in set (0.00 sec)
现在我们再次使用与之前相同的
语句将
分区p0与表交换：e2ALTER
TABLEmysql> ALTER TABLE e EXCHANGE PARTITION p0 WITH TABLE e2;
Query OK, 0 rows affected (0.28 sec)
以下查询的输出显示存储在 partitionp0中的表行和存储在 table 中的表行，e2在发出
ALTER
TABLE语句之前，现在已经交换了位置：
mysql> SELECT * FROM e;
+------+-------+-------+
| id   | fname | lname |
+------+-------+-------+
|   16 | Frank | White |
| 1669 | Jim   | Smith |
|  337 | Mary  | Jones |
| 2005 | Linda | Black |
+------+-------+-------+
4 rows in set (0.00 sec)
mysql> SELECT PARTITION_NAME, TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_NAME = 'e';
+----------------+------------+
| PARTITION_NAME | TABLE_ROWS |
+----------------+------------+
| p0             |          1 |
| p1             |          0 |
| p2             |          0 |
| p3             |          3 |
+----------------+------------+
4 rows in set (0.00 sec)
mysql> SELECT * FROM e2;
+----+---------+-------+
| id | fname   | lname |
+----+---------+-------+
| 41 | Michael | Green |
+----+---------+-------+
1 row in set (0.00 sec)
不匹配的行
您应该记住，在发出
ALTER TABLE ...
EXCHANGE PARTITION语句之前在非分区表中找到的任何行都必须满足将它们存储在目标分区中所需的条件；否则，声明失败。要查看这是如何发生的，首先将一行插入表e2的分区定义边界之外的
行。例如，插入列值过大的行；然后，再次尝试将表与分区交换：
p0eidmysql> INSERT INTO e2 VALUES (51, "Ellen", "McDonald");
Query OK, 1 row affected (0.08 sec)
mysql> ALTER TABLE e EXCHANGE PARTITION p0 WITH TABLE e2;
ERROR 1707 (HY000): Found row that does not match the partition
只有WITHOUT VALIDATION选项会允许此操作成功：
mysql> ALTER TABLE e EXCHANGE PARTITION p0 WITH TABLE e2 WITHOUT VALIDATION;
Query OK, 0 rows affected (0.02 sec)
当分区与包含与分区定义不匹配的行的表交换时，数据库管理员有责任修复不匹配的行，这可以使用
REPAIR TABLEor
来执行ALTER
TABLE ... REPAIR PARTITION。
在没有逐行验证的情况下交换分区
WITHOUT
VALIDATION为避免在与具有多行的表交换分区时耗时的验证，可以通过附加到
ALTER
TABLE ... EXCHANGE PARTITION语句
来跳过逐行验证步骤。
以下示例比较了在使用和不使用验证的情况下，将分区与非分区表交换时的执行时间差异。分区表 (table
e) 包含两个分区，每个分区有 100 万行。删除表 e 的 p0 中的行，并将 p0 与 100 万行的未分区表交换。该WITH
VALIDATION操作需要 0.74 秒。相比之下，该WITHOUT VALIDATION操作需要 0.01 秒。
# Create a partitioned table with 1 million rows in each partition
CREATE TABLE e (
id INT NOT NULL,
fname VARCHAR(30),
lname VARCHAR(30)
)
PARTITION BY RANGE (id) (
PARTITION p0 VALUES LESS THAN (1000001),
PARTITION p1 VALUES LESS THAN (2000001),
);
mysql> SELECT COUNT(*) FROM e;
| COUNT(*) |
+----------+
|  2000000 |
+----------+
1 row in set (0.27 sec)
# View the rows in each partition
SELECT PARTITION_NAME, TABLE_ROWS FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_NAME = 'e';
+----------------+-------------+
| PARTITION_NAME | TABLE_ROWS  |
+----------------+-------------+
| p0             |     1000000 |
| p1             |     1000000 |
+----------------+-------------+
2 rows in set (0.00 sec)
# Create a nonpartitioned table of the same structure and populate it with 1 million rows
CREATE TABLE e2 (
id INT NOT NULL,
fname VARCHAR(30),
lname VARCHAR(30)
);
mysql> SELECT COUNT(*) FROM e2;
+----------+
| COUNT(*) |
+----------+
|  1000000 |
+----------+
1 row in set (0.24 sec)
# Create another nonpartitioned table of the same structure and populate it with 1 million rows
CREATE TABLE e3 (
id INT NOT NULL,
fname VARCHAR(30),
lname VARCHAR(30)
);
mysql> SELECT COUNT(*) FROM e3;
+----------+
| COUNT(*) |
+----------+
|  1000000 |
+----------+
1 row in set (0.25 sec)
# Drop the rows from p0 of table e
mysql> DELETE FROM e WHERE id < 1000001;
Query OK, 1000000 rows affected (5.55 sec)
# Confirm that there are no rows in partition p0
mysql> SELECT PARTITION_NAME, TABLE_ROWS FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_NAME = 'e';
+----------------+------------+
| PARTITION_NAME | TABLE_ROWS |
+----------------+------------+
| p0             |          0 |
| p1             |    1000000 |
+----------------+------------+
2 rows in set (0.00 sec)
# Exchange partition p0 of table e with the table e2 'WITH VALIDATION'
mysql> ALTER TABLE e EXCHANGE PARTITION p0 WITH TABLE e2 WITH VALIDATION;
Query OK, 0 rows affected (0.74 sec)
# Confirm that the partition was exchanged with table e2
mysql> SELECT PARTITION_NAME, TABLE_ROWS FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_NAME = 'e';
+----------------+------------+
| PARTITION_NAME | TABLE_ROWS |
+----------------+------------+
| p0             |    1000000 |
| p1             |    1000000 |
+----------------+------------+
2 rows in set (0.00 sec)
# Once again, drop the rows from p0 of table e
mysql> DELETE FROM e WHERE id < 1000001;
Query OK, 1000000 rows affected (5.55 sec)
# Confirm that there are no rows in partition p0
mysql> SELECT PARTITION_NAME, TABLE_ROWS FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_NAME = 'e';
+----------------+------------+
| PARTITION_NAME | TABLE_ROWS |
+----------------+------------+
| p0             |          0 |
| p1             |    1000000 |
+----------------+------------+
2 rows in set (0.00 sec)
# Exchange partition p0 of table e with the table e3 'WITHOUT VALIDATION'
mysql> ALTER TABLE e EXCHANGE PARTITION p0 WITH TABLE e3 WITHOUT VALIDATION;
Query OK, 0 rows affected (0.01 sec)
# Confirm that the partition was exchanged with table e3
mysql> SELECT PARTITION_NAME, TABLE_ROWS FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_NAME = 'e';
+----------------+------------+
| PARTITION_NAME | TABLE_ROWS |
+----------------+------------+
| p0             |    1000000 |
| p1             |    1000000 |
+----------------+------------+
2 rows in set (0.00 sec)
如果分区与包含与分区定义不匹配的行的表交换，则数据库管理员有责任修复不匹配的行，这可以使用REPAIR
TABLEor
执行ALTER
TABLE ... REPAIR PARTITION。
与非分区表交换子分区
您还可以使用语句将子分区表的子分区（请参阅第 24.2.6 节，“子分区”）与非
分区表交换ALTER TABLE ...
EXCHANGE PARTITION。在以下示例中，我们首先创建一个es由 分区RANGE和子分区的
KEY表，像对表 一样填充此表
e，然后创建该es2表的一个空的、未分区的副本，如下所示：
mysql> CREATE TABLE es (
->     id INT NOT NULL,
->     fname VARCHAR(30),
->     lname VARCHAR(30)
-> )
->     PARTITION BY RANGE (id)
->     SUBPARTITION BY KEY (lname)
->     SUBPARTITIONS 2 (
->         PARTITION p0 VALUES LESS THAN (50),
->         PARTITION p1 VALUES LESS THAN (100),
->         PARTITION p2 VALUES LESS THAN (150),
->         PARTITION p3 VALUES LESS THAN (MAXVALUE)
->     );
Query OK, 0 rows affected (2.76 sec)
mysql> INSERT INTO es VALUES
->     (1669, "Jim", "Smith"),
->     (337, "Mary", "Jones"),
->     (16, "Frank", "White"),
->     (2005, "Linda", "Black");
Query OK, 4 rows affected (0.04 sec)
Records: 4  Duplicates: 0  Warnings: 0
mysql> CREATE TABLE es2 LIKE es;
Query OK, 0 rows affected (1.27 sec)
mysql> ALTER TABLE es2 REMOVE PARTITIONING;
Query OK, 0 rows affected (0.70 sec)
Records: 0  Duplicates: 0  Warnings: 0
虽然我们在创建表时没有明确命名任何子分区，但我们可以通过在从该表中
进行选择时包含表的列
es来获取这些子分区的生成名称
，如下所示：
SUBPARTITION_NAMEPARTITIONSINFORMATION_SCHEMAmysql> SELECT PARTITION_NAME, SUBPARTITION_NAME, TABLE_ROWS
->     FROM INFORMATION_SCHEMA.PARTITIONS
->     WHERE TABLE_NAME = 'es';
+----------------+-------------------+------------+
| PARTITION_NAME | SUBPARTITION_NAME | TABLE_ROWS |
+----------------+-------------------+------------+
| p0             | p0sp0             |          1 |
| p0             | p0sp1             |          0 |
| p1             | p1sp0             |          0 |
| p1             | p1sp1             |          0 |
| p2             | p2sp0             |          0 |
| p2             | p2sp1             |          0 |
| p3             | p3sp0             |          3 |
| p3             | p3sp1             |          0 |
+----------------+-------------------+------------+
8 rows in set (0.00 sec)
以下
语句将表中的子分区与未分区表ALTER
TABLE交换
：
p3sp0eses2mysql> ALTER TABLE es EXCHANGE PARTITION p3sp0 WITH TABLE es2;
Query OK, 0 rows affected (0.29 sec)
您可以通过发出以下查询来验证行是否已交换：
mysql> SELECT PARTITION_NAME, SUBPARTITION_NAME, TABLE_ROWS
->     FROM INFORMATION_SCHEMA.PARTITIONS
->     WHERE TABLE_NAME = 'es';
+----------------+-------------------+------------+
| PARTITION_NAME | SUBPARTITION_NAME | TABLE_ROWS |
+----------------+-------------------+------------+
| p0             | p0sp0             |          1 |
| p0             | p0sp1             |          0 |
| p1             | p1sp0             |          0 |
| p1             | p1sp1             |          0 |
| p2             | p2sp0             |          0 |
| p2             | p2sp1             |          0 |
| p3             | p3sp0             |          0 |
| p3             | p3sp1             |          0 |
+----------------+-------------------+------------+
8 rows in set (0.00 sec)
mysql> SELECT * FROM es2;
+------+-------+-------+
| id   | fname | lname |
+------+-------+-------+
| 1669 | Jim   | Smith |
|  337 | Mary  | Jones |
| 2005 | Linda | Black |
+------+-------+-------+
3 rows in set (0.00 sec)
如果一个表被子分区，你只能用一个未分区的表交换表的一个子分区——而不是整个分区，如下所示：
mysql> ALTER TABLE es EXCHANGE PARTITION p3 WITH TABLE es2;
ERROR 1704 (HY000): Subpartitioned table, use subpartition instead of partition
表结构以严格的方式进行比较；分区表和非分区表的列和索引的数量、顺序、名称和类型必须完全匹配。此外，两个表必须使用相同的存储引擎：
mysql> CREATE TABLE es3 LIKE e;
Query OK, 0 rows affected (1.31 sec)
mysql> ALTER TABLE es3 REMOVE PARTITIONING;
Query OK, 0 rows affected (0.53 sec)
Records: 0  Duplicates: 0  Warnings: 0
mysql> SHOW CREATE TABLE es3\G
*************************** 1. row ***************************
Table: es3
Create Table: CREATE TABLE `es3` (
`id` int(11) NOT NULL,
`fname` varchar(30) DEFAULT NULL,
`lname` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
1 row in set (0.00 sec)
mysql> ALTER TABLE es3 ENGINE = MyISAM;
Query OK, 0 rows affected (0.15 sec)
Records: 0  Duplicates: 0  Warnings: 0
mysql> ALTER TABLE es EXCHANGE PARTITION p3sp0 WITH TABLE es3;
ERROR 1497 (HY000): The mix of handlers in the partitions is not allowed in this version of MySQL
© Mysql 中文网
