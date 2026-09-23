# ALTER TEXT SEARCH DICTIONARY

ALTER TEXT SEARCH DICTIONARY
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER TEXT SEARCH DICTIONARYALTER TEXT SEARCH DICTIONARY — 更改文本搜索字典的定义大纲
ALTER TEXT SEARCH DICTIONARY name (
option [ = value ] [, ... ]
)
ALTER TEXT SEARCH DICTIONARY name RENAME TO new_name
ALTER TEXT SEARCH DICTIONARY name OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
ALTER TEXT SEARCH DICTIONARY name SET SCHEMA new_schema
描述
ALTER TEXT SEARCH DICTIONARY更改文本搜索字典的定义。你可以更改该字典的模板特定选项，或者更改该字典的名称或拥有者。
要使用
ALTER TEXT SEARCH DICTIONARY，你必须是字典的拥有者。
参数name
一个现有的文本搜索字典的名称（可以是模式限定的）。
option
要为这个字典设置的模板特定选项的名称。
value
用于一个模板特定选项的新值。如果等号和值被忽略，则会从该字典
中移除该选项之前的设置，允许使用默认值。
new_name
该文本搜索字典的新名称。
new_owner
该文本搜索字典的新拥有者。
new_schema
该文本搜索字典的新模式。
模板特定的选项可以以任何顺序出现。
示例
下面的命令更改一个基于 Snowball 的字典的停用词列表。其他参数保持不变。
ALTER TEXT SEARCH DICTIONARY my_dict ( StopWords = newrussian );
下面的命令更改语言选项为dutch，并完全移除停用词选项。
ALTER TEXT SEARCH DICTIONARY my_dict ( language = dutch, StopWords );
下面的命令“更新”该字典的定义，但实际上没有做任何更改。
ALTER TEXT SEARCH DICTIONARY my_dict ( dummy );
（之所以能这样做是因为选项移除代码在选项不存在时也不会抱怨）。
这种技巧在为该字典更改配置文件时有用：ALTER
将强制现有的数据库会话重读配置文件，否则如果会话之前已经读取过
就不会再次读取。
兼容性
在 SQL 标准中没有
ALTER TEXT SEARCH DICTIONARY语句。
其他参考CREATE TEXT SEARCH DICTIONARY, DROP TEXT SEARCH DICTIONARY上一页 上一级 下一页ALTER TEXT SEARCH CONFIGURATION 起始页 ALTER TEXT SEARCH PARSER
