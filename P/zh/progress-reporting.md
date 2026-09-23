# 27.4. 进度报告

27.4. 进度报告
版本：
纠错本页面
搜索
目录导航
❮
❯
27.4. 进度报告 #27.4.1. ANALYZE 进度报告27.4.2. CLUSTER 进度报告27.4.3. COPY 进度报告27.4.4. CREATE INDEX 进度报告27.4.5. VACUUM 进度报告27.4.6. 基础备份进度报告
PostgreSQL具有在命令执行过程中报告某些命令进度的能力。
目前，支持进度报告的命令只有ANALYZE,CLUSTER,CREATE INDEX, VACUUM,COPY,
和 BASE_BACKUP(即 pg_basebackup 发出的进行基础备份的复制命令)。
未来可能还会扩展。
27.4.1. ANALYZE 进度报告 #
每当ANALYZE运行时，pg_stat_progress_analyze视图将包含当前运行该命令的每个后端的一行。
下面的表描述了将要报告的信息，并提供了关于如何解释它们的信息。
表 27.38. pg_stat_progress_analyze 视图
列类型
描述
pid integer
后端的进程 ID。
datid oid
后端连接到的数据库的OID。
datname name
后端连接到的数据库的名称。
relid oid
被分析的表的OID。
phase text
当前处理阶段。参见 表 27.39。
sample_blks_total bigint
将被采样的堆块的总数。
sample_blks_scanned bigint
扫描的堆块数量。
ext_stats_total bigint
扩展统计信息的数量。
ext_stats_computed bigint
已经计算的扩展统计的数量。此计数器仅在 computing extended statistics 阶段增进。
child_tables_total bigint
子表数量。
child_tables_done bigint
扫描的子表数。此计数器只有在acquiring inherited sample rows阶段才会增加。
current_child_table_relid oid
当前正在扫描的子表的OID。此字段仅在acquiring inherited sample rows阶段有效。
delay_time double precision
由于基于成本的延迟而花费的总睡眠时间（请参见
第 19.10.2 节），以毫秒为单位
（如果 track_cost_delay_timing 被启用，则为此值，否则为零）。
表 27.39. ANALYZE 阶段阶段描述initializing
命令正在准备开始扫描堆。此阶段预计会非常短暂。
acquiring sample rows
该命令当前正在扫描relid给出的表以获取示例行。
acquiring inherited sample rows
该命令当前正在扫描子表以获得示例行。列child_tables_total,
child_tables_done，和current_child_table_relid包含此阶段的进度信息。
computing statistics
该命令从表扫描期间获得的样本行计算统计信息。
computing extended statistics
该命令从表扫描期间获得的样本行计算扩展统计信息。
finalizing analyze
该命令在更新pg_class。当此阶段完成时，ANALYZE将结束。
注意
请注意，当对一个分区表运行 ANALYZE 而不使用
ONLY 关键字时，它的所有分区也会被递归分析。
在这种情况下，ANALYZE 的进度首先报告父表，
收集其继承统计信息，然后是每个分区的进度。
27.4.2. CLUSTER 进度报告 #
每当CLUSTER或VACUUM FULL运行时，pg_stat_progress_cluster视图将包含当前正在运行的每一个后台的记录。下面的表格描述了将被报告的信息，并提供了关于如何解释这些信息的信息。
表 27.40. pg_stat_progress_cluster 视图
列类型
描述
pid integer
后端的进程 ID。
datid oid
后端连接到的数据库的 OID。
datname name
后端连接到的数据库的名称。
relid oid
被集簇的表的 OID。
command text
正在运行的命令。CLUSTER 或 VACUUM FULL。
phase text
当前处理阶段。参见 表 27.41。
cluster_index_relid oid
如果正在使用索引对表进行扫描，这就是正在使用的索引的OID；否则为0。
heap_tuples_scanned bigint
扫描的堆元组数。
这个计数器只有在阶段为seq scanning heap,
index scanning heap
或 writing new heap时才会增进。
heap_tuples_written bigint
写入的堆元组的数量。这个计数器只有在阶段为seq scanning heap,
index scanning heap
或 writing new heap时才会前进。
heap_blks_total bigint
表中的堆块总数。 这个数字是在seq scanning heap的开始时报告的。
heap_blks_scanned bigint
扫描的堆块数量。 这个计数器只有在阶段为seq scanning heap时才会增进。
index_rebuild_count bigint
重建的索引数。 该计数器仅在阶段为rebuilding index时才会增进。
表 27.41. CLUSTER 和 VACUUM FULL 阶段阶段描述initializing
该命令准备开始扫描堆。 这个阶段预计会非常短暂。
seq scanning heap
该命令目前采用顺序扫描的方式对表进行扫描。
index scanning heap
CLUSTER目前正在使用索引扫描表。
sorting tuples
CLUSTER目前正在对元组进行排序。
writing new heap
CLUSTER目前正在写入新的堆。
swapping relation files
目前，该命令正在将新建立的文件调换到位。
rebuilding index
该命令目前正在重建一个索引。
performing final cleanup
该命令正在执行最后的清理工作。 当此阶段完成后，CLUSTER或VACUUM FULL将结束。
27.4.3. COPY 进度报告 #
当COPY正在运行时，pg_stat_progress_copy视图将包含一行
为当前正在运行COPY命令的每个后端。
下表描述了将被报告的信息，并提供了如何解释它的信息。
表 27.42. pg_stat_progress_copy 视图
列类型
描述
pid integer
后端的进程 ID。
datid oid
后端连接到的数据库的 OID。
datname name
后端连接到的数据库的名称。
relid oid
执行COPY命令的表的OID。如果从SELECT查询中复制，它被设置为0。
command text
正在运行的命令：COPY FROM，或COPY TO。
type text
数据读取或写入的I/O类型：FILE，PROGRAM，PIPE（用于COPY FROM STDIN和COPY TO STDOUT），或CALLBACK（例如在逻辑复制的初始表同步期间使用）。
bytes_processed bigint
已经被COPY命令处理的字节数。
bytes_total bigint
COPY FROM命令的源文件大小，以字节计。如果不可用则设置为0。
tuples_processed bigint
已经被COPY命令处理的元组数。
tuples_excluded bigint
没有处理的元组数，因为它们被COPY命令的WHERE子句所排除。
tuples_skipped bigint
跳过的元组数量，因为它们包含格式错误的数据。只有当为ON_ERROR选项指定了除stop以外的值时，此计数器才会增加。
27.4.4. CREATE INDEX 进度报告 #
每当运行CREATE INDEX或REINDEX时，pg_stat_progress_create_index视图将包含当前正在创建索引的每个后端的一行。 下面的表描述了将要报告的信息，并提供了关于如何解释它的信息。
表 27.43. pg_stat_progress_create_index 视图
列类型
描述
pid integer
创建索引的后端的进程 ID。
datid oid
后端连接到的数据库的 OID。
datname name
后端连接到的数据库的名称。
relid oid
正在创建索引的表的OID。
index_relid oid
正在创建或重建索引的OID。在非并发 CREATE INDEX 时，此为 0。
command text
特定的命令类型：CREATE INDEX、
CREATE INDEX CONCURRENTLY、
REINDEX或REINDEX CONCURRENTLY。
phase text
索引创建的当前处理阶段。 参见 表 27.44。
lockers_total bigint
在适用的情况下，需要等待的储物柜总数。
lockers_done bigint
已经等待的储物柜数量。
current_locker_pid bigint
目前正在等待的储物柜的进程ID。
blocks_total bigint
本阶段要处理的区块总数。
blocks_done bigint
当前阶段已经处理的区块数量。
tuples_total bigint
当前阶段要处理的元组总数。
tuples_done bigint
当前阶段已经处理的元组数量。
partitions_total bigint
要创建或附加索引的分区总数，包括直接和间接分区。
0 表示在 REINDEX 期间，或者当索引未被分区时。
partitions_done bigint
已经创建或附加索引的分区数量，包括直接和间接分区。
0 表示在 REINDEX 期间，或者当索引未被分区时。
表 27.44. CREATE INDEX Phases阶段描述初始化
CREATE INDEX或REINDEX正在准备创建索引。 这个阶段预计会非常短暂。
构建前等待读写器
CREATE INDEX CONCURRENTLY或REINDEX CONCURRENTLY正在等待有可能看到表的写锁的事务完成。 当不在并发模式时，这个阶段会被跳过。lockers_total、lockers_done和current_locker_pid列包含了这个阶段的进度信息。
新建索引
索引是由访问方法专用代码建立的。 在这一阶段，支持进度报告的访问方法填写自己的进度数据，子阶段在这一栏中表示。 通常情况下，blocks_total和blocks_done将包含进度数据，也可能包含tuples_total和tuples_done。
在验证前等待读写器
CREATE INDEX CONCURRENTLY或REINDEX CONCURRENTLY正在等待有可能写入表的事务完成。 当不在并发模式时，这个阶段会被跳过。lockers_total、lockers_done和current_locker_pid列包含了这个阶段的进度信息。
索引验证：扫描索引
CREATE INDEX CONCURRENTLY正在扫描索引，搜索需要验证的元组。 当不在并发模式时，这个阶段会被跳过。blocks_total（设置为索引的总大小）和blocks_done列包含了这个阶段的进度信息。
索引验证：排序元组
CREATE INDEX CONCURRENTLY正在对索引扫描阶段的输出进行排序。
索引验证：扫描表
CREATE INDEX CONCURRENTLY正在扫描表，以验证前两个阶段收集的索引元组。 当不在并发模式时，这个阶段被跳过。blocks_total（设置为表的总大小）和blocks_done列包含这个阶段的进度信息。
等待旧快照
CREATE INDEX CONCURRENTLY或REINDEX CONCURRENTLY正在等待可能看到表的事务释放快照。 当不处于并发模式时，这个阶段会被跳过。lockers_total、lockers_done和current_locker_pid列包含了这个阶段的进度信息。
在标记死之前等待读者
REINDEX CONCURRENTLY正在等待表上有读锁的事务完成后，再将旧索引标记为死索引。 当不在并发模式时，这个阶段被跳过。lockers_total、lockers_done和current_locker_pid列包含了这个阶段的进度信息。
在丢弃之前等待读者
REINDEX CONCURRENTLY等待表上有读锁的事务完成后，再丢弃旧索引。当不在并发模式时，这个阶段被跳过。列 lockers_total、lockers_done 和 current_locker_pid包含了这个阶段的进度信息。
27.4.5. VACUUM 进度报告 #
每当VACUUM正在运行时，
pg_stat_progress_vacuum视图将包含
每个后端（包括自动清理工作进程）当前正在清理的行。
下表描述了将报告的信息，并提供了如何解释这些信息的说明。
VACUUM FULL命令的进度通过
pg_stat_progress_cluster报告，
因为VACUUM FULL和CLUSTER
都会重写表，而常规VACUUM仅在原地修改表。
请参见第 27.4.2 节。
表 27.45. pg_stat_progress_vacuum 视图
列类型
描述
pid integer
后端的进程 ID。
datid oid
后端连接到的数据库的 OID。
datname name
后端连接到的数据库名称。
relid oid
被清理的表的OID。
phase text
vacuum的当前处理阶段。参见 表 27.46。
heap_blks_total bigint
该表中堆块的总数。这个数字在扫描开始时报告，之后增加的块将不会（并且不需要）被这个VACUUM访问。
heap_blks_scanned bigint
被扫描的堆块数量。由于可见性映射被用来优化扫描，一些块将被跳过而不做检查，
被跳过的块会被包括在这个总数中，因此当清理完成时这个数字最终将会等于heap_blks_total。
仅当处于扫描堆阶段时这个计数器才会前进。
heap_blks_vacuumed bigint
被清理的堆块数量。除非表没有索引，这个计数器仅在处于清理堆阶段时才会前进。
不包含死亡元组的块会被跳过，因此这个计数器可能有时会向前跳跃一个比较大的增量。
index_vacuum_count bigint
已完成的索引清理周期数。
max_dead_tuple_bytes bigint
在需要执行索引清理周期之前，我们可以存储的死元组数据量，基于
maintenance_work_mem。
dead_tuple_bytes bigint
自上次索引清理周期以来收集的死元组数据量。
num_dead_item_ids bigint
自上次索引清理周期以来收集的死项标识符数量。
indexes_total bigint
将被清理或整理的索引总数。该数字在
vacuuming indexes 阶段开始时报告，或在
cleaning up indexes 阶段报告。
indexes_processed bigint
已处理的索引数量。此计数器仅在阶段为
vacuuming indexes 或
cleaning up indexes 时递增。
delay_time double precision
由于基于成本的延迟而花费的总睡眠时间（请参见
第 19.10.2 节），以毫秒为单位
（如果 track_cost_delay_timing 被启用，则为此值，否则为零）。这包括任何相关并行工作者的
睡眠时间。然而，并行工作者报告其睡眠时间的频率不超过每秒一次，因此报告的值可能会稍显过时。
表 27.46. VACUUM阶段阶段描述initializing
VACUUM正在准备开始扫描堆。这个阶段应该很简短。
扫描堆
VACUUM正在扫描堆。如果需要，它将会对每个页面进行修建以及碎片整理，并且可能会执行冻结活动。heap_blks_scanned列可以用来监控扫描的进度。
清理索引
VACUUM当前正在清理索引。
如果一个表拥有索引，那么每次清理时这个阶段会在堆扫描完成后至少发生一次。
如果maintenance_work_mem不足以存放找到的死亡元组（或者，在autovacuum情况下，如果设置了autovacuum_work_mem），则每次清理时会多次清理索引。
清理堆
VACUUM当前正在清理堆。清理堆与扫描堆不是同一个概念，清理堆发生在每一次清理索引的实例之后。如果heap_blks_scanned小于heap_blks_total，系统将在这个阶段完成之后回去扫描堆；否则，系统将在这个阶段完成后开始清理索引。
清理索引
VACUUM当前正在清理索引。这个阶段发生在堆被完全扫描并且对堆和索引的所有清理都已经完成以后。
截断堆
VACUUM正在截断堆，以便把关系尾部的空页面返还给操作系统。这个阶段发生在清理完索引之后。
执行最终清理
VACUUM正在执行最终清理。在此阶段，VACUUM将清理空闲空间映射，
更新pg_class中的统计信息，并向累积统计系统报告统计信息。当此阶段完成时，
VACUUM将结束。
27.4.6. 基础备份进度报告 #
每当像pg_basebackup这样的应用程序进行基本备份时，
pg_stat_progress_basebackup视图将包含当前运行BASE_BACKUP复制命令和流备份的每个WAL发送进程的一行。
下面的表描述了将要报告的信息，并提供了关于如何解释它的信息。
表 27.47. pg_stat_progress_basebackup 视图
列类型
描述
pid integer
WAL发送方进程ID。
phase text
目前的处理阶段。 参见 表 27.48。
backup_total bigint
将被流输送的数据总量。这是在streaming database files阶段开始时的估计和报告。
注意，这只是一个近似值，因为在streaming database files阶段，数据库可能会改变，而WAL日志可能会在稍后的备份中包含。
一旦流数据量超过了估计的总大小，该值始终与backup_streamed相同。
如果在pg_basebackup中禁用估算（也就是说，指定了--no-estimate-size选项），这为NULL。
backup_streamed bigint
数据流的总量。这个计数器只在streaming database files阶段或transferring wal files时增加。
tablespaces_total bigint
要流输送的表空间总数。
tablespaces_streamed bigint
流输送的表空间数。此计数器仅在streaming database files阶段增加。
表 27.48. 基本备份阶段阶段描述initializing
WAL发送器进程正在准备开始备份。这个阶段预计会非常短暂。
waiting for checkpoint to finish
WAL发送进程当前正在执行pg_backup_start以准备进行基本备份，并等待开始备份的检查点完成。
estimating backup size
WAL发送程序目前正在估计将作为基础备份流传输的数据库文件的总量。
streaming database files
WAL发送器当前正在流数据库文件作为基础备份。
waiting for wal archiving to finish
WAL发送进程当前正在执行pg_backup_stop以完成备份，
并等待所有用于基本备份的WAL文件成功归档。
如果在pg_basebackup中指定了--wal-method=none或
--wal-method=stream，备份将在此阶段完成时结束。
transferring wal files
WAL发送器进程正在传输备份过程中产生的所有WAL日志。
如果pg_basebackup中指定了--wal-method=fetch，
则该阶段发生在waiting for wal archiving to finish阶段之后。当此阶段完成时备份将结束。
上一页 上一级 下一页27.3. 查看锁 起始页 27.5. 动态追踪
