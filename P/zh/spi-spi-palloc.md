# SPI_palloc

SPI_palloc
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_pallocSPI_palloc — 在上层执行器上下文中分配内存大纲
void * SPI_palloc(Size size)
描述
SPI_palloc在上层执行器上下文中分配内存。
这个函数只能在连接到SPI时使用。否则，它会抛出错误。
参数Size size
要分配的存储空间大小（以字节计）
返回值
指向具有指定大小的新存储空间的指针
上一页 上一级 下一页45.3. 内存管理 起始页 SPI_repalloc
