# 12.4.4 赋值运算符_MySQL 8.0 参考手册

12.4.4 赋值运算符_MySQL 8.0 参考手册
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
12.4.1 运算符优先级1
12.4.2 比较函数和运算符1
12.4.3 逻辑运算符1
12.4.4 赋值运算符1
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
MySQL 8.0 参考手册  / 第 12 章函数和运算符  / 12.4 运营商  /
12.4.4 赋值运算符
12.4.4 赋值运算符
表 12.6 赋值运算符
姓名
描述
:=
赋值
=
赋值（作为
SET
语句的一部分，或作为语句中SET子句的
一部分UPDATE）
:=
赋值运算符。使运算符左侧的用户变量取其右侧的值。右侧的值可以是文字值、存储值的另一个变量或产生标量值的任何合法表达式，包括查询结果（前提是该值是标量值）。您可以在同一
SET
语句中执行多个赋值。您可以在同一语句中执行多个赋值。
与 不同
=，该
:=
运算符永远不会被解释为比较运算符。这意味着您可以
:=在任何有效的 SQL 语句（不仅仅是
SET
语句）中使用来为变量赋值。
mysql> SELECT @var1, @var2;
-> NULL, NULL
mysql> SELECT @var1 := 1, @var2;
-> 1, NULL
mysql> SELECT @var1, @var2;
-> 1, NULL
mysql> SELECT @var1, @var2 := @var1;
-> 1, 1
mysql> SELECT @var1, @var2;
-> 1, 1
mysql> SELECT @var1:=COUNT(*) FROM t1;
-> 4
mysql> SELECT @var1;
-> 4:=除了 ，您还可以使用 in 其他语句
进行赋值
SELECT，例如
UPDATE，如下所示：
mysql> SELECT @var1;
-> 4
mysql> SELECT * FROM t1;
-> 1, 3, 5, 7
mysql> UPDATE t1 SET c1 = 2 WHERE c1 = @var1:= 1;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0
mysql> SELECT @var1;
-> 1
mysql> SELECT * FROM t1;
-> 2, 3, 5, 7
虽然也可以使用
:=
运算符在单个 SQL 语句中设置和读取同一变量的值，但不建议这样做。
第 9.4 节，“用户定义的变量”，解释了为什么你应该避免这样做。
=
此运算符用于在两种情况下执行值分配，将在接下来的两段中进行描述。
在
SET
语句中，=被视为赋值运算符，使运算符左侧的用户变量取其右侧的值。（换句话说，当在
SET
语句中使用时，=被视为与 相同
:=。）右侧的值可以是文字值、存储值的另一个变量或产生标量值的任何合法表达式，包括结果一个查询（前提是这个值是一个标量值）。您可以在同一
SET
语句中执行多个赋值。
在语句的SET子句中
UPDATE，
=也充当赋值运算符；然而，在这种情况下，它会导致在运算符左侧命名的列采用右侧给定的值，前提是满足WHERE属于 的任何条件UPDATE。您可以在语句的同一
SET子句中
进行多项赋值UPDATE。
在任何其他上下文中，=被视为
比较运算符。
mysql> SELECT @var1, @var2;
-> NULL, NULL
mysql> SELECT @var1 := 1, @var2;
-> 1, NULL
mysql> SELECT @var1, @var2;
-> 1, NULL
mysql> SELECT @var1, @var2 := @var1;
-> 1, 1
mysql> SELECT @var1, @var2;
-> 1, 1
有关详细信息，请参阅第 13.7.6.1 节，“变量赋值的 SET 语法”、
第 13.2.13 节，“UPDATE 语句”和第 13.2.11 节，“子查询”。
© Mysql 中文网
