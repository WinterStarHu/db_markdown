# 第 46 章 后台工作进程

第 46 章 后台工作进程
版本：
纠错本页面
搜索
目录导航
❮
❯
第 46 章 后台工作进程
PostgreSQL可以扩展以在单独的进程中运行用户提供的代码。
这些进程由postgres启动、停止和监视，
允许它们的生命周期与服务器的状态密切相关。
这些进程附加到PostgreSQL的
共享内存区域，并具有内部连接到数据库的选项；它们还可以运行
多个事务串行，就像常规的客户端连接服务器进程一样。此外，
通过链接到libpq，它们可以连接到
服务器并像常规客户端应用程序一样运行。
警告
在使用后台工作进程时具有相当大的鲁棒性和安全性风险，因为它们由C语言编写，对数据具有无限制的访问权。希望使用包括后台工作进程在内的模块的管理员必须要极度小心。只有仔细审计过的模块才会被允许运行后台工作进程。
通过将模块名放在shared_preload_libraries中，可以在PostgreSQL被启动时初始化后台工作进程。
一个希望运行后台工作进程的模块需要通过在其_PG_init()函数中调用RegisterBackgroundWorker(BackgroundWorker*worker)来注册它。
也可以在系统启动后通过调用RegisterDynamicBackgroundWorker(BackgroundWorker*worker, BackgroundWorkerHandle**handle)来启动后台工作进程。
不像只能通过postmaster调用的RegisterBackgroundWorker，RegisterDynamicBackgroundWorker必须从一个常规后端或其他后台工作进程调用。
结构 BackgroundWorker 定义如下：
typedef void (*bgworker_main_type)(Datum main_arg);
typedef struct BackgroundWorker
{
char        bgw_name[BGW_MAXLEN];
char        bgw_type[BGW_MAXLEN];
int         bgw_flags;
BgWorkerStartTime bgw_start_time;
int         bgw_restart_time;       /* in seconds, or BGW_NEVER_RESTART */
char        bgw_library_name[MAXPGPATH];
char        bgw_function_name[BGW_MAXLEN];
Datum       bgw_main_arg;
char        bgw_extra[BGW_EXTRALEN];
pid_t       bgw_notify_pid;
} BackgroundWorker;
bgw_name和bgw_type是要被用在日志消息、进程列表和类似环境中的字符串。对于同种类型的所有后台工作进程，bgw_type应该相同，例如这样才可能将进程列表中的这些工作组分组。另一方面，bgw_name可以包含有关特定进程的额外信息（通常，bgw_name中的字符串在某种程度上也会包含类型，但是并没有严格的要求）。
bgw_flags 是一个按位或位掩码，表示模块所需的功能。可能的值有：
BGWORKER_SHMEM_ACCESS
请求共享内存访问。 此标志是必需的。
BGWORKER_BACKEND_DATABASE_CONNECTION
请求建立数据库连接的能力，以便稍后运行事务和查询。
使用BGWORKER_BACKEND_DATABASE_CONNECTION连接到数据库的后台工作进程，还必须使用
BGWORKER_SHMEM_ACCESS附加共享内存，否则工作进程启动将失败。
bgw_start_time是服务器状态，在该状态中postgres会启动该进程，它可以是BgWorkerStart_PostmasterStart（在postgres本身完成初始化之后立即启动，这种进程不能使用数据库连接）、BgWorkerStart_ConsistentState（当一个热备用中达到一个一致性状态之后立即启动，允许进程连接到数据库并运行只读查询）和BgWorkerStart_RecoveryFinished（在系统进入到正常读写状态后立即启动）之一。注意后两种值在服务器不是一个热备用的情况下是等同的。注意这种设置仅仅表示何时启动进程，当一个不同状态到达时它们不会停止。
bgw_restart_time是时间间隔，以秒计；是在进程崩溃情况下，postgres重新启动进程之前等待的时间间隔。它可以是任何正值，或者BGW_NEVER_RESTART，表示在出现崩溃后不重启进程。
bgw_library_name 是一个库的名称，其中应寻找后台
工作者的初始入口点。该命名的库将由工作进程动态加载，并使用
bgw_function_name 来标识要调用的函数。如果调用
核心代码中的函数，这必须设置为 "postgres"。
bgw_function_name是用作新后台工作者初始入口点的函数
名称。如果此函数位于动态加载的库中，则必须标记为
PGDLLEXPORT（而不是static）。
bgw_main_arg是后台工作者主函数的Datum参数。这个主函数应该有一个单一的Datum类型的参数，并且返回void。bgw_main_arg将被作为参数传递。此外，全局变量MyBgworkerEntry指向注册时传入的BackgroundWorker结构的一份拷贝，工作者会发现检查这个结构会很有用。
在 Windows （以及任何定义了EXEC_BACKEND的地方）上或者动态后台工作者中，用引用的方式传递Datum是不安全的，只有传值才安全。如果要求一个参数，最安全的方式是传递一个 int32 或者其他的小型值，并且把它当做共享内存中分配的一个数组的索引来使用。如果被传递的是一个cstring或者text这样的值，那么在新的后台工作者进程中该指针将不会有效。
bgw_extra可以包含要传递给后台工作者的额外数据。与bgw_main_arg不同，这个数据不会被作为一个参数传递给工作者的主函数，而是按照上面所述通过MyBgworkerEntry来访问。
bgw_notify_pid是一个PostgreSQL后端进程的PID，   当后台工作者进程启动或者退出时，postmaster会向这个PID所指的进程发送SIGUSR1。
对于在postmaster启动时注册的工作者，它应该为0；或者注册该工作者的后端不希望等待该工作者启动时，它也应该为0。否则，它应该被初始化为MyProcPid。
一旦运行，该进程可以通过调用
BackgroundWorkerInitializeConnection(char *dbname, char *username, uint32 flags)或
BackgroundWorkerInitializeConnectionByOid(Oid dboid, Oid useroid, uint32 flags)来连接数据库。
这允许进程使用SPI接口执行事务和查询。如果dbname为NULL或
dboid为InvalidOid，则会话不会连接到任何特定数据库，但可以访问共享目录。
如果username为NULL或useroid为
InvalidOid，进程将以initdb期间创建的超级用户身份运行。
如果将BGWORKER_BYPASS_ALLOWCONN指定为flags，则可以绕过连接不允许用户连接的数据库的限制。
如果将BGWORKER_BYPASS_ROLELOGINCHECK指定为flags，则可以绕过用于连接数据库的角色的登录检查。
后台工作进程只能调用这两个函数中的一个，且只能调用一次。无法切换数据库。
当控制到达后台工作者的主函数时，信号初始会被阻塞，并且必须被它解除阻塞。这是为了允许进程自定义它的信号处理器。在新进程中可以通过调用BackgroundWorkerUnblockSignals来解除对信号的阻塞，还可以通过调用BackgroundWorkerBlockSignals来阻塞信号。
如果一个后台工作者的bgw_restart_time被配置为
BGW_NEVER_RESTART，或者它退出时的退出码为0，或者它是被
TerminateBackgroundWorker所终止，它将会被postmaster在退出时自动解除
注册。否则，它将在等待通过bgw_restart_time配置的时间段之后被重新启动，
或者在postmaster因为一次后端失败重新初始化集簇时立刻被重启。需要临时禁止执行的后端应该使用
可中断的休眠而不是退出，这可以通过调用WaitLatch()实现。
调用该函数时要确保WL_POSTMASTER_DEATH标志被设置，并且验证在
postgres本身被终止的紧急情况下产生的快速退出返回码。
当一个后台工作者是通过RegisterDynamicBackgroundWorker函数
注册时，后端可以执行该注册以获得有关该工作者的状态信息。希望这样做的后端应该把一个
BackgroundWorkerHandle *的地址作为第二个参数传递给
RegisterDynamicBackgroundWorker。如果工作者被成功地注册，
这个指针将被用一个非透明句柄初始化，它之后会被传递给
GetBackgroundWorkerPid(BackgroundWorkerHandle *, pid_t *)或者
TerminateBackgroundWorker(BackgroundWorkerHandle *)。
GetBackgroundWorkerPid可以被用来测试工作者的状态：返回值为
BGWH_NOT_YET_STARTED表示该工作者还未被postmaster启动；
BGWH_STOPPED表示它已经被启动但是不再运行；
而BGWH_STARTED表示它正在运行。在最后一种情况下，PID也将被通过
第二个参数返回。
TerminateBackgroundWorker导致postmaster发送SIGTERM
给工作者（如果它在运行），并且在它不再运行时尽快解除注册。
在某些情况下，一个注册后台工作者的进程可能希望等待该工作者启动起来。其实现方式是：把
bgw_notify_pid初始化成MyProcPid并且接着
把注册时得到的BackgroundWorkerHandle *传递给
WaitForBackgroundWorkerStartup(BackgroundWorkerHandle
*handle, pid_t *)函数。
这个函数将阻塞直到postmaster已经尝试启动该后台工作者，或者直到postmaster死亡。如果后台
工作者正在运行，返回值将是BGWH_STARTED，并且其PID将被写入到所提供的地址。
否则，返回值将是BGWH_STOPPED或者
BGWH_POSTMASTER_DIED。
进程也可以等待一个后台工作者关闭，方法是使用WaitForBackgroundWorkerShutdown(BackgroundWorkerHandle
*handle)函数并且传入注册时得到的BackgroundWorkerHandle *。这个函数将阻塞直至后台工作者退出或者postmaster死掉。当后台工作者退出时，返回值是BGWH_STOPPED，如果postmaster死掉则会返回BGWH_POSTMASTER_DIED。
后台工作者可以发送异步通知消息，可以通过SPI的NOTIFY命令，或者直接通过Async_Notify()。
这样的通知将在事务提交的时候发送。
后台工作者不应该使用LISTEN命令接收异步通知，因为工作者没有可以使用这些通知的基础架构。
src/test/modules/worker_spi模块包含了一个实例，它展示了一些有用的技巧。
注册的后台工作进程的最大数量由max_worker_processes限制。
上一页 上一级 下一页SPI_start_transaction 起始页 第 47 章 逻辑解码
