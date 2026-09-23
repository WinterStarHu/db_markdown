# 8.9.6 优化器统计_MySQL 8.0 参考手册

8.9.6 优化器统计_MySQL 8.0 参考手册
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
8.1 优化概述
8.2 优化SQL语句
8.3 优化和索引
8.4 优化数据库结构
8.5 优化 InnoDB 表
8.6 优化 MyISAM 表
8.7 优化 MEMORY 表
8.8 了解查询执行计划
8.9 控制查询优化器
8.9.1 控制查询计划评估1
8.9.2 可切换优化1
8.9.3 优化器提示1
8.9.4 索引提示1
8.9.5 优化器成本模型1
8.9.6 优化器统计1
8.10 缓冲和缓存
8.11 优化锁定操作
8.12 优化MySQL服务器
8.13 测量性能（基准测试）
8.14 查看服务器线程（进程）信息
第9章语言结构
第 10 章字符集、排序规则、Unicode
第 11 章数据类型
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
MySQL 8.0 参考手册  / 第8章优化  / 8.9 控制查询优化器  /
8.9.6 优化器统计
8.9.6 优化器统计
数据字典表存储有关列值的column_statistics直方图统计信息，供优化器在构建查询执行计划时使用。要执行直方图管理，请使用该ANALYZE
TABLE语句。
该column_statistics表具有以下特征：
该表包含所有数据类型的列的统计信息，除了几何类型（空间数据）和
JSON.
该表是持久的，因此不需要在每次服务器启动时都创建列统计信息。
服务器对表进行更新；用户没有。
用户不能直接访问该column_statistics表，因为它是数据字典的一部分。直方图信息可使用
INFORMATION_SCHEMA.COLUMN_STATISTICS实现，它作为数据字典表上的视图实现。
COLUMN_STATISTICS有这些列：
SCHEMA_NAME,
TABLE_NAME,
COLUMN_NAME：应用统计信息的架构、表和列的名称。
HISTOGRAM：
JSON描述列统计信息的值，存储为直方图。
列直方图包含存储在列中的部分值范围的桶。直方图是
JSON允许灵活表示列统计信息的对象。这是一个示例直方图对象：
{
"buckets": [
[
1,
0.3333333333333333
],
[
2,
0.6666666666666666
],
[
3,
1
]
],
"null-values": 0,
"last-updated": "2017-03-24 13:32:40.000000",
"sampling-rate": 1,
"histogram-type": "singleton",
"number-of-buckets-specified": 128,
"data-type": "int",
"collation-id": 8
}
直方图对象具有以下键：
buckets: 直方图桶。桶结构取决于直方图类型。
对于singleton直方图，桶包含两个值：
值 1：桶的值。类型取决于列数据类型。
值 2：表示值的累积频率的双精度值。例如，.25 和 .75 表示列中 25% 和 75% 的值小于或等于桶值。
对于equi-height直方图，桶包含四个值：
值 1、2：桶的下限值和上限值。类型取决于列数据类型。
值 3：表示值的累积频率的双精度值。例如，.25 和 .75 表示列中 25% 和 75% 的值小于或等于桶上限值。
Value 4：从bucket lower value到它的upper value范围内的distinct values的个数。
null-values：一个介于 0.0 和 1.0 之间的数字，表示列值中 SQL
NULL值的比例。如果为 0，则该列不包含任何
NULL值。
last-updatedYYYY-MM-DD
hh:mm:ss.uuuuuu：生成直方图时，格式
为 UTC 值。
sampling-rate：一个介于 0.0 和 1.0 之间的数字，表示为创建直方图而采样的数据分数。值 1 表示已读取所有数据（无采样）。
histogram-type：直方图类型：
singleton：一个桶代表列中的一个值。当列中不同值的数量小于或等于ANALYZE TABLE
生成直方图的语句中指定的桶数时，将创建此直方图类型。
equi-height：一个桶代表一系列值。当列中不同值的数量大于
ANALYZE TABLE生成直方图的语句中指定的桶数时，将创建此直方图类型。
number-of-buckets-specifiedANALYZE
TABLE：在生成直方图
的语句中指定的桶数。
data-type：此直方图包含的数据类型。当从持久存储读取直方图并将其解析到内存中时，需要这样做。该值是int, uint
（无符号整数）、double、
decimal、datetime或
string（包括字符和二进制字符串）之一。
collation-id：直方图数据的排序规则 ID。data-type值为
时最有意义
string。值对应
ID于表中的列值
INFORMATION_SCHEMA.COLLATIONS
。
要从直方图对象中提取特定值，您可以使用JSON操作。例如：
mysql> SELECT
TABLE_NAME, COLUMN_NAME,
HISTOGRAM->>'$."data-type"' AS 'data-type',
JSON_LENGTH(HISTOGRAM->>'$."buckets"') AS 'bucket-count'
FROM INFORMATION_SCHEMA.COLUMN_STATISTICS;
+-----------------+-------------+-----------+--------------+
| TABLE_NAME      | COLUMN_NAME | data-type | bucket-count |
+-----------------+-------------+-----------+--------------+
| country         | Population  | int       |          226 |
| city            | Population  | int       |         1024 |
| countrylanguage | Language    | string    |          457 |
+-----------------+-------------+-----------+--------------+
如果适用，优化器将直方图统计信息用于为其收集统计信息的任何数据类型的列。优化器应用直方图统计来根据列值与常量值比较的选择性（过滤效果）来确定行估计。这些形式的谓词有资格使用直方图：
col_name = constant
col_name <> constant
col_name != constant
col_name > constant
col_name < constant
col_name >= constant
col_name <= constant
col_name IS NULL
col_name IS NOT NULL
col_name BETWEEN constant AND constant
col_name NOT BETWEEN constant AND constant
col_name IN (constant[, constant] ...)
col_name NOT IN (constant[, constant] ...)
例如，这些语句包含符合直方图使用条件的谓词：
SELECT * FROM orders WHERE amount BETWEEN 100.0 AND 300.0;
SELECT * FROM tbl WHERE col1 = 15 AND col2 > 100;
与常量值进行比较的要求包括常量函数，例如
ABS()和
FLOOR()：
SELECT * FROM tbl WHERE col1 < ABS(-34);
直方图统计信息主要用于非索引列。向直方图统计信息适用的列添加索引也可能有助于优化器进行行估计。权衡是：
修改表数据时必须更新索引。
直方图仅按需创建或更新，因此在修改表数据时不会增加开销。另一方面，当表发生修改时，统计信息会逐渐过时，直到下一次更新它们为止。
优化器更喜欢范围优化器行估计而不是从直方图统计中获得的行估计。如果优化器确定范围优化器适用，则它不使用直方图统计信息。
对于索引的列，可以使用索引潜水获得行估计以进行相等比较（请参阅
第 8.2.1.2 节，“范围优化”）。在这种情况下，直方图统计不一定有用，因为指数跳水可以产生更好的估计。
在某些情况下，使用直方图统计信息可能不会改进查询执行（例如，如果统计信息已过时）。要检查是否是这种情况，请使用ANALYZE
TABLE重新生成直方图统计信息，然后再次运行查询。
或者，要禁用直方图统计信息，请使用
ANALYZE TABLE删除它们。禁用直方图统计的另一种方法是关闭系统变量的
condition_fanout_filter标志optimizer_switch（尽管这也可能禁用其他优化）：
SET optimizer_switch='condition_fanout_filter=off';
如果使用直方图统计，则使用 可以看到结果效果EXPLAIN。考虑以下查询，其中没有可用于列的索引
col1：
SELECT * FROM t1 WHERE col1 < 24;
如果直方图统计表明 57% 的行
t1满足col1 <
24谓词，即使没有索引也可以进行过滤，并在列
EXPLAIN中显示 57.00 。filtered
© Mysql 中文网
