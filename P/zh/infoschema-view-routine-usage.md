# 35.64. view_routine_usage

35.64. view_routine_usage
版本：
纠错本页面
搜索
目录导航
❮
❯
35.64. view_routine_usage #
视图view_routine_usage标识被使用在一个视图的查询表达式（定义该视图的SELECT语句）中的所有例程（函数和过程）。只有被一个当前已启用的角色拥有的例程才会被包括在这个视图中。
表 35.62. view_routine_usage 列
列类型
描述
table_catalog sql_identifier
包含该视图的数据库名称（总是当前数据库）
table_schema sql_identifier
包含该视图的模式名称
table_name sql_identifier
视图的名称
specific_catalog sql_identifier
包含该函数的数据库名称（总是当前数据库）
specific_schema sql_identifier
包含函数的模式名称
specific_name sql_identifier
函数的“特定名称”。  详见 第 35.45 节。
上一页 上一级 下一页35.63. view_column_usage 起始页 35.65. view_table_usage
