# 35.40. routine_column_usage

35.40. routine_column_usage
版本：
纠错本页面
搜索
目录导航
❮
❯
35.40. routine_column_usage #
视图routine_column_usage标识出函数或过程中使用的所有列，
无论是在SQL主体中还是在参数默认表达式中。（这仅适用于未引用的SQL主体，
而不适用于带引号的主体或其他语言中的函数。）只有当表由当前启用的角色拥有时，
才会包含列。
表 35.38. routine_column_usage Columns
列类型
描述
specific_catalog sql_identifier
包含该函数的数据库名称（总是当前数据库）
specific_schema sql_identifier
包含函数的模式名称
specific_name sql_identifier
函数的“特定名称”。  详请参见 第 35.45 节。
routine_catalog sql_identifier
包含该函数的数据库名称（总是当前数据库）
routine_schema sql_identifier
包含该函数的模式名称
routine_name sql_identifier
函数的名称（在重载的情况下可能会重复）
table_catalog sql_identifier
包含该函数所使用的表的数据库的名称（总是当前数据库）
table_schema sql_identifier
包含该函数所使用的表的模式名称
table_name sql_identifier
该函数所使用的表的名称
column_name sql_identifier
该函数所使用的列的名称
上一页 上一级 下一页35.39. role_usage_grants 起始页 35.41. routine_privileges
