# 35.56. triggered_update_columns

35.56. triggered_update_columns
版本：
纠错本页面
搜索
目录导航
❮
❯
35.56. triggered_update_columns #
对于当前数据库中指定列列表（如UPDATE OF column1, column2）的触发器，视图triggered_update_columns标识这些列。没有指定列列表的触发器不被包括在该视图中。只有那些当前用户拥有或具有某种除SELECT之外特权的列才会被显示。
表 35.54. triggered_update_columns 列
列类型
描述
trigger_catalog sql_identifier
包含触发器的数据库名称（总是当前数据库）
trigger_schema sql_identifier
包含触发器的模式名称
trigger_name sql_identifier
触发器的名称
event_object_catalog sql_identifier
包含触发器所在的表的数据库名称（总是当前数据库）
event_object_schema sql_identifier
包含触发器所在的表的模式名称
event_object_table sql_identifier
触发器所在的表的名称
event_object_column sql_identifier
触发器定义所在的列的名称
上一页 上一级 下一页35.55. transforms 起始页 35.57. triggers
