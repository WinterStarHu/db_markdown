# CREATE TEXT SEARCH DICTIONARY

CREATE TEXT SEARCH DICTIONARY
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE TEXT SEARCH DICTIONARYCREATE TEXT SEARCH DICTIONARY — 定义一个新的文本搜索字典大纲
CREATE TEXT SEARCH DICTIONARY name (
TEMPLATE = template
[, option = value [, ... ]]
)
描述
CREATE TEXT SEARCH DICTIONARY 创建一个
新的文本搜索字典。一个文本搜索字典指定一种识别搜索感兴趣或者不感兴趣
的单词的方法。一个字典依赖于一个文本搜索模板，后者指定了实际执行该工
作的函数。通常该字典提供一些控制该模板函数细节行为的选项。
如果给出了一个模式名称，那么该文本搜索字典会被创建在指定的模式中。
否则它会被创建在当前模式中。
定义文本搜索字典的用户将成为其拥有者。
进一步的信息可参考第 12 章。
参数name
要创建的文本搜索字典的名称。该名称可以是模式限定的。
template
将定义该字典基本行为的文本搜索模板的名称。
option
要为此字典设置的模板特定选项的名称。
value
用于模板特定选项的值。如果该值不是一个简单标识符或数字，它必须
被加引号（但如果你愿意，可以始终对其加引号）。
选项可以以任意顺序出现。
示例
下面的示例命令创建了一个基于 Snowball 的字典，它使用了非标准的
停用词列表。
CREATE TEXT SEARCH DICTIONARY my_russian (
template = snowball,
language = russian,
stopwords = myrussian
);
兼容性
在 SQL 标准中没有
CREATE TEXT SEARCH DICTIONARY 语句。
另见ALTER TEXT SEARCH DICTIONARY, DROP TEXT SEARCH DICTIONARY上一页 上一级 下一页CREATE TEXT SEARCH CONFIGURATION 起始页 CREATE TEXT SEARCH PARSER
