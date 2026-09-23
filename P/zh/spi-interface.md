# 45.1. 接口函数

45.1. 接口函数
版本：
纠错本页面
搜索
目录导航
❮
❯
45.1. 接口函数 #SPI_connect — 将一个C函数连接到SPI管理器SPI_finish — 将一个 C 函数从 SPI 管理器断开SPI_execute — 执行一个命令SPI_exec — 执行一个读/写命令SPI_execute_extended — 执行带线外参数的命令SPI_execute_with_args — 用线外参数执行命令SPI_prepare — 准备一个语句，但尚未执行它SPI_prepare_cursor — 预备一个语句，但不执行它SPI_prepare_extended — 准备语句，但尚未执行它SPI_prepare_params — 预备一个语句，但不执行它SPI_getargcount — 返回由 SPI_prepare 准备的语句所需的参数数量SPI_getargtypeid — 为由 SPI_prepare
准备好的一个语句的一个参数返回其数据类型 OIDSPI_is_cursor_plan — 如果一个由SPI_prepare预备好的语句
可以用于SPI_cursor_open则返回trueSPI_execute_plan — 执行一个由SPI_prepare准备好的语句SPI_execute_plan_extended — 执行一个由SPI_prepare准备的语句SPI_execute_plan_with_paramlist — 执行由SPI_prepare预备的语句SPI_execp — 以读写模式执行一个语句SPI_cursor_open — 使用由SPI_prepare创建的语句建立一个游标SPI_cursor_open_with_args — 使用查询和参数设置游标SPI_cursor_open_with_paramlist — 使用参数设置游标SPI_cursor_parse_open — 使用查询字符串和参数设置游标SPI_cursor_find — 通过名称查找一个现有的游标SPI_cursor_fetch — 从游标中获取一些行SPI_cursor_move — 移动游标SPI_scroll_cursor_fetch — 从游标中获取一些行SPI_scroll_cursor_move — 移动游标SPI_cursor_close — 关闭游标SPI_keepplan — 保存一个预备语句SPI_saveplan — 保存一个预备语句SPI_register_relation — 通过名称使临时命名关系在 SPI 查询中可用SPI_unregister_relation — 从注册表中移除短暂命名关系SPI_register_trigger_data — 使短暂触发器数据在 SPI 查询中可用上一页 上一级 下一页第 45 章 服务器编程接口 起始页 SPI_connect
