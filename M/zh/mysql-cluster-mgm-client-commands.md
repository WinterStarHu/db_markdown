# 23.6.1 NDB Cluster Management Client 中的命令_MySQL 8.0 参考手册

23.6.1 NDB Cluster Management Client 中的命令_MySQL 8.0 参考手册
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
23.6 NDB Cluster的管理
23.6.1 NDB Cluster Management Client 中的命令1
23.6.2 NDB Cluster 日志消息1
23.6.3 NDB Cluster 中生成的事件报告1
23.6.4 NDB Cluster 启动阶段总结1
23.6.5 执行 NDB Cluster 的滚动重启1
23.6.6 NDB Cluster 单用户模式1
23.6.7 在线添加 NDB Cluster 数据节点1
23.6.8 NDB Cluster 在线备份1
23.6.9 NDB Cluster 的 MySQL 服务器使用1
23.6.10 NDB Cluster 磁盘数据表1
23.6.11 在 NDB Cluster 中使用 ALTER TABLE 进行在线操作1
23.6.12 权限同步和 NDB_STORED_USER1
23.6.13 NDB Cluster 的文件系统加密1
23.6.14 NDB API 统计计数器和变量1
23.6.15 ndbinfo：NDB 集群信息数据库1
23.6.16 NDB Cluster 的 INFORMATION_SCHEMA 表1
23.6.17 NDB Cluster 和性能模式1
23.6.18 快速参考：NDB Cluster SQL 语句1
23.6.19 NDB Cluster 安全问题1
23.6.9 导入数据到MySQL集群1
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.6 NDB Cluster的管理  /
23.6.1 NDB Cluster Management Client 中的命令
23.6.1 NDB Cluster Management Client 中的命令
除了中央配置文件之外，还可以通过管理客户端ndb_mgm提供的命令行界面来控制集群。这是运行集群的主要管理界面。
事件日志的命令在
第 23.6.3 节，“NDB Cluster 中生成的事件报告”中给出；第 23.6.8 节，“NDB Cluster 的在线备份”中提供了用于创建备份和从中恢复的命令
。
将 ndb_mgm 与 MySQL 集群管理器一起使用。
MySQL Cluster Manager 1.4.8 为 NDB 8.0 提供实验性支持。MySQL Cluster Manager 处理启动和停止进程并在内部跟踪它们的状态，因此
对于受 MySQL Cluster Manager 控制的 NDB Cluster，没有必要为这些任务使用ndb_mgm 。建议
不要使用 NDB Cluster 发行版附带的ndb_mgm
命令行客户端来执行涉及启动或停止节点的操作。这些包括但不限于
START、
STOP、
RESTART和
SHUTDOWN命令。有关详细信息，请参阅MySQL 集群管理器进程命令.
管理客户端具有以下基本命令。在接下来的清单中，node_id表示数据节点 ID 或关键字ALL，表示该命令应应用于集群的所有数据节点。
CONNECT
connection-string
连接到连接字符串指示的管理服务器。如果客户端已经连接到此服务器，客户端将重新连接。
CREATE NODEGROUP
nodeid[,
nodeid, ...]
创建一个新的 NDB Cluster 节点组并使数据节点加入它。
在将新的数据节点在线添加到 NDB Cluster 之后使用此命令，并使它们加入新的节点组，从而开始完全参与集群。该命令将以逗号分隔的节点 ID 列表作为其唯一参数——这些是刚刚添加和启动的节点的 ID，它们将加入新的节点组。该列表不得包含重复的 ID；从 NDB 8.0.26 开始，任何重复项的存在都会导致命令返回错误。列表中的节点数必须与已经属于集群的每个节点组中的节点数相同（每个 NDB Cluster 节点组必须具有相同数量的节点）。换句话说，
该命令创建的新节点组的节点组ID是自动确定的，总是集群中下一个最大的未使用节点组ID；无法手动设置。
有关更多信息，请参阅
第 23.6.7 节，“在线添加 NDB Cluster 数据节点”。
DROP NODEGROUP
nodegroup_id
使用给定的 删除 NDB Cluster 节点组
nodegroup_id。
此命令可用于从 NDB Cluster 中删除节点组。DROP NODEGROUP将要删除的节点组的节点组 ID 作为其唯一参数。
DROP NODEGROUP仅用于从该节点组中删除受影响节点组中的数据节点。它不会停止数据节点，将它们分配给不同的节点组，或将它们从集群的配置中删除。不属于节点组的数据节点在管理客户端
SHOW命令
的输出中指示，no nodegroup而不是节点组 ID，如下所示（使用粗体文本指示）：
id=3    @10.100.2.67  (8.0.32-ndb-8.0.32, no nodegroup)
DROP NODEGROUP仅当要删除的节点组中的所有数据节点都完全没有任何表数据和表定义时才有效。由于目前无法使用ndb_mgm或
mysql客户端从特定数据节点或节点组中删除所有数据，这意味着该命令仅在以下两种情况下成功：
CREATE
NODEGROUP在ndb_mgm客户端中
发出之后，但在mysql客户端中
发出任何
ALTER TABLE
... REORGANIZE PARTITION语句
之前。
使用删除所有NDBCLUSTER
表后DROP TABLE。
TRUNCATE TABLE不适用于此目的，因为这只会删除表数据；数据节点继续存储
NDBCLUSTER表的定义，直到DROP
TABLE发出一条导致表元数据被删除的语句。
有关更多信息DROP NODEGROUP，请参阅第 23.6.7 节，“在线添加 NDB Cluster 数据节点”。
ENTER SINGLE USER MODE
node_id
进入单用户模式，仅node_id
允许由节点 ID 标识的 MySQL 服务器访问数据库。
ndb_mgm客户端明确确认
此命令已发出并已生效，如下所示：
ndb_mgm> ENTER SINGLE USER MODE 100
Single user mode entered
Access is granted for API node 100 only.
此外，在命令的输出中指示在单用户模式下具有独占访问权限的 API 或 SQL 节点
SHOW，如下所示：
ndb_mgm> SHOW
Cluster Configuration
---------------------
[ndbd(NDB)]     2 node(s)
id=5    @127.0.0.1  (mysql-8.0.32 ndb-8.0.32, single user mode, Nodegroup: 0, *)
id=6    @127.0.0.1  (mysql-8.0.32 ndb-8.0.32, single user mode, Nodegroup: 0)
[ndb_mgmd(MGM)] 1 node(s)
id=50   @127.0.0.1  (mysql-8.0.32 ndb-8.0.32)
[mysqld(API)]   2 node(s)
id=100  @127.0.0.1  (mysql-8.0.32 ndb-8.0.32, allowed single user)
id=101 (not connected, accepting connect from any host)
EXIT SINGLE USER MODE
退出单用户模式，使所有 SQL 节点（即所有正在运行的mysqld进程）都可以访问数据库。
笔记
EXIT SINGLE USER
MODE即使不在单用户模式下
也可以使用，尽管在这种情况下该命令无效。
HELP
显示有关所有可用命令的信息。
node_id
NODELOG DEBUG {ON|OFF}
在节点日志中切换调试日志记录，就好像受影响的数据节点或节点已使用该
--verbose选项启动一样。
NODELOG DEBUG ON开始调试日志；
NODELOG DEBUG OFF关闭调试注销。
PROMPT
[prompt]
将ndb_mgm
显示的提示更改为字符串文字prompt。
prompt不应被引用（除非您希望提示包含引号）。与mysql客户端的情况不同，无法识别特殊字符序列和转义符。如果在没有参数的情况下调用，该命令会将提示重置为默认值 ( ndb_mgm>)。
此处显示了一些示例：
ndb_mgm> PROMPT mgm#1:
mgm#1: SHOW
Cluster Configuration
...
mgm#1: PROMPT mymgm >
mymgm > PROMPT 'mymgm:'
'mymgm:' PROMPT  mymgm:
mymgm: PROMPT
ndb_mgm> EXIT
$>
请注意，不会修剪前导空格和
prompt字符串中的空格。删除尾随空格。
QUIT,
EXIT
终止管理客户端。
此命令不会影响连接到集群的任何节点。
node_id
REPORT report-type
report-type为由 标识的数据节点node_id或所有使用的数据节点
显示类型的报告
ALL。
目前，有 3 个可接受的值
report-type：
BackupStatus提供有关正在进行的集群备份的状态报告
MemoryUsage显示每个数据节点正在使用多少数据内存和索引内存，如本例所示：
ndb_mgm> ALL REPORT MEMORY
Node 1: Data usage is 5%(177 32K pages of total 3200)
Node 1: Index usage is 0%(108 8K pages of total 12832)
Node 2: Data usage is 5%(177 32K pages of total 3200)
Node 2: Index usage is 0%(108 8K pages of total 12832)
此信息也可从
ndbinfo.memoryusage
表中获得。
EventLog从一个或多个数据节点的事件日志缓冲区报告事件。
report-type不区分大小写且
“模糊”；对于MemoryUsage，您可以使用MEMORY（如前面的示例所示），memory甚至简单地
使用MEM（或mem）。你可以用类似的方式缩写BackupStatus。
node_id
RESTART [-n] [-i] [-a] [-f]
node_id重新启动由（或所有数据节点）
标识的
数据节点。
使用-i选项 with
RESTART会导致数据节点执行初始重启；也就是说，节点的文件系统被删除并重新创建。效果与停止数据节点进程然后使用系统 shell 中的
ndbd再次启动它所获得的效果相同。
--initial
笔记
使用此选项时不会删除备份文件和磁盘数据文件。
使用该选项会导致数据节点进程重新启动，但在发出适当的命令-n之前，数据节点实际上并未联机
。此选项的效果与从系统 shell 中
使用ndbd
或ndbdSTART停止数据节点然后再次启动它所获得的效果相同
。 --nostart -n
使用这些-a会导致依赖此节点的所有当前事务中止。当节点重新加入集群时，不会进行 GCP 检查。
通常，RESTART如果使节点脱机会导致集群不完整，则会失败。该
-f选项强制节点重新启动而不进行检查。如果使用此选项并且结果是一个不完整的集群，则整个集群将重新启动。
SHOW
显示集群和集群节点的基本信息。对于所有节点，输出包括节点的 ID、类型和NDB软件版本。如果节点已连接，还会显示其 IP 地址；否则输出显示, with
用于允许从任何地址连接的节点。
not connected, accepting connect from
ip_addressany host
此外，对于数据节点，输出包括
starting节点是否尚未启动，并显示节点所属的节点组。如果数据节点充当主节点，则用星号 ( *) 表示。
考虑一个集群，其配置文件包含此处显示的信息（为清楚起见，省略了可能的其他设置）：
[ndbd default]
DataMemory= 128G
NoOfReplicas= 2
[ndb_mgmd]
NodeId=50
HostName=198.51.100.150
[ndbd]
NodeId=5
HostName=198.51.100.10
DataDir=/var/lib/mysql-cluster
[ndbd]
NodeId=6
HostName=198.51.100.20
DataDir=/var/lib/mysql-cluster
[ndbd]
NodeId=7
HostName=198.51.100.30
DataDir=/var/lib/mysql-cluster
[ndbd]
NodeId=8
HostName=198.51.100.40
DataDir=/var/lib/mysql-cluster
[mysqld]
NodeId=100
HostName=198.51.100.100
[api]
NodeId=101
该集群（含一个SQL节点）启动后，
SHOW输出如下：
ndb_mgm> SHOW
Connected to Management Server at: localhost:1186
Cluster Configuration
---------------------
[ndbd(NDB)]     4 node(s)
id=5    @198.51.100.10  (mysql-8.0.32 ndb-8.0.32, Nodegroup: 0, *)
id=6    @198.51.100.20  (mysql-8.0.32 ndb-8.0.32, Nodegroup: 0)
id=7    @198.51.100.30  (mysql-8.0.32 ndb-8.0.32, Nodegroup: 1)
id=8    @198.51.100.40  (mysql-8.0.32 ndb-8.0.32, Nodegroup: 1)
[ndb_mgmd(MGM)] 1 node(s)
id=50   @198.51.100.150  (mysql-8.0.32 ndb-8.0.32)
[mysqld(API)]   2 node(s)
id=100  @198.51.100.100  (mysql-8.0.32 ndb-8.0.32)
id=101 (not connected, accepting connect from any host)
此命令的输出还指示 cluster 何时处于单用户模式（请参阅
ENTER SINGLE USER MODE
命令说明以及
第 23.6.6 节，“NDB Cluster 单用户模式”）。在 NDB 8.0 中，它还指示当该模式生效时哪个 API 或 SQL 节点具有独占访问权限；这仅在连接到集群的所有数据节点和管理节点都运行 NDB 8.0 时有效。
SHUTDOWN
关闭所有集群数据节点和管理节点。要在完成此操作后退出管理客户端，请使用
EXIT或
QUIT。
此命令不会关闭连接到集群的任何 SQL 节点或 API 节点。
node_id
START
node_id使由（或所有数据节点）
标识的数据节点联机
。
ALL START只作用于所有数据节点，不影响管理节点。
重要的
要使用此命令使数据节点联机，数据节点必须已使用
--nostart或
启动-n。
node_id
STATUS
显示由
node_id（或所有数据节点）标识的数据节点的状态信息。
可能的节点状态值包括
UNKNOWN、NO_CONTACT、
NOT_STARTED、STARTING、
STARTED、SHUTTING_DOWN和RESTARTING。
此命令的输出还指示集群何时处于单用户模式。
node_id
STOP [-a] [-f]
停止由 标识的数据或管理节点
node_id。
笔记
ALL STOP只停止所有数据节点，不影响管理节点。
受此命令影响的节点与集群断开连接，其关联的ndbd或
ndb_mgmd进程终止。
该-a选项会导致节点立即停止，而无需等待任何未决事务的完成。
通常，STOP如果结果会导致不完整的集群，则失败。该-f选项会强制节点关闭而不进行检查。如果使用此选项并且结果是一个不完整的集群，则该集群会立即关闭。
警告
使用该-a选项还会禁用在
STOP调用时执行的安全检查，以确保停止节点不会导致集群不完整。换句话说，在将
-a选项与STOP
命令一起使用时应格外小心，因为此选项使集群有可能经历强制关闭，因为它不再具有存储在中的所有数据的完整副本
NDB。
附加命令。 ndb_mgm客户端中
可用的许多其他命令在
别处进行了描述，如下表所示：
START BACKUP用于在ndb_mgm
客户端执行在线备份；该ABORT BACKUP
命令用于取消已经在进行中的备份。有关更多信息，请参阅第 23.6.8 节，“NDB Cluster 的在线备份”。
该CLUSTERLOG命令用于执行各种日志记录功能。有关更多信息和示例，请参阅
第 23.6.3 节，“NDB Cluster 中生成的事件报告” 。NODELOG DEBUG
激活或停用节点日志中的调试打印输出，如本节前面所述。
对于测试和诊断工作，客户端支持
DUMP可用于在集群上执行内部命令的命令。除非 MySQL 支持指示这样做，否则永远不要在生产环境中使用它。有关更多信息，请参阅
NDB Cluster Management Client DUMP 命令。
© Mysql 中文网
