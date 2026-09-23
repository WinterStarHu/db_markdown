# SPI_pfree

SPI_pfree
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_pfreeSPI_pfree — 在上层执行器上下文中释放内存大纲
void SPI_pfree(void * pointer)
描述
SPI_pfree释放之前使用
SPI_palloc或
SPI_repalloc分配的内存。
这个函数不再与普通的pfree有区别。
保留它只是为了对现有代码保持向后兼容。
参数void * pointer
指向要释放的现有存储的指针
上一页 上一级 下一页SPI_repalloc 起始页 SPI_copytuple
