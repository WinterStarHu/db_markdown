# 第 45 章 服务器编程接口

第 45 章 服务器编程接口
版本：
纠错本页面
搜索
目录导航
❮
❯
第 45 章 服务器编程接口目录45.1. 接口函数SPI_connect — 将一个C函数连接到SPI管理器SPI_finish — 将一个 C 函数从 SPI 管理器断开SPI_execute — 执行一个命令SPI_exec — 执行一个读/写命令SPI_execute_extended — 执行带线外参数的命令SPI_execute_with_args — 用线外参数执行命令SPI_prepare — 准备一个语句，但尚未执行它SPI_prepare_cursor — 预备一个语句，但不执行它SPI_prepare_extended — 准备语句，但尚未执行它SPI_prepare_params — 预备一个语句，但不执行它SPI_getargcount — 返回由 SPI_prepare 准备的语句所需的参数数量SPI_getargtypeid — 为由 SPI_prepare
准备好的一个语句的一个参数返回其数据类型 OIDSPI_is_cursor_plan — 如果一个由SPI_prepare预备好的语句
可以用于SPI_cursor_open则返回trueSPI_execute_plan — 执行一个由SPI_prepare准备好的语句SPI_execute_plan_extended — 执行一个由SPI_prepare准备的语句SPI_execute_plan_with_paramlist — 执行由SPI_prepare预备的语句SPI_execp — 以读写模式执行一个语句SPI_cursor_open — 使用由SPI_prepare创建的语句建立一个游标SPI_cursor_open_with_args — 使用查询和参数设置游标SPI_cursor_open_with_paramlist — 使用参数设置游标SPI_cursor_parse_open — 使用查询字符串和参数设置游标SPI_cursor_find — 通过名称查找一个现有的游标SPI_cursor_fetch — 从游标中获取一些行SPI_cursor_move — 移动游标SPI_scroll_cursor_fetch — 从游标中获取一些行SPI_scroll_cursor_move — 移动游标SPI_cursor_close — 关闭游标SPI_keepplan — 保存一个预备语句SPI_saveplan — 保存一个预备语句SPI_register_relation — 通过名称使临时命名关系在 SPI 查询中可用SPI_unregister_relation — 从注册表中移除短暂命名关系SPI_register_trigger_data — 使短暂触发器数据在 SPI 查询中可用45.2. 接口支持函数SPI_fname — 为指定的列号确定列名SPI_fnumber — 为指定的列名确定列号SPI_getvalue — 返回指定列的字符串值SPI_getbinval — 返回指定列的二进制值SPI_gettype — 返回指定列的数据类型名称SPI_gettypeid — 返回指定列的数据类型的OIDSPI_getrelname — 返回指定关系的名称SPI_getnspname — 返回指定关系的模式的名字空间SPI_result_code_string — 将错误代码作为字符串返回45.3. 内存管理SPI_palloc — 在上层执行器上下文中分配内存SPI_repalloc — 在上层执行器上下文中重新分配内存SPI_pfree — 在上层执行器上下文中释放内存SPI_copytuple — 在上层执行器上下文中复制一行SPI_returntuple — 准备返回一个元组作为 DatumSPI_modifytuple — 通过替换给定行的选定字段来创建一行SPI_freetuple — 释放一个在上层执行器上下文中分配的行SPI_freetuptable — 释放一个由SPI_execute
或类似函数创建的行集合SPI_freeplan — 释放一个之前保存的预备语句45.4. 事务管理SPI_commit — 提交当前事务SPI_rollback — 中止当前事务SPI_start_transaction — 废弃函数45.5. 数据变更的可见性45.6. 示例
服务器编程接口（SPI）给予用户定义C函数编写者在其函数或程序内运行SQL命令的能力。
SPI是一组接口函数，它们可以简化对解析器、规划器和执行器的访问。
SPI也做一些内存管理。
注意
可用的过程语言提供了多种方法从函数中执行 SQL 命令。大部分这些设施都是基于 SPI 的，因此这个文档也对那些语言的用户有用。
注意如果一个通过 SPI 调用的命令失败，那么控制将不会返回到你的 C 函数中。相反，你的 C 函数所在的事务或者子事务将被回滚。（这可能看起来令人惊讶，因为据文档所说 SPI 函数大多数都有错误返回约定。但是那些约定只适用于在 SPI 函数本身内部检测到的错误。）通过在可能失败的 SPI 调用周围建立自己的子事务可以在错误之后恢复控制。
SPI成功时返回一个非负结果（要么通过一个返回的整数值，要么如下所述放在全局变量SPI_result中）。错误时，将会返回一个负结果或者NULL。
使用 SPI 的源代码文件必须包括头文件executor/spi.h。
上一页 上一级 下一页44.11. 环境变量 起始页 45.1. 接口函数
