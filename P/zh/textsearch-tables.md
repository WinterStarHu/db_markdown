# 12.2. 表和索引

12.2. 表和索引
版本：
纠错本页面
搜索
目录导航
❮
❯
12.2. 表和索引 #12.2.1. 搜索表12.2.2. 创建索引
在前一节中的例子演示了使用简单常数字符串进行全文匹配。本节展示如何搜索表数据，以及可选择地使用索引。
12.2.1. 搜索表 #
可以在没有索引的情况下进行全文搜索。一个简单的查询将打印每一行的title，这些行在其body字段中包含词friend：
SELECT title
FROM pgweb
WHERE to_tsvector('english', body) @@ to_tsquery('english', 'friend');
这将还会找到相关的词，例如friends和friendly，因为这些都被约减到同一个正规化的词位。
以上的查询指定要使用english配置来解析和正规化字符串。我们也可以忽略配置参数：
SELECT title
FROM pgweb
WHERE to_tsvector(body) @@ to_tsquery('friend');
这个查询将使用由default_text_search_config设置的配置。
一个更复杂的例子是选择10个最近的文档，要求它们在title或body中包含create和table：
SELECT title
FROM pgweb
WHERE to_tsvector(title || ' ' || body) @@ to_tsquery('create & table')
ORDER BY last_mod_date DESC
LIMIT 10;
为了清晰，我们忽略了coalesce函数调用，它可能需要被用来查找在这两个字段中包含NULL的行。
尽管这些查询可以在没有索引的情况下工作，大部分应用会发现这种方法太慢了，除了偶尔的临时搜索。实际使用文本搜索通常要求创建一个索引。
12.2.2. 创建索引 #
我们可以创建一个GIN索引（第 12.9 节）来加速文本搜索：
CREATE INDEX pgweb_idx ON pgweb USING GIN (to_tsvector('english', body));
注意这里使用了to_tsvector的双参数版本。只有指定了一个配置名称的文本搜索函数可以被用在表达式索引（第 11.7 节）中。这是因为索引内容必须没有被default_text_search_config影响。如果它们被影响，索引内容可能会不一致，因为不同的项可能包含被使用不同文本搜索配置创建的tsvector，并且没有办法猜测哪个是哪个。也没有可能正确地转储和恢复这样的一个索引。
由于to_tsvector的双参数版本被使用在上述的索引中，只有一个使用了带有相同配置名的双参数版to_tsvector的查询引用才能使用该索引。即，WHERE to_tsvector('english', body) @@ 'a & b' 可以使用该索引，但WHERE to_tsvector(body) @@ 'a & b'不能。这保证一个索引只能和创建索引项时所用的相同配置一起使用。
可以建立更复杂的表达式索引，在其中配置名被另一个列指定，例如：
CREATE INDEX pgweb_idx ON pgweb USING GIN (to_tsvector(config_name, body));
这里config_name是pgweb表中的一个列。这允许在同一个索引中有混合配置，同时记录哪个配置被用于每一个索引项。例如，如果文档集合包含不同语言的文档，这就可能会有用。同样，要使用索引的查询必须被措辞成匹配，例如WHERE to_tsvector(config_name, body) @@ 'a & b'。
索引甚至可以连接列：
CREATE INDEX pgweb_idx ON pgweb USING GIN (to_tsvector('english', title || ' ' || body));
另一种方法是创建一个单独的tsvector列来保存to_tsvector的输出。若要使此列与其源数据保持自动更新，用存储生成的列。这个例子是title和body的连接，使用coalesce来保证当其他域为NULL时一个域仍然能留在索引中：
ALTER TABLE pgweb
ADD COLUMN textsearchable_index_col tsvector
GENERATED ALWAYS AS (to_tsvector('english', coalesce(title, '') || ' ' || coalesce(body, ''))) STORED;
然后我们创建一个GIN索引来加速搜索：
CREATE INDEX textsearch_idx ON pgweb USING GIN (textsearchable_index_col);
现在我们准备好执行一个快速的全文搜索了：
SELECT title
FROM pgweb
WHERE textsearchable_index_col @@ to_tsquery('create & table')
ORDER BY last_mod_date DESC
LIMIT 10;
单独列方法相对于表达式索引的一个优势在于，它不必为了利用索引而在查询中显式地指定文本搜索配置。如上述例子所示，查询可以依赖default_text_search_config。另一个优势是搜索将会更快，因为它不必重做to_tsvector调用来验证索引匹配（在使用 GiST 索引时这一点比使用 GIN 索引时更重要；见第 12.9 节）。表达式索引方法更容易建立，但是它要求更少的磁盘空间，因为tsvector表示没有被显式地存储下来。
上一页 上一级 下一页12.1. 介绍 起始页 12.3. 控制文本搜索
