# SPI_register_trigger_data

SPI_register_trigger_data
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_register_trigger_dataSPI_register_trigger_data — 使短暂触发器数据在 SPI 查询中可用大纲
int SPI_register_trigger_data(TriggerData *tdata)
描述
SPI_register_trigger_data会使被触发器捕获的任何短暂
关系对通过当前 SPI 连接规划和执行的查询可用。当前，这表示用
REFERENCING OLD/NEW TABLE AS ... 子句定义的被
AFTER 触发器捕获的过渡表。这个函数应该在连接后由
PL 触发器处理函数调用。
参数TriggerData *tdata
以fcinfo->context传递给触发器处理函数的TriggerData对象
返回值
如果命令的执行成功，则会返回下列（非负）值：
SPI_OK_TD_REGISTER
如果被捕获的触发器数据（如果有）已经成功注册
出现错误时，会返回下列负值之一：
SPI_ERROR_ARGUMENT
如果tdata为NULL
SPI_ERROR_UNCONNECTED
如果从未连接的C函数中调用
SPI_ERROR_REL_DUPLICATE
如果任何触发器数据瞬时关系的名称已经为该连接注册过
上一页 上一级 下一页SPI_unregister_relation 起始页 45.2. 接口支持函数
