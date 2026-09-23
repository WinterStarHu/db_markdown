# F.18. intagg — 整数聚合器和枚举器

F.18. intagg — 整数聚合器和枚举器
版本：
纠错本页面
搜索
目录导航
❮
❯
F.18. intagg — 整数聚合器和枚举器 #F.18.1. 函数F.18.2. 示例用法
intagg模块提供了一个整数聚合器以及一个枚举器。intagg现在已被弃用，因为有内建的函数能提供其功能的超集。不过，该模块仍然作为内建函数的一个兼容性包装器被提供。
F.18.1. 函数 #
聚合器是一个聚合函数int_array_aggregate(integer)，它产生一个完全包含输入整数的整数数组。这是一个array_agg的包装器，它对任何数组类型做同样的事情。
枚举器是一个函数int_array_enum(integer[])，它返回setof integer。它本质上是聚合器的一个逆操作：给定一个整数数组，将它展开成行的集合。这是unnest的一个包装器，它对任何数组类型做相同的事情。
F.18.2. 示例用法 #
许多数据库系统都有多对多表的概念。这样的表通常位于两个有索引的表之间，
例如：
CREATE TABLE left_table  (id INT PRIMARY KEY, ...);
CREATE TABLE right_table (id INT PRIMARY KEY, ...);
CREATE TABLE many_to_many(id_left  INT REFERENCES left_table,
id_right INT REFERENCES right_table);
它通常这样使用：
SELECT right_table.*
FROM right_table JOIN many_to_many ON (right_table.id = many_to_many.id_right)
WHERE many_to_many.id_left = item;
这将返回左表中某条记录对应右表中的所有条目。这是SQL中非常常见的结构。
现在，当many_to_many表中条目非常多时，这种方法可能会很繁琐。
通常，这样的连接会导致对表中每个右侧条目进行索引扫描和获取，针对特定的左侧条目。
如果你的系统非常动态，几乎无能为力。然而，如果你有一些相对静态的数据，
你可以使用聚合器创建一个汇总表。
CREATE TABLE summary AS
SELECT id_left, int_array_aggregate(id_right) AS rights
FROM many_to_many
GROUP BY id_left;
这将创建一个每个左侧项目一行的表，以及一个右侧项目的数组。现在如果没有
使用数组的方法，这个表几乎没用；这就是为什么有数组枚举器。你可以执行
SELECT id_left, int_array_enum(rights) FROM summary WHERE id_left = item;
上述使用int_array_enum的查询产生的结果与
SELECT id_left, id_right FROM many_to_many WHERE id_left = item;
的结果相同。区别在于，对汇总表的查询只需从表中获取一行，而直接查询
many_to_many则必须对每个条目进行索引扫描和获取。
在某个系统中，EXPLAIN显示一个代价为8488的查询被降至329。
原始查询是一个涉及many_to_many表的连接，现被替换为：
SELECT id_right, count(id_right) FROM
( SELECT id_left, int_array_enum(rights) AS id_right
FROM summary
JOIN (SELECT id FROM left_table
WHERE id = item) AS lefts
ON (summary.id_left = lefts.id)
) AS list
GROUP BY id_right
ORDER BY count DESC;
上一页 上一级 下一页F.17. hstore — hstore 键/值数据类型 起始页 F.19. intarray — 操作整数数组
