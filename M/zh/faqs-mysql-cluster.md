# A.10 MySQL 8.0 FAQ：NDB Cluster_MySQL 8.0 参考手册

A.10 MySQL 8.0 FAQ：NDB Cluster_MySQL 8.0 参考手册
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
A.1 MySQL 8.0 FAQ：一般
A.2 MySQL 8.0 FAQ：存储引擎
A.3 MySQL 8.0 常见问题解答：服务器 SQL 模式
A.4 MySQL 8.0 FAQ：存储过程和函数
A.5 MySQL 8.0 FAQ：触发器
A.6 MySQL 8.0 FAQ：视图
A.7 MySQL 8.0 FAQ：INFORMATION_SCHEMA
A.8 MySQL 8.0 FAQ：迁移
A.9 MySQL 8.0 FAQ：安全
A.10 MySQL 8.0 FAQ：NDB Cluster
A.11 MySQL 8.0 FAQ：MySQL 中日韩字符集
A.12 MySQL 8.0 常见问题解答：连接器和 API
A.13 MySQL 8.0 常见问题解答：C API、libmysql
A.14 MySQL 8.0 FAQ：复制
A.15 MySQL 8.0 FAQ：MySQL 企业级线程池
A.16 MySQL 8.0 FAQ：InnoDB Change Buffer
A.17 MySQL 8.0 FAQ：InnoDB 静态数据加密
A.18 MySQL 8.0 FAQ：虚拟化支持
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 附录 A MySQL 8.0 常见问题解答  /
A.10 MySQL 8.0 FAQ：NDB Cluster
A.10 MySQL 8.0 FAQ：NDB Cluster
在下一节中，我们将回答有关 MySQL NDB Cluster 和
NDB存储引擎的常见问题。
A.10.1.
哪些版本的 MySQL 软件支持 NDB Cluster？我必须从源代码编译吗？
A.10.2.
“NDB”和“NDBCLUSTER”是什么意思？
A.10.3.
使用 NDB Cluster 与使用 MySQL Replication 有什么区别？
A.10.4.
我需要任何特殊的网络来运行 NDB Cluster 吗？集群中的计算机如何通信？
A.10.5。
我需要多少台计算机来运行 NDB Cluster，为什么？
A.10.6.
NDB Cluster 中的不同计算机做什么？
A.10.7。
当我在 NDB Cluster 管理客户端中运行 SHOW 命令时，我看到一行输出如下所示：
A.10.8。
我可以在哪些操作系统上使用 NDB Cluster？
A.10.9.
运行 NDB Cluster 的硬件要求是什么？
A.10.10。
使用 NDB Cluster 需要多少 RAM？是否可以使用磁盘内存？
A.10.11。
NDB Cluster 可以使用哪些文件系统？网络文件系统或网络共享呢？
A.10.12。
我可以在虚拟机（例如由 VMWare、VirtualBox、Parallels 或 Xen 创建的虚拟机）中运行 NDB Cluster 节点吗？
A.10.13。
我正在尝试填充 NDB Cluster 数据库。加载过程提前终止，我收到如下错误消息：
A.10.14。
NDB Cluster 使用 TCP/IP。这是否意味着我可以在 Internet 上运行它，一个或多个节点位于远程位置？
A.10.15。
我是否必须学习一种新的编程或查询语言才能使用 NDB Cluster？
A.10.16.
NDB Cluster 支持哪些编程语言和 API？
A.10.17.
NDB Cluster 是否包含任何管理工具？
A.10.18。
使用 NDB Cluster 时如何找出错误或警告消息的含义？
A.10.19.
NDB Cluster 事务安全吗？支持哪些隔离级别？
A.10.20。
NDB Cluster 支持哪些存储引擎？
A.10.21。
如果发生灾难性故障——例如，整个城市停电，我的 UPS 出现故障——我会丢失所有数据吗？
A.10.22。
是否可以将 FULLTEXT 索引与 NDB Cluster 一起使用？
A.10.23。
我可以在一台计算机上运行多个节点吗？
A.10.24。
我可以在不重新启动 NDB Cluster 的情况下将数据节点添加到它吗？
A.10.25。
使用 NDB Cluster 时，我应该注意哪些限制？
A.10.26.
NDB Cluster 是否支持外键？
A.10.27。
如何将现有的 MySQL 数据库导入 NDB Cluster？
A.10.28。
NDB Cluster 节点如何相互通信？
A.10.29。
什么是仲裁员？
A.10.30。
NDB Cluster 支持哪些数据类型？
A.10.31。
如何启动和停止 NDB Cluster？
A.10.32。
NDB Cluster 关闭时 NDB Cluster 数据会发生什么情况？
A.10.33。
NDB Cluster 有多个管理节点是个好主意吗？
A.10.34。
我可以在一个 NDB Cluster 中混合使用不同类型的硬件和操作系统吗？
A.10.35。
我可以在一台主机上运行两个数据节点吗？两个 SQL 节点？
A.10.36.
我可以在 NDB Cluster 中使用主机名吗？
A.10.37。
NDB Cluster 是否支持 IPv6？
A.10.38。
如何处理具有多个 MySQL 服务器的 NDB Cluster 中的 MySQL 用户？
A.10.39。
如果其中一个 SQL 节点发生故障，我如何继续发送查询？
A.10.40。
如何备份和恢复 NDB Cluster？
A.10.41。
什么是“天使流程”？
A.10.1.
哪些版本的 MySQL 软件支持 NDB Cluster？我必须从源代码编译吗？
标准 MySQL Server 8.0 版本不支持 NDB Cluster。相反，MySQL NDB Cluster 作为单独的产品提供。可用的 NDB Cluster 发布系列包括以下内容：
NDB 集群 7.2。
该系列不再支持新部署或维护。NDB Cluster 7.2 的用户应该尽快升级到更新的版本系列。我们建议新部署使用最新的 NDB Cluster 8.0 版本。
NDB 集群 7.3。
本系列是 NDB Cluster 之前的一般可用性 (GA) 版本，仍可用于生产，但我们建议新部署使用最新的 NDB Cluster 8.0 版本。可以从
https://mysql.net.cn/downloads/cluster/获得最新的 NDB Cluster 7.3 版本。
NDB 集群 7.4。
本系列是 NDB Cluster 之前的一般可用性 (GA) 版本，仍可用于生产，但我们建议新部署使用最新的 NDB Cluster 8.0 版本。可以从
https://mysql.net.cn/downloads/cluster/获得最新的 NDB Cluster 7.4 版本。
NDB 集群 7.5。
本系列是 NDB Cluster 之前的一般可用性 (GA) 版本，仍可用于生产，但我们建议新部署使用最新的 NDB Cluster 7.6 版本。可以从
https://mysql.net.cn/downloads/cluster/获得最新的 NDB Cluster 7.5 版本。
NDB 集群 7.6。
本系列是 NDB Cluster 之前的一般可用性 (GA) 版本，仍可用于生产，但我们建议新部署使用最新的 NDB Cluster 8.0 版本。可以从
https://mysql.net.cn/downloads/cluster/获得最新的 NDB Cluster 7.6 版本。
NDB 集群 8.0。
本系列是 NDB Cluster 的最新通用版 (GA)，基于
NDB存储引擎 8.0 版和 MySQL Server 8.0。NDB Cluster 8.0 可用于生产；用于生产的新部署应该使用本系列中最新的 GA 版本，目前是 NDB Cluster 8.0.32。您可以从https://mysql.net.cn/downloads/cluster/获取最新的 NDB Cluster 8.0 版本
。有关本系列中的新功能和其他重要更改的信息，请参阅
第 23.2.4 节，“NDB Cluster 中的新功能”。
您可以从源代码获取和编译 NDB Cluster（请参阅
第 23.3.1.4 节，“在 Linux 上从源代码构建 NDB Cluster”和
第 23.3.2.2 节，“在 Windows 上从源代码编译和安装 NDB Cluster”），但除了在大多数特殊情况下，我们建议使用 Oracle 提供的适合您的操作平台和环境的以下安装程序之一：
Linux
二进制版本（tar.gz文件）
Linux RPM 包
文件
.deb
_
Windows
二进制
“免安装”版本
Windows MSI 安装程序
安装包也可以从您平台的包管理系统获得。
NDB您可以使用以下语句之一SHOW VARIABLES LIKE 'have_%'来
确定您的 MySQL 服务器是否
SHOW ENGINES支持
SHOW PLUGINS。
A.10.2.“ NDB ”和“ NDBCLUSTER ”是
什么意思？
“ NDB ”代表
“网络数据库
”。
_ _ _ _ NDB并且NDBCLUSTER都是支持 MySQL 集群支持的存储引擎的名称。NDB是首选，但任何一个名称都是正确的。
A.10.3.
使用 NDB Cluster 与使用 MySQL Replication 有什么区别？
在传统的 MySQL 复制中，源 MySQL 服务器更新一个或多个副本。事务按顺序提交，缓慢的事务会导致副本滞后于源。这意味着如果源发生故障，副本可能没有记录最后几笔交易。如果事务安全的引擎如
InnoDB正在使用时，事务要么在副本上完成，要么根本不应用，但复制并不能保证源和副本上的所有数据始终保持一致。在 NDB Cluster 中，所有数据节点保持同步，任何一个数据节点提交的事务都会为所有数据节点提交。在数据节点发生故障的情况下，所有剩余的数据节点都保持一致的状态。
简而言之，标准的 MySQL 复制是
异步的，而 NDB Cluster 是同步的。
NDB Cluster 中也提供异步复制。
NDB Cluster 复制
（有时也称为“ geo-replication ”）包括在两个 NDB 集群之间以及从 NDB 集群复制到非集群 MySQL 服务器的能力。请参阅第 23.7 节，“NDB Cluster 复制”。
A.10.4.
我需要任何特殊的网络来运行 NDB Cluster 吗？集群中的计算机如何通信？
NDB Cluster 旨在用于高带宽环境，计算机使用 TCP/IP 进行连接。它的性能直接取决于集群计算机之间的连接速度。NDB Cluster 的最低连接要求包括一个典型的 100 兆位以太网网络或等效网络。我们建议您尽可能使用千兆以太网。
A.10.5。
我需要多少台计算机来运行 NDB Cluster，为什么？
运行一个可行的集群至少需要三台计算机。但是，NDB Cluster 中推荐的最小
计算机数量是四台：每台运行管理和 SQL 节点，两台计算机用作数据节点。两个数据节点的目的是提供冗余；管理节点必须在单独的机器上运行，以保证在其中一个数据节点出现故障时继续提供仲裁服务。
为了提供更高的吞吐量和高可用性，您应该使用多个 SQL 节点（连接到集群的 MySQL 服务器）。也可以（尽管不是绝对必要）运行多个管理服务器。
A.10.6.
NDB Cluster 中的不同计算机做什么？
NDB Cluster 具有物理和逻辑组织，计算机是物理元素。集群的逻辑或功能元素称为
节点，而容纳集群节点的计算机有时称为
集群主机。共有三种类型的节点，每种节点对应于集群中的特定角色。这些是：
管理节点。
该节点为整个集群提供管理服务，包括启动、关闭、备份和其他节点的配置数据。管理节点服务器实现为应用程序
ndb_mgmd；用于控制 NDB Cluster 的管理客户端是ndb_mgm。有关这些程序的信息，请参阅
第 23.5.4 节，“ndb_mgmd - NDB Cluster Management Server Daemon”和
第 23.5.5 节，“ndb_mgm - The NDB Cluster Management Client”。
数据节点。
这种类型的节点存储和复制数据。数据节点功能由
NDB数据节点进程
ndbd的实例处理。有关更多信息，请参阅
第 23.5.1 节，“ndbd — NDB Cluster 数据节点守护程序”。
SQL 节点。
这只是 MySQL 服务器 ( mysqld ) 的一个实例，它是在支持NDBCLUSTER存储引擎的情况下构建的，并--ndb-cluster以启用该引擎的
--ndb-connectstring选项和使其能够连接到 NDB Cluster 管理服务器的选项开始。有关这些选项的更多信息，请参阅
第 23.4.3.9.1 节，“NDB Cluster 的 MySQL 服务器选项”。
笔记
API 节点是直接使用集群数据节点进行数据存储和检索的任何应用程序
。因此，SQL 节点可以被认为是一种 API 节点，它使用 MySQL 服务器为集群提供 SQL 接口。您可以使用 NDB API 编写此类应用程序（不依赖于 MySQL 服务器），它为 NDB Cluster 数据提供直接的、面向对象的事务和扫描接口；有关详细信息，请参阅NDB Cluster API 概述：NDB API。
A.10.7。
当我SHOW在 NDB Cluster 管理客户端中运行该命令时，我看到一行输出如下所示：
id=2    @10.100.10.32  (Version: 8.0.32-ndb-8.0.32 Nodegroup: 0, *)
什么*意思？这个节点与其他节点有何不同？
最简单的回答是，“这不是你可以控制的，在任何情况下你都不需要担心，除非你是一个编写或分析 NDB Cluster 源代码的软件工程师”。
如果您对该答案不满意，这里有一个更长、更技术性的版本：
NDB Cluster 中的许多机制需要数据节点之间的分布式协调。这些分布式算法和协议包括全局检查点、DDL（模式）更改和节点重启处理。为了使这种协调更简单，数据节点“选出”它们中的一个作为领导者。没有影响此选择的面向用户的机制，它是完全自动的；它是自动的这一事实是 NDB Cluster 内部架构的关键部分。
当一个节点充当任何这些机制的“领导者”时，它通常是活动的协调点，而其他节点充当“追随者”，按照领导者的指示执行他们的部分活动。如果充当领导者的节点发生故障，则其余节点将选举新的领导者。由旧领导者协调的正在进行的任务可能会失败或由新领导者继续，这取决于所涉及的实际机制。
这些不同的机制和协议中的一些可能具有不同的领导节点，但通常会为所有这些机制和协议选择相同的领导者。在管理客户端的输出中指示为领导者的节点在SHOW
内部称为
DICT管理器，负责协调 DDL 和元数据活动。
NDB Cluster 的设计方式使得领导者的选择在集群本身之外没有明显的影响。例如，当前领导者的 CPU 或资源使用率并没有明显高于其他数据节点，领导者的故障与任何其他数据节点的故障对集群的影响不应该有显着不同。
A.10.8。
我可以在哪些操作系统上使用 NDB Cluster？
大多数类 Unix 操作系统都支持 NDB Cluster。Microsoft Windows 操作系统的生产设置也支持 NDB Cluster。
有关在各种操作系统版本、操作系统发行版和硬件平台上为 NDB Cluster 提供的支持级别的更多详细信息，请参阅
https://www.mysql.com/support/supportedplatforms/cluster.html。
A.10.9.
运行 NDB Cluster 的硬件要求是什么？
NDB Cluster 应该在任何支持
NDB-enabled 二进制文件的平台上运行。对于数据节点和 API 节点，更快的 CPU 和更多的内存可能会提高性能，而 64 位 CPU 可能比 32 位处理器更有效。用于数据节点的机器上必须有足够的内存来容纳每个节点的数据库份额（请参阅我需要多少内存？了解更多信息）。对于仅用于运行 NDB Cluster 管理服务器的计算机，要求最低；一台普通的台式 PC（或同等设备）通常足以完成此任务。节点可以通过标准的 TCP/IP 网络和硬件进行通信。他们也可以使用高速SCI协议；但是，需要特殊的网络硬件和软件才能使用 SCI（请参阅
第 23.4.4 节，“使用 NDB Cluster 的高速互连”）。
A.10.10。
使用 NDB Cluster 需要多少 RAM？是否可以使用磁盘内存？
NDB Cluster 最初仅作为内存实现，但当前可用的所有版本也提供了将 NDB Cluster 存储在磁盘上的能力。有关更多信息，请参阅
第 23.6.10 节，“NDB Cluster 磁盘数据表”。
对于内存NDB表，您可以使用以下公式粗略估计集群中每个数据节点需要多少 RAM：
(SizeofDatabase × NumberOfReplicas × 1.1 ) / NumberOfDataNodes
要更准确地计算内存需求，需要为集群数据库中的每个表确定每行所需的存储空间（有关详细信息，请参见
第 11.7 节，“数据类型存储需求”），并将其乘以行数。您还必须记住按如下方式考虑任何列索引：
为表创建的每个主键或散列索引
NDBCLUSTER每条记录需要 21-25 个字节。这些索引使用
IndexMemory.
每个有序索引每条记录需要 10 个字节的存储空间，使用DataMemory.
创建主键或唯一索引也会创建有序索引，除非此索引是使用
USING HASH. 换句话说：
Cluster 表上的主键或唯一索引通常每条记录占用 31 到 35 个字节。
但是，如果使用创建主键或唯一索引USING HASH，则每条记录只需要 21 到 25 个字节。
使用所有主键和唯一索引创建 NDB Cluster 表USING HASH
通常会导致表更新运行得更快——在某些情况下，比USING
HASH未用于创建主键和唯一键的表的更新快 20% 到 30%。这是因为需要更少的内存（因为没有创建有序索引），并且必须使用更少的 CPU（因为必须读取和可能更新的索引更少）。但是，这也意味着必须通过其他方式来满足本来可以使用范围扫描的查询，这可能会导致选择速度变慢。
在计算集群内存需求时，您可能会发现最近的 MySQL 8.0 版本中可用的ndb_size.pl实用程序很有用。NDBCLUSTER此 Perl 脚本连接到当前（非集群）MySQL 数据库，并创建一个报告，说明该数据库在使用存储引擎时需要多少空间。有关更多信息，请参阅
第 23.5.28 节，“ndb_size.pl — NDBCLUSTER 大小需求估计器”。
特别重要的是要记住每个 NDB Cluster 表都必须有一个主键。NDB如果没有定义，存储引擎会自动创建一个主键；
这个主键是在没有创建的情况下创建的USING HASH。
您可以使用ndb_mgmREPORT MEMORYUSAGE客户端中的命令
确定在任何给定时间有多少内存用于存储 NDB Cluster 数据和索引
；有关更多信息，请参阅
第 23.6.1 节，“NDB Cluster Management Client 中的命令”。此外，当 80% 的可用资源
或（在 NDB 7.6 之前）正在使用时，以及当使用率达到 90%、99% 和 100% 时，警告将写入集群日志。
DataMemoryIndexMemoryA.10.11。
NDB Cluster 可以使用哪些文件系统？网络文件系统或网络共享呢？
通常，主机操作系统本机的任何文件系统都应该与 NDB Cluster 一起工作。如果您发现给定的文件系统与 NDB Cluster 一起工作得特别好（或不是特别好），我们邀请您在NDB Cluster 论坛中讨论您的发现。
对于 Windows，我们建议您NTFS
对 NDB Cluster 使用文件系统，就像我们对标准 MySQL 所做的那样。我们不使用FAT或
VFAT文件系统测试 NDB Cluster。因此，我们不建议将它们与 MySQL 或 NDB Cluster 一起使用。
NDB Cluster 是作为无共享解决方案实现的；这背后的想法是，单个硬件的故障不应导致多个集群节点的故障，甚至可能导致整个集群的故障。因此，NDB Cluster 不支持使用网络共享或网络文件系统。这也适用于 SAN 等共享存储设备。
A.10.12。
我可以在虚拟机（例如由 VMWare、VirtualBox、Parallels 或 Xen 创建的虚拟机）中运行 NDB Cluster 节点吗？
NDB Cluster 支持在虚拟机中使用。我们目前支持并测试使用
Oracle VM。
一些 NDB Cluster 用户已经使用其他虚拟化产品成功部署了 NDB Cluster；在这种情况下，Oracle 可以提供 NDB Cluster 支持，但特定于虚拟环境的问题必须咨询该产品的供应商。
A.10.13。
我正在尝试填充 NDB Cluster 数据库。加载过程提前终止，我收到如下错误消息：
ERROR 1114: The table 'my_cluster_table' is
full
为什么会这样？
原因很可能是您的设置没有为所有表数据和所有索引提供足够的 RAM，
包括存储引擎所需的主键，
NDB以及在表定义不包含主键定义的情况下自动创建的主键关键。
还值得注意的是，所有数据节点都应具有相同数量的 RAM，因为集群中的任何数据节点都不能使用比任何单个数据节点可用的最小内存量更多的内存。例如，如果有四台计算机托管 Cluster 数据节点，其中三台有 3GB 的 RAM 可用于存储 Cluster 数据，而其余数据节点只有 1GB RAM，那么每个数据节点最多可以将 1GB 用于 NDB Cluster 数据和指标。
在某些情况下，即使当ndb_mgm -e "ALL REPORT MEMORYUSAGE"显示大量空闲
时，也可能在 MySQL 客户端应用程序中出现
Table is full错误。您可以强制为 NDB Cluster 表创建额外的分区，从而通过使用
选项为
哈希索引提供更多内存。通常，设置
为您希望在表中存储的行数的两倍就足够了。
DataMemoryNDBMAX_ROWSCREATE TABLEMAX_ROWS
出于类似的原因，您有时也会遇到数据节点在数据负载过重的节点上重启的问题。该MinFreePct
参数可以通过保留一部分（默认为 5%）DataMemory
和（在 NDB 7.6 之前）
IndexMemory用于重新启动来帮助解决此问题。此保留内存不可用于存储
NDB表格或数据。
A.10.14。
NDB Cluster 使用 TCP/IP。这是否意味着我可以在 Internet 上运行它，一个或多个节点位于远程位置？
在这种情况下，集群不太可能可靠地运行，因为 NDB Cluster 的设计和实现是假设它将在保证专用高速连接的条件下运行，例如在使用 100 Mbps 或千兆位的 LAN 设置中找到的连接以太网——最好是后者。我们既不使用比这更慢的任何东西来测试也不保证其性能。
此外，记住 NDB Cluster 中节点之间的通信是不安全的是非常重要的；它们既没有加密也没有受到任何其他保护机制的保护。集群最安全的配置是在防火墙后面的专用网络中，无法从外部直接访问任何集群数据或管理节点。（对于 SQL 节点，您应该采取与任何其他 MySQL 服务器实例相同的预防措施。）有关更多信息，请参阅第 23.6.19 节，“NDB Cluster 安全问题”。
A.10.15。
我是否必须学习一种新的编程或查询语言才能使用 NDB Cluster？
不。虽然一些专门的命令用于管理和配置集群本身，但以下操作只需要标准 (My)SQL 语句：
创建、更改和删除表
插入、更新和删除表数据
创建、更改和删除主索引和唯一索引
设置 NDB Cluster 需要一些专门的配置参数和文件——
有关这些的信息，
请参阅第 23.4.3 节，“NDB Cluster 配置文件” 。NDB Cluster 管理客户端 ( ndb_mgm )
中使用了一些简单的命令来执行诸如启动和停止集群节点之类的任务。请参阅
第 23.6.1 节，“NDB Cluster Management Client 中的命令”。
A.10.16.
NDB Cluster 支持哪些编程语言和 API？
NDB Cluster 支持与标准 MySQL 服务器相同的编程 API 和语言，包括 ODBC、.Net、MySQL C API 以及流行脚本语言（如 PHP、Perl 和 Python）的众多驱动程序。使用这些 API 编写的 NDB Cluster 应用程序的行为与其他 MySQL 应用程序类似；它们将 SQL 语句传输到 MySQL 服务器（在 NDB Cluster 的情况下，是一个 SQL 节点），并接收包含数据行的响应。有关这些 API 的更多信息，请参阅
第 29 章，连接器和 API。
NDB Cluster 还支持使用 NDB API 进行应用程序编程，它为 NDB Cluster 数据提供了一个低级 C++ 接口，而无需通过 MySQL 服务器。请参阅
导航台 API。此外，
NDBCLUSTERC语言的MGM API暴露了很多管理功能；有关更多信息，
请参阅
MGM API 。
NDB Cluster 还支持使用 ClusterJ 进行 Java 应用程序编程，它支持使用会话和事务的数据域对象模型。有关更多信息，请参阅
Java 和 NDB Cluster。
此外，NDB Cluster 提供了对 的支持
memcached，允许开发人员使用接口访问存储在 NDB Cluster 中的memcached
数据；有关详细信息，请参阅
ndbmemcache—NDB Cluster 的 Memcache API（不再支持）。
NDB Cluster 还包括支持针对 编写的 NoSQL 应用程序的适配器Node.js，其中 NDB Cluster 作为数据存储。有关更多信息，
请参阅适用于 JavaScript 的 MySQL NoSQL 连接器。A.10.17.
NDB Cluster 是否包含任何管理工具？
NDB Cluster 包括一个用于执行基本管理功能的命令行客户端。请参阅
第 23.5.5 节，“ndb_mgm - NDB Cluster Management Client”和
第 23.6.1 节，“NDB Cluster Management Client 中的命令”。
MySQL Cluster Manager 也支持 NDB Cluster 7.6 及更早版本，这是一个单独的产品，提供了一个高级命令行界面，可以自动执行许多 NDB Cluster 管理任务，例如滚动重启和配置更改。从 1.4.8 版本开始，MySQL Cluster Manager 还提供了对 NDB Cluster 8.0 的实验性支持。有关 MySQL Cluster Manager 的更多信息，请参阅
MySQL Cluster Manager 1.4.8 用户手册。
A.10.18。
使用 NDB Cluster 时如何找出错误或警告消息的含义？
有两种方法可以做到这一点：
在mysql客户端中，在收到错误或警告条件通知后立即
使用
SHOW ERRORS或SHOW WARNINGS 。
在系统 shell 提示符下，使用perror --ndb
error_code。
A.10.19.
NDB Cluster 事务安全吗？支持哪些隔离级别？
是的。对于使用
NDB存储引擎创建的表，支持事务。目前，NDB Cluster 仅支持
READ COMMITTED事务隔离级别。
A.10.20。
NDB Cluster 支持哪些存储引擎？
NDB Cluster 需要NDB
存储引擎。也就是说，为了在 NDB Cluster 中的节点之间共享表，必须使用
ENGINE=NDB（或等效选项
ENGINE=NDBCLUSTER）创建表。
可以在与 NDB Cluster 一起使用的 MySQL 服务器上使用其他存储引擎（例如InnoDB或
MyISAM）创建表，但由于这些表不使用
NDB，因此它们不参与集群；每个这样的表对于创建它的单个 MySQL 服务器实例都是严格本地的。
InnoDBNDB Cluster在体系结构、要求和实现方面与
集群有很大不同
；尽管他们的名字有任何相似之处，但两者并不兼容。有关InnoDB集群的更多信息，请参阅
MySQL AdminAPI。另请参阅
第 23.2.6 节，“使用 InnoDB 的 MySQL 服务器与 NDB Cluster 相比”NDB ，以获取有关存储引擎和
InnoDB存储引擎
之间差异的信息。A.10.21。
如果发生灾难性故障——例如，整个城市停电，我的 UPS 出现故障——我会丢失所有数据吗？
记录所有提交的事务。因此，虽然在发生灾难时可能会丢失一些数据，但这应该是非常有限的。通过最小化每个事务的操作数，可以进一步减少数据丢失。（在任何情况下，每个事务执行大量操作都不是一个好主意。）
A.10.22。FULLTEXT是否可以在NDB Cluster
中使用索引？
FULLTEXT目前只有InnoDB和
MyISAM存储引擎支持索引。有关更多信息，请参阅
第 12.10 节，“全文搜索功能”。
A.10.23。
我可以在一台计算机上运行多个节点吗？
这是可能的，但并不总是可取的。运行集群的主要原因之一是提供冗余。为了获得这种冗余的全部好处，每个节点都应该驻留在单独的机器上。如果您将多个节点放在一台机器上，而那台机器发生故障，您将失去所有这些节点。出于这个原因，如果您确实在一台机器上运行多个数据节点，那么以这样一种方式设置它们非常重要，即这台机器的故障不会导致给定节点组中所有数据节点的丢失.
鉴于 NDB Cluster 可以在装有低成本（甚至免费）操作系统的商品硬件上运行，为了保护关键任务数据，额外增加一两台机器的费用是非常值得的。还值得注意的是，对运行管理节点的集群主机的要求是最低的。可以使用 300 MHz 奔腾或等效 CPU 和足够的操作系统 RAM 以及ndb_mgmd
和ndb_mgm进程
的少量开销来完成此任务。
在具有多个 CPU、内核或两者的单个主机上运行多个集群数据节点是可以接受的。NDB Cluster 发行版还提供了一个多线程版本的数据节点二进制文件，旨在用于此类系统。有关更多信息，请参阅
第 23.5.3 节，“ndbmtd — NDB Cluster 数据节点守护进程（多线程）”。
在某些情况下也可以在同一台机器上同时运行数据节点和 SQL 节点；这种安排的执行情况取决于许多因素，例如内核和 CPU 的数量以及数据节点和 SQL 节点进程可用的磁盘和内存量，在规划此类安排时必须考虑这些因素一个配置。
A.10.24。
我可以在不重新启动 NDB Cluster 的情况下将数据节点添加到它吗？
可以在不使集群脱机的情况下将新数据节点添加到正在运行的 NDB Cluster。有关更多信息，请参阅
第 23.6.7 节，“在线添加 NDB Cluster 数据节点”。
对于其他类型的 NDB Cluster 节点，只需要滚动重启（请参阅
第 23.6.5 节，“执行 NDB Cluster 的滚动重启”）。
A.10.25。
使用 NDB Cluster 时，我应该注意哪些限制？
NDBMySQL NDB Cluster 中表的
限制包括以下内容：
不支持临时表；使用或
因错误而失败
的
CREATE
TEMPORARY TABLE语句
。ENGINE=NDBENGINE=NDBCLUSTER
表唯一支持的用户定义分区类型
NDBCLUSTER是
KEY和LINEAR KEY。尝试NDB使用任何其他分区类型创建表失败并出现错误。
FULLTEXT不支持索引。
不支持索引前缀。只能索引完整的列。
不支持空间索引（尽管可以使用空间列）。请参阅第 11.4 节，“空间数据类型”。
对部分事务和部分回滚的支持与其他事务存储引擎的支持相当，例如InnoDB可以回滚单个语句。
每个表允许的最大属性数为 512。属性名称不能超过 31 个字符。对于每个表，表名和数据库名的最大组合长度为 122 个字符。
在 NDB 8.0 之前，表行的最大大小为 14 KB，不包括BLOB
值。在 NDB 8.0 中，此最大值增加到 30000 字节。有关更多信息，请参阅
第 23.2.7.5 节，“与 NDB Cluster 中的数据库对象相关的限制”。
每个
NDB表的行数没有设置限制。表大小的限制取决于许多因素，特别是每个数据节点可用的 RAM 量。
有关 NDB Cluster 中限制的完整列表，请参阅
第 23.2.7 节，“NDB Cluster 的已知限制”。另请参阅
第 23.2.7.11 节，“NDB Cluster 8.0 中已解决的先前 NDB Cluster 问题”。
A.10.26.
NDB Cluster 是否支持外键？
NDB Cluster 提供对外键约束的支持，这与
InnoDB存储引擎中的外键约束相当；有关更多详细信息，请参阅
第 1.7.3.2 节，“外键约束”，以及
第 13.1.20.5 节，“外键约束”。需要外键支持的应用程序应该使用 NDB Cluster 7.3、7.4、7.5 或更高版本。
A.10.27。
如何将现有的 MySQL 数据库导入 NDB Cluster？
您可以像使用任何其他版本的 MySQL 一样将数据库导入 NDB Cluster。除了本 FAQ 中其他地方提到的限制之外，唯一的其他特殊要求是要包含在集群中的任何表都必须使用
NDB存储引擎。这意味着必须使用ENGINE=NDB或
创建表ENGINE=NDBCLUSTER。
也可以将使用其他存储引擎的现有表转换为NDBCLUSTER使用一个或多个ALTER TABLE
语句。NDBCLUSTER
但是，在进行转换之前，表的定义必须与存储引擎兼容。在 MySQL 8.0 中，还需要一个额外的解决方法；有关详细信息，请参阅
第 23.2.7 节，“NDB Cluster 的已知限制”。
A.10.28。
NDB Cluster 节点如何相互通信？
集群节点可以通过三种不同的传输机制中的任何一种进行通信：TCP/IP、SHM（共享内存）和 SCI（可伸缩一致性接口）。在可用的情况下，默认情况下在驻留在同一集群主机上的节点之间使用 SHM；然而，这被认为是实验性的。SCI 是一种高速（每秒 1 GB 或更高）、高可用性协议，用于构建可扩展的多处理器系统；它需要特殊的硬件和驱动程序。有关使用 SCI 作为 NDB Cluster 的传输机制的更多信息，
请参阅
第 23.4.4 节，“使用 NDB Cluster 的高速互连” 。A.10.29。
什么是仲裁员？
如果集群中的一个或多个数据节点发生故障，则可能并非所有集群数据节点都能够“看到”彼此。事实上，在网络分区中，两组数据节点可能会彼此隔离，也称为“裂脑”
场景。这种情况是不可取的，因为每组数据节点都试图表现得好像它是整个集群。仲裁员需要在竞争的数据节点集之间做出决定。
当至少一个节点组中的所有数据节点都处于活动状态时，网络分区就不是问题，因为集群的任何一个子集都不能单独形成一个功能集群。当没有单个节点组的所有节点都处于活动状态时，就会出现真正的问题，在这种情况下，网络分区（
“裂脑”情景）成为可能。然后需要仲裁员。所有集群节点都将同一个节点识别为仲裁器，通常是管理服务器；但是，可以将集群中的任何 MySQL 服务器配置为充当仲裁器。仲裁器接受第一组集群节点与其联系，并通知其余组关闭。仲裁者的选择由ArbitrationRank
MySQL 服务器和管理服务器节点的配置参数控制。您还可以使用ArbitrationRank
配置参数来控制仲裁员选择过程。有关这些参数的更多信息，请参阅
第 23.4.3.5 节，“定义 NDB Cluster 管理服务器”.
仲裁者的角色本身并没有对如此指定的主机强加任何繁重的要求，因此仲裁者主机不需要特别快或特别为此目的具有额外的内存。
A.10.30。
NDB Cluster 支持哪些数据类型？
NDB Cluster 支持所有常用的 MySQL 数据类型，包括与 MySQL 空间扩展相关的数据类型；但是，NDB存储引擎不支持空间索引。（只有 支持空间索引MyISAM；有关更多信息，请参见
第 11.4 节，“空间数据类型”。）此外，与NDB表一起使用时，索引也有一些差异。
笔记
NDB Cluster 磁盘数据表（即，使用
TABLESPACE ... STORAGE DISK ENGINE=NDB或
创建的表TABLESPACE ... STORAGE DISK
ENGINE=NDBCLUSTER）只有固定宽度的行。这意味着（例如）每个包含
VARCHAR(255)
列的磁盘数据表记录需要 255 个字符的空间（根据用于表的字符集和排序规则的要求），而不管其中存储的实际字符数。
有关这些问题的更多信息，
请参阅第 23.2.7 节，“NDB Cluster 的已知限制” 。A.10.31。
如何启动和停止 NDB Cluster？
需要分别启动集群中的每个节点，顺序如下：
使用ndb_mgmd命令
启动管理节点
。
您必须包含
-f
或--config-file选项来告诉管理节点在哪里可以找到它的配置文件。
使用ndbd
命令
启动每个数据节点。
每个数据节点必须以
-c
或--ndb-connectstring选项启动，以便数据节点知道如何连接到管理服务器。
使用您首选的启动脚本启动每个 MySQL 服务器（SQL 节点），例如mysqld_safe。
每个 MySQL 服务器必须使用
--ndbcluster和
--ndb-connectstring选项启动。这些选项导致mysqld启用
NDBCLUSTER存储引擎支持以及如何连接到管理服务器。
这些命令中的每一个都必须从装有受影响节点的机器上的系统 shell 运行。（您不必亲自到机器旁——远程登录 shell 可用于此目的。）您可以通过在装有管理节点的机器上启动NDB
管理客户端ndb_mgm并发出
SHOWor来验证集群是否正在运行ALL STATUS
命令。
要关闭正在运行的集群，请
SHUTDOWN在管理客户端中发出命令。或者，您可以在系统 shell 中输入以下命令：
$> ndb_mgm -e "SHUTDOWN"
（此示例中的引号是可选的，因为
-e选项后面的命令字符串中没有空格；此外，该
SHUTDOWN命令与其他管理客户端命令一样，不区分大小写。）
这些命令中的任何一个都会导致ndb_mgm、
ndb_mgm和任何ndbd
进程正常终止。可以使用mysqladmin shutdown停止作为 SQL 节点运行的 MySQL 服务器。
有关更多信息，请参阅
第 23.6.1 节，“NDB Cluster 管理客户端中的命令”和
第 23.3.6 节，“NDB Cluster 的安全关闭和重启”。
MySQL Cluster Manager 提供了额外的方法来处理 NDB Cluster 节点的启动和停止。有关此工具的更多信息，
请参阅MySQL Cluster Manager 1.4.8 用户手册。A.10.32。
NDB Cluster 关闭时 NDB Cluster 数据会发生什么情况？
集群数据节点保存在内存中的数据被写入磁盘，并在集群下次启动时重新加载到内存中。
A.10.33。
NDB Cluster 有多个管理节点是个好主意吗？
它可以用作故障安全装置。在任何给定时间只有一个管理节点控制集群，但可以将一个管理节点配置为主管理节点，并在主管理节点发生故障时接管一个或多个附加管理节点。
有关如何配置 NDB Cluster 管理节点的信息，
请参阅第 23.4.3 节，“NDB Cluster 配置文件” 。A.10.34。
我可以在一个 NDB Cluster 中混合使用不同类型的硬件和操作系统吗？
是的，只要所有机器和操作系统都具有相同的
“字节顺序”（都是大端或小端）。
也可以在不同节点上使用来自不同 NDB Cluster 版本的软件。但是，我们仅支持将这种使用作为滚动升级过程的一部分（请参阅
第 23.6.5 节，“执行 NDB Cluster 的滚动重启”）。
A.10.35。
我可以在一台主机上运行两个数据节点吗？两个 SQL 节点？
是的，可以这样做。在多个数据节点的情况下，建议（但不是必需）每个节点使用不同的数据目录。如果要在一台机器上运行多个 SQL 节点，mysqld的每个实例都必须使用不同的 TCP/IP 端口。
可以在同一台主机上同时运行数据节点和 SQL 节点，但您应该知道
ndbd或ndbmtd进程可能会与mysqld竞争内存。
A.10.36.
我可以在 NDB Cluster 中使用主机名吗？
是的，可以为集群主机使用 DNS 和 DHCP。但是，如果您的应用程序需要“五个九”的
可用性，您应该使用固定（数字）IP 地址，因为依赖于 DNS 和 DHCP 等服务的集群主机之间的通信会引入额外的潜在故障点。
A.10.37。
NDB Cluster 是否支持 IPv6？
SQL 节点（MySQL 服务器）之间的连接支持 IPv6，但所有其他类型的 NDB Cluster 节点之间的连接必须使用 IPv4。
实际上，这意味着您可以使用 IPv6 在 NDB Cluster 之间进行复制，但同一 NDB Cluster 中的节点之间的连接必须使用 IPv4。有关更多信息，请参阅
第 23.7.3 节，“NDB Cluster 复制中的已知问题”。
A.10.38。
如何处理具有多个 MySQL 服务器的 NDB Cluster 中的 MySQL 用户？
MySQL 用户帐户和权限通常不会在访问同一 NDB Cluster 的不同 MySQL 服务器之间自动传播。MySQL NDB Cluster 提供对共享和同步用户以及使用权限的NDB_STORED_USER权限的支持；有关详细信息，请参阅使用共享授权表的分布式权限。您应该知道，此实现是 NDB 8.0 的新实现，并且与 NDB Cluster 早期版本中采用的共享权限机制不兼容，NDB 8.0 不再支持该机制。
A.10.39。
如果其中一个 SQL 节点发生故障，我如何继续发送查询？
MySQL NDB Cluster 不提供 SQL 节点之间的任何类型的自动故障转移。您的应用程序必须准备好处理 SQL 节点的丢失并在它们之间进行故障转移。
A.10.40。
如何备份和恢复 NDB Cluster？
您可以在 NDB 管理客户端和ndb_restore程序
中使用 NDB Cluster 本机备份和还原功能
。请参阅
第 23.6.8 节，“NDB Cluster 的在线备份”和
第 23.5.23 节，“ndb_restore - 恢复 NDB Cluster 备份”。
您还可以使用mysqldump和 MySQL 服务器
中为此目的提供的传统功能。有关详细信息，请参阅第 4.5.4 节，“mysqldump — 数据库备份程序”。
A.10.41。
什么是“天使流程”？
此进程监视并在必要时尝试重新启动数据节点进程。如果您在启动ndbd后检查系统上的活动进程列表，您会看到实际上有 2 个进程以该名称运行，如下所示（为简洁起见，我们省略了ndb_mgmd
和ndbd的输出）：
$> ./ndb_mgmd
$> ps aux | grep ndb
me      23002  0.0  0.0 122948  3104 ?        Ssl  14:14   0:00 ./ndb_mgmd
me      23025  0.0  0.0   5284   820 pts/2    S+   14:14   0:00 grep ndb
$> ./ndbd -c 127.0.0.1 --initial
$> ps aux | grep ndb
me      23002  0.0  0.0 123080  3356 ?        Ssl  14:14   0:00 ./ndb_mgmd
me      23096  0.0  0.0  35876  2036 ?        Ss   14:14   0:00 ./ndbmtd -c 127.0.0.1 --initial
me      23097  1.0  2.4 524116 91096 ?        Sl   14:14   0:00 ./ndbmtd -c 127.0.0.1 --initial
me      23168  0.0  0.0   5284   812 pts/2    R+   14:15   0:00 grep ndb
显示内存和 CPU 使用情况的ndbd进程
0.0是天使进程（尽管它实际上确实使用了非常少量的每个进程）。此进程仅检查主
ndbd或ndbmtd进程（实际处理数据的主数据节点进程）是否正在运行。如果允许这样做（例如，如果
StopOnError
配置参数设置为false），天使进程会尝试重新启动主数据节点进程。
© Mysql 中文网
