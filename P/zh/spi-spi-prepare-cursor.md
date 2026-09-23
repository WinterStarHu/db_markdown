# SPI_prepare_cursor

SPI_prepare_cursor
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_prepare_cursorSPI_prepare_cursor — 预备一个语句，但不执行它大纲
SPIPlanPtr SPI_prepare_cursor(const char * command, int nargs,
Oid * argtypes, int cursorOptions)
描述
SPI_prepare_cursor和
SPI_prepare一样，不过它也允许说明规划器的
“游标选项”参数。这是一个位掩码，它的值如
nodes/parsenodes.h中
DeclareCursorStmt的options域所示。
SPI_prepare总是把该游标选项视为零。
这个函数现在被弃用，用SPI_prepare_extended代替。
参数const char * command
命令字符串
int nargs
输入参数的数量（$1、$2等）
Oid * argtypes
一个指向数组的指针，该数组包含参数的数据类型的
OID
int cursorOptions
整数形式的游标选项位掩码，零会产生默认行为
返回值
SPI_prepare_cursor具有和
SPI_prepare一样的返回约定。
注意事项
在cursorOptions中设置的有用位包括
CURSOR_OPT_SCROLL、
CURSOR_OPT_NO_SCROLL、
CURSOR_OPT_FAST_PLAN、
CURSOR_OPT_GENERIC_PLAN以及
CURSOR_OPT_CUSTOM_PLAN。特别注意
CURSOR_OPT_HOLD会被忽略。
上一页 上一级 下一页SPI_prepare 起始页 SPI_prepare_extended
