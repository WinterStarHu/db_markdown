# 53.20. pg_replication_slots

53.20. pg_replication_slots
版本：
纠错本页面
搜索
目录导航
❮
❯
53.20. pg_replication_slots #
pg_replication_slots视图提供了当前集簇上存在的所有复制槽的列表，以及它们的当前状态。
有关复制槽的更多信息，请参见第 26.2.6 节和第 47 章。
表 53.20. pg_replication_slots 列
列类型
描述
slot_name name
一个唯一的、集簇范围内的复制槽标识符
plugin name
包含这个逻辑槽正在使用的输出插件的共享对象基础名称，对于物理槽为null。
slot_type text
槽类型：physical或logical
datoid oid
(参考 pg_database.oid)
与这个槽相关的数据库的OID，或者为空值。只有逻辑槽具有相关的数据库。
database name
(参考 pg_database.datname)
与这个槽相关的数据库的名称，或者为空值。只有逻辑槽具有相关的数据库。
temporary bool
如果这是一个临时复制槽则为真。临时槽不会被保存在磁盘上并且会在出错或会话结束时自动被删除。
active bool
如果此槽当前正在流式传输，则为真
active_pid int4
此槽的会话流数据的进程ID。若不活动，则为NULL。
xmin xid
这个槽需要数据库保留的最旧事务。VACUUM不能移除被其后续事务删除的元组。
catalog_xmin xid
这个槽需要数据库保留的影响系统目录的最旧事务。VACUUM不能移除被其后续事务删除的目录元组。
restart_lsn pg_lsn
最老的WAL的地址（LSN），仍可能被此插槽的使用者所需，
因此在检查点期间不会自动删除，除非此LSN落后于当前LSN超过max_slot_wal_keep_size。
如果此插槽的LSN从未被保留，则为NULL。
confirmed_flush_lsn pg_lsn
逻辑槽的消费者已确认接收到数据的地址（LSN）。在此
LSN之前提交的事务对应的数据不再可用。物理槽的
NULL。
wal_status text
此槽声明的 WAL 文件的可用性。
可能的值有：
reserved 表示声明的文件在 max_wal_size 之内。extended 表示
max_wal_size 超出，但文件仍然保留，可能是通过复制槽或
wal_keep_size。
unreserved 表示该槽不再保留所需的 WAL 文件，并且其中一些将在
下一个检查点被删除。通常在 max_slot_wal_keep_size 设置为
非负值时发生。此状态可以返回到 reserved 或 extended。
lost 表示该槽不再可用。
safe_wal_size int8
可写入 WAL 的字节数，以便此插槽不会处于"丢失"状态的危险中。
对于丢失插槽，它是NULL，以及如果max_slot_wal_keep_size是-1。
two_phase bool
如果该插槽为解码准备事务所启用则为真。物理插槽总是为假。
two_phase_at pg_lsn
启用准备事务解码的地址 (LSN)。对于 two_phase 为 false 的逻辑槽和物理槽，值为 NULL。
inactive_since timestamptz
槽变为非活动状态的时间。如果槽当前正在流式传输，则为 NULL。如果槽变为无效，
此值将永远不会更新。
对于从主服务器同步的备用槽（其 synced 字段为
true），inactive_since 表示槽同步（见 第 47.2.3 节）
最近停止的时间。如果槽始终保持同步，则为 NULL。这有助于备用槽跟踪
同步何时被中断。
conflicting bool
如果此逻辑槽与恢复发生冲突（因此现在无效），则为真。当此列为真时，请检查
invalidation_reason 列以获取冲突原因。对于物理槽始终为 NULL。
invalidation_reason text
槽失效的原因。对于逻辑槽和物理槽均设置。如果槽未失效，则为 NULL。
可能的值有：
wal_removed 表示所需的 WAL 已被删除。
rows_removed 表示所需的行已被删除。仅对逻辑槽设置。
wal_level_insufficient 表示主服务器没有足够的 wal_level 来执行逻辑解码。仅对逻辑槽设置。
idle_timeout 表示槽在配置的
idle_replication_slot_timeout 持续时间内保持非活动状态。
failover bool
如果这是一个逻辑槽，且启用了同步到备用节点，则为真，
以便在故障切换后可以从新的主节点恢复逻辑复制。
物理槽始终为假。
synced bool
如果这是一个从主服务器同步过来的逻辑槽，则为真。在热备份中，标记为
true 的 synced 列的槽既不能用于逻辑解码，也不能手动删除。该列的值在
主服务器上没有意义；主服务器上所有槽的该列默认值为 false，但可能（如果
是从提升的备用服务器遗留的）也为 true。
上一页 上一级 下一页53.19. pg_replication_origin_status 起始页 53.21. pg_roles
