# ALTER TEXT SEARCH CONFIGURATION

ALTER TEXT SEARCH CONFIGURATION
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER TEXT SEARCH CONFIGURATIONALTER TEXT SEARCH CONFIGURATION — 更改文本搜索配置的定义大纲
ALTER TEXT SEARCH CONFIGURATION name
ADD MAPPING FOR token_type [, ... ] WITH dictionary_name [, ... ]
ALTER TEXT SEARCH CONFIGURATION name
ALTER MAPPING FOR token_type [, ... ] WITH dictionary_name [, ... ]
ALTER TEXT SEARCH CONFIGURATION name
ALTER MAPPING REPLACE old_dictionary WITH new_dictionary
ALTER TEXT SEARCH CONFIGURATION name
ALTER MAPPING FOR token_type [, ... ] REPLACE old_dictionary WITH new_dictionary
ALTER TEXT SEARCH CONFIGURATION name
DROP MAPPING [ IF EXISTS ] FOR token_type [, ... ]
ALTER TEXT SEARCH CONFIGURATION name RENAME TO new_name
ALTER TEXT SEARCH CONFIGURATION name OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
ALTER TEXT SEARCH CONFIGURATION name SET SCHEMA new_schema
描述
ALTER TEXT SEARCH CONFIGURATION
更改文本搜索配置的定义。你可以修改其从记号类型到词典的映射
或者更改该配置的名称或拥有者。
要使用ALTER TEXT SEARCH CONFIGURATION，
你必须是该配置的拥有者。
参数name
一个现有文本搜索配置的名称（可以是模式限定的）。
token_type
由该配置的解析器发出的记号类型的名称。
dictionary_name
在其中查阅指定角色类型的文本搜索字典的名称。如果列出了
多个字典，会按照指定的顺序查阅它们。
old_dictionary
在映射中要替换的文本搜索字典的名称。
new_dictionary
被用来替代old_dictionary
的文本搜索字典的名称。
new_name
该文本搜索配置的新名称。
new_owner
该文本搜索配置的新拥有者。
new_schema
该文本搜索配置的新模式。
ADD MAPPING FOR形式会安装一些字典（用列表列出）用于在其中
查阅指定的记号类型。如果对任一记号类型已经有一个映射，则会发生错误。
ALTER MAPPING FOR形式做同样的事情，但是首先会移除这些记号
类型的任何现有映射。ALTER MAPPING REPLACE形式用
new_dictionary来替换任何位
置上的old_dictionary。当出
现FOR时，只会为指定的记号类型做这样的事情。如果不出现
FOR，则会为该配置中所有的映射都这样做。
DROP MAPPING形式会移除指定记号类型的所有字典，导致该文本
搜索配置忽略这些类型。除非出现IF EXISTS，在那些记号类型没有
任何映射时会发生错误。
示例
下面的例子把english字典替换为swedish字典
在my_config中任何位置上使用english的地方。
ALTER TEXT SEARCH CONFIGURATION my_config
ALTER MAPPING REPLACE english WITH swedish;
兼容性
在 SQL 标准中没有ALTER TEXT SEARCH CONFIGURATION语句。
另见CREATE TEXT SEARCH CONFIGURATION, DROP TEXT SEARCH CONFIGURATION上一页 上一级 下一页ALTER TABLESPACE 起始页 ALTER TEXT SEARCH DICTIONARY
