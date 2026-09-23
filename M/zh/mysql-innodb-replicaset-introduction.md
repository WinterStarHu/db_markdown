# 第 22 章 InnoDB 副本集_MySQL 8.0 参考手册

第 22 章 InnoDB 副本集_MySQL 8.0 参考手册
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
第 22 章 InnoDB 副本集
第 22 章 InnoDB 副本集
本章介绍 MySQL InnoDB ReplicaSet，它结合了 MySQL 技术，使您能够部署和管理
第 17 章，复制。此内容是 InnoDB ReplicaSet 的高级概述，有关完整文档，请参阅
MySQL InnoDB ReplicaSet。
InnoDB ReplicaSet 由至少两个 MySQL Server 实例组成，它提供了您熟悉的所有 MySQL Replication 功能，例如读取横向扩展和数据安全性。InnoDB ReplicaSet 使用以下 MySQL 技术：
MySQL Shell，它是 MySQL 的高级客户端和代码编辑器。
MySQL 服务器和第 17 章，复制，它使一组 MySQL 实例能够提供可用性和异步读取横向扩展。InnoDB ReplicaSet 提供了一种替代的、易于使用的编程方式来处理复制。
MySQL Router，一种轻量级中间件，可在您的应用程序和 InnoDB ReplicaSet 之间提供透明路由。
InnoDB ReplicaSet 的接口类似于
MySQL InnoDB Cluster，您使用 MySQL Shell 将 MySQL Server 实例作为 ReplicaSet 工作，并且 MySQL Router 也以与 InnoDB Cluster 相同的方式紧密集成。
基于 MySQL 复制，InnoDB ReplicaSet 有一个主实例，它复制到一个或多个辅助实例。InnoDB ReplicaSet 不提供 InnoDB Cluster 提供的所有功能，例如自动故障转移或多主模式。但是，它确实支持以类似方式配置、添加和删除实例等功能。您可以手动切换或故障转移到辅助实例，例如在发生故障时。您甚至可以采用现有的 Replication 部署，然后将其作为 InnoDB ReplicaSet 进行管理。
您使用
作为 MySQL Shell 的一部分提供的AdminAPI来处理 InnoDB ReplicaSet。AdminAPI 在 JavaScript 和 Python 中可用，非常适合 MySQL 部署的脚本和自动化，以实现高可用性和可扩展性。通过使用 MySQL Shell 的 AdminAPI，您可以避免手动配置许多实例。相反，AdminAPI 为一组 MySQL 实例提供了一个有效的现代接口，使您能够从一个中央工具配置、管理和监控您的部署。
要开始使用 InnoDB ReplicaSet，您需要
下载
并安装MySQL Shell。你需要一些安装了 MySQL Server 实例的主机
，你也可以
安装MySQL Router。
InnoDB ReplicaSet 支持MySQL Clone，这使您能够简单地提供实例。过去，要在加入 MySQL 复制部署之前配置新实例，您需要以某种方式手动将事务传输到加入实例。这可能涉及制作文件副本、手动复制文件等。您只需
将一个实例添加到副本集，它就会自动配置。
同样，InnoDB ReplicaSet 与
MySQL Router紧密集成，您可以使用 AdminAPI与
它们一起工作。MySQL Router 可以在称为引导的过程中基于 InnoDB ReplicaSet 自动配置自身
，这样您就无需手动配置路由。MySQL Router 然后透明地将客户端应用程序连接到 InnoDB ReplicaSet，为客户端连接提供路由和负载平衡。此集成还使您能够使用 AdminAPI 管理针对 InnoDB ReplicaSet 引导的 MySQL 路由器的某些方面。InnoDB ReplicaSet 状态信息包括有关针对 ReplicaSet 引导的 MySQL 路由器的详细信息。操作使您能够
在 ReplicaSet 级别创建 MySQL Router 用户
，以使用针对 ReplicaSet 引导的 MySQL Routers，等等。
有关这些技术的更多信息，请参阅说明中链接的用户文档。除了此用户文档之外，MySQL Shell JavaScript API 参考或 MySQL Shell Python API 参考中还有所有 AdminAPI 方法的开发人员文档，可从
Connectors and APIs获得。
© Mysql 中文网
