# 23.2.2 NDB Cluster 节点、节点组、片段副本和分区_MySQL 8.0 参考手册

23.2.2 NDB Cluster 节点、节点组、片段副本和分区_MySQL 8.0 参考手册
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
23.2.1 NDB Cluster 核心概念1
23.2.2 NDB Cluster 节点、节点组、片段副本和分区1
23.2.3 NDB Cluster 硬件、软件和网络要求1
23.2.4 NDB Cluster 中的新功能1
23.2.5 NDB 8.0 中添加、弃用或删除的选项、变量和参数1
23.2.6 使用 InnoDB 的 MySQL 服务器与 NDB Cluster 比较1
23.2.7 NDB Cluster 的已知限制1
23.3 NDB Cluster 安装
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.2 NDB Cluster 概述  /
23.2.2 NDB Cluster 节点、节点组、片段副本和分区
23.2.2 NDB Cluster 节点、节点组、片段副本和分区
本节讨论 NDB Cluster 划分和复制数据以进行存储的方式。
在接下来的几段中讨论了一些对于理解该主题至关重要的概念。
数据节点。
一个ndbd或ndbmtd进程，它存储一个或多个片段副本——即
分配给节点所属节点组的
分区副本（在本节后面讨论）。
每个数据节点应位于单独的计算机上。虽然也可以在一台计算机上托管多个数据节点进程，但通常不推荐这种配置。
在提到
ndbd或ndbmtd进程时
，术语“节点”和“数据节点”通常可以互换使用；在提到的地方，管理节点（ndb_mgmd
进程）和 SQL 节点（mysqld进程）在本讨论中指定为这样。
节点组。
节点组由一个或多个节点组成，并存储分区或片段副本集（请参阅下一项）。
NDB Cluster 中节点组的数量不能直接配置；它是数据节点数量和片段副本数量（NoOfReplicas
配置参数）的函数，如下所示：
[# of node groups] = [# of data nodes] / NoOfReplicas
因此，具有 4 个数据节点的 NDB Cluster 如果
在文件
NoOfReplicas中设置为 1，则有 4 个节点组，如果设置为 2，则有 2 个节点组，如果设置为 4，则有 1 个节点组
。片段副本将在本节后面讨论；有关更多信息
，请参阅
第 23.4.3.6 节，“定义 NDB Cluster 数据节点”。
config.iniNoOfReplicasNoOfReplicasNoOfReplicas
笔记
NDB Cluster 中的所有节点组必须具有相同数量的数据节点。
您可以在线添加新的节点组（以及新的数据节点）到正在运行的 NDB Cluster；有关更多信息，请参阅
第 23.6.7 节，“在线添加 NDB Cluster 数据节点”。
分割。
这是集群存储的一部分数据。每个节点负责保持分配给它的任何分区的至少一个副本（即至少一个片段副本）对集群可用。
NDB Cluster 默认使用的分区数取决于数据节点数和数据节点使用的 LDM 线程数，如下所示：
[# of partitions] = [# of data nodes] * [# of LDM threads]
使用运行ndbmtd的数据节点时，LDM 线程的数量由 的设置控制
MaxNoOfExecutionThreads。使用ndbd时，只有一个 LDM 线程，这意味着集群分区与参与集群的节点一样多。使用
设置为 3 或更少的ndbmtd时也是如此
。MaxNoOfExecutionThreads（您应该知道，LDM 线程的数量会随着该参数的值而增加，但不是以严格的线性方式增加，并且在设置它时还有其他限制；
MaxNoOfExecutionThreads
有关详细信息，请参阅 的描述。）
NDB 和用户定义的分区。
NDB Cluster 通常会自动对表进行分区
NDBCLUSTER。但是，也可以对NDBCLUSTER表使用用户定义的分区。这受到以下限制：
在表的生产中仅支持KEY和LINEAR
KEY分区方案NDB。
可以为任何NDB表
显式定义的最大分区数是 NDB Cluster 中的节点组数，如本节前面所讨论的那样确定。为数据节点进程运行ndbd时，设置 LDM 线程数无效（因为
仅适用于ndbmtd）；在这种情况下，为了执行此计算，可以将此值视为等于 1。
8 * [number of LDM
threads] * [number of node
groups]ThreadConfig
有关更多信息，请参阅第 23.5.3 节，“ndbmtd — NDB Cluster 数据节点守护进程（多线程）”。
有关 NDB Cluster 和用户定义分区的更多信息，请参阅第 23.2.7 节，“NDB Cluster 的已知限制”和
第 24.6.2 节，“与存储引擎相关的分区限制”。
片段副本。
这是集群分区的副本。节点组中的每个节点存储一个片段副本。有时也称为
分区副本。片段副本数等于每个节点组的节点数。
分片副本完全属于单个节点；一个节点可以（并且通常确实）存储多个片段副本。
下图说明了一个 NDB Cluster，它有四个运行ndbd的数据节点，排列在两个节点组中，每个节点有两个节点；节点1和2属于节点组0，节点3和4属于节点组1。
笔记
此处仅显示数据节点；尽管工作的 NDB Cluster 需要一个用于集群管理的ndb_mgmd进程和至少一个 SQL 节点来访问集群存储的数据，但为了清楚起见，图中省略了这些。
图 23.2 具有两个节点组的 NDB Cluster
集群存储的数据分为四个分区，编号为 0、1、2 和 3。每个分区以多个副本的形式存储在同一个节点组上。分区存储在备用节点组上，如下所示：
分区0存储在节点组0上；主分
片副本
（主副本）存储在节点1上，
备份分片副本
（分区的备份副本）存储在节点2上。
Partition 1存放在其他节点组（node group 1）上；这个分区的主分片副本在节点 3 上，它的备份分片副本在节点 4 上。
Partition 2 存储在节点组 0 上，但其两个分片副本的放置与 Partition 0 相反；对于分区 2，主片段副本存储在节点 2 上，备份存储在节点 1 上。
分区3存储在节点组1上，其两个分片副本的位置与分区1相反，即其主分片副本位于节点4，备份位于节点3。
这对于 NDB Cluster 的持续运行意味着：只要参与集群的每个节点组都有至少一个节点在运行，集群就会拥有所有数据的完整副本并保持活力。下图说明了这一点。
图 23.3 2x2 NDB Cluster 所需的节点
在此示例中，集群由两个节点组组成，每个节点组由两个数据节点组成。每个数据节点都在运行一个ndbd实例。节点组 0 中的至少一个节点和节点组 1 中的至少一个节点的任意组合都足以使集群保持“活动”状态。但是，如果单个节点组中的两个节点都发生故障，则由另一个节点组中剩余的两个节点组成的组合是不够的。在这种情况下，集群丢失了整个分区，因此无法再提供对所有 NDB Cluster 数据的完整集合的访问。
单个 NDB Cluster 实例支持的最大节点组数为 48。
© Mysql 中文网
