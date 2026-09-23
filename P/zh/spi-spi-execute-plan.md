# SPI_execute_plan

SPI_execute_plan
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_execute_planSPI_execute_plan — 执行一个由SPI_prepare准备好的语句大纲
int SPI_execute_plan(SPIPlanPtr plan, Datum * values, const char * nulls,
bool read_only, long count)
描述
SPI_execute_plan执行一个由
SPI_prepare或其同类方法准备好的语句。
read_only和
count的解释和
SPI_execute中相同。
参数SPIPlanPtr plan
预备语句（由SPI_prepare返回）
Datum * values
一个实际参数值的数组。必须与语句的参数数量相同。
const char * nulls
一个描述哪些参数为空值的数组。必须和语句的参数数量等长。
如果nulls为NULL，
那么SPI_execute_plan会假设没有参数
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
返回值和SPI_execute相同，
还有下列额外可能的错误（负值）结果：
SPI_ERROR_ARGUMENT
如果plan为NULL
或者非法，或者count小于 0
SPI_ERROR_PARAM
如果values为NULL但是
plan被准备时用了一些参数
如果成功，SPI_execute会设置
SPI_processed和
SPI_tuptable。
上一页 上一级 下一页SPI_is_cursor_plan 起始页 SPI_execute_plan_extended
