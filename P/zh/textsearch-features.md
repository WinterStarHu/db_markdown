# 12.4. 附加功能

12.4. 附加功能
版本：
纠错本页面
搜索
目录导航
❮
❯
12.4. 附加功能 #12.4.1. 操纵文档12.4.2. 操作查询12.4.3. 用于自动更新的触发器12.4.4. 收集文档统计信息
本节描述在文本搜索中有用的一些附加函数和操作符。
12.4.1. 操纵文档 #
第 12.3.1 节展示了未经处理的文本文档如何被转换成tsvector值。PostgreSQL也提供了用于操纵已经为tsvector形式的文档的函数和操作符。
tsvector || tsvector
tsvector连接操作符返回一个向量，它结合了作为参数给出的两个向量的词位和位置信息。位置和权重标签在连接期间被保留。出现在右侧向量中的位置被使用左侧向量中提到的最大位置进行偏移，这样结果几乎等于在两个原始文档字符串的连接上执行to_tsvector的结果（这种等价不是完全的，因为从左侧参数的尾端移除的任何停用词将会影响结果，而如果文本连接被使用它们就影响了右侧参数中的词位位置）。
使用向量形式的连接而不是在应用to_tsvector之前连接文本的一个优点是你可以使用不同配置来解析文档的不同部分。此外，因为setweight函数按照相同的方式标记给定向量的所有词位，如果你想把文档的不同部分标注不同的权重，你就有必要解析文本并且在连接之前做setweight。
setweight(vector tsvector, weight "char") returns tsvector
setweight返回输入向量的一个拷贝，其中每一个位置都被标注为给定的weight：A、B、C或D（D是新向量的默认值并且并不会被显示在输出上）。向量被连接时会保留这些标签，允许来自文档的不同部分的词被排名函数给予不同的权重。
注意权重标签是应用到位置而不是词位。如果输入向量已经被剥离了位置，则setweight什么也不会做。
length(vector tsvector) returns integer
返回存储在向量中的词位数。
strip(vector tsvector) returns tsvector
返回一个向量，其中列出了和给定向量相同的词位，不过没有任何位置或权重信息。其结果通常比未被剥离的向量小很多，但是用处也小很多。相关度排名在已剥离的向量上不如未剥离的向量有效。此外，<->（FOLLOWED BY）tsquery操作符不会匹配已剥离的输入，因为它无法确定词位之间的距离。
表 9.43中有tsvector相关函数的完整列表。
12.4.2. 操作查询 #
第 12.3.2 节展示了未经处理的文本形式的查询如何被转换成tsquery值。PostgreSQL也提供了用于操纵已经是tsquery形式的查询的函数和操作符。
tsquery && tsquery
返回两个给定查询的 AND 组合。
tsquery || tsquery
返回两个给定查询的 OR 组合。
!! tsquery
返回给定查询的否定（NOT）。
tsquery <-> tsquery
返回一个查询，它用<->（紧跟）tsquery操作符搜索两个紧跟的匹配，第一个匹配符合第一个给定的查询而第二个匹配符合第二个给定的查询。例如：
SELECT to_tsquery('fat') <-> to_tsquery('cat | rat');
?column?
----------------------------
'fat' <-> ( 'cat' | 'rat' )
tsquery_phrase(query1 tsquery, query2 tsquery [, distance integer ]) returns tsquery
返回一个查询，它使用<N> tsquery操作符搜索两个距离为distance个词位的匹配，第一个匹配符合第一个给定的查询而第二个匹配符合第二个给定的查询。例如：
SELECT tsquery_phrase(to_tsquery('fat'), to_tsquery('cat'), 10);
tsquery_phrase
------------------
'fat' <10> 'cat'
numnode(query tsquery) returns integer
返回一个tsquery中的节点数（词位外加操作符）。要确定查询是否有意义或者是否只包含停用词时，这个函数有用，在前一种情况它返回 > 0，后一种情况返回 0。例子：
SELECT numnode(plainto_tsquery('the any'));
NOTICE:  query contains only stopword(s) or doesn't contain lexeme(s), ignored
numnode
---------
0
SELECT numnode('foo & bar'::tsquery);
numnode
---------
3
querytree(query tsquery) returns text
返回一个tsquery中可以被用来搜索一个索引的部分。这个函数可用来检测不可被索引的查询，例如那些只包含停用词或者只有否定术语的查询。例如：
SELECT querytree(to_tsquery('defined'));
querytree
-----------
'defin'
SELECT querytree(to_tsquery('!defined'));
querytree
-----------
T
12.4.2.1. 查询重写 #
ts_rewrite函数族在一个给定的tsquery中搜索一个目标子查询的出现，并且将每一次出现替换成一个替补子查询。本质上这个操作就是一个tsquery版本的子串替换。一个目标和替补的组合可以被看成是一个查询重写规则。一个这类重写规则的集合可以是一个强大的搜索助手。例如，你可以使用同义词扩展搜索（如，new york、big apple、nyc、gotham），或者收缩搜索来将用户导向某些热点主题。在这个特性和分类词典（第 12.6.4 节）有些功能重叠。但是，你可以随时修改一组重写规则而无需重新索引，而更新一个分类词典则要求进行重新索引才能生效。
ts_rewrite (query tsquery, target tsquery, substitute tsquery) returns tsquery
这种形式的ts_rewrite简单地应用一个单一重写规则：不管target出现在query中的那个地方，它都被substitute替代。例如：
SELECT ts_rewrite('a & b'::tsquery, 'a'::tsquery, 'c'::tsquery);
ts_rewrite
------------
'b' & 'c'
ts_rewrite (query tsquery, select text) returns tsquery
这种形式的ts_rewrite接受一个开始query和一个 SQL select命令，它们以一个文本字符串的形式给出。select必须得到tsquery类型的两列。对于select结果的每一行，在当前query值中出现的第一列值（目标）被第二列值（替代）所替换。例如：
CREATE TABLE aliases (t tsquery PRIMARY KEY, s tsquery);
INSERT INTO aliases VALUES('a', 'c');
SELECT ts_rewrite('a & b'::tsquery, 'SELECT t,s FROM aliases');
ts_rewrite
------------
'b' & 'c'
注意当多个重写规则以这种方式应用时，应用的顺序很重要；因此在实际中你会要求源查询按某些排序键ORDER BY。
让我们考虑一个现实生活中的天文学例子。我们将使用基于表的重写规则扩展查询supernovae：
CREATE TABLE aliases (t tsquery PRIMARY KEY, s tsquery);
INSERT INTO aliases VALUES(to_tsquery('supernovae'), to_tsquery('supernovae|sn'));
SELECT ts_rewrite(to_tsquery('supernovae & crab'), 'SELECT * FROM aliases');
ts_rewrite
---------------------------------
'crab' & ( 'supernova' | 'sn' )
我们可以通过更新表来更改重写规则：
UPDATE aliases
SET s = to_tsquery('supernovae|sn & !nebulae')
WHERE t = to_tsquery('supernovae');
SELECT ts_rewrite(to_tsquery('supernovae & crab'), 'SELECT * FROM aliases');
ts_rewrite
---------------------------------------------
'crab' & ( 'supernova' | 'sn' & !'nebula' )
当有很多重写规则时，重写可能会很慢，因为它要为每一个可能的匹配检查每一条规则。要过滤掉明显不符合的规则，我们可以为tsquery类型使用包含操作符。在下面的例子中，我们只选择那些可能匹配原始查询的规则：
SELECT ts_rewrite('a & b'::tsquery,
'SELECT t,s FROM aliases WHERE ''a & b''::tsquery @> t');
ts_rewrite
------------
'b' & 'c'
12.4.3. 用于自动更新的触发器 #注意
本节中描述的方法已被使用存储生成的列所淘汰，如 第 12.2.2 节中所述。
当使用一个单独的列来存储你的文档的tsvector表示时，有必要创建一个触发器在文档内容列改变时更新tsvector列。两个内建触发器函数可以用于这个目的，或者你可以编写自己的触发器函数。
tsvector_update_trigger(tsvector_column_name,​ config_name, text_column_name [, ... ])
tsvector_update_trigger_column(tsvector_column_name,​ config_column_name, text_column_name [, ... ])
这些触发函数会自动从一个或多个文本列中计算出一个tsvector列，
在CREATE TRIGGER命令指定的参数控制下。它们的使用示例是：
CREATE TABLE messages (
title       text,
body        text,
tsv         tsvector
);
CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
ON messages FOR EACH ROW EXECUTE FUNCTION
tsvector_update_trigger(tsv, 'pg_catalog.english', title, body);
INSERT INTO messages VALUES('title here', 'the body text is here');
SELECT * FROM messages;
title    |         body          |            tsv
------------+-----------------------+----------------------------
title here | the body text is here | 'bodi':4 'text':5 'titl':1
SELECT title, body FROM messages WHERE tsv @@ to_tsquery('title & body');
title    |         body
------------+-----------------------
title here | the body text is here
创建了这个触发器后，任何title或
body的更改都会自动反映到
tsv中，应用程序无需担心这一点。
第一个触发器参数必须是要更新的tsvector列的名称。第二个参数指定要用于执行转换的文本搜索配置。对于tsvector_update_trigger，配置名称简单地作为第二个触发器参数给出。它必须是模式限定的，如上所示，以便触发器的行为不会因search_path的变化而改变。对于tsvector_update_trigger_column，第二个触发器参数是另一个表列的名称，它必须是类型regconfig。这允许逐行选择配置。剩下的参数是文本列的名称（类型为text、varchar或char）。这些将按给定的顺序包含在文档中。NULL值将被跳过（但其他列仍将被索引）。
这些内建触发器的一个限制是它们将所有输入列同样对待。要对列进行不同的处理 — 例如，使标题的权重和正文的不同 — 就需要编写一个自定义触发器。下面是用PL/pgSQL作为触发器语言的一个例子：
CREATE FUNCTION messages_trigger() RETURNS trigger AS $$
begin
new.tsv :=
setweight(to_tsvector('pg_catalog.english', coalesce(new.title,'')), 'A') ||
setweight(to_tsvector('pg_catalog.english', coalesce(new.body,'')), 'D');
return new;
end
$$ LANGUAGE plpgsql;
CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
ON messages FOR EACH ROW EXECUTE FUNCTION messages_trigger();
要记住，在触发器中创建tsvector值时，明确指定配置名称是很重要的，
这样列的内容就不会受到default_text_search_config更改的影响。
如果不这样做，很可能会导致问题，比如在转储和恢复后搜索结果发生变化。
12.4.4. 收集文档统计信息 #
函数 ts_stat 对于检查你的配置和寻找停用词候选项非常有用。
ts_stat(sqlquery text, [ weights text, ]
OUT word text, OUT ndoc integer,
OUT nentry integer) returns setof record
sqlquery 是一个文本值，它包含一个必须返回单一 tsvector 列的 SQL 查询。ts_stat 执行该查询并返回有关包含在该 tsvector 数据中的每一个可区分词位（词）的统计数据。返回的列是：
word text — 一个词位的值
ndoc integer — 词出现过的文档（tsvector）的数量
nentry integer — 词出现的总次数
如果提供了 weights，只有具有其中之一权重的出现才被计算在内。
例如，要在一个文档集合中查找十个最频繁的词：
SELECT * FROM ts_stat('SELECT vector FROM apod')
ORDER BY nentry DESC, ndoc DESC, word
LIMIT 10;
同样的要求，但是只计算具有权重 A 或 B 的出现次数：
SELECT * FROM ts_stat('SELECT vector FROM apod', 'ab')
ORDER BY nentry DESC, ndoc DESC, word
LIMIT 10;
上一页 上一级 下一页12.3. 控制文本搜索 起始页 12.5. 解析器
