# 7.2. 表表达式

7.2. 表表达式
版本：
纠错本页面
搜索
目录导航
❮
❯
7.2. 表表达式 #7.2.1. FROM子句7.2.2. WHERE子句7.2.3. GROUP BY和HAVING子句7.2.4. GROUPING SETS、CUBE和ROLLUP7.2.5. 窗口函数处理
表表达式计算一个表。该表表达式包含一个FROM子句，该子句后面可以选用WHERE、GROUP BY和HAVING子句。最简单的表表达式只是引用磁盘上的一个表，一个所谓的基本表，但是我们可以用更复杂的表表达式以多种方法修改或组合基本表。
表表达式里可选的WHERE、GROUP BY和HAVING子句指定一系列对源自FROM子句的表的转换操作。所有这些转换最后生成一个虚拟表，它提供行传递给选择列表计算查询的输出行。
7.2.1. FROM子句 #
FROM子句从一个用逗号分隔的表引用列表中的一个或多个其他表中生成一个表。
FROM table_reference [, table_reference [, ...]]
表引用可以是一个表名字（可能有模式限定），或者是一个生成的表，例如子查询、一个JOIN结构或者这些东西的复杂组合。如果在FROM子句中引用了多于一个表，那么它们被交叉连接（即构造它们的行的笛卡尔积，见下文）。FROM列表的结果是一个中间的虚拟表，该表可以进行由WHERE、GROUP BY和HAVING子句指定的转换，并最后生成整体的表表达式结果。
如果一个表引用是一个简单的表名字并且它是表继承层次中的父表，那么该表引用将产生该表和它的后代表中的行，除非你在该表名字前面放上ONLY关键字。但是，这种引用只会产生出现在该命名表中的列 — 在子表中增加的列都会被忽略。
除了在表名前写ONLY，你可以在表名后面写上*来显式地指定要包括所有的后代表。没有实际的理由再继续使用这种语法，因为搜索后代表现在总是默认行为。不过，为了保持与旧版本的兼容性，仍然支持这种语法。
7.2.1.1. 连接表 #
一个连接表是根据特定的连接类型的规则从两个其他（真实或
派生）表中派生的表。目前支持内连接、外连接和交叉连接。一个连接表的一般语法是
T1 join_type T2 [ join_condition ]
所有类型的连接都可以被链在一起或者嵌套：T1和
T2都可以是连接表。在JOIN子句周围可以使用圆括号来控制连接顺序。如果不使用圆括号，JOIN子句会从左至右嵌套。
连接类型交叉连接
T1 CROSS JOIN T2
对来自于T1和T2的行的每一种可能的组合（即笛卡尔积），连接表将包含这样一行：它由所有T1中的列后面跟着所有T2中的列构成。如果两个表分别有 N 和 M 行，连接表将有 N * M 行。
FROM T1 CROSS JOIN
T2等效于FROM T1 INNER JOIN
T2 ON TRUE（见下文）。它也等效于
FROM T1,
T2。
注意
当多于两个表出现时，后一种等效并不严格成立，因为JOIN比
逗号绑定得更紧。例如
FROM T1 CROSS JOIN
T2 INNER JOIN T3
ON condition
和FROM T1,
T2 INNER JOIN T3
ON condition
并不完全相同，因为第一种情况中的condition可以
引用T1，但在第二种情况中却不行。
条件连接
T1 { [INNER] | { LEFT | RIGHT | FULL } [OUTER] } JOIN T2 ON boolean_expression
T1 { [INNER] | { LEFT | RIGHT | FULL } [OUTER] } JOIN T2 USING ( join column list )
T1 NATURAL { [INNER] | { LEFT | RIGHT | FULL } [OUTER] } JOIN T2
INNER和OUTER对所有连接形式都是可选的。INNER是默认；LEFT、RIGHT和FULL指示一个外连接。
连接条件在ON或USING子句中指定，或者用关键字NATURAL隐含地指定。连接条件决定来自两个源表中的哪些行是“匹配”的，这些我们将在后文详细解释。
可能的条件连接类型是：
INNER JOIN
对于 T1 的每一行 R1，生成的连接表都有一行对应 T2 中的每一个满足与 R1 的连接条件的行。
LEFT OUTER JOIN
首先，执行一次内连接。然后，为 T1 中每一个无法在连接条件上匹配 T2 里任何一行的行添加一个连接行，该连接行中 T2 的列用空值补齐。因此，生成的连接表里为来自 T1 的每一行都至少包含一行。
RIGHT OUTER JOIN
首先，执行一次内连接。然后，为 T2 中每一个无法在连接条件上匹配 T1 里任何一行的行添加一个连接行，该连接行中 T1 的列用空值补齐。因此，生成的连接表里为来自 T2 的每一行都至少包含一行。
FULL OUTER JOIN
首先，执行一次内连接。然后，为 T1 中每一个无法在连接条件上匹配 T2 里任何一行的行添加一个连接行，该连接行中 T2 的列用空值补齐。同样，为 T2 中每一个无法在连接条件上匹配 T1 里任何一行的行添加一个连接行，该连接行中 T1 的列用空值补齐。
ON子句是最常见的连接条件的形式：它接收一个和WHERE子句里用的一样的布尔值表达式。如果两个分别来自T1和T2的行在ON表达式上运算的结果为真，那么它们就算是匹配的行。
USING是个缩写符号，它允许你利用特殊的情况：连接的两端都具有相同的连接列名。它接受共享列名的一个逗号分隔列表，并且为其中每一个共享列构造一个包含等值比较的连接条件。例如用USING (a, b)连接T1和T2会产生连接条件ON T1.a
= T2.a AND T1.b
= T2.b。
更进一步，JOIN USING的输出会抑制冗余列：不需要把匹配上的列都打印出来，因为它们必须具有相等的值。不过JOIN ON会先产生来自T1的所有列，后面跟上所有来自T2的列；而JOIN USING会先为列出的每一个列对产生一个输出列，然后再跟上来自T1的剩余列，最后跟上来自T2的剩余列。
最后，NATURAL是USING的简写形式：它形成一个USING列表，包含所有在两个输入表中都出现的列名。与USING一样，这些列在输出表中只出现一次。如果没有公共的列名，NATURAL JOIN的行为就像CROSS JOIN。
注意
USING对于连接关系中的列改变是相当安全的，因为只有被列出的列会被组合成连接条件。NATURAL的风险更大，因为如果其中一个关系的模式改变会导致出现一个新的匹配列名，就会导致连接将新列也组合成连接条件。
为了解释这些问题，假设我们有一个表t1：
num | name
-----+------
1 | a
2 | b
3 | c
和t2：
num | value
-----+-------
1 | xxx
3 | yyy
5 | zzz
然后我们用不同的连接方式可以获得各种结果：
=> SELECT * FROM t1 CROSS JOIN t2;
num | name | num | value
-----+------+-----+-------
1 | a    |   1 | xxx
1 | a    |   3 | yyy
1 | a    |   5 | zzz
2 | b    |   1 | xxx
2 | b    |   3 | yyy
2 | b    |   5 | zzz
3 | c    |   1 | xxx
3 | c    |   3 | yyy
3 | c    |   5 | zzz
(9 rows)
=> SELECT * FROM t1 INNER JOIN t2 ON t1.num = t2.num;
num | name | num | value
-----+------+-----+-------
1 | a    |   1 | xxx
3 | c    |   3 | yyy
(2 rows)
=> SELECT * FROM t1 INNER JOIN t2 USING (num);
num | name | value
-----+------+-------
1 | a    | xxx
3 | c    | yyy
(2 rows)
=> SELECT * FROM t1 NATURAL INNER JOIN t2;
num | name | value
-----+------+-------
1 | a    | xxx
3 | c    | yyy
(2 rows)
=> SELECT * FROM t1 LEFT JOIN t2 ON t1.num = t2.num;
num | name | num | value
-----+------+-----+-------
1 | a    |   1 | xxx
2 | b    |     |
3 | c    |   3 | yyy
(3 rows)
=> SELECT * FROM t1 LEFT JOIN t2 USING (num);
num | name | value
-----+------+-------
1 | a    | xxx
2 | b    |
3 | c    | yyy
(3 rows)
=> SELECT * FROM t1 RIGHT JOIN t2 ON t1.num = t2.num;
num | name | num | value
-----+------+-----+-------
1 | a    |   1 | xxx
3 | c    |   3 | yyy
|      |   5 | zzz
(3 rows)
=> SELECT * FROM t1 FULL JOIN t2 ON t1.num = t2.num;
num | name | num | value
-----+------+-----+-------
1 | a    |   1 | xxx
2 | b    |     |
3 | c    |   3 | yyy
|      |   5 | zzz
(4 rows)
用ON指定的连接条件也可以包含与连接不直接相关的条件。这种功能可能对某些查询很有用，但是需要我们仔细想清楚。例如：
=> SELECT * FROM t1 LEFT JOIN t2 ON t1.num = t2.num AND t2.value = 'xxx';
num | name | num | value
-----+------+-----+-------
1 | a    |   1 | xxx
2 | b    |     |
3 | c    |     |
(3 rows)
注意把限制放在WHERE子句中会产生不同的结果：
=> SELECT * FROM t1 LEFT JOIN t2 ON t1.num = t2.num WHERE t2.value = 'xxx';
num | name | num | value
-----+------+-----+-------
1 | a    |   1 | xxx
(1 row)
这是因为放在ON子句中的一个约束在连接之前被处理，而放在WHERE子句中的一个约束是在连接之后被处理。这对内连接没有关系，但是对于外连接会带来麻烦。
7.2.1.2. 表和列别名 #
你可以给一个表或复杂的表引用指定一个临时的名字，用于剩下的查询中引用那些派生的表。这被叫做表别名。
要创建一个表别名，我们可以写：
FROM table_reference AS alias
或者
FROM table_reference alias
AS关键字是可选的。alias可以是任意标识符。
表别名的典型应用是给长表名赋予比较短的标识符，以保持连接子句的可读性。例如：
SELECT * FROM some_very_long_table_name s JOIN another_fairly_long_name a ON s.id = a.num;
到这里，别名成为当前查询的表引用的新名称 — 我们不再能够用该表最初的名字引用它了。因此，下面的用法是不合法的：
SELECT * FROM my_table AS m WHERE my_table.a > 5;    -- 错误
表别名主要是为了书写方便，但在将表与自身连接时是必须的，例如：
SELECT * FROM people AS mother JOIN people AS child ON mother.id = child.mother_id;
圆括弧用于解决歧义。在下面的例子中，第一个语句将把别名b赋给my_table的第二个实例，但是第二个语句把别名赋给连接的结果：
SELECT * FROM my_table AS a CROSS JOIN my_table AS b ...
SELECT * FROM (my_table AS a CROSS JOIN my_table) AS b ...
另外一种给表指定别名的形式是给表的列赋予临时名字，就像给表本身指定别名一样：
FROM table_reference [AS] alias ( column1 [, column2 [, ...]] )
如果指定的列别名比表里实际的列少，那么剩下的列就没有被重命名。这种语法对于自连接或子查询特别有用。
如果用这些形式中的任何一种给一个JOIN子句的输出附加了一个别名，那么该别名就在JOIN的作用下隐去了其原始的名字。例如：
SELECT a.* FROM my_table AS a JOIN your_table AS b ON ...
是合法 SQL，但是：
SELECT a.* FROM (my_table AS a JOIN your_table AS b ON ...) AS c
是不合法的：表别名a在别名c外面是看不到的。
7.2.1.3. 子查询 #
指定派生表的子查询必须用括号括起来。它们可以被分配一个表别名，
并可选地分配列别名（如在第 7.2.1.2 节中）。
例如：
FROM (SELECT * FROM table1) AS alias_name
这个例子等效于FROM table1 AS alias_name。更有趣的情况是在子查询涉及
分组或聚合时，子查询不能被简化为一个简单的连接。
子查询也可以是一个VALUES列表：
FROM (VALUES ('anne', 'smith'), ('bob', 'jones'), ('joe', 'blow'))
AS names(first, last)
同样，表别名是可选的。为VALUES列表的列分配别名是可选的，
但这是一个好的实践。有关更多信息，请参见第 7.7 节。
根据SQL标准，子查询必须提供一个表别名。
PostgreSQL允许省略AS
和别名，但在可能移植到其他系统的SQL代码中，编写别名是一个好习惯。
7.2.1.4. 表函数 #
表函数是那些生成一个行集合的函数，这个集合可以是由基本数据类型（标量类型）组成，也可以是由复合数据类型（表行）组成。它们的用法类似一个表、视图或者在查询的FROM子句里的子查询。表函数返回的列可以像一个表列、视图或者子查询那样被包含在SELECT、JOIN或WHERE子句里。
表函数也可以使用ROWS FROM语法组合，返回的结果以平行列的形式呈现；在这种情况下，结果行的数量是最大一个函数结果的数量，较小的结果会用空值来填充。
function_call [WITH ORDINALITY] [[AS] table_alias [(column_alias [, ... ])]]
ROWS FROM( function_call [, ... ] ) [WITH ORDINALITY] [[AS] table_alias [(column_alias [, ... ])]]
如果指定了WITH ORDINALITY子句，一个额外的bigint类型的列将会被增加到函数的结果列中。这个列对函数结果集的行进行编号，编号从1开始（这是对SQL标准语法UNNEST ... WITH ORDINALITY的一般化）。默认情况下，序数列被称为ordinality，但也可以通过使用一个AS子句给它分配一个不同的列名。
调用特殊的表函数UNNEST可以使用任意数量的数组参数，它会返回对应的列数，就好像在每一个参数上单独调用UNNEST（第 9.19 节）并且使用ROWS FROM结构把它们组合起来。
UNNEST( array_expression [, ... ] ) [WITH ORDINALITY] [[AS] table_alias [(column_alias [, ... ])]]
如果没有指定table_alias，该函数名将被用作表名。在ROWS FROM()结构的情况中，会使用第一个函数名。
如果没有提供列的别名，那么对于一个返回基数据类型的函数，列名也与该函数
名相同。对于一个返回复合类型的函数，结果列会从该类型的属性得到名称。
一些例子：
CREATE TABLE foo (fooid int, foosubid int, fooname text);
CREATE FUNCTION getfoo(int) RETURNS SETOF foo AS $$
SELECT * FROM foo WHERE fooid = $1;
$$ LANGUAGE SQL;
SELECT * FROM getfoo(1) AS t1;
SELECT * FROM foo
WHERE foosubid IN (
SELECT foosubid
FROM getfoo(foo.fooid) z
WHERE z.fooid = foo.fooid
);
CREATE VIEW vw_getfoo AS SELECT * FROM getfoo(1);
SELECT * FROM vw_getfoo;
有时，定义一个能够根据它们被调用方式返回不同列集合的表函数是很有用的。
为了支持这些，表函数可以被声明为返回没有OUT参数的伪类型record。
如果在查询里使用这样的函数，那么我们必须在查询中指定所预期的行结构，这样系统才知道如何分析和规划该查询。
这种语法是这样的：
function_call [AS] alias (column_definition [, ... ])
function_call AS [alias] (column_definition [, ... ])
ROWS FROM( ... function_call AS (column_definition [, ... ]) [, ... ] )
在没有使用ROWS FROM()语法时，
column_definition列表会取代无法附着在
FROM项上的列别名列表，列定义中的名称就起到列别名的作用。
在使用ROWS FROM()语法时，
可以为每一个成员函数单独附着一个
column_definition列表；或者在只有一个成员
函数并且没有WITH ORDINALITY子句的情况下，可以在
ROWS FROM()后面写一个
column_definition列表来取代一个列别名列表。
考虑下面的例子：
SELECT *
FROM dblink('dbname=mydb', 'SELECT proname, prosrc FROM pg_proc')
AS t1(proname name, prosrc text)
WHERE proname LIKE 'bytea%';
dblink函数（dblink模块的一部分）执行一个远程的查询。它被声明为返回record，因为它可能会被用于任何类型的查询。 实际的列集必须在调用它的查询中指定，这样分析器才知道类似*这样的东西应该扩展成什么样子。
此示例使用ROWS FROM：
SELECT *
FROM ROWS FROM
(
json_to_recordset('[{"a":40,"b":"foo"},{"a":"100","b":"bar"}]')
AS (a INTEGER, b TEXT),
generate_series(1, 3)
) AS x (p, q, s)
ORDER BY p;
p  |  q  | s
-----+-----+---
40 | foo | 1
100 | bar | 2
|     | 3
它将两个函数连接到一个FROM目标中。
json_to_recordset()被指示返回两列，第一个integer
和第二个text。generate_series()的结果直接使用。
ORDER BY子句将列值排序为整数。
7.2.1.5. LATERAL 子查询 #
可以在出现于FROM中的子查询前放置关键词LATERAL。这允许它们引用前面的FROM项提供的列（如果没有LATERAL，每个子查询将被独立计算，并且因此不能被其他FROM项交叉引用）。
出现在FROM中的表函数的前面也可以被放上关键词LATERAL，但对于函数该关键词是可选的，在任何情况下函数的参数都可以包含对前面的FROM项提供的列的引用。
一个LATERAL项可以出现在FROM列表的顶层，或者在JOIN树中。
在后一种情况下，它还可以引用任何在它右侧的JOIN左侧的项。
如果一个FROM项包含LATERAL交叉引用，计算过程如下：对于提供交叉引用列的FROM项的每一行，或者多个提供这些列的多个FROM项的行集合，LATERAL项将被使用该行或者行集中的列值进行计算。得到的结果行将和它们被计算出来的行进行正常的连接。对于来自这些列的源表的每一行或行集，该过程将重复。
LATERAL的一个简单例子：
SELECT * FROM foo, LATERAL (SELECT * FROM bar WHERE bar.id = foo.bar_id) ss;
这不是非常有用，因为它和一种更简单的形式得到的结果完全一样：
SELECT * FROM foo, bar WHERE bar.id = foo.bar_id;
在必须要使用交叉引用列来计算那些即将要被连接的行时，LATERAL是最有用的。一种常用的应用是为一个返回集合的函数提供一个参数值。例如，假设vertices(polygon)返回一个多边形的顶点集合，我们可以这样标识存储在一个表中的多边形中靠近的顶点：
SELECT p1.id, p2.id, v1, v2
FROM polygons p1, polygons p2,
LATERAL vertices(p1.poly) v1,
LATERAL vertices(p2.poly) v2
WHERE (v1 <-> v2) < 10 AND p1.id != p2.id;
这个查询也可以被写成：
SELECT p1.id, p2.id, v1, v2
FROM polygons p1 CROSS JOIN LATERAL vertices(p1.poly) v1,
polygons p2 CROSS JOIN LATERAL vertices(p2.poly) v2
WHERE (v1 <-> v2) < 10 AND p1.id != p2.id;
或者写成其他几种等价的公式（正如以上提到的，LATERAL关键词在这个例子中并不是必不可少的，但是我们在这里使用它是为了使表述更清晰）。
有时候也会特别地将LEFT JOIN放在一个LATERAL子查询的前面，这样即使LATERAL子查询对源行不产生行，源行也会出现在结果中。例如，如果get_product_names()返回一个制造商制造的产品的名字，但是某些制造商在我们的表中目前没有制造产品，我们可以找出哪些制造商是这样：
SELECT m.name
FROM manufacturers m LEFT JOIN LATERAL get_product_names(m.id) pname ON true
WHERE pname IS NULL;
7.2.2. WHERE子句 #
WHERE子句的语法是
WHERE search_condition
其中search_condition是任意值表达式（参阅第 4.2 节），
该表达式返回一个boolean类型的值。
在完成对FROM子句的处理之后，生成的虚拟表的每一行都会根据搜索条件进行检查。
如果该条件的结果是真，那么该行被保留在输出表中；否则（也就是说，如果结果是假或空）就把它抛弃。
搜索条件通常至少要引用一些在FROM子句里生成的列；虽然这不是必须的，但如果不引用这些列，
那么WHERE子句就没什么用了。
注意
内连接的连接条件既可以写在WHERE子句，也可以写在JOIN子句里。
例如，这些表表达式是等效的：
FROM a, b WHERE a.id = b.id AND b.val > 5
和：
FROM a INNER JOIN b ON (a.id = b.id) WHERE b.val > 5
或者可能还有：
FROM a NATURAL JOIN b WHERE b.val > 5
你想用哪个只是一个风格问题。FROM子句里的JOIN语法可能不那么容易移植到其他SQL数据库管理系统中。
对于外部连接而言没有选择：它们必须在FROM子句中完成。
外部连接的ON或USING子句不等于WHERE条件，
因为它导致最终结果中行的增加（对那些不匹配的输入行）和减少。
这里是一些WHERE子句的例子：
SELECT ... FROM fdt WHERE c1 > 5
SELECT ... FROM fdt WHERE c1 IN (1, 2, 3)
SELECT ... FROM fdt WHERE c1 IN (SELECT c1 FROM t2)
SELECT ... FROM fdt WHERE c1 IN (SELECT c3 FROM t2 WHERE c2 = fdt.c1 + 10)
SELECT ... FROM fdt WHERE c1 BETWEEN (SELECT c3 FROM t2 WHERE c2 = fdt.c1 + 10) AND 100
SELECT ... FROM fdt WHERE EXISTS (SELECT c1 FROM t2 WHERE c2 > fdt.c1)
fdt是从FROM子句中派生的表。那些不符合WHERE子句的搜索条件的行会被从fdt中删除。
请注意我们把标量子查询当做一个值表达式来用。和任何其他查询一样，子查询里可以使用复杂的表表达式。
同时还请注意fdt在子查询中也被引用。只有在c1也是作为子查询输入表的生成表的列时，
才必须把c1限定成fdt.c1。但限定列名字可以增加语句的清晰度，即使有时候不是必须的。
这个例子展示了一个外层查询的列名范围如何扩展到它的内层查询。
7.2.3. GROUP BY和HAVING子句 #
在通过了WHERE过滤器之后，生成的输入表可能会使用GROUP BY子句进行分组，并使用HAVING子句删除一些分组行。
SELECT select_list
FROM ...
[WHERE ...]
GROUP BY grouping_column_reference [, grouping_column_reference]...
GROUP BY子句用于将表中在所有列上具有相同值的行分组在一起。 这些列的列出顺序并没有关系。其效果是将每组具有相同值的行组合为一个组行，它代表该组里的所有行。 这样可以消除输出中的冗余和/或计算应用于这些组的聚合。例如：
=> SELECT * FROM test1;
x | y
---+---
a | 3
c | 2
b | 5
a | 1
(4 rows)
=> SELECT x FROM test1 GROUP BY x;
x
---
a
b
c
(3 rows)
在第二个查询中，我们不能写成SELECT * FROM test1 GROUP BY x，因为列y没有单一的值可以与每个组相关联。被分组的列可以在选择列表中引用，因为它们在每个组都有单一的值。
通常，如果一个表被分组，那么没有在GROUP BY中列出的列都不能被引用，除非在聚合表达式中被引用。 一个用聚合表达式的例子是：
=> SELECT x, sum(y) FROM test1 GROUP BY x;
x | sum
---+-----
a |   4
b |   5
c |   2
(3 rows)
这里的sum是一个聚合函数，它在整个组上计算出一个单一值。有关可用的聚合函数的更多信息可以在第 9.21 节中找到。
提示
没有聚合表达式的分组实际上计算了一个列中不同值的集合。我们也可以用DISTINCT子句实现（参阅第 7.3.3 节）。
这里是另一个例子：它计算每种产品的总销售额（而不是所有产品的总销售额）：
SELECT product_id, p.name, (sum(s.units) * p.price) AS sales
FROM products p LEFT JOIN sales s USING (product_id)
GROUP BY product_id, p.name, p.price;
在这个例子中，列product_id、p.name和p.price必须在GROUP BY子句中，因为它们在查询的选择列表中被引用（但见下文）。列s.units不必在GROUP BY列表中，因为它只是在一个聚合表达式（sum(...)）中使用，它代表一个产品的销售额。对于每种产品，这个查询都返回一个关于该产品所有销售额的汇总行。
如果产品表被建立起来，例如product_id是主键，那么在上面的例子中用product_id来分组就够了，因为名称和价格都是函数依赖于产品 ID，并且关于为每个产品 ID 分组返回哪个名称和价格值就不会有歧义。
在严格的 SQL 里，GROUP BY只能对源表的列进行分组，但PostgreSQL把这个扩展为也允许GROUP BY去根据选择列表中的列分组。也允许对值表达式进行分组，而不仅是简单的列名。
如果一个表已经用GROUP BY子句分了组，然后你又只对其中的某些组感兴趣，那么就可以用HAVING子句，它很像WHERE子句，用于从结果中删除一些组。其语法是：
SELECT select_list FROM ... [WHERE ...] GROUP BY ... HAVING boolean_expression
在HAVING子句中的表达式可以引用分组的表达式和未分组的表达式（后者必须涉及一个聚合函数）。
例子：
=> SELECT x, sum(y) FROM test1 GROUP BY x HAVING sum(y) > 3;
x | sum
---+-----
a |   4
b |   5
(2 rows)
=> SELECT x, sum(y) FROM test1 GROUP BY x HAVING x < 'c';
x | sum
---+-----
a |   4
b |   5
(2 rows)
再次，一个更现实的例子：
SELECT product_id, p.name, (sum(s.units) * (p.price - p.cost)) AS profit
FROM products p LEFT JOIN sales s USING (product_id)
WHERE s.date > CURRENT_DATE - INTERVAL '4 weeks'
GROUP BY product_id, p.name, p.price, p.cost
HAVING sum(p.price * s.units) > 5000;
在上面的例子里，WHERE子句用那些非分组的列选择数据行（表达式只是对那些最近四周发生的销售为真）。而HAVING子句限制输出为总销售收入超过 5000 的组。请注意聚合表达式不需要在查询中的所有地方都一样。
如果一个查询包含聚合函数调用，但是没有GROUP BY子句，分组仍然会发生：结果是一个单一行（或者根本就没有行，如果该单一行被HAVING所消除）。它包含一个HAVING子句时也是这样，即使没有任何聚合函数调用或者GROUP BY子句。
7.2.4. GROUPING SETS、CUBE和ROLLUP #
使用分组集的概念可以实现比上述更加复杂的分组操作。由
FROM和WHERE子句选出的数据被按照每一个指定
的分组集单独分组，按照简单GROUP BY子句对每一个分组计算
聚集，然后返回结果。例如：
=> SELECT * FROM items_sold;
brand | size | sales
-------+------+-------
Foo   | L    |  10
Foo   | M    |  20
Bar   | M    |  15
Bar   | L    |  5
(4 rows)
=> SELECT brand, size, sum(sales) FROM items_sold GROUP BY GROUPING SETS ((brand), (size), ());
brand | size | sum
-------+------+-----
Foo   |      |  30
Bar   |      |  20
| L    |  15
| M    |  35
|      |  50
(5 rows)
GROUPING SETS的每一个子列表可以指定一个或者多个列或者表达式，
它们将按照直接出现在GROUP BY子句中同样的方式被解释。一个空的
分组集表示所有的行都要被聚集到一个单一分组（即使没有输入行存在也会被输出）
中，这就像前面所说的没有GROUP BY子句的聚集函数的情况一样。
对于分组列或表达式没有出现在其中的分组集的结果行，对分组列或表达式的引用会
被空值所替代。要区分一个特定的输出行来自于哪个分组，请见
表 9.66。
PostgreSQL 中提供了一种简化方法来指定两种常用类型的分组集。下面形式的子句
ROLLUP ( e1, e2, e3, ... )
表示给定的表达式列表及其所有前缀（包括空列表），因此它等效于
GROUPING SETS (
( e1, e2, e3, ... ),
...
( e1, e2 ),
( e1 ),
( )
)
这通常被用来分析层次数据，例如按部门、区和公司范围计算的总薪水。
下面形式的子句
CUBE ( e1, e2, ... )
表示给定的列表及其可能的子集（即幂集）。因此
CUBE ( a, b, c )
等效于
GROUPING SETS (
( a, b, c ),
( a, b    ),
( a,    c ),
( a       ),
(    b, c ),
(    b    ),
(       c ),
(         )
)
CUBE或ROLLUP子句中的元素可以是表达式或者
圆括号中的元素子列表。在后一种情况中，对于生成分组集的目的来说，子列
表被当做单一单元来对待。例如：
CUBE ( (a, b), (c, d) )
等效于
GROUPING SETS (
( a, b, c, d ),
( a, b       ),
(       c, d ),
(            )
)
并且
ROLLUP ( a, (b, c), d )
等效于
GROUPING SETS (
( a, b, c, d ),
( a, b, c    ),
( a          ),
(            )
)
CUBE和ROLLUP可以被直接用在
GROUP BY子句中，也可以被嵌套在一个
GROUPING SETS子句中。如果一个
GROUPING SETS子句被嵌套在另一个同类子句中，
效果和把内层子句的所有元素直接写在外层子句中一样。
如果在单个GROUP BY子句中指定了多个分组项，那么最终的分组集列表是各个
项目的笛卡尔积。例如：
GROUP BY a, CUBE (b, c), GROUPING SETS ((d), (e))
等价于
GROUP BY GROUPING SETS (
(a, b, c, d), (a, b, c, e),
(a, b, d),    (a, b, e),
(a, c, d),    (a, c, e),
(a, d),       (a, e)
)
当一次指定多个分组项时，最终的分组集合可能包含重复项。例如：
GROUP BY ROLLUP (a, b), ROLLUP (a, c)
等同于
GROUP BY GROUPING SETS (
(a, b, c),
(a, b),
(a, b),
(a, c),
(a),
(a),
(a, c),
(a),
()
)
如果这些重复项是不希望出现的，可以在GROUP BY上直接使用DISTINCT子句来删除它们。因此：
GROUP BY DISTINCT ROLLUP (a, b), ROLLUP (a, c)
等同于
GROUP BY GROUPING SETS (
(a, b, c),
(a, b),
(a, c),
(a),
()
)
这与使用SELECT DISTINCT不同，因为输出行仍然可能包含重复项。如果任何一个未分组的列包含 NULL，则无法区分其与分组该列时使用的 NULL。
注意
在表达式中，结构(a, b)通常被识别为一个
行构造器。在
GROUP BY子句中，这不会在表达式的顶层应用，并且
(a, b)会按照上面所说的被解析为一个表达式的列表。如果出于
某种原因你在分组表达式中需要一个行构造器，请使用
ROW(a, b)。
7.2.5. 窗口函数处理 #
如果查询包含任何窗口函数（见第 3.5 节、第 9.22 节和第 4.2.8 节），这些函数将在任何分组、聚集和HAVING过滤被执行之后被计算。也就是说如果查询使用了任何聚集、GROUP BY或HAVING，则窗口函数看到的行是分组行而不是来自于FROM/WHERE的原始表行。
当使用多个窗口函数时，所有在其窗口定义中具有等效
PARTITION BY 和 ORDER BY 子句的窗口函数
保证看到输入行的相同排序，即使 ORDER BY 并不唯一确定排序。
但是，对于具有不同 PARTITION BY 或 ORDER BY
规范的函数，其评估不作任何保证。
（在这种情况下，通常需要在窗口函数评估的多次传递之间进行排序步骤，
并且排序不能保证保持其 ORDER BY 视为等价的行的顺序。）
目前，窗口函数总是要求排序好的数据，并且这样查询的输出总是被根据窗口函数的 PARTITION BY/ORDER BY 子句的一个或者另一个排序。但是，我们不推荐依赖于此。如果你希望确保结果以特定的方式排序，请显式使用顶层的 ORDER BY 子句。
上一页 上一级 下一页7.1. 概述 起始页 7.3. 选择列表
