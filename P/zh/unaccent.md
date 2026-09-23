# F.48. unaccent — 一个去除变音符号的文本搜索字典

F.48. unaccent — 一个去除变音符号的文本搜索字典
版本：
纠错本页面
搜索
目录导航
❮
❯
F.48. unaccent — 一个去除变音符号的文本搜索字典 #F.48.1. 配置F.48.2. 用法F.48.3. 函数
unaccent是一个文本搜索字典，它能从词位中移除重音
（变音符号）。它是一个过滤词典，这表示它的输出总是会被传递给下一个
字典（如果有），这和字典的通常行为不同。这允许为全文搜索做与重音无关的处理。
unaccent的当前实现不能被用作thesaurus字典的正规化字典。
这个模块被认为是“可信的”，也就是说，它可以由对当前数据库具有CREATE权限的非超级用户安装。
F.48.1. 配置 #
unaccent字典接受下列选项：
RULES是包含翻译规则列表的文件的基本名。这个文件必须被存储在$SHAREDIR/tsearch_data/（这里$SHAREDIR表示PostgreSQL安装的共享数据目录）中。它的名称必须以.rules（不包含在RULES参数中）结束。
规则文件具有下面的格式：
每一行表示一个翻译规则，由一个带有重音的字符和一个不带重音的字符构成。
第一个字符将被翻译成第二个。例如，
À        A
Á        A
Â        A
Ã        A
Ä        A
Å        A
Æ        AE
两个字符必须由空格分隔，并且一行上的任何前导或尾随空白都将被忽略。
或者，如果一行只给出一个字符，则删除该字符的实例；
这在用单独的字符表示重音的语言中是有用的。
实际上，每个“字符”可以是不包含空格的任何字符串，因此，
除了去除变音符之外，unaccent字典也可以用于其他类型的字符串替换。
一些字符，比如数字符号，可能在它们的翻译规则中需要空格。在这种情况下，可以使用双引号将翻译后的字符括起来。
当翻译字符中包含双引号时，需要用第二个双引号对其进行转义。例如：
¼      " 1/4"
½      " 1/2"
¾      " 3/4"
“       """"
”       """"
与其他PostgreSQL文本搜索配置文件一样，
规则文件必须以UTF-8编码方式存储。加载时，数据将自动转换为当前数据库的编码。
任何含有不可翻译字符的行都将被忽略，因此规则文件可以包含当前编码中不适用的规则。
在unaccent.rules中可以找到一个更完整的例子，它可以直接用于大部分欧洲语言，
当unaccent模块被安装时，它被安装在$SHAREDIR/tsearch_data/中。
这个规则文件将带有重音的字符翻译为相同的无重音字符，并且还将连字扩展为等效的一系列简单字符
（例如，Æ 转换为 AE）。
F.48.2. 用法 #
安装unaccent扩展会创建一个文本搜索模板unaccent和一个基于它的字典unaccent。unaccent字典有默认的参数设置RULES='unaccent'，这会让该字典使用标准的unaccent.rules文件。如果你希望修改该参数，可以
mydb=# ALTER TEXT SEARCH DICTIONARY unaccent (RULES='my_rules');
或者基于该模板创建新的字典。
要测试该字典，你可以尝试：
mydb=# select ts_lexize('unaccent','Hôtel');
ts_lexize
-----------
{Hotel}
(1 row)
这里是一个展示如何将unaccent字典插入到一个文本搜索配置的例子：
mydb=# CREATE TEXT SEARCH CONFIGURATION fr ( COPY = french );
mydb=# ALTER TEXT SEARCH CONFIGURATION fr
ALTER MAPPING FOR hword, hword_part, word
WITH unaccent, french_stem;
mydb=# select to_tsvector('fr','Hôtels de la Mer');
to_tsvector
-------------------
'hotel':1 'mer':4
(1 row)
mydb=# select to_tsvector('fr','Hôtel de la Mer') @@ to_tsquery('fr','Hotels');
?column?
----------
t
(1 row)
mydb=# select ts_headline('fr','Hôtel de la Mer',to_tsquery('fr','Hotels'));
ts_headline
------------------------
<b>Hôtel</b> de la Mer
(1 row)
F.48.3. 函数 #
unaccent()函数从一个给定的字符串中移除重音（附加符号）。基本上，它是unaccent字典的一个包装器，但是它可以在普通的文本搜索环境之外使用。
unaccent([dictionary regdictionary, ] string text) returns text
如果省略dictionary参数，则使用名为unaccent并且与unaccent()函数在同一模式下的文本搜索字典。
例如：
SELECT unaccent('unaccent', 'Hôtel');
SELECT unaccent('Hôtel');
上一页 上一级 下一页F.47. tsm_system_time —
SYSTEM_TIME采样方法用于TABLESAMPLE 起始页 F.49. uuid-ossp — 一个UUID生成器
