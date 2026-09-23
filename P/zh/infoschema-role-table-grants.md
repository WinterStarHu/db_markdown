# 35.37. role_table_grants

35.37. role_table_grants
版本：
纠错本页面
搜索
目录导航
❮
❯
35.37. role_table_grants #
视图role_table_grants标识所有在表或视图上授予的特权，这些特权的授予者或者被授予者是一个当前已被启用的角色。更多信息可以在table_privileges中找到。这个视图和table_privileges之间的唯一实质性区别是，这个视图忽略那些以授予给PUBLIC的方式使当前用户获得其访问权限的表。
表 35.35. role_table_grants 列
列类型
描述
grantor sql_identifier
授予特权的角色名称
grantee sql_identifier
被授予特权的角色名称
table_catalog sql_identifier
包含该表的数据库名称（始终是当前数据库）
table_schema sql_identifier
包含该表的模式名称
table_name sql_identifier
表的名称
privilege_type character_data
特权的类型：SELECT、
INSERT、UPDATE、
DELETE、TRUNCATE、
REFERENCES或TRIGGER
is_grantable yes_or_no
如果特权是可授予的，则为YES，否则为NO
with_hierarchy yes_or_no
在 SQL 标准中，WITH HIERARCHY OPTION是一个独立的（子）特权，它允许在表继承层级上进行特定操作。
在 PostgreSQL 中，这被包括在SELECT特权中，因此这一列在特权为SELECT时显示YES，其他时候显示NO。
上一页 上一级 下一页35.36. role_routine_grants 起始页 35.38. role_udt_grants
