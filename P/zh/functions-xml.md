# 9.15. XML 函数

9.15. XML 函数
版本：
纠错本页面
搜索
目录导航
❮
❯
9.15. XML 函数 #9.15.1. 产生 XML 内容9.15.2. XML 谓词9.15.3. 处理 XML9.15.4. 将表映射到 XML
本节中描述的函数以及类函数的表达式都在类型 xml 的值上操作。类型 xml 的详细信息请参见 第 8.13 节。用于在值和类型 xml 之间转换的类函数的表达式 xmlparse
和 xmlserialize 记录在这里，而不是在本节中。
使用大部分这些函数要求 PostgreSQL 使用 configure --with-libxml 进行编译。
9.15.1. 产生 XML 内容 #
有一组函数和类函数的表达式可以用来从 SQL 数据产生 XML 内容。它们特别适合于将查询结果格式化成 XML 文档以便于在客户端应用中处理。
9.15.1.1. xmltext #
xmltext ( text ) → xml
该函数xmltext返回一个 XML 值，其中包含一个文本节点，节点内容为输入参数。
预定义实体如和号(&)、左尖括号和右尖括号(< >)、
以及引号("")都会被转义。
示例:
SELECT xmltext('< foo & bar >');
xmltext
-------------------------
&lt; foo &amp; bar &gt;
9.15.1.2. xmlcomment #
xmlcomment ( text ) → xml
函数xmlcomment创建了一个 XML 值，它包含一个使用指定文本作为内容的 XML 注释。
该文本不能包含“---”或者以“-”结尾，否则该结果的结构
不是一个合法的 XML 注释。如果参数为空，结果也为空。
例子：
SELECT xmlcomment('hello');
xmlcomment
--------------
<!--hello-->
9.15.1.3. xmlconcat #
xmlconcat ( xml [, ...] ) → xml
函数xmlconcat将由单个 XML 值组成的列表串接成一个单独的值，这个值包含一个 XML 内容片段。空值会被忽略，只有当没有非空参数时结果才为空。
例子：
SELECT xmlconcat('<abc/>', '<bar>foo</bar>');
xmlconcat
----------------------
<abc/><bar>foo</bar>
如果 XML 声明存在，它们会按照下面的方式被组合。如果所有的参数值都有相同的 XML 版本声明，该版本将被用在结果中，否则将不使用版本。如果所有参数值有独立声明值“yes”，那么该值将被用在结果中。如果所有参数值都有一个独立声明值并且至少有一个为“no”，则“no”被用在结果中。否则结果中将没有独立声明。如果结果被决定要要求一个独立声明但是没有版本声明，将会使用一个版本 1.0 的版本声明，因为 XML 要求一个 XML 声明要包含一个版本声明。编码声明会被忽略并且在所有情况下都会被移除。
例子：
SELECT xmlconcat('<?xml version="1.1"?><foo/>', '<?xml version="1.1" standalone="no"?><bar/>');
xmlconcat
-----------------------------------
<?xml version="1.1"?><foo/><bar/>
9.15.1.4. xmlelement #
xmlelement ( NAME name [, XMLATTRIBUTES ( attvalue [ AS attname ] [, ...] ) ] [, content [, ...]] ) → xml
xmlelement 表达式使用给定名称、属性和内容产生一个 XML 元素。
语法中显示的name和attname项是简单的标识符，而不是值。
attvalue和content项是表达式，它们可以生成任何PostgreSQL数据类型。
XMLATTRIBUTES的参数生成XML元素的属性；将content值连接起来形成其内容。
例子：
SELECT xmlelement(name foo);
xmlelement
------------
<foo/>
SELECT xmlelement(name foo, xmlattributes('xyz' as bar));
xmlelement
------------------
<foo bar="xyz"/>
SELECT xmlelement(name foo, xmlattributes(current_date as bar), 'cont', 'ent');
xmlelement
-------------------------------------
<foo bar="2007-01-26">content</foo>
不是合法 XML 名字的元素名和属性名将被转义，转义的方法是将违反的字符用序列_xHHHH_替换，其中HHHH是被替换字符的 Unicode 代码点的十六进制表示。例如：
SELECT xmlelement(name "foo$bar", xmlattributes('xyz' as "a&b"));
xmlelement
----------------------------------
<foo_x0024_bar a_x0026_b="xyz"/>
如果属性值是一个列引用，则不需要指定一个显式的属性名，在这种情况下列的名字将被默认用于属性的名字。在其他情况下，属性必须被给定一个显式名称。因此这个例子是合法的：
CREATE TABLE test (a xml, b xml);
SELECT xmlelement(name test, xmlattributes(a, b)) FROM test;
但是下面这些不合法：
SELECT xmlelement(name test, xmlattributes('constant'), a, b) FROM test;
SELECT xmlelement(name test, xmlattributes(func(a, b))) FROM test;
如果指定了元素内容，它们将被根据其数据类型格式化。如果内容本身也是类型xml，就可以构建复杂的 XML 文档。例如：
SELECT xmlelement(name foo, xmlattributes('xyz' as bar),
xmlelement(name abc),
xmlcomment('test'),
xmlelement(name xyz));
xmlelement
----------------------------------------------
<foo bar="xyz"><abc/><!--test--><xyz/></foo>
其他类型的内容将被格式化为合法的 XML 字符数据。这意味着字符 <, >, 和 & 将被转换为实体。二进制数据（数据类型bytea）将被表示成 base64 或十六进制编码，具体取决于配置参数xmlbinary的设置。为了使PostgreSQL的映射与SQL:2006及以后的SQL:2006中指定的映射保持一致，个别数据类型的特殊行为将不断发展，正如第 D.3.1.3 节中讨论的那样。
9.15.1.5. xmlforest #
xmlforest ( content [ AS name ] [, ...] ) → xml
表达式xmlforest使用给定名称和内容产生一个元素的 XML 森林（序列）。
对于xmlelement，每个name都必须是一个简单的标识符，而content表达式可以有任何数据类型。
示例：
SELECT xmlforest('abc' AS foo, 123 AS bar);
xmlforest
------------------------------
<foo>abc</foo><bar>123</bar>
SELECT xmlforest(table_name, column_name)
FROM information_schema.columns
WHERE table_schema = 'pg_catalog';
xmlforest
------------------------------------​-----------------------------------
<table_name>pg_authid</table_name>​<column_name>rolname</column_name>
<table_name>pg_authid</table_name>​<column_name>rolsuper</column_name>
...
如我们在第二个示例中所见，如果内容值是一个列引用，元素名称可以被忽略，这种情况下默认使用列名。否则，必须指定一个名字。
如上文xmlelement所示，非法 XML 名字的元素名会被转义。相似地，内容数据也会被转义来产生合法的 XML 内容，除非它已经是一个xml类型。
注意如果 XML 森林由多于一个元素组成，那么它不是合法的 XML 文档，因此在xmlelement中包装xmlforest表达式会有用处。
9.15.1.6. xmlpi #
xmlpi ( NAME name [, content ] ) → xml
表达式xmlpi创建一个 XML 处理指令。
对于xmlelement，name必须是一个简单的标识符，而content表达式可以有任何数据类型。如果存在，content不能包含字符序列?>。
示例：
SELECT xmlpi(name php, 'echo "hello world";');
xmlpi
-----------------------------
<?php echo "hello world";?>
9.15.1.7. xmlroot #
xmlroot ( xml, VERSION {text|NO VALUE} [, STANDALONE {YES|NO|NO VALUE} ] ) → xml
表达式xmlroot修改 XML 值的根节点的属性。如果指定了一个版本，它会替换根节点的版本声明中的值；如果指定了一个独立设置，它会替换根节点的独立声明中的值。
SELECT xmlroot(xmlparse(document '<?xml version="1.1"?><content>abc</content>'),
version '1.0', standalone yes);
xmlroot
----------------------------------------
<?xml version="1.0" standalone="yes"?>
<content>abc</content>
9.15.1.8. xmlagg #
xmlagg ( xml ) → xml
和这里描述的其他函数不同，函数xmlagg是一个聚合函数。它将聚合函数调用的输入值串接起来，非常像xmlconcat所做的事情，除了串接是跨行发生的而不是在单一行的多个表达式上发生。聚合函数的更多信息请见第 9.21 节。
例子：
CREATE TABLE test (y int, x xml);
INSERT INTO test VALUES (1, '<foo>abc</foo>');
INSERT INTO test VALUES (2, '<bar/>');
SELECT xmlagg(x) FROM test;
xmlagg
----------------------
<foo>abc</foo><bar/>
为了决定串接的顺序，可以为聚合调用增加一个ORDER BY子句，如第 4.2.7 节中所述。例如：
SELECT xmlagg(x ORDER BY y DESC) FROM test;
xmlagg
----------------------
<bar/><foo>abc</foo>
在以前的版本中推荐使用下列非标准方法，并且它们在特定情况下仍然有用：
SELECT xmlagg(x) FROM (SELECT * FROM test ORDER BY y DESC) AS tab;
xmlagg
----------------------
<bar/><foo>abc</foo>
9.15.2. XML 谓词 #
本节描述的表达式检查xml值的属性。
9.15.2.1. IS DOCUMENT #
xml IS DOCUMENT → boolean
如果参数 XML 值是一个正确的 XML 文档，则IS DOCUMENT返回真，如果不是则返回假（即它是一个内容片段），或者是参数为空时返回空。文档和内容片段之间的区别请见第 8.13 节。
9.15.2.2. IS NOT DOCUMENT #
xml IS NOT DOCUMENT → boolean
如果参数中的XML值是一个正确的XML文档，那么表达式IS NOT DOCUMENT返回假，如果不是（也就是说，它是一个内容片段），则返回真；如果参数为空，则返回空。
9.15.2.3. XMLEXISTS #
XMLEXISTS ( text PASSING [BY {REF|VALUE}] xml [BY {REF|VALUE}] ) → boolean
函数xmlexists评估一个XPath 1.0表达式（第一个参数），以传递的XML值作为其上下文项。如果评估的结果产生一个空节点集，该函数返回假；如果产生任何其他值，则返回真。如果任何参数为空，则函数返回空。作为上下文项传递的非空值必须是一个XML文档，而不是内容片段或任何非XML值。
例子：
SELECT xmlexists('//town[text() = ''Toronto'']' PASSING BY VALUE '<towns><town>Toronto</town><town>Ottawa</town></towns>');
xmlexists
------------
t
(1 row)
BY REF和BY VALUE子句在PostgreSQL中被接受，但在第 D.3.2 节中被忽略。
在SQL标准中，xmlexists函数评估XML查询语言中的表达式，但PostgreSQL只允许使用XPath 1.0表达式，在第 D.3.1 节中讨论过。
9.15.2.4. xml_is_well_formed #
xml_is_well_formed ( text ) → boolean
xml_is_well_formed_document ( text ) → boolean
xml_is_well_formed_content ( text ) → boolean
这些函数检查一个text字符串是否表示
良构的 XML，返回一个布尔结果。
xml_is_well_formed_document检查一个良构的
文档，而xml_is_well_formed_content检查
良构的内容。xml_is_well_formed在
xmloption配置参数设置为
DOCUMENT时执行前者，设置为
CONTENT时执行后者。这意味着
xml_is_well_formed对于检查一个简单
转换为xml的操作是否会成功非常有用，而其他两个
函数则用于检查对应的XMLPARSE变体
是否会成功。
示例:
SET xmloption TO DOCUMENT;
SELECT xml_is_well_formed('<>');
xml_is_well_formed
--------------------
f
(1 row)
SELECT xml_is_well_formed('<abc/>');
xml_is_well_formed
--------------------
t
(1 row)
SET xmloption TO CONTENT;
SELECT xml_is_well_formed('abc');
xml_is_well_formed
--------------------
t
(1 row)
SELECT xml_is_well_formed_document('<pg:foo xmlns:pg="http://postgresql.org/stuff">bar</pg:foo>');
xml_is_well_formed_document
-----------------------------
t
(1 row)
SELECT xml_is_well_formed_document('<pg:foo xmlns:pg="http://postgresql.org/stuff">bar</my:foo>');
xml_is_well_formed_document
-----------------------------
f
(1 row)
最后一个例子显示了检查是否正确匹配命名空间。
9.15.3. 处理 XML #
要处理数据类型xml的值，PostgreSQL提供了
函数xpath和xpath_exists，
它们计算XPath 1.0表达式，以及XMLTABLE
表函数。
9.15.3.1. xpath #
xpath ( xpath text, xml xml [, nsarray text[] ] ) → xml[]
函数xpath根据 XML 值xml计算 XPath 1.0 表达式xpath (以文本形式给出)。
它返回一个 XML 值的数组，该数组对应于该 XPath 表达式产生的节点集合。
如果该 XPath 表达式返回一个标量值而不是一个节点集合，将会返回一个单一元素的数组。
第二个参数必须是一个良构的 XML 文档。特别地，它必须有一个单一根节点元素。
该函数可选的第三个参数是一个命名空间映射的数组。这个数组应该是一个二维text数组，其第二轴长度等于2（即它应该是一个数组的数组，其中每一个都由刚好 2 个元素组成）。每个数组项的第一个元素是命名空间的名称（别名），第二个元素是命名空间的 URI。并不要求在这个数组中提供的别名和在 XML 文档本身中使用的那些命名空间相同（换句话说，在 XML 文档中和在xpath函数环境中，别名都是本地的）。
示例:
SELECT xpath('/my:a/text()', '<my:a xmlns:my="http://example.com">test</my:a>',
ARRAY[ARRAY['my', 'http://example.com']]);
xpath
--------
{test}
(1 row)
要处理默认（匿名）命名空间，做这样的事情：
SELECT xpath('//mydefns:b/text()', '<a xmlns="http://example.com"><b>test</b></a>',
ARRAY[ARRAY['mydefns', 'http://example.com']]);
xpath
--------
{test}
(1 row)
9.15.3.2. xpath_exists #
xpath_exists ( xpath text, xml xml [, nsarray text[] ] ) → boolean
函数xpath_exists是xpath函数的一种特殊形式。这个函数不是返回满足 XPath 1.0 表达式的单一 XML 值，它返回一个布尔值表示查询是否被满足（具体来说，它是否产生了空节点集以外的任何值）。这个函数等价于标准的XMLEXISTS谓词，不过它还提供了对一个命名空间映射参数的支持。
示例:
SELECT xpath_exists('/my:a/text()', '<my:a xmlns:my="http://example.com">test</my:a>',
ARRAY[ARRAY['my', 'http://example.com']]);
xpath_exists
--------------
t
(1 row)
9.15.3.3. xmltable #
XMLTABLE (
[ XMLNAMESPACES ( namespace_uri AS namespace_name [, ...] ), ]
row_expression PASSING [BY {REF|VALUE}] document_expression [BY {REF|VALUE}]
COLUMNS name { type [PATH column_expression] [DEFAULT default_expression] [NOT NULL | NULL]
| FOR ORDINALITY }
[, ...]
) → setof record
xmltable表达式基于给定的XML值产生一个表、一个抽取行的XPath过滤器以及一个列定义集合。
虽然它在语法上类似于函数，但它只能作为一个表出现在查询的FROM子句中。
可选的XMLNAMESPACES子句是一个逗号分隔的命名空间定义列表。
其中每个namespace_uri是一个text表达式，每个namespace_name是一个简单的标识符。
它指定文档中使用的XML命名空间及其别名。当前不支持默认的命名空间说明。
所需的row_expression参数是一个求值的XPath 1.0表达式（以text形式给出），通过传递XML值document_expression作为其上下文项，得到一组XML节点。
这些节点就是xmltable转换为输出行的内容。如果document_expression为空，或者row_expression产生空节点集或节点集以外的任何值，则不会产生行。
document_expression提供了上下文项给row_expression。
它必须是一个格式良好的XML文档；不接受片段/森林。BY REF和BY VALUE子句被接受但被忽略，正如在
第 D.3.2 节中所讨论的。
在SQL标准中，xmltable函数评估XML查询语言中的表达式，
但PostgreSQL只允许使用XPath 1.0的表达式，正如在
第 D.3.1 节所讨论的。
需要的COLUMNS子句指定将在输出表中生成的列。有关格式，请参阅上面的语法摘要。
每个列都需要一个名称，作为一个数据类型（除非指定了FOR ORDINALITY，在这种情况下类型integer是隐式的）。
路径、默认值以及为空性子句是可选的。
被标记为FOR ORDINALITY的列将按照从row_expression的结果节点集中检索到的节点的顺序，从1开始，填充行号。最多只能有一个列被标记为FOR ORDINALITY。
注意
XPath 1.0并没有为节点集中的节点指定顺序，因此依赖特定结果顺序的代码将取决于实现。详情请参见第 D.3.1.2 节。
列的column_expression是一个XPath 1.0表达式，它对每一行都要进行求值，并以row_expression结果中的当前节点作为其上下文项，以找到列的值。如果没有给出column_expression，那么列名被用作隐式路径。
如果一个列的XPath表达式返回一个非XML值（在XPath 1.0中仅限于string、boolean或double），而该列的PostgreSQL类型不是xml，那么该列将被设置为将值的字符串表示法分配给PostgreSQL类型。（如果值是布尔值，如果输出列的类型类别是数字，那么它的字符串表示方式将被认为是1或0，否则true或false。）
如果一个列的XPath表达式返回一个非空的XML节点集，并且该列的PostgreSQL类型是xml，那么如果该列是文档或内容形式的，那么该列将被精确地分配表达式结果。
[8]
分配给xml输出列的非XML结果会产生内容，一个带有结果字符串值的单个文本节点。分配给任何其他类型的列的XML结果不能有一个以上的节点，否则会产生错误。如果正好有一个节点，则该列将被设置为将该节点的字符串值（如XPath 1.0 string函数定义的那样）分配给PostgreSQL类型。
一个XML元素的字符串值是按文档顺序连接的所有文本节点的值，包括该元素及其子节点。没有下级文本节点的元素的字符串值是一个空字符串（不是NULL）。任何xsi:nil属性都会被忽略。请注意，两个非文本元素之间的仅包含空白的text()节点会被保留，并且text()节点上的前导空白不会被扁平化。可以参考XPath 1.0中的string函数，以了解定义其他XML节点类型和非XML值的字符串值的规则。
这里介绍的转换规则并不完全是SQL标准中的转换规则，如第 D.3.1.3 节中讨论的那样。
如果路径表达式为给定行返回一个空节点集（通常情况下，当它不匹配时），该列将被设置为NULL，除非指定了default_expression；然后使用评估该表达式产生的值。
default_expression，而不是在调用xmltable时立即被评估，而是在每次需要列的默认值时，都会被评估。如果表达式符合稳定或不可更改的条件，则可以跳过重复评估。这意味着，你可以在default_expression中使用像nextval这样的易变函数。
列可能会被标记为NOT NULL。如果一个NOT NULL列的column_expression不匹配任何内容并且没有DEFAULT或者default_expression也计算为空，则会报告一个错误。
例子:
CREATE TABLE xmldata AS SELECT
xml $$
<ROWS>
<ROW id="1">
<COUNTRY_ID>AU</COUNTRY_ID>
<COUNTRY_NAME>Australia</COUNTRY_NAME>
</ROW>
<ROW id="5">
<COUNTRY_ID>JP</COUNTRY_ID>
<COUNTRY_NAME>Japan</COUNTRY_NAME>
<PREMIER_NAME>Shinzo Abe</PREMIER_NAME>
<SIZE unit="sq_mi">145935</SIZE>
</ROW>
<ROW id="6">
<COUNTRY_ID>SG</COUNTRY_ID>
<COUNTRY_NAME>Singapore</COUNTRY_NAME>
<SIZE unit="sq_km">697</SIZE>
</ROW>
</ROWS>
$$ AS data;
SELECT xmltable.*
FROM xmldata,
XMLTABLE('//ROWS/ROW'
PASSING data
COLUMNS id int PATH '@id',
ordinality FOR ORDINALITY,
"COUNTRY_NAME" text,
country_id text PATH 'COUNTRY_ID',
size_sq_km float PATH 'SIZE[@unit = "sq_km"]',
size_other text PATH
'concat(SIZE[@unit!="sq_km"], " ", SIZE[@unit!="sq_km"]/@unit)',
premier_name text PATH 'PREMIER_NAME' DEFAULT '未指定');
id | ordinality | COUNTRY_NAME | country_id | size_sq_km |  size_other  | premier_name
----+------------+--------------+------------+------------+--------------+---------------
1 |          1 | Australia    | AU         |            |              | not specified
5 |          2 | Japan        | JP         |            | 145935 sq_mi | Shinzo Abe
6 |          3 | Singapore    | SG         |        697 |              | not specified
下面的例子展示了多个text()节点的连接，列名作为XPath过滤器的使用，以及对空格、XML注释和处理指令的处理:
CREATE TABLE xmlelements AS SELECT
xml $$
<root>
<element>  Hello<!-- xyxxz -->2a2<?aaaaa?> <!--x-->  bbb<x>xxx</x>CC  </element>
</root>
$$ AS data;
SELECT xmltable.*
FROM xmlelements, XMLTABLE('/root' PASSING data COLUMNS element text);
element
-------------------------
Hello2a2   bbbxxxCC
下面的例子展示了如何使用XMLNAMESPACES子句指定用于XML文档以及XPath表达式中的命名空间列表：
WITH xmldata(data) AS (VALUES ('
<example xmlns="http://example.com/myns" xmlns:B="http://example.com/b">
<item foo="1" B:bar="2"/>
<item foo="3" B:bar="4"/>
<item foo="4" B:bar="5"/>
</example>'::xml)
)
SELECT xmltable.*
FROM XMLTABLE(XMLNAMESPACES('http://example.com/myns' AS x,
'http://example.com/b' AS "B"),
'/x:example/x:item'
PASSING (SELECT data FROM xmldata)
COLUMNS foo int PATH '@foo',
bar int PATH '@B:bar');
foo | bar
-----+-----
1 |   2
3 |   4
4 |   5
(3 rows)
9.15.4. 将表映射到 XML #
下面的函数将关系表的内容映射成 XML 值。它们可以被看成是 XML 导出功能：
table_to_xml ( table regclass, nulls boolean,
tableforest boolean, targetns text ) → xml
query_to_xml ( query text, nulls boolean,
tableforest boolean, targetns text ) → xml
cursor_to_xml ( cursor refcursor, count integer, nulls boolean,
tableforest boolean, targetns text ) → xml
table_to_xml映射由参数table传递的命名表的内容。
regclass类型接受使用常见标记标识表的字符串，包括可选的模式限定和双引号（详见第 8.19 节）。
query_to_xml执行由参数query传递的查询并映射结果集。
cursor_to_xml从cursor指定的游标中取出指定数量的行。
如果需要映射一个大型的表，我们推荐这种变体，因为每个函数都是在内存中构建结果值的。
如果tableforest为假，则结果的 XML 文档看起来像这样：
<tablename>
<row>
<columnname1>data</columnname1>
<columnname2>data</columnname2>
</row>
<row>
...
</row>
...
</tablename>
如果tableforest为真，结果是一个看起来像这样的 XML 内容片段：
<tablename>
<columnname1>data</columnname1>
<columnname2>data</columnname2>
</tablename>
<tablename>
...
</tablename>
...
如果没有表名可用，即在映射一个查询或一个游标时，在第一种格式中使用字符串table，在第二种格式中使用row。
这几种格式的选择由用户决定。第一种格式是一个正确的 XML 文档，它在很多应用中都很重要。如果结果值要被重组为一个文档，第二种格式在cursor_to_xml函数中更有用。前文讨论的产生 XML 内容的函数（特别是xmlelement）可以被用来将结果修改成符合用户的要求。
数据值会被以前文的函数xmlelement中描述的相同方法映射。
参数nulls决定空值是否会被包含在输出中。如果为真，列中的空值被表示为：
<columnname xsi:nil="true"/>
其中xsi是 XML 模式实例的 XML 名称空间前缀。一个合适的名称空间声明将被加入到结果值中。如果为假，包含空值的列将被从输出中忽略。
参数targetns指定想要的结果的 XML 名称空间。如果没有想要的特定名称空间，将会传递一个空串。
下面的函数返回 XML 模式文档，这些文档描述上述对应函数所执行的映射：
table_to_xmlschema ( table regclass, nulls boolean,
tableforest boolean, targetns text ) → xml
query_to_xmlschema ( query text, nulls boolean,
tableforest boolean, targetns text ) → xml
cursor_to_xmlschema ( cursor refcursor, nulls boolean,
tableforest boolean, targetns text ) → xml
最重要的是相同的参数被传递来获得匹配的 XML 数据映射和 XML 模式文档。
下面的函数产生 XML 数据映射和对应的 XML 模式，并把产生的结果链接在一起放在一个文档（或森林）中。在要求自包含和自描述的结果时，它们非常有用：
table_to_xml_and_xmlschema ( table regclass, nulls boolean,
tableforest boolean, targetns text ) → xml
query_to_xml_and_xmlschema ( query text, nulls boolean,
tableforest boolean, targetns text ) → xml
另外，下面的函数可用于产生相似的整个模式或整个当前数据库的映射：
schema_to_xml ( schema name, nulls boolean,
tableforest boolean, targetns text ) → xml
schema_to_xmlschema ( schema name, nulls boolean,
tableforest boolean, targetns text ) → xml
schema_to_xml_and_xmlschema ( schema name, nulls boolean,
tableforest boolean, targetns text ) → xml
database_to_xml ( nulls boolean,
tableforest boolean, targetns text ) → xml
database_to_xmlschema ( nulls boolean,
tableforest boolean, targetns text ) → xml
database_to_xml_and_xmlschema ( nulls boolean,
tableforest boolean, targetns text ) → xml
这些函数会忽略当前用户不可读的表。数据库范围的函数还会忽略当前用户没有USAGE (查找)权限的模式。
请注意，这可能会产生大量数据，这些数据需要在内存中构建。当请求大型模式或数据库的内容映射时，可能值得考虑单独映射表，甚至可能通过游标。
一个模式内容映射的结果看起来像这样：
<schemaname>
table1-mapping
table2-mapping
...
</schemaname>
其中一个表映射的格式取决于上文解释的tableforest参数。
一个数据库内容映射的结果看起来像这样：
<dbname>
<schema1name>
...
</schema1name>
<schema2name>
...
</schema2name>
...
</dbname>
其中的模式映射如上所述。
作为一个使用这些函数产生的输出的例子，例 9.1展示了一个 XSLT 样式表，它将table_to_xml_and_xmlschema的输出转换为一个包含表数据的表格形式的 HTML 文档。以一种相似的方式，这些函数的结果可以被转换成其他基于 XML 的格式。
例 9.1. 转换 SQL/XML 输出到 HTML 的 XSLT 样式表
<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xsd="http://www.w3.org/2001/XMLSchema"
xmlns="http://www.w3.org/1999/xhtml"
>
<xsl:output method="xml"
doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
doctype-public="-//W3C/DTD XHTML 1.0 Strict//EN"
indent="yes"/>
<xsl:template match="/*">
<xsl:variable name="schema" select="//xsd:schema"/>
<xsl:variable name="tabletypename"
select="$schema/xsd:element[@name=name(current())]/@type"/>
<xsl:variable name="rowtypename"
select="$schema/xsd:complexType[@name=$tabletypename]/xsd:sequence/xsd:element[@name='row']/@type"/>
<html>
<head>
<title><xsl:value-of select="name(current())"/></title>
</head>
<body>
<table>
<tr>
<xsl:for-each select="$schema/xsd:complexType[@name=$rowtypename]/xsd:sequence/xsd:element/@name">
<th><xsl:value-of select="."/></th>
</xsl:for-each>
</tr>
<xsl:for-each select="row">
<tr>
<xsl:for-each select="*">
<td><xsl:value-of select="."/></td>
</xsl:for-each>
</tr>
</xsl:for-each>
</table>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
[8]
在顶层包含一个以上的元素节点的结果，或者在元素之外的非空格文本，就是内容形式的一个例子。
一个XPath结果可以是这两种形式的，例如，如果它返回的是一个从包含它的元素中选择的属性节点。
这样的结果将被放到内容形式中，每个不允许的节点都会被替换为它的字符串值，就像XPath 1.0string函数定义的那样。
上一页 上一级 下一页9.14. UUID 函数 起始页 9.16. JSON 函数和操作符
