# 35.11. collation_character_set_​applicability

35.11. collation_character_set_​applicability
版本：
纠错本页面
搜索
目录导航
❮
❯
35.11. collation_character_set_​applicability #
视图 collation_character_set_applicability
标识可用的排序规则适用于哪些字符集。在 PostgreSQL 中，每个数据库中只有一种字符集（解释见
第 35.7 节），因此这个视图没有提供很有用的信息。
表 35.9. collation_character_set_applicability 列
列类型
描述
collation_catalog sql_identifier
包含该排序规则的数据库名称（总是当前数据库）
collation_schema sql_identifier
包含该排序规则的模式名称
collation_name sql_identifier
默认排序规则的名称
character_set_catalog sql_identifier
字符集当前尚未实现为模式对象，因此这一列为空
character_set_schema sql_identifier
字符集当前尚未实现为模式对象，因此这一列为空
character_set_name sql_identifier
字符集名称
上一页 上一级 下一页35.10. collations 起始页 35.12. column_column_usage
