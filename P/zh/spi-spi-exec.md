# SPI_exec

SPI_exec
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_execSPI_exec — 执行一个读/写命令大纲
int SPI_exec(const char * command, long count)
描述
SPI_exec和
SPI_execute相同，但后者的
read_only参数的值总是取
false。
参数const char * command
包含要执行的命令的字符串
long count
要返回的最大行数，或者用0表示没有限制
返回值
见SPI_execute。
上一页 上一级 下一页SPI_execute 起始页 SPI_execute_extended
