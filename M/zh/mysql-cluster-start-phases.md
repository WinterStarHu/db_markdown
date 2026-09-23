# 23.6.4 NDB Cluster 启动阶段总结_MySQL 8.0 参考手册

23.6.4 NDB Cluster 启动阶段总结_MySQL 8.0 参考手册
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
23.6.4 NDB Cluster 启动阶段总结
23.6.4 NDB Cluster 启动阶段总结
本节简要介绍了启动 NDB Cluster 数据节点时所涉及的步骤。更完整的信息可以在内部指南中的NDB Cluster Start Phases中找到。
NDB
这些阶段与管理客户端命令输出中报告的阶段相同
node_id
STATUS（请参阅
第 23.6.1 节，“NDB Cluster 管理客户端中的命令”）。这些开始阶段也在表的start_phase
列中报告ndbinfo.nodes
。
启动类型。
有几种不同的启动类型和模式，如下表所示：
初始启动。
集群以所有数据节点上的干净文件系统开始。这发生在集群第一次启动时，或者当所有数据节点使用该--initial选项重新启动时。
笔记
使用 重新启动节点时，不会删除磁盘数据文件
--initial。
系统重启。
集群启动并读取存储在数据节点中的数据。当集群在使用后关闭时，当希望集群从它停止的地方恢复操作时，会发生这种情况。
节点重启。
这是在集群本身运行时集群节点的联机重启。
初始节点重启。
这与节点重启相同，只是节点重新初始化并使用干净的文件系统启动。
设置和初始化（阶段 -1）。
在启动之前，
必须初始化每个数据节点（ ndbd进程）。初始化包括以下步骤：
获取节点ID
获取配置数据
分配用于节点间通信的端口
根据从配置文件中获取的设置分配内存
当一个数据节点或SQL节点第一次连接到管理节点时，它会保留一个集群节点ID。为确保没有其他节点分配相同的节点 ID，该 ID 会一直保留，直到该节点设法连接到集群并且至少有一个
ndbd报告该节点已连接。节点 ID 的保留由相关节点与ndb_mgmd之间的连接保护。
每个数据节点都初始化完成后，集群启动过程就可以进行了。此处列出了集群在此过程中经历的阶段：
阶段 0。
和块开始NDBFS。
在以选项
NDBCNTR启动的那些数据节点上清除数据节点文件系统。--initialPhase 1.
在这个阶段，所有剩余的
NDB内核块都被启动。建立 NDB Cluster 连接，建立块间通信，并启动心跳。在节点重启的情况下，还会检查 API 节点连接。
笔记
当一个或多个节点在第 1 阶段挂起而其余节点或多个节点在第 2 阶段挂起时，这通常表示网络出现问题。此类问题的一个可能原因是一台或多台集群主机具有多个网络接口。导致这种情况的另一个常见问题来源是群集节点之间通信所需的 TCP/IP 端口被阻塞。在后一种情况下，这通常是由于防火墙配置错误造成的。
阶段 2.
内核NDBCNTR块检查所有现有节点的状态。选择主节点，并初始化集群模式文件。
阶段 3.
和内核块在它们DBLQH之间
DBTC建立通信。启动类型确定；如果这是重新启动，则
DBDIH块获得执行重新启动的权限。
第 4 阶段
。对于初始启动或初始节点重新启动，创建重做日志文件。这些文件的数量等于
NoOfFragmentLogFiles.
对于系统重启：
读取模式或模式。
从本地检​​查点读取数据。
应用所有重做信息，直到达到最新的可恢复全局检查点。
对于节点重启，找到重做日志的尾部。
阶段 5。
数据节点启动的大部分与数据库相关的部分都在此阶段执行。对于初始启动或系统重启，先执行本地检查点，然后执行全局检查点。在此阶段开始定期检查内存使用情况，并执行任何所需的节点接管。
阶段 6。
在此阶段，定义和设置节点组。
Phase 7.
The arbitrator node is selected and begins to function. The
next backup ID is set, as is the backup disk write speed.
Nodes reaching this start phase are marked as
Started. It is now possible for API nodes
(including SQL nodes) to connect to the cluster.
Phase 8.
If this is a system restart, all indexes are rebuilt (by
DBDIH).
Phase 9.
The node internal startup variables are reset.
Phase 100 (OBSOLETE).
Formerly, it was at this point during a node restart or
initial node restart that API nodes could connect to the
node and begin to receive events. Currently, this phase is
empty.
Phase 101.
At this point in a node restart or initial node restart,
event delivery is handed over to the node joining the
cluster. The newly-joined node takes over responsibility for
delivering its primary data to subscribers. This phase is
also referred to as
SUMA
handover phase.
在初始启动或系统重启完成此过程后，将启用事务处理。对于节点重启或初始节点重启，启动过程的完成意味着该节点现在可以充当事务协调器。
© Mysql 中文网
