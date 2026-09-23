# SPI_scroll_cursor_move

SPI_scroll_cursor_move
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_scroll_cursor_moveSPI_scroll_cursor_move — 移动游标大纲
void SPI_scroll_cursor_move(Portal portal, FetchDirection direction,
long count)
描述
SPI_scroll_cursor_move在一个游标中跳过
一定数量的行。这等效于 SQL 命令MOVE。
参数Portal portal
包含该游标的门户
FetchDirection direction
FETCH_FORWARD、
FETCH_BACKWARD、
FETCH_ABSOLUTE或
FETCH_RELATIVE之一
long count
FETCH_FORWARD或者
FETCH_BACKWARD方式中要移动的行数；
FETCH_ABSOLUTE方式中要移动到的绝对行号；
FETCH_RELATIVE方式中要移动到的相对行号
返回值
成功时，就像在SPI_execute中会设置
SPI_processed。
SPI_tuptable被设置为NULL，
因为这个函数不返回行。
备注
参数direction和
count的详细解释请见
SQL FETCH命令。
如果该游标的计划不是用CURSOR_OPT_SCROLL
选项创建的，除FETCH_FORWARD之外的方向值会
失败。
上一页 上一级 下一页SPI_scroll_cursor_fetch 起始页 SPI_cursor_close
