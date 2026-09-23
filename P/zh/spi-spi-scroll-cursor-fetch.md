# SPI_scroll_cursor_fetch

SPI_scroll_cursor_fetch
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_scroll_cursor_fetchSPI_scroll_cursor_fetch — 从游标中获取一些行大纲
void SPI_scroll_cursor_fetch(Portal portal, FetchDirection direction,
long count)
描述
SPI_scroll_cursor_fetch从一个游标中取出一些行。这等效于 SQL 命令FETCH。
参数Portal portal
包含该游标的 portal
FetchDirection direction
FETCH_FORWARD、FETCH_BACKWARD、FETCH_ABSOLUTE或FETCH_RELATIVE之一
long count
FETCH_FORWARD或FETCH_BACKWARD方式中要取出的行数；FETCH_ABSOLUTE方式中要取出的绝对行号；或FETCH_RELATIVE方式中要取出的相对行号
返回值
如果成功，SPI_execute会设置
SPI_processed和
SPI_tuptable。
注释
参数direction和
count的详细解释请见
SQL FETCH命令。
如果该游标的计划不是用CURSOR_OPT_SCROLL
选项创建的，除FETCH_FORWARD之外的方向值会
失败。
上一页 上一级 下一页SPI_cursor_move 起始页 SPI_scroll_cursor_move
