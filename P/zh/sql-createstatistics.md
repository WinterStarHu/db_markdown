# CREATE STATISTICS

CREATE STATISTICS
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE STATISTICSCREATE STATISTICS — 定义扩展统计大纲
CREATE STATISTICS [ [ IF NOT EXISTS ] statistics_name ]
ON ( expression )
FROM table_name
CREATE STATISTICS [ [ IF NOT EXISTS ] statistics_name ]
[ ( statistics_kind [, ... ] ) ]
ON { column_name | ( expression ) }, { column_name | ( expression ) } [, ...]
FROM table_name
描述
CREATE STATISTICS将创建一个新的扩展统计对象，
追踪指定表、外部表或物化视图的数据。该统计对象将在当前数据库中创建，
被发出该命令的用户拥有。
CREATE STATISTICS命令有两种基本形式。
第一种形式允许对单个表达式的单变量统计信息进行收集，提供了类似于表达式索引的好处，而不需要索引维护的开销。
这种形式不允许指定统计类型，因为不同的统计类型仅针对多元统计。
此命令的第二种形式允许收集多个列和/或表达式的多元统计信息，并可选地指定需要包括的统计信息类型。
这种形式也会自动使得列表中包含的任何表达式上的单变量统计信息被收集。
如果指定了模式名称（例如，CREATE STATISTICS
myschema.mystat ...），则统计对象将在指定的模式中创建。
否则，它将在当前模式中创建。如果指定了统计对象的名称，
则该名称必须与同一模式中任何其他统计对象的名称不同。
参数IF NOT EXISTS
如果已经存在具有相同名称的统计对象，则不会抛出错误。在这种情况下，会发出通知。
请注意，这里仅考虑统计对象的名称，而不是其定义的详细信息。
当指定IF NOT EXISTS时，统计名称是必需的。
statistics_name
要创建的统计对象的名称（可以选择包含模式限定符）。
如果省略名称，PostgreSQL 会根据父表的名称以及定义的
列名和/或表达式选择一个合适的名称。
statistics_kind
在此统计对象中计算的多变量统计种类。
目前支持的种类是启用n-distinct统计的ndistinct，启用功能依赖性统计的dependencies，以及启用最常见的值列表的mcv。
如果省略该子句，则统计对象中将包含所有支持的统计类型。
如果统计信息定义包含任何复杂表达式而不仅仅是简单的列引用，单变量表达式统计会自动构建。
有关更多信息，请参阅第 14.2.2 节和第 69.2 节。
column_name
被计算的统计信息包含的表列的名称。
这里只在建立多变量统计信息时才被允许。
至少必须指定两个列名或表达式，它们的顺序是不重要的。
expression
由计算统计信息包含的表达式。
这可以用于在单个表达式上构建单变量统计信息，或者作为多个列名和/或表达式的列表的一部分来构建多变量统计信息。
在后一种情况中，将为列表中的每个表达式自动构建单独的单变量统计信息。
table_name
包含要计算统计信息的列的表的名称（可选模式限定符）；请参阅ANALYZE，
了解继承和分区处理的解释。
注意
你必须是表的所有者才能创建读取它的统计对象。不过，一旦创建，
统计对象的所有权与基础表无关。
表达式统计信息是对每个表达式的，就像在表达式上创建索引，只是它们避免了索引维护的开销。
表达式统计信息是为统计对象定义中的每个表达式自动构建的。
扩展统计信息目前不被查询规划器用于对表连接进行的选择性估计。这个限制可能会在未来版本的
PostgreSQL中被移除。
示例
用两个功能相关的列创建表t1，
即第一列中的值的信息足以确定另一列中的值。然后，
在这些列上构建函数依赖关系统计信息：
CREATE TABLE t1 (
a   int,
b   int
);
INSERT INTO t1 SELECT i/100, i/500
FROM generate_series(1,1000000) s(i);
ANALYZE t1;
-- 匹配行的数量将被大大低估：
EXPLAIN ANALYZE SELECT * FROM t1 WHERE (a = 1) AND (b = 0);
CREATE STATISTICS s1 (dependencies) ON a, b FROM t1;
ANALYZE t1;
-- 现在行计数估计会更准确：
EXPLAIN ANALYZE SELECT * FROM t1 WHERE (a = 1) AND (b = 0);
如果没有函数依赖性统计，规划器会认为两个WHERE条件是独立的，
并且会将它们的选择性乘以一起，以致得到太小的行数估计。
通过这样的统计，规划器认识到WHERE条件是多余的，并且不会低估行数。
创建表t2与两个完全相关的列(包含相同的数据)，并且在这些列上创建一个MCV列表:
CREATE TABLE t2 (
a   int,
b   int
);
INSERT INTO t2 SELECT mod(i,100), mod(i,100)
FROM generate_series(1,1000000) s(i);
CREATE STATISTICS s2 (mcv) ON a, b FROM t2;
ANALYZE t2;
-- valid combination (found in MCV)
EXPLAIN ANALYZE SELECT * FROM t2 WHERE (a = 1) AND (b = 1);
-- invalid combination (not found in MCV)
EXPLAIN ANALYZE SELECT * FROM t2 WHERE (a = 1) AND (b = 2);
MCV列表为计划器提供了关于表中普遍出现的特定值的更详细的信息，以及表中未显示的值组合的选择性上限，允许它在这两种情况下产生更好的估计值。
使用单个时间戳列创建表t3，并用该列上的表达式运行查询。
没有扩展的统计信息，计划器无法获知表达式数据分布的相关信息，然后使用默认的估计值。
计划器也没有认识到按月截断日期的值完全取决于按天截断日期的值。
然后表达式和ndistinct统计构建在这两个表达式之上:
CREATE TABLE t3 (
a   timestamp
);
INSERT INTO t3 SELECT i FROM generate_series('2020-01-01'::timestamp,
'2020-12-31'::timestamp,
'1 minute'::interval) s(i);
ANALYZE t3;
-- the number of matching rows will be drastically underestimated:
EXPLAIN ANALYZE SELECT * FROM t3
WHERE date_trunc('month', a) = '2020-01-01'::timestamp;
EXPLAIN ANALYZE SELECT * FROM t3
WHERE date_trunc('day', a) BETWEEN '2020-01-01'::timestamp
AND '2020-06-30'::timestamp;
EXPLAIN ANALYZE SELECT date_trunc('month', a), date_trunc('day', a)
FROM t3 GROUP BY 1, 2;
-- build ndistinct statistics on the pair of expressions (per-expression
-- statistics are built automatically)
CREATE STATISTICS s3 (ndistinct) ON date_trunc('month', a), date_trunc('day', a) FROM t3;
ANALYZE t3;
-- now the row count estimates are more accurate:
EXPLAIN ANALYZE SELECT * FROM t3
WHERE date_trunc('month', a) = '2020-01-01'::timestamp;
EXPLAIN ANALYZE SELECT * FROM t3
WHERE date_trunc('day', a) BETWEEN '2020-01-01'::timestamp
AND '2020-06-30'::timestamp;
EXPLAIN ANALYZE SELECT date_trunc('month', a), date_trunc('day', a)
FROM t3 GROUP BY 1, 2;
没有表达式和ndistinct统计信息，规划器就没有表达式的不同值的数量所相关的信息，并且不得不依赖默认估计值。
相等和范围条件假设有0.5%的选择性，并且表达式中不同值的数量被假设为与列相同(也就是独一无二的)。
这将导致前两个查询中的行数严重低估。
此外，计划器没有关于表达式之间关系的信息，所以它假设两个WHERE和GROUP BY条件是独立的，并将它们的选择相乘，以得到对聚合查询中的组数的严重高估。
由于缺乏表达式准确的统计信息，这种情况进一步加剧了，强迫计划器使用默认的ndistinct估计，对于从列的ndistinct派生的表达式。
有了这些统计信息，规划器就能认识到这些条件是有相互关系的，并得出更准确的估计。
兼容性
SQL标准中没有CREATE STATISTICS命令。
另请参阅ALTER STATISTICS, DROP STATISTICS上一页 上一级 下一页CREATE SERVER 起始页 CREATE SUBSCRIPTION
