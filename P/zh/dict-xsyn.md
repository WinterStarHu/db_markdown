# F.13. dict_xsyn — 示例同义词全文搜索字典

F.13. dict_xsyn — 示例同义词全文搜索字典
版本：
纠错本页面
搜索
目录导航
❮
❯
F.13. dict_xsyn — 示例同义词全文搜索字典 #F.13.1. 配置F.13.2. 用法
dict_xsyn（扩展同义词字典）是一个附加全文搜索字典模板的例子。这种字典类型将词替换为它们的同义词分组，并且使使用其任一同义词进行搜索变得可能。
F.13.1. 配置 #
一个dict_xsyn字典接受以下选项：
matchorig控制该字典是否接受原始词。默认为true。
matchsynonyms控制该字典是否接受同义词。默认为false。
keeporig控制原始词是否被包括在字典的输出中。默认为true。
keepsynonyms 控制同义词是否被包括在词典的输出中。默认为 true。
rules 是包含同义词列表的文件的基本名。这个文件必须被存储在 $SHAREDIR/tsearch_data/（其中 $SHAREDIR 表示 PostgreSQL 安装的共享数据目录）中。它的名称必须以 .rules 结束（这不包括在 rules 参数中）。
规则文件具有以下格式：
每一行表示一个单一词的同义词分组，它在该行中首先被给出。同义词被空白分隔，这样：
word syn1 syn2 syn3
井号（#）是注释定界符。它可以出现在一行中的任何位置。该行的剩余部分将被跳过。
例如，可以看看安装在 $SHAREDIR/tsearch_data/ 中的 xsyn_sample.rules。
F.13.2. 用法 #
安装 dict_xsyn 扩展会用默认参数创建一个文本搜索模板 xsyn_template 以及一个基于它的词典 xsyn。你可以修改参数，例如
mydb# ALTER TEXT SEARCH DICTIONARY xsyn (RULES='my_rules', KEEPORIG=false);
ALTER TEXT SEARCH DICTIONARY
或者基于该模板创建新的词典。
要测试该词典，你可以尝试
mydb=# SELECT ts_lexize('xsyn', 'word');
ts_lexize
-----------------------
{syn1,syn2,syn3}
mydb# ALTER TEXT SEARCH DICTIONARY xsyn (RULES='my_rules', KEEPORIG=true);
ALTER TEXT SEARCH DICTIONARY
mydb=# SELECT ts_lexize('xsyn', 'word');
ts_lexize
-----------------------
{word,syn1,syn2,syn3}
mydb# ALTER TEXT SEARCH DICTIONARY xsyn (RULES='my_rules', KEEPORIG=false, MATCHSYNONYMS=true);
ALTER TEXT SEARCH DICTIONARY
mydb=# SELECT ts_lexize('xsyn', 'syn1');
ts_lexize
-----------------------
{syn1,syn2,syn3}
mydb# ALTER TEXT SEARCH DICTIONARY xsyn (RULES='my_rules', KEEPORIG=true, MATCHORIG=false, KEEPSYNONYMS=false);
ALTER TEXT SEARCH DICTIONARY
mydb=# SELECT ts_lexize('xsyn', 'syn1');
ts_lexize
-----------------------
{word}
现实世界的用法将涉及将它包括在一个文本搜索配置中，如第 12 章所描述的。看起来像这样：
ALTER TEXT SEARCH CONFIGURATION english
ALTER MAPPING FOR word, asciiword WITH xsyn, english_stem;
上一页 上一级 下一页F.12. dict_int —
示例全文搜索字典用于整数 起始页 F.14. earthdistance — 计算大圆距离
