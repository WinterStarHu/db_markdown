# pg_recvlogical

pg_recvlogical
版本：
纠错本页面
搜索
目录导航
❮
❯
pg_recvlogicalpg_recvlogical — 控制 PostgreSQL 逻辑解码流大纲pg_recvlogical [option...]描述
pg_recvlogical 控制逻辑解码复制槽以及来自这种复制槽的流数据。
它会创建一个复制模式的连接，因此它受到和 pg_receivewal
相同的约束，还有逻辑复制（第 47 章）的约束。
pg_recvlogical 与逻辑解码 SQL 接口的 peek 和 get 模式没有等效性。它接收到数据以及干净地退出时，它会惰性地发送数据的确认。为了检查一个槽上还未消费的待处理数据，可以使用pg_logical_slot_peek_changes。
如果没有致命错误，pg_recvlogical 将运行直到被
SIGINT
(Control+C)
或 SIGTERM 信号终止。
当 pg_recvlogical 接收到
SIGHUP 信号时，它会关闭当前输出文件
并使用 --file 选项指定的文件名打开一个新文件。
这允许我们通过先重命名当前文件，然后发送
SIGHUP 信号到
pg_recvlogical 来轮换输出文件。
选项
必须指定以下选项中的至少一个以选择一个操作：
--create-slot
创建一个新的逻辑复制槽，名称由 --slot 指定，
使用由 --plugin 指定的输出插件，
针对由 --dbname 指定的数据库。
--slot 和 --dbname 是此操作所需的。
--enable-two-phase 和 --enable-failover
选项可以与 --create-slot 一起指定。
--drop-slot
删除名称由 --slot 指定的复制槽，然后退出。
--slot 是此操作所需的。
--start
从指定的逻辑复制槽 --slot 开始流式传输更改，
直到被信号终止。如果服务器端的更改流以服务器关闭
或断开连接结束，则在循环中重试，除非指定了
--no-loop。
--slot 和 --dbname,
--file 是此操作所需的。
流格式由创建槽时指定的输出插件决定。
连接必须指向用于创建槽的相同数据库。
--create-slot 和 --start 可以被一起指定。
--drop-slot 不能和另一个动作组合在一起。
以下命令行选项控制输出的位置和格式以及其他复制行为：
-E lsn--endpos=lsn
在 --start 模式下，当接收到达指定的 LSN 时，自动停止复制并以正常退出状态 0 退出。
如果在非 --start 模式下指定，则会引发错误。
如果存在 LSN 完全等于 lsn 的记录，则该记录将被输出。
--endpos 选项不会意识到事务边界，可能会在事务进行到一半时截断输出。
任何部分输出的事务都不会被消耗，并且在下次从插槽读取时将被重新播放。单个消息永远不会被截断。
--enable-failover
使槽能够与备用进行同步。此选项只能与
--create-slot 一起指定。
-f filename--file=filename
将接收并解码的事务数据写入此文件。对于stdout，使用-。
此参数是--start所需的。
-F interval_seconds--fsync-interval=interval_seconds
指定pg_recvlogical应该多久发出fsync()调用，
以确保输出文件安全地刷新到磁盘。
服务器偶尔会要求客户端执行刷新操作，并将刷新位置报告给服务器。此设置是为了更频繁地执行刷新操作。
指定间隔0会完全禁用发出fsync()调用，同时仍然向服务器报告进度。在这种情况下，如果发生崩溃，数据可能会丢失。
-I lsn--startpos=lsn
在--start模式下，从给定LSN开始复制。有关此操作的详细信息，请参阅第 47 章中的文档和第 54.4 节。在其他模式下被忽略。
--if-not-exists
当指定--create-slot并且具有指定名称的槽已经存在时，不要抛出错误。
-n--no-loop
当与服务器的连接丢失时，请不要在循环中重试，只需退出。
-o name[=value]--option=name[=value]
将选项name传递给输出插件，
如果指定，选项值为value。存在哪些选项及其效果取决于所使用的输出插件。
-P plugin--plugin=plugin
在创建插槽时，请使用指定的逻辑解码输出插件。请参阅第 47 章。
如果插槽已经存在，则此选项无效。
-s interval_seconds--status-interval=interval_seconds
这个选项与pg_receivewal中同名选项具有相同的效果。请参阅那里的描述。
-S slot_name--slot=slot_name
在--start模式下，使用现有的逻辑复制插槽名slot_name。
在--create-slot模式下，创建此名称的插槽。
在--drop-slot模式下，删除具有此名称的插槽。
此参数是任何操作所需的。
-t--enable-two-phase--two-phase（已弃用）
启用对预处理事务的解码。此选项只能与
--create-slot一起指定。
-v--verbose
启用详细模式。
以下命令行选项控制数据库连接参数。
-d dbname--dbname=dbname
要连接的数据库。有关此的详细说明，请参见
操作的描述。dbname 可以是一个 连接字符串。如果是这样，
连接字符串参数将覆盖任何冲突的命令行选项。
此参数是 --create-slot
和 --start 所需的。
-h hostname-or-ip--host=hostname-or-ip
指定运行服务器的机器的主机名。如果值以斜杠开头，
则将其用作 Unix 域套接字的目录。默认值取自
PGHOST 环境变量（如果设置），否则尝试使用
Unix 域套接字连接。
-p port--port=port
指定服务器监听连接的 TCP 端口或本地 Unix 域套接字文件
扩展名。默认值为 PGPORT 环境变量（如果设置），
或编译时默认值。
-U user--username=user
连接时使用的用户名。默认值为当前操作系统用户名。
-w--no-password
从不发出密码提示。如果服务器需要
密码认证，而没有其他方式（如 .pgpass 文件）
提供密码，则连接尝试将失败。此选项在
批处理作业和脚本中非常有用，因为没有用户在场输入密码。
-W--password
强制 pg_recvlogical 在连接到数据库之前提示输入密码。
此选项从来不是必需的，因为
pg_recvlogical 会在服务器要求密码认证时自动提示输入密码。
然而，pg_recvlogical 会浪费一次连接尝试来发现服务器需要密码。
在某些情况下，输入 -W 是值得的，以避免额外的连接尝试。
还有下列附加选项可用：
-V--version
打印pg_recvlogical的版本并且退出。
-?--help
显示关于pg_recvlogical命令行参数的帮助，并且退出。
Exit Status
pg_recvlogical 会在接收到
SIGINT 或 SIGTERM 信号时以状态
0 退出。（这是正常的结束方式，因此这不是错误。）对于致命错误或其他信号，
退出状态将为非零。
环境
和大部分其他PostgreSQL工具相似，这个工具也使用libpq（见第 32.15 节）支持的环境变量。
环境变量PG_COLOR规定在诊断消息中是否使用颜色。可能的值为always、auto、never。
注解
如果在源集群上启用了组权限，pg_recvlogical将会在接收到的WAL文件上保留组权限。
示例
请参见第 47.1 节以获取一个示例。
另见pg_receivewal上一页 上一级 下一页pg_receivewal 起始页 pg_restore
