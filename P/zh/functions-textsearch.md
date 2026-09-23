# 9.13. 文本搜索函数和操作符

9.13. 文本搜索函数和操作符
版本：
纠错本页面
搜索
目录导航
❮
❯
9.13. 文本搜索函数和操作符 #
表 9.42,
表 9.43 和
表 9.44
总结了为全文搜索提供的函数和运算符。PostgreSQL的文本搜索功能的详细解释可参考第 12 章。
表 9.42. 文本搜索操作符
操作符
描述
示例
tsvector @@ tsquery
→ boolean
tsquery @@ tsvector
→ boolean
tsvector匹配tsquery吗？（参数可以按任意顺序给出。）
to_tsvector('fat cats ate rats') @@ to_tsquery('cat & rat')
→ t
text @@ tsquery
→ boolean
隐式调用to_tsvector()后的文本字符串匹配tsquery吗？
'fat cats ate rats' @@ to_tsquery('cat & rat')
→ t
tsvector || tsvector
→ tsvector
连接两个tsvector。如果两个输入都包含词素位置，则相应地调整第二个输入的位置。
'a:1 b:2'::tsvector || 'c:1 d:2 b:3'::tsvector
→ 'a':1 'b':2,5 'c':3 'd':4
tsquery && tsquery
→ tsquery
AND两个tsquery，生成一个匹配两个输入查询的文档的查询。
'fat | rat'::tsquery && 'cat'::tsquery
→ ( 'fat' | 'rat' ) & 'cat'
tsquery || tsquery
→ tsquery
ORs两个tsquery在一起，生成一个匹配任一输入查询的文档的查询。
'fat | rat'::tsquery || 'cat'::tsquery
→ 'fat' | 'rat' | 'cat'
!! tsquery
→ tsquery
否定tsquery，生成一个与输入查询不匹配的文档的查询。
!! 'cat'::tsquery
→ !'cat'
tsquery <-> tsquery
→ tsquery
构造一个短语查询，如果两个输入查询在连续的词素上匹配，该查询将进行匹配。
to_tsquery('fat') <-> to_tsquery('rat')
→ 'fat' <-> 'rat'
tsquery @> tsquery
→ boolean
第一个tsquery包含了第二个吗？(这只考虑出现在一个查询中的所有词素是否出现在另一个查询中，忽略了组合操作符。)
'cat'::tsquery @> 'cat & rat'::tsquery
→ f
tsquery <@ tsquery
→ boolean
第一个tsquery包含在第二个中吗？(这只考虑出现在一个查询中的所有词素是否出现在另一个查询中，而忽略了组合操作符。)
'cat'::tsquery <@ 'cat & rat'::tsquery
→ t
'cat'::tsquery <@ '!cat & rat'::tsquery
→ t
除了这些专用操作符之外， 表 9.1 中所示的常用比较操作符也适用于tsvector和tsquery类型。
它们对于文本搜索不是很有用，但允许例如在这些类型的列上建立唯一索引。
表 9.43. 文本搜索函数
函数
描述
示例
array_to_tsvector ( text[] )
→ tsvector
将文本字符串数组转换为tsvector。
给定的字符串被直接用作词元，不经过进一步处理。数组元素不得为空字符串
或NULL。
array_to_tsvector('{fat,cat,rat}'::text[])
→ 'cat' 'fat' 'rat'
get_current_ts_config ( )
→ regconfig
返回当前默认文本搜索配置的OID（由 default_text_search_config 所设定的）。
get_current_ts_config()
→ english
length ( tsvector )
→ integer
返回tsvector中的词位数。
length('fat:2,4 cat:3 rat:5A'::tsvector)
→ 3
numnode ( tsquery )
→ integer
返回tsquery中词位和操作符的数目。
numnode('(fat & rat) | cat'::tsquery)
→ 5
plainto_tsquery (
[ config regconfig, ]
query text )
→ tsquery
将文本转换为tsquery，根据指定的或默认配置对单词进行标准化。
字符串中的任何标点符号都会被忽略（它不决定查询操作符）。结果查询匹配文本中包含所有非停止词的文档。
plainto_tsquery('english', 'The Fat Rats')
→ 'fat' & 'rat'
phraseto_tsquery (
[ config regconfig, ]
query text )
→ tsquery
将文本转换为tsquery，根据指定的或默认配置对单词进行标准化。
字符串中的任何标点符号都会被忽略（它不决定查询操作符）。结果查询匹配包含文本中所有非停止词的短语。
phraseto_tsquery('english', 'The Fat Rats')
→ 'fat' <-> 'rat'
phraseto_tsquery('english', 'The Cat and Rats')
→ 'cat' <2> 'rat'
websearch_to_tsquery (
[ config regconfig, ]
query text )
→ tsquery
将文本转换为tsquery，根据指定的或默认配置对单词进行标准化。引用的单词序列被转换为短语测试。
“or”一词被理解为产生OR操作符，而破折号产生NOT操作符；其他标点符号被忽略。这类似于一些常见的网络搜索工具的行为。
websearch_to_tsquery('english', '"fat rat" or cat dog')
→ 'fat' <-> 'rat' | 'cat' & 'dog'
querytree ( tsquery )
→ text
生成tsquery的可转位部分的表示。结果为空或仅为T表示不可索引查询。
querytree('foo & ! bar'::tsquery)
→ 'foo'
setweight ( vector tsvector, weight "char" )
→ tsvector
将指定的weight赋给vector的每个元素。
setweight('fat:2,4 cat:3 rat:5B'::tsvector, 'A')
→ 'cat':3A 'fat':2A,4A 'rat':5A
setweight ( vector tsvector, weight "char", lexemes text[] )
→ tsvector
为vector中列出的lexemes赋予指定的weight。
lexemes中的字符串被视为词元，不经过进一步处理。不匹配vector中任何词元的字符串将被忽略。
setweight('fat:2,4 cat:3 rat:5,6B'::tsvector, 'A', '{cat,rat}')
→ 'cat':3A 'fat':2,4 'rat':5A,6A
strip ( tsvector )
→ tsvector
从tsvector中移除位置和权重。
strip('fat:2,4 cat:3 rat:5A'::tsvector)
→ 'cat' 'fat' 'rat'
to_tsquery (
[ config regconfig, ]
query text )
→ tsquery
将文本转换为tsquery，根据指定的或默认配置对单词进行标准化。单词必须由有效的tsquery操作符组合。
to_tsquery('english', 'The & Fat & Rats')
→ 'fat' & 'rat'
to_tsvector (
[ config regconfig, ]
document text )
→ tsvector
将文本转换为tsvector，根据指定的或默认配置对单词进行标准化。结果中包含位置信息。
to_tsvector('english', 'The Fat Rats')
→ 'fat':2 'rat':3
to_tsvector (
[ config regconfig, ]
document json )
→ tsvector
to_tsvector (
[ config regconfig, ]
document jsonb )
→ tsvector
将JSON文档中的每个字符串值转换为tsvector，根据指定的或默认配置对单词进行标准化。
然后将结果按文档顺序连接起来以产生输出。位置信息就像在每对字符串值之间存在一个停止词一样生成。
(注意，当输入为jsonb时，JSON对象的字段的“document order”取决于实现;请观察这些例子中的差异。)
to_tsvector('english', '{"aa": "The Fat Rats", "b": "dog"}'::json)
→ 'dog':5 'fat':2 'rat':3
to_tsvector('english', '{"aa": "The Fat Rats", "b": "dog"}'::jsonb)
→ 'dog':1 'fat':4 'rat':5
json_to_tsvector (
[ config regconfig, ]
document json,
filter jsonb )
→ tsvector
jsonb_to_tsvector (
[ config regconfig, ]
document jsonb,
filter jsonb )
→ tsvector
选择filter请求的JSON文档中的每个项，并将每个项转换为tsvector，根据指定的或默认配置对单词进行标准化。
然后将结果按文档顺序连接起来以产生输出。位置信息就像在每对选定的项目之间存在一个停止词一样生成。
(注意，当输入为jsonb时，JSON对象字段的“document order”取决于实现。)
filter必须是一个jsonb数组，其中包含0个或多个关键字:
"string"(包括所有字符串值)，
"numeric"(包括所有数值)，
"boolean"(包括所有布尔值)，
"key"(包括所有键)，或
"all"(包括以上所有关键字)。
作为一种特殊情况，该filter也可以是这些关键字之一的简单JSON值。
json_to_tsvector('english', '{"a": "The Fat Rats", "b": 123}'::json, '["string", "numeric"]')
→ '123':5 'fat':2 'rat':3
json_to_tsvector('english', '{"cat": "The Fat Rats", "dog": 123}'::json, '"all"')
→ '123':9 'cat':1 'dog':7 'fat':4 'rat':5
ts_delete ( vector tsvector, lexeme text )
→ tsvector
从vector中删除给定的lexeme的任何出现。
lexeme字符串被视为原样的词元，不经过进一步处理。
ts_delete('fat:2,4 cat:3 rat:5A'::tsvector, 'fat')
→ 'cat':3 'rat':5A
ts_delete ( vector tsvector, lexemes text[] )
→ tsvector
从vector中删除lexemes中的任何出现。
lexemes中的字符串被视为词元，不经过进一步处理。
不匹配vector中任何词元的字符串将被忽略。
ts_delete('fat:2,4 cat:3 rat:5A'::tsvector, ARRAY['fat','rat'])
→ 'cat':3
ts_filter ( vector tsvector, weights "char"[] )
→ tsvector
只从vector中选择具有给定weights的元素。
ts_filter('fat:2,4 cat:3b,7c rat:5A'::tsvector, '{a,b}')
→ 'cat':3B 'rat':5A
ts_headline (
[ config regconfig, ]
document text,
query tsquery
[, options text ] )
→ text
以缩写形式显示document中query的匹配项，该匹配项必须是原始文本，而不是tsvector。
在匹配查询之前，文档中的单词将根据指定的或默认的配置进行规范化。
第 12.3.4 节中讨论了该函数的使用，还描述了可用的options。
ts_headline('The fat cat ate the rat.', 'cat')
→ The fat <b>cat</b> ate the rat.
ts_headline (
[ config regconfig, ]
document json,
query tsquery
[, options text ] )
→ text
ts_headline (
[ config regconfig, ]
document jsonb,
query tsquery
[, options text ] )
→ text
以缩写形式显示匹配JSONdocument中字符串值中的query。
更多细节请参阅 第 12.3.4 节。
ts_headline('{"cat":"raining cats and dogs"}'::jsonb, 'cat')
→ {"cat": "raining <b>cats</b> and dogs"}
ts_rank (
[ weights real[], ]
vector tsvector,
query tsquery
[, normalization integer ] )
→ real
计算一个分数，显示vector与query的匹配程度。详情请参见第 12.3.3 节。
ts_rank(to_tsvector('raining cats and dogs'), 'cat')
→ 0.06079271
ts_rank_cd (
[ weights real[], ]
vector tsvector,
query tsquery
[, normalization integer ] )
→ real
使用覆盖密度算法计算一个分数，显示vector与query的匹配程度。
详情参见第 12.3.3 节。
ts_rank_cd(to_tsvector('raining cats and dogs'), 'cat')
→ 0.1
ts_rewrite ( query tsquery,
target tsquery,
substitute tsquery )
→ tsquery
在query中使用substitute替换出现的target。
详情参见第 12.4.2.1 节。
ts_rewrite('a & b'::tsquery, 'a'::tsquery, 'foo|bar'::tsquery)
→ 'b' & ( 'foo' | 'bar' )
ts_rewrite ( query tsquery,
select text )
→ tsquery
根据目标替换部分query，并替换通过执行SELECT命令获得的查询。
详情参见第 12.4.2.1 节。
SELECT ts_rewrite('a & b'::tsquery, 'SELECT t,s FROM aliases')
→ 'b' & ( 'foo' | 'bar' )
tsquery_phrase ( query1 tsquery, query2 tsquery )
→ tsquery
构造一个短语查询，在连续的词位上搜索
query1
和 query2 的匹配项（与 <-> 操作符相同）。
tsquery_phrase(to_tsquery('fat'), to_tsquery('cat'))
→ 'fat' <-> 'cat'
tsquery_phrase ( query1 tsquery, query2 tsquery, distance integer )
→ tsquery
构造一个短语查询，用于搜索 query1 和
query2 的匹配项，这些匹配项恰好出现在
distance 词位之间。
tsquery_phrase(to_tsquery('fat'), to_tsquery('cat'), 10)
→ 'fat' <10> 'cat'
tsvector_to_array ( tsvector )
→ text[]
将 tsvector 转换为词位的数组。
tsvector_to_array('fat:2,4 cat:3 rat:5A'::tsvector)
→ {cat,fat,rat}
unnest ( tsvector )
→ setof record
( lexeme text,
positions smallint[],
weights text )
将 tsvector 展开为一组行，每个行对应一个词位。
select * from unnest('cat:3 fat:2,4 rat:5A'::tsvector)
→
lexeme | positions | weights
--------+-----------+---------
cat    | {3}       | {D}
fat    | {2,4}     | {D,D}
rat    | {5}       | {A}
注意
所有接受一个可选的 regconfig 参数的文本搜索函数在该参数被忽略时，使用由
default_text_search_config 指定的配置。
表 9.44 中的函数被单独列出，因为它们通常不被用于日常的文本
搜索操作。它们主要有助于开发和调试新的文本搜索配置。
表 9.44. 文本搜索调试函数
函数
描述
例子
ts_debug (
[ config regconfig, ]
document text )
→ setof record
( alias text,
description text,
token text,
dictionaries regdictionary[],
dictionary regdictionary,
lexemes text[] )
根据指定的或默认的文本搜索配置从document中提取和标准化标记，并返回关于每个标记是如何处理的信息。
详见第 12.8.1 节。
ts_debug('english', 'The Brightest supernovaes')
→ (asciiword,"Word, all ASCII",The,{english_stem},english_stem,{}) ...
ts_lexize ( dict regdictionary, token text )
→ text[]
如果字典知道输入标记，则返回替换词位数组；如果字典知道标记，但它是停止词，则返回空数组；如果它不是已知词，则返回NULL。
详见第 12.8.3 节。
ts_lexize('english_stem', 'stars')
→ {star}
ts_parse ( parser_name text,
document text )
→ setof record
( tokid integer,
token text )
使用命名的解析器从document中提取标记。
详见第 12.8.2 节。
ts_parse('default', 'foo - bar')
→ (1,foo) ...
ts_parse ( parser_oid oid,
document text )
→ setof record
( tokid integer,
token text )
使用OID指定的解析器从document中提取标记。
详见第 12.8.2 节。
ts_parse(3722, 'foo - bar')
→ (1,foo) ...
ts_token_type ( parser_name text )
→ setof record
( tokid integer,
alias text,
description text )
返回一个表，该表描述命名解析器可以识别的每种类型的标记。
详见第 12.8.2 节。
ts_token_type('default')
→ (1,asciiword,"Word, all ASCII") ...
ts_token_type ( parser_oid oid )
→ setof record
( tokid integer,
alias text,
description text )
返回一个表，该表描述OID指定的解析器可以识别的每种标记类型。
详见第 12.8.2 节。
ts_token_type(3722)
→ (1,asciiword,"Word, all ASCII") ...
ts_stat ( sqlquery text
[, weights text ] )
→ setof record
( word text,
ndoc integer,
nentry integer )
执行sqlquery，该查询必须返回单个tsvector列，并返回关于数据中包含的每个不同词位的统计信息。
详见第 12.4.4 节。
ts_stat('SELECT vector FROM apod')
→ (foo,10,15) ...
上一页 上一级 下一页9.12. 网络地址函数和操作符 起始页 9.14. UUID 函数
