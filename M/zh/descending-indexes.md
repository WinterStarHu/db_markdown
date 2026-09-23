# 8.3.13 降序索引_MySQL 8.0 参考手册

8.3.13 降序索引_MySQL 8.0 参考手册
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
8.3.13 降序索引
8.3.13 降序索引
MySQL 支持降序索引：DESC在索引定义中不再被忽略，而是导致按降序存储键值。以前，可以按相反顺序扫描索引，但会降低性能。降序索引可以正向扫描，效率更高。当最有效的扫描顺序混合了某些列的升序和其他列的降序时，降序索引还使优化器可以使用多列索引。
考虑以下表定义，其中包含两列和四个两列索引定义，用于列上升序和降序索引的各种组合：
CREATE TABLE t (
c1 INT, c2 INT,
INDEX idx1 (c1 ASC, c2 ASC),
INDEX idx2 (c1 ASC, c2 DESC),
INDEX idx3 (c1 DESC, c2 ASC),
INDEX idx4 (c1 DESC, c2 DESC)
);
表定义产生四个不同的索引。优化器可以对每个子句执行正向索引扫描，
ORDER BY不需要使用以下
filesort操作：
ORDER BY c1 ASC, c2 ASC    -- optimizer can use idx1
ORDER BY c1 DESC, c2 DESC  -- optimizer can use idx4
ORDER BY c1 ASC, c2 DESC   -- optimizer can use idx2
ORDER BY c1 DESC, c2 ASC   -- optimizer can use idx3
降序索引的使用受以下条件限制：
仅
InnoDB存储引擎支持降序索引，具有以下限制：
如果索引包含降序索引键列或主键包含降序索引列，则二级索引不支持更改缓冲。
InnoDBSQL 解析器不使用降序索引
。对于InnoDB
全文搜索，这意味着FTS_DOC_ID索引表的列上所需的索引不能定义为降序索引。有关更多信息，请参阅
第 15.6.2.4 节，“InnoDB 全文索引”。
升序索引可用的所有数据类型都支持降序索引。
VIRTUAL普通（非生成的）和生成的列（和
）
都支持降序索引STORED。
DISTINCT可以使用任何包含匹配列的索引，包括降序键部分。
具有降序键部分的索引不用于
MIN()/MAX()
优化调用聚合函数但没有GROUP BY子句的查询。
支持降序索引
BTREE但不支持HASH
索引。FULLTEXT或索引不支持降序
SPATIAL
索引。
为
、和
索引
明确指定ASC和
指示符会导致错误。
DESCHASHFULLTEXTSPATIAL
您可以在Extra的输出列中看到EXPLAIN优化器能够使用降序索引，如下所示：
mysql> CREATE TABLE t1 (
-> a INT,
-> b INT,
-> INDEX a_desc_b_asc (a DESC, b ASC)
-> );
mysql> EXPLAIN SELECT * FROM t1 ORDER BY a ASC\G
*************************** 1. row ***************************
id: 1
select_type: SIMPLE
table: t1
partitions: NULL
type: index
possible_keys: NULL
key: a_desc_b_asc
key_len: 10
ref: NULL
rows: 1
filtered: 100.00
Extra: Backward index scan; Using index
在EXPLAIN FORMAT=TREE输出中，使用降序索引通过在
(reverse)索引名称后面添加来表示，如下所示：
mysql> EXPLAIN FORMAT=TREE SELECT * FROM t1 ORDER BY a ASC\G
*************************** 1. row ***************************
EXPLAIN: -> Index scan on t1 using a_desc_b_asc (reverse)  (cost=0.35 rows=1)
另请参阅EXPLAIN 额外信息。
© Mysql 中文网
