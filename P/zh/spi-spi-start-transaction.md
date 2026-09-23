# SPI_start_transaction

SPI_start_transaction
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_start_transactionSPI_start_transaction — 废弃函数大纲
void SPI_start_transaction(void)
描述
SPI_start_transaction不执行任何操作，仅用于与早期PostgreSQL版本的代码兼容性而存在。
在过去，调用SPI_commit或SPI_rollback之后需要使用它，但现在这些函数会自动开始一个新事务。
上一页 上一级 下一页SPI_rollback 起始页 45.5. 数据变更的可见性
