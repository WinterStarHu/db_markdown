# SPI_connect

SPI_connect
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_connectSPI_connect, SPI_connect_ext — 将一个C函数连接到SPI管理器大纲
int SPI_connect(void)
int SPI_connect_ext(int options)
描述
SPI_connect从一个C函数调用中打开一个到SPI管理器的连接。如果你想通过SPI执行命令，你必须调用这个函数。有一些实用的SPI函数可以从未连接的C函数中调用。
SPI_connect_ext执行相同的操作，但有一个参数允许传递选项标志。目前，以下选项值可用：
SPI_OPT_NONATOMIC
将SPI连接设置为nonatomic，这意味着事务控制调用（SPI_commit、
SPI_rollback）是允许的。否则，调用这些函数将立即导致错误。
SPI_connect()是等效于
SPI_connect_ext(0)。
返回值SPI_OK_CONNECT
成功时
这些函数返回 int 而不是 void 是历史原因。所有失败情况通过
ereport 或 elog 报告。
（在 PostgreSQL v10 之前的版本中，
一些但不是所有的失败会以 SPI_ERROR_CONNECT 的结果值报告。）
上一页 上一级 下一页45.1. 接口函数 起始页 SPI_finish
