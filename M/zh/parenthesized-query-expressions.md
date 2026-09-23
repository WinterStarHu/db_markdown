# 13.2.10.6 带括号的查询表达式_MySQL 8.0 参考手册

13.2.10.6 带括号的查询表达式_MySQL 8.0 参考手册
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
13.1 数据定义语句
13.2 数据操作语句
13.2.1 CALL 语句1
13.2.2 删除语句1
13.2.3 DO 声明1
13.2.4 HANDLER 语句1
13.2.5 导入表语句1
13.2.6 插入语句1
13.2.7 加载数据语句1
13.2.8 加载 XML 语句1
13.2.9 REPLACE 语句1
13.2.10 SELECT 语句1
13.2.10.1 SELECT ... INTO 语句
13.2.10.2 JOIN 子句
13.2.10.3 UNION 子句
13.2.10.4 INTERSECT 子句
13.2.10.5 EXCEPT 子句
13.2.10.6 带括号的查询表达式
13.2.11 子查询1
13.2.12 TABLE 语句1
13.2.13 更新语句1
13.2.14 VALUES 语句1
13.2.15 WITH（公用表表达式）1
13.2.12 集合操作1
13.3 事务和锁定语句
13.4 复制语句
13.5 准备好的语句
13.6 复合语句语法
13.7 数据库管理语句
13.8 效用语句
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
MySQL 8.0 参考手册  / 第 13 章 SQL 语句  / 13.2 数据操作语句  / 13.2.10 SELECT 语句  /
13.2.10.6 带括号的查询表达式
13.2.10.6 带括号的查询表达式
parenthesized_query_expression:
( query_expression [order_by_clause] [limit_clause] )
[order_by_clause]
[limit_clause]
[into_clause]
query_expression:
query_block [set_op query_block [set_op query_block ...]]
[order_by_clause]
[limit_clause]
[into_clause]
query_block:
SELECT ... | TABLE | VALUES
order_by_clause:
ORDER BY as for SELECT
limit_clause:
LIMIT as for SELECT
into_clause:
INTO as for SELECT
set_op:
UNION | INTERSECT | EXCEPT
MySQL 8.0.22 及更高版本支持根据上述语法的带括号的查询表达式。SELECT在最简单的情况下，带括号的查询表达式包含返回结果集
的单个
或其他语句，并且没有以下可选子句：(SELECT 1);
(SELECT * FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'mysql');
TABLE t;
VALUES ROW(2, 3, 4), ROW(1, -2, 3);（从 MySQL 8.0.19 开始
支持TABLEand
语句。）VALUES
带括号的查询表达式还可以包含由一个或多个集合操作链接的查询，例如
UNION, 并以任何或所有可选子句结尾：
mysql> (SELECT 1 AS result UNION SELECT 2);
+--------+
| result |
+--------+
|      1 |
|      2 |
+--------+
mysql> (SELECT 1 AS result UNION SELECT 2) LIMIT 1;
+--------+
| result |
+--------+
|      1 |
+--------+
mysql> (SELECT 1 AS result UNION SELECT 2) LIMIT 1 OFFSET 1;
+--------+
| result |
+--------+
|      2 |
+--------+
mysql> (SELECT 1 AS result UNION SELECT 2)
ORDER BY result DESC LIMIT 1;
+--------+
| result |
+--------+
|      2 |
+--------+
mysql> (SELECT 1 AS result UNION SELECT 2)
ORDER BY result DESC LIMIT 1 OFFSET 1;
+--------+
| result |
+--------+
|      1 |
+--------+
mysql> (SELECT 1 AS result UNION SELECT 3 UNION SELECT 2)
ORDER BY result LIMIT 1 OFFSET 1 INTO @var;
mysql> SELECT @var;
+------+
| @var |
+------+
|    2 |
+------+
除了UNION，
INTERSECT和EXCEPTset 运算符从 MySQL 8.0.31 开始可用。
在和INTERSECT之前
执行，因此以下两个语句是等价的：
UNIONEXCEPTSELECT a FROM t1 EXCEPT SELECT b FROM t2 INTERSECT SELECT c FROM t3;
SELECT a FROM t1 EXCEPT (SELECT b FROM t2 INTERSECT SELECT c FROM t3);
括号查询表达式也用作查询表达式，因此通常由查询块组成的查询表达式也可能由括号查询表达式组成：
(TABLE t1 ORDER BY a) UNION (TABLE t2 ORDER BY b) ORDER BY z;
查询块可能有尾随ORDER BY和
LIMIT子句，它们在外部集合操作、ORDER BY和
之前应用LIMIT。
您不能有一个带有尾随ORDER
BY或LIMIT不包含在括号中的查询块，但括号可以以多种方式用于强制执行：
LIMIT对每个查询块
执行：(SELECT 1 LIMIT 1) UNION (VALUES ROW(2) LIMIT 1);
(VALUES ROW(1), ROW(2) LIMIT 2) EXCEPT (SELECT 2 LIMIT 1);
强制执行LIMIT查询块和整个查询表达式：
(SELECT 1 LIMIT 1) UNION (SELECT 2 LIMIT 1) LIMIT 1;
强制执行LIMIT整个查询表达式（不带括号）：
VALUES ROW(1), ROW(2) INTERSECT VALUES ROW(2), ROW(1) LIMIT 1;
混合执行：LIMIT在第一个查询块和整个查询表达式上：
(SELECT 1 LIMIT 1) UNION SELECT 2 LIMIT 1;
本节中描述的语法受到某些限制：
如果括号内
INTO有另一个子句，则不允许查询表达式
的尾随子句。INTO
在 MySQL 8.0.31 之前，当ORDER BY或
LIMIT出现在带括号的查询表达式中并且也应用于外部查询时，结果是未定义的。这在 MySQL 8.0.31 及更高版本中不是问题，这是根据 SQL 标准处理的。
在 MySQL 8.0.31 之前，带括号的查询表达式不允许多级ORDER BY或
LIMIT操作，包含这些的语句会被拒绝
ER_NOT_SUPPORTED_YET。在 MySQL 8.0.31 及之后的版本中，取消了此限制，允许嵌套的括号查询表达式。支持的最大嵌套层数为63；这是在解析器执行任何简化或合并之后。
此处显示了此类声明的示例：
mysql> (SELECT 'a' UNION SELECT 'b' LIMIT 2) LIMIT 3;
+---+
| a |
+---+
| a |
| b |
+---+
2 rows in set (0.00 sec)
您应该知道，在 MySQL 8.0.31 及更高版本中，当折叠括号内的表达式主体时，MySQL 遵循 SQL 标准语义，因此较高的外部限制不能覆盖内部较低的限制。例如，(SELECT
... LIMIT 5) LIMIT 10可以返回不超过五行。
© Mysql 中文网
