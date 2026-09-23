# SPI_cursor_fetch

SPI_cursor_fetch
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_cursor_fetchSPI_cursor_fetch — 从游标中获取一些行大纲
void SPI_cursor_fetch(Portal portal, bool forward, long count)
描述
SPI_cursor_fetch从一个游标获取一些行。
这等效于 SQL 命令FETCH的一个子集（更多功能
见SPI_scroll_cursor_fetch）。
参数Portal portal
包含该游标的 portal
bool forward
为真表示向前获取，为假表示向后获取
long count
要获取的最大行数
返回值
如果成功，SPI_execute会设置
SPI_processed和
SPI_tuptable。
注释
如果该游标的计划不是用CURSOR_OPT_SCROLL
选项创建的，向后获取会失败。
上一页 上一级 下一页SPI_cursor_find 起始页 SPI_cursor_move
