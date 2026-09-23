# 24.2.2 列表分区_MySQL 8.0 参考手册

24.2.2 列表分区_MySQL 8.0 参考手册
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
24.2.2 列表分区
24.2.2 列表分区
MySQL 中的列表分区在许多方面类似于范围分区。与按 分区一样RANGE，每个分区都必须明确定义。两种类型的分区之间的主要区别在于，在列表分区中，每个分区的定义和选择基于列值在一组值列表之一中的成员资格，而不是在一组连续范围之一中的成员资格。值。这是通过使用where
是列值或基于列值并返回整数值的表达式，然后通过 定义每个分区来完成的
，where
是逗号分隔的整数列表。
PARTITION BY
LIST(expr)exprVALUES IN
(value_list)value_list
笔记
在 MySQL 8.0 中
NULL，
当按LIST.
但是，在使用分区时可以在值列表中使用其他列类型LIST COLUMN，这将在本节后面进行描述。
与按范围定义分区的情况不同，列表分区不需要以任何特定顺序声明。有关更详细的语法信息，请参阅
第 13.1.20 节，“CREATE TABLE 语句”。
对于下面的示例，我们假设要分区的表的基本定义由
CREATE TABLE此处显示的语句提供：
CREATE TABLE employees (
id INT NOT NULL,
fname VARCHAR(30),
lname VARCHAR(30),
hired DATE NOT NULL DEFAULT '1970-01-01',
separated DATE NOT NULL DEFAULT '9999-12-31',
job_code INT,
store_id INT
);（这是用作第 24.2.1 节“RANGE 分区”
中示例基础的同一张表
。与其他分区示例一样，我们假设
default_storage_engine是
InnoDB。）
假设有 20 家音像店分布在 4 个特许经营店中，如下表所示。
地区
商店 ID 号
北
3, 5, 6, 9, 17
东方
1, 2, 10, 11, 19, 20
西方
4, 12, 13, 14, 18
中央
7, 8, 15, 16
要以将属于同一区域的商店的行存储在同一分区中的方式对该表进行分区，您可以使用CREATE TABLE
此处显示的语句：
CREATE TABLE employees (
id INT NOT NULL,
fname VARCHAR(30),
lname VARCHAR(30),
hired DATE NOT NULL DEFAULT '1970-01-01',
separated DATE NOT NULL DEFAULT '9999-12-31',
job_code INT,
store_id INT
)
PARTITION BY LIST(store_id) (
PARTITION pNorth VALUES IN (3,5,6,9,17),
PARTITION pEast VALUES IN (1,2,10,11,19,20),
PARTITION pWest VALUES IN (4,12,13,14,18),
PARTITION pCentral VALUES IN (7,8,15,16)
);
这使得在表中添加或删除与特定区域相关的员工记录变得容易。例如，假设西部地区的所有商店都出售给另一家公司。在 MySQL 8.0 中，所有与该地区门店工作的员工相关的行都可以通过查询删除
，这比等效
语句ALTER TABLE employees TRUNCATE PARTITION
pWest的执行效率要高得多。（使用也会删除所有这些行，但也会
从表的定义中删除分区；您需要使用语句来恢复表的原始分区方案。）
DELETEDELETE FROM employees WHERE store_id IN
(4,12,13,14,18);ALTER TABLE
employees DROP PARTITION pWestpWestALTER TABLE ... ADD
PARTITION
与RANGE分区一样，可以将LIST分区与按散列或键的分区相结合以产生复合分区（子分区）。请参阅
第 24.2.6 节，“子分区”。
与RANGE分区的情况不同，没有“包罗万象”，例如
MAXVALUE；分区表达式的所有预期值都应包含在PARTITION
... VALUES IN (...)子句中。包含不匹配的分区列值的
INSERT语句失败并出现错误，如本例所示：
mysql> CREATE TABLE h2 (
->   c1 INT,
->   c2 INT
-> )
-> PARTITION BY LIST(c1) (
->   PARTITION p0 VALUES IN (1, 4, 7),
->   PARTITION p1 VALUES IN (2, 5, 8)
-> );
Query OK, 0 rows affected (0.11 sec)
mysql> INSERT INTO h2 VALUES (3, 5);
ERROR 1525 (HY000): Table has no partition for value 3
当使用单个
INSERT语句将多行插入到单个
InnoDB表中时，
InnoDB将语句视为单个事务，因此任何不匹配值的存在都会导致语句完全失败，因此不会插入任何行。
IGNORE您可以使用关键字
来忽略此类错误
。如果这样做，则不会插入包含不匹配的分区列值的行，但会插入任何具有匹配值的行，并且不会报告任何错误：
mysql> TRUNCATE h2;
Query OK, 1 row affected (0.00 sec)
mysql> SELECT * FROM h2;
Empty set (0.00 sec)
mysql> INSERT IGNORE INTO h2 VALUES (2, 5), (6, 10), (7, 5), (3, 1), (1, 9);
Query OK, 3 rows affected (0.00 sec)
Records: 5  Duplicates: 2  Warnings: 0
mysql> SELECT * FROM h2;
+------+------+
| c1   | c2   |
+------+------+
|    7 |    5 |
|    1 |    9 |
|    2 |    5 |
+------+------+
3 rows in set (0.00 sec)
MySQL 8.0 还提供了对分区的支持，LIST
COLUMNS分区的一种变体
LIST可以让你使用整数类型以外的类型的列来分区列，并使用多个列作为分区键。有关详细信息，请参阅
第 24.2.3.2 节，“LIST COLUMNS 分区”。
© Mysql 中文网
