# 8.8.3 扩展的 EXPLAIN 输出格式_MySQL 8.0 参考手册

8.8.3 扩展的 EXPLAIN 输出格式_MySQL 8.0 参考手册
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
8.8.1 使用 EXPLAIN 优化查询1
8.8.2 EXPLAIN 输出格式1
8.8.3 扩展的 EXPLAIN 输出格式1
8.8.4 获取命名连接的执行计划信息1
8.8.5 估计查询性能1
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
MySQL 8.0 参考手册  / 第8章优化  / 8.8 了解查询执行计划  /
8.8.3 扩展的 EXPLAIN 输出格式
8.8.3 扩展的 EXPLAIN 输出格式
该EXPLAIN语句产生额外的（“扩展的”）信息，这些信息不是
EXPLAIN输出的一部分，但可以通过发出SHOW WARNINGS
后面的语句来查看EXPLAIN。从 MySQL 8.0.12 开始，扩展信息可用于
SELECT、
DELETE、
INSERT、
REPLACE和
UPDATE语句。在 8.0.12 之前，扩展信息仅适用于
SELECT语句。
输出中的Message值
SHOW WARNINGS显示优化器如何限定
SELECT语句
中的表名和列名，SELECT应用重写和优化规则后的样子，以及可能的关于优化过程的其他注释。
SHOW WARNINGS可在语句后
显示的扩展信息
EXPLAIN仅针对
SELECT语句生成。
SHOW WARNINGS显示其他可解释语句（DELETE、
INSERT、
REPLACE和
UPDATE）的空结果。
以下是扩展
EXPLAIN输出的示例：
mysql> EXPLAIN
SELECT t1.a, t1.a IN (SELECT t2.a FROM t2) FROM t1\G
*************************** 1. row ***************************
id: 1
select_type: PRIMARY
table: t1
type: index
possible_keys: NULL
key: PRIMARY
key_len: 4
ref: NULL
rows: 4
filtered: 100.00
Extra: Using index
*************************** 2. row ***************************
id: 2
select_type: SUBQUERY
table: t2
type: index
possible_keys: a
key: a
key_len: 5
ref: NULL
rows: 3
filtered: 100.00
Extra: Using index
2 rows in set, 1 warning (0.00 sec)
mysql> SHOW WARNINGS\G
*************************** 1. row ***************************
Level: Note
Code: 1003
Message: /* select#1 */ select `test`.`t1`.`a` AS `a`,
<in_optimizer>(`test`.`t1`.`a`,`test`.`t1`.`a` in
( <materialize> (/* select#2 */ select `test`.`t2`.`a`
from `test`.`t2` where 1 having 1 ),
<primary_index_lookup>(`test`.`t1`.`a` in
<temporary table> on <auto_key>
where ((`test`.`t1`.`a` = `materialized-subquery`.`a`))))) AS `t1.a
IN (SELECT t2.a FROM t2)` from `test`.`t1`
1 row in set (0.00 sec)
因为显示的语句SHOW
WARNINGS可能包含特殊标记以提供有关查询重写或优化器操作的信息，所以该语句不一定是有效的 SQL 并且不打算执行。输出还可能包括具有值的行，这些
Message值提供有关优化器采取的操作的额外非 SQL 解释性说明。
以下列表描述了可以出现在由 显示的扩展输出中的特殊标记SHOW
WARNINGS：
<auto_key>
为临时表自动生成的键。
<cache>(expr)
表达式（例如标量子查询）执行一次，结果值保存在内存中供以后使用。对于包含多个值的结果，可能会创建并<temporary
table>显示一个临时表。
<exists>(query
fragment)
子查询谓词转换为
EXISTS谓词，子查询转换为可以与
EXISTS谓词一起使用。
<in_optimizer>(query
fragment)
这是一个没有用户意义的内部优化器对象。
<index_lookup>(query
fragment)
使用索引查找来处理查询片段以查找符合条件的行。
<if>(condition,
expr1,
expr2)
如果条件为真，则求值为
expr1，否则
为expr2。
<is_not_null_test>(expr)
验证表达式不计算为 的测试
NULL。
<materialize>(query
fragment)
使用子查询实现。
`materialized-subquery`.col_name
col_name对内部临时表中
列的引用具体
化以保存评估子查询的结果。
<primary_index_lookup>(query
fragment)
使用主键查找来处理查询片段以查找符合条件的行。
<ref_null_helper>(expr)
这是一个没有用户意义的内部优化器对象。
/* select#N */
select_stmt
SELECT与非扩展EXPLAIN输出中id值为
的行关联N。
outer_tables semi join
(inner_tables)
半连接操作。
inner_tables显示未拉出的表。请参阅第 8.2.2.1 节，“使用半连接转换优化 IN 和 EXISTS 子查询谓词”。
<temporary table>
这表示为缓存中间结果而创建的内部临时表。
当某些表属于const
或system类型时，涉及这些表中的列的表达式会由优化器及早评估，而不是显示语句的一部分。但是，对于FORMAT=JSON，某些
const表访问显示为ref使用 const 值的访问。
© Mysql 中文网
