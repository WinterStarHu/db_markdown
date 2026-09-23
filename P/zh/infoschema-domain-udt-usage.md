# 35.22. domain_udt_usage

35.22. domain_udt_usage
版本：
纠错本页面
搜索
目录导航
❮
❯
35.22. domain_udt_usage #
视图domain_udt_usage标识所有基于被一个当前启用的角色拥有的数据类型的域。
注意在PostgreSQL中，内建数据类型的行为相似于用户定义的类型，
因此它们也被包括在这里。
表 35.20. domain_udt_usage 列
列类型
描述
udt_catalog sql_identifier
该域数据类型被定义的数据库名称（总是当前数据库）
udt_schema sql_identifier
该域数据类型被定义的模式名称
udt_name sql_identifier
该域数据类型的名称
domain_catalog sql_identifier
包含该域的数据库名称（始终是当前数据库）
domain_schema sql_identifier
包含该域的模式名称
domain_name sql_identifier
域名称
上一页 上一级 下一页35.21. domain_constraints 起始页 35.23. domains
