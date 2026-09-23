# 35.8. check_constraint_routine_usage

35.8. check_constraint_routine_usage
版本：
纠错本页面
搜索
目录导航
❮
❯
35.8. check_constraint_routine_usage #
视图check_constraint_routine_usage标识由检查约束使用的例程（函数和过程）。只有那些例程显示为当前启用的角色所拥有。
表 35.6. check_constraint_routine_usage 列
列类型
描述
constraint_catalog sql_identifier
包含约束的数据库名称（总是当前数据库）
constraint_schema sql_identifier
包含约束的模式名
constraint_name sql_identifier
约束的名称
specific_catalog sql_identifier
包含该函数的数据库名称（总是当前数据库）
specific_schema sql_identifier
包含函数的模式名称
specific_name sql_identifier
函数的“特定名称”。  详见 第 35.45 节。
上一页 上一级 下一页35.7. character_sets 起始页 35.9. check_constraints
