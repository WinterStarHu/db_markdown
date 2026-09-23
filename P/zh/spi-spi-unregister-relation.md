# SPI_unregister_relation

SPI_unregister_relation
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_unregister_relationSPI_unregister_relation — 从注册表中移除短暂命名关系大纲
int SPI_unregister_relation(const char * name)
描述
SPI_unregister_relation从当前连接的注册项中移除一个短暂存在的关系。
参数const char * name
注册项名称
返回值
如果该命令的执行成功，则会返回下列（非负）值：
SPI_OK_REL_UNREGISTER
如果tuplestore已经成功地从注册项中移除
出现错误时，会返回下列负值之一：
SPI_ERROR_ARGUMENT
如果name为NULL
SPI_ERROR_UNCONNECTED
如果从一个未连接的C函数中调用
SPI_ERROR_REL_NOT_FOUND
如果没有在当前连接的注册项中找到name
上一页 上一级 下一页SPI_register_relation 起始页 SPI_register_trigger_data
