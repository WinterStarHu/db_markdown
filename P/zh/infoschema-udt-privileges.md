# 35.58. udt_privileges

35.58. udt_privileges
版本：
纠错本页面
搜索
目录导航
❮
❯
35.58. udt_privileges #
视图udt_privileges标识所有在用户定义类型上授予的USAGE特权，这些特权的授予者或者被授予者是一个当前已被启用的角色。
对每一个类型、授予者和被授予者的组合都有一行。
这个视图只显示组合类型（原因见下面的第 35.60 节）。
域特权见第 35.59 节。
表 35.56. udt_privileges 列
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
类型名称
privilege_type character_data
总是 TYPE USAGE
is_grantable yes_or_no
如果该特权是可授予的，则为YES，否则为NO
上一页 上一级 下一页35.57. triggers 起始页 35.59. usage_privileges
