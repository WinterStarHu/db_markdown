# 8.3.10 索引扩展的使用_MySQL 8.0 参考手册

8.3.10 索引扩展的使用_MySQL 8.0 参考手册
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
8.3.1 MySQL如何使用索引1
8.3.2 主键优化1
8.3.3 空间索引优化1
8.3.4 外键优化1
8.3.5 列索引1
8.3.6 多列索引1
8.3.7 验证索引使用1
8.3.8 InnoDB和MyISAM索引统计收集1
8.3.9 B-Tree和哈希索引的比较1
8.3.10 索引扩展的使用1
8.3.11 优化器使用生成的列索引1
8.3.12 不可见索引1
8.3.13 降序索引1
8.3.14 从 TIMESTAMP 列进行索引查找1
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
MySQL 8.0 参考手册  / 第8章优化  / 8.3 优化和索引  /
8.3.10 索引扩展的使用
8.3.10 索引扩展的使用
InnoDB通过将主键列附加到它来自动扩展每个二级索引。考虑这个表定义：
CREATE TABLE t1 (
i1 INT NOT NULL DEFAULT 0,
i2 INT NOT NULL DEFAULT 0,
d DATE DEFAULT NULL,
PRIMARY KEY (i1, i2),
INDEX k_d (d)
) ENGINE = InnoDB;
该表定义列的主键(i1,
i2)。它还
k_d在列上定义了二级索引(d)，但在内部InnoDB扩展了该索引并将其视为列(d, i1, i2)。
在确定如何以及是否使用该索引时，优化器会考虑扩展二级索引的主键列。这可以产生更高效的查询执行计划和更好的性能。
优化器可以将扩展二级索引用于
ref、range和
index_merge索引访问、松散索引扫描访问、连接和排序优化以及
MIN()/MAX()
优化。
以下示例显示了优化器是否使用扩展二级索引如何影响执行计划。假设t1填充了这些行：
INSERT INTO t1 VALUES
(1, 1, '1998-01-01'), (1, 2, '1999-01-01'),
(1, 3, '2000-01-01'), (1, 4, '2001-01-01'),
(1, 5, '2002-01-01'), (2, 1, '1998-01-01'),
(2, 2, '1999-01-01'), (2, 3, '2000-01-01'),
(2, 4, '2001-01-01'), (2, 5, '2002-01-01'),
(3, 1, '1998-01-01'), (3, 2, '1999-01-01'),
(3, 3, '2000-01-01'), (3, 4, '2001-01-01'),
(3, 5, '2002-01-01'), (4, 1, '1998-01-01'),
(4, 2, '1999-01-01'), (4, 3, '2000-01-01'),
(4, 4, '2001-01-01'), (4, 5, '2002-01-01'),
(5, 1, '1998-01-01'), (5, 2, '1999-01-01'),
(5, 3, '2000-01-01'), (5, 4, '2001-01-01'),
(5, 5, '2002-01-01');
现在考虑这个查询：
EXPLAIN SELECT COUNT(*) FROM t1 WHERE i1 = 3 AND d = '2000-01-01'
执行计划取决于是否使用扩展索引。
当优化器不考虑索引扩展时，它只将索引k_d视为(d).
EXPLAIN因为查询产生了这个结果：
mysql> EXPLAIN SELECT COUNT(*) FROM t1 WHERE i1 = 3 AND d = '2000-01-01'\G
*************************** 1. row ***************************
id: 1
select_type: SIMPLE
table: t1
type: ref
possible_keys: PRIMARY,k_d
key: k_d
key_len: 4
ref: const
rows: 5
Extra: Using where; Using index
当优化器考虑索引扩展时，它k_d会将(d, i1, i2). 在这种情况下，它可以使用最左边的索引前缀(d,
i1)来生成更好的执行计划：
mysql> EXPLAIN SELECT COUNT(*) FROM t1 WHERE i1 = 3 AND d = '2000-01-01'\G
*************************** 1. row ***************************
id: 1
select_type: SIMPLE
table: t1
type: ref
possible_keys: PRIMARY,k_d
key: k_d
key_len: 8
ref: const,const
rows: 1
Extra: Using index
在这两种情况下，key表示优化器使用二级索引k_d，但
EXPLAIN输出显示使用扩展索引的这些改进：
key_len从 4 个字节变为 8 个字节，表明键查找使用列d
和i1，而不仅仅是d。
ref值从
变为const因为const,const
键查找使用两个键部分，而不是一个。
计数从5rows减少到 1，表明InnoDB应该需要检查更少的行来生成结果。
该Extra值从
Using where; Using index变为
Using index。这意味着可以仅使用索引读取行，而无需查询数据行中的列。
还可以通过以下方式看到使用扩展索引的优化器行为的差异SHOW
STATUS：
FLUSH TABLE t1;
FLUSH STATUS;
SELECT COUNT(*) FROM t1 WHERE i1 = 3 AND d = '2000-01-01';
SHOW STATUS LIKE 'handler_read%'
前面的语句包括FLUSH
TABLES并FLUSH STATUS
刷新表缓存并清除状态计数器。
没有索引扩展，SHOW
STATUS产生这个结果：
+-----------------------+-------+
| Variable_name         | Value |
+-----------------------+-------+
| Handler_read_first    | 0     |
| Handler_read_key      | 1     |
| Handler_read_last     | 0     |
| Handler_read_next     | 5     |
| Handler_read_prev     | 0     |
| Handler_read_rnd      | 0     |
| Handler_read_rnd_next | 0     |
+-----------------------+-------+
使用索引扩展，SHOW
STATUS产生此结果。该
Handler_read_next值从 5 减少到 1，表示更有效地使用索引：
+-----------------------+-------+
| Variable_name         | Value |
+-----------------------+-------+
| Handler_read_first    | 0     |
| Handler_read_key      | 1     |
| Handler_read_last     | 0     |
| Handler_read_next     | 1     |
| Handler_read_prev     | 0     |
| Handler_read_rnd      | 0     |
| Handler_read_rnd_next | 0     |
+-----------------------+-------+
系统变量的use_index_extensions标志允许控制优化器在确定如何使用表的二级索引optimizer_switch时是否考虑主键列
。InnoDB默认情况下，use_index_extensions
启用。要检查禁用索引扩展是否可以提高性能，请使用以下语句：
SET optimizer_switch = 'use_index_extensions=off';
优化器对索引扩展的使用受到索引中键部分数量 (16) 和最大键长度（3072 字节）的通常限制。
© Mysql 中文网
