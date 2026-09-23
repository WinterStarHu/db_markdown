# 35.12. column_column_usage

35.12. column_column_usage
版本：
纠错本页面
搜索
目录导航
❮
❯
35.12. column_column_usage #
视图column_column_usage标识依赖于同一表中的另一个基本列生成的所有列。只包含当前启用的角色所拥有的表。
表 35.10. column_column_usage 列
列类型
描述
table_catalog sql_identifier
包含表的数据库的名称（始终是当前数据库）
table_schema sql_identifier
包含表的模式的名称
table_name sql_identifier
表的名称
column_name sql_identifier
生成列所依赖的基本列的名称
dependent_column sql_identifier
生成的列的名称
上一页 上一级 下一页35.11. collation_character_set_​applicability 起始页 35.13. column_domain_usage
