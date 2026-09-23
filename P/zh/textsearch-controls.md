# 12.3. 控制文本搜索

12.3. 控制文本搜索
版本：
纠错本页面
搜索
目录导航
❮
❯
12.3. 控制文本搜索 #12.3.1. 解析文档12.3.2. 解析查询12.3.3. 排名搜索结果12.3.4. 高亮结果
要实现全文搜索必须要有一个从文档创建tsvector以及从用户查询创建tsquery的函数。而且我们需要一种有用的顺序返回结果，因此我们需要一个函数能够根据文档与查询的相关性比较文档。还有一点重要的是要能够很好地显示结果。PostgreSQL对所有这些函数都提供了支持。
12.3.1. 解析文档 #
PostgreSQL提供了函数to_tsvector将一个文档转换成tsvector数据类型。
to_tsvector([ config regconfig, ] document text) returns tsvector
to_tsvector把一个文本文档解析成记号，把记号缩减成词位，并且返回一个tsvector，它列出了词位以及词位在文档中的位置。文档被根据指定的或默认的文本搜索配置来处理。下面是一个简单例子：
SELECT to_tsvector('english', 'a fat  cat sat on a mat - it ate a fat rats');
to_tsvector
-----------------------------------------------------
'ate':9 'cat':3 'fat':2,11 'mat':7 'rat':12 'sat':4
在上面这个例子中我们看到，作为结果的tsvector不包含词a、on或it，词rats变成了rat，并且标点符号-被忽略了。
to_tsvector函数在内部调用了一个解析器，它把文档文本分解成记号并且为每一种记号分配一个类型。对于每一个记号，会去查询一个词典列表（第 12.6 节），该列表会根据记号的类型而变化。第一个识别记号的词典产生一个或多个正规化的词位来表示该记号。例如，rats变成rat是因为一个词典识别到该词rats是rat的复数形式。一些词会被识别为停用词（第 12.6.1 节），这将导致它们被忽略，因为它们出现得太频繁以至于在搜索中起不到作用。在我们的例子中有a、on和it是停用词。如果在列表中没有词典能识别该记号，那它将也会被忽略。在这个例子中标点符号-就属于这种情况，因为事实上没有词典会给它分配记号类型（空间符号），即空间记号不会被索引。对于解析器、词典以及要索引哪些记号类型是由所选择的文本搜索配置（第 12.7 节）决定的。可以在同一个数据库中有多种不同的配置，并且有用于很多种语言的预定义配置。在我们的例子中，我们使用用于英语的默认配置english。
函数setweight可以被用来对tsvector中的项标注一个给定的权重，这里一个权重可以是四个字母之一：A、B、C或D。这通常被用来标记来自文档不同部分的项，例如标题对正文。稍后，这种信息可以被用来排名搜索结果。
因为to_tsvector(NULL) 将返回NULL，不论何时一个字段可能为空时，我们推荐使用coalesce。下面是我们推荐的从一个结构化文档创建一个tsvector的方法：
UPDATE tt SET ti =
setweight(to_tsvector(coalesce(title,'')), 'A')    ||
setweight(to_tsvector(coalesce(keyword,'')), 'B')  ||
setweight(to_tsvector(coalesce(abstract,'')), 'C') ||
setweight(to_tsvector(coalesce(body,'')), 'D');
这里我们已经使用了setweight在完成的tsvector标注每一个词位的来源，并且接着将标注过的tsvector值用tsvector连接操作符||合并在一起（第 12.4.1 节给出了关于这些操作的细节）。
12.3.2. 解析查询 #
PostgreSQL提供了函数to_tsquery、plainto_tsquery、phraseto_tsquery以及websearch_to_tsquery用来把一个查询转换成tsquery数据类型。to_tsquery提供了比plainto_tsquery和phraseto_tsquery更多的特性，但是它对其输入要求更加严格。websearch_to_tsquery是to_tsquery的一个简化版本，它使用一种可选择的语法，类似于Web搜索引擎使用的语法。
to_tsquery([ config regconfig, ] querytext text) returns tsquery
to_tsquery从querytext创建一个tsquery值，
其必须由用tsquery运算符&（AND）、|（OR）、
!（NOT）和<->（FOLLOWED BY）分隔的单个标记组成，
可能使用括号进行分组。换句话说，输入到to_tsquery的内容必须已遵循
第 8.11.2 节中描述的tsquery输入的一般规则。不同之处在于，
基本的tsquery输入按面值接受标记，而to_tsquery会使用指定或默认配置将
每个标记标准化为一个词元，并丢弃那些配置为停用词的标记。例如：
SELECT to_tsquery('english', 'The & Fat & Rats');
to_tsquery
---------------
'fat' & 'rat'
与基本tsquery输入一样，可以附加权重以限制每个词元仅匹配具有该权重的tsvector词元。
例如：
SELECT to_tsquery('english', 'Fat | Rats:AB');
to_tsquery
------------------
'fat' | 'rat':AB
此外，*可以附加到词元以指定前缀匹配：
SELECT to_tsquery('supern:*A & star:A*B');
to_tsquery
--------------------------
'supern':*A & 'star':*AB
这样的词元将匹配以给定字符串开头的tsvector中的任何单词。
to_tsquery也能够接受单引号短语。当配置包括一个会在这种短语上触发的同义词词典时就是它的主要用处。在下面的例子中，一个同义词词典含规则supernovae stars : sn：
SELECT to_tsquery('''supernovae stars'' & !crab');
to_tsquery
---------------
'sn' & !'crab'
在没有引号时，to_tsquery将为那些没有被 AND、OR 或者 FOLLOWED BY 操作符分隔的记号产生一个语法错误。
plainto_tsquery([ config regconfig, ] querytext text) returns tsquery
plainto_tsquery将未格式化的文本querytext转换成一个tsquery值。该文本被解析并被规范化，很像to_tsvector，然后&（AND）tsquery操作符被插入到留下来的词之间。
例子:
SELECT plainto_tsquery('english', 'The Fat Rats');
plainto_tsquery
-----------------
'fat' & 'rat'
注意plainto_tsquery不会识别其输入中的tsquery操作符、权重标签或前缀匹配标签:
SELECT plainto_tsquery('english', 'The Fat & Rats:C');
plainto_tsquery
---------------------
'fat' & 'rat' & 'c'
这里，所有输入的标点符号都被丢弃了。
phraseto_tsquery([ config regconfig, ] querytext text) returns tsquery
phraseto_tsquery的行为很像plainto_tsquery，不过前者会在留下来的词之间插入<->（FOLLOWED BY）操作符而不是&（AND）操作符。此外，停用词也不是简单地丢弃掉，而是通过插入<N>操作符（而不是<->操作符）来处理。在搜索准确的词位序列时这个函数很有用，因为FOLLOWED BY操作符不仅检查所有词位的存在性，还会检查词位的顺序。
例子：
SELECT phraseto_tsquery('english', 'The Fat Rats');
phraseto_tsquery
------------------
'fat' <-> 'rat'
和plainto_tsquery相似，phraseto_tsquery函数不会识别其输入中的tsquery操作符、权重标签或者前缀匹配标签：
SELECT phraseto_tsquery('english', 'The Fat & Rats:C');
phraseto_tsquery
-----------------------------
'fat' <-> 'rat' <-> 'c'
websearch_to_tsquery([ config regconfig, ] querytext text) returns tsquery
websearch_to_tsquery使用一种可供选择的语法从querytext创建一个tsquery值，这种语法中简单的未格式化文本是一个有效的查询。与plainto_tsquery和phraseto_tsquery不同，它还识别特定的操作符。此外，这个函数绝不会报出语法错误，这就可以把原始的用户提供的输入用于搜索。支持下列语法：
无引号文本：不在引号中的文本将被转换成由&操作符分隔的词，就像被plainto_tsquery处理过那样。
"引号文本"：在引号中的文本将被转换成由<->操作符分隔的词，就像被phraseto_tsquery处理过那样。
OR：“or”将转换为|运算符。
-：破折号将转换为!运算符。
忽略其他标点符号。因此，与plainto_tsquery和phraseto_tsquery一样，websearch_to_tsquery函数在其输入中将不会识别tsquery运算符、权重标签或前缀匹配标签。
示例：
SELECT websearch_to_tsquery('english', 'The fat rats');
websearch_to_tsquery
----------------------
'fat' & 'rat'
(1 row)
SELECT websearch_to_tsquery('english', '"supernovae stars" -crab');
websearch_to_tsquery
----------------------------------
'supernova' <-> 'star' & !'crab'
(1 row)
SELECT websearch_to_tsquery('english', '"sad cat" or "fat rat"');
websearch_to_tsquery
-----------------------------------
'sad' <-> 'cat' | 'fat' <-> 'rat'
(1 row)
SELECT websearch_to_tsquery('english', 'signal -"segmentation fault"');
websearch_to_tsquery
---------------------------------------
'signal' & !( 'segment' <-> 'fault' )
(1 row)
SELECT websearch_to_tsquery('english', '""" )( dummy \\ query <->');
websearch_to_tsquery
----------------------
'dummi' & 'queri'
(1 row)
12.3.3. 排名搜索结果 #
排名处理尝试度量文档和一个特定查询的相关性，这样当有很多匹配时最相关的那些可以被先显示。PostgreSQL提供了两种预定义的排名函数，它们考虑词法、临近性和结构信息；即，它们考虑查询词在文档中出现得有多频繁，文档中的词有多接近，以及词出现的文档部分有多重要。不过，相关性的概念是模糊的并且与应用非常相关。不同的应用可能要求额外的信息用于排名，例如，文档修改时间。内建的排名函数只是例子。你可以编写你自己的排名函数和/或把它们的结果与附加因素整合在一起来适应你的特定需求。
目前可用的两种排名函数是：
ts_rank([ weights float4[], ] vector tsvector, query tsquery [, normalization integer ]) returns float4
基于匹配词位的频率对向量进行排名。
ts_rank_cd([ weights float4[], ] vector tsvector, query tsquery [, normalization integer ]) returns float4
这个函数为给定文档向量和查询计算覆盖密度排名，该方法在 Clarke、Cormack 和 Tudhope 于 1999 年在期刊 "Information Processing and Management" 上的文章  "Relevance Ranking for One to Three Term Queries" 中有描述。覆盖密度类似于ts_rank排名，不过它会考虑匹配词位相互之间的接近度。
这个函数要求词位的位置信息来执行其计算。因此，它会忽略“被剥离的”词位。如果在输入中没有未被剥离的词位，结果将会是零（strip函数和tsvector中的位置信息的更多内容请见第 12.4.1 节）。
对这两个函数，可选的weights参数提供了为词实例赋予更多或更少权重的能力，这种能力是依据它们被标注的情况的。权重数组指定每一类词应该得到多重的权重，按照如下的顺序：
{D-权重, C-权重, B-权重, A-权重}
如果没有提供weights，那么将使用这些默认值：
{0.1, 0.2, 0.4, 1.0}
通常权重被用来标记来自文档特别区域的词，如标题或一个初始的摘要，这样它们可以被认为比来自文档正文的词更重要或更不重要。
由于一个较长的文档有更多的机会包含一个查询术语，因此考虑文档的尺寸是合理的，例如一个一百个词的文档中有一个搜索词的五个实例而零一个一千个词的文档中有该搜索词的五个实例，则前者比后者更相关。两种排名函数都采用一个整数normalization选项，它指定文档长度是否影响其排名以及如何影响。该整数选项控制多个行为，因此它是一个位掩码：你可以使用|指定一个或多个行为（例如，2|4）。
0（默认值）忽略文档长度
1 用 1 + 文档长度的对数除排名
2 用文档长度除排名
4 用长度之间的平均调和距离除排名（只被ts_rank_cd实现）
8 用文档中唯一词的数量除排名
16 用 1 + 文档中唯一词数量的对数除排名
32 用排名 + 1 除排名
如果多于一个标志位被指定，转换将根据列出的顺序被应用。
值得注意的是排名函数并不使用任何全局信息，因此它不可能按照某些时候期望地产生一个公平的正规化，从 1% 或 100%。正规化选项 32 （rank/(rank+1)）可以被应用来缩放所有的排名到范围零到一，但是当然这只是一个外观上的改变；它不会影响搜索结果的顺序。
这里是一个例子，它只选择十个最高排名的匹配：
SELECT title, ts_rank_cd(textsearch, query) AS rank
FROM apod, to_tsquery('neutrino|(dark & matter)') query
WHERE query @@ textsearch
ORDER BY rank DESC
LIMIT 10;
title                     |   rank
-----------------------------------------------+----------
Neutrinos in the Sun                          |      3.1
The Sudbury Neutrino Detector                 |      2.4
A MACHO View of Galactic Dark Matter          |  2.01317
Hot Gas and Dark Matter                       |  1.91171
The Virgo Cluster: Hot Plasma and Dark Matter |  1.90953
Rafting for Solar Neutrinos                   |      1.9
NGC 4650A: Strange Galaxy and Dark Matter     |  1.85774
Hot Gas and Dark Matter                       |   1.6123
Ice Fishing for Cosmic Neutrinos              |      1.6
Weak Lensing Distorts the Universe            | 0.818218
这是相同的例子使用正规化的排名：
SELECT title, ts_rank_cd(textsearch, query, 32 /* rank/(rank+1) */ ) AS rank
FROM apod, to_tsquery('neutrino|(dark & matter)') query
WHERE  query @@ textsearch
ORDER BY rank DESC
LIMIT 10;
title                     |        rank
-----------------------------------------------+-------------------
Neutrinos in the Sun                          | 0.756097569485493
The Sudbury Neutrino Detector                 | 0.705882361190954
A MACHO View of Galactic Dark Matter          | 0.668123210574724
Hot Gas and Dark Matter                       |  0.65655958650282
The Virgo Cluster: Hot Plasma and Dark Matter | 0.656301290640973
Rafting for Solar Neutrinos                   | 0.655172410958162
NGC 4650A: Strange Galaxy and Dark Matter     | 0.650072921219637
Hot Gas and Dark Matter                       | 0.617195790024749
Ice Fishing for Cosmic Neutrinos              | 0.615384618911517
Weak Lensing Distorts the Universe            | 0.450010798361481
排名可能会非常昂贵，因为它要求查询每一个匹配文档的tsvector，这可能会涉及很多I/O，因此很慢。不幸的是，这几乎不可能避免，因为实际查询常常导致大量的匹配。
12.3.4. 高亮结果 #
要表示搜索结果，理想的方式是显示每一个文档的一个部分并且显示它是怎样与查询相关的。通常，搜索引擎显示文档片段时会对其中的搜索术语进行标记。PostgreSQL提供了一个函数ts_headline来实现这个功能。
ts_headline([ config regconfig, ] document text, query tsquery [, options text ]) returns text
ts_headline 接受一个文档以及一个查询，并返回文档中
突出显示查询中术语的摘录。具体来说，该函数将使用查询选择相关的文本片段，
然后突出显示出现在查询中的所有单词，即使这些单词的位置与查询的限制不匹配。
可以通过config指定用于解析文档的配置；如果
config被省略，则使用
default_text_search_config配置。
如果指定了 options 字符串，它必须
由一个或多个 option=value 对组成，且用逗号分隔。
可用的选项包括：
MaxWords、MinWords（整数）：
这些数字决定了输出的最长和最短标题。
默认值为 35 和 15。
ShortWord（整数）：长度小于或等于此值的单词
将在标题的开头和结尾被删除，除非它们是
查询词。 默认值为三，去除了常见的英语
冠词。
HighlightAll（布尔值）：如果
true，整个文档将被用作
标题，忽略前面的三个参数。 默认值为
false。
MaxFragments（整数）：要显示的文本
片段的最大数量。 默认值为零，选择一种
非片段基础的标题生成方法。 大于零的值选择片段基础的标题生成（见下文）。
StartSel、StopSel（字符串）：
用于分隔出现在文档中的查询词的字符串，以将它们与其他摘录的单词区分开。 默认值为 “<b>” 和
“</b>”，这对于 HTML 输出是合适的（但请参见下面的警告）。
FragmentDelimiter（字符串）：当显示多个
片段时，片段将由此字符串分隔。
默认值为 “ ... ”。
警告：跨站脚本（XSS）安全性
ts_headline 的输出不能保证
安全地直接包含在网页中。当
HighlightAll 为 false（默认值）时，一些简单的 XML 标签会从文档中移除，但这
并不能保证移除所有 HTML 标记。因此，这并不能
有效防御诸如跨站脚本（XSS）攻击等攻击，尤其是在处理不受信任的输入时。为了防范
此类攻击，所有 HTML 标记应从输入
文档中移除，或在输出上使用 HTML 清理器。
这些选项名称不区分大小写。
如果字符串值包含空格或逗号，必须用双引号括起来。
在基于非片段的标题生成中，ts_headline为给定的query查找匹配项，并选择一个要显示的匹配项，优先选择在允许标题长度内具有更多查询词的匹配项。
在基于片段的标题生成中，ts_headline定位查询匹配项，并将每个匹配项拆分为“fragments”，每个匹配项不超过MaxWords个词，首选具有更多查询词的片段，并且在可能的情况下“拉伸”片段以包括周围的词。 因此，当查询匹配跨越文档的大部分时，或者当需要显示多个匹配时，基于片段的模式更有用。 在任一模式下，如果无法识别查询匹配项，则将显示文档中前 MinWords 单词的单个片段。
例如：
SELECT ts_headline('english',
'The most common type of search
is to find all documents containing given query terms
and return them in order of their similarity to the
query.',
to_tsquery('english', 'query & similarity'));
ts_headline
------------------------------------------------------------
containing given <b>query</b> terms                       +
and return them in order of their <b>similarity</b> to the+
<b>query</b>.
SELECT ts_headline('english',
'Search terms may occur
many times in a document,
requiring ranking of the search matches to decide which
occurrences to display in the result.',
to_tsquery('english', 'search & term'),
'MaxFragments=10, MaxWords=7, MinWords=3, StartSel=<<, StopSel=>>');
ts_headline
------------------------------------------------------------
<<Search>> <<terms>> may occur                            +
many times ... ranking of the <<search>> matches to decide
ts_headline使用原始文档，而不是一个tsvector摘要，因此它可能很慢并且应该小心使用。
上一页 上一级 下一页12.2. 表和索引 起始页 12.4. 附加功能
