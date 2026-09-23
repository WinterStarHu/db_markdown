# SPI_rollback

SPI_rollback
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_rollbackSPI_rollback, SPI_rollback_and_chain — 中止当前事务大纲
void SPI_rollback(void)
void SPI_rollback_and_chain(void)
描述
SPI_rollback回滚当前事务。它大致相当于运行SQL命令ROLLBACK。
事务回滚后，将自动启动一个新事务，使用默认的事务特性，以便调用者可以继续使用SPI功能。
SPI_rollback_and_chain是相同的，但新事务将使用与刚结束的事务一样的事务特性启动，就像使用SQL命令ROLLBACK AND CHAIN一样。
只有当SPI连接已经在对SPI_connect_ext的调用中被设置为非原子的情况下才能执行这些函数。
上一页 上一级 下一页SPI_commit 起始页 SPI_start_transaction
