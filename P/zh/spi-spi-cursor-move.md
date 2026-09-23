# SPI_cursor_move

SPI_cursor_move
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_cursor_moveSPI_cursor_move — 移动游标大纲
void SPI_cursor_move(Portal portal, bool forward, long count)
描述
SPI_cursor_move跳过游标中的一些行。
这等效于 SQL 命令MOVE的一个子集（更多功能
请见SPI_scroll_cursor_move）。
参数Portal portal
包含该游标的 portal
bool forward
为真表示前移，为假表示后移
long count
要移动的最大行数
注释
如果该游标的计划不是用CURSOR_OPT_SCROLL
选项创建的，向后移动会失败。
上一页 上一级 下一页SPI_cursor_fetch 起始页 SPI_scroll_cursor_fetch
