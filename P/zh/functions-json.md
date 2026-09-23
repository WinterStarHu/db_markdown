# 9.16. JSON 函数和操作符

9.16. JSON 函数和操作符
版本：
纠错本页面
搜索
目录导航
❮
❯
9.16. JSON 函数和操作符 #9.16.1. 处理和创建JSON数据9.16.2. SQL/JSON 路径语言9.16.3. SQL/JSON 查询函数9.16.4. JSON_TABLE
本节介绍：
用于处理和创建 JSON 数据的函数和操作符
SQL/JSON 路径语言
SQL/JSON 查询函数
为了在 SQL 环境中提供对 JSON 数据类型的原生支持，
PostgreSQL 实现了
SQL/JSON 数据模型。
该模型由一系列项组成。每个项可以包含 SQL 标量值，
以及一个额外的 SQL/JSON 空值和使用 JSON 数组与对象的复合数据结构。
该模型是对 JSON 规范中隐含数据模型的形式化定义，
RFC 7159。
SQL/JSON 允许您在常规 SQL 数据的基础上处理 JSON 数据，
并支持事务，包括：
将 JSON 数据上传到数据库并以字符或二进制字符串的形式
存储在常规 SQL 列中。
从关系数据生成 JSON 对象和数组。
使用 SQL/JSON 查询函数和 SQL/JSON 路径语言表达式
查询 JSON 数据。
要了解有关 SQL/JSON 标准的更多信息，请参阅 [sqltr-19075-6]。有关 PostgreSQL 中支持的 JSON 类型的详细信息，见 第 8.14 节。
9.16.1. 处理和创建JSON数据 #
表 9.47显示了可用于JSON数据类型的运算符（参见第 8.14 节）。
此外，表 9.1中显示的常规比较运算符可用于jsonb，但不适用于json。
比较运算符遵循B树操作的排序规则，详见第 8.14.4 节。
另请参阅第 9.21 节，了解聚合函数json_agg，将记录值聚合为JSON，
聚合函数json_object_agg将值对聚合为JSON对象，以及它们的jsonb等效函数，
jsonb_agg和jsonb_object_agg。
表 9.47. json 和 jsonb 操作符
操作符
描述
示例
json -> integer
→ json
jsonb -> integer
→ jsonb
提取JSON数组的第n个元素（数组元素从0开始索引，但负整数从末尾开始计数）。
'[{"a":"foo"},{"b":"bar"},{"c":"baz"}]'::json -> 2
→ {"c":"baz"}
'[{"a":"foo"},{"b":"bar"},{"c":"baz"}]'::json -> -3
→ {"a":"foo"}
json -> text
→ json
jsonb -> text
→ jsonb
用给定的键提取JSON对象字段。
'{"a": {"b":"foo"}}'::json -> 'a'
→ {"b":"foo"}
json ->> integer
→ text
jsonb ->> integer
→ text
提取JSON数组的第n个元素，作为text。
'[1,2,3]'::json ->> 2
→ 3
json ->> text
→ text
jsonb ->> text
→ text
用给定的键提取JSON对象字段，作为text。
'{"a":1,"b":2}'::json ->> 'b'
→ 2
json #> text[]
→ json
jsonb #> text[]
→ jsonb
提取指定路径下的 JSON 子对象，路径元素可以是字段键或数组索引。
'{"a": {"b": ["foo","bar"]}}'::json #> '{a,b,1}'
→ "bar"
json #>> text[]
→ text
jsonb #>> text[]
→ text
将指定路径上的 JSON 子对象提取为 text。
'{"a": {"b": ["foo","bar"]}}'::json #>> '{a,b,1}'
→ bar
注意
如果 JSON 输入没有匹配请求的正确结构，字段/元素/路径提取操作符返回 NULL，而不是失败；例如，如果不存在这样的键或数组元素。
还有一些操作符仅适用于 jsonb，如表 表 9.48 所示。
第 第 8.14.4 节 描述了如何使用这些操作符来有效地搜索索引的 jsonb 数据。
表 9.48. 附加的 jsonb 操作符
操作符
描述
示例
jsonb @> jsonb
→ boolean
第一个 JSON 值是否包含第二个？（请参见 第 8.14.3 节 以了解包含的详细信息。）
'{"a":1, "b":2}'::jsonb @> '{"b":2}'::jsonb
→ t
jsonb <@ jsonb
→ boolean
第一个 JSON 值是否包含在第二个 JSON 中？
'{"b":2}'::jsonb <@ '{"a":1, "b":2}'::jsonb
→ t
jsonb ? text
→ boolean
文本字符串是否作为JSON值中的顶级键或数组元素存在？
'{"a":1, "b":2}'::jsonb ? 'b'
→ t
'["a", "b", "c"]'::jsonb ? 'b'
→ t
jsonb ?| text[]
→ boolean
文本数组中的字符串是否作为顶级键或数组元素存在？
'{"a":1, "b":2, "c":3}'::jsonb ?| array['b', 'd']
→ t
jsonb ?& text[]
→ boolean
文本数组中的所有字符串都作为顶级键或数组元素存在吗？
'["a", "b", "c"]'::jsonb ?& array['a', 'b']
→ t
jsonb || jsonb
→ jsonb
连接两个jsonb值。
连接两个数组将生成一个包含每个输入的所有元素的数组。
连接两个对象将生成一个包含它们键的并集的对象，当存在重复的键时取第二个对象的值。
所有其他情况都通过将非数组输入转换为单元素数组来处理，然后按照两个数组的方式进行处理。
不递归操作：只有顶级数组或对象结构被合并。
'["a", "b"]'::jsonb || '["a", "d"]'::jsonb
→ ["a", "b", "a", "d"]
'{"a": "b"}'::jsonb || '{"c": "d"}'::jsonb
→ {"a": "b", "c": "d"}
'[1, 2]'::jsonb || '3'::jsonb
→ [1, 2, 3]
'{"a": "b"}'::jsonb || '42'::jsonb
→ [{"a": "b"}, 42]
要将一个数组作为单个条目附加到另一个数组中，请将其包装在另一个数组附加层中，例如：
'[1, 2]'::jsonb || jsonb_build_array('[3, 4]'::jsonb)
→ [1, 2, [3, 4]]
jsonb - text
→ jsonb
从JSON对象中删除键（以及它的值），或从JSON数组中删除匹配的字符串值。
'{"a": "b", "c": "d"}'::jsonb - 'a'
→ {"c": "d"}
'["a", "b", "c", "b"]'::jsonb - 'b'
→ ["a", "c"]
jsonb - text[]
→ jsonb
从左操作数中删除所有匹配的键或数组元素。
'{"a": "b", "c": "d"}'::jsonb - '{a,c}'::text[]
→ {}
jsonb - integer
→ jsonb
删除具有指定索引的数组元素（负整数从末尾计数）。如果JSON值不是数组，则抛出错误。
'["a", "b"]'::jsonb - 1
→ ["a"]
jsonb #- text[]
→ jsonb
删除指定路径上的字段或数组元素，路径元素可以是字段键或数组索引。
'["a", {"b":1}]'::jsonb #- '{1,b}'
→ ["a", {}]
jsonb @? jsonpath
→ boolean
JSON 路径是否为指定的 JSON 值返回任何项？
（这仅适用于 SQL 标准的 JSON 路径表达式，而不适用于
谓词检查
表达式，因为那些总是返回一个值。）
'{"a":[1,2,3,4,5]}'::jsonb @? '$.a[*] ? (@ > 2)'
→ true
jsonb @@ jsonpath
→ boolean
返回指定 JSON 值的 JSON 路径谓词检查结果。
（这仅适用于
谓词检查表达式，
不适用于 SQL 标准的 JSON 路径表达式，
因为如果路径结果不是单个布尔值，则会返回 NULL。）
'{"a":[1,2,3,4,5]}'::jsonb @@ '$.a[*] > 2'
→ true
注意
jsonpath 操作符 @?
和 @@ 抑制以下错误：缺少对象字段或数组元素，意外的 JSON 项目类型，日期时间和数字错误。  jsonpath 相关的函数也可以被告知抑制这些类型的错误。  在搜索不同结构的 JSON 文档集合时，此行为可能会有所帮助。
表 9.49 显示了用于构造 json 和 jsonb 值的函数。某些函数具有 RETURNING 子句，该子句指定返回的数据类型。它必须是 json、jsonb、bytea、字符字符串类型（text、char 或 varchar），或可以转换为 json 的类型。默认情况下，返回 json 类型。
表 9.49. JSON 创建函数
函数
描述
示例
to_json ( anyelement )
→ json
to_jsonb ( anyelement )
→ jsonb
将任何 SQL 值转换为 json 或 jsonb。数组和组合递归地转换为数组和对象（多维数组在 JSON 中变成数组的数组）。否则，如果存在从 SQL 数据类型到 json 的类型转换，则转换函数将用于执行转换；[a]
否则，将生成一个标量 JSON 值。对于除数字、布尔值或空值之外的任何标量，将使用文本表示，并根据需要进行转义，使其成为有效的 JSON 字符串值。
to_json('Fred said "Hi."'::text)
→ "Fred said \"Hi.\""
to_jsonb(row(42, 'Fred said "Hi."'::text))
→ {"f1": 42, "f2": "Fred said \"Hi.\""}
array_to_json ( anyarray [, boolean ] )
→ json
将 SQL 数组转换为 JSON 数组。该行为与 to_json 相同，只是如果可选 boolean 参数为真，换行符将在顶级数组元素之间添加。
array_to_json('{{1,5},{99,100}}'::int[])
→ [[1,5],[99,100]]
json_array (
[ { value_expression [ FORMAT JSON ] } [, ...] ]
[ { NULL | ABSENT } ON NULL ]
[ RETURNING data_type [ FORMAT JSON [ ENCODING UTF8 ] ] ])
json_array (
[ query_expression ]
[ RETURNING data_type [ FORMAT JSON [ ENCODING UTF8 ] ] ])
从一系列value_expression参数或
query_expression的结果中构造一个JSON数组，
其中query_expression必须是返回单列的SELECT查询。
如果指定了ABSENT ON NULL，则会忽略NULL值。
如果使用query_expression，情况始终如此。
json_array(1,true,json '{"a":null}')
→ [1, true, {"a":null}]
json_array(SELECT * FROM (VALUES(1),(2)) t)
→ [1, 2]
row_to_json ( record [, boolean ] )
→ json
将SQL组合值转换为JSON对象。该行为与to_json相同，只是如果可选boolean参数为真，换行符将在顶级元素之间添加。
row_to_json(row(1,'foo'))
→ {"f1":1,"f2":"foo"}
json_build_array ( VARIADIC "any" )
→ json
jsonb_build_array ( VARIADIC "any" )
→ jsonb
根据可变参数列表构建可能异构类型的JSON数组。每个参数都按照to_json或to_jsonb进行转换。
json_build_array(1, 2, 'foo', 4, 5)
→ [1, 2, "foo", 4, 5]
json_build_object ( VARIADIC "any" )
→ json
jsonb_build_object ( VARIADIC "any" )
→ jsonb
根据可变参数列表构建一个JSON对象。按照惯例，参数列表由交替的键和值组成。
关键参数强制转换为文本；值参数按照to_json或to_jsonb进行转换。
json_build_object('foo', 1, 2, row(3,'bar'))
→ {"foo" : 1, "2" : {"f1":3,"f2":"bar"}}
json_object (
[ { key_expression { VALUE | ':' }
value_expression [ FORMAT JSON [ ENCODING UTF8 ] ] }[, ...] ]
[ { NULL | ABSENT } ON NULL ]
[ { WITH | WITHOUT } UNIQUE [ KEYS ] ]
[ RETURNING data_type [ FORMAT JSON [ ENCODING UTF8 ] ] ])
构造一个包含所有给定键/值对的JSON对象，
如果未提供任何键/值对，则构造一个空对象。
key_expression 是一个标量表达式，
用于定义JSON键，该键会被转换为
text类型。
它不能为NULL，也不能属于
具有到json类型转换的类型。
如果指定了WITH UNIQUE KEYS，则不能有重复的
key_expression。
对于任何value_expression计算结果为
NULL的键值对，如果指定了
ABSENT ON NULL，则会从输出中省略；
如果指定了NULL ON NULL或省略了该子句，
则键会包含值NULL。
json_object('code' VALUE 'P123', 'title': 'Jaws')
→ {"code" : "P123", "title" : "Jaws"}
json_object ( text[] )
→ json
jsonb_object ( text[] )
→ jsonb
从文本数组构建JSON对象。该数组必须有一个维度且成员数为偶数，在这种情况下，它们被视为交替的键/值对；或者有两个维度，每个内部数组恰好有两个元素，它们被视为键/值对。所有值都转换为JSON字符串。
json_object('{a, 1, b, "def", c, 3.5}')
→ {"a" : "1", "b" : "def", "c" : "3.5"}
json_object('{{a, 1}, {b, "def"}, {c, 3.5}}')
→ {"a" : "1", "b" : "def", "c" : "3.5"}
json_object ( keys text[], values text[] )
→ json
jsonb_object ( keys text[], values text[] )
→ jsonb
这种形式的json_object从单独的文本数组中成对地获取键和值。否则，它与单参数形式相同。
json_object('{a,b}', '{1,2}')
→ {"a": "1", "b": "2"}
json (
表达式
[ FORMAT JSON [ ENCODING UTF8 ]]
[ { WITH | WITHOUT } UNIQUE [ KEYS ]] )
→ json
将指定为text或bytea字符串（UTF8编码）的给定表达式转换为JSON值。
如果表达式为NULL，则返回一个SQL空值。
如果指定了WITH UNIQUE，则表达式中不得包含任何重复的对象键。
json('{"a":123, "b":[true,"foo"], "a":"bar"}')
→ {"a":123, "b":[true,"foo"], "a":"bar"}
json_scalar ( expression )
将给定的 SQL 标量值转换为 JSON 标量值。如果输入为 NULL，则返回一个
SQL 空值。如果输入是数字或布尔值，则返回相应的 JSON 数字
或布尔值。对于任何其他值，返回 JSON 字符串。
json_scalar(123.45)
→ 123.45
json_scalar(CURRENT_TIMESTAMP)
→ "2022-05-10T10:51:04.62128-04:00"
json_serialize (
expression [ FORMAT JSON [ ENCODING UTF8 ] ]
[ RETURNING data_type [ FORMAT JSON [ ENCODING UTF8 ] ] ] )
将 SQL/JSON 表达式转换为字符或二进制字符串。expression 可以是任意 JSON 类型、任意字符字符串类型，或 UTF8 编码的 bytea。RETURNING 中使用的返回类型可以是任意字符串类型或 bytea。默认类型是 text。
json_serialize('{ "a" : 1 } ' RETURNING bytea)
→ \x7b20226122203a2031207d20
[a]
例如，hstore 扩展有一个从 hstore 到 json 的转换，这样通过 JSON 创建函数转换的 hstore 值将被表示为 JSON 对象，而不是原始字符串值。
表 9.50 详细介绍了用于测试 JSON 的
SQL/JSON 功能。
表 9.50. SQL/JSON 测试函数
函数签名
描述
示例
expression IS [ NOT ] JSON
[ { VALUE | SCALAR | ARRAY | OBJECT } ]
[ { WITH | WITHOUT } UNIQUE [ KEYS ] ]
此谓词用于测试 expression 是否可以解析为 JSON，可能是指定类型的 JSON。
如果指定了 SCALAR 或 ARRAY 或
OBJECT，则测试 JSON 是否属于该特定类型。如果
WITH UNIQUE KEYS 被指定，则 expression 中的任何对象也会被测试是否具有重复键。
SELECT js,
js IS JSON "json?",
js IS JSON SCALAR "scalar?",
js IS JSON OBJECT "object?",
js IS JSON ARRAY "array?"
FROM (VALUES
('123'), ('"abc"'), ('{"a": "b"}'), ('[1,2]'),('abc')) foo(js);
js     | json? | scalar? | object? | array?
------------+-------+---------+---------+--------
123        | t     | t       | f       | f
"abc"      | t     | t       | f       | f
{"a": "b"} | t     | f       | t       | f
[1,2]      | t     | f       | f       | t
abc        | f     | f       | f       | f
SELECT js,
js IS JSON OBJECT "object?",
js IS JSON ARRAY "array?",
js IS JSON ARRAY WITH UNIQUE KEYS "array w. UK?",
js IS JSON ARRAY WITHOUT UNIQUE KEYS "array w/o UK?"
FROM (VALUES ('[{"a":"1"},
{"b":"2","b":"3"}]')) foo(js);
-[ RECORD 1 ]-+--------------------
js            | [{"a":"1"},        +
|  {"b":"2","b":"3"}]
object?       | f
array?        | t
array w. UK?  | f
array w/o UK? | t
表 9.51 显示可用于处理 json 和 jsonb 值的函数。
表 9.51. JSON 处理函数
函数
描述
示例
json_array_elements ( json )
→ setof json
jsonb_array_elements ( jsonb )
→ setof jsonb
将顶级JSON数组展开为一组JSON值。
select * from json_array_elements('[1,true, [2,false]]')
→
value
-----------
1
true
[2,false]
json_array_elements_text ( json )
→ setof text
jsonb_array_elements_text ( jsonb )
→ setof text
将顶级JSON数组展开为一组text值。
select * from json_array_elements_text('["foo", "bar"]')
→
value
-----------
foo
bar
json_array_length ( json )
→ integer
jsonb_array_length ( jsonb )
→ integer
返回顶层JSON数组中的元素数量。
json_array_length('[1,2,3,{"f1":1,"f2":[5,6]},4]')
→ 5
jsonb_array_length('[]')
→ 0
json_each ( json )
→ setof record
( key text,
value json )
jsonb_each ( jsonb )
→ setof record
( key text,
value jsonb )
将顶级JSON对象展开为一组键/值对。
select * from json_each('{"a":"foo", "b":"bar"}')
→
key | value
-----+-------
a   | "foo"
b   | "bar"
json_each_text ( json )
→ setof record
( key text,
value text )
jsonb_each_text ( jsonb )
→ setof record
( key text,
value text )
将顶级JSON对象扩展为一组键/值对。返回的值的类型为text。
select * from json_each_text('{"a":"foo", "b":"bar"}')
→
key | value
-----+-------
a   | foo
b   | bar
json_extract_path ( from_json json, VARIADIC path_elems text[] )
→ json
jsonb_extract_path ( from_json jsonb, VARIADIC path_elems text[] )
→ jsonb
在指定路径下提取JSON子对象。(这在功能上相当于#>操作符，但在某些情况下，将路径写成可变参数列表会更方便。)
json_extract_path('{"f2":{"f3":1},"f4":{"f5":99,"f6":"foo"}}', 'f4', 'f6')
→ "foo"
json_extract_path_text ( from_json json, VARIADIC path_elems text[] )
→ text
jsonb_extract_path_text ( from_json jsonb, VARIADIC path_elems text[] )
→ text
将指定路径上的JSON子对象提取为text。(这在功能上等同于#>>操作符。)
json_extract_path_text('{"f2":{"f3":1},"f4":{"f5":99,"f6":"foo"}}', 'f4', 'f6')
→ foo
json_object_keys ( json )
→ setof text
jsonb_object_keys ( jsonb )
→ setof text
返回顶级JSON对象中的键集合。
select * from json_object_keys('{"f1":"abc","f2":{"f3":"a", "f4":"b"}}')
→
json_object_keys
------------------
f1
f2
json_populate_record ( base anyelement, from_json json )
→ anyelement
jsonb_populate_record ( base anyelement, from_json jsonb )
→ anyelement
将顶级JSON对象扩展为具有base参数的复合类型的行。JSON对象将被扫描，查找名称与输出行类型的列名匹配的字段，并将它们的值插入到输出的这些列中。
(不对应任何输出列名的字段将被忽略。)在典型的使用中，base的值仅为NULL，这意味着任何不匹配任何对象字段的输出列都将被填充为空。
但是，如果base不为NULL，那么它包含的值将用于不匹配的列。
要将JSON值转换为输出列的SQL类型，需要按次序应用以下规则:
在所有情况下，JSON空值都会转换为SQL空值。
如果输出列的类型是json或jsonb，则会精确地重制JSON值。
如果输出列是复合(行)类型，且JSON值是JSON对象，则该对象的字段将转换为输出行类型的列，通过这些规则的递归应用。
同样，如果输出列是数组类型，而JSON值是JSON数组，则通过这些规则的递归应用将JSON数组的元素转换为输出数组的元素。
否则，如果JSON值是字符串，则将字符串的内容提供给输入转换函数，用以确定列的数据类型。
否则，JSON值的普通文本表示将被提供给输入转换函数，以确定列的数据类型。
虽然下面的示例使用一个常量JSON值，典型的用法是在查询的FROM子句中从另一个表侧面地引用json或jsonb列。
在FROM子句中编写json_populate_record是一种很好的实践，因为提取的所有列都可以使用，而不需要重复的函数调用。
create type subrowtype as (d int, e text);
create type myrowtype as (a int, b text[], c subrowtype);
select * from json_populate_record(null::myrowtype,
'{"a": 1, "b": ["2", "a b"], "c": {"d": 4, "e": "a  b c"}, "x": "foo"}')
→
a |   b       |      c
---+-----------+-------------
1 | {2,"a b"} | (4,"a b c")
jsonb_populate_record_valid ( base anyelement, from_json json )
→ boolean
用于测试 jsonb_populate_record 的函数。如果输入的 jsonb_populate_record
对给定的 JSON 对象能正常完成，则返回 true；也就是说，输入有效，
否则返回 false。
create type jsb_char2 as (a char(2));
select jsonb_populate_record_valid(NULL::jsb_char2, '{"a": "aaa"}');
→
jsonb_populate_record_valid
-----------------------------
f
(1 row)
select * from jsonb_populate_record(NULL::jsb_char2, '{"a": "aaa"}') q;
→
ERROR:  value too long for type character(2)
select jsonb_populate_record_valid(NULL::jsb_char2, '{"a": "aa"}');
→
jsonb_populate_record_valid
-----------------------------
t
(1 row)
select * from jsonb_populate_record(NULL::jsb_char2, '{"a": "aa"}') q;
→
a
----
aa
(1 row)
json_populate_recordset ( base anyelement, from_json json )
→ setof anyelement
jsonb_populate_recordset ( base anyelement, from_json jsonb )
→ setof anyelement
将对象的顶级JSON数组展开为一组具有base参数的复合类型的行。
对于json[b]_populate_record，将如上所述处理JSON数组的每个元素。
create type twoints as (a int, b int);
select * from json_populate_recordset(null::twoints, '[{"a":1,"b":2}, {"a":3,"b":4}]')
→
a | b
---+---
1 | 2
3 | 4
json_to_record ( json )
→ record
jsonb_to_record ( jsonb )
→ record
将顶级JSON对象展开为具有由 AS子句定义的复合类型的行。
(与所有返回record的函数一样，调用查询必须使用AS子句显式定义记录的结构。)
输出记录由JSON对象的字段填充，与上面描述的json[b]_populate_record的方式相同。
由于没有输入记录值，不匹配的列总是用空值填充。
create type myrowtype as (a int, b text);
select * from json_to_record('{"a":1,"b":[1,2,3],"c":[1,2,3],"e":"bar","r": {"a": 123, "b": "a b c"}}') as x(a int, b text, c int[], d text, r myrowtype)
→
a |    b    |    c    | d |       r
---+---------+---------+---+---------------
1 | [1,2,3] | {1,2,3} |   | (123,"a b c")
json_to_recordset ( json )
→ setof record
jsonb_to_recordset ( jsonb )
→ setof record
将顶级JSON对象数组展开为一组由AS子句定义的复合类型的行。
(与所有返回record的函数一样，调用查询必须使用AS子句显式定义记录的结构。)
对于json[b]_populate_record，将如上所述处理JSON数组的每个元素。
select * from json_to_recordset('[{"a":1,"b":"foo"}, {"a":"2","c":"bar"}]') as x(a int, b text)
→
a |  b
---+-----
1 | foo
2 |
jsonb_set ( target jsonb, path text[], new_value jsonb [, create_if_missing boolean ] )
→ jsonb
返回target，将path指定的项替换为new_value，
如果create_if_missing为真(此为默认值)并且path指定的项不存在，则添加new_value。
路径中的所有前面步骤都必须存在，否则将不加改变地返回target。
与面向路径操作符一样，负整数出现在JSON数组末尾的path计数中。
如果最后一个路径步骤是超出范围的数组索引，并且create_if_missing为真，那么如果索引为负，新值将添加到数组的开头，如果索引为正，则添加到数组的结尾。
jsonb_set('[{"f1":1,"f2":null},2,null,3]', '{0,f1}', '[2,3,4]', false)
→ [{"f1": [2, 3, 4], "f2": null}, 2, null, 3]
jsonb_set('[{"f1":1,"f2":null},2]', '{0,f3}', '[2,3,4]')
→ [{"f1": 1, "f2": null, "f3": [2, 3, 4]}, 2]
jsonb_set_lax ( target jsonb, path text[], new_value jsonb [, create_if_missing boolean [, null_value_treatment text ]] )
→ jsonb
如果new_value不是NULL，则行为与jsonb_set完全相同。否则，根据null_value_treatment的值进行处理，其值必须是'raise_exception'、'use_json_null'、'delete_key'或'return_target'之一。默认值为'use_json_null'。
jsonb_set_lax('[{"f1":1,"f2":null},2,null,3]', '{0,f1}', null)
→ [{"f1": null, "f2": null}, 2, null, 3]
jsonb_set_lax('[{"f1":99,"f2":null},2]', '{0,f3}', null, true, 'return_target')
→ [{"f1": 99, "f2": null}, 2]
jsonb_insert ( target jsonb, path text[], new_value jsonb [, insert_after boolean ] )
→ jsonb
返回插入new_value的target。
如果path指派的项是一个数组元素，如果 insert_after为假（此为默认值），则new_value将被插入到该项之前，如果 insert_after为真则在该项之后。
如果由path指派的项是一个对象字段，则只在对象不包含该键时才插入 new_value。
路径中的所有前面步骤都必须存在，否则将不加改变地返回target。
与面向路径操作符一样，负整数出现在JSON数组末尾的 path计数中。
如果最后一个路径步骤是超出范围的数组下标，则如果下标为负，则将新值添加到数组的开头；如果下标为正，则将新值添加到数组的结尾。
jsonb_insert('{"a": [0,1,2]}', '{a, 1}', '"new_value"')
→ {"a": [0, "new_value", 1, 2]}
jsonb_insert('{"a": [0,1,2]}', '{a, 1}', '"new_value"', true)
→ {"a": [0, 1, "new_value", 2]}
json_strip_nulls ( target json [,strip_in_arrays boolean ] )
→ json
jsonb_strip_nulls ( target jsonb [,strip_in_arrays boolean ] )
→ jsonb
从给定的 JSON 值中递归删除所有具有 null 值的对象字段。
如果 strip_in_arrays 为 true（默认值为 false），
null 数组元素也会被删除。
否则，它们不会被删除。裸 null 值永远不会被删除。
json_strip_nulls('[{"f1":1, "f2":null}, 2, null, 3]')
→ [{"f1":1},2,null,3]
jsonb_strip_nulls('[1,2,null,3,4]', true)
→ [1,2,3,4]
jsonb_path_exists ( target jsonb, path jsonpath [, vars jsonb [, silent boolean ]] )
→ boolean
检查指定的 JSON 路径是否为给定的 JSON 值返回任何项。
（这仅适用于 SQL 标准的 JSON 路径表达式，不适用于
谓词检查表达式，
因为后者总是返回一个值。）
如果指定了 vars 参数，它必须是一个 JSON 对象，
其字段提供要替换到 jsonpath 表达式中的命名值。
如果指定了 silent 参数且值为
true，函数将抑制与 @? 和
@@ 操作符相同的错误。
jsonb_path_exists('{"a":[1,2,3,4,5]}', '$.a[*] ? (@ >= $min && @ <= $max)', '{"min":2, "max":4}')
→ t
jsonb_path_match ( target jsonb, path jsonpath [, vars jsonb [, silent boolean ]] )
→ boolean
返回指定 JSON 值的 JSON 路径谓词检查的 SQL 布尔结果。
（这仅适用于
谓词检查表达式，而非 SQL 标准的 JSON 路径表达式，
因为如果路径结果不是单个布尔值，它要么失败，要么返回 NULL。）
可选的 vars 和 silent 参数的作用与
jsonb_path_exists 相同。
jsonb_path_match('{"a":[1,2,3,4,5]}', 'exists($.a[*] ? (@ >= $min && @ <= $max))', '{"min":2, "max":4}')
→ t
jsonb_path_query ( target jsonb, path jsonpath [, vars jsonb [, silent boolean ]] )
→ setof jsonb
返回指定 JSON 值的 JSON 路径返回的所有 JSON 项。
对于 SQL 标准的 JSON 路径表达式，它返回从 target 中选取的 JSON 值。
对于 谓词检查表达式，它返回谓词检查的结果：
true、false 或 null。
可选的 vars 和 silent 参数的作用与
jsonb_path_exists 相同。
select * from jsonb_path_query('{"a":[1,2,3,4,5]}', '$.a[*] ? (@ >= $min && @ <= $max)', '{"min":2, "max":4}')
→
jsonb_path_query
-−-−-−-−-−-−-−-−-−
2
3
4
jsonb_path_query_array ( target jsonb, path jsonpath [, vars jsonb [, silent boolean ]] )
→ jsonb
返回指定 JSON 值的 JSON 路径返回的所有 JSON 项，作为 JSON 数组。
参数与 jsonb_path_query 相同。
jsonb_path_query_array('{"a":[1,2,3,4,5]}', '$.a[*] ? (@ >= $min && @ <= $max)', '{"min":2, "max":4}')
→ [2, 3, 4]
jsonb_path_query_first ( target jsonb, path jsonpath [, vars jsonb [, silent boolean ]] )
→ jsonb
返回指定 JSON 值的 JSON 路径返回的第一个 JSON 项，若无结果则返回
NULL。
参数与 jsonb_path_query 相同。
jsonb_path_query_first('{"a":[1,2,3,4,5]}', '$.a[*] ? (@ >= $min && @ <= $max)', '{"min":2, "max":4}')
→ 2
jsonb_path_exists_tz ( target jsonb, path jsonpath [, vars jsonb [, silent boolean ]] )
→ boolean
jsonb_path_match_tz ( target jsonb, path jsonpath [, vars jsonb [, silent boolean ]] )
→ boolean
jsonb_path_query_tz ( target jsonb, path jsonpath [, vars jsonb [, silent boolean ]] )
→ setof jsonb
jsonb_path_query_array_tz ( target jsonb, path jsonpath [, vars jsonb [, silent boolean ]] )
→ jsonb
jsonb_path_query_first_tz ( target jsonb, path jsonpath [, vars jsonb [, silent boolean ]] )
→ jsonb
这些函数的作用类似于上面描述的没有_tz后缀的对应函数，不同之处在于这些函数支持需要时区感知转换的日期/时间值的比较。
下面的示例需要将仅日期值2015-08-02解释为带有时区的时间戳，因此结果取决于当前的TimeZone设置。
由于这种依赖性，这些函数被标记为稳定的，这意味着这些函数不能用于索引。它们的对应函数是不可变的，因此可以用于索引；但如果要求进行这样的比较，它们将抛出错误。
jsonb_path_exists_tz('["2015-08-01 12:00:00-05"]', '$[*] ? (@.datetime() < "2015-08-02".datetime())')
→ t
jsonb_pretty ( jsonb )
→ text
将给定的 JSON 值转换为精美打印的、缩进的文本。
jsonb_pretty('[{"f1":1,"f2":null}, 2]')
→
[
{
"f1": 1,
"f2": null
},
2
]
json_typeof ( json )
→ text
jsonb_typeof ( jsonb )
→ text
以文本字符串形式返回顶级 JSON 值的类型。可能的类型有
object、array、
string、number、
boolean 和 null。
（null 的结果不应该与 SQL NULL 混淆；
参见示例。）
json_typeof('-123.4')
→ number
json_typeof('null'::json)
→ null
json_typeof(NULL::json) IS NULL
→ t
9.16.2. SQL/JSON 路径语言 #
SQL/JSON 路径表达式指定要从 JSON 值中检索的项，类似于用于访问 XML
内容的 XPath 表达式。在 PostgreSQL 中，路径表达式
作为 jsonpath 数据类型实现，并且可以使用
第 8.14.7 节 中描述的任何元素。
JSON 查询函数和操作符将提供的路径表达式传递给 路径引擎
进行评估。如果表达式匹配查询的 JSON 数据，则返回相应的 JSON 项或项目集合。
如果没有匹配，结果将是 NULL、false 或错误，具体取决于函数。
路径表达式使用 SQL/JSON 路径语言编写，可以包含算术表达式和函数。
路径表达式由 jsonpath 数据类型允许的元素序列组成。
路径表达式通常从左向右求值，但你可以使用圆括号来更改操作的顺序。
如果计算成功，将生成一系列 JSON 项，并将计算结果返回到 JSON 查询函数，
该函数将完成指定的计算。
要引用被查询的 JSON 值（上下文项），请在路径表达式中使用
$ 变量。路径的第一个元素必须始终是
$。它后面可以跟一个或多个
访问器操作符，
这些操作符逐级深入 JSON 结构，以检索上下文项的子项。每个访问器操作符作用于
上一步评估的结果，从每个输入项产生零个、一个或多个输出项。
例如，假设你有一些来自GPS追踪器的JSON数据，想要解析，比如：
SELECT '{
"track": {
"segments": [
{
"location":   [ 47.763, 13.4034 ],
"start time": "2018-10-14 10:05:14",
"HR": 73
},
{
"location":   [ 47.706, 13.2635 ],
"start time": "2018-10-14 10:39:21",
"HR": 135
}
]
}
}' AS json \gset
（以上示例可以复制粘贴到psql中，为以下示例做准备。
然后psql会将:'json'展开成一个合适的带引号字符串常量，
其中包含JSON值。）
要检索可用的轨道段，您需要使用
.key 访问运算符
来遍历周围的 JSON 对象，例如：
=> select jsonb_path_query(:'json', '$.track.segments');
jsonb_path_query
-----------------------------------------------------------​-----------------------------------------------------------​---------------------------------------------
[{"HR": 73, "location": [47.763, 13.4034], "start time": "2018-10-14 10:05:14"}, {"HR": 135, "location": [47.706, 13.2635], "start time": "2018-10-14 10:39:21"}]
要检索数组的内容，通常使用[*]操作符。
下面的示例将返回所有可用轨道段的位置坐标：
=> select jsonb_path_query(:'json', '$.track.segments[*].location');
jsonb_path_query
-------------------
[47.763, 13.4034]
[47.706, 13.2635]
这里我们从整个JSON输入值($)开始，
然后.track访问器选择了与"track"对象键相关联的JSON对象，
接着.segments访问器选择了该对象中与"segments"键相关联的JSON数组，
然后[*]访问器选择该数组的每个元素（产生一系列项），
最后.location访问器选择了每个对象中与"location"键相关联的JSON数组。
在此示例中，每个对象都有一个"location"键；
但如果其中任何一个没有，.location访问器将不会为该输入项产生输出。
要仅返回第一个段的坐标，可以在[]访问运算符中指定相应的下标。请记住，JSON数组索引是从0开始的：
=> select jsonb_path_query(:'json', '$.track.segments[0].location');
jsonb_path_query
-------------------
[47.763, 13.4034]
每个路径求值步骤的结果可以通过一个或多个列在
jsonpath 操作符和方法进行处理，这些操作符和方法列于
第 9.16.2.3 节中。每个方法名前必须加点。
例如，你可以获取数组的大小：
=> select jsonb_path_query(:'json', '$.track.segments.size()');
jsonb_path_query
------------------
2
更多在路径表达式中使用 jsonpath 操作符和方法的示例
请参见下文的 第 9.16.2.3 节。
路径还可以包含
过滤表达式，其工作方式类似于SQL中的
WHERE子句。过滤表达式以问号开头，并在括号中提供条件：
? (condition)
过滤表达式必须写在应应用该表达式的路径求值步骤之后。该步骤的结果会被过滤，
仅包含满足所提供条件的项。SQL/JSON 定义了三值逻辑，因此条件可以产生
true、false或unknown。
unknown值的作用与 SQL 中的NULL相同，
可以使用is unknown谓词进行测试。后续的路径求值步骤仅使用
过滤表达式返回true的项。
可以在过滤表达式中使用的函数和操作符列在表 9.53中。
在过滤表达式中，@变量表示正在考虑的值（即前面路径步骤的一个结果）。
你可以在@后面编写访问操作符以检索组件项。
例如，假设您想检索所有高于130的心率值。您可以按如下方式实现：
=> select jsonb_path_query(:'json', '$.track.segments[*].HR ? (@ > 130)');
jsonb_path_query
------------------
135
要获取具有此类值的片段的开始时间，必须先过滤掉无关的片段，然后再选择开始时间，
因此过滤表达式应用于上一步，且条件中使用的路径不同：
=> select jsonb_path_query(:'json', '$.track.segments[*] ? (@.HR > 130)."start time"');
jsonb_path_query
-----------------------
"2018-10-14 10:39:21"
您可以按顺序使用多个过滤表达式（如有需要）。
下面的示例选择所有包含相关坐标位置且心率值较高的片段的开始时间：
=> select jsonb_path_query(:'json', '$.track.segments[*] ? (@.location[1] < 13.4) ? (@.HR > 130)."start time"');
jsonb_path_query
-----------------------
"2018-10-14 10:39:21"
也允许在不同嵌套层级使用过滤表达式。下面的示例首先按位置过滤所有段，
然后返回这些段的高心率值（如果有的话）：
=> select jsonb_path_query(:'json', '$.track.segments[*] ? (@.location[1] < 13.4).HR ? (@ > 130)');
jsonb_path_query
------------------
135
您也可以将过滤表达式嵌套使用。
这个示例返回轨迹的大小（如果它包含任何心率值较高的片段），否则返回空序列：
=> select jsonb_path_query(:'json', '$.track ? (exists(@.segments[*] ? (@.HR > 130))).segments.size()');
jsonb_path_query
------------------
2
9.16.2.1. 偏离 SQL 标准 #
PostgreSQL对SQL/JSON路径语言的实现与SQL/JSON标准存在以下偏差。
9.16.2.1.1. 布尔谓词检查表达式 #
作为SQL标准的扩展，PostgreSQL路径表达式可以是一个布尔谓词，
而SQL标准只允许在过滤器中使用谓词。虽然SQL标准的路径表达式返回被查询JSON值的相关
元素，谓词检查表达式返回谓词的单个三值jsonb结果：true、
false或null。
例如，我们可以写出如下SQL标准的过滤表达式：
=> select jsonb_path_query(:'json', '$.track.segments ?(@[*].HR > 130)');
jsonb_path_query
-----------------------------------------------------------​----------------------
{"HR": 135, "location": [47.706, 13.2635], "start time": "2018-10-14 10:39:21"}
类似的谓词检查表达式仅返回true，表示存在匹配：
=> select jsonb_path_query(:'json', '$.track.segments[*].HR > 130');
jsonb_path_query
------------------
true
注意
谓词检查表达式是@@操作符（以及
jsonb_path_match函数）中必需的，不应与
@?操作符（或
jsonb_path_exists函数）一起使用。
9.16.2.1.2. 正则表达式解释 #
在like_regex过滤器中使用的正则表达式模式的解释存在细微差异，
如第 9.16.2.4 节中所述。
9.16.2.2. 严格模式（Strict）和宽松模式（Lax） #
当您查询 JSON 数据时，路径表达式可能与实际的 JSON 数据结构不匹配。
试图访问对象的不存在成员或数组的不存在元素被定义为结构错误。
SQL/JSON 路径表达式有两种处理结构错误的模式：
宽松模式（lax，默认）— 路径引擎会隐式地将查询的数据适配到指定的路径。
任何无法按以下描述修复的结构错误都会被抑制，不会产生匹配结果。
严格模式（strict）—如果发生了结构错误，则会引发错误。
宽松模式便于在 JSON 数据不符合预期模式时匹配 JSON 文档和路径表达式。
如果操作数不符合特定操作的要求，可以自动将其包装为 SQL/JSON 数组，
或通过将其元素转换为 SQL/JSON 序列来解包，然后执行操作。此外，比较运算符
在宽松模式下会自动解包其操作数，因此您可以开箱即用地比较 SQL/JSON 数组。
大小为 1 的数组被视为等同于其唯一元素。以下情况不会执行自动解包：
路径表达式包含返回数组类型和元素数量的 type() 或
size() 方法。
查询的 JSON 数据包含嵌套数组。在这种情况下，仅最外层数组会被解包，
所有内层数组保持不变。因此，隐式解包只能在每个路径评估步骤中向下
进行一级。
例如，当查询上述列出的 GPS 数据时，您可以在使用宽松模式时
抽象出它存储了一个段数组的事实：
=> select jsonb_path_query(:'json', 'lax $.track.segments.location');
jsonb_path_query
-------------------
[47.763, 13.4034]
[47.706, 13.2635]
在严格模式下，指定的路径必须与被查询的 JSON 文档结构完全匹配，
因此使用此路径表达式会导致错误：
=> select jsonb_path_query(:'json', 'strict $.track.segments.location');
ERROR:  jsonpath member accessor can only be applied to an object
若要获得与宽松模式相同的结果，必须显式地展开
segments 数组：
=> select jsonb_path_query(:'json', 'strict $.track.segments[*].location');
jsonb_path_query
-------------------
[47.763, 13.4034]
[47.706, 13.2635]
宽松模式的展开行为可能导致意想不到的结果。例如，下面使用 .** 访问器的查询
会选中每个 HR 值两次：
=> select jsonb_path_query(:'json', 'lax $.**.HR');
jsonb_path_query
-------------------
73
135
73
135
这是因为 .** 访问器既选择了 segments 数组，也选择了它的每个元素，
而 .HR 访问器在使用宽松模式时会自动展开数组。为了避免意外结果，
我们建议仅在严格模式下使用 .** 访问器。下面的查询只会选中每个 HR 值一次：
=> select jsonb_path_query(:'json', 'strict $.**.HR');
jsonb_path_query
-------------------
73
135
数组的展开也可能导致意想不到的结果。考虑下面这个示例，它选择了所有的
location 数组：
=> select jsonb_path_query(:'json', 'lax $.track.segments[*].location');
jsonb_path_query
-------------------
[47.763, 13.4034]
[47.706, 13.2635]
(2 rows)
正如预期，它返回了完整的数组。但应用过滤表达式会导致数组被展开以评估每个
项目，只返回匹配表达式的项目：
=> select jsonb_path_query(:'json', 'lax $.track.segments[*].location ?(@[*] > 15)');
jsonb_path_query
-------------------
47.763
47.706
(2 rows)
尽管路径表达式选择的是完整的数组。使用严格模式可以恢复选择数组的行为：
=> select jsonb_path_query(:'json', 'strict $.track.segments[*].location ?(@[*] > 15)');
jsonb_path_query
-------------------
[47.763, 13.4034]
[47.706, 13.2635]
(2 rows)
9.16.2.3. SQL/JSON 路径操作符和方法 #
表 9.52 显示了 jsonpath 中可用的运算符和方法。
注意，虽然一元运算符和方法可以应用于前一步路径产生的多个值，但二元运算符（加法等）
只能应用于单个值。在宽松模式下，应用于数组的方法会对数组中的每个值执行。例外的是
.type() 和 .size()，它们作用于数组本身。
表 9.52. jsonpath 操作符和方法
操作符/方法
描述
示例
number + number
→ number
加法
jsonb_path_query('[2]', '$[0] + 3')
→ 5
+ number
→ number
一元加号（无操作）；与加法不同，这个可以迭代多个值
jsonb_path_query_array('{"x": [2,3,4]}', '+ $.x')
→ [2, 3, 4]
number - number
→ number
减法
jsonb_path_query('[2]', '7 - $[0]')
→ 5
- number
→ number
否定；与减法不同，它可以迭代多个值
jsonb_path_query_array('{"x": [2,3,4]}', '- $.x')
→ [-2, -3, -4]
number * number
→ number
乘法
jsonb_path_query('[4]', '2 * $[0]')
→ 8
number / number
→ number
除法
jsonb_path_query('[8.5]', '$[0] / 2')
→ 4.2500000000000000
number % number
→ number
模数（余数）
jsonb_path_query('[32]', '$[0] % 10')
→ 2
value . type()
→ string
JSON项的类型 (参见 json_typeof)
jsonb_path_query_array('[1, "2", {}]', '$[*].type()')
→ ["number", "string", "object"]
value . size()
→ number
JSON项的大小（数组元素的数量，如果不是数组则为1）
jsonb_path_query('{"m": [11, 15]}', '$.m.size()')
→ 2
value . boolean()
→ boolean
从 JSON 布尔值、数字或字符串转换而来的布尔值
jsonb_path_query_array('[1, "yes", false]', '$[*].boolean()')
→ [true, true, false]
value . string()
→ string
从 JSON 布尔值、数字、字符串或日期时间转换而来的字符串值
jsonb_path_query_array('[1.23, "xyz", false]', '$[*].string()')
→ ["1.23", "xyz", "false"]
jsonb_path_query('"2023-08-15 12:34:56"', '$.timestamp().string()')
→ "2023-08-15T12:34:56"
value . double()
→ number
从 JSON 数字或字符串转换过来的近似浮点数
jsonb_path_query('{"len": "1.9"}', '$.len.double() * 2')
→ 3.8
number . ceiling()
→ number
大于或等于给定数字的最接近的整数
jsonb_path_query('{"h": 1.3}', '$.h.ceiling()')
→ 2
number . floor()
→ number
小于或等于给定数字的最近整数
jsonb_path_query('{"h": 1.7}', '$.h.floor()')
→ 1
number . abs()
→ number
给定数字的绝对值
jsonb_path_query('{"z": -0.3}', '$.z.abs()')
→ 0.3
value . bigint()
→ bigint
从 JSON 数字或字符串转换而来的大整数值
jsonb_path_query('{"len": "9876543219"}', '$.len.bigint()')
→ 9876543219
value . decimal( [ precision [ , scale ] ] )
→ decimal
从 JSON 数字或字符串转换的四舍五入十进制值
（precision 和 scale 必须是整数值）
jsonb_path_query('1234.5678', '$.decimal(6, 2)')
→ 1234.57
value . integer()
→ integer
从 JSON 数字或字符串转换而来的整数值
jsonb_path_query('{"len": "12345"}', '$.len.integer()')
→ 12345
value . number()
→ numeric
从 JSON 数字或字符串转换而来的数值
jsonb_path_query('{"len": "123.45"}', '$.len.number()')
→ 123.45
string . datetime()
→ datetime_type
(see note)
从字符串转换过来的日期/时间值
jsonb_path_query('["2015-8-1", "2015-08-12"]', '$[*] ? (@.datetime() < "2015-08-2".datetime())')
→ "2015-8-1"
string . datetime(template)
→ datetime_type
(see note)
使用指定的to_timestamp模板从字符串转换过来的日期/时间值
jsonb_path_query_array('["12:30", "18:40"]', '$[*].datetime("HH24:MI")')
→ ["12:30:00", "18:40:00"]
string . date()
→ date
从字符串转换而来的日期值
jsonb_path_query('"2023-08-15"', '$.date()')
→ "2023-08-15"
string . time()
→ time without time zone
从字符串转换而来的无时区时间值
jsonb_path_query('"12:34:56"', '$.time()')
→ "12:34:56"
string . time(precision)
→ time without time zone
从字符串转换而来的无时区时间值，带有调整到给定精度的分数秒
jsonb_path_query('"12:34:56.789"', '$.time(2)')
→ "12:34:56.79"
string . time_tz()
→ time with time zone
从字符串转换而来的带时区时间值
jsonb_path_query('"12:34:56 +05:30"', '$.time_tz()')
→ "12:34:56+05:30"
string . time_tz(precision)
→ time with time zone
从字符串转换而来的带时区时间值，带有根据给定精度调整的
小数秒
jsonb_path_query('"12:34:56.789 +05:30"', '$.time_tz(2)')
→ "12:34:56.79+05:30"
string . timestamp()
→ timestamp without time zone
从字符串转换而来的无时区时间戳值
jsonb_path_query('"2023-08-15 12:34:56"', '$.timestamp()')
→ "2023-08-15T12:34:56"
string . timestamp(precision)
→ timestamp without time zone
从字符串转换而来的无时区时间戳值，带有根据给定精度调整的
小数秒
jsonb_path_query('"2023-08-15 12:34:56.789"', '$.timestamp(2)')
→ "2023-08-15T12:34:56.79"
string . timestamp_tz()
→ timestamp with time zone
从字符串转换而来的带时区时间戳值
jsonb_path_query('"2023-08-15 12:34:56 +05:30"', '$.timestamp_tz()')
→ "2023-08-15T12:34:56+05:30"
string . timestamp_tz(precision)
→ timestamp with time zone
从字符串转换而来的带时区时间戳值，分秒部分根据给定的精度进行调整
jsonb_path_query('"2023-08-15 12:34:56.789 +05:30"', '$.timestamp_tz(2)')
→ "2023-08-15T12:34:56.79+05:30"
object . keyvalue()
→ array
对象的键值对，表示为包含三个字段的对象数组："key"，
"value"，和"id"；"id"是键值对所归属对象的唯一标识符
jsonb_path_query_array('{"x": "20", "y": 32}', '$.keyvalue()')
→ [{"id": 0, "key": "x", "value": "20"}, {"id": 0, "key": "y", "value": 32}]
注意
datetime() 和datetime(template)方法的结果类型可以是date, timetz, time, timestamptz, 或 timestamp。
这两个方法都动态地确定它们的结果类型。
datetime()方法依次尝试将其输入字符串与date, timetz, time, timestamptz, 和 timestamp的ISO格式进行匹配。
它在第一个匹配格式时停止，并发出相应的数据类型。
datetime(template)方法根据所提供的模板字符串中使用的字段确定结果类型。
datetime()和datetime(template)方法使用与to_timestamp SQL函数相同的解析规则(see 第 9.8 节)，但有三个例外。
首先，这些方法不允许不匹配的模板模式。
其次，模板字符串中只允许以下分隔符:减号、句点、斜杠、逗号、撇号、分号、冒号和空格。
第三，模板字符串中的分隔符必须与输入字符串完全匹配。
如果需要比较不同的日期/时间类型，将应用隐式转换。date值可以转换为
timestamp或timestamptz，timestamp可以转换为
timestamptz，time可以转换为timetz。
但是，除第一个转换外，所有这些转换都依赖于当前的TimeZone
设置，因此只能在支持时区的jsonpath函数中执行。类似地，其他将字符串转换为
日期/时间类型的方法也会进行此类转换，这可能涉及当前的TimeZone
设置。因此，这些转换也只能在支持时区的jsonpath函数中执行。
表 9.53显示了可用的过滤器表达式元素。
表 9.53. jsonpath 过滤器表达式元素
谓词/值
描述
示例
value == value
→ boolean
相等比较（这个，和其他比较操作符，适用于所有JSON标量值）
jsonb_path_query_array('[1, "a", 1, 3]', '$[*] ? (@ == 1)')
→ [1, 1]
jsonb_path_query_array('[1, "a", 1, 3]', '$[*] ? (@ == "a")')
→ ["a"]
value != value
→ boolean
value <> value
→ boolean
不相等比较
jsonb_path_query_array('[1, 2, 1, 3]', '$[*] ? (@ != 1)')
→ [2, 3]
jsonb_path_query_array('["a", "b", "c"]', '$[*] ? (@ <> "b")')
→ ["a", "c"]
value < value
→ boolean
小于比较
jsonb_path_query_array('[1, 2, 3]', '$[*] ? (@ < 2)')
→ [1]
value <= value
→ boolean
小于或等于比较
jsonb_path_query_array('["a", "b", "c"]', '$[*] ? (@ <= "b")')
→ ["a", "b"]
value > value
→ boolean
大于比较
jsonb_path_query_array('[1, 2, 3]', '$[*] ? (@ > 2)')
→ [3]
value >= value
→ boolean
大于或等于比较
jsonb_path_query_array('[1, 2, 3]', '$[*] ? (@ >= 2)')
→ [2, 3]
true
→ boolean
JSON常数 true
jsonb_path_query('[{"name": "John", "parent": false}, {"name": "Chris", "parent": true}]', '$[*] ? (@.parent == true)')
→ {"name": "Chris", "parent": true}
false
→ boolean
JSON常数 false
jsonb_path_query('[{"name": "John", "parent": false}, {"name": "Chris", "parent": true}]', '$[*] ? (@.parent == false)')
→ {"name": "John", "parent": false}
null
→ value
JSON常数 null (注意，与SQL不同，与null比较可以正常工作)
jsonb_path_query('[{"name": "Mary", "job": null}, {"name": "Michael", "job": "driver"}]', '$[*] ? (@.job == null) .name')
→ "Mary"
boolean && boolean
→ boolean
布尔 AND
jsonb_path_query('[1, 3, 7]', '$[*] ? (@ > 1 && @ < 5)')
→ 3
boolean || boolean
→ boolean
布尔 OR
jsonb_path_query('[1, 3, 7]', '$[*] ? (@ < 1 || @ > 5)')
→ 7
! boolean
→ boolean
布尔 NOT
jsonb_path_query('[1, 3, 7]', '$[*] ? (!(@ < 5))')
→ 7
boolean is unknown
→ boolean
测试布尔条件是否为 unknown。
jsonb_path_query('[-1, 2, 7, "foo"]', '$[*] ? ((@ > 0) is unknown)')
→ "foo"
string like_regex string [ flag string ]
→ boolean
测试第一个操作数是否与第二个操作数给出的正则表达式匹配，可选使用由一串flag字符描述的修改（参见第 9.16.2.4 节）。
jsonb_path_query_array('["abc", "abd", "aBdC", "abdacb", "babc"]', '$[*] ? (@ like_regex "^ab.*c")')
→ ["abc", "abdacb"]
jsonb_path_query_array('["abc", "abd", "aBdC", "abdacb", "babc"]', '$[*] ? (@ like_regex "^ab.*c" flag "i")')
→ ["abc", "aBdC", "abdacb"]
string starts with string
→ boolean
测试第二个操作数是否为第一个操作数的初始子串。
jsonb_path_query('["John Smith", "Mary Stone", "Bob Johnson"]', '$[*] ? (@ starts with "John")')
→ "John Smith"
exists ( path_expression )
→ boolean
测试路径表达式是否至少匹配一个SQL/JSON项。
如果路径表达式会导致错误，则返回unknown；第二个例子使用这个方法来避免在严格模式下出现无此键(no-such-key)错误。
jsonb_path_query('{"x": [1, 2], "y": [2, 4]}', 'strict $.* ? (exists (@ ? (@[*] > 2)))')
→ [2, 4]
jsonb_path_query_array('{"value": 41}', 'strict $ ? (exists (@.name)) .name')
→ []
9.16.2.4. SQL/JSON 正则表达式 #
SQL/JSON路径表达式允许通过like_regex过滤器将文本匹配为正则表达式。
例如，下面的SQL/JSON路径查询将不区分大小写地匹配以英语元音开头的数组中的所有字符串:
$[*] ? (@ like_regex "^[aeiou]" flag "i")
可选的flag字符串可以包括一个或多个字符
i用于不区分大小写的匹配，
m允许^
和$在换行时匹配，
s允许.匹配换行符，
和q引用整个模式（将行为简化为一个简单的子字符串匹配）。
SQL/JSON标准借用了来自LIKE_REGEX操作符的正则表达式定义，其使用了XQuery标准。
PostgreSQL目前不支持LIKE_REGEX操作符。因此，like_regex过滤器是使用
第 9.7.3 节中描述的POSIX正则表达式引擎来实现的。
这导致了与标准SQL/JSON行为的各种细微差异，这在第 9.7.3.8 节中进行了分类。
但是请注意，这里描述的标志字母不兼容并不适用于SQL/JSON，因为它将XQuery标志字母翻译为符合POSIX引擎的预期。
请记住，like_regex的模式参数是一个JSON路径字符串文字，根据第 8.14.7 节给出的规则编写。
这特别意味着在正则表达式中要使用的任何反斜杠都必须加倍。例如，匹配只包含数字的根文档的字符串值:
$.* ? (@ like_regex "^\\d+$")
9.16.3. SQL/JSON 查询函数 #
SQL/JSON 函数 JSON_EXISTS()、JSON_QUERY() 和
JSON_VALUE()，如 表 9.54 中所述，
可用于查询 JSON 文档。每个函数都对 path_expression
（一个 SQL/JSON 路径查询）应用于 context_item（文档）。
详情请参见 第 9.16.2 节，了解
path_expression 可以包含的内容。
path_expression 也可以引用变量，其值通过各函数支持的
PASSING 子句中相应名称指定。
context_item 可以是 jsonb 值，或可成功转换为
jsonb 的字符串。
表 9.54. SQL/JSON 查询函数
函数签名
描述
示例
JSON_EXISTS (
context_item, path_expression
[ PASSING { value AS varname } [, ...]]
[{ TRUE | FALSE | UNKNOWN | ERROR } ON ERROR ]) → boolean
如果对 context_item 应用 SQL/JSON path_expression
返回任何项目，则返回 true，否则返回 false。
ON ERROR 子句指定在 path_expression
评估期间发生错误时的行为。指定 ERROR 会抛出带有相应消息的错误。其他选项包括
返回 boolean 值 FALSE 或 TRUE，或者返回实际上是 SQL NULL 的
UNKNOWN 值。默认情况下，如果未指定 ON ERROR 子句，则返回
boolean 值 FALSE。
示例：
JSON_EXISTS(jsonb '{"key1": [1,2,3]}', 'strict $.key1[*] ? (@ > $x)' PASSING 2 AS x)
→ t
JSON_EXISTS(jsonb '{"a": [1,2,3]}', 'lax $.a[5]' ERROR ON ERROR)
→ f
JSON_EXISTS(jsonb '{"a": [1,2,3]}', 'strict $.a[5]' ERROR ON ERROR)
→
ERROR:  jsonpath array subscript is out of bounds
JSON_QUERY (
context_item, path_expression
[ PASSING { value AS varname } [, ...]]
[ RETURNING data_type [ FORMAT JSON [ ENCODING UTF8 ] ] ]
[ { WITHOUT | WITH { CONDITIONAL | [UNCONDITIONAL] } } [ ARRAY ] WRAPPER ]
[ { KEEP | OMIT } QUOTES [ ON SCALAR STRING ] ]
[ { ERROR | NULL | EMPTY { [ ARRAY ] | OBJECT } | DEFAULT expression } ON EMPTY ]
[ { ERROR | NULL | EMPTY { [ ARRAY ] | OBJECT } | DEFAULT expression } ON ERROR ]) → jsonb
返回将 SQL/JSON path_expression 应用于
context_item 的结果。
默认情况下，结果作为类型为jsonb的值返回，
尽管可以使用RETURNING子句返回
为某种可以成功强制转换的其他类型。
如果路径表达式可能返回多个值，则可能需要使用WITH WRAPPER子句
将这些值包装起来，使其成为有效的JSON字符串，因为默认行为是不包装它们，
就好像指定了WITHOUT WRAPPER。WITH WRAPPER子句
默认被理解为WITH UNCONDITIONAL WRAPPER，这意味着即使是单个结果值
也会被包装。要仅在存在多个值时应用包装器，请指定WITH CONDITIONAL WRAPPER。
如果指定了WITHOUT WRAPPER，则获取多个结果值将被视为错误。
如果结果是标量字符串，默认情况下，返回值将被引号包围，使其成为有效的 JSON 值。
可以通过指定 KEEP QUOTES 来显式设置。相反，可以通过指定
OMIT QUOTES 来省略引号。为了确保结果是有效的 JSON 值，
当同时指定 WITH WRAPPER 时，不能指定 OMIT QUOTES。
ON EMPTY 子句指定了当计算 path_expression
结果为空集时的行为。ON ERROR 子句指定了当计算
path_expression 出错、将结果值强制转换为
RETURNING 类型时出错，或当计算 ON EMPTY
表达式且 path_expression 结果为空集时的行为。
对于ON EMPTY和ON ERROR，指定ERROR会抛出带有相应消息的错误。
其他选项包括返回SQL NULL、空数组（EMPTY [ARRAY]）、空对象（EMPTY OBJECT）或用户指定的表达式（DEFAULT expression），
该表达式可以被强制转换为jsonb或RETURNING中指定的类型。
当未指定ON EMPTY或ON ERROR时，默认返回SQL NULL值。
示例：
JSON_QUERY(jsonb '[1,[2,3],null]', 'lax $[*][$off]' PASSING 1 AS off WITH CONDITIONAL WRAPPER)
→ 3
JSON_QUERY(jsonb '{"a": "[1, 2]"}', 'lax $.a' OMIT QUOTES)
→ [1, 2]
JSON_QUERY(jsonb '{"a": "[1, 2]"}', 'lax $.a' RETURNING int[] OMIT QUOTES ERROR ON ERROR)
→
ERROR:  malformed array literal: "[1, 2]"
DETAIL:  Missing "]" after array dimensions.
JSON_VALUE (
context_item, path_expression
[ PASSING { value AS varname } [, ...]]
[ RETURNING data_type ]
[ { ERROR | NULL | DEFAULT expression } ON EMPTY ]
[ { ERROR | NULL | DEFAULT expression } ON ERROR ]) → text
返回将 SQL/JSON path_expression 应用于
context_item 的结果。
仅当提取的值预期为单个 SQL/JSON 标量项时使用
JSON_VALUE()；获取多个值将被视为错误。
如果预期提取的值可能是对象或数组，请改用
JSON_QUERY 函数。
默认情况下，结果必须是单个标量值，作为类型为 text 的值返回，
尽管可以使用 RETURNING 子句返回可成功转换为其他类型的值。
ON ERROR 和 ON EMPTY 子句的语义与
JSON_QUERY 描述中提到的类似，但替代抛出错误返回的值集不同。
注意，JSON_VALUE 返回的标量字符串总是去除引号，
等同于在 JSON_QUERY 中指定 OMIT QUOTES。
示例：
JSON_VALUE(jsonb '"123.45"', '$' RETURNING float)
→ 123.45
JSON_VALUE(jsonb '"03:04 2015-02-01"', '$.datetime("HH24:MI YYYY-MM-DD")' RETURNING date)
→ 2015-02-01
JSON_VALUE(jsonb '[1,2]', 'strict $[$off]' PASSING 1 as off)
→ 2
JSON_VALUE(jsonb '[1,2]', 'strict $[*]' DEFAULT 9 ON ERROR)
→ 9
注意
context_item 表达式如果不是 jsonb 类型，
会通过隐式转换转换为 jsonb 类型。但请注意，转换过程中发生的任何解析错误
都会被无条件抛出，也就是说，不会根据（指定的或隐式的）ON ERROR 子句进行处理。
注意
JSON_VALUE() 如果 path_expression 返回 JSON
null，则返回 SQL NULL，而 JSON_QUERY() 则返回
JSON null 本身。
9.16.4. JSON_TABLE #
JSON_TABLE 是一个 SQL/JSON 函数，用于查询 JSON 数据，
并将结果呈现为关系视图，可以像常规 SQL 表一样访问。您可以在 JSON_TABLE
中使用 FROM 子句，适用于 SELECT、UPDATE 或
DELETE，并且可以作为 MERGE 语句中的数据源。
以 JSON 数据作为输入，JSON_TABLE 使用 JSON 路径表达式提取提供数据中的一部分，
用作构造视图的行模式。由行模式给出的每个 SQL/JSON 值作为构造视图中单独行的
来源。
要将行模式拆分为列，JSON_TABLE提供了定义所创建视图
架构的COLUMNS子句。对于每一列，可以指定单独的 JSON 路径表达式，
该表达式将针对行模式进行评估，以获取一个 SQL/JSON 值，该值将成为给定输出行中
指定列的值。
可以使用NESTED PATH子句提取存储在行模式嵌套级别的 JSON 数据。
每个NESTED PATH子句都可以使用来自行模式嵌套级别的数据生成一个或多个列。
这些列可以使用类似于顶层 COLUMNS 子句的 COLUMNS 子句来指定。
由 NESTED COLUMNS 构造的行称为子行，并且与父级
COLUMNS子句中指定的列构造的行连接，以获得最终视图中的行。
子列本身可能包含NESTED PATH规范，从而允许提取位于任意嵌套
级别的数据。由同一级别的多个NESTED PATH生成的列被视为彼此的
兄弟，它们的行在与父行连接后通过 UNION 合并。
由JSON_TABLE生成的行会横向连接到生成它们的行，因此您无需显式地将构造的视图与包含JSON数据的原始表连接。
语法如下：
JSON_TABLE (
context_item, path_expression [ AS json_path_name ] [ PASSING { value AS varname } [, ...] ]
COLUMNS ( json_table_column [, ...] )
[ { ERROR | EMPTY [ARRAY]} ON ERROR ]
)
其中 json_table_column 是：
name FOR ORDINALITY
| name type
[ FORMAT JSON [ENCODING UTF8]]
[ PATH path_expression ]
[ { WITHOUT | WITH { CONDITIONAL | [UNCONDITIONAL] } } [ ARRAY ] WRAPPER ]
[ { KEEP | OMIT } QUOTES [ ON SCALAR STRING ] ]
[ { ERROR | NULL | EMPTY { [ARRAY] | OBJECT } | DEFAULT expression } ON EMPTY ]
[ { ERROR | NULL | EMPTY { [ARRAY] | OBJECT } | DEFAULT expression } ON ERROR ]
| name type EXISTS [ PATH path_expression ]
[ { ERROR | TRUE | FALSE | UNKNOWN } ON ERROR ]
| NESTED [ PATH ] path_expression [ AS json_path_name ] COLUMNS ( json_table_column [, ...] )
每个语法元素将在下面进行更详细的描述。
context_item, path_expression [ AS json_path_name ] [ PASSING { value AS varname } [, ...]]
输入文档查询由context_item指定，path_expression是定义查询的SQL/JSON路径表达式，
json_path_name是path_expression的可选名称。可选的PASSING子句为
path_expression中提到的变量提供数据值。使用上述元素对输入数据进行评估的结果称为
行模式，它用作构造视图中行值的来源。
COLUMNS（json_table_column [，...]）
定义构造视图模式的COLUMNS子句。在此子句中，您可以指定每一列，
该列将通过对行模式应用JSON路径表达式获得的SQL/JSON值进行填充。json_table_column有
以下几种变体：
name FOR ORDINALITY
添加一个序号列，提供从1开始的顺序行编号。每个NESTED PATH（见下文）
都会为任何嵌套的序号列获得自己的计数器。
name type
[FORMAT JSON [ENCODING UTF8]]
[ PATH path_expression ]
插入通过对行模式应用path_expression获得的SQL/JSON值，
并在将其强制转换为指定的type后，插入视图的输出行中。
指定 FORMAT JSON 明确表示您期望该值是一个有效的
json 对象。只有当 type 是
bpchar、bytea、character varying、
name、json、jsonb、text 或
这些类型的域之一时，才有意义指定 FORMAT JSON。
可选地，您可以指定 WRAPPER 和
QUOTES 子句来格式化输出。请注意，
指定 OMIT QUOTES 会覆盖
FORMAT JSON（如果也指定了），因为未加引号的
字面量不构成有效的 json 值。
可选地，您可以使用 ON EMPTY 和
ON ERROR 子句来指定当 JSON 路径求值结果为空时是否抛出错误，
以及当 JSON 路径求值过程中发生错误或将 SQL/JSON 值强制转换为指定类型时是否返回指定值。
两者的默认值均为返回一个 NULL 值。
注意
本条款在内部转换为并具有与 JSON_VALUE 或 JSON_QUERY 相同的语义。
如果指定的类型不是标量类型，或者存在 FORMAT JSON、WRAPPER 或
QUOTES 子句，则使用后者。
name type
EXISTS [ PATH path_expression ]
插入一个布尔值，该值是通过对行模式应用
path_expression 获得的，
并在强制转换为指定的
type 后插入视图的输出行中。
该值对应于将 PATH 表达式应用于行模式时是否产生任何值。
指定的 type 应当可以从
boolean 类型进行转换。
可选地，您可以使用 ON ERROR 来指定在 JSON 路径评估期间发生错误
或将 SQL/JSON 值强制转换为指定类型时，是否抛出错误或返回指定的值。默认是返回一个布尔值
FALSE。
注意
本条款在内部被转换为并且具有与
JSON_EXISTS
相同的语义。
NESTED [ PATH ] path_expression [ AS json_path_name ]
COLUMNS ( json_table_column [, ...] )
从行模式的嵌套层级中提取 SQL/JSON 值，生成由COLUMNS
子句定义的一个或多个列，并将提取的 SQL/JSON 值插入到这些列中。
json_table_column 表达式在COLUMNS
子句中使用与父COLUMNS子句相同的语法。
NESTED PATH 语法是递归的，
因此您可以通过在彼此之间指定多个
NESTED PATH 子句来向下进入多个嵌套级别。
它允许在单个函数调用中展开 JSON 对象和数组的层次结构，
而不是在 SQL 语句中链接多个
JSON_TABLE 表达式。
注意
在上述描述的每个json_table_column变体中，
如果省略了PATH子句，则使用路径表达式
$.name，其中
name是提供的列名。
AS json_path_name
可选的json_path_name用作所提供的
path_expression的标识符。该名称必须唯一且
与列名不同。
{ ERROR | EMPTY } ON ERROR
可选的ON ERROR可用于指定在评估顶层
path_expression时如何处理错误。使用ERROR
表示希望抛出错误，使用EMPTY则返回一个空表，即包含0行的表。
注意，此子句不影响评估列时发生的错误，列的行为取决于是否针对给定列
指定了ON ERROR子句。
示例
在下面的示例中，将使用包含 JSON 数据的下列表：
CREATE TABLE my_films ( js jsonb );
INSERT INTO my_films VALUES (
'{ "favorites" : [
{ "kind" : "comedy", "films" : [
{ "title" : "Bananas",
"director" : "Woody Allen"},
{ "title" : "The Dinner Game",
"director" : "Francis Veber" } ] },
{ "kind" : "horror", "films" : [
{ "title" : "Psycho",
"director" : "Alfred Hitchcock" } ] },
{ "kind" : "thriller", "films" : [
{ "title" : "Vertigo",
"director" : "Alfred Hitchcock" } ] },
{ "kind" : "drama", "films" : [
{ "title" : "Yojimbo",
"director" : "Akira Kurosawa" } ] }
] }');
下面的查询演示了如何使用JSON_TABLE将
my_films表中的JSON对象转换为一个视图，
该视图包含原始JSON中键kind、
title和director对应的列，
以及一个序号列：
SELECT jt.* FROM
my_films,
JSON_TABLE (js, '$.favorites[*]' COLUMNS (
id FOR ORDINALITY,
kind text PATH '$.kind',
title text PATH '$.films[*].title' WITH WRAPPER,
director text PATH '$.films[*].director' WITH WRAPPER)) AS jt;
id |   kind   |             title              |             director
----+----------+--------------------------------+----------------------------------
1 | comedy   | ["Bananas", "The Dinner Game"] | ["Woody Allen", "Francis Veber"]
2 | horror   | ["Psycho"]                     | ["Alfred Hitchcock"]
3 | thriller | ["Vertigo"]                    | ["Alfred Hitchcock"]
4 | drama    | ["Yojimbo"]                    | ["Akira Kurosawa"]
(4 rows)
以下是上述查询的修改版本，展示了在顶层 JSON 路径表达式中指定的过滤器中
使用 PASSING 参数的方法，以及各个列的各种选项：
SELECT jt.* FROM
my_films,
JSON_TABLE (js, '$.favorites[*] ? (@.films[*].director == $filter)'
PASSING 'Alfred Hitchcock' AS filter
COLUMNS (
id FOR ORDINALITY,
kind text PATH '$.kind',
title text FORMAT JSON PATH '$.films[*].title' OMIT QUOTES,
director text PATH '$.films[*].director' KEEP QUOTES)) AS jt;
id |   kind   |  title  |      director
----+----------+---------+--------------------
1 | horror   | Psycho  | "Alfred Hitchcock"
2 | thriller | Vertigo | "Alfred Hitchcock"
(2 rows)
以下是上述查询的修改版本，展示了如何使用NESTED PATH来填充
title和director列，说明它们如何与父列id和kind连接：
SELECT jt.* FROM
my_films,
JSON_TABLE ( js, '$.favorites[*] ? (@.films[*].director == $filter)'
PASSING 'Alfred Hitchcock' AS filter
COLUMNS (
id FOR ORDINALITY,
kind text PATH '$.kind',
NESTED PATH '$.films[*]' COLUMNS (
title text FORMAT JSON PATH '$.title' OMIT QUOTES,
director text PATH '$.director' KEEP QUOTES))) AS jt;
id |   kind   |  title  |      director
----+----------+---------+--------------------
1 | horror   | Psycho  | "Alfred Hitchcock"
2 | thriller | Vertigo | "Alfred Hitchcock"
(2 rows)
以下是相同的查询，但根路径中没有过滤条件：
SELECT jt.* FROM
my_films,
JSON_TABLE ( js, '$.favorites[*]'
COLUMNS (
id FOR ORDINALITY,
kind text PATH '$.kind',
NESTED PATH '$.films[*]' COLUMNS (
title text FORMAT JSON PATH '$.title' OMIT QUOTES,
director text PATH '$.director' KEEP QUOTES))) AS jt;
id |   kind   |      title      |      director
----+----------+-----------------+--------------------
1 | comedy   | Bananas         | "Woody Allen"
1 | comedy   | The Dinner Game | "Francis Veber"
2 | horror   | Psycho          | "Alfred Hitchcock"
3 | thriller | Vertigo         | "Alfred Hitchcock"
4 | drama    | Yojimbo         | "Akira Kurosawa"
(5 rows)
下面展示了另一个使用不同JSON对象作为输入的查询。它展示了
NESTED路径$.movies[*]和$.books[*]之间的
UNION“兄弟连接”，以及在NESTED层级使用
FOR ORDINALITY列（列为movie_id、
book_id和author_id）的用法：
SELECT * FROM JSON_TABLE (
'{"favorites":
[{"movies":
[{"name": "One", "director": "John Doe"},
{"name": "Two", "director": "Don Joe"}],
"books":
[{"name": "Mystery", "authors": [{"name": "Brown Dan"}]},
{"name": "Wonder", "authors": [{"name": "Jun Murakami"}, {"name":"Craig Doe"}]}]
}]}'::json, '$.favorites[*]'
COLUMNS (
user_id FOR ORDINALITY,
NESTED '$.movies[*]'
COLUMNS (
movie_id FOR ORDINALITY,
mname text PATH '$.name',
director text),
NESTED '$.books[*]'
COLUMNS (
book_id FOR ORDINALITY,
bname text PATH '$.name',
NESTED '$.authors[*]'
COLUMNS (
author_id FOR ORDINALITY,
author_name text PATH '$.name'))));
user_id | movie_id | mname | director | book_id |  bname  | author_id | author_name
---------+----------+-------+----------+---------+---------+-----------+--------------
1 |        1 | One   | John Doe |         |         |           |
1 |        2 | Two   | Don Joe  |         |         |           |
1 |          |       |          |       1 | Mystery |         1 | Brown Dan
1 |          |       |          |       2 | Wonder  |         1 | Jun Murakami
1 |          |       |          |       2 | Wonder  |         2 | Craig Doe
(5 rows)
上一页 上一级 下一页9.15. XML 函数 起始页 9.17. 序列操作函数
