# CREATE MATERIALIZED VIEW

CREATE MATERIALIZED VIEW
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE MATERIALIZED VIEWCREATE MATERIALIZED VIEW — 定义一个新的物化视图大纲
CREATE MATERIALIZED VIEW [ IF NOT EXISTS ] table_name
[ (column_name [, ...] ) ]
[ USING method ]
[ WITH ( storage_parameter [= value] [, ... ] ) ]
[ TABLESPACE tablespace_name ]
AS query
[ WITH [ NO ] DATA ]
描述
CREATE MATERIALIZED VIEW定义一个查询的物化视图。
在该命令被发出时，查询会被执行并且被用来填充该视图（除非使用了
WITH NO DATA），并且后来可能会用
REFRESH MATERIALIZED VIEW进行刷新。
CREATE MATERIALIZED VIEW类似于
CREATE TABLE AS，不过它还会记住被用来初始化该视图的查询，
这样它可以在后来被命令刷新。一个物化视图有很多和表相同的属性，但是不支持
临时物化视图。
CREATE MATERIALIZED VIEW需要对用于物化视图的模式具有
CREATE权限。
参数IF NOT EXISTS
如果已经存在一个同名的物化视图时不要抛出错误。这种情况下会发出一个
提示。注意这不保证现有的物化视图与将要创建的物化视图相似。
table_name
要创建的物化视图的名称（可选地包含模式限定符）。该名称必须与同一模式中的任何其他关系（表、序列、索引、视图、物化视图或外部表）的名称不同。
column_name
新物化视图中的一个列名。如果没有提供列名，会从查询的输出列名中获取。
USING method
此可选子句指定用于存储新物化视图内容的表访问方法；该方法需要是TABLE类型的访问方法。
详细信息请参考 第 62 章。如果未指定此选项，则为新物化视图选择默认表访问方法。
详细信息请参考 default_table_access_method。
WITH ( storage_parameter [= value] [, ... ] )
这个子句为新的物化视图指定可选的存储参数，详见Storage Parameters在
CREATE TABLE文档中的更多信息。所有CREATE
TABLE支持的参数CREATE MATERIALIZED
VIEW也支持。
详见CREATE TABLE。
TABLESPACE tablespace_name
tablespace_name是
要把新物化视图创建在其中的表空间的名称。如果没有指定，
将查阅default_tablespace。
query
一个 SELECT、TABLE、
或 VALUES 命令。该查询将在安全受限的操作中运行；
特别是，调用那些自身创建临时表的函数将会失败。此外，在查询运行期间，
search_path 会临时更改为 pg_catalog, pg_temp。
WITH [ NO ] DATA
这个子句指定物化视图是否在创建时被填充。如果不是，该物化视图将被标记为
不可扫描并且在REFRESH
MATERIALIZED VIEW被使用前不能被查询。
兼容性
CREATE MATERIALIZED VIEW是一种
PostgreSQL扩展。
另见ALTER MATERIALIZED VIEW, CREATE TABLE AS, CREATE VIEW, DROP MATERIALIZED VIEW, REFRESH MATERIALIZED VIEW上一页 上一级 下一页CREATE LANGUAGE 起始页 CREATE OPERATOR
