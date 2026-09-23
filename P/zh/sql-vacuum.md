# VACUUM

VACUUM
版本：
纠错本页面
搜索
目录导航
❮
❯
VACUUMVACUUM — 垃圾收集并可选地分析一个数据库大纲
VACUUM [ ( option [, ...] ) ] [ table_and_columns [, ...] ]
其中 option 可以是以下之一：
FULL [ boolean ]
FREEZE [ boolean ]
VERBOSE [ boolean ]
ANALYZE [ boolean ]
DISABLE_PAGE_SKIPPING [ boolean ]
SKIP_LOCKED [ boolean ]
INDEX_CLEANUP { AUTO | ON | OFF }
PROCESS_MAIN [ boolean ]
PROCESS_TOAST [ boolean ]
TRUNCATE [ boolean ]
PARALLEL integer
SKIP_DATABASE_STATS [ boolean ]
ONLY_DATABASE_STATS [ boolean ]
BUFFER_USAGE_LIMIT size
并且 table_and_columns 是：
[ ONLY ] table_name [ * ] [ ( column_name [, ...] ) ]
描述
VACUUM收回由死亡元组占用的存储空间。在通常的PostgreSQL操作中，被删除或者被更新废弃的元组并没有在物理上从它们的表中移除，它们将一直存在直到一次VACUUM被执行。因此有必要周期性地做VACUUM，特别是在频繁被更新的表上。
在没有table_and_columns列表的情况下，VACUUM会处理当前用户具有清理权限的当前数据库中的每一个表和物化视图。如果给出一个列表，VACUUM只处理列表中的那些表。
VACUUM ANALYZE执行一次VACUUM，然后对每个选定的表执行一次ANALYZE。这是两种命令的一种方便的组合形式，可以用于例行的维护脚本。其处理细节可参考ANALYZE。
简单的 VACUUM（不带FULL）简单地收回空间并使其可以被重用。
这种形式的命令可以和表的普通读写操作并行，因为它不会获得一个排他锁。
但是，这种形式中额外的空间并没有被还给操作系统（在大多数情况下），它仅仅被保留在同一个表中以备重用。
它还允许我们利用多个 CPU 来处理索引。 此功能称为parallel vacuum。
要禁用此功能，可以使用PARALLEL选项并将并行工作程序指定为零。
VACUUM FULL将表的整个内容重写到一个新的磁盘文件中，并且不包含额外的空间，这使得没有被使用的空间被还给操作系统。
这种形式的命令更慢并且在其被处理时要求在每个表上保持一个ACCESS EXCLUSIVE 锁。
参数FULL
选择“完全”清理，它可以收回更多空间，并且需要更长时间和表上的排他锁。这种方法还需要额外的磁盘空间，因为它会创建该表的新拷贝，并且在操作完成之前都不会释放旧的拷贝。通常这种方法只用于需要从表中收回大量空间时。
FREEZE
选择激进的元组“冻结”。指定FREEZE
等价于参数vacuum_freeze_min_age和
vacuum_freeze_table_age设置为0的
VACUUM。当表被重写时总是会执行激进的冻结，
因此指定FULL时这个选项是多余的。
VERBOSE
打印每个表在INFO级别的详细清理活动报告。
ANALYZE
更新优化器用以决定最有效执行查询的方法的统计信息。
DISABLE_PAGE_SKIPPING
通常，VACUUM将基于可见性映射跳过页面。已知所有元组都被冻结的页面总是会被跳过，而那些所有元组对所有事务都可见的页面则可能会被跳过（除非执行的是激进的清理）。此外，除非在执行激进的清理时，一些页面也可能会被跳过，这样可避免等待其他会话完成对其使用。这个选项禁用所有的跳过页面的行为，其意图是只在可见性映射内容被怀疑时使用，这种情况只有在硬件或软件问题导致数据库损坏时才会发生。
SKIP_LOCKED
规定VACUUM在开始处理关系时不等待任何冲突锁被释放：如果关系不能立即锁定而不等待，则跳过关系。请注意即使采用此选项，VACUUM在打开关系的索引时仍可能阻塞。此外，VACUUM ANALYZE在从分区、继承子表和某些类型的外表获取示例行时，仍然可能阻塞。还有，虽然VACUUM通常处理指定分区表的所有分区，但如果分区表上的锁冲突，此选项将导致VACUUM跳过所有分区。
INDEX_CLEANUP
通常，当表中的死元组很少时，VACUUM将跳过索引清理。处理全部表索引的成本预计将大大超过删除死索引元组的好处。当多于零个死元组时，此选项可用于强制VACUUM处理索引。默认值是AUTO，这允许VACUUM在适当的时候跳过索引清理。如果INDEX_CLEANUP设置为ON，VACUUM将适当地从索引中删除所有死元组。这对于向后兼容PostgreSQL的早期版本是很有用的，在那里这是标准的行为。
INDEX_CLEANUP也可以设置为OFF来强制VACUUM 总是 略过索引清理，即使表中有许多死元组。
当需要使VACUUM尽可能快地运行，以避免临近的事务ID回卷时，这可能很有用(参见第 24.1.5 节)。
然而，由vacuum_failsafe_age控制的回卷失效保护机制通常会自动触发，以避免事务ID回卷失败，并且应优先考虑。
如果索引清理不被定期执行，性能可能会变差，
因为当表被修改时，索引会累积死元组，并且表自己也会累积死行指针，这些在索引清理完成之前无法删除。
该选项对没有索引的表无影响，并且如果使用了FULL选项就会被忽略。
它对事务ID回卷失效保护机制也没有影响。
当触发时会略过索引清理，即使INDEX_CLEANUP设置为ON。
PROCESS_MAIN
指定VACUUM应尝试处理主关系。这通常是期望的行为，
并且是默认设置。将此选项设置为false可能在仅需要清理关系对应的
TOAST表时很有用。
PROCESS_TOAST
指定VACUUM应尝试处理每个关系对应的
TOAST表（如果存在）。这通常是期望的行为，
也是默认行为。当只需要清理主关系时，将此选项设为false可能会有用。
使用FULL选项时必须设置此选项。
TRUNCATE
指定VACUUM应该尝试截断表末尾的任何空页面，并允许
被截断页面的磁盘空间返回给操作系统。这通常是期望的行为，
并且是默认设置，除非vacuum_truncate
被设置为false，或者要进行VACUUM的表的
vacuum_truncate选项被设置为false。
将此选项设置为false可能有助于避免
ACCESS EXCLUSIVE锁，这种锁是截断所需的。
如果使用了FULL选项，则此选项将被忽略。
PARALLEL
使用integer后台工作进程并行执行VACUUM
的索引清理和索引清理阶段（每个清理阶段的详细信息请参考表 27.46）。
用于执行操作的工作进程数量等于关系上支持并行清理的索引数量，该数量受PARALLEL
选项指定的工作进程数量的限制，如果有的话，该数量还受到max_parallel_maintenance_workers限制。
当且仅当索引的大小大于min_parallel_index_scan_size时，索引才能参与并行清理。
请注意，不保证在执行期间会使用integer中指定的并行工作进程数。
清理运行时可能需要比指定的更少的工作进程，甚至根本没有工作进程。每个索引只能使用一个工作进程。
所以只有当表中至少有2个索引时才会启动并行工作进程。
在每个阶段开始之前启动清理工作进程，并在阶段结束时退出。这些行为可能会在未来的版本中发生变化。
此选项不能与FULL选项一起使用。
SKIP_DATABASE_STATS
指定VACUUM应跳过更新有关最旧未冻结XID的数据库全局统计信息。
通常，VACUUM会在命令结束时更新这些统计信息。然而，在拥有大量表
的数据库中，这可能需要一些时间，并且除非包含最旧未冻结XID的表在被清理的表之列，
否则不会有任何效果。此外，如果多个VACUUM命令并行执行，则一次
只能有一个命令更新数据库全局统计信息。因此，如果一个应用程序计划发出一系列
VACUUM命令，那么在最后一个命令之前的所有命令中设置此选项可能会
很有帮助；或者在所有命令中都设置此选项，然后单独执行
VACUUM (ONLY_DATABASE_STATS)。
ONLY_DATABASE_STATS
指定VACUUM只执行更新关于最旧未冻结XIDs的数据库全局统计信息。
当指定此选项时，
table_and_columns
列表必须为空，并且除了VERBOSE之外，
不能启用其他选项。
BUFFER_USAGE_LIMIT
指定
缓冲区访问策略
的环形缓冲区大小，用于VACUUM。此大小用于计算作为
此策略一部分将被重用的共享缓冲区数量。0表示禁用
缓冲区访问策略的使用。如果同时指定了ANALYZE，
则BUFFER_USAGE_LIMIT值将用于清理和分析阶段。此选项不能与
FULL选项一起使用，除非也指定了ANALYZE。
如果未指定此选项，VACUUM将使用
vacuum_buffer_usage_limit中的值。较高的设置可以使
VACUUM运行得更快，但设置过大可能会导致太多其他有用的页面
从共享缓冲区中被驱逐。最小值为128 kB，最大值为
16 GB。
boolean
指定打开还是关闭所选选项。你可以写入TRUE、ON或
1以启用该选项，以及FALSE、OFF或0来禁用它。
在省略boolean值的情况下，TRUE被假定。
integer
指定传递给所选选项的非负整数值。
size
指定以千字节为单位的内存量。大小也可以指定为一个包含数字大小的字符串，
后跟以下任意一个内存单位：B（字节），
kB（千字节），MB（兆字节），
GB（千兆字节），或TB（太字节）。
table_name
要进行 VACUUM 的特定表或物化视图的名称（可选的模式限定）。如果在表名之前指定了
ONLY，则仅对该表进行 VACUUM。如果
没有指定 ONLY，则该表及其所有继承子表或分区（如果有）也会被 VACUUM。
可选地，可以在表名后指定 * 以明确表示要进行 VACUUM 的继承子表
（或分区）。
column_name
要分析的指定列的名称。缺省是所有列。如果指定了一个列的列表，则ANALYZE也必须被指定。
输出
如果声明了VERBOSE，VACUUM会发出进度消息来表明当前正在处理哪个表。各种有关这些表的统计信息也会打印出来。
注意
要清理一个表，通常必须拥有该表的MAINTAIN权限。
但是，数据库所有者被允许清理其数据库中的所有表，除了共享目录。
VACUUM会跳过调用用户无权清理的任何表。
当VACUUM正在运行时，search_path会暂时更改为pg_catalog,
pg_temp。
VACUUM不能在一个事务块内执行。
对具有GIN索引的表，VACUUM（任何形式）也会通过将待处理索引项移动到主要GIN索引结构中的合适位置来完成任何待处理的索引插入。详见第 65.4.4.1 节。
我们建议定期对所有数据库进行清理，以删除死行。 PostgreSQL包括一个“autovacuum”设施，可以自动化常规清理维护。有关自动和手动清理的更多信息，请参阅第 24.1 节。
日常使用时，不推荐FULL选项，但在特殊情况下它可能会有用。一个例子是当你删除或更新了一个表中的绝大部分行时，如果你希望在物理上收缩表以减少磁盘空间占用并允许更快的表扫描，则该选项是比较合适的。VACUUM FULL通常会比简单VACUUM更多地收缩表。
PARALLEL选项仅用于清理目的。如果此选项与ANALYZE选项一起指定，则不会影响ANALYZE。
VACUUM会导致I/O流量的大幅度增加，这可能导致其他活动会话性能变差。因此，有时建议使用基于成本的清理延迟特性。
对于并行清理，每个工作线程的睡眠与该工作线程完成的工作成比例。详情请参阅第 19.10.2 节。
每个后端运行没有FULL选项的VACUUM时，将在pg_stat_progress_vacuum视图中报告它的进度。
运行VACUUM FULL的后端将改为在pg_stat_progress_cluster视图中报告它的进度。
详见第 27.4.5 节和第 27.4.2 节。
示例
清理单一表onek，为优化器分析它并打印出详细的清理活动报告：
VACUUM (VERBOSE, ANALYZE) onek;
兼容性
在SQL标准中没有VACUUM语句。
以下语法用于PostgreSQL 9.0版本之前，且仍然支持：
VACUUM [ FULL ] [ FREEZE ] [ VERBOSE ] [ ANALYZE ] [ table_and_columns [, ...] ]
注意，在此语法中，选项必须按所示顺序准确指定。
另请参阅vacuumdb, 第 19.10.2 节, 第 24.1.6 节, 第 27.4.5 节, 第 27.4.2 节上一页 上一级 下一页UPDATE 起始页 VALUES
