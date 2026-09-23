# 12.25.5 精度数学示例_MySQL 8.0 参考手册

12.25.5 精度数学示例_MySQL 8.0 参考手册
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
12.1 内置函数和操作符参考
12.2 可加载函数参考
12.3 表达式求值中的类型转换
12.4 运营商
12.5 流量控制函数
12.6 数值函数和运算符
12.7 日期和时间函数
12.8 字符串函数和运算符
12.9 MySQL 使用什么日历？
12.10 全文搜索功能
12.11 转换函数和运算符
12.12 XML函数
12.13 位函数和运算符
12.14 加密和压缩函数
12.15 锁定函数
12.16 信息函数
12.17空间分析函数
12.18 JSON函数
12.19 与全局事务标识符（GTID）一起使用的函数
12.20聚合函数
12.21 窗口函数
12.22性能模式函数
12.23 内部函数
12.24 辅助功能
12.25 精密数学
12.25.1 数值类型1
12.25.2 DECIMAL 数据类型特征1
12.25.3 表达式处理1
12.25.4 舍入行为1
12.25.5 精度数学示例1
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
MySQL 8.0 参考手册  / 第 12 章函数和运算符  / 12.25 精密数学  /
12.25.5 精度数学示例
12.25.5 精度数学示例
本节提供一些示例，显示 MySQL 中的精确数学查询结果。这些示例演示了第 12.25.3 节“表达式处理”和
第 12.25.4 节“舍入行为”中描述的原则。
示例 1。在可能的情况下使用数字及其精确值：
mysql> SELECT (.1 + .2) = .3;
+----------------+
| (.1 + .2) = .3 |
+----------------+
|              1 |
+----------------+
对于浮点值，结果不准确：
mysql> SELECT (.1E0 + .2E0) = .3E0;
+----------------------+
| (.1E0 + .2E0) = .3E0 |
+----------------------+
|                    0 |
+----------------------+
另一种查看精确值和近似值处理差异的方法是多次将一个小数加到总和中。考虑以下存储过程，它
.0001向变量添加 1,000 次。
CREATE PROCEDURE p ()
BEGIN
DECLARE i INT DEFAULT 0;
DECLARE d DECIMAL(10,4) DEFAULT 0;
DECLARE f FLOAT DEFAULT 0;
WHILE i < 10000 DO
SET d = d + .0001;
SET f = f + .0001E0;
SET i = i + 1;
END WHILE;
SELECT d, f;
END;d逻辑上和
的总和f
应为 1，但这仅适用于小数计算。浮点计算引入了小错误：
+--------+------------------+
| d      | f                |
+--------+------------------+
| 1.0000 | 0.99999999999991 |
+--------+------------------+
示例 2。乘法以标准 SQL 所需的比例执行。也就是说，对于两个数字X1和
X2具有规模
S1和S2，结果的规模是：
S1
+ S2mysql> SELECT .01 * .01;
+-----------+
| .01 * .01 |
+-----------+
| 0.0001    |
+-----------+
示例 3。精确值数字的舍入行为是明确定义的：
舍入行为（例如，
ROUND()函数）独立于底层 C 库的实现，这意味着结果在平台之间是一致的。
精确值列（DECIMAL和整数）和精确值数字的舍入使用“从零舍入一半”规则。小数部分为 .5 或更大的值从零四舍五入到最接近的整数，如下所示：
mysql> SELECT ROUND(2.5), ROUND(-2.5);
+------------+-------------+
| ROUND(2.5) | ROUND(-2.5) |
+------------+-------------+
| 3          | -3          |
+------------+-------------+
浮点值的舍入使用 C 库，它在许多系统上使用“舍入到最接近的偶数”
规则。小数部分正好在两个整数中间的值四舍五入到最接近的偶数：
mysql> SELECT ROUND(2.5E0), ROUND(-2.5E0);
+--------------+---------------+
| ROUND(2.5E0) | ROUND(-2.5E0) |
+--------------+---------------+
|            2 |            -2 |
+--------------+---------------+
例 4。在严格模式下，插入一个超出列范围的值会导致错误，而不是截断为合法值。
当 MySQL 未在严格模式下运行时，将截断为合法值：
mysql> SET sql_mode='';
Query OK, 0 rows affected (0.00 sec)
mysql> CREATE TABLE t (i TINYINT);
Query OK, 0 rows affected (0.01 sec)
mysql> INSERT INTO t SET i = 128;
Query OK, 1 row affected, 1 warning (0.00 sec)
mysql> SELECT i FROM t;
+------+
| i    |
+------+
|  127 |
+------+
1 row in set (0.00 sec)
但是，如果严格模式生效，则会发生错误：
mysql> SET sql_mode='STRICT_ALL_TABLES';
Query OK, 0 rows affected (0.00 sec)
mysql> CREATE TABLE t (i TINYINT);
Query OK, 0 rows affected (0.00 sec)
mysql> INSERT INTO t SET i = 128;
ERROR 1264 (22003): Out of range value adjusted for column 'i' at row 1
mysql> SELECT i FROM t;
Empty set (0.00 sec)
示例 5：在严格模式和ERROR_FOR_DIVISION_BY_ZERO
set 下，除以零会导致错误，而不是
NULL.
在非严格模式下，除以零的结果为
NULL：
mysql> SET sql_mode='';
Query OK, 0 rows affected (0.01 sec)
mysql> CREATE TABLE t (i TINYINT);
Query OK, 0 rows affected (0.00 sec)
mysql> INSERT INTO t SET i = 1 / 0;
Query OK, 1 row affected (0.00 sec)
mysql> SELECT i FROM t;
+------+
| i    |
+------+
| NULL |
+------+
1 row in set (0.03 sec)
但是，如果正确的 SQL 模式有效，除以零是错误的：
mysql> SET sql_mode='STRICT_ALL_TABLES,ERROR_FOR_DIVISION_BY_ZERO';
Query OK, 0 rows affected (0.00 sec)
mysql> CREATE TABLE t (i TINYINT);
Query OK, 0 rows affected (0.00 sec)
mysql> INSERT INTO t SET i = 1 / 0;
ERROR 1365 (22012): Division by 0
mysql> SELECT i FROM t;
Empty set (0.01 sec)
例子 6。精确值文字被评估为精确值。
近似值文字使用浮点数计算，但精确值文字处理为
DECIMAL：
mysql> CREATE TABLE t SELECT 2.5 AS a, 25E-1 AS b;
Query OK, 1 row affected (0.01 sec)
Records: 1  Duplicates: 0  Warnings: 0
mysql> DESCRIBE t;
+-------+-----------------------+------+-----+---------+-------+
| Field | Type                  | Null | Key | Default | Extra |
+-------+-----------------------+------+-----+---------+-------+
| a     | decimal(2,1) unsigned | NO   |     | 0.0     |       |
| b     | double                | NO   |     | 0       |       |
+-------+-----------------------+------+-----+---------+-------+
2 rows in set (0.01 sec)
例 7。如果聚合函数的参数是精确数值类型，则结果也是精确数值类型，其标度至少是参数的标度。
考虑这些陈述：
mysql> CREATE TABLE t (i INT, d DECIMAL, f FLOAT);
mysql> INSERT INTO t VALUES(1,1,1);
mysql> CREATE TABLE y SELECT AVG(i), AVG(d), AVG(f) FROM t;
结果仅为浮点参数的双精度值。对于精确类型参数，结果也是精确类型：
mysql> DESCRIBE y;
+--------+---------------+------+-----+---------+-------+
| Field  | Type          | Null | Key | Default | Extra |
+--------+---------------+------+-----+---------+-------+
| AVG(i) | decimal(14,4) | YES  |     | NULL    |       |
| AVG(d) | decimal(14,4) | YES  |     | NULL    |       |
| AVG(f) | double        | YES  |     | NULL    |       |
+--------+---------------+------+-----+---------+-------+
结果仅为浮点参数的双精度值。对于精确类型参数，结果也是精确类型。
© Mysql 中文网
