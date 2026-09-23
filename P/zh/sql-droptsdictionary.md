# DROP TEXT SEARCH DICTIONARY

DROP TEXT SEARCH DICTIONARY
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP TEXT SEARCH DICTIONARYDROP TEXT SEARCH DICTIONARY — 移除一个文本搜索字典大纲
DROP TEXT SEARCH DICTIONARY [ IF EXISTS ] name [ CASCADE | RESTRICT ]
描述
DROP TEXT SEARCH DICTIONARY 删除一个
现有的文本搜索字典。要执行这个命令，你必须是该字典的拥有者。
参数IF EXISTS
如果该文本搜索字典不存在则不要抛出错误，而是发出一个提示。
name
一个现有文本搜索字典的名称（可以是模式限定的）。
CASCADE
自动删除依赖于该文本搜索字典的对象，然后删除所有
依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该文本搜索字典，则拒绝删除它。这是默认值。
示例
移除文本搜索字典english：
DROP TEXT SEARCH DICTIONARY english;
如果有任何使用该字典的文本搜索配置存在，这个命令都不会成功。增加
CASCADE可以将这类配置与字典一起删除。
兼容性
SQL 标准中没有DROP TEXT SEARCH DICTIONARY
语句。
另见ALTER TEXT SEARCH DICTIONARY, CREATE TEXT SEARCH DICTIONARY上一页 上一级 下一页DROP TEXT SEARCH CONFIGURATION 起始页 DROP TEXT SEARCH PARSER
