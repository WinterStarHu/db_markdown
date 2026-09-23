# SELECT

SELECT
版本：
纠错本页面
搜索
目录导航
❮
❯
SELECTSELECT, TABLE, WITH — 从表或视图中检索行大纲
[ WITH [ RECURSIVE ] with_query [, ...] ]
SELECT [ ALL | DISTINCT [ ON ( expression [, ...] ) ] ]
[ { * | expression [ [ AS ] output_name ] } [, ...] ]
[ FROM from_item [, ...] ]
[ WHERE condition ]
[ GROUP BY [ ALL | DISTINCT ] grouping_element [, ...] ]
[ HAVING condition ]
[ WINDOW window_name AS ( window_definition ) [, ...] ]
[ { UNION | INTERSECT | EXCEPT } [ ALL | DISTINCT ] select ]
[ ORDER BY expression [ ASC | DESC | USING operator ] [ NULLS { FIRST | LAST } ] [, ...] ]
[ LIMIT { count | ALL } ]
[ OFFSET start [ ROW | ROWS ] ]
[ FETCH { FIRST | NEXT } [ count ] { ROW | ROWS } { ONLY | WITH TIES } ]
[ FOR { UPDATE | NO KEY UPDATE | SHARE | KEY SHARE } [ OF from_reference [, ...] ] [ NOWAIT | SKIP LOCKED ] [...] ]
其中 from_item 可以是以下之一：
[ ONLY ] table_name [ * ] [ [ AS ] alias [ ( column_alias [, ...] ) ] ]
[ TABLESAMPLE sampling_method ( argument [, ...] ) [ REPEATABLE ( seed ) ] ]
[ LATERAL ] ( select ) [ [ AS ] alias [ ( column_alias [, ...] ) ] ]
with_query_name [ [ AS ] alias [ ( column_alias [, ...] ) ] ]
[ LATERAL ] function_name ( [ argument [, ...] ] )
[ WITH ORDINALITY ] [ [ AS ] alias [ ( column_alias [, ...] ) ] ]
[ LATERAL ] function_name ( [ argument [, ...] ] ) [ AS ] alias ( column_definition [, ...] )
[ LATERAL ] function_name ( [ argument [, ...] ] ) AS ( column_definition [, ...] )
[ LATERAL ] ROWS FROM( function_name ( [ argument [, ...] ] ) [ AS ( column_definition [, ...] ) ] [, ...] )
[ WITH ORDINALITY ] [ [ AS ] alias [ ( column_alias [, ...] ) ] ]
from_item join_type from_item { ON join_condition | USING ( join_column [, ...] ) [ AS join_using_alias ] }
from_item NATURAL join_type from_item
from_item CROSS JOIN from_item
并且 grouping_element 可以是以下之一：
( )
expression
( expression [, ...] )
ROLLUP ( { expression | ( expression [, ...] ) } [, ...] )
CUBE ( { expression | ( expression [, ...] ) } [, ...] )
GROUPING SETS ( grouping_element [, ...] )
并且 with_query 是：
with_query_name [ ( column_name [, ...] ) ] AS [ [ NOT ] MATERIALIZED ] ( select | values | insert | update | delete | merge )
[ SEARCH { BREADTH | DEPTH } FIRST BY column_name [, ...] SET search_seq_col_name ]
[ CYCLE column_name [, ...] SET cycle_mark_col_name [ TO cycle_mark_value DEFAULT cycle_mark_default ] USING cycle_path_col_name ]
TABLE [ ONLY ] table_name [ * ]
描述
SELECT检索零个或多个表中的行。
SELECT的一般处理如下：
WITH列表中的所有查询都会被计算。
这些实际上充当临时表，可以在FROM列表中引用。
在FROM列表中多次引用的WITH查询只会计算一次，
除非使用NOT MATERIALIZED进行其他指定。
（参见下面的WITH Clause。）
所有FROM列表中的元素都会被计算。
（FROM列表中的每个元素都是一个真实或虚拟表。）
如果在FROM列表中指定了多个元素，则它们会被交叉连接在一起。
（参见下面的FROM Clause。）
如果指定了WHERE子句，则不满足条件的所有行将从输出中删除。
（参见下面的WHERE Clause。）
如果指定了GROUP BY子句，
或者存在聚合函数调用，
输出将合并为匹配一个或多个值的行组，
并计算聚合函数的结果。
如果存在HAVING子句，
它将消除不满足给定条件的组。（参见
GROUP BY Clause和
HAVING Clause。）
虽然查询输出列名义上是在下一步计算的，
但它们也可以在GROUP BY子句中被引用（按名称或序号）。
实际输出行是使用每个选定行或行组的SELECT输出表达式计算的。
（参见下面的SELECT List。）
SELECT DISTINCT消除结果中的重复行。
SELECT DISTINCT ON消除所有指定表达式匹配的行。
SELECT ALL（默认）将返回所有候选行，包括重复行。
（参见下面的DISTINCT Clause。）
使用运算符UNION、INTERSECT和EXCEPT，
可以将多个SELECT语句的输出合并成一个结果集。
UNION运算符返回在一个或两个结果集中的所有行。
INTERSECT运算符返回严格在两个结果集中的所有行。
EXCEPT运算符返回在第一个结果集中但不在第二个结果集中的行。
在这三种情况下，除非指定ALL，否则将消除重复行。
噪声词DISTINCT可以添加以明确指定消除重复行。
请注意，这里的默认行为是DISTINCT，即使SELECT本身的默认行为是ALL。
（参见下面的UNION Clause、INTERSECT Clause和EXCEPT Clause。）
如果指定了ORDER BY子句，则返回的行按指定顺序排序。
如果没有给出ORDER BY，系统将以最快速度返回行。
（参见下面的ORDER BY Clause。）
如果指定了LIMIT（或FETCH FIRST）或OFFSET子句，
SELECT语句只返回结果行的子集。（参见下面的LIMIT Clause。）
如果指定了FOR UPDATE、FOR NO KEY UPDATE、FOR SHARE
或FOR KEY SHARE，
SELECT语句将选定的行锁定，防止并发更新。（参见下面的The Locking Clause。）
你必须拥有在一个SELECT命令中使用的每一列上的
SELECT特权。FOR NO KEY UPDATE、
FOR UPDATE、
FOR SHARE或FOR KEY SHARE
还要求（对这样选中的每一个表至少一列的）UPDATE
特权。
参数WITH 子句
WITH 子句允许您指定一个或多个子查询，这些子查询可以在主查询中通过名称引用。
子查询在主查询执行期间实际上充当临时表或视图。
每个子查询可以是 SELECT、TABLE、VALUES、
INSERT、UPDATE、
DELETE 或 MERGE 语句。
在 WITH 中编写数据修改语句（INSERT、
UPDATE、DELETE 或 MERGE）时，
通常会包含一个 RETURNING 子句。
形成主查询读取的临时表的是 RETURNING 的输出，而非语句修改的底层表。
如果省略 RETURNING，语句仍会执行，但不会产生输出，因此主查询无法将其作为表引用。
对于每一个WITH查询，都必须指定一个名称（无需模式限定）。可选地，可以指定一个列名列表。如果省略该列表，会从该子查询中推导列名。
如果指定了RECURSIVE，则允许一个
SELECT子查询使用名称引用自身。
这样一个子查询的形式必须是
non_recursive_term UNION [ ALL | DISTINCT ] recursive_term
其中递归自引用必须出现在UNION的右手边。每个
查询中只允许一个递归自引用。不支持递归数据修改语句，但是
可以在一个数据查询语句中使用一个递归
SELECT查询的结果。例子可见
第 7.8 节。
RECURSIVE的另一个效果是
WITH查询不需要被排序：一个查询可以引用另一个
在列表中比它靠后的查询（不过，循环引用或者互递归没有实现）。
如果没有RECURSIVE，WITH
查询只能引用在WITH列表中位置更前面的兄弟
WITH查询。
当WITH子句中有多个查询时，RECURSIVE应只编写一次，紧跟在WITH之后。
它适用于WITH子句中的所有查询，尽管它对不使用递归或前向引用的查询没有影响。
可选的SEARCH子句计算一个搜索序列列，可用于按宽度优先或深度优先的顺序对递归查询的结果排序。
提供的列名列表指定用于保持跟踪已访问行的行键。
名为search_seq_col_name的列将被添加到WITH查询的结果列列表中。
这个列可以通过外部查询进行排序，以实现单独的排序。
示例请见第 7.8.2.1 节 。
可选的CYCLE子句用于检测递归查询中的循环。
提供的列名列表指定将用于保持跟踪访问的行的行键。
名为cycle_mark_col_name的列，将被添加到WITH查询的结果列的列表中。
当检测到循环时，此列将设置为cycle_mark_value，否则为cycle_mark_default。
此外，当检测到循环时，递归联合的处理将停止。
cycle_mark_value和cycle_mark_default必须是常量，并且它们必须被强制为公共数据类型，并且数据类型必须有一个不等运算符。
(SQL标准要求它们是布尔常量或字符串，但PostgreSQL不要求那样。)
默认为使用TRUE 和 FALSE (boolean类型)。
此外，名为cycle_path_col_name的列将被添加到WITH查询的结果列的列表中。
此列将用于跟踪访问的行的内部。
示例请参见第 7.8.2.2 节
SEARCH和CYCLE子句仅对递归WITH查询有效。
with_query必须是两个SELECT(或等效)命令(非嵌套UNION)的UNION(或UNION ALL)
如果同时使用两个子句，SEARCH子句添加的列出现在CYCLE子句添加的列之前。
主查询以及WITH查询全部（理论上）在同一时间
被执行。这意味着从该查询的任何部分都无法看到
WITH中的一个数据修改语句的效果，不过可以读
取其RETURNING输出。如果两个这样的数据修改语句
尝试修改相同的行，结果将无法确定。
WITH查询的一个关键属性是，即使主查询多次引用它们，它们通常每次执行主查询只计算一次。
特别是，数据修改语句确保执行一次而且只执行一次，而与主查询是否读取它们的全部或任何输出无关。
但是，WITH查询可以标记为NOT MATERIALIZED以移除此保证。
在这种情况下，WITH查询可以折叠到主查询中，就好像它是主查询的FROM子句中的简单的SELECT。
如果主查询多次引用WITH查询，则会导致重复计算;但是，如果每次此类使用只需要WITH查询的总输出中的几行，NOT MATERIALIZED可以通过允许查询联合优化来节省开销。
NOT MATERIALIZED被忽略，如果它被附加到一个递归的WITH查询，或者不是无副作用的（也就是说，不是包含非易失性函数的普通的SELECT）。
默认情况下，如果查询在主查询的FROM子句中仅一次使用，则无副作用的WITH查询将折叠到主查询中。
这允许在语义不可见的情况下两个查询级别的联合优化。 但是，通过将WITH查询标记为MATERIALIZED，可以防止此类折叠。
这可能很有用，例如，如果WITH查询被用作优化围栏，以防止规划者选择错误计划。
PostgreSQL版本之前没有做过这样的折叠，所以为旧版本编写的查询可能依赖于WITH作为优化围栏。
更多信息请见第 7.8 节。
FROM 子句
FROM 子句为SELECT
指定一个或多个源表。如果指定了多个源表，结果将是所有源表的
笛卡尔积（交叉连接）。但是通常会增加限定条件（通过
WHERE）来把返回的行限制为该笛卡尔积的一个小子集。
FROM 子句可以包含以下元素：
table_name
要扫描的现有表或视图的名称（可选模式限定符）。如果在表名之前指定ONLY，
则仅扫描该表。如果未指定ONLY，则扫描该表及其所有后代表（如果有）。
可选地，可以在表名后指定*，以明确指示包括后代表。
alias
一个替代名称，用于包含别名的FROM项。别名用于简洁或消除自连接（同一表被多次扫描）的歧义。
当提供别名时，它完全隐藏了表或函数的实际名称；例如给定FROM foo AS f，SELECT的其余部分必须引用此FROM项为f而不是foo。
如果写了一个别名，还可以写一个列别名列表，为表的一个或多个列提供替代名称。
TABLESAMPLE sampling_method ( argument [, ...] ) [ REPEATABLE ( seed ) ]
一个TABLESAMPLE子句在一个table_name之后指示应该使用指定的sampling_method来检索该表中的行的子集。这种抽样在应用任何其他过滤器之前进行，比如WHERE子句。标准的PostgreSQL发行版包括两种抽样方法，BERNOULLI和SYSTEM，其他抽样方法可以通过扩展安装在数据库中。
BERNOULLI和SYSTEM抽样方法
各接受一个argument
，即要抽样的表格比例，表示为0到100之间的百分比。
此参数可以是任何实数表达式。
（其他抽样方法可能接受更多或不同的参数。）
这两种方法各自返回表格的一个随机选择样本，该样本将包含
大约指定百分比的表格行。
BERNOULLI方法扫描整个表格，并
以指定概率独立选择或忽略单个行。
SYSTEM方法进行块级抽样，
每个块有指定的选择机会；返回每个选定块中的所有行。
当指定小的抽样百分比时，SYSTEM方法比
BERNOULLI方法快得多，但由于聚类效应，
可能返回表格的不太随机的样本。
可选的REPEATABLE子句指定用于在抽样方法中生成随机数的seed数或表达式。
种子值可以是任何非空浮点值。如果两个查询指定相同的种子和argument值，
则如果表在此期间未更改，则将选择相同的表样本。但是不同的种子值通常会产生不同的样本。
如果未给出REPEATABLE，则每个查询都会选择一个新的随机样本，基于系统生成的种子。
请注意，一些附加的抽样方法不接受REPEATABLE，并且在每次使用时总是生成新的样本。
select
子SELECT可以出现在FROM子句中。
这相当于其输出在此单个SELECT命令的持续时间内被创建为一个临时表。
请注意，子SELECT必须用括号括起来，并且可以像表一样提供别名。
此外，这里也可以使用
VALUES命令。
with_query_name
一个WITH查询通过写入它的名称来引用，就像查询的名称是表名一样。
（实际上，WITH查询为主查询隐藏了同名的任何真实表。
如果必要，您可以通过模式限定表的名称来引用同名的真实表。）
别名可以像表一样提供。
function_name
函数调用可以出现在FROM子句中。
（这对于返回结果集的函数特别有用，但任何函数都可以使用。）
这就好像函数的输出被创建为一个临时表，在这个单个SELECT命令的持续时间内。
如果函数的结果类型是复合的（包括具有多个OUT参数的情况），
每个属性都成为隐式表中的一个单独列。
当在函数调用中添加可选的WITH ORDINALITY子句时，
将会在函数的结果列后附加一个bigint类型的额外列。
该列对函数结果集的行进行编号，从1开始。
默认情况下，该列名为ordinality。
别名可以像表一样提供。如果写了别名，还可以编写列别名列表，
为函数的复合返回类型的一个或多个属性提供替代名称，包括存在的序号列。
多个函数调用可以通过用ROWS FROM( ... )括起来，
合并成一个单一的FROM-子句项。这样一个项的输出是每个函数的第一行连接在一起，
然后是每个函数的第二行，依此类推。如果某些函数产生的行数少于其他函数，
则用空值替换缺失的数据，以确保返回的行数总是与产生最多行的函数相同。
如果函数被定义为返回record数据类型，则必须存在一个别名或关键字AS，
后面跟着一个列定义列表，形式为( column_name
data_type [, ... ])。
列定义列表必须与函数返回的实际列数和类型匹配。
当使用ROWS FROM( ... )语法时，如果其中一个函数需要列定义列表，
最好将列定义列表放在函数调用后面ROWS FROM( ... )内部。只有在只有一个函数且没有
WITH ORDINALITY子句时，才能在ROWS FROM( ... )结构后放置列定义列表。
要在列定义列表中使用ORDINALITY，必须使用ROWS FROM( ... )语法，
并将列定义列表放在ROWS FROM( ... )内部。
join_type
其中之一是
[ INNER ] JOINLEFT [ OUTER ] JOINRIGHT [ OUTER ] JOINFULL [ OUTER ] JOIN
对于INNER和OUTER连接类型，必须指定连接条件，即
ON join_condition、
USING (join_column [, ...])，
或者NATURAL。请参见下文的含义。
一个JOIN子句结合了两个FROM项，为了方便起见，我们将其称为“表”，
虽然实际上它们可以是任何类型的FROM项。
如有必要，使用括号确定嵌套的顺序。
在没有括号的情况下，JOIN从左到右嵌套。
无论如何，JOIN比分隔FROM列表项的逗号更紧密。
所有JOIN选项只是一种表示上的便利，因为它们并没有做任何你不能用普通的FROM和WHERE做的事情。
LEFT OUTER JOIN返回符合连接条件的所有行的笛卡尔积（即，通过连接条件的所有组合行），以及左表中每一行的一个副本，对于这些行，右表中没有通过连接条件的行。这个左表行通过在右表列中插入空值来扩展到连接表的完整宽度。请注意，只有JOIN子句的条件在决定哪些行有匹配时才会被考虑。外部条件在之后应用。
相反，RIGHT OUTER JOIN返回所有连接的行，再加上每个未匹配的右侧行的一行
（在左侧扩展为null）。这只是一种符号上的便利，因为你可以通过交换左右表将其转换为LEFT
OUTER JOIN。
FULL OUTER JOIN返回所有连接的行，以及每个未匹配的左侧行（右侧扩展为null），以及每个未匹配的右侧行（左侧扩展为null）。ON join_conditionjoin_condition是一个表达式，其结果为boolean类型的值（类似于WHERE子句），指定哪些连接中的行被认为是匹配的。USING ( join_column [, ...] ) [ AS join_using_alias ]
一个形如USING ( a, b, ... )的子句是ON left_table.a = right_table.a AND
left_table.b = right_table.b ...的简写。此外，
USING意味着只有每对等价列中的一个会包含在连接输出中，而不是两者都包含。
如果指定了一个join_using_alias名称，
它为连接列提供了一个表别名。只有在USING子句中列出的连接列可以通过此名称访问。
与常规alias不同，这不会隐藏连接表的名称。
与常规alias也不同，您不能编写列别名列表 —— 连接列的输出名称与它们在USING列表中出现的名称相同。
NATURAL
NATURAL是一个简写，表示一个包含两个表中所有具有相同名称的列的USING列表。
如果没有共同的列名，NATURAL等同于ON TRUE。
CROSS JOIN
CROSS JOIN等同于INNER JOIN ON (TRUE)，
也就是说，没有任何行被条件限制删除。它们产生一个简单的笛卡尔积，
与在FROM的顶层列出两个表时得到的结果相同，
但受连接条件（如果有）的限制。
LATERAL
LATERAL关键字可以在子SELECT FROM项之前出现。
这允许子SELECT引用在FROM列表中出现在其前面的FROM项的列。
（没有LATERAL，每个子SELECT都是独立评估的，因此不能交叉引用任何其他FROM项。）
LATERAL也可以在函数调用FROM项之前出现，但在这种情况下，它是一个噪音词，因为函数表达式可以在任何情况下引用先前的FROM项。
一个LATERAL项可以出现在FROM列表的顶层，或者在JOIN树中。
在后一种情况下，它还可以引用任何在它右侧的JOIN左侧的项。
当FROM项包含LATERAL交叉引用时，评估过程如下：
对于提供交叉引用列的FROM项的每一行，或者提供列的多个FROM项的一组行，
使用该行或行集的列的值来评估LATERAL项。得到的行将像往常一样与计算出它们的行连接。
对来自列源表的每一行或一组行重复此过程。
列源表必须与INNER或LEFT连接到LATERAL项，
否则将无法从中计算每个LATERAL项的行集。因此，尽管像
X RIGHT JOIN LATERAL Y
这样的结构在语法上是有效的，但实际上不允许Y引用X。
WHERE 子句
可选的WHERE子句的形式
WHERE condition
其中condition
是任一计算得到boolean类型结果的表达式。任何不满足
这个条件的行都会从输出中被消除。如果用一行的实际值替换其中的
变量引用后，该表达式返回真，则该行符合条件。
GROUP BY 子句
可选的GROUP BY子句的形式
GROUP BY [ ALL | DISTINCT ] grouping_element [, ...]
GROUP BY将会把所有被选择的行中共享相同分组表达式
值的那些行压缩成一个行。一个被用在
grouping_element中的
expression可以是输入列名、输出列
（SELECT列表项）的名称或序号或者由输入列
值构成的任意表达式。在出现歧义时，GROUP BY名称
将被解释为输入列名而不是输出列名。
如果任何GROUPING SETS、ROLLUP或者CUBE作为分组元素存在，则GROUP BY子句整体上定义了数个独立的分组集。
其效果等效于在子查询间构建一个UNION ALL，子查询带有分组集作为它们的GROUP BY子句。
在处理前可选的DISTINCT子句移除重复集合；它不做UNION ALL到UNION DISTINCT的转换。
处理分组集的进一步细节请见第 7.2.4 节。
聚合函数（如果使用）会在组成每一个分组的所有行上进行计算，从而为每
一个分组产生一个单独的值（如果有聚合函数但是没有
GROUP BY子句，则查询会被当成是由所有选中行构成
的一个单一分组）。传递给每一个聚合函数的行集合可以通过在聚合函数调
用附加一个FILTER子句来进一步过滤，详见
第 4.2.7 节。当存在一个
FILTER子句时，只有那些匹配它的行才会被包括在该聚
合函数的输入中。
当存在GROUP BY子句或者任何聚合函数时，
SELECT列表表达式不能引用非分组列（除非它
出现在聚合函数中或者它函数依赖于分组列），因为这样做会导致返回
非分组列的值时会有多种可能的值。如果分组列是包含非分组列的表的主键（
或者主键的子集），则存在函数依赖。
记住所有的聚合函数都是在HAVING子句或者
SELECT列表中的任何“标量”表达式之前被计算。
这意味着一个CASE表达式不能被用来跳过一个聚合函数的
计算，见第 4.2.14 节。
当前，FOR NO KEY UPDATE、FOR UPDATE、
FOR SHARE和FOR KEY SHARE不能和
GROUP BY一起指定。
HAVING 子句
可选的HAVING子句的形式
HAVING condition
其中condition与
WHERE子句中指定的条件相同。
HAVING消除不满足该条件的分组行。
HAVING与WHERE不同：
WHERE会在应用GROUP
BY之前过滤个体行，而HAVING过滤由
GROUP BY创建的分组行。
condition中引用
的每一个列必须无歧义地引用一个分组列（除非该引用出现在一个聚合
函数中或者该非分组列函数依赖于分组列）。
即使没有GROUP BY子句，HAVING
的存在也会把一个查询转变成一个分组查询。这和查询中包含聚合函数但没有
GROUP BY子句时的情况相同。所有被选择的行都被认为是一个
单一分组，并且SELECT列表和
HAVING子句只能引用聚合函数中的表列。如果该
HAVING条件为真，这样一个查询将会发出一个单一行；
否则不返回行。
当前，FOR NO KEY UPDATE、FOR UPDATE、
FOR SHARE和FOR KEY SHARE不能与
HAVING一起指定。
WINDOW 子句
可选的WINDOW子句的形式
WINDOW window_name AS ( window_definition ) [, ...]
其中window_name
是一个可以从OVER子句或
后续窗口定义中引用的名称，window_definition是
[ existing_window_name ]
[ PARTITION BY expression [, ...] ]
[ ORDER BY expression [ ASC | DESC | USING operator ] [ NULLS { FIRST | LAST } ] [, ...] ]
[ frame_clause ]
如果指定了一个existing_window_name，
它必须引用WINDOW列表中一个更早出现的项；新窗口将从
该项中复制它的划分子句以及排序子句（如果有）。在这种情况下，新窗口
不能指定它自己的PARTITION BY子句，并且它只能在被复制
窗口没有ORDER BY的情况下指定该子句。新窗口总是使用它
自己的帧子句，被复制的窗口不必指定一个帧子句。
PARTITION BY列表元素的解释以
GROUP BY子句元素的方式
进行，不过它们总是简单表达式并且绝不能是输出列的名称或编号。另一个区
别是这些表达式可以包含聚合函数调用，而这在常规GROUP BY
子句中是不被允许的。它们被允许的原因是窗口是在分组和聚合之后进行的。
类似地，ORDER BY列表元素的解释也以语句级
ORDER BY子句元素的方式进行，
不过该表达式总是被当做简单表达式并且绝不会是输出列的名称或编号。
可选的frame_clause为依赖帧的窗口函数
定义窗口帧（并非所有窗口函数都依赖于帧）。窗口帧是查询中
每一行（称为当前行）的相关行的集合。
frame_clause可以是
{ RANGE | ROWS | GROUPS } frame_start [ frame_exclusion ]
{ RANGE | ROWS | GROUPS } BETWEEN frame_start AND frame_end [ frame_exclusion ]
之一，其中frame_start和frame_end可以是
UNBOUNDED PRECEDING
offset PRECEDING
CURRENT ROW
offset FOLLOWING
UNBOUNDED FOLLOWING
之一，并且frame_exclusion可以是
EXCLUDE CURRENT ROW
EXCLUDE GROUP
EXCLUDE TIES
EXCLUDE NO OTHERS
之一。如果省略frame_end，它会被默认为CURRENT
ROW。限制是：
frame_start不能是UNBOUNDED FOLLOWING，
frame_end不能是UNBOUNDED PRECEDING，
并且frame_end的选择在上面frame_start
和frame_end选项的列表中不能早于
frame_start的选择 — 例如
RANGE BETWEEN CURRENT ROW AND offset
PRECEDING是不被允许的。
默认的帧选项是RANGE UNBOUNDED PRECEDING，
它和RANGE BETWEEN UNBOUNDED PRECEDING AND
CURRENT ROW相同；它把帧设置为从分区开始
直到当前行的最后一个平级（被窗口的ORDER BY子句认为
等价于当前行；如果没有ORDER BY，则所有的行都是平级的）。
通常，UNBOUNDED PRECEDING表示帧从分区的第一行开始，类似地
UNBOUNDED FOLLOWING表示帧以分区的最后一行结束，无论是
RANGE、ROWS还是GROUPS模式。
在ROWS模式中，CURRENT ROW表示
帧以当前行开始或结束；但在RANGE或GROUPS模式中，它表示
帧以当前行的第一个或最后一个平级行开始或结束
在ORDER BY排序中。
offset PRECEDING和
offset FOLLOWING选项
的含义会根据帧模式而变化。
在ROWS模式中，offset
是一个整数，表示帧开始或结束于当前行之前或之后的那么多行。
在GROUPS模式中，offset
是一个整数，表示帧开始或结束于当前行的平级组之前或之后的那么多个平级组，其中
平级组是一组根据窗口的ORDER BY子句等效的行。
在RANGE模式中，使用
offset选项要求窗口定义中必须有
正好一个ORDER BY列。
然后帧包含那些排序列值不超过offset且
小于（对于PRECEDING）或大于（对于FOLLOWING）当前行的排序列
值的行。在这些情况下，offset表达式的数据类型取决于
排序列的数据类型。对于数字排序列，它通常与排序列是相同类型，但对于日期时间
排序列，它是interval。
在所有这些情况下，offset的值必须是非空和非负的。此外，
虽然offset不必是简单常量，但它不能包含变量、聚合函数或窗口
函数。
frame_exclusion选项允许从帧中排除当前行周围的行，即便它们根据帧的起始和结束选项来说应该被包含在帧中。EXCLUDE CURRENT ROW把当前行从帧中排除。EXCLUDE GROUP把当前行和它在排序上的平级行从帧中排除。EXCLUDE TIES从帧中排除当前行的任何平级行，但不排除当前行本身。EXCLUDE NO OTHERS只是明确地指定不排除当前行或其平级行的默认行为。
注意，如果ORDER BY排序无法把行唯一地排序，则ROWS模式可能产生不可预测的结果。RANGE和GROUPS模式的目的是确保在ORDER BY顺序中平级的行被同样对待：一个给定平级组中的所有行将在一个帧中或者被从帧中排除。
WINDOW子句的目的是指定出现在查询的
SELECT list或
ORDER BY子句中的
窗口函数的行为。这些函数可以在它们的
OVER子句中用名称引用WINDOW
子句项。不过，WINDOW子句项不是必须被引用。
如果在查询中没有用到它，它会被简单地忽略。可以使用根本没有任何
WINDOW子句的窗口函数，因为窗口函数调用可
以直接在其OVER子句中指定它的窗口定义。不过，当多
个窗口函数都需要相同的窗口定义时，
WINDOW子句能够减少输入。
当前，FOR NO KEY UPDATE、FOR UPDATE、
FOR SHARE和FOR KEY SHARE不能和
WINDOW一起被指定。
窗口函数的详细描述在
第 3.5 节、
第 4.2.8 节以及
第 7.2.5 节中。
SELECT 列表
SELECT列表（位于关键词
SELECT和FROM之间）指定构成
SELECT语句输出行的表达式。这些表达式
可以（并且通常确实会）引用FROM子句中计算得到的列。
正如在表中一样，SELECT的每一个输出列都有一个名称。
在一个简单的SELECT中，这个名称只是被用来标记要显
示的列，但是当SELECT是一个大型查询的一个子查询时，大型查询
会把该名称看做子查询产生的虚表的列名。要指定用于输出列的名称，在该列的表达式
后面写上
AS output_name（
你可以省略AS，但只能在期望的输出名称不匹配任何
PostgreSQL关键词（见附录 C）时省略。为了避免和未来增加的关键词冲突，
推荐总是写上AS或者用双引号引用输出名称）。如果你不指定列名，
PostgreSQL会自动选择一个名称。如果列的表达式
是一个简单的列引用，那么被选择的名称就和该列的名称相同。在使用函数或者类型名称
的更复杂的情况中，系统可能会生成诸如
?column?之类的名称。
一个输出列的名称可以被用来在ORDER BY以及
GROUP BY子句中引用该列的值，但是不能用于
WHERE和HAVING子句（在其中
必须写出表达式）。
可以在输出列表中写*来取代表达式，它是被选中
行的所有列的一种简写方式。还可以写
table_name.*，它
是只来自那个表的所有列的简写形式。在这些情况中无法用
AS指定新的名称，输出列的名称将和表列的名称相同。
根据 SQL 标准，输出列表中的表达式应该在应用DISTINCT、ORDER BY或者LIMIT之前计算。在使用DISTINCT时显然必须这样做，否则就无法搞清到底在区分什么值。不过，在很多情况下如果先计算ORDER BY和LIMIT再计算输出表达式会很方便，特别是如果输出列表中包含任何 volatile 或者代价昂贵的函数时尤其如此。通过这种行为，函数计算的顺序更加直观并且对于从未出现在输出中的行将不会进行计算。只要输出表达式没有被DISTINCT、ORDER BY或者GROUP BY引用，PostgreSQL实际将在排序和限制行数之后计算输出表达式（作为一个反例，SELECT f(x) FROM tab ORDER BY 1显然必须在排序之前计算f(x)）。包含有集合返回函数的输出表达式实际是在排序之后和限制行数之前被计算，这样LIMIT才能切断来自集合返回函数的输出。
注意
9.6 版本之前的PostgreSQL不对执行输出表达式、排序、限制行数的时间顺序做任何保证，那将取决于被选中的查询计划的形式。
DISTINCT 子句
如果指定了SELECT DISTINCT，所有重复的行会被从结果
集中移除（为每一组重复的行保留一行）。SELECT ALL则
指定相反的行为：所有行都会被保留，这也是默认情况。
SELECT DISTINCT ON ( expression [, ...] )
只保留在给定表达式上计算相等的行集合中的第一行。
DISTINCT ON表达式使用和
ORDER BY相同的规则（见上文）解释。注意，除非用
ORDER BY来确保所期望的行出现在第一位，每一个集
合的“第一行”是不可预测的。例如：
SELECT DISTINCT ON (location) location, time, report
FROM weather_reports
ORDER BY location, time DESC;
为每个地点检索最近的天气报告。但是如果我们不使用
ORDER BY来强制对每个地点的时间值进行降序排序，
我们为每个地点得到的报告的时间可能是无法预测的。
DISTINCT ON表达式必须匹配最左边的
ORDER BY表达式。ORDER BY子句通常
将包含额外的表达式，这些额外的表达式用于决定在每一个
DISTINCT ON分组内行的优先级。
当前，FOR NO KEY UPDATE、FOR UPDATE、
FOR SHARE和FOR KEY SHARE不能和
DISTINCT一起使用。
UNION 子句
UNION子句具有下面的形式：
select_statement UNION [ ALL | DISTINCT ] select_statement
select_statement
是任何没有ORDER BY、LIMIT、
FOR NO KEY UPDATE、FOR UPDATE、
FOR SHARE和FOR KEY SHARE子句的
SELECT语句（如果子表达式被包围在圆括号内，
ORDER BY和LIMIT可以被附着到其上。如果没有
圆括号，这些子句将被应用到UNION的结果而不是右侧
的表达式上）。
UNION操作符计算所涉及的
SELECT语句所返回的行的并集。如果一行
至少出现在两个结果集中的一个内，它就会在并集中。作为
UNION两个操作数的
SELECT语句必须产生相同数量的列并且
对应位置上的列必须具有兼容的数据类型。
UNION的结果不会包含重复行，除非指定了
ALL选项。ALL会阻止消除重复（因此，
UNION ALL通常显著地快于UNION，
尽量使用ALL）。可以写DISTINCT来
显式地指定消除重复行的行为。
除非用圆括号指定计算顺序，
同一个SELECT语句中的多个
UNION操作符会从左至右计算。
当前，FOR NO KEY UPDATE、FOR UPDATE、
FOR SHARE和
FOR KEY SHARE不能用于UNION结果或者
UNION的任何输入。
INTERSECT 子句
INTERSECT子句具有下面的形式：
select_statement INTERSECT [ ALL | DISTINCT ] select_statement
select_statement
是任何没有ORDER
BY、LIMIT、FOR NO KEY UPDATE、FOR UPDATE、
FOR SHARE以及FOR KEY SHARE子句的
SELECT语句。
INTERSECT操作符计算所涉及的
SELECT语句返回的行的交集。如果
一行同时出现在两个结果集中，它就在交集中。
INTERSECT的结果不会包含重复行，除非指定了
ALL选项。如果有ALL，一个在左表中有
m次重复并且在右表中有n
次重复的行将会在结果中出现
min(m,n) 次。
DISTINCT可以写来显式地指定消除重复行的行为。
除非用圆括号指定计算顺序，
同一个SELECT语句中的多个
INTERSECT操作符会从左至右计算。
INTERSECT的优先级比
UNION更高。也就是说，
A UNION B INTERSECT
C将被读成A UNION (B INTERSECT
C)。
当前，FOR NO KEY UPDATE、FOR UPDATE、
FOR SHARE和
FOR KEY SHARE不能用于INTERSECT结果或者
INTERSECT的任何输入。
EXCEPT 子句
EXCEPT子句具有下面的形式：
select_statement EXCEPT [ ALL | DISTINCT ] select_statement
select_statement是
任何没有ORDER BY、LIMIT、FOR NO KEY UPDATE、FOR UPDATE、
FOR SHARE以及FOR KEY SHARE子句的
SELECT语句。
EXCEPT操作符计算位于左
SELECT语句的结果中但不在右
SELECT语句结果中的行集合。
EXCEPT的结果不会包含重复行，除非指定了
ALL选项。如果有ALL，一个在左表中有
m次重复并且在右表中有
n次重复的行将会在结果集中出现
max(m-n,0) 次。
DISTINCT可以写来显式地指定消除重复行的行为。
除非用圆括号指定计算顺序，
同一个SELECT语句中的多个
EXCEPT操作符会从左至右计算。
EXCEPT的优先级与
UNION相同。
当前，FOR NO KEY UPDATE、FOR UPDATE、
FOR SHARE和
FOR KEY SHARE不能用于EXCEPT结果或者
EXCEPT的任何输入。
ORDER BY 子句
可选的ORDER BY子句的形式如下：
ORDER BY expression [ ASC | DESC | USING operator ] [ NULLS { FIRST | LAST } ] [, ...]
ORDER BY子句导致结果行被按照指定的表达式排序。
如果两行按照最左边的表达式是相等的，则会根据下一个表达式比较它们，
依次类推。如果按照所有指定的表达式它们都是相等的，则它们被返回的
顺序取决于实现。
每一个expression
可以是输出列（SELECT列表项）的名称或
序号，它也可以是由输入列值构成的任意表达式。
序号指的是输出列的顺序（从左至右）位置。这种特性可以为不具有唯一
名称的列定义一个顺序。这不是绝对必要的，因为总是可以使用
AS子句为输出列赋予一个名称。
也可以在ORDER BY子句中使用任意表达式，包括没
有出现在SELECT输出列表中的列。因此，
下面的语句是合法的：
SELECT name FROM distributors ORDER BY code;
这种特性的一个限制是一个应用在UNION、
INTERSECT或EXCEPT子句结果上的
ORDER BY只能指定输出列名称或序号，但不能指定表达式。
如果一个ORDER BY表达式是一个既匹配输出列名称又匹配
输入列名称的简单名称，ORDER BY将把它解读成输出列名称。
这与在同样情况下GROUP BY会做出的选择相反。这种
不一致是为了与 SQL 标准兼容。
可以为ORDER BY子句中的任何表达式之后增加关键词
ASC（升序）或DESC（降序）。如果没有指定，
ASC被假定为默认值。或者，可以在USING
子句中指定一个特定的排序操作符名称。一个排序操作符必须是某个
B-树操作符族的小于或者大于成员。ASC通常等价于
USING <而DESC通常等价于
USING >（但是一种用户定义数据类型的创建者可以
准确地定义默认排序顺序是什么，并且它可能会对应于其他名称的操作符）。
如果指定NULLS LAST，空值会排在所有非空值之后；如果指定
NULLS FIRST，空值会排在所有非空值之前。如果都没有指定，
在指定或隐含ASC时的默认行为是NULLS LAST，
而在指定或隐含DESC时的默认行为是
NULLS FIRST（因此，默认行为是空值大于非空值）。
当指定USING时，默认的空值顺序取决于该操作符是否为
小于或者大于操作符。
注意顺序选项只应用到它们所跟随的表达式上。例如
ORDER BY x, y DESC和
ORDER BY x DESC, y DESC是不同的。
字符串数据会根据引用到被排序列上的排序规则进行排序。根据需要可以通过在
expression中包括一个
COLLATE子句来覆盖，例如
ORDER BY mycolumn COLLATE "en_US"。更多信息请见
第 4.2.10 节和
第 23.2 节。
LIMIT 子句
LIMIT子句由两个独立的子句构成：
LIMIT { count | ALL }
OFFSET start
参数count指定要返回
的最大行数，而start
指定在返回行之前要跳过的行数。在两者都被指定时，在开始计算要返回的
count行之前会跳过
start行。
如果count表达式计算
为 NULL，它会被当成LIMIT ALL，即没有限制。如果
start计算为
NULL，它会被当作OFFSET 0。
SQL:2008 引入了一种不同的语法来达到相同的结果，
PostgreSQL也支持它：
OFFSET start { ROW | ROWS }
FETCH { FIRST | NEXT } [ count ] { ROW | ROWS } { ONLY | WITH TIES }
在这种语法中，标准要求start或count是一个文本常量、一个参数或者一个变量名；
而作为一种PostgreSQL的扩展，还允许其他的表达式，但通常需要被封闭在圆括号中以避免歧义。
如果在一个FETCH子句中省略count，它的默认值为 1。
WITH TIES选项用于返回在结果集中根据ORDER BY子句排序后与最后一名并列的任何额外行；ORDER BY在这种情况下是强制性的，并且SKIP LOCKED是不被允许的。
ROW和ROWS以及FIRST和NEXT是噪声词，它们不影响这些子句的效果。
根据标准，如果都存在，OFFSET子句必须出现在FETCH子句之前；
但是PostgreSQL更宽松，它允许两种顺序。
在使用LIMIT时，用一个ORDER BY子句把
结果行约束到一个唯一顺序是个好办法。否则你将得到该查询结果行的
一个不可预测的子集 — 你可能要求从第 10 到第 20 行，但是在
什么顺序下的第 10 到第 20 呢？除非指定ORDER BY，你
是不知道顺序的。
查询规划器在生成一个查询计划时会考虑LIMIT，因此
根据你使用的LIMIT和OFFSET，你很可能
得到不同的计划（得到不同的行序）。所以，使用不同的
LIMIT/OFFSET值来选择一个查询结果的
不同子集将会给出不一致的结果，除非你
用ORDER BY强制一种可预测的结果顺序。这不是一个
缺陷，它是 SQL 不承诺以任何特定顺序（除非使用
ORDER BY来约束顺序）给出一个查询结果这一事实造
成的必然后果。
如果没有一个ORDER BY来强制选择一个确定的子集，
重复执行同样的LIMIT查询甚至可能会返回一个表中行
的不同子集。同样，这也不是一种缺陷，在这种情况下也无法
保证结果的确定性。
锁定子句
FOR UPDATE、FOR NO KEY UPDATE、
FOR SHARE和FOR KEY SHARE
是锁定子句，它们影响SELECT
把行从表中取得时如何对它们加锁。
锁定子句的一般形式为
FOR lock_strength [ OF from_reference [, ...] ] [ NOWAIT | SKIP LOCKED ]
其中 lock_strength 可以是以下之一
UPDATE
NO KEY UPDATE
SHARE
KEY SHARE
from_reference 必须是一个表的
alias 或非隐藏的
table_name，该名称在
FROM 子句中被引用。有关每种行级锁模式的更多信息，
请参阅 第 13.3.2 节。
为了防止该操作等待其他事务提交，可使用NOWAIT或者SKIP LOCKED选项。
使用NOWAIT时，如果选中的行不能被立即锁定，该语句会报告错误而不是等待。
使用 SKIP LOCKED时，无法被立即锁定的任何选中行都会被跳过。
跳过已锁定行会提供数据的一个不一致的视图，因此这不适合于一般目的的工作，但是可以被用来避免多个用户访问一个类似队列的表时出现锁竞争。
注意NOWAIT和SKIP LOCKED只适合行级锁 — 所要求的ROW SHARE表级锁仍然会以常规的方式（见第 13 章）取得。
如果想要不等待的表级锁，你可以先使用带NOWAIT的LOCK。
如果在一个锁定子句中提到了特定的表，则只有来自于那些表的
行会被锁定，任何SELECT中用到的
其他表还是被简单地照常读取。一个没有表列表的锁定子句会影响
该语句中用到的所有表。如果一个锁定子句被应用到一个视图或者
子查询，它会影响在该视图或子查询中用到的所有表。不过，这些
子句不适用于主查询引用的WITH查询。如果你希望
在一个WITH查询中发生行锁定，应该在该
WITH查询内指定一个锁定子句。
如果有必要对不同的表指定不同的锁定行为，可以写多个锁定子句。
如果同一个表在多于一个锁定子句中被提到（或者被隐式影响），
那么会按照所指定的最强的锁定行为来处理它。类似地，如果在任何
影响一个表的子句中指定了NOWAIT，就会按照
NOWAIT的行为来处理该表。否则如果
SKIP LOCKED在任何影响该表的子句中被指定，
该表就会被按照SKIP LOCKED来处理。
如果被返回的行无法清晰地与表中的行对应，则不能使用锁定子句。
例如，锁定子句不能与聚合一起使用。
当一个锁定子句出现在一个SELECT查询的顶层时，
被锁定的行正好就是该查询返回的行。在连接查询的情况下，被锁定
的行是那些对返回的连接行有贡献的行。此外，自该查询的快照起满足
查询条件的行将被锁定，如果它们在该快照后被更新并且不再满足
查询条件，它们将不会被返回。如果使用了LIMIT，只要
已经返回的行数满足了限制，锁定就会停止（但注意被
OFFSET跳过的行将被锁定）。类似地，如果在一个游标
的查询中使用锁定子句，只有被该游标实际取出或者跳过的行才将被
锁定。
当一个锁定子句出现在一个子-SELECT中时，被锁定
行是那些该子查询返回给外层查询的行。这些被锁定的行的数量可能比
从子查询自身的角度看到的要少，因为来自外层查询的条件可能会被用
来优化子查询的执行。例如：
SELECT * FROM (SELECT * FROM mytable FOR UPDATE) ss WHERE col1 = 5;
将只锁定具有col1 = 5的行（虽然在子查询中并没有写上
该条件）。
早前的版本无法维持一个被之后的保存点升级的锁。例如，这段代码：
BEGIN;
SELECT * FROM mytable WHERE key = 1 FOR UPDATE;
SAVEPOINT s;
UPDATE mytable SET ... WHERE key = 1;
ROLLBACK TO s;
在ROLLBACK TO之后将无法维持
FOR UPDATE锁。在 9.3 中已经修复这个问题。
小心
一个运行在READ COMMITTED事务隔离级别并且使用
ORDER BY和锁定子句的SELECT命令有可能返回无序的行。
这是因为ORDER BY会被首先应用。该命令对结果排序，但是可能
接着在尝试获得一个或者多个行上的锁时阻塞。一旦SELECT解除
阻塞，某些排序列值可能已经被修改，从而导致那些行变成无序的（尽管它们根
据原始列值是有序的）。根据需要，可以通过在子查询中放置
FOR UPDATE/SHARE来解决这个问题，例如
SELECT * FROM (SELECT * FROM mytable FOR UPDATE) ss ORDER BY column1;
注意这将导致锁定mytable的所有行，而顶层的
FOR UPDATE只会锁定实际被返回的行。这可能会导致显著的
性能差异，特别是把ORDER BY与LIMIT或者其他
限制组合使用时。因此只有在并发更新排序列并且要求严格的排序结果时才推荐
使用这种技术。
在REPEATABLE READ或SERIALIZABLE事务隔离级别下，
这将导致序列化失败（带有SQLSTATE为'40001'），
因此在这些隔离级别下不可能接收到无序的行。
TABLE 命令
命令
TABLE name
等价于
SELECT * FROM name
它可以被用作一个顶层命令，或者用在复杂查询中以节省空间。只有
WITH、
UNION、INTERSECT、EXCEPT、
ORDER BY、LIMIT、OFFSET、
FETCH以及FOR锁定子句可以用于
TABLE。不能使用WHERE子句和任何形式
的聚集。
示例
要将表films与表distributors连接：
SELECT f.title, f.did, d.name, f.date_prod, f.kind
FROM distributors d JOIN films f USING (did);
title       | did |     name     | date_prod  |   kind
-------------------+-----+--------------+------------+----------
The Third Man     | 101 | British Lion | 1949-12-23 | Drama
The African Queen | 101 | British Lion | 1951-08-11 | Romantic
...
要对所有电影的len列求和并且用
kind对结果分组：
SELECT kind, sum(len) AS total FROM films GROUP BY kind;
kind   | total
----------+-------
Action   | 07:34
Comedy   | 02:58
Drama    | 14:28
Musical  | 06:42
Romantic | 04:38
要对所有电影的len列求和、对结果按照
kind分组并且显示总长小于 5 小时的分组：
SELECT kind, sum(len) AS total
FROM films
GROUP BY kind
HAVING sum(len) < interval '5 hours';
kind   | total
----------+-------
Comedy   | 02:58
Romantic | 04:38
下面两个例子都是根据第二列（name）的内容来排序结果：
SELECT * FROM distributors ORDER BY name;
SELECT * FROM distributors ORDER BY 2;
did |       name
-----+------------------
109 | 20th Century Fox
110 | Bavaria Atelier
101 | British Lion
107 | Columbia
102 | Jean Luc Godard
113 | Luso films
104 | Mosfilm
103 | Paramount
106 | Toho
105 | United Artists
111 | Walt Disney
112 | Warner Bros.
108 | Westward
接下来的例子展示了如何得到表distributors和
actors的并集，把结果限制为那些在每个表中以
字母 W 开始的行。只想要可区分的行，因此省略了关键词
ALL。
distributors:               actors:
did |     name              id |     name
-----+--------------        ----+----------------
108 | Westward               1 | Woody Allen
111 | Walt Disney            2 | Warren Beatty
112 | Warner Bros.           3 | Walter Matthau
...                         ...
SELECT distributors.name
FROM distributors
WHERE distributors.name LIKE 'W%'
UNION
SELECT actors.name
FROM actors
WHERE actors.name LIKE 'W%';
name
----------------
Walt Disney
Walter Matthau
Warner Bros.
Warren Beatty
Westward
Woody Allen
这个例子展示了如何在FROM子句中使用函数，
分别使用和不使用列定义列表：
CREATE FUNCTION distributors(int) RETURNS SETOF distributors AS $$
SELECT * FROM distributors WHERE did = $1;
$$ LANGUAGE SQL;
SELECT * FROM distributors(111);
did |    name
-----+-------------
111 | Walt Disney
CREATE FUNCTION distributors_2(int) RETURNS SETOF record AS $$
SELECT * FROM distributors WHERE did = $1;
$$ LANGUAGE SQL;
SELECT * FROM distributors_2(111) AS (f1 int, f2 text);
f1  |     f2
-----+-------------
111 | Walt Disney
这里是带有增加的序数列的函数的例子：
SELECT * FROM unnest(ARRAY['a','b','c','d','e','f']) WITH ORDINALITY;
unnest | ordinality
--------+----------
a      |        1
b      |        2
c      |        3
d      |        4
e      |        5
f      |        6
(6 rows)
这个示例展示了如何使用简单的WITH子句：
WITH t AS (
SELECT random() as x FROM generate_series(1, 3)
)
SELECT * FROM t
UNION ALL
SELECT * FROM t;
x
--------------------
0.534150459803641
0.520092216785997
0.0735620250925422
0.534150459803641
0.520092216785997
0.0735620250925422
注意WITH查询只被评估一次，所以我们得到了两组相同的三个随机值。
这个例子使用WITH RECURSIVE从一个只显示
直接下属的表中寻找雇员 Mary
的所有下属（直接的或者间接的）以及他们的间接层数：
WITH RECURSIVE employee_recursive(distance, employee_name, manager_name) AS (
SELECT 1, employee_name, manager_name
FROM employee
WHERE manager_name = 'Mary'
UNION ALL
SELECT er.distance + 1, e.employee_name, e.manager_name
FROM employee_recursive er, employee e
WHERE er.employee_name = e.manager_name
)
SELECT distance, employee_name FROM employee_recursive;
注意这种递归查询的典型形式：一个初始条件，后面跟着
UNION，然后是查询的递归部分。要确保
查询的递归部分最终将不返回任何行，否则该查询将无限循环（
更多例子见第 7.8 节）。
这个例子使用LATERAL为manufacturers
表的每一行应用一个集合返回函数get_product_names()：
SELECT m.name AS mname, pname
FROM manufacturers m, LATERAL get_product_names(m.id) pname;
当前没有任何产品的制造商不会出现在结果中，因为这是一个内连接。
如果我们希望把这类制造商的名称包括在结果中，我们可以：
SELECT m.name AS mname, pname
FROM manufacturers m LEFT JOIN LATERAL get_product_names(m.id) pname ON true;
兼容性
当然，SELECT语句是兼容 SQL 标准的。
但是也有一些扩展和缺失的特性。
省略的FROM子句
PostgreSQL允许我们省略
FROM子句。一种简单的使用是计算简单表达式
的结果：
SELECT 2+2;
?column?
----------
4
某些其他SQL数据库需要引入一个假的
单行表放在该SELECT的
FROM子句中才能做到这一点。
空SELECT列表
SELECT之后的输出表达式列表可以为空，
这会产生一个零列的结果表。对 SQL 标准来说这不是合法的
语法。PostgreSQL允许
它是为了与允许零列保持一致。不过在使用
DISTINCT时不允许空列表。
省略AS关键字
在 SQL 标准中，只要新列名是一个合法的列名（就是说与任何保留
关键字不同），就可以省略输出列名之前的可选关键字AS。
PostgreSQL要稍微严格些：只要新列名匹配
任何关键字（保留或者非保留）就需要AS。推荐的习惯是
使用AS或者带双引号的输出列名来防止与未来增加的
关键字可能的冲突。
在FROM项中，标准和
PostgreSQL都允许省略非保留
关键字别名之前的AS。但是由于语法的歧义，这无法
用于输出列名。
在FROM中省略子SELECT的别名
根据SQL标准，FROM列表中的子SELECT必须有一个别名。
在PostgreSQL中，这个别名可以省略。
ONLY和继承
在书写ONLY时，SQL 标准要求在表名周围加上圆括号，例如
SELECT * FROM ONLY
(tab1), ONLY (tab2) WHERE ...。PostgreSQL
认为这些圆括号是可选的。
PostgreSQL允许写一个拖尾的*来
显式指定包括子表的非-ONLY行为。而标准则不允许
这样。
（这些点同等地适用于所有支持ONLY选项的 SQL 命令）。
TABLESAMPLE子句限制
当前只在常规表和物化视图上接受TABLESAMPLE子句。
根据 SQL 标准，应该可以把它应用于任何FROM项。
FROM中的函数调用
PostgreSQL允许一个函数调用被直接写作
FROM列表的一个成员。在 SQL 标准中，有必要把这样一个函数
调用包裹在一个子-SELECT中。也就是说，语法
FROM func(...) alias
近似等价于
FROM LATERAL (SELECT func(...)) alias。
注意LATERAL被认为是隐式的，这是因为标准对于
FROM中的一个UNNEST()项要求
LATERAL语义。PostgreSQL会把
UNNEST()和其他集合返回函数同样对待。
GROUP BY和ORDER BY可用的命名空间
在 SQL-92 标准中，一个ORDER BY子句只能使用输出
列名或者序号，而一个GROUP BY子句只能使用基于输
入列名的表达式。PostgreSQL扩展了
这两种子句以允许它们使用其他的选择（但如果有歧义时还是使用标准的
解释）。PostgreSQL也允许两种子句
指定任意表达式。注意出现在一个表达式中的名称将总是被当做输入列名而
不是输出列名。
SQL:1999 及其后的标准使用了一种略微不同的定义，它并不完全向后兼容
SQL-92。不过，在大部分的情况下，
PostgreSQL会以与 SQL:1999 相同的
方式解释ORDER BY或GROUP
BY表达式。
函数依赖
PostgreSQL识别函数依赖（允许列从
GROUP BY中省略），仅当一个表的主键被包括在
GROUP BY列表中时。SQL 标准指定了应该要识别
的额外条件。
LIMIT和OFFSET
LIMIT和OFFSET子句是
PostgreSQL-特有的语法，在
MySQL也被使用。SQL:2008 标准已经
引入了具有相同功能的子句OFFSET ... FETCH {FIRST|NEXT}
...（如上文
LIMIT Clause中所示）。这种语法
也被IBM DB2使用（
Oracle编写的应用常常使用自动生成的
rownum列来实现这些子句的效果，这在 PostgreSQL
中是没有的）。
FOR NO KEY UPDATE、FOR UPDATE、FOR SHARE、FOR KEY SHARE
尽管 SQL 标准中出现了FOR UPDATE，但标准只允许它作为
DECLARE CURSOR的一个选项。
PostgreSQL允许它出现在任何
SELECT查询以及子-SELECT中，但这是
一种扩展。FOR NO KEY UPDATE、FOR SHARE
以及FOR KEY SHARE变体，以及NOWAIT
和SKIP LOCKED选项没有在标准中出现。
WITH中的数据修改语句
PostgreSQL 允许 INSERT、UPDATE、DELETE 和
MERGE 用作 WITH 查询。这在 SQL 标准中不存在。
非标准子句
DISTINCT ON ( ... )是 SQL 标准的扩展。
ROWS FROM( ... )是 SQL 标准的扩展。
WITH的MATERIALIZED 和 NOT MATERIALIZED 选项是 SQL 标准的扩展。
上一页 上一级 下一页SECURITY LABEL 起始页 SELECT INTO
