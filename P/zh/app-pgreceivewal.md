# pg_receivewal

pg_receivewal
版本：
纠错本页面
搜索
目录导航
❮
❯
pg_receivewalpg_receivewal — 以流的方式从一个PostgreSQL服务器获取预写式日志大纲pg_receivewal [option...]描述
pg_receivewal用于从一个运行中的PostgreSQL集簇以流的方式获取预写式日志。预写式日志使用流复制协议进行流式传输，并写入本地文件目录。该目录可用作归档位置，以便使用时间点恢复进行恢复（见第 25.3 节）。
pg_receivewal实时流式传输服务器上生成的预写式日志，不像archive_command和archive_library那样等待段完成。
因此，在使用pg_receivewal时，不需要设置archive_timeout。
与PostgreSQL后备服务器上的WAL接收进程不同，pg_receivewal默认仅在WAL文件关闭时刷新WAL数据。
必须指定选项--synchronous以实时刷新WAL数据。由于pg_receivewal不应用于WAL，当synchronous_commit等于remote_apply时，不应允许其成为同步备用。
如果发生这种情况，它将表现为一个永远无法赶上的备用，并导致事务提交阻塞。为避免这种情况，您应该为synchronous_standby_names配置一个适当的值，或指定与pg_receivewal不匹配的application_name，或将synchronous_commit的值更改为其他内容，而不是remote_apply。
预写式日志通过常规PostgreSQL连接进行流式传输，并使用复制协议。连接必须由具有REPLICATION权限（见第 21.2 节）的用户或超级用户建立，并且pg_hba.conf必须允许复制连接。服务器还必须配置足够高的max_wal_senders，以至少留出一个可用于流的会话。
预写式日志流式传输的起始点是在pg_receivewal启动时计算的：
首先，扫描写入WAL段文件的目录，并找到最新完成的段文件，将下一个WAL段文件的开头作为起始点。
如果无法用上述方法计算起始点，并且使用了复制插槽，则会发出额外的READ_REPLICATION_SLOT命令来检索插槽的restart_lsn，以用作起始点。
仅当从PostgreSQL 15及更高版本流式传输预写式日志时，此选项才可用。
如果无法用上述方法计算起始点，则使用服务器从IDENTIFY_SYSTEM命令报告的最新WAL刷新位置作为起始点。
如果该连接丢失，或者它一开始就由于一个非致命错误而没有被建立，pg_receivewal将无限期地重试连接，并尽可能重新建立流。为了避免这种行为，使用-n参数。
如果没有致命错误，pg_receivewal
将运行直到被SIGINT
(Control+C)
或SIGTERM信号终止。
选项-D directory--directory=directory
输出写入的目录。
该参数是必需的。
-E lsn--endpos=lsn
当接收到达指定的LSN时，自动停止复制并以正常退出状态0退出。
如果有一个记录的LSN正好等于lsn，该记录将被处理。
--if-not-exists
当指定--create-slot并且具有指定名称的槽已经存在时，不要抛出错误。
-n--no-loop
不要在连接错误上循环。相反，遇到错误时立刻退出。
--no-sync
这个选项导致pg_receivewal不强制WAL数据被刷回磁盘。这样会更快，但是也意味着后续的操作系统崩溃会导致WAL段损坏。通常，这个选项对于测试有用，但不应该在对生产部署进行WAL归档时使用。
这个选项与---synchronous不兼容。
-s interval--status-interval=interval
指定发送回服务器的状态包之间的秒数。这允许我们更容易地监控服务器的进度。
一个零值完全禁用这种周期性的状态更新，不过当服务器需要时还是会有一个更新
被发送来避免超时导致的断开连接。默认值是10秒。
-S slotname--slot=slotname
要求pg_receivewal使用一个已有的复制槽（见
第 26.2.6 节）。在使用这个选项时，
pg_receivewal将会报告给服务器一个刷写位置，指示每一个
段是何时被同步到磁盘的，这样服务器可以在不需要该段时移除它。
当pg_receivewal的复制客户端在服务器
上被配置为一个同步后备时，那么使用一个复制槽将会向服务器报告刷写
位置，但只在一个WAL文件被关闭时报告。因此，该配置将导致主服务器
上的事务等待很长的时间并且无法令人满意地工作。要让这种配置工作
正确，还必须指定选项---synchronous（见下文）。
--synchronous
在WAL数据被收到后立即刷入到磁盘。还要在刷写后立即向服务器回送
一个状态包（不考虑--status-interval）。
如果pg_receivewal的复制客户端在服务器
上被配置为一个同步后备，应该指定这个选项来确保向服务器发送及时的反馈。
-v--verbose
启用详细模式。
-Z level-Z method[:detail]--compress=level--compress=method[:detail]
启用预写式日志的压缩。
压缩方法可以设置为gzip、lz4（如果
PostgreSQL是使用--with-lz4编译的）
或none表示不压缩。可以选择性地指定压缩详细字符串。
如果详细字符串是整数，则表示压缩级别。否则，它应是以逗号分隔的项列表，
每项形式为keyword或
keyword=value。目前唯一支持的关键字是
level。
如果未指定压缩级别，则将使用默认压缩级别。如果只指定了级别而没有提及算法，
则如果级别大于0，将使用gzip压缩，如果级别为0，则不使用压缩。
当使用gzip时，所有文件名都会自动添加后缀.gz，
而当使用lz4时，会添加后缀.lz4。
以下命令行选项控制数据库连接参数。
-d connstr--dbname=connstr
指定用于连接服务器的参数，作为一个连接字符串；这些参数将覆盖任何冲突的命令行选项。
该选项被称为--dbname，以保持与其他客户端应用程序的一致性，
但由于pg_receivewal不会连接到集群中的任何特定数据库，
连接字符串中包含的任何数据库名称都会被服务器忽略。
但是，以这种方式提供的数据库名称会覆盖默认数据库名称（replication），
用于在~/.pgpass中查找复制连接的密码。
同样，用于连接PostgreSQL的中间件或代理可能会利用该名称，
用于连接路由等目的。
-h host--host=host
指定服务器运行所在机器的主机名。如果值以斜杠开头，则用作
Unix 域套接字的目录。默认值取自PGHOST环境变量（如果设置了），
否则尝试使用 Unix 域套接字连接。
-p port--port=port
指定服务器监听连接的 TCP 端口或本地 Unix 域套接字文件扩展名。
默认为环境变量 PGPORT 的值（如果设置了该变量），
或编译时的默认值。
-U username--username=username
用于连接的用户名。
-w--no-password
永远不要发出密码提示。如果服务器需要密码认证且没有通过其他方式（如
.pgpass 文件）获得密码，连接尝试将失败。此选项在
批处理作业和脚本中非常有用，因为没有用户在场输入密码。
-W--password
强制 pg_receivewal 在连接数据库之前提示输入密码。
该选项从来不是必需的，因为
pg_receivewal 会在服务器要求密码认证时自动提示输入密码。
但是，pg_receivewal 会浪费一次连接尝试来确认服务器是否需要密码。
在某些情况下，输入 -W 以避免额外的连接尝试是值得的。
pg_receivewal 可以执行下列两种动作之一，以控制物理复制槽：
--create-slot
用--slot中指定的名称创建一个新的物理复制槽，
然后退出。
--drop-slot
删除--slot中指定的复制槽，然后退出。
其他选项也可用：
-V--version
打印pg_receivewal版本并退出。
-?--help
显示有关pg_receivewal命令行参数的帮助并退出。
退出状态
pg_receivewal在接收到SIGINT或
SIGTERM信号时将以状态码0退出。（这是正常的结束方式，
因此这不是一个错误。）对于致命错误或其他信号，退出状态将为非零。
环境
和大部分其他PostgreSQL工具相似，这个工具也使用libpq（见第 32.15 节）支持的环境变量。
环境变量PG_COLOR规定在诊断消息中是否使用颜色。可能的值为always、auto、never。
备注
当使用pg_receivewal而不是
archive_command或
archive_library作为主要的WAL备份方法时，
强烈建议使用复制槽。否则，服务器可能会在备份之前回收或删除预写式日志文件，
因为它没有任何关于WAL流已归档到哪里的信息，
无论是来自archive_command或
archive_library还是复制槽。但是，请注意，
如果接收端无法及时获取WAL数据，复制槽将填满服务器的磁盘空间。
如果在源集簇上启用了组权限，pg_receivewal将保留接收到的WAL文件上的组权限。
示例
要从位于mydbserver的服务器流式传送预写式日志并将其存储在本地目录/usr/local/pgsql/archive：
$ pg_receivewal -h mydbserver -D /usr/local/pgsql/archive
另请参阅pg_basebackup上一页 上一级 下一页pg_isready 起始页 pg_recvlogical
