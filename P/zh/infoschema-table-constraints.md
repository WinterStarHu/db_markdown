# 35.52. table_constraints

35.52. table_constraints
版本：
纠错本页面
搜索
目录导航
❮
❯
35.52. table_constraints #
视图table_constraints包含所有属于当前用户拥有或在其上具有某种除SELECT之外特权的表的约束。
表 35.50. table_constraints 列
列类型
描述
constraint_catalog sql_identifier
包含该约束的数据库名称（始终是当前数据库）
constraint_schema sql_identifier
包含该约束的模式的名称
constraint_name sql_identifier
约束的名称
table_catalog sql_identifier
包含该表的数据库名称（始终是当前数据库）
table_schema sql_identifier
包含该表的模式的名称
table_name sql_identifier
表的名称
constraint_type character_data
约束的类型：CHECK（包括非空约束），
FOREIGN KEY，PRIMARY KEY，
或 UNIQUE
is_deferrable yes_or_no
如果该约束是可延迟的，则为YES，否则为NO
initially_deferred yes_or_no
如果该约束是可延迟的且初始就被延迟，则为YES，否则为NO
enforced yes_or_no
如果约束被强制，则为 YES，否则为 NO
nulls_distinct yes_or_no
如果约束是唯一约束，则 YES 表示约束将空值视为不同，NO 表示约束将空值视为相同，否则对于其他类型的约束为 null。
上一页 上一级 下一页35.51. sql_sizing 起始页 35.53. table_privileges
