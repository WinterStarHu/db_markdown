# 8.16. 组合类型

8.16. 组合类型
版本：
纠错本页面
搜索
目录导航
❮
❯
8.16. 组合类型 #8.16.1. 组合类型的声明8.16.2. 构造组合值8.16.3. 访问组合类型8.16.4. 修改组合类型8.16.5. 在查询中使用组合类型8.16.6. 组合类型输入和输出语法
一个组合类型表示一行或一个记录的结构，它本质上就是一个字段名和它们数据类型的列表。PostgreSQL允许把组合类型用在很多能用简单类型的地方。例如，一个表的一列可以被声明为一种组合类型。
8.16.1. 组合类型的声明 #
这里有两个定义组合类型的简单例子：
CREATE TYPE complex AS (
r       double precision,
i       double precision
);
CREATE TYPE inventory_item AS (
name            text,
supplier_id     integer,
price           numeric
);
该语法堪比CREATE TABLE，不过只能指定字段名和类型，当前不能包括约束（例如NOT NULL）。注意AS关键词是必不可少的，如果没有它，系统将认为用户想要的是一种不同类型的CREATE TYPE命令，并且你将得到奇怪的语法错误。
定义了类型之后，我们可以用它们来创建表：
CREATE TABLE on_hand (
item      inventory_item,
count     integer
);
INSERT INTO on_hand VALUES (ROW('fuzzy dice', 42, 1.99), 1000);
或函数:
CREATE FUNCTION price_extension(inventory_item, integer) RETURNS numeric
AS 'SELECT $1.price * $2' LANGUAGE SQL;
SELECT price_extension(item, 10) FROM on_hand;
每当您创建一个表时，还会自动创建一个组合类型，与表同名，用于表示表的行类型。例如，如果我们说：
CREATE TABLE inventory_item (
name            text,
supplier_id     integer REFERENCES suppliers,
price           numeric CHECK (price > 0)
);
那么与上面显示的相同的inventory_item组合类型也会随之产生，并且可以像上面那样使用。
但是请注意当前实现的一个重要限制：由于组合类型没有关联的约束，因此在表之外的组合类型的值上不适用表定义中显示的约束。
（要解决这个问题，创建一个覆盖组合类型的CHECK约束的域，并将所需的约束应用于该域。）
8.16.2. 构造组合值 #
要把一个组合值写作一个文字常量，将该域值封闭在圆括号中并且用逗号分隔它们。你可以在任何域值周围放上双引号，并且如果该域值包含逗号或圆括号则必须这样做（更多细节见下文）。这样，一个组合常量的一般格式是下面这样的：
'( val1 , val2 , ... )'
一个例子是：
'("fuzzy dice",42,1.99)'
这将是上文定义的inventory_item类型的一个合法值。要让一个域为 NULL，在列表中它的位置上根本不写字符。例如，这个常量指定其第三个域为 NULL：
'("fuzzy dice",42,)'
如果你写一个空字符串而不是 NULL，写上两个引号：
'("",42,)'
这里第一个域是一个非 NULL 空字符串，第三个是 NULL。
（这些常量实际上只是第 4.1.2.7 节中讨论的一般类型常量的特殊情况。该常量最初被当做一个字符串并且被传递给组合类型输入转换例程。有必要用一次显式类型说明来告知要把该常量转换成何种类型。）。
ROW表达式也能被用来构建组合值。在大部分情况下，比起使用字符串语法，这相当简单易用，因为你不必担心多层引用。我们已经在上文用过这种方法：
ROW('fuzzy dice', 42, 1.99)
ROW('', 42, NULL)
只要在表达式中有多于一个域，ROW关键词实际上就是可选的，因此这些可以被简化成：
('fuzzy dice', 42, 1.99)
('', 42, NULL)
第 4.2.13 节中更加详细地讨论了ROW表达式语法。
8.16.3. 访问组合类型 #
要访问一个组合列的一个域，可以写成一个点和域的名称，更像从一个表名中选择一个域。事实上，它太像从一个表名中选择，这样我们不得不使用圆括号来避免让解析器混淆。例如，你可能尝试从例子表on_hand中选取一些子域：
SELECT item.name FROM on_hand WHERE item.price > 9.99;
这不会有用，因为名称item会被当成是一个表名，而不是on_hand的一个列名。你必须写成这样：
SELECT (item).name FROM on_hand WHERE (item).price > 9.99;
或者你还需要使用表名（例如在一个多表查询中），像这样：
SELECT (on_hand.item).name FROM on_hand WHERE (on_hand.item).price > 9.99;
现在加上括号的对象就被正确地解释为对item列的引用，然后可以从中选出子域。
只要你从一个组合值中选择一个域，相似的语法问题就适用。例如，要从一个返回组合值的函数的结果中选取一个域，你需要这样写：
SELECT (my_func(...)).field FROM ...
如果没有额外的圆括号，这将生成一个语法错误。
特殊的字段名称*表示“所有字段”，第 8.16.5 节中有进一步的解释。
8.16.4. 修改组合类型 #
这里有一些插入和更新组合列的正确语法的例子。首先，插入或更新整个列：
INSERT INTO mytab (complex_col) VALUES((1.1,2.2));
UPDATE mytab SET complex_col = ROW(1.1,2.2) WHERE ...;
第一个例子省略了ROW，第二个例子使用了它；我们可以用任一方式完成。
我们可以更新组合列的单个子字段：
UPDATE mytab SET complex_col.r = (complex_col).r + 1 WHERE ...;
注意这里我们不需要（事实上也不能）在正好出现在SET之后的列名周围加上圆括号，但在等号右边的表达式中引用同一列时确实需要圆括号。
并且我们也可以指定子字段作为INSERT的目标：
INSERT INTO mytab (complex_col.r, complex_col.i) VALUES(1.1, 2.2);
如果我们没有为该列的所有子字段提供值，剩下的子字段将用空值填充。
8.16.5. 在查询中使用组合类型 #
对于查询中的组合类型，有各种特殊的语法规则和行为。这些规则提供了有用的捷径，但如果你不懂背后的逻辑就会感到困惑。
在PostgreSQL中，查询中对一个表名（或别名）的引用实际上是对该表的当前行的组合值的引用。例如，如果我们有一个如上所示的表inventory_item，我们可以写：
SELECT c FROM inventory_item c;
这个查询产生一个单一组合值列，所以我们会得到这样的输出：
c
------------------------
("fuzzy dice",42,1.99)
(1 row)
不过要注意简单的名称会在表名之前先匹配到列名，因此这个例子可行的原因仅仅是因为在该查询的表中没有名为c的列。
普通的限定列名语法table_name.column_name可以理解为把字段选择应用在该表的当前行的组合值上（由于效率原因，实际上不是以这种方式实现）。
当我们写
SELECT c.* FROM inventory_item c;
时，根据SQL标准，我们应该得到该表展开成列的内容：
name    | supplier_id | price
------------+-------------+-------
fuzzy dice |          42 |  1.99
(1 row)
就好像查询是
SELECT c.name, c.supplier_id, c.price FROM inventory_item c;
尽管如上所示，PostgreSQL将对任何组合值表达式应用这种展开行为，但只要.*所应用的值不是一个简单的表名，你就需要把该值写在圆括号内。例如，如果myfunc()是一个返回组合类型的函数，该组合类型由列a、b和c组成，那么这两个查询有相同的结果：
SELECT (myfunc(x)).* FROM some_table;
SELECT (myfunc(x)).a, (myfunc(x)).b, (myfunc(x)).c FROM some_table;
提示
PostgreSQL通过将第一种形式转换为第二种来处理列展开。因此，在这个例子中，用两种语法时对每行都会调用myfunc()三次。如果它是一个开销很大的函数，你可能希望避免这样做，所以可以用一个这样的查询：
SELECT m.* FROM some_table, LATERAL myfunc(x) AS m;
把该函数放在一个LATERAL FROM项中会防止它对每一行被调用超过一次。m.*仍然会被展开为m.a, m.b, m.c，但现在那些变量只是对这个FROM项的输出的引用（这里关键词LATERAL是可选的，但我们在这里写上它是为了说明该函数从some_table中得到x）。
composite_value.* 语法在出现在
SELECT 输出列表、
RETURNING 列表（在
INSERT/UPDATE/DELETE/MERGE 中）、
VALUES 子句或
行构造器的顶层时，会导致此类列扩展。
在所有其他上下文中（包括嵌套在这些结构内时），将 .* 附加到复合值
不会改变值，因为它表示“所有列”，因此会再次产生相同的复合值。
例如，如果 somefunc() 接受一个复合值参数，这些查询是相同的：
SELECT somefunc(c.*) FROM inventory_item c;
SELECT somefunc(c) FROM inventory_item c;
在这两种情况下，inventory_item 的当前行作为单个复合值参数
传递给函数。尽管 .* 在这种情况下不起作用，但使用它是良好的
编码风格，因为它明确表示意图使用复合值。特别是，解析器会将
c（在 c.* 中）视为表名或别名，而不是列名，
因此不存在歧义；而没有 .* 时，不清楚 c 是
表名还是列名，实际上如果存在名为 c 的列，则会优先解释为列名。
另一个演示这些概念的例子是下面这些查询，它们表示相同的东西：
SELECT * FROM inventory_item c ORDER BY c;
SELECT * FROM inventory_item c ORDER BY c.*;
SELECT * FROM inventory_item c ORDER BY ROW(c.*);
所有这些ORDER BY子句指定该行的组合值，导致根据第 9.25.6 节中介绍的规则对行进行排序。不过，如果inventory_item包含一个名为c的列，第一种情况会不同于其他情况，因为它表示仅按那一列排序。给定之前所示的列名，下面这些查询也等效于上面的那些查询：
SELECT * FROM inventory_item c ORDER BY ROW(c.name, c.supplier_id, c.price);
SELECT * FROM inventory_item c ORDER BY (c.name, c.supplier_id, c.price);
（最后一种情况使用了一个省略关键字ROW的行构造器）。
另一种与组合值相关的特殊语法行为是，我们可以使用函数记法来抽取一个组合值的字段。解释这种行为的简单方式是记法field(table)和table.field是可以互换的。例如，这些查询是等效的：
SELECT c.name FROM inventory_item c WHERE c.price > 1000;
SELECT name(c) FROM inventory_item c WHERE price(c) > 1000;
此外，如果我们有一个函数接受单一的组合类型参数，我们可以以任意一种记法来调用它。这些查询全都是等效的：
SELECT somefunc(c) FROM inventory_item c;
SELECT somefunc(c.*) FROM inventory_item c;
SELECT c.somefunc FROM inventory_item c;
这种函数记法和字段记法之间的等效性使得我们可以在组合类型上使用函数来实现“计算字段”。
一个使用上述最后一种查询的应用不会直接意识到somefunc不是一个真实的表列。
提示
由于这种行为，让一个接受单一组合类型参数的函数与该组合类型的任意字段具有相同的名称是不明智的。出现歧义时，如果使用了字段名语法，则字段名解释将被选择，而如果使用的是函数调用语法则会选择函数解释。不过，PostgreSQL在版本11之前总是选择字段名解释，除非该调用的语法要求它是一个函数调用。在老的版本中强制函数解释的一种方法是用方案限定函数名，也就是写成schema.func(compositevalue)。
8.16.6. 组合类型输入和输出语法 #
一个组合值的外部文本表达由根据字段类型的 I/O 转换规则解释的项，外加指示组合结构的装饰组成。装饰由整个值周围的圆括号（(和)），外加相邻项之间的逗号（,）组成。圆括号之外的空格会被忽略，但是在圆括号之内空格会被当成字段值的一部分，并且根据字段数据类型的输入转换规则可能有意义，也可能没有意义。例如，在
'(  42)'
中，如果字段类型是整数则空格会被忽略，而如果是文本则空格不会被忽略。
如前所示，在写一个组合值时，你可以在任意字段值周围写上双引号。如果不这样做会让字段值迷惑组合值解析器，你就必须这么做。特别地，包含圆括号、逗号、双引号或反斜线的字段必须用双引号引用。要把一个双引号或者反斜线放在一个被引用的组合字段值中，需要在它前面放上一个反斜线（还有，一个双引号引用的字段值中的一对双引号被认为是表示一个双引号字符，这和 SQL 字符串中单引号的规则类似）。另一种办法是，你可以避免引用以及使用反斜线转义来保护所有可能被当作组合语法的数据字符。
一个全空的字段值（在逗号或圆括号之间完全没有字符）表示一个 NULL。要写一个空字符串值而不是 NULL，可以写成""。
如果字段值是空串或者包含圆括号、逗号、双引号、反斜线或空格，组合输出例程将在字段值周围放上双引号（对空格这样处理并不是不可缺少的，但是可以提高可读性）。嵌入在字段值中的双引号及反斜线将被双写。
注意
记住你在一个 SQL 命令中写的东西将首先被解释为一个字符串，然后才会被解释为一个组合。这就让你所需要的反斜线数量翻倍（假定使用了转义字符串语法）。例如，要在组合值中插入一个含有一个双引号和一个反斜线的text字段，你需要写成：
INSERT ... VALUES ('("\"\\")');
字符串处理器会移除一层反斜线，这样在组合值解析器那里看到的就会是("\"\\")。接着，字符串被交给text数据类型的输入例程并且变成"\（如果我们使用的数据类型的输入例程也会特别处理反斜线，例如bytea，在命令中我们可能需要八个反斜线用来在组合字段中存储一个反斜线）。美元引用（见第 4.1.2.4 节）可以被用来避免双写反斜线。
提示
当在 SQL 命令中书写组合值时，ROW构造器语法通常比组合文字语法更容易使用。在ROW中，单个字段值可以按照平时不是组合值成员的写法来写。
上一页 上一级 下一页8.15. 数组 起始页 8.17. 范围类型
