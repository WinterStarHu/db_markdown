# 35.35. role_column_grants

35.35. role_column_grants
版本：
纠错本页面
搜索
目录导航
❮
❯
35.35. role_column_grants #
视图role_column_grants标识所有在列上授予的特权，这些特权的授予者或者被授予者是一个当前已被启用的角色。更多信息可以在column_privileges中找到。这个视图和column_privileges之间的唯一实质性区别是：这个视图忽略那些以授予给PUBLIC的方式使当前用户获得其访问权限的列。
表 35.33. role_column_grants 列
列类型
描述
grantor sql_identifier
授予特权的角色名称
grantee sql_identifier
被授予特权的角色名称
table_catalog sql_identifier
包含该列的表所在的数据库名称（总是当前数据库）
table_schema sql_identifier
包含该列的表所在的模式名称
table_name sql_identifier
包含该列的表名称
column_name sql_identifier
列名
privilege_type character_data
特权类型：SELECT、INSERT、UPDATE或
REFERENCES
is_grantable yes_or_no
如果该特权是可授予的，则为YES，否则为NO
上一页 上一级 下一页35.34. referential_constraints 起始页 35.36. role_routine_grants
