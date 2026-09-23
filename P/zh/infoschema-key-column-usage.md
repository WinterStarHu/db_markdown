# 35.32. key_column_usage

35.32. key_column_usage
版本：
纠错本页面
搜索
目录导航
❮
❯
35.32. key_column_usage #
视图key_column_usage标识当前数据库中所有被某种唯一、主键或外键约束限制的列。检查约束不包括在此视图中。只有那些当前用户能够访问的列才会被显示（作为拥有者或具有某些特权）。
表 35.30. key_column_usage 列
列类型
描述
constraint_catalog sql_identifier
包含该约束的数据库名称（始终是当前数据库）
constraint_schema sql_identifier
包含该约束的模式名称
constraint_name sql_identifier
约束的名称
table_catalog sql_identifier
包含被这个约束限制的列的表所在的数据库名称（始终是当前数据库）
table_schema sql_identifier
包含被这个约束限制的列的表所在的模式名称
table_name sql_identifier
包含被这个约束限制的列的表的名称
column_name sql_identifier
被这个约束限制的列的名称
ordinal_position cardinal_number
该列在约束键中的顺序位置（从 1 开始计数）
position_in_unique_constraint cardinal_number
对于一个外键约束，被引用列在其唯一约束中的顺序位置（从 1 开始计数）；对于其他约束为空
上一页 上一级 下一页35.31. foreign_tables 起始页 35.33. parameters
