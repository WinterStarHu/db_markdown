# SPI_getrelname

SPI_getrelname
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_getrelnameSPI_getrelname — 返回指定关系的名称大纲
char * SPI_getrelname(Relation rel)
描述
SPI_getrelname返回指定关系名称的拷贝（当你不再需要该拷贝后，可以使用pfree
释放它）。
参数Relation rel
输入关系
返回值
指定关系的名称。
上一页 上一级 下一页SPI_gettypeid 起始页 SPI_getnspname
