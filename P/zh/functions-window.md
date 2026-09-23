# 9.22. 窗口函数

9.22. 窗口函数
版本：
纠错本页面
搜索
目录导航
❮
❯
9.22. 窗口函数 #
Window functions提供了跨越与当前查询行相关的行集执行计算的能力。
该特性的介绍请参见第 3.5 节，语法细节请参见第 4.2.8 节。
内置的窗口函数罗列在表 9.67中。注意，这些函数必须使用窗口函数语法来调用，也就是说，需要一个OVER子句。
除了这些函数之外，任何内置的或用户定义的普通聚合(例如非有序集或假设集聚合)都可以作为窗口函数使用；关于内置聚合的列表，参见第 9.21 节。
聚合函数只有在调用之后有一个OVER子句时才作为窗口函数；否则，它们充当普通的聚合，并为整个集合返回一行。
表 9.67. 通用窗口函数
函数
描述
row_number ()
→ bigint
返回当前行在其分区内的行号，从1开始计数。
rank ()
→ bigint
返回当前行的排名，包含间隔；即对等组中第一行的row_number。
dense_rank ()
→ bigint
返回当前行的排名，不包括间隔；该函数有效地计数对等组。
percent_rank ()
→ double precision
返回当前行的相对排名，即(rank - 1) / (总的分区行数 - 1)。因此，该值的范围从0到1（包含在内）。
cume_dist ()
→ double precision
返回累积分布，即（当前行之前或与当前行对等的分区行数）/（总的分区行数）。取值范围为1/N到1。
ntile ( num_buckets integer )
→ integer
返回一个从1到参数值的整数，并将分区尽可能均匀地划分。
lag ( value anycompatible
[, offset integer
[, default anycompatible ]] )
→ anycompatible
返回分区中在当前行之前offset行的value；如果没有这样的行，则返回default（必须与value相兼容的类型）。
offset和default都是针对当前行求值的。如果省略，offset默认为1，default为NULL。
lead ( value anycompatible
[, offset integer
[, default anycompatible ]] )
→ anycompatible
返回分区中在当前行之后offset行的value；
如果没有这样的行，则返回default
(必须与value兼容的类型)。
offset和default都是针对当前行求值的。
如果省略，offset默认为1，default为NULL。
first_value ( value anyelement )
→ anyelement
返回在窗口框架的第一行求得的value。
last_value ( value anyelement )
→ anyelement
返回在窗口框架的最后一行求得的value。
nth_value ( value anyelement, n integer )
→ anyelement
返回在窗口框架的第n行求得的value(从1开始计数)；如果没有这样的行，则返回NULL。
在表 9.67中列出的所有函数都依赖于相关窗口定义的ORDER BY子句指定的排序顺序。
仅考虑ORDER BY列时不能区分的行被称为是同等行。
定义的这四个排名函数（包括 cume_dist），对于对等组的所有行的答案相同。
注意first_value、last_value和nth_value只考虑“窗口帧”内的行，它默认情况下包含从分区的开始行直到当前行的最后一个同等行。
这对last_value可能不会给出有用的结果，有时对nth_value也一样。
你可以通过向OVER子句增加一个合适的帧声明（RANGE、ROWS或GROUPS）来重定义帧。
关于帧声明的更多信息请参考第 4.2.8 节。
当一个聚集函数被用作窗口函数时，它将在当前行的窗口帧内的行上聚集。
一个使用ORDER BY和默认窗口帧定义的聚集产生一种“运行时求和”类型的行为，这可能是或者不是想要的结果。
为了获取在整个分区上的聚集，忽略ORDER BY或者使用ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING。
其他窗口帧声明可以用来获得其他的效果。
注意
SQL 标准为lead、lag、first_value、last_value和nth_value定义了一个RESPECT NULLS或IGNORE NULLS选项。
这在PostgreSQL中没有实现：行为总是与标准的默认相同，即RESPECT NULLS。
同样，标准中用于nth_value的FROM FIRST或FROM LAST选项没有实现：只有支持默认的FROM FIRST行为（你可以通过反转ORDER BY的排序达到FROM LAST的结果）。
上一页 上一级 下一页9.21. 聚合函数 起始页 9.23. 合并支持函数
