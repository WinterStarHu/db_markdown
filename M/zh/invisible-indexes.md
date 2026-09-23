# 8.3.12 不可见索引_MySQL 8.0 参考手册

8.3.12 不可见索引_MySQL 8.0 参考手册
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
8.3.12 不可见索引
8.3.12 不可见索引
MySQL 支持不可见索引；也就是说，优化器未使用的索引。该功能适用​​于主键以外的索引（显式或隐式）。
默认情况下索引是可见的。要显式控制新索引的可见性，请使用VISIBLEor
INVISIBLE关键字作为 、 或 的索引定义CREATE TABLE的
CREATE INDEX一部分
ALTER TABLE：
CREATE TABLE t1 (
i INT,
j INT,
k INT,
INDEX i_idx (i) INVISIBLE
) ENGINE = InnoDB;
CREATE INDEX j_idx ON t1 (j) INVISIBLE;
ALTER TABLE t1 ADD INDEX k_idx (k) INVISIBLE;
要更改现有索引的可见性，请在操作中使用
VISIBLEorINVISIBLE
关键字ALTER TABLE ... ALTER INDEX
：
ALTER TABLE t1 ALTER INDEX i_idx INVISIBLE;
ALTER TABLE t1 ALTER INDEX i_idx VISIBLE;
有关索引是可见还是不可见的信息可从
INFORMATION_SCHEMA.STATISTICS表或SHOW INDEX输出中获得。例如：
mysql> SELECT INDEX_NAME, IS_VISIBLE
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'db1' AND TABLE_NAME = 't1';
+------------+------------+
| INDEX_NAME | IS_VISIBLE |
+------------+------------+
| i_idx      | YES        |
| j_idx      | NO         |
| k_idx      | NO         |
+------------+------------+
不可见的索引使测试删除索引对查询性能的影响成为可能，而无需进行破坏性更改，如果索引被证明是必需的，则必须撤消该更改。删除和重新添加索引对于大型表来说可能代价高昂，而使其不可见和可见是快速的就地操作。
如果优化器实际上需要或使用一个不可见的索引，有几种方法可以注意到它不存在对表查询的影响：
包含引用不可见索引的索引提示的查询会发生错误。
Performance Schema 数据显示受影响查询的工作负载增加。
查询有不同的
EXPLAIN执行计划。
以前没有出现的查询出现在慢速查询日志中。
系统变量的use_invisible_indexes标志optimizer_switch控制优化器是否使用不可见的索引来构建查询执行计划。如果标志是
off（默认值），优化器将忽略不可见索引（与引入此标志之前的行为相同）。如果标志是
on，不可见索引保持不可见，但优化器将它们考虑到执行计划构造中。
使用SET_VAR优化器提示
optimizer_switch临时更新 的值，您可以仅在单个查询期间启用不可见索引，如下所示：
mysql> EXPLAIN SELECT /*+ SET_VAR(optimizer_switch = 'use_invisible_indexes=on') */
>     i, j FROM t1 WHERE j >= 50\G
*************************** 1. row ***************************
id: 1
select_type: SIMPLE
table: t1
partitions: NULL
type: range
possible_keys: j_idx
key: j_idx
key_len: 5
ref: NULL
rows: 2
filtered: 100.00
Extra: Using index condition
mysql> EXPLAIN SELECT i, j FROM t1 WHERE j >= 50\G
*************************** 1. row ***************************
id: 1
select_type: SIMPLE
table: t1
partitions: NULL
type: ALL
possible_keys: NULL
key: NULL
key_len: NULL
ref: NULL
rows: 5
filtered: 33.33
Extra: Using where
索引可见性不影响索引维护。例如，索引会随着表行的更改而持续更新，而唯一索引可防止将重复项插入列中，无论索引是可见的还是不可见的。
没有显式主键的表如果在列上有任何UNIQUE
索引，可能仍然有一个有效的隐式主键。NOT NULL在这种情况下，第一个这样的索引对表行施加了与显式主键相同的约束，并且该索引不能被设置为不可见。考虑下表定义：
CREATE TABLE t2 (
i INT NOT NULL,
j INT NOT NULL,
UNIQUE j_idx (j)
) ENGINE = InnoDB;NOT NULL该定义不包括显式主键，但列
上的索引j
将与主键相同的约束放在行上，并且不能使其不可见：
mysql> ALTER TABLE t2 ALTER INDEX j_idx INVISIBLE;
ERROR 3522 (HY000): A primary key index cannot be invisible.
现在假设在表中添加了一个显式主键：
ALTER TABLE t2 ADD PRIMARY KEY (i);
不能使显式主键不可见。此外，唯一索引j不再充当隐式主键，因此可以不可见：
mysql> ALTER TABLE t2 ALTER INDEX j_idx INVISIBLE;
Query OK, 0 rows affected (0.03 sec)
© Mysql 中文网
