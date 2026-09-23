# pg_ctl

pg_ctl
版本：
纠错本页面
搜索
目录导航
❮
❯
pg_ctlpg_ctl — 初始化、启动、停止或控制一个PostgreSQL服务器大纲pg_ctl  init[db]  [-D datadir] [-s] [-o initdb-options]pg_ctl  start  [-D datadir] [-l filename] [-W] [-t seconds] [-s] [-o options] [-p path] [-c]pg_ctl  stop  [-D datadir] [-m
s[mart]  |   f[ast]  |   i[mmediate]
] [-W] [-t seconds] [-s]pg_ctl  restart  [-D datadir] [-m
s[mart]  |   f[ast]  |   i[mmediate]
] [-W] [-t seconds] [-s] [-o options] [-c]pg_ctl  reload  [-D datadir] [-s]pg_ctl  status  [-D datadir]pg_ctl  promote  [-D datadir] [-W] [-t seconds] [-s]pg_ctl  logrotate  [-D datadir] [-s]pg_ctl  kill   signal_name   process_id 在 Microsoft Windows 上，还有：pg_ctl  register  [-D datadir] [-N servicename] [-U username] [-P password] [-S
a[uto]  |   d[emand]
] [-e source] [-W] [-t seconds] [-s] [-o options]pg_ctl  unregister  [-N servicename]描述
pg_ctl是一个用于初始化PostgreSQL数据库集簇，启动、停止或重启PostgreSQL数据库服务器（postgres），或者显示一个正在运行服务器的状态的工具。尽管服务器可以被手工启动，pg_ctl封装了重定向日志输出以及正确地从终端和进程组脱离等任务。它也提供了方便的选项用来控制关闭。
init或initdb模式会创建一个新的PostgreSQL数据库集簇，也就是将由一个单一服务器实例管理的数据库集合。这个模式调用initdb命令。详见initdb。
start模式启动一个新的服务器。该服务器被启动在后台，并且它的标准输入被附加到/dev/null（或nul在 Windows 上）。在 Unix 类系统上，默认情况下服务器的标准输出和标准错误被发送到pg_ctl的标准输出（不是标准错误）。pg_ctl的标准输出应该接着被重定向到一个文件或用管道导向另一个进程（例如日志轮转程序rotatelogs）；否则postgres将把它的输出写到控制终端（从后台）并且将不会离开 shell 的进程组。在 Windows 上，默认情况下服务器的标准输出和标准错误被发送到终端。这些默认行为可以使用-l追加服务器的输出到一个日志文件来改变。我们推荐使用-l或输出重定向。
stop模式会关闭在指定数据目录中运行的服务器。可以使用-m选项选择三种不同的关闭方法。“Smart”模式禁止新连接，然后等待所有现有客户端断开连接。如果服务器处于热备状态，一旦所有客户端断开连接，恢复和流复制将终止。“Fast”模式（默认）不等待客户端断开连接。所有活动事务都将回滚，客户端将被强制断开连接，然后服务器将关闭。“Immediate”模式将立即中止所有服务器进程，而不是进行干净的关闭。这个选择将导致在下次服务器启动时进行崩溃恢复循环。
restart模式实际上会先执行一个停止操作然后紧接着执行一个启动操作。这使得我们能够更改postgres的命令行选项，或者更改不通过重启服务器无法更改的配置文件选项。如果在服务器启动期间在命令行上使用了相对路径，则restart可能会失败，除非pg_ctl在与上次启动服务器相同的目录中运行。
reload模式简单地向postgres服务器进程发送一个SIGHUP信号，导致它重新读取它的配置文件（postgresql.conf、pg_hba.conf等）。这允许改变配置文件选项而无需完整的服务器重启来让改变生效。
status模式检查一个服务器是否运行在指定的数据目录中。如果有一个服务器正在运行，其PID和用来调用它的命令行选项将被显示。如果服务器没有在运行，pg_ctl将返回退出状态3。如果没有指定一个可以访问的数据目录，pg_ctl将返回退出状态4。
promote模式命令运行在指定数据目录中的后备服务器结束后备模式并开始读写操作。
logrotate模式轮换服务器日志文件。有关如何将此模式与外部日志轮换工具一起使用的详细信息，参见第 24.3 节。
kill模式向一个指定进程发送一个信号。这主要用于没有kill命令的Microsoft Windows。使用--help来查看受支持的信号名称列表。
register模式把PostgreSQL服务器注册为Microsoft Windows上的一个系统服务。-S选项允许选择服务启动类型，可以是“auto”（随系统自动启动）或“demand”（按需启动）。
unregister模式在Microsoft Windows上移除一个系统服务的注册。这会撤销register命令的效果。
选项-c--core-files
在可行的平台上尝试允许服务器崩溃产生核心文件，方法是提升在核心文件上的任何软性资源限制。
这对于通过允许从一个失败的服务器进程中获得栈跟踪来调试或诊断问题非常有用。
-D datadir--pgdata=datadir
指定数据库配置文件的文件系统位置。如果这个选项被忽略，将使用环境变量PGDATA。
-l filename--log=filename
追加服务器日志输出到filename。如果该文件不存在，它会被创建。umask被设置为077，这样默认情况下不允许其他用户访问该日志文件。
-m mode--mode=mode
指定关闭模式。mode可以是smart、fast或immediate，或者这三者之一的第一个字母。如果这个选项被忽略，则fast是默认值。
-o options--options=options
指定被直接传递给postgres命令的选项。-o可以被指定多次，所有给定的选项都会被传过去。
这些options通常应该被单引号或双引号包围，以确保它们作为一个组传递。
-o initdb-options--options=initdb-options
指定要直接传递给initdb命令的选项。-o可以被指定多次，所有给定的选项都会被传过去。
initdb-options 通常应该被单引号或
双引号包围，以确保它们作为一个组传递。
-p path
指定 postgres 可执行程序的位置。默认情况下，postgres 可执行程序来自与 pg_ctl 相同的目录，或者如果没有找到，则来自硬编码的安装目录。除非你正在做一些不同寻常的事情并且遇到 postgres 可执行程序未找到的错误，否则不需要使用此选项。
在 init 模式中，此选项类似于指定 initdb 可执行程序的位置。
-s--silent
只打印错误，不打印信息消息。
-t seconds--timeout=seconds
指定等待一个操作完成时要等待的最大秒数（见选项 -w）。默认为 PGCTLTIMEOUT 环境变量的值，如果该环境变量未设置，则默认为 60 秒。
-V--version
打印 pg_ctl 版本并退出。
-w--wait
等待操作完成。此选项支持模式 start、stop、restart、promote 和 register，并且是这些模式的默认设置。
在等待时，pg_ctl 会反复检查服务器的 PID 文件，在检查之间会短暂休眠。当 PID 文件指示服务器已准备好接受连接时，启动被认为完成。当服务器移除 PID 文件时，关闭被认为完成。pg_ctl 会根据启动或关闭的成功与否返回一个退出代码。
如果操作在超时时间（见选项-t）内未能完成，则pg_ctl会以一个非零退出状态退出。但是注意该操作可能会在后台继续进行并最终取得成功。
-W--no-wait
不等待操作完成。这是选项-w的对立面。
如果禁用等待，所请求的动作会被触发，但是不会有关于其成功与否的反馈。在这种情况下，可能必须用服务器日志文件或外部监控系统来检查该操作的进度和成功与否。
在以前版本的PostgreSQL中，这是除stop模式之外的默认选项。
-?--help
显示有关pg_ctl命令行参数的帮助并退出。
如果一个指定的选项有效，但与选中的操作模式无关，则pg_ctl会忽略它。
Windows 的选项-e source
作为一个 Windows 服务运行时，pg_ctl用来
在事件日志中记录日志的事件源的名称。默认是PostgreSQL。
注意这只控制由pg_ctl本身发送的消息，一旦开始，
服务器将使用event_source参数中指定的事件源。如果服务器在启动时很早（在该参数被设置前）就失败，它可能也会使用默认的事件源名称
PostgreSQL来记录。
-N servicename
要注册的系统服务的名称。这个名称将被用于服务名和显示名。
默认是PostgreSQL。
-P password
用于运行该服务的用户的密码。
-S start-type
要注册的系统服务的启动类型。start-type可以
是auto、demand，或者这两者之一的第一个字母。
如果这个选项被忽略，则auto是默认值。
-U username
用于运行该服务的用户的用户名。对于域用户，使用格式DOMAIN\username。
环境PGCTLTIMEOUT
等待启动或关闭完成时要等待的默认秒数限制。如果没有设置，
默认值是60秒。
PGDATA
默认的数据目录位置。
大部分pg_ctl模式都要求知道数据目录位置；
因此-D选项是必需的，除非PGDATA被设置。
更多影响服务器的变量，请见postgres。
文件postmaster.pid
pg_ctl在数据目录中检查这个文件，以判断服务器当前是否正在运行。
postmaster.opts如果这个文件存在于数据目录中，pg_ctl（处于restart模式中）将把该文件的内容作为选项传递给postgres，除非通过-o选项进行了覆盖。这个文件的内容也会在status模式中显示。
示例启动服务器
要启动服务器，并等待服务器接受连接：
$ pg_ctl start
要使用端口 5433 启动服务器，并且在运行时不使用fsync，请使用：
$ pg_ctl -o "-F -p 5433" start
停止服务器
要停止服务器，使用：
$ pg_ctl stop
-m选项允许控制服务器如何关闭：
$ pg_ctl stop -m smart
重启服务器
重启服务器几乎等价于停止服务器并且再次启动它，不过pg_ctl默认会保存并重用被传递给之前的运行实例的命令行选项。要以和之前相同的选项重启服务器，使用：
$ pg_ctl restart
但是如果指定了-o，则会替换任何之前的选项。要使用端口 5433 重启并在重启时禁用fsync：
$ pg_ctl -o "-F -p 5433" restart
显示服务器状态
这里是pg_ctl状态输出的例子：
$ pg_ctl status
pg_ctl: server is running (PID: 13718)
/usr/local/pgsql/bin/postgres "-D" "/usr/local/pgsql/data" "-p" "5433" "-B" "128"
第二行是在重启模式可能被调用的命令行。
参见其他initdb, postgres上一页 上一级 下一页pg_createsubscriber 起始页 pg_resetwal
