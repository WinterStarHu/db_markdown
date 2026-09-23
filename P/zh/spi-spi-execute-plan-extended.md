# SPI_execute_plan_extended

SPI_execute_plan_extended
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_execute_plan_extendedSPI_execute_plan_extended — 执行一个由SPI_prepare准备的语句大纲
int SPI_execute_plan_extended(SPIPlanPtr plan,
const SPIExecuteOptions * options)
描述
SPI_execute_plan_extended 执行一个由SPI_prepare或它的一个同类所准备的语句。
这个函数等同于SPI_execute_plan，除了传递到查询的参数值的信息表现不同，并且可以传递附加的执行控制选项。
查询参数值由ParamListInfo结构体表示，便于传递已经以该格式可用的值。
动态参数设置也可以使用，通过在ParamListInfo中指定的钩子函数。
而且，与总是累积结果元组到SPI_tuptable结构不同，元组可以传递到调用者提供的DestReceiver对象，就像它们被执行器生成的那样。
这对可能产生多个元组的查询特别有帮助，因为数据可以在运行时处理，而不是积累在内存中。
参数SPIPlanPtr plan
预备语句（由SPI_prepare返回）
const SPIExecuteOptions * options
包含可选参数的结构体
调用者应始终将整个options结构体归零，然后填充他们想设置的任何字段。
这确保代码的向前兼容性，因为在未来添加到结构体中的任何字段将被定义为向后兼容，如果它们为零。
当前有效的options字段为：
ParamListInfo params
包含查询参数类型和值的数据结构；如果没有则为NULL
bool read_onlytrue表示只读执行bool allow_nonatomic
true允许非原子执行CALL和DO语句（但此字段会被忽略，
除非将SPI_OPT_NONATOMIC标志传递给
SPI_connect_ext）
bool must_return_tuples
如果为true，如果查询不是一种返回元组的类型则抛出错误（这不禁止返回零元组的情况）
uint64 tcount
要返回的最大行数，或者用0表示没有限制
DestReceiver * dest
DestReceiver对象将接收查询发出的任何元组；如果为NULL，结果元组将积累到SPI_tuptable结构中，就像在SPI_execute_plan中一样。
ResourceOwner owner
资源所有者将在执行时持有计划的引用计数。
如果为NULL，则使用CurrentResourceOwner。对于不保存的计划，
忽略此项，因为SPI不会获取它们的引用计数。
返回值
返回值与SPI_execute_plan相同。
当 options->dest 为 NULL时，
SPI_processed 和 SPI_tuptable
在SPI_execute_plan中设定。
当 options->dest 不为 NULL时，
SPI_processed 被设定为零，SPI_tuptable
被设定为 NULL。如果需要元组计数，调用者的DestReceiver
对象必须计算它。
上一页 上一级 下一页SPI_execute_plan 起始页 SPI_execute_plan_with_paramlist
