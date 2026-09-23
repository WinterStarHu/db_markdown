# SPI_cursor_parse_open

SPI_cursor_parse_open
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_cursor_parse_openSPI_cursor_parse_open — 使用查询字符串和参数设置游标大纲
Portal SPI_cursor_parse_open(const char *name,
const char *command,
const SPIParseOpenOptions * options)
描述
SPI_cursor_parse_open 建立一个游标（内部的，一个门户），将执行指定的查询字符串。
这可以与由SPI_prepare_cursor跟随的SPI_cursor_open_with_paramlist相比较，
除了查询字符串内参数引用，是通过提供ParamListInfo对象完全处理的。
对一次性查询执行，这个函数将优先于被SPI_cursor_open_with_paramlist跟随的SPI_prepare_cursor。
如果同样的命令带着很多不同的参数被执行，二者中的某一个方法也许会更快，取决于重新计划的开销与定制计划的收益的对比。
options->params 对象通常应以PARAM_FLAG_CONST标志标记每个参数，因为一个一次性计划总是用于查询。
被传入的参数数据将被复制到游标的 portal 中，因此在该游标仍然存在时
可以释放掉被传入的参数数据。
参数const char * name
portal 的名字，或者设置成NULL
让系统选择一个名称
const char * command
命令字符串
const SPIParseOpenOptions * options
包含可选参数的结构体
调用者应始终将整个options结构体归零，然后填充他们想设置的任何字段。
这确保代码的向前兼容性，因为在未来添加到结构体中的任何字段将被定义为行为向后兼容，如果它们为零。
当前有效的options字段为：
ParamListInfo params
包含查询参数类型和值的数据结构；如果没有则为NULL
int cursorOptions
整数形式的游标选项位掩码；零会导致默认行为
bool read_only对只读执行返回true返回值
指向包含该游标的 portal 的指针。注意这里没有错误返回约定，
任何错误都将通过elog报告。
上一页 上一级 下一页SPI_cursor_open_with_paramlist 起始页 SPI_cursor_find
