# 35.44. routine_table_usage

35.44. routine_table_usage
版本：
纠错本页面
搜索
目录导航
❮
❯
35.44. routine_table_usage #
视图routine_table_usage用于标识函数或过程所使用的所有表。
该信息目前不被PostgreSQL追踪。
表 35.42. routine_table_usage 列
列类型
描述
specific_catalog sql_identifier
包含该函数的数据库名称（总是当前数据库）
specific_schema sql_identifier
包含函数的模式名称
specific_name sql_identifier
函数的“特定名称”。  详请参见 第 35.45 节。
routine_catalog sql_identifier
包含该函数的数据库名称（总是当前数据库）
routine_schema sql_identifier
包含该函数的模式名称
routine_name sql_identifier
函数的名称（在重载的情况下可能会重复）
table_catalog sql_identifier
包含由该函数所使用的表的数据库名称（总是当前数据库）
table_schema sql_identifier
包含该函数所使用的表的模式名称
table_name sql_identifier
该函数所使用的表的名称
上一页 上一级 下一页35.43. routine_sequence_usage 起始页 35.45. routines
