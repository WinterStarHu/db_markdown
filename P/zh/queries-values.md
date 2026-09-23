# 7.7. VALUES 列表

7.7. VALUES 列表
版本：
纠错本页面
搜索
目录导航
❮
❯
7.7. VALUES 列表 #
VALUES提供了一种生成“常量表”的方法，它可以被用于查询中而不需要实际在磁盘上创建一个表。语法是：
VALUES ( expression [, ...] ) [, ...]
每一个被圆括号包围的表达式列表生成表中的一行。列表都必须具有相同数量的元素（即表中列的数目），并且在每个列表中对应的项必须具有兼容的数据类型。分配给结果的每一列的实际数据类型使用和UNION相同的规则确定（参见第 10.5 节）。
一个例子：
VALUES (1, 'one'), (2, 'two'), (3, 'three');
将会返回一个有两列三行的表。它实际上等效于：
SELECT 1 AS column1, 'one' AS column2
UNION ALL
SELECT 2, 'two'
UNION ALL
SELECT 3, 'three';
在默认情况下，PostgreSQL将column1、column2等名字分配给一个VALUES表的列。这些列名不是由SQL标准指定的，并且不同的数据库系统的做法也不同，因此通常最好使用表别名列表来重写这些默认的名字，像这样：
=> SELECT * FROM (VALUES (1, 'one'), (2, 'two'), (3, 'three')) AS t (num,letter);
num | letter
-----+--------
1 | one
2 | two
3 | three
(3 rows)
在句法上，后面跟随表达式列表的VALUES被视为和
SELECT select_list FROM table_expression
一样，并且可以出现在SELECT能出现的任何地方。例如，你可以把它用作UNION的一部分，或者附加一个sort_specification（ORDER BY、LIMIT和/或OFFSET）给它。VALUES最常见的用途是作为一个INSERT命令的数据源，以及作为一个子查询。
更多信息请见VALUES。
上一页 上一级 下一页7.6. LIMIT和OFFSET 起始页 7.8. WITH 查询（公共表表达式）
