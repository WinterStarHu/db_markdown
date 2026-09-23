# SPI_fname

SPI_fname
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_fnameSPI_fname — 为指定的列号确定列名大纲
char * SPI_fname(TupleDesc rowdesc, int colnumber)
描述
SPI_fname 返回指定列的列名的拷贝。 （当你不再需要该列名拷贝时，可以使用 pfree
释放它。）
参数TupleDesc rowdesc
输入行描述
int colnumber
列号（从 1 开始计数）
返回值
列名；如果 colnumber 超出范围则返回
NULL。出错时 SPI_result 会被设置成
SPI_ERROR_NOATTRIBUTE。
上一页 上一级 下一页45.2. 接口支持函数 起始页 SPI_fnumber
