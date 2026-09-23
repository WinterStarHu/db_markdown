# 23.6.3 NDB Cluster 中生成的事件报告_MySQL 8.0 参考手册

23.6.3 NDB Cluster 中生成的事件报告_MySQL 8.0 参考手册
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
23.6.3.1 NDB Cluster 日志记录管理命令
23.6.3.2 NDB Cluster 日志事件
23.6.3.3 在 NDB Cluster Management Client 中使用 CLUSTERLOG STATISTICS
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
23.6.3 NDB Cluster 中生成的事件报告
23.6.3 NDB Cluster 中生成的事件报告
23.6.3.1 NDB Cluster 日志记录管理命令23.6.3.2 NDB Cluster 日志事件23.6.3.3 在 NDB Cluster Management Client 中使用 CLUSTERLOG STATISTICS
在本节中，我们讨论 NDB Cluster 提供的事件日志类型，以及记录的事件类型。
NDB Cluster 提供两种类型的事件日志：
集群日志，其中包括所有集群节点生成的事件
。集群日志是推荐用于大多数用途的日志，因为它在单个位置提供整个集群的日志记录信息。
默认情况下，集群日志保存
在管理服务器的
.
ndb_node_id_cluster.lognode_idDataDir
集群日志记录信息也可以发送到
stdout或syslog
设施除了或代替保存到文件中，这由为
DataDir和
LogDestination
配置参数设置的值确定。有关这些参数的更多信息，
请参阅
第 23.4.3.5 节，“定义 NDB Cluster 管理服务器” 。
节点日志对于每个节点都是本地的。
节点事件日志记录生成的
输出被写入
节点的
. 为管理节点和数据节点生成节点事件日志。
ndb_node_id_out.lognode_idDataDir
节点日志旨在仅在应用程序开发期间使用，或用于调试应用程序代码。
两种类型的事件日志都可以设置为记录不同的事件子集。
每个可报告事件都可以根据三个不同的标准进行区分：
类别：这可以是
以下
值
之一
：STARTUP、、、、、、、、
或。SHUTDOWNSTATISTICSCHECKPOINTNODERESTARTCONNECTIONERRORINFO
优先级：这由 0 到 15 之间的数字之一表示，其中 0 表示
“最重要”，15表示“最不重要” 。”
严重级别：这可以是
以下值
之一
：ON、、、、、、、、
或。（有时也称为日志级别。）
DEBUGINFOWARNINGERRORCRITICALALERTALL
集群日志和节点日志都可以根据这些属性进行过滤。
NDB Cluster（从 NDB 8.0.26 开始）生成的日志消息中使用的格式如下所示：
timestamp [node_type] level -- Node node_id: message
日志或日志消息中的每一行都包含以下信息：
一个
格式timestamp。
时间戳值目前仅解析为整秒；不支持小数秒。
YYYY-MM-DD
HH:MM:SSnode_type执行日志记录的节点或应用程序
的或类型。在集群日志中，这总是[MgmSrvr]; 在数据节点日志中，它始终是[ndbd].
[NdbApi]NDB API 应用程序和工具生成的日志中可能存在其他值。
事件的level级别，有时也称为其严重级别或日志级别。有关严重级别的更多信息，
请参阅本节前面的内容以及
第 23.6.3.1 节，“NDB Cluster 日志记录管理命令” 。
报告事件的节点 ID ( node_id)。
包含message事件描述的 。日志中最常见的事件类型是集群中不同节点之间的连接和断开连接，以及何时出现检查点。在某些情况下，描述可能包含状态或其他信息。
此处显示了来自实际集群日志的示例：
2021-06-10 10:01:07 [MgmtSrvr] INFO     -- Node 5: Start phase 5 completed (system restart)
2021-06-10 10:01:07 [MgmtSrvr] INFO     -- Node 6: Start phase 5 completed (system restart)
2021-06-10 10:01:07 [MgmtSrvr] INFO     -- Node 5: Start phase 6 completed (system restart)
2021-06-10 10:01:07 [MgmtSrvr] INFO     -- Node 6: Start phase 6 completed (system restart)
2021-06-10 10:01:07 [MgmtSrvr] INFO     -- Node 5: President restarts arbitration thread [state=1]
2021-06-10 10:01:07 [MgmtSrvr] INFO     -- Node 5: Start phase 7 completed (system restart)
2021-06-10 10:01:07 [MgmtSrvr] INFO     -- Node 6: Start phase 7 completed (system restart)
2021-06-10 10:01:07 [MgmtSrvr] INFO     -- Node 5: Start phase 8 completed (system restart)
2021-06-10 10:01:07 [MgmtSrvr] INFO     -- Node 6: Start phase 8 completed (system restart)
2021-06-10 10:01:07 [MgmtSrvr] INFO     -- Node 5: Start phase 9 completed (system restart)
2021-06-10 10:01:07 [MgmtSrvr] INFO     -- Node 6: Start phase 9 completed (system restart)
2021-06-10 10:01:07 [MgmtSrvr] INFO     -- Node 5: Start phase 50 completed (system restart)
2021-06-10 10:01:07 [MgmtSrvr] INFO     -- Node 6: Start phase 50 completed (system restart)
2021-06-10 10:01:07 [MgmtSrvr] INFO     -- Node 5: Start phase 101 completed (system restart)
2021-06-10 10:01:07 [MgmtSrvr] INFO     -- Node 6: Start phase 101 completed (system restart)
2021-06-10 10:01:07 [MgmtSrvr] INFO     -- Node 5: Started (mysql-8.0.32 ndb-8.0.32)
2021-06-10 10:01:07 [MgmtSrvr] INFO     -- Node 6: Started (mysql-8.0.32 ndb-8.0.32)
2021-06-10 10:01:07 [MgmtSrvr] INFO     -- Node 5: Node 50: API mysql-8.0.32 ndb-8.0.32
2021-06-10 10:01:07 [MgmtSrvr] INFO     -- Node 6: Node 50: API mysql-8.0.32 ndb-8.0.32
2021-06-10 10:01:08 [MgmtSrvr] INFO     -- Node 6: Prepare arbitrator node 50 [ticket=75fd00010fa8b608]
2021-06-10 10:01:08 [MgmtSrvr] INFO     -- Node 5: Started arbitrator node 50 [ticket=75fd00010fa8b608]
2021-06-10 10:01:08 [MgmtSrvr] INFO     -- Node 6: Communication to Node 100 opened
2021-06-10 10:01:08 [MgmtSrvr] INFO     -- Node 6: Communication to Node 101 opened
2021-06-10 10:01:08 [MgmtSrvr] INFO     -- Node 5: Communication to Node 100 opened
2021-06-10 10:01:08 [MgmtSrvr] INFO     -- Node 5: Communication to Node 101 opened
2021-06-10 10:01:36 [MgmtSrvr] INFO     -- Alloc node id 100 succeeded
2021-06-10 10:01:36 [MgmtSrvr] INFO     -- Nodeid 100 allocated for API at 127.0.0.1
2021-06-10 10:01:36 [MgmtSrvr] INFO     -- Node 100: mysqld --server-id=1
2021-06-10 10:01:36 [MgmtSrvr] INFO     -- Node 5: Node 100 Connected
2021-06-10 10:01:36 [MgmtSrvr] INFO     -- Node 6: Node 100 Connected
2021-06-10 10:01:36 [MgmtSrvr] INFO     -- Node 5: Node 100: API mysql-8.0.32 ndb-8.0.32
2021-06-10 10:01:36 [MgmtSrvr] INFO     -- Node 6: Node 100: API mysql-8.0.32 ndb-8.0.32
有关其他信息，请参阅
第 23.6.3.2 节，“NDB Cluster 日志事件”。
© Mysql 中文网
