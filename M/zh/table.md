# 13.2.12 TABLE 语句_MySQL 8.0 参考手册

13.2.12 TABLE 语句_MySQL 8.0 参考手册
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
13.2.12 TABLE 语句
13.2.12 TABLE 语句
TABLE是 MySQL 8.0.19 中引入的 DML 语句，它返回指定表的行和列。
TABLE table_name [ORDER BY column_name] [LIMIT number [OFFSET number]]
该TABLE语句在某些方面就像SELECT. 鉴于存在名为 的表t，以下两个语句产生相同的输出：
TABLE t;
SELECT * FROM t;TABLE您可以分别对使用ORDER
BY和LIMIT子句
生成的行数进行排序和限制
。这些功能与 with 一起使用时的相同子句相同
SELECT（包括可选
OFFSET子句 with LIMIT），如您在此处所见：
mysql> TABLE t;
+----+----+
| a  | b  |
+----+----+
|  1 |  2 |
|  6 |  7 |
|  9 |  5 |
| 10 | -4 |
| 11 | -1 |
| 13 |  3 |
| 14 |  6 |
+----+----+
7 rows in set (0.00 sec)
mysql> TABLE t ORDER BY b;
+----+----+
| a  | b  |
+----+----+
| 10 | -4 |
| 11 | -1 |
|  1 |  2 |
| 13 |  3 |
|  9 |  5 |
| 14 |  6 |
|  6 |  7 |
+----+----+
7 rows in set (0.00 sec)
mysql> TABLE t LIMIT 3;
+---+---+
| a | b |
+---+---+
| 1 | 2 |
| 6 | 7 |
| 9 | 5 |
+---+---+
3 rows in set (0.00 sec)
mysql> TABLE t ORDER BY b LIMIT 3;
+----+----+
| a  | b  |
+----+----+
| 10 | -4 |
| 11 | -1 |
|  1 |  2 |
+----+----+
3 rows in set (0.00 sec)
mysql> TABLE t ORDER BY b LIMIT 3 OFFSET 2;
+----+----+
| a  | b  |
+----+----+
|  1 |  2 |
| 13 |  3 |
|  9 |  5 |
+----+----+
3 rows in set (0.00 sec)
TABLESELECT在两个关键方面
不同于
：
TABLE始终显示表的所有列。
TABLE不允许任意过滤行；也就是说，TABLE
不支持任何WHERE子句。
为了限制返回哪些表列，过滤超出使用ORDER BY
和LIMIT/或两者可以完成的行，使用
SELECT。
TABLE可以与临时表一起使用。
TABLE也可以用于代替
SELECT许多其他结构，包括此处列出的结构：
使用UNION，如下所示：
mysql> TABLE t1;
+---+----+
| a | b  |
+---+----+
| 2 | 10 |
| 5 |  3 |
| 7 |  8 |
+---+----+
3 rows in set (0.00 sec)
mysql> TABLE t2;
+---+---+
| a | b |
+---+---+
| 1 | 2 |
| 3 | 4 |
| 6 | 7 |
+---+---+
3 rows in set (0.00 sec)
mysql> TABLE t1 UNION TABLE t2;
+---+----+
| a | b  |
+---+----+
| 2 | 10 |
| 5 |  3 |
| 7 |  8 |
| 1 |  2 |
| 3 |  4 |
| 6 |  7 |
+---+----+
6 rows in set (0.00 sec)
刚才展示的UNION相当于下面的语句：
mysql> SELECT * FROM t1 UNION SELECT * FROM t2;
+---+----+
| a | b  |
+---+----+
| 2 | 10 |
| 5 |  3 |
| 7 |  8 |
| 1 |  2 |
| 3 |  4 |
| 6 |  7 |
+---+----+
6 rows in set (0.00 sec)
TABLE也可以与SELECT语句、
VALUES语句或两者联合使用。请参阅
第 13.2.10.3 节，“UNION 子句”。
使用INTO填充用户变量，使用INTO OUTFILE或INTO
DUMPFILE将表数据写入文件。有关更具体的信息和示例，
请参阅
第 13.2.10.1 节，“SELECT ... INTO 语句” 。
在许多情况下，您可以使用子查询。t1给定具有名为 的列的
任何表
，以及
具有单个列
a的第二个表，如下语句是可能的：t2SELECT * FROM t1 WHERE a IN (TABLE t2);
假设表的单列t1
名为x，前面的内容等同于此处显示的每个语句（并且在两种情况下产生完全相同的结果）：
SELECT * FROM t1 WHERE a IN (SELECT x FROM t2);
SELECT * FROM t1 WHERE a IN (SELECT * FROM t2);
有关更多信息，请参阅第 13.2.11 节，“子查询”。
WithINSERT和
REPLACE语句，否则您将使用
SELECT *. 有关更多信息和示例，
请参阅第 13.2.6.1 节，“INSERT ... SELECT 语句” 。
TABLE在许多情况下也可以用来代替SELECTin
CREATE
TABLE ... SELECT或
CREATE VIEW ...
SELECT. 有关更多信息和示例，请参阅这些语句的描述。
© Mysql 中文网
