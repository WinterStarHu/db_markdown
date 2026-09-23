# SPI_commit

SPI_commit
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_commitSPI_commit, SPI_commit_and_chain — 提交当前事务大纲
void SPI_commit(void)
void SPI_commit_and_chain(void)
描述
SPI_commit 提交当前事务。它大致相当于运行SQL命令COMMIT。
在事务提交后，将自动启动一个新事务，使用默认的事务特性，以便调用者可以继续使用SPI工具。
如果在提交过程中出现故障，则当前事务将被回滚，并启动一个新事务，之后错误将以通常的方式抛出。
SPI_commit_and_chain 是相同的，
但新事务将以与刚刚完成的事务相同的事务特性启动，
就像使用SQL命令COMMIT AND CHAIN一样。
只有当SPI连接已经在对SPI_connect_ext的调用中被设置为非原子的情况下才能执行这些函数。
上一页 上一级 下一页45.4. 事务管理 起始页 SPI_rollback
