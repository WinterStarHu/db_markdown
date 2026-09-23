# 24.3.5 获取分区信息_MySQL 8.0 参考手册

24.3.5 获取分区信息_MySQL 8.0 参考手册
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
24.3.5 获取分区信息
24.3.5 获取分区信息
本节讨论获取有关现有分区的信息，这可以通过多种方式完成。获取此类信息的方法包括：
使用SHOW CREATE TABLE
语句查看创建分区表时使用的分区子句。
使用该SHOW TABLE STATUS
语句来确定表是否已分区。
查询
INFORMATION_SCHEMA.PARTITIONS
表。
使用语句
EXPLAIN
SELECT查看给定的
SELECT.
从 MySQL 8.0.16 开始，当对分区表进行插入、删除或更新时，二进制日志记录有关分区和（如果有）发生行事件的子分区的信息。为发生在不同分区或子分区中的修改创建一个新的行事件，即使涉及的表是相同的。因此，如果事务涉及三个分区或子分区，则会生成三个行事件。对于更新事件，“之前”映像和“之后”映像的分区信息都被记录下来。-v如果您指定或
，则显示分区信息--verbose使用mysqlbinlog查看二进制日志时的选项。分区信息仅在使用基于行的日志记录时记录 ( binlog_format=ROW)。
正如本章其他地方所讨论的，
SHOW CREATE TABLE在其输出中包含PARTITION BY用于创建分区表的子句。例如：
mysql> SHOW CREATE TABLE trb3\G
*************************** 1. row ***************************
Table: trb3
Create Table: CREATE TABLE `trb3` (
`id` int(11) DEFAULT NULL,
`name` varchar(50) DEFAULT NULL,
`purchased` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
/*!50100 PARTITION BY RANGE (YEAR(purchased))
(PARTITION p0 VALUES LESS THAN (1990) ENGINE = InnoDB,
PARTITION p1 VALUES LESS THAN (1995) ENGINE = InnoDB,
PARTITION p2 VALUES LESS THAN (2000) ENGINE = InnoDB,
PARTITION p3 VALUES LESS THAN (2005) ENGINE = InnoDB) */
0 row in set (0.00 sec)
分区表的输出与SHOW TABLE STATUS
非分区表的输出相同，只是该Create_options列包含字符串partitioned。该
Engine列包含表的所有分区使用的存储引擎的名称。（有关此语句的更多信息，请参阅
第 13.7.7.38 节，“SHOW TABLE STATUS 语句”。）
您还可以从 中获取有关分区的信息
INFORMATION_SCHEMA，其中包含一个
PARTITIONS表。请参阅
第 26.3.21 节，“INFORMATION_SCHEMA PARTITIONS 表”。
SELECT可以使用 确定给定查询
中涉及分区表的哪些分区
EXPLAIN。输出中的
partitions列
EXPLAIN列出了查询将匹配记录的分区。
假设trb1创建并填充了一个表，如下所示：
CREATE TABLE trb1 (id INT, name VARCHAR(50), purchased DATE)
PARTITION BY RANGE(id)
(
PARTITION p0 VALUES LESS THAN (3),
PARTITION p1 VALUES LESS THAN (7),
PARTITION p2 VALUES LESS THAN (9),
PARTITION p3 VALUES LESS THAN (11)
);
INSERT INTO trb1 VALUES
(1, 'desk organiser', '2003-10-15'),
(2, 'CD player', '1993-11-05'),
(3, 'TV set', '1996-03-10'),
(4, 'bookcase', '1982-01-10'),
(5, 'exercise bike', '2004-05-09'),
(6, 'sofa', '1987-06-05'),
(7, 'popcorn maker', '2001-11-22'),
(8, 'aquarium', '1992-08-04'),
(9, 'study desk', '1984-09-16'),
(10, 'lava lamp', '1998-12-25');
您可以看到在诸如 之类的查询中使用了哪些分区
SELECT * FROM trb1;，如下所示：
mysql> EXPLAIN SELECT * FROM trb1\G
*************************** 1. row ***************************
id: 1
select_type: SIMPLE
table: trb1
partitions: p0,p1,p2,p3
type: ALL
possible_keys: NULL
key: NULL
key_len: NULL
ref: NULL
rows: 10
Extra: Using filesort
在这种情况下，将搜索所有四个分区。但是，当将使用分区键的限制条件添加到查询时，您可以看到仅扫描那些包含匹配值的分区，如下所示：
mysql> EXPLAIN SELECT * FROM trb1 WHERE id < 5\G
*************************** 1. row ***************************
id: 1
select_type: SIMPLE
table: trb1
partitions: p0,p1
type: ALL
possible_keys: NULL
key: NULL
key_len: NULL
ref: NULL
rows: 10
Extra: Using where
EXPLAIN 还提供有关使用的密钥和可能的密钥的信息：
mysql> ALTER TABLE trb1 ADD PRIMARY KEY (id);
Query OK, 10 rows affected (0.03 sec)
Records: 10  Duplicates: 0  Warnings: 0
mysql> EXPLAIN SELECT * FROM trb1 WHERE id < 5\G
*************************** 1. row ***************************
id: 1
select_type: SIMPLE
table: trb1
partitions: p0,p1
type: range
possible_keys: PRIMARY
key: PRIMARY
key_len: 4
ref: NULL
rows: 7
Extra: Using where
如果EXPLAIN用于检查针对非分区表的查询，则不会产生错误，但partitions列的值始终为
NULL。
输出列显示表rows中
EXPLAIN的总行数。
另见第 13.8.2 节，“EXPLAIN 语句”。
© Mysql 中文网
