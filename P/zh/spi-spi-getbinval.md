# SPI_getbinval

SPI_getbinval
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_getbinvalSPI_getbinval — 返回指定列的二进制值大纲
Datum SPI_getbinval(HeapTuple row, TupleDesc rowdesc, int colnumber,
bool * isnull)
描述
SPI_getbinval以内部形式（作为Datum类型）返回指定列的值。
这个函数不会为该datum分配新空间。在传引用数据类型的情况下，
返回值将是一个指向被传递行的指针。
参数HeapTuple row
要检查的输入行
TupleDesc rowdesc
输入行描述
int colnumber
列号（从 1 开始计）
bool * isnull
列中是否为空值的标志
返回值
该列的二进制值会被返回。如果该列为空，由isnull
指向的变量将被设置为true，否则设置为false。
错误时SPI_result会被设置为
SPI_ERROR_NOATTRIBUTE。
上一页 上一级 下一页SPI_getvalue 起始页 SPI_gettype
