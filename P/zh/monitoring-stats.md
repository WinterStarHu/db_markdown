# 27.2. 累计统计系统

27.2. 累计统计系统
版本：
纠错本页面
搜索
目录导航
❮
❯
27.2. 累计统计系统 #27.2.1. 统计收集配置27.2.2. 查看统计信息27.2.3. pg_stat_activity27.2.4. pg_stat_replication27.2.5. pg_stat_replication_slots27.2.6. pg_stat_wal_receiver27.2.7. pg_stat_recovery_prefetch27.2.8. pg_stat_subscription27.2.9. pg_stat_subscription_stats27.2.10. pg_stat_ssl27.2.11. pg_stat_gssapi27.2.12. pg_stat_archiver27.2.13. pg_stat_io27.2.14. pg_stat_bgwriter27.2.15. pg_stat_checkpointer27.2.16. pg_stat_wal27.2.17. pg_stat_database27.2.18. pg_stat_database_conflicts27.2.19. pg_stat_all_tables27.2.20. pg_stat_all_indexes27.2.21. pg_statio_all_tables27.2.22. pg_statio_all_indexes27.2.23. pg_statio_all_sequences27.2.24. pg_stat_user_functions27.2.25. pg_stat_slru27.2.26. Statistics Functions
PostgreSQL的累积统计系统支持收集和报告有关服务器活动的信息。
目前，对表和索引的访问以磁盘块和单个行的术语进行计数。每个表中的总行数，
以及每个表的清理和分析操作的信息也被计数。如果启用，对用户定义函数的调用
和每个函数中花费的总时间也会被计数。
PostgreSQL也支持报告关于系统当前正在发生的情况的动态信息，
例如其他服务器进程当前正在执行的确切命令，以及系统中存在哪些其他连接。此功能独立于累积统计系统。
27.2.1. 统计收集配置 #
因为统计收集给查询执行增加了一些负荷，系统可以被配置为收集或不收集信息。这由配置参数控制，它们通常在postgresql.conf中设置（关于设置配置参数的细节请见第 19 章）。
参数track_activities允许监控当前被任意服务器进程执行的命令。
参数 track_cost_delay_timing 启用
基于成本的清理延迟监控。
参数track_counts控制是否收集关于表和索引访问的累积统计信息。
参数track_functions启用对用户定义函数使用的跟踪。
参数 track_io_timing 启用对块读取、写入、扩展和
fsync 时间的监控。
参数 track_wal_io_timing 启用 WAL 读取、写入和 fsync 时间的监控。
通常这些参数被设置在postgresql.conf中，这样它们会应用于所有服务器进程，但是可以在单个会话中使用SET命令打开或关闭它们（为了阻止普通用户对管理员隐藏他们的活动，只有超级用户被允许使用SET来改变这些参数）。
累积统计数据存储在共享内存中。每个PostgreSQL进程在本地收集统计数据，
然后在适当的间隔更新共享数据。当服务器，包括物理副本，正常关闭时，统计数据的永久副本存储在
pg_stat子目录中，以便统计数据可以在服务器重新启动时保留。相反，当从不干净的
关闭开始（例如，立即关闭后，服务器崩溃，从基本备份开始和时间点恢复），所有统计计数器都会被重置。
27.2.2. 查看统计信息 #
有几个预定义的视图，列在表 27.1中，
可用于显示系统的当前状态。还有几个其他视图，列在表 27.2中，可用于显示累积统计信息。
或者，可以使用底层的累积统计函数构建自定义视图，如在第 27.2.26 节中讨论的那样。
当使用累积统计视图和函数来监视收集的数据时，重要的是要意识到信息不会立即更新。每个单独的服务器进程在空闲之前将累积的统计信息刷新到共享内存中，但不会频繁于每PGSTAT_MIN_INTERVAL毫秒（1秒，除非在构建服务器时更改）一次；因此，仍在进行中的查询或事务不会影响显示的总计，显示的信息滞后于实际活动。然而，由track_activities收集的当前查询信息始终是最新的。
另一个重要点是，当服务器进程被要求显示任何累积的统计信息时，默认配置下
访问的值会被缓存直到当前事务结束。因此，只要你继续当前事务，统计信息将
显示静态信息。类似地，所有会话当前查询的信息在事务内首次请求时被收集，
并且在整个事务期间显示相同的信息。这是一个特性，而非缺陷，因为它允许你
对统计信息执行多个查询并关联结果，而无需担心数据在背后发生变化。
在交互式分析统计信息或使用开销较大的查询时，访问单个统计信息之间的时
间差可能导致缓存统计数据出现显著偏差。为最小化偏差，可以将
stats_fetch_consistency 设置为 snapshot，
代价是增加了缓存不必要统计数据的内存使用。相反，如果已知统计信息只被
访问一次，则缓存访问过的统计信息是不必要的，可以通过将
stats_fetch_consistency 设置为 none 来避免。
你可以调用 pg_stat_clear_snapshot() 来丢弃当前事务的
统计快照或缓存值（如果有）。下一次使用统计信息时（在快照模式下）将构建
新快照，或（在缓存模式下）缓存访问过的统计信息。
事务还可以在视图pg_stat_xact_all_tables、
pg_stat_xact_sys_tables、
pg_stat_xact_user_tables和
pg_stat_xact_user_functions中看到自己的统计信息
（尚未刷新到共享内存统计信息）。这些数字不像上面所述那样起作用；
相反，它们在事务期间持续更新。
在 表 27.1 中显示的动态统计视图中的一些信息是安全受限的。
普通用户只能看到他们自己会话的所有信息
（属于他们所属于角色的会话）。在其他会话的行中，许多列将为 NULL。
但是，请注意，会话的存在及其一般属性，例如会话用户
和数据库对所有用户可见。超级用户和具有内置角色
pg_read_all_stats
权限的角色可以看到所有会话的所有信息。
表 27.1. 动态统计视图视图名称描述
pg_stat_activity
每个服务器进程一行，显示与该进程的当前活动相关的信息，例如状态和当前查询。详见
pg_stat_activity。
pg_stat_replication每个 WAL 发送进程一行，显示有关到该发送进程连接的备用服务器的复制的统计信息。详见pg_stat_replication。
pg_stat_wal_receiver只有一行，显示来自 WAL 接收器所连接服务器的有关该接收器的统计信息。详见
pg_stat_wal_receiver。
pg_stat_recovery_prefetch只有一行，显示了恢复过程中预取的块的统计信息。详见
pg_stat_recovery_prefetch。
pg_stat_subscription每个订阅至少一行，显示有关该订阅的工作者的信息。详见
pg_stat_subscription。
pg_stat_ssl每个连接（常规和复制）一行，显示在该连接上使用的 SSL 的信息。详见
pg_stat_ssl。
pg_stat_gssapi每个连接（常规和复制）一行，显示关于 GSSAPI 验证和加密的信息。详见
pg_stat_gssapi。
pg_stat_progress_analyze每个正在运行ANALYZE的后台进程（包括自动清理工作进程）对应一行，
显示当前进度。
请参阅第 27.4.1 节。
pg_stat_progress_create_index每个正在运行CREATE INDEX或REINDEX的后端对应一行，显示
当前进度。
请参阅第 27.4.4 节。
pg_stat_progress_vacuum每个正在运行VACUUM的后台进程（包括自动清理工作进程）对应一行，
显示当前进度。
请参阅第 27.4.5 节。
pg_stat_progress_cluster每个正在运行
CLUSTER或VACUUM FULL的后台进程对应一行，显示当前进度。
请参阅第 27.4.2 节。
pg_stat_progress_basebackup每个正在流式传输基础备份的WAL发送进程对应一行，
显示当前进度。
请参阅第 27.4.6 节。
pg_stat_progress_copy每个正在运行COPY的后台进程对应一行，显示当前进度。
请参阅第 27.4.3 节。
表 27.2. 收集的统计信息视图视图名称描述pg_stat_archiver只有一行，显示有关 WAL 归档进程活动的统计信息。详见
pg_stat_archiver。
pg_stat_bgwriter只有一行，显示有关后台写进程活动的统计信息。详见
pg_stat_bgwriter。
pg_stat_checkpointer只有一行，显示有关检查点进程活动的统计信息。详见
pg_stat_checkpointer。
pg_stat_database每个数据库一行，显示数据库范围的统计信息。详见
pg_stat_database。
pg_stat_database_conflicts
每个数据库一行，显示数据库范围的统计信息，
这些信息的内容是关于由于与后备服务器的恢复过程
发生冲突而被取消的查询。详见
pg_stat_database_conflicts。
pg_stat_io
每个后端类型、上下文和目标对象的组合对应一行，
包含集群范围的 I/O 统计信息。
详见
pg_stat_io。
pg_stat_replication_slots每个复制槽一行，显示关于复制槽的利用率的统计信息。
详见
pg_stat_replication_slots。
pg_stat_slru每个 SLRU 一行，显示操作的统计信息。详见
pg_stat_slru。
pg_stat_subscription_stats每个订阅一行，显示有关错误和冲突的统计信息。
有关详细信息，请参见
pg_stat_subscription_stats。
pg_stat_wal仅一行，显示WAL活动的统计信息。
有关详细信息，请参见
pg_stat_wal。
pg_stat_all_tables
当前数据库中每个表一行，显示有关访问指定表的统计信息。
有关详细信息，请参见
pg_stat_all_tables。
pg_stat_sys_tables和pg_stat_all_tables一样，但只显示系统表。pg_stat_user_tables和pg_stat_all_tables一样，但只显示用户表。pg_stat_xact_all_tables和pg_stat_all_tables相似，但计数动作只在当前事务内发生（还没有被包括在pg_stat_all_tables和相关视图中）。用于生存和死亡行数量的列以及清理和分析动作在此视图中不出现。pg_stat_xact_sys_tables和pg_stat_xact_all_tables一样，但只显示系统表。pg_stat_xact_user_tables和pg_stat_xact_all_tables一样，但只显示用户表。pg_stat_all_indexes
当前数据库中的每个索引一行，显示与访问指定索引有关的统计信息。
详见
pg_stat_all_indexes。
pg_stat_sys_indexes和pg_stat_all_indexes一样，但只显示系统表上的索引。pg_stat_user_indexes和pg_stat_all_indexes一样，但只显示用户表上的索引。pg_stat_user_functions
每一个被跟踪的函数一行，显示与执行该函数有关的统计信息。详见
pg_stat_user_functions。
pg_stat_xact_user_functions和pg_stat_user_functions相似，但是只统计在当前事务期间的调用（还没有被包括在pg_stat_user_functions中）。pg_statio_all_tables
当前数据库中的每个表一行，显示有关在指定表上 I/O 的统计信息。详见
pg_statio_all_tables。
pg_statio_sys_tables和pg_statio_all_tables一样，但只显示系统表。pg_statio_user_tables和pg_statio_all_tables一样，但只显示用户表。pg_statio_all_indexes
当前数据库中每个索引一行，显示与指定索引上的 I/O 有关的统计信息。
详见
pg_statio_all_indexes。
pg_statio_sys_indexes和pg_statio_all_indexes一样，但只显示系统表上的索引。pg_statio_user_indexes和pg_statio_all_indexes一样，但只显示用户表上的索引。pg_statio_all_sequences
当前数据库中每个序列一行，显示与指定序列上的 I/O 有关的统计信息。
详见
pg_statio_all_sequences。
pg_statio_sys_sequences和pg_statio_all_sequences一样，但只显示系统序列（目前没有定义系统序列，因此这个视图总是为空）。pg_statio_user_sequences和pg_statio_all_sequences一样，但只显示用户序列。
针对每个索引的统计信息对于判断哪个索引正在被使用以及它们的效果特别有用。
pg_stat_io和pg_statio_视图集对于
确定缓冲区缓存的有效性非常有用。它们可以用来计算缓存命中率。请注意，虽然
PostgreSQL的I/O统计捕获了大多数调用内核以执行
I/O的情况，但它们无法区分需要从磁盘获取的数据和已经驻留在内核页面缓存中的
数据。建议用户将PostgreSQL统计视图与操作系统
工具结合使用，以更全面地了解其数据库的I/O性能。
27.2.3. pg_stat_activity #
pg_stat_activity视图每个服务器进程将有一行，显示与该进程当前活动相关的信息。
表 27.3. pg_stat_activity 视图
列类型
描述
datid oid
这个后端连接到的数据库的OID
datname name
这个后端连接到的数据库的名称
pid integer
这个后端的进程 ID
leader_pid integer
如果此进程是并行查询工作者，则为并行组领导者的进程 ID；如果此进程是并行应用
工作者，则为领导应用工作者的进程 ID。NULL 表示此进程是并行组
领导者或领导应用工作者，或者不参与任何并行操作。
usesysid oid
登录到这个后端的用户的 OID
usename name
登录到这个后端的用户的名称
application_name text
连接到这个后端的应用程序的名称
client_addr inet
连接到这个后端的客户端的 IP 地址。如果这个字段为空，它表示客户端通过服务器机器上的一个 Unix 套接字连接或者这是一个内部进程，如自动清理。
client_hostname text
已连接的客户端的主机名，由client_addr的反向 DNS 查找报告。
这个字段将只对 IP 连接非空，并且只有 log_hostname被启用时才会非空。
client_port integer
客户端用于与此后端通信的 TCP 端口号，如果使用 Unix 套接字，则为-1。如果该字段为空，它表示这是一个内部服务器进程。
backend_start timestamp with time zone
这个进程被启动的时间。对客户端后端来说，这就是客户端连接到服务器的时间。
xact_start timestamp with time zone
这个进程的当前事务被启动的时间，如果没有活动事务则为空。
如果当前查询是它的第一个事务，这一列等于query_start列。
query_start timestamp with time zone
当前活动查询开始的时间，如果state不是active，则为上一个查询开始的时间
state_change timestamp with time zone
state上一次被改变的时间
wait_event_type text
后端等待的事件类型，如果有的话；否则为NULL。参见表 27.4。
wait_event text
如果后端当前正在等待，则等待事件名称，否则为NULL。参见表 27.5至
表 27.13。
state text
此后端的当前整体状态。
可能的值有：
starting：后端正在初始启动。客户端
身份验证在此阶段进行。
active：后端正在执行查询。
idle：后端正在等待新的客户端命令。
idle in transaction：后端处于事务中，
但当前未执行查询。
idle in transaction (aborted)：此状态类似于
idle in transaction，但事务中的一个语句导致了错误。
fastpath function call：后端正在执行
快速路径函数。
disabled：如果此后端中 track_activities 被禁用，则报告此状态。
backend_xid xid
此后端的顶级事务标识符（如果有）；请参阅
第 67.1 节。
backend_xmin xid
当前后端的xmin范围。
query_id bigint
这个后端的最近查询的标识符。如果state是active，这个字段显示当前正在执行的查询的标识符。
在所有其他状态，它显示执行的最后一个查询的标识符。
默认不计算查询标识符，因此该字段将为空，除非启用compute_query_id参数或配置了计算查询标识符的第三方模块。
query text
这个后端最近查询的文本。如果state为active，这个字段显示当前正在执行的查询。
在所有其他状态下，它显示上一个被执行的查询。默认情况下，查询文本会被截断至1024个字节，这个值可以通过参数track_activity_query_size更改。
backend_type text
当前后端的类型。可能的类型有
autovacuum launcher、autovacuum worker、
logical replication launcher、
logical replication worker、
parallel worker、background writer、
client backend、checkpointer、
archiver、standalone backend、
startup、walreceiver、
walsender、walwriter和
walsummarizer。
此外，由扩展注册的后台工作进程可能有
额外的类型。
注意
wait_event 和 state 列是
独立的。如果后端处于 active 状态，
它可能正在或可能没有在某个事件上 waiting。如果状态
是 active 且 wait_event 非 NULL，则
表示正在执行查询，但在系统的某个地方被阻塞。
为了保持报告开销低，系统不会尝试同步后端活动数据的不同方面。
因此，视图的列之间可能存在短暂的不一致。
表 27.4. 等待事件类型等待事件类型描述Activity服务器进程空闲。此事件类型表示在其主处理循环中等待活动的进程。
wait_event将识别特定的等待点；参见表 27.5。
BufferPin服务器进程正在等待对数据缓冲的独占访问。
如果另一个进程持有一个打开的游标，该游标最后一次从相关缓冲区读取数据，则缓冲区销等待可能是漫长的。
参见表 27.6。
Client服务器进程正在等待连接到用户应用程序的套接字上的活动。
因此，服务器预计发生一些独立于其内部进程的事情。wait_event将识别特定的等待点；参见表 27.7。
Extension服务器进程正在等待扩展模块定义的某个条件。参见表 27.8。
InjectionPoint服务器进程正在等待注入点达到测试中定义的结果。详见
第 36.10.14 节。此类型没有预定义的等待点。
IO服务器进程正在等待一个I/O操作完成。wait_event将识别特定的等待点；参见表 27.9。
IPC服务器进程正在等待与另一个服务器进程进行交互。wait_event将识别特定的等待点；参见表 27.10。
Lock服务器进程正在等待一个重量级锁。重量级锁，也称为锁管理器锁或简单锁，主要保护表等SQL可见对象。
然而，它们也用于确保某些内部操作的互斥，例如关系扩展。wait_event将识别等待的锁的类型；参见表 27.11。
LWLock 服务器进程正在等待一个轻量级锁。大多数这样的锁保护共享内存中的特定数据结构。
wait_event将包含标识轻量级锁用途的名称。
(有些锁有特定的名称；其他锁是一组锁的一部分，每个锁具有类似的目的。)参见表 27.12。
Timeout服务器进程正在等待超时过期。wait_event将识别特定的等待点；参见表 27.13。
表 27.5. Wait Events of Type ActivityActivity Wait EventDescriptionArchiverMainWaiting in main loop of archiver process.AutovacuumMainWaiting in main loop of autovacuum launcher process.BgwriterHibernateWaiting in background writer process, hibernating.BgwriterMainWaiting in main loop of background writer process.CheckpointerMainWaiting in main loop of checkpointer process.CheckpointerShutdownWaiting for checkpointer process to be terminated.IoWorkerMainWaiting in main loop of IO Worker process.LogicalApplyMainWaiting in main loop of logical replication apply process.LogicalLauncherMainWaiting in main loop of logical replication launcher process.LogicalParallelApplyMainWaiting in main loop of logical replication parallel apply process.RecoveryWalStreamWaiting in main loop of startup process for WAL to arrive, during streaming recovery.ReplicationSlotsyncMainWaiting in main loop of slot sync worker.ReplicationSlotsyncShutdownWaiting for slot sync worker to shut down.SysloggerMainWaiting in main loop of syslogger process.WalReceiverMainWaiting in main loop of WAL receiver process.WalSenderMainWaiting in main loop of WAL sender process.WalSummarizerWalWaiting in WAL summarizer for more WAL to be generated.WalWriterMainWaiting in main loop of WAL writer process.表 27.6. Wait Events of Type BufferpinBufferPin Wait EventDescriptionBufferPinWaiting to acquire an exclusive pin on a buffer.表 27.7. Wait Events of Type ClientClient Wait EventDescriptionClientReadWaiting to read data from the client.ClientWriteWaiting to write data to the client.GssOpenServerWaiting to read data from the client while establishing a GSSAPI session.LibpqwalreceiverConnectWaiting in WAL receiver to establish connection to remote server.LibpqwalreceiverReceiveWaiting in WAL receiver to receive data from remote server.SslOpenServerWaiting for SSL while attempting connection.WaitForStandbyConfirmationWaiting for WAL to be received and flushed by the physical standby.WalSenderWaitForWalWaiting for WAL to be flushed in WAL sender process.WalSenderWriteDataWaiting for any activity when processing replies from WAL receiver in WAL sender process.表 27.8. Wait Events of Type ExtensionExtension Wait EventDescriptionExtensionWaiting in an extension.表 27.9. Wait Events of Type IoIO Wait EventDescriptionAioIoCompletionWaiting for another process to complete IO.AioIoUringExecutionWaiting for IO execution via io_uring.AioIoUringSubmitWaiting for IO submission via io_uring.BasebackupReadWaiting for base backup to read from a file.BasebackupSyncWaiting for data written by a base backup to reach durable storage.BasebackupWriteWaiting for base backup to write to a file.BuffileReadWaiting for a read from a buffered file.BuffileTruncateWaiting for a buffered file to be truncated.BuffileWriteWaiting for a write to a buffered file.ControlFileReadWaiting for a read from the pg_control file.ControlFileSyncWaiting for the pg_control file to reach durable storage.ControlFileSyncUpdateWaiting for an update to the pg_control file to reach durable storage.ControlFileWriteWaiting for a write to the pg_control file.ControlFileWriteUpdateWaiting for a write to update the pg_control file.CopyFileCopyWaiting for a file copy operation.CopyFileReadWaiting for a read during a file copy operation.CopyFileWriteWaiting for a write during a file copy operation.DataFileExtendWaiting for a relation data file to be extended.DataFileFlushWaiting for a relation data file to reach durable storage.DataFileImmediateSyncWaiting for an immediate synchronization of a relation data file to durable storage.DataFilePrefetchWaiting for an asynchronous prefetch from a relation data file.DataFileReadWaiting for a read from a relation data file.DataFileSyncWaiting for changes to a relation data file to reach durable storage.DataFileTruncateWaiting for a relation data file to be truncated.DataFileWriteWaiting for a write to a relation data file.DsmAllocateWaiting for a dynamic shared memory segment to be allocated.DsmFillZeroWriteWaiting to fill a dynamic shared memory backing file with zeroes.LockFileAddtodatadirReadWaiting for a read while adding a line to the data directory lock file.LockFileAddtodatadirSyncWaiting for data to reach durable storage while adding a line to the data directory lock file.LockFileAddtodatadirWriteWaiting for a write while adding a line to the data directory lock file.LockFileCreateReadWaiting to read while creating the data directory lock file.LockFileCreateSyncWaiting for data to reach durable storage while creating the data directory lock file.LockFileCreateWriteWaiting for a write while creating the data directory lock file.LockFileRecheckdatadirReadWaiting for a read during recheck of the data directory lock file.LogicalRewriteCheckpointSyncWaiting for logical rewrite mappings to reach durable storage during a checkpoint.LogicalRewriteMappingSyncWaiting for mapping data to reach durable storage during a logical rewrite.LogicalRewriteMappingWriteWaiting for a write of mapping data during a logical rewrite.LogicalRewriteSyncWaiting for logical rewrite mappings to reach durable storage.LogicalRewriteTruncateWaiting for truncate of mapping data during a logical rewrite.LogicalRewriteWriteWaiting for a write of logical rewrite mappings.RelationMapReadWaiting for a read of the relation map file.RelationMapReplaceWaiting for durable replacement of a relation map file.RelationMapWriteWaiting for a write to the relation map file.ReorderBufferReadWaiting for a read during reorder buffer management.ReorderBufferWriteWaiting for a write during reorder buffer management.ReorderLogicalMappingReadWaiting for a read of a logical mapping during reorder buffer management.ReplicationSlotReadWaiting for a read from a replication slot control file.ReplicationSlotRestoreSyncWaiting for a replication slot control file to reach durable storage while restoring it to memory.ReplicationSlotSyncWaiting for a replication slot control file to reach durable storage.ReplicationSlotWriteWaiting for a write to a replication slot control file.SlruFlushSyncWaiting for SLRU data to reach durable storage during a checkpoint or database shutdown.SlruReadWaiting for a read of an SLRU page.SlruSyncWaiting for SLRU data to reach durable storage following a page write.SlruWriteWaiting for a write of an SLRU page.SnapbuildReadWaiting for a read of a serialized historical catalog snapshot.SnapbuildSyncWaiting for a serialized historical catalog snapshot to reach durable storage.SnapbuildWriteWaiting for a write of a serialized historical catalog snapshot.TimelineHistoryFileSyncWaiting for a timeline history file received via streaming replication to reach durable storage.TimelineHistoryFileWriteWaiting for a write of a timeline history file received via streaming replication.TimelineHistoryReadWaiting for a read of a timeline history file.TimelineHistorySyncWaiting for a newly created timeline history file to reach durable storage.TimelineHistoryWriteWaiting for a write of a newly created timeline history file.TwophaseFileReadWaiting for a read of a two phase state file.TwophaseFileSyncWaiting for a two phase state file to reach durable storage.TwophaseFileWriteWaiting for a write of a two phase state file.VersionFileSyncWaiting for the version file to reach durable storage while creating a database.VersionFileWriteWaiting for the version file to be written while creating a database.WalsenderTimelineHistoryReadWaiting for a read from a timeline history file during a walsender timeline command.WalBootstrapSyncWaiting for WAL to reach durable storage during bootstrapping.WalBootstrapWriteWaiting for a write of a WAL page during bootstrapping.WalCopyReadWaiting for a read when creating a new WAL segment by copying an existing one.WalCopySyncWaiting for a new WAL segment created by copying an existing one to reach durable storage.WalCopyWriteWaiting for a write when creating a new WAL segment by copying an existing one.WalInitSyncWaiting for a newly initialized WAL file to reach durable storage.WalInitWriteWaiting for a write while initializing a new WAL file.WalReadWaiting for a read from a WAL file.WalSummaryReadWaiting for a read from a WAL summary file.WalSummaryWriteWaiting for a write to a WAL summary file.WalSyncWaiting for a WAL file to reach durable storage.WalSyncMethodAssignWaiting for data to reach durable storage while assigning a new WAL sync method.WalWriteWaiting for a write to a WAL file.表 27.10. Wait Events of Type IpcIPC Wait EventDescriptionAppendReadyWaiting for subplan nodes of an Append plan node to be ready.ArchiveCleanupCommandWaiting for archive_cleanup_command to complete.ArchiveCommandWaiting for archive_command to complete.BackendTerminationWaiting for the termination of another backend.BackupWaitWalArchiveWaiting for WAL files required for a backup to be successfully archived.BgworkerShutdownWaiting for background worker to shut down.BgworkerStartupWaiting for background worker to start up.BtreePageWaiting for the page number needed to continue a parallel B-tree scan to become available.BufferIoWaiting for buffer I/O to complete.CheckpointDelayCompleteWaiting for a backend that blocks a checkpoint from completing.CheckpointDelayStartWaiting for a backend that blocks a checkpoint from starting.CheckpointDoneWaiting for a checkpoint to complete.CheckpointStartWaiting for a checkpoint to start.ExecuteGatherWaiting for activity from a child process while executing a Gather plan node.HashBatchAllocateWaiting for an elected Parallel Hash participant to allocate a hash table.HashBatchElectWaiting to elect a Parallel Hash participant to allocate a hash table.HashBatchLoadWaiting for other Parallel Hash participants to finish loading a hash table.HashBuildAllocateWaiting for an elected Parallel Hash participant to allocate the initial hash table.HashBuildElectWaiting to elect a Parallel Hash participant to allocate the initial hash table.HashBuildHashInnerWaiting for other Parallel Hash participants to finish hashing the inner relation.HashBuildHashOuterWaiting for other Parallel Hash participants to finish partitioning the outer relation.HashGrowBatchesDecideWaiting to elect a Parallel Hash participant to decide on future batch growth.HashGrowBatchesElectWaiting to elect a Parallel Hash participant to allocate more batches.HashGrowBatchesFinishWaiting for an elected Parallel Hash participant to decide on future batch growth.HashGrowBatchesReallocateWaiting for an elected Parallel Hash participant to allocate more batches.HashGrowBatchesRepartitionWaiting for other Parallel Hash participants to finish repartitioning.HashGrowBucketsElectWaiting to elect a Parallel Hash participant to allocate more buckets.HashGrowBucketsReallocateWaiting for an elected Parallel Hash participant to finish allocating more buckets.HashGrowBucketsReinsertWaiting for other Parallel Hash participants to finish inserting tuples into new buckets.LogicalApplySendDataWaiting for a logical replication leader apply process to send data to a parallel apply process.LogicalParallelApplyStateChangeWaiting for a logical replication parallel apply process to change state.LogicalSyncDataWaiting for a logical replication remote server to send data for initial table synchronization.LogicalSyncStateChangeWaiting for a logical replication remote server to change state.MessageQueueInternalWaiting for another process to be attached to a shared message queue.MessageQueuePutMessageWaiting to write a protocol message to a shared message queue.MessageQueueReceiveWaiting to receive bytes from a shared message queue.MessageQueueSendWaiting to send bytes to a shared message queue.MultixactCreationWaiting for a multixact creation to complete.ParallelBitmapScanWaiting for parallel bitmap scan to become initialized.ParallelCreateIndexScanWaiting for parallel CREATE INDEX workers to finish heap scan.ParallelFinishWaiting for parallel workers to finish computing.ProcarrayGroupUpdateWaiting for the group leader to clear the transaction ID at transaction end.ProcSignalBarrierWaiting for a barrier event to be processed by all backends.PromoteWaiting for standby promotion.RecoveryConflictSnapshotWaiting for recovery conflict resolution for a vacuum cleanup.RecoveryConflictTablespaceWaiting for recovery conflict resolution for dropping a tablespace.RecoveryEndCommandWaiting for recovery_end_command to complete.RecoveryPauseWaiting for recovery to be resumed.ReplicationOriginDropWaiting for a replication origin to become inactive so it can be dropped.ReplicationSlotDropWaiting for a replication slot to become inactive so it can be dropped.RestoreCommandWaiting for restore_command to complete.SafeSnapshotWaiting to obtain a valid snapshot for a READ ONLY DEFERRABLE transaction.SyncRepWaiting for confirmation from a remote server during synchronous replication.WalReceiverExitWaiting for the WAL receiver to exit.WalReceiverWaitStartWaiting for startup process to send initial data for streaming replication.WalSummaryReadyWaiting for a new WAL summary to be generated.XactGroupUpdateWaiting for the group leader to update transaction status at transaction end.表 27.11. Wait Events of Type LockLock Wait EventDescriptionadvisoryWaiting to acquire an advisory user lock.applytransactionWaiting to acquire a lock on a remote transaction being applied by a logical replication subscriber.extendWaiting to extend a relation.frozenidWaiting to update pg_database.datfrozenxid and pg_database.datminmxid.objectWaiting to acquire a lock on a non-relation database object.pageWaiting to acquire a lock on a page of a relation.relationWaiting to acquire a lock on a relation.spectokenWaiting to acquire a speculative insertion lock.transactionidWaiting for a transaction to finish.tupleWaiting to acquire a lock on a tuple.userlockWaiting to acquire a user lock.virtualxidWaiting to acquire a virtual transaction ID lock; see 第 67.1 节.表 27.12. Wait Events of Type LwlockLWLock Wait EventDescriptionAddinShmemInitWaiting to manage an extension's space allocation in shared memory.AioUringCompletionWaiting for another process to complete IO via io_uring.AioWorkerSubmissionQueueWaiting to access AIO worker submission queue.AutoFileWaiting to update the postgresql.auto.conf file.AutovacuumWaiting to read or update the current state of autovacuum workers.AutovacuumScheduleWaiting to ensure that a table selected for autovacuum still needs vacuuming.BackgroundWorkerWaiting to read or update background worker state.BtreeVacuumWaiting to read or update vacuum-related information for a B-tree index.BufferContentWaiting to access a data page in memory.BufferMappingWaiting to associate a data block with a buffer in the buffer pool.CheckpointerCommWaiting to manage fsync requests.CommitTsWaiting to read or update the last value set for a transaction commit timestamp.CommitTsBufferWaiting for I/O on a commit timestamp SLRU buffer.CommitTsSLRUWaiting to access the commit timestamp SLRU cache.ControlFileWaiting to read or update the pg_control file or create a new WAL file.DSMRegistryWaiting to read or update the dynamic shared memory registry.DSMRegistryDSAWaiting to access dynamic shared memory registry's dynamic shared memory allocator.DSMRegistryHashWaiting to access dynamic shared memory registry's shared hash table.DynamicSharedMemoryControlWaiting to read or update dynamic shared memory allocation information.InjectionPointWaiting to read or update information related to injection points.LockFastPathWaiting to read or update a process' fast-path lock information.LockManagerWaiting to read or update information about “heavyweight” locks.LogicalRepLauncherDSAWaiting to access logical replication launcher's dynamic shared memory allocator.LogicalRepLauncherHashWaiting to access logical replication launcher's shared hash table.LogicalRepWorkerWaiting to read or update the state of logical replication workers.MultiXactGenWaiting to read or update shared multixact state.MultiXactMemberBufferWaiting for I/O on a multixact member SLRU buffer.MultiXactMemberSLRUWaiting to access the multixact member SLRU cache.MultiXactOffsetBufferWaiting for I/O on a multixact offset SLRU buffer.MultiXactOffsetSLRUWaiting to access the multixact offset SLRU cache.MultiXactTruncationWaiting to read or truncate multixact information.NotifyBufferWaiting for I/O on a NOTIFY message SLRU buffer.NotifyQueueWaiting to read or update NOTIFY messages.NotifyQueueTailWaiting to update limit on NOTIFY message storage.NotifySLRUWaiting to access the NOTIFY message SLRU cache.OidGenWaiting to allocate a new OID.ParallelAppendWaiting to choose the next subplan during Parallel Append plan execution.ParallelBtreeScanWaiting to synchronize workers during Parallel B-tree scan plan execution.ParallelHashJoinWaiting to synchronize workers during Parallel Hash Join plan execution.ParallelQueryDSAWaiting for parallel query dynamic shared memory allocation.ParallelVacuumDSAWaiting for parallel vacuum dynamic shared memory allocation.PerSessionDSAWaiting for parallel query dynamic shared memory allocation.PerSessionRecordTypeWaiting to access a parallel query's information about composite types.PerSessionRecordTypmodWaiting to access a parallel query's information about type modifiers that identify anonymous record types.PerXactPredicateListWaiting to access the list of predicate locks held by the current serializable transaction during a parallel query.PgStatsDataWaiting for shared memory stats data access.PgStatsDSAWaiting for stats dynamic shared memory allocator access.PgStatsHashWaiting for stats shared memory hash table access.PredicateLockManagerWaiting to access predicate lock information used by serializable transactions.ProcArrayWaiting to access the shared per-process data structures (typically, to get a snapshot or report a session's transaction ID).RelationMappingWaiting to read or update a pg_filenode.map file (used to track the filenode assignments of certain system catalogs).RelCacheInitWaiting to read or update a pg_internal.init relation cache initialization file.ReplicationOriginWaiting to create, drop or use a replication origin.ReplicationOriginStateWaiting to read or update the progress of one replication origin.ReplicationSlotAllocationWaiting to allocate or free a replication slot.ReplicationSlotControlWaiting to read or update replication slot state.ReplicationSlotIOWaiting for I/O on a replication slot.SerialBufferWaiting for I/O on a serializable transaction conflict SLRU buffer.SerialControlWaiting to read or update shared pg_serial state.SerializableFinishedListWaiting to access the list of finished serializable transactions.SerializablePredicateListWaiting to access the list of predicate locks held by serializable transactions.SerializableXactHashWaiting to read or update information about serializable transactions.SerialSLRUWaiting to access the serializable transaction conflict SLRU cache.SharedTidBitmapWaiting to access a shared TID bitmap during a parallel bitmap index scan.SharedTupleStoreWaiting to access a shared tuple store during parallel query.ShmemIndexWaiting to find or allocate space in shared memory.SInvalReadWaiting to retrieve messages from the shared catalog invalidation queue.SInvalWriteWaiting to add a message to the shared catalog invalidation queue.SubtransBufferWaiting for I/O on a sub-transaction SLRU buffer.SubtransSLRUWaiting to access the sub-transaction SLRU cache.SyncRepWaiting to read or update information about the state of synchronous replication.SyncScanWaiting to select the starting location of a synchronized table scan.TablespaceCreateWaiting to create or drop a tablespace.TwoPhaseStateWaiting to read or update the state of prepared transactions.WaitEventCustomWaiting to read or update custom wait events information.WALBufMappingWaiting to replace a page in WAL buffers.WALInsertWaiting to insert WAL data into a memory buffer.WALSummarizerWaiting to read or update WAL summarization state.WALWriteWaiting for WAL buffers to be written to disk.WrapLimitsVacuumWaiting to update limits on transaction id and multixact consumption.XactBufferWaiting for I/O on a transaction status SLRU buffer.XactSLRUWaiting to access the transaction status SLRU cache.XactTruncationWaiting to execute pg_xact_status or update the oldest transaction ID available to it.XidGenWaiting to allocate a new transaction ID.表 27.13. Wait Events of Type TimeoutTimeout Wait EventDescriptionBaseBackupThrottleWaiting during base backup when throttling activity.CheckpointWriteDelayWaiting between writes while performing a checkpoint.PgSleepWaiting due to a call to pg_sleep or a sibling function.RecoveryApplyDelayWaiting to apply WAL during recovery because of a delay setting.RecoveryRetrieveRetryIntervalWaiting during recovery when WAL data is not available from any source (pg_wal, archive or stream).RegisterSyncRequestWaiting while sending synchronization requests to the checkpointer, because the request queue is full.SpinDelayWaiting while acquiring a contended spinlock.VacuumDelayWaiting in a cost-based vacuum delay point.VacuumTruncateWaiting to acquire an exclusive lock to truncate off any empty pages at the end of a table vacuumed.WalSummarizerErrorWaiting after a WAL summarizer error.
下面是如何查看等待事件的示例：
SELECT pid, wait_event_type, wait_event FROM pg_stat_activity WHERE wait_event is NOT NULL;
pid  | wait_event_type | wait_event
------+-----------------+------------
2540 | Lock            | relation
6644 | LWLock          | ProcArray
(2 rows)
SELECT a.pid, a.wait_event, w.description
FROM pg_stat_activity a JOIN
pg_wait_events w ON (a.wait_event_type = w.type AND
a.wait_event = w.name)
WHERE a.wait_event is NOT NULL and a.state = 'active';
-[ RECORD 1 ]------------------------------------------------------​------------
pid         | 686674
wait_event  | WALInitSync
description | Waiting for a newly initialized WAL file to reach durable storage
注意
扩展可以向 Extension、InjectionPoint 和
LWLock 事件添加到 表 27.8 和
表 27.12 中显示的列表。在某些情况下，
由扩展分配的 LWLock 名称可能不会在所有服务器进程中
可用。它可能仅被报告为 “extension”，
而不是扩展分配的名称。
27.2.4. pg_stat_replication #
pg_stat_replication 视图将在每个 WAL 发送方进程中包含一行，
显示关于复制到发送方连接的备用服务器的统计信息。只有直接连接的备用服务器被列出；
没有关于下游备用服务器的信息。
表 27.14. pg_stat_replication 视图
列类型
描述
pid integer
WAL 发送进程的进程 ID
usesysid oid
登录到这个 WAL 发送进程的用户的 OID
usename name
登录到这个 WAL 发送进程的用户的名称
application_name text
连接到这个 WAL 发送进程的应用名称
client_addr inet
连接到这个 WAL 发送进程的客户端的 IP 地址。
如果这个字段为空，它表示该客户端通过服务器机器上的一个 Unix 套接字连接。
client_hostname text
已连接的客户端的主机名，由 client_addr 的反向 DNS 查找报告。
这个字段将只对 IP 连接非空，并且只有 log_hostname 被启用时才会非空。
client_port integer
客户端用来与这个 WAL 发送进程通信的 TCP 端口号，如果使用 Unix 套接字则为 -1
backend_start timestamp with time zone
这个进程开始的时间，即客户端何时连接到这个 WAL 发送进程。
backend_xmin xid
由 hot_standby_feedback 报告的这个后备机的 xmin 水平线。
state text
当前的 WAL 发送进程状态。
可能的值是：
startup: 这个 WAL 发送进程正在启动。
catchup: 这个 WAL 发送进程连接的备用服务器正在赶上主服务器。
streaming: 在其连接的备用服务器赶上主服务器之后，这个 WAL 发送进程正在流式传输变化。
backup: 这个 WAL 发送进程正在发送一个备份。
stopping: 这个 WAL 发送进程正在停止。
sent_lsn pg_lsn
在这个连接上发送的最后一个预写日志的位置
write_lsn pg_lsn
该后备服务器写入到磁盘的最后一个预写式日志的位置
flush_lsn pg_lsn
该后备服务器刷入到磁盘的最后一个预写式日志的位置
replay_lsn pg_lsn
被重放到该后备服务器上的数据库中的最后一个预写式日志的位置
write_lag interval
从本地刷新近期的WAL与接收到该后备服务器已写入WAL的通知（但尚未刷新或应用它）之间的时间经过。
如果将此服务器配置为同步后备服务器，则可以使用此参数来衡量在提交时synchronous_commit级别
remote_write所导致的延迟。
flush_lag interval
在本地刷写近期的WAL与接收到该后备服务器已经写入并且刷写它（但还没有应用）的通知之间流逝的时间。
如果这台服务器被配置为一个同步后备，这可以用来计量在提交时synchronous_commit的级别
on所导致的延迟。
replay_lag interval
在本地刷写近期的WAL与接收到该后备服务器已经写入它、刷写它并且应用它的通知之间流逝的时间。
如果这台服务器被配置为一个同步后备，这可以用来计量在提交时synchronous_commit的级别
remote_apply所导致的延迟。
sync_priority integer
在基于优先的同步复制中，这台后备服务器被选为同步后备的优先级。
在基于规定数量的同步复制中，这个值没有效果。
sync_state text
该后备服务器的同步状态。
可能的值是：
async: 该后备服务器是异步的。
potential: 该后备服务器现在是异步的，但可能在当前的同步后备失效时变成同步的。
sync: 该后备服务器是同步的。
quorum: 该后备服务器被视为规定数量后备服务器的候选。
reply_time 带时区的时间戳
从备用服务器收到的最后一条回复消息的发送时间
pg_stat_replication视图中报告的滞后时间是近期的WAL被写入、刷写并且重放以及发送器知道这一切所花的时间的度量。如果远程服务器被配置为一台同步备用，这些时间表示由每一种同步提交级别所带来的（或者是可能带来的）提交延迟。对于一台异步备用，replay_lag列是最近的事务变得对查询可见的延迟时间的近似值。如果备用服务器已经完全追上了发送服务器并且没有WAL活动，在短时间内将继续显示最近测到的滞后时间，然后就会显示为NULL。
对于物理复制会自动测量滞后时间。逻辑解码插件可能会选择性地发出跟踪消息；如果它们没有这样做，跟踪机制将把滞后显示为NULL。
注意
报告的滞后时间并非按照当前的重放速率该备用还有多久才能追上发送服务器的预测。在新的WAL被生成期间，这样一种系统将显示类似的时间，但是当发送器变为闲置时会显示不同的值。特别是当备用服务器完全追上时，pg_stat_replication显示的是写入、刷写及重放最近报告的WAL位置所花的时间而不是一些用户可能预期的零。这种做法与为近期的写事务测量同步提交和事务可见性延迟的目的一致。为了降低用户预期一种不同的滞后模型带来的混淆，在一个完全重放完的闲置系统上，滞后列会在一段比较短的时间后回复成NULL。监控系统应该选择将这种情况表示为缺失数据、零或者继续显示最近的已知值。
27.2.5. pg_stat_replication_slots #
pg_stat_replication_slots视图将包含每个逻辑复制槽的一行，显示关于其使用情况的统计信息。
表 27.15. pg_stat_replication_slots 视图
列类型
描述
slot_name text
唯一的、集群范围的复制槽标识符
spill_txns bigint
当逻辑解码在解码来自WAL的更改时所使用的内存超过logical_decoding_work_mem，溢出到磁盘的事务数。
顶级事务和子事务的计数器都是递增的。
spill_count bigint
在为该槽解码来自WAL的更改时，事务溢出到磁盘的次数。
此计数器在每次事务被溢出时递增，并且同一事务可能被溢出多次。
spill_bytes bigint
在对来自WAL的更改执行解码时，已解码的事务数据溢出到磁盘的数量。
这个和其他溢出计数器可用于测量逻辑解码期间发生的I/O，并且允许调优logical_decoding_work_mem。
stream_txns bigint
在逻辑解码在解码来自该槽位的WAL更改时所使用的内存超过logical_decoding_work_mem之后，流到解码输出插件的正在进行的事务数。
流仅对顶级事务有效（子事务不能独立流），因此子事务的计数器不会增加。
stream_countbigint
在为该槽解码来自WAL的更改时，将正在进行的事务流到解码输出插件的次数。
此计数器在每次事务流化时递增，并且同一事务可能被流化多次。
stream_bytesbigint
在为该槽解码来自WAL的更改时，为将正在进行的事务流到解码输出插件而解码的事务数据的数量。
这个和针对此槽位的其他流计数器可用于调优logical_decoding_work_mem。
total_txns bigint
针对此槽的，发送到解码输出插件的已解码事务数。
这只计算顶级事务，对子事务不会增加。
注意，这包括流化和/或溢出的事务。
total_bytesbigint
在对此槽位的WAL进行解码时，为将事务发送到解码输出插件而解码的事务数据量。
注意这包括流和/或溢出的数据。
stats_reset timestamp with time zone
这些统计最后重置的时间
27.2.6. pg_stat_wal_receiver #
pg_stat_wal_receiver视图只包含一行，它显示了从 WAL 接收器所连接的服务器得到的有关该接收器的统计信息。
表 27.16. pg_stat_wal_receiver 视图
列类型
描述
pid integer
WAL接收器进程的进程ID
status text
WAL接收器进程的活动状态
receive_start_lsn pg_lsn
WAL接收器启动时使用的第一个写前日志位置
receive_start_tli integer
WAL接收器启动时使用的第一个时间线编号
written_lsn pg_lsn
已经接收并写入磁盘的最后一个预写式日志位置，但没有刷入。这不能用于数据完整性检查。
flushed_lsn pg_lsn
已经接收并刷入到磁盘的最后一个预写式日志位置，该字段的初始值是启动WAL接收器时使用的第一个日志位置
received_tli integer
接收并刷入到磁盘的最后一个预写式日志位置的时间线编号，该字段的初始值为启动WAL接收器时使用的第一个日志位置的时间线编号
last_msg_send_time timestamp with time zone
从源头WAL发送器收到的最后一条信息的发送时间
last_msg_receipt_time timestamp with time zone
从源头WAL发送器收到的最后一条信息的接收时间
latest_end_lsn pg_lsn
向源头WAL发送器报告的最后的预写式日志位置
latest_end_time timestamp with time zone
向源头WAL发送方报告的最后一次写前日志位置的时间
slot_name text
这个WAL接收器使用的复制槽名称
sender_host text
这个WAL接收器连接到的PostgreSQL实例的主机。
这可以是主机名、IP地址，或者目录路径，如果连接是通过
Unix套接字进行的。(路径的情况可以区分，因为它
总是以/开头的绝对路径。)
sender_port integer
这个WAL接收器连接的PostgreSQL实例的端口号。
conninfo text
这个WAL接收器使用的连接字符串，对安全敏感的字段进行了模糊处理。
27.2.7. pg_stat_recovery_prefetch #
pg_stat_recovery_prefetch视图将只包含一行。
wal_distance、block_distance和
io_depth列显示当前值，其他列显示可以使用
pg_stat_reset_shared函数重置的累积计数器。
表 27.17. pg_stat_recovery_prefetch 视图
列类型
描述
stats_reset timestamp with time zone
这些统计数据上次重置的时间
prefetch bigint
因为不在缓冲池中，所以预取的块数
hit bigint
因为它们已经在缓冲池中，所以未预取的块数
skip_init bigint
未预取的块数，因为它们将被零初始化
skip_new bigint
未预取的块数，因为它们尚不存在
skip_fpw bigint
由于WAL中包含完整页图像而未预取的块数
skip_rep bigint
由于最近已经预取过而未预取的块数
wal_distance int
预取器向前查看多少字节
block_distance int
预取器向前查看多少个块
io_depth int
已启动但尚未完成的预取数量
27.2.8. pg_stat_subscription #表 27.18. pg_stat_subscription View
列类型
描述
subid oid
订阅的OID
subname name
订阅的名称
worker_type text
订阅工作进程的类型。可能的类型有apply、parallel apply和
table synchronization。
pid integer
订阅工作进程的进程ID
leader_pid integer
如果此进程是并行应用工作进程，则为领导应用工作进程的进程ID；
如果此进程是领导应用工作进程或表同步工作进程，则为NULL
relid oid
工作进程正在同步的关系的OID；对于领导应用工作进程和并行应用工作进程为NULL
received_lsn pg_lsn
接收到的最后写前日志位置，此字段的初始值为0；对于并行应用工作进程为NULL
last_msg_send_time timestamp with time zone
从源WAL发送者接收到的最后一条消息的发送时间；对于并行应用工作进程为NULL
last_msg_receipt_time timestamp with time zone
从源WAL发送者接收到的最后一条消息的接收时间；对于并行应用工作进程为NULL
latest_end_lsn pg_lsn
报告给源WAL发送者的最新写前日志位置；对于并行应用工作进程为NULL
latest_end_time timestamp with time zone
报告给源WAL发送器的最后写前日志位置的时间；对于并行应用工作者为 NULL
27.2.9. pg_stat_subscription_stats #
pg_stat_subscription_stats 视图将包含每个订阅的一行。
表 27.19. pg_stat_subscription_stats 视图
列类型
描述
subid oid
订阅的 OID
subname name
订阅的名称
apply_error_count bigint
应用更改时发生错误的次数。请注意，任何导致应用错误的冲突都将计入
apply_error_count 和相应的冲突计数（例如，confl_*）。
sync_error_count bigint
在初始表同步期间发生错误的次数
confl_insert_exists bigint
在应用更改期间，行插入违反了
NOT DEFERRABLE 唯一约束的次数。有关此冲突的详细信息，请参见 insert_exists。
confl_update_origin_differs bigint
在应用更改期间，更新被应用到之前由其他源修改的行的次数。有关此冲突的详细信息，请参见
update_origin_differs。
confl_update_exists bigint
更新的行值在应用更改期间违反了
NOT DEFERRABLE 唯一约束的次数。有关此冲突的详细信息，请参见 update_exists。
confl_update_missing bigint
在应用更改期间，待更新的元组未找到的次数。有关此冲突的详细信息，请参见 update_missing。
confl_delete_origin_differs bigint
在应用更改期间，删除操作应用于之前由其他源修改的行的次数。
有关此冲突的详细信息，请参见 delete_origin_differs。
confl_delete_missing bigint
在应用更改期间，未找到要删除的元组的次数。有关此冲突的详细信息，请参见
delete_missing。
confl_multiple_unique_conflicts bigint
在应用更改时，行插入或更新的行值违反多个
NOT DEFERRABLE 唯一约束的次数。有关此冲突的详细信息，请参见
multiple_unique_conflicts。
stats_reset timestamp with time zone
这些统计数据最后一次重置的时间
27.2.10. pg_stat_ssl #
pg_stat_ssl视图将为每一个后端或者 WAL 发送进程包含一行，用来显示这个连接上的 SSL 使用情况。
可以把它与pg_stat_activity或者pg_stat_replication通过pid列连接来得到更多有关该连接的细节。
表 27.20. pg_stat_ssl 视图
列类型
描述
pid integer
后端或 WAL 发送进程的 ID
ssl boolean
如果在此连接上使用 SSL，则为真
version text
使用的 SSL 版本，如果此连接上没有使用 SSL 则为 NULL
cipher text
正在使用的SSL密码的名称，如果此连接上没有使用SSL则为NULL
bits integer
使用的加密算法中的位数，如果此连接上没有使用SSL则为NULL
client_dn text
客户端证书中的区别名称(DN)，如果没有提供客户端证书或在此连接上没有使用SSL，则为NULL。
如果DN字段长于NAMEDATALEN(标准构建中为64个字符)，则该字段将被截断。
client_serial numeric
客户端证书的序列号，如果没有提供客户端证书或在此连接上没有使用SSL，则为NULL。
证书序列号和证书颁发者的组合唯一标识一个证书(除非颁发者错误地重用序列号)。
issuer_dn text
客户端证书颁发者的区别名称(DN)，如果没有提供客户端证书或在此连接上没有使用SSL，则为NULL。该字段像client_dn一样被截断。
27.2.11. pg_stat_gssapi #
pg_stat_gssapi视图将包含每一个后端一行，显示该连接上的GSSAPI使用情况。
它可以加入到pg_stat_activity或pg_stat_replication上的pid列，获取更多关于连接的详细信息。
表 27.21. pg_stat_gssapi 视图
列类型
描述
pid integer
后端进程 ID
gss_authenticated boolean
如果此连接使用了 GSSAPI 身份验证，则为 True
principal text
用于验证此连接的主体，如果未使用 GSSAPI 对此连接进行身份验证，则为 NULL。
如果主体长度超过 NAMEDATALEN (标准构建中为 64 个字符)，则该字段被截断。
encrypted boolean
如果在此连接上使用了 GSSAPI 加密，则为真
credentials_delegated boolean
如果在此连接上委派了 GSSAPI 凭据，则为 True。
27.2.12. pg_stat_archiver #
pg_stat_archiver 视图总是有一行，其中包含关于集群的存档进程的数据。
表 27.22. pg_stat_archiver 视图
列类型
描述
archived_count bigint
已成功存档的 WAL 文件数
last_archived_wal text
最近成功归档的 WAL 文件的名称
last_archived_time timestamp with time zone
最近成功归档操作的时间
failed_count bigint
记录 WAL 文件归档失败次数
last_failed_wal text
最近一次归档操作失败的 WAL 文件的名称
last_failed_time timestamp with time zone
最近一次归档操作失败的时间
stats_reset timestamp with time zone
这些统计数据最后一次重置的时间
通常，WAL文件按照顺序进行归档，从最旧到最新，但这并不是保证，也不适用于特殊情况，比如在推广备用机或崩溃恢复后。因此，不能安全地假设所有早于
last_archived_wal的文件也已成功归档。
27.2.13. pg_stat_io #
pg_stat_io视图将包含每种后端类型、目标I/O对象和I/O上下文
的组合的一行，显示集群范围的I/O统计信息。不合理的组合将被省略。
当前，关系（例如表、索引）和WAL活动的I/O被跟踪。然而，绕过共享缓冲区的关系I/O
（例如，当将表从一个表空间移动到另一个表空间时）目前不被跟踪。
表 27.23. pg_stat_io 视图
列类型
描述
backend_type text
后端的类型（例如，后台工作者，自动清理工作者）。请参阅
pg_stat_activity以获取有关
backend_type的更多信息。一些
backend_type不会累积I/O操作统计信息，因此不会包含在视图中。
object text
I/O 操作的目标对象。可能的值有：
relation: 永久关系。
temp relation: 临时关系。
wal: 预写日志。
context text
I/O 操作的上下文。可能的值有：
normal: 一种 I/O 操作的默认或标准
context。例如，默认情况下，关系数据从共享缓冲区读取和写入。因此，关系数据的读取和写入
在 context normal 中被跟踪。
init: 创建 WAL 段时执行的 I/O 操作在
context init 中被跟踪。
vacuum: 在清理和分析永久关系时，在共享缓冲区外执行的 I/O 操作。临时表的清理使用与其他临时表 I/O 操作相同的本地缓冲池，并在 context normal 中被跟踪。
bulkread: 在共享缓冲区外执行的某些大规模读取 I/O 操作，例如对大表的顺序扫描。
bulkwrite: 在共享缓冲区外执行的某些大规模写入 I/O 操作，例如 COPY。
reads bigint
读取操作的次数。
read_bytes numeric
读取操作的总大小（以字节为单位）。
read_time double precision
等待读取操作的时间（以毫秒为单位）（如果
track_io_timing 被启用且
object 不是 wal，
或如果 track_wal_io_timing 被启用
且 object 是 wal，
否则为零）
writes bigint
写入操作的次数。
write_bytes numeric
写入操作的总大小（以字节为单位）。
write_time double precision
等待写入操作的时间（以毫秒为单位）（如果
track_io_timing 被启用且
object 不是 wal，
或如果 track_wal_io_timing 被启用
且 object 是 wal，
否则为零）
writebacks bigint
进程请求内核写入永久存储的大小为 BLCKSZ（通常为8kB）的单位数量。
writeback_time double precision
等待写回操作所花费的时间（以毫秒为单位）（如果
track_io_timing 被启用，否则为零）。这
包括排队写出请求所花费的时间，以及可能写出脏数据所花费的时间。
extends bigint
关系扩展操作的数量。
extend_bytes numeric
关系扩展操作的总大小（以字节为单位）。
extend_time double precision
等待扩展操作所花费的时间（以毫秒为单位）。 （如果
track_io_timing 被启用且
object 不是 wal，
或如果 track_wal_io_timing 被启用
且 object 是 wal，
否则为零）
hits bigint
在共享缓冲区中找到所需块的次数。
evictions bigint
一个块从共享或本地缓冲区写出以便为其他用途腾出空间的次数。
在contextnormal中，这表示一个块从缓冲区被驱逐并替换为另一个块的次数。
在context bulkwrite、
bulkread和vacuum中，这表示一个块从共享缓冲区被驱逐，
以便将共享缓冲区添加到一个单独的、大小有限的环形缓冲区中，用于批量I/O操作。
reuses bigint
在bulkread、bulkwrite或
vacuum上下文中，作为I/O操作的一部分，
在共享缓冲区之外的大小受限环形缓冲区中重用了现有缓冲区的次数。
fsyncs bigint
fsync调用的数量。这些仅在context
normal中被跟踪。
fsync_time double precision
等待 fsync 操作所花费的时间（以毫秒为单位）（如果
track_io_timing 被启用且
object 不是 wal，
或如果 track_wal_io_timing 被启用
且 object 是 wal，
否则为零）
stats_reset timestamp with time zone
上次重置这些统计信息的时间。
某些后端类型从不对某些 I/O 对象和/或某些 I/O 上下文执行 I/O 操作。这些行会从视图
中省略。例如，检查点进程不会检查临时表，因此不会有
backend_type checkpointer 和
object temp relation 的行。
此外，某些 I/O 操作永远不会由某些后端类型执行，或者不会在某些 I/O 对象
和/或某些 I/O 上下文中执行。这些单元格将为 NULL。例如，临时表不会被
fsync，因此 fsyncs 对于
object temp relation 将为 NULL。
同样，后台写入器不执行读取操作，因此 reads 在
backend_type background writer
的行中将为 NULL。
对于 object wal，
fsyncs 和 fsync_time 跟踪
在 issue_xlog_fsync 中执行的 WAL 文件的 fsync 活动。
writes 和 write_time
跟踪在 XLogWrite 中执行的 WAL 文件的写入活动。
有关更多信息，请参见 第 28.5 节。
pg_stat_io 可以用来为数据库调优提供信息。
例如：
较高的 evictions 计数可能表明需要增加共享缓冲区。
客户端后端依赖检查点进程确保数据持久化到永久存储。大量的
fsyncs 由 client backend 执行可能表明
共享缓冲区或检查点进程配置错误。有关配置检查点进程的更多信息，
请参见 第 28.5 节。
通常，客户端后端应该能够依赖辅助进程（如检查点进程和后台写入器）
尽可能多地写出脏数据。大量由客户端后端执行的写操作可能表明共享
缓冲区或检查点进程配置错误。有关配置检查点进程的更多信息，请参见
第 28.5 节。
注意
跟踪 I/O 等待时间的列仅在
track_io_timing 被启用时才会非零。用户在引用这些列时应
小心，确保与其对应的 I/O 操作结合使用，以防 track_io_timing
在上次统计重置以来的整个时间内未被启用。
27.2.14. pg_stat_bgwriter #
pg_stat_bgwriter视图将始终只有一行，包含有关
集群后台写入器的数据。
表 27.24. pg_stat_bgwriter 视图
列类型
描述
buffers_clean bigint
后台写入器写入的缓冲区数
maxwritten_clean bigint
后台写入器因为写入太多缓冲区而停止清理扫描的次数
buffers_alloc bigint
分配的缓冲区数
stats_reset timestamp with time zone
这些统计数据最后一次重置的时间
27.2.15. pg_stat_checkpointer #
pg_stat_checkpointer 视图将始终只有一行，包含有关检查点进程的数据。
表 27.25. pg_stat_checkpointer 视图
列类型
描述
num_timed bigint
由于超时而调度的检查点数量
num_requested bigint
请求的检查点数量
num_done bigint
已执行的检查点数量
restartpoints_timed bigint
由于超时或执行失败后尝试，计划的重启点数量
restartpoints_req bigint
请求的重启点数量
restartpoints_done bigint
已执行的重启点数量
write_time double precision
在处理检查点和重启点期间，写入磁盘文件所花费的总时间，
以毫秒为单位
sync_time double precision
在处理检查点和重启点期间，用于将文件同步到磁盘部分所花费的总时间，单位为毫秒
buffers_written bigint
在检查点和重启点期间写入的共享缓冲区数量
slru_written bigint
在检查点和重启点期间写入的 SLRU 缓冲区数量
stats_reset timestamp with time zone
这些统计数据最后一次重置的时间
如果服务器自上一个检查点以来一直处于空闲状态，则可以跳过检查点。
num_timed 和
num_requested 统计已完成和跳过的
检查点，而 num_done 仅跟踪
已完成的检查点。类似地，如果最后重放的检查点记录
已经是最后一个重启点，则可以跳过重启点。
restartpoints_timed 和
restartpoints_req 统计已完成和
跳过的重启点，而 restartpoints_done
仅跟踪已完成的重启点。
27.2.16. pg_stat_wal #
pg_stat_wal 视图将始终有一行，包含关于集群的WAL活动的数据。
表 27.26. pg_stat_wal 视图
列类型
描述
wal_records bigint
生成的WAL记录的总数
wal_fpi bigint
生成的WAL全页图像的总数
wal_bytes numeric
生成的WAL总量，以字节计
wal_buffers_full bigint
因为WAL缓冲区已满，WAL数据被写入磁盘的次数
stats_reset timestamp with time zone
这些统计数据最后一次重置的时间
27.2.17. pg_stat_database #
pg_stat_database视图将包含一行用于集群中的每个数据库，加一行用于共享对象，显示
数据库范围的统计信息。
表 27.27. pg_stat_database 视图
列类型
描述
datid oid
该数据库的OID，属于共享关系的对象为0
datname name
这个数据库的名称，或者共享对象为NULL。
numbackends integer
当前连接到此数据库的后端数，对于共享对象则为NULL。这是该视图中唯一返回反映当前状态的值的列;所有其他列返回自上次重置以来累积的值。
xact_commit bigint
此数据库中已提交的事务数
xact_rollback bigint
此数据库中已回滚的事务数
blks_read bigint
在该数据库中读取的磁盘块数
blks_hit bigint
在缓存中发现磁盘块的次数，因此读取不是必需的（这只包括在PostgreSQL缓存中，而不是在操作系统的文件系统缓存中）
tup_returned bigint
由顺序扫描获取的活动行数和由索引扫描返回的索引条目数
tup_fetched bigint
在该数据库中由索引扫描检索的活动行数
tup_inserted bigint
查询在该数据库中插入的行数
tup_updated bigint
在该数据库中查询更新的行数
tup_deleted bigint
该数据库中被查询删除的行数
conflicts bigint
由于与此数据库中的恢复冲突而取消的查询数。(冲突只发生在备用服务器上;详请参见
pg_stat_database_conflicts。)
temp_files bigint
该数据库中查询创建的临时文件的数量。所有临时文件都将被计数，而不考虑临时文件为什么被创建(例如，排序或散列)，也不考虑log_temp_files设置。
temp_bytes bigint
该数据库中查询写入临时文件的数据总量。所有临时文件都将被计数，而不考虑临时文件为什么被创建，也不考虑log_temp_files设置。
deadlocks bigint
在该数据库中检测到的死锁数
checksum_failures bigint
在该数据库（或共享对象）中检测到的数据页校验和失败的数量，
如果数据校验和被禁用，则为 NULL。
checksum_last_failure timestamp with time zone
在该数据库（或共享对象）中检测到的最后一次数据页校验和失败的时间，
如果数据校验和被禁用，则为 NULL。
blk_read_time double precision
在该数据库中通过后端读取数据文件块所花费的时间，以毫秒为单位(如果启用了track_io_timing，否则为零)
blk_write_time double precision
在这个数据库中通过后端写数据文件块所花费的时间，以毫秒为单位（如果启用了track_io_timing，否则为零）
session_time double precision
此数据库中数据库会话所消耗的时间，以毫秒计（注意统计信息仅在会话状态发生变化时更新，因此如果会话空闲很长时间，则不包括此空闲时间）
active_time double precision
此数据库中执行SQL语句所消耗的时间，以毫秒计（这对应于 pg_stat_activity中的 active 和 fastpath function call 状态）
idle_in_transaction_time double precision
此数据库中事务空闲所消耗的时间，以毫秒计（这对应于 pg_stat_activity中的 idle in transaction 和 idle in transaction (aborted) 状态）
sessions bigint
此数据库建立的会话总数
sessions_abandoned bigint
此数据库因为到客户端的连接丢失而被终止的数据库会话数
sessions_fatal bigint
此数据库因为致命错误而被终止的数据库会话数
sessions_killed bigint
此数据库因为操作者介入而被终止的数据库会话数
parallel_workers_to_launch bigint
计划由此数据库的查询启动的并行工作进程数量
parallel_workers_launched bigint
由此数据库的查询启动的并行工作进程数量
stats_reset timestamp with time zone
这些统计数据最后一次重置的时间
27.2.18. pg_stat_database_conflicts #
pg_stat_database_conflicts视图为每一个数据库包含一行，用来显示数据库范围内由于与后备服务器上的恢复过程冲突而被取消的查询的统计信息。
这个视图将只包含后备服务器上的信息，因为冲突不会发生在主服务器上。
表 27.28. pg_stat_database_conflicts 视图
列类型
描述
datid oid
数据库的OID
datname name
该数据库的名称
confl_tablespace bigint
这个数据库中由于删除表空间而取消的查询数量
confl_lock bigint
此数据库中由于锁定超时而被取消的查询数量
confl_snapshot bigint
此数据库中由于旧快照而取消的查询数量
confl_bufferpin bigint
此数据库中由于固定缓冲区而被取消的查询数量
confl_deadlock bigint
此数据库中由于死锁而被取消的查询数量
confl_active_logicalslot bigint
由于旧快照或主服务器上的wal_level
设置过低而被取消的此数据库中逻辑槽的使用次数
27.2.19. pg_stat_all_tables #
pg_stat_all_tables视图将为当前数据库中的每一个表（包括 TOAST 表）包含一行，该行显示与对该表的访问相关的统计信息。
pg_stat_user_tables和pg_stat_sys_tables视图包含相同的信息，但是被过滤得分别只显示用户和系统表。
表 27.29. pg_stat_all_tables 视图
Column Type
描述
relid oid
表的OID
schemaname name
该表所在的模式的名称
relname name
该表的名称
seq_scan bigint
在此表上启动的顺序扫描数
last_seq_scan timestamp with time zone
此表上最后一次顺序扫描的时间，基于最近的事务停止时间
seq_tup_read bigint
连续扫描获取的活动行数
idx_scan bigint
对这个表发起的索引扫描数
last_idx_scan timestamp with time zone
此表上最后一次索引扫描的时间，基于最近的事务停止时间
idx_tup_fetch bigint
索引扫描获取的活动行数
n_tup_ins bigint
插入的总行数
n_tup_upd bigint
更新的总行数。（这包括在n_tup_hot_upd和
n_tup_newpage_upd中计数的行更新，以及其余的非
HOT更新。）
n_tup_del bigint
删除的总行数
n_tup_hot_upd bigint
更新的行数HOT 更新。
这些是索引中不需要后续版本的更新。
n_tup_newpage_upd bigint
更新的行数，其中后续版本被写入到一个
新的堆页面，留下一个原始版本，
其包含一个
t_ctid
字段，该字段指向另一个堆页面。这些更新始终是非
HOT更新。
n_live_tup bigint
活的行的估计数量
n_dead_tup bigint
死亡行的估计数量
n_mod_since_analyze bigint
自上次分析此表以来修改的行的估计数量
n_ins_since_vacuum bigint
自上次对该表进行清理（不包括 VACUUM FULL）以来插入的行数估计
last_vacuum timestamp with time zone
最后一次手动清理这个表（不包括 VACUUM FULL）
last_autovacuum timestamp with time zone
这个表最后一次被自动清理守护进程清理的时间
last_analyze timestamp with time zone
上一次手动分析这个表的时间
last_autoanalyze timestamp with time zone
自动清理守护进程最后一次分析此表的时间
vacuum_count bigint
这个表被手动清理的次数（不包括 VACUUM FULL）
autovacuum_count bigint
这个表被自动清理守护进程清理的次数
analyze_count bigint
手动分析这个表的次数
autoanalyze_count bigint
这个表被自动清理守护进程分析的次数
total_vacuum_time double precision
此表手动清理的总时间，以毫秒为单位
（不包括 VACUUM FULL）。
（这包括由于基于成本的延迟而花费的睡眠时间。）
total_autovacuum_time double precision
此表由自动清理守护进程清理的总时间，
以毫秒为单位。 （这包括由于
基于成本的延迟而花费的睡眠时间。）
total_analyze_time double precision
此表手动分析的总时间，以毫秒为单位。
（这包括由于基于成本的延迟而花费的睡眠时间。）
total_autoanalyze_time double precision
此表由 autovacuum 守护进程分析的总时间，
以毫秒为单位。 （这包括由于
基于成本的延迟而花费的睡眠时间。）
27.2.20. pg_stat_all_indexes #
pg_stat_all_indexes 视图将为当前数据库中的每个索引包含一行，
显示关于对该索引访问的统计信息。 pg_stat_user_indexes 和
pg_stat_sys_indexes 视图包含相同的信息，
但过滤得只分别显示用户和系统索引。
表 27.30. pg_stat_all_indexes 视图
列类型
描述
relid oid
此索引的表的OID
indexrelid oid
此索引的OID
schemaname name
此索引所在的模式名称
relname name
该索引的表名称
indexrelname name
该索引的名称
idx_scan bigint
在该索引上发起的索引扫描数量
last_idx_scan timestamp with time zone
基于最近的事务停止时间，该索引上最后一次扫描的时间
idx_tup_read bigint
扫描该索引返回的索引项数量
idx_tup_fetch bigint
使用该索引进行简单索引扫描获取的活动表行数量
索引可以被简单索引扫描、“位图”索引扫描以及优化器使用。在一次位图扫描中，多个索引的输出可以被通过 AND 或 OR 规则组合，因此当使用一次位图扫描时难以将取得的个体堆行与特定的索引关联起来。因此，一次位图扫描会增加它使用的索引的pg_stat_all_indexes.idx_tup_read计数，并且为每个表增加pg_stat_all_tables.idx_tup_fetch计数，但是它不影响pg_stat_all_indexes.idx_tup_fetch。如果所提供的常量值不在优化器统计信息记录的范围之内，优化器也会访问索引来检查，因为优化器统计信息可能已经过时。
注意
即使不用位图扫描，idx_tup_read和idx_tup_fetch计数也可能不同，因为idx_tup_read统计从该索引取得的索引项，而idx_tup_fetch统计从表取得的活动行。如果使用该索引取得了任何死亡行或尚未提交的行，或者如果通过一次仅用索引扫描的方式避免了任何堆获取，后者将会更少。
注意
索引扫描有时可能在每次执行中执行多个索引搜索。
每次索引搜索都会增加 pg_stat_all_indexes.idx_scan，
因此索引扫描的计数可能显著超过
索引扫描执行器节点执行的总数。
这可能发生在使用某些 SQL
结构的查询中，以搜索与列表或数组中的任何值匹配的行
（参见 第 9.25 节）。它
也可能发生在具有
column_name =
value1 OR
column_name =
value2 ... 结构的查询中，但仅当
优化器将该结构转换为等效的
多值数组表示时。类似地，当 B-tree 索引扫描使用
跳过扫描优化时，每次扫描重新定位到下一个可能具有匹配
元组的索引叶页时都会执行一次索引搜索（参见 第 11.3 节）。
提示
EXPLAIN ANALYZE 输出每个索引扫描节点执行的索引搜索总数。请参见
第 14.1.2 节 以获取演示其工作原理的示例。
27.2.21. pg_statio_all_tables #
pg_statio_all_tables 视图将为当前数据库中的每个表（包括 TOAST 表）包含一行，该行显示指定表上有关 I/O 的统计信息。pg_statio_user_tables 和 pg_statio_sys_tables 视图包含相同的信息，但是被过滤得分别只显示用户表和系统表。
表 27.31. pg_statio_all_tables 视图
列类型
描述
relid oid
表的 OID
schemaname name
该表所在的模式名称
relname name
该表的名称
heap_blks_read bigint
从该表中读取的磁盘块数量
heap_blks_hit bigint
该表中的缓冲区命中数
idx_blks_read bigint
从该表上所有索引读取的磁盘块数量
idx_blks_hit bigint
该表上所有索引中的缓冲区命中数
toast_blks_read bigint
从该表的TOAST表中读取的磁盘块数量（如果有的话）
toast_blks_hit bigint
该表的TOAST表中的缓冲区命中数（如果有的话）
tidx_blks_read bigint
从这个表的TOAST表索引中读取的磁盘块的数量（如果有的话）
tidx_blks_hit bigint
这个表的TOAST表索引中的缓冲区命中数（如果有的话）
27.2.22. pg_statio_all_indexes #
pg_statio_all_indexes视图将为当前数据库中的每个索引包含一行，
该行显示指定索引上有关 I/O 的统计信息。pg_statio_user_indexes
和pg_statio_sys_indexes视图包含相同的信息，
但是被过滤得分别只显示用户索引和系统索引。
表 27.32. pg_statio_all_indexes 视图
列类型
描述
relid oid
此索引对应表的OID
indexrelid oid
该索引的OID
schemaname name
该索引所在的模式名称
relname name
该索引的表名称
indexrelname name
该索引的名称
idx_blks_read bigint
从该索引读取的磁盘块数量
idx_blks_hit bigint
该索引中的缓冲区命中数
27.2.23. pg_statio_all_sequences #
pg_statio_all_sequences视图将为当前数据库中的每个序列包含一行，显示该序列的 I/O 统计信息。
表 27.33. pg_statio_all_sequences 视图
列类型
描述
relid oid
序列的OID
schemaname name
此序列所在的模式名称
relname name
此序列的名称
blks_read bigint
从此序列读取的磁盘块数量
blks_hit bigint
此序列中的缓冲区命中数
27.2.24. pg_stat_user_functions #
pg_stat_user_functions视图将为每一个被追踪的函数包含一行，该行显示有关该函数执行的统计信息。
track_functions参数控制到底哪些函数被跟踪。
表 27.34. pg_stat_user_functions 视图
列类型
描述
funcid oid
函数的OID
schemaname name
该函数所在模式的名称
funcname name
该函数的名称
calls bigint
该函数被调用的次数
total_time double precision
在该函数及其调用的所有其他函数中花费的总时间，以毫秒计
self_time double precision
在该函数本身花费的总时间，不包括被其调用的其他函数，以毫秒计
27.2.25. pg_stat_slru #
PostgreSQL 访问某些磁盘上的信息，
通过 SLRU (简单最近最少使用) 缓存。
pg_stat_slru 视图将包含每个被跟踪的 SLRU 缓存的一行，
显示有关访问缓存页面的统计信息。
对于作为核心服务器一部分的每个SLRU缓存，存在一个配置参数控制其大小，
参数名后缀为_buffers。
表 27.35. pg_stat_slru 视图
列类型
描述
name text
SLRU 的名称
blks_zeroed bigint
初始化期间被置零的块数
blks_hit bigint
已经在SLRU中的磁盘块被发现的次数，因此不需要读取（这只包括SLRU中的命中，而不是操作系统的文件系统缓存）
blks_read bigint
为这个SLRU读取的磁盘块数
blks_written bigint
为这个SLRU写入的磁盘块数
blks_exists bigint
为这个SLRU检查是否存在的块数
flushes bigint
此SLRU的脏数据刷新数
truncates bigint
这个SLRU的截断数
stats_reset timestamp with time zone
这些统计数据最后一次重置的时间
27.2.26. Statistics Functions #
其他查看统计信息的方法是通过编写查询来实现，这些查询使用上述标准视图所用的底层统计信息访问函数。
如要了解如函数名等细节，可参考标准视图的定义（例如，在psql中你可以发出\d+ pg_stat_activity）。
针对每个数据库统计信息的访问函数把一个数据库 OID 作为参数来标识要报告哪个数据库。
针对每个表和每个索引的函数要求表或索引 OID。
针对每个函数统计信息的函数用一个函数 OID。
注意只有在当前数据库中的表、索引和函数才能被这些函数看到。
与累积统计系统相关的其他功能在表 27.36中列出。
表 27.36. Additional Statistics Functions
函数
描述
pg_backend_pid ()
→ integer
返回附加到当前会话的服务器进程的进程 ID。
pg_stat_get_backend_io ( integer )
→ setof record
返回具有指定进程 ID 的后端的 I/O 统计信息。输出字段与
pg_stat_io 视图中的字段完全相同。
此函数不返回检查点进程、后台写入器、启动进程和 autovacuum 启动器的 I/O 统计信息，
因为它们已经在 pg_stat_io 视图中可见，并且每种类型只有一个。
pg_stat_get_activity ( integer )
→ setof record
使用指定的进程 ID 返回有关后端信息的记录，如果指定了NULL，则返回系统中每个活动后端的一条记录。
返回的字段是pg_stat_activity视图中字段的子集。
pg_stat_get_backend_wal ( integer )
→ record
返回具有指定进程 ID 的后端的 WAL 统计信息。输出字段与
pg_stat_wal 视图中的字段完全相同。
此函数不返回检查点进程、后台写入器、启动进程和 autovacuum 启动器的 WAL 统计信息。
pg_stat_get_snapshot_timestamp ()
→ 带时区的时间戳
返回当前统计快照的时间戳，如果没有统计快照则返回NULL。如果在事务中第一次访问累积统计信息时将stats_fetch_consistency设置为snapshot。
pg_stat_get_xact_blocks_fetched ( oid )
→ bigint
返回当前事务中表或索引的块读取请求次数。这个数字减去
pg_stat_get_xact_blocks_hit给出了内核read()调用的次数；实际的物理读取次数通常较低，这是由于内核级别的缓冲。
pg_stat_get_xact_blocks_hit ( oid )
→ bigint
返回在当前事务中在缓存中找到的表或索引的块读取请求次数（不触发内核read()调用）。
pg_stat_clear_snapshot ()
→ void
丢弃当前的统计快照或缓存信息。
pg_stat_reset ()
→ void
将当前数据库的所有统计计数器重置为零。
默认情况下该函数仅限于超级用户，但其他用户可以被授予EXECUTE权限以运行此函数。
pg_stat_reset_shared ( [ target text DEFAULT NULL ] )
→ void
根据参数重置一些集群范围内的统计计数器为零。target 可以是：
archiver：重置pg_stat_archiver视图中显示的所有计数器。
bgwriter：重置pg_stat_bgwriter视图中显示的所有计数器。
checkpointer：重置pg_stat_checkpointer视图中显示的所有计数器。
io：重置pg_stat_io视图中显示的所有计数器。
recovery_prefetch：重置pg_stat_recovery_prefetch视图中显示的所有计数器。
slru：重置pg_stat_slru视图中显示的所有计数器。
wal：重置pg_stat_wal视图中显示的所有计数器。
NULL或未指定：重置上述所有视图中的计数器。
默认情况下，此函数仅限超级用户使用，但可以授予其他用户EXECUTE权限以运行该函数。
pg_stat_reset_single_table_counters ( oid )
→ void
重置当前数据库中的单个表或索引的统计信息，或者在集群中跨所有数据库共享的统计信息为零。
默认情况下，此函数仅限超级用户使用，但可以授予其他用户EXECUTE权限以运行该函数。
pg_stat_reset_backend_stats ( integer )
→ void
将具有指定进程 ID 的单个后端的统计信息重置为零。
此函数默认仅限超级用户使用，但可以授予其他用户EXECUTE权限以运行该函数。
pg_stat_reset_single_function_counters ( oid )
→ void
将当前数据库中单个函数的统计信息重置为零。
默认情况下该函数仅限于超级用户，但其他用户可以被授予EXECUTE来运行此函数。
pg_stat_reset_slru ( [ target text DEFAULT NULL ] )
→ void
将单个 SLRU 缓存或集群中所有 SLRU 的统计信息重置为零。如果 target 是
NULL 或未指定，则重置 pg_stat_slru 视图中显示的所有
SLRU 缓存的计数器。参数可以是
commit_timestamp、
multixact_member、
multixact_offset、
notify、
serializable、
subtransaction，或
transaction，
用于仅重置该条目的计数器。
如果参数是 other（或任何未识别的名称），则重置所有其他 SLRU 缓存的计数器，
例如扩展定义的缓存。
默认情况下，此函数仅限超级用户使用，但可以授予其他用户 EXECUTE 权限以运行该函数。
pg_stat_reset_replication_slot ( text )
→ void
重置由参数定义的复制槽的统计信息。如果参数为NULL，则重置所有复制槽的统计信息。
该函数默认仅限于超级用户，但可以授予其他用户EXECUTE权限来运行该函数。
pg_stat_reset_subscription_stats ( oid )
→ void
重置pg_stat_subscription_stats视图中显示的单个订阅的统计信息为零。
如果参数是NULL，则重置所有订阅的统计信息。
默认情况下，此函数仅限超级用户使用，但其他用户可以被授予EXECUTE权限来运行该函数。
警告
使用pg_stat_reset()还会重置自动清理使用的计数器，
以确定何时触发清理或分析。重置这些计数器可能导致自动清理不执行必要的工作，
这可能会导致问题，如表膨胀或过时的表统计信息。建议在统计信息重置后进行全库ANALYZE。
pg_stat_get_activity，是视图pg_stat_activity的底层函数，
返回包含每个后端进程所有可用信息的记录集。有时仅获取这部分信息的子集会更方便。
在这种情况下，可以使用另一组每后端统计访问函数；这些函数显示在表 27.37中。
这些访问函数使用会话的后端ID号，该ID号是一个小整数（>= 0），与任何并发会话的后端ID不同，
尽管会话的ID在退出后可以被回收。后端ID用于识别会话的临时模式（如果有的话）等用途。
函数pg_stat_get_backend_idset提供了一种方便的方法来列出所有活动后端的ID号，
以便调用这些函数。例如，要显示所有后端的PID和当前查询：
SELECT pg_stat_get_backend_pid(backendid) AS pid,
pg_stat_get_backend_activity(backendid) AS query
FROM pg_stat_get_backend_idset() AS backendid;
表 27.37. 每个后端统计函数
函数
描述
pg_stat_get_backend_activity ( integer )
→ text
返回此后端最近查询的文本。
pg_stat_get_backend_activity_start ( integer )
→ timestamp with time zone
返回后端最近一次查询开始的时间。
pg_stat_get_backend_client_addr ( integer )
→ inet
返回连接到此后端的客户端的IP地址。
pg_stat_get_backend_client_port ( integer )
→ integer
返回客户端用于通信的TCP端口号。
pg_stat_get_backend_dbid ( integer )
→ oid
返回此后端连接的数据库的OID。
pg_stat_get_backend_idset ()
→ setof integer
返回当前活动的后端ID号集合。
pg_stat_get_backend_pid ( integer )
→ integer
返回此后端进程ID。
pg_stat_get_backend_start ( integer )
→ timestamp with time zone
返回该进程开始的时间。
pg_stat_get_backend_subxact ( integer )
→ 记录
返回关于具有指定ID的后端子事务的信息记录。
返回的字段包括subxact_count，表示后端子事务缓存中的
子事务数量，以及subxact_overflow，指示后端的子事务
缓存是否溢出。
pg_stat_get_backend_userid ( integer )
→ oid
返回登录到此后端的用户的OID。
pg_stat_get_backend_wait_event ( integer )
→ text
如果后端当前正在等待，则返回等待事件名称，否则为NULL。参见
表 27.5 到 表 27.13。
pg_stat_get_backend_wait_event_type ( integer )
→ text
如果后端当前正在等待，返回等待事件类型名称，否则返回NULL。
详请参见表 27.4。
pg_stat_get_backend_xact_start ( integer )
→ timestamp with time zone
返回后端当前事务开始的时间。
上一页 上一级 下一页27.1. 标准 Unix 工具 起始页 27.3. 查看锁
