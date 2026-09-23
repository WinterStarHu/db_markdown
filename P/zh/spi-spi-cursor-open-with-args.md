# SPI_cursor_open_with_args

SPI_cursor_open_with_args
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_cursor_open_with_argsSPI_cursor_open_with_args — 使用查询和参数设置游标大纲
Portal SPI_cursor_open_with_args(const char *name,
const char *command,
int nargs, Oid *argtypes,
Datum *values, const char *nulls,
bool read_only, int cursorOptions)
描述
SPI_cursor_open_with_args建立一个将
执行指定查询的游标（在内部是一个 portal）。大部分参数具有和
SPI_prepare_cursor
和SPI_cursor_open中相应参数相同的含
义。
对于一次性查询执行，这个函数应该比
SPI_prepare_cursor后续的
SPI_cursor_open更优。如果相同的命令
要用很多不同的参数执行，哪种方法更快就要取决于重做计划的
代价与定制计划带来的好处之间的权衡。
被传入的参数数据将被复制到游标的 portal 中，因此在该游标仍然存在时
可以释放被传入的参数数据。
这个函数现在已被废弃，推荐使用SPI_cursor_parse_open，它提供等效的
功能，并使用更现代的API来处理查询参数。
参数const char * name
portal 的名字，或者设置成NULL
让系统选择一个名称
const char * command
命令字符串
int nargs
输入参数的数量（$1、$2等）
Oid * argtypes
一个长度为nargs的数组，
包含参数的数据类型的OID
Datum * values
一个长度为nargs的数组，
包含实际的参数值
const char * nulls
一个长度为nargs的数组，
描述哪些参数为空值
如果nulls为NULL，
那么SPI_cursor_open_with_args会假设没有参数
为空值。否则，如果对应的参数值为非空，
nulls
数组的每一个项都应该是' '；如果对应参数值为空，
nulls数组的项应为'n'（在后
面的情况中，对应的values项中的值没有
关系）。注意nulls不是一个文本字符串，
它只是一个数组：它不需要一个'\0'终止符。
bool read_only对只读执行返回trueint cursorOptions
整数形式的游标选项位掩码；零会导致默认行为
返回值
指向包含该游标的 portal 的指针。注意这里没有错误返回约定，
任何错误都将通过elog报告。
上一页 上一级 下一页SPI_cursor_open 起始页 SPI_cursor_open_with_paramlist
