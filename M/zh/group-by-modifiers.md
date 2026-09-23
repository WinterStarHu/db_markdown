# 12.20.2 GROUP BY 修饰符_MySQL 8.0 参考手册

12.20.2 GROUP BY 修饰符_MySQL 8.0 参考手册
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
12.20.1 聚合函数说明1
12.20.2 GROUP BY 修饰符1
12.20.3 MySQL对GROUP BY的处理1
12.20.4 函数依赖检测1
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
MySQL 8.0 参考手册  / 第 12 章函数和运算符  / 12.20聚合函数  /
12.20.2 GROUP BY 修饰符
12.20.2 GROUP BY 修饰符
该GROUP BY子句允许一个WITH
ROLLUP修饰符，该修饰符会导致摘要输出包含表示更高级别（即超级聚合）摘要操作的额外行。ROLLUP
因此，您可以使用单个查询在多个分析级别回答问题。例如，
ROLLUP可用于为 OLAP（联机分析处理）操作提供支持。
假设一个sales表有
year、country、
product和profit
列用于记录销售利润率：
CREATE TABLE sales
(
year    INT,
country VARCHAR(20),
product VARCHAR(32),
profit  INT
);
要总结每年的表格内容，请使用如下简单的方法
GROUP BY：
mysql> SELECT year, SUM(profit) AS profit
FROM sales
GROUP BY year;
+------+--------+
| year | profit |
+------+--------+
| 2000 |   4525 |
| 2001 |   3010 |
+------+--------+
输出显示每年的总（合计）利润。要同时确定所有年份的总利润总和，您必须自己将各个值相加或运行额外的查询。或者您可以使用ROLLUP，它通过单个查询提供两个级别的分析。向子句添加
WITH ROLLUP修饰符GROUP
BY会导致查询生成另一个（超级聚合）行，显示所有年份值的总计：
mysql> SELECT year, SUM(profit) AS profit
FROM sales
GROUP BY year WITH ROLLUP;
+------+--------+
| year | profit |
+------+--------+
| 2000 |   4525 |
| 2001 |   3010 |
| NULL |   7535 |
+------+--------+
列中的NULL值year
标识总计超级聚合行。
ROLLUP当有多个GROUP BY列时，效果会更复杂。在这种情况下，每次除了最后一个分组列中的值发生变化时，查询都会生成一个额外的超级聚合摘要行。
例如，在没有的情况下，基于 、 和 的表的
摘要ROLLUP可能
如下所示，其中输出仅指示年/国家/产品分析级别的摘要值：
salesyearcountryproductmysql> SELECT year, country, product, SUM(profit) AS profit
FROM sales
GROUP BY year, country, product;
+------+---------+------------+--------+
| year | country | product    | profit |
+------+---------+------------+--------+
| 2000 | Finland | Computer   |   1500 |
| 2000 | Finland | Phone      |    100 |
| 2000 | India   | Calculator |    150 |
| 2000 | India   | Computer   |   1200 |
| 2000 | USA     | Calculator |     75 |
| 2000 | USA     | Computer   |   1500 |
| 2001 | Finland | Phone      |     10 |
| 2001 | USA     | Calculator |     50 |
| 2001 | USA     | Computer   |   2700 |
| 2001 | USA     | TV         |    250 |
+------+---------+------------+--------+
添加后，ROLLUP查询会产生几个额外的行：
mysql> SELECT year, country, product, SUM(profit) AS profit
FROM sales
GROUP BY year, country, product WITH ROLLUP;
+------+---------+------------+--------+
| year | country | product    | profit |
+------+---------+------------+--------+
| 2000 | Finland | Computer   |   1500 |
| 2000 | Finland | Phone      |    100 |
| 2000 | Finland | NULL       |   1600 |
| 2000 | India   | Calculator |    150 |
| 2000 | India   | Computer   |   1200 |
| 2000 | India   | NULL       |   1350 |
| 2000 | USA     | Calculator |     75 |
| 2000 | USA     | Computer   |   1500 |
| 2000 | USA     | NULL       |   1575 |
| 2000 | NULL    | NULL       |   4525 |
| 2001 | Finland | Phone      |     10 |
| 2001 | Finland | NULL       |     10 |
| 2001 | USA     | Calculator |     50 |
| 2001 | USA     | Computer   |   2700 |
| 2001 | USA     | TV         |    250 |
| 2001 | USA     | NULL       |   3000 |
| 2001 | NULL    | NULL       |   3010 |
| NULL | NULL    | NULL       |   7535 |
+------+---------+------------+--------+
现在输出包括四个分析级别的摘要信息，而不仅仅是一个：
在给定年份和国家/地区的每组产品行之后，会出现一个额外的超级聚合摘要行，显示所有产品的总数。这些行的
product列设置为
NULL。
在给定年份的每组行之后，会出现一个额外的超级聚合摘要行，显示所有国家和产品的总数。这些行的
country和products
列设置为NULL。
最后，在所有其他行之后，会出现一个额外的超级聚合摘要行，显示所有年份、国家和产品的总计。此行的
year、country和
products列设置为
NULL。
每个超级聚合行中的NULL指标是在将行发送到客户端时生成的。服务器查看GROUP BY
最​​左边已更改值的子句中命名的列。对于名称与这些名称中的任何一个匹配的结果集中的任何列，其值都设置为NULL。（如果您指定按列位置对列进行分组，服务器会识别要按NULL位置设置的列。）
因为NULL超级聚合行中的值是在查询处理的后期放入结果集中的，所以您
NULL只能在选择列表或
HAVING子句中将它们作为值进行测试。您不能将它们作为
NULL连接条件或
WHERE子句中的值进行测试以确定要选择哪些行。例如，您不能添加WHERE product IS
NULL到查询以从输出中消除除超级聚合行之外的所有行。
这些NULL值确实出现
NULL在客户端，并且可以使用任何 MySQL 客户端编程接口进行测试。但是此时，你无法区分a
NULL代表的是常规分组值还是超聚合值。要测试区别，请使用
GROUPING()稍后描述的函数。
以前，MySQL 不允许在
具有选项的查询中使用DISTINCT或。此限制在 MySQL 8.0.12 及更高版本中取消。（错误#87450、错误#86311、错误#26640100、错误#26073513）
ORDER BYWITH ROLLUP
对于GROUP BY ... WITH ROLLUP查询，要测试NULL结果中的值是否表示超级聚合值，该
GROUPING()函数可用于选择列表、HAVING子句和（从 MySQL 8.0.12 开始）ORDER BY子句。例如，当
列出现在超级聚合行中时返回 1，否则返回GROUPING(year)0 。类似地，分别为 和列
中
的超级聚合值
返回 1：NULLyearGROUPING(country)GROUPING(product)NULLcountryproductmysql> SELECT
year, country, product, SUM(profit) AS profit,
GROUPING(year) AS grp_year,
GROUPING(country) AS grp_country,
GROUPING(product) AS grp_product
FROM sales
GROUP BY year, country, product WITH ROLLUP;
+------+---------+------------+--------+----------+-------------+-------------+
| year | country | product    | profit | grp_year | grp_country | grp_product |
+------+---------+------------+--------+----------+-------------+-------------+
| 2000 | Finland | Computer   |   1500 |        0 |           0 |           0 |
| 2000 | Finland | Phone      |    100 |        0 |           0 |           0 |
| 2000 | Finland | NULL       |   1600 |        0 |           0 |           1 |
| 2000 | India   | Calculator |    150 |        0 |           0 |           0 |
| 2000 | India   | Computer   |   1200 |        0 |           0 |           0 |
| 2000 | India   | NULL       |   1350 |        0 |           0 |           1 |
| 2000 | USA     | Calculator |     75 |        0 |           0 |           0 |
| 2000 | USA     | Computer   |   1500 |        0 |           0 |           0 |
| 2000 | USA     | NULL       |   1575 |        0 |           0 |           1 |
| 2000 | NULL    | NULL       |   4525 |        0 |           1 |           1 |
| 2001 | Finland | Phone      |     10 |        0 |           0 |           0 |
| 2001 | Finland | NULL       |     10 |        0 |           0 |           1 |
| 2001 | USA     | Calculator |     50 |        0 |           0 |           0 |
| 2001 | USA     | Computer   |   2700 |        0 |           0 |           0 |
| 2001 | USA     | TV         |    250 |        0 |           0 |           0 |
| 2001 | USA     | NULL       |   3000 |        0 |           0 |           1 |
| 2001 | NULL    | NULL       |   3010 |        0 |           1 |           1 |
| NULL | NULL    | NULL       |   7535 |        1 |           1 |           1 |
+------+---------+------------+--------+----------+-------------+-------------+GROUPING()您可以使用GROUPING()标签代替超级聚合NULL值
，而不是直接
显示
结果：mysql> SELECT
IF(GROUPING(year), 'All years', year) AS year,
IF(GROUPING(country), 'All countries', country) AS country,
IF(GROUPING(product), 'All products', product) AS product,
SUM(profit) AS profit
FROM sales
GROUP BY year, country, product WITH ROLLUP;
+-----------+---------------+--------------+--------+
| year      | country       | product      | profit |
+-----------+---------------+--------------+--------+
| 2000      | Finland       | Computer     |   1500 |
| 2000      | Finland       | Phone        |    100 |
| 2000      | Finland       | All products |   1600 |
| 2000      | India         | Calculator   |    150 |
| 2000      | India         | Computer     |   1200 |
| 2000      | India         | All products |   1350 |
| 2000      | USA           | Calculator   |     75 |
| 2000      | USA           | Computer     |   1500 |
| 2000      | USA           | All products |   1575 |
| 2000      | All countries | All products |   4525 |
| 2001      | Finland       | Phone        |     10 |
| 2001      | Finland       | All products |     10 |
| 2001      | USA           | Calculator   |     50 |
| 2001      | USA           | Computer     |   2700 |
| 2001      | USA           | TV           |    250 |
| 2001      | USA           | All products |   3000 |
| 2001      | All countries | All products |   3010 |
| All years | All countries | All products |   7535 |
+-----------+---------------+--------------+--------+
对于多个表达式参数，
GROUPING()返回一个表示位掩码的结果，该位掩码组合了每个表达式的结果，最低位对应于最右边表达式的结果。例如，
GROUPING(year, country, product)
评估如下：
result for GROUPING(product)
+ result for GROUPING(country) << 1
+ result for GROUPING(year) << 2GROUPING()
如果任何表达式表示超级聚合，则
这样的结果为非零NULL，因此您可以仅返回超级聚合行并像这样过滤掉常规分组行：
mysql> SELECT year, country, product, SUM(profit) AS profit
FROM sales
GROUP BY year, country, product WITH ROLLUP
HAVING GROUPING(year, country, product) <> 0;
+------+---------+---------+--------+
| year | country | product | profit |
+------+---------+---------+--------+
| 2000 | Finland | NULL    |   1600 |
| 2000 | India   | NULL    |   1350 |
| 2000 | USA     | NULL    |   1575 |
| 2000 | NULL    | NULL    |   4525 |
| 2001 | Finland | NULL    |     10 |
| 2001 | USA     | NULL    |   3000 |
| 2001 | NULL    | NULL    |   3010 |
| NULL | NULL    | NULL    |   7535 |
+------+---------+---------+--------+
该sales表不包含任何
NULL值，因此结果中的所有NULL
值都ROLLUP表示超级聚合值。当数据集包含
NULL值时，ROLLUP
摘要NULL不仅可以在超级聚合行中包含值，还可以在常规分组行中包含值。
GROUPING()使这些能够被区分。假设该表t1包含一个简单的数据集，其中包含一组数量值的两个分组因子，其中NULL表示类似“其他”或“未知”的内容：
mysql> SELECT * FROM t1;
+------+-------+----------+
| name | size  | quantity |
+------+-------+----------+
| ball | small |       10 |
| ball | large |       20 |
| ball | NULL  |        5 |
| hoop | small |       15 |
| hoop | large |        5 |
| hoop | NULL  |        3 |
+------+-------+----------+
一个简单的操作就产生了这些结果，在这些结果中，将超级聚合行中的
值与常规分组行中
的值ROLLUP区分开来并不容易
：NULLNULLmysql> SELECT name, size, SUM(quantity) AS quantity
FROM t1
GROUP BY name, size WITH ROLLUP;
+------+-------+----------+
| name | size  | quantity |
+------+-------+----------+
| ball | NULL  |        5 |
| ball | large |       20 |
| ball | small |       10 |
| ball | NULL  |       35 |
| hoop | NULL  |        3 |
| hoop | large |        5 |
| hoop | small |       15 |
| hoop | NULL  |       23 |
| NULL | NULL  |       58 |
+------+-------+----------+
使用GROUPING()将标签替换为超级聚合NULL值使结果更易于解释：
mysql> SELECT
IF(GROUPING(name) = 1, 'All items', name) AS name,
IF(GROUPING(size) = 1, 'All sizes', size) AS size,
SUM(quantity) AS quantity
FROM t1
GROUP BY name, size WITH ROLLUP;
+-----------+-----------+----------+
| name      | size      | quantity |
+-----------+-----------+----------+
| ball      | NULL      |        5 |
| ball      | large     |       20 |
| ball      | small     |       10 |
| ball      | All sizes |       35 |
| hoop      | NULL      |        3 |
| hoop      | large     |        5 |
| hoop      | small     |       15 |
| hoop      | All sizes |       23 |
| All items | All sizes |       58 |
+-----------+-----------+----------+
使用 ROLLUP 时的其他注意事项
下面的讨论列出了一些特定于 MySQL 实现的行为ROLLUP。
在 MySQL 8.0.12 之前，当您使用 时ROLLUP，您不能同时使用ORDER BY子句对结果进行排序。换句话说，ROLLUP
和ORDER BY在 MySQL 中是互斥的。但是，您仍然可以控制排序顺序。要解决阻止使用
ROLLUPwith的限制ORDER BY并实现分组结果的特定排序顺序，请将分组结果集生成为派生表并应用于ORDER
BY它。例如：
mysql> SELECT * FROM
(SELECT year, SUM(profit) AS profit
FROM sales GROUP BY year WITH ROLLUP) AS dt
ORDER BY year DESC;
+------+--------+
| year | profit |
+------+--------+
| 2001 |   3010 |
| 2000 |   4525 |
| NULL |   7535 |
+------+--------+
从 MySQL 8.0.12 开始，ORDER BY和
ROLLUP可以一起使用，这使得可以使用ORDER BY和
GROUPING()来实现分组结果的特定排序顺序。例如：
mysql> SELECT year, SUM(profit) AS profit
FROM sales
GROUP BY year WITH ROLLUP
ORDER BY GROUPING(year) DESC;
+------+--------+
| year | profit |
+------+--------+
| NULL |   7535 |
| 2000 |   4525 |
| 2001 |   3010 |
+------+--------+
在这两种情况下，超级聚合摘要行都按照计算它们的行进行排序，它们的位置取决于排序顺序（升序排序在末尾，降序排序在开头）。
LIMIT可用于限制返回给客户端的行数。LIMIT在之后应用ROLLUP，因此该限制适用于由添加的额外行ROLLUP。例如：
mysql> SELECT year, country, product, SUM(profit) AS profit
FROM sales
GROUP BY year, country, product WITH ROLLUP
LIMIT 5;
+------+---------+------------+--------+
| year | country | product    | profit |
+------+---------+------------+--------+
| 2000 | Finland | Computer   |   1500 |
| 2000 | Finland | Phone      |    100 |
| 2000 | Finland | NULL       |   1600 |
| 2000 | India   | Calculator |    150 |
| 2000 | India   | Computer   |   1200 |
+------+---------+------------+--------+
使用LIMITwithROLLUP
可能会产生更难以解释的结果，因为用于理解超级聚合行的上下文较少。
MySQL 扩展允许未出现在
GROUP BY列表中的列在选择列表中被命名。（有关非聚合列和 的信息
GROUP BY，请参阅
第 12.20.3 节，“MySQL 对 GROUP BY 的处理”。）在这种情况下，服务器可以自由地从摘要行中的这个非聚合列中选择任何值，这包括添加的额外行通过
WITH ROLLUP。例如，在以下查询中，country是一个未出现在GROUP BY列表中的非聚合列，并且为此列选择的值是不确定的：
mysql> SELECT year, country, SUM(profit) AS profit
FROM sales
GROUP BY year WITH ROLLUP;
+------+---------+--------+
| year | country | profit |
+------+---------+--------+
| 2000 | India   |   4525 |
| 2001 | USA     |   3010 |
| NULL | USA     |   7535 |
+------+---------+--------+ONLY_FULL_GROUP_BY当未启用 SQL 模式
时，此行为是允许的
。如果启用该模式，服务器将拒绝查询为非法，因为country未在GROUP BY子句中列出。ONLY_FULL_GROUP_BY启用后，您仍然可以使用非确定性值列的函数来执行
查询
ANY_VALUE()：
mysql> SELECT year, ANY_VALUE(country) AS country, SUM(profit) AS profit
FROM sales
GROUP BY year WITH ROLLUP;
+------+---------+--------+
| year | country | profit |
+------+---------+--------+
| 2000 | India   |   4525 |
| 2001 | USA     |   3010 |
| NULL | USA     |   7535 |
+------+---------+--------+MATCH()在 MySQL 8.0.28 及更高版本中，除非在
WHERE子句中调用，否则
汇总列不能用作（并因错误而被拒绝）的参数。有关更多信息，请参阅
第 12.10 节，“全文搜索功能”。
© Mysql 中文网
