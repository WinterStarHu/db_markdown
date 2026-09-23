# 35.36. role_routine_grants

35.36. role_routine_grants
版本：
纠错本页面
搜索
目录导航
❮
❯
35.36. role_routine_grants #
视图role_routine_grants标识所有在函数上授予的特权，这些特权的授予者或者被授予者是一个当前已被启用的角色。更多信息可以在routine_privileges中找到。这个视图和routine_privileges之间的唯一实质性区别是：这个视图忽略那些以授予给PUBLIC的方式使当前用户获得其访问权限的函数。
表 35.34. role_routine_grants 列
列类型
描述
grantor sql_identifier
授予该特权的角色名称
grantee sql_identifier
被授予该特权的角色名称
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
privilege_type character_data
总是为EXECUTE（函数唯一的特权类型）
is_grantable yes_or_no
如果该特权是可授予的，则为YES，否则为NO
上一页 上一级 下一页35.35. role_column_grants 起始页 35.37. role_table_grants
