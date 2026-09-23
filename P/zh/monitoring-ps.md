# 27.1. 标准 Unix 工具

27.1. 标准 Unix 工具
版本：
纠错本页面
搜索
目录导航
❮
❯
27.1. 标准 Unix 工具 #
在大多数Unix平台上，PostgreSQL修改了ps报告的命令标题，以便可以轻松识别各个服务器进程。一个示例显示如下：
$ ps auxww | grep ^postgres
postgres  15551  0.0  0.1  57536  7132 pts/0    S    18:02   0:00 postgres -i
postgres  15554  0.0  0.0  57536  1184 ?        Ss   18:02   0:00 postgres: background writer
postgres  15555  0.0  0.0  57536   916 ?        Ss   18:02   0:00 postgres: checkpointer
postgres  15556  0.0  0.0  57536   916 ?        Ss   18:02   0:00 postgres: walwriter
postgres  15557  0.0  0.0  58504  2244 ?        Ss   18:02   0:00 postgres: autovacuum launcher
postgres  15582  0.0  0.0  58772  3080 ?        Ss   18:04   0:00 postgres: joe runbug 127.0.0.1 idle
postgres  15606  0.0  0.0  58772  3052 ?        Ss   18:07   0:00 postgres: tgl regression [local] SELECT waiting
postgres  15610  0.0  0.0  58772  3056 ?        Ss   18:07   0:00 postgres: tgl regression [local] idle in transaction
（ps的适当调用在不同平台上有所不同，显示的细节也不同。此示例来自最近的Linux系统。）这里列出的第一个进程是主服务器进程。显示的命令参数与启动时使用的相同。接下来的四个进程是主进程自动启动的后台工作进程。（如果您设置系统不运行自动清理，则“autovacuum launcher”进程将不存在。）其余的每个进程都是处理一个客户端连接的服务器进程。每个这样的进程将其命令行显示为
postgres: user database host activity
用户、数据库和（客户端）主机项目在客户端连接的生命周期内保持不变，但活动指示器会更改。活动可以是idle（即等待客户端命令）、idle in transaction（在BEGIN块内等待客户端）、或命令类型名称，如SELECT。此外，如果服务器进程当前正在等待另一个会话持有的锁，则会附加waiting。在上面的示例中，我们可以推断进程15606正在等待进程15610完成其事务，从而释放一些锁。（进程15610必须是阻塞进程，因为没有其他活动会话。在更复杂的情况下，需要查看pg_locks系统视图，以确定谁在阻塞谁。）
如果配置了cluster_name，则集簇的名称
也将会显示在ps的输出中：
$ psql -c 'SHOW cluster_name'
cluster_name
--------------
server1
(1 row)
$ ps aux|grep server1
postgres   27093  0.0  0.0  30096  2752 ?        Ss   11:34   0:00 postgres: server1: background writer
...
如果你已经关闭了update_process_title，那么活动指示器将不会被更新，进程标题仅在新进程被启动的时候设置一次。 在某些平台上这样做可以为每个命令节省可观的开销，但在其他平台上却不明显。
提示
Solaris需要特别的处理。你必须使用/usr/ucb/ps而不是/bin/ps。 你还必须使用两个w标志，而不是一个。另外，你对postgres命令的最初调用必须用一个比服务器进程提供的短的ps状态显示。如果你没有满足全部三个要求，每个服务器进程的ps输出将是原始的postgres命令行。
上一页 上一级 下一页第 27 章 监控数据库活动 起始页 27.2. 累计统计系统
