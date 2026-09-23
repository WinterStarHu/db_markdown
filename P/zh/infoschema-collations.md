# 35.10. collations

35.10. collations
版本：
纠错本页面
搜索
目录导航
❮
❯
35.10. collations #
视图collations包含当前数据库中可用的排序规则。
表 35.8. collations 列
列类型
描述
collation_catalog sql_identifier
包含该排序规则的数据库名称（总是当前数据库）
collation_schema sql_identifier
包含该排序规则的模式名称
collation_name sql_identifier
默认排序规则的名称
pad_attribute character_data
总是 NO PAD （另一种选择 PAD
SPACE 不被 PostgreSQL 支持。）
上一页 上一级 下一页35.9. check_constraints 起始页 35.11. collation_character_set_​applicability
