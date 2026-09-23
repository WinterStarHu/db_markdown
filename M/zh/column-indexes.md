# 8.3.5 列索引_MySQL 8.0 参考手册

8.3.5 列索引_MySQL 8.0 参考手册
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
8.3.5 列索引
8.3.5 列索引
最常见的索引类型涉及单列，将来自该列的值的副本存储在数据结构中，允许快速查找具有相应列值的行。B-tree 数据结构让索引可以快速找到一个特定的值、一组值或一个值范围，对应于子句
中的=,
>, ≤,
BETWEEN,等运算符。INWHERE
每个表的最大索引数和最大索引长度由每个存储引擎定义。请参阅
第 15 章，InnoDB 存储引擎和
第 16 章，替代存储引擎。所有存储引擎都支持每个表至少有 16 个索引，总索引长度至少为 256 字节。大多数存储引擎都有更高的限制。
有关列索引的其他信息，请参阅
第 13.1.15 节，“CREATE INDEX 语句”。
索引前缀全文索引空间索引MEMORY 存储引擎中的索引
索引前缀
使用
字符串列的索引规范中的语法，您可以创建仅使用
该列的第一个字符的索引。以这种方式仅索引列值的前缀可以使索引文件小得多。索引
或
列时，
必须为索引指定前缀长度。例如：
col_name(N)NBLOBTEXTCREATE TABLE test (blob_col BLOB, INDEX(blob_col(10)));
对于使用或
行格式的InnoDB表，
前缀最长可达 767 个字节
。
对于使用or
行格式的表，
前缀长度限制为 3072 字节
。对于 MyISAM 表，前缀长度限制为 1000 字节。
REDUNDANTCOMPACTInnoDBDYNAMICCOMPRESSED
笔记
前缀限制以字节为单位，而 、 和 语句中的前缀长度CREATE TABLE被
ALTER TABLE解释
CREATE INDEX为非二进制字符串类型（ 、 、 ）的字符数和二进制字符串类型（ 、
、
CHAR）
VARCHAR的
TEXT字节数。在为使用多字节字符集的非二进制字符串列指定前缀长度时，请考虑这一点。
BINARYVARBINARYBLOB
如果搜索词超过索引前缀长度，则索引用于排除不匹配的行，并检查剩余的行以查找可能的匹配项。
有关索引前缀的其他信息，请参阅
第 13.1.15 节，“CREATE INDEX 语句”。
全文索引
FULLTEXT索引用于全文搜索。只有InnoDB和
MyISAM存储引擎支持
FULLTEXT索引，并且仅
支持CHAR、
VARCHAR和
TEXT列。索引总是在整个列上进行，并且不支持列前缀索引。有关详细信息，请参阅
第 12.10 节，“全文搜索功能”。
优化适用于
FULLTEXT针对单个
InnoDB表的某些类型的查询。具有这些特征的查询特别有效：
FULLTEXT只返回文档 ID 或文档 ID 和搜索排名的查询。
FULLTEXT查询按分数的降序对匹配行进行排序，并应用一个
LIMIT子句来获取前 N 个匹配行。要应用此优化，必须没有
WHERE子句，并且只能有一个
ORDER BY降序排列的子句。
FULLTEXT只检索
COUNT(*)与搜索词匹配的行的值的查询，没有附加WHERE
子句。WHERE将子句
编码为，不带任何比较运算符。
WHERE MATCH(text)
AGAINST
('other_text')> 0
对于包含全文表达式的查询，MySQL 在查询执行的优化阶段评估这些表达式。优化器不只是查看全文表达式并进行估计，它实际上是在制定执行计划的过程中对它们进行评估。
此行为的含义是，
EXPLAIN全文查询通常比非全文查询慢，非全文查询在优化阶段不进行表达式评估。
EXPLAIN由于优化过程中发生的匹配，全文查询可能会显示Select tables optimized away在列中；Extra在这种情况下，在以后的执行过程中不需要进行表访问。
空间索引
您可以在空间数据类型上创建索引。
MyISAM并InnoDB
支持空间类型的 R 树索引。其他存储引擎使用 B 树来索引空间类型（除了
ARCHIVE，它不支持空间类型索引）。
MEMORY 存储引擎中的索引
MEMORY存储引擎默认使用
索引HASH，但也支持
BTREE索引。
© Mysql 中文网
