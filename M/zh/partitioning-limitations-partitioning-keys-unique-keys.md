# 24.6.1 分区键、主键和唯一键_MySQL 8.0 参考手册

24.6.1 分区键、主键和唯一键_MySQL 8.0 参考手册
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
24.4 分区修剪
24.5 分区选择
24.6 分区的约束和限制
24.6.1 分区键、主键和唯一键1
24.6.2 与存储引擎相关的分区限制1
24.6.3 与函数相关的分区限制1
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
MySQL 8.0 参考手册  / 第24章分区  / 24.6 分区的约束和限制  /
24.6.1 分区键、主键和唯一键
24.6.1 分区键、主键和唯一键
本节讨论分区键与主键和唯一键的关系。管理这种关系的规则可以表示如下：分区表的分区表达式中使用的所有列必须是表可能具有的每个唯一键的一部分。
换句话说，表上的每个唯一键都必须使用表的分区表达式中的每一列。（这也包括表的主键，因为它根据定义是唯一键。这种特殊情况将在本节后面讨论。）例如，以下每个表创建语句都是无效的：
CREATE TABLE t1 (
col1 INT NOT NULL,
col2 DATE NOT NULL,
col3 INT NOT NULL,
col4 INT NOT NULL,
UNIQUE KEY (col1, col2)
)
PARTITION BY HASH(col3)
PARTITIONS 4;
CREATE TABLE t2 (
col1 INT NOT NULL,
col2 DATE NOT NULL,
col3 INT NOT NULL,
col4 INT NOT NULL,
UNIQUE KEY (col1),
UNIQUE KEY (col3)
)
PARTITION BY HASH(col1 + col3)
PARTITIONS 4;
在每一种情况下，建议的表将至少有一个不包括分区表达式中使用的所有列的唯一键。
以下每个语句都是有效的，并且代表一种可以使相应的无效表创建语句起作用的方法：
CREATE TABLE t1 (
col1 INT NOT NULL,
col2 DATE NOT NULL,
col3 INT NOT NULL,
col4 INT NOT NULL,
UNIQUE KEY (col1, col2, col3)
)
PARTITION BY HASH(col3)
PARTITIONS 4;
CREATE TABLE t2 (
col1 INT NOT NULL,
col2 DATE NOT NULL,
col3 INT NOT NULL,
col4 INT NOT NULL,
UNIQUE KEY (col1, col3)
)
PARTITION BY HASH(col1 + col3)
PARTITIONS 4;
此示例显示在这种情况下产生的错误：
mysql> CREATE TABLE t3 (
->     col1 INT NOT NULL,
->     col2 DATE NOT NULL,
->     col3 INT NOT NULL,
->     col4 INT NOT NULL,
->     UNIQUE KEY (col1, col2),
->     UNIQUE KEY (col3)
-> )
-> PARTITION BY HASH(col1 + col3)
-> PARTITIONS 4;
ERROR 1491 (HY000): A PRIMARY KEY must include all columns in the table's partitioning function
该CREATE TABLE语句失败，因为col1和col3
都包含在建议的分区键中，但这些列都不是表上两个唯一键的一部分。这显示了对无效表定义的一种可能修复：
mysql> CREATE TABLE t3 (
->     col1 INT NOT NULL,
->     col2 DATE NOT NULL,
->     col3 INT NOT NULL,
->     col4 INT NOT NULL,
->     UNIQUE KEY (col1, col2, col3),
->     UNIQUE KEY (col3)
-> )
-> PARTITION BY HASH(col3)
-> PARTITIONS 4;
Query OK, 0 rows affected (0.05 sec)
在这种情况下，建议的分区键
col3是两个唯一键的一部分，并且表创建语句成功。
下表根本无法分区，因为无法在分区键中包含属于两个唯一键的任何列：
CREATE TABLE t4 (
col1 INT NOT NULL,
col2 INT NOT NULL,
col3 INT NOT NULL,
col4 INT NOT NULL,
UNIQUE KEY (col1, col3),
UNIQUE KEY (col2, col4)
);
由于每个主键根据定义都是唯一键，因此此限制还包括表的主键（如果有的话）。例如，接下来的两个语句是无效的：
CREATE TABLE t5 (
col1 INT NOT NULL,
col2 DATE NOT NULL,
col3 INT NOT NULL,
col4 INT NOT NULL,
PRIMARY KEY(col1, col2)
)
PARTITION BY HASH(col3)
PARTITIONS 4;
CREATE TABLE t6 (
col1 INT NOT NULL,
col2 DATE NOT NULL,
col3 INT NOT NULL,
col4 INT NOT NULL,
PRIMARY KEY(col1, col3),
UNIQUE KEY(col2)
)
PARTITION BY HASH( YEAR(col2) )
PARTITIONS 4;
在这两种情况下，主键都不包括分区表达式中引用的所有列。但是，接下来的两个语句都是有效的：
CREATE TABLE t7 (
col1 INT NOT NULL,
col2 DATE NOT NULL,
col3 INT NOT NULL,
col4 INT NOT NULL,
PRIMARY KEY(col1, col2)
)
PARTITION BY HASH(col1 + YEAR(col2))
PARTITIONS 4;
CREATE TABLE t8 (
col1 INT NOT NULL,
col2 DATE NOT NULL,
col3 INT NOT NULL,
col4 INT NOT NULL,
PRIMARY KEY(col1, col2, col4),
UNIQUE KEY(col2, col1)
)
PARTITION BY HASH(col1 + YEAR(col2))
PARTITIONS 4;
如果表没有唯一键（包括没有主键），则此限制不适用，您可以在分区表达式中使用任何列，只要列类型与分区类型兼容即可。
出于同样的原因，您以后不能将唯一键添加到分区表，除非该键包含表的分区表达式使用的所有列。考虑如下所示创建的分区表：
mysql> CREATE TABLE t_no_pk (c1 INT, c2 INT)
->     PARTITION BY RANGE(c1) (
->         PARTITION p0 VALUES LESS THAN (10),
->         PARTITION p1 VALUES LESS THAN (20),
->         PARTITION p2 VALUES LESS THAN (30),
->         PARTITION p3 VALUES LESS THAN (40)
->     );
Query OK, 0 rows affected (0.12 sec)t_no_pk可以使用以下任一
ALTER
TABLE语句
添加主键
：#  possible PK
mysql> ALTER TABLE t_no_pk ADD PRIMARY KEY(c1);
Query OK, 0 rows affected (0.13 sec)
Records: 0  Duplicates: 0  Warnings: 0
# drop this PK
mysql> ALTER TABLE t_no_pk DROP PRIMARY KEY;
Query OK, 0 rows affected (0.10 sec)
Records: 0  Duplicates: 0  Warnings: 0
#  use another possible PK
mysql> ALTER TABLE t_no_pk ADD PRIMARY KEY(c1, c2);
Query OK, 0 rows affected (0.12 sec)
Records: 0  Duplicates: 0  Warnings: 0
# drop this PK
mysql> ALTER TABLE t_no_pk DROP PRIMARY KEY;
Query OK, 0 rows affected (0.09 sec)
Records: 0  Duplicates: 0  Warnings: 0
然而，下一条语句失败了，因为c1
它是分区键的一部分，但不是建议的主键的一部分：
#  fails with error 1503
mysql> ALTER TABLE t_no_pk ADD PRIMARY KEY(c2);
ERROR 1503 (HY000): A PRIMARY KEY must include all columns in the table's partitioning function
由于t_no_pkhas onlyc1
在其分区表达式中，尝试c2单独添加唯一键失败。c1但是，您可以添加一个同时使用和
的唯一键c2。
这些规则也适用于您希望使用 进行分区的现有非分区表
ALTER
TABLE ... PARTITION BY。考虑
np_pk如下所示创建的表：
mysql> CREATE TABLE np_pk (
->     id INT NOT NULL AUTO_INCREMENT,
->     name VARCHAR(50),
->     added DATE,
->     PRIMARY KEY (id)
-> );
Query OK, 0 rows affected (0.08 sec)
以下
ALTER
TABLE语句因错误而失败，因为该
added列不是表中任何唯一键的一部分：
mysql> ALTER TABLE np_pk
->     PARTITION BY HASH( TO_DAYS(added) )
->     PARTITIONS 4;
ERROR 1503 (HY000): A PRIMARY KEY must include all columns in the table's partitioning function
但是，此使用列作为分区列的语句id是有效的，如下所示：
mysql> ALTER TABLE np_pk
->     PARTITION BY HASH(id)
->     PARTITIONS 4;
Query OK, 0 rows affected (0.11 sec)
Records: 0  Duplicates: 0  Warnings: 0
在 的情况下np_pk，唯一可以用作分区表达式一部分的列是
id；如果您希望使用分区表达式中的任何其他列对该​​表进行分区，则必须首先修改该表，方法是将所需的一个或多个列添加到主键，或者完全删除主键。
© Mysql 中文网
