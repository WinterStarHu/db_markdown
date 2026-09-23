# CREATE TEXT SEARCH PARSER

CREATE TEXT SEARCH PARSER
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE TEXT SEARCH PARSERCREATE TEXT SEARCH PARSER — 定义一个新的文本搜索解析器大纲
CREATE TEXT SEARCH PARSER name (
START = start_function ,
GETTOKEN = gettoken_function ,
END = end_function ,
LEXTYPES = lextypes_function
[, HEADLINE = headline_function ]
)
描述
CREATE TEXT SEARCH PARSER 创建一个
新的文本搜索解析器。一个文本搜索解析器定义把文本字符串分解成记号
并且为记号分配类型（分类）的方法。一个解析器本身并不特别有用，但
是必须与一些要用于搜索的文本搜索字典一起绑定到一个文本搜索配置
中。
如果给出了一个模式名称，那么文本搜索解析器将被创建在指定的模式中。
否则它会被创建在当前模式中。
只有超级用户才能使用 CREATE TEXT SEARCH PARSER。
（这是因为错误的文本搜索解析器定义可能会让服务器混淆甚至崩溃。）
更多信息可以参考 第 12 章。
参数name
要创建的文本搜索解析器的名称。该名称可以是模式限定的。
start_function
用于该解析器的开始函数名称。
gettoken_function
用于该解析器的取下一个记号函数名称。
end_function
用于该解析器的结束函数名称。
lextypes_function
用于该解析器的词法类型函数（一个返回其产生的记号类型集合信息的函数）的名称。
headline_function
用于该解析器的标题函数（一个对记号集合进行综述的函数）的名称。
如有必要，函数的名称可以被模式限定。参数类型没有给出，
因为每种类型的函数的参数列表是预先确定的。除了标题函数之外，
所有函数都是必需的。
参数可以以任何顺序出现，而不是必须按照上面所展示的顺序。
兼容性
在 SQL 标准中没有
CREATE TEXT SEARCH PARSER 语句。
另见ALTER TEXT SEARCH PARSER, DROP TEXT SEARCH PARSER上一页 上一级 下一页CREATE TEXT SEARCH DICTIONARY 起始页 CREATE TEXT SEARCH TEMPLATE
