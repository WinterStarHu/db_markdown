# 18.4 监控组复制_MySQL 8.0 参考手册

18.4 监控组复制_MySQL 8.0 参考手册
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
18.1 组复制背景
18.2 开始
18.3 要求和限制
18.4 监控组复制
18.4.1 GTID 和组复制1
18.4.2 组复制服务器状态1
18.4.3 replication_group_members 表1
18.4.4 replication_group_member_stats 表1
18.5 组复制操作
18.6 组复制安全
18.7 组复制性能和故障排除
18.8 升级组复制
18.9 组复制系统变量
18.10 常见问题
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
MySQL 8.0 参考手册  / 第十八章 组复制  /
18.4 监控组复制
18.4 监控组复制
18.4.1 GTID 和组复制18.4.2 组复制服务器状态18.4.3 replication_group_members 表18.4.4 replication_group_member_stats 表
假设
启用了性能模式，请使用性能模式表来监视组复制。下表显示特定于组复制的信息：
performance_schema.replication_group_member_stats
performance_schema.replication_group_members
请参阅第 18.4.3 节，“replication_group_members 表”和
第 18.4.4 节，“replication_group_member_stats 表”，它们讨论了解释这些表中可用的信息。
这些 Performance Schema 复制表还显示了与 Group Replication 相关的信息：
performance_schema.replication_connection_status
显示有关组复制的信息，例如已从组接收并在应用程序队列（中继日志）中排队的事务。
performance_schema.replication_applier_status
显示组复制相关通道和线程的状态。如果有许多不同的工作线程在应用事务，那么工作表也可以用来监视每个工作线程在做什么。
此处列出了由 Group Replication 插件创建的复制通道：
group_replication_recovery- 此通道用于与分布式恢复阶段相关的复制更改。
group_replication_applier- 此通道用于来自组的传入更改。这是用于应用直接来自集团的交易的渠道。
从 MySQL 8.0.21 开始，非错误情况的组复制生命周期事件被归类为系统消息，并且始终记录到复制组成员上的服务器错误日志中。您可以使用此信息来查看服务器在复制组中的成员身份的历史记录。在以前的版本中，非错误情况的 Group Replication 生命周期事件被归类为信息消息，可以通过
log_error_verbosity为服务器指定级别 3 将其添加到错误日志中。
一些影响整个组的生命周期事件记录在每个组成员上，例如新成员进入
ONLINE组状态或初选。其他事件仅记录在发生它们的成员上，例如在成员上启用或禁用超级只读模式，或者成员离开组。许多生命周期事件如果频繁发生则可以指示问题，这些事件将记录为警告消息，包括成员变得不可访问和再次可访问，以及成员通过二进制日志的状态传输或远程克隆操作开始分布式恢复。
笔记
如果您正在使用
mysqladmin监视一个或多个辅助实例，您应该知道
FLUSH STATUS此实用程序执行的语句会在本地实例上创建一个 GTID 事件，这可能会影响未来的组操作。
© Mysql 中文网
