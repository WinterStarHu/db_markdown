# 2.6. 表之间的连接

2.6. 表之间的连接
版本：
纠错本页面
搜索
目录导航
❮
❯
2.6. 表之间的连接 #
到目前为止，我们的查询一次只访问一个表。查询可以一次访问多个表，或者用这种方式访问一个表而同时处理该表的多个行。 一次同时访问多张表（或者多个实例的同一张表）的查询叫join查询。它们将一个表中的行与另一个表中的行结合起来，用一个表达式来指定哪些行将被配对。例如，返回所有天气记录以及相关的城市位置。数据库需要拿 weather表每行的city列和cities表所有行的name列进行比较， 并选取那些在该值上相匹配的行。
[4]
这个任务可以用下面的查询来实现：
SELECT * FROM weather JOIN cities ON city = name;
city      | temp_lo | temp_hi | prcp |    date    |     name      | location
---------------+---------+---------+------+------------+---------------+-----------
San Francisco |      46 |      50 | 0.25 | 1994-11-27 | San Francisco | (-194,53)
San Francisco |      43 |      57 |    0 | 1994-11-29 | San Francisco | (-194,53)
(2 rows)
观察结果集的两个方面：
没有城市Hayward的结果行。这是因为在cities表里面没有Hayward的匹配行，所以连接忽略 weather表里的不匹配行。我们稍后将看到如何修复它。
有两个列包含城市名字。这是正确的， 因为weather和cities表的列被串接在一起。不过，实际上我们不想要这些， 因此你将可能希望明确列出输出列而不是使用*：
SELECT city, temp_lo, temp_hi, prcp, date, location
FROM weather JOIN cities ON city = name;
因为这些列的名字都不一样，所以解析器自动地找出它们属于哪个表。如果在两个表里有重名的列，你需要限定列名来说明你究竟想要哪一个，如：
SELECT weather.city, weather.temp_lo, weather.temp_hi,
weather.prcp, weather.date, cities.location
FROM weather JOIN cities ON weather.city = cities.name;
人们广泛认为在一个连接查询中限定所有列名是一种好的风格，这样即使未来向其中一个表里添加重名列也不会导致查询失败。
到目前为止，这种类型的连接查询也可以用下面这样的形式写出来：
SELECT *
FROM weather, cities
WHERE city = name;
这个语法比JOIN/ON早，它是在SQL-92中引入的。
这种语法是在FROM子句中简单地列出表，比较表达式被添加到WHERE子句中。  这种旧的隐式语法和新的显式JOIN/ON语法的结果是相同的。  对于查询的读者来说，显式的语法使其含义更容易理解。连接条件是由它自己的关键词引入的，而以前这个条件是和WHERE子句中其他条件混在一起的。
现在我们将看看如何能把Hayward记录找回来。我们想让查询干的事是扫描weather表， 并且对每一行都找出匹配的cities表行。如果我们没有找到匹配的行，那么我们需要一些“空值”代替cities表的列。 这种类型的查询叫外连接 （我们在此之前看到的连接都是inner joins）。这样的命令看起来像这样：
SELECT *
FROM weather LEFT OUTER JOIN cities ON weather.city = cities.name;
city      | temp_lo | temp_hi | prcp |    date    |     name      | location
---------------+---------+---------+------+------------+---------------+-----------
Hayward       |      37 |      54 |      | 1994-11-29 |               |
San Francisco |      46 |      50 | 0.25 | 1994-11-27 | San Francisco | (-194,53)
San Francisco |      43 |      57 |    0 | 1994-11-29 | San Francisco | (-194,53)
(3 rows)
这个查询是一个左外连接， 因为在连接操作符左部的表中的行在输出中至少要出现一次， 而在右部的表的行只有在能找到匹配的左部表行时才被输出。 如果输出的左部表的行没有对应匹配的右部表的行，那么右部表行的列将填充空值（null）。
练习：.
还有右外连接和全外连接。试着找出来它们能干什么。
我们也可以把一个表和自己连接起来。这叫做自连接。 比如，假设我们想找出那些在其他天气记录的温度范围内的天气记录。这样我们就需要拿 weather表里每行的temp_lo和temp_hi列与weather表里其他行的temp_lo和temp_hi列进行比较。我们可以用下面的查询实现这个目标：
SELECT w1.city, w1.temp_lo AS low, w1.temp_hi AS high,
w2.city, w2.temp_lo AS low, w2.temp_hi AS high
FROM weather w1 JOIN weather w2
ON w1.temp_lo < w2.temp_lo AND w1.temp_hi > w2.temp_hi;
city      | low | high |     city      | low | high
---------------+-----+------+---------------+-----+------
San Francisco |  43 |   57 | San Francisco |  46 |   50
Hayward       |  37 |   54 | San Francisco |  46 |   50
(2 rows)
在这里我们把weather表重新标记为w1和w2以区分连接的左部和右部。你还可以用这样的别名在其他查询里节省一些敲键，比如：
SELECT *
FROM weather w JOIN cities c ON w.city = c.name;
你以后会经常碰到这样的缩写的。
[4]
这里只是一个概念上的模型。连接通常以比实际比较每个可能的行对更高效的方式执行， 但这些是用户看不到的。
上一页 上一级 下一页2.5. 查询表 起始页 2.7. 聚合函数
