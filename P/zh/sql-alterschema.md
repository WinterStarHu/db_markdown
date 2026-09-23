# ALTER SCHEMA

ALTER SCHEMA
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER SCHEMAALTER SCHEMA — 更改模式的定义大纲
ALTER SCHEMA name RENAME TO new_name
ALTER SCHEMA name OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
描述
ALTER SCHEMA更改模式的定义。
您必须拥有该模式才能使用ALTER SCHEMA。
要重命名一个模式，您还必须拥有数据库的
CREATE权限。
要更改所有者，您必须能够SET ROLE为新的所有者角色，
并且该角色必须拥有数据库的CREATE权限。
（请注意，超级用户会自动拥有所有这些权限。）
参数name
现有模式的名称。
new_name
该模式的新名称。新名称不能以pg_开始，因为这些名称被
保留用于系统模式。
new_owner
该模式的新拥有者。
兼容性
在 SQL 标准中没有ALTER SCHEMA语句。
另见CREATE SCHEMA, DROP SCHEMA上一页 上一级 下一页ALTER RULE 起始页 ALTER SEQUENCE
