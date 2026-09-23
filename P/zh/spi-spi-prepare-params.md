# SPI_prepare_params

SPI_prepare_params
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_prepare_paramsSPI_prepare_params — 预备一个语句，但不执行它大纲
SPIPlanPtr SPI_prepare_params(const char * command,
ParserSetupHook parserSetup,
void * parserSetupArg,
int cursorOptions)
描述
SPI_prepare_params为指定的命令创建并
返回一个预备语句，但不执行该命令。这个函数等效于
SPI_prepare_cursor，此外调用者可以指定
解析器钩子函数来控制外部参数引用的解析。
这个函数现在被弃用，建议使用SPI_prepare_extended。
参数const char * command
命令字符串
ParserSetupHook parserSetup
解析器钩子设置函数
void * parserSetupArg
对于 parserSetup 的直通参数
int cursorOptions
整数形式的游标选项位掩码；零会导致默认行为
返回值
SPI_prepare_params 具有和
SPI_prepare 相同的返回习惯。
上一页 上一级 下一页SPI_prepare_extended 起始页 SPI_getargcount
