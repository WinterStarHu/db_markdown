# 第21章InnoDB Cluster_MySQL 8.0 参考手册

第21章InnoDB Cluster_MySQL 8.0 参考手册
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
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  /
第21章InnoDB Cluster
第21章InnoDB Cluster
本章介绍 MySQL InnoDB Cluster，它结合了 MySQL 技术，使您能够为 MySQL 部署和管理完整的集成高可用性解决方案。此内容是 InnoDB Cluster 的高级概述，有关完整文档，请参阅
MySQL InnoDB Cluster。
重要的
InnoDB Cluster 不提供对 MySQL NDB Cluster 的支持。有关 MySQL NDB Cluster 的更多信息，请参阅
第 23 章，MySQL NDB Cluster 8.0和
第 23.2.6 节，“使用 InnoDB 的 MySQL 服务器与 NDB Cluster 相比”。
InnoDB Cluster 由至少三个 MySQL Server 实例组成，它提供高可用性和扩展功能。InnoDB Cluster 使用以下 MySQL 技术：
MySQL Shell，它是 MySQL 的高级客户端和代码编辑器。
MySQL Server 和Group Replication，它使一组 MySQL 实例能够提供高可用性。InnoDB Cluster 提供了一种替代的、易于使用的编程方式来使用组复制。
MySQL Router，一种轻量级中间件，可在您的应用程序和 InnoDB Cluster 之间提供透明路由。
下图概述了这些技术如何协同工作：
图 21.1 InnoDB Cluster 概览
基于 MySQL Group Replication构建，提供自动成员管理、容错、自动故障转移等功能。InnoDB Cluster 通常以单主模式运行，有一个主实例（读写）和多个从实例（只读）。高级用户还可以利用
多主
模式，其中所有实例都是主实例。您甚至可以在 InnoDB Cluster 在线时更改集群的拓扑结构，以确保尽可能高的可用性。
您使用作为 MySQL Shell 的一部分提供的AdminAPI
来处理 InnoDB Cluster
。AdminAPI 在 JavaScript 和 Python 中可用，非常适合 MySQL 部署的脚本和自动化，以实现高可用性和可扩展性。通过使用 MySQL Shell 的 AdminAPI，您可以避免手动配置许多实例。相反，AdminAPI 为一组 MySQL 实例提供了一个有效的现代接口，使您能够从一个中央工具配置、管理和监控您的部署。
要开始使用 InnoDB Cluster，您需要
下载
并安装MySQL Shell。你需要一些安装了 MySQL Server 实例的主机
，你也可以
安装MySQL Router。
InnoDB Cluster 支持MySQL Clone，这使您能够简单地配置实例。过去，要在加入一组 MySQL 实例之前配置一个新实例，您需要以某种方式手动将事务传输到加入实例。这可能涉及制作文件副本、手动复制文件等。使用 InnoDB Cluster，您只需将一个实例添加到集群，它就会自动配置。
同样，InnoDB Cluster 与
MySQL Router紧密集成，您可以使用 AdminAPI与
它们一起工作。MySQL Router 可以在一个名为bootstrapping的过程中基于 InnoDB Cluster 自动配置自己
，这样您就无需手动配置路由。然后，MySQL Router 透明地将客户端应用程序连接到 InnoDB 集群，为客户端连接提供路由和负载平衡。此集成还使您能够使用 AdminAPI 管理针对 InnoDB 集群引导的 MySQL 路由器的某些方面。InnoDB Cluster 状态信息包括有关针对集群引导的 MySQL 路由器的详细信息。操作使您能够在集群级别创建 MySQL Router 用户，以使用针对集群引导的 MySQL Routers，等等。
有关这些技术的更多信息，请参阅说明中链接的用户文档。除了此用户文档之外，MySQL Shell JavaScript API 参考或 MySQL Shell Python API 参考中还有所有 AdminAPI 方法的开发人员文档，可从
Connectors and APIs获得。
© Mysql 中文网
