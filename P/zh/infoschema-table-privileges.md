# 35.53. table_privileges

35.53. table_privileges
版本：
纠错本页面
搜索
目录导航
❮
❯
35.53. table_privileges #
视图 table_privileges 标识在表或视图上所有被授予的特权，这些特权必须是被一个当前已被启用角色授出或者被授予给一个当前已被启用角色。对每一个表、授予者和被授予者的组合都有一行。
表 35.51. table_privileges 列
列类型
描述
grantor sql_identifier
授予该特权的角色名称
grantee sql_identifier
被授予该特权的角色名称
table_catalog sql_identifier
包含该表的数据库名称（总是当前数据库）
table_schema sql_identifier
包含该表的模式名称
table_name sql_identifier
表的名称
privilege_type character_data
该特权的类型：SELECT、
INSERT、UPDATE、
DELETE、TRUNCATE、
REFERENCES或TRIGGER
is_grantable yes_or_no
YES 如果该特权是可授予的，NO 如果不是
with_hierarchy yes_or_no
在 SQL 标准中，WITH HIERARCHY OPTION是一个独立的（子）特权，它允许在表继承层级上的特定操作。
在 PostgreSQL 中，这被包括在SELECT特权中，因此这一列在特权为SELECT时显示YES，否则显示NO。
上一页 上一级 下一页35.52. table_constraints 起始页 35.54. tables
