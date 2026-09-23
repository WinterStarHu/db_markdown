# SPI_cursor_find

SPI_cursor_find
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_cursor_findSPI_cursor_find — 通过名称查找一个现有的游标大纲
Portal SPI_cursor_find(const char * name)
描述
SPI_cursor_find通过名称查找一个现有的 portal。
这主要用于解析由其他某个函数返回的游标名称。
参数const char * name
portal 的名称
返回值
带有指定名称的 portal 的指针，如果没有找到就是
NULL
注意事项
注意，此函数可能返回一个Portal对象，该对象没有类似游标的属性；例如，它可能不返回元组。 如果你只是将Portal指针传递给其他SPI函数，它们可以防范这种情况，但在直接检查Portal时需要谨慎。
上一页 上一级 下一页SPI_cursor_parse_open 起始页 SPI_cursor_fetch
