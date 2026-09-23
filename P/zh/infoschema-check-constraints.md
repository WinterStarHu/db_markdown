# 35.9. check_constraints

35.9. check_constraints
版本：
纠错本页面
搜索
目录导航
❮
❯
35.9. check_constraints #
视图check_constraints包含所有检查约束，不管是定义在一个表上的还是定义在一个域上的，它们被一个当前启用的角色所拥有（表或域的拥有者就是约束的拥有者）。
SQL 标准将非空约束视为带有 CHECK (column_name IS NOT
NULL) 表达式的检查约束。因此，非空约束也包含在此处，
并且没有单独的视图。
表 35.7. check_constraints 列
列类型
描述
constraint_catalog sql_identifier
包含约束的数据库名称（总是当前数据库）
constraint_schema sql_identifier
包含约束的模式的名称
constraint_name sql_identifier
约束的名称
check_clause character_data
检查约束的检查表达式
上一页 上一级 下一页35.8. check_constraint_routine_usage 起始页 35.10. collations
