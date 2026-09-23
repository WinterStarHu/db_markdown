# 13.2.14 VALUES 语句_MySQL 8.0 参考手册

13.2.14 VALUES 语句_MySQL 8.0 参考手册
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
13.2.14 VALUES 语句
13.2.14 VALUES 语句
VALUES是 MySQL 8.0.19 中引入的 DML 语句，它返回一组一行或多行作为表。换句话说，它是一个表值构造函数，也可以作为一个独立的 SQL 语句。
VALUES row_constructor_list [ORDER BY column_designator] [LIMIT number]
row_constructor_list:
ROW(value_list)[, ROW(value_list)][, ...]
value_list:
value[, value][, ...]
column_designator:
column_index
该VALUES语句由VALUES关键字组成，后跟一个或多个行构造函数的列表，以逗号分隔。行构造函数由ROW()行构造函数子句和括号中包含的一个或多个标量值的值列表组成。值可以是任何 MySQL 数据类型的文字或解析为标量值的表达式。
ROW()不能为空（但每个提供的标量值都可以是NULL）。ROW()同一
语句中的每个
VALUES值在其值列表中都必须具有相同数量的值。
DEFAULT关键字不受支持
VALUES并导致语法错误，除非它用于在语句中提供
值INSERT。
的输出VALUES是一个表：
mysql> VALUES ROW(1,-2,3), ROW(5,7,9), ROW(4,6,8);
+----------+----------+----------+
| column_0 | column_1 | column_2 |
+----------+----------+----------+
|        1 |       -2 |        3 |
|        5 |        7 |        9 |
|        4 |        6 |        8 |
+----------+----------+----------+
3 rows in set (0.00 sec)
从中输出的表的列
VALUES具有隐式命名的列column_0、column_1、
column_2等，始终以 开头
0。这个事实可用于使用可选ORDER BY子句按列对行进行排序，其方式与此子句用于
SELECT语句的方式相同，如下所示：
mysql> VALUES ROW(1,-2,3), ROW(5,7,9), ROW(4,6,8) ORDER BY column_1;
+----------+----------+----------+
| column_0 | column_1 | column_2 |
+----------+----------+----------+
|        1 |       -2 |        3 |
|        4 |        6 |        8 |
|        5 |        7 |        9 |
+----------+----------+----------+
3 rows in set (0.00 sec)
在MySQL 8.0.21及之后的版本中，该
VALUES语句还支持
LIMIT限制输出行数的子句。（以前，LIMIT允许但什么也没做。）
该VALUES语句对于列值的数据类型是宽松的；您可以在同一列中混合类型，如下所示：
mysql> VALUES ROW("q", 42, '2019-12-18'),
->     ROW(23, "abc", 98.6),
->     ROW(27.0002, "Mary Smith", '{"a": 10, "b": 25}');
+----------+------------+--------------------+
| column_0 | column_1   | column_2           |
+----------+------------+--------------------+
| q        | 42         | 2019-12-18         |
| 23       | abc        | 98.6               |
| 27.0002  | Mary Smith | {"a": 10, "b": 25} |
+----------+------------+--------------------+
3 rows in set (0.00 sec)
重要的
VALUES用一个或多个
ROW()acts 实例作为表值构造函数；尽管它可用于在
INSERTor
REPLACE语句中提供值，但不要将它与VALUES也用于此目的的关键字混淆。您也不应该将它与
VALUES()引用
INSERT ...
ON DUPLICATE KEY UPDATE.
您还应该记住，这ROW()是一个行值构造函数（请参阅第 13.2.11.5 节，“行子查询”），而VALUES ROW()是一个表值构造函数；两者不能互换使用。
VALUES可用于您可以雇用的许多情况SELECT，包括此处列出的情况：
使用UNION，如下所示：
mysql> SELECT 1,2 UNION SELECT 10,15;
+----+----+
| 1  | 2  |
+----+----+
|  1 |  2 |
| 10 | 15 |
+----+----+
2 rows in set (0.00 sec)
mysql> VALUES ROW(1,2) UNION VALUES ROW(10,15);
+----------+----------+
| column_0 | column_1 |
+----------+----------+
|        1 |        2 |
|       10 |       15 |
+----------+----------+
2 rows in set (0.00 sec)
您可以将具有多行的构造表合并在一起，如下所示：
mysql> VALUES ROW(1,2), ROW(3,4), ROW(5,6)
>     UNION VALUES ROW(10,15),ROW(20,25);
+----------+----------+
| column_0 | column_1 |
+----------+----------+
|        1 |        2 |
|        3 |        4 |
|        5 |        6 |
|       10 |       15 |
|       20 |       25 |
+----------+----------+
5 rows in set (0.00 sec)
在这种情况下，您也可以（通常最好是）
UNION完全省略并使用单个VALUES语句，如下所示：
mysql> VALUES ROW(1,2), ROW(3,4), ROW(5,6), ROW(10,15), ROW(20,25);
+----------+----------+
| column_0 | column_1 |
+----------+----------+
|        1 |        2 |
|        3 |        4 |
|        5 |        6 |
|       10 |       15 |
|       20 |       25 |
+----------+----------+
VALUES也可以与
SELECT语句、
TABLE语句或两者结合使用。
中构造的表
UNION必须包含相同数量的列，就像您使用
SELECT. 有关更多示例，请参见
第 13.2.10.3 节，“UNION 子句”。
在加入。有关更多信息和示例，
请参阅第 13.2.10.2 节，“JOIN 子句” 。VALUES()在
INSERTor
语句中
代替REPLACE，在这种情况下，其语义与此处描述的略有不同。有关详细信息，请参阅第 13.2.6 节，“INSERT 语句”。
代替 和 中的源
CREATE
TABLE ... SELECT表
CREATE VIEW ...
SELECT。有关更多信息和示例，请参阅这些语句的描述。
© Mysql 中文网
