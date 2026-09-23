# SPI_cursor_open

SPI_cursor_open
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_cursor_openSPI_cursor_open — 使用由SPI_prepare创建的语句建立一个游标大纲
Portal SPI_cursor_open(const char * name, SPIPlanPtr plan,
Datum * values, const char * nulls,
bool read_only)
描述
SPI_cursor_open建立一个游标（在内部是一个
portal），该游标将执行由SPI_prepare准备好的一个语句。参数具有和SPI_execute_plan的相应参数相同的含义。
使用一个游标而不是直接执行该语句有两个好处。首先，可以一次只取出一些结果行，避免为返回很多行的查询过度使用内存。其次，一个 portal 可以比当前的C函数生存更长时间（事实上，它可以生存到当前事务结束）。把 portal 的名称返回给该C函数的调用者提供了一种将一个行集合返回为结果的方法。
被传入的参数数据将被复制到游标的 portal 中，因此在该游标仍然存在时可以释放掉被传入的参数数据。
参数const char * name
portal 的名字，或者设置成NULL
让系统选择一个名称
SPIPlanPtr plan
预备语句（由SPI_prepare返回）
Datum * values
一个实际参数值的数组。必须和语句的参数数量相同。
const char * nulls
一个描述哪些参数为空值的数组。必须和语句的参数数量相同。
如果nulls为NULL，
那么SPI_cursor_open会假设没有参数
为空值。否则，如果对应的参数值为非空，
nulls
数组的每一个项都应该是' '；如果对应参数值为空，
nulls数组的项应为'n'（在后
面的情况中，对应的values项中的值没有
关系）。注意nulls不是一个文本字符串，
它只是一个数组：它不需要一个'\0'终止符。
bool read_onlytrue表示只读执行返回值
指向包含该游标的 portal 的指针。注意这里没有错误返回约定，
任何错误都将通过elog报告。
上一页 上一级 下一页SPI_execp 起始页 SPI_cursor_open_with_args
