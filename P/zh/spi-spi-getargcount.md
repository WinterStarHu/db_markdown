# SPI_getargcount

SPI_getargcount
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_getargcountSPI_getargcount — 返回由 SPI_prepare 准备的语句所需的参数数量大纲
int SPI_getargcount(SPIPlanPtr plan)
描述
SPI_getargcount 返回执行一个由
SPI_prepare 准备好的语句所需的参数数量。
参数SPIPlanPtr plan
预备语句（由 SPI_prepare 返回）
返回值
plan 所期望的参数计数。如果该
plan 为 NULL 或者无效，
SPI_result 会被设置为 SPI_ERROR_ARGUMENT
并且返回 -1。
上一页 上一级 下一页SPI_prepare_params 起始页 SPI_getargtypeid
