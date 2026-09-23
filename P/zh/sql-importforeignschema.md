# IMPORT FOREIGN SCHEMA

IMPORT FOREIGN SCHEMA
版本：
纠错本页面
搜索
目录导航
❮
❯
IMPORT FOREIGN SCHEMAIMPORT FOREIGN SCHEMA — 从外部服务器导入表定义大纲
IMPORT FOREIGN SCHEMA remote_schema
[ { LIMIT TO | EXCEPT } ( table_name [, ...] ) ]
FROM SERVER server_name
INTO local_schema
[ OPTIONS ( option 'value' [, ... ] ) ]
描述
IMPORT FOREIGN SCHEMA 创建表示存在于
外部服务器上的表的外部表。新外部表将由发出该命令的用户所拥有，并且用
匹配远程表的正确的列定义和选项创建。
默认情况下，存在于外部服务器上一个特定模式中的所有表和视图都会被导入。
根据需要，表的列表可以被限制到一个指定的子集，或者可以排除特定的表。
新外部表都被创建在一个必须已经存在的目标模式中。
要使用 IMPORT FOREIGN SCHEMA，用户必须具有
USAGE 特权以及在目标模式上的
CREATE 特权。
参数remote_schema
要从哪个远程模式导入。一个远程模式的特定含义依赖于所使用的外部数据包装器。
LIMIT TO ( table_name [, ...] )
只导入匹配给定表名之一的外部表。外部模式中其他的表将被忽略。
EXCEPT ( table_name [, ...] )
把指定的外部表排除在导入之外。除了列在这里的表之外，外部模式
中存在的所有表都将被导入。
server_name
要从哪个外部服务器导入。
local_schema
被导入的外部表将创建在其中的模式。
OPTIONS ( option 'value' [, ...] )
要在导入期间使用的选项。允许使用的选项名称和值与每一个外部数据包装器
有关。
示例
从服务器film_server上的远程模式foreign_films
中导入表定义，把外部表创建在本地模式films中：
IMPORT FOREIGN SCHEMA foreign_films
FROM SERVER film_server INTO films;
同上，但是只导入两个表actors和
directors（如果存在）：
IMPORT FOREIGN SCHEMA foreign_films LIMIT TO (actors, directors)
FROM SERVER film_server INTO films;
兼容性
IMPORT FOREIGN SCHEMA命令符合
SQL标准，不过OPTIONS
子句是PostgreSQL的扩展。
另见CREATE FOREIGN TABLE, CREATE SERVER上一页 上一级 下一页GRANT 起始页 INSERT
