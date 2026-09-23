# 8.2.4 优化性能模式查询_MySQL 8.0 参考手册

8.2.4 优化性能模式查询_MySQL 8.0 参考手册
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
8.2.1 优化 SELECT 语句1
8.2.2 优化子查询、派生表、视图引用和公用表表达式1
8.2.3 优化 INFORMATION_SCHEMA 查询1
8.2.4 优化性能模式查询1
8.2.5 优化数据变更语句1
8.2.6 优化数据库权限1
8.2.7 其他优化技巧1
8.3 优化和索引
8.4 优化数据库结构
8.5 优化 InnoDB 表
8.6 优化 MyISAM 表
8.7 优化 MEMORY 表
8.8 了解查询执行计划
8.9 控制查询优化器
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
MySQL 8.0 参考手册  / 第8章优化  / 8.2 优化SQL语句  /
8.2.4 优化性能模式查询
8.2.4 优化性能模式查询
监控数据库的应用程序可能会频繁使用性能模式表。要最有效地为这些表编写查询，请利用它们的索引。例如，包含一个WHERE子句，该子句根据与索引列中特定值的比较来限制检索行。
大多数性能模式表都有索引。没有的表通常包含很少的行或不太可能被频繁查询的表。Performance Schema 索引使优化器可以访问除全表扫描之外的执行计划。这些索引还提高了相关对象的性能，例如sys使用这些表的模式视图。
要查看给定的 Performance Schema 表是否有索引以及它们是什么，请使用SHOW INDEXor
SHOW CREATE TABLE：
mysql> SHOW INDEX FROM performance_schema.accounts\G
*************************** 1. row ***************************
Table: accounts
Non_unique: 0
Key_name: ACCOUNT
Seq_in_index: 1
Column_name: USER
Collation: NULL
Cardinality: NULL
Sub_part: NULL
Packed: NULL
Null: YES
Index_type: HASH
Comment:
Index_comment:
Visible: YES
*************************** 2. row ***************************
Table: accounts
Non_unique: 0
Key_name: ACCOUNT
Seq_in_index: 2
Column_name: HOST
Collation: NULL
Cardinality: NULL
Sub_part: NULL
Packed: NULL
Null: YES
Index_type: HASH
Comment:
Index_comment:
Visible: YES
mysql> SHOW CREATE TABLE performance_schema.rwlock_instances\G
*************************** 1. row ***************************
Table: rwlock_instances
Create Table: CREATE TABLE `rwlock_instances` (
`NAME` varchar(128) NOT NULL,
`OBJECT_INSTANCE_BEGIN` bigint(20) unsigned NOT NULL,
`WRITE_LOCKED_BY_THREAD_ID` bigint(20) unsigned DEFAULT NULL,
`READ_LOCKED_BY_COUNT` int(10) unsigned NOT NULL,
PRIMARY KEY (`OBJECT_INSTANCE_BEGIN`),
KEY `NAME` (`NAME`),
KEY `WRITE_LOCKED_BY_THREAD_ID` (`WRITE_LOCKED_BY_THREAD_ID`)
) ENGINE=PERFORMANCE_SCHEMA DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
要查看性能模式查询的执行计划以及它是否使用任何索引，请使用
EXPLAIN：
mysql> EXPLAIN SELECT * FROM performance_schema.accounts
WHERE (USER,HOST) = ('root','localhost')\G
*************************** 1. row ***************************
id: 1
select_type: SIMPLE
table: accounts
partitions: NULL
type: const
possible_keys: ACCOUNT
key: ACCOUNT
key_len: 278
ref: const,const
rows: 1
filtered: 100.00
Extra: NULLEXPLAIN输出表明优化器使用包含
和列
的accounts
表索引。ACCOUNTUSERHOST
性能模式索引是虚拟的：它们是性能模式存储引擎的构造，不使用内存或磁盘存储。Performance Schema 向优化器报告索引信息，以便优化器构建高效的执行计划。Performance Schema 反过来使用有关要查找的内容（例如，特定键值）的优化器信息，以便它可以在不构建实际索引结构的情况下执行高效查找。这个实现提供了两个重要的好处：
它完全避免了经常更新的表通常产生的维护成本。
它在查询执行的早期阶段减少了检索的数据量。对于索引列的条件，性能模式有效地只返回满足查询条件的表行。如果没有索引，性能模式将返回表中的所有行，要求优化器稍后根据每一行评估条件以产生最终结果。
性能模式索引是预定义的，不能删除、添加或更改。
Performance Schema 索引类似于哈希索引。例如：
它们仅用于使用
=or<=>
运算符的相等比较。
它们是无序的。如果查询结果必须具有特定的行排序特征，请包含一个ORDER
BY子句。
有关散列索引的其他信息，请参阅
第 8.3.9 节，“B 树和散列索引的比较”。
© Mysql 中文网
