# 27.5. 动态追踪

27.5. 动态追踪
版本：
纠错本页面
搜索
目录导航
❮
❯
27.5. 动态追踪 #27.5.1. 动态追踪的编译27.5.2. 内置探针27.5.3. 使用探针27.5.4. 定义新探针
PostgreSQL提供了功能来支持数据库服务器的动态追踪。这样就允许在代码中的特定点上调用外部工具来追踪执行过程。
一些探针或追踪点已经被插入在源代码中。这些探针的目的是被数据库开发者和管理员使用。默认情况下，探针不被编译到PostgreSQL中；用户需要显式地告诉配置脚本使得探针可用。
目前，在写本文当时DTrace已被支持，它在 Solaris、macOS、FreeBSD、NetBSD 和 Oracle Linux 上可用。
Linux 的SystemTap项目提供了一种可用的 DTrace 等价物。支持其他动态追踪工具在理论上可以通过改变src/include/utils/probes.h中的宏定义实现。
27.5.1. 动态追踪的编译 #
默认情况下，探针是不可用的，因此您需要明确告诉配置脚本在
PostgreSQL中启用探针。要包含DTrace支持，
请在配置时指定--enable-dtrace。有关更多信息，请参阅
第 17.3.3.6 节。
27.5.2. 内置探针 #
如表 27.49所示，源代码中提供了一些标准探针。表 27.50显示了在探针中使用的类型。当然，可以增加更多探针来增强PostgreSQL的可观测性。
表 27.49. 内置 DTrace 探针名称参数描述transaction-start(LocalTransactionId)在一个新事务开始时触发的探针。arg0 是事务 ID。transaction-commit(LocalTransactionId)在一个事务成功完成时触发的探针。arg0 是事务 ID。transaction-abort(LocalTransactionId)当一个事务未成功完成时触发的探针。arg0 是事务 ID。query-start(const char *)当一个查询的处理开始时触发的探针。arg0 是查询字符串。query-done(const char *)当一个查询的处理完成时触发的探针。arg0 是查询字符串。query-parse-start(const char *)当一个查询的解析开始时触发的探针。arg0 是查询字符串。query-parse-done(const char *)当一个查询的解析完成时触发的探针。arg0 是查询字符串。query-rewrite-start(const char *)当一个查询的重写开始时触发的探针。arg0 是查询字符串。query-rewrite-done(const char *)当一个查询的重写完成时触发的探针。arg0 是查询字符串。query-plan-start()当一个查询的规划开始时触发的探针。query-plan-done()当一个查询的规划完成时触发的探针。query-execute-start()当一个查询的执行开始时触发的探针。query-execute-done()当查询的执行完成时触发的探针。statement-status(const char *)任何时候当服务器进程更新它的pg_stat_activity.status时触发的探针。arg0 是新的状态字符串。checkpoint-start(int)当检查点开始时触发的探针。arg0 传递位标志来区分不同的检查点类型，例如关闭（shutdown）、立即（immediate）或强制（force）。checkpoint-done(int, int, int, int, int)当检查点完成时触发的探针（检查点处理过程中序列中列出的下一个触发的探针）。arg0 是写入的缓冲区数量。arg1 是缓冲区的总数。arg2、arg3 和 arg4 分别包含增加、删除和循环回收的 WAL 文件的数量。clog-checkpoint-start(bool)当检查点的 CLOG 部分开始时触发的探针。arg0 为真表示正常检查点，为假表示关闭检查点。clog-checkpoint-done(bool)当检查点的 CLOG 部分完成时触发的探针。arg0 的含义与clog-checkpoint-start中相同。subtrans-checkpoint-start(bool)当检查点的 SUBTRANS 部分开始时触发的探针。arg0 为真表示正常检查点，为假表示关闭检查点。subtrans-checkpoint-done(bool)当检查点的 SUBTRANS 部分完成时触发的探针。arg0 的含义与subtrans-checkpoint-start中相同。multixact-checkpoint-start(bool)当一个检查点的 MultiXact 部分被开始时触发的探针。arg0 为 true 表示正常检查点，为 false 表示关闭检查点。multixact-checkpoint-done(bool)当一个检查点的 MultiXact 部分完成时触发的探针。arg0 的含义与multixact-checkpoint-start中相同。buffer-checkpoint-start(int)当一个检查点的写缓冲区部分被开始时触发的探针。arg0 传递位标志来区分不同的检查点类型，例如关闭、立即或强制。buffer-sync-start(int, int)当我们在检查点期间开始写脏缓冲区时（在标识哪些缓冲区必须被写之后）触发的探针。arg0 是缓冲区总数，arg1 是当前为脏并且需要被写的缓冲区数量。buffer-sync-written(int)在检查点期间当每个缓冲区被写完之后触发的探针。arg0 是缓冲区的 ID。buffer-sync-done(int, int, int)当所有脏缓冲区被写之后触发的探针。arg0 是缓冲区总数。arg1 是检查点进程实际写的缓冲区数量。arg2 是期望写的数目（arg1 的buffer-sync-start）；arg1 和 arg2 的任何不同反映在该检查点期间有其他进程刷写了缓冲区。buffer-checkpoint-sync-start()在脏缓冲区被写入到内核之后并且在开始发出 fsync 请求之前触发的探针。buffer-checkpoint-done()当同步缓冲区到磁盘完成时触发的探针。twophase-checkpoint-start()当检查点的两阶段部分开始时触发的探针。twophase-checkpoint-done()当检查点的两阶段部分完成时触发的探针。buffer-extend-start(ForkNumber, BlockNumber, Oid, Oid, Oid, int, unsigned int)当关系扩展开始时触发的探针。arg0 包含要扩展的分叉。arg1、arg2 和 arg3
包含标识该关系的表空间、数据库和关系 OID。arg4 是为本地缓冲区创建临时关系的后端
ID，或者对于共享缓冲区是 INVALID_PROC_NUMBER (-1)。arg5 是调用者
希望扩展的块数。buffer-extend-done(ForkNumber, BlockNumber, Oid, Oid, Oid, int, unsigned int, BlockNumber)当关系扩展完成时触发的探针。arg0 包含要扩展的分叉。arg1、arg2 和 arg3
包含标识该关系的表空间、数据库和关系 OID。arg4 是为本地缓冲区创建临时关系的后端
ID，或者对于共享缓冲区是 INVALID_PROC_NUMBER (-1)。arg5 是关系
扩展的块数，由于资源限制，可能少于 buffer-extend-start 中的数目。
arg6 包含第一个新块的 BlockNumber。buffer-read-start(ForkNumber, BlockNumber, Oid, Oid, Oid, int)当开始读取缓冲区时触发的探针。arg0 和 arg1 包含页面的分叉号和块号。
arg2、arg3 和 arg4 包含表空间、数据库和关系的 OID，用于标识该关系。
arg5 是为本地缓冲区创建临时关系的后端 ID，或者对于共享缓冲区是
INVALID_PROC_NUMBER (-1)。buffer-read-done(ForkNumber, BlockNumber, Oid, Oid, Oid, int, bool)当缓冲区读取完成时触发的探针。arg0 和 arg1 包含页面的分叉号和块号。
arg2、arg3 和 arg4 包含表空间、数据库和关系的 OID，用于标识该关系。
arg5 是为本地缓冲区创建临时关系的后端 ID，或者对于共享缓冲区是
INVALID_PROC_NUMBER (-1)。arg6 为 true 表示缓冲区在池中找到，
为 false 表示未找到。buffer-flush-start(ForkNumber, BlockNumber, Oid, Oid, Oid)在发出对一个共享缓冲区的任意写请求之前触发的探针。arg0 和 arg1 包含该页的分叉号和块号。arg2、arg3 和 arg4 包含表空间、数据库和关系 OID 用以识别该关系。buffer-flush-done(ForkNumber, BlockNumber, Oid, Oid, Oid)当写请求完成时触发的探针（注意这只反映传递数据给内核的时间，它通常并没有实际地被写入到磁盘）。参数和buffer-flush-start相同。wal-buffer-write-dirty-start()当一个服务器进程因为没有可用 WAL 缓冲区空间开始写一个脏 WAL 缓冲区时触发的探针（如果这经常发生，表示wal_buffers太小）。wal-buffer-write-dirty-done()当一次脏 WAL 缓冲区写入完成时触发的探针。wal-insert(unsigned char, unsigned char)当一个 WAL 记录被插入时触发的探针。arg0 是该记录的资源管理者（rmid）。arg1 包含 info 标志。wal-switch()当请求一次 WAL 段切换时触发的探针。smgr-md-read-start(ForkNumber, BlockNumber, Oid, Oid, Oid, int)当开始从关系中读取一个块时触发的探针。arg0 和 arg1 包含页面的分叉号和块号。arg2、arg3 和 arg4 包含标识该关系的表空间、数据库和关系 OID。arg5 是为本地缓冲区创建临时关系的后端 ID，或者对于共享缓冲区是INVALID_PROC_NUMBER（-1）。smgr-md-read-done(ForkNumber, BlockNumber, Oid, Oid, Oid, int, int, int)当块读取完成时触发的探针。arg0 和 arg1 包含页面的分叉号和块号。arg2、arg3 和 arg4 包含标识该关系的表空间、数据库和关系 OID。arg5 是为本地缓冲区创建临时关系的后端 ID，或共享缓冲区的INVALID_PROC_NUMBER（-1）。arg6 是实际读取的字节数，而 arg7 是请求的字节数（如果两者不同，则表示短读）。smgr-md-write-start(ForkNumber, BlockNumber, Oid, Oid, Oid, int)当开始向关系写入块时触发的探针。arg0 和 arg1 包含页面的分叉号和块号。arg2、arg3 和 arg4 包含标识该关系的表空间、数据库和关系 OID。arg5 是为本地缓冲区创建临时关系的后端 ID，或者对于共享缓冲区是INVALID_PROC_NUMBER (-1)。smgr-md-write-done(ForkNumber, BlockNumber, Oid, Oid, Oid, int, int, int)当块写入完成时触发的探针。arg0 和 arg1 包含页面的分叉号和块号。arg2、arg3 和 arg4 包含表空间、数据库和关系的 OID，用于标识该关系。arg5 是为本地缓冲区创建临时关系的后端 ID，或者对于共享缓冲区是INVALID_PROC_NUMBER（-1）。arg6 是实际写入的字节数，而 arg7 是请求的字节数（如果两者不同，则表示写入不完整）。sort-start(int, bool, int, int, bool, int)当一次排序操作开始时触发的探针。arg0 指示是堆排序、索引排序或数据排序。arg1 为真表示唯一值强制。arg2 是键列的数目。arg3 是允许使用的工作内存数（以千字节计）。如果要求随机访问排序结果，那么 arg4 为真。arg5 为0时表示串行，为1时表示并行工作者，为2时表示并行领袖。sort-done(bool, long)当一次排序完成时触发的探针。arg0 为真表示外排序，为假表示内排序。arg1 是用于一次外排序的磁盘块的数目，或用于一次内排序的以千字节计的内存。lwlock-acquire(char *, LWLockMode)当成功获得一个 LWLock 时触发的探针。arg0 是该 LWLock 所在的切片。arg1 所请求的锁模式，是排他或共享。lwlock-release(char *)当一个 LWLock 被释放时（但是注意还没有唤醒任何一个被释放的等待者）触发的探针。arg0 是该 LWLock 所在的切片。lwlock-wait-start(char *, LWLockMode)当一个 LWLock 不是立即可用并且一个服务器进程因此开始等待该锁变为可用时触发的探针。arg0 是该 LWLock 所在的切片。arg1 所请求的锁模式，是排他或共享。lwlock-wait-done(char *, LWLockMode)当一个进程从对一个 LWLock 的等待中被释放时（它实际还没有得到该锁）时触发的探针。arg0 是该 LWLock 所在的切片。arg1 所请求的锁模式，是排他或共享。lwlock-condacquire(char *, LWLockMode)当调用者指定无需等待而成功获得一个 LWLock 时触发的探针。arg0 是该 LWLock 所在的切片。arg1 所请求的锁模式，是排他或共享。lwlock-condacquire-fail(char *, LWLockMode)当调用者指定无需等待而没有成功获得一个 LWLock 时触发的探针。arg0 是该 LWLock 所在的切片。arg1 所请求的锁模式，是排他或共享。lock-wait-start(unsigned int, unsigned int, unsigned int, unsigned int, unsigned int, LOCKMODE)当一个重量级锁（lmgr锁）的请求由于锁不可用开始等待时触发的探针。arg0 到 arg3 是标识被锁定对象的标签域。arg4 指示被锁对象的类型。arg5 表示请求的锁类型。lock-wait-done(unsigned int, unsigned int, unsigned int, unsigned int, unsigned int, LOCKMODE)当一个重量级锁（lmgr 锁）的请求结束等待时（即已经得到锁）触发的探针。参数与lock-wait-start一样。deadlock-found()当死锁检测器发现死锁时触发的探针。表 27.50. 定义在探针参数中使用的类型类型定义LocalTransactionIdunsigned intLWLockModeintLOCKMODEintBlockNumberunsigned intOidunsigned intForkNumberintboolunsigned char27.5.3. 使用探针 #
下面的例子展示了一个分析系统中事务计数的 DTrace 脚本，可以用来代替一次性能测试之前和之后的pg_stat_database快照：
#!/usr/sbin/dtrace -qs
postgresql$1:::transaction-start
{
@start["Start"] = count();
self->ts  = timestamp;
}
postgresql$1:::transaction-abort
{
@abort["Abort"] = count();
}
postgresql$1:::transaction-commit
/self->ts/
{
@commit["Commit"] = count();
@time["Total time (ns)"] = sum(timestamp - self->ts);
self->ts=0;
}
当被执行时，该例子 D 脚本给出这样的输出：
# ./txn_count.d `pgrep -n postgres` or ./txn_count.d <PID>
^C
Start                                          71
Commit                                         70
Total time (ns)                        2312105013
注意
SystemTap 为追踪脚本使用一个不同于 DTrace 的标记，但是底层的探针是兼容的。值得注意的是，在写这篇文章时，SystemTap 脚本必须使用双下划线代替连字符来引用探针名。在未来的 SystemTap 发行中这很可能会被修复。
你应该记住，DTrace 脚本需要细心地编写和调试，否则收集到的追踪信息可能会毫无意义。在大部分发现问题的情况下，出现问题的是仪器，而不是底层系统。当讨论使用动态追踪发现的信息时，一定要附上使用的脚本，以便其也能被检查和讨论。
27.5.4. 定义新探针 #
开发者可以在代码中任意位置定义新的探针，当然这需要重新编译。下面是插入新探针的步骤：
决定探针名称以及通过探针提供的数据
将探针定义添加到src/backend/utils/probes.d
如果pg_trace.h还不存在于包含探针点的模块中，请包含它，并在源代码中期望的位置插入TRACE_POSTGRESQL探针宏
重新编译并验证新探针是否可用
示例：.
这里是一个如何添加探针以通过事务 ID 追踪所有新事务的例子。
决定探针将被命名为transaction-start并且需要一个LocalTransactionId类型的参数。
将该探针定义加入到src/backend/utils/probes.d：
probe transaction__start(LocalTransactionId);
注意探针名称中双下划线的使用。在一个使用探针的 DTrace 脚本中，双下划线需要被替换为一个连字符，因此，对用户而言transaction-start是文档名。
在编译时，transaction__start被转换成一个宏调用TRACE_POSTGRESQL_TRANSACTION_START（注意这里是单下划线），可以通过包含头文件pg_trace.h获得。将宏调用加入到源代码中的合适位置。在这种情况下，看起来类似：
TRACE_POSTGRESQL_TRANSACTION_START(vxid.localTransactionId);
在重新编译和运行新的二进制文件之后，通过运行下面的 DTrace 命令来检查新增的探针是否可用。你应该看到类似下面的输出：
# dtrace -ln transaction-start
ID    PROVIDER          MODULE           FUNCTION NAME
18705 postgresql49878     postgres     StartTransactionCommand transaction-start
18755 postgresql49877     postgres     StartTransactionCommand transaction-start
18805 postgresql49876     postgres     StartTransactionCommand transaction-start
18855 postgresql49875     postgres     StartTransactionCommand transaction-start
18986 postgresql49873     postgres     StartTransactionCommand transaction-start
向 C 代码中添加追踪宏时，有一些事情需要注意：
需要小心的是，为探针参数指定的数据类型要匹配宏中使用的变量的数据类型，否则会发生编译错误。
在大多数平台上，如果用--enable-dtrace编译了PostgreSQL，无论何时当控制经过一个追踪宏时，都会评估该宏的参数，即使没有进行追踪也会这样做。通常不需要担心你是否只在报告一些局部变量的值。但是要注意不要将开销大的函数调用放入参数中。如果你需要这样做，考虑通过检查追踪是否真的被启用来保护该宏：
if (TRACE_POSTGRESQL_TRANSACTION_START_ENABLED())
TRACE_POSTGRESQL_TRANSACTION_START(some_function(...));
每个追踪宏有一个对应的ENABLED宏。
上一页 上一级 下一页27.4. 进度报告 起始页 27.6. 监控磁盘使用情况
