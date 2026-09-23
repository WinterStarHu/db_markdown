# 12.8.3 函数结果的字符集和整理_MySQL 8.0 参考手册

12.8.3 函数结果的字符集和整理_MySQL 8.0 参考手册
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
12.8.1 字符串比较函数和运算符1
12.8.2 正则表达式1
12.8.3 函数结果的字符集和整理1
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
MySQL 8.0 参考手册  / 第 12 章函数和运算符  / 12.8 字符串函数和运算符  /
12.8.3 函数结果的字符集和整理
12.8.3 函数结果的字符集和整理
MySQL 有许多返回字符串的运算符和函数。本节回答问题：这样一个字符串的字符集和排序规则是什么？
对于接受字符串输入并返回字符串结果作为输出的简单函数，输出的字符集和排序规则与主要输入值的字符集和排序规则相同。例如，
返回与 具有相同字符串和排序规则的字符串
。这同样适用于
,
,
,
,
,
,
,
,
,
,
,
,
,
,
和
。
UPPER(X)XINSTR()LCASE()LOWER()LTRIM()MID()REPEAT()REPLACE()REVERSE()RIGHT()RPAD()RTRIM()SOUNDEX()SUBSTRING()TRIM()UCASE()UPPER()
笔记
与所有其他函数不同，该REPLACE()函数始终忽略字符串输入的排序规则并执行区分大小写的比较。
如果字符串输入或函数结果是二进制字符串，则该字符串具有binary字符集和排序规则。这可以通过使用
CHARSET()和
COLLATION()函数来检查，这两个函数都返回binary一个二进制字符串参数：
mysql> SELECT CHARSET(BINARY 'a'), COLLATION(BINARY 'a');
+---------------------+-----------------------+
| CHARSET(BINARY 'a') | COLLATION(BINARY 'a') |
+---------------------+-----------------------+
| binary              | binary                |
+---------------------+-----------------------+
对于组合多个字符串输入并返回单个字符串输出的操作，标准 SQL 的“聚合规则”适用于确定结果的排序规则：
如果发生显式，请使用
.
COLLATE
YY
如果显式并发生，则引发错误。
COLLATE
YCOLLATE
Z
否则，如果所有排序规则都是
Y，请使用
Y。
否则，结果没有排序规则。
例如，对于，生成的排序规则是。这同样适用于,
,
,
,
,
和
。
CASE ... WHEN a THEN b WHEN b THEN c
COLLATE X ENDXUNION||CONCAT()ELT()GREATEST()IF()LEAST()
对于转换为字符数据的操作，操作产生的字符串的字符集和排序
规则由确定默认连接字符集和排序规则的系统变量定义（请参阅character_set_connection第
10.4 节，“连接字符集和排序规则”） . 这仅适用于、
、
、
、
和
。
collation_connectionBIN_TO_UUID()CAST()CONV()FORMAT()HEX()SPACE()
虚拟生成列的表达式会出现上述原则的例外情况。在此类表达式中，表字符集用于
BIN_TO_UUID()、
CONV()或
HEX()结果，而不管连接字符集如何。
如果对字符串函数返回的结果的字符集或排序规则有任何疑问，请使用
CHARSET()或
COLLATION()函数查找：
mysql> SELECT USER(), CHARSET(USER()), COLLATION(USER());
+----------------+-----------------+--------------------+
| USER()         | CHARSET(USER()) | COLLATION(USER())  |
+----------------+-----------------+--------------------+
| test@localhost | utf8mb3         | utf8mb3_general_ci |
+----------------+-----------------+--------------------+
mysql> SELECT CHARSET(COMPRESS('abc')), COLLATION(COMPRESS('abc'));
+--------------------------+----------------------------+
| CHARSET(COMPRESS('abc')) | COLLATION(COMPRESS('abc')) |
+--------------------------+----------------------------+
| binary                   | binary                     |
+--------------------------+----------------------------+
© Mysql 中文网
