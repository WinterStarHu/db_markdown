# 4.2. 值表达式

4.2. 值表达式
版本：
纠错本页面
搜索
目录导航
❮
❯
4.2. 值表达式 #4.2.1. 列引用4.2.2. 位置参数4.2.3. 下标4.2.4. 字段选择4.2.5. 操作符调用4.2.6. 函数调用4.2.7. 聚合表达式4.2.8. 窗口函数调用4.2.9. 类型转换4.2.10. 排序规则表达式4.2.11. 标量子查询4.2.12. 数组构造器4.2.13. 行构造器4.2.14. 表达式计算规则
值表达式被用于各种各样的环境中，例如在SELECT命令的目标列表中、作为INSERT或UPDATE中的新列值或者若干命令中的搜索条件。为了区别于一个表表达式（是一个表）的结果，一个值表达式的结果有时候被称为一个标量。值表达式因此也被称为标量表达式（或者甚至简称为表达式）。表达式语法允许使用算术、逻辑、集合和其他操作从原始部分计算值。
一个值表达式是下列之一：
一个常量或文字值
一个列引用
在一个函数定义体或预备语句中的一个位置参数引用
一个下标表达式
一个字段选择表达式
一个操作符调用
一个函数调用
一个聚合表达式
一个窗口函数调用
一个类型转换
一个排序规则表达式
一个标量子查询
一个数组构造器
一个行构造器
另一个在圆括号（用来分组子表达式以及重载优先级）中的值表达式
在这个列表之外，还有一些结构可以被分类为一个表达式，但是它们不遵循任何一般语法规则。这些通常具有一个函数或操作符的语义并且在第 9 章中的合适位置解释。一个例子是IS NULL子句。
我们已经在第 4.1.2 节中讨论过常量。下面的小节会讨论剩下的选项。
4.2.1. 列引用 #
一个列可以以下面的形式被引用：
correlation.columnname
correlation是一个表（有可能以一个模式名限定）的名字，或者是在FROM子句中为一个表定义的别名。如果列名在当前查询所使用的表中都是唯一的，关联名称和分隔用的句点可以被忽略（另见第 7 章）。
4.2.2. 位置参数 #
一个位置参数引用被用来指示一个由 SQL 语句外部提供的值。参数被用于 SQL 函数定义和预备查询中。某些客户端库还支持独立于 SQL 命令字符串来指定数据值，在这种情况下参数被用来引用那些线外数据值。一个参数引用的形式是：
$number
例如，考虑一个函数dept的定义：
CREATE FUNCTION dept(text) RETURNS dept
AS $$ SELECT * FROM dept WHERE name = $1 $$
LANGUAGE SQL;
这里$1引用函数被调用时第一个函数参数的值。
4.2.3. 下标 #
如果一个表达式得到了一个数组类型的值，那么可以抽取出该数组值的一个特定元素：
expression[subscript]
或者抽取出多个相邻元素（一个“数组切片”）：
expression[lower_subscript:upper_subscript]
（这里，方括号[ ]表示其字面意思）。每一个subscript自身是一个表达式，它将四舍五入到最接近的整数值。
通常，数组expression必须被加上括号，但是当要被加下标的表达式只是一个列引用或位置参数时，括号可以被忽略。还有，当原始数组是多维时，多个下标可以被连接起来。例如：
mytable.arraycolumn[4]
mytable.two_d_column[17][34]
$1[10:42]
(arrayfunction(a,b))[42]
最后一个例子中的圆括号是必需的。详见第 8.15 节。
4.2.4. 字段选择 #
如果一个表达式得到一个复合类型（行类型）的值，那么可以抽取该行的指定字段
expression.fieldname
通常行expression必须被加上括号，但是当该表达式是仅从一个表引用或位置参数选择时，圆括号可以被忽略。例如：
mytable.mycolumn
$1.somecolumn
(rowfunction(a,b)).col3
（因此，一个被限定的列引用实际上只是字段选择语法的一种特例）。一种重要的特例是从一个复合类型的表列中抽取一个字段：
(compositecol).somefield
(mytable.compositecol).somefield
这里需要圆括号来显示compositecol是一个列名而不是一个表名，在第二种情况中则是显示mytable是一个表名而不是一个模式名。
你可以通过书写.*来请求一个复合值的所有字段：
(compositecol).*
这种记法的行为根据上下文会有不同，详见第 8.16.5 节。
4.2.5. 操作符调用 #
对于操作符调用，有两种可能的语法：
expression operator expression（二元中缀操作符）operator expression（一元前缀操作符）
其中operator记号遵循第 4.1.3 节的语法规则，或者是关键词AND、OR和NOT之一，或者是一个如下形式的受限定操作符名：
OPERATOR(schema.operatorname)
哪个特定操作符存在以及它们是一元的还是二元的取决于由系统或用户定义的那些操作符。第 9 章描述了内建操作符。
4.2.6. 函数调用 #
一个函数调用的语法是一个函数的名称（可能受限于一个模式名）后面跟上封闭于圆括号中的参数列表：
function_name ([expression [, expression ... ]] )
例如，下面会计算 2 的平方根：
sqrt(2)
内建函数的列表在第 9 章中。其他函数可以由用户增加。
当在一个某些用户不信任其他用户的数据库中发出查询时，在编写函数调用时应遵守第 10.3 节中的安全防范措施。
参数可以选择性地附加名称。详见第 4.3 节。
注意
一个采用单一组合类型参数的函数可以选择性地使用字段选择语法调用，反之
字段选择也可以用函数风格书写。也就是说，记号col(table)和table.col是
可以互换的。这种行为不是 SQL 标准，但在PostgreSQL中提供，因为它允许函数的使用来
模拟“计算字段”。详见第 8.16.5 节。
4.2.7. 聚合表达式 #
一个聚合表达式表示在由一个查询选择的行上应用一个聚合函数。一个聚合函数将多个输入减少到一个单一输出值，例如对输入的求和或平均。一个聚合表达式的语法是下列之一：
aggregate_name (expression [ , ... ] [ order_by_clause ] ) [ FILTER ( WHERE filter_clause ) ]
aggregate_name (ALL expression [ , ... ] [ order_by_clause ] ) [ FILTER ( WHERE filter_clause ) ]
aggregate_name (DISTINCT expression [ , ... ] [ order_by_clause ] ) [ FILTER ( WHERE filter_clause ) ]
aggregate_name ( * ) [ FILTER ( WHERE filter_clause ) ]
aggregate_name ( [ expression [ , ... ] ] ) WITHIN GROUP ( order_by_clause ) [ FILTER ( WHERE filter_clause ) ]
这里aggregate_name是一个之前定义的聚合（可能带有一个模式名限定），并且expression是任意自身不包含聚合表达式的值表达式或一个窗口函数调用。可选的order_by_clause和filter_clause描述如下。
第一种形式的聚合表达式为每一个输入行调用一次聚合。第二种形式和第一种相同，因为ALL是默认选项。第三种形式为输入行中表达式的每一个可区分值（或者对于多个表达式是值的可区分集合）调用一次聚合。第四种形式为每一个输入行调用一次聚合，因为没有特定的输入值被指定，它通常只对于count(*)聚合函数有用。最后一种形式被用于有序集聚合函数，其描述如下。
大部分聚合函数忽略空输入，这样其中一个或多个表达式得到空值的行将被丢弃。除非另有说明，对于所有内建聚合都是这样。
例如，count(*)得到输入行的总数；count(f1)得到输入行中f1为非空的数量，因为count忽略空值；而count(distinct f1)得到f1的非空可区分值的数量。
通常，输入行以未指定的顺序传递给聚合函数。在许多情况下，这并不重要；例如，
min 无论以何种顺序接收输入，结果都是相同的。然而，某些聚合函数
（例如 array_agg 和 string_agg）产生的结果
依赖于输入行的顺序。使用此类聚合时，可以使用可选的 order_by_clause
来指定所需的排序。order_by_clause 的语法与查询级别的
ORDER BY 子句相同，如 第 7.5 节 中所述，
但其表达式始终只是表达式，不能是输出列名或数字。例如：
WITH vals (v) AS ( VALUES (1),(3),(4),(3),(2) )
SELECT array_agg(v ORDER BY v DESC) FROM vals;
array_agg
-------------
{4,3,3,2,1}
由于 jsonb 只保留最后匹配的键，其键的排序可能很重要：
WITH vals (k, v) AS ( VALUES ('key0','1'), ('key1','3'), ('key1','2') )
SELECT jsonb_object_agg(k, v ORDER BY v) FROM vals;
jsonb_object_agg
----------------------------
{"key0": "1", "key1": "3"}
在处理多参数聚合函数时，注意ORDER BY出现在所有聚合参数之后。例如，要这样写：
SELECT string_agg(a, ',' ORDER BY a) FROM table;
而不能这样写：
SELECT string_agg(a ORDER BY a, ',') FROM table;  -- 不正确
后者在语法上是合法的，但是它表示用两个ORDER BY键来调用一个单一参数聚合函数（第二个是无用的，因为它是一个常量）。
如果在DISTINCT中指定了一个
order_by_clause，则ORDER
BY表达式只能引用DISTINCT列表中的列。例如：
WITH vals (v) AS ( VALUES (1),(3),(4),(3),(2) )
SELECT array_agg(DISTINCT v ORDER BY v DESC) FROM vals;
array_agg
-----------
{4,3,2,1}
按照到目前为止的描述，如果一般目的和统计性聚集中
排序是可选的，在要为它排序输入行时可以在该聚集的常规参数
列表中放置ORDER BY。有一个聚集函数的子集叫
做有序集聚集，它要求一个
order_by_clause，通常是因为
该聚集的计算只对其输入行的特定顺序有意义。有序集聚集的典
型例子包括排名和百分位计算。按照上文的最后一种语法，对于
一个有序集聚集，
order_by_clause被写在
WITHIN GROUP (...)中。
order_by_clause中的表达式
会像普通聚集参数一样对每一个输入行计算一次，按照每个
order_by_clause的要求排序并
且交给该聚集函数作为输入参数（这和非
WITHIN GROUP
order_by_clause的情况不同，在其中表达
式的结果不会被作为聚集函数的参数）。如果有在
WITHIN GROUP之前的参数表达式，会把它们称
为直接参数以便与列在
order_by_clause中的
聚集参数相区分。与普通聚集参数不同，针对
每次聚集调用只会计算一次直接参数，而不是为每一个输入行
计算一次。这意味着只有那些变量被GROUP BY
分组时，它们才能包含这些变量。这个限制同样适用于根本不在
一个聚集表达式内部的直接参数。直接参数通常被用于百分数
之类的东西，它们只有作为每次聚集计算用一次的单一值才有意
义。直接参数列表可以为空，在这种情况下，写成()
而不是(*)（实际上
PostgreSQL接受两种拼写，但是只有第一
种符合 SQL 标准）。
有序集聚集的调用例子：
SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY income) FROM households;
percentile_cont
-----------------
50489
这会从表households的
income列得到第 50 个百分位或者中位的值。
这里0.5是一个直接参数，对于百分位部分是一个
在不同行之间变化的值的情况它没有意义。
如果指定了FILTER，那么只有对filter_clause计算为真的输入行会被交给该聚合函数，其他行会被丢弃。例如：
SELECT
count(*) AS unfiltered,
count(*) FILTER (WHERE i < 5) AS filtered
FROM generate_series(1,10) AS s(i);
unfiltered | filtered
------------+----------
10 |        4
(1 row)
预定义的聚合函数在第 9.21 节中描述。其他聚合函数可以由用户增加。
一个聚合表达式只能出现在SELECT命令的结果列表或是HAVING子句中。在其他子句（如WHERE）中禁止使用它，因为那些子句的计算在逻辑上是在聚合的结果被形成之前。
当一个聚合表达式出现在一个子查询中（见第 4.2.11 节和第 9.24 节），聚合通常在该子查询的行上被计算。但是如果该聚合的参数（以及filter_clause，如果有）只包含外层变量则会产生一个异常：该聚合则属于最近的那个外层，并且会在那个查询的行上被计算。该聚合表达式从整体上则是对其所出现于的子查询的一种外层引用，并且在那个子查询的任意一次计算中都作为一个常量。只出现在结果列表或HAVING子句的限制适用于该聚合所属的查询层次。
4.2.8. 窗口函数调用 #
一个窗口函数调用表示在一个查询选择的行的某个部分上应用一个聚合类的函数。和非窗口聚合函数调用不同，这不会被约束为将被选择的行分组为一个单一的输出行 — 在查询输出中每一个行仍保持独立。不过，窗口函数能够根据窗口函数调用的分组声明（PARTITION BY列表）访问属于当前行所在分组中的所有行。一个窗口函数调用的语法是下列之一：
function_name ([expression [, expression ... ]]) [ FILTER ( WHERE filter_clause ) ] OVER window_name
function_name ([expression [, expression ... ]]) [ FILTER ( WHERE filter_clause ) ] OVER ( window_definition )
function_name ( * ) [ FILTER ( WHERE filter_clause ) ] OVER window_name
function_name ( * ) [ FILTER ( WHERE filter_clause ) ] OVER ( window_definition )
其中window_definition的语法是
[ existing_window_name ]
[ PARTITION BY expression [, ...] ]
[ ORDER BY expression [ ASC | DESC | USING operator ] [ NULLS { FIRST | LAST } ] [, ...] ]
[ frame_clause ]
可选的frame_clause是下列之一
{ RANGE | ROWS | GROUPS } frame_start [ frame_exclusion ]
{ RANGE | ROWS | GROUPS } BETWEEN frame_start AND frame_end [ frame_exclusion ]
其中frame_start和frame_end可以是下面形式中的一种
UNBOUNDED PRECEDING
offset PRECEDING
CURRENT ROW
offset FOLLOWING
UNBOUNDED FOLLOWING
而frame_exclusion可以是下列之一
EXCLUDE CURRENT ROW
EXCLUDE GROUP
EXCLUDE TIES
EXCLUDE NO OTHERS
这里，expression表示任何不包含窗口函数调用的值表达式。
window_name是对定义在查询的WINDOW子句中的一个命名窗口声明的引用。还可以使用在WINDOW子句中定义命名窗口的相同语法在圆括号内给定一个完整的window_definition，详见SELECT参考页。值得指出的是，OVER wname并不严格等价于OVER (wname ...)；后者表示复制并修改窗口定义，并且在被引用窗口声明包括一个帧子句时会被拒绝。
PARTITION BY子句将查询的行分组成为分区，窗口函数会独立地处理它们。PARTITION BY工作起来类似于一个查询级别的GROUP BY子句，不过它的表达式总是只是表达式并且不能是输出列的名称或编号。如果没有PARTITION BY，该查询产生的所有行被当作一个单一分区来处理。ORDER BY子句决定被窗口函数处理的一个分区中的行的顺序。它工作起来类似于一个查询级别的ORDER BY子句，但是同样不能使用输出列的名称或编号。如果没有ORDER BY，行将以未指定的顺序被处理。
frame_clause指定构成窗口帧的行集合，它是当前分区的一个子集，窗口函数将作用在该帧而不是整个分区。帧中的行集合会随着哪一行是当前行而变化。在RANGE、ROWS或者GROUPS模式中可以指定帧，在每一种情况下，帧的范围都是从frame_start到frame_end。如果frame_end被省略，则末尾默认为CURRENT ROW。
UNBOUNDED PRECEDING的一个frame_start表示该帧开始于分区的第一行，类似地UNBOUNDED FOLLOWING的一个frame_end表示该帧结束于分区的最后一行。
在RANGE或GROUPS模式中，CURRENT ROW的一个frame_start表示帧开始于当前行的第一个平级行（被窗口的ORDER BY子句排序为与当前行等效的行），而CURRENT ROW的一个frame_end表示帧结束于当前行的最后一个平级行。在ROWS模式中，CURRENT ROW就表示当前行。
在offset PRECEDING以及offset FOLLOWING帧选项中，offset必须是一个不包含任何变量、聚合函数或者窗口函数的表达式。offset的含义取决于帧模式：
在ROWS模式中，offset必须得到一个非空、非负的整数，并且该选项表示帧开始于当前行之前或者之后指定数量的行。
在GROUPS模式中，offset也必须得到一个非空、非负的整数，并且该选项表示帧开始于当前行的平级组之前或者之后指定数量的平级组，这里平级组是在ORDER BY顺序中等效的行集合（要使用GROUPS模式，在窗口定义中就必须有一个ORDER BY子句）。
在RANGE模式中，这些选项要求ORDER BY子句正好指定一列。offset指定当前行中那一列的值与它在该帧中前面或后面的行中的列值的最大差值。offset表达式的数据类型会随着排序列的数据类型而变化。对于数字的排序列，它通常是与排序列相同的类型，但对于日期时间排序列它是一个interval。例如，如果排序列是类型date或者timestamp，我们可以写RANGE BETWEEN '1 day' PRECEDING AND '10 days' FOLLOWING。offset仍然要求是非空且非负，不过“非负”的含义取决于它的数据类型。
在任何一种情况下，到帧末尾的距离都受限于到分区末尾的距离，因此对于离分区末尾比较近的行来说，帧可能会包含比较少的行。
注意在ROWS以及GROUPS模式中，0 PRECEDING和0 FOLLOWING与CURRENT ROW等效。通常在RANGE模式中，这个结论也成立（只要有一种合适的、与数据类型相关的“零”的含义）。
frame_exclusion选项允许当前行周围的行被排除在帧之外，即便根据帧的开始和结束选项应该把它们包括在帧中。EXCLUDE CURRENT ROW会把当前行排除在帧之外。EXCLUDE GROUP会把当前行以及它在顺序上的平级行都排除在帧之外。EXCLUDE TIES把当前行的任何平级行都从帧中排除，但不排除当前行本身。EXCLUDE NO OTHERS只是明确地指定不排除当前行或其平级行的这种默认行为。
默认的帧选项是RANGE UNBOUNDED PRECEDING，它和RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW相同。如果使用ORDER BY，这会把该帧设置为从分区开始一直到当前行的最后一个ORDER BY平级行的所有行。如果不使用ORDER BY，就意味着分区中所有的行都被包括在窗口帧中，因为所有行都成为了当前行的平级行。
限制是frame_start不能是UNBOUNDED FOLLOWING、frame_end不能是UNBOUNDED PRECEDING，并且在上述frame_start和frame_end选项的列表中frame_end选择不能早于frame_start选择出现 — 例如不允许RANGE BETWEEN CURRENT ROW AND offset PRECEDING，但允许ROWS BETWEEN 7 PRECEDING AND 8 PRECEDING，虽然它不会选择任何行。
如果指定了FILTER，那么只有对filter_clause计算为真的输入行会被交给该窗口函数，其他行会被丢弃。只有聚合的窗口函数才接受FILTER子句。
内建的窗口函数在表 9.67中介绍。用户可以加入其他窗口函数。此外，任何内建的或者用户定义的通用聚合或者统计性聚合都可以被用作窗口函数（有序集和假想集聚合当前不能被用作窗口函数）。
使用*的语法被用来把参数较少的聚合函数当作窗口函数调用，例如count(*) OVER (PARTITION BY x ORDER BY y)。星号（*）通常不被用于窗口相关的函数。窗口相关的函数不允许在函数参数列表中使用DISTINCT或ORDER BY。
只有在SELECT列表和查询的ORDER BY子句中才允许窗口函数调用。
更多关于窗口函数的信息可以在第 3.5 节、第 9.22 节以及第 7.2.5 节中找到。
4.2.9. 类型转换 #
一个类型转换指定从一种数据类型到另一种数据类型的转换。PostgreSQL接受两种等价的类型转换语法：
CAST ( expression AS type )
expression::type
CAST语法遵从 SQL，而用::的语法是PostgreSQL的历史用法。
当一个转换被应用到一种已知类型的值表达式上时，它表示一种运行时类型转换。只有已经定义了一种合适的类型转换操作时，该转换才会成功。注意这和常量的转换（如第 4.1.2.7 节中所示）使用不同。应用于一个未修饰字符串文字的转换表示一种类型到一个文字常量值的初始赋值，并且因此它将对任意类型都成功（如果该字符串文字的内容对于该数据类型的输入语法是可接受的）。
如果一个值表达式必须产生的类型没有歧义（例如当它被指派给一个表列），通常可以省略显式类型转换，在这种情况下系统会自动应用一个类型转换。但是，只有对在系统目录中被标记为“OK to apply implicitly”的转换才会执行自动转换。其他转换必须使用显式转换语法调用。这种限制是为了防止出人意料的转换被无声无息地应用。
还可以用类似函数的语法来指定一次类型转换：
typename ( expression )
不过，这只对那些名称也作为函数名可用的类型有效。例如，double precision不能以这种方式使用，但是等效的float8可以。还有，如果名称interval、time和timestamp被用双引号引用，那么由于语法冲突的原因，它们只能以这种方式使用。因此，函数风格的转换语法的使用会导致不一致性并且应该尽可能被避免。
注意
函数风格的语法事实上只是一次函数调用。当两种标准类型语法之一被用来做一次运行时转换时，它将在内部调用一个已注册的函数来执行该转换。简而言之，这些转换函数具有和它们的输出类型相同的名字，并且因此“函数风格的语法”无非是对底层转换函数的一次直接调用。显然，一个可移植的应用不应当依赖于它。详见CREATE CAST。
4.2.10. 排序规则表达式 #
COLLATE子句会重载一个表达式的排序规则。它被追加到它适用的表达式：
expr COLLATE collation
这里collation可能是一个受模式限定的标识符。COLLATE子句比操作符绑定得更紧，需要时可以使用圆括号。
如果没有显式指定排序规则，数据库系统会从表达式所涉及的列中推导出一个排序规则，如果该表达式没有涉及列，则会默认采用数据库的默认排序规则。
COLLATE子句的两种常见使用是重载ORDER BY子句中的排序顺序，例如：
SELECT a, b, c FROM tbl WHERE ... ORDER BY a COLLATE "C";
以及重载具有区域敏感结果的函数或操作符调用的排序规则，例如：
SELECT * FROM tbl WHERE a > 'foo' COLLATE "C";
注意在后一种情况中，COLLATE子句被附加到我们希望影响的操作符的一个输入参数上。COLLATE子句被附加到该操作符或函数调用的哪个参数上无关紧要，因为被操作符或函数应用的排序规则是考虑所有参数得来的，并且一个显式的COLLATE子句将重载所有其他参数的排序规则（不过，附加非匹配COLLATE子句到多于一个参数是一种错误。详见第 23.2 节）。因此，这会给出和前一个例子相同的结果：
SELECT * FROM tbl WHERE a COLLATE "C" > 'foo';
但是这是一个错误：
SELECT * FROM tbl WHERE (a > 'foo') COLLATE "C";
因为它尝试把一个排序规则应用到>操作符的结果，而它的数据类型是非可排序数据类型boolean。
4.2.11. 标量子查询 #
一个标量子查询是一种圆括号内的普通SELECT查询，它刚好返回一行一列（关于书写查询可见第 7 章）。SELECT查询被执行并且该单一返回值被使用在周围的值表达式中。将一个返回超过一行或一列的查询作为一个标量子查询使用是一种错误（但是如果在一次特定执行期间该子查询没有返回行则不是错误，该标量结果被当做为空）。该子查询可以从周围的查询中引用变量，这些变量在该子查询的任何一次计算中都将作为常量。对于其他涉及子查询的表达式还可见第 9.24 节。
例如，下列语句会寻找每个州中最大的城市人口：
SELECT name, (SELECT max(pop) FROM cities WHERE cities.state = states.name)
FROM states;
4.2.12. 数组构造器 #
一个数组构造器是一个能构建一个数组值并且将值用于它的成员元素的表达式。一个简单的数组构造器由关键词ARRAY、一个左方括号[、一个用于数组元素值的表达式列表（用逗号分隔）以及最后的一个右方括号]组成。例如：
SELECT ARRAY[1,2,3+4];
array
---------
{1,2,7}
(1 row)
默认情况下，数组元素类型是成员表达式的公共类型，使用和UNION或CASE结构（见第 10.5 节）相同的规则决定。你可以通过显式将数组构造器转换为想要的类型来重载，例如：
SELECT ARRAY[1,2,22.7]::integer[];
array
----------
{1,2,23}
(1 row)
这和把每一个表达式单独地转换为数组元素类型的效果相同。关于转换的更多信息请见第 4.2.9 节。
多维数组值可以通过嵌套数组构造器来构建。在内层的构造器中，关键词ARRAY可以被忽略。例如，这些语句产生相同的结果：
SELECT ARRAY[ARRAY[1,2], ARRAY[3,4]];
array
---------------
{{1,2},{3,4}}
(1 row)
SELECT ARRAY[[1,2],[3,4]];
array
---------------
{{1,2},{3,4}}
(1 row)
因为多维数组必须是矩形的，处于同一层次的内层构造器必须产生相同维度的子数组。任何被应用于外层ARRAY构造器的转换会自动传播到所有的内层构造器。
多维数组构造器元素可以是任何得到一个正确种类数组的任何东西，而不仅仅是一个子-ARRAY结构。例如：
CREATE TABLE arr(f1 int[], f2 int[]);
INSERT INTO arr VALUES (ARRAY[[1,2],[3,4]], ARRAY[[5,6],[7,8]]);
SELECT ARRAY[f1, f2, '{{9,10},{11,12}}'::int[]] FROM arr;
array
------------------------------------------------
{{{1,2},{3,4}},{{5,6},{7,8}},{{9,10},{11,12}}}
(1 row)
你可以构造一个空数组，但是因为无法得到一个无类型的数组，你必须显式地把你的空数组转换成想要的类型。例如：
SELECT ARRAY[]::integer[];
array
----------
{}
(1 row)
也可以从一个子查询的结果构建一个数组。在这种形式中，数组构造器被写为关键词ARRAY后跟着一个加了圆括号（不是方括号）的子查询。例如：
SELECT ARRAY(SELECT oid FROM pg_proc WHERE proname LIKE 'bytea%');
array
------------------------------------------------------------------
{2011,1954,1948,1952,1951,1244,1950,2005,1949,1953,2006,31,2412}
(1 row)
SELECT ARRAY(SELECT ARRAY[i, i*2] FROM generate_series(1,5) AS a(i));
array
----------------------------------
{{1,2},{2,4},{3,6},{4,8},{5,10}}
(1 row)
子查询必须返回一个单一列。如果子查询的输出列是非数组类型，
结果的一维数组将为该子查询结果中的每一行有一个元素，
并且有一个与子查询的输出列匹配的元素类型。如果子查询的输出列
是一种数组类型，结果将是同类型的一个数组，但是要高一个维度。
在这种情况下，该子查询的所有行必须产生同样维度的数组，否则结果
就不会是矩形形式。
用ARRAY构建的一个数组值的下标总是从一开始。更多关于数组的信息，请见第 8.15 节。
4.2.13. 行构造器 #
一个行构造器是能够构建一个行值（也称作一个组合值）并用值作为其成员字段的表达式。一个行构造器由关键词ROW、一个左圆括号、用于行字段值的零个或多个表达式（用逗号分隔）以及最后的一个右圆括号组成。例如：
SELECT ROW(1,2.5,'this is a test');
当在列表中有超过一个表达式时，关键词ROW是可选的。
一个行构造器可以包括语法rowvalue.*，它将被扩展为该行值的元素的一个列表，就像在一个顶层SELECT列表（见第 8.16.5 节）中使用.*时发生的事情一样。例如，如果表t有列f1和f2，那么这些是相同的：
SELECT ROW(t.*, 42) FROM t;
SELECT ROW(t.f1, t.f2, 42) FROM t;
注意
在PostgreSQL 8.2 以前，.*语法不会在行构造器中被扩展，这样写ROW(t.*, 42)会创建一个有两个字段的行，其第一个字段是另一个行值。新的行为通常更有用。如果你需要嵌套行值的旧行为，写内层行值时不要用.*，例如ROW(t, 42)。
默认情况下，由一个ROW表达式创建的值是一种匿名记录类型。如果必要，它可以被转换为一种命名的组合类型 — 或者是一个表的行类型，或者是一种用CREATE TYPE AS创建的组合类型。为了避免歧义，可能需要一个显式转换。例如：
CREATE TABLE mytable(f1 int, f2 float, f3 text);
CREATE FUNCTION getf1(mytable) RETURNS int AS 'SELECT $1.f1' LANGUAGE SQL;
-- 不需要转换因为只有一个 getf1() 存在
SELECT getf1(ROW(1,2.5,'this is a test'));
getf1
-------
1
(1 row)
CREATE TYPE myrowtype AS (f1 int, f2 text, f3 numeric);
CREATE FUNCTION getf1(myrowtype) RETURNS int AS 'SELECT $1.f1' LANGUAGE SQL;
-- 现在我们需要一个转换来指示要调用哪个函数：
SELECT getf1(ROW(1,2.5,'this is a test'));
ERROR:  function getf1(record) is not unique
SELECT getf1(ROW(1,2.5,'this is a test')::mytable);
getf1
-------
1
(1 row)
SELECT getf1(CAST(ROW(11,'this is a test',2.5) AS myrowtype));
getf1
-------
11
(1 row)
行构造函数可以用于构建复合值，以存储在复合类型的表列中，或传递给接受复合参数的函数。此外，可以使用标准比较运算符测试行，如在 第 9.2 节 中所述，比较一行与另一行，如在 第 9.25 节 中所述，并在与子查询相关的情况下使用它们，如在 第 9.24 节 中讨论的那样。
4.2.14. 表达式计算规则 #
子表达式的计算顺序没有被定义。特别地，一个操作符或函数的输入不必按照从左至右或其他任何固定顺序进行计算。
此外，如果一个表达式的结果可以通过只计算其一部分来决定，那么其他子表达式可能完全不需要被计算。例如，如果我们写：
SELECT true OR somefunc();
那么somefunc()将（可能）完全不被调用。如果我们写成下面这样也是一样：
SELECT somefunc() OR true;
注意这和一些编程语言中布尔操作符从左至右的“短路”不同。
因此，在复杂表达式中使用带有副作用的函数是不明智的。在WHERE和HAVING子句中依赖副作用或计算顺序尤其危险，因为在建立一个执行计划时这些子句会被广泛地重新处理。这些子句中布尔表达式（AND/OR/NOT的组合）可能会以布尔代数定律所允许的任何方式被重组。
当有必要强制计算顺序时，可以使用一个CASE结构（见第 9.18 节）。例如，在一个WHERE子句中使用下面的方法尝试避免除零是不可靠的：
SELECT ... WHERE x > 0 AND y/x > 1.5;
但是这是安全的：
SELECT ... WHERE CASE WHEN x > 0 THEN y/x > 1.5 ELSE false END;
一个以这种风格使用的CASE结构将使得优化尝试失败，因此只有必要时才这样做（在这个特别的例子中，最好通过写y > 1.5*x来回避这个问题）。
不过，CASE不是这类问题的万灵药。上述技术的一个限制是，
它无法阻止常量子表达式的提早计算。如第 36.7 节
中所述，当查询被规划而不是被执行时，被标记成
IMMUTABLE的函数和操作符可以被计算。因此
SELECT CASE WHEN x > 0 THEN x ELSE 1/0 END FROM tab;
很可能会导致一次除零失败，因为规划器尝试简化常量子表达式。即便是
表中的每一行都有x > 0（这样运行时永远不会进入到
ELSE分支）也是这样。
虽然这个特别的例子可能看起来愚蠢，没有明显涉及常量的情况可能会发生
在函数内执行的查询中，因为函数参数的值和本地变量可以作为常量
被插入到查询中用于规划目的。例如，在PL/pgSQL函数
中，使用一个IF-THEN-ELSE语句来
保护一种有风险的计算比把它嵌在一个CASE表达式中要安全得多。
另一个同类型的限制是，一个CASE无法阻止其所包含的聚集表达式
的计算，因为在考虑SELECT列表或HAVING子句中的
其他表达式之前，会先计算聚集表达式。例如，下面的查询会导致一个除零错误，
虽然看起来好像已经对这种情况加以了保护：
SELECT CASE WHEN min(employees) > 0
THEN avg(expenses / employees)
END
FROM departments;
min()和avg()聚集会在所有输入行上并行地计算，
因此如果任何行有employees等于零，在有机会测试
min()的结果之前，就会发生除零错误。取而代之的是，可以使用
一个WHERE或FILTER子句来首先阻止有问题的输入行到达
一个聚集函数。
上一页 上一级 下一页4.1. 词法结构 起始页 4.3. 调用函数
