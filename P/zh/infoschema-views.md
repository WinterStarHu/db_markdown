# 35.66. views

35.66. views
版本：
纠错本页面
搜索
目录导航
❮
❯
35.66. views #
视图views包含定义在当前数据库中的所有视图。只有当前用户能够访问（作为拥有者或具有某些特权）的视图才会被显示。
表 35.64. views 列
列类型
描述
table_catalog sql_identifier
包含该视图的数据库名称（总是当前数据库）
table_schema sql_identifier
包含该视图的模式名称
table_name sql_identifier
视图名称
view_definition character_data
定义视图的查询表达式（如果该视图不被当前已启用角色拥有则为空）
check_option character_data
CASCADED 或 LOCAL 如果视图上有CHECK OPTION 定义，NONE 如果没有
is_updatable yes_or_no
如果该视图是可更新的（允许UPDATE和DELETE），则为YES，否则为NO
is_insertable_into yes_or_no
如果该视图是可插入的（允许INSERT），则为YES，否则为NO
is_trigger_updatable yes_or_no
如果该视图上有一个INSTEAD OF
UPDATE触发器，则为YES，否则为NO
is_trigger_deletable yes_or_no
如果该视图上有一个INSTEAD OF
DELETE触发器，则为YES，否则为NO
is_trigger_insertable_into yes_or_no
如果该视图上有一个INSTEAD OF
INSERT触发器，则为YES，否则为NO
上一页 上一级 下一页35.65. view_table_usage 起始页 部分 V. 服务器编程
