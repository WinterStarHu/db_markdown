# 23.2.6 使用 InnoDB 的 MySQL 服务器与 NDB Cluster 比较_MySQL 8.0 参考手册

23.2.6 使用 InnoDB 的 MySQL 服务器与 NDB Cluster 比较_MySQL 8.0 参考手册
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
23.2.6.1 NDB 和 InnoDB 存储引擎的区别
23.2.6.2 NDB 和 InnoDB 工作负载
23.2.6.3 NDB 和 InnoDB 特性使用总结
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
23.2.6 使用 InnoDB 的 MySQL 服务器与 NDB Cluster 比较
23.2.6 使用 InnoDB 的 MySQL 服务器与 NDB Cluster 比较
23.2.6.1 NDB 和 InnoDB 存储引擎的区别23.2.6.2 NDB 和 InnoDB 工作负载23.2.6.3 NDB 和 InnoDB 特性使用总结
MySQL Server 在存储引擎方面提供了多种选择。由于NDB和
InnoDB都可以作为事务性 MySQL 存储引擎，MySQL Server 的用户有时会对 NDB Cluster 感兴趣。他们
将MySQL 8.0 中的默认存储引擎NDB视为可能的替代或升级。InnoDB虽然NDB和
InnoDBNDB Cluster 具有共同的特点，但在架构和实现上存在差异，因此一些现有的 MySQL Server 应用程序和使用场景可以很好地适合 NDB Cluster，但不是所有的。
在本节中，我们将讨论和比较NDBNDB 8.0 使用的存储引擎与InnoDBMySQL 8.0 使用的存储引擎的一些特性。接下来的几节提供了技术比较。在许多情况下，必须根据具体情况决定何时何地使用 NDB Cluster，并考虑所有因素。虽然为每个可能的使用场景提供细节超出了本文档的范围，但我们也尝试提供一些非常通用的指导，说明一些常见类型的应用程序
NDB相对于
InnoDB后端的相对适用性。
NDB Cluster 8.0 使用基于 MySQL 8.0的mysqldInnoDB ，包括对
1.1 的支持。虽然可以将InnoDB表与 NDB Cluster 一起使用，但此类表不是集群的。也不可能将来自 NDB Cluster 8.0 发行版的程序或库与 MySQL Server 8.0 一起使用，反之亦然。
虽然某些类型的常见业务应用程序确实可以在 NDB Cluster 或 MySQL 服务器上运行（很可能使用InnoDB存储引擎），但存在一些重要的架构和实现差异。第 23.2.6.1 节，“NDB 和 InnoDB 存储引擎之间的差异”提供了这些差异的摘要。由于差异，一些使用场景显然更适合一种引擎或另一种引擎；参见
第 23.2.6.2 节，“NDB 和 InnoDB 工作负载”。这反过来又会影响更适合与NDB或
一起使用的应用程序类型InnoDB。请参阅
第 23.2.6.3 节，“NDB 和 InnoDB 功能使用摘要”，用于比较每种类型在常见数据库应用程序中的相对适用性。
有关
存储引擎NDB和
MEMORY存储引擎的相关特性的信息，请参阅
何时使用 MEMORY 或 NDB Cluster。
有关 MySQL 存储引擎的更多信息，
请参阅第 16 章，替代存储引擎。
© Mysql 中文网
