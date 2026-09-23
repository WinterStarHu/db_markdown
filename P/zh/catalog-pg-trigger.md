# 52.58. pg_trigger

52.58. pg_trigger
版本：
纠错本页面
搜索
目录导航
❮
❯
52.58. pg_trigger #
目录pg_trigger存储表和视图上的触发器。
详见CREATE TRIGGER。
表 52.58. pg_trigger 列
列类型
描述
oid oid
行标识符
tgrelid oid
(references pg_class.oid)
触发器所在的表
tgparentid oid
(references pg_trigger.oid)
此触发器克隆自的父触发器（这会在创建分区或附加到分区表时发生）；
如果不是克隆则为零。
tgname name
触发器名称（在同一个表的触发器中必须唯一）
tgfoid oid
(references pg_proc.oid)
要被触发器调用的函数
tgtype int2
标识触发器触发条件的位掩码
tgenabled char
控制触发器在session_replication_role模式中的触发。
O = 触发器在“origin”和“local”模式触发，
D = 触发器被禁用，
R = 触发器在“replica”模式触发，
A = 触发器总是触发。
tgisinternal bool
为真表示触发器是内部生成的（通常是为了强制由tgconstraint指定的约束）
tgconstrrelid oid
(references pg_class.oid)
被一个引用完整性约束引用的表（如果触发器不是针对一个引用完整性约束则为零）
tgconstrindid oid
(references pg_class.oid)
支持一个唯一、主键、引用完整性约束或者排除约束的索引（如果触发器不是针对这些约束类型中的一个则为零）
tgconstraint oid
(references pg_constraint.oid)
与触发器相关的pg_constraint项（如果触发器不用于约束则为零）
tgdeferrable bool
如果约束触发器可推迟则为真
tginitdeferred bool
如果约束触发器初始可推迟则为真
tgnargs int2
传递给触发器函数的参数字符串个数
tgattr int2vector
(references pg_attribute.attnum)
如果触发器是列限定的，这里存放列号；否则这是一个空数组
tgargs bytea
传递给触发器的参数字符串，每一个都以NULL结尾
tgqual pg_node_tree
触发器WHEN条件的表达式树（以nodeToString()的表现形式），如果没有则为空
tgoldtable name
OLD TABLE的REFERENCING子句名称，如果没有则为空
tgnewtable name
NEW TABLE的REFERENCING子句名称，如果没有则为空
当前，列限定触发器只被UPDATE事件支持，因此tgattr只用于这种事件类型。tgtype可能包含用于其他事件类型的位，但其他事件类型被认为是表范围的，无论tgattr中包含什么。
注意
当tgconstraint非零时，tgconstrrelid、tgconstrindid、tgdeferrable和tginitdeferred与被引用的pg_constraint项有很大的冗余。
但是，存在将一个不可延迟触发器关联到一个可延迟约束的可能性：外键约束可以有一些可延迟和一些不可延迟触发器。
注意
如果一个关系在本目录中拥有任何触发器，其pg_class.relhastriggers必须为真。
上一页 上一级 下一页52.57. pg_transform 起始页 52.59. pg_ts_config
