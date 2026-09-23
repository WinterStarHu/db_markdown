# SPI_getnspname

SPI_getnspname
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_getnspnameSPI_getnspname — 返回指定关系的模式的名字空间大纲
char * SPI_getnspname(Relation rel)
描述
SPI_getnspname 返回指定
Relation 所属的名字空间的名称拷贝。这等效
于该关系的模式。当你用完这个函数的返回值后，应该调用
pfree 释放它。
参数Relation rel
输入关系
返回值
指定关系的命名空间的名称。
上一页 上一级 下一页SPI_getrelname 起始页 SPI_result_code_string
