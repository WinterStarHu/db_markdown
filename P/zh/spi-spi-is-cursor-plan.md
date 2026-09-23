# SPI_is_cursor_plan

SPI_is_cursor_plan
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_is_cursor_planSPI_is_cursor_plan — 如果一个由SPI_prepare预备好的语句
可以用于SPI_cursor_open则返回true大纲
bool SPI_is_cursor_plan(SPIPlanPtr plan)
描述
SPI_is_cursor_plan会返回true
如果一个由SPI_prepare预备好的语句可以被作为
参数传递给SPI_cursor_open，否则返回false。
原则是该plan表示一个单一命令并且这个命令
向其调用者返回元组；例如，只要不含INTO子句，
SELECT就被允许，而只有包含一个RETURNING
子句时才允许UPDATE。
参数SPIPlanPtr plan
预备语句（由SPI_prepare返回）
返回值
true或false用于指示该plan
是否能产生一个游标，并将SPI_result设置为零。
如果无法确定答案（例如，如果plan为NULL
或无效，或者在未连接到SPI时调用），则SPI_result
会被设置为一个合适的错误码，并返回false。
上一页 上一级 下一页SPI_getargtypeid 起始页 SPI_execute_plan
