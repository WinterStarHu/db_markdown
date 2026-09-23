# CREATE ACCESS METHOD

CREATE ACCESS METHOD
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE ACCESS METHODCREATE ACCESS METHOD — 定义一个新的访问方法大纲
CREATE ACCESS METHOD name
TYPE access_method_type
HANDLER handler_function
描述
CREATE ACCESS METHOD 创建一种新的访问方法。
访问方法名称在数据库中必须是唯一的。
只有超级用户可以定义新的访问方法。
参数name
要创建的访问方法的名称。
access_method_type
这个子句指定要定义的访问方法的类型。当前只支持TABLE和INDEX。
handler_function
handler_function是一个之前已注册的函数的名称（可能被模式限定），该函数表示访问方法。处理器函数必须被声明为接收一个单一的internal类型的参数，并且它的返回类型取决于访问方法的类型；
对于TABLE访问方法，它必须是table_am_handler，而对于INDEX访问方法，它必须是index_am_handler。
处理器函数必须实现的 C 级别 API 取决于访问方法的类型。第 62 章中描述了表访问方法的API，而第 63 章中描述了索引访问方法的 API。
示例
用处理器函数heptree_handler创建一种索引访问方法heptree：
CREATE ACCESS METHOD heptree TYPE INDEX HANDLER heptree_handler;
兼容性
CREATE ACCESS METHOD是一种PostgreSQL扩展。
另见DROP ACCESS METHOD, CREATE OPERATOR CLASS, CREATE OPERATOR FAMILY上一页 上一级 下一页COPY 起始页 CREATE AGGREGATE
