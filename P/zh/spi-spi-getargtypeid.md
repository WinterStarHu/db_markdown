# SPI_getargtypeid

SPI_getargtypeid
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_getargtypeidSPI_getargtypeid — 为由 SPI_prepare
准备好的一个语句的一个参数返回其数据类型 OID大纲
Oid SPI_getargtypeid(SPIPlanPtr plan, int argIndex)
描述
SPI_getargtypeid 返回由
SPI_prepare 准备好的一个语句的
第argIndex个参数的类型的 OID。
第一个参数的索引为零。
参数SPIPlanPtr plan
预备语句（由 SPI_prepare 返回）
int argIndex
参数的索引，从零开始
返回值
给定索引处的参数的类型 OID。如果该
plan 为 NULL 或者无效，
或者 argIndex 小于零或者不小于
plan 声明的参数数量，
SPI_result 会被设置为
SPI_ERROR_ARGUMENT 并且将会返回
InvalidOid。
上一页 上一级 下一页SPI_getargcount 起始页 SPI_is_cursor_plan
