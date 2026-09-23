# 2.7. 聚合函数

2.7. 聚合函数
版本：
纠错本页面
搜索
目录导航
❮
❯
2.7. 聚合函数 #
和大多数其他关系数据库产品一样，PostgreSQL支持聚合函数。 一个聚合函数从多个输入行中计算出一个结果。 比如，我们有在一个行集合上计算count（计数）、sum（和）、avg（平均值）、max（最大值）和min（最小值）的函数。
比如，我们可以用下面的语句找出所有记录中最低温度的最高值：
SELECT max(temp_lo) FROM weather;
max
-----
46
(1 row)
如果我们想知道这个读数发生在哪个城市（或城市），
我们可以尝试：
SELECT city FROM weather WHERE temp_lo = max(temp_lo);     -- 错误
但这将不起作用，因为聚合函数
max 不能在
WHERE 子句中使用。
（这个限制存在是因为
WHERE 子句决定了哪些行将包含在聚合计算中；
所以显然它必须在计算聚合函数之前进行评估。）
然而，通常情况下，
查询可以重新表述以实现所需的结果，这里
通过使用 子查询：
SELECT city FROM weather
WHERE temp_lo = (SELECT max(temp_lo) FROM weather);
city
---------------
San Francisco
(1 row)
这是可以的，因为子查询是一个独立的计算，
它单独计算自己的聚合，而不受外部查询中发生的事情的影响。
聚合函数在与GROUP BY子句结合时也非常有用。例如，我们可以通过以下查询获取每个城市的读数和观察到的最低温度：
SELECT city, count(*), max(temp_lo)
FROM weather
GROUP BY city;
city      | count | max
---------------+-------+-----
Hayward       |     1 |  37
San Francisco |     2 |  46
(2 rows)
这使我们每个城市得到一个输出行。每个聚合结果是在匹配该城市的表行上计算的。
我们可以使用HAVING来过滤这些分组的行：
SELECT city, count(*), max(temp_lo)
FROM weather
GROUP BY city
HAVING max(temp_lo) < 40;
city   | count | max
---------+-------+-----
Hayward |     1 |  37
(1 row)
这使我们仅获取所有temp_lo值低于40的城市的相同结果。最后，如果我们只关心以“S”开头的城市的话，我们可以这样做：
SELECT city, count(*), max(temp_lo)
FROM weather
WHERE city LIKE 'S%'            -- (1)
GROUP BY city;
city      | count | max
---------------+-------+-----
San Francisco |     2 |  46
(1 row)
(1)
LIKE操作符进行模式匹配，详细说明请参见第 9.7 节。
理解聚合和SQL的WHERE以及HAVING子句之间的关系对我们非常重要。WHERE和HAVING的基本区别如下：WHERE在分组和聚合计算之前选取输入行（因此，它控制哪些行进入聚合计算），而HAVING在分组和聚合之后选取分组行。因此，WHERE子句不能包含聚合函数；因为试图用聚合函数判断哪些行应输入给聚合运算是没有意义的。相反，HAVING子句总是包含聚合函数（严格说来，你可以写不使用聚合的HAVING子句，但这样做很少有用。同样的条件用在WHERE阶段会更有效）。
在前面的例子里，我们可以在WHERE里应用城市名称限制，因为它不需要聚合。这样比放在HAVING里更加高效，因为可以避免那些未通过WHERE检查的行参与到分组和聚合计算中。
选择进入聚合计算的行的另一种方法是使用FILTER，这是一个每个聚合的选项：
SELECT city, count(*) FILTER (WHERE temp_lo < 45), max(temp_lo)
FROM weather
GROUP BY city;
city      | count | max
---------------+-------+-----
Hayward       |     1 |  37
San Francisco |     1 |  46
(2 rows)
FILTER与WHERE非常相似，
不同之处在于它仅从附加到特定聚合函数的输入中删除行。
在这里，count聚合仅计算
temp_lo低于45的行；但是
max聚合仍然应用于所有行，
因此仍然找到46的读数。
上一页 上一级 下一页2.6. 表之间的连接 起始页 2.8. 更新
