# 35.41. routine_privileges

35.41. routine_privileges
版本：
纠错本页面
搜索
目录导航
❮
❯
35.41. routine_privileges #
视图routine_privileges标识所有授予给当前启用角色或由当前启用角色授予的函数特权。对于每一种函数、授予者和被授予者的组合，这里都有一行。
表 35.39. routine_privileges 列
列类型
描述
grantor sql_identifier
授予特权的角色名称
grantee sql_identifier
被授予特权的角色名称
specific_catalog sql_identifier
包含该函数的数据库名称（总是当前数据库）
specific_schema sql_identifier
包含该函数的模式名称
specific_name sql_identifier
函数的“特定名称”。  详请参见 第 35.45 节。
routine_catalog sql_identifier
包含该函数的数据库名称（总是当前数据库）
routine_schema sql_identifier
包含该函数的模式名称
routine_name sql_identifier
函数的名称（在重载的情况下可能会重复）
privilege_type character_data
总是EXECUTE（函数唯一的特权类型）
is_grantable yes_or_no
如果该特权是可授予的，则为YES，否则为NO
上一页 上一级 下一页35.40. routine_column_usage 起始页 35.42. routine_routine_usage
