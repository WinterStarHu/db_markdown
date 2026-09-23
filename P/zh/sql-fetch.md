# FETCH

FETCH
版本：
纠错本页面
搜索
目录导航
❮
❯
FETCHFETCH — 使用游标从查询中检索行大纲
FETCH [ direction ] [ FROM | IN ] cursor_name
其中 direction 可以是以下之一：
NEXT
PRIOR
FIRST
LAST
ABSOLUTE count
RELATIVE count
count
ALL
FORWARD
FORWARD count
FORWARD ALL
BACKWARD
BACKWARD count
BACKWARD ALL
描述
FETCH从之前创建的游标中检索行。
游标具有一个相关联的位置，FETCH会用到该位置。
游标位置可能会位于查询结果的第一行之前、结果中任意行之上或者
结果的最后一行之后。在被创建时，游标被定位在第一行之前。在取出
一些行后，该游标被定位在最近被取出的行上。如果
FETCH运行超过了可用行的末尾，则该游标会被定位
在最后一行之后（如果向后取，则是第一行之前）。
FETCH ALL或者FETCH BACKWARD
ALL将总是让游标被定位于最后一行之后或者第一行之前。
NEXT、PRIOR、FIRST、
LAST、ABSOLUTE、RELATIVE
形式会在适当移动游标后取出一行。如果没有这样一行，将返回一个空
结果，并且视情况将游标定位在第一行之前或者最后一行之后。
使用FORWARD和BACKWARD的形式会在
向前移动或者向后移动的方向上检索指定数量的行，然后将游标定位在
最后返回的行上（如果count超过可用的行数，则定位
在所有行之后或者之前）。
RELATIVE 0、FORWARD 0以及
BACKWARD 0都会请求检索当前行但不移动游标，也就是
重新取最近被取出的行。 只要游标没有被定位在第一行之前或者最后一行
之后，这种操作都会成功，否则不会返回任何行。
注意
这个页面描述在 SQL 命令层面上对游标的使用。如果想要在
PL/pgSQL函数中使用游标，规则会有所不同
— 请见第 41.7.3 节。
参数directiondirection 定义
获取方向以及要取得的行数。它可以是下列之一：
NEXT
取出下一行。如果省略direction，这将是默认值。
PRIOR
取出当前位置之前的一行。
FIRST
取出该查询的第一行（和ABSOLUTE 1相同）。
LAST
取出该查询的最后一行（和ABSOLUTE -1相同）。
ABSOLUTE count
取出该查询的第count个行，如果count为负则是从尾部开始取出
第abs(count)个行。如果
count超出范围，将定位在第一行
之前或者最后一行之后。特别地，ABSOLUTE 0
会定位在第一行之前。
RELATIVE count
取出第count个后继行，如果
count为负
则是取出前面的第abs(count)个行。
RELATIVE 0重新取出当前行（如果有）。
count
取出接下来的count行（和
FORWARD count相同）。
ALL
取出所有剩余的行（和FORWARD ALL相同）。
FORWARD
取出下一行（和NEXT相同）。
FORWARD count
取出接下来的count行。
FORWARD 0重新取出当前行。
FORWARD ALL
取出所有剩下的行。
BACKWARD
取出当前行前面的一行（和PRIOR相同）。
BACKWARD count
取出前面的count行（反向扫描）。
BACKWARD 0会重新取出当前行。
BACKWARD ALL
取出所有当前位置之前的行（反向扫描）。
countcount 是一个
可能带有符号的整数常量，它决定要取得的位置或者行数。对于
FORWARD和BACKWARD情况，指定一个负的
count等效于改变
FORWARD和BACKWARD的意义。
cursor_name
一个已打开游标的名称。
输出
如果成功完成，FETCH命令返回一个下面形式的命令标签：
FETCH count
count是获取的行数（可能
为零）。注意在psql中，命令标签将不会实际显示，
因为psql会显示获取的行。
注释
如果想要使用FETCH的任意变体而不使用带有正计数的
FETCH NEXT或者FETCH FORWARD，
应该用SCROLL声明游标。对于简单查询，
PostgreSQL将允许从不带
SCROLL的游标中反向获取行，但最好不要依赖这种行为。
如果游标被声明为带有NO SCROLL，则不允许反向获取。
用ABSOLUTE取行并不比用相对移动快多少：不管怎样，
底层实现都必须遍历所有的中间行。用负绝对值获取的情况更糟：必须读到
查询尾部来找到最后一行，并且接着从那里反向开始遍历。不过，回卷到查询
的开始（正如FETCH ABSOLUTE 0）是很快的。
DECLARE被用来定义游标。使用
MOVE可改变游标位置而不检索数据。
示例
下面的例子用一个游标遍历一个表：
BEGIN WORK;
-- 建立一个游标：
DECLARE liahona SCROLL CURSOR FOR SELECT * FROM films;
-- 在游标 liahona 中取出前 5 行：
FETCH FORWARD 5 FROM liahona;
code  |          title          | did | date_prod  |   kind   |  len
-------+-------------------------+-----+------------+----------+-------
BL101 | The Third Man           | 101 | 1949-12-23 | Drama    | 01:44
BL102 | The African Queen       | 101 | 1951-08-11 | Romantic | 01:43
JL201 | Une Femme est une Femme | 102 | 1961-03-12 | Romantic | 01:25
P_301 | Vertigo                 | 103 | 1958-11-14 | Action   | 02:08
P_302 | Becket                  | 103 | 1964-02-03 | Drama    | 02:28
-- 取出前面一行：
FETCH PRIOR FROM liahona;
code  |  title  | did | date_prod  |  kind  |  len
-------+---------+-----+------------+--------+-------
P_301 | Vertigo | 103 | 1958-11-14 | Action | 02:08
-- 关闭游标并且结束事务：
CLOSE liahona;
COMMIT WORK;
兼容性
SQL 标准只定义FETCH在嵌入式 SQL 中使用。
这里描述的FETCH变体返回数据时就好像数据是
一个SELECT结果，而不是被放在主变量中。
除这一点之外，FETCH完全向上兼容于 SQL 标准。
涉及FORWARD和BACKWARD的
FETCH形式，以及形式FETCH count和FETCH
ALL（其中FORWARD是隐式的）都是
PostgreSQL扩展。
SQL 标准只允许FROM在游标名之前。使用
IN的选项或者完全省去它们是一种扩展。
另见CLOSE, DECLARE, MOVE上一页 上一级 下一页EXPLAIN 起始页 GRANT
