# pg_archivecleanup

pg_archivecleanup
版本：
纠错本页面
搜索
目录导航
❮
❯
pg_archivecleanuppg_archivecleanup — 清理PostgreSQL WAL 归档文件大纲pg_archivecleanup [option...]  archivelocation   oldestkeptwalfile 简介
pg_archivecleanup被设计用作
archive_cleanup_command在作为后备服务器运行（
第 26.2 节）时来清理 WAL 文件归档。
pg_archivecleanup也可以被用作一个单独的程序来清理
WAL 文件归档。
要配置一个后备服务器以使用pg_archivecleanup，把下面
的内容放在postgresql.conf配置文件中：
archive_cleanup_command = 'pg_archivecleanup archivelocation %r'
其中archivelocation是要从中移除 WAL 段文件的目录。
当被用在archive_cleanup_command中时，所有逻辑上在
%r参数的值之前的 WAL 文件都将被从
archivelocation移除。这能最小化需要被保留的文件数量，
同时能保留崩溃后重启的能力。如果对于这台特定的后备服务器，
archivelocation是一个短暂的暂存区域，使用这个参数就是
合适的，但是当archivelocation要用作一个长期的 WAL 归档
区域或者当多个后备服务器正在从这个归档位置恢复时，使用这个参数就
不合适。
当被用作一个单独的程序时，所有逻辑上在oldestkeptwalfile
之前的 WAL 文件将被从archivelocation中移除。在这种模式
中，如果指定了.partial或者.backup文件名，则
只有该文件前缀将被用作oldestkeptwalfile。这种对
.backup文件名的处理允许你移除所有在一个特定基础备份之前归
档的 WAL 文件而不出错。例如，下面的例子将移除所有比 WAL 文件名
000000010000003700000010老的文件：
pg_archivecleanup -d archive 000000010000003700000010.00000020.backup
pg_archivecleanup:  keep WAL file "archive/000000010000003700000010" and later
pg_archivecleanup:  removing file "archive/00000001000000370000000F"
pg_archivecleanup:  removing file "archive/00000001000000370000000E"
pg_archivecleanup假定
archivelocation是一个可读的目录并且对于服务器拥有者是可写的。
选项
pg_archivecleanup 接受以下命令行参数：
-b--clean-backup-history
也删除备份历史文件。详情请参见 第 25.3.2 节 中关于备份
历史文件的说明。
-d--debug
在 stderr 上打印大量调试日志输出。
-n--dry-run
打印将被删除的文件名到 stdout（执行模拟运行）。
-V--version
打印 pg_archivecleanup 的版本信息并退出。
-x extension--strip-extension=extension
指定一个扩展名，在决定是否删除文件前会从所有文件名中去除该扩展名。
这通常用于清理存储过程中被压缩程序添加了扩展名的归档文件。
例如：-x .gz。
-?--help
显示关于 pg_archivecleanup 命令行参数的帮助信息，
并退出。
环境
环境变量 PG_COLOR 指定是否在诊断消息中使用颜色。可能的值是 always, auto 和 never。
备注
pg_archivecleanup 被设计为与 PostgreSQL 8.0 及其后的版本一起工作，当作为一个单独的工具使用时，或者与 PostgreSQL 9.0 及其后的版本一起工作，当作为一个归档清理命令使用。
pg_archivecleanup 以 C 写成并且具有很容易修改的源代码，其中有特别指定的区域用于修改以符合你的需要。
示例在 Linux 或 Unix 系统上，你可能会用：
archive_cleanup_command = 'pg_archivecleanup -d /mnt/standby/archive %r 2>>cleanup.log'
其中归档目录位于备用服务器上，这样archive_command通过 NFS
来访问它，但是文件对于备用服务器来说是本地的。这将会
在cleanup.log中产生调试输出
从归档目录中移除不再需要的文件
上一页 上一级 下一页initdb 起始页 pg_checksums
