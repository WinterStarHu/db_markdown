# 7.5. 行排序 (ORDER BY)

7.5. 行排序 (ORDER BY)
版本：
纠错本页面
搜索
目录导航
❮
❯
7.5. 行排序 (ORDER BY) #
在一个查询生成一个输出表之后（在处理完选择列表之后），还可以选择性地对它进行排序。如果没有选择排序，那么行将以未指定的顺序返回。 这时候的实际顺序将取决于扫描和连接计划类型以及行在磁盘上的顺序，但是肯定不能依赖这些东西。一种特定的顺序只能在显式地选择了排序步骤之后才能被保证。
ORDER BY子句指定了排序顺序：
SELECT select_list
FROM table_expression
ORDER BY sort_expression1 [ASC | DESC] [NULLS { FIRST | LAST }]
[, sort_expression2 [ASC | DESC] [NULLS { FIRST | LAST }] ...]
排序表达式可以是任何在查询的选择列表中合法的表达式。一个例子是：
SELECT a, b FROM table1 ORDER BY a + b, c;
当多于一个表达式被指定，后面的值将被用于排序那些在前面值上相等的行。每一个表达式后可以选择性地放置一个ASC或DESC关键词来设置排序方向为升序或降序。ASC顺序是默认值。升序会把较小的值放在前面，而“较小”则由<操作符定义。相似地，降序则由>操作符定义。
[6]
NULLS FIRST和NULLS LAST选项可以用来决定在排序顺序中，空值是出现在非空值之前还是出现在非空值之后。默认情况下，排序时空值被认为比任何非空值都要大，即NULLS FIRST是DESC顺序的默认值，而NULLS LAST是其他情况下的默认值。
注意顺序选项是对每一个排序列独立考虑的。例如ORDER BY x, y DESC表示ORDER BY x ASC, y DESC，而和ORDER BY x DESC, y DESC不同。
一个sort_expression也可以是列标签或者一个输出列的编号，如：
SELECT a + b AS sum, c FROM table1 ORDER BY sum;
SELECT a, max(b) FROM table1 GROUP BY a ORDER BY 1;
两者都根据第一个输出列排序。注意一个输出列的名字必须孤立，即它不能被用在一个表达式中 — 例如，这是不正确的：
SELECT a + b AS sum, c FROM table1 ORDER BY sum + c;          -- 错误
该限制是为了减少混淆。如果一个ORDER BY项是一个单一名字并且匹配一个输出列名或者一个表表达式的列，仍然会出现混淆。在这种情况中输出列将被使用。只有在你使用AS来重命名一个输出列来匹配某些其他表列的名字时，这才会导致混淆。
ORDER BY可以被应用于UNION、INTERSECT或EXCEPT组合的结果，但是在这种情况下它只被允许根据输出列名或编号排序，而不能根据表达式排序。
[6]
事实上，PostgreSQL为表达式的数据类型使用默认B-tree操作符类来决定ASC和DESC的排序顺序。照惯例，数据类型将被建立，这样<和>操作符负责这个排序顺序，但是一个用户定义的数据类型的设计者可以选择做些不同的设置。
上一页 上一级 下一页7.4. 组合查询 (UNION, INTERSECT, EXCEPT) 起始页 7.6. LIMIT和OFFSET
