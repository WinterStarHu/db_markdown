# ALTER TRIGGER

ALTER TRIGGER
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER TRIGGERALTER TRIGGER — 更改触发器的定义大纲
ALTER TRIGGER name ON table_name RENAME TO new_name
ALTER TRIGGER name ON table_name [ NO ] DEPENDS ON EXTENSION extension_name
描述
ALTER TRIGGER更改现有触发器的属性。
RENAME子句更改给定触发器的名称，而不改变触发器定义。
如果触发器所在的表是分区表，则分区中的相应克隆触发器也会被重命名。
DEPENDS ON EXTENSION子句标记触发器依赖于扩展，如果扩展被删除，
触发器也将自动被删除。
要更改触发器的属性，你必须拥有该触发器所作用的表。
参数name
要修改的现有触发器的名称。
table_name
该触发器作用的表的名称。
new_name
触发器的新名称。
extension_name
触发器依赖的扩展名称（如果指定了NO，则不再依赖）。
当扩展被删除时，标记为依赖于该扩展的触发器会自动被删除。
备注
临时启用或禁用触发器的功能由ALTER TABLE提供，而不是
ALTER TRIGGER，因为ALTER TRIGGER没有
方便的方式来表示一次性启用或禁用一个表的所有触发器的选项。
示例
要重命名一个现有的触发器：
ALTER TRIGGER emp_stamp ON emp RENAME TO emp_track_chgs;
要把一个触发器标记为依赖于一个扩展：
ALTER TRIGGER emp_stamp ON emp DEPENDS ON EXTENSION emplib;
兼容性
ALTER TRIGGER是一个
PostgreSQL的 SQL 标准扩展。
另见ALTER TABLE上一页 上一级 下一页ALTER TEXT SEARCH TEMPLATE 起始页 ALTER TYPE
