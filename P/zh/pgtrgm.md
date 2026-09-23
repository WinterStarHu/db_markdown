# F.35. pg_trgm — 使用三元组匹配支持文本相似性

F.35. pg_trgm — 使用三元组匹配支持文本相似性
版本：
纠错本页面
搜索
目录导航
❮
❯
F.35. pg_trgm —
使用三元组匹配支持文本相似性 #F.35.1. 三元组（或者三元组）概念F.35.2. 函数和操作符F.35.3. GUC 参数F.35.4. 索引支持F.35.5. 文本搜索集成F.35.6. 参考F.35.7. 作者
pg_trgm模块提供用于确定基于三元组匹配的字母数字文本相似度的函数和操作符，以及支持快速搜索相似字符串的索引操作符类。
该模块被认为是“trusted”，也就是说，它可以由对当前数据库具有CREATE权限的非超级用户安装。
F.35.1. 三元组（或者三元组）概念 #
一个三元组是从一个字符串中取出的由三个连续字符组成的组。我们可以通过对两个字符串之间共享的三元组计数来度量它们的相似度。这种简单的思想已经成为在很多自然语言中度量词相似度的有效方法。
注意
pg_trgm在从一个字符串中提取三元组时会忽略非词字符（非字母数字）。在决定字符串中所含的三元组集合时，每一个词被认为具有两个空格前缀和一个空格后缀。例如，字符串“cat”中的三元组集合是：
“  c”、
“ ca”、
“cat”以及
“at ”。
字符串“foo|bar”中的三元组集合是：
“  f”、
“ fo”、
“foo”、
“oo ”、
“  b”、
“ ba”、
“bar”以及
“ar ”。
F.35.2. 函数和操作符 #
pg_trgm模块所提供的函数如表 F.26中所示，操作符则显示在表 F.27中。
表 F.26. pg_trgm 函数
函数
描述
similarity ( text, text )
→ real
返回一个数字指示两个参数有多相似。该结果的范围是 0（指示两个字符串完全不相似）到 1（指示两个字符串完全相同）。
show_trgm ( text )
→ text[]
返回一个给定字符串中所有的 trigrams 组成的一个数组（实际上除了调试很少有用）。
word_similarity ( text, text )
→ real
返回一个数字表示第一个字符串中的 trigram 集合与第二个字符串中 trigram 的有序集中任何连续部分的最大相似度。详情请见下文的解释。
strict_word_similarity ( text, text )
→ real
与word_similarity相同，但是强制连续部分的边界与词边界相匹配。由于我们没有跨词的 trigram，这个函数实际上返回第一个字符串和第二个字符串任意连续部分的相似度。
show_limit ()
→ real
返回%操作符使用的当前相似度阈值。例如，这设定两个词被认为足够相似时，它们之间应满足的最小相似度（已废弃；而是使用SHOW pg_trgm.similarity_threshold）。
set_limit ( real )
→ real
设定%操作符使用的当前相似度阈值。该阈值必须介于 0 和 1 之间（默认为 0.3）。
返回传递进来的同一个值（已废弃；
而是使用SET pg_trgm.similarity_threshold）。
考虑下面的例子：
# SELECT word_similarity('word', 'two words');
word_similarity
-----------------
0.8
(1 row)
在第一个字符串中，trigram集合是{"  w"," wo","wor","ord","rd "}。
在第二个字符串中，trigram的有序集是{"  t"," tw","two","wo ","  w"," wo","wor","ord","rds","ds "}。
在第二个字符串中最相似的trigram有序集的部分是{"  w"," wo","wor","ord"}，并且相似度是0.8。
这个函数返回的值可以大概地理解为第一个字符串和第二个字符串任意子串的最大相似度。不过，这个函数不会对该部分的边界加入填充。因此，除了失配的词边界之外，第二个字符串中存在的额外字符的数目没有被考虑。
同时，strict_word_similarity在第二个字符串中选择一个由词构成的部分。
在上面的例子中，strict_word_similarity会选择单个词'words'形成的部分，
其trigram集合为{"  w"," wo","wor","ord","rds","ds "}。
# SELECT strict_word_similarity('word', 'two words'), similarity('word', 'words');
strict_word_similarity | similarity
------------------------+------------
0.571429 |   0.571429
(1 row)
因此，strict_word_similarity函数对于计算整个词的相似度有用，而word_similarity更适合于计算词的部分相似度。
表 F.27. pg_trgm 操作符
操作符
描述
text % text
→ boolean
如果参数具有超过pg_trgm.similarity_threshold设置的当前相似度阈值的相似度，则返回true。
text <% text
→ boolean
如果第一个参数中的trigram集合与第二个参数中有序trigram集合的一个连续部分之间的相似度超过
pg_trgm.word_similarity_threshold参数设置的当前词相似度阈值，
则返回true。
text %> text
→ boolean
<%操作符的交换子。
text <<% text
→ boolean
如果第二个参数有有序trigram集合的一个连续部分匹配词边界，并且其与第一个参数的trigram集合的相似度超过
pg_trgm.strict_word_similarity_threshold参数设置的当前严格词相似度阈值，
则返回true。
text %>> text
→ boolean
<<%操作符的交换子。
text <-> text
→ real
返回参数之间的“距离”，即 1 减去similarity()值。
text <<-> text
→ real
返回参数之间的“距离”，它是 1 减去word_similarity()的值。
text <->> text
→ real
<<->操作符的交换子。
text <<<-> text
→ real
返回参数之间的“距离”，也就是1减去strict_word_similarity()的值。
text <->>> text
→ real
<<<->操作符的交换子。
F.35.3. GUC 参数 #
pg_trgm.similarity_threshold (real)
#
设置%操作符使用的当前相似度阈值。该阈值必须位于 0 和 1 之间（默认是 0.3）。
pg_trgm.word_similarity_threshold (real)
#
设置<%和%>操作符使用的当前词相似度阈值。该阈值必须位于 0 和 1 之间（默认是 0.6）。
pg_trgm.strict_word_similarity_threshold (real)
#
设置<<%和%>>运算符使用的当前严格词相似度阈值。
阈值必须介于0和1之间（默认值为0.5）。
F.35.4. 索引支持 #
pg_trgm模块提供了GiST和GIN索引操作符类，这些类允许您在文本列上创建索引，
以实现非常快速的相似性搜索。这些索引类型支持上述描述的相似性操作符，并且还支持基于三元组的
索引搜索，例如LIKE、ILIKE、~、
~*和=查询。
在默认构建的pg_trgm中，相似性比较是大小写不敏感的。
不支持不等式操作符。
请注意，对于等式操作符，这些索引可能不如常规B树索引高效。
例子：
CREATE TABLE test_trgm (t text);
CREATE INDEX trgm_idx ON test_trgm USING GIST (t gist_trgm_ops);
或
CREATE INDEX trgm_idx ON test_trgm USING GIN (t gin_trgm_ops);
gist_trgm_ops GiST opclass 将一组三元组近似为位图签名。
它的可选整数参数siglen 确定签名长度（以字节为单位）。
默认长度为12个字节。签名长度的有效值介于1到2024字节之间。
更长的签名导致更精确的搜索（扫描索引的一小部分和更少的堆页面），但代价是更大的索引。
创建签名长度为32字节的此类索引的示例：
CREATE INDEX trgm_idx ON test_trgm USING GIST (t gist_trgm_ops(siglen=32));
此时，你将有一个t列上的索引，你可以用它进行相似度搜索。一个典型的查询是
SELECT t, similarity(t, 'word') AS sml
FROM test_trgm
WHERE t % 'word'
ORDER BY sml DESC, t;
这将返回在文本列中与word足够相似的所有值，按最佳匹配到最差匹配的方式排序。索引将被用来让这种搜索变快，即使在一个非常大的数据集上。
上述查询的一种变体是
SELECT t, t <-> 'word' AS dist
FROM test_trgm
ORDER BY dist LIMIT 10;
这能够用GiST索引有效地实现，但是用GIN索引无法做到。当只想要少数最接近的匹配时，这通常会比第一种形式更好。
也可以把一个t列上的索引用于词相似度或者严格词相似度。典型的查询是：
SELECT t, word_similarity('word', t) AS sml
FROM test_trgm
WHERE 'word' <% t
ORDER BY sml DESC, t;
和
SELECT t, strict_word_similarity('word', t) AS sml
FROM test_trgm
WHERE 'word' <<% t
ORDER BY sml DESC, t;
这将返回文本列中符合条件的所有值：这些值在其对应的有序trigram集中有一个连续部分与word的trigram集合足够相似，这些值会按照最好匹配到最差匹配的顺序排列。即便在非常大的数据集上，索引也将使得这一操作的速度更快。
上述查询可能的变体有：
SELECT t, 'word' <<-> t AS dist
FROM test_trgm
ORDER BY dist LIMIT 10;
和
SELECT t, 'word' <<<-> t AS dist
FROM test_trgm
ORDER BY dist LIMIT 10;
这可以用 GiST 索引很高效地实现，但是用 GIN 索引不行。
从PostgreSQL 9.1 中开始，这些索引类型也支持用于LIKE和ILIKE的索引搜索，例如
SELECT * FROM test_trgm WHERE t LIKE '%foo%bar';
该索引搜索通过从搜索字符串中抽取 trigram 并且在索引中查找它们来工作。搜索字符串中有更多 trigram，索引搜索的效率更高。不像基于 B-树的搜索，搜索字符串不需要是左锚定的。
从PostgreSQL 9.3 中开始，这些索引类型也支持用于正则表达式匹配（~和~*操作符）的索引搜索，例如
SELECT * FROM test_trgm WHERE t ~ '(foo|bar)';
该索引搜索通过从正则表达式中抽取 trigram 并且在索引中查找它们来工作。正则表达式中能抽取出更多 trigram，索引搜索的效率更高。不像基于 B-树的搜索，搜索字符串不需要是左锚定的。
对于LIKE和正则表达式搜索，记住没有可抽取 trigram 的模式将退化成一个全索引扫描。
GiST 和 GIN 索引之间的选择依赖于 GiST 和 GIN 的相对性能特性，这在其他地方讨论。
F.35.5. 文本搜索集成 #
在与一个全文索引联合使用时，trigram 匹配是一种非常有用的工具。特别是它能有助于识别拼写错误的输入词，这些词直接用全文搜索机制是不会被匹配的。
第一步是生成一个包含文档中所有唯一词的辅助表：
CREATE TABLE words AS SELECT word FROM
ts_stat('SELECT to_tsvector(''simple'', bodytext) FROM documents');
其中documents是一个具有我们希望搜索的文本字段bodytext的表。对to_tsvector函数使用simple配置而不是使用语言相关的配置的原因是，我们想要一个原始（未去掉词根的）词的列表。
接下来，在词列上创建一个 trigram 索引：
CREATE INDEX words_idx ON words USING GIN (word gin_trgm_ops);
现在，类似于前面例子的一个SELECT查询可以用来为用户搜索术语中的拼写错误的词建议拼写。要求被选择的词也与拼写错误的词具有相似的长度是一种有用的额外测试。
注意
由于words表已经被生成为一个单独的、静态的表，它将需要定期重新生成，以便与文档集合保持合理的同步。要求它完全与文档集合同步通常是不必要的。
F.35.6. 参考 #
GiST 开发站点
http://www.sai.msu.su/~megera/postgres/gist/
Tsearch2 开发站点
http://www.sai.msu.su/~megera/postgres/gist/tsearch/V2/
F.35.7. 作者 #
Oleg Bartunov <oleg@sai.msu.su>，俄罗斯莫斯科，莫斯科大学
Teodor Sigaev <teodor@sigaev.ru>，俄罗斯莫斯科 Delta-Soft Ltd.，俄罗斯
Alexander Korotkov <a.korotkov@postgrespro.ru>，俄罗斯莫斯科，Postgres Professional
文档：Christopher Kings-Lynne
这个模块由俄罗斯莫斯科 Delta-Soft Ltd. 赞助。
上一页 上一级 下一页F.34. pg_surgery — 对关系数据执行低级操作 起始页 F.36. pg_visibility — 可见性映射信息和工具
