# ALTER INDEX

ALTER INDEX
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER INDEXALTER INDEX — 更改索引的定义大纲
ALTER INDEX [ IF EXISTS ] name RENAME TO new_name
ALTER INDEX [ IF EXISTS ] name SET TABLESPACE tablespace_name
ALTER INDEX name ATTACH PARTITION index_name
ALTER INDEX name [ NO ] DEPENDS ON EXTENSION extension_name
ALTER INDEX [ IF EXISTS ] name SET ( storage_parameter [= value] [, ... ] )
ALTER INDEX [ IF EXISTS ] name RESET ( storage_parameter [, ... ] )
ALTER INDEX [ IF EXISTS ] name ALTER [ COLUMN ] column_number
SET STATISTICS integer
ALTER INDEX ALL IN TABLESPACE name [ OWNED BY role_name [, ... ] ]
SET TABLESPACE new_tablespace [ NOWAIT ]
描述
ALTER INDEX更改现有索引的定义。以下描述了几种子形式。
请注意，每种子形式所需的锁级别可能不同。除非明确说明，否则会持有
ACCESS EXCLUSIVE锁。当列出多个子命令时，所持有的锁
将是任何子命令所需的最严格的锁。
RENAME
RENAME形式更改索引的名称。如果索引与表约束相关联
（例如UNIQUE、PRIMARY KEY或
EXCLUDE），则约束也会被重命名。这对存储的数据
没有影响。
重命名索引会获取一个SHARE UPDATE EXCLUSIVE
锁。
SET TABLESPACE
此形式将索引的表空间更改为指定的表空间，并将与索引关联的
数据文件移动到新的表空间。要更改索引的表空间，您必须拥有该
索引并具有新表空间的CREATE权限。
可以使用ALL IN TABLESPACE形式移动当前数据库
中表空间内的所有索引，该形式将锁定所有要移动的索引，然后逐
一移动。此形式还支持OWNED BY，它将仅移动由
指定角色拥有的索引。如果指定了NOWAIT选项，
则如果无法立即获取所需的所有锁，该命令将失败。请注意，系统
目录不会通过此命令移动，如果需要，请使用ALTER DATABASE
或显式的ALTER INDEX调用。
另请参见
CREATE TABLESPACE。
ATTACH PARTITION index_name
使指定的索引（可能包含模式限定）附加到被修改的索引上。
指定的索引必须位于包含被修改索引的表的分区上，并且具有等效的定义。
附加的索引不能单独删除，如果其父索引被删除，它将自动被删除。
DEPENDS ON EXTENSION extension_nameNO DEPENDS ON EXTENSION extension_name
此形式将索引标记为依赖于扩展，或者如果指定了NO，则不再
依赖于该扩展。标记为依赖于扩展的索引会在扩展被删除时自动删除。
SET ( storage_parameter [= value] [, ... ] )
此形式更改一个或多个特定于索引方法的存储参数。请参阅
CREATE INDEX
了解可用参数的详细信息。请注意，此命令不会立即修改索引内容；
根据参数，您可能需要使用
REINDEX
重建索引以获得所需的效果。
RESET ( storage_parameter [, ... ] )
此形式将一个或多个索引方法特定的存储参数重置为其默认值。与
SET一样，可能需要一个REINDEX来完全更新索引。
ALTER [ COLUMN ] column_number SET STATISTICS integer
此形式为后续的ANALYZE操作设置每列的统计
信息收集目标，但只能用于定义为表达式的索引列。由于表达式缺乏唯一名称，我们通过索引列
的序号来引用它们。
目标可以设置在0到10000的范围内；或者，将其设置为-1以恢复为使用系统默认的统计目标
(default_statistics_target)。
有关PostgreSQL查询规划器使用统计信息的更多信息，请参阅
第 14.2 节。
参数IF EXISTS
如果该索引不存在，不要抛出错误。这种情况下将发出一个提示。
column_number
引用该索引列的顺序（从左往右）位置的顺序号。
name
要更改的一个现有索引的名称（可能被模式限定）。
new_name
该索引的新名称。
tablespace_name
该索引将被移动到的表空间。
extension_name
该索引所依赖的扩展的名称。
storage_parameter
一个索引方法特定的存储参数的名称。
value
一个索引方法特定的存储参数的新值。根据该参数，这可能是一个数字或一个
词。
注释
也可以用ALTER TABLE来做这些操作。实际上，
ALTER INDEX只是ALTER TABLE应用在索引
上的形式的别名而已。
以前有一种ALTER INDEX OWNER变体，但现在已被忽略（会出现
一个警告）。一个索引的拥有者不能与其表的拥有者不同。更改表的拥有者
会自动地更改索引的拥有者。
不允许更改系统目录索引的任何部分。
示例
要重命名一个现有索引：
ALTER INDEX distributors RENAME TO suppliers;
将一个索引移动到一个不同的表空间：
ALTER INDEX distributors SET TABLESPACE fasttablespace;
更改一个索引的填充因子（假设该索引方法支持它）：
ALTER INDEX distributors SET (fillfactor = 75);
REINDEX INDEX distributors;
为一个表达式索引设置统计信息收集目标：
CREATE INDEX coord_idx ON measured (x, y, (z + t));
ALTER INDEX coord_idx ALTER COLUMN 3 SET STATISTICS 1000;
兼容性
ALTER INDEX是一种
PostgreSQL扩展。
另请参阅CREATE INDEX, REINDEX上一页 上一级 下一页ALTER GROUP 起始页 ALTER LANGUAGE
