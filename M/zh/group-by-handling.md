# 12.20.3 MySQL对GROUP BY的处理_MySQL 8.0 参考手册

12.20.3 MySQL对GROUP BY的处理_MySQL 8.0 参考手册
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
12.20.3 MySQL对GROUP BY的处理
12.20.3 MySQL对GROUP BY的处理
SQL-92 和更早版本不允许选择列表、HAVING条件或ORDER
BY列表引用未在GROUP BY子句中命名的非聚合列的查询。例如，此查询在标准 SQL-92 中是非法的，因为name选择列表中的非聚合列未出现在GROUP BY：
SELECT o.custid, c.name, MAX(o.payment)
FROM orders AS o, customers AS c
WHERE o.custid = c.custid
GROUP BY o.custid;
为了使查询在 SQL-92 中合法，name
必须从选择列表中省略该列或在
GROUP BY子句中命名该列。
SQL:1999 及更高版本允许每个可选功能 T301 这样的非聚合，如果它们在功能上依赖于
列：如果和
GROUP BY之间存在这样的关系，则查询是合法的。例如，主键是.
namecustidcustidcustomers
MySQL 实现了函数依赖检测。如果
ONLY_FULL_GROUP_BY启用 SQL 模式（默认情况下启用），MySQL 将拒绝选择列表、HAVING条件或
ORDER BY列表引用既未在GROUP BY子句中命名也未在功能上依赖于它们的非聚合列的查询。
MySQL 还允许在
启用GROUP BYSQL 模式时未在子句
中命名的非聚合列ONLY_FULL_GROUP_BY，前提是该列仅限于单个值，如以下示例所示：
mysql> CREATE TABLE mytable (
->    id INT UNSIGNED NOT NULL PRIMARY KEY,
->    a VARCHAR(10),
->    b INT
-> );
mysql> INSERT INTO mytable
-> VALUES (1, 'abc', 1000),
->        (2, 'abc', 2000),
->        (3, 'def', 4000);
mysql> SET SESSION sql_mode = sys.list_add(@@session.sql_mode, 'ONLY_FULL_GROUP_BY');
mysql> SELECT a, SUM(b) FROM mytable WHERE a = 'abc';
+------+--------+
| a    | SUM(b) |
+------+--------+
| abc  |   3000 |
+------+--------+SELECT使用 时，列表
中也可能有多个非聚合列ONLY_FULL_GROUP_BY。在这种情况下，每个这样的列都必须限制为
WHERE子句中的单个值，并且所有这些限制条件都必须由 logical 连接AND，如下所示：
mysql> DROP TABLE IF EXISTS mytable;
mysql> CREATE TABLE mytable (
->    id INT UNSIGNED NOT NULL PRIMARY KEY,
->    a VARCHAR(10),
->    b VARCHAR(10),
->    c INT
-> );
mysql> INSERT INTO mytable
-> VALUES (1, 'abc', 'qrs', 1000),
->        (2, 'abc', 'tuv', 2000),
->        (3, 'def', 'qrs', 4000),
->        (4, 'def', 'tuv', 8000),
->        (5, 'abc', 'qrs', 16000),
->        (6, 'def', 'tuv', 32000);
mysql> SELECT @@session.sql_mode;
+---------------------------------------------------------------+
| @@session.sql_mode                                            |
+---------------------------------------------------------------+
| ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION |
+---------------------------------------------------------------+
mysql> SELECT a, b, SUM(c) FROM mytable
->     WHERE a = 'abc' AND b = 'qrs';
+------+------+--------+
| a    | b    | SUM(c) |
+------+------+--------+
| abc  | qrs  |  17000 |
+------+------+--------+
如果ONLY_FULL_GROUP_BY禁用，MySQL 对标准 SQL 使用的扩展
GROUP BY允许选择列表、
HAVING条件或ORDER
BY列表引用非聚合列，即使这些列在功能上不依赖于GROUP
BY列。这会导致 MySQL 接受前面的查询。在这种情况下，服务器可以自由地从每个组中选择任何值，因此除非它们相同，否则所选的值是不确定的，这可能不是您想要的。此外，从每个组中选择值不会受到添加ORDER BY子句的影响。结果集排序发生在选择值之后，并且
ORDER BY不影响服务器选择每个组中的哪个值。ONLY_FULL_GROUP_BY当您知道由于数据的某些属性，每个组中未命名的每个非聚合列中的所有值
GROUP BY对于每个组都相同时，
禁用
主要有用。ONLY_FULL_GROUP_BY您可以通过使用
ANY_VALUE()引用非聚合列
来实现相同的效果而无需禁用
。
下面的讨论演示了函数依赖，当函数依赖不存在时 MySQL 产生的错误消息，以及在没有函数依赖的情况下使 MySQL 接受查询的方法。
ONLY_FULL_GROUP_BY此查询在启用
时可能无效，
因为address选择列表中的非聚合列未在GROUP BY
子句中命名：
SELECT name, address, MAX(age) FROM t GROUP BY name;
如果name是主键t或者是唯一NOT
NULL列，则查询有效。在这种情况下，MySQL 认识到所选列在功能上依赖于分组列。例如，如果name是一个主键，它的值决定了的值，address因为每组只有一个主键值，因此只有一行。因此，
address组内值的选择没有随机性，不需要拒绝查询。
如果name不是主键t或唯一NOT
NULL列，则查询无效。在这种情况下，无法推断出函数依赖性并发生错误：
mysql> SELECT name, address, MAX(age) FROM t GROUP BY name;
ERROR 1055 (42000): Expression #2 of SELECT list is not in GROUP
BY clause and contains nonaggregated column 'mydb.t.address' which
is not functionally dependent on columns in GROUP BY clause; this
is incompatible with sql_mode=only_full_group_by
如果您知道，对于给定的数据集，
每个name值实际上唯一地确定address值，address
在功能上有效地依赖于
name。要告诉 MySQL 接受查询，可以使用ANY_VALUE()函数：
SELECT name, ANY_VALUE(address), MAX(age) FROM t GROUP BY name;
或者，禁用
ONLY_FULL_GROUP_BY.
然而，前面的示例非常简单。特别是，您不太可能对单个主键列进行分组，因为每个组只包含一行。有关在更复杂的查询中演示函数依赖的其他示例，请参阅第 12.20.4 节，“函数依赖的检测”。
如果查询具有聚合函数但没有子句，则它在选择列表、条件或
启用
的列表
GROUP
BY中不能有非聚合列：HAVINGORDER BYONLY_FULL_GROUP_BYmysql> SELECT name, MAX(age) FROM t;
ERROR 1140 (42000): In aggregated query without GROUP BY, expression
#1 of SELECT list contains nonaggregated column 'mydb.t.name'; this
is incompatible with sql_mode=only_full_group_by
如果没有GROUP BY，则只有一个组，并且不确定name为该组选择哪个值。ANY_VALUE()如果nameMySQL 选择哪个值
并不重要，这里也
可以使用：SELECT ANY_VALUE(name), MAX(age) FROM t;
ONLY_FULL_GROUP_BY还会影响对使用DISTINCTand的查询的处理ORDER
BY。考虑t
具有三列c1,c2并且c3包含以下行的表的情况：
c1 c2 c3
1  2  A
3  4  B
1  2  C
假设我们执行以下查询，期望结果按以下顺序排序c3：
SELECT DISTINCT c1, c2 FROM t ORDER BY c3;
要对结果进行排序，必须先消除重复项。但是这样做，我们应该保留第一行还是第三行？这种任意选择会影响 的保留值c3，进而影响排序并使其具有任意性。为防止出现此问题，
如果任何
表达式不满足以下至少一个条件
，则查询已被视为无效DISTINCT而被拒绝：ORDER BYORDER BY
表达式等于选择列表中的一个
表达式引用并属于查询的选定表的所有列都是选择列表的元素
标准 SQL 的另一个 MySQL 扩展允许在HAVING子句中引用选择列表中的别名表达式。例如，以下查询返回
name在表中只出现一次的值
orders：
SELECT name, COUNT(name) FROM orders
GROUP BY name
HAVING COUNT(name) = 1;
MySQL 扩展允许在
HAVING聚合列的子句中使用别名：
SELECT name, COUNT(name) AS c FROM orders
GROUP BY name
HAVING c = 1;
标准 SQL 只允许在GROUP
BY子句中使用列表达式，因此像这样的语句是无效的，因为FLOOR(value/100)它是一个非列表达式：
SELECT id, FLOOR(value/100)
FROM tbl_name
GROUP BY id, FLOOR(value/100);
MySQL 扩展标准 SQL 以允许
GROUP BY子句中的非列表达式，并认为前面的语句有效。
标准 SQL 也不允许在GROUP
BY子句中使用别名。MySQL 扩展了标准 SQL 以允许使用别名，因此另一种编写查询的方法如下：
SELECT id, FLOOR(value/100) AS val
FROM tbl_name
GROUP BY id, val;
别名被视为子句
val中的列表达式。GROUP BY
如果子句中存在非列表达式GROUP
BY，MySQL 会识别该表达式与选择列表中的表达式之间的相等性。这意味着在ONLY_FULL_GROUP_BY启用 SQL 模式的情况下，包含的查询GROUP BY id,
FLOOR(value/100)是有效的，因为相同
FLOOR()的表达式出现在选择列表中。但是，MySQL 不会尝试识别对GROUP BY非列表达式的函数依赖，因此以下查询在
ONLY_FULL_GROUP_BY启用时无效，即使第三个选择的表达式是id列的简单公式和
子句
FLOOR()中的表达式
：GROUP BYSELECT id, FLOOR(value/100), id+FLOOR(value/100)
FROM tbl_name
GROUP BY id, FLOOR(value/100);
解决方法是使用派生表：
SELECT id, F, id+F
FROM
(SELECT id, FLOOR(value/100) AS F
FROM tbl_name
GROUP BY id, FLOOR(value/100)) AS dt;
© Mysql 中文网
