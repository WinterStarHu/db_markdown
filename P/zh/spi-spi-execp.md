# SPI_execp

SPI_execp
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_execpSPI_execp — 以读写模式执行一个语句大纲
int SPI_execp(SPIPlanPtr plan, Datum * values, const char * nulls, long count)
描述
SPI_execp与
SPI_execute_plan相同，不过后者的
read_only参数总是取false。
参数SPIPlanPtr plan
预备语句（由SPI_prepare返回）
Datum * values
一个实际参数值的数组。必须与语句的参数数量相同。
const char * nulls
一个描述哪些参数为空值的数组。必须与语句的参数数量相同。
如果nulls为NULL，
那么SPI_execp会假设没有参数
为空值。否则，如果对应的参数值为非空，
nulls
数组的每一个项都应该是' '；如果对应参数值为空，
nulls数组的项应为'n'（在后
面的情况中，对应的values项中的值没有
关系）。注意nulls不是一个文本字符串，
它只是一个数组：它不需要一个'\0'终止符。
long count
要返回的最大行数，或者用0表示没有限制
返回值
见SPI_execute_plan。
如果成功，SPI_execute会设置
SPI_processed和
SPI_tuptable。
上一页 上一级 下一页SPI_execute_plan_with_paramlist 起始页 SPI_cursor_open
