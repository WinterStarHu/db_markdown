# 23.7.10 NDB Cluster 复制：双向和循环复制_MySQL 8.0 参考手册

23.7.10 NDB Cluster 复制：双向和循环复制_MySQL 8.0 参考手册
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
23.7 NDB 集群复制
23.7.1 NDB Cluster 复制：缩写和符号1
23.7.2 NDB Cluster 复制的一般要求1
23.7.3 NDB Cluster 复制中的已知问题1
23.7.4 NDB Cluster 复制模式和表1
23.7.5 准备 NDB Cluster 进行复制1
23.7.6 启动 NDB Cluster 复制（单复制通道）1
23.7.7 使用两个复制通道进行 NDB Cluster 复制1
23.7.8 使用 NDB Cluster 复制实现故障转移1
23.7.9 使用 NDB Cluster 复制的 NDB Cluster 备份1
23.7.10 NDB Cluster 复制：双向和循环复制1
23.7.11 NDB Cluster 复制冲突解决1
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.7 NDB 集群复制  /
23.7.10 NDB Cluster 复制：双向和循环复制
23.7.10 NDB Cluster 复制：双向和循环复制
可以使用 NDB Cluster 在两个集群之间进行双向复制，也可以在任意数量的集群之间进行循环复制。
循环复制示例。
在接下来的几段中，我们考虑涉及三个编号为 1、2 和 3 的 NDB 集群的复制设置示例，其中集群 1 作为集群 2 的复制源，集群 2 作为集群 3 的源，集群3 作为集群 1 的源。每个集群有两个 SQL 节点，SQL 节点 A 和 B 属于集群 1，SQL 节点 C 和 D 属于集群 2，SQL 节点 E 和 F 属于集群 3。
只要满足以下条件，就支持使用这些集群的循环复制：
所有源和副本上的 SQL 节点都相同。
所有充当源和副本的 SQL 节点都以系统变量
log_replica_updates
（从 NDB 8.0.26 开始）或
log_slave_updates（NDB 8.0.26 及更早版本）启用。
这种类型的循环复制设置如下图所示：
图 23.15 NDB Cluster 循环复制所有源作为副本
在这个场景中，Cluster 1 中的 SQL 节点 A 复制到 Cluster 2 中的 SQL 节点 C；SQL节点C复制到Cluster 3中的SQL节点E；SQL节点E复制到SQL节点A，即复制线（图中弯箭头所示）直接连接所有作为复制源和副本的SQL节点。
也可以以并非所有源 SQL 节点都是副本的方式设置循环复制，如下所示：
图 23.16 NDB Cluster 循环复制，其中并非所有源都是副本
在这种情况下，每个集群中的不同 SQL 节点用作复制源和副本。您
不得启动任何启用系统变量
log_replica_updates（NDB 8.0.26 及更高版本）或log_slave_updates
（在 NDB 8.0.26 之前）的 SQL 节点。NDB Cluster 的这种循环复制方案，其中复制线（再次由图中的弯曲箭头指示）是不连续的，应该是可能的，但应该注意的是，它尚未经过彻底测试，因此必须仍然被认为是实验性的。
使用 NDB-native 备份和恢复来初始化副本集群。
设置循环复制时，可以通过
START BACKUP在一个 NDB Cluster 上使用管理客户端命令来初始化副本集群以创建备份，然后使用ndb_restore在另一个 NDB Cluster 上应用此备份。这不会在充当副本的第二个 NDB Cluster 的 SQL 节点上自动创建二进制日志；为了创建二进制日志，您必须
SHOW TABLES在该 SQL 节点上发出一条语句；这应该在运行之前完成
START REPLICA。这是一个已知的问题。
多源故障转移示例。
在本节中，我们讨论多源 NDB Cluster 复制设置中的故障转移，其中三个 NDB Clusters 的服务器 ID 为 1、2 和 3。在这种情况下，Cluster 1 复制到 Clusters 2 和 3；集群 2 也复制到集群 3。这种关系如下所示：
图 23.17 具有 3 个源的 NDB Cluster 多主复制
换句话说，数据通过 2 条不同的路径从集群 1 复制到集群 3：直接复制和通过集群 2。
并非所有参与多源复制的 MySQL 服务器都必须同时充当源和副本，并且给定的 NDB Cluster 可能对不同的复制通道使用不同的 SQL 节点。此处显示了这种情况：
图 23.18 NDB Cluster 多源复制，使用 MySQL 服务器
作为副本的 MySQL 服务器必须在启用系统变量log_replica_updates
（从 NDB 8.0.26 开始）或
log_slave_updates（NDB 8.0.26 及更早版本）的情况下运行。上图中还显示了
哪些mysqld进程需要此选项。
笔记
使用log_replica_updates
orlog_slave_updates系统变量对不作为副本运行的服务器没有影响。
当其中一个复制集群出现故障时，就会出现故障转移的需要。在此示例中，我们考虑 Cluster 1 丢失服务的情况，因此 Cluster 3 丢失来自 Cluster 1 的 2 个更新源。因为 NDB Clusters 之间的复制是异步的，所以不能保证 Cluster 3 的更新直接来自 Cluster 1比通过集群 2 收到的更新更新。您可以通过确保集群 3 在集群 1 的更新方面赶上集群 2 来处理此问题。就 MySQL 服务器而言，这意味着您需要从 MySQL 复制任何未完成的更新服务器C到服务器F。
在服务器 C 上，执行以下查询：
mysqlC> SELECT @latest:=MAX(epoch)
->     FROM mysql.ndb_apply_status
->     WHERE server_id=1;
mysqlC> SELECT
->     @file:=SUBSTRING_INDEX(File, '/', -1),
->     @pos:=Position
->     FROM mysql.ndb_binlog_index
->     WHERE orig_epoch >= @latest
->     AND orig_server_id = 1
->     ORDER BY epoch ASC LIMIT 1;
笔记
您可以通过向表中添加适当的索引来提高此查询的性能，从而可能显着加快故障转移时间ndb_binlog_index。有关更多信息，请参阅
第 23.7.4 节，“NDB Cluster 复制模式和表”。
@file将和
的值@pos手动从服务器 C 复制到服务器 F（或让您的应用程序执行等效操作）。然后在服务器F上，执行如下CHANGE REPLICATION
SOURCE TO语句（NDB 8.0.23及之后）或
CHANGE MASTER TO语句（NDB 8.0.23之前）：
mysqlF> CHANGE MASTER TO
->     MASTER_HOST = 'serverC'
->     MASTER_LOG_FILE='@file',
->     MASTER_LOG_POS=@pos;
从 NDB 8.0.23 开始，您还可以使用以下语句：
mysqlF> CHANGE REPLICATION SOURCE TO
->     SOURCE_HOST = 'serverC'
->     SOURCE_LOG_FILE='@file',
->     SOURCE_LOG_POS=@pos;
完成后，您可以
START REPLICA在 MySQL 服务器 F 上发出一条语句；这会导致将源自服务器 B 的任何缺失更新复制到服务器 F。
CHANGE REPLICATION SOURCE TO|
_ CHANGE MASTER TO语句还支持一个IGNORE_SERVER_IDS选项，该选项采用逗号分隔的服务器 ID 列表，并导致忽略来自相应服务器的事件。有关详细信息，请参阅第 13.4.2.1 节，“CHANGE MASTER TO 语句”和
第 13.7.7.36 节，“SHOW SLAVE | 副本状态声明”。有关此选项如何与
ndb_log_apply_status变量交互的信息，请参阅第 23.7.8 节，“使用 NDB Cluster 复制实现故障转移”。
© Mysql 中文网
