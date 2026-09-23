# dblink_get_pkey

dblink_get_pkey
版本：
纠错本页面
搜索
目录导航
❮
❯
dblink_get_pkeydblink_get_pkey — 返回一个关系的主键字段的位置和字段名称
大纲
dblink_get_pkey(text relname) returns setof dblink_pkey_results
描述
dblink_get_pkey提供关于本地数据库中一个关系的主键的信息。这有时有助于生成要发送到远程数据库的查询。
参数relname
一个本地关系的名称，例如foo或myschema.mytab。如果该名称是大小写混合的或包含特殊字符，则需要包括双引号，例如"FooBar"；如果没有引号，字符串将被折叠为小写形式。
返回值
为每个主键字段返回一行，如果该关系没有主键则不返回行。结果行类型被定义为：
CREATE TYPE dblink_pkey_results AS (position int, colname text);
position列值从 1 到 N；它是该字段在主键中的编号，而不是在表列中的编号。
示例
CREATE TABLE foobar (
f1 int,
f2 int,
f3 int,
PRIMARY KEY (f1, f2, f3)
);
CREATE TABLE
SELECT * FROM dblink_get_pkey('foobar');
position | colname
----------+---------
1 | f1
2 | f2
3 | f3
(3 rows)
上一页 上一级 下一页dblink_cancel_query 起始页 dblink_build_sql_insert
