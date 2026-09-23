# 35.19. constraint_table_usage

35.19. constraint_table_usage
版本：
纠错本页面
搜索
目录导航
❮
❯
35.19. constraint_table_usage #
视图constraint_table_usage标识在当前数据库中被某个约束使用的所有表（这与视图table_constraints不同，它标识所有表约束及其定义的表）。对于一个外键约束，这个视图标识该外键引用的表。对于一个唯一或主键约束，这个视图仅标识该约束所属的表。检查约束和非空约束不包括在这个视图中。
表 35.17. constraint_table_usage 列
列类型
描述
table_catalog sql_identifier
包含被某个约束使用的表的数据库名称（始终是当前数据库）
table_schema sql_identifier
包含被某个约束使用的表的模式名称
table_name sql_identifier
包含被某个约束使用的表名称
constraint_catalog sql_identifier
包含该约束的数据库名称（始终是当前数据库）
constraint_schema sql_identifier
包含该约束的模式名称
constraint_name sql_identifier
约束的名称
上一页 上一级 下一页35.18. constraint_column_usage 起始页 35.20. data_type_privileges
