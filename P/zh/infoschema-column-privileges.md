# 35.15. column_privileges

35.15. column_privileges
版本：
纠错本页面
搜索
目录导航
❮
❯
35.15. column_privileges #
视图column_privileges标识所有授予给当前启用的角色或由当前启用的角色授予的特权。对每一个列、授予者和被授予者的组合只有一行。
如果一个特权被授予在整个表上，它在这个视图中将显示为在每一列上授予，但只有在列粒度可用的特权类型才会这样：
SELECT、INSERT、
UPDATE、REFERENCES。
表 35.13. column_privileges 列权限
列类型
描述
grantor sql_identifier
授予特权的角色名称
grantee sql_identifier
被授予特权的角色名称
table_catalog sql_identifier
包含该列的表所在的数据库名称（始终是当前数据库）
table_schema sql_identifier
包含该列的表所在的模式名称
table_name sql_identifier
包含该列的表名称
column_name sql_identifier
列名称
privilege_type character_data
特权类型：SELECT、INSERT、UPDATE或REFERENCES
is_grantable yes_or_no
如果该特权是可授予的，则为YES，否则为NO
上一页 上一级 下一页35.14. column_options 起始页 35.16. column_udt_usage
