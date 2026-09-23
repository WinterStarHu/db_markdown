# 35.16. column_udt_usage

35.16. column_udt_usage
版本：
纠错本页面
搜索
目录导航
❮
❯
35.16. column_udt_usage #
视图column_udt_usage标识所有使用被一个当前启用的角色拥有的数据类型的列。注意在PostgreSQL中，内建数据类型的行为和用户定义的类型相似，因此它们也被包括在这里。详见第 35.17 节。
表 35.14. column_udt_usage 列
列类型
描述
udt_catalog sql_identifier
该列数据类型（如果适用，底层的域类型）被定义的数据库名称（总是当前数据库）
udt_schema sql_identifier
该列数据类型（如果适用，底层的域类型）被定义的模式名称
udt_name sql_identifier
该列数据类型（如果适用，底层的域类型）的名称
table_catalog sql_identifier
包含表的数据库的名称（总是当前数据库）
table_schema sql_identifier
包含表的模式的名称
table_name sql_identifier
表的名称
column_name sql_identifier
列的名称
上一页 上一级 下一页35.15. column_privileges 起始页 35.17. columns
