# 8.3.9 B-Tree和哈希索引的比较_MySQL 8.0 参考手册

8.3.9 B-Tree和哈希索引的比较_MySQL 8.0 参考手册
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
8.3.9 B-Tree和哈希索引的比较
8.3.9 B-Tree和哈希索引的比较
了解 B 树和散列数据结构有助于预测不同的查询如何在索引中使用这些数据结构的不同存储引擎上执行，特别是对于MEMORY允许您选择 B 树或散列索引的存储引擎。
B-Tree 索引特性哈希索引特征
B-Tree 索引特性
B 树索引可用于在使用
=、
>、
>=、
<、
<=或BETWEEN运算符的表达式中进行列比较。LIKE
如果参数
LIKE是不以通配符开头的常量字符串，索引也可用于比较。例如，以下SELECT语句使用索引：
SELECT * FROM tbl_name WHERE key_col LIKE 'Patrick%';
SELECT * FROM tbl_name WHERE key_col LIKE 'Pat%_ck%';
在第一个语句中，只考虑带有的行。在第二条语句中，只考虑带有的行。
'Patrick'
<= key_col <
'Patricl''Pat' <=
key_col < 'Pau'
以下SELECT语句不使用索引：
SELECT * FROM tbl_name WHERE key_col LIKE '%Patrick%';
SELECT * FROM tbl_name WHERE key_col LIKE other_col;
在第一条语句中，LIKE
值以通配符开头。在第二个语句中，LIKE值不是常量。
如果使用and
超过三个字符，MySQL 使用Turbo Boyer-Moore 算法初始化字符串的模式，然后使用该模式更快地执行搜索。
... LIKE
'%string%'stringcol_name IS
NULL如果已编入索引，则使用使用索引
的搜索col_name。
任何未跨越子句中所有
AND级别的
索引都WHERE不会用于优化查询。换句话说，为了能够使用索引，必须在每个
AND组中使用索引的前缀。
以下WHERE子句使用索引：
... WHERE index_part1=1 AND index_part2=2 AND other_column=3
/* index = 1 OR index = 2 */
... WHERE index=1 OR A=10 AND index=2
/* optimized like "index_part1='hello'" */
... WHERE index_part1='hello' AND index_part3=5
/* Can use index on index1 but not on index2 or index3 */
... WHERE index1=1 AND index2=2 OR index1=3 AND index3=3;
这些WHERE子句
不使用索引：
/* index_part1 is not used */
... WHERE index_part2=1 AND index_part3=2
/*  Index is not used in both parts of the WHERE clause  */
... WHERE index=1 OR A=10
/* No index spans all rows  */
... WHERE index_part1=1 OR index_part2=10
有时 MySQL 不使用索引，即使索引可用。发生这种情况的一种情况是优化器估计使用索引将需要 MySQL 访问表中很大一部分的行。（在这种情况下，表扫描可能会快得多，因为它需要更少的查找。）但是，如果这样的查询LIMIT仅用于检索某些行，则 MySQL 无论如何都会使用索引，因为它可以更快地找到结果中返回几行。
哈希索引特征
散列索引与刚刚讨论的那些有一些不同的特征：
它们仅用于使用
=or<=>
运算符（但速度非常快）的相等比较。它们不用于比较运算符，例如
<查找值范围的运算符。依赖这种类型的单值查找的系统被称为“键值存储”；要将 MySQL 用于此类应用程序，请尽可能使用哈希索引。
优化器不能使用散列索引来加速
ORDER BY操作。（这种类型的索引不能用于按顺序搜索下一个条目。）
MySQL 无法确定两个值之间大约有多少行（范围优化器使用它来决定使用哪个索引）。如果将MyISAM或
InnoDB表更改为散列索引
MEMORY表，这可能会影响某些查询。
只能使用整个键来搜索行。（对于 B 树索引，键的任何最左边的前缀都可用于查找行。）
© Mysql 中文网
