# 9.28. 系统管理函数

9.28. 系统管理函数
版本：
纠错本页面
搜索
目录导航
❮
❯
9.28. 系统管理函数 #9.28.1. 配置设置函数9.28.2. 服务器信号函数9.28.3. 备份控制函数9.28.4. 恢复控制函数9.28.5. 快照同步函数9.28.6. 复制管理函数9.28.7. 数据库对象管理函数9.28.8. 索引维护函数9.28.9. 通用文件访问函数9.28.10. 顾问锁函数
这一节描述的函数用于控制和监视一个PostgreSQL安装。
9.28.1. 配置设置函数 #
表 9.95显示可用于查询和修改运行时配置参数的函数。
表 9.95. 配置设置函数
函数
描述
示例
current_setting ( setting_name text [, missing_ok boolean ] )
→ text
返回设置的setting_name的当前值。如果没有这样的设置，current_setting将抛出一个错误，除非missing_ok被提供并且为true（在此情况下返回NULL）。这个函数对应于SQL命令SHOW。
current_setting('datestyle')
→ ISO, MDY
set_config (
setting_name text,
new_value text,
is_local boolean )
→ text
将参数 setting_name 设置为 new_value，
并返回该值。如果 is_local 为 true，
新值仅在当前事务期间有效。如果希望新值在当前会话的其余时间内有效，
请使用 false。此函数对应于 SQL 命令 SET。
set_config 接受 new_value 的 NULL 值，
但由于设置不能为 NULL，因此它被解释为请求将设置重置为其默认值。
set_config('log_statement_stats', 'off', false)
→ off
9.28.2. 服务器信号函数 #
在表 9.96中展示的函数向其他服务器进程发送控制信号。默认情况下这些函数只能被超级用户使用，但是如果需要，可以利用GRANT把访问特权授予给其他用户。
每个这样的函数如果信号成功发出则返回true，如果发送信号失败则返回false。
表 9.96. 服务器信号函数
函数
描述
pg_cancel_backend ( pid integer )
→ boolean
取消具有指定进程 ID 的会话的当前查询。如果调用角色是被取消的后端的角色成员，
或者调用角色具有 pg_signal_backend 权限，则也允许这样做，
但是只有超级用户可以取消超级用户后端。
作为例外，具有 pg_signal_autovacuum_worker 权限的角色被允许
取消 autovacuum 工作进程，这些进程在其他情况下被视为超级用户后端。
pg_log_backend_memory_contexts ( pid integer )
→ boolean
请求记录具有指定进程ID的后端的内存上下文。此函数可以将请求发送到后端和辅助进程，但不包括记录器。这些内存上下文将以
LOG消息级别记录。它们将根据设置的日志配置出现在服务器日志中
(有关更多信息，请参见第 19.8 节)，
但无论如何都不会发送给客户端
(client_min_messages)。
pg_reload_conf ()
→ boolean
使PostgreSQL服务器的所有进程重新加载其配置文件。
（这是通过向postmaster进程发送SIGHUP信号来启动的，
postmaster进程又向其每个子进程发送SIGHUP。）
您可以使用pg_file_settings、
pg_hba_file_rules和
pg_ident_file_mappings视图来检查可能存在的错误，
然后再重新加载配置文件。
pg_rotate_logfile ()
→ boolean
通知日志文件管理器立即切换到一个新的输出文件。
这仅在内置日志采集器运行时有效，因为否则没有日志文件管理器子进程。
pg_terminate_backend ( pid integer, timeout bigint DEFAULT 0 )
→ boolean
终止具有指定进程 ID 的会话。如果调用角色是被终止的后端的角色成员，
或者调用角色具有 pg_signal_backend 权限，则也允许这样做，
但是只有超级用户可以终止超级用户后端。
作为例外，具有 pg_signal_autovacuum_worker 权限的角色被允许
终止 autovacuum 工作进程，这些进程在其他情况下被视为超级用户后端。
如果未指定 timeout 或其值为零，则此函数返回 true，
无论进程是否实际终止，仅表示信号发送成功。如果指定了 timeout（以毫秒为单位）并且大于零，
函数将等待直到进程实际终止或直到给定时间过去。如果进程被终止，函数
返回 true。在超时情况下，将发出警告并返回 false。
pg_cancel_backend和pg_terminate_backend向由进程 ID 标识的后端进程发送信号（分别是SIGINT或SIGTERM）。
一个活动后端的进程 ID可以从pg_stat_activity视图的pid列中找到，或者通过在服务器上列出postgres进程（在 Unix 上使用ps或者在Windows上使用任务管理器）得到。
一个活动后端的角色可以在pg_stat_activity视图的usename列中找到。
pg_log_backend_memory_contexts 可用于记录后端进程的内存上下文。例如：
postgres=# SELECT pg_log_backend_memory_contexts(pg_backend_pid());
pg_log_backend_memory_contexts
--------------------------------
t
(1 row)
每个内存上下文将记录一条消息。例如：
LOG:  logging memory contexts of PID 10377
STATEMENT:  SELECT pg_log_backend_memory_contexts(pg_backend_pid());
LOG:  level: 1; TopMemoryContext: 80800 total in 6 blocks; 14432 free (5 chunks); 66368 used
LOG:  level: 2; pgstat TabStatusArray lookup hash table: 8192 total in 1 blocks; 1408 free (0 chunks); 6784 used
LOG:  level: 2; TopTransactionContext: 8192 total in 1 blocks; 7720 free (1 chunks); 472 used
LOG:  level: 2; RowDescriptionContext: 8192 total in 1 blocks; 6880 free (0 chunks); 1312 used
LOG:  level: 2; MessageContext: 16384 total in 2 blocks; 5152 free (0 chunks); 11232 used
LOG:  level: 2; Operator class cache: 8192 total in 1 blocks; 512 free (0 chunks); 7680 used
LOG:  level: 2; smgr relation table: 16384 total in 2 blocks; 4544 free (3 chunks); 11840 used
LOG:  level: 2; TransactionAbortContext: 32768 total in 1 blocks; 32504 free (0 chunks); 264 used
...
LOG:  level: 2; ErrorContext: 8192 total in 1 blocks; 7928 free (3 chunks); 264 used
LOG:  Grand total: 1651920 bytes in 201 blocks; 622360 free (88 chunks); 1029560 used
如果同一父上下文下的子上下文超过 100 个，将记录前 100 个子上下文，并附上其余上下文的摘要。
请注意，频繁调用此函数可能会产生显著的开销，
因为它可能会生成大量日志消息。
9.28.3. 备份控制函数 #
在表 9.97中显示的函数有助于进行在线备份。
这些函数在恢复过程中无法执行（除了pg_backup_start、
pg_backup_stop和pg_wal_lsn_diff）。
有关正确使用这些函数的详细信息，参见第 25.3 节。
表 9.97. 备份控制函数
函数
描述
pg_create_restore_point ( name text )
→ pg_lsn
在预写日志中创建一个命名标记记录，稍后可以将其用作恢复目标，并返回相应的预写日志位置。
然后可以将给定的名称与recovery_target_name一起使用，以指定进行恢复的点。
要避免创建多个名称相同的恢复点，因为恢复将在第一个名称与恢复目标匹配的恢复点停止。
默认情况下，该函数仅限超级用户使用，但可以授权给其他用户执行该函数。
pg_current_wal_flush_lsn ()
→ pg_lsn
返回当前预写日志刷新位置（参见下面的说明）。
pg_current_wal_insert_lsn ()
→ pg_lsn
返回当前预写日志插入位置（参见下面的说明）。
pg_current_wal_lsn ()
→ pg_lsn
返回当前预写日志写位置（参见下面的说明）。
pg_backup_start (
label text
[, fast boolean
] )
→ pg_lsn
准备服务器开始在线备份。唯一必需的参数是备份的任意用户定义标签。
（通常这将是备份转储文件存储的名称。）
如果将可选的第二个参数指定为true，
它将尽快执行pg_backup_start。这将强制立即进行检查点，
这将导致I/O操作的激增，从而减慢任何同时执行的查询。
默认情况下，此函数仅限于超级用户，但可以授予其他用户执行权限以运行该函数。
pg_backup_stop (
[wait_for_archive boolean
] )
→ record
( lsn pg_lsn,
labelfile text,
spcmapfile text )
完成在线备份。函数的结果中返回备份标签文件和表空间映射文件的期望内容，并必须写入备份区域的文件中。
这些文件不得写入实时数据目录（这样做将导致PostgreSQL在崩溃时无法重新启动）。
有一个类型为boolean的可选参数。
如果为false，则在备份完成后立即返回，而无需等待WAL进行归档。
此行为仅适用于独立监视WAL归档的备份软件。否则，可能会缺少使备份一致所需的WAL，使备份无效。
默认情况下或当此参数为true时，pg_backup_stop将在启用归档时等待WAL进行归档。
（在备用机上，这意味着仅当archive_mode = always时才会等待。
如果主机上的写入活动较低，则可能有必要在主机上运行pg_switch_wal以触发立即段切换。）
在主机上执行时，此函数还会在预写式日志归档区域中创建一个备份历史文件。
历史文件包括给定给pg_backup_start的标签、备份的起始和结束预写式日志位置，以及备份的起始和结束时间。
在记录结束位置后，当前的预写式日志插入点会自动前进到下一个预写式日志文件，以便立即归档结束的预写式日志文件以完成备份。
函数的结果是一个记录。
lsn列保存备份的结束预写式日志位置（可以忽略）。
第二列返回备份标签文件的内容，第三列返回表空间映射文件的内容。
这些必须作为备份的一部分存储，并作为恢复过程的一部分。
默认情况下，此函数仅限于超级用户，但可以授予其他用户EXECUTE权限来运行该函数。
pg_switch_wal ()
→ pg_lsn
强制服务器切换到一个新的预写式日志文件，这允许对当前文件进行归档（假设你正在使用
连续归档）。其结果是在刚刚完成的预写式日志文件中结束预写式日志位置加1。
如果自从上次预写式日志切换以来没有预写式日志活动，pg_switch_wal将不做任何操作，并返回当前正在使用的预写式日志文件的起始位置。
默认情况下该函数仅限超级用户使用，但可以授权其他用户执行该函数。
pg_walfile_name ( lsn pg_lsn )
→ text
将预写式日志位置转换为保持该位置的WAL文件的名称。
pg_walfile_name_offset ( lsn pg_lsn )
→ record
( file_name text,
file_offset integer )
将预写式日志位置转换为WAL文件名和该文件中的字节偏移量。
pg_split_walfile_name ( file_name text )
→ record
( segment_number numeric,
timeline_id bigint )
从一个WAL文件名中提取序列号和时间线ID。
pg_wal_lsn_diff ( lsn1 pg_lsn, lsn2 pg_lsn )
→ numeric
计算两个预写式日志位置之间的字节（lsn1 - lsn2）差异。
这可以与pg_stat_replication或表 9.97中所示的一些函数一起使用，以获得复制延迟。
pg_current_wal_lsn 显示当前预写式日志写位置，与上述函数所用的格式相同。
类似地，pg_current_wal_insert_lsn显示当前预写式日志插入位置，pg_current_wal_flush_lsn显示当前预写式日志刷新位置。
插入位置是预写式日志在任何时刻的“逻辑”结束，而写位置是已经从服务器内部缓冲区实际写入的内容的结束，而刷新位置是已知的要写入持久化存储的最后一个位置。
写位置是可以从服务器外部检查的最后位置，如果你对归档部分完成的预写式日志文件感兴趣，那么它通常就是你想要的位置。
插入和刷新位置主要用于服务器调试目的。这些都是只读操作，不需要超级用户权限。
你可以使用pg_walfile_name_offset从pg_lsn值中提取对应的写前日志文件名和字节偏移量。
例如：
postgres=# SELECT * FROM pg_walfile_name_offset((pg_backup_stop()).lsn);
file_name         | file_offset
--------------------------+-------------
00000001000000000000000D |     4039624
(1 row)
同样，pg_walfile_name只提取写前日志文件名。
pg_split_walfile_name 用于从文件偏移量和 WAL 文件名计算
LSN，例如：
postgres=# \set file_name '000000010000000100C000AB'
postgres=# \set offset 256
postgres=# SELECT '0/0'::pg_lsn + pd.segment_number * ps.setting::int + :offset AS lsn
FROM pg_split_walfile_name(:'file_name') pd,
pg_show_all_settings() ps
WHERE ps.name = 'wal_segment_size';
lsn
---------------
C001/AB000100
(1 row)
9.28.4. 恢复控制函数 #
表 9.98中展示的函数提供有关备用服务器当前状态的信息。
这些函数可以在恢复或正常运行过程中被执行。
表 9.98. 恢复信息函数
函数
描述
pg_is_in_recovery ()
→ boolean
如果恢复仍在进行则返回真。
pg_last_wal_receive_lsn ()
→ pg_lsn
返回已接收并通过流复制同步到磁盘的最后一个写前日志位置。
当流复制正在进行时这将单调地增加。如果恢复已经完成，那么在恢复期间，接收到的最后一条WAL记录的位置将保持静态，并同步到磁盘。
如果流复制已禁用，或者尚未启动，函数将返回NULL。
pg_last_wal_replay_lsn ()
→ pg_lsn
返回恢复期间重新播放的最后一个预写式日志位置。如果恢复仍在进行中，这将单调地增加。
如果恢复已经完成，那么恢复期间应用的最后WAL记录的位置将保持静态。当服务器正常启动且没有恢复时，函数返回NULL。
pg_last_xact_replay_timestamp ()
→ timestamp with time zone
返回恢复期间重放的最后一个事务的时间戳。这是在主服务器上为该事务生成提交或中止WAL记录的时间。
如果在恢复期间没有重放任何事务，该函数将返回NULL。否则，如果恢复仍在进行中，这将单调地增加。
如果恢复已经完成，那么在恢复期间应用最后一个事务时，这将会保持静态。
当服务器正常启动且没有恢复时，函数返回NULL。
pg_get_wal_resource_managers ()
→ setof record
( rm_id integer,
rm_name text,
rm_builtin boolean )
返回系统中当前加载的WAL资源管理器。列rm_builtin指示它是内置资源管理器还是由扩展加载的自定义资源管理器。
控制恢复进度的功能如 表 9.99所示。这些函数只能在恢复过程中执行。
表 9.99. 恢复控制函数
函数
描述
pg_is_wal_replay_paused ()
→ boolean
如果请求了恢复暂停，则返回真。
pg_get_wal_replay_pause_state ()
→ text
返回恢复暂停状态。如果没有请求暂停，返回值是not paused，如果请求暂停但恢复还没有暂停，返回值是pause requested，如果恢复实际已经暂停，返回值是paused。
pg_promote ( wait boolean DEFAULT true, wait_seconds integer DEFAULT 60 )
→ boolean
将备用服务器提升为主服务器状态。
当wait设置为true（默认值）时，函数将等待直到提升完成或wait_seconds秒数已过，如果提升成功则返回true，否则返回false。
如果wait设置为false，则该函数在向postmaster发送SIGUSR1信号以触发提升后立即返回true。
默认情况下这个函数仅限超级用户使用，但可以授权给其他用户执行该函数。
pg_wal_replay_pause ()
→ void
请求暂停恢复。
请求不意味着恢复马上停止。
如果你想要保证恢复实际上是暂停的，你需要检查pg_get_wal_replay_pause_state()返回的恢复暂停状态。
注意，pg_is_wal_replay_paused()返回是否作出请求。
在恢复暂停时，不会应用进一步的数据库更改。
如果热备是激活的，所有新查询将看到相同的一致的数据库快照，并且在恢复继续之前不会生成进一步的查询冲突。
默认情况下该函数仅限超级用户使用，但可以授权其他用户执行该函数。
pg_wal_replay_resume ()
→ void
如果暂停了，则重新启动恢复。
默认情况下该函数仅限超级用户使用，但可以授权其他用户执行该函数。
pg_wal_replay_pause和pg_wal_replay_resume不能在提升进行时执行。
如果在恢复暂停时触发了提升，则暂停状态结束，提升继续进行。
如果禁用了流复制，则暂停状态可能会无限期地持续下去，不会出现问题。
如果正在进行流复制，那么将继续接收WAL记录，这将最终填满可用磁盘空间，这取决于暂停持续时间、WAL生成速度和可用磁盘空间。
9.28.5. 快照同步函数 #
PostgreSQL允许数据库会话同步它们的快照。一个快照决定对于正在使用该快照的事务哪些数据是可见的。当两个或更多个会话需要看到数据库中的相同内容时，就需要同步快照。如果两个会话独立开始其事务，就总是有可能有某个第三事务在两个START TRANSACTION命令的执行之间提交，这样其中一个会话就可以看到该事务的效果而另一个则看不到。
为了解决这个问题，PostgreSQL允许一个事务导出它正在使用的快照。只要导出的事务仍然保持打开，其他事务可以导入它的快照，并且因此可以保证它们可以看到和第一个事务看到的完全一样的数据库视图。但是注意这些事务中的任何一个对数据库所作的更改对其他事务仍然保持不可见，和未提交事务所作的修改一样。因此这些事务是针对以前存在的数据同步，而对由它们自己所作的更改则采取正常的动作。
如表 9.100中所示，快照通过pg_export_snapshot函数导出，并且通过SET TRANSACTION命令导入。
表 9.100. 快照同步函数
函数
描述
pg_export_snapshot ()
→ text
保存事务的当前快照并返回text字符串以标识该快照。
必须将此字符串传递（在数据库之外）给希望导入快照的客户端。快照仅在导出它的事务结束之前才可用于导入。
如果需要的话，一个事务可以导出多个快照。
请注意，这样做仅在READ COMMITTED事务中有用，因为在REPEATABLE READ和更高的隔离级别中，事务在它们的生命周期中使用相同的快照。
一旦事务导出了快照，它就不能用 PREPARE TRANSACTION进行准备。
pg_log_standby_snapshot ()
→ pg_lsn
获取正在运行事务的快照并将其写入WAL，而无需等待bgwriter或checkpointer
记录一个。这对于备用上的逻辑解码非常有用，因为逻辑槽的创建必须等到
这样的记录在备用上被重放后才能完成。
9.28.6. 复制管理函数 #
表 9.101中展示的函数用于控制以及与复制特性交互。
有关底层特性的信息请见第 26.2.5 节、第 26.2.6 节以及第 48 章。
复制原点函数的使用仅限于超级用户。
默认只允许超级用户使用复制源的函数，但可以通过GRANT命令允许其他用户使用。
复制槽的函数只限于超级用户和拥有REPLICATION权限的用户。
很多这些函数在复制协议中都有等价的命令，见
第 54.4 节。
第 9.28.3 节、
第 9.28.4 节和
第 9.28.5 节
中描述的函数也与复制相关。
表 9.101. 复制管理函数
函数
描述
pg_create_physical_replication_slot ( slot_name name [, immediately_reserve boolean, temporary boolean ] )
→ record
( slot_name name,
lsn pg_lsn )
创建一个新的名为slot_name的物理复制槽。
第二个参数是可选的，当它为true时，指定立即为这个
复制槽保留LSN；否则该LSN会在来自
流复制客户端的第一个连接时被保留。来自一个物理槽的流改变只可能出现在
使用流复制协议时 — 见第 54.4 节。当可选的
第三个参数temporary被设置为真时，指定该槽不会被
持久地存储在磁盘上，并且仅对当前会话的使用有意义。临时槽也会在发生
任何错误时被释放。这个函数对应于复制协议命令CREATE_REPLICATION_SLOT
... PHYSICAL。
pg_drop_replication_slot ( slot_name name )
→ void
删除名为slot_name的物理或逻辑复制槽。与复制协议命令
DROP_REPLICATION_SLOT相同。
pg_create_logical_replication_slot ( slot_name name, plugin name [, temporary boolean, twophase boolean, failover boolean ] )
→ record
( slot_name name,
lsn pg_lsn )
创建一个新的逻辑（解码）复制槽，名称为slot_name，
使用输出插件plugin。可选的第三个参数temporary，
当设置为true时，指定该槽不应永久存储到磁盘，仅供当前会话使用。
临时槽在发生任何错误时也会被释放。可选的第四个参数twophase，
当设置为true时，指定启用对该槽的预准备事务的解码。可选的第五个参数
failover，当设置为true时，指定该槽启用同步到备用节点，
以便在故障转移后可以恢复逻辑复制。调用此函数的效果等同于复制协议命令
CREATE_REPLICATION_SLOT ... LOGICAL。
pg_copy_physical_replication_slot ( src_slot_name name, dst_slot_name name [, temporary boolean ] )
→ record
( slot_name name,
lsn pg_lsn )
将现有的物理复制槽，名为src_slot_name，复制到名为
dst_slot_name的物理复制槽。复制的物理槽从与源槽相同的
LSN开始保留WAL。temporary是可选的。
如果省略temporary，则使用与源槽相同的值。不允许复制
已失效的槽。
pg_copy_logical_replication_slot ( src_slot_name name, dst_slot_name name [, temporary boolean [, plugin name ]] )
→ record
( slot_name name,
lsn pg_lsn )
复制一个已存在的逻辑复制槽，名为src_slot_name，到一个名为
dst_slot_name的逻辑复制槽，且可选择更改输出插件和持久性。
复制的逻辑槽从与源逻辑槽相同的LSN开始。temporary和
plugin都是可选的；如果省略，则使用源槽的值。源逻辑槽的
failover选项不会被复制，默认设置为false。
这是为了避免在故障转移到正在同步该槽的备用节点后无法继续逻辑复制的风险。
不允许复制已失效的槽。
pg_logical_slot_get_changes ( slot_name name, upto_lsn pg_lsn, upto_nchanges integer, VARIADIC options text[] )
→ setof record
( lsn pg_lsn,
xid xid,
data text )
返回槽slot_name中的更改，从上次消费更改的点开始。
如果upto_lsn和upto_nchanges为NULL，
逻辑解码将持续到WAL末尾。如果upto_lsn非NULL，
解码将仅包含在指定LSN之前提交的事务。如果upto_nchanges非NULL，
解码将在解码产生的行数超过指定值时停止。但请注意，实际返回的行数可能更多，
因为此限制仅在解码每个新事务提交时添加产生的行后检查。
如果指定的槽是逻辑故障转移槽，则函数不会返回，直到所有物理槽
synchronized_standby_slots
确认收到WAL。
pg_logical_slot_peek_changes ( slot_name name, upto_lsn pg_lsn, upto_nchanges integer, VARIADIC options text[] )
→ setof record
( lsn pg_lsn,
xid xid,
data text )
行为与
pg_logical_slot_get_changes() 函数完全相同，
不同之处在于更改不会被消费；也就是说，它们将在未来的调用中
再次返回。
pg_logical_slot_get_binary_changes ( slot_name name, upto_lsn pg_lsn, upto_nchanges integer, VARIADIC options text[] )
→ setof record
( lsn pg_lsn,
xid xid,
data bytea )
行为与 pg_logical_slot_get_changes() 函数完全相同，
只是返回的更改为 bytea 类型。
pg_logical_slot_peek_binary_changes ( slot_name name, upto_lsn pg_lsn, upto_nchanges integer, VARIADIC options text[] )
→ setof record
( lsn pg_lsn,
xid xid,
data bytea )
行为就像pg_logical_slot_peek_changes()函数，不过更改会以bytea返回。
pg_replication_slot_advance ( slot_name name, upto_lsn pg_lsn )
→ record
( slot_name name,
end_lsn pg_lsn )
推进名为slot_name的复制槽当前确认的位置。该槽不会向后移动，
也不会超过当前插入位置。返回槽的名称和实际推进到的位置。如果有任何推进，
更新后的槽位置信息将在下一个检查点写出。因此在崩溃事件中，槽可能会返回到
之前的位置。如果指定的槽是逻辑故障转移槽，则该函数不会返回，直到所有物理槽
中指定的
synchronized_standby_slots
确认了WAL接收。
pg_replication_origin_create ( node_name text )
→ oid
创建具有给定外部名称的复制源，并返回分配给它的内部ID。
名称不得超过512字节。
pg_replication_origin_drop ( node_name text )
→ void
删除一个以前创建的复制源，包括任何相关的重放进度。
pg_replication_origin_oid ( node_name text )
→ oid
通过名称查找复制源并返回其内部ID。如果未找到这样的复制源，则返回 NULL。
pg_replication_origin_session_setup ( node_name text )
→ void
将当前会话标记为从给定的源回放，从而允许跟踪回放进度。
只能在当前没有选择源时使用。使用pg_replication_origin_session_reset命令来撤销。
pg_replication_origin_session_reset ()
→ void
取消pg_replication_origin_session_setup()的效果。
pg_replication_origin_session_is_setup ()
→ boolean
如果在当前会话中选择了复制源，则返回真。
pg_replication_origin_session_progress ( flush boolean )
→ pg_lsn
返回当前会话中选择的复制源的重放位置。参数flush决定对应的本地事务是否被确保已经刷入磁盘。
pg_replication_origin_xact_setup ( origin_lsn pg_lsn, origin_timestamp timestamp with time zone )
→ void
将当前事务标记为重放在给定LSN和时间戳上提交的事务。
只能在使用pg_replication_origin_session_setup选择复制源时调用。
pg_replication_origin_xact_reset ()
→ void
取消pg_replication_origin_xact_setup()的效果。
pg_replication_origin_advance ( node_name text, lsn pg_lsn )
→ void
将给定节点的复制进度设置为给定的位置。这主要用于设置初始位置，或在配置更改或类似的变更后设置新位置。
请注意，这个函数的不当使用可能会导致不一致的复制数据。
pg_replication_origin_progress ( node_name text, flush boolean )
→ pg_lsn
返回给定复制源的重放位置。参数flush决定对应的本地事务是否被确保已经刷入磁盘。
pg_logical_emit_message ( transactional boolean, prefix text, content text [, flush boolean DEFAULT false] )
→ pg_lsn
pg_logical_emit_message ( transactional boolean, prefix text, content bytea [, flush boolean DEFAULT false] )
→ pg_lsn
发出逻辑解码消息。这可以用于通过 WAL 将通用消息传递给逻辑解码插件。transactional 参数指定消息是否应成为当前事务的一部分，或者是否应立即写入并在逻辑解码器读取记录时解码。prefix 参数是一个文本前缀，逻辑解码插件可以使用它来轻松识别对它们有趣的消息。content 参数是消息的内容，可以是文本或二进制形式。flush 参数（默认设置为 false）控制消息是否立即刷新到 WAL。flush 对 transactional 没有影响，因为消息的 WAL 记录与其事务一起刷新。
pg_sync_replication_slots ()
→ void
从主服务器同步逻辑故障转移复制槽到备用服务器。此函数只能在备用服务器上执行。临时同步槽（如果有）不能用于逻辑解码，并且必须在提升后删除。有关详细信息，请参见 第 47.2.3 节。请注意，此函数主要用于测试和调试目的，应谨慎使用。此外，如果 sync_replication_slots 已启用，并且 slotsync 工作进程已在运行以执行槽的同步，则无法执行此函数。
小心
如果在执行函数后，备用上禁用 hot_standby_feedback，或者在 primary_slot_name 中配置的物理槽被移除，则可能会导致同步槽的必要行被主服务器上的 VACUUM 过程删除，从而使同步槽失效。
9.28.7. 数据库对象管理函数 #
表 9.102中所示的函数计算数据库对象的磁盘空间使用情况，或帮助表示或理解使用结果。bigint结果以字节为单位。如果将不代表已有对象的OID传递给这些函数之一，则返回NULL。
表 9.102. 数据库对象大小函数
函数
描述
pg_column_size ( "any" )
→ integer
显示用于存储任何单个数据值的字节数。如果直接应用于表的列值，则反映所做的任何压缩。
pg_column_compression ( "any" )
→ text
显示用于压缩单个变长值的压缩算法。如果值没有被压缩，则返回NULL。
pg_column_toast_chunk_id ( "any" )
→ oid
显示一个磁盘上chunk_id的
TOAST值。如果该值未被
TOAST或不在磁盘上，则返回NULL。
详情请参见第 66.2 节关于
TOAST的更多信息。
pg_database_size ( name )
→ bigint
pg_database_size ( oid )
→ bigint
计算具有指定名称或OID的数据库使用的总磁盘空间。要使用此函数，您必须对指定数据库具有CONNECT权限
（默认情况下授予），或者具有pg_read_all_stats角色的权限。
pg_indexes_size ( regclass )
→ bigint
计算附加到指定表的索引所使用的总磁盘空间。
pg_relation_size ( relation regclass [, fork text ] )
→ bigint
计算指定关系的一个“fork”所使用的磁盘空间。
(注意在大多数情况下，使用更高级的函数 pg_total_relation_size或pg_table_size更方便，它们将所有分叉的大小相加。)
使用一个参数，这将返回关系的主数据分叉的大小。第二个参数可以用来指定要检查哪个分叉:
main返回关系的主数据分叉的大小。
fsm 返回与该关系关联的空闲空间映射(参见第 66.3 节)的大小。
vm 返回与该关系相关联的可见性映射(参见第 66.4 节)的大小。
init 返回初始化分叉的大小，如果有的话，与关系相关。
pg_size_bytes ( text )
→ bigint
将人类可读格式的大小（由pg_size_pretty返回）转换为字节。
有效单位包括bytes、B、kB、
MB、GB、TB和PB。
pg_size_pretty ( bigint )
→ text
pg_size_pretty ( numeric )
→ text
将字节大小转换为更易于人类阅读的格式，带有大小单位（字节，kB，MB，GB，TB或PB）。请注意，单位是2的幂，而不是10的幂，因此1kB是1024字节，
1MB是10242 = 1048576字节，依此类推。
pg_table_size ( regclass )
→ bigint
计算指定表所使用的磁盘空间，不包括索引(但包括它的TOAST表，如果有的话，空闲空间映射，以及可见性映射)。
pg_tablespace_size ( name )
→ bigint
pg_tablespace_size ( oid )
→ bigint
计算具有指定名称或OID的表空间中使用的总磁盘空间。
要使用此函数，您必须对指定的表空间具有CREATE权限，
或者具有pg_read_all_stats角色的权限，
除非它是当前数据库的默认表空间。
pg_total_relation_size ( regclass )
→ bigint
计算指定表所使用的总磁盘空间，包括所有索引和TOAST数据。
结果等价于pg_table_size + pg_indexes_size。
上述操作表和索引的函数接受一个regclass参数，它是该表或索引在pg_class系统目录中的 OID。
你不必手工去查找该 OID，因为regclass数据类型的输入转换器会为你代劳。
只需写包围在单引号内的表名，这样它看起来像一个文字常量。
为了与普通SQL名称的处理相兼容，该字符串将被转换为小写形式，除非其中在表名周围包含双引号。
详见第 8.19 节。
表 9.103中展示的函数帮助标识数据库对象相关的磁盘文件。
表 9.103. 数据库对象位置函数
函数
描述
pg_relation_filenode ( relation regclass )
→ oid
返回当前分配给指定关系的“filenode”数字。文件节点是用于该关系的文件名称的基本组件（更多信息请参阅第 66.1 节）。
对于大多数关系，其结果与pg_class.relfilenode相同，但对于某些系统目录，relfilenode为0，并且必须使用这个函数来获得正确的值。
如果传递的是一个没有存储的关系，例如一个视图，那么函数将返回NULL。
pg_relation_filepath ( relation regclass )
→ text
返回关系的完整文件路径名称（相对于数据库集群的数据目录，PGDATA）。
pg_filenode_relation ( tablespace oid, filenode oid )
→ regclass
返回给定表空间 OID 和其存储的 filenode 的关系 OID。
这本质上是 pg_relation_filepath 的逆映射。
对于数据库的默认表空间，可以将表空间指定为零。
如果当前数据库中没有与给定值关联的关系，或者处理的是临时关系，则返回 NULL。
表 9.104 列出用于管理排序规则的函数。
表 9.104. 排序规则管理函数
函数
描述
pg_collation_actual_version ( oid )
→ text
返回当前安装在操作系统中的该排序规则对象的实际版本。
如果这个版本与pg_collation.collversion中的值不同，则依赖于该排序规则的对象可能需要被重建。
还可以参考ALTER COLLATION。
pg_database_collation_actual_version ( oid )
→ text
返回数据库当前在操作系统中安装的排序规则的实际版本。如果这与pg_database.datcollversion中的值不同，则依赖于排序规则的对象可能需要重新构建。
参见ALTER DATABASE。
pg_import_system_collations ( schema regnamespace )
→ integer
基于在操作系统中找到的所有区域环境，加入排序规则到系统目录pg_collation中。
这是 initdb 会用到的，更多细节请参考第 23.2.2 节。
如果后来在操作系统上安装了额外的区域环境，可以再次运行这个函数加入新区域环境的排序规则。
匹配pg_collation中现有条目的区域环境将被跳过（但是这个函数不会移除以在操作系统中不再存在的区域环境为基础的排序规则对象）。
schema参数通常是pg_catalog，但这不是一种要求，排序规则也可以被安装到其他的方案中。
该函数返回其创建的新排序规则对象的数量。
此函数仅限超级用户使用。
表 9.105 列出用于
操作统计信息的函数。
这些函数在恢复期间无法执行。
警告
这些统计信息操作函数所做的更改可能会被 autovacuum（或手动
VACUUM 或 ANALYZE）覆盖，应视为临时更改。
表 9.105. 数据库对象统计信息操作函数
函数
描述
pg_restore_relation_stats (
VARIADIC kwargs "any" )
→ boolean
更新表级统计信息。通常，这些统计信息是自动收集的，或作为 VACUUM 或 ANALYZE 的一部分进行更新，因此不必调用此函数。
然而，在恢复后调用此函数是有用的，以便优化器能够选择更好的计划，前提是
ANALYZE 尚未运行。
被跟踪的统计信息可能会因版本而异，因此参数以 argname
和 argvalue 的形式成对传递：
SELECT pg_restore_relation_stats(
'arg1name', 'arg1value'::arg1type,
'arg2name', 'arg2value'::arg2type,
'arg3name', 'arg3value'::arg3type);
例如，要为表 mytable 设置 relpages 和
reltuples 值：
SELECT pg_restore_relation_stats(
'schemaname', 'myschema',
'relname',    'mytable',
'relpages',   173::integer,
'reltuples',  10000::real);
参数 schemaname 和
relname 是必需的，指定表。其他参数是与
pg_class 中某些列对应的统计信息的名称和值。
当前支持的关系统计信息有
relpages，类型为 integer，reltuples，类型为
real，relallvisible，类型为 integer，以及 relallfrozen
，类型为 integer。
此外，此函数接受参数名称 version，类型为 integer，用于指定统计信息来源的服务器版本。
这预计将有助于从旧版本的 PostgreSQL 移植统计信息。
小错误将被报告为 WARNING 并被忽略，剩余的统计信息仍将被恢复。如果所有
指定的统计信息成功恢复，则返回 true，否则返回 false。
调用者必须对表具有 MAINTAIN 权限或是数据库的拥有者。
pg_clear_relation_stats ( schemaname text, relname text )
→ void
清除给定关系的表级统计信息，就好像该表是新创建的一样。
调用者必须对表具有 MAINTAIN 权限或是数据库的拥有者。
pg_restore_attribute_stats (
VARIADIC kwargs "any" )
→ boolean
创建或更新列级统计信息。通常，这些统计信息是自动收集的，或作为 VACUUM 或 ANALYZE 的一部分进行更新，因此不必调用此函数。
然而，在恢复后调用此函数是有用的，以便优化器能够选择更好的计划，前提是
ANALYZE 尚未运行。
被跟踪的统计信息可能会因版本而异，因此参数以 argname
和 argvalue 的形式成对传递：
SELECT pg_restore_attribute_stats(
'arg1name', 'arg1value'::arg1type,
'arg2name', 'arg2value'::arg2type,
'arg3name', 'arg3value'::arg3type);
例如，要为表 mytable 的属性 col1 设置
avg_width 和 null_frac 值：
SELECT pg_restore_attribute_stats(
'schemaname', 'myschema',
'relname',    'mytable',
'attname',    'col1',
'inherited',  false,
'avg_width',  125::integer,
'null_frac',  0.5::real);
必需的参数是 schemaname 和
relname，类型为 text，用于指定表；可以是 attname，类型为 text，或 attnum，类型为 smallint，用于指定列；以及 inherited，用于指定统计信息是否包括来自子表的值。其他参数是与
pg_stats 中列对应的统计信息的名称和值。
此外，此函数接受参数名称 version，类型为 integer，用于指定统计信息来源的服务器版本。
这预计将有助于从旧版本的 PostgreSQL 移植统计信息。
小错误将被报告为 WARNING 并被忽略，剩余的统计信息仍将被恢复。如果所有
指定的统计信息成功恢复，则返回 true，否则返回 false。
调用者必须对表具有 MAINTAIN 权限或是数据库的拥有者。
pg_clear_attribute_stats (
schemaname text,
relname text,
attname text,
inherited boolean )
→ void
清除给定关系和属性的列级统计信息，就好像该表是新创建的一样。
调用者必须对表具有 MAINTAIN 权限或是数据库的拥有者。
表 9.106 列出提供有关分区表结构信息的函数。
表 9.106. 分区信息函数
函数
描述
pg_partition_tree ( regclass )
→ setof record
( relid regclass,
parentrelid regclass,
isleaf boolean,
level integer )
列出给定分区表或分区索引的分区树中的表或索引，每行对应一个分区。
提供的信息包括分区的OID、其直接父分区的OID、一个布尔值以告知分区是否是叶子，以及一个整数用来告诉分区在层次结构中的级别。
对于输入表或索引，级别值为0，其直接子分区的为1，它们的分区为2，以此类推。
如果关系不存在，或者不是分区或分区表，则不返回行。
pg_partition_ancestors ( regclass )
→ setof regclass
列出给定分区的祖先关系，包括关系本身。如果关系不存在，或者不是分区或分区表，则不返回行。
pg_partition_root ( regclass )
→ regclass
返回给定关系所属的分区树的最顶级父节点。如果关系不存在，或者不是分区或分区表，则返回NULL。
例如，要检查分区表measurement中包含的数据的总大小，可以使用以下查询:
SELECT pg_size_pretty(sum(pg_relation_size(relid))) AS total_size
FROM pg_partition_tree('measurement');
9.28.8. 索引维护函数 #
表 9.107 显示了索引维护任务可以使用的函数。
(注意，这些维护任务通常由自动清理(autovacuum)自动完成;只有在特殊情况下才需要使用这些函数。)
这些函数在恢复过程中无法执行。这些函数的使用局限于超级用户和给定索引的所有者。
表 9.107. 索引维护函数
函数
描述
brin_summarize_new_values ( index regclass )
→ integer
扫描指定的BRIN索引以查找基表中当前没有被索引归纳的页面范围；
对于任何这样的范围，它都通过扫描这些表页来创建一个新的摘要索引元组。
返回插入到索引中的新页面范围摘要的数量。
brin_summarize_range ( index regclass, blockNumber bigint )
→ integer
归纳覆盖给定块的页面范围（如果还没有归纳的话）。这类似于
brin_summarize_new_values，只是它只处理覆盖给定表块数的页范围。
brin_desummarize_range ( index regclass, blockNumber bigint )
→ void
删除归纳了覆盖给定表块的页面范围的BRIN索引元组，如果有的话。
gin_clean_pending_list ( index regclass )
→ bigint
清理指定GIN索引的“pending”列表，通过将其中的条目批量移动到主要的GIN数据结构。
返回从挂起列表中删除的页数。如果参数是使用禁用fastupdate选项构建的GIN索引，则不会发生清理，结果为零，因为索引没有挂起的列表。
关于挂起列表和fastupdate选项的详细信息，请参见第 65.4.4.1 节和第 65.4.5 节。
9.28.9. 通用文件访问函数 #
表 9.108中展示的函数提供了对数据库服务器所在机器上的文件的本地访问。
只能访问数据库集簇目录以及log_directory中的文件，除非用户是超级用户或者被授予了角色pg_read_server_files。
使用相对路径访问集簇目录中的文件，以及匹配log_directory配置设置的路径访问日志文件。
注意在pg_read_file()或者相关函数上，向用户授予EXECUTE特权，
以允许他们有能力读取服务器上该数据库服务器进程能读取的任何文件；这些函数会绕过所有的数据库内特权检查。
这意味着，例如，具有这种访问的用户能够读取pg_authid表中存储着认证信息的内容，也能读取数据库中的任何表数据。
因此，授予对这些函数的访问应该要仔细考虑。
在授予这些函数的权限时，请注意，显示可选参数的表条目大多被实现为
具有不同参数列表的多个物理函数。如果要使用这些函数，必须分别授予
每个函数的权限。psql的\df
命令可以用来检查实际的函数签名。
其中一些函数接受一个可选的missing_ok参数，该参数指定当文件或
目录不存在时的行为。如果true，函数返回NULL或
一个空的结果集（视情况而定）。如果false，则会引发错误。（除了
“文件未找到”之外的失败情况在任何情况下都会报告为错误。）默认值是
false。
表 9.108. 通用文件访问函数
函数
描述
pg_ls_dir ( dirname text [, missing_ok boolean, include_dot_dirs boolean ] )
→ setof text
返回指定目录中所有文件（和目录以及其他特殊文件）的名称。include_dot_dirs参数标示在结果集中是否包括“.”和“..”；默认为不包括它们。要包括它们在missing_ok为true时能够有用，以从不存在的目录中辨别一个空目录。
这个函数默认限制为超级用户，但是其他用户可以被授予EXECUTE以运行此函数。
pg_ls_logdir ()
→ setof record
( name text,
size bigint,
modification timestamp with time zone )
返回服务器日志目录中每个普通文件的名称、大小和最后修改时间（mtime）。以点开头的文件名、目录和其他特殊文件将被排除。
默认情况下，此函数仅限于超级用户和具有pg_monitor角色特权的角色，但其他用户可以被授予EXECUTE权限来运行该函数。
pg_ls_waldir ()
→ setof record
( name text,
size bigint,
modification timestamp with time zone )
返回服务器的预写式日志（WAL）目录中每个普通文件的名称、大小和最后修改时间（mtime）。以点开头的文件名、目录和其他特殊文件将被排除。
默认情况下，此函数仅限于超级用户和具有pg_monitor角色特权的角色，但其他用户可以被授予EXECUTE权限来运行该函数。
pg_ls_logicalmapdir ()
→ setof record
( name text,
size bigint,
modification timestamp with time zone )
返回服务器的pg_logical/mappings目录中每个普通文件的名称、大小和最后修改时间（mtime）。以点开头的文件名、目录和其他特殊文件将被排除。
默认情况下，此函数仅限于超级用户和pg_monitor角色的成员，但其他用户可以被授予EXECUTE权限来运行该函数。
pg_ls_logicalsnapdir ()
→ setof record
( name text,
size bigint,
modification timestamp with time zone )
返回服务器的pg_logical/snapshots目录中每个普通文件的名称、大小和最后修改时间（mtime）。以点开头的文件名、目录和其他特殊文件将被排除。
默认情况下，此函数仅限于超级用户和pg_monitor角色的成员，但其他用户可以被授予EXECUTE权限来运行该函数。
pg_ls_replslotdir ( slot_name text )
→ setof record
( name text,
size bigint,
modification timestamp with time zone )
返回服务器的pg_replslot/slot_name目录中每个普通文件的名称、大小和最后修改时间（mtime），
其中slot_name是作为函数输入提供的复制槽的名称。以点开头的文件名、目录和其他特殊文件将被排除。
默认情况下，此函数仅限于超级用户和pg_monitor角色的成员，但其他用户可以被授予EXECUTE权限来运行该函数。
pg_ls_summariesdir ()
→ setof record
( name text,
size bigint,
modification timestamp with time zone )
返回服务器 WAL 汇总目录中每个普通文件的名称、大小和最后修改时间（mtime）
(pg_wal/summaries）。以点开头的文件、目录和其他特殊文件被排除在外。
此函数默认仅限超级用户和 pg_monitor 角色的成员使用，但可以授予其他用户执行该函数的权限。
pg_ls_archive_statusdir ()
→ setof record
( name text,
size bigint,
modification timestamp with time zone )
返回服务器的WAL归档状态目录(pg_wal/archive_status)中的每个普通文件的名称、大小和最后修改时间(mtime)。
文件名以一个点开始，目录和其他特殊文件不包括。
这个函数默认限制在超级用户和pg_monitor角色的成员，但其他用户可以被授予EXECUTE以运行此函数。
pg_ls_tmpdir ( [ tablespace oid ] )
→ setof record
( name text,
size bigint,
modification timestamp with time zone )
返回针对指定tablespace的临时文件目录中的每个普通文件的名称、大小和最后修改时间(mtime)。
如果tablespace没有提供，pg_default 表空间将被检查。文件名以一个点开始，目录和其他特殊文件不包括。
这个函数默认限制在超级用户和pg_monitor角色的成员，但其他用户可以被授予EXECUTE以运行此函数。
pg_read_file ( filename text [, offset bigint, length bigint ] [, missing_ok boolean ] )
→ text
返回一个文本文件的全部或部分内容，从指定的字节offset开始，最多返回length字节（如果先到达文件末尾，则返回更少字节）。
如果offset为负数，则表示相对于文件末尾。如果省略offset和length，则返回整个文件。
从文件中读取的字节会按照数据库的编码解释；如果这些字节在该编码中无效，则会抛出错误。
默认情况下，此函数仅限超级用户使用，但可以授予其他用户EXECUTE权限以运行此函数。
pg_read_binary_file ( filename text [, offset bigint, length bigint ] [, missing_ok boolean ] )
→ bytea
返回文件的全部或部分内容。此函数与pg_read_file相同，但它可以读取任意二进制数据，并将结果作为bytea返回，而不是text；因此，不会执行编码检查。
默认情况下，此函数仅限超级用户使用，但可以授予其他用户EXECUTE权限以运行此函数。
结合convert_from函数，此函数可用于以指定编码读取文本文件并转换为数据库的编码：
SELECT convert_from(pg_read_binary_file('file_in_utf8.txt'), 'UTF8');
pg_stat_file ( filename text [, missing_ok boolean ] )
→ record
( size bigint,
access timestamp with time zone,
modification timestamp with time zone,
change timestamp with time zone,
creation timestamp with time zone,
isdir boolean )
返回一个记录，包含文件的大小、最后访问时间戳、最后修改时间戳，最后文件状态变更时间戳（仅在UNIX平台）、文件创建时间戳（仅Windows），以及一个标志指示它是否是一个目录。
这个函数默认限制在超级用户，但其他用户可以被授予EXECUTE以运行此函数。
9.28.10. 顾问锁函数 #
表 9.109中展示的函数管理咨询锁。
有关正确使用这些函数的细节，请参考第 13.3.5 节。
所有这些函数都打算用于锁定应用程序定义的资源，可以通过一个64位键值或两个32位键值来标识（注意这两个键空间不能重叠）。
如果另一个会话已经在相同的资源标识符上持有一个冲突的锁，函数将等待直到资源变得可用，或者返回一个false结果，适用于该函数。
锁可以是共享或排他的：共享锁不会与同一资源上的其他共享锁发生冲突，只会与排他锁发生冲突。
锁可以在会话级（这样它们被保持直到释放或会话结束）或在事务级（这样它们被保持直到当前事务结束；没有手动释放的机制）。
多个会话级锁请求堆叠，因此如果同一个资源标识符被锁定三次，那么必须有三个解锁请求来在会话结束之前释放资源。
表 9.109. 咨询锁函数
函数
描述
pg_advisory_lock ( key bigint )
→ void
pg_advisory_lock ( key1 integer, key2 integer )
→ void
获取一个排他的会话级咨询锁，如有必要则等待。
pg_advisory_lock_shared ( key bigint )
→ void
pg_advisory_lock_shared ( key1 integer, key2 integer )
→ void
获取一个共享的会话级咨询锁，如有必要则等待。
pg_advisory_unlock ( key bigint )
→ boolean
pg_advisory_unlock ( key1 integer, key2 integer )
→ boolean
释放以前获取的排他会话级咨询锁。如果锁成功释放则返回true。
如果锁没有被持有，则返回false，此外，服务器将报告一个SQL警告。
pg_advisory_unlock_all ()
→ void
释放当前会话所持有的所有会话级咨询锁。（即使客户端异常断开连接，这个函数也会在会话结束时被隐式调用。）
pg_advisory_unlock_shared ( key bigint )
→ boolean
pg_advisory_unlock_shared ( key1 integer, key2 integer )
→ boolean
释放以前获取的共享会话级咨询锁。如果锁成功释放则返回true。
如果锁没有被持有，则返回false，此外，服务器将报告一个SQL警告。
pg_advisory_xact_lock ( key bigint )
→ void
pg_advisory_xact_lock ( key1 integer, key2 integer )
→ void
获取一个排他的事务级咨询锁，如有必要则等待。
pg_advisory_xact_lock_shared ( key bigint )
→ void
pg_advisory_xact_lock_shared ( key1 integer, key2 integer )
→ void
获取一个共享的事务级咨询锁，如有必要则等待。
pg_try_advisory_lock ( key bigint )
→ boolean
pg_try_advisory_lock ( key1 integer, key2 integer )
→ boolean
获取一个排他的会话级咨询锁，如果可用。这将立即获得锁并
返回true，或者如果不能立即获取锁则立即返回false
而无需等待。
pg_try_advisory_lock_shared ( key bigint )
→ boolean
pg_try_advisory_lock_shared ( key1 integer, key2 integer )
→ boolean
获取一个共享的会话级咨询锁，如果可用。这将立即获得锁并
返回true，或者如果不能立即获取锁则立即返回false
而无需等待。
pg_try_advisory_xact_lock ( key bigint )
→ boolean
pg_try_advisory_xact_lock ( key1 integer, key2 integer )
→ boolean
获取一个排他的事务级咨询锁，如果可用。这将立即获得锁并
返回true，或者如果不能立即获取锁则立即返回false
而无需等待。
pg_try_advisory_xact_lock_shared ( key bigint )
→ boolean
pg_try_advisory_xact_lock_shared ( key1 integer, key2 integer )
→ boolean
获取一个共享的事务级咨询锁，如果可用。这将立即获得锁并
返回true，或者如果不能立即获取锁则立即返回false
而无需等待。
上一页 上一级 下一页9.27. 系统信息函数和运算符 起始页 9.29. 触发器函数
