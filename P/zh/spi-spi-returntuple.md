# SPI_returntuple

SPI_returntuple
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_returntupleSPI_returntuple — 准备返回一个元组作为 Datum大纲
HeapTupleHeader SPI_returntuple(HeapTuple row, TupleDesc rowdesc)
描述
SPI_returntuple为一个行在上层执行器上下文中
创建一个拷贝，把它以一种行类型Datum的形式返回。
返回的指针只需要在返回前通过PointerGetDatum
被转换成Datum。
这个函数只能在连接到SPI时使用。否则，它会返回NULL并把SPI_result设置为SPI_ERROR_UNCONNECTED。
注意这应该用于声明为返回组合类型的函数。它不能用于触发器，
在触发器中应使用SPI_copytuple来返回一个被修改的行。
参数HeapTuple row
要复制的行
TupleDesc rowdesc
行的描述符（对大部分有效的缓存，每次都传递相同的描述符）
返回值
指向被复制行的HeapTupleHeader，或者在出错时返回NULL（错误的内容请参考SPI_result）
上一页 上一级 下一页SPI_copytuple 起始页 SPI_modifytuple
