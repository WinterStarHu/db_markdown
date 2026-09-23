# 35.63. view_column_usage

35.63. view_column_usage
版本：
纠错本页面
搜索
目录导航
❮
❯
35.63. view_column_usage #
视图view_column_usage标识所有在视图的查询表达式中使用的列（定义该视图的SELECT语句）。只有当包含该列的表被当前启用的角色拥有时，该列才会被包括在这个视图中。
注意
系统表的列不被包括。这个问题应该会在某个时候被修复。
表 35.61. view_column_usage 列
列类型
描述
view_catalog sql_identifier
包含该视图的数据库名称（始终是当前数据库）
view_schema sql_identifier
包含该视图的模式名称
view_name sql_identifier
视图的名称
table_catalog sql_identifier
包含该视图所使用的列的表的数据库名称（始终是当前数据库）
table_schema sql_identifier
包含该视图所使用的列的表的模式名称
table_name sql_identifier
包含该视图所使用的列的表的名称
column_name sql_identifier
被该视图所使用的列名称
上一页 上一级 下一页35.62. user_mappings 起始页 35.64. view_routine_usage
