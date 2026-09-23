# SPI_gettype

SPI_gettype
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_gettypeSPI_gettype — 返回指定列的数据类型名称大纲
char * SPI_gettype(TupleDesc rowdesc, int colnumber)
描述
SPI_gettype 返回该指定列的数据类型名称
的拷贝（当你不再需要该拷贝后，可以使用 pfree
释放它）。
参数TupleDesc rowdesc
输入行描述
int colnumber
列号（从 1 开始）
返回值
指定列的数据类型名称，或者在错误时返回 NULL。
错误时 SPI_result 会被设置成
SPI_ERROR_NOATTRIBUTE。
上一页 上一级 下一页SPI_getbinval 起始页 SPI_gettypeid
