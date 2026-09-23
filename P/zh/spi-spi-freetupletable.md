# SPI_freetuptable

SPI_freetuptable
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_freetuptableSPI_freetuptable — 释放一个由SPI_execute
或类似函数创建的行集合大纲
void SPI_freetuptable(SPITupleTable * tuptable)
描述
SPI_freetuptable释放一个由之前的 SPI 命令
执行函数（例如SPI_execute）创建的行集合。因此，
调用这个函数时，常常使用SPI_tuptable作为
参数。
如果一个使用SPI的C函数需要执行多个命令并且不想保留早期命令的结果，这个
函数就有用了。注意，SPI_finish会释放任何未释放的
行集合。还有，如果在一个使用SPI的C函数的执行中开始了一个子事务并且后来
被中止，SPI 会自动释放该子事务运行期间创建的任何行集合。
从PostgreSQL 9.3 开始，
SPI_freetuptable包含了保护逻辑以避免对于同
一行集的重复删除请求。在以前的发布中，重复的删除将会导致崩溃。
参数SPITupleTable * tuptable
要释放的行集的指针，NULL 表示不执行任何操作
上一页 上一级 下一页SPI_freetuple 起始页 SPI_freeplan
