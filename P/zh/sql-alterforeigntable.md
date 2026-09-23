# ALTER FOREIGN TABLE

ALTER FOREIGN TABLE
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER FOREIGN TABLEALTER FOREIGN TABLE — 更改外部表的定义大纲
ALTER FOREIGN TABLE [ IF EXISTS ] [ ONLY ] name [ * ]
action [, ... ]
ALTER FOREIGN TABLE [ IF EXISTS ] [ ONLY ] name [ * ]
RENAME [ COLUMN ] column_name TO new_column_name
ALTER FOREIGN TABLE [ IF EXISTS ] name
RENAME TO new_name
ALTER FOREIGN TABLE [ IF EXISTS ] name
SET SCHEMA new_schema
其中 action 是以下之一：
ADD [ COLUMN ] column_name data_type [ COLLATE collation ] [ column_constraint [ ... ] ]
DROP [ COLUMN ] [ IF EXISTS ] column_name [ RESTRICT | CASCADE ]
ALTER [ COLUMN ] column_name [ SET DATA ] TYPE data_type [ COLLATE collation ]
ALTER [ COLUMN ] column_name SET DEFAULT expression
ALTER [ COLUMN ] column_name DROP DEFAULT
ALTER [ COLUMN ] column_name { SET | DROP } NOT NULL
ALTER [ COLUMN ] column_name SET STATISTICS integer
ALTER [ COLUMN ] column_name SET ( attribute_option = value [, ... ] )
ALTER [ COLUMN ] column_name RESET ( attribute_option [, ... ] )
ALTER [ COLUMN ] column_name SET STORAGE { PLAIN | EXTERNAL | EXTENDED | MAIN | DEFAULT }
ALTER [ COLUMN ] column_name OPTIONS ( [ ADD | SET | DROP ] option ['value'] [, ... ])
ADD table_constraint [ NOT VALID ]
VALIDATE CONSTRAINT constraint_name
DROP CONSTRAINT [ IF EXISTS ]  constraint_name [ RESTRICT | CASCADE ]
DISABLE TRIGGER [ trigger_name | ALL | USER ]
ENABLE TRIGGER [ trigger_name | ALL | USER ]
ENABLE REPLICA TRIGGER trigger_name
ENABLE ALWAYS TRIGGER trigger_name
SET WITHOUT OIDS
INHERIT parent_table
NO INHERIT parent_table
OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
OPTIONS ( [ ADD | SET | DROP ] option ['value'] [, ... ])
描述
ALTER FOREIGN TABLE 更改现有外部表的定义。
有几种子形式：
ADD COLUMN
这种形式向外部表添加一个新列，使用与
CREATE FOREIGN TABLE 相同的语法。
与向常规表添加列的情况不同，底层存储不会发生任何变化：
此操作仅声明某个新列现在可以通过外部表访问。
DROP COLUMN [ IF EXISTS ]
这种形式从外部表中删除一个列。
如果表外的任何内容依赖于该列，则需要指定 CASCADE；
例如，视图。
如果指定了 IF EXISTS 并且该列不存在，则不会抛出错误。
在这种情况下，会发出通知。
SET DATA TYPE
这种形式更改外部表中列的类型。
同样，这对任何底层存储没有影响：此操作仅更改
PostgreSQL 认为该列的类型。
SET/DROP DEFAULT
这些形式设置或移除列的默认值。
默认值仅适用于后续的 INSERT
或 UPDATE 命令；它们不会导致表中已存在的行发生变化。
SET/DROP NOT NULL
标记列为允许或不允许 NULL 值。
SET STATISTICS
这种形式设置每列的统计信息收集目标，以便后续
ANALYZE 操作。
有关更多详细信息，请参见 ALTER TABLE 的类似形式。
SET ( attribute_option = value [, ... ] )RESET ( attribute_option [, ... ] )
这种形式设置或重置每个属性选项。
有关更多详细信息，请参见 ALTER TABLE 的类似形式。
SET STORAGE
这种形式设置列的存储模式。
有关更多详细信息，请参见 ALTER TABLE 的类似形式。
请注意，存储模式没有影响，除非表的外部数据包装器选择关注它。
ADD table_constraint [ NOT VALID ]
这种形式向外部表添加一个新约束，使用与
CREATE FOREIGN TABLE 相同的语法。
目前仅支持 CHECK 和 NOT NULL 约束。
与向常规表添加约束的情况不同，没有任何操作来验证约束是否正确；
相反，此操作仅声明某个新条件应被假定为对外部表中的所有行成立。
（请参见 CREATE FOREIGN TABLE 中的讨论。）
如果约束被标记为 NOT VALID（仅允许用于 CHECK 情况），
则不假定它成立，而只是记录以备将来使用。
VALIDATE CONSTRAINT
这种形式将先前标记为 NOT VALID 的约束标记为有效。
不会采取任何措施来验证约束，但将假定未来的查询成立。
DROP CONSTRAINT [ IF EXISTS ]
此形式删除外部表上指定的约束。
如果指定了 IF EXISTS 并且约束
不存在，则不会抛出错误。
在这种情况下，会发出通知。
DISABLE/ENABLE [ REPLICA | ALWAYS ] TRIGGER
这些形式配置属于外部表的触发器的触发。
有关更多详细信息，请参见 ALTER TABLE 的类似形式。
SET WITHOUT OIDS
用于删除 oid 系统列的向后兼容语法。
由于 oid 系统列不能再添加，因此这永远不会产生效果。
INHERIT parent_table
此形式将目标外部表作为指定父表的新子表添加。
有关更多详细信息，请参见 ALTER TABLE 的类似形式。
NO INHERIT parent_table
此形式将目标外部表从指定父表的子表列表中移除。
OWNER
此形式将外部表的拥有者更改为指定用户。
OPTIONS ( [ ADD | SET | DROP ] option ['value'] [, ... ] )
更改外部表或其某一列的选项。
ADD、SET 和 DROP
指定要执行的操作。如果没有明确指定操作，则假定为 ADD。
不允许重复的选项名称（尽管表选项和列选项可以具有相同的名称）。
选项名称和值也会使用外部数据包装库进行验证。
RENAME
RENAME 形式更改外部表的名称
或外部表中单个列的名称。
SET SCHEMA
此形式将外部表移动到另一个模式中。
所有除了RENAME和SET SCHEMA的
动作都能被整合到一个多修改列表以便能被并行应用。例如，可以在一个
命令中增加几个列并且/或者修改几个列的类型。
如果该命令被写作ALTER FOREIGN TABLE IF EXISTS ...并且
该外部表不存在，则不会抛出错误。这种情况下会发出一个提示。
您必须拥有该表才能使用ALTER FOREIGN TABLE。
要更改外部表的模式，您还必须对新模式具有
CREATE权限。
要更改所有者，您必须能够SET ROLE为新的所有者角色，
并且该角色必须对表的模式具有CREATE权限。
（这些限制确保更改所有者不会执行您通过删除和重新创建表
无法完成的操作。然而，超级用户仍然可以更改任何表的所有权。）
要添加列或更改列类型，您还必须对数据类型具有
USAGE权限。
参数name
一个要修改的现有外部表的名称（可以被模式限定）。如果在表名前指定了
ONLY，则只有该表被修改。如果没有指定ONLY，
该表和它所有的后代表（如果有）都会被修改。可选地，在表名后面指定
*可以显式地表示将后代表包括在内。
column_name
一个新的或现有列的名称。
new_column_name
一个现有列的新名称。
new_name
该表的新名称。
data_type
新列的数据类型，或者一个现有列的新数据类型。
table_constraint
外部表的新表约束。
constraint_name
要删除的现有约束的名称。
CASCADE
自动删除依赖于被删除列或约束的对象（例如，引用该列的视图），
并且接着删除依赖于那些对象的所有对象（见第 5.15 节）。
RESTRICT
如果有任何依赖对象就拒绝删除该列或约束。这是默认行为。
trigger_name
要禁用或启用的一个触发器的名称。
ALL
禁用或启用所有属于该外部表的触发器（如果任何触发器是内部生成
的触发器，这都要求超级用户特权。核心系统不会向外部表增加这类触发
器，但是附加代码会这样做。）。
USER
禁用或启用属于该外部表的除了内部生成的触发器之外的所有触发器。
parent_table
要与这个外部表关联或解除关联的父表。
new_owner
该表的新拥有者的用户名。
new_schema
该表要被移动到其中的模式的名称。
Notes
关键词COLUMN是噪声词，可以被忽略。
当使用ADD COLUMN或
DROP COLUMN增加或移除一列、增加一个NOT NULL
或CHECK
约束，或者用SET DATA TYPE更改列类型时，不会检查与外部服务器的一
致性。确保该表定义匹配远端是用户的责任。
关于有效参数的进一步描述可参考CREATE FOREIGN TABLE。
示例
要把一列标记为非空：
ALTER FOREIGN TABLE distributors ALTER COLUMN street SET NOT NULL;
要更改外部表的选项：
ALTER FOREIGN TABLE myschema.distributors OPTIONS (ADD opt1 'value', SET opt2 'value2', DROP opt3);
兼容性
形式ADD、DROP以及
SET DATA TYPE符合 SQL 标准。其他形式是 SQL 标准的
PostgreSQL扩展。在一个
ALTER FOREIGN TABLE命令中指定多个操作也是一种扩展。
ALTER FOREIGN TABLE DROP COLUMN可以被用来删除
一个外部表的唯一一列，从而留下一个零列的表。这是一种 SQL 的扩展，它
不允许零列的外部表。
另请参阅CREATE FOREIGN TABLE, DROP FOREIGN TABLE上一页 上一级 下一页ALTER FOREIGN DATA WRAPPER 起始页 ALTER FUNCTION
