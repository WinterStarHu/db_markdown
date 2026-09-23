# EXECUTE

EXECUTE
版本：
纠错本页面
搜索
目录导航
❮
❯
EXECUTEEXECUTE — 执行预备语句大纲
EXECUTE name [ ( parameter [, ...] ) ]
描述
EXECUTE被用来执行一个之前准备好的语句。
由于预备语句只在会话期间存在，该预备语句必须在当前会话中由一个更早
执行的PREPARE语句所创建。
如果创建预备语句的PREPARE语句指定了一些参数，
必须向EXECUTE语句传递一组兼容的参数，否则会
发生错误。注意（与函数不同）预备语句无法基于其参数的类型或者数量重载。
在一个数据库会话中，预备语句的名称必须唯一。
更多关于创建和使用预备语句的信息请见PREPARE。
参数name
要执行的预备语句的名称。
parameter
给预备语句的参数的实际值。这必须是一个能得到与该参数数据类型（
在预备语句创建时决定）兼容的值的表达式。
输出
EXECUTE返回的命令标签是预备语句的命令标签而不是
EXECUTE。
示例
示例在Examples
的PREPARE文档中给出。
兼容性
SQL 标准包括了一个EXECUTE语句，
但是只用于嵌入式 SQL。这个版本的
EXECUTE语句也用了一种有点不同的语法。
另请参阅DEALLOCATE, PREPARE上一页 上一级 下一页END 起始页 EXPLAIN
