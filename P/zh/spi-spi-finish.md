# SPI_finish

SPI_finish
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_finishSPI_finish — 将一个 C 函数从 SPI 管理器断开大纲
int SPI_finish(void)
描述
SPI_finish关闭一个到 SPI 管理器的现有连接。你必须在完成你的C函数的当前调用中所需的 SPI 操作之后调用这个函数。不过，如果你通过elog(ERROR)中断了事务，你无须担心这个函数的调用。在那种情况下，SPI 将自己自动进行清理。
返回值SPI_OK_FINISH
如果正确断开连接
SPI_ERROR_UNCONNECTED
如果从一个未连接的 C 函数中调用
上一页 上一级 下一页SPI_connect 起始页 SPI_execute
