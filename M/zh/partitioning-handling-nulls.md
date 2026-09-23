# 24.2.7 MySQL分区如何处理NULL_MySQL 8.0 参考手册

24.2.7 MySQL分区如何处理NULL_MySQL 8.0 参考手册
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
24.2.1 范围分区1
24.2.2 列表分区1
24.2.3 列分区1
24.2.4 哈希分区1
24.2.5 KEY分区1
24.2.6 子分区1
24.2.7 MySQL分区如何处理NULL1
24.3 分区管理
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
MySQL 8.0 参考手册  / 第24章分区  / 24.2 分区类型  /
24.2.7 MySQL分区如何处理NULL
24.2.7 MySQL分区如何处理NULL
MySQL 中的分区不会禁止
NULL分区表达式的值，无论它是列值还是用户提供的表达式的值。尽管它被允许
NULL用作必须以其他方式产生整数的表达式的值，但请务必记住它
NULL不是数字。MySQL 的分区实现将NULL其视为小于任何非NULL值，就像它
所做的ORDER BY那样。
这意味着NULL不同类型的分区之间的处理方式不同，如果您没有做好准备，可能会产生您意想不到的行为。在这种情况下，我们将在本节中讨论每种 MySQL 分区类型NULL在确定应存储行的分区时如何处理值，并为每种分区类型提供示例。
使用 RANGE 分区处理 NULL。
如果将一行插入到分区表中，
RANGE使得用于确定分区的列值为NULL，则该行将插入到最低分区。考虑名为 的数据库中的这两个表p，创建如下：
mysql> CREATE TABLE t1 (
->     c1 INT,
->     c2 VARCHAR(20)
-> )
-> PARTITION BY RANGE(c1) (
->     PARTITION p0 VALUES LESS THAN (0),
->     PARTITION p1 VALUES LESS THAN (10),
->     PARTITION p2 VALUES LESS THAN MAXVALUE
-> );
Query OK, 0 rows affected (0.09 sec)
mysql> CREATE TABLE t2 (
->     c1 INT,
->     c2 VARCHAR(20)
-> )
-> PARTITION BY RANGE(c1) (
->     PARTITION p0 VALUES LESS THAN (-5),
->     PARTITION p1 VALUES LESS THAN (0),
->     PARTITION p2 VALUES LESS THAN (10),
->     PARTITION p3 VALUES LESS THAN MAXVALUE
-> );
Query OK, 0 rows affected (0.09 sec)您可以对数据库中的表
CREATE TABLE使用以下查询
来查看这两个语句创建的分区
：
PARTITIONSINFORMATION_SCHEMAmysql> SELECT TABLE_NAME, PARTITION_NAME, TABLE_ROWS, AVG_ROW_LENGTH, DATA_LENGTH
>   FROM INFORMATION_SCHEMA.PARTITIONS
>   WHERE TABLE_SCHEMA = 'p' AND TABLE_NAME LIKE 't_';
+------------+----------------+------------+----------------+-------------+
| TABLE_NAME | PARTITION_NAME | TABLE_ROWS | AVG_ROW_LENGTH | DATA_LENGTH |
+------------+----------------+------------+----------------+-------------+
| t1         | p0             |          0 |              0 |           0 |
| t1         | p1             |          0 |              0 |           0 |
| t1         | p2             |          0 |              0 |           0 |
| t2         | p0             |          0 |              0 |           0 |
| t2         | p1             |          0 |              0 |           0 |
| t2         | p2             |          0 |              0 |           0 |
| t2         | p3             |          0 |              0 |           0 |
+------------+----------------+------------+----------------+-------------+
7 rows in set (0.00 sec)
（有关此表的更多信息，请参阅
第 26.3.21 节，“INFORMATION_SCHEMA PARTITIONS 表”NULL 。）现在让我们用包含用作分区键的列中的单个行填充这些表中的每一个
，并验证这些行使用一对
SELECT语句插入：
mysql> INSERT INTO t1 VALUES (NULL, 'mothra');
Query OK, 1 row affected (0.00 sec)
mysql> INSERT INTO t2 VALUES (NULL, 'mothra');
Query OK, 1 row affected (0.00 sec)
mysql> SELECT * FROM t1;
+------+--------+
| id   | name   |
+------+--------+
| NULL | mothra |
+------+--------+
1 row in set (0.00 sec)
mysql> SELECT * FROM t2;
+------+--------+
| id   | name   |
+------+--------+
| NULL | mothra |
+------+--------+
1 row in set (0.00 sec)INFORMATION_SCHEMA.PARTITIONS您可以通过重新运行先前的查询并检查输出
来查看哪些分区用于存储插入的行
：mysql> SELECT TABLE_NAME, PARTITION_NAME, TABLE_ROWS, AVG_ROW_LENGTH, DATA_LENGTH
>   FROM INFORMATION_SCHEMA.PARTITIONS
>   WHERE TABLE_SCHEMA = 'p' AND TABLE_NAME LIKE 't_';
+------------+----------------+------------+----------------+-------------+
| TABLE_NAME | PARTITION_NAME | TABLE_ROWS | AVG_ROW_LENGTH | DATA_LENGTH |
+------------+----------------+------------+----------------+-------------+
| t1         | p0             |          1 |             20 |          20 |
| t1         | p1             |          0 |              0 |           0 |
| t1         | p2             |          0 |              0 |           0 |
| t2         | p0             |          1 |             20 |          20 |
| t2         | p1             |          0 |              0 |           0 |
| t2         | p2             |          0 |              0 |           0 |
| t2         | p3             |          0 |              0 |           0 |
+------------+----------------+------------+----------------+-------------+
7 rows in set (0.01 sec)SELECT您还可以通过删除这些分区然后重新运行语句
来证明这些行存储在每个表的编号最小的分区中
：mysql> ALTER TABLE t1 DROP PARTITION p0;
Query OK, 0 rows affected (0.16 sec)
mysql> ALTER TABLE t2 DROP PARTITION p0;
Query OK, 0 rows affected (0.16 sec)
mysql> SELECT * FROM t1;
Empty set (0.00 sec)
mysql> SELECT * FROM t2;
Empty set (0.00 sec)
（有关 的更多信息ALTER TABLE ... DROP
PARTITION，请参阅第 13.1.9 节，“ALTER TABLE 语句”。）
NULL对于使用 SQL 函数的分区表达式，也以这种方式处理。假设我们使用CREATE
TABLE如下语句定义一个表：
CREATE TABLE tndate (
id INT,
dt DATE
)
PARTITION BY RANGE( YEAR(dt) ) (
PARTITION p0 VALUES LESS THAN (1990),
PARTITION p1 VALUES LESS THAN (2000),
PARTITION p2 VALUES LESS THAN MAXVALUE
);
与其他 MySQL 函数一样，
YEAR(NULL)返回
NULL. dt
列值为 的行NULL被视为分区表达式的计算结果小于任何其他值，因此被插入到 partitionp0中。
使用 LIST 分区处理 NULL。 当且仅当其分区之一是使用包含 的值列表定义时，
分区表才LIST允许
值。与此相反的是，未在值列表中明确使用的分区表拒绝生成分区表达式值的行，如本例所示：
NULLNULLLISTNULLNULLmysql> CREATE TABLE ts1 (
->     c1 INT,
->     c2 VARCHAR(20)
-> )
-> PARTITION BY LIST(c1) (
->     PARTITION p0 VALUES IN (0, 3, 6),
->     PARTITION p1 VALUES IN (1, 4, 7),
->     PARTITION p2 VALUES IN (2, 5, 8)
-> );
Query OK, 0 rows affected (0.01 sec)
mysql> INSERT INTO ts1 VALUES (9, 'mothra');
ERROR 1504 (HY000): Table has no partition for value 9
mysql> INSERT INTO ts1 VALUES (NULL, 'mothra');
ERROR 1504 (HY000): Table has no partition for value NULL
只能将c1值介于
0和之间的行8插入到ts1中。NULL
超出这个范围，就像数字一样
9。我们可以创建表
ts2并使ts3值列表包含NULL，如下所示：
mysql> CREATE TABLE ts2 (
->     c1 INT,
->     c2 VARCHAR(20)
-> )
-> PARTITION BY LIST(c1) (
->     PARTITION p0 VALUES IN (0, 3, 6),
->     PARTITION p1 VALUES IN (1, 4, 7),
->     PARTITION p2 VALUES IN (2, 5, 8),
->     PARTITION p3 VALUES IN (NULL)
-> );
Query OK, 0 rows affected (0.01 sec)
mysql> CREATE TABLE ts3 (
->     c1 INT,
->     c2 VARCHAR(20)
-> )
-> PARTITION BY LIST(c1) (
->     PARTITION p0 VALUES IN (0, 3, 6),
->     PARTITION p1 VALUES IN (1, 4, 7, NULL),
->     PARTITION p2 VALUES IN (2, 5, 8)
-> );
Query OK, 0 rows affected (0.01 sec)
在为分区定义值列表时，您可以（并且应该）NULL像对待任何其他值一样对待。例如，VALUES IN (NULL)和
VALUES IN (1, 4, 7, NULL)都是有效的，
VALUES IN (1, NULL, 4, 7), VALUES IN
(NULL, 1, 4, 7), 等等。您可以将具有NULLfor 列的行插入c1
到每个表中ts2，并且
ts3：
mysql> INSERT INTO ts2 VALUES (NULL, 'mothra');
Query OK, 1 row affected (0.00 sec)
mysql> INSERT INTO ts3 VALUES (NULL, 'mothra');
Query OK, 1 row affected (0.00 sec)
通过针对 发出适当的查询
INFORMATION_SCHEMA.PARTITIONS，您可以确定哪些分区用于存储刚刚插入的行（我们假设，与前面的示例一样，分区表是在p
数据库中创建的）：
mysql> SELECT TABLE_NAME, PARTITION_NAME, TABLE_ROWS, AVG_ROW_LENGTH, DATA_LENGTH
>   FROM INFORMATION_SCHEMA.PARTITIONS
>   WHERE TABLE_SCHEMA = 'p' AND TABLE_NAME LIKE 'ts_';
+------------+----------------+------------+----------------+-------------+
| TABLE_NAME | PARTITION_NAME | TABLE_ROWS | AVG_ROW_LENGTH | DATA_LENGTH |
+------------+----------------+------------+----------------+-------------+
| ts2        | p0             |          0 |              0 |           0 |
| ts2        | p1             |          0 |              0 |           0 |
| ts2        | p2             |          0 |              0 |           0 |
| ts2        | p3             |          1 |             20 |          20 |
| ts3        | p0             |          0 |              0 |           0 |
| ts3        | p1             |          1 |             20 |          20 |
| ts3        | p2             |          0 |              0 |           0 |
+------------+----------------+------------+----------------+-------------+
7 rows in set (0.01 sec)
如本节前面所示，您还可以通过删除这些分区然后执行
SELECT.
使用 HASH 和 KEY 分区处理 NULL。
NULL对于由HASHor
分区的表，处理方式略有不同KEY。在这些情况下，任何产生NULL值的分区表达式都被视为其返回值为零。我们可以通过检查创建分区表HASH并用包含适当值的记录填充它对文件系统的影响来验证此行为。假设您有一个使用以下语句创建
的表th（也在数据库中）：pmysql> CREATE TABLE th (
->     c1 INT,
->     c2 VARCHAR(20)
-> )
-> PARTITION BY HASH(c1)
-> PARTITIONS 2;
Query OK, 0 rows affected (0.00 sec)
可以使用此处显示的查询查看属于该表的分区：
mysql> SELECT TABLE_NAME,PARTITION_NAME,TABLE_ROWS,AVG_ROW_LENGTH,DATA_LENGTH
>   FROM INFORMATION_SCHEMA.PARTITIONS
>   WHERE TABLE_SCHEMA = 'p' AND TABLE_NAME ='th';
+------------+----------------+------------+----------------+-------------+
| TABLE_NAME | PARTITION_NAME | TABLE_ROWS | AVG_ROW_LENGTH | DATA_LENGTH |
+------------+----------------+------------+----------------+-------------+
| th         | p0             |          0 |              0 |           0 |
| th         | p1             |          0 |              0 |           0 |
+------------+----------------+------------+----------------+-------------+
2 rows in set (0.00 sec)
TABLE_ROWS每个分区的值为 0。现在插入列值为th0 的
两行
，并验证这些行是否已插入，如下所示：
c1NULLmysql> INSERT INTO th VALUES (NULL, 'mothra'), (0, 'gigan');
Query OK, 1 row affected (0.00 sec)
mysql> SELECT * FROM th;
+------+---------+
| c1   | c2      |
+------+---------+
| NULL | mothra  |
+------+---------+
|    0 | gigan   |
+------+---------+
2 rows in set (0.01 sec)
回想一下，对于任何整数N， 的值总是
。对于按
或分区的表，此结果被视为用于确定正确的分区为
。再次检查
表，我们可以看到这两行都被插入到分区中：
NULL MOD
NNULLHASHKEY0INFORMATION_SCHEMA.PARTITIONSp0mysql> SELECT TABLE_NAME, PARTITION_NAME, TABLE_ROWS, AVG_ROW_LENGTH, DATA_LENGTH
>   FROM INFORMATION_SCHEMA.PARTITIONS
>   WHERE TABLE_SCHEMA = 'p' AND TABLE_NAME ='th';
+------------+----------------+------------+----------------+-------------+
| TABLE_NAME | PARTITION_NAME | TABLE_ROWS | AVG_ROW_LENGTH | DATA_LENGTH |
+------------+----------------+------------+----------------+-------------+
| th         | p0             |          2 |             20 |          20 |
| th         | p1             |          0 |              0 |           0 |
+------------+----------------+------------+----------------+-------------+
2 rows in set (0.00 sec)
通过在表的定义中重复使用PARTITION BY
KEYinplace of的最后一个示例PARTITION BY HASH
，您可以验证
NULL对于这种类型的分区，它也被视为 0。
© Mysql 中文网
