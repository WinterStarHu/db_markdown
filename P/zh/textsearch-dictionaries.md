# 12.6. 词典

12.6. 词典
版本：
纠错本页面
搜索
目录导航
❮
❯
12.6. 词典 #12.6.1. 停用词12.6.2. 简单词典12.6.3. 同义词词典12.6.4. 同义词词典12.6.5. Ispell 词典12.6.6. Snowball 词典
词典被用来消除不被搜索考虑的词（stop words）、并被用来正规化词，这样同一个词的不同派生形式将会匹配。一个被成功地正规化的词被称为一个词位。除了提高搜索质量，正规化和移除停用词减小了文档的tsvector表示的尺寸，因而提高了性能。正规化不会总是有语言上的意义，并且通常依赖于应用的语义。
一些正规化的例子：
语言学的 — Ispell 词典尝试将输入词缩减为一种正规化的形式；词干分析器词典移除词的结尾
URL位置可以被规范化来得到等效的 URL 匹配：
http://www.pgsql.ru/db/mw/index.html
http://www.pgsql.ru/db/mw/
http://www.pgsql.ru/db/../db/mw/index.html
颜色名可以被它们的十六进制值替换，例如red, green, blue, magenta -> FF0000, 00FF00, 0000FF, FF00FF
如果索引数字，我们可以移除某些小数位来缩减可能的数字的范围，因此如果只保留小数点后两位，例如3.14159265359、3.1415926、3.14在正规化后会变得相同。
一个词典是一个程序，它接受一个记号作为输入，并返回：
如果输入的记号对词典是已知的，则返回一个词位数组（注意一个记号可能产生多于一个词位）
一个TSL_FILTER标志被设置的单一词位，用一个新记号来替换要被传递给后续字典的原始记号（做这件事的一个字典被称为一个过滤字典）
如果字典知道该记号但它是一个停用词，则返回一个空数组
如果字典不识别该输入记号，则返回NULL
PostgreSQL为许多语言提供了预定义的字典。也有多种预定义模板可以用于创建带自定义参数的新词典。每一种预定义词典模板在下面描述。如果没有合适的现有模板，可以创建新的；例子见PostgreSQL发布的contrib/区域。
一个文本搜索配置把一个解析器和一组处理解析器输出记号的词典绑定在一起。对于每一种解析器能返回的记号类型，配置都指定了一个单独的词典列表。当该类型的一个记号被解析器找到时，每一个词典都被按照顺序查询，直到某个词典将其识别为一个已知词。如果它被标识为一个停用词，或者没有一个词典识别它，它将被丢弃并且不会被索引和用于搜索。通常，第一个返回非NULL输出的词典决定结果，并且任何剩下的词典都不会被查找；但是一个过滤词典可以将给定词替换为一个被修改的词，它再被传递给后续的词典。
配置一个词典列表的通用规则是将最狭窄、最特定的词典放在第一位，然后是更加通用的词典，以一个非常通用的词典结尾，像一个Snowball词干分析器或simple，它识别所有内容。例如，对于一个天文学相关的搜索（astro_en配置）我们可以把记号类型asciiword（ASCII词）绑定到一个天文学术语的同义词词典、一个通用英语词典和一个Snowball英语词干分析器：
ALTER TEXT SEARCH CONFIGURATION astro_en
ADD MAPPING FOR asciiword WITH astrosyn, english_ispell, english_stem;
一个过滤词典可以被放置在列表中的任意位置，除了在最后，因为放在最后就等于无用。过滤词典可用于部分正规化词来简化后续词典的工作。例如，一个过滤词典可以被用来从带重音的字母中移除重音符号，就像unaccent模块所做的。
12.6.1. 停用词 #
停用词是非常常用、在几乎每一个文档中出现并且没有任何区分度的词。因此，在全文搜索的环境中它们可以被忽略。例如，每一段英语文本都包含a和the等词，因此把它们存储在一个索引中是没有用处的。但是，停用词确实会影响在tsvector中的位置，这进而会影响排名：
SELECT to_tsvector('english', 'in the list of stop words');
to_tsvector
----------------------------
'list':3 'stop':5 'word':6
缺失的位置1、2、4是因为停用词。文档的排名计算在使用和不使用停用词的情况下是很不同的：
SELECT ts_rank_cd (to_tsvector('english', 'in the list of stop words'), to_tsquery('list & stop'));
ts_rank_cd
------------
0.05
SELECT ts_rank_cd (to_tsvector('english', 'list stop words'), to_tsquery('list & stop'));
ts_rank_cd
------------
0.1
如何对待停用词是由指定词典决定的。例如，ispell词典首先正规化词并且查看停用词列表，而Snowball词干分析器首先检查停用词的列表。这种不同行为的原因是试图降低噪声。
12.6.2. 简单词典 #
simple词典模板的操作是将输入记号转换为小写形式并且根据一个停用词文件检查它。如果该记号在该文件中被找到，则返回一个空数组，导致该记号被丢弃。否则，该词的小写形式被返回作为正规化的词位。作为一种选择，该词典可以被配置为将非停用词报告为未识别，允许它们被传递给列表中的下一个词典。
下面是一个使用simple模板的词典定义的例子：
CREATE TEXT SEARCH DICTIONARY public.simple_dict (
TEMPLATE = pg_catalog.simple,
STOPWORDS = english
);
这里，english是一个停用词文件的基本名称。该文件的全名将是$SHAREDIR/tsearch_data/english.stop，其中$SHAREDIR表示PostgreSQL安装的共享数据目录，通常是/usr/local/share/postgresql（如果不确定，使用pg_config --sharedir）。该文件格式是一个词的列表，每行一个。空行和尾部的空格都被忽略，并且大写也被折叠成小写，但是没有其他对该文件内容的处理。
现在我们能够测试我们的词典：
SELECT ts_lexize('public.simple_dict', 'YeS');
ts_lexize
-----------
{yes}
SELECT ts_lexize('public.simple_dict', 'The');
ts_lexize
-----------
{}
如果没有在停用词文件中找到，我们也可以选择返回NULL而不是小写形式的词。这种行为可以通过设置词典的Accept参数为false来选择。继续该例子：
ALTER TEXT SEARCH DICTIONARY public.simple_dict ( Accept = false );
SELECT ts_lexize('public.simple_dict', 'YeS');
ts_lexize
-----------
SELECT ts_lexize('public.simple_dict', 'The');
ts_lexize
-----------
{}
在使用默认值Accept = true时，只有把一个simple词典放在词典列表的尾部才有用，因为它将不会传递任何记号给后续的词典。相反，Accept = false只有当至少有一个后续词典的情况下才有用。
小心
大部分类型的词典依赖于配置文件，例如停用词文件。这些文件必须被存储为 UTF-8 编码。当它们被读入服务器时，如果存在不同，它们将被翻译成真实的数据库编码。
小心
通常，当一个词典配置文件第一次在数据库会话中使用时，数据库会话将只读取它一次。如果你修改了一个配置文件并且想强迫现有的会话取得新内容，可以在该词典上发出一个ALTER TEXT SEARCH DICTIONARY命令。这可以是一次“假”更新，它并不实际修改任何参数值。
12.6.3. 同义词词典 #
这个字典模板用于创建将单词替换为同义词的字典。不支持短语（请使用词典模板第 12.6.4 节）。同义词字典可用于解决语言问题，例如，防止英语词干字典将单词“Paris”减少为“pari”。在同义词字典中只需有一行Paris paris，并将其放在english_stem字典之前。例如：
SELECT * FROM ts_debug('english', 'Paris');
alias   |   description   | token |  dictionaries  |  dictionary  | lexemes
-----------+-----------------+-------+----------------+--------------+---------
asciiword | Word, all ASCII | Paris | {english_stem} | english_stem | {pari}
CREATE TEXT SEARCH DICTIONARY my_synonym (
TEMPLATE = synonym,
SYNONYMS = my_synonyms
);
ALTER TEXT SEARCH CONFIGURATION english
ALTER MAPPING FOR asciiword
WITH my_synonym, english_stem;
SELECT * FROM ts_debug('english', 'Paris');
alias   |   description   | token |       dictionaries        | dictionary | lexemes
-----------+-----------------+-------+---------------------------+------------+---------
asciiword | Word, all ASCII | Paris | {my_synonym,english_stem} | my_synonym | {paris}
synonym模板要求的唯一参数是SYNONYMS，它是其配置文件的基本名 — 上例中的my_synonyms。该文件的完整名称将是$SHAREDIR/tsearch_data/my_synonyms.syn（其中$SHAREDIR表示PostgreSQL安装的共享数据目录）。该文件格式是每行一个要被替换的词，后面跟着它的同义词，用空白分隔。空行和结尾的空格会被忽略。
synonym模板还有一个可选的参数CaseSensitive，其默认值为false。当CaseSensitive为false时，同义词文件中的词被折叠成小写，这和输入标记一样。当它为true时，词和标记将不会被折叠成小写，但是比较时就好像被折叠过一样。
在配置文件中，同义词的末尾可以放置一个星号（*）。这表示该同义词是一个前缀。当在to_tsvector()中使用该条目时，星号会被忽略，但当在to_tsquery()中使用时，结果将是一个带有前缀匹配标记的查询项（参见第 12.3.2 节）。例如，假设我们在$SHAREDIR/tsearch_data/synonym_sample.syn中有以下条目：
postgres        pgsql
postgresql      pgsql
postgre pgsql
gogle   googl
indices index*
那么我们将得到以下结果：
mydb=# CREATE TEXT SEARCH DICTIONARY syn (template=synonym, synonyms='synonym_sample');
mydb=# SELECT ts_lexize('syn', 'indices');
ts_lexize
-----------
{index}
(1 row)
mydb=# CREATE TEXT SEARCH CONFIGURATION tst (copy=simple);
mydb=# ALTER TEXT SEARCH CONFIGURATION tst ALTER MAPPING FOR asciiword WITH syn;
mydb=# SELECT to_tsvector('tst', 'indices');
to_tsvector
-------------
'index':1
(1 row)
mydb=# SELECT to_tsquery('tst', 'indices');
to_tsquery
------------
'index':*
(1 row)
mydb=# SELECT 'indexes are very useful'::tsvector;
tsvector
---------------------------------
'are' 'indexes' 'useful' 'very'
(1 row)
mydb=# SELECT 'indexes are very useful'::tsvector @@ to_tsquery('tst', 'indices');
?column?
----------
t
(1 row)
12.6.4. 同义词词典 #
一个同义词词典（有时被简写成TZ）是一个词的集合，其中包括了词与短语之间的联系，即广义词（BT）、狭义词（NT）、首选词、非首选词、相关词等。
基本上一个同义词词典会用一个首选词替换所有非首选词，并且也可选择地保留原始术语用于索引。PostgreSQL的同义词词典的当前实现是同义词词典的一个扩展，并增加了短语支持。一个同义词词典要求一个下列格式的配置文件：
# this is a comment
sample word(s) : indexed word(s)
more sample word(s) : more indexed word(s)
...
其中冒号（:）符号扮演了一个短语及其替换之间的定界符。
一个同义词词典使用一个子词典（在词典的配置中指定）在检查短语匹配之前正规化输入文本。只能选择一个子词典。如果子词典无法识别一个词，将报告一个错误。在这种情况下，你应该移除该词的使用或者让子词典学会这个词。你可以在一个被索引词的开头放上一个星号（*）来跳过在其上应用子词典，但是所有样本词必须被子词典知道。
如果有多个短语匹配输入，则分类词典选择最长的那一个，并且使用最后的定义打破平局。
由子词典识别的特定停用词不能够被指定；改用?标记任何可以出现停用词的地方。例如，假定根据子词典a和the是停用词：
? one ? two : swsw
匹配a one the two和the one a two；两者都将被swsw替换。
由于一个分类词典具有识别短语的能力，它必须记住它的状态并与解析器交互。一个分类词典使用这些任务来检查它是否应当处理下一个词或者停止累积。分类词典必须被小心地配置。例如，如果分类词典被分配只处理asciiword记号，则一个形如one 7的分类词典定义将不会工作，因为记号类型uint没有被分配给该分类词典。
小心
在索引期间要用到分类词典，因此分类词典参数中的任何变化都要求重新索引。对于大多数其他字典类型，例如增加或移除停用词等小改动都不会强制重新索引。
12.6.4.1. 分类词典配置 #
要定义一个新的分类词典，可使用thesaurus模板。例如：
CREATE TEXT SEARCH DICTIONARY thesaurus_simple (
TEMPLATE = thesaurus,
DictFile = mythesaurus,
Dictionary = pg_catalog.english_stem
);
这里：
thesaurus_simple是新词典的名称
mythesaurus是分类词典配置文件的基础名称（它的全名将是$SHAREDIR/tsearch_data/mythesaurus.ths，其中$SHAREDIR表示安装的共享数据目录）。
pg_catalog.english_stem是要用于分类词典正规化的子词典（这里是一个 Snowball 英语词干分析器）。注意子词典将拥有它自己的配置（例如停用词），但这里没有展示。
现在可以在配置中把分类词典thesaurus_simple绑定到想要的记号类型上，例如：
ALTER TEXT SEARCH CONFIGURATION russian
ALTER MAPPING FOR asciiword, asciihword, hword_asciipart
WITH thesaurus_simple;
12.6.4.2. 分类词典示例 #
考虑一个简单的天文学分类词典thesaurus_astro，它包含一些天文学词组合：
supernovae stars : sn
crab nebulae : crab
下面我们创建一个词典并绑定一些记号类型到一个天文学分类词典以及英语词干分析器：
CREATE TEXT SEARCH DICTIONARY thesaurus_astro (
TEMPLATE = thesaurus,
DictFile = thesaurus_astro,
Dictionary = english_stem
);
ALTER TEXT SEARCH CONFIGURATION russian
ALTER MAPPING FOR asciiword, asciihword, hword_asciipart
WITH thesaurus_astro, english_stem;
现在我们可以看看它如何工作。ts_lexize对于测试一个分类词典用处不大，因为它把它的输入看成是一个单一记号。我们可以用plainto_tsquery和to_tsvector，它们将把其输入字符串打断成多个记号：
SELECT plainto_tsquery('supernova star');
plainto_tsquery
-----------------
'sn'
SELECT to_tsvector('supernova star');
to_tsvector
-------------
'sn':1
原则上，如果你对参数加了引号，你可以使用to_tsquery：
SELECT to_tsquery('''supernova star''');
to_tsquery
------------
'sn'
注意在thesaurus_astro中supernova star匹配supernovae stars，因为我们在分类词典定义中指定了english_stem词干分析器。该词干分析器移除了e和s。
要索引原始短语以及替代短语，只需将其包含在定义的右侧部分中：
supernovae stars : sn supernovae stars
SELECT plainto_tsquery('supernova star');
plainto_tsquery
-----------------------------
'sn' & 'supernova' & 'star'
12.6.5. Ispell 词典 #
Ispell词典模板支持词法词典，它可以把一个词的很多不同语言学的形式正规化成相同的词位。例如，一个英语Ispell词典可以匹配搜索词bank的词尾变化和词形变化，例如banking、banked、banks、banks'和bank's。
标准PostgreSQL发行版不包含任何Ispell配置文件。
大量语言的词典可从Ispell获取。
此外，还支持一些更现代的词典文件格式 — MySpell (OO < 2.0.1)
和Hunspell(OO >= 2.0.2)。在OpenOffice
Wiki上有大量词典可用。
要创建一个Ispell词典，执行这些步骤：
下载词典配置文件。OpenOffice扩展文件的扩展名是.oxt。有必要提取.aff和.dic文件，把扩展名改为.affix和.dict。对于某些词典文件，还需要使用下面的命令把字符转换成 UTF-8 编码（例如挪威语词典）：
iconv -f ISO_8859-1 -t UTF-8 -o nn_no.affix nn_NO.aff
iconv -f ISO_8859-1 -t UTF-8 -o nn_no.dict nn_NO.dic
拷贝文件到$SHAREDIR/tsearch_data目录
用下面的命令将文件加载到 PostgreSQL：
CREATE TEXT SEARCH DICTIONARY english_hunspell (
TEMPLATE = ispell,
DictFile = en_us,
AffFile = en_us,
Stopwords = english);
这里，DictFile、AffFile和StopWords指定词典、词缀和停用词文件的基础名称。停用词文件的格式和前面解释的simple词典类型相同。其他文件的格式在这里没有指定，但是可以从上面提到的网站获得。
Ispell 词典通常识别一个有限集合的词，因此它们后面应该跟着另一个更广义的词典；例如，一个 Snowball 词典，它可以识别所有内容。
Ispell的.affix文件具有下面的结构：
prefixes
flag *A:
.           >   RE      # As in enter > reenter
suffixes
flag T:
E           >   ST      # As in late > latest
[^AEIOU]Y   >   -Y,IEST # As in dirty > dirtiest
[AEIOU]Y    >   EST     # As in gray > grayest
[^EY]       >   EST     # As in small > smallest
.dict文件具有下面的结构：
lapse/ADGRS
lard/DGRS
large/PRTY
lark/MRS
.dict文件的格式是：
basic_form/affix_class_name
在.affix文件中，每一个词缀标志以下面的格式描述：
condition > [-stripping_letters,] adding_affix
这里的条件具有和正则表达式相似的格式。它可以使用分组[...]和[^...]。例如，[AEIOU]Y表示词的最后一个字母是"y"并且倒数第二个字母是"a"、"e"、"i"、"o"或者"u"。[^EY]表示最后一个字母既不是"e"也不是"y"。
Ispell 词典支持划分复合词，这是一个有用的特性。注意词缀文件应该用compoundwords controlled语句指定一个特殊标志，它标记可以参与到复合构成中的词典词：
compoundwords  controlled z
下面是挪威语的一些例子：
SELECT ts_lexize('norwegian_ispell', 'overbuljongterningpakkmesterassistent');
{over,buljong,terning,pakk,mester,assistent}
SELECT ts_lexize('norwegian_ispell', 'sjokoladefabrikk');
{sjokoladefabrikk,sjokolade,fabrikk}
MySpell格式是Hunspell格式的一个子集。Hunspell的.affix文件具有下面的结构：
PFX A Y 1
PFX A   0     re         .
SFX T N 4
SFX T   0     st         e
SFX T   y     iest       [^aeiou]y
SFX T   0     est        [aeiou]y
SFX T   0     est        [^ey]
一个词缀类的第一行是头部。头部后面列出了词缀规则的字段：
参数名（PFX 或 SFX）
标志（词缀类的名称）
从该词的开始（前缀）或结尾（后缀）剥离字符
增加词缀
和正则表达式格式类似的条件。
.dict文件看起来和Ispell的.dict文件相似：
larder/M
lardy/RT
large/RSPMYT
largehearted
注意
MySpell 不支持复合词。Hunspell则对复合词有更好的支持。当前，PostgreSQL只实现了 Hunspell 中基本的复合词操作。
12.6.6. Snowball 词典 #
Snowball 词典模板基于 Martin Porter 的一个项目，他是流行的英语 Porter 词干分析算法的发明者。Snowball 现在对许多语言提供词干分析算法（详见Snowball 站点）。每一个算法懂得按照其语言中的拼写，如何缩减词的常见变体形式为一个基础或词干。一个 Snowball 词典要求一个language参数来标识要用哪种词干分析器，并且可以选择地指定一个stopword文件名来给出一个要被消除的词列表（PostgreSQL的标准停用词列表也是由 Snowball 项目提供的）。例如，有一个内建的定义等效于
CREATE TEXT SEARCH DICTIONARY english_stem (
TEMPLATE = snowball,
Language = english,
StopWords = english
);
停用词文件格式和已经解释的一样。
一个Snowball词典识别所有的东西，不管它能不能简化该词，因此它应当被放置在词典列表的最后。把它放在任何其他词典前面是没有用处的，因为一个记号永远不会穿过它而进入到下一个词典。
上一页 上一级 下一页12.5. 解析器 起始页 12.7. 配置示例
