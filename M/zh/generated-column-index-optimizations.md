# 8.3.11 优化器使用生成的列索引_MySQL 8.0 参考手册

8.3.11 优化器使用生成的列索引_MySQL 8.0 参考手册
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
8.3.11 优化器使用生成的列索引
8.3.11 优化器使用生成的列索引
MySQL 支持生成列的索引。例如：
CREATE TABLE t1 (f1 INT, gc INT AS (f1 + 1) STORED, INDEX (gc));
生成的列gc定义为表达式f1 + 1。该列也被索引，优化器可以在执行计划构造期间考虑该索引。在以下查询中，
WHERE子句引用gc
并且优化器考虑该列上的索引是否产生更有效的计划：
SELECT * FROM t1 WHERE gc > 9;
优化器可以使用生成的列上的索引来生成执行计划，即使在查询中没有按名称直接引用这些列。如果
WHERE, ORDER BY, or
GROUP BY子句引用与某些索引生成列的定义相匹配的表达式，则会发生这种情况。以下查询不直接引用，gc
但确实使用了与 的定义相匹配的表达式
gc：
SELECT * FROM t1 WHERE f1 + 1 > 9;
优化器识别出该表达式f1 +
1与 的定义匹配gc并且已gc被索引，因此它在执行计划构造期间考虑该索引。你可以看到这个使用
EXPLAIN：
mysql> EXPLAIN SELECT * FROM t1 WHERE f1 + 1 > 9\G
*************************** 1. row ***************************
id: 1
select_type: SIMPLE
table: t1
partitions: NULL
type: range
possible_keys: gc
key: gc
key_len: 5
ref: NULL
rows: 1
filtered: 100.00
Extra: Using index condition
实际上，优化器已将表达式替换为与表达式f1
+ 1匹配的生成列的名称。EXPLAIN
这在以下显示的扩展信息中可用的重写查询中也很明显SHOW
WARNINGS：
mysql> SHOW WARNINGS\G
*************************** 1. row ***************************
Level: Note
Code: 1003
Message: /* select#1 */ select `test`.`t1`.`f1` AS `f1`,`test`.`t1`.`gc`
AS `gc` from `test`.`t1` where (`test`.`t1`.`gc` > 9)
以下限制和条件适用于优化器对生成的列索引的使用：
对于匹配生成的列定义的查询表达式，表达式必须相同并且必须具有相同的结果类型。例如，如果生成的列表达式是，如果查询使用，或者如果
（整数表达式）与字符串进行比较
f1 + 1，则优化器无法识别匹配
项。1 + f1f1 + 1
优化适用于这些运算符：
=、
<、
<=、
>、
>=、
BETWEEN和
IN()。
BETWEEN对于and
以外的运算符
IN()，任一操作数都可以替换为匹配的生成列。对于
BETWEENand
IN()，只有第一个参数可以替换为匹配的生成列，其他参数必须具有相同的结果类型。
BETWEEN并且
IN()尚不支持涉及 JSON 值的比较。
生成的列必须定义为至少包含函数调用或前一项中提到的运算符之一的表达式。表达式不能包含对另一列的简单引用。例如，gc INT AS (f1) STORED仅包含列引用，因此
gc不考虑索引。
为了将字符串与索引生成的列进行比较，这些列从返回带引号的字符串的 JSON 函数计算值，JSON_UNQUOTE()列定义中需要从函数值中删除额外的引号。（对于字符串与函数结果的直接比较，JSON 比较器会处理引号删除，但这不会发生在索引查找中。）例如，不要像这样编写列定义：
doc_name TEXT AS (JSON_EXTRACT(jdoc, '$.name')) STORED
像这样写：
doc_name TEXT AS (JSON_UNQUOTE(JSON_EXTRACT(jdoc, '$.name'))) STORED
使用后一个定义，优化器可以检测到这两个比较的匹配：
... WHERE JSON_EXTRACT(jdoc, '$.name') = 'some_string' ...
... WHERE JSON_UNQUOTE(JSON_EXTRACT(jdoc, '$.name')) = 'some_string' ...
如果不在JSON_UNQUOTE()列定义中，优化器只会检测第一个比较的匹配项。
如果优化器选择了错误的索引，可以使用索引提示来禁用它并强制优化器做出不同的选择。
© Mysql 中文网
