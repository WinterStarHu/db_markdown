# SPI_freeplan

SPI_freeplan
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_freeplanSPI_freeplan — 释放一个之前保存的预备语句大纲
int SPI_freeplan(SPIPlanPtr plan)
描述
SPI_freeplan 释放一个之前由
SPI_prepare 返回的或者由
SPI_keepplan、SPI_saveplan
保存的预备语句。
参数SPIPlanPtr plan
要释放的语句的指针
返回值
成功返回 0；如果 plan 为 NULL
或者无效则返回 SPI_ERROR_ARGUMENT
上一页 上一级 下一页SPI_freetuptable 起始页 45.4. 事务管理
