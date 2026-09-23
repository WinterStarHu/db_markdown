# SPI_saveplan

SPI_saveplan
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_saveplanSPI_saveplan — 保存一个预备语句大纲
SPIPlanPtr SPI_saveplan(SPIPlanPtr plan)
描述
SPI_saveplan把一个被传入的语句（由
SPI_prepare准备好）复制到不会被
SPI_finish或事务管理器释放的内存中。
这让你能够在当前会话的后续C函数调用中重用预备语句。
参数SPIPlanPtr plan
要保存的预备语句
返回值
要被复制的语句的指针；如果没有成功则返回NULL。
错误时，SPI_result会被这样设置：
SPI_ERROR_ARGUMENT
如果plan为NULL或无效
SPI_ERROR_UNCONNECTED
如果从一个未连接的C函数调用
注意事项
原始的被传入的语句不会被释放，因此你可能希望在其上执行
SPI_freeplan以避免在
SPI_finish之前发生内存泄露。
在大部分情况下，SPI_keepplan更适合于
执行这种功能，因为它在很大程度上达到了同样的结果而无需物理地
复制该预备语句的数据结构。
上一页 上一级 下一页SPI_keepplan 起始页 SPI_register_relation
