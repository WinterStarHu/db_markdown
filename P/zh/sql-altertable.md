# ALTER TABLE

ALTER TABLE
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER TABLEALTER TABLE — 更改表的定义大纲
ALTER TABLE [ IF EXISTS ] [ ONLY ] name [ * ]
action [, ... ]
ALTER TABLE [ IF EXISTS ] [ ONLY ] name [ * ]
RENAME [ COLUMN ] column_name TO new_column_name
ALTER TABLE [ IF EXISTS ] [ ONLY ] name [ * ]
RENAME CONSTRAINT constraint_name TO new_constraint_name
ALTER TABLE [ IF EXISTS ] name
RENAME TO new_name
ALTER TABLE [ IF EXISTS ] name
SET SCHEMA new_schema
ALTER TABLE ALL IN TABLESPACE name [ OWNED BY role_name [, ... ] ]
SET TABLESPACE new_tablespace [ NOWAIT ]
ALTER TABLE [ IF EXISTS ] name
ATTACH PARTITION partition_name { FOR VALUES partition_bound_spec | DEFAULT }
ALTER TABLE [ IF EXISTS ] name
DETACH PARTITION partition_name [ CONCURRENTLY | FINALIZE ]
其中 action 是以下之一：
ADD [ COLUMN ] [ IF NOT EXISTS ] column_name data_type [ COLLATE collation ] [ column_constraint [ ... ] ]
DROP [ COLUMN ] [ IF EXISTS ] column_name [ RESTRICT | CASCADE ]
ALTER [ COLUMN ] column_name [ SET DATA ] TYPE data_type [ COLLATE collation ] [ USING expression ]
ALTER [ COLUMN ] column_name SET DEFAULT expression
ALTER [ COLUMN ] column_name DROP DEFAULT
ALTER [ COLUMN ] column_name { SET | DROP } NOT NULL
ALTER [ COLUMN ] column_name SET EXPRESSION AS ( expression )
ALTER [ COLUMN ] column_name DROP EXPRESSION [ IF EXISTS ]
ALTER [ COLUMN ] column_name ADD GENERATED { ALWAYS | BY DEFAULT } AS IDENTITY [ ( sequence_options ) ]
ALTER [ COLUMN ] column_name { SET GENERATED { ALWAYS | BY DEFAULT } | SET sequence_option | RESTART [ [ WITH ] restart ] } [...]
ALTER [ COLUMN ] column_name DROP IDENTITY [ IF EXISTS ]
ALTER [ COLUMN ] column_name SET STATISTICS { integer | DEFAULT }
ALTER [ COLUMN ] column_name SET ( attribute_option = value [, ... ] )
ALTER [ COLUMN ] column_name RESET ( attribute_option [, ... ] )
ALTER [ COLUMN ] column_name SET STORAGE { PLAIN | EXTERNAL | EXTENDED | MAIN | DEFAULT }
ALTER [ COLUMN ] column_name SET COMPRESSION compression_method
ADD table_constraint [ NOT VALID ]
ADD table_constraint_using_index
ALTER CONSTRAINT constraint_name [ DEFERRABLE | NOT DEFERRABLE ] [ INITIALLY DEFERRED | INITIALLY IMMEDIATE ] [ ENFORCED | NOT ENFORCED ]
ALTER CONSTRAINT constraint_name [ INHERIT | NO INHERIT ]
VALIDATE CONSTRAINT constraint_name
DROP CONSTRAINT [ IF EXISTS ]  constraint_name [ RESTRICT | CASCADE ]
DISABLE TRIGGER [ trigger_name | ALL | USER ]
ENABLE TRIGGER [ trigger_name | ALL | USER ]
ENABLE REPLICA TRIGGER trigger_name
ENABLE ALWAYS TRIGGER trigger_name
DISABLE RULE rewrite_rule_name
ENABLE RULE rewrite_rule_name
ENABLE REPLICA RULE rewrite_rule_name
ENABLE ALWAYS RULE rewrite_rule_name
DISABLE ROW LEVEL SECURITY
ENABLE ROW LEVEL SECURITY
FORCE ROW LEVEL SECURITY
NO FORCE ROW LEVEL SECURITY
CLUSTER ON index_name
SET WITHOUT CLUSTER
SET WITHOUT OIDS
SET ACCESS METHOD { new_access_method | DEFAULT }
SET TABLESPACE new_tablespace
SET { LOGGED | UNLOGGED }
SET ( storage_parameter [= value] [, ... ] )
RESET ( storage_parameter [, ... ] )
INHERIT parent_table
NO INHERIT parent_table
OF type_name
NOT OF
OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
REPLICA IDENTITY { DEFAULT | USING INDEX index_name | FULL | NOTHING }
并且 partition_bound_spec 是：
IN ( partition_bound_expr [, ...] ) |
FROM ( { partition_bound_expr | MINVALUE | MAXVALUE } [, ...] )
TO ( { partition_bound_expr | MINVALUE | MAXVALUE } [, ...] ) |
WITH ( MODULUS numeric_literal, REMAINDER numeric_literal )
并且 column_constraint 是：
[ CONSTRAINT constraint_name ]
{ NOT NULL [ NO INHERIT ] |
NULL |
CHECK ( expression ) [ NO INHERIT ] |
DEFAULT default_expr |
GENERATED ALWAYS AS ( generation_expr ) [ STORED | VIRTUAL ] |
GENERATED { ALWAYS | BY DEFAULT } AS IDENTITY [ ( sequence_options ) ] |
UNIQUE [ NULLS [ NOT ] DISTINCT ] index_parameters |
PRIMARY KEY index_parameters |
REFERENCES reftable [ ( refcolumn ) ] [ MATCH FULL | MATCH PARTIAL | MATCH SIMPLE ]
[ ON DELETE referential_action ] [ ON UPDATE referential_action ] }
[ DEFERRABLE | NOT DEFERRABLE ] [ INITIALLY DEFERRED | INITIALLY IMMEDIATE ] [ ENFORCED | NOT ENFORCED ]
并且 table_constraint 是：
[ CONSTRAINT constraint_name ]
{ CHECK ( expression ) [ NO INHERIT ] |
NOT NULL column_name [ NO INHERIT ] |
UNIQUE [ NULLS [ NOT ] DISTINCT ] ( column_name [, ... ] [, column_name WITHOUT OVERLAPS ] ) index_parameters |
PRIMARY KEY ( column_name [, ... ] [, column_name WITHOUT OVERLAPS ] ) index_parameters |
EXCLUDE [ USING index_method ] ( exclude_element WITH operator [, ... ] ) index_parameters [ WHERE ( predicate ) ] |
FOREIGN KEY ( column_name [, ... ] [, PERIOD column_name ] ) REFERENCES reftable [ ( refcolumn [, ... ]  [, PERIOD refcolumn ] ) ]
[ MATCH FULL | MATCH PARTIAL | MATCH SIMPLE ] [ ON DELETE referential_action ] [ ON UPDATE referential_action ] }
[ DEFERRABLE | NOT DEFERRABLE ] [ INITIALLY DEFERRED | INITIALLY IMMEDIATE ] [ ENFORCED | NOT ENFORCED ]
并且 table_constraint_using_index 是：
[ CONSTRAINT constraint_name ]
{ UNIQUE | PRIMARY KEY } USING INDEX index_name
[ DEFERRABLE | NOT DEFERRABLE ] [ INITIALLY DEFERRED | INITIALLY IMMEDIATE ]
index_parameters 在 UNIQUE, PRIMARY KEY, 并且 EXCLUDE 约束中为：
[ INCLUDE ( column_name [, ... ] ) ]
[ WITH ( storage_parameter [= value] [, ... ] ) ]
[ USING INDEX TABLESPACE tablespace_name ]
exclude_element 在 EXCLUDE 约束中是：
{ column_name | ( expression ) } [ COLLATE collation ] [ opclass [ ( opclass_parameter = value [, ... ] ) ] ] [ ASC | DESC ] [ NULLS { FIRST | LAST } ]
referential_action 在 FOREIGN KEY/REFERENCES 约束中是：
{ NO ACTION | RESTRICT | CASCADE | SET NULL [ ( column_name [, ... ] ) ] | SET DEFAULT [ ( column_name [, ... ] ) ] }
描述
ALTER TABLE更改现有表的定义。以下描述了几种子形式。
请注意，每种子形式所需的锁级别可能不同。除非明确说明，否则会获取
ACCESS EXCLUSIVE锁。当提供多个子命令时，获取的锁
将是任何子命令所需的最严格的锁。
ADD COLUMN [ IF NOT EXISTS ] #
这个表单使用与CREATE TABLE相同的语法向表中添加新列。
如果指定了IF NOT EXISTS，并且已经存在具有该名称的列，
则不会抛出错误。
DROP COLUMN [ IF EXISTS ] #
这个表单从表中删除一列。涉及该列的索引和表约束也将被自动删除。
如果删除列会导致多变量统计引用的列被移除，那么这些统计数据也将被移除，
因为统计数据只包含单列数据。
如果表外有任何依赖于该列的内容，例如外键引用或视图，您需要使用CASCADE。
如果指定了IF EXISTS，并且该列不存在，则不会抛出错误。在这种情况下，会发出通知。
SET DATA TYPE #
这个表单改变了表的一列的类型。涉及该列的索引和简单的表约束将自动转换为使用新的列类型，通过重新解析最初提供的表达式。
可选的COLLATE子句指定新列的排序规则；如果省略，则排序规则为新列类型的默认值。
可选的USING子句指定如何从旧值计算新列的值；如果省略，则默认转换与从旧数据类型到新数据类型的赋值转换相同。
如果从旧类型到新类型没有隐式或赋值转换，则必须提供USING子句。
当使用此形式时，列的统计信息将被移除，
因此建议在之后对表运行 ANALYZE
。对于虚拟生成列，ANALYZE
是不必要的，因为此类列从不具有统计信息。
SET/DROP DEFAULT #
这些形式设置或删除列的默认值（其中删除等同于将默认值设置为 NULL）。新的默认值仅适用于后续的 INSERT 或 UPDATE 命令；它不会导致表中已经存在的行发生变化。
SET/DROP NOT NULL #
这些形式改变了列是否标记为允许空值或拒绝空值。
SET NOT NULL 只能应用于列，
前提是表中的记录没有包含该列的
NULL 值。通常在 ALTER TABLE 期间会通过扫描
整个表来检查这一点，除非指定了 NOT VALID；
然而，如果存在有效的 CHECK 约束
（并且在同一命令中没有被删除），证明没有
NULL 可以存在，则跳过表扫描。
如果列具有无效的非空约束，
SET NOT NULL 将验证它。
如果该表是一个分区，则如果在父表中标记为
NOT NULL，则无法对列执行 DROP NOT NULL。
要从所有分区中删除 NOT NULL 约束，请在父表上执行
DROP NOT NULL。即使父表上没有 NOT NULL 约束，
仍然可以根据需要将此类约束添加到各个分区；也就是说，子表可以禁止 NULL，即使父表允许它们，但反之则不行。
还可以仅从父表中删除 NOT NULL 约束，这不会从子表中删除它。
SET EXPRESSION AS #
此形式替换生成列的表达式。存储生成列中的现有数据
将被重写，所有未来的更改将应用新的生成表达式。
当此形式用于存储生成列时，其统计信息
将被移除，因此建议在之后对表运行
ANALYZE
。对于虚拟生成列，ANALYZE
是不必要的，因为此类列从不具有统计信息。
DROP EXPRESSION [ IF EXISTS ] #
此形式将一个存储生成列转换为普通的基本列。列中的现有数据将被保留，
但以后的更改将不再应用生成表达式。
此形式目前仅支持存储生成列（不支持虚拟列）。
如果指定了 DROP EXPRESSION IF EXISTS 并且
列不是生成列，则不会抛出错误。在这种情况下，将发出通知。
ADD GENERATED { ALWAYS | BY DEFAULT } AS IDENTITYSET GENERATED { ALWAYS | BY DEFAULT }DROP IDENTITY [ IF EXISTS ] #
这些形式会改变列是否为标识列，或更改现有标识列的生成属性。
详细信息请参见CREATE TABLE。
与SET DEFAULT类似，这些形式仅影响后续INSERT
和UPDATE命令的行为；它们不会导致表中已有的行发生变化。
如果指定了DROP IDENTITY IF EXISTS，并且该列不是标识列，则不会抛出错误。
在这种情况下，会发出一条通知。
SET sequence_optionRESTART #
这些形式改变了现有标识列下面的序列。sequence_option是
ALTER SEQUENCE支持的一个选项，
比如INCREMENT BY。
SET STATISTICS #
此形式设置后续ANALYZE操作的每列统计收集目标。
目标可以设置在0到10000的范围内。将其设置为DEFAULT以恢复使用系统默认统计目标
(default_statistics_target)。
（设置为-1的值是获取相同结果的过时写法。）
有关PostgreSQL查询规划器使用统计信息的更多信息，请参阅
第 14.2 节。
SET STATISTICS获取一个SHARE UPDATE EXCLUSIVE锁。
SET ( attribute_option = value [, ... ] )RESET ( attribute_option [, ... ] ) #
此形式设置或重置每个属性选项。目前，唯一
定义的每个属性选项是 n_distinct 和
n_distinct_inherited，它们覆盖后续
ANALYZE
操作所做的不同值数量估计。n_distinct 影响表本身的统计信息，
而 n_distinct_inherited 影响为表及其继承子表收集的统计信息，以及
为分区表收集的统计信息。当指定的值
是正值时，查询规划器将假设该列包含确切数量的不同非空值。
还可以通过使用小于 0 且大于或等于 -1 的值来指定分数值。
这指示查询规划器通过将指定数量的绝对值乘以表中估计的行数来估算不同值的数量。
例如，值 -1 表示列中的所有值都是不同的，而值 -0.5 表示每个值平均出现两次。
这在表的大小随时间变化时可能很有用。有关查询规划器使用统计信息的更多信息，请参见
第 14.2 节。
更改每个属性选项会获取一个SHARE UPDATE EXCLUSIVE锁。
SET STORAGE { PLAIN | EXTERNAL | EXTENDED | MAIN | DEFAULT }
#
此形式设置列的存储模式。这控制了该列是内联存储还是在一个次级
TOAST表中存储，以及数据是否应该被压缩。
PLAIN必须用于固定长度的值，例如integer，
并且是内联的、未压缩的。MAIN用于内联的、可压缩的数据。
EXTERNAL用于外部的、未压缩的数据，而EXTENDED
用于外部的、压缩的数据。
写入DEFAULT会将存储模式设置为列数据类型的默认模式。
对于支持非PLAIN存储的大多数数据类型，
EXTENDED是默认值。
使用EXTERNAL会使对非常大的text和
bytea值的子字符串操作运行得更快，但代价是增加了存储空间。
请注意，ALTER TABLE ... SET STORAGE本身不会更改表中的任何内容；
它只是设置了在未来表更新期间要采用的策略。
有关更多信息，请参见第 66.2 节。
SET COMPRESSION compression_method
#
此形式设置列的压缩方法，确定将来插入的值将如何被压缩（如果存储模式允许压缩）。
这不会导致表被重写，因此现有数据仍然可以用其他压缩方法进行压缩。
如果使用pg_restore还原表，那么所有值都将使用配置的压缩方法重新写入。
然而，当从另一个关系插入数据时（例如，通过INSERT ... SELECT），源表中的值不一定会被解压缩，因此任何先前压缩的数据可能会保留其现有的压缩方法，而不是使用目标列的压缩方法重新压缩。
支持的压缩方法有pglz和lz4。
（lz4仅在构建PostgreSQL时使用了--with-lz4才可用。）此外，compression_method可以是default，它选择了在数据插入时咨询default_toast_compression设置以确定要使用的方法的默认行为。
ADD table_constraint [ NOT VALID ] #
此形式使用与 CREATE TABLE 相同的约束语法向表添加新约束，
以及当前仅允许用于外键、CHECK 和非空约束的选项 NOT VALID。
通常，此形式将导致扫描表以验证表中所有现有行是否满足新约束。
但是，如果使用了 NOT VALID 选项，则跳过此潜在的长时间扫描。
该约束仍将应用于后续的插入或更新（即，除非在引用表中存在匹配行，否则它们将失败，
在外键的情况下，或者除非新行满足指定的检查条件，否则它们将失败）。
但是，数据库不会假设该约束对表中的所有行都成立，直到通过使用 VALIDATE
CONSTRAINT 选项进行验证。
有关使用 NOT VALID 选项的更多信息，请参见下面的 Notes。
虽然大多数形式的ADD
table_constraint
需要一个ACCESS EXCLUSIVE锁，ADD
FOREIGN KEY只需要一个SHARE ROW
EXCLUSIVE锁。请注意，ADD FOREIGN KEY
还会在引用的表上获取一个SHARE ROW EXCLUSIVE锁，除了在声明约束的表上获取的锁之外。
当向分区表添加唯一或主键约束时，适用额外限制；请参见 CREATE TABLE。
ADD table_constraint_using_index #
这个表单基于现有的唯一索引向表中添加一个新的PRIMARY KEY或UNIQUE约束。
约束将包括索引的所有列。
索引不能有表达式列，也不能是部分索引。此外，它必须是具有默认排序顺序的b-tree索引。
这些限制确保索引等效于通过常规ADD PRIMARY KEY或ADD UNIQUE命令构建的索引。
如果指定了PRIMARY KEY，并且索引的列尚未标记为NOT NULL，
那么此命令将尝试对每个这样的列执行ALTER COLUMN SET NOT NULL。
这需要进行全表扫描以验证列不包含空值。在所有其他情况下，这是一个快速操作。
如果提供了约束名，则索引将被重命名以匹配约束名。否则，约束将被命名为与索引相同。
执行此命令后，索引将被约束所“拥有”，就像索引是由常规ADD PRIMARY KEY或ADD UNIQUE命令构建的一样。
特别是，删除约束将导致索引也消失。
这种形式目前不支持分区表。
注意
使用现有索引添加约束在需要添加新约束且不想长时间阻塞表更新的情况下非常有用。
为此，使用CREATE UNIQUE INDEX CONCURRENTLY创建索引，然后使用此语法将其转换为约束。
见下面的示例。
ALTER CONSTRAINT #
此形式修改先前创建的约束的属性。目前仅外键约束可以以这种方式进行修改，但请参见下文。
ALTER CONSTRAINT ... INHERITALTER CONSTRAINT ... NO INHERIT #
这些形式修改可继承的约束，使其变为不可继承，反之亦然。目前仅非空约束可以以这种方式进行修改。
除了改变约束的继承状态外，在将不可继承的约束标记为可继承的情况下，如果表有子表，则将向它们添加等效的约束。
如果在有子表的情况下将可继承的约束标记为不可继承，则子表上的相应约束将被标记为不再继承，但不会被删除。
VALIDATE CONSTRAINT #
此形式验证先前创建的外键、检查或非空约束，状态为 NOT VALID，通过扫描表以确保没有行不满足该约束。
如果约束被设置为 NOT ENFORCED，则会抛出错误。
如果约束已经标记为有效，则不会发生任何事情。
（请参见下面的 Notes 以了解此命令的有用性。）
这个命令获取一个SHARE UPDATE EXCLUSIVE锁。
DROP CONSTRAINT [ IF EXISTS ] #
这个表单删除表上指定的约束，以及约束下的任何索引。
如果指定了IF EXISTS并且约束不存在，则不会抛出错误。在这种情况下，会发出通知。
DISABLE/ENABLE [ REPLICA | ALWAYS ] TRIGGER #
这些形式配置了属于表的触发器的触发。
禁用的触发器仍然为系统所知，但在其触发事件发生时不会被执行。
（对于延迟触发器，启用状态在事件发生时检查，而不是在触发器函数实际执行时。）
可以禁用或启用指定名称的单个触发器，或表上的所有触发器，或仅用户触发器
（此选项排除内部生成的约束触发器，例如用于实现外键约束或可延迟的唯一性和排他性约束的触发器）。
禁用或启用内部生成的约束触发器需要超级用户权限；应谨慎进行，因为如果不执行触发器，则约束的完整性无法保证。
触发器触发机制也受配置变量session_replication_role的影响。
简单启用的触发器（默认）将在复制角色为“origin”（默认）或“local”时触发。
配置为ENABLE REPLICA的触发器只会在会话处于“replica”模式时触发，
而配置为ENABLE ALWAYS的触发器将在当前复制角色无关时触发。
这种机制的效果是，在默认配置中，触发器不会在副本上触发。这是有用的，因为如果在原始表上使用触发器来传播数据，
那么复制系统也会复制传播的数据；因此触发器不应该在副本上第二次触发，因为那会导致重复。然而，如果触发器用于
其他目的，比如创建外部警报，那么可能适合将其设置为ENABLE ALWAYS，以便在副本上也触发。
当该命令应用于分区表时，分区中对应的克隆触发器的状态也会被更新，除非指定了ONLY。
这个命令获取一个SHARE ROW EXCLUSIVE锁。
DISABLE/ENABLE [ REPLICA | ALWAYS ] RULE #
这些形式配置了属于表的重写规则的触发。
禁用的规则仍然为系统所知，但在查询重写期间不会应用。
语义与禁用/启用触发器相同。对于ON SELECT规则，此配置将被忽略，
这些规则始终会被应用，以确保视图在当前会话处于非默认复制角色时仍然正常工作。
规则触发机制也受配置变量session_replication_role的影响，类似于上面描述的触发器。
DISABLE/ENABLE ROW LEVEL SECURITY #
这些形式控制着属于表的行安全策略的应用。如果启用并且表没有任何策略，
那么将应用默认拒绝策略。请注意，即使行级安全已禁用，表仍然可以存在策略。
在这种情况下，策略将不会被应用，策略将被忽略。
另请参阅
CREATE POLICY。
NO FORCE/FORCE ROW LEVEL SECURITY #
这些形式控制了用户是表所有者时对表的行安全策略的应用。如果启用，当用户是表所有者时将应用行级安全策略。
如果禁用（默认情况下），则当用户是表所有者时不会应用行级安全。
另请参阅
CREATE POLICY。
CLUSTER ON #
这个表单选择了将来CLUSTER操作的默认索引。它实际上并不重新对表进行集簇。
更改集簇选项会获取一个SHARE UPDATE EXCLUSIVE锁。
SET WITHOUT CLUSTER #
这个命令从表中移除最近使用的
CLUSTER
索引规范。这会影响未来不指定索引的集簇操作。
更改集簇选项会获取一个SHARE UPDATE EXCLUSIVE锁。
SET WITHOUT OIDS #
向后兼容的语法，用于移除oid系统列。由于无法再添加oid系统列，因此这永远不会产生影响。
SET ACCESS METHOD #
此形式通过使用指定的访问方法重写表来更改表的访问方法；指定
DEFAULT 会选择设置为
default_table_access_method 配置参数的访问方法。
详见 第 62 章 了解更多信息。
应用于分区表时，没有数据需要重写，但之后创建的分区将默认使用给定的访问
方法，除非被USING子句覆盖。指定DEFAULT会移除之前的值，
导致未来的分区默认使用default_table_access_method。
SET TABLESPACE #
这个表单将表的表空间更改为指定的表空间，并将与表关联的数据文件移动到新的表空间。
表上的索引（如果有）不会被移动；但它们可以通过额外的SET TABLESPACE命令单独移动。
当应用于分区表时，不会移动任何内容，但之后使用CREATE TABLE PARTITION OF创建的任何分区将使用该表空间，
除非被TABLESPACE子句覆盖。
当前数据库中的所有表都可以通过使用ALL IN TABLESPACE形式来移动，
这将首先锁定要移动的所有表，然后逐个移动。此形式还支持OWNED BY，
它只会移动由指定角色拥有的表。如果指定了NOWAIT选项，
则如果无法立即获取所需的所有锁定，则命令将失败。请注意，系统目录不会被此命令移动；
如果需要，可以使用ALTER DATABASE或显式的ALTER TABLE调用。
information_schema关系不被视为系统目录的一部分，将被移动。
另请参阅CREATE TABLESPACE。
SET { LOGGED | UNLOGGED } #
这个表单将表从未记录更改为记录，反之亦然
(参见UNLOGGED）。它不能应用
到临时表。
这也会改变与表相关联的任何序列的持久性（用于标识或序列列）。然而，也可以单独改变这些序列的持久性。
此形式不支持分区表。
SET ( storage_parameter [= value] [, ... ] ) #
这个表单用于更改表的一个或多个存储参数。请参阅
Storage Parameters中的
CREATE TABLE文档
以获取有关可用参数的详细信息。请注意，此命令不会立即修改表内容；
根据参数，您可能需要重写表以获得所需的效果。
可以使用 VACUUM
FULL、CLUSTER或强制表重写的一种形式
的ALTER TABLE来执行此操作。
对于与规划器相关的参数，更改将在下次锁定表时生效，因此当前正在执行的查询不会受到影响。
SHARE UPDATE EXCLUSIVE 锁将被用于 fillfactor、toast 和 autovacuum 存储参数，
以及 planner 参数 parallel_workers。
RESET ( storage_parameter [, ... ] ) #
这个表单将一个或多个存储参数重置为它们的默认值。与 SET 一样，可能需要进行表重写来完全更新表。
INHERIT parent_table #
此形式将目标表添加为指定父表的新子表。随后，对父表的查询将包括目标表的记录。
要作为子表添加，目标表必须已经包含与父表相同的所有列（也可以有额外的列）。列的数据类型必须匹配。
此外，父表上的所有 CHECK 和 NOT NULL 约束也必须存在于子表上，除了那些标记为不可继承的（即使用 ALTER TABLE ... ADD CONSTRAINT ... NO INHERIT 创建的），这些将被忽略。
所有匹配的子表约束不得标记为不可继承。目前 UNIQUE、PRIMARY KEY 和 FOREIGN KEY 约束不被考虑，但这在未来可能会改变。
NO INHERIT parent_table #
这个表单将目标表从指定父表的子表列表中移除。
对父表的查询将不再包括来自目标表的记录。
OF type_name #
这个表单将表与一个复合类型链接起来，就好像 CREATE TABLE OF 已经形成了它。
表的列名和类型列表必须与复合类型的完全匹配。表不能继承自任何其他表。
这些限制确保 CREATE TABLE OF 将允许一个等效的表定义。
NOT OF #
这个表单将一个类型化表与其类型分离。
OWNER TO #
这个表单将表、序列、视图、物化视图或外部表的所有者更改为指定的用户。
REPLICA IDENTITY #
此形式更改写入预写日志的信息，以识别被更新或删除的行。
在大多数情况下，只有当每列的旧值与新值不同时，才会记录旧值；然而，如果旧值存储在外部，则无论是否更改，都会始终记录。
此选项在逻辑复制使用时才有效。
DEFAULT #
记录主键列的旧值。这是非系统表的默认值。
当没有主键时，行为与 NOTHING 相同。
USING INDEX index_name #
记录由命名索引覆盖的列的旧值，该索引必须是唯一的、非部分的、不可延迟的，并且仅包含标记为 NOT NULL 的列。如果此索引被删除，则行为与 NOTHING 相同。
FULL #
记录行中所有列的旧值。
NOTHING #
不记录关于旧行的任何信息。这是系统表的默认值。
RENAME #
RENAME表单用于更改表（或索引、序列、视图、物化视图或外部表）的名称，
表中单个列的名称，或表的约束的名称。重命名具有基础索引的约束时，索引也会被重命名。
存储的数据不受影响。
SET SCHEMA #
这个表单将表移动到另一个模式中。与表列相关的索引、约束和序列也将被移动。
ATTACH PARTITION partition_name { FOR VALUES partition_bound_spec | DEFAULT } #
这个形式将一个现有的表（可能本身已经被分区）作为目标表的一个分区附加上去。
可以使用FOR VALUES将表作为特定值的分区附加上去，
或者使用DEFAULT将其作为默认分区附加上去。
对于目标表中的每个索引，附加表中将创建一个相应的索引；
或者，如果已经存在等效的索引，则将其附加到目标表的索引上，
就像执行了ALTER INDEX ATTACH PARTITION一样。
请注意，如果现有表是一个外部表，当前不允许将该表作为目标表的分区附加上去，
如果目标表上有UNIQUE索引。（另请参见CREATE FOREIGN TABLE。）
对于目标表中存在的每个用户定义的行级触发器，将在附加表中创建一个相应的触发器。
使用FOR VALUES的分区对
partition_bound_spec使用与
CREATE TABLE相同的语法。
分区边界规范必须与目标表的分区策略和分区键相对应。
要附加的表必须具有与目标表完全相同的列，且不能多；此外，列的类型也必须匹配。
同时，它必须具有目标表的所有NOT NULL和
CHECK约束，且不能标记为NO INHERIT。
目前FOREIGN KEY约束不被考虑。
如果父表中不存在UNIQUE和PRIMARY KEY约束，
它们将在分区中创建。
如果新分区是一个常规表，将执行全表扫描以检查表中现有行是否违反分区约束。
可以通过向表添加一个有效的CHECK约束来避免此扫描，
该约束只允许满足所需分区约束的行在运行此命令之前。
CHECK约束将用于确定无需扫描表以验证分区约束。
但是，如果分区键中的任何一个是表达式，并且分区不接受NULL值，
则此方法不起作用。如果附加的列表分区不接受NULL值，
还需向分区键列添加NOT NULL约束，除非它是一个表达式。
如果新分区是一个外部表，不会对外部表中的所有行进行验证，以确保符合分区约束。
（参见CREATE FOREIGN TABLE中关于外部表约束的讨论。）
当表具有默认分区时，定义新分区会改变默认分区的分区约束。默认分区不能包含任何需要移动到新分区的行，并将扫描以验证是否存在这些行。
如果存在适当的CHECK约束，则可以避免这种扫描。与新分区的扫描一样，当默认分区是外部表时，总是跳过这种扫描。
附加分区会在父表上获取一个SHARE UPDATE EXCLUSIVE锁，
除了在被附加的表和默认分区（如果有）上获取ACCESS EXCLUSIVE锁。
如果要附加的表本身是分区表，则还必须在所有子分区上保持锁定。同样，如果默认
分区本身是分区表，则也必须保持锁定。
通过添加如在第 5.12.2.2 节中描述的CHECK约束，可以避免对子分区的锁定。
DETACH PARTITION partition_name [ CONCURRENTLY | FINALIZE ] #
这个表单会分离目标表的指定分区。被分离的分区将继续存在作为一个独立的表，但不再与它被分离的表有任何联系。
附加到目标表索引的任何索引都会被分离。创建为目标表克隆的任何触发器都会被移除。
在外键约束中引用这个分区表的任何表都会获得SHARE锁。
如果指定了CONCURRENTLY，它将使用降低的锁级别来避免阻塞可能正在访问分区表的其他会话。
在这种模式下，内部使用两个事务。在第一个事务期间，对父表和分区都采取SHARE UPDATE EXCLUSIVE锁，
并将分区标记为正在分离；在那一点上，事务被提交，并等待使用分区表的所有其他事务。
一旦所有这些事务都完成，第二个事务将在分区表上获取SHARE UPDATE EXCLUSIVE，
在分区上获取ACCESS EXCLUSIVE，并完成分离过程。
一个重复分区约束的CHECK约束被添加到分区中。
CONCURRENTLY不能在事务块中运行，如果分区表包含默认分区，则不允许运行。
如果指定了FINALIZE，则会完成之前被取消或中断的DETACH CONCURRENTLY调用。
分区表中最多只能有一个分区处于挂起的分离状态。
所有对单个表执行的 ALTER TABLE 形式，除了 RENAME、SET SCHEMA、ATTACH PARTITION 和 DETACH PARTITION，都可以组合成一个多个修改的列表一起应用。
例如，可以在一个命令中添加多个列和/或修改多个列的类型。这在处理大表时特别有用，因为只需对表进行一次遍历。
您必须拥有该表才能使用ALTER TABLE。
要更改表的模式或表空间，您还必须拥有新模式或表空间的
CREATE权限。
要将表作为父表的新子表添加，您还必须拥有父表的所有权。
同样，要将表作为表的新分区附加，您必须拥有被附加表的所有权。
要更改所有者，您必须能够SET ROLE为新的所有角色，
并且该角色必须拥有表模式的CREATE权限。
（这些限制确保更改所有者不会做任何您通过删除和重新创建表
无法完成的事情。然而，超级用户仍然可以更改任何表的所有权。）
要添加列、更改列类型或使用OF子句，您还必须拥有
数据类型的USAGE权限。
参数IF EXISTS #
如果表不存在则不要抛出一个错误。这种情况下会发出一个通知。
name #
要修改的一个现有表的名称（可以是模式限定的）。如果在表名前指定了
ONLY，则只会修改该表。如果没有指定ONLY，
该表及其所有后代表（如果有）都会被修改。可选地，在表名后面可以指定
*用来显式地指示包括后代表。
column_name #
新列或者现有列的名称。
new_column_name #
现有列的新名称。
new_name #
表的新名称。
data_type #
新列的数据类型，或者现有列的新数据类型。
table_constraint #
表的新约束。
constraint_name #
新约束或者现有约束的名称。
CASCADE #
自动删除依赖于被删除列或约束的对象（例如引用该列的视图），
并且接着删除依赖于那些对象的
所有对象（见第 5.15 节）。
RESTRICT #
如果有任何依赖对象时拒绝删除列或约束。这是默认行为。
trigger_name #
要禁用或启用的单个触发器的名称。
ALL #
禁用或启用属于表的所有触发器。
（如果任何触发器是内部生成的约束触发器，例如用于实现外键约束或可延迟唯一性和
排除性约束的触发器，则需要超级用户权限。）
USER #
禁用或启用表中除了内部生成的约束触发器之外的所有触发器，例如用于实现外键约束或
可延迟唯一性和排除性约束的触发器。
index_name #
现有索引的名称。
storage_parameter #
表存储参数的名称。
value #
表存储参数的新值。根据该参数，该值可能是一个数字或一个词。
parent_table #
要与这个表关联或解除关联的父表。
new_owner #
该表的新拥有者的用户名。
new_access_method #
将表转换为的访问方法的名称。
new_tablespace #
要把该表移入的表空间的名称。
new_schema #
要把该表移入的模式的名称。
partition_name #
要作为新分区附加到这个表或从这个表上分离的表的名称。
partition_bound_spec #
新分区的分区边界说明。更多细节请参考CREATE TABLE中相同的语法。
Notes
关键词COLUMN是噪声，可以省略。
当使用 ADD COLUMN 添加列并指定非易失性 DEFAULT 时，默认值在语句执行时被评估，并存储在表的元数据中，当访问任何现有行时将返回该值。
该值仅在表被重写时应用，使得即使在大表上， ALTER TABLE 也非常快速。
如果未指定列约束，则使用 NULL 作为 DEFAULT。在这两种情况下都不需要重写表。
添加具有易失性 DEFAULT（例如，clock_timestamp()）、存储生成列、身份列或具有约束的域数据类型的列将导致整个表及其索引被重写。
添加虚拟生成列从不需要重写。
更改现有列的类型通常会导致整个表及其索引被重写。
作为例外，当更改现有列的类型时，如果 USING 子句不更改列内容，并且旧类型可以二进制强制转换为新类型或是新类型的无约束域，则不需要重写表。
但是，除非系统能够验证新索引在逻辑上等同于现有索引，否则索引仍将被重建。例如，如果列的排序规则已更改，则需要重建索引，因为新的排序顺序可能不同。
然而，在没有排序规则更改的情况下，可以将列从 text 更改为 varchar（或反之）而无需重建索引，因为这些数据类型的排序是相同的。
对于大表，表和/或索引的重建可能需要相当长的时间，并且会暂时需要多达双倍的磁盘空间。
添加 CHECK 或 NOT NULL
约束需要扫描表以验证现有行是否满足该约束，但不需要重写表。
如果将 CHECK 约束添加为 NOT ENFORCED，
则不会执行验证。
类似地，在挂接一个新分区时，它可能需要被扫描以验证现有行满足该分区约束。
提供在一个ALTER TABLE中指定多个更改的选项的主要
原因就是多次表扫描或者重写可以因此被整合成一次。
扫描大型表以验证新的外键、检查或非空约束
可能需要很长时间，并且在 ALTER TABLE ADD CONSTRAINT
命令提交之前，其他对表的更新会被锁定。
NOT VALID 约束选项的主要目的是减少添加约束对
并发更新的影响。使用 NOT VALID 时，
ADD CONSTRAINT 命令不会扫描表
并且可以立即提交。之后，可以发出 VALIDATE
CONSTRAINT 命令以验证现有行是否满足约束。
验证步骤不需要锁定并发更新，因为它知道其他事务将
对它们插入或更新的行执行约束；只有
预先存在的行需要检查。因此，验证仅在被
修改的表上获取 SHARE UPDATE EXCLUSIVE 锁。
（如果约束是外键，则还需要在约束引用的表上获取
ROW SHARE 锁。）除了提高并发性外，
在已知表中存在预先违反的情况下，使用 NOT VALID
和 VALIDATE CONSTRAINT 也是有用的。
一旦约束到位，就不能插入新的违反，并且现有问题
可以在闲暇时纠正，直到 VALIDATE CONSTRAINT 最终
成功。
DROP COLUMN形式不会在物理上移除列，而只是简
单地让它对 SQL 操作不可见。后续该表中的插入和更新操作将为该列存储
一个空值。因此，删除一个列很快，但是它不会立刻减少表所占的磁盘空间，
因为被删除列所占用的空间还没有被回收。随着现有行被更新，空间将被逐渐
回收。
要强制立即回收被已删除列占据的空间，你可以执行一种能导致全表重写的
ALTER TABLE形式。这种形式会导致重新构造每一个把被
删除列替换为空值的行。
ALTER TABLE的重写形式对于 MVCC 是不安全的。
在一次表重写之后，如果并发事务使用的是一个在重写发生前取得的
快照，该表将对这些并发事务呈现出空表的形态。详见
第 13.6 节。
SET DATA TYPE的USING选项能实际指定
涉及该列旧值的任何表达式。也就是说，它不仅可以引用要被转换的列，
还可以引用其他列。这允许使用SET DATA TYPE语法完成十分
普遍的转换。由于这种灵活性，USING表达式不适合于列
的默认值（如果有），结果可能不是一个默认值所需的常量表达式。这意味着
在没有从旧类型到新类型的隐式或者赋值转换时，即便提供了一个
USING子句，SET DATA TYPE还是可能无法
转换默认值。在这种情况下，用DROP DEFAULT删除该默认值，
执行ALTER TYPE并且接着使用SET DEFAULT增加
一个合适的新默认值。类似的考虑也适用于涉及该列的索引和约束。
如果一个表有任何后代表，在不对后代表做相同操作的情况下，不允许在父表中增加列、重命名列或者更改列的类型。这确保了后代总是具有和父表匹配的列。类似地，如果不对所有后代上的CHECK约束进行重命名，就不能在父表中重命名该CHECK约束，这样CHECK约束也能在父表及其后代之间保持匹配（不过，这个限制不适用于基于索引的约束）。此外，因为从父表中选择也会从其后代中选择，父表上的约束不能被标记为有效，除非它在那些后代上也被标记为有效。在所有这些情况下，ALTER TABLE ONLY都将被拒绝。
只有当一个后代表的列不是从任何其他父表继承而来并且没有该列的独立定义时，
一次递归的DROP COLUMN操作才会移除该列。一次非递归
的DROP COLUMN（即
ALTER TABLE ONLY ... DROP COLUMN）不会移除
任何后代列，而是会把它们标记成独立定义的列。对于一个分区表，一个非递归的DROP COLUMN命令将会失败，因为一个表的所有分区都必须有和分区根节点相同的列。
对于标识列（ADD GENERATED，SET等），以及DROP IDENTITY等操作，
以及CLUSTER，OWNER和TABLESPACE等操作，永远不会递归到后代表；
也就是说，它们总是像指定了ONLY一样操作。
影响触发器状态的操作会递归到分区化表的分区（除非指定了ONLY），但永远不会递归到传统继承的后代表。
添加约束只会递归到未标记为NO INHERIT的CHECK约束。
不允许更改系统目录表的任何部分。
可用参数的进一步描述请见CREATE TABLE。
第 5 章中有关于继承的更多信息。
示例
要向一个表增加一个类型为varchar的列：
ALTER TABLE distributors ADD COLUMN address varchar(30);
这将导致表中所有现有行都用新列的空值填充。
要添加默认值为非空的列：
ALTER TABLE measurements
ADD COLUMN mtime timestamp with time zone DEFAULT now();
现有行将以当前时间填充为新列的值，然后新行将使用其插入时间。
要添加一列并用不同于默认值的值填充它：
ALTER TABLE transactions
ADD COLUMN status varchar(30) DEFAULT 'old',
ALTER COLUMN status SET default 'current';
现有行将用old填充，但是随后的命令的默认值将是current。
其效果与在单独的ALTER TABLE命令中发出两个子命令的效果相同。
要从表中删除一列：
ALTER TABLE distributors DROP COLUMN address RESTRICT;
要在一个操作中更改两个现有列的类型：
ALTER TABLE distributors
ALTER COLUMN address TYPE varchar(80),
ALTER COLUMN name TYPE varchar(100);
通过一个USING子句更改一个包含 Unix 时间戳的整数列为
timestamp with time zone：
ALTER TABLE foo
ALTER COLUMN foo_timestamp SET DATA TYPE timestamp with time zone
USING
timestamp with time zone 'epoch' + foo_timestamp * interval '1 second';
同样，当该列具有一个不能自动转换为新数据类型的默认值表达式时：
ALTER TABLE foo
ALTER COLUMN foo_timestamp DROP DEFAULT,
ALTER COLUMN foo_timestamp TYPE timestamp with time zone
USING
timestamp with time zone 'epoch' + foo_timestamp * interval '1 second',
ALTER COLUMN foo_timestamp SET DEFAULT now();
重命名一个现有列：
ALTER TABLE distributors RENAME COLUMN address TO city;
重命名一个现有的表：
ALTER TABLE distributors RENAME TO suppliers;
重命名一个现有的约束：
ALTER TABLE distributors RENAME CONSTRAINT zipchk TO zip_check;
为一列增加一个非空约束：
ALTER TABLE distributors ALTER COLUMN street SET NOT NULL;
从一列移除一个非空约束：
ALTER TABLE distributors ALTER COLUMN street DROP NOT NULL;
向一个表及其所有子表增加一个检查约束：
ALTER TABLE distributors ADD CONSTRAINT zipchk CHECK (char_length(zipcode) = 5);
只向一个表增加一个检查约束（不为其子表增加）：
ALTER TABLE distributors ADD CONSTRAINT zipchk CHECK (char_length(zipcode) = 5) NO INHERIT;
（该检查约束也不会被未来的子表继承）。
从一个表及其子表移除一个检查约束：
ALTER TABLE distributors DROP CONSTRAINT zipchk;
只从一个表移除一个检查约束：
ALTER TABLE ONLY distributors DROP CONSTRAINT zipchk;
（该检查约束仍为子表保留在某个地方）。
为一个表增加一个外键约束：
ALTER TABLE distributors ADD CONSTRAINT distfk FOREIGN KEY (address) REFERENCES addresses (address);
为一个表增加一个外键约束，并且尽量不要影响其他工作：
ALTER TABLE distributors ADD CONSTRAINT distfk FOREIGN KEY (address) REFERENCES addresses (address) NOT VALID;
ALTER TABLE distributors VALIDATE CONSTRAINT distfk;
为一个表增加一个（多列）唯一约束：
ALTER TABLE distributors ADD CONSTRAINT dist_id_zipcode_key UNIQUE (dist_id, zipcode);
为一个表增加一个自动命名的主键约束，注意一个表只能拥有一个主键：
ALTER TABLE distributors ADD PRIMARY KEY (dist_id);
把一个表移动到一个不同的表空间：
ALTER TABLE distributors SET TABLESPACE fasttablespace;
把一个表移动到一个不同的模式：
ALTER TABLE myschema.distributors SET SCHEMA yourschema;
重建一个主键约束，并且在重建索引期间不阻塞更新：
CREATE UNIQUE INDEX CONCURRENTLY dist_id_temp_idx ON distributors (dist_id);
ALTER TABLE distributors DROP CONSTRAINT distributors_pkey,
ADD CONSTRAINT distributors_pkey PRIMARY KEY USING INDEX dist_id_temp_idx;
要把一个分区挂接到一个范围分区表上：
ALTER TABLE measurement
ATTACH PARTITION measurement_y2016m07 FOR VALUES FROM ('2016-07-01') TO ('2016-08-01');
要把一个分区挂接到一个列表分区表上：
ALTER TABLE cities
ATTACH PARTITION cities_ab FOR VALUES IN ('a', 'b');
要把一个分区挂接到一个哈希分区表上：
ALTER TABLE orders
ATTACH PARTITION orders_p4 FOR VALUES WITH (MODULUS 4, REMAINDER 3);
要把一个默认分区挂接到一个分区表上：
ALTER TABLE cities
ATTACH PARTITION cities_partdef DEFAULT;
从一个分区表分离一个分区：
ALTER TABLE measurement
DETACH PARTITION measurement_y2015m12;
兼容性
形式 ADD [COLUMN],
DROP [COLUMN], DROP IDENTITY, RESTART,
SET DEFAULT, SET DATA TYPE（不带 USING），
SET GENERATED 和 SET sequence_option
符合 SQL 标准。
形式 ADD table_constraint
符合 SQL 标准，当省略 USING INDEX 和
NOT VALID 子句，并且约束类型为
CHECK、UNIQUE、PRIMARY KEY，
或 REFERENCES 之一时。
其他形式是
PostgreSQL 对 SQL 标准的扩展。
此外，在单个 ALTER TABLE 命令中指定多个操作的能力也是一种扩展。
ALTER TABLE DROP COLUMN可以被用来删除一个表的唯一的
列，从而留下一个零列的表。这是一种 SQL 的扩展，SQL 中不允许零列的表。
另见CREATE TABLE上一页 上一级 下一页ALTER SYSTEM 起始页 ALTER TABLESPACE
