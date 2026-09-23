# SPI_getvalue

SPI_getvalue
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_getvalueSPI_getvalue — 返回指定列的字符串值大纲
char * SPI_getvalue(HeapTuple row, TupleDesc rowdesc, int colnumber)
描述
SPI_getvalue 返回指定列的值的字符串表示。
结果在使用palloc分配的内存中返回（当你不再
需要该结果时，你可以使用pfree释放该内存）。
参数HeapTuple row
要检查的输入行
TupleDesc rowdesc
输入行描述
int colnumber
列号（从1开始计）
返回值
列值，如果列为空值、colnumber超出范围
（SPI_result被设置为
SPI_ERROR_NOATTRIBUTE）或者没有输出函数
可用（SPI_result被设置为
SPI_ERROR_NOOUTFUNC）则返回
NULL。
上一页 上一级 下一页SPI_fnumber 起始页 SPI_getbinval
