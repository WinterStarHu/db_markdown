# DROP TEXT SEARCH PARSER

DROP TEXT SEARCH PARSER
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP TEXT SEARCH PARSERDROP TEXT SEARCH PARSER — 移除一个文本搜索解析器大纲
DROP TEXT SEARCH PARSER [ IF EXISTS ] name [ CASCADE | RESTRICT ]
描述
DROP TEXT SEARCH PARSER 删除一个
现有的文本搜索解析器。你必须是一个超级用户来使用这个命令。
参数IF EXISTS
如果该文本搜索解析器不存在，则不要抛出错误。
在这种情况下会发出一个提示。
name
一个现有文本搜索解析器的名称（可以是模式限定的）。
CASCADE
自动删除依赖于该文本搜索解析器的对象，然后删除所有
依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该文本搜索解析器，则拒绝删除它。这是默认值。
示例
移除文本搜索解析器my_parser：
DROP TEXT SEARCH PARSER my_parser;
如果有任何使用该解析器的文本搜索配置存在，这个命令都不会成功。增加
CASCADE可以将这类配置与解析器一起删除。
兼容性
SQL 标准中没有DROP TEXT SEARCH PARSER
语句。
另见ALTER TEXT SEARCH PARSER, CREATE TEXT SEARCH PARSER上一页 上一级 下一页DROP TEXT SEARCH DICTIONARY 起始页 DROP TEXT SEARCH TEMPLATE
