# SPI_execute_with_args

SPI_execute_with_args
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_execute_with_argsSPI_execute_with_args — 用线外参数执行命令大纲
int SPI_execute_with_args(const char *command,
int nargs, Oid *argtypes,
Datum *values, const char *nulls,
bool read_only, long count)
描述
SPI_execute_with_args执行一个可能包括
对外部提供的参数引用的命令。命令文本用
$n引用一个参数，并且调用
会为每一个这种符号指定数据类型和值。
read_only和
count的解释与
SPI_execute中相同。
相对于SPI_execute，这个例程的主要优点是数据值可以被插入到命令中而无需冗长的引用/转义，并且因此减少了 SQL 注入攻击的风险。
可以通过在SPI_prepare后面跟上
SPI_execute_plan达到相似的结果；但是，
使用这个函数时查询计划总是被定制成提供的具体参数值。
对于一次性的查询执行，这个函数应该更优先选择。
如果同样的命令需要用很多不同的参数执行，
两种方法都可能会更快，这取决于重新做规划的代价与
定制计划带来的好处之间的对比。
参数const char * command
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
那么SPI_execute_with_args会假设没有参数
为空值。否则，如果对应的参数值为非空，
nulls
数组的每一个项都应该是' '；如果对应参数值为空，
nulls数组的项应为'n'（在后
面的情况中，对应的values项中的值没有
关系）。注意nulls不是一个文本字符串，
它只是一个数组：它不需要一个'\0'终止符。
bool read_onlytrue表示只读执行long count
要返回的最大行数，或者用0表示没有限制
返回值
返回值同SPI_execute一样。
如果成功，SPI_execute会设置
SPI_processed和
SPI_tuptable。
上一页 上一级 下一页SPI_execute_extended 起始页 SPI_prepare
