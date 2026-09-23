# 11.1.7 超出范围和溢出处理_MySQL 8.0 参考手册

11.1.7 超出范围和溢出处理_MySQL 8.0 参考手册
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
11.1 数值数据类型
11.1.1 数字数据类型语法1
11.1.2 整数类型（精确值）——INTEGER、INT、SMALLINT、TINYINT、MEDIUMINT、BIGINT1
11.1.3 定点类型（精确值）——DECIMAL、NUMERIC1
11.1.4 浮点类型（近似值）——FLOAT、DOUBLE1
11.1.5 比特值类型——BIT1
11.1.6 数值类型属性1
11.1.7 超出范围和溢出处理1
11.2 日期和时间数据类型
11.3 字符串数据类型
11.4 空间数据类型
11.5 JSON数据类型
11.6 数据类型默认值
11.7 数据类型存储要求
11.8 为列选择正确的类型
11.9 使用来自其他数据库引擎的数据类型
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
MySQL 8.0 参考手册  / 第 11 章数据类型  / 11.1 数值数据类型  /
11.1.7 超出范围和溢出处理
11.1.7 超出范围和溢出处理
当 MySQL 将值存储在列数据类型允许范围之外的数字列中时，结果取决于当时有效的 SQL 模式：
如果启用了严格的 SQL 模式，MySQL 会根据 SQL 标准拒绝超出范围的值并出错，并且插入失败。
如果没有启用限制模式，MySQL 会将值裁剪到列数据类型范围的适当端点，并存储结果值。
当将超出范围的值分配给整数列时，MySQL 存储表示列数据类型范围的相应端点的值。
当为浮点或定点列分配的值超出指定（或默认）精度和小数位数隐含的范围时，MySQL 存储表示该范围相应端点的值。
假设一个表t1有这样的定义：
CREATE TABLE t1 (i1 TINYINT, i2 TINYINT UNSIGNED);
启用严格 SQL 模式后，会发生超出范围的错误：
mysql> SET sql_mode = 'TRADITIONAL';
mysql> INSERT INTO t1 (i1, i2) VALUES(256, 256);
ERROR 1264 (22003): Out of range value for column 'i1' at row 1
mysql> SELECT * FROM t1;
Empty set (0.00 sec)
在未启用严格 SQL 模式的情况下，会出现带有警告的裁剪：
mysql> SET sql_mode = '';
mysql> INSERT INTO t1 (i1, i2) VALUES(256, 256);
mysql> SHOW WARNINGS;
+---------+------+---------------------------------------------+
| Level   | Code | Message                                     |
+---------+------+---------------------------------------------+
| Warning | 1264 | Out of range value for column 'i1' at row 1 |
| Warning | 1264 | Out of range value for column 'i2' at row 1 |
+---------+------+---------------------------------------------+
mysql> SELECT * FROM t1;
+------+------+
| i1   | i2   |
+------+------+
|  127 |  255 |
+------+------+
当未启用严格 SQL 模式时，由于裁剪而发生的列分配转换将报告为ALTER TABLE、
LOAD DATA、
UPDATE和多行
INSERT语句的警告。在严格模式下，这些语句会失败，部分或全部值不会被插入或更改，这取决于表是否是事务表和其他因素。有关详细信息，请参阅
第 5.1.11 节，“服务器 SQL 模式”。
数值表达式计算期间溢出会导致错误。例如，最大的有符号
BIGINT值是 9223372036854775807，所以下面的表达式会产生错误：
mysql> SELECT 9223372036854775807 + 1;
ERROR 1690 (22003): BIGINT value is out of range in '(9223372036854775807 + 1)'
在这种情况下，要使操作成功，请将值转换为无符号；
mysql> SELECT CAST(9223372036854775807 AS UNSIGNED) + 1;
+-------------------------------------------+
| CAST(9223372036854775807 AS UNSIGNED) + 1 |
+-------------------------------------------+
|                       9223372036854775808 |
+-------------------------------------------+
是否发生溢出取决于操作数的范围，因此处理上述表达式的另一种方法是使用精确值算法，因为
DECIMAL值的范围比整数大：
mysql> SELECT 9223372036854775807.0 + 1;
+---------------------------+
| 9223372036854775807.0 + 1 |
+---------------------------+
|     9223372036854775808.0 |
+---------------------------+
默认情况下，整数值之间的减法，其中一个是类型
UNSIGNED，会产生一个无符号的结果。如果结果为负，则会产生错误：
mysql> SET sql_mode = '';
Query OK, 0 rows affected (0.00 sec)
mysql> SELECT CAST(0 AS UNSIGNED) - 1;
ERROR 1690 (22003): BIGINT UNSIGNED value is out of range in '(cast(0 as unsigned) - 1)'
如果NO_UNSIGNED_SUBTRACTION
启用 SQL 模式，则结果是否定的：
mysql> SET sql_mode = 'NO_UNSIGNED_SUBTRACTION';
mysql> SELECT CAST(0 AS UNSIGNED) - 1;
+-------------------------+
| CAST(0 AS UNSIGNED) - 1 |
+-------------------------+
|                      -1 |
+-------------------------+
如果此类操作的结果用于更新
UNSIGNED整数列，则结果将被裁剪为列类型的最大值，或者如果NO_UNSIGNED_SUBTRACTION
启用则裁剪为 0。如果启用了严格 SQL 模式，则会发生错误并且该列保持不变。
© Mysql 中文网
