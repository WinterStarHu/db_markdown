# SPI_fnumber

SPI_fnumber
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_fnumberSPI_fnumber — 为指定的列名确定列号大纲
int SPI_fnumber(TupleDesc rowdesc, const char * colname)
描述
SPI_fnumber 返回指定列名的列号。
如果 colname 引用的是一个系统列（例如，
ctid），那么将返回对应的负值列号。调用者应该小心地测试
返回值是否正好为 SPI_ERROR_NOATTRIBUTE
来检测错误；除非系统列应该被拒绝，测试结果是否小于或等于零这种
方式是不正确的。
参数TupleDesc rowdesc
输入行描述
const char * colname
列名
返回值
列号（用户定义的列从1开始计），如果没有找到所提到的列名则返回
SPI_ERROR_NOATTRIBUTE。
上一页 上一级 下一页SPI_fname 起始页 SPI_getvalue
