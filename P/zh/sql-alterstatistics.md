# ALTER STATISTICS

ALTER STATISTICS
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER STATISTICSALTER STATISTICS —
更改扩展统计对象的定义
大纲
ALTER STATISTICS name OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
ALTER STATISTICS name RENAME TO new_name
ALTER STATISTICS name SET SCHEMA new_schema
ALTER STATISTICS name SET STATISTICS { new_target | DEFAULT }
描述
ALTER STATISTICS更改现有扩展统计对象的参数。
任何在ALTER STATISTICS命令中没有明确设定的参数保持它们之前的设置。
您必须拥有统计对象的所有权才能使用ALTER STATISTICS。
要更改统计对象的模式，您还必须拥有新模式的CREATE
权限。要更改所有者，您必须能够SET ROLE为新的所有者角色，
并且该角色必须在统计对象的模式中拥有CREATE权限。
（这些限制确保更改所有者不会执行您通过删除和重新创建统计对象
无法完成的操作。然而，超级用户仍然可以更改任何统计对象的所有权。）
参数
name
要更改的统计对象的名称（可选带模式限定）。
new_owner
统计对象的新所有者的用户名。
new_name
统计对象的新名称。
new_schema
统计对象的新模式。
new_target
该统计对象用于后续ANALYZE操作的统计收集目标。
目标值可设置在0到10000之间。设置为DEFAULT可恢复使用系统默认的统计目标
(default_statistics_target)。
（设置为-1是过时的写法，但效果相同。）
有关PostgreSQL查询规划器使用统计信息的更多信息，请参见
第 14.2 节。
兼容性
SQL标准中没有ALTER STATISTICS命令。
另见CREATE STATISTICS, DROP STATISTICS上一页 上一级 下一页ALTER SERVER 起始页 ALTER SUBSCRIPTION
