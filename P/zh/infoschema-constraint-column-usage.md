# 35.18. constraint_column_usage

35.18. constraint_column_usage
版本：
纠错本页面
搜索
目录导航
❮
❯
35.18. constraint_column_usage #
视图 constraint_column_usage 标识当前数据库中被某些约束使用的所有列。
仅显示包含在当前启用角色拥有的表中的那些列。对于检查约束，该视图
标识在检查表达式中使用的列。对于非空约束，该视图标识定义约束的列。
对于外键约束，该视图标识外键所引用的列。对于唯一或主键约束，该视图
标识受约束的列。
表 35.16. constraint_column_usage 列
列类型
描述
table_catalog sql_identifier
包含被某个约束使用的列的表所在的数据库名称（总是当前数据库）
table_schema sql_identifier
包含被某个约束使用的列的表所在的模式名称
table_name sql_identifier
包含被某个约束使用的列的表名称
column_name sql_identifier
被某个约束使用的列名称
constraint_catalog sql_identifier
包含该约束的数据库名称（总是当前数据库）
constraint_schema sql_identifier
包含该约束的模式名称
constraint_name sql_identifier
约束的名称
上一页 上一级 下一页35.17. columns 起始页 35.19. constraint_table_usage
