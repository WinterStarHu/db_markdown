# 19.17. 开发者选项

19.17. 开发者选项
版本：
纠错本页面
搜索
目录导航
❮
❯
19.17. 开发者选项 #
下面的参数目的是用在开发测试上，并且永远不能用于生产数据库。
但是，它们中的一些能够用于帮助恢复严重损坏的数据库。
同样，它们被从例子postgresql.conf文件中排除。
请注意许多这些参数要求特殊的源代码编译标志才能工作。
allow_in_place_tablespaces (boolean)
#
允许将表空间创建为pg_tblspc内的目录，当CREATE TABLESPACE命令提供空位置字符串时。
这旨在允许测试主服务器和备用服务器在同一台机器上运行的复制场景。这样的目录可能会混淆备份工具，因为这些工具期望在该位置只找到符号链接。
只有超级用户和具有适当SET权限的用户才能更改此设置。
allow_system_table_mods (boolean)
#
允许修改系统表的结构以及对系统表进行某些其他风险操作。即使对于超级用户，这也通常是不允许的。
不明智地使用此设置可能导致无法检索的数据丢失或严重损坏数据库系统。
只有超级用户和具有适当SET特权的用户才能更改此设置。
backtrace_functions (string)
#
这个参数包含一个以逗号分隔的C函数名称列表。
如果出现错误，并且发生错误的内部C函数的名称与列表中的值相匹配，那么将向服务器日志中写入一个回溯跟踪信息和错误消息。
这可以用来调试源代码的特定区域。
回溯支持并非在所有平台上都可以使用，并且回溯的质量取决于编译选项。
只有超级用户和具有适当SET权限的用户才能更改此设置。
debug_copy_parse_plan_trees (boolean)
#
启用此选项会强制所有解析和计划树通过
copyObject()，以便捕获 copyObject() 中的错误和遗漏。
默认情况下为关闭。
此参数仅在编译时定义了 DEBUG_NODE_TESTS_ENABLED 时可用
（在使用 configure 选项
--enable-cassert 时会自动发生）。
debug_discard_caches (integer)
#
当设置为1时，每个系统目录缓存条目在第一个可能的机会时失效，不管任何使之无效的事情是否真的发生。
作为结果，系统目录的缓存被有效地禁用，因此服务器将运行得非常缓慢。
较高的值递归地运行缓存失效，这样会更慢，而且只用于测试缓存逻辑自身。
默认值0选择正常的目录缓存行为。
当试图触发涉及并发目录更改的难以复现的错误时，此参数非常有用，但除此之外它不太被需要。
详请参见源码文件inval.c 和 pg_config_manual.h。
当 DISCARD_CACHES_ENABLED在编译时定义时，可支持此参数（当使用configure 选项
--enable-cassert时自动发生）。在生产构建中，它的值总是0，
并且试图将它设置为另一个值将引发错误。
debug_io_direct (string)
#
要求内核通过使用O_DIRECT（大多数类Unix系统）、F_NOCACHE
（macOS）或FILE_FLAG_NO_BUFFERING（Windows）来最小化关系数据和
WAL文件的缓存影响。
可以设置为空字符串（默认值）以禁用直接 I/O 的使用，
或者设置为应使用直接 I/O 的操作的逗号分隔列表。
有效选项为 data 用于
主数据文件，wal 用于 WAL 文件，以及
wal_init 用于初始分配时的 WAL 文件。
此参数只能在服务器启动时设置。
一些操作系统和文件系统不支持直接 I/O，因此非默认设置可能在启动时被拒绝或导致错误。
当前此功能会降低性能，仅供开发人员测试使用。
debug_parallel_query (enum)
#
允许在即使没有预期性能收益的情况下，也可以出于测试目的使用并行查询。
debug_parallel_query的允许值为
off（仅在预计会提高性能时使用并行模式），
on（对所有被认为安全的查询强制使用并行查询），
以及regress（类似于on，但具有如下所述的额外行为更改）。
更具体地说，将该值设置为on的将在看起来安全的任何查询计划的顶部添加一个Gather 节点，以便查询在并行 worker 内部运行。
即使当并行 worker不可用或不能使用时，例如启动子事务之类的操作将被禁止，在并行查询上下文中将被禁止，除非规划器认为这会导致查询失败。
如果设置此选项时发生失败或意外结果，查询使用的一些函数可能需要被标记为PARALLEL UNSAFE(或者，可能是PARALLEL RESTRICTED)。
设置该值为regress与设置为on 具有相同的所有效果，加上一些附加效果，为了便于自动回归测试。
通常，来自并行 worker 的消息包含一个上下文行表示之，
但是regress的设置会抑制这一行，因此输出与非并行执行时相同。
此外，通过此设置添加到计划中的Gather节点在EXPLAIN输出中是隐藏的，以便输出匹配如果将此设置off将获得的结果。
debug_raw_expression_coverage_test (boolean)
#
启用此选项会强制所有 DML 语句的原始解析树通过
raw_expression_tree_walker() 扫描，以便捕获该函数中的错误和遗漏。
默认情况下为关闭。
此参数仅在编译时定义了 DEBUG_NODE_TESTS_ENABLED 时可用
（在使用 configure 选项
--enable-cassert 时会自动发生）。
debug_write_read_parse_plan_trees (boolean)
#
启用此选项会强制所有解析和计划树通过
outfuncs.c/readfuncs.c，以便捕获这些模块中的错误和遗漏。
默认情况下为关闭。
此参数仅在编译时定义了 DEBUG_NODE_TESTS_ENABLED 时可用
（在使用 configure 选项
--enable-cassert 时会自动发生）。
ignore_system_indexes (boolean)
#
读取系统表时忽略系统索引（但是修改系统表时依然同时更新索引）。这在从被破坏的系统索引中恢复数据时有用。这个参数在会话开始之后不能被更改。
post_auth_delay (integer)
#
执行身份验证过程后启动新服务器进程时延迟的时间量。这是为了给开发者们一个机会在一个服务器进程上附加一个调试器。
如果指定值时没有单位，则以秒为单位。0值（默认值）禁用延迟。这个参数在会话开始之后不能被更改。
pre_auth_delay (integer)
#
在新服务器进程分叉后，在进行身份验证过程之前，延迟的时间量。这是为了给开发者们一个机会在一个服务器进程上附加一个调试器来跟踪认证过程中的不当行为。
如果指定值时没有单位，则以秒为单位。0值（默认值）禁用延迟。这个参数只能在postgresql.conf文件中或在服务器命令行上设置。
trace_notify (boolean)
#
为LISTEN和NOTIFY命令生成大量调试输出。client_min_messages和log_min_messages必须是DEBUG1或者更低才能把这种输出分别发送到客户端或者服务器日志。
trace_sort (boolean)
#
如果开启，发出有关排序操作期间资源使用的信息。
trace_locks (boolean)
#
如果开启，发出锁使用情况的信息。被转储信息中包括锁操作的类型、锁的类型和
被锁或被解锁对象的唯一标识符。同样包括的还有已经授予这个对象的锁类型的位掩码和
等待这个对象的锁类型的位掩码。对每一种锁类型，已授权锁和等待锁的计数也会被一起转储。
一个日志文件输出的例子如下：
LOG:  LockAcquire: new: lock(0xb7acd844) id(24688,24696,0,0,0,1)
grantMask(0) req(0,0,0,0,0,0,0)=0 grant(0,0,0,0,0,0,0)=0
wait(0) type(AccessShareLock)
LOG:  GrantLock: lock(0xb7acd844) id(24688,24696,0,0,0,1)
grantMask(2) req(1,0,0,0,0,0,0)=1 grant(1,0,0,0,0,0,0)=1
wait(0) type(AccessShareLock)
LOG:  UnGrantLock: updated: lock(0xb7acd844) id(24688,24696,0,0,0,1)
grantMask(0) req(0,0,0,0,0,0,0)=0 grant(0,0,0,0,0,0,0)=0
wait(0) type(AccessShareLock)
LOG:  CleanUpLock: deleting: lock(0xb7acd844) id(24688,24696,0,0,0,1)
grantMask(0) req(0,0,0,0,0,0,0)=0 grant(0,0,0,0,0,0,0)=0
wait(0) type(INVALID)
被转储结构的详细信息可以在src/include/storage/lock.h中找到。
只有在编译PostgreSQL时定义了LOCK_DEBUG宏，
这个参数才可用。
trace_lwlocks (boolean)
#
如果开启，发出轻量级锁的使用信息。轻量级锁主要是为了提供对共享内存数据结构的互斥访问。
只有在编译PostgreSQL时定义了LOCK_DEBUG宏，
这个参数才可用。
trace_userlocks (boolean)
#
如果开启，发出关于用户锁使用的信息。与trace_locks的输出一样，但只用于顾问锁。
只有在编译PostgreSQL时定义了LOCK_DEBUG宏，这个参数才可用。
trace_lock_oidmin (integer)
#
如果设置，不会跟踪小于这个OID的锁（用于避免在系统表上的输出）。
只有在编译PostgreSQL时定义了LOCK_DEBUG宏，这个参数才可用。
trace_lock_table (integer)
#
无条件地跟踪此表（OID）上的锁。
只有在编译PostgreSQL时定义了LOCK_DEBUG宏，这个参数才可用。
debug_deadlocks (boolean)
#
如果设置，当死锁超时发生时，转储所有当前锁的信息。
只有在编译PostgreSQL时定义了LOCK_DEBUG宏，这个参数才可用。
log_btree_build_stats (boolean)
#
如果设置，会记录 B 树操作上的系统资源使用情况统计（内存和 CPU）。
只有在编译PostgreSQL时定义了BTREE_BUILD_STATS宏，这个参数才可用。
wal_consistency_checking (string)
#
这个参数被设计用来检查WAL重做例程中的缺陷。当启用时，被修改的任何缓冲区的全页映像及其WAL记录都被加入到记录中。如果该记录后来被重放，系统将首先应用每个记录，然后测试该记录修改的缓冲区是否符合存储的映像。在某些情况下（例如提示位），小的变动是可以接受的，并且会被忽略。任何预期之外的差别都将导致致命错误，终止恢复。
默认值为空字符串，表示禁用该功能。可以设置为all以检查所有记录，
或者设置为逗号分隔的资源管理器列表，以仅检查来自这些资源管理器的记录。目前支持的资源管理器有
heap、heap2、btree、hash、
gin、gist、sequence、spgist、
brin和generic。扩展可以定义额外的资源管理器。只有超级用户和具有
适当SET权限的用户才能更改此设置。
wal_debug (boolean)
#
如果打开，WAL相关的调试输出将被发出。只有在编译PostgreSQL时定义了WAL_DEBUG宏的情况下，这个参数才可用。
ignore_checksum_failure (boolean)
#
只有当-k被启用时才有效。
在读取过程中检测到校验和失败通常会导致PostgreSQL报告错误，中止当前事务。
将ignore_checksum_failure设置为on会导致系统忽略失败（但仍然报告警告），并继续处理。
这种行为可能导致崩溃，传播或隐藏损坏，或其他严重问题。然而，它可能允许您跳过错误，
并检索可能仍然存在于表中的未损坏的元组，如果块头仍然正常。如果头部损坏，即使启用此选项也会报告错误。
默认设置为off。
只有超级用户和具有适当SET权限的用户才能更改此设置。
zero_damaged_pages (boolean)
#
检测到损坏的页面头通常会导致PostgreSQL报告错误，中止当前事务。
将zero_damaged_pages设置为on会导致系统报告警告，将内存中的损坏页面清零，并继续处理。
这种行为会破坏数据，即损坏页面上的所有行。但是，它确实允许您跳过错误，并从表中可能存在的未损坏页面中检索行。
如果由于硬件或软件错误而发生损坏，这对于恢复数据很有用。通常在放弃从表的损坏页面恢复数据的希望之前，不应将其设置为on。
清零的页面不会强制写入磁盘，因此建议在再次关闭此参数之前重新创建表或索引。默认设置为off。
只有超级用户和具有适当SET权限的用户才能更改此设置。
ignore_invalid_pages (boolean)
#
如果设置为 off（默认值），则在恢复期间检测到引用无效页面的 WAL 记录会导致 PostgreSQL 引发 PANIC 级别错误，中止恢复。
将ignore_invalid_pages设置为on会导致系统忽略 WAL 记录中的无效页面引用（但仍报告警告），并继续恢复。
此行为可能会导致崩溃、数据丢失、传播或隐藏损坏，或其他严重问题。
但是，它可能允许你通过 PANIC 级错误，完成恢复，并启动服务器。
参数只能在服务器启动时设置。它仅在恢复期间或待机模式下生效。
jit_debugging_support (boolean)
#
如果 LLVM 具有所需的功能，则使用 GDB 注册生成的函数。这会让调试更加容易。
默认设置是 off。这个参数只能在服务器启动时设置。
jit_dump_bitcode (boolean)
#
将生成的 LLVM IR 写入文件系统，位于 data_directory 内。
这仅对于在 JIT 实现内部工作时有用。默认设置为 off。
只有超级用户和具有适当 SET 权限的用户才能更改此设置。
jit_expressions (boolean)
#
当 JIT 编译被激活时（见 第 30.2 节），确定表达式是否用 JIT 编译。默认值是 on。
jit_profiling_support (boolean)
#
如果LLVM有所需的功能，发出需要的数据以允许perf对JIT生成的函数进行分析。
这会写出文件到~/.debug/jit/中，如果需要，由用户负责对其执行清理。
默认设置是off。
这个参数只能在服务器启动时设置。
jit_tuple_deforming (boolean)
#
当JIT编译被激活时（见第 30.2 节），确定元组变形是否被JIT编译。默认值是on。
remove_temp_files_after_crash (boolean)
#
当设置为on时，这是默认值，PostgreSQL将在后端崩溃后自动删除临时文件。
如果禁用，文件将被保留，并且也许可用于调试，例如。
重复的崩溃可能会导致无用文件的积累。
该参数只能在postgresql.conf文件中或服务器命令行中设置。
send_abort_for_crash (boolean)
#
默认情况下，在后端崩溃后，postmaster 会通过发送 SIGQUIT
信号来停止剩余的子进程，这使它们能够或多或少地优雅退出。当此选项设置为
on 时，会改为发送 SIGABRT 信号。
这通常会为每个这样的子进程生成一个核心转储文件。
这对于在崩溃后调查其他进程的状态可能很有用。但在发生重复崩溃的情况下，
也可能会消耗大量磁盘空间，因此不要在未仔细监控的系统上启用此选项。
请注意，没有支持自动清理核心文件的功能。
此参数只能在 postgresql.conf 文件中或通过服务器命令行设置。
send_abort_for_kill (boolean)
#
默认情况下，在尝试通过SIGQUIT停止子进程后，
postmaster会等待五秒钟，然后发送SIGKILL以强制
立即终止。当此选项设置为on时，会发送
SIGABRT而不是SIGKILL。
这通常会为每个这样的子进程生成一个核心转储文件。
这对于调查“卡住的”子进程的状态可能很有用。
但在发生重复崩溃的情况下，这也可能消耗大量磁盘空间，
因此不要在未仔细监控的系统上启用此选项。
请注意，没有支持自动清理核心文件的功能。
此参数只能在postgresql.conf文件中
或服务器命令行上设置。
debug_logical_replication_streaming (enum)
#
允许的值是buffered和immediate。
默认值是buffered。此参数旨在用于测试大事务的逻辑解码和复制。
debug_logical_replication_streaming的效果在发布者和订阅者之间是不同的：
在发布者端，debug_logical_replication_streaming允许在逻辑解码中
立即流式传输或序列化更改。当设置为immediate时，如果
streaming
选项在
CREATE SUBSCRIPTION
中启用，则对每个更改进行流式传输，否则序列化每个更改。当设置为
buffered时，解码将在达到logical_decoding_work_mem
时流式传输或序列化更改。
在订阅者端，如果streaming选项设置为
parallel，可以使用debug_logical_replication_streaming
来指示主应用工作者将更改发送到共享内存队列或将所有更改序列化到文件。
当设置为buffered时，主应用工作者通过共享内存队列将更改发送
给并行应用工作者。当设置为immediate时，主应用工作者将所有
更改序列化到文件，并通知并行应用工作者在事务结束时读取并应用这些更改。
上一页 上一级 下一页19.16. 自定义选项 起始页 19.18. 短选项
