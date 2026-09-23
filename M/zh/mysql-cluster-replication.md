# 23.7 NDB 集群复制_MySQL 8.0 参考手册

23.7 NDB 集群复制_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  /
23.7 NDB 集群复制
23.7 NDB 集群复制
23.7.1 NDB Cluster 复制：缩写和符号23.7.2 NDB Cluster 复制的一般要求23.7.3 NDB Cluster 复制中的已知问题23.7.4 NDB Cluster 复制模式和表23.7.5 准备 NDB Cluster 进行复制23.7.6 启动 NDB Cluster 复制（单复制通道）23.7.7 使用两个复制通道进行 NDB Cluster 复制23.7.8 使用 NDB Cluster 复制实现故障转移23.7.9 使用 NDB Cluster 复制的 NDB Cluster 备份23.7.10 NDB Cluster 复制：双向和循环复制23.7.11 NDB Cluster 复制冲突解决
NDB Cluster 支持异步复制，通常简称为
“复制”。本节说明如何设置和管理配置，其中一组计算机作为 NDB Cluster 复制到第二台计算机或一组计算机。我们假定读者对本手册其他地方讨论的标准 MySQL 复制有一定的了解。（参见第 17 章，复制）。
笔记
NDB Cluster 不支持使用 GTID 进行复制；NDB存储引擎
也不支持半同步复制和组复制。
正常（非集群）复制涉及一个源服务器和一个副本服务器，源之所以如此命名是因为要复制的操作和数据源自它，而副本是这些服务器的接收者。在 NDB Cluster 中，复制在概念上非常相似，但在实践中可能更复杂，因为它可以扩展到涵盖许多不同的配置，包括在两个完整的集群之间复制。尽管 NDB Cluster 本身依赖于NDB存储引擎来实现集群功能，但没有必要将其
NDB用作复制表的副本副本的存储引擎（请参阅
从 NDB 复制到其他存储引擎). 但是，为了获得最大可用性，可以（并且更可取）从一个 NDB Cluster 复制到另一个，我们讨论的正是这种场景，如下图所示：
图 23.10 NDB Cluster-to-Cluster 复制布局
在这种情况下，复制过程是记录源集群的连续状态并将其保存到副本集群的过程。此过程由称为 NDB 二进制日志注入器线程的特殊线程完成，该线程在每个 MySQL 服务器上运行并生成二进制日志 ( binlog)。该线程确保集群中产生二进制日志的所有更改——而不仅仅是那些通过 MySQL 服务器影响的更改——都以正确的序列化顺序插入到二进制日志中。我们将 MySQL 源服务器和副本服务器称为复制服务器或复制节点，将它们之间的数据流或通信线路称为
复制通道。
有关使用 NDB Cluster 和 NDB Cluster 复制执行时间点恢复的信息，请参阅
第 23.7.9.2 节，“使用 NDB Cluster 复制的时间点恢复”。
NDB API 副本状态变量。
NDB API 计数器可以在副本集群上提供增强的监控功能。这些计数器作为 NDB 统计
_slave状态变量实现，如输出所示，或在连接到 MySQL 服务器的MySQLSHOW STATUS客户端会话中针对性能模式
session_status或
global_status表
的查询结果中，该服务器在 NDB Cluster Replication 中充当副本。通过比较影响replicated的语句执行前后这些状态变量的值
NDB表，您可以观察副本在 NDB API 级别上采取的相应操作，这在监视或故障排除 NDB Cluster 复制时非常有用。第 23.6.14 节，“NDB API 统计计数器和变量”，提供了额外的信息。
从导航台复制到非导航台表。
可以使用其他 MySQL 存储引擎（例如或
在副本
mysqldNDB上）将
表从充当复制源的 NDB Cluster 复制到表
。这取决于许多条件；有关详细信息，请参阅
从 NDB 到其他存储引擎的复制和
从 NDB 到非事务性存储引擎的复制。
InnoDBMyISAM
© Mysql 中文网
