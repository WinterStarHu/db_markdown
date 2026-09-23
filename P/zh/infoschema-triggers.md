# 35.57. triggers

35.57. triggers
版本：
纠错本页面
搜索
目录导航
❮
❯
35.57. triggers #
视图triggers包含所有定义在当前数据库中表和视图上的触发器，并且只显示当前用户拥有的触发器或者是当前用户在其上具有某种除SELECT之外特权的触发器。
表 35.55. triggers 列
列类型
描述
trigger_catalog sql_identifier
包含触发器的数据库名称（总是当前数据库）
trigger_schema sql_identifier
包含触发器的模式名称
trigger_name sql_identifier
触发器的名称
event_manipulation character_data
触发该触发器的事件（INSERT、UPDATE或DELETE）
event_object_catalog sql_identifier
包含触发器所在的表的数据库名称（始终是当前数据库）
event_object_schema sql_identifier
包含触发器所在的表的模式名称
event_object_table sql_identifier
触发器所在的表的名称
action_order cardinal_number
同一个表上具有相同event_manipulation、action_timing和action_orientation的触发器之间的触发顺序。
在PostgreSQL中，触发器按照名称顺序被触发，因此这一列会反映这种顺序。
action_condition character_data
触发器的WHEN条件，如果没有则为空（如果该表不被一个当前已启用角色拥有也是为空）
action_statement character_data
触发器执行的语句（当前总是 EXECUTE FUNCTION function(...)）
action_orientation character_data
标识触发器是对每个被处理的行触发一次还是为每个语句触发一次（ROW或STATEMENT）
action_timing character_data
触发器在什么时候触发（BEFORE、AFTER或INSTEAD OF）
action_reference_old_table sql_identifier
“旧”过渡表的名称，如果没有则为空
action_reference_new_table sql_identifier
“新”过渡表的名称，如果没有则为空
action_reference_old_row sql_identifier
应用于一个PostgreSQL中不可用的特性
action_reference_new_row sql_identifier
应用于一个PostgreSQL中不可用的特性
created time_stamp
应用于一个PostgreSQL中不可用的特性
PostgreSQL中的触发器有两点与 SQL 标准不兼容，这会影响在该信息模式中的表示。第一，在PostgreSQL中触发器的名字是局限于每个表的，而不是独立于模式对象。因此可能在一个模式中会有重复的触发器名称，只要它们属于不同的表（trigger_catalog和trigger_schema才真正标识了触发器被定义在哪个表上）。第二，在PostgreSQL中触发器可以被定义为在多个事件上触发（例如ON INSERT OR
UPDATE），而在 SQL 标准中只允许一个。如果一个触发器被定义为在多个事件上触发，它在信息模式中被表示为多行，每一行对应于一类事件。作为这两个问题的结果，视图triggers的主键实际上是(trigger_catalog, trigger_schema, event_object_table,
trigger_name, event_manipulation)，而不是(trigger_catalog, trigger_schema, trigger_name)（这是 SQL 标准指定的）。尽管如此，如果你以符合 SQL 标准（在模式中触发器名称唯一并且每个触发器只能有一种事件类型）的方式定义你的触发器，这将不会影响你。
注意
在PostgreSQL 9.1 之前，这个视图的列
action_timing、
action_reference_old_table、
action_reference_new_table、
action_reference_old_row和
action_reference_new_row
分别被命名为
condition_timing、
condition_reference_old_table、
condition_reference_new_table、
condition_reference_old_row和
condition_reference_new_row。
那也是它们在 SQL:1999 标准中的命名。新的命名遵循 SQL:2003 及其后的版本。
上一页 上一级 下一页35.56. triggered_update_columns 起始页 35.58. udt_privileges
