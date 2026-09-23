# CREATE TEXT SEARCH TEMPLATE

CREATE TEXT SEARCH TEMPLATE
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE TEXT SEARCH TEMPLATECREATE TEXT SEARCH TEMPLATE — 定义一个新的文本搜索模板大纲
CREATE TEXT SEARCH TEMPLATE name (
[ INIT = init_function , ]
LEXIZE = lexize_function
)
描述
CREATE TEXT SEARCH TEMPLATE 创建一个
新的文本搜索模板。文本搜索模板定义实现文本搜索字典的函数。一个模板
本身没什么用处，但是必须被实例化为一个字典来使用。字典通常指定要给
予模板函数的参数。
如果给出了一个模式名，文本搜索模板会被创建在指定模式中。否则它会被
创建在当前模式中。
必须成为超级用户以使用
CREATE TEXT SEARCH TEMPLATE。这种限制是因为错误的文本
搜索模板定义会让服务器混淆甚至崩溃。将模板与字典分隔开来的原因是模板
中封装了定义字典的“不安全”方面。在定义字典时可以被设置的
参数对非特权用户是可以安全设置的，因此创建字典不需要拥有特权来操作。
进一步的信息可以参考第 12 章。
参数name
要创建的文本搜索模板的名称。该名称可以被模式限定。
init_function
用于模板的初始化函数的名称。
lexize_function
用于模板的分词函数的名称。
如有必要，函数名称可以被模式限定。参数类型没有给出，因为每一类
函数的参数列表是预先定义好的。分词函数是必需的，但初始化函数
是可选的。
参数可以以任何顺序出现，而不仅仅是上文所示的顺序。
兼容性
在 SQL 标准中没有
CREATE TEXT SEARCH TEMPLATE 语句。
另请参阅ALTER TEXT SEARCH TEMPLATE, DROP TEXT SEARCH TEMPLATE上一页 上一级 下一页CREATE TEXT SEARCH PARSER 起始页 CREATE TRANSFORM
