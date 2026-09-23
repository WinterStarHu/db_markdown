# 13.2.12 集合操作_MySQL 8.0 参考手册

13.2.12 集合操作_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 13 章 SQL 语句  / 13.2 数据操作语句  /
13.2.12 集合操作
13.2.12 集合操作
13.2.12.1 UNION 子句13.2.12.2 INTERSECT 子句13.2.12.3 EXCEPT 子句
SQL 集操作将多个查询块的结果合并为一个结果。查询块，有时也称为简单表，是返回结果集的任何 SQL 语句，例如
SELECT。MySQL 8.0（8.0.19 及更高版本）也支持TABLEand
VALUES语句。有关更多信息，请参阅本章其他地方对这些语句的单独描述。
SQL 标准定义了以下三个集合操作：
UNION：将来自两个查询块的所有结果组合成一个结果，省略任何重复项。
INTERSECT：仅合并两个查询块的结果共有的那些行，省略任何重复项。
EXCEPT：对于两个查询块
Aand B，返回所有A不存在于中的结果B，省略任何重复项。
（某些数据库系统，例如 Oracle，使用
MINUS此操作符的名称。MySQL 不支持此操作。）
MySQL 早就支持了UNION；MySQL 8.0 添加了对INTERSECTand
的支持EXCEPT（MySQL 8.0.31 及更高版本）。
这些集合运算符中的每一个都支持一个ALL
修饰符。当ALL关键字跟在集合运算符之后时，这会导致结果中包含重复项。有关详细信息和示例，请参阅以下涵盖各个运算符的部分。
所有三个集合运算符还支持一个DISTINCT
关键字，它可以抑制结果中的重复项。由于这是集合运算符的默认行为，因此通常没有必要DISTINCT明确指定。
通常，查询块和集合操作可以以任意数量和顺序组合。此处显示了一个大大简化的表示：
query_block [set_op query_block] [set_op query_block] ...
query_block:
SELECT | TABLE | VALUES
set_op:
UNION | INTERSECT | EXCEPT
这可以更准确、更详细地表示，如下所示：
query_expression:
[with_clause] /* WITH clause */
query_expression_body
[order_by_clause] [limit_clause] [into_clause]
query_expression_body:
query_term
|  query_expression_body UNION [ALL | DISTINCT] query_term
|  query_expression_body EXCEPT [ALL | DISTINCT] query_term
query_term:
query_primary
|  query_term INTERSECT [ALL | DISTINCT] query_block
query_primary:
query_block
|  '(' query_expression_body [order_by_clause] [limit_clause] [into_clause] ')'
query_block:   /* also known as a simple table */
query_specification                     /* SELECT statement */
|  table_value_constructor                 /* VALUES statement */
|  explicit_table                          /* TABLE statement  */
您应该知道INTERSECT是 在UNION或之前计算的EXCEPT。这意味着，例如，TABLE x UNION TABLE y INTERSECT
TABLE z始终被评估为TABLE x UNION
(TABLE y INTERSECT TABLE z). 有关详细信息，请参阅
第 13.2.12.2 节，“INTERSECT 子句”。
此外，您应该记住，虽然
UNION和INTERSECT集合运算符是可交换的（顺序不重要），
EXCEPT但不是（操作数的顺序影响结果）。换句话说，以下所有陈述都是正确的：
TABLE x UNION TABLE y并TABLE y
UNION TABLE x产生相同的结果，尽管行的顺序可能不同。ORDER BY您可以使用;强制它们相同 请参阅
Unions 中的 ORDER BY 和 LIMIT。
TABLE x INTERSECT TABLE y并
TABLE y INTERSECT TABLE x返回相同的结果。
TABLE x EXCEPT TABLE y并且TABLE y
EXCEPT TABLE x不会产生相同的结果。
更多信息和示例可以在以下部分中找到。
© Mysql 中文网
