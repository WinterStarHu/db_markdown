# 35.55. transforms

35.55. transforms
版本：
纠错本页面
搜索
目录导航
❮
❯
35.55. transforms #
视图transforms包含当前数据库中定义的转换的信息。更准确
来说，它包含在转换中的每一个函数（“from SQL”或
“to SQL”函数）的一行。
表 35.53. transforms 列
列类型
描述
udt_catalog sql_identifier
包含该转换所适用类型的数据库的名称（始终是当前数据库）
udt_schema sql_identifier
包含该转换所适用类型的模式名称
udt_name sql_identifier
该转换所适用类型的名称
specific_catalog sql_identifier
包含该函数的数据库名称（总是当前数据库）
specific_schema sql_identifier
包含函数的模式名称
specific_name sql_identifier
函数的“特定名称”。  详见 第 35.45 节。
group_name sql_identifier
SQL 标准允许在“组”中定义转换，并且在运行时选择一个
组。PostgreSQL 不支持这种做法，转换是与一种语言相关的。作为一种折衷，
该字段包含该转换所适用的语言。
transform_type character_data
FROM SQL 或 TO SQL
上一页 上一级 下一页35.54. tables 起始页 35.56. triggered_update_columns
