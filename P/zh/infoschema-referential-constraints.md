# 35.34. referential_constraints

35.34. referential_constraints
版本：
纠错本页面
搜索
目录导航
❮
❯
35.34. referential_constraints #
视图referential_constraints包含当前数据库中的所有引用（外键）约束。只有那些当前用户具有其引用表上写权限（作为拥有者或具有某些除SELECT之外的特权）的约束才会被显示。
表 35.32. referential_constraints 列
列类型
描述
constraint_catalog sql_identifier
包含约束的数据库名称（总是当前数据库）
constraint_schema sql_identifier
包含约束的模式名称
constraint_name sql_identifier
约束的名称
unique_constraint_catalog sql_identifier
包含该外键约束所引用的唯一或主键约束的数据库名称（始终是当前数据库）
unique_constraint_schema sql_identifier
包含该外键约束所引用的唯一或主键约束的模式名称
unique_constraint_name sql_identifier
唯一或主键约束的名称，该约束被外键约束引用
match_option character_data
外键约束的匹配选项：
FULL、PARTIAL或
NONE。
update_rule character_data
外键约束的更新规则：
CASCADE、SET NULL、
SET DEFAULT、RESTRICT或
NO ACTION。
delete_rule character_data
外键约束的删除规则：
CASCADE、SET NULL、
SET DEFAULT、RESTRICT或
NO ACTION。
上一页 上一级 下一页35.33. parameters 起始页 35.35. role_column_grants
