# 23.5.1 ndbd — NDB Cluster 数据节点守护进程_MySQL 8.0 参考手册

23.5.1 ndbd — NDB Cluster 数据节点守护进程_MySQL 8.0 参考手册
Skip to Main Content
Documentation
MySQL手册
MySQL企业版
工作台
InnoDB集群
MySQL NDB集群
连接器
Section Menu:
Documentation Home
MySQL 8.0 参考手册
前言和法律声明
第一章 一般信息
第 2 章安装和升级 MySQL
第 3 章教程
第 4 章 MySQL 程序
第 5 章 MySQL 服务器管理
第 6 章 安全
第 7 章备份与恢复
第8章优化
第9章语言结构
第 10 章字符集、排序规则、Unicode
第 11 章数据类型
第 12 章函数和运算符
第 13 章 SQL 语句
第14章MySQL数据字典
第 15 章 InnoDB 存储引擎
第 16 章替代存储引擎
第十七章复制
第十八章 组复制
第十九章MySQL Shell
第 20 章使用 MySQL 作为文档存储
第21章InnoDB Cluster
第 22 章 InnoDB 副本集
第 23 章 MySQL NDB Cluster 8.0
23.1 一般信息
23.2 NDB Cluster 概述
23.3 NDB Cluster 安装
23.4 NDB Cluster的配置
23.5 NDB 集群程序
23.5.1 ndbd — NDB Cluster 数据节点守护进程1
23.5.2 ndbinfo_select_all — 从 ndbinfo 表中选择1
23.5.3 ndbmtd — NDB Cluster 数据节点守护进程（多线程）1
23.5.4 ndb_mgmd — NDB 集群管理服务器守护进程1
23.5.5 ndb_mgm — NDB 集群管理客户端1
23.5.6 ndb_blob_tool — 检查和修复 NDB 集群表的 BLOB 和 TEXT 列1
23.5.7 ndb_config — 提取 NDB Cluster 配置信息1
23.5.8 ndb_delete_all — 从 NDB 表中删除所有行1
23.5.9 ndb_desc — 描述 NDB 表1
23.5.10 ndb_drop_index — 从 NDB 表中删除索引1
23.5.11 ndb_drop_table — 删除 NDB 表1
23.5.12 ndb_error_reporter — NDB 错误报告实用程序1
23.5.13 ndb_import — 将 CSV 数据导入 NDB1
23.5.14 ndb_index_stat — NDB 索引统计实用程序1
23.5.15 ndb_move_data — NDB 数据复制实用程序1
23.5.16 ndb_perror — 获取 NDB 错误消息信息1
23.5.17 ndb_print_backup_file — 打印 NDB 备份文件内容1
23.5.18 ndb_print_file — 打印 NDB 磁盘数据文件内容1
23.5.19 ndb_print_frag_file — 打印 NDB 片段列表文件内容1
23.5.20 ndb_print_schema_file — 打印 NDB 模式文件内容1
23.5.21 ndb_print_sys_file — 打印 NDB 系统文件内容1
23.5.22 ndb_redo_log_reader - 检查和打印集群重做日志的内容1
23.5.23 ndb_restore — 恢复 NDB Cluster 备份1
23.5.24 ndb_secretsfile_reader — 从加密的 NDB 数据文件中获取密钥信息1
23.5.25 ndb_select_all — 从 NDB 表打印行1
23.5.26 ndb_select_count — 打印 NDB 表的行数1
23.5.27 ndb_show_tables — 显示 NDB 表列表1
23.5.28 ndb_size.pl — NDBCLUSTER 大小需求估计器1
23.5.29 ndb_top — 查看 NDB 线程的 CPU 使用信息1
23.5.30 ndb_waiter — 等待 NDB Cluster 达到给定状态1
23.5.31 ndbxfrm — 压缩、解压缩、加密和解密 NDB Cluster 创建的文件1
23.6 NDB Cluster的管理
23.7 NDB 集群复制
23.8 NDB Cluster 发行说明
第24章分区
第25章存储对象
第 26 章 INFORMATION_SCHEMA 表
第 27 章 MySQL 性能模式
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.5 NDB 集群程序  /
23.5.1 ndbd — NDB Cluster 数据节点守护进程
23.5.1 ndbd — NDB Cluster 数据节点守护进程
ndbd是用于使用 NDB Cluster 存储引擎处理表中所有数据的进程。这是授权数据节点完成分布式事务处理、节点恢复、磁盘检查点、在线备份和相关任务的过程。
在 NDB Cluster 中，一组ndbd进程协作处理数据。这些进程可以在同一台计算机（主机）或不同的计算机上执行。数据节点与集群主机的对应关系是完全可配置的。
下表显示了
可与ndbd一起使用的选项。表后有其他说明。
表 23.24 与程序 ndbd 一起使用的命令行选项
格式
描述
添加、弃用或删除
--bind-address=name
本地绑定地址
（支持所有基于 MySQL 8.0 的 NDB 版本）
--character-sets-dir=path
包含字符集的目录
（支持所有基于 MySQL 8.0 的 NDB 版本）
--connect-delay=#
--connect-retry-delay 的已过时同义词，应使用它代替此选项
删除：NDB 8.0.28
--connect-retries=#
设置放弃前重试连接的次数；0 表示仅尝试 1 次（不重试）；-1 表示无限期地继续重试
（支持所有基于 MySQL 8.0 的 NDB 版本）
--connect-retry-delay=#
尝试联系管理服务器之间等待的时间，以秒为单位；0 表示尝试之间不等待
（支持所有基于 MySQL 8.0 的 NDB 版本）
--connect-string=connection_string,
-c
connection_string
与 --ndb-connectstring 相同
（支持所有基于 MySQL 8.0 的 NDB 版本）
--core-file
写入核心文件出错；用于调试
（支持所有基于 MySQL 8.0 的 NDB 版本）
--daemon,
-d
将 ndbd 作为守护进程启动（默认）；用 --nodaemon 覆盖
（支持所有基于 MySQL 8.0 的 NDB 版本）
--defaults-extra-file=path
读取全局文件后读取给定文件
（支持所有基于 MySQL 8.0 的 NDB 版本）
--defaults-file=path
仅从给定文件中读取默认选项
（支持所有基于 MySQL 8.0 的 NDB 版本）
--defaults-group-suffix=string
还阅读带有 concat(group, suffix) 的组
（支持所有基于 MySQL 8.0 的 NDB 版本）
--filesystem-password=password
节点文件系统加密密码；可以从 stdin、tty 或 my.cnf 文件传递
添加：8.0.31
--filesystem-password-from-stdin={TRUE|FALSE}
获取节点文件系统加密的密码，从 stdin 传递
添加：8.0.31
--foreground
在前台运行 ndbd，用于调试目的（暗示 --nodaemon）
（支持所有基于 MySQL 8.0 的 NDB 版本）
--help,
-?
显示帮助文本并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--initial
执行 ndbd 的初始启动，包括文件系统清理；在使用此选项之前查阅文档
（支持所有基于 MySQL 8.0 的 NDB 版本）
--initial-start
执行部分初始启动（需要 --nowait-nodes）
（支持所有基于 MySQL 8.0 的 NDB 版本）
--install[=name]
用于将数据节点进程安装为Windows服务；不适用于其他平台
（支持所有基于 MySQL 8.0 的 NDB 版本）
--logbuffer-size=#
控制日志缓冲区的大小；用于调试生成许多日志消息时使用；默认值足以满足正常操作
（支持所有基于 MySQL 8.0 的 NDB 版本）
--login-path=path
从登录文件中读取给定路径
（支持所有基于 MySQL 8.0 的 NDB 版本）
--ndb-connectstring=connection_string,
-c
connection_string
设置用于连接到 ndb_mgmd 的连接字符串。语法：“[nodeid=id;][host=]hostname[:port]”。覆盖 NDB_CONNECTSTRING 和 my.cnf 中的条目
（支持所有基于 MySQL 8.0 的 NDB 版本）
--ndb-mgmd-host=connection_string,
-c
connection_string
与 --ndb-connectstring 相同
（支持所有基于 MySQL 8.0 的 NDB 版本）
--ndb-nodeid=#
为此节点设置节点 ID，覆盖 --ndb-connectstring 设置的任何 ID
（支持所有基于 MySQL 8.0 的 NDB 版本）
--nodaemon
不要将 ndbd 作为守护进程启动；提供用于测试目的
（支持所有基于 MySQL 8.0 的 NDB 版本）
--no-defaults
不要从登录文件以外的任何选项文件中读取默认选项
（支持所有基于 MySQL 8.0 的 NDB 版本）
--nostart,
-n
不要立即启动 ndbd；ndbd 等待命令从 ndb_mgm 开始
（支持所有基于 MySQL 8.0 的 NDB 版本）
--nowait-nodes=list
不要等待这些数据节点启动（采用逗号分隔的节点 ID 列表）；需要 --ndb-nodeid
（支持所有基于 MySQL 8.0 的 NDB 版本）
--ndb-optimized-node-selection
为交易节点的选择启用优化。默认启用；使用 --skip-ndb-optimized-node-selection 禁用
删除：8.0.31
--print-defaults
打印程序参数列表并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--remove[=name]
用于删除之前作为 Windows 服务安装的数据节点进程；不适用于其他平台
（支持所有基于 MySQL 8.0 的 NDB 版本）
--usage,
-?
显示帮助文本并退出；与 --help 相同
（支持所有基于 MySQL 8.0 的 NDB 版本）
--verbose,
-v
将额外的调试信息写入节点日志
（支持所有基于 MySQL 8.0 的 NDB 版本）
--version,
-V
显示版本信息并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
笔记
所有这些选项也适用于该程序的多线程版本 ( ndbmtd )，您可以用“ ndbmtd ”代替
“ ndbd ”，无论后者在本节中出现在哪里。
--bind-address
命令行格式
--bind-address=name
类型
细绳
默认值
使ndbd绑定到特定的网络接口（主机名或 IP 地址）。该选项没有默认值。
--character-sets-dir
命令行格式
--character-sets-dir=path
包含字符集的目录。
--connect-delay=#
命令行格式
--connect-delay=#
弃用
是（在 8.0.28-ndb-8.0.28 中删除）
类型
数字
默认值
5
最小值
0
最大值
3600
确定启动时尝试联系管理服务器之间等待的时间（尝试次数由
--connect-retries选项控制）。默认值为 5 秒。
此选项已弃用，并且会在 NDB Cluster 的未来版本中删除。改用
--connect-retry-delay。
--connect-retries=#
命令行格式
--connect-retries=#
类型
数字
默认值
12
最小值 (≥ 8.0.28-ndb-8.0.28)
-1
最小值
-1
最小值
-1
最小值（≤ 8.0.27-ndb-8.0.27）
0
最大值
65535
设置放弃前重试连接的次数；0 表示仅尝试 1 次（不重试）。默认值为 12 次尝试。尝试之间等待的时间由--connect-retry-delay
选​​项控制。
从 NDB 8.0.28 开始，您可以将此选项设置为 -1，在这种情况下，数据节点进程会无限期地继续尝试连接。
--connect-retry-delay=#
命令行格式
--connect-retry-delay=#
类型
数字
默认值
5
最小值
0
最大值
4294967295
确定在启动时尝试联系管理服务器之间等待的时间（尝试之间的时间由
--connect-retries选​​项控制）。默认值为 5 秒。
此选项取代了
--connect-delay现在已弃用并在 NDB Cluster 的未来版本中删除的选项。
从 NDB 8.0.28 开始，此选项的缩写形式-r已弃用，并且可能会在 NDB Cluster 的未来版本中删除。请改用长格式。
--connect-string
命令行格式
--connect-string=connection_string
类型
细绳
默认值
[none]
与 相同--ndb-connectstring。
--core-file
命令行格式
--core-file
写入核心文件出错；在调试中使用。
--daemon,-d
命令行格式
--daemon
指示ndbd或
ndbmtd作为守护进程执行。这是默认行为。
--nodaemon可用于防止进程作为守护进程运行。
在 Windows 平台上
运行ndbd或ndbmtd
时，此选项无效
。
--defaults-extra-file
命令行格式
--defaults-extra-file=path
类型
细绳
默认值
[none]
读取全局文件后读取给定文件。
--defaults-file
命令行格式
--defaults-file=path
类型
细绳
默认值
[none]
仅从给定文件中读取默认选项。
--defaults-group-suffix
命令行格式
--defaults-group-suffix=string
类型
细绳
默认值
[none]
还可以阅读带有 concat(group, suffix) 的组。
--filesystem-password
命令行格式
--filesystem-password=password
介绍
8.0.31
stdin使用,
tty, 或file
将文件系统加解密密码传递给数据节点进程my.cnf
。
需要EncryptedFileSystem =
1。
有关更多信息，请参阅
第 23.6.13 节，“NDB Cluster 的文件系统加密”。
--filesystem-password-from-stdin
命令行格式
--filesystem-password-from-stdin={TRUE|FALSE}
介绍
8.0.31
将文件系统加解密密码从stdin（仅）传递给数据节点进程。
需要EncryptedFileSystem =
1。
有关更多信息，请参阅
第 23.6.13 节，“NDB Cluster 的文件系统加密”。
--foreground
命令行格式
--foreground
导致ndbd或ndbmtd
作为前台进程执行，主要用于调试目的。该选项隐含该
--nodaemon选项。
在 Windows 平台上
运行ndbd或ndbmtd
时，此选项无效
。
--help
命令行格式
--help
显示帮助文本并退出。
--initial
命令行格式
--initial
指示ndbd执行初始启动。初始启动会删除早期ndbd实例为恢复目的创建的任何文件
。它还会重新创建恢复日志文件。在某些操作系统上，此过程可能会花费大量时间。
只有在非常特殊的情况下
启动ndbd
进程时才--initial使用启动；这是因为此选项会导致所有文件从 NDB Cluster 文件系统中删除，并重新创建所有重做日志文件。此处列出了这些情况：
执行已更改任何文件内容的软件升级时。
使用新版本的
ndbd重新启动节点时。
当由于某种原因节点重启或系统重启反复失败时，作为最后的手段。在这种情况下，请注意由于数据文件被破坏，该节点将无法再用于恢复数据。
警告
为避免最终丢失数据的可能性，建议您不要将该
--initial选项与 一起使用
StopOnError = 0。相反，仅在集群启动后设置
StopOnError为 0
config.ini，然后正常重启数据节点——即没有该
--initial选项。有关此问题的详细说明，请参阅StopOnError
参数说明。（缺陷号 24945638）
使用此选项可防止
StartPartialTimeout
和
StartPartitionedTimeout
配置参数产生任何影响。
重要的
此选项不影响受影响节点已创建的备份文件。
在 NDB 8.0.21 之前，该--initial选项也不会影响任何磁盘数据文件。在 NDB 8.0.21 及更高版本中，当用于执行集群的初始重启时，该选项会导致删除与磁盘数据表空间关联的所有数据文件以及与该数据节点上先前存在的日志文件组关联的撤消日志文件（参见
第 23.6.10 节，“NDB 集群磁盘数据表”）。
此选项对刚刚从已经运行的数据节点开始（或重新启动）的数据节点恢复数据也没有影响（除非它们也以 开始--initial，作为初始重新启动的一部分）。这种数据恢复是自动发生的，并且不需要用户干预正常运行的 NDB Cluster。
第一次启动集群时（即在创建任何数据节点文件之前）允许使用此选项；但是，
没有必要这样做。
--initial-start
命令行格式
--initial-start
在执行集群的部分初始启动时使用此选项。每个节点都应使用此选项以及
--nowait-nodes.
假设您有一个 4 节点集群，其数据节点的 ID 为 2、3、4 和 5，并且您希望仅使用节点 2、4 和 5 执行部分初始启动，即省略节点 3：
$> ndbd --ndb-nodeid=2 --nowait-nodes=3 --initial-start
$> ndbd --ndb-nodeid=4 --nowait-nodes=3 --initial-start
$> ndbd --ndb-nodeid=5 --nowait-nodes=3 --initial-start
使用此选项时，还必须为使用该选项启动的数据节点指定节点 ID
--ndb-nodeid。
重要的
不要将此选项与
ndb_mgmd--nowait-nodes的选项
混淆，后者可用于启用配置有多个管理服务器的集群，以便在所有管理服务器不在线的情况下启动。
--install[=name]
命令行格式
--install[=name]
特定于平台
视窗
类型
细绳
默认值
ndbd
使ndbd作为 Windows 服务安装。或者，您可以为服务指定一个名称；如果未设置，服务名称默认为
ndbd. 虽然最好在或配置文件中指定其他ndbd程序选项
，但可以与
. 但是，在这种情况下，
必须先指定该选项，然后再给出任何其他选项，Windows 服务安装才能成功。
my.inimy.cnf--install--install
通常不建议将此选项与选项一起使用--initial，因为这会导致每次停止和启动服务时都擦除并重建数据节点文件系统。如果您打算使用影响数据节点启动的任何其他ndbd选项 - 包括
--initial-start，
--nostart和
- 以及 ，还应--nowait-nodes格外小心--install，并且您应该绝对确定您完全理解并考虑这样做的任何可能后果所以。
该--install选项对非 Windows 平台没有影响。
--logbuffer-size=#
命令行格式
--logbuffer-size=#
类型
整数
默认值
32768
最小值
2048
最大值
4294967295
设置数据节点日志缓冲区的大小。在使用大量额外日志进行调试时，如果日志消息过多，日志缓冲区可能会用完空间，在这种情况下，一些日志消息可能会丢失。这不应在正常操作期间发生。
--login-path
命令行格式
--login-path=path
类型
细绳
默认值
[none]
从登录文件中读取给定路径。
--ndb-connectstring
命令行格式
--ndb-connectstring=connection_string
类型
细绳
默认值
[none]
设置用于连接到 ndb_mgmd 的连接字符串。语法：“[nodeid=id;][host=]hostname[:port]”。覆盖 NDB_CONNECTSTRING 和 my.cnf 中的条目。
--ndb-mgmd-host
命令行格式
--ndb-mgmd-host=connection_string
类型
细绳
默认值
[none]
与 相同--ndb-connectstring。
--ndb-nodeid
命令行格式
--ndb-nodeid=#
类型
整数
默认值
[none]
为此节点设置节点 ID，覆盖 --ndb-connectstring 设置的任何 ID。
--ndb-optimized-node-selection
命令行格式
--ndb-optimized-node-selection
删除
8.0.31
为交易节点的选择启用优化。默认启用；用于
--skip-ndb-optimized-node-selection禁用。
--nodaemon
命令行格式
--nodaemon
防止ndbd或
ndbmtd作为守护进程执行。此选项覆盖
--daemon选项。这对于在调试二进制文件时将输出重定向到屏幕很有用。
Windows 上ndbd和
ndbmtd
的默认行为是在前台运行，因此在 Windows 平台上不需要此选项，因为它没有任何效果。
--no-defaults
命令行格式
--no-defaults
不要从登录文件以外的任何选项文件中读取默认选项。
--nostart,-n
命令行格式
--nostart
指示ndbd不要自动启动。使用此选项时，
ndbd连接到管理服务器，从中获取配置数据，并初始化通信对象。但是，在管理服务器明确请求之前，它不会真正启动执行引擎。这可以通过START
在管理客户端中发出适当的命令来完成（请参阅
第 23.6.1 节，“NDB Cluster Management Client 中的命令”）。
--nowait-nodes=node_id_1[,
node_id_2[, ...]]
命令行格式
--nowait-nodes=list
类型
细绳
默认值
此选项采用集群在启动之前不等待的数据节点列表。
这可用于以分区状态启动集群。例如，要启动只有一半数据节点（节点 2、3、4 和 5）在 4 节点集群中运行的集群，您可以启动每个ndbd进程--nowait-nodes=3,5。在这种情况下，集群会在节点 2 和 4 连接后立即启动，并且不会
像其他情况那样等待
StartPartitionedTimeout
几毫秒以等待节点 3 和 5 连接。
如果你想在没有一个ndbd
的情况下启动与上一个示例相同的集群（例如，节点 3 的主机遇到硬件故障），那么启动节点 2、4 和 5
--nowait-nodes=3。然后集群在节点 2、4、5 连接时立即启动，而不等待节点 3 启动。
--print-defaults
命令行格式
--print-defaults
打印程序参数列表并退出。
--remove[=name]
命令行格式
--remove[=name]
特定于平台
视窗
类型
细绳
默认值
ndbd
导致删除以前作为 Windows 服务安装的ndbd进程。或者，您可以为要卸载的服务指定一个名称；如果未设置，服务名称默认为
ndbd.
该--remove选项对非 Windows 平台没有影响。
--usage
命令行格式
--usage
显示帮助文本并退出；与 --help 相同。
--verbose,-v
导致将额外的调试输出写入节点日志。
您还可以在数据节点运行时
使用NODELOG DEBUG
ON和启用和禁用此额外日志记录。NODELOG DEBUG
OFF
--version
命令行格式
--version
显示版本信息并退出。
ndbd生成一组日志文件，这些文件放置在配置文件中指定的目录
DataDir中
config.ini。
下面列出了这些日志文件。
node_id是并且表示节点的唯一标识符。例如
ndb_2_error.log是节点ID为 的数据节点产生的错误日志2。
ndb_node_id_error.log
是一个文件，其中包含引用的ndbd进程遇到的所有崩溃的记录。此文件中的每条记录都包含一个简短的错误字符串和对此崩溃的跟踪文件的引用。此文件中的典型条目可能如下所示：
Date/Time: Saturday 30 July 2004 - 00:20:01
Type of error: error
Message: Internal program error (failed ndbrequire)
Fault ID: 2341
Problem data: DbtupFixAlloc.cpp
Object of reference: DBTUP (Line: 173)
ProgramName: NDB Kernel
ProcessID: 14909
TraceFile: ndb_2_trace.log.2
***EOM***可以在数据节点错误消息中找到数据节点进程过早关闭时
可能生成的ndbd退出代码和消息的列表。
重要的
错误日志文件中的最后一个条目不一定是最新的（也不可能是）。错误日志中的条目未按
时间顺序列出；相反，它们对应于文件中确定的跟踪文件的顺序
（见下文）。因此，错误日志条目以循环而非顺序的方式被覆盖。
ndb_node_id_trace.log.next
ndb_node_id_trace.log.trace_id
是一个跟踪文件，准确描述了错误发生之前发生的事情。此信息对于 NDB Cluster 开发团队的分析很有用。
可以配置在覆盖旧文件之前创建的这些跟踪文件的数量。
trace_id是一个数字，对于每个连续的跟踪文件递增。
ndb_node_id_trace.log.next
是跟踪要分配的下一个跟踪文件编号的文件。
ndb_node_id_out.log
是包含
ndbd进程输出的任何数据的文件。仅当ndbd作为守护进程启动时
才会创建此文件，这是默认行为。
ndb_node_id.pid
是一个包含
ndbd进程作为守护进程启动时的进程 ID 的文件。它还用作锁定文件，以避免启动具有相同标识符的节点。
ndb_node_id_signal.log
是仅在
ndbd调试版本中使用的文件，其中可以跟踪所有传入、传出和内部消息及其在ndbd进程中的数据。
.pid建议不要使用通过 NFS 安装的目录，因为在某些环境中，这可能会导致问题，即使在进程终止后，文件
上的锁定仍然有效。
要启动ndbd，可能还需要指定管理服务器的主机名和它正在侦听的端口。可选地，还可以指定进程要使用的节点 ID。
$> ndbd --connect-string="nodeid=2;host=ndb_mgmd.mysql.com:1186"有关此问题的更多信息，
请参阅第 23.4.3.3 节，“NDB Cluster 连接字符串” 。有关数据节点配置参数的更多信息，请参阅
第 23.4.3.6 节，“定义 NDB Cluster 数据节点”。
当ndbd启动时，它实际上启动了两个进程。其中第一个称为“天使过程”；它唯一的工作是发现执行过程何时完成，然后重新启动
ndbd进程（如果配置为这样做）。因此，如果您尝试使用 Unix kill命令杀死ndbd，则有必要杀死两个进程，从 angel 进程开始。终止ndbd进程的首选方法是使用管理客户端并从那里停止进程。
执行过程使用一个线程来读取、写入和扫描数据，以及所有其他活动。该线程是异步实现的，因此它可以轻松处理数千个并发操作。此外，看门狗线程监督执行线程以确保它不会挂在无限循环中。线程池处理文件 I/O，每个线程能够处理一个打开的文件。线程也可用于
ndbd进程中传输器的传输器连接。在执行大量操作（包括更新）的多处理器系统中，如果允许的话，
ndbd进程最多可以消耗 2 个 CPU。
对于具有多个 CPU 的机器，可以使用
属于不同节点组的多个ndbd进程；然而，这样的配置仍然被认为是实验性的，并且在生产环境中不受 MySQL 8.0 的支持。请参阅
第 23.2.7 节，“NDB Cluster 的已知限制”。
© Mysql 中文网
