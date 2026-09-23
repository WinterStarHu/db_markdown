# SPI_repalloc

SPI_repalloc
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_repallocSPI_repalloc — 在上层执行器上下文中重新分配内存大纲
void * SPI_repalloc(void * pointer, Size size)
描述
SPI_repalloc改变之前用SPI_palloc
分配的内存段的大小。
这个函数不再和普通的repalloc相区别。
保留它只是为了对现有代码保持向后兼容。
参数void * pointer
指向要改变的现有存储的指针
Size size
要分配的存储空间大小（以字节计）
返回值
指向具有指定大小的新存储空间的指针，现有区域的内容会被复制到其中
上一页 上一级 下一页SPI_palloc 起始页 SPI_pfree
