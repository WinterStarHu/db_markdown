# ALTER EVENT TRIGGER

ALTER EVENT TRIGGER
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER EVENT TRIGGERALTER EVENT TRIGGER — 更改事件触发器的定义大纲
ALTER EVENT TRIGGER name DISABLE
ALTER EVENT TRIGGER name ENABLE [ REPLICA | ALWAYS ]
ALTER EVENT TRIGGER name OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
ALTER EVENT TRIGGER name RENAME TO new_name
描述
ALTER EVENT TRIGGER更改现有事件触发器的属性。
必须是超级用户才能修改事件触发器。
参数name
要修改的现有触发器的名称。
new_owner
该事件触发器的新拥有者的用户名。
new_name
该事件触发器的新名称。
DISABLE/ENABLE [ REPLICA | ALWAYS ]
这些形式配置事件触发器的触发。一个被禁用的触发器对系统来说仍然是可知的，
但是当其触发事件发生时却不会执行它。另见
session_replication_role。
兼容性
在 SQL 标准中没有 ALTER EVENT TRIGGER 语句。
另见CREATE EVENT TRIGGER, DROP EVENT TRIGGER上一页 上一级 下一页ALTER DOMAIN 起始页 ALTER EXTENSION
