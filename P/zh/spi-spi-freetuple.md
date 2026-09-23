# SPI_freetuple

SPI_freetuple
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_freetupleSPI_freetuple — 释放一个在上层执行器上下文中分配的行大纲
void SPI_freetuple(HeapTuple row)
描述
SPI_freetuple释放之前在上层执行器上下文中
分配的一行。
这个函数不再和普通的heap_freetuple有区别。
保留它只是为了对现有代码保持向后兼容。
参数HeapTuple row
要释放的行
上一页 上一级 下一页SPI_modifytuple 起始页 SPI_freetuptable
