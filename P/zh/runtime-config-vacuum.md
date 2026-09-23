# 19.10. 清理

19.10. 清理
版本：
纠错本页面
搜索
目录导航
❮
❯
19.10. 清理 #19.10.1. 自动清理19.10.2. 基于成本的清理延迟19.10.3. 默认行为19.10.4. 冻结
这些参数控制清理的行为。有关清理的目的和职责的更多信息，请参见 第 24.1 节。
19.10.1. 自动清理 #
这些设置控制autovacuum特性的行为。详情请参考
第 24.1.6 节。注意很多这些设置可以被针对每个表
的设置所覆盖，参见Storage Parameters。
autovacuum (boolean)
#
控制服务器是否应运行
autovacuum 启动器守护进程。默认情况下这是开启的；但是，
track_counts 也必须启用以使
autovacuum 工作。
此参数只能在 postgresql.conf
文件中或在服务器命令行上设置；但是，可以通过更改表存储参数
禁用单个表的 autovacuum。
请注意，即使此参数被禁用，系统
仍会在必要时启动 autovacuum 进程以
防止事务 ID 回绕。有关更多信息，请参见 第 24.1.5 节。
autovacuum_worker_slots (integer)
#
指定为 autovacuum 工作进程保留的后端槽的数量。
默认通常为 16 个槽，但如果您的内核设置不支持，
则可能会更少（在 initdb 期间确定）。
此参数只能在服务器启动时设置。
更改此值时，请考虑同时调整
autovacuum_max_workers。
autovacuum_max_workers (integer)
#
指定可以同时运行的最大 autovacuum 进程数量（不包括
autovacuum 启动器）。默认值为 3。
此参数只能在 postgresql.conf
文件中或在服务器命令行上设置。
请注意，设置此值高于
autovacuum_worker_slots 将没有效果，
因为 autovacuum 工作进程是从该设置建立的槽池中获取的。
autovacuum_naptime (integer)
#
指定在任何给定数据库上 autovacuum 运行之间的最小延迟。
在每轮中，守护进程检查数据库并根据需要对该数据库中的表
发出 VACUUM 和 ANALYZE 命令。
如果此值未指定单位，则视为秒。
默认值为一分钟 (1min)。
此参数只能在 postgresql.conf
文件中或在服务器命令行上设置。
autovacuum_vacuum_threshold (integer)
#
指定触发任何一个表中的 VACUUM 所需的最小更新或删除元组数量。
默认值为 50 个元组。
此参数只能在 postgresql.conf
文件中或在服务器命令行上设置；
但是，可以通过更改表存储参数来覆盖单个表的设置。
autovacuum_vacuum_insert_threshold (integer)
#
指定触发任一表中 VACUUM 所需的插入元组数量。
默认值为 1000 个元组。如果指定为 -1，autovacuum 将不会
根据插入数量触发任何表的 VACUUM 操作。
此参数只能在 postgresql.conf 文件中
或在服务器命令行上设置；但可以通过更改表存储参数
来覆盖单个表的设置。
autovacuum_analyze_threshold (integer)
#
指定触发任一表中 ANALYZE 所需的最小插入、更新或删除元组数量。
默认值为 50 个元组。
此参数只能在 postgresql.conf 文件中
或在服务器命令行上设置；但可以通过更改表存储参数
来覆盖单个表的设置。
autovacuum_vacuum_scale_factor (floating point)
#
指定在决定是否触发 VACUUM 时，添加到
autovacuum_vacuum_threshold 的表大小的比例。
默认值为 0.2（表大小的 20%）。
此参数只能在 postgresql.conf 文件中
或在服务器命令行上设置；但可以通过更改表存储参数
来覆盖单个表的设置。
autovacuum_vacuum_insert_scale_factor (floating point)
#
指定在决定是否触发 VACUUM 时，添加到
autovacuum_vacuum_insert_threshold 的未冻结页面的比例。
默认值为 0.2（表中未冻结页面的 20%）。
此参数只能在 postgresql.conf 文件中
或在服务器命令行上设置；但可以通过更改表存储参数
来覆盖单个表的设置。
autovacuum_analyze_scale_factor (floating point)
#
指定在决定是否触发 ANALYZE 时，添加到
autovacuum_analyze_threshold 的表大小的比例。
默认值为 0.1（表大小的 10%）。
此参数只能在 postgresql.conf 文件中
或在服务器命令行上设置；但可以通过更改表存储参数
来覆盖单个表的设置。
autovacuum_vacuum_max_threshold (integer)
#
指定触发任一表中 VACUUM 所需的最大更新或删除元组数量，
即对 autovacuum_vacuum_threshold 和
autovacuum_vacuum_scale_factor 计算的值的限制。
默认值为 100,000,000 个元组。如果指定为 -1，autovacuum 将不会强制
触发 VACUUM 操作的最大更新或删除元组数量。
此参数只能在 postgresql.conf 文件中
或在服务器命令行上设置；但可以通过更改存储参数
来覆盖单个表的设置。
autovacuum_freeze_max_age (integer)
#
指定表的 pg_class.relfrozenxid 字段
可以达到的最大年龄（以事务为单位），在此之后将强制执行 VACUUM
操作以防止表内事务 ID 回绕。
请注意，即使 autovacuum 被禁用，系统仍会启动 autovacuum 进程以防止回绕。
VACUUM 还允许从 pg_xact 子目录中删除旧文件，这就是
默认值相对较低的 2 亿事务的原因。
此参数只能在服务器启动时设置，但可以通过更改表存储参数
来减少单个表的设置。
有关更多信息，请参见 第 24.1.5 节。
autovacuum_multixact_freeze_max_age (integer)
#
指定表的 pg_class.relminmxid 字段
可以达到的最大年龄（以 multixacts 为单位），在此之后将强制执行
VACUUM 操作以防止表内 multixact ID 回绕。
请注意，即使 autovacuum 被禁用，系统仍会启动 autovacuum 进程以防止回绕。
对 multixacts 进行 VACUUM 还允许从 pg_multixact/members 和
pg_multixact/offsets 子目录中删除旧文件，这就是
默认值相对较低的 4 亿 multixacts 的原因。
此参数只能在服务器启动时设置，但可以通过更改表存储参数
来减少单个表的设置。
有关更多信息，请参见 第 24.1.5.1 节。
autovacuum_vacuum_cost_delay (floating point)
#
指定将在自动 VACUUM 操作中使用的成本延迟值。
如果指定 -1，将使用常规 vacuum_cost_delay 值。
如果此值未指定单位，则视为毫秒。
默认值为 2 毫秒。
此参数只能在 postgresql.conf 文件或服务器命令行中设置；
但可以通过更改表存储参数来覆盖单个表的设置。
autovacuum_vacuum_cost_limit (integer)
#
指定将在自动 VACUUM 操作中使用的成本限制值。
如果指定 -1（这是默认值），将使用常规
vacuum_cost_limit 值。请注意，
如果有多个运行的 autovacuum 工作进程，则该值将按比例分配给每个工作进程，
以确保每个工作进程的限制总和不超过此变量的值。
此参数只能在 postgresql.conf 文件或服务器命令行中设置；
但可以通过更改表存储参数来覆盖单个表的设置。
19.10.2. 基于成本的清理延迟 #
在VACUUM和ANALYZE命令的执行过程中，系统维持着一个内部计数器来跟踪各种被执行的I/O操作的估算开销。当累计的成本达到一个限制（由vacuum_cost_limit指定），执行这些操作的进程将按照vacuum_cost_delay所指定的休眠一小段时间。然后它将重置计数器并继续执行。
这个特性的出发点是允许管理员降低这些命令对并发的数据库活动产生的I/O影响。在很多情况下，VACUUM和ANALYZE等维护命令能否快速完成并不重要，而非常重要的是这些命令不会对系统执行其他数据库操作的能力产生显著的影响。基于成本的清理延迟提供了一种方式让管理员能够保证这一点。
对于手动发出的VACUUM命令，该特性默认被禁用。要启用它，只需将vacuum_cost_delay变量设为一个非零值。
vacuum_cost_delay (floating point)
#
当成本限制被超出时，进程将休眠的时间。如果此值未指定单位，则视为毫秒。
默认值为 0，这将禁用基于成本的 VACUUM 延迟功能。
正值将启用基于成本的 VACUUM。
在使用基于成本的清理时，vacuum_cost_delay的合适值通常很小，也许是小于1毫秒。
虽然vacuum_cost_delay可以被设置为毫秒级别的值，但是在较老的平台上可能无法准确地测量这种延迟。
在这样的平台上，增加 VACUUM的节流资源消耗在1ms以上，需要改变其他的清理开销参数。
尽管如此，你应该保持 vacuum_cost_delay 在平台能持续测量的情况下尽可能小；大延迟没有帮助。
vacuum_cost_page_hit (integer)
#
在共享缓冲区缓存中进行清理的估计成本。它表示锁定缓冲池、
查找共享哈希表和扫描页面内容的成本。
默认值为 1。
vacuum_cost_page_miss (integer)
#
估算从磁盘读取的缓冲区进行清理的成本。这表示锁定缓冲池、查找共享哈希表、从磁盘读取所需块并扫描其内容的工作量。默认值为
2。
vacuum_cost_page_dirty (integer)
#
清理修改之前干净的块时收取的估算成本。这表示将脏块刷新到磁盘所需的额外 I/O。默认值为
20。
vacuum_cost_limit (integer)
#
这是导致清理过程休眠的累计成本，休眠时间为 vacuum_cost_delay。默认值为 200。
注意
有些操作会保持关键性的锁，这样可以尽快完成。基于代价的清理延迟在这类操作期间不会发生。因此有可能代价会累计至大大超过指定的限制。为了防止在这种情况下的无意义的长时间延迟，实际延迟的计算方式是vacuum_cost_delay *
accumulated_balance /
vacuum_cost_limit，且最大值是vacuum_cost_delay * 4。
19.10.3. 默认行为 #vacuum_truncate (boolean)
#
启用或禁用 VACUUM 尝试截断表末尾的任何空页面。默认值为 true。
如果为 true，VACUUM 和 autovacuum 将进行截断，并且截断页面的磁盘空间将返回给操作系统。请注意，截断需要对表进行 ACCESS EXCLUSIVE 锁。
VACUUM 的 TRUNCATE 参数（如果指定）将覆盖此参数的值。通过更改表存储参数，也可以为单个表覆盖此设置。
19.10.4. 冻结 #
为了在事务 ID 回绕后保持正确性，PostgreSQL 将足够旧的行标记为 冻结。这些行对所有人可见；其他事务不需要检查其插入的 XID 来确定可见性。VACUUM 负责将行标记为冻结。以下设置控制 VACUUM 的冻结行为，应根据系统的 XID 消耗率和主要工作负载的数据访问模式进行调整。有关事务 ID 回绕和调整这些参数的更多信息，请参见 第 24.1.5 节。
vacuum_freeze_table_age (integer)
#
如果表的 pg_class.relfrozenxid 字段达到此设置指定的年龄，VACUUM 将执行激进扫描。激进扫描与常规 VACUUM 的不同之处在于，它访问每个可能包含未冻结 XIDs 或 MXIDs 的页面，而不仅仅是那些可能包含死元组的页面。默认值为 1.5 亿个事务。尽管用户可以将此值设置为从零到二十亿的任何值，VACUUM 将默默地将有效值限制为 autovacuum_freeze_max_age 的 95%，以便在为表启动反回绕的 autovacuum 之前，有机会运行定期的手动 VACUUM。有关更多信息，请参见 第 24.1.5 节。
vacuum_freeze_min_age (integer)
#
指定 VACUUM 应该使用的截止年龄（以事务为单位），以决定是否触发冻结具有较旧 XID 的页面。默认值为 5000 万个事务。尽管用户可以将此值设置为从零到十亿的任何值，VACUUM 将默默地将有效值限制为 autovacuum_freeze_max_age 的一半，以避免强制 autovacuum 之间的时间过短。有关更多信息，请参见 第 24.1.5 节。
vacuum_failsafe_age (integer)
#
指定表的最大年龄（以事务为单位），
pg_class.relfrozenxid
字段在 VACUUM 采取
特殊措施以避免系统范围的事务 ID
回绕失败之前可以达到的最大值。 这是 VACUUM
的最后手段策略。 当为了防止事务 ID 回绕而进行的
autovacuum 已经运行了一段时间时，failsafe 通常会被触发，
尽管在任何 VACUUM 期间都可能触发 failsafe。
当触发 failsafe 时，任何生效的基于成本的延迟将不再适用，
进一步的非必要维护任务（例如索引清理）将被绕过，
并且任何正在使用的 缓冲区访问策略
将被禁用，从而使 VACUUM 可以自由使用所有
共享缓冲区。
默认值为 16 亿事务。 尽管用户可以将此值设置为从零到 21 亿，
VACUUM 将默默地将有效值调整为不低于
autovacuum_freeze_max_age 的 105%。
vacuum_multixact_freeze_table_age (integer)
#
VACUUM 在表的
pg_class.relminmxid 字段达到
此设置指定的年龄时执行激进扫描。 激进扫描与常规的
VACUUM 不同，它访问每个可能
包含未冻结 XIDs 或 MXIDs 的页面，而不仅仅是那些可能包含死
元组的页面。 默认值为 1.5 亿多重事务。
尽管用户可以将此值设置为从零到 20 亿，
VACUUM 将默默地将有效值限制为
autovacuum_multixact_freeze_max_age 的 95%，
以便在为表启动反回绕之前，定期手动执行 VACUUM 有机会运行。
有关更多信息，请参见 第 24.1.5.1 节。
vacuum_multixact_freeze_min_age (integer)
#
指定 VACUUM 应该使用的截止年龄（以多重事务为单位），
以决定是否触发冻结具有较旧多重事务 ID 的页面。 默认值为 500 万多重事务。
尽管用户可以将此值设置为从零到十亿，
VACUUM 将默默地将有效值限制为
autovacuum_multixact_freeze_max_age 的一半，
以便在强制 autovacuum 之间不会有不合理的短时间间隔。
有关更多信息，请参见 第 24.1.5.1 节。
vacuum_multixact_failsafe_age (integer)
#
指定表的最大年龄（以多重事务为单位），
pg_class.relminmxid
字段在 VACUUM 采取
特殊措施以避免系统范围的多重事务 ID
回绕失败之前可以达到的最大值。 这是 VACUUM
的最后手段策略。 当为了防止多重事务 ID 回绕而进行的
autovacuum 已经运行了一段时间时，failsafe 通常会被触发，
尽管在任何 VACUUM 期间都可能触发 failsafe。
当触发 failsafe 时，任何生效的基于成本的延迟将不再适用，
并且进一步的非必要维护任务（例如索引清理）将被绕过。
默认值为 16 亿多重事务。 尽管用户可以将
此值设置为从零到 21 亿，
VACUUM 将默默地将有效值调整为不低于
autovacuum_multixact_freeze_max_age 的 105%。
vacuum_max_eager_freeze_failure_rate (floating point)
#
指定 VACUUM 可以扫描的最大页面数（作为
关系中总页面的一个比例），并在禁用急切扫描之前
失败 设置所有冻结的可见性映射。值为
0 将完全禁用急切扫描。默认值为
0.03（3%）。
请注意，当启用急切扫描时，只有冻结失败会计入上限，
而不是成功的冻结。成功的页面冻结在关系中
的所有可见但未完全冻结的页面内部限制为20%。限制成功的页面
冻结有助于在多个正常的清理之间分摊开销，并限制
在下一个激进的清理之前再次修改的页面的急切冻结的潜在
负面影响。
此参数只能在 postgresql.conf 文件中
或在服务器命令行上设置；但是可以通过更改
相应的表存储参数 来覆盖单个表的设置。
有关调整清理冻结行为的更多信息，请参见
第 24.1.5 节。
上一页 上一级 下一页19.9. 运行时统计 起始页 19.11. 客户端连接默认值
