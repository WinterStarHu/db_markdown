# 35.65. view_table_usage

35.65. view_table_usage
版本：
纠错本页面
搜索
目录导航
❮
❯
35.65. view_table_usage #
视图view_table_usage标识被使用在一个视图的查询表达式（定义该视图的SELECT语句）中的所有表。只有当前已启用角色拥有的表才会被包括在这个视图中。
注意
系统表没有被包括。这应当会在某个时候被修复。
表 35.63. view_table_usage 列
列类型
描述
view_catalog sql_identifier
包含该视图的数据库名称（始终是当前数据库）
view_schema sql_identifier
包含该视图的模式名称
view_name sql_identifier
视图的名称
table_catalog sql_identifier
包含被该视图所使用的表的数据库名称（总是当前数据库）
table_schema sql_identifier
包含被该视图所使用的表的模式名称
table_name sql_identifier
包含被该视图所使用的表的名称
上一页 上一级 下一页35.64. view_routine_usage 起始页 35.66. views
