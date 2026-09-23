# 35.38. role_udt_grants

35.38. role_udt_grants
版本：
纠错本页面
搜索
目录导航
❮
❯
35.38. role_udt_grants #
视图role_udt_grants旨在识别授予用户定义类型的USAGE特权，
其中授予者或被授予者是当前启用的角色。更多信息可以在udt_privileges中找到。
这个视图和udt_privileges之间的唯一实质性区别是，
这个视图省略了通过授予PUBLIC使当前用户获得访问权限的对象。
由于数据类型在 PostgreSQL 中并没有真正的特权，而只有一个隐式授予给PUBLIC，
这个视图是空的。
表 35.36. role_udt_grants 列
列类型
描述
grantor sql_identifier
授予特权的角色名称
grantee sql_identifier
被授予特权的角色名称
udt_catalog sql_identifier
包含该类型的数据库名称（始终是当前数据库）
udt_schema sql_identifier
包含该类型的模式名称
udt_name sql_identifier
类型的名称
privilege_type character_data
总是 TYPE USAGE
is_grantable yes_or_no
如果该特权是可授予的，则为 YES，否则为 NO
上一页 上一级 下一页35.37. role_table_grants 起始页 35.39. role_usage_grants
