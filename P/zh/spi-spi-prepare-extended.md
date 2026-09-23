# SPI_prepare_extended

SPI_prepare_extended
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_prepare_extendedSPI_prepare_extended — 准备语句，但尚未执行它大纲
SPIPlanPtr SPI_prepare_extended(const char * command,
const SPIPrepareOptions * options)
描述
SPI_prepare_extended 创建并返回一个为指定命令准备的语句，但不执行该命令。
这个函数等同于 SPI_prepare，此外调用者可以指定选项以控制
外部参数引用的解析，以及查询解析和计划的其他方面。
参数const char * command
命令字符串
const SPIPrepareOptions * options
包含可选参数的结构
调用者应始终将整个options结构体归零，然后填充他们想设置的任何字段。
这确保代码的向前兼容性，因为在未来添加到结构体中的任何字段将被定义为行为向后兼容，如果它们为零。
当前有效的options字段为：
ParserSetupHook parserSetup
解析器钩子设置函数
void * parserSetupArg
对于 parserSetup的直通参数
RawParseMode parseMode
原始解析的模式；RAW_PARSE_DEFAULT（零）
产生默认行为
int cursorOptions
整数形式的游标选项位掩码；零会导致默认行为
返回值
SPI_prepare_extended 具有与SPI_prepare相同的返回约定。
上一页 上一级 下一页SPI_prepare_cursor 起始页 SPI_prepare_params
