# 35.59. usage_privileges

35.59. usage_privileges
版本：
纠错本页面
搜索
目录导航
❮
❯
35.59. usage_privileges #
视图usage_privileges标识所有在多种对象上授予的USAGE特权，这些特权的授予者或者被授予者是一个当前已被启用的角色。在PostgreSQL中，这当前适用于排序规则、域、外部数据包装器、外部服务器和序列。对每一个对象、授予者和被授予者都有一行。
由于在PostgreSQL中排序规则并没有真正的特权，这个视图对所有排序规则显示由拥有者授予给PUBLIC的隐式非可授予的USAGE特权。但是对其他对象类型则显示真实的特权。
在 PostgreSQL 中，序列也支持除USAGE之外的SELECT和UPDATE特权。这些是非标准的并且因此在该信息模式中不可见。
表 35.57. usage_privileges 列
列类型
描述
grantor sql_identifier
授予该特权的角色名称
grantee sql_identifier
被授予该特权的角色名称
object_catalog sql_identifier
包含该对象的数据库名称（始终是当前数据库）
object_schema sql_identifier
如果适用，则为包含该对象的模式名称，否则为一个空字符串
object_name sql_identifier
对象的名称
object_type character_data
COLLATION或DOMAIN或FOREIGN DATA WRAPPER或FOREIGN SERVER或SEQUENCE
privilege_type character_data
总是USAGE
is_grantable yes_or_no
如果该特权是可授予的，则为YES，否则为NO
上一页 上一级 下一页35.58. udt_privileges 起始页 35.60. user_defined_types
