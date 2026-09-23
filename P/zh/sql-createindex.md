# CREATE INDEX

CREATE INDEX
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE INDEXCREATE INDEX — 定义一个新索引大纲
CREATE [ UNIQUE ] INDEX [ CONCURRENTLY ] [ [ IF NOT EXISTS ] name ] ON [ ONLY ] table_name [ USING method ]
( { column_name | ( expression ) } [ COLLATE collation ] [ opclass [ ( opclass_parameter = value [, ... ] ) ] ] [ ASC | DESC ] [ NULLS { FIRST | LAST } ] [, ...] )
[ INCLUDE ( column_name [, ...] ) ]
[ NULLS [ NOT ] DISTINCT ]
[ WITH ( storage_parameter [= value] [, ... ] ) ]
[ TABLESPACE tablespace_name ]
[ WHERE predicate ]
描述
CREATE INDEX在指定关系的指定列上构建
一个索引，该关系可以是一个表或者一个物化视图。索引主要被用来提升
数据库性能（不过不当的使用会导致性能变差）。
索引的键域被指定为列名，或者写在圆括号中的表达式。如果索引方法支持
多列索引，可以指定多个域。
一个索引域可以是一个从表行的一列或者更多列值进行计算的表达式。
这种特性可以被用来获得对基于基本数据某种变换的数据的快速访问。
例如，一个在upper(col)上计算的索引可以允许子句
WHERE upper(col) = 'JIM'使用索引。
PostgreSQL提供了索引方法
B-树、哈希、GiST、SP-GiST、GIN 以及 BRIN。用户也可以定义自己的索引
方法，但是相对较复杂。
当WHERE子句存在时，会创建一个
部分索引。部分索引只包含表中一部分行的项，
通常索引这一部分会比表的其他部分更有用。例如，如果有一个表包含了
已付和未付订单，其中未付订单占了整个表的一小部分并且是经常被使用
的部分，可以通过只在这一部分上创建一个索引来改进性能。另一种可能
的应用是使用带有UNIQUE的
WHERE在表的一个子集上强制唯一性。更多的讨论
请见第 11.8 节。
WHERE子句中使用的表达式只能引用底层表的列，但
它可以引用所有列而不仅仅是被索引的列。当前，
WHERE中也禁止使用子查询和聚合表达式。同样的
限制也适用于表达式索引中的表达式域。
所有在索引定义中使用的函数和操作符必须是“不可变的”，
就是说它们的结果必须仅依赖于它们的参数而不受外在因素（例如另
一个表的内容和当前的时间）的影响。这种限制确保了索引的行为是
明确的。要在一个索引表达式或者WHERE子句中
使用用户定义的函数，记住在创建函数时把它标记为不可变。
参数UNIQUE
导致系统在索引被创建时（如果数据已经存在）或者加入数据时
检查重复值。尝试插入或更新会导致重复项的数据将产生一个错误。
当唯一索引被应用在分区表上时会有额外的限制，请参考CREATE TABLE。
CONCURRENTLY
当使用了这个选项时，PostgreSQL在构建索引时
不会取得任何会阻止该表上并发插入、更新或者删除的锁。而标准的索引
构建将会把表锁住以阻止对表的写（但不阻塞读），这种锁定会持续到索
引创建完毕。在使用这个选项时有多个需要注意的地方 — 请见
Building Indexes Concurrently。
对于临时表，CREATE INDEX始终是非并发的，因为没有其他会话可以访问它们，并且创建非并发索引的成本更低。
IF NOT EXISTS
如果一个同名关系已经存在则不要抛出错误。这种情况下会发出一个提示。
注意，现有的索引与将要创建的索引之间并不保证有任何相似。当
IF NOT EXISTS被指定时，需要指定索引名。
INCLUDE
可选的INCLUDE子句指定一个列的列表，其中的列将被包括在索引中作为非键列。非键列不能作为索引扫描的条件，并且该索引所强制的任何唯一性或排除约束都不会考虑它们。不过，只用索引的扫描可以返回非键列的内容而无需访问该索引的基表，因为在索引项中就能直接拿到它们。因此，非键列的增加允许查询使用只用索引的扫描，否则就无法使用。
保守地向索引中增加非键列是明智的，特别是很宽的列。如果一个索引元组超过索引类型允许的最大尺寸，数据插入将会失败。在任何情况下，非键列都会重复来自索引基表的数据并且让索引的尺寸膨胀，因此可能会拖慢搜索。此外，B树重复数据删除永远不会与具有非键列的索引一起使用。
INCLUDE子句中列出的列不需要合适的操作符类，甚至数据类型没有为给定的访问方法定义操作符类的列都可以包括在这个子句中。
不支持把表达式作为被包括列，因为它们不能被用在只用索引的扫描中。
当前，有B-树、GiST和SP-GiST索引访问方法支持这一特性。
在这些索引中，INCLUDE子句中列出的列的值被包括在对应于堆元组的叶子元组中，但是不包括在用于树导航的上层索引项中。
name
要创建的索引的名称。这里不能包含模式名称；索引总是在其父表所在的模式中创建。
索引的名称必须与该模式中的任何其他关系（表、序列、索引、视图、物化视图或外部表）的名称不同。
如果省略名称，PostgreSQL会根据父表的名称和索引列的名称选择一个合适的名称。
ONLY
如果该表是分区表，指示不要在分区上递归创建索引。默认是递归创建索引。
table_name
要被索引的表的名称（可以是模式限定的）。
method
要使用的索引方法的名称。选择包括btree、hash、
gist、spgist、gin、
brin，或用户安装的访问方法，如
bloom。
默认方法是btree。
column_name
表中列的名称。
expression
一个基于一个或多个表列的表达式。如语法中所示，表达式通常必须
被写在圆括号中。不过，如果该表达式是一个函数调用的形式，圆括号
可以省略。
collation
要用于该索引的排序规则的名称。默认情况下，该索引使用被索引列
的排序规则或者被索引表达式的结果排序规则。当查询涉及到使用非
默认排序规则的表达式时，使用非默认排序规则的索引就能派上用场。
opclass
操作符类的名称。详见下文。
opclass_parameter
操作符类参数的名称。详见下文。
ASC
指定升序排序（默认）。
DESC
指定降序排序。
NULLS FIRST
指定把空值排序在非空值前面。在指定DESC时，
这是默认行为。
NULLS LAST
指定把空值排序在非空值后面。在没有指定DESC时，
这是默认行为。
NULLS DISTINCTNULLS NOT DISTINCT
指定对于唯一索引，是否应将空值视为不同（而非相等）。默认情况下，它们是不同的，
因此唯一索引可以在列中包含多个空值。
storage_parameter
索引方法相关的存储参数的名称。详见
Index Storage Parameters。
tablespace_name
在其中创建索引的表空间。如果没有指定，
default_tablespace，或者对临时表上的索引使用
temp_tablespaces。
predicate
部分索引的约束表达式。
索引存储参数
可选的 WITH 子句指定索引的 存储参数。每种索引方法都有自己允许的存储参数集。
B-tree、hash、GiST 和 SP-GiST 索引方法都接受此参数：
fillfactor (integer)
#
控制索引方法尝试填充索引页面的程度。对于 B-trees，叶页面在初始索引构建期间以及在右侧扩展索引时（添加新的最大键值）填充到此百分比。如果页面随后变得完全满，它们将被拆分，从而导致磁盘索引结构的碎片化。B-trees 的默认填充因子为 90，但可以选择从 10 到 100 的任何整数值。
对需要进行多次插入和(或)更新的表，B-树索引可以从CREATE INDEX
时设置的较低的填充因子中受益（跟随批量加载数据到表）。
50-90范围内的值可以有效地“平滑”在B-树索引的早期生命周期中页面分割的速率
（这样降低填充因子甚至可以降低页面分割的绝对数量，尽管这种效果高度依赖于工作负载）。
第 65.1.4.2 节中描述的B-树自底向上索引删除技术依赖于页面上有一些
“额外的”空间来存储“额外的”元组版本，
因此可能会受到填充因子的影响（尽管效果通常不显著）。
在其他特定情况下，在CREATE INDEX时将填充因子增加到100
可能是有用的，这是一种最大化空间利用率的方法。只有当您完全确定表是静态的
（即它永远不会受到插入或更新的影响）时，才应该考虑这一点。
如果填充因子设置为100，则会有损害性能的风险：
即使是少量更新或插入也会导致页面突然大量拆分。
其他索引方法以不同但大致类似的方式使用填充因子；默认填充因子因方法而异。
B-树索引还接受这个参数：
deduplicate_items (boolean)
#
控制使用第 65.1.4.3 节中描述的 B-树重复数据删除技术。设置为
ON或OFF以启用或禁用优化（ON
和OFF的其他写法在第 19.1 节中有介绍）。
默认值为ON。
注意
通过ALTER INDEX关闭deduplicate_items
可以防止将来的插入触发重复数据删除，但本身不会使现有的发布列表元组使用标准的元组表示。
GiST索引还额外接受这个参数：
buffering (enum)
#
控制是否使用在 第 65.2.4.1 节 中描述的缓冲构建技术来构建索引。使用 OFF 禁用缓冲，使用 ON 启用缓冲，使用 AUTO 初始禁用，但一旦索引大小达到 effective_cache_size，将动态启用。默认值为 AUTO。
请注意，如果可以进行排序构建，则将使用排序构建，而不是缓冲构建，除非指定 buffering=ON。
GIN索引接受这些参数：
fastupdate (boolean)
#
控制使用在 第 65.4.4.1 节 中描述的快速更新技术。ON 启用快速更新，OFF 禁用它。默认值为 ON。
注意
通过 ALTER INDEX 关闭 fastupdate 将阻止未来的插入进入待处理索引条目列表，但不会自行刷新现有条目。您可能希望对表进行 VACUUM 或随后调用 gin_clean_pending_list 函数以确保待处理列表被清空。
gin_pending_list_limit (integer)
#
覆盖此索引的全局设置 gin_pending_list_limit。该值以千字节为单位指定。
BRIN 索引接受这些参数：
pages_per_range (integer)
#
定义用于每一个BRIN索引项的块范围由多少个表块组成（详见
第 65.5.1 节）。默认是128。
autosummarize (boolean)
#
定义每当在下一个页面检测到插入时，是否为前一个页面范围排队汇总运行（有关更多详细信息，请参见 第 65.5.1.1 节）。默认值为 off。
并发构建索引
创建索引可能会干扰数据库的常规操作。通常
PostgreSQL会锁住要被索引的表，让它不能被写入，
并且用该表上的一次扫描来执行整个索引的构建。其他事务仍然可以读取表，
但是如果它们尝试在该表上进行插入、更新或者删除，它们会被阻塞直到索引
构建完成。如果系统是一个生产数据库，这可能会导致严重的后果。非常大的
表可能会需要很多个小时，而且即使是较小的表，在构建索引过程中阻塞
写入者一段时间在生产系统中也是不能接受的。
PostgreSQL支持构建索引时不阻塞写入。这种方法通过
指定CREATE INDEX的CONCURRENTLY选项
实现。当使用这个选项时，PostgreSQL必须执行该表的
两次扫描，此外它必须等待所有现有可能会修改或者使用该索引的事务终止。因此这种
方法比起标准索引构建过程来说要做更多工作并且需要更多时间。不过，由于它
允许在构建索引时继续普通操作，这种方式对于在生产环境中增加新索引很有用。
当然，由索引创建带来的额外 CPU 和 I/O 开销可能会拖慢其他操作。
在并发索引构建中，索引实际上是在一个事务中作为一个“无效”索引输入到
系统目录中，然后在另外两个事务中进行两次表扫描。在每次表扫描之前，索引构建
必须等待已经修改表的现有事务终止。在第二次扫描之后，索引构建必须等待任何
具有早于第二次扫描的快照（参见第 13 章）的事务终止，包括任何
并发索引构建的其他表上使用的事务，如果涉及的索引是部分索引或具有不是简单
列引用的列。然后最终索引可以标记为“有效”并准备好使用，CREATE INDEX命令终止。
即使如此，索引可能不会立即用于查询：在最坏的情况下，只要存在早于索引构建
开始的事务，索引就无法使用。
如果在扫描表时出现问题，比如死锁或唯一索引中的唯一性冲突，CREATE INDEX
命令将失败，但会留下一个“无效”的索引。这个索引将被忽略用于查询，
因为它可能是不完整的；但它仍会消耗更新开销。 psql
\d 命令将把这样的索引报告为 INVALID：
postgres=# \d tab
Table "public.tab"
Column |  Type   | Collation | Nullable | Default
--------+---------+-----------+----------+---------
col    | integer |           |          |
Indexes:
"idx" btree (col) INVALID
在这种情况下推荐的恢复方法是删除索引，然后尝试再次执行 CREATE INDEX CONCURRENTLY。
（另一种可能性是使用 REINDEX INDEX CONCURRENTLY 重建索引）。
并发构建一个唯一索引时需要注意的另一点是，当第二次表扫描开始时，唯一约束
已经被强制在其他事务上。这意味着在该索引变得可用之前，其他查询中可能就会
报告该约束被违背，或者甚至在索引构建最终失败的情况中也是这样。还有，如果在
第二次扫描时发生失败，“无效的”索引也会继续强制它的唯一性约束。
表达式索引和部分索引的并发构建也被支持。在这些表达式计算过程中发生的
错误可能导致和上述唯一约束违反类似的行为。
常规索引构建允许在同一个表上同时构建其他常规索引，但是在一个表上同时
只能有一个并发索引构建发生。在两种情况下，在索引被构建时不允许表的模式修改。另一个不同是，一个常规CREATE INDEX
命令可以在一个事务块中执行，但是
CREATE INDEX CONCURRENTLY不可以。
当前不支持在分区表上并发生成索引。
然而，你可以在每个分区上单独并发构建索引，然后最终以非并发的方式创建分区索引，以减少对分区表的写入被锁定的时间。
在这种情况下，生成分区索引仅是元数据操作。
Notes
关于索引何时能被使用、何时不被使用以及什么情况下它们有用的信息请
见第 11 章。
当前，只有 B-树、GiST、GIN 和 BRIN 索引方法支持多键列索引。
是否可以有多个键列与是否可以将INCLUDE列添加到索引无关。
索引最多可以有32列，包括INCLUDE列。
（可以在构建PostgreSQL时修改这个限制）。
当前只有 B-树支持唯一索引。
为索引的每一列可以指定一个带可选参数的操作符类。该操作符
类标识要被该索引用于该列的操作符。例如，一个四字节整数上的 B-树索引
会使用int4_ops类。这个操作符类包括了用于四字节整数
的比较函数。实际上，通常列数据类型的默认操作符类就足够了。对某些数据
类型指定操作符类的主要原因是，可能会有多于一种有意义的顺序。例如，
我们可能想用绝对值或者实数部分对复数类型排序。我们可以通过为该数据
类型定义两个操作符类来做到，并且在创建索引时选择其中合适的类。更多
有关操作符类的信息请见第 11.10 节以及第 36.16 节。
当在一个分区表上调用CREATE INDEX时，默认的行为是递归到所有的分区上以确保它们都具有匹配的索引。每一个分区首先会被检查是否有一个等效的索引存在，如果有则该索引将被挂接为被创建索引的一个分区索引，而被创建的索引将成为其父索引。如果不存在匹配的索引，则会创建一个新的索引并且自动进行挂接。如果命令中没有指定索引名称，每个分区中的新索引的名称将被自动决定。如果指定了ONLY选项，则不会进行递归，并且该索引会被标记为无效（一旦所有的分区都得到该索引，ALTER INDEX ... ATTACH PARTITION可以把该索引标记为有效）。不过，要注意不管是否指定这一选项，未来使用CREATE TABLE ... PARTITION OF创建的任何分区将自动有一个匹配的索引，不管有没有指定ONLY。
对于支持有序扫描的索引方法（当前只有 B-树），可以指定可选子句ASC、
DESC、NULLS FIRST以及NULLS LAST
来修改索引的排序顺序。由于一个有序索引能前向或者反向扫描，通常创建一个
单列DESC索引没什么用处 — 一个常规索引已经提供了排序
顺序。这些选项的价值是可以创建多列索引，让它的排序顺序匹配有混合排序要求
的查询，例如SELECT ... ORDER BY x ASC, y
DESC。如果你想要在依靠索引避免排序步骤的查询中支持
“空值排序低”这种行为，NULLS选项就能派上用场，默认
的行为是“空值排序高”。
系统定期收集表中所有列的统计信息。新创建的非表达式索引可以立即使用
这些统计数据来确定索引的有用性。对于新的表达式索引，需要运行
ANALYZE
或等待autovacuum守护程序分析表以
生成这些索引的统计信息。
当CREATE INDEX正在运行时，search_path会暂时更改为pg_catalog,
pg_temp。
对于大多数索引方法，索引的创建速度取决于
maintenance_work_mem的设置。较大的值将会减少
索引创建所需的时间，当然不要把它设置得超过实际可用的内存量（那会迫使
机器进行交换）。
PostgreSQL 可以在利用多个 CPU 的同时构建索引，以更快地处理表行。此功能称为 并行索引构建。对于支持并行构建索引的索引方法（目前为 B-tree、GIN 和 BRIN），maintenance_work_mem 指定每个索引构建操作作为整体可以使用的最大内存量，无论启动了多少个工作进程。通常，成本模型会自动确定应请求多少个工作进程（如果有的话）。
增加maintenance_work_mem可以让并行索引构建受益，而等效的串行索引构建将无法受益或者得到很小的益处。注意maintenance_work_mem可能会影响请求的工作进程的数量，因为并行工作者必须在总的maintenance_work_mem预算中占有至少32MB的份额。还必须有32MB的份额留给领导进程。增加max_parallel_maintenance_workers可以允许使用更多的工作者，这将降低索引创建所需的时间，只要索引构建不是I/O密集型的。当然，还需要有足够的CPU计算能力，否则工作者们会闲置。
通过ALTER TABLE为parallel_workers设置一个值直接控制着CREATE INDEX会对表请求多少并行工作者进程。这会完全绕过成本模型，并且防止maintenance_work_mem对请求多少并行工作者产生影响。通过ALTER TABLE将parallel_workers设置为0将禁用所有情况下的并行索引构建。
提示
在把parallel_workers用于调优一次索引构建之后，你可能想要重置parallel_workers。这可以避免对查询计划的无意更改，因为parallel_workers影响所有并行表扫描。
虽然带有CONCURRENTLY选项的CREATE INDEX支持并行构建并且没有特殊的限制，但只有第一次表扫描会实际以并行方式执行。
使用DROP INDEX来移除一个索引。
与任何长时间运行的事务一样，在表上执行CREATE INDEX可能会影响哪些元组可以被并发的VACUUM在任何其他表上移除。
以前的PostgreSQL发行也有一种 R-树索引方法。这种方法已经被移除，因为它比起 GiST 方法来说没有什么明显的优势。如果指定了USING rtree，CREATE INDEX将会把它解释为USING gist，以便把旧的数据库转换成 GiST。
每个运行CREATE INDEX的后端将在pg_stat_progress_create_index视图中报告其进度。有关详细信息，请参见第 27.4.4 节。
示例
在表films中的列title上创建一个B-树索引：
CREATE UNIQUE INDEX title_idx ON films (title);
要在表films的列title上创建一个唯一的B-树索引并且包括列director和rating：
CREATE UNIQUE INDEX title_idx ON films (title) INCLUDE (director, rating);
要创建禁用重复项的 B 树索引：
CREATE INDEX title_idx ON films (title) WITH (deduplicate_items = off);
在表达式lower(title)上创建一个索引，以允许高效的大小写
不敏感搜索：
CREATE INDEX ON films ((lower(title)));
（在这个例子中我们选择省略索引名称，这样系统会选择一个名字，
通常是films_lower_idx）。
创建一个具有非默认排序规则的索引：
CREATE INDEX title_idx_german ON films (title COLLATE "de_DE");
创建一个具有非默认空值排序顺序的索引：
CREATE INDEX title_idx_nulls_low ON films (title NULLS FIRST);
创建一个具有非默认填充因子的索引：
CREATE UNIQUE INDEX title_idx ON films (title) WITH (fillfactor = 70);
创建一个禁用快速更新的GIN索引：
CREATE INDEX gin_idx ON documents_table USING GIN (locations) WITH (fastupdate = off);
在表films中的列code上创建一个索引，并且
将索引放在表空间indexspace中：
CREATE INDEX code_idx ON films (code) TABLESPACE indexspace;
在一个点属性上创建一个 GiST 索引，这样我们可以在转换函数的结果
上有效地使用 box 操作符：
CREATE INDEX pointloc
ON points USING gist (box(location,location));
SELECT * FROM points
WHERE box(location,location) && '(0,0),(1,1)'::box;
创建一个索引而不排斥对表的写操作：
CREATE INDEX CONCURRENTLY sales_quantity_index ON sales_table (quantity);
兼容性
CREATE INDEX是一种
PostgreSQL的语言扩展。在 SQL 标准中
没有对于索引的规定。
另见ALTER INDEX, DROP INDEX, REINDEX, 第 27.4.4 节上一页 上一级 下一页CREATE GROUP 起始页 CREATE LANGUAGE
