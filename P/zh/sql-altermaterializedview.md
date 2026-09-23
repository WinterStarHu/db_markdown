# ALTER MATERIALIZED VIEW

ALTER MATERIALIZED VIEW
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER MATERIALIZED VIEWALTER MATERIALIZED VIEW — 更改物化视图的定义大纲
ALTER MATERIALIZED VIEW [ IF EXISTS ] name
action [, ... ]
ALTER MATERIALIZED VIEW name
[ NO ] DEPENDS ON EXTENSION extension_name
ALTER MATERIALIZED VIEW [ IF EXISTS ] name
RENAME [ COLUMN ] column_name TO new_column_name
ALTER MATERIALIZED VIEW [ IF EXISTS ] name
RENAME TO new_name
ALTER MATERIALIZED VIEW [ IF EXISTS ] name
SET SCHEMA new_schema
ALTER MATERIALIZED VIEW ALL IN TABLESPACE name [ OWNED BY role_name [, ... ] ]
SET TABLESPACE new_tablespace [ NOWAIT ]
其中action是以下之一：
ALTER [ COLUMN ] column_name SET STATISTICS integer
ALTER [ COLUMN ] column_name SET ( attribute_option = value [, ... ] )
ALTER [ COLUMN ] column_name RESET ( attribute_option [, ... ] )
ALTER [ COLUMN ] column_name SET STORAGE { PLAIN | EXTERNAL | EXTENDED | MAIN | DEFAULT }
ALTER [ COLUMN ] column_name SET COMPRESSION compression_method
CLUSTER ON index_name
SET WITHOUT CLUSTER
SET ACCESS METHOD new_access_method
SET TABLESPACE new_tablespace
SET ( storage_parameter [= value] [, ... ] )
RESET ( storage_parameter [, ... ] )
OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
描述
ALTER MATERIALIZED VIEW更改现有物化视图的
多个辅助属性。
您必须拥有该物化视图才能使用ALTER MATERIALIZED VIEW。
要更改物化视图的模式，您还必须拥有新模式的CREATE
权限。
要更改所有者，您必须能够SET ROLE为新的所有角色，
并且该角色必须拥有物化视图模式的CREATE权限。
（这些限制确保更改所有者不会执行任何您无法通过删除和重新创建
物化视图来完成的操作。然而，超级用户仍然可以更改任何视图的所有权。）
可用于ALTER MATERIALIZED VIEW的语句形式和动作是
ALTER TABLE的一个子集，并且在用于物化视图时具有相
同的含义。详见ALTER TABLE的描述。
参数name
一个现有物化视图的名称（可选的模式限定）。
column_name
一个现有列的名称。
extension_name
该物化视图所依赖的扩展的名称（如果指定了 NO ，则不再依赖）。
当删除扩展时，标记为依赖于该扩展的物化视图会被自动删除。
new_column_name
一个现有列的新名称。
new_owner
该物化视图的新拥有者的用户名。
new_name
该物化视图的新名称。
new_schema
该物化视图的新模式。
示例
把物化视图foo重命名为
bar：
ALTER MATERIALIZED VIEW foo RENAME TO bar;
兼容性
ALTER MATERIALIZED VIEW是一个
PostgreSQL扩展。
另见CREATE MATERIALIZED VIEW, DROP MATERIALIZED VIEW, REFRESH MATERIALIZED VIEW上一页 上一级 下一页ALTER LARGE OBJECT 起始页 ALTER OPERATOR
