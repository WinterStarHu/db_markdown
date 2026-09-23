# SPI_cursor_close

SPI_cursor_close
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_cursor_closeSPI_cursor_close — 关闭游标大纲
void SPI_cursor_close(Portal portal)
描述
SPI_cursor_close关闭一个之前创建的游标
并释放它的 portal 存储。
所有打开的游标会在事务结束时自动关闭。
只有在希望尽快释放资源时，才需要调用
SPI_cursor_close。
参数Portal portal
包含该游标的 portal
上一页 上一级 下一页SPI_scroll_cursor_move 起始页 SPI_keepplan
