# 23.3 NDB Cluster 安装_MySQL 8.0 参考手册

23.3 NDB Cluster 安装_MySQL 8.0 参考手册
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
23.3.1 在 Linux 上安装 NDB Cluster1
23.3.2 在 Windows 上安装 NDB Cluster1
23.3.3 NDB Cluster 的初始配置1
23.3.4 NDB Cluster 初始启动1
23.3.5 带有表和数据的 NDB Cluster 示例1
23.3.6 NDB Cluster 的安全关闭和重启1
23.3.7 升级和降级 NDB Cluster1
23.3.8 NDB Cluster 自动安装程序（不再支持）1
23.4 NDB Cluster的配置
23.5 NDB 集群程序
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  /
23.3 NDB Cluster 安装
23.3 NDB Cluster 安装
23.3.1 在 Linux 上安装 NDB Cluster23.3.2 在 Windows 上安装 NDB Cluster23.3.3 NDB Cluster 的初始配置23.3.4 NDB Cluster 初始启动23.3.5 带有表和数据的 NDB Cluster 示例23.3.6 NDB Cluster 的安全关闭和重启23.3.7 升级和降级 NDB Cluster23.3.8 NDB Cluster 自动安装程序（不再支持）
本节介绍规划、安装、配置和运行 NDB Cluster 的基础知识。尽管
第 23.4 节“NDB Cluster 的配置”中的示例提供了有关各种集群选项和配置的更深入的信息，但遵循此处概述的指南和过程的结果应该是一个可用的 NDB Cluster，它满足以下
最低要求数据的可用性和保护。
有关在发行版本之间升级或降级 NDB Cluster 的信息，请参阅
第 23.3.7 节，“升级和降级 NDB Cluster”。
本节涵盖硬件和软件要求；网络问题；安装 NDB Cluster；基本配置问题；启动、停止和重新启动集群；加载示例数据库；并执行查询。
假设。
以下部分对集群的物理和网络配置做了一些假设。这些假设将在接下来的几段中讨论。
集群节点和主机。
集群由四个节点组成，每个节点都位于单独的主机上，并且每个节点在典型的以太网网络上都有一个固定的网络地址，如下所示：
表 23.5 示例集群中节点的网络地址
节点
IP地址
管理节点 ( mgmd )
198.51.100.10
SQL 节点 ( mysqld )
198.51.100.20
数据节点“A”（ndbd）
198.51.100.30
数据节点“B”（ndbd）
198.51.100.40
此设置也显示在下图中：
图 23.4 NDB Cluster 多机设置
网络寻址。
为了简单（和可靠性），本
操作指南仅使用数字 IP 地址。但是，如果 DNS 解析在您的网络上可用，则可以在配置集群时使用主机名代替 IP 地址。或者，您可以使用该hosts
文件（通常/etc/hosts用于 Linux 和其他类 Unix 操作系统、
C:\WINDOWS\system32\drivers\etc\hostsWindows 或您的操作系统的等效项）提供一种方法来进行主机查找（如果可用）。
在 NDB 8.0.22 之前，所有用于连接数据和管理节点的网络地址都必须使用 IPv4 或可使用 IPv4 进行解析。这包括 SQL 节点用来联系其他节点的地址。从 NDB 8.0.22 开始，NDB Cluster 支持 IPv6 用于任何和所有集群节点之间的连接。
潜在的主机文件问题。
由于某些操作系统（包括某些 Linux 发行版）/etc/hosts在安装过程中设置系统自己的主机名的方式，在尝试为集群节点使用主机名时会出现一个常见问题。考虑两台主机名为
ndb1和的机器ndb2，它们都在
cluster网络域中。Red Hat Linux（包括一些衍生产品，如 CentOS 和 Fedora）在这些机器的
/etc/hosts文件中放置了以下条目：
#  ndb1 /etc/hosts:
127.0.0.1   ndb1.cluster ndb1 localhost.localdomain localhost#  ndb2 /etc/hosts:
127.0.0.1   ndb2.cluster ndb2 localhost.localdomain localhost
SUSE Linux（包括 OpenSUSE）将这些条目放在机器的/etc/hosts文件中：
#  ndb1 /etc/hosts:
127.0.0.1       localhost
127.0.0.2       ndb1.cluster ndb1#  ndb2 /etc/hosts:
127.0.0.1       localhost
127.0.0.2       ndb2.cluster ndb2
在这两种情况下，ndb1路由
ndb1.cluster到环回 IP 地址，但从 DNS 获取公共 IP 地址ndb2.cluster，同时ndb2路由ndb2.cluster
到环回地址并获取公共地址
ndb1.cluster。结果是每个数据节点都连接到管理服务器，但不知道其他数据节点何时连接，因此数据节点在启动时似乎挂起。
警告
您不能在 中混合localhost使用其他主机名或 IP 地址config.ini。由于这些原因，这种情况下的解决方案（除了对所有
config.ini HostName
条目使用 IP 地址之外）是从中删除完全限定的主机名，
/etc/hosts并将它们
config.ini用于所有群集主机。
主机类型。
我们安装方案中的每台主机都是基于 Intel 的台式 PC，运行支持的操作系统，以标准配置安装到磁盘，并且不运行不必要的服务。具有标准 TCP/IP 网络功能的核心操作系统应该足够了。同样为了简单起见，我们还假设所有主机上的文件系统设置相同。如果不是，您应该相应地调整这些说明。
网络硬件。
每台机器上都安装了标准的 100 Mbps 或 1 Gb 以太网卡，以及这些卡的适当驱动程序，并且所有四台主机都通过标准发布的以太网网络设备（例如交换机）连接。（所有机器都应该使用相同吞吐量的网卡。也就是说，集群中的所有四台机器都应该有 100 Mbps 的网卡
，或者所有四台机器都应该有 1 Gbps 的网卡。）NDB Cluster 工作在 100 Mbps 网络中；然而，千兆以太网提供更好的性能。
重要的
NDB Cluster不适用于吞吐量低于 100 Mbps 或经历高度延迟的网络。由于这个原因（以及其他原因），尝试在广域网（如 Internet）上运行 NDB Cluster 不太可能成功，并且在生产中不受支持。
样本数据。
我们使用world可从 MySQL 网站下载的数据库（请参阅
https://mysql.net.cn/doc/index-other.html）。我们假设每台机器都有足够的内存来运行操作系统、所需的 NDB Cluster 进程和（在数据节点上）存储数据库。
有关安装 MySQL 的一般信息，请参阅
第 2 章，安装和升级 MySQL。有关在 Linux 和其他类 Unix 操作系统上安装 NDB Cluster 的信息，请参阅
第 23.3.1 节，“在 Linux 上安装 NDB Cluster”。有关在 Windows 操作系统上安装 NDB Cluster 的信息，请参阅
第 23.3.2 节，“在 Windows 上安装 NDB Cluster”。
有关 NDB Cluster 硬件、软件和网络要求的一般信息，请参阅
第 23.2.3 节，“NDB Cluster 硬件、软件和网络要求”。
© Mysql 中文网
