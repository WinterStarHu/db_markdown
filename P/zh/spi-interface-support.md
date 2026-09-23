# 45.2. 接口支持函数

45.2. 接口支持函数
版本：
纠错本页面
搜索
目录导航
❮
❯
45.2. 接口支持函数 #SPI_fname — 为指定的列号确定列名SPI_fnumber — 为指定的列名确定列号SPI_getvalue — 返回指定列的字符串值SPI_getbinval — 返回指定列的二进制值SPI_gettype — 返回指定列的数据类型名称SPI_gettypeid — 返回指定列的数据类型的OIDSPI_getrelname — 返回指定关系的名称SPI_getnspname — 返回指定关系的模式的名字空间SPI_result_code_string — 将错误代码作为字符串返回
这里描述的函数提供了一个接口，从SPI_execute
及其他SPI函数返回的结果集中提取信息。
本节中描述的所有函数都可以在已连接和未连接的C函数中使用。
上一页 上一级 下一页SPI_register_trigger_data 起始页 SPI_fname
