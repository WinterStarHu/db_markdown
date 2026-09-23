# SPI_copytuple

SPI_copytuple
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_copytupleSPI_copytuple — 在上层执行器上下文中复制一行大纲
HeapTuple SPI_copytuple(HeapTuple row)
描述
SPI_copytuple在上层执行器上下文中为一行创建
一份拷贝。这通常用于从一个触发器中返回一个被修改的行。在一个被声
明为返回组合类型的函数中，应使用
SPI_returntuple。
这个函数只能在连接到SPI时使用。否则，它会返回NULL并将SPI_result设置为SPI_ERROR_UNCONNECTED。
参数HeapTuple row
要拷贝的行
返回值
被拷贝的行，或者在出错时返回NULL（请参见SPI_result以获取错误指示）
上一页 上一级 下一页SPI_pfree 起始页 SPI_returntuple
