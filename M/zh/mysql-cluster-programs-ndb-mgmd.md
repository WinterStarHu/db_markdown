# 23.5.4 ndb_mgmd — NDB 集群管理服务器守护进程_MySQL 8.0 参考手册

23.5.4 ndb_mgmd — NDB 集群管理服务器守护进程_MySQL 8.0 参考手册
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
23.5.4 ndb_mgmd — NDB 集群管理服务器守护进程
23.5.4 ndb_mgmd — NDB 集群管理服务器守护进程
管理服务器是读取集群配置文件并将此信息分发给请求它的集群中的所有节点的进程。它还维护集群活动的日志。管理客户端可以连接到管理服务器并检查集群的状态。
下表显示了
可以与ndb_mgmd一起使用的所有选项。表后有其他说明。
表 23.26 与程序 ndb_mgmd 一起使用的命令行选项
格式
描述
添加、弃用或删除
--bind-address=host
本地绑定地址
（支持所有基于 MySQL 8.0 的 NDB 版本）
--character-sets-dir=path
包含字符集的目录
删除：8.0.31
--cluster-config-suffix=name
读取 my.cnf 文件中的 cluster_config 部分时覆盖默认组后缀；用于测试
添加：NDB 8.0.24
--config-cache[=TRUE|FALSE]
启用管理服务器配置缓存；默认为真
（支持所有基于 MySQL 8.0 的 NDB 版本）
--config-file=file,
-f
file
指定集群配置文件；如果存在，还指定 --reload 或 --initial 以覆盖配置缓存
（支持所有基于 MySQL 8.0 的 NDB 版本）
--configdir=directory,
--config-dir=directory
指定集群管理服务器配置缓存目录
（支持所有基于 MySQL 8.0 的 NDB 版本）
--connect-retries=#
放弃前重试连接的次数
删除：8.0.31
--connect-retry-delay=#
尝试联系管理服务器之间等待的秒数
删除：8.0.31
--connect-string=connection_string,
-c
connection_string
与 --ndb-connectstring 相同
（支持所有基于 MySQL 8.0 的 NDB 版本）
--core-file
写入核心文件出错；用于调试
删除：8.0.31
--daemon,
-d
以守护进程模式运行 ndb_mgmd（默认）
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
--help,
-?
显示帮助文本并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--initial
导致管理服务器从配置文件重新加载配置数据，绕过配置缓存
（支持所有基于 MySQL 8.0 的 NDB 版本）
--install[=name]
用于安装管理服务器进程作为 Windows 服务；不适用于其他平台
（支持所有基于 MySQL 8.0 的 NDB 版本）
--interactive
以交互模式运行 ndb_mgmd（生产中未正式支持；仅用于测试目的）
（支持所有基于 MySQL 8.0 的 NDB 版本）
--log-name=name
写入应用于此节点的集群日志消息时使用的名称
（支持所有基于 MySQL 8.0 的 NDB 版本）
--login-path=path
从登录文件中读取给定路径
（支持所有基于 MySQL 8.0 的 NDB 版本）
--mycnf
从 my.cnf 文件读取集群配置数据
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
--ndb-optimized-node-selection
为交易节点的选择启用优化。默认启用；使用 --skip-ndb-optimized-node-selection 禁用
删除：8.0.31
--no-defaults
不要从登录文件以外的任何选项文件中读取默认选项
（支持所有基于 MySQL 8.0 的 NDB 版本）
--no-nodeid-checks
不执行任何节点 ID 检查
（支持所有基于 MySQL 8.0 的 NDB 版本）
--nodaemon
不要将 ndb_mgmd 作为守护进程运行
（支持所有基于 MySQL 8.0 的 NDB 版本）
--nowait-nodes=list
不等待启动此管理服务器时指定的管理节点；需要 --ndb-nodeid 选项
（支持所有基于 MySQL 8.0 的 NDB 版本）
--print-defaults
打印程序参数列表并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--print-full-config,
-P
打印完整配置并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--reload
使管理服务器将配置文件与配置缓存进行比较
（支持所有基于 MySQL 8.0 的 NDB 版本）
--remove[=name]
用于删除以前作为 Windows 服务安装的管理服务器进程，可选择指定要删除的服务名称；不适用于其他平台
（支持所有基于 MySQL 8.0 的 NDB 版本）
--usage,
-?
显示帮助文本并退出；与 --help 相同
（支持所有基于 MySQL 8.0 的 NDB 版本）
--skip-config-file
不要使用配置文件
（支持所有基于 MySQL 8.0 的 NDB 版本）
--verbose,
-v
将附加信息写入日志
（支持所有基于 MySQL 8.0 的 NDB 版本）
--version,
-V
显示版本信息并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--bind-address=host
命令行格式
--bind-address=host
类型
细绳
默认值
[none]
使管理服务器绑定到特定网络接口（主机名或 IP 地址）。该选项没有默认值。
--character-sets-dir
命令行格式
--character-sets-dir=path
删除
8.0.31
包含字符集的目录。
cluster-config-suffix
命令行格式
--cluster-config-suffix=name
介绍
8.0.24-ndb-8.0.24
类型
细绳
默认值
[none]
在读取集群配置部分时覆盖默认组后缀my.cnf；用于测试。
--config-cache
命令行格式
--config-cache[=TRUE|FALSE]
类型
布尔值
默认值
TRUE
此选项的默认值为1（或
TRUE，或ON），可用于禁用管理服务器的配置缓存，以便它在
config.ini每次启动时读取其配置（请参阅
第 23.4.3 节，“NDB Cluster 配置文件”）。您可以通过使用以下任一选项
启动ndb_mgmd进程来执行此操作：
--config-cache=0
--config-cache=FALSE
--config-cache=OFF
--skip-config-cache
仅当管理服务器在启动时没有存储配置时，使用刚刚列出的选项之一才有效。如果管理服务器找到任何配置缓存文件，则
--config-cache选项或
--skip-config-cache选项将被忽略。因此，要禁用配置缓存，应在管理服务器首次启动时使用该选项。否则——也就是说，如果您希望为已经存在的管理服务器禁用配置缓存创建了配置缓存—您必须停止管理服务器，手动删除任何现有的配置缓存文件，然后重新启动管理服务器
--skip-config-cache（或
--config-cache设置为 0
OFF、 或FALSE）。
配置缓存文件通常在mysql-cluster安装目录下命名的目录中创建（除非已使用该
--configdir选项覆盖此位置）。每次管理服务器更新其配置数据时，它都会写入一个新的缓存文件。这些文件使用以下格式按创建顺序依次命名：
ndb_node-id_config.bin.seq-number
node-id是管理服务器的节点 ID；seq-number
是一个序列号，从 1 开始。例如，如果管理服务器的节点 ID 是 5，那么前三个配置缓存文件在创建时将被命名为ndb_5_config.bin.1、
ndb_5_config.bin.2和
ndb_5_config.bin.3。
如果您的目的是在不实际禁用缓存的情况下清除或重新加载配置缓存，则应该
使用其中一个选项
--reload或
--initial而不是
--skip-config-cache.
要重新启用配置缓存，只需重新启动管理服务器，但不要
使用之前用于禁用配置缓存
的--config-cache或
选项。--skip-config-cache
ndb_mgmd不检查配置目录 (--configdir) 或在使用时尝试创建一个--skip-config-cache。（漏洞 #13428853）
--config-file=filename,
-f filename
命令行格式
--config-file=file
被禁用
skip-config-file
类型
文件名
默认值
[none]
指示管理服务器应将哪个文件用作其配置文件。默认情况下，管理服务器查找
与ndb_mgmd可执行文件config.ini位于同一目录中的
文件；否则必须明确指定文件名和位置。
此选项没有默认值，除非管理服务器被迫读取配置文件，否则将被忽略，因为ndb_mgmd是使用--reload或
--initial选项启动的，或者因为管理服务器找不到任何配置缓存。从 NDB 8.0.26 开始，
如果指定时没有指定
或，则ndb_mgmd拒绝启动
。
--config-file--initial--reload如果ndb_mgmd以启动，
--config-file也会读取
该选项。有关更多信息，请参阅
第 23.4.3 节，“NDB Cluster 配置文件”。
--config-cache=OFF
--configdir=dir_name
命令行格式
--configdir=directory--config-dir=directory
类型
文件名
默认值
$INSTALLDIR/mysql-cluster
指定集群管理服务器的配置缓存目录。--config-dir是这个选项的别名。
在 NDB 8.0.27 及更高版本中，这必须是绝对路径。否则，管理服务器拒绝启动。
--connect-retries
命令行格式
--connect-retries=#
删除
8.0.31
类型
整数
默认值
12
最小值
0
最大值
12
放弃前重试连接的次数。
--connect-retry-delay
命令行格式
--connect-retry-delay=#
删除
8.0.31
类型
整数
默认值
5
最小值
0
最大值
5
尝试联系管理服务器之间等待的秒数。
--connect-string
命令行格式
--connect-string=connection_string
类型
细绳
默认值
[none]
与 --ndb-connectstring 相同。
--core-file
命令行格式
--core-file
删除
8.0.31
写入核心文件出错；在调试中使用。
--daemon,
-d
命令行格式
--daemon
指示ndb_mgmd作为守护进程启动。这是默认行为。
在 Windows 平台上
运行ndb_mgmd
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
--help
命令行格式
--help
显示帮助文本并退出。
--initial
命令行格式
--initial
配置数据在内部缓存，而不是每次启动管理服务器时都从集群全局配置文件中读取（请参阅
第 23.4.3 节，“NDB 集群配置文件”）。使用该
--initial选项会覆盖此行为，强制管理服务器删除任何现有的缓存文件，然后从集群配置文件中重新读取配置数据并构建新的缓存。
这与选项有两个不同之处
--reload。首先，
--reload强制服务器根据缓存检查配置文件，仅当文件内容与缓存不同时才重新加载其数据。第二，--reload不删除任何现有的缓存文件。
如果调用
ndb_mgmd--initial但找不到全局配置文件，则管理服务器无法启动。
当管理服务器启动时，它会检查同一 NDB Cluster 中的另一个管理服务器，并尝试使用其他管理服务器的配置数据。在执行具有多个管理节点的 NDB Cluster 的滚动重启时，此行为会产生影响。有关更多信息，请参阅
第 23.6.5 节，“执行 NDB Cluster 的滚动重启”。
与该选项一起使用时
--config-file，只有在实际找到配置文件时才清除缓存。
--install[=name]
命令行格式
--install[=name]
特定于平台
视窗
类型
细绳
默认值
ndb_mgmd
导致ndb_mgmd作为 Windows 服务安装。或者，您可以为服务指定一个名称；如果未设置，服务名称默认为
ndb_mgmd. 尽管最好在或配置文件中指定其他ndb_mgmd程序选项
，但可以将它们与
. 但是，在这种情况下，必须先指定该选项，然后再给出任何其他选项，Windows 服务安装才能成功。
my.inimy.cnf--install--install
通常不建议将此选项与 选项一起使用--initial，因为这会导致每次停止和启动服务时配置缓存都被擦除和重建。如果您打算使用影响管理服务器启动的任何其他ndb_mgmd选项，也应该小心
，并且您应该绝对确定您完全理解并允许这样做的任何可能后果。
该--install选项对非 Windows 平台没有影响。
--interactive
命令行格式
--interactive
以交互模式启动ndb_mgmd；也就是说，一旦管理服务器运行，就会启动ndb_mgm客户端会话。此选项不会启动任何其他 NDB Cluster 节点。
--log-name=name
命令行格式
--log-name=name
类型
细绳
默认值
MgmtSrvr
提供要在集群日志中用于此节点的名称。
--login-path
命令行格式
--login-path=path
类型
细绳
默认值
[none]
从登录文件中读取给定路径。
--mycnf
命令行格式
--mycnf
从my.cnf
文件中读取配置数据。
--ndb-connectstring
命令行格式
--ndb-connectstring=connection_string
类型
细绳
默认值
[none]
设置连接字符串。语法：
. 覆盖
和中的条目。如果指定则忽略
；从 NDB 8.0.27 开始，当同时使用这两个选项时会发出警告。
[nodeid=id;][host=]hostname[:port]NDB_CONNECTSTRINGmy.cnf--config-file
--ndb-mgmd-host
命令行格式
--ndb-mgmd-host=connection_string
类型
细绳
默认值
[none]
与 --ndb-connectstring 相同。
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
--no-nodeid-checks
命令行格式
--no-nodeid-checks
不要对节点 ID 执行任何检查。
--nodaemon
命令行格式
--nodaemon
指示ndb_mgmd不要作为守护进程启动。
Windows 上ndb_mgmd
的默认行为是在前台运行，因此在 Windows 平台上不需要此选项。
--no-defaults
命令行格式
--no-defaults
不要从登录文件以外的任何选项文件中读取默认选项。
--nowait-nodes
命令行格式
--nowait-nodes=list
类型
数字
默认值
[none]
最小值
1
最大值
255
当启动 NDB Cluster 配置有两个管理节点时，每个管理服务器通常会检查另一个ndb_mgmd是否也在运行以及另一个管理服务器的配置是否与它自己的相同。但是，有时希望仅使用一个管理节点启动集群（并且可能允许
稍后启动另一个ndb_mgmd ）。此选项会导致管理节点绕过对其节点 ID 传递给此选项的任何其他管理节点的任何检查，从而允许集群启动，就像配置为仅使用已启动的管理节点一样。
为了便于说明，请考虑文件的以下部分config.ini（我们省略了与此示例无关的大部分配置参数）：
[ndbd]
NodeId = 1
HostName = 198.51.100.101
[ndbd]
NodeId = 2
HostName = 198.51.100.102
[ndbd]
NodeId = 3
HostName = 198.51.100.103
[ndbd]
NodeId = 4
HostName = 198.51.100.104
[ndb_mgmd]
NodeId = 10
HostName = 198.51.100.150
[ndb_mgmd]
NodeId = 11
HostName = 198.51.100.151
[api]
NodeId = 20
HostName = 198.51.100.200
[api]
NodeId = 21
HostName = 198.51.100.201
假设您希望仅使用具有节点 ID10并在 IP 地址为 198.51.100.150 的主机上运行的管理服务器来启动此集群。（假设，例如，你打算在其上的其他管理服务器的主机由于硬件故障暂时不可用，你正在等待它被修复。）以这种方式启动集群，使用命令在 198.51.100.150 机器上输入以下命令：
$> ndb_mgmd --ndb-nodeid=10 --nowait-nodes=11
如上例所示，使用 时
--nowait-nodes，还必须使用--ndb-nodeid
选项指定此
ndb_mgmd进程的节点 ID。
然后您可以按照通常的方式启动集群的每个数据节点。如果您希望稍后在不重新启动数据节点的情况下启动和使用除第一个管理服务器之外的第二个管理服务器，则必须使用引用两个管理服务器的连接字符串启动每个数据节点，如下所示：
$> ndbd -c 198.51.100.150,198.51.100.151对于您希望作为连接到此集群的 NDB Cluster SQL 节点启动的任何mysqld进程
使用的连接字符串也是如此。有关更多信息，请参阅第 23.4.3.3 节，“NDB Cluster 连接字符串”。
当与ndb_mgmd一起使用时，此选项仅影响管理节点相对于其他管理节点的行为。不要将它与
--nowait-nodes用于
ndbd或ndbmtd的选项混淆，以允许集群以少于其完整数据节点的数量开始；当与数据节点一起使用时，此选项仅影响它们对其他数据节点的行为。
多个管理节点 ID 可以作为逗号分隔列表传递给此选项。每个节点 ID 必须不小于 1 且不大于 255。实际上，很少为同一个 NDB Cluster 使用两个以上的管理服务器（或者有任何需要这样做）；在大多数情况下，您只需要将您不想在启动集群时使用的一个管理服务器的单个节点 ID 传递给此选项。
笔记
当您稍后启动“丢失的”管理服务器时，其配置必须与集群已在使用的管理服务器的配置相匹配。否则，它无法通过现有管理服务器执行的配置检查，并且不会启动。
--print-defaults
命令行格式
--print-defaults
打印程序参数列表并退出。
--print-full-config,
-P
命令行格式
--print-full-config
显示有关集群配置的扩展信息。使用命令行上的此选项，
ndb_mgmd进程会打印有关集群设置的信息，包括集群配置部分的扩展列表以及参数及其值。通常与
--config-file
( -f) 选项一起使用。
--reload
命令行格式
--reload
NDB Cluster 配置数据存储在内部，而不是在每次启动管理服务器时从集群全局配置文件中读取（请参阅
第 23.4.3 节，“NDB Cluster 配置文件”）。使用此选项会强制管理服务器根据集群配置文件检查其内部数据存储，并在发现配置文件与缓存不匹配时重新加载配置。现有配置缓存文件会保留，但不会使用。
这与选项有两个不同之处
--initial。首先，
--initial导致所有缓存文件被删除。第二，--initial强制管理服务器重新读取全局配置文件并构建新的缓存。
如果管理服务器找不到全局配置文件，则--reload忽略该选项。
使用时--reload，管理服务器在尝试读取全局配置文件之前必须能够与集群中的数据节点和任何其他管理服务器进行通信；否则，管理服务器无法启动。这可能是由于网络环境的变化而发生的，例如节点的新 IP 地址或更改的防火墙配置。在这种情况下，您必须使用
--initialinstead 来强制丢弃现有的缓存配置并从文件中重新加载。有关其他信息，请参阅
第 23.6.5 节，“执行 NDB Cluster 的滚动重启”。
--remove[=name]
命令行格式
--remove[=name]
特定于平台
视窗
类型
细绳
默认值
ndb_mgmd
删除已作为 Windows 服务安装的管理服务器进程，可选择指定要删除的服务的名称。仅适用于 Windows 平台。
--skip-config-file
命令行格式
--skip-config-file
不读取集群配置文件；忽略
--initial和
--reload选项（如果指定）。
--usage
命令行格式
--usage
显示帮助文本并退出；与 --help 相同。
--verbose,
-v
命令行格式
--verbose
删除已作为 Windows 服务安装的管理服务器进程，可选择指定要删除的服务的名称。仅适用于 Windows 平台。
--version
命令行格式
--version
显示版本信息并退出。
启动管理服务器时不一定必须指定连接字符串。但是，如果您使用多个管理服务器，则应提供连接字符串，并且集群中的每个节点都应明确指定其节点 ID。
有关使用连接字符串的信息，请参阅第 23.4.3.3 节，“NDB Cluster 连接字符串”。
第 23.5.4 节，“ndb_mgmd - NDB Cluster Management Server Daemon” ，描述了ndb_mgmd的其他选项。
以下文件由
ndb_mgmd在其起始目录中创建或使用，并放置在配置文件DataDir中指定的目录中。config.ini在接下来的列表中，
node_id是唯一的节点标识符。
config.ini是整个集群的配置文件。该文件由用户创建并由管理服务器读取。
第 23.4 节，“NDB Cluster 的配置”，讨论了如何设置这个文件。
ndb_node_id_cluster.log
is the cluster events log file. Examples of such events
include checkpoint startup and completion, node startup
events, node failures, and levels of memory usage. A
complete listing of cluster events with descriptions may be
found in Section 23.6, “Management of NDB Cluster”.
By default, when the size of the cluster log reaches one
million bytes, the file is renamed to
ndb_node_id_cluster.log.seq_id,
where seq_id is the sequence
number of the cluster log file. (For example: If files with
the sequence numbers 1, 2, and 3 already exist, the next log
file is named using the number 4.) You
can change the size and number of files, and other
characteristics of the cluster log, using the
LogDestination
configuration parameter.
ndb_node_id_out.log
is the file used for stdout and
stderr when running the management server
as a daemon.
ndb_node_id.pid
is the process ID file used when running the management
server as a daemon.
© Mysql 中文网
