# pg_checksums

pg_checksums
版本：
纠错本页面
搜索
目录导航
❮
❯
pg_checksumspg_checksums — 在PostgreSQL数据库集簇中启用、禁用或检查数据校验和大纲pg_checksums [option...] [[ -D  |   --pgdata ]datadir]描述
pg_checksums检查、启用或禁用数据
校验和在PostgreSQL集簇中。运行
pg_checksums之前，必须彻底关闭服务器。
验证校验和时，如果没有校验和错误，则退出状态为零，
如果检测到至少一个校验和失败，则退出状态为非零。
启用或禁用校验和时，如果操作失败，则退出状态为非零。
在验证校验和时，集群中的每个文件都会被扫描。启用校验和时，
每个具有更改校验和的关系文件块都会被就地重写。
禁用校验和只会更新文件pg_control。
选项
以下命令行选项可用：
-D directory--pgdata=directory
指定数据库集群存储的目录。
-c--check
检查校验和。如果没有指定其他选项，这是默认模式。
-d--disable
禁用校验和。
-e--enable
启用校验和。
-f filenode--filenode=filenode
仅在与文件节点filenode相关时验证校验和。
-N--no-sync
默认情况下，pg_checksums 会等待所有文件安全写入磁盘。
该选项使得pg_checksums 不等待直接返回，速度更快，
但这意味着后续操作系统崩溃可能导致更新的数据目录损坏。通常，该选项
适用于测试，但不应在生产环境中使用。使用--check时，
该选项无效。
-P--progress
启用进度报告。开启此功能将在检查或启用校验和时提供进度报告。
--sync-method=method
当设置为fsync（默认值）时，pg_checksums将递归打开并同步
数据目录中的所有文件。查找文件时会跟随WAL目录和每个配置的表空间的符号链接。
在 Linux 上，可以使用 syncfs 来请求操作系统同步包含数据目录、
WAL 文件和每个表空间的整个文件系统。有关使用 syncfs 时需注意的
注意事项，请参见 recovery_init_sync_method。
当使用--no-sync时，此选项无效。
-v--verbose
启用详细输出。列出所有已检查的文件。
-V--version
打印pg_checksums版本并退出。
-?--help
显示关于pg_checksums命令行参数的帮助信息，并退出。
环境PGDATA
指定数据库集簇存储的目录；可以用-D选项覆盖。
PG_COLOR
指定是否在诊断消息中使用颜色。可能的值为always、auto和never。
备注
在大型集簇中启用校验和的时间可能很长。在此操作期间，写到数据目录的集簇或其他程序必须是未启动的，否则可能出现数据丢失。
当复制设置与执行关系文件块的直接拷贝的工具（例如pg_rewind）一起使用时，启用和禁用校验和会导致以不正确校验和形式出现的页面损坏，如果未在所有节点上执行一致的操作的话。故在复制设置中启用或禁用校验和时，推荐在一致地切换所有集簇之前停止所有集簇。此外销毁所有备用数据库，在主数据库上执行操作，最后从头开始重建备用服务器，也是安全的。
如果pg_checksums在启用或禁用校验和时异常终止或杀掉，那么集簇的数据校验和配置保持不变，pg_checksums可以重新运行以执行相同操作。
上一页 上一级 下一页pg_archivecleanup 起始页 pg_controldata
