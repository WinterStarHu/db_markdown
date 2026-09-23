# SPI_keepplan

SPI_keepplan
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_keepplanSPI_keepplan — 保存一个预备语句大纲
int SPI_keepplan(SPIPlanPtr plan)
描述
SPI_keepplan 保存一个被传入的语句（由
SPI_prepare 准备好），这样它将不会被
SPI_finish 或者事务管理器释放。这让你能够
在当前会话的后续 C 函数调用中重用预备语句。
参数SPIPlanPtr plan
要保存的预备语句
返回值
成功返回 0；如果plan为NULL
或无效则返回SPI_ERROR_ARGUMENT
注意事项
这个函数通过指针调整的方法（不需要数据复制）将被传入的语句重定位
到永久存储中。如果你后来需要删除它，可以对它使用
SPI_freeplan。
上一页 上一级 下一页SPI_cursor_close 起始页 SPI_saveplan
