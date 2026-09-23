# 52.21. pg_event_trigger

52.21. pg_event_trigger
版本：
纠错本页面
搜索
目录导航
❮
❯
52.21. pg_event_trigger #
目录pg_event_trigger存储事件触发器。更多信息参见第 38 章。
表 52.21. pg_event_trigger 列
列类型
描述
oid oid
行标识符
evtname name
触发器名（必须唯一）
evtevent name
此触发器触发的事件的标识符
evtowner oid
(references pg_authid.oid)
事件触发器的拥有者
evtfoid oid
(references pg_proc.oid)
将被调用的函数
evtenabled char
控制事件触发器触发的 session_replication_role 模式。
O = 触发器在 “origin” 和 “local” 模式触发，
D = 触发器被禁用，
R = 触发器在 “replica” 模式触发，
A = 触发器总是触发。
evttags text[]
此触发器将触发的命令标签。如果为 NULL，此触发器的触发不受命令标签的限制。
上一页 上一级 下一页52.20. pg_enum 起始页 52.22. pg_extension
