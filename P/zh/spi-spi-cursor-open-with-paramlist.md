# SPI_cursor_open_with_paramlist

SPI_cursor_open_with_paramlist
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_cursor_open_with_paramlistSPI_cursor_open_with_paramlist — 使用参数设置游标大纲
Portal SPI_cursor_open_with_paramlist(const char *name,
SPIPlanPtr plan,
ParamListInfo params,
bool read_only)
描述
SPI_cursor_open_with_paramlist建立一个
游标（在内部是一个 portal），它将执行一个由
SPI_prepare准备好的语句。这个函数等效于
SPI_cursor_open，不过被传递给该查询
的参数值的信息以不同的方式呈现。ParamListInfo表现形
式更方便于把这种格式的值向下传递。它也支持通过
ParamListInfo中指定的钩子函数动态设置参数。
被传入的参数数据将被复制到游标的 portal 中，因此在该游标仍然存在时
可以释放掉被传入的参数数据。
参数const char * name
portal 的名字，或者设置成NULL
让系统选择一个名称
SPIPlanPtr plan
预备语句（由SPI_prepare返回）
ParamListInfo params
包含参数类型和值的数据结构；如果没有则为 NULL
bool read_onlytrue表示只读执行返回值
指向包含该游标的 portal 的指针。注意这里没有错误返回约定，
任何错误都将通过elog报告。
上一页 上一级 下一页SPI_cursor_open_with_args 起始页 SPI_cursor_parse_open
