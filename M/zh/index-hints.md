# 8.9.4 索引提示_MySQL 8.0 参考手册

8.9.4 索引提示_MySQL 8.0 参考手册
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
8.1 优化概述
8.2 优化SQL语句
8.3 优化和索引
8.4 优化数据库结构
8.5 优化 InnoDB 表
8.6 优化 MyISAM 表
8.7 优化 MEMORY 表
8.8 了解查询执行计划
8.9 控制查询优化器
8.9.1 控制查询计划评估1
8.9.2 可切换优化1
8.9.3 优化器提示1
8.9.4 索引提示1
8.9.5 优化器成本模型1
8.9.6 优化器统计1
8.10 缓冲和缓存
8.11 优化锁定操作
8.12 优化MySQL服务器
8.13 测量性能（基准测试）
8.14 查看服务器线程（进程）信息
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
MySQL 8.0 参考手册  / 第8章优化  / 8.9 控制查询优化器  /
8.9.4 索引提示
8.9.4 索引提示
索引提示向优化器提供有关如何在查询处理期间选择索引的信息。此处描述的索引提示不同于
第 8.9.3 节“优化器提示”中描述的优化器提示。索引和优化器提示可以单独使用或一起使用。
索引提示适用于SELECTand
UPDATE语句。它们也适用于多表DELETE
语句，但不适用于单表DELETE，如本节后面所示。
索引提示在表名之后指定。（有关在语句中指定表的一般语法
SELECT，请参阅
第 13.2.10.2 节，“JOIN 子句”。）引用单个表的语法（包括索引提示）如下所示：
tbl_name [[AS] alias] [index_hint_list]
index_hint_list:
index_hint [index_hint] ...
index_hint:
USE {INDEX|KEY}
[FOR {JOIN|ORDER BY|GROUP BY}] ([index_list])
| {IGNORE|FORCE} {INDEX|KEY}
[FOR {JOIN|ORDER BY|GROUP BY}] (index_list)
index_list:
index_name [, index_name] ...
该提示告诉 MySQL 仅使用一个命名索引来查找表中的行。替代语法告诉 MySQL 不要使用某些特定的索引或索引。如果显示 MySQL 使用了可能索引列表中的错误索引，
这些提示将很有用。USE INDEX
(index_list)IGNORE INDEX
(index_list)EXPLAIN
该FORCE INDEX提示的作用类似于，此外还假定表扫描的
成本非常高。换句话说，仅当无法使用指定索引之一来查找表中的行时才使用表扫描。
USE
INDEX (index_list)
笔记
从 MySQL 8.0.20 开始，服务器支持索引级优化器提示JOIN_INDEX、
GROUP_INDEX、
ORDER_INDEX和
INDEX，它们等效于并旨在取代FORCE INDEX
索引提示，以及
NO_JOIN_INDEX、
NO_GROUP_INDEX、
NO_ORDER_INDEX和
NO_INDEX优化器提示，它们等效于并旨在取代
IGNORE INDEX索引提示。因此，您应该期望USE INDEX、FORCE
INDEX和IGNORE INDEX在 MySQL 的未来版本中被弃用，并在之后的某个时间被完全删除。
DELETE单表和多表语句
都支持这些索引级优化器提示
。
有关详细信息，请参阅
索引级优化器提示。
每个提示都需要索引名称，而不是列名称。要引用主键，请使用名称PRIMARY。要查看表的索引名称，请使用SHOW
INDEX语句或
INFORMATION_SCHEMA.STATISTICS
表。
index_name值不必是完整的索引名称
。它可以是索引名称的明确前缀。如果前缀不明确，则会发生错误。
例子：
SELECT * FROM table1 USE INDEX (col1_index,col2_index)
WHERE col1=1 AND col2=2 AND col3=3;
SELECT * FROM table1 IGNORE INDEX (col3_index)
WHERE col1=1 AND col2=2 AND col3=3;
索引提示的语法具有以下特点：
省略
index_listfor在语法上是有效的USE
INDEX，这意味着“不使用索引。”
省略orindex_list是
语法错误。
FORCE INDEXIGNORE
INDEXFOR您可以通过向提示添加子句来
指定索引提示的范围
。这为查询处理的各个阶段的执行计划的优化器选择提供了更细粒度的控制。要仅影响 MySQL 决定如何在表中查找行以及如何处理连接时使用的索引，请使用FOR
JOIN. 要影响对行进行排序或分组的索引使用，请使用FOR ORDER BYor
FOR GROUP BY。
您可以指定多个索引提示：
SELECT * FROM t1 USE INDEX (i1) IGNORE INDEX FOR ORDER BY (i2) ORDER BY a;
在多个提示中命名相同的索引不是错误（即使在相同的提示中）：
SELECT * FROM t1 USE INDEX (i1) USE INDEX (i1,i1);但是对于同一张表
，混合USE INDEX
and
是错误的：FORCE INDEXSELECT * FROM t1 USE INDEX FOR JOIN (i1) FORCE INDEX FOR JOIN (i2);
如果索引提示不包含FOR子句，则提示的范围适用于语句的所有部分。例如，这个提示：
IGNORE INDEX (i1)
等同于这种提示组合：
IGNORE INDEX FOR JOIN (i1)
IGNORE INDEX FOR ORDER BY (i1)
IGNORE INDEX FOR GROUP BY (i1)
在 MySQL 5.0 中，没有FOR子句的提示范围仅适用于行检索。要使服务器在不存在FOR子句时使用此旧行为，请old在服务器启动时启用系统变量。注意在复制设置中启用此变量。对于基于语句的二进制日志记录，源和副本的不同模式可能会导致复制错误。
处理索引提示时，它们按类型 ( USE, FORCE,
IGNORE) 和范围 ( FOR
JOIN, FOR ORDER BY, FOR
GROUP BY) 收集在单个列表中。例如：
SELECT * FROM t1
USE INDEX () IGNORE INDEX (i2) USE INDEX (i1) USE INDEX (i2);
相当于：
SELECT * FROM t1
USE INDEX (i1,i2) IGNORE INDEX (i2);
然后按以下顺序将索引提示应用于每个范围：
{USE|FORCE} INDEX如果存在则应用。（如果不是，则使用优化器确定的索引集。）
IGNORE INDEX应用于上一步的结果。例如，以下两个查询是等价的：
SELECT * FROM t1 USE INDEX (i1) IGNORE INDEX (i2) USE INDEX (i2);
SELECT * FROM t1 USE INDEX (i1);
对于FULLTEXT搜索，索引提示的工作方式如下：
对于自然语言模式搜索，索引提示会被忽略。例如，IGNORE INDEX(i1)在没有警告的情况下被忽略并且索引仍然被使用。
对于布尔模式搜索，带有FOR
ORDER BYor的索引提示将FOR GROUP BY被静默忽略。FOR
JOIN有或没有FOR修饰符的索引提示都被接受。与提示如何应用于非FULLTEXT搜索相反，提示用于查询执行的所有阶段（查找行和检索、分组和排序）。即使提示是针对非FULLTEXT索引给出的，也是如此。
例如，以下两个查询是等价的：
SELECT * FROM t
USE INDEX (index1)
IGNORE INDEX FOR ORDER BY (index1)
IGNORE INDEX FOR GROUP BY (index1)
WHERE ... IN BOOLEAN MODE ... ;
SELECT * FROM t
USE INDEX (index1)
WHERE ... IN BOOLEAN MODE ... ;
索引提示适用于DELETE
语句，但前提是您使用多表
DELETE语法，如下所示：
mysql> EXPLAIN DELETE FROM t1 USE INDEX(col2)
-> WHERE col1 BETWEEN 1 AND 100 AND COL2 BETWEEN 1 AND 100\G
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that
corresponds to your MySQL server version for the right syntax to use near 'use
index(col2) where col1 between 1 and 100 and col2 between 1 and 100' at line 1
mysql> EXPLAIN DELETE t1.* FROM t1 USE INDEX(col2)
-> WHERE col1 BETWEEN 1 AND 100 AND COL2 BETWEEN 1 AND 100\G
*************************** 1. row ***************************
id: 1
select_type: DELETE
table: t1
partitions: NULL
type: range
possible_keys: col2
key: col2
key_len: 5
ref: NULL
rows: 72
filtered: 11.11
Extra: Using where
1 row in set, 1 warning (0.00 sec)
© Mysql 中文网
