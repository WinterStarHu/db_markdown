# 23.2 NDB Cluster 概述_MySQL 8.0 参考手册

23.2 NDB Cluster 概述_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  /
23.2 NDB Cluster 概述
23.2 NDB Cluster 概述
23.2.1 NDB Cluster 核心概念23.2.2 NDB Cluster 节点、节点组、片段副本和分区23.2.3 NDB Cluster 硬件、软件和网络要求23.2.4 NDB Cluster 中的新功能23.2.5 NDB 8.0 中添加、弃用或删除的选项、变量和参数23.2.6 使用 InnoDB 的 MySQL 服务器与 NDB Cluster 比较23.2.7 NDB Cluster 的已知限制
NDB Cluster是一种在无共享系统中启用内存数据库集群的技术。无共享架构使系统能够与非常便宜的硬件一起工作，并且对硬件或软件的特定要求最少。
NDB Cluster 被设计为没有任何单点故障。在无共享系统中，每个组件都应该有自己的内存和磁盘，并且不推荐或不支持使用共享存储机制，例如网络共享、网络文件系统和 SAN。
NDB Cluster将标准MySQL
服务器与称为NDB
（代表“网络数据库
”）的内存中集群存储引擎集成在一起。在我们的文档中，该术语NDB指的是特定于存储引擎的设置部分，而“ MySQL NDB Cluster ”指的是一个或多个 MySQL 服务器与
NDB存储引擎的组合。
NDB Cluster 由一组称为
主机的计算机组成，每个计算机运行一个或多个进程。这些进程称为
节点，可能包括 MySQL 服务器（用于访问 NDB 数据）、数据节点（用于存储数据）、一个或多个管理服务器，以及可能的其他专用数据访问程序。NDB Cluster 中这些组件的关系如下所示：
图 23.1 NDB Cluster 组件
所有这些程序一起工作以形成一个 NDB Cluster（请参阅
第 23.5 节，“NDB Cluster 程序”）。当
NDB存储引擎存储数据时，表（和表数据）存储在数据节点中。这些表可以直接访问集群中的所有其他 MySQL 服务器（SQL 节点）。因此，在集群中存储数据的薪资应用程序中，如果一个应用程序更新了员工的薪水，所有查询此数据的其他 MySQL 服务器都可以立即看到此更改。
尽管 NDB Cluster SQL 节点使用mysqld
服务器守护进程，但它在许多关键方面与 MySQL 8.0 发行版提供的
mysqld二进制文件不同，并且这两个版本的
mysqld不可互换。
此外，未连接到 NDB Cluster 的 MySQL 服务器无法使用NDB存储引擎，也无法访问任何 NDB Cluster 数据。
可以镜像存储在 NDB Cluster 的数据节点中的数据；集群可以处理单个数据节点的故障，除了少量事务因丢失事务状态而中止外，没有其他影响。因为事务应用程序应该处理事务失败，所以这不应该是问题的根源。
可以停止和重新启动单个节点，然后可以重新加入系统（集群）。滚动重启（所有节点依次重启）用于进行配置更改和软件升级（请参阅
第 23.6.5 节，“执行 NDB Cluster 的滚动重启”）。滚动重启也用作在线添加新数据节点过程的一部分（请参阅第 23.6.7 节，“在线添加 NDB Cluster 数据节点”）。有关数据节点、它们在 NDB Cluster 中的组织方式以及它们如何处理和存储 NDB Cluster 数据的更多信息，请参阅
第 23.2.2 节，“NDB Cluster 节点、节点组、片段副本和分区”。
NDB可以使用NDB Cluster 管理客户端中的 -native 功能和 NDB Cluster 发行版中包含的ndb_restore程序
来备份和恢复 NDB Cluster 数据库
。有关更多信息，请参阅
第 23.6.8 节，“NDB Cluster 的在线备份”和
第 23.5.23 节，“ndb_restore - 恢复 NDB Cluster 备份”。您还可以在mysqldump和 MySQL 服务器中使用为此目的提供的标准 MySQL 功能
。有关详细信息，请参阅
第 4.5.4 节，“mysqldump — 数据库备份程序”。
NDB Cluster 节点可以采用不同的传输机制进行节点间通信；在大多数实际部署中使用基于标准 100 Mbps 或更快以太网硬件的 TCP/IP。
© Mysql 中文网
