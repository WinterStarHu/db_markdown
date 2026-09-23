# F.50. xml2 — XPath查询和XSLT功能

F.50. xml2 — XPath查询和XSLT功能
版本：
纠错本页面
搜索
目录导航
❮
❯
F.50. xml2 — XPath查询和XSLT功能 #F.50.1. 废弃公告F.50.2. 函数描述F.50.3. xpath_tableF.50.4. XSLT 函数F.50.5. 作者
xml2模块提供 XPath 查询和 XSLT 功能。
F.50.1. 废弃公告 #
从PostgreSQL 8.3 开始，在核心服务器中就已经有基于 SQL/XML 标准的 XML 相关功能。那些功能覆盖了 XML 语法检查和 XPath 查询，这些本模块也能做，但是其 API 并不是完全兼容。这个模块已经有计划将从 PostgreSQL 的一个未来版本中移除，因此我们鼓励你尝试转换你的应用。如果你发现这个模块的某些功能在更新的 API 中没有合适的形式相对应，请向<pgsql-hackers@lists.postgresql.org>表达你的问题，这样该缺点会被进行改进。
F.50.2. 函数描述 #
表 F.37展示了这个模块提供的函数。这些函数提供了直接的 XML 解析和 XPath 查询。
表 F.37. xml2 函数
函数
描述
xml_valid ( document text )
→ boolean
解析给定的文档，如果文档是格式良好的 XML，则返回 true。（注意，这是标准 PostgreSQL 函数xml_is_well_formed()的别名。
名称xml_valid()在技术上是不正确的，因为在 XML 中有效性和结构良好性具有不同的含义。）
xpath_string ( document text, query text )
→ text
在提供的文档上评估 XPath 查询，并将结果转换为text。
xpath_number ( document text, query text )
→ real
在提供的文档上评估 XPath 查询，并将结果转换为real。
xpath_bool ( document text, query text )
→ boolean
在提供的文档上评估 XPath 查询，并将结果转换为boolean。
xpath_nodeset ( document text, query text, toptag text, itemtag text )
→ text
评估文档上的查询，并将结果包装在 XML 标签中。如果结果是多值的，输出将如下所示：
<toptag>
<itemtag>Value 1 which could be an XML fragment</itemtag>
<itemtag>Value 2....</itemtag>
</toptag>
如果toptag或itemtag是空字符串，则相关标签将被省略。
xpath_nodeset ( document text, query text, itemtag text )
→ text
类似于xpath_nodeset(document, query, toptag, itemtag)，但结果省略了toptag。
xpath_nodeset ( document text, query text )
→ text
类似于xpath_nodeset(document, query, toptag, itemtag)，但结果省略了两个标签。
xpath_list ( document text, query text, separator text )
→ text
评估文档上的查询并返回由指定分隔符分隔的多个值，例如Value
1,Value 2,Value 3，如果separator
是,。
xpath_list ( document text, query text )
→ text
这是上述函数的包装器，使用,作为分隔符。
F.50.3. xpath_table #
xpath_table(text key, text document, text relation, text xpaths, text criteria) returns setof record
xpath_table是一个表函数，它在一组文档中的每一个上计算一组 XPath 查询，并且将结果作为一个表返回。来自原始文档表的主键域被返回为结果的第一列，这样结果集可以被用于连接。其参数在表 F.38中描述。
表 F.38. xpath_table 参数参数描述key
“key”域的名称 — 这只是被用作输出表中第一列的域，即它标识每一个输出行是来自于哪个记录（见下面有关多个值的注解）
document
包含 XML 文档的字段名称
relation
包含文档的表或视图名称
xpaths
一个或多个 XPath 表达式，用 | 分隔
criteria
WHERE 子句的内容。这不能被忽略，因此如果你想要处理关系中的所有行，可以使用 true 或 1=1
这些参数（除了 XPath 字符串）只是会被替换到一个纯粹的 SQL SELECT 语句中，因此你有一些灵活性 — 该语句是
SELECT <key>, <document> FROM <relation> WHERE <criteria>
因此那些参数可以是那些特定位置上合法的 任何东西。来自于这个 SELECT 的结果需要返回正好两列（它确实会这样，除非你尝试为键或文档列出多个字段）。注意这种简单方法要求你验证任何用户提供的值来避免 SQL 注入攻击。
该函数必须被使用在一个 FROM 表达式中，并带有一个 AS 子句来指定输出列，例如
SELECT * FROM
xpath_table('article_id',
'article_xml',
'articles',
'/article/author|/article/pages|/article/title',
'date_entered > ''2003-01-01'' ')
AS t(article_id integer, author text, page_count integer, title text);
AS 子句定义了输出表中列的名称和类型。第一个是 “key” 字段，剩下的对应于 XPath 查询。如果 XPath 查询比结果列多，额外的查询将被忽略。如果结果列比 XPath 查询多，额外的列将是 NULL。
注意这个例子定义 page_count 结果列为一个整数。该函数在内部处理字符串表示，因此当你在输出中想要一个整数时，它将采用 XPath 结果的字符串表示并且使用 PostgreSQL 输入函数来把它转换成一个整数（或者 AS 子句要求的任何类型）。如果它无法做到这一点将会导致一个错误 — 例如结果是空 — 因此如果你认为你的数据有任何问题，你可能希望坚持用 text 作为列类型。
调用SELECT语句不一定只能是SELECT * — 它可以通过名称引用输出列或将它们连接到其他表。
该函数生成一个虚拟表，您可以对其执行任何操作（例如，聚合、连接、排序等）。因此，我们也可以有：
SELECT t.title, p.fullname, p.email
FROM xpath_table('article_id', 'article_xml', 'articles',
'/article/title|/article/author/@id',
'xpath_string(article_xml,''/article/@date'') > ''2003-03-20'' ')
AS t(article_id integer, title text, author_id integer),
tblPeopleInfo AS p
WHERE t.author_id = p.person_id;
作为一个更复杂的示例。当然，为方便使用，您可以将所有这些内容都包装在一个视图中。
F.50.3.1. 多值结果 #
xpath_table函数假定每一个 XPath 查询的结果可能是多值的，因此该函数返回的行数可能与输入文档的数目不同。被返回的第一行包含来自每一个查询的第一个结果，第二行则是来自每一个查询的第二个结果。如果其中一个查询的值比其他查询少，则会为它返回空值。
在某些情况下，一个用户将知道一个给定的 XPath 查询将只返回一个单一结果（可能是一个唯一文档标识符） — 如果和一个返回多值的 XPath 查询一起使用，单值结果将只出现在结果的第一行中。对于这种情况的解决方案是使用键域作为针对一个更简单 XPath 查询的连接的一部分。一个例子：
CREATE TABLE test (
id int PRIMARY KEY,
xml text
);
INSERT INTO test VALUES (1, '<doc num="C1">
<line num="L1"><a>1</a><b>2</b><c>3</c></line>
<line num="L2"><a>11</a><b>22</b><c>33</c></line>
</doc>');
INSERT INTO test VALUES (2, '<doc num="C2">
<line num="L1"><a>111</a><b>222</b><c>333</c></line>
<line num="L2"><a>111</a><b>222</b><c>333</c></line>
</doc>');
SELECT * FROM
xpath_table('id','xml','test',
'/doc/@num|/doc/line/@num|/doc/line/a|/doc/line/b|/doc/line/c',
'true')
AS t(id int, doc_num varchar(10), line_num varchar(10), val1 int, val2 int, val3 int)
WHERE id = 1 ORDER BY doc_num, line_num
id | doc_num | line_num | val1 | val2 | val3
----+---------+----------+------+------+------
1 | C1      | L1       |    1 |    2 |    3
1 |         | L2       |   11 |   22 |   33
要在每一行上得到doc_num，解决方案是使用xpath_table的两个调用并且连接结果：
SELECT t.*,i.doc_num FROM
xpath_table('id', 'xml', 'test',
'/doc/line/@num|/doc/line/a|/doc/line/b|/doc/line/c',
'true')
AS t(id int, line_num varchar(10), val1 int, val2 int, val3 int),
xpath_table('id', 'xml', 'test', '/doc/@num', 'true')
AS i(id int, doc_num varchar(10))
WHERE i.id=t.id AND i.id=1
ORDER BY doc_num, line_num;
id | line_num | val1 | val2 | val3 | doc_num
----+----------+------+------+------+---------
1 | L1       |    1 |    2 |    3 | C1
1 | L2       |   11 |   22 |   33 | C1
(2 rows)
F.50.4. XSLT 函数 #
如果安装了 libxslt，那么可以使用下列函数：
F.50.4.1. xslt_process #
xslt_process(text document, text stylesheet, text paramlist) returns text
这个函数将 XSL 样式表应用于文档并返回转换后的结果。paramlist是一个用于转换的参数赋值列表，以a=1,b=2的形式指定。注意参数解析非常简单：参数值不能包含逗号！
还有一个双参数版本的xslt_process，它不会向转换传递任何参数。
F.50.5. 作者 #
John Gray <jgray@azuli.co.uk>
这个模块的开发由 Torchbox Ltd. (www.torchbox.com) 赞助。它与 PostgreSQL 使用相同的 BSD 许可证。
上一页 上一级 下一页F.49. uuid-ossp — 一个UUID生成器 起始页 附录 G. 附加提供的程序
