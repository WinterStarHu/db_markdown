# 35.21. domain_constraints

35.21. domain_constraints
版本：
纠错本页面
搜索
目录导航
❮
❯
35.21. domain_constraints #
视图domain_constraints包含所有属于当前数据库中定义的域的约束。只有当前用户能访问的那些域才会被显示（作为拥有者或具有某些特权）。
表 35.19. domain_constraints 列
列类型
描述
constraint_catalog sql_identifier
包含该约束的数据库名称（总是当前数据库）
constraint_schema sql_identifier
包含该约束的模式名称
constraint_name sql_identifier
约束的名称
domain_catalog sql_identifier
包含该域的数据库名称（总是当前数据库）
domain_schema sql_identifier
包含该域的模式名称
domain_name sql_identifier
域名称
is_deferrable yes_or_no
如果该约束是可延迟的，则为YES，如果不是则为NO
initially_deferred yes_or_no
如果该约束是可延迟的且初始就被延迟，则为YES，如果不是则为NO
上一页 上一级 下一页35.20. data_type_privileges 起始页 35.22. domain_udt_usage
