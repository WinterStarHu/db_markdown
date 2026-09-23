# 35.43. routine_sequence_usage

35.43. routine_sequence_usage
版本：
纠错本页面
搜索
目录导航
❮
❯
35.43. routine_sequence_usage #
视图 routine_sequence_usage 标识出所有被函数或过程使用的序列，
无论是在 SQL 主体中还是在参数默认表达式中。（这仅适用于未引用的 SQL 主体，
而不适用于引用的主体或其他语言中的函数。）只有当前启用角色拥有的序列才会被包括进来。
表 35.41. routine_sequence_usage 列
列类型
描述
specific_catalog sql_identifier
包含该函数的数据库名称（总是当前数据库）
specific_schema sql_identifier
包含函数的模式名称
specific_name sql_identifier
函数的“特定名称”。  详见 第 35.45 节。
routine_catalog sql_identifier
包含该函数的数据库名称（始终是当前数据库）
routine_schema sql_identifier
包含函数的模式名称
routine_name sql_identifier
函数的名称（在重载的情况下可能会重复）
schema_catalog sql_identifier
包含由函数使用的序列的数据库名称（始终是当前数据库）
sequence_schema sql_identifier
包含由函数使用的序列的模式名称
sequence_name sql_identifier
函数使用的序列名称
上一页 上一级 下一页35.42. routine_routine_usage 起始页 35.44. routine_table_usage
