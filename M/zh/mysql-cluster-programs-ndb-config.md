# 23.5.7 ndb_config — 提取 NDB Cluster 配置信息_MySQL 8.0 参考手册

23.5.7 ndb_config — 提取 NDB Cluster 配置信息_MySQL 8.0 参考手册
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
23.5.7 ndb_config — 提取 NDB Cluster 配置信息
23.5.7 ndb_config — 提取 NDB Cluster 配置信息
此工具从多个来源之一提取数据节点、SQL 节点和 API 节点的当前配置信息：NDB Cluster 管理节点
config.ini或其my.cnf
文件。默认情况下，管理节点是配置数据的来源；--config-file要覆盖默认值，请使用或
--mycnf选项执行 ndb_config 。也可以通过指定其节点 ID 将数据节点用作源
。
--config_from_node=node_id
ndb_config还可以提供所有可以使用的配置参数的离线转储，以及它们的默认值、最大值和最小值等信息。可以以文本或 XML 格式生成转储；有关详细信息，请参阅
本节后
--configinfo和
--xml您可以使用选项
、
或
之一按部分（ DB、
SYSTEM或）
过滤结果。
CONNECTIONS--nodes--system--connections
下表显示了
可以与ndb_config一起使用的所有选项。表后有其他说明。
表 23.29 与程序 ndb_config 一起使用的命令行选项
格式
描述
添加、弃用或删除
--character-sets-dir=path
包含字符集的目录
删除：8.0.31
--cluster-config-suffix=name
读取 my.cnf 文件中的 cluster_config 部分时覆盖默认组后缀；用于测试
添加：NDB 8.0.24
--config-file=file_name
设置config.ini文件的路径
（支持所有基于 MySQL 8.0 的 NDB 版本）
--config-from-node=#
从具有此 ID 的节点获取配置数据（必须是数据节点）
（支持所有基于 MySQL 8.0 的 NDB 版本）
--configinfo
以文本格式转储有关所有导航台配置参数的信息，包括默认值、最大值和最小值。与 --xml 一起使用以获得 XML 输出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--connections
仅打印有关集群配置文件的 [tcp]、[tcp default]、[sci]、[sci default]、[shm] 或 [shm default] 部分中指定的连接的信息。不能与 --system 或 --nodes 一起使用
（支持所有基于 MySQL 8.0 的 NDB 版本）
--connect-retries=#
放弃前重试连接的次数
（支持所有基于 MySQL 8.0 的 NDB 版本）
--connect-retry-delay=#
尝试联系管理服务器之间等待的秒数
（支持所有基于 MySQL 8.0 的 NDB 版本）
--connect-string=connection_string,
-c
connection_string
与 --ndb-connectstring 相同
（支持所有基于 MySQL 8.0 的 NDB 版本）
--core-file
写入核心文件出错；用于调试
删除：8.0.31
--defaults-extra-file=path
读取全局文件后读取给定文件
（支持所有基于 MySQL 8.0 的 NDB 版本）
--defaults-file=path
仅从给定文件中读取默认选项
（支持所有基于 MySQL 8.0 的 NDB 版本）
--defaults-group-suffix=string
还阅读带有 concat(group, suffix) 的组
（支持所有基于 MySQL 8.0 的 NDB 版本）
--diff-default
仅打印具有非默认值的配置参数
（支持所有基于 MySQL 8.0 的 NDB 版本）
--fields=string,
-f
字段分隔符
（支持所有基于 MySQL 8.0 的 NDB 版本）
--help,
-?
显示帮助文本并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--host=name
指定主机
（支持所有基于 MySQL 8.0 的 NDB 版本）
--login-path=path
从登录文件中读取给定路径
（支持所有基于 MySQL 8.0 的 NDB 版本）
--mycnf
从 my.cnf 文件中读取配置数据
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
删除：8.0.31
--ndb-optimized-node-selection
为交易节点的选择启用优化。默认启用；使用 --skip-ndb-optimized-node-selection 禁用
删除：8.0.31
--no-defaults
不要从登录文件以外的任何选项文件中读取默认选项
（支持所有基于 MySQL 8.0 的 NDB 版本）
--nodeid=#
获取具有此 ID 的节点配置
（支持所有基于 MySQL 8.0 的 NDB 版本）
--nodes
仅打印节点信息（集群配置文件的 [ndbd] 或 [ndbd default] 部分）。不能与 --system 或 --connections 一起使用
（支持所有基于 MySQL 8.0 的 NDB 版本）
--query=string,
-q
string
一个或多个查询选项（属性）
（支持所有基于 MySQL 8.0 的 NDB 版本）
--query-all,
-a
将所有参数和值转储到单个以逗号分隔的字符串
（支持所有基于 MySQL 8.0 的 NDB 版本）
--print-defaults
打印程序参数列表并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--rows=string,
-r
string
行分隔符
（支持所有基于 MySQL 8.0 的 NDB 版本）
--system
仅打印 SYSTEM 部分信息（请参阅 ndb_config --configinfo 输出）。不能与 --nodes 或 --connections 一起使用
（支持所有基于 MySQL 8.0 的 NDB 版本）
--type=name
指定节点类型
（支持所有基于 MySQL 8.0 的 NDB 版本）
--usage,
-?
显示帮助文本并退出；与 --help 相同
（支持所有基于 MySQL 8.0 的 NDB 版本）
--version,
-V
显示版本信息并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--configinfo
--xml
使用 --xml 和 --configinfo 以 XML 格式获取所有 NDB 配置参数的转储，包括默认值、最大值和最小值
（支持所有基于 MySQL 8.0 的 NDB 版本）
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
--configinfo
该--configinfo选项导致
ndb_config转储 NDB Cluster 分布支持的每个 NDB Cluster 配置参数的列表，其中ndb_config是其中的一部分，包括以下信息：
简要说明每个参数的用途、作用和用法
config.ini可以使用参数
的文件部分
参数的数据类型或测量单位
适用时，参数的默认值、最小值和最大值
NDB Cluster 发布版本和构建信息
默认情况下，此输出为文本格式。此输出的一部分显示如下：
$> ndb_config --configinfo
****** SYSTEM ******
Name (String)
Name of system (NDB Cluster)
MANDATORY
PrimaryMGMNode (Non-negative Integer)
Node id of Primary ndb_mgmd(MGM) node
Default: 0 (Min: 0, Max: 4294967039)
ConfigGenerationNumber (Non-negative Integer)
Configuration generation number
Default: 0 (Min: 0, Max: 4294967039)
****** DB ******
MaxNoOfSubscriptions (Non-negative Integer)
Max no of subscriptions (default 0 == MaxNoOfTables)
Default: 0 (Min: 0, Max: 4294967039)
MaxNoOfSubscribers (Non-negative Integer)
Max no of subscribers (default 0 == 2 * MaxNoOfTables)
Default: 0 (Min: 0, Max: 4294967039)
…
将此选项与
--xml获取 XML 格式输出的选项一起使用。
--config-file=path-to-file
命令行格式
--config-file=file_name
类型
文件名
默认值
提供管理服务器的配置文件 ( config.ini) 的路径。这可能是相对或绝对路径。如果管理节点位于与调用ndb_config的主机不同的主机上，则必须使用绝对路径。
--config_from_node=#
命令行格式
--config-from-node=#
类型
数字
默认值
none
最小值
1
最大值
48
从具有此 ID 的数据节点获取集群的配置数据。
如果具有此 ID 的节点不是数据节点，
ndb_config 将失败并出现错误。（要改为从管理节点获取配置数据，只需省略此选项即可。）
--connections
命令行格式
--connections
告诉ndb_config仅打印
CONNECTIONS信息——即关于在 cluster 配置文件的 , , 或 部分中找到的参数的信息
[tcp]（[tcp default]参见
[shm]第[shm
default]23.4.3.10节，“NDB Cluster TCP/IP 连接”和第 23.4.3.12 节，“NDB集群共享内存连接”，了解更多信息）。
--nodes此选项与和
互斥
--system；只能使用这 3 个选项中的一个。
--diff-default
命令行格式
--diff-default
仅打印具有非默认值的配置参数。
--fields=delimiter,
-f delimiter
命令行格式
--fields=string
类型
细绳
默认值
指定delimiter用于分隔结果中的字段的字符串。默认值为
,（逗号字符）。
笔记
如果delimiter包含空格或转义符（例如\n换行符），则必须用引号引起来。
--host=hostname
命令行格式
--host=name
类型
细绳
默认值
指定要获取其配置信息的节点的主机名。
笔记
虽然主机名localhost通常会解析为 IP 地址127.0.0.1，但这不一定适用于所有操作平台和配置。这意味着如果
ndb_config
localhost在
解析config.ini为不同地址的不同主机上运行（例如，在某些版本的 SUSE Linux 上，这是--host=localhostlocalhost127.0.0.2). 通常，为了获得最佳结果，您应该为与主机相关的所有 NDB Cluster 配置值使用数字 IP 地址，或者验证所有 NDB Cluster 主机是否
localhost以相同的方式处理。
--mycnf
命令行格式
--mycnf
从my.cnf
文件中读取配置数据。
--ndb-connectstring=connection_string,
-c
connection_string
命令行格式
--ndb-connectstring=connection_string
类型
细绳
默认值
[none]
指定连接到管理服务器时使用的连接字符串。连接字符串的格式与第 23.4.3.3 节，“NDB Cluster 连接字符串”中描述的相同
，默认为localhost:1186.
--no-defaults
命令行格式
--no-defaults
不要从登录文件以外的任何选项文件中读取默认选项。
--nodeid=node_id
命令行格式
--ndb-nodeid=#
删除
8.0.31
类型
整数
默认值
[none]
指定要获取其配置信息的节点的节点ID。
--nodes
命令行格式
--nodes
告诉ndb_config打印仅与 cluster 配置文件的
[ndbd]or[ndbd
default]部分中定义的参数相关的信息（请参阅第 23.4.3.6 节，“定义 NDB Cluster 数据节点”）。
--connections此选项与和
互斥
--system；只能使用这 3 个选项中的一个。
--query=query-options,
-q query-options
命令行格式
--query=string
类型
细绳
默认值
这是一个以逗号分隔的
查询选项列表，即要返回的一个或多个节点属性的列表。这些包括
nodeid（节点 ID）、类型（节点类型——即ndbd、
mysqld或ndb_mgmd），以及要获取其值的任何配置参数。
例如，
--query=nodeid,type,datamemory,datadir
返回每个节点的节点 ID、节点类型、
DataMemory和
DataDir。
笔记
如果给定的参数不适用于某种类型的节点，则返回一个空字符串作为相应的值。有关详细信息，请参阅本节后面的示例。
--query-all,
-a
命令行格式
--query-all
类型
细绳
默认值
返回所有查询选项的逗号分隔列表（节点属性；请注意，此列表是单个字符串。
--rows=separator,
-r separator
命令行格式
--rows=string
类型
细绳
默认值
指定separator用于分隔结果中的行的字符串。默认为空格字符。
笔记
如果separator包含空格或转义符（例如\n换行符），则必须用引号引起来。
--system
命令行格式
--system
告诉ndb_config只打印
SYSTEM信息。这包括无法在运行时更改的系统变量；因此，它们在集群配置文件中没有相应的部分。在ndb_config****** SYSTEM ******的输出中
可以看到它们（以 为前缀
） 。
--configinfo--nodes此选项与和
互斥
--connections；只能使用这 3 个选项中的一个。
--type=node_type
命令行格式
--type=name
类型
枚举
默认值
[none]
有效值
ndbdmysqldndb_mgmd
过滤结果，以便仅返回应用于指定节点
node_type
（ndbd、mysqld或
ndb_mgmd）的配置值。
--usage,
--help, 或-?
命令行格式
--help
导致ndb_config打印可用选项列表，然后退出。
--version,
-V
命令行格式
--version
导致ndb_config打印版本信息字符串，然后退出。
--configinfo
--xml
命令行格式
--configinfo --xml
通过添加此选项使ndb_config以 XML 形式提供输出。
--configinfo此示例中显示了此类输出的一部分：
$> ndb_config --configinfo --xml
<configvariables protocolversion="1" ndbversionstring="5.7.40-ndb-7.5.29"
ndbversion="460032" ndbversionmajor="7" ndbversionminor="5"
ndbversionbuild="0">
<section name="SYSTEM">
<param name="Name" comment="Name of system (NDB Cluster)" type="string"
mandatory="true"/>
<param name="PrimaryMGMNode" comment="Node id of Primary ndb_mgmd(MGM) node"
type="unsigned" default="0" min="0" max="4294967039"/>
<param name="ConfigGenerationNumber" comment="Configuration generation number"
type="unsigned" default="0" min="0" max="4294967039"/>
</section>
<section name="MYSQLD" primarykeys="NodeId">
<param name="wan" comment="Use WAN TCP setting as default" type="bool"
default="false"/>
<param name="HostName" comment="Name of computer for this node"
type="string" default=""/>
<param name="Id" comment="NodeId" type="unsigned" mandatory="true"
min="1" max="255" deprecated="true"/>
<param name="NodeId" comment="Number identifying application node (mysqld(API))"
type="unsigned" mandatory="true" min="1" max="255"/>
<param name="ExecuteOnComputer" comment="HostName" type="string"
deprecated="true"/>
…
</section>
…
</configvariables>
笔记
通常，
ndb_config
--configinfo --xml生成的 XML 输出使用每个元素一行进行格式化；出于易读性的原因，我们在上一个示例和下一个示例中添加了额外的空格。这对使用此输出的应用程序应该没有任何影响，因为大多数 XML 处理器要么理所当然地忽略不必要的空白，要么可以被指示这样做。
XML 输出还指示何时更改给定参数需要使用该
--initial选项重新启动数据节点。initial="true"
这通过相应
<param>元素中属性的存在来显示。此外，还显示重启类型（system或
）；node如果给定参数需要重新启动系统，则通过restart="system"相应<param>元素中存在的属性来指示。例如，更改为
Diskless参数设置的值需要系统初始重启，如此处所示（带有
restart和initial
为可见性突出显示的属性）：
<param name="Diskless" comment="Run wo/ disk" type="bool" default="false"
restart="system" initial="true"/>
目前，与不需要初始重启的参数相对应initial的元素的 XML 输出中不包含任何属性
；<param>换句话说，initial="false"是默认值，false如果该属性不存在，则应采用该值。类似地，默认的重启类型是node（即集群的在线或
“滚动”重启），但
restart仅当重启类型为system（意味着所有集群节点必须同时关闭，则重新启动）。
已弃用的参数在 XML 输出中由
deprecated属性指示，如下所示：
<param name="NoOfDiskPagesToDiskAfterRestartACC" comment="DiskCheckpointSpeed"
type="unsigned" default="20" min="1" max="4294967039" deprecated="true"/>
在这种情况下，comment指的是一个或多个取代已弃用参数的参数。与 类似initial，该
deprecated属性仅在参数被弃用时指示，
deprecated="true"对于未弃用的参数根本不出现。（漏洞 #21127135）
所需的参数用 表示
mandatory="true"，如下所示：
<param name="NodeId"
comment="Number identifying application node (mysqld(API))"
type="unsigned" mandatory="true" min="1" max="255"/>与仅针对需要初始重启或已弃用的参数显示initialor
属性
的方式大致相同，仅当实际需要给定参数时才包含该属性。
deprecatedmandatory
重要的
该--xml选项只能与--configinfo选项一起使用。使用
--xmlwithout
--configinfo失败并出现错误。
与此程序一起使用的选项不同，用于获取当前配置数据，--configinfo并
使用在编译ndb_config--xml时从 NDB Cluster 源获取的信息。因此，这两个选项
不需要连接到正在运行的 NDB Cluster 或访问or
文件。config.inimy.cnf
--print-defaults
命令行格式
--print-defaults
打印程序参数列表并退出。
--defaults-file
命令行格式
--defaults-file=path
类型
细绳
默认值
[none]
仅从给定文件中读取默认选项。
--defaults-extra-file
命令行格式
--defaults-extra-file=path
类型
细绳
默认值
[none]
读取全局文件后读取给定文件。
--defaults-group-suffix
命令行格式
--defaults-group-suffix=string
类型
细绳
默认值
[none]
还可以阅读带有 concat(group, suffix) 的组。
--login-path
命令行格式
--login-path=path
类型
细绳
默认值
[none]
从登录文件中读取给定路径。
--help
命令行格式
--help
显示帮助文本并退出。
--connect-string
命令行格式
--connect-string=connection_string
类型
细绳
默认值
[none]
与 相同
--ndb-connectstring。
--ndb-mgmd-host
命令行格式
--ndb-mgmd-host=connection_string
类型
细绳
默认值
[none]
与 相同
--ndb-connectstring。
--ndb-nodeid
命令行格式
--ndb-nodeid=#
删除
8.0.31
类型
整数
默认值
[none]
为此节点设置节点 ID，覆盖由 设置的任何 ID
--ndb-connectstring。
--core-file
命令行格式
--core-file
删除
8.0.31
写入核心文件出错；在调试中使用。
--character-sets-dir
命令行格式
--character-sets-dir=path
删除
8.0.31
包含字符集的目录。
--connect-retries
命令行格式
--connect-retries=#
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
类型
整数
默认值
5
最小值
0
最大值
5
尝试联系管理服务器之间等待的秒数。
--ndb-optimized-node-selection
命令行格式
--ndb-optimized-node-selection
删除
8.0.31
为交易节点的选择启用优化。默认启用；用于
--skip-ndb-optimized-node-selection禁用。
不支持将其他ndb_config选项（例如
--queryor
--type）与
--configinfo（带或不带该
--xml选项）结合使用。目前，如果您尝试这样做，通常的结果是除--configinfoor之外的所有其他选项--xml
都被忽略。但是，不能保证这种行为并随时更改. 此外，由于ndb_config与该--configinfo选项一起使用时，不会访问 NDB Cluster 或读取任何文件，因此尝试指定其他选项（例如--ndb-connectstring或
--config-filewith
--configinfo没有任何意义）。
例子
获取集群中各节点的节点ID和类型：
$> ./ndb_config --query=nodeid,type --fields=':' --rows='\n'
1:ndbd
2:ndbd
3:ndbd
4:ndbd
5:ndb_mgmd
6:mysqld
7:mysqld
8:mysqld
9:mysqld
在此示例中，我们使用
--fields选项用冒号字符 ( :) 分隔每个节点的 ID 和类型，并使用
--rows选项将每个节点的值放在输出中的新行上。
要生成可供数据、SQL 和 API 节点用于连接到管理服务器的连接字符串：
$> ./ndb_config --config-file=usr/local/mysql/cluster-data/config.ini \
--query=hostname,portnumber --fields=: --rows=, --type=ndb_mgmd
198.51.100.179:1186
此ndb_config调用仅检查数据节点（使用
--type选项），并显示每个节点的 ID 和主机名的值，以及为其
DataMemory和
DataDir参数设置的值：
$> ./ndb_config --type=ndbd --query=nodeid,host,datamemory,datadir -f ' : ' -r '\n'
1 : 198.51.100.193 : 83886080 : /usr/local/mysql/cluster-data
2 : 198.51.100.112 : 83886080 : /usr/local/mysql/cluster-data
3 : 198.51.100.176 : 83886080 : /usr/local/mysql/cluster-data
4 : 198.51.100.119 : 83886080 : /usr/local/mysql/cluster-data
在这个例子中，我们分别使用短选项
-f和-r来设置字段分隔符和行分隔符，以及短选项-q来传递要获取的参数列表。
要排除来自任何主机的结果，特别是一个主机，请使用以下--host选项：
$> ./ndb_config --host=198.51.100.176 -f : -r '\n' -q id,type
3:ndbd
5:ndb_mgmd
在这个例子中，我们也使用了缩写形式
-q来确定要查询的属性。
--nodeid
同样，您可以使用该选项
将结果限制为具有特定 ID 的节点。
© Mysql 中文网
