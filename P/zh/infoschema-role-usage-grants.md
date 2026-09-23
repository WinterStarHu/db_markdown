# 35.39. role_usage_grants

35.39. role_usage_grants
版本：
纠错本页面
搜索
目录导航
❮
❯
35.39. role_usage_grants #
视图 role_usage_grants 标识
USAGE 特权，这些特权授予在各种对象上，
其中授予者或被授予者是当前已启用的角色。
更多信息可以在 usage_privileges 中找到。
这个视图和 usage_privileges 之间的唯一有效区别
是这个视图省略了通过授予给 PUBLIC 的方式
使当前用户获得访问权限的对象。
表 35.37. role_usage_grants 列
列类型
描述
grantor sql_identifier
授予该特权的角色名称
grantee sql_identifier
被授予该特权的角色名称
object_catalog sql_identifier
包含该对象的数据库名称（总是当前数据库）
object_schema sql_identifier
如果适用，则为包含该对象的模式名称，否则为一个空字符串
object_name sql_identifier
对象的名称
object_type character_data
COLLATION 或 DOMAIN 或 FOREIGN DATA WRAPPER 或 FOREIGN SERVER 或 SEQUENCE
privilege_type character_data
总是 USAGE
is_grantable yes_or_no
如果该特权是可授予的，则为 YES，否则为 NO
上一页 上一级 下一页35.38. role_udt_grants 起始页 35.40. routine_column_usage
