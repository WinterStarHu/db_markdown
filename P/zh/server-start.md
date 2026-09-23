# 18.3. 启动数据库服务器

18.3. 启动数据库服务器
版本：
纠错本页面
搜索
目录导航
❮
❯
18.3. 启动数据库服务器 #18.3.1. 服务器启动失败18.3.2. 客户端连接问题
在任何人可以访问数据库前，你必须启动数据库服务器。 数据库服务器程序是 postgres。
如果您使用的是 PostgreSQL 的预打包版本，那么几乎可以肯定的是，它包含了根据操作系统的约定将服务器作为后台任务运行的规定。
使用包的基础设施来启动服务器比自己弄清楚如何启动要简单得多。有关详细信息，请参阅包级文档。
手动启动服务器的基本方法是直接调用 postgres，使用 -D 选项指定数据目录的位置，例如：
$ postgres -D /usr/local/pgsql/data
这将把服务器放在前台运行。这个步骤同样必须以 PostgreSQL 用户帐户登录来操作。如果没有 -D 选项，服务器将尝试使用环境变量 PGDATA 命名的目录。如果这个环境变量也没有提供则导致失败。
通常最好在后台启动postgres。要这样做，使用常用的 Unix shell 语法：
$ postgres -D /usr/local/pgsql/data >logfile 2>&1 &
如上所示，把服务器的stdout和stderr输出存储到某个地方是非常重要的。这将对审计目的和诊断问题有所帮助（见第 24.3 节以获取更深入的日志文件处理讨论）。
postgres还接受其他一些命令行选项。更多的信息请见postgres参考页和下面的第 19 章。
这些 shell 语法很容易让人觉得无聊。因此我们提供了包装器程序pg_ctl以简化一些任务。例如：
pg_ctl start -l logfile
将在后台启动服务器并且把输出放到指定的日志文件中。-D选项和postgres中的一样。pg_ctl还可以用于停止服务器。
通常，你会希望在计算机启动的时候启动数据库服务器。自动启动脚本是操作系统相关的。在contrib/start-scripts目录中有一些随PostgreSQL分发的示例脚本。安装将需要root权限。
不同的系统在引导时有不同的启动守护进程的习惯。许多系统有一个文件/etc/rc.local或/etc/rc.d/rc.local。其他的使用init.d或rc.d目录。不管你做什么，服务器必须由PostgreSQL用户账户而不是root或任何其他用户启动。因此你可能应该在你的命令中使用su postgres -c '...'这种形式。例如：
su postgres -c 'pg_ctl start -D /usr/local/pgsql/data -l serverlog'
这里有一些更多的操作系统特定建议。（在每种情况下，请确保使用正确的安装目录和用户名称，我们展示的是通用值。）
对于FreeBSD，查看contrib/start-scripts/freebsd文件在PostgreSQL源分发中。
在OpenBSD上，添加以下行到文件/etc/rc.local：
if [ -x /usr/local/pgsql/bin/pg_ctl -a -x /usr/local/pgsql/bin/postgres ]; then
su -l postgres -c '/usr/local/pgsql/bin/pg_ctl start -s -l /var/postgresql/log -D /usr/local/pgsql/data'
echo -n ' postgresql'
fi
在Linux系统上，要么添加
/usr/local/pgsql/bin/pg_ctl start -l logfile -D /usr/local/pgsql/data
到/etc/rc.d/rc.local
或/etc/rc.local，或查看contrib/start-scripts/linux文件在PostgreSQL源分发中。
当使用systemd时，可以使用以下服务单元文件（例如，在/etc/systemd/system/postgresql.service）：
[Unit]
Description=PostgreSQL database server
Documentation=man:postgres(1)
After=network-online.target
Wants=network-online.target
[Service]
Type=notify
User=postgres
ExecStart=/usr/local/pgsql/bin/postgres -D /usr/local/pgsql/data
ExecReload=/bin/kill -HUP $MAINPID
KillMode=mixed
KillSignal=SIGINT
TimeoutSec=infinity
[Install]
WantedBy=multi-user.target
使用Type=notify要求服务器二进制文件使用configure --with-systemd构建。
仔细考虑超时设置。systemd在撰写本文时有一个默认超时为90秒，并将在该时间内未报告准备就绪的进程。但是，一个可能需要在启动时执行崩溃恢复的PostgreSQL服务器可能需要更长时间才能准备就绪。建议值为infinity可禁用超时逻辑。
在NetBSD上，根据偏好使用FreeBSD或Linux启动脚本。
在Solaris上，创建一个名为/etc/init.d/postgresql的文件，其中包含以下行：
su - postgres -c "/usr/local/pgsql/bin/pg_ctl start -l logfile -D /usr/local/pgsql/data"
然后，在/etc/rc3.d中创建一个符号链接为S99postgresql。
当服务器在运行时，它的PID被保存在数据目录中的postmaster.pid文件。这样做可以防止多个服务器实例运行在同一个数据目录中，并且也可以被用来关闭服务器。
18.3.1. 服务器启动失败 #
有几个常见的原因会导致服务器启动失败。通过检查服务器日志或使用手工启动的方法（不做标准输出或标准错误的重定向），就可以看到出现什么错误消息。下面我们详细地解释一些最常见的错误消息。
LOG:  could not bind IPv4 address "127.0.0.1": Address already in use
HINT:  Is another postmaster already running on port 5432? If not, wait a few seconds and retry.
FATAL:  could not create any TCP/IP sockets
正如这个消息所说的，这表示：你试图在一个已经有服务器运行着的端口上再启动另一个服务器。不过，如果核心错误消息不是Address already in use或其变体，那就有可能是别的问题。 例如，试图在一个被保留的端口上启动服务器会收到下面这样的消息：
$ postgres -p 666
LOG:  could not bind IPv4 address "127.0.0.1": Permission denied
HINT:  Is another postmaster already running on port 666? If not, wait a few seconds and retry.
FATAL:  could not create any TCP/IP sockets
像这样的消息：
FATAL:  could not create shared memory segment: Invalid argument
DETAIL:  Failed system call was shmget(key=5440001, size=4011376640, 03600).
可能意味着你的内核对共享内存区的限制小于PostgreSQL试图创建的工作区域（本例中是4011376640字节）。这只有在您将shared_memory_type设置为sysv时才有可能发生。在这种情况下，你可以试着以小于正常数量的缓冲区（shared_buffers）启动服务器，或者重新配置内核以增加共享内存允许的尺寸。当你试图在同一台机器上启动多个服务器，并且它们所需的总空间超过了内核的限制，也会报这个错。
一个这样的错误：
FATAL:  could not create semaphores: No space left on device
DETAIL:  Failed system call was semget(5440126, 17, 03600).
并不意味着你已经用光了磁盘空间。它的意思是你的内核对System V信号量的限制小于PostgreSQL想创建的数量。和上面一样，你可以通过减少允许的连接数（max_connections）来绕开这个限制，但最终你还是会希望提高内核的限制。
关于配置System V IPC功能的细节请见第 18.4.1 节。
18.3.2. 客户端连接问题 #
尽管可能在客户端出现的错误情况范围宽广而且是应用相关的，但的确有几种与服务器的启动方式直接相关。除了下面提到的几种错误之外的问题都应该在相应的客户端应用文档中。
psql: error: 无法连接到位于 "server.joe.com" (123.123.123.123) 的服务器，端口 5432 连接被拒绝
该主机上的服务器是否正在运行并接受 TCP/IP 连接？
这是通用的 “我找不到可以连接的服务器” 失败。当尝试进行 TCP/IP 通信时，它看起来像上面所示。一个常见的错误是忘记配置 listen_addresses 以使服务器接受远程 TCP 连接。
另外，当试图通过 Unix 域套接字与本地服务器通信时，你会看到这个：
psql: error: connection to server on socket "/tmp/.s.PGSQL.5432" failed: No such file or directory
Is the server running locally and accepting connections on that socket?
如果服务器确实在运行，检查客户端的套接字路径（这里是 /tmp）的理解与服务器的unix_socket_directories设置的一致性。
连接失败信息总是显示服务器地址或套接字路径名，有助于验证客户端是不是尝试连接到正确的位置。
如果实际上没有服务器在那里监听，典型的核心错误消息将是Connection refused或No such file or directory（值得注意的是这种环境中的Connection refused并不表示服务器得到了你的连接请求并拒绝了它。
那种情况会产生一个不同的消息，如第 20.16 节中所示）。
其他像Connection timed out这样的消息可能表示更基础的问题，如缺少网络连接，或者有防火墙阻塞了连接。
上一页 上一级 下一页18.2. 创建一个数据库集簇 起始页 18.4. 管理内核资源
