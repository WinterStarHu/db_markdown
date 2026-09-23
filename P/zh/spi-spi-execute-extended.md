# SPI_execute_extended

SPI_execute_extended
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_execute_extendedSPI_execute_extended — 执行带线外参数的命令大纲
int SPI_execute_extended(const char *command,
const SPIExecuteOptions * options)
描述
SPI_execute_extended执行一个可能包括关于外部支持参数的命令。
命令文本引用参数为$n，以及options->params对象（如果提供）提供值和类型信息，对于每个符号。
不同的执行选项也可以在options结构中指定。
options->params对象通常应以PARAM_FLAG_CONST标记每个参数，因为查询总是使用一次性计划。
如果options->dest为非NULL，则结果元组在执行器生成时被传递到该对象，而不是积累在SPI_tuptable中。
使用调用者提供的DestReceiver对象对于可能生成多个元组的查询特别有帮助，因为数据可以在生成时处理，而不是积累在内存中。
参数const char * command
命令字符串
const SPIExecuteOptions * options
包含可选参数的结构
调用者应始终将整个options结构体归零，然后填充他们想要设置的字段。
这确保代码的向前兼容性，因为将来添加到结构体中的任何字段如果为零将被定义为向后兼容。
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
DestReceiver对象将接收查询发出的任何元组；如果为NULL，结果元组积累到SPI_tuptable结构之中，就像在SPI_execute中一样。
ResourceOwner owner
这个字段存在是为了与SPI_execute_plan_extended保持一致，但它被忽略，因为被SPI_execute_extended使用的计划从来不保存。
返回值
返回值同SPI_execute一样。
当options->dest为NULL时，SPI_processed 和 SPI_tuptable设置为在SPI_execute中。
当options->dest不为NULL时，SPI_processed被设置为零，并且SPI_tuptable被设置为NULL。 如果需要元组计数，调用者的DestReceiver对象必须计算它。
上一页 上一级 下一页SPI_exec 起始页 SPI_execute_with_args
