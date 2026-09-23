# 12.21.2 窗口函数概念和语法_MySQL 8.0 参考手册

12.21.2 窗口函数概念和语法_MySQL 8.0 参考手册
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
12.21.1 窗口函数说明1
12.21.2 窗口函数概念和语法1
12.21.3 窗口函数框架规范1
12.21.4 命名窗口1
12.21.5 窗口函数限制1
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
MySQL 8.0 参考手册  / 第 12 章函数和运算符  / 12.21 窗口函数  /
12.21.2 窗口函数概念和语法
12.21.2 窗口函数概念和语法
本节介绍如何使用窗口函数。示例使用与第 12.20.2 节“GROUP BY 修饰符”GROUPING()中函数
讨论中相同的销售信息数据集：
mysql> SELECT * FROM sales ORDER BY country, year, product;
+------+---------+------------+--------+
| year | country | product    | profit |
+------+---------+------------+--------+
| 2000 | Finland | Computer   |   1500 |
| 2000 | Finland | Phone      |    100 |
| 2001 | Finland | Phone      |     10 |
| 2000 | India   | Calculator |     75 |
| 2000 | India   | Calculator |     75 |
| 2000 | India   | Computer   |   1200 |
| 2000 | USA     | Calculator |     75 |
| 2000 | USA     | Computer   |   1500 |
| 2001 | USA     | Calculator |     50 |
| 2001 | USA     | Computer   |   1500 |
| 2001 | USA     | Computer   |   1200 |
| 2001 | USA     | TV         |    150 |
| 2001 | USA     | TV         |    100 |
+------+---------+------------+--------+
窗口函数对一组查询行执行类似聚合的操作。然而，聚合操作将查询行分组为单个结果行，而窗口函数为每个查询行生成一个结果：
发生函数计算的行称为当前行。
与对其进行函数评估的当前行相关的查询行构成当前行的窗口。
例如，使用销售信息表，这两个查询执行聚合操作，为作为一个组的所有行生成单个全局总和，并按国家/地区分组总和：
mysql> SELECT SUM(profit) AS total_profit
FROM sales;
+--------------+
| total_profit |
+--------------+
|         7535 |
+--------------+
mysql> SELECT country, SUM(profit) AS country_profit
FROM sales
GROUP BY country
ORDER BY country;
+---------+----------------+
| country | country_profit |
+---------+----------------+
| Finland |           1610 |
| India   |           1350 |
| USA     |           4575 |
+---------+----------------+
相比之下，窗口操作不会将查询行组折叠为单个输出行。相反，它们为每一行生成一个结果。与前面的查询一样，以下查询使用
SUM(), 但这次作为窗口函数：
mysql> SELECT
year, country, product, profit,
SUM(profit) OVER() AS total_profit,
SUM(profit) OVER(PARTITION BY country) AS country_profit
FROM sales
ORDER BY country, year, product, profit;
+------+---------+------------+--------+--------------+----------------+
| year | country | product    | profit | total_profit | country_profit |
+------+---------+------------+--------+--------------+----------------+
| 2000 | Finland | Computer   |   1500 |         7535 |           1610 |
| 2000 | Finland | Phone      |    100 |         7535 |           1610 |
| 2001 | Finland | Phone      |     10 |         7535 |           1610 |
| 2000 | India   | Calculator |     75 |         7535 |           1350 |
| 2000 | India   | Calculator |     75 |         7535 |           1350 |
| 2000 | India   | Computer   |   1200 |         7535 |           1350 |
| 2000 | USA     | Calculator |     75 |         7535 |           4575 |
| 2000 | USA     | Computer   |   1500 |         7535 |           4575 |
| 2001 | USA     | Calculator |     50 |         7535 |           4575 |
| 2001 | USA     | Computer   |   1200 |         7535 |           4575 |
| 2001 | USA     | Computer   |   1500 |         7535 |           4575 |
| 2001 | USA     | TV         |    100 |         7535 |           4575 |
| 2001 | USA     | TV         |    150 |         7535 |           4575 |
+------+---------+------------+--------+--------------+----------------+
查询中的每个窗口操作都通过包含一个OVER子句来表示，该子句指定如何将查询行划分为组以供窗口函数处理：
第一个OVER子句为空，它将整个查询行集视为一个分区。窗口函数因此产生一个全局总和，但对每一行都这样做。
第二个OVER子句按国家/地区对行进行分区，生成每个分区（每个国家/地区）的总和。该函数为每个分区行生成此总和。
窗口函数只允许在选择列表和
ORDER BY子句中使用。查询结果行由FROM子句确定，after
WHERE, GROUP BY, and
HAVING处理，开窗执行发生在ORDER BY,
LIMIT, 和之前SELECT
DISTINCT。
许多聚合函数都允许该OVER子句，因此可以将其用作窗口或非窗口函数，具体取决于该
OVER子句是否存在：
AVG()
BIT_AND()
BIT_OR()
BIT_XOR()
COUNT()
JSON_ARRAYAGG()
JSON_OBJECTAGG()
MAX()
MIN()
STDDEV_POP(), STDDEV(), STD()
STDDEV_SAMP()
SUM()
VAR_POP(), VARIANCE()
VAR_SAMP()
有关每个聚合函数的详细信息，请参阅
第 12.20.1 节，“聚合函数说明”。
MySQL 还支持仅用作窗口函数的非聚合函数。对于这些，该OVER条款是强制性的：
CUME_DIST()
DENSE_RANK()
FIRST_VALUE()
LAG()
LAST_VALUE()
LEAD()
NTH_VALUE()
NTILE()
PERCENT_RANK()
RANK()
ROW_NUMBER()
有关每个非聚合函数的详细信息，请参阅
第 12.21.1 节，“窗口函数说明”。
作为这些非聚合窗口函数之一的示例，此查询使用ROW_NUMBER()，它生成其分区内每一行的行号。在这种情况下，行按国家/地区编号。默认情况下，分区行是无序的，行编号是不确定的。要对分区行进行排序，
ORDER BY请在窗口定义中包含一个子句。该查询使用无序和有序分区（the
row_num1和row_num2
列）来说明省略和包含之间的区别ORDER BY：
mysql> SELECT
year, country, product, profit,
ROW_NUMBER() OVER(PARTITION BY country) AS row_num1,
ROW_NUMBER() OVER(PARTITION BY country ORDER BY year, product) AS row_num2
FROM sales;
+------+---------+------------+--------+----------+----------+
| year | country | product    | profit | row_num1 | row_num2 |
+------+---------+------------+--------+----------+----------+
| 2000 | Finland | Computer   |   1500 |        2 |        1 |
| 2000 | Finland | Phone      |    100 |        1 |        2 |
| 2001 | Finland | Phone      |     10 |        3 |        3 |
| 2000 | India   | Calculator |     75 |        2 |        1 |
| 2000 | India   | Calculator |     75 |        3 |        2 |
| 2000 | India   | Computer   |   1200 |        1 |        3 |
| 2000 | USA     | Calculator |     75 |        5 |        1 |
| 2000 | USA     | Computer   |   1500 |        4 |        2 |
| 2001 | USA     | Calculator |     50 |        2 |        3 |
| 2001 | USA     | Computer   |   1500 |        3 |        4 |
| 2001 | USA     | Computer   |   1200 |        7 |        5 |
| 2001 | USA     | TV         |    150 |        1 |        6 |
| 2001 | USA     | TV         |    100 |        6 |        7 |
+------+---------+------------+--------+----------+----------+
如前所述，要使用窗口函数（或将聚合函数视为窗口函数），
OVER请在函数调用后包含一个子句。该
OVER子句有两种形式：
over_clause:
{OVER (window_spec) | OVER window_name}
两种形式都定义了窗口函数应该如何处理查询行。它们的区别在于窗口是直接在OVER子句中定义，还是由对查询中其他地方定义的命名窗口的引用提供：
在第一种情况下，窗口规范直接出现在OVER子句中的括号之间。
在第二种情况下，是由查询中其他地方的子句window_name
定义的窗口规范的名称
。WINDOW有关详细信息，请参阅
第 12.21.4 节，“命名窗口”。
对于语法，窗口规范有几个部分，都是可选的：
OVER
(window_spec)window_spec:
[window_name] [partition_clause] [order_clause] [frame_clause]
如果OVER()为空，则窗口由所有查询行组成，窗口函数使用所有行计算结果。否则，括号内的子句确定哪些查询行用于计算函数结果以及它们如何分区和排序：
window_nameWINDOW: 由查询中其他地方的子句定义的窗口的名称。如果window_name在OVER子句中单独出现，则它完全定义了窗口。如果还给出了分区、排序或框架子句，它们会修改命名窗口的解释。有关详细信息，请参阅
第 12.21.4 节，“命名窗口”。
partition_clause: 一个
PARTITION BY子句指示如何将查询行分组。给定行的窗口函数结果基于包含该行的分区的行。如果PARTITION BY省略，则存在由所有查询行组成的单个分区。
笔记
窗口函数的分区不同于表分区。有关表分区的信息，请参阅第 24 章，分区。
partition_clause有这样的语法：
partition_clause:
PARTITION BY expr [, expr] ...
标准 SQLPARTITION BY只需要后跟列名。MySQL 扩展是允许表达式，而不仅仅是列名。例如，如果表包含TIMESTAMP
名为 的列ts，则标准 SQL 允许
PARTITION BY ts但不允许
PARTITION BY HOUR(ts)，而 MySQL 则两者都允许。
order_clause：一个ORDER
BY子句指示如何对每个分区中的行进行排序。根据
ORDER BY子句相等的分区行被认为是对等的。如果
ORDER BY省略，则分区行是无序的，不暗示处理顺序，并且所有分区行都是对等的。
order_clause有这样的语法：
order_clause:
ORDER BY expr [ASC|DESC] [, expr [ASC|DESC]] ...
每个ORDER BY表达式后面可以有选择地跟有ASCor
DESC来指示排序方向。ASC如果未指定方向，则为默认值。NULL对于升序排序，值首先排序，对于降序排序，最后排序。
窗口中的ORDER BY定义适用于各个分区。要将结果集作为一个整体进行排序，请ORDER BY在查询顶层包含 。
frame_clause：框架是当前分区的子集，框架子句指定如何定义子集。框架条款有许多自己的子条款。有关详细信息，请参阅
第 12.21.3 节，“窗口函数框架规范”。
© Mysql 中文网
