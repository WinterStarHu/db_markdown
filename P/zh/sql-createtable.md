# CREATE TABLE

CREATE TABLE
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE TABLECREATE TABLE — 定义一个新表大纲
CREATE [ [ GLOBAL | LOCAL ] { TEMPORARY | TEMP } | UNLOGGED ] TABLE [ IF NOT EXISTS ] table_name ( [
{ column_name data_type [ STORAGE { PLAIN | EXTERNAL | EXTENDED | MAIN | DEFAULT } ] [ COMPRESSION compression_method ] [ COLLATE collation ] [ column_constraint [ ... ] ]
| table_constraint
| LIKE source_table [ like_option ... ] }
[, ... ]
] )
[ INHERITS ( parent_table [, ... ] ) ]
[ PARTITION BY { RANGE | LIST | HASH } ( { column_name | ( expression ) } [ COLLATE collation ] [ opclass ] [, ... ] ) ]
[ USING method ]
[ WITH ( storage_parameter [= value] [, ... ] ) | WITHOUT OIDS ]
[ ON COMMIT { PRESERVE ROWS | DELETE ROWS | DROP } ]
[ TABLESPACE tablespace_name ]
CREATE [ [ GLOBAL | LOCAL ] { TEMPORARY | TEMP } | UNLOGGED ] TABLE [ IF NOT EXISTS ] table_name
OF type_name [ (
{ column_name [ WITH OPTIONS ] [ column_constraint [ ... ] ]
| table_constraint }
[, ... ]
) ]
[ PARTITION BY { RANGE | LIST | HASH } ( { column_name | ( expression ) } [ COLLATE collation ] [ opclass ] [, ... ] ) ]
[ USING method ]
[ WITH ( storage_parameter [= value] [, ... ] ) | WITHOUT OIDS ]
[ ON COMMIT { PRESERVE ROWS | DELETE ROWS | DROP } ]
[ TABLESPACE tablespace_name ]
CREATE [ [ GLOBAL | LOCAL ] { TEMPORARY | TEMP } | UNLOGGED ] TABLE [ IF NOT EXISTS ] table_name
PARTITION OF parent_table [ (
{ column_name [ WITH OPTIONS ] [ column_constraint [ ... ] ]
| table_constraint }
[, ... ]
) ] { FOR VALUES partition_bound_spec | DEFAULT }
[ PARTITION BY { RANGE | LIST | HASH } ( { column_name | ( expression ) } [ COLLATE collation ] [ opclass ] [, ... ] ) ]
[ USING method ]
[ WITH ( storage_parameter [= value] [, ... ] ) | WITHOUT OIDS ]
[ ON COMMIT { PRESERVE ROWS | DELETE ROWS | DROP } ]
[ TABLESPACE tablespace_name ]
其中 column_constraint 是：
[ CONSTRAINT constraint_name ]
{ NOT NULL [ NO INHERIT ]  |
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
FOREIGN KEY ( column_name [, ... ] [, PERIOD column_name ] ) REFERENCES reftable [ ( refcolumn [, ... ] [, PERIOD refcolumn ] ) ]
[ MATCH FULL | MATCH PARTIAL | MATCH SIMPLE ] [ ON DELETE referential_action ] [ ON UPDATE referential_action ] }
[ DEFERRABLE | NOT DEFERRABLE ] [ INITIALLY DEFERRED | INITIALLY IMMEDIATE ] [ ENFORCED | NOT ENFORCED ]
并且 like_option 是：
{ INCLUDING | EXCLUDING } { COMMENTS | COMPRESSION | CONSTRAINTS | DEFAULTS | GENERATED | IDENTITY | INDEXES | STATISTICS | STORAGE | ALL }
并且 partition_bound_spec 是：
IN ( partition_bound_expr [, ...] ) |
FROM ( { partition_bound_expr | MINVALUE | MAXVALUE } [, ...] )
TO ( { partition_bound_expr | MINVALUE | MAXVALUE } [, ...] ) |
WITH ( MODULUS numeric_literal, REMAINDER numeric_literal )
index_parameters 在 UNIQUE, PRIMARY KEY, 并且 EXCLUDE 约束中 为：
[ INCLUDE ( column_name [, ... ] ) ]
[ WITH ( storage_parameter [= value] [, ... ] ) ]
[ USING INDEX TABLESPACE tablespace_name ]
exclude_element 在 EXCLUDE 约束中 是：
{ column_name | ( expression ) } [ COLLATE collation ] [ opclass [ ( opclass_parameter = value [, ... ] ) ] ] [ ASC | DESC ] [ NULLS { FIRST | LAST } ]
referential_action 在 FOREIGN KEY/REFERENCES 约束中 是：
{ NO ACTION | RESTRICT | CASCADE | SET NULL [ ( column_name [, ... ] ) ] | SET DEFAULT [ ( column_name [, ... ] ) ] }
描述
CREATE TABLE将在当前数据库中创建一个新的、初始为空的表。该表将由发出该命令的用户所拥有。
如果给出了模式名称（例如，CREATE TABLE
myschema.mytable ...），则表将在指定的模式中创建。
否则，它将在当前模式中创建。 临时表存在于一个特殊的模式中，因此在创建临时表时不能给出模式名称。
表的名称必须与同一模式中的任何其他关系（表、序列、索引、视图、物化视图或外部表）的名称不同。
CREATE TABLE也会自动地创建一个数据类型来表示对应于该表一行的组合类型。因此，表不能用同一个模式中任何已有数据类型的名称。
可选的约束子句指定一个插入或更新操作要成功，新的或更新过的行必须满足的约束（测试）。一个约束是一个 SQL 对象，它帮助以多种方式定义表中的合法值集合。
有两种方式来定义约束：表约束和列约束。一个列约束会作为列定义的一部分定义。一个表约束定义不与一个特定列绑定，并且它可以包含多于一个列。每个列约束也可以被写作一个表约束，列约束只是一种当约束只影响一列时方便书写的记号习惯。
要能创建一个表，你必须分别具有所有列类型或OF子句中类型的USAGE特权。
参数TEMPORARY or TEMP #
如果指定，该表被创建为一个临时表。
临时表会在会话结束时自动删除，或者也可以选择在当前事务结束时删除（见下文的ON COMMIT）。
默认搜索路径首先包括临时模式，因此当临时表存在时，不会为新计划选择同名的已有永久表，除非它们使用模式限定的名称进行引用。
在一个临时表上创建的任何索引也自动地变为临时的。
自动清理守护进程不能访问并且因此也不能清理或分析临时表。由于这个原因，应该通过会话的 SQL 命令执行合适的清理和分析操作。例如，如果一个临时表将要被用于复杂的查询，最好在填充完毕后在其上运行ANALYZE。
可以选择将GLOBAL或LOCAL写在TEMPORARY或TEMP的前面。这当前在PostgreSQL中没有区别并且已被废弃，见Compatibility。
UNLOGGED #
如果指定，该表被创建为一个不受日志记录的表。写入到不做日志的表中的数据不会被写到预写式日志中（见第 28 章），这让它们比普通表快得多。不过，它们在崩溃时是不安全的：一个不做日志的表在一次崩溃或非干净关闭之后会被自动截断。一个不做日志的表中的内容也不会被复制到后备服务器中。在一个不做日志的表上创建的任何索引也会自动地不被日志记录。
如果指定了这个选项，那么与非记录表一起创建的任何序列（用于标识或序列列）也将被创建为非记录。
此形式不支持分区表。
IF NOT EXISTS #
如果一个同名关系已经存在，不要抛出一个错误。在这种情况下会发出一个提示。注意这不保证现有的关系是和将要被创建的关系相似的东西。
table_name #
要被创建的表名（可以选择用模式限定）。
OF type_name #
创建一个 类型表，其结构来自指定的独立复合类型（即，
使用 CREATE TYPE 创建的类型），尽管它仍然
生成一个新的复合类型。该表将依赖于引用的类型，这意味着对该类型的级联更改和
删除操作将传播到该表。
类型表始终具有与其派生类型相同的列名和数据类型，因此您不能指定额外的列。
但是 CREATE TABLE 命令可以向表添加默认值
和约束，并指定存储参数。
column_name #
列的名称将在新表中被建立。
data_type #
列的数据类型。这可以包括数组
规格。有关PostgreSQL支持的数据类型的详细信息，请参考第 8 章。
COLLATE collation #
COLLATE子句为该列（必须是一种可排序数据类型）赋予一个排序规则。
如果没有指定，将使用该列数据类型的默认排序规则。
STORAGE { PLAIN | EXTERNAL | EXTENDED | MAIN | DEFAULT }
#
此形式设置列的存储模式。这控制了该列是内联存储还是在一个次级
TOAST表中存储，以及数据是否需要压缩。
PLAIN必须用于固定长度的值，例如integer，
并且是内联的、未压缩的。MAIN用于内联的、可压缩的数据。
EXTERNAL用于外部的、未压缩的数据，而EXTENDED
用于外部的、压缩的数据。
写入DEFAULT会将存储模式设置为列数据类型的默认模式。
对于支持非PLAIN存储的大多数数据类型，
EXTENDED是默认值。
使用EXTERNAL会使对非常大的text和
bytea值的子字符串操作运行得更快，但代价是增加了存储空间。
有关更多信息，请参见第 66.2 节。
COMPRESSION compression_method #
COMPRESSION子句设置列的压缩方法。
压缩仅支持变宽数据类型，并且仅可在列的存储模式为main 或 extended的时候使用。
(列存储模式的信息请参见ALTER TABLE。)
为分区表设置此属性没有直接影响，因为该表没有自己的存储空间，但是配置值将由新创建的分区继承。
支持的压缩方法为pglz 和lz4。
(仅在构建PostgreSQL时使用了--with-lz4的时候，lz4 才可用。)
此外，compression_method可以是default来显式地指定默认行为，也就是在数据插入时参考default_toast_compression 设置，以确定要使用的方法。
INHERITS ( parent_table [, ... ] ) #
可选的INHERITS子句指定一个表的列表，
新表将从其中自动地继承所有列。
父表可以是普通表或者外部表。
INHERITS的使用在新的子表和它的父表之间创建一种持久的关系。
对于父表的模式修改通常也会传播到子表，
并且默认情况下子表的数据会被包括在对父表的扫描中。
如果在多个父表中存在同名的列，除非父表中每一个这种列的数据类型都能匹配，
否则会报告一个错误。如果没有冲突，那么重复列会被融合来形成新表中的一个单一列。
如果新表中的列名列表包含一个也是继承而来的列名，该数据类型必须也匹配继承的列，
并且列定义会被融合成一个。如果新表显式地为列指定了任何默认值，
这个默认值将覆盖来自该列继承声明中的默认值。
否则，任何父表都必须为该列指定相同的默认值，或者会报告一个错误。
CHECK约束本质上也采用和列相同的方式被融合：
如果多个父表或者新表定义中包含相同的命名CHECK约束，
这些约束必须全部具有相同的检查表达式，否则将报告一个错误。
具有相同名称和表达式的约束将被融合成一份拷贝。
一个父表中的被标记为NO INHERIT的约束将不会被考虑。
注意新表中一个未命名的CHECK约束将永远不会被融合，
因为那样总是会为它选择一个唯一的名字。
列的STORAGE设置也会从父表复制过来。
如果父表中的列是标识列，那么该属性不会被继承。
如果需要，可以将子表中的列声明为标识列。
PARTITION BY { RANGE | LIST | HASH } ( { column_name | ( expression ) } [ opclass ] [, ...] )  #
可选的PARTITION BY子句指定了对表进行分区的策略。
这样创建的表称为分区表。
带括号的列或表达式的列表构成表的分区键。
使用范围或哈希分区时，分区键可以包含多个列或表达式（最多32个，但在构建
PostgreSQL时可以更改此限制），
但对于列表分区，分区键必须由单个列或表达式组成。
范围和列表分区需要btree运算符类，而哈希分区需要哈希运算符类。
如果没有运算符类被显式指定，将使用相应类型的默认运算符类；
如果不存在默认运算符类，则将引发错误。
使用哈希分区时，所使用的运算符类必须实现支持功能2（详情请参阅第 36.16.3 节）。
分区表被分成多个子表（称为分区），它们是使用单独的CREATE TABLE命令创建的。
分区表本身是空的。插入到表中的数据行将根据分区键中的列或表达式的值路由到分区。
如果没有现有的分区与新行中的值匹配，则会报告错误。
有关表分区的更多讨论，请参阅第 5.12 节
PARTITION OF parent_table { FOR VALUES partition_bound_spec | DEFAULT } #
将表创建为指定父表的分区。
该表建立时，可以使用FOR VALUES创建为特定值的分区，
也可以使用DEFAULT创建默认分区。父表中存在的任何索引、
约束和用户定义的行级触发器都将克隆到新分区上。
partition_bound_spec
必须对应于父表的分区方法和分区键，并且必须不能与该父表的任何现有分区重叠。
具有IN的形式用于列表分区，
具有FROM和TO的形式用于范围分区，
具有WITH的形式用于哈希分区。
partition_bound_expr是任何无变量表达式（不允许子查询、窗口函数、聚合函数和集返回函数）。
它的数据类型必须与相应分区键列的数据类型相匹配。
表达式在表创建时只计算一次，因此它甚至可以包含易失性表达式，如CURRENT_TIMESTAMP。
在创建列表分区时，可以指定NULL来表示分区允许分区键列为空。
但是，给定父表不能有多于一个这样的列表分区。无法为范围分区指定
NULL。
创建范围分区时，由FROM指定的下限是一个包含范围，
而用TO指定的上限是排除范围。也就是说，
在FROM列表中指定的值是该分区的相应分区键列的有效值，
而TO列表中的值不是。请注意，
必须根据按行比较的规则来理解此语句（第 9.25.5 节）。
例如，给定PARTITION BY RANGE (x,y)，分区范围
FROM (1, 2) TO (3, 4)允许x=1与任何y>=2，
x=2与任何非空y，和x=3与任何y<4。
在创建范围分区时，可以使用特殊值MINVALUE和MAXVALUE
来指示列值没有下限或上限。例如，使用FROM (MINVALUE) TO (10)
定义的分区允许任何小于10的值，并且使用FROM (10) TO (MAXVALUE)
定义的分区允许任何大于或等于10的值。
创建涉及多个列的范围分区时，将MAXVALUE作为下限的一部分并将
MINVALUE作为上限的一部分也是有意义的。例如，使用
FROM (0, MAXVALUE) TO (10, MAXVALUE)
定义的分区允许第一个分区键列大于0且小于或等于10的任何行。类似地，
使用FROM ('a', MINVALUE) TO ('b', MINVALUE)定义的分区
允许第一个分区键列以"a"开头的任何行。
请注意，如果MINVALUE或MAXVALUE用于分区边界的一列，
则必须为所有后续列使用相同的值。例如，(10, MINVALUE, 0)
不是有效的边界；你应该写(10, MINVALUE, MINVALUE)。
还要注意，某些元素类型，如timestamp，具有“无穷”的概念，
这只是另一个可以存储的值。这与MINVALUE和MAXVALUE不同，
它们不是可以存储的实际值，而是它们表示值无界的方式。MAXVALUE
可以被认为比任何其他值（包括“无穷”）都大的值，MINVALUE
可以被认为是比任何其他值（包括“负无穷”）都小的值。因此，
范围FROM ('infinity') TO (MAXVALUE)不是空的范围；
它只允许存储一个值— "infinity"。
如果指定了DEFAULT，则表将创建为父表的默认分区。此选项不适用于哈希分区表。
不适合给定父表的任何其他分区的分区键值将路由到默认分区。
当一个表已有DEFAULT分区并且要对它添加新分区时，
必须扫描默认分区以验证它不包含可能属于新分区的任何行。
如果默认分区包含大量行，则速度可能会很慢。
如果默认分区是外表或者它具有可证明的不可能包含能放置在新分区中的行的约束，则将略过扫描
当创建哈希分区时，必须指定模数和余数。
模数必须是正整数，余数必须是小于模数的非负整数。
通常情况下，当初始设置哈希分区表时，应选择一个与分区数相等的模数，并为每个表分配相同的模数和不同的余数（请参阅下方示例）。
不过，并不要求每个分区都具有相同的模数，只要求哈希分区表里面的分区中出现的每个模数都是下一个较大模数的因数。
这允许以增量的方式增加分区数量而不需要一次移动所有数据。
例如，假设你有一个包含8个分区的哈希分区表，每个分区有模数8，但发现有必要将分区数增加到16个。
您可以拆分其中一个模数-8分区，然后创建两个新的模数-16分区来覆盖键空间的相同部分（一个的余数等于被拆分的分区的余数，另一个的余数等于该值加8），而后用数据重新填充它们。
然后，你可以对每一个模数-8分区重复此操作过程，直到没有剩余。
虽然这其中的每个步骤都可能会导致大量的数据移动操作，它仍然要好于建一个全新的表并一次移动全部数据。
分区必须与其所属的分区表的字段名和类型相同。
对分区表字段名或类型的修改，将自动传播到所有分区。
CHECK约束将自动被每一个分区继承，但是单独的分区可以指定额外的CHECK约束；与父表相同名称和条件的额外约束将被父表约束合并。
可以为每个分区分别指定默认值。但是请注意，在通过分区表插入元组时不会应用分区的默认值。
插入分区表中的行将自动路由到正确的分区。如果不存在合适的分区，则会发生错误。
操作，如TRUNCATE通常会影响表及其所有继承子代，将会级联到所有分区，但也可以在单个分区上执行。
注意，使用PARTITION OF创建分区需要在父分区表上获取一个ACCESS EXCLUSIVE锁。
同样，使用DROP TABLE删除分区需要在父表上获取一个ACCESS EXCLUSIVE锁。
可以使用ALTER TABLE ATTACH/DETACH PARTITION来执行这些操作，使用更弱的锁，从而减少对分区表上并发操作的干扰。
LIKE source_table [ like_option ... ] #
LIKE子句指定一个表，新表将自动复制该表的所有列名、数据类型及其非空约束。
和INHERITS不同，新表和原始表在创建完成之后是完全分离的。对原始表的更改将不会被应用到新表，并且不可能在原始表的扫描中包括新表的数据。
同样与INHERITS不同，用LIKE拷贝的列和
约束不会和相似的命名列及约束融合。如果显式指定了相同的名称或者在
另一个LIKE子句中指定了相同的名称，将会发出一个错误。
可选的like_option子句指定要复制原始表的哪些附加属性。
指定INCLUDING会复制该属性，指定EXCLUDING
会省略该属性。EXCLUDING是默认值。如果对同一类型的对象
进行了多次指定，则以最后一次为准。可用的选项包括：
INCLUDING COMMENTS #
将会复制被复制列、约束和索引的注释。默认行为是排除注释，
这会导致新表中的被复制列和约束没有注释。
INCLUDING COMPRESSION #
列的压缩方法将被复制。默认行为是排除压缩方法，
导致列使用默认的压缩方法。
INCLUDING CONSTRAINTS #
CHECK约束将被复制。列约束和表约束之间没有区分。
非空约束总是会被复制到新表中。
INCLUDING DEFAULTS #
将复制列定义的默认表达式。否则，默认表达式不会被复制，
导致新表中复制的列具有空默认值。请注意，复制调用数据库修改
函数（例如nextval）的默认值可能会在
原始表和新表之间创建功能链接。
INCLUDING GENERATED #
任何生成表达式以及复制的列定义的存储/虚拟选择将被复制。
默认情况下，新列将是常规基础列。
INCLUDING IDENTITY #
复制的列定义的任何标识规范都会被复制。每个新表的标识列都会创建一个新
的序列，与旧表关联的序列分开。
INCLUDING INDEXES #
索引，主键，唯一，以及
排除约束将在新表上创建。新索引和约束的名称将根据
默认规则选择，而不管原始名称如何。（此行为避免了新索引可能出现的
重复名称失败。）
INCLUDING STATISTICS #
扩展统计信息被复制到新表中。
INCLUDING STORAGE #
STORAGE设置将会被复制到复制的列定义中。
默认行为是排除STORAGE设置，这会导致新表中的复制列
使用类型特定的默认设置。有关STORAGE设置的更多信息，
请参见第 66.2 节。
INCLUDING ALL #
INCLUDING ALL是一个缩写形式，用于选择所有可用的单个选项。
（在INCLUDING ALL之后编写单个
EXCLUDING子句可能会很有用，以选择除某些特定选项之外的所有选项。）
LIKE子句也能被用来从视图、外部表或组合类型拷贝列定义。
不适用的选项（例如来自视图的INCLUDING INDEXES）会被忽略。
CONSTRAINT constraint_name #
一个列约束或表约束的可选名称。如果该约束被违反，约束名将会出现在错误消息中，
这样类似col must be positive的约束名可以用来与客户端应用
沟通有用的约束信息。（指定包含空格的约束名时需要用到双引号。）如果没有指定约束名，
系统将生成一个。
NOT NULL [ NO INHERIT ]  #
该列不允许包含空值。
一个被标记为NO INHERIT的约束将不会传播到子表。
NULL #
该列允许包含空值。这是默认值。
这个子句只是提供与非标准 SQL 数据库的兼容性。在新的应用中不推荐使用。
CHECK ( expression ) [ NO INHERIT ]  #
CHECK指定一个产生布尔结果的表达式，一个插入或更新操作要想成功，其中新的或被更新的行必须满足该表达式。计算出 TRUE 或 UNKNOWN 的表达式就会成功。只要任何一个插入或更新操作的行产生了 FALSE 结果，将报告一个错误异常并且插入或更新不会修改数据库。一个被作为列约束指定的检查约束只应该引用该列的值，而一个出现在表约束中的表达式可以引用多列。
当前，CHECK表达式不能包含子查询，也不能引用当前行的列之外的变量（参见 第 5.5.1 节）。可以引用系统列tableoid，但不能引用其他系统列。
一个被标记为NO INHERIT的约束将不会传播到子表。
当一个表有多个CHECK约束时，检查完NOT NULL约束后，对于每一行会以它们名称的字母表顺序来进行检查（版本 9.5 之前的PostgreSQL对于CHECK约束不遵从任何特定的引发顺序）。
DEFAULT
default_expr #
DEFAULT子句为出现在其定义中的列赋予一个默认数据值。该值是任何不包含变量的表达式（特别是，不允许对当前表中的其他列进行交叉引用）。子查询也是不允许的。默认值表达式的数据类型必须匹配列的数据类型。
默认值表达式将被用在任何没有为该列指定值的插入操作中。如果一列没有默认值，那么默认值为 null。
GENERATED ALWAYS AS ( generation_expr ) [ STORED | VIRTUAL ] #
此子句将列创建为生成列。 列无法被写入，读取时将返回指定表达式的结果。
当指定 VIRTUAL 时，该列将在读取时计算，并且不会占用任何存储。
当指定 STORED 时，该列将在写入时计算并存储在磁盘上。
VIRTUAL 是默认值。
生成表达式可以引用表中的其他列，但不能引用其他生成的列。使用的任何函数和运算符都必须是不可变的。不允许引用其他表。
虚拟生成列不能具有用户定义的类型，虚拟生成列的生成表达式不得引用用户定义的函数或类型，即只能使用内置函数或类型。这也间接适用，例如对于基础运算符或类型转换的函数或类型。（存储型生成列没有此限制。）
GENERATED { ALWAYS | BY DEFAULT } AS IDENTITY [ ( sequence_options ) ] #
此条款将列创建为标识列。它将附带一个隐式序列，
并且在新插入的行中，该列将自动从序列中分配值。
这样的列隐式为NOT NULL。
子句ALWAYS和BY DEFAULT确定如何在
INSERT和UPDATE命令中明确处理用户指定的值。
在INSERT命令中，如果选择了ALWAYS，则仅当
INSERT 语句指定OVERRIDING SYSTEM VALUE时
才接受用户指定的值。如果选择BY DEFAULT，则用户指定的值优先。
有关详细信息，请参阅INSERT。（在COPY命令中，
无论此设置如何，始终使用用户指定的值。）
在UPDATE命令中，如果选择了ALWAYS，
则将列更新为除DEFAULT之外的任何值都将被拒绝。
如果选择BY DEFAULT，则该列可以正常更新。
（UPDATE命令没有OVERRIDING子句。）
可选的sequence_options子句可以用来覆盖序列的参数。
可用的选项包括CREATE SEQUENCE中显示的那些选项，
以及SEQUENCE NAME name、
LOGGED和UNLOGGED，它们允许选择序列的名称
和持久性级别。如果没有SEQUENCE NAME，系统会为序列选择一个
未使用的名称。如果没有LOGGED或UNLOGGED，
序列将具有与表相同的持久性级别。
UNIQUE [ NULLS [ NOT ] DISTINCT ]（列约束）UNIQUE [ NULLS [ NOT ] DISTINCT ] ( column_name [, ... ] [, column_name WITHOUT OVERLAPS ] )
[ INCLUDE ( column_name [, ...]) ] (表约束) #
UNIQUE约束指定一个表中的一列或多列组成的组包含唯一的值。
唯一表约束的行为与唯一列约束的行为相同，只是表约束能够跨越多列。
约束因此强制在这些列中的至少一列的任何两行必须不同。
如果为最后一列指定了WITHOUT OVERLAPS选项，则将检查该列的重叠情况，而不是
相等。在这种情况下，约束的其他列将允许重复，只要重复项在
WITHOUT OVERLAPS列中不重叠。（如果该列是日期或时间戳的范围，这有时称为
时间键，但PostgreSQL允许对任何基础类型的范围进行操作。）
实际上，这种约束是通过EXCLUDE约束而不是UNIQUE约束来强制执行的。
因此，例如UNIQUE (id, valid_at WITHOUT OVERLAPS)的行为类似于
EXCLUDE USING GIST (id WITH =, valid_at WITH
&&)。WITHOUT OVERLAPS列必须具有范围或多范围类型。
不允许空范围/多范围。约束的非WITHOUT OVERLAPS列可以是任何可以在
GiST索引中进行相等比较的类型。默认情况下，仅支持范围类型，但您可以通过添加
btree_gist扩展来使用其他类型（这是使用此功能的预期方式）。
对于唯一约束的目的，null值不被视为相等，除非指定了NULLS NOT DISTINCT。
每一个唯一约束将命名一个列的集合，并且它与该表上任何其他唯一或主键约束所命名的列集合都不相同。
（否则，冗余的唯一约束将被丢弃。）
在为多级分区层次结构建立唯一约束时，
目标分区表的分区键中的所有列，以及那些由它派生的所有分区表，
必须被包含在约束定义中。
添加唯一约束将自动在约束中使用的列或列组上创建唯一的 btree
索引。但是，如果约束包含 WITHOUT OVERLAPS 子句，则
将使用 GiST 索引。创建的索引与唯一约束具有相同的名称。
可选 INCLUDE 子句向该索引添加一个或多个列是简单的 “payload”：在它们上面唯一性是不强制的，并且该索引不能基于这些列搜索。
然而它们可以通过一个仅对索引的扫描检索。
请注意虽然约束在包含的列上是非强制的，但是它仍然依赖于它们。
因此，这样的列上的某些操作（例如 DROP COLUMN）可能会导致级联约束和索引删除。
PRIMARY KEY （列约束）PRIMARY KEY ( column_name [, ... ] [, column_name WITHOUT OVERLAPS ] )
[ INCLUDE ( column_name [, ...]) ] (表约束) #
PRIMARY KEY 约束指定表的一个或者多个列只能包含唯一（不重复）、非空的值。一个表上只能指定一个主键，可以作为列约束或表约束。
主键约束所涉及的列集合应该不同于同一个表上定义的任何唯一约束的列集合（否则，该唯一约束是多余的并且会被丢弃）。
PRIMARY KEY 强制的数据约束可以看成是 UNIQUE 和 NOT NULL 的组合，
然而，把一组列标识为主键也为模式设计提供了元数据，因为主键标识其他表可以依赖这一个列集合作为行的唯一标识符。
当放到分区表上时，PRIMARY KEY 约束共享前面描述的UNIQUE 约束的限制。
添加 PRIMARY KEY 约束将自动在约束中使用的列或列组上创建唯一的 btree
索引，或者如果指定了 WITHOUT OVERLAPS 则使用 GiST。
可选 INCLUDE 子句向该索引添加一个或多个列是简单的“payload”：在它们上面唯一性是不强制的，并且该索引不能基于这些列搜索。
然而它们可以通过一个仅对索引的扫描检索。
请注意虽然约束在包含的列上是非强制的，但是它仍然依赖于它们。
因此，这样的列上的某些操作（例如DROP COLUMN）可能会导致级联约束和索引删除。
EXCLUDE [ USING index_method ] ( exclude_element WITH operator [, ... ] ) index_parameters [ WHERE ( predicate ) ] #
EXCLUDE 子句定义了一个排除约束，该约束保证如果
任意两行在指定的列或表达式上使用指定的操作符进行比较，不会有所有这些
比较返回TRUE。如果所有指定的操作符都测试相等，这等同于一个
UNIQUE 约束，尽管普通的唯一约束会更快。然而，排除约束可以指定
比简单相等更一般的约束。例如，您可以指定一个约束，表中没有两行包含重叠的圆
(参见第 8.8 节)，通过使用
&& 操作符。操作符需要是可交换的。
排除约束是通过使用与约束同名的索引来实现的，因此每个指定的操作符必须与适当的操作符类
相关联（参见 第 11.10 节）以用于索引访问方法 index_method。
每个 exclude_element 定义索引的一列，因此它可以选择性地指定排序规则、
操作符类、操作符类参数和/或排序选项；这些内容在 CREATE INDEX 中有详细描述。
访问方法必须支持amgettuple（见第 63 章），目前这意味着GIN无法使用。尽管允许，但是在一个排除约束中使用 B-树或哈希索引没有意义，因为它无法做得比一个普通唯一索引更出色。因此在实践中访问方法将总是GiST或SP-GiST。
predicate 允许你在该表的一个子集上指定一个排除约束。在内部这会创建一个部分索引。注意在为此周围的圆括号是必须的。
在为多级分区层次结构建立排除约束时，目标分区表的分区键中的所有列，
以及其所有后代分区表的列，必须包含在约束定义中。此外，这些列必须使用相等运算符进行比较。
这些限制确保潜在冲突的行将存在于同一分区中。约束还可以引用其他不属于任何分区键的列，
这些列可以使用任何适当的运算符进行比较。
REFERENCES reftable [ ( refcolumn ) ] [ MATCH matchtype ] [ ON DELETE referential_action ] [ ON UPDATE referential_action ]（列约束）FOREIGN KEY ( column_name [, ... ] [, PERIOD column_name ] )
REFERENCES reftable [ ( refcolumn [, ... ] [, PERIOD refcolumn ] ) ]
[ MATCH matchtype ]
[ ON DELETE referential_action ]
[ ON UPDATE referential_action ]
（表约束） #
这些子句指定了外键约束，要求新表中的一组一个或多个列
只能包含与引用表某行的引用列中的值匹配的值。如果省略
refcolumn 列表，则使用
reftable 的主键。否则，
refcolumn 列表必须引用
非延迟唯一或主键约束的列，或者是非部分唯一索引的列。
如果最后一列标记为 PERIOD，则以特殊方式处理。
当非 PERIOD 列进行相等比较时（并且必须至少有
一列），PERIOD 列则不进行比较。相反，如果引用表
有匹配的记录（基于非 PERIOD 部分的键），其组合
的 PERIOD 值完全覆盖引用记录的值，则认为约束
满足。换句话说，引用必须在其整个持续时间内有一个被引用的
记录。此列必须是范围或多范围类型。此外，引用表必须声明
一个带有 WITHOUT OVERLAPS 的主键或唯一约束。
最后，如果外键有一个 PERIOD column_name
规范，则相应的 refcolumn
（如果存在）也必须标记为 PERIOD。如果省略
refcolumn 子句，因此选择
reftable 的主键约束，则主键的最后一列必须标记为
WITHOUT OVERLAPS。
对于每对引用列和被引用列，如果它们是可排序的数据类型，
则排序规则必须是确定性的，或者必须相同。这确保了两个列
对相等的概念是一致的。
用户必须对引用表（整个表或特定的引用列）具有
REFERENCES 权限。添加外键约束需要对引用表
进行 SHARE ROW EXCLUSIVE 锁。请注意，外键约束
不能在临时表和永久表之间定义。
被插入到引用列的一个值会使用给定的匹配类型与被引用表的值进行匹配。
有三种匹配类型：MATCH FULL、MATCH PARTIAL以及MATCH SIMPLE（这是默认值）。
MATCH FULL将不允许一个多列外键中的一列为空，除非所有外键列都是空；如果它们都是空，则不要求该行在被引用表中有一个匹配。
MATCH SIMPLE允许任意外键列为空，如果任一为空，则不要求该行在被引用表中有一个匹配。
MATCH PARTIAL现在还没有被实现（当然，NOT NULL约束能被应用在引用列上来防止这些情况发生）。
此外，当引用列中的数据发生变化时，会对该表列中的数据
执行某些操作。ON DELETE 子句指定在引用表中
被引用的行被删除时要执行的操作。同样，ON UPDATE
子句指定在引用表中的引用列被更新为新值时要执行的操作。
如果行被更新，但引用列实际上没有改变，则不执行任何操作。
参照操作作为数据更改命令的一部分执行，即使约束是延迟的。
每个子句有以下可能的操作：
NO ACTION #
如果删除或更新将导致外键约束违反，则产生错误。
如果约束是延迟的，则在约束检查时，如果仍然存在任何
引用行，将产生此错误。这是默认操作。
RESTRICT #
如果要删除或更新的行与引用表中的行匹配，则产生错误。
即使在操作后的状态不会违反外键约束，也会阻止该操作。
特别是，它防止将被引用行更新为不同但比较相等的值。
（但它不阻止将列更新为相同值的 “no-op” 更新。）
在时间外键中，不支持此选项。
CASCADE #
删除任何引用已删除行的行，或将引用列的值更新为
被引用列的新值。
在时间外键中，不支持此选项。
SET NULL [ ( column_name [, ... ] ) ] #
将所有引用列或指定子集的引用列设置为 NULL。
只能为 ON DELETE 操作指定列的子集。
在时间外键中，不支持此选项。
SET DEFAULT [ ( column_name [, ... ] ) ] #
将所有引用列或指定子集的引用列设置为其默认值。
只能为 ON DELETE 操作指定列的子集。
（如果默认值不为 NULL，则必须在引用表中有一行与默认值匹配，
否则操作将失败。）
在时间外键中，不支持此选项。
如果被引用列频繁更改，最好在引用列上加上一个索引，这样与外键约束相关的引用动作能够更高效地被执行。
DEFERRABLENOT DEFERRABLE #
这控制约束是否可以延迟。不可延迟的约束将在每个命令后
立即检查。可延迟的约束检查可以推迟到事务结束时
（使用 SET CONSTRAINTS 命令）。
NOT DEFERRABLE 是默认值。
目前，只有 UNIQUE、PRIMARY KEY、
EXCLUDE 和 REFERENCES（外键）约束
接受此子句。NOT NULL 和 CHECK 约束
是不可延迟的。请注意，可延迟约束不能用作包含
INSERT 语句中的 ON CONFLICT 子句的冲突仲裁者。
INITIALLY IMMEDIATEINITIALLY DEFERRED #
如果一个约束是可延迟的，这个子句指定检查该约束的默认时间。
如果该约束是INITIALLY IMMEDIATE，它会在每一个语句之后被检查。
这是默认值。
如果该约束是INITIALLY DEFERRED，它只会在事务结束时被检查。
约束检查时间可以用SET CONSTRAINTS命令修改。
ENFORCEDNOT ENFORCED #
当约束被 ENFORCED 时，数据库系统将确保约束
得到满足，通过在适当的时间（每个语句后或在事务结束时，
视情况而定）检查约束。这是默认行为。如果约束为
NOT ENFORCED，数据库系统将不检查约束。
然后由应用程序代码确保约束得到满足。数据库系统仍然可能
假设数据实际上满足约束，以便在不影响结果正确性的情况下
进行优化决策。
NOT ENFORCED 约束在运行时实际检查约束代价过高时
可以作为文档使用。
目前仅支持外键和 CHECK 约束。
USING method #
此可选子句指定用于存储新表内容的表访问方法；该方法需要的是类型TABLE的访问方法。详见 第 62 章 。
如果未指定此选项，则为新表选择默认表访问方法。详见default_table_access_method。
创建分区时，表访问方法是其分区表的访问方法（如果已设置）。
WITH ( storage_parameter [= value] [, ... ] ) #
这个子句为一个表或索引指定可选的存储参数，详见Storage Parameters下面的内容。
为了向后兼容，表的WITH子句还可以包括OIDS=FALSE以指定新表的行不应包含 OIDs（对象标识符），OIDS=TRUE不再受支持。
WITHOUT OIDS #
这是向后兼容的语法，用于声明表WITHOUT OIDS，不再支持创建表WITH OIDS。
ON COMMIT #
可以使用ON COMMIT来控制事务块结束时临时表的行为。
有三种选项：
PRESERVE ROWS #
在事务结束时不会采取特殊操作。
这是默认行为。
DELETE ROWS #
在每个事务块结束时，临时表中的所有行都会被删除。
本质上，每次提交时都会自动执行一次TRUNCATE。
当用于分区表时，这不会级联到其分区。
DROP #
在当前事务块结束时，临时表将被删除。
当用于分区表时，此操作会删除其分区；
当用于具有继承子表的表时，会删除依赖的子表。
TABLESPACE tablespace_name #
tablespace_name是新表要创建于其中的表空间名称。如果没有指定，将参考default_tablespace，或者如果表是临时的则参考temp_tablespaces。
对于分区表，由于表本身不需要存储，指定的表空间将覆盖default_tablespace作为默认表空间，在未显式指定其他表空间时用于任何新创建的分区。
USING INDEX TABLESPACE tablespace_name #
这个子句允许选择与一个UNIQUE、PRIMARY KEY或者EXCLUDE约束相关的索引将被创建在哪个表空间中。如果没有指定，将参考default_tablespace，或者如果表是临时的则参考temp_tablespaces。
存储参数
WITH子句能够为表或与一个UNIQUE、PRIMARY KEY或者EXCLUDE约束相关的索引指定存储参数。
用于索引的存储参数已经在CREATE INDEX中介绍过。
当前可用于表的存储参数在下文中列出。
如下文所示，对于很多这类参数，都有一个名字带有toast.前缀的附加参数，它能被用来控制该表的二级TOAST表（如果存在）的行为（关于 TOAST 详见第 66.2 节）。
如果一个表的参数值被设置但是相应的toast.参数没有被设置，那么 TOAST 表将使用该表的参数值。
不支持为分区表指定这些参数，但可以为单个叶子分区指定它们。
fillfactor (integer)
#
表的填充因子是介于10和100之间的百分比。
100（完全填充）是默认值。当指定较小的填充因子时，INSERT操作仅将表页填充到指定的百分比；
每页上剩余的空间用于更新该页上的行。这使得UPDATE有机会将更新后的行的副本放在
与原始行相同的页上，这比放在不同的页上更有效，并使仅堆元组更新更有可能发生。
对于条目永远不会更新的表，完全填充是最佳选择，但在频繁更新的表中，较小的填充因子更合适。此参数不能
为TOAST表设置。
toast_tuple_target (integer)
#
在我们尝试压缩和/或将长列值移动到TOAST表中之前，toast_tuple_target指定需要的最小元组长度，
也是在toasting开始时尝试减少长度的目标长度。这会影响标记为 External（用于移动）、
Main（用于压缩）或 Extended（用于两者）的列，并且仅适用于新元组。对现有行没有影响。
默认情况下此参数设置为允许每个块至少 4 个元组，默认块大小为 2040 字节。
有效值介于 128 字节和(块大小-标头)之间，默认大小为 8160 字节。
更改此值对于非常短或非常长的行可能没有用处。
请注意默认设置通常接近最佳状态，在某些情况下设置此参数可能会产生负面影响。
此参数不能对TOAST表设置。
parallel_workers (integer)
#
这个参数设置用于辅助并行扫描这个表的工作者数量。
如果没有设置这个参数，系统将基于关系的尺寸来决定一个值。
规划者或使用并行扫描的实用程序选择的工作者数量可能会比较少，例如max_worker_processes的设置较小就是一种可能的原因。
autovacuum_enabled, toast.autovacuum_enabled (boolean)
#
为一个特定的表启用或者禁用自动清理守护进程。如果为真，自动清理守护进程将遵照第 24.1.6 节中讨论的规则在这个表上执行自动的VACUUM或者ANALYZE操作。如果为假，这个表不会被自动清理，不过为了阻止事务 ID 回卷时还是会对它进行自动的清理。有关回卷阻止请见第 24.1.5 节。如果autovacuum参数为假，自动清理守护进程根本就不会运行（除非为了阻止事务 ID 回卷），设置独立的表存储参数也不会覆盖这个设置。因此显式地将这个存储参数设置为true很少有大的意义，只有设置为false才更有用。
vacuum_index_cleanup, toast.vacuum_index_cleanup (enum)
#
当VACUUM在此表上运行时强制或禁用索引清理。
默认值为AUTO。
用OFF，索引清理被禁用，用ON则被启用，而采用AUTO，决定被动态做出，每次VACUUM运行时。
动态行为允许VACUUM避免不必要的扫描索引以移除很少的死元组。
强制禁用全部索引清理可以显著加快VACUUM，但如果表修改很频繁，也可能导致索引严重膨胀。
VACUUM的INDEX_CLEANUP参数，如果指定，将覆盖此选项的值。
vacuum_truncate, toast.vacuum_truncate (boolean)
#
每个表的 vacuum_truncate 参数值。
TRUNCATE 参数的 VACUUM，
如果指定，将覆盖此选项的值。
autovacuum_vacuum_threshold, toast.autovacuum_vacuum_threshold (integer)
#
autovacuum_vacuum_threshold参数对于每个表的值。
autovacuum_vacuum_max_threshold, toast.autovacuum_vacuum_max_threshold (integer)
#
每个表的 autovacuum_vacuum_max_threshold
参数的值。
autovacuum_vacuum_scale_factor, toast.autovacuum_vacuum_scale_factor (floating point)
#
autovacuum_vacuum_scale_factor参数对于每个表的值。
autovacuum_vacuum_insert_threshold, toast.autovacuum_vacuum_insert_threshold (integer)
#
autovacuum_vacuum_insert_threshold参数对于每个表的值。特殊值-1可用于禁用表上的插入清理。
autovacuum_vacuum_insert_scale_factor, toast.autovacuum_vacuum_insert_scale_factor (floating point)
#
autovacuum_vacuum_insert_scale_factor参数对于每个表的值。
autovacuum_analyze_threshold (integer)
#
autovacuum_analyze_threshold参数对于每个表的值。
autovacuum_analyze_scale_factor (floating point)
#
autovacuum_analyze_scale_factor参数的每个表的值。
autovacuum_vacuum_cost_delay, toast.autovacuum_vacuum_cost_delay (floating point)
#
autovacuum_vacuum_cost_delay参数的每个表的值。
autovacuum_vacuum_cost_limit, toast.autovacuum_vacuum_cost_limit (integer)
#
autovacuum_vacuum_cost_limit参数的每个表的值。
autovacuum_freeze_min_age, toast.autovacuum_freeze_min_age (integer)
#
vacuum_freeze_min_age参数的每个表的值。注意自动清理将忽略超过系统范围autovacuum_freeze_max_age设置一半的针对每个表的autovacuum_freeze_min_age参数。
autovacuum_freeze_max_age, toast.autovacuum_freeze_max_age (integer)
#
autovacuum_freeze_max_age参数对于每个表的值。注意自动清理将忽略
超过系统范围设置的针对每个表的autovacuum_freeze_max_age参数（只能被设置得较小）。
autovacuum_freeze_table_age, toast.autovacuum_freeze_table_age (integer)
#
vacuum_freeze_table_age参数对于每个表的值。
autovacuum_multixact_freeze_min_age, toast.autovacuum_multixact_freeze_min_age (integer)
#
vacuum_multixact_freeze_min_age参数对于每个表的值。注意自动清理将忽略
超过系统范围autovacuum_multixact_freeze_max_age参数一半的针对每个表的autovacuum_multixact_freeze_min_age参数。
autovacuum_multixact_freeze_max_age, toast.autovacuum_multixact_freeze_max_age (integer)
#
autovacuum_multixact_freeze_max_age参数对于每个表的值。注意自动清理将忽略
超过系统范围设置的针对每个表的autovacuum_multixact_freeze_max_age参数（只能被设置得较小）。
autovacuum_multixact_freeze_table_age, toast.autovacuum_multixact_freeze_table_age (integer)
#
vacuum_multixact_freeze_table_age参数的每个表值。
log_autovacuum_min_duration, toast.log_autovacuum_min_duration (integer)
#
log_autovacuum_min_duration参数的每个表值。
vacuum_max_eager_freeze_failure_rate, toast.vacuum_max_eager_freeze_failure_rate (floating point)
#
每个表的 vacuum_max_eager_freeze_failure_rate
参数的值。
user_catalog_table (boolean)
#
声明该表是一个用于逻辑复制目的的额外目录表。详见第 47.6.2 节。不能对 TOAST 表设置这个参数。
注释
PostgreSQL为每一个唯一约束和主键约束创建一个索引来强制唯一性。因此，没有必要显式地为主键列创建一个索引（详见CREATE INDEX）。
在当前的实现中，唯一约束和主键不会被继承。这使得继承和唯一约束的组合相当不正常。
一个表不能有超过 1600 列（实际上，由于元组长度限制，有效的限制通常更低）。
示例
创建表films和表distributors：
CREATE TABLE films (
code        char(5) CONSTRAINT firstkey PRIMARY KEY,
title       varchar(40) NOT NULL,
did         integer NOT NULL,
date_prod   date,
kind        varchar(10),
len         interval hour to minute
);
CREATE TABLE distributors (
did    integer PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
name   varchar(40) NOT NULL CHECK (name <> '')
);
创建一个有二维数组的表：
CREATE TABLE array_int (
vector  int[][]
);
为表films定义一个唯一表约束。唯一表约束可以在表的一列或多列上定义：
CREATE TABLE films (
code        char(5),
title       varchar(40),
did         integer,
date_prod   date,
kind        varchar(10),
len         interval hour to minute,
CONSTRAINT production UNIQUE(date_prod)
);
定义一个列检查约束：
CREATE TABLE distributors (
did     integer CHECK (did > 100),
name    varchar(40)
);
定义一个表检查约束：
CREATE TABLE distributors (
did     integer,
name    varchar(40),
CONSTRAINT con1 CHECK (did > 100 AND name <> '')
);
为表films定义一个主键表约束：
CREATE TABLE films (
code        char(5),
title       varchar(40),
did         integer,
date_prod   date,
kind        varchar(10),
len         interval hour to minute,
CONSTRAINT code_title PRIMARY KEY(code,title)
);
为表distributors定义一个主键约束。下面的两个例子是等价的，第一个使用表约束语法，第二个使用列约束语法：
CREATE TABLE distributors (
did     integer,
name    varchar(40),
PRIMARY KEY(did)
);
CREATE TABLE distributors (
did     integer PRIMARY KEY,
name    varchar(40)
);
为列name赋予一个文字常量默认值，安排列did的默认值是从一个序列对象中选择下一个值产生，并且让modtime的默认值是该行被插入的时间：
CREATE TABLE distributors (
name      varchar(40) DEFAULT 'Luso Films',
did       integer DEFAULT nextval('distributors_serial'),
modtime   timestamp DEFAULT current_timestamp
);
在表distributors上定义两个NOT NULL列约束，其中之一被显式给定了一个名称：
CREATE TABLE distributors (
did     integer CONSTRAINT no_null NOT NULL,
name    varchar(40) NOT NULL
);
为name列定义一个唯一约束：
CREATE TABLE distributors (
did     integer,
name    varchar(40) UNIQUE
);
同样的唯一约束用表约束指定：
CREATE TABLE distributors (
did     integer,
name    varchar(40),
UNIQUE(name)
);
创建相同的表，指定表和它的唯一索引的填充因子为70%：
CREATE TABLE distributors (
did     integer,
name    varchar(40),
UNIQUE(name) WITH (fillfactor=70)
)
WITH (fillfactor=70);
创建表circles，带有一个排除约束阻止任意两个圆重叠：
CREATE TABLE circles (
c circle,
EXCLUDE USING gist (c WITH &&)
);
在表空间diskvol1中创建表cinemas：
CREATE TABLE cinemas (
id serial,
name text,
location text
) TABLESPACE diskvol1;
创建一个组合类型以及一个类型化的表：
CREATE TYPE employee_type AS (name text, salary numeric);
CREATE TABLE employees OF employee_type (
PRIMARY KEY (name),
salary WITH OPTIONS DEFAULT 1000
);
创建一个范围分区表：
CREATE TABLE measurement (
logdate         date not null,
peaktemp        int,
unitsales       int
) PARTITION BY RANGE (logdate);
创建在分区键中具有多个列的范围分区表：
CREATE TABLE measurement_year_month (
logdate         date not null,
peaktemp        int,
unitsales       int
) PARTITION BY RANGE (EXTRACT(YEAR FROM logdate), EXTRACT(MONTH FROM logdate));
创建列表分区表：
CREATE TABLE cities (
city_id      bigserial not null,
name         text not null,
population   bigint
) PARTITION BY LIST (left(lower(name), 1));
创建哈希分区表：
CREATE TABLE orders (
order_id     bigint not null,
cust_id      bigint not null,
status       text
) PARTITION BY HASH (order_id);
创建范围分区表的分区：
CREATE TABLE measurement_y2016m07
PARTITION OF measurement (
unitsales DEFAULT 0
) FOR VALUES FROM ('2016-07-01') TO ('2016-08-01');
使用分区键中的多个列创建范围分区表的几个分区：
CREATE TABLE measurement_ym_older
PARTITION OF measurement_year_month
FOR VALUES FROM (MINVALUE, MINVALUE) TO (2016, 11);
CREATE TABLE measurement_ym_y2016m11
PARTITION OF measurement_year_month
FOR VALUES FROM (2016, 11) TO (2016, 12);
CREATE TABLE measurement_ym_y2016m12
PARTITION OF measurement_year_month
FOR VALUES FROM (2016, 12) TO (2017, 01);
CREATE TABLE measurement_ym_y2017m01
PARTITION OF measurement_year_month
FOR VALUES FROM (2017, 01) TO (2017, 02);
创建列表分区表的分区：
CREATE TABLE cities_ab
PARTITION OF cities (
CONSTRAINT city_id_nonzero CHECK (city_id != 0)
) FOR VALUES IN ('a', 'b');
创建本身是分区的列表分区表的分区，然后向其添加分区：
CREATE TABLE cities_ab
PARTITION OF cities (
CONSTRAINT city_id_nonzero CHECK (city_id != 0)
) FOR VALUES IN ('a', 'b') PARTITION BY RANGE (population);
CREATE TABLE cities_ab_10000_to_100000
PARTITION OF cities_ab FOR VALUES FROM (10000) TO (100000);
创建哈希分区表的分区：
CREATE TABLE orders_p1 PARTITION OF orders
FOR VALUES WITH (MODULUS 4, REMAINDER 0);
CREATE TABLE orders_p2 PARTITION OF orders
FOR VALUES WITH (MODULUS 4, REMAINDER 1);
CREATE TABLE orders_p3 PARTITION OF orders
FOR VALUES WITH (MODULUS 4, REMAINDER 2);
CREATE TABLE orders_p4 PARTITION OF orders
FOR VALUES WITH (MODULUS 4, REMAINDER 3);
创建默认分区：
CREATE TABLE cities_partdef
PARTITION OF cities DEFAULT;
Compatibility
CREATE TABLE命令遵循SQL标准，除了以下例外。
临时表
尽管CREATE TEMPORARY TABLE的语法很像 SQL 标准的语法，但事实是并不相同。在标准中，临时表只需要被定义一次并且会自动地存在（从空内容开始）于需要它们的每一个会话中。PostgreSQL则要求每一个会话为每一个要用的临时表发出它自己的CREATE TEMPORARY TABLE命令。这允许不同的会话为不同的目的使用相同的临时表名，而标准的方法约束一个给定临时表名的所有实例都必须具有相同的表结构。
标准中对于临时表行为的定义被广泛地忽略了。PostgreSQL在这一点上的行为和多种其他 SQL 数据库是相似的。
SQL 标准也区分全局和局部临时表，其中一个局部临时表为每一个会话中的每一个 SQL 模块具有一个独立的内容集合，但是它的定义仍然是多个会话共享的。因为PostgreSQL不支持 SQL 模块，这种区别与PostgreSQL无关。
为了兼容性目的，PostgreSQL将在临时表声明中接受GLOBAL和LOCAL关键词，但是它们当前没有效果。我们不鼓励使用这些关键词，因为未来版本的PostgreSQL可能采用一种更兼容标准的解释。
临时表的ON COMMIT子句也和 SQL 标准相似，但是有一些不同。如果忽略ON COMMIT子句，SQL 指定默认行为是ON COMMIT DELETE ROWS。但是，PostgreSQL中的默认行为是ON COMMIT PRESERVE ROWS。SQL 中不存在ON COMMIT DROP选项。
非延迟唯一性约束
当一个UNIQUE或PRIMARY KEY约束是非可延迟的，PostgreSQL就会在每次插入或修改行时立即检查唯一性。SQL 标准指出只有在语句结束时才应该强制唯一性。当一个单一命令更新多个键值时，这两者是不同的。要得到兼容标准的行为，将该约束声明为DEFERRABLE但是不延迟（即INITIALLY IMMEDIATE）。注意这可能要显著地慢于立即唯一性检查。
列检查约束
SQL 标准指出 CHECK 列约束只能引用它们应用到的列，只有 CHECK 表约束能够引用多列。PostgreSQL 并没有强制这个限制，它同样处理列检查约束和表检查约束。
EXCLUDE 约束
EXCLUDE 约束类型是一种 PostgreSQL 扩展。
外键约束
在外键操作中指定列列表的能力 SET DEFAULT 和 SET NULL 是一个 PostgreSQL 扩展。
它是一个 PostgreSQL 扩展，外键约束可以引用唯一索引的列，而不是主键或唯一约束的列。
NULL “约束”
NULL “约束”（实际上是一个非约束）是一个 PostgreSQL 对 SQL 标准的扩展，它也被包括在一些其他的数据库系统中以实现兼容性（以及对称的 NOT NULL 约束）。因为它是任意列的默认值，它的存在就像噪声一样。
Constraint Naming
SQL标准规定在包含表或域的模式范围内表和域的约束必须具有唯一的名称。
PostgreSQL是比较宽松的：它只需要约束名称在附加到特定表或域的约束之间是唯一的。
但是，对于基于索引的约束(UNIQUE,PRIMARY KEY,和EXCLUDE约束)，
这个额外的自由度并不存在，因为关联的索引被命名为与约束相同的名称，并且索引名称在相同模式的所有关系中必须是唯一的。
继承
通过INHERITS子句的多继承是一种PostgreSQL的语言扩展。
SQL:1999以及之后的标准使用一种不同的语法和不同的语义定义了单继承。
SQL:1999风格的继承还没有被PostgreSQL支持。
零列
PostgreSQL允许创建一个没有列的表（例如CREATE TABLE foo();）。
这是一个对于SQL标准的扩展，它不允许零列表。零列表本身并不是很有用，
但是不允许它们会为ALTER TABLE DROP COLUMN带来奇怪的特殊情况，
因此忽略这种规范限制看起来更加整洁。
多个标识列
PostgreSQL允许一个表拥有多个标识列。
该标准指定一个表最多只能有一个标识列。
这主要是为了给模式更改或迁移提供更大的灵活性。
请注意，INSERT命令仅支持一个适用于整个语句的覆盖子句，
因此不支持具有不同行为的多个标识列。
Generated Columns
选项 STORED 和 VIRTUAL 不是标准选项，但也被其他 SQL 实现使用。SQL
标准并未指定生成列的存储方式。
LIKE Clause
虽然 SQL 标准中有一个 LIKE 子句，但是 PostgreSQL 接受的很多 LIKE 子句选项却不在标准中，并且有些标准中的选项也没有被 PostgreSQL 实现。
WITH Clause
WITH 子句是一个 PostgreSQL 扩展，存储参数不在标准中。
Tablespaces
PostgreSQL 的表空间概念不是标准的一部分。因此，子句 TABLESPACE 和 USING INDEX TABLESPACE 是扩展。
类型化表
类型化表实现了 SQL 标准的一个子集。根据标准，一个类型化表具有与底层组合类型相对应的列，以及一个其他的“自引用列”。PostgreSQL不显式支持自引用列。
PARTITION BY 子句
PARTITION BY 子句是PostgreSQL的一个扩展。
PARTITION OF 子句
PARTITION OF 子句是PostgreSQL的一个扩展。
另请参阅ALTER TABLE, DROP TABLE, CREATE TABLE AS, CREATE TABLESPACE, CREATE TYPE上一页 上一级 下一页CREATE SUBSCRIPTION 起始页 CREATE TABLE AS
