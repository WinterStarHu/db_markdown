# SPI_modifytuple

SPI_modifytuple
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_modifytupleSPI_modifytuple — 通过替换给定行的选定字段来创建一行大纲
HeapTuple SPI_modifytuple(Relation rel, HeapTuple row, int ncols,
int * colnum, Datum * values, const char * nulls)
描述
SPI_modifytuple创建一个新行，其中选定的列
用新值替代，其他列则从输入行中拷贝。输入行本身不被修改。新行被返回在上层的执行器上下文中。
这个函数只能在连接到SPI时使用。否则，它会返回NULL并且把SPI_result设置为SPI_ERROR_UNCONNECTED。
参数Relation rel
只被用作该行的行描述符的来源（传递一个关系而不是
一个行描述符是一种设计缺陷）。
HeapTuple row
要修改的行
int ncols
要修改的列数
int * colnum
一个长度为ncols的数组，包含了要修改的列号
（列号从 1 开始）
Datum * values
一个长度为ncols的数组，包含了指定列的新值
const char * nulls
一个长度为ncols的数组，描述哪些新值为null
如果nulls为NULL，那么
SPI_modifytuple假定没有新值为null。否则，
如果对应的新值为非null，nulls数组的每一项都应
为' '，而如果对应的新值为null则为'n'（在
后一种情况中，对应的values项中的新值无关紧
要）。注意nulls不是一个文本字符串，只是一个
数组：它不需要一个'\0'终止符。
返回值
修改过的新行，它被分配在上层的执行器上下文中，或者在出错时返回NULL（错误的内容请参考SPI_result）
出错时，SPI_result被设置如下：
SPI_ERROR_ARGUMENT
如果rel为NULL，或者
row为NULL，或者ncols
小于等于0，或者colnum为NULL，
或者values为NULL。
SPI_ERROR_NOATTRIBUTE
如果colnum包含一个无效的列号（小于等于0或者大于
row中的列数）。
SPI_ERROR_UNCONNECTED
如果SPI不是活跃状态
上一页 上一级 下一页SPI_returntuple 起始页 SPI_freetuple
