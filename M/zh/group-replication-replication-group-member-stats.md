# 18.4.4 replication_group_member_stats 表_MySQL 8.0 参考手册

18.4.4 replication_group_member_stats 表_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第十八章 组复制  / 18.4 监控组复制  /
18.4.4 replication_group_member_stats 表
18.4.4 replication_group_member_stats 表
复制组中的每个成员都证明并应用该组接收到的事务。有关验证者和应用程序过程的统计信息有助于了解应用程序队列如何增长、发现了多少冲突、检查了多少事务、哪些事务在各处提交，等等。
该
performance_schema.replication_group_member_stats
表提供了与认证过程相关的组级信息，以及复制组中每个单独成员接收和发起的事务的统计信息。该信息在作为复制组成员的所有服务器实例之间共享，因此可以从任何成员查询有关所有组成员的信息。请注意，远程成员的统计信息刷新由
group_replication_flow_control_period
选项中指定的消息周期控制，因此这些信息可能与本地收集的查询成员统计信息略有不同。要使用此表来监视组复制成员，请发出以下语句：
mysql> SELECT * FROM performance_schema.replication_group_member_stats\G
从MySQL 8.0.19开始，还可以使用如下语句：
mysql> TABLE performance_schema.replication_group_member_stats\G
这些列对于监视组中连接的成员的性能很重要。假设该组的一个成员总是报告其队列中的交易数量比其他成员多。这意味着该成员被延迟并且无法与组中的其他成员保持同步。根据此信息，您可以决定从组中删除该成员，或者延迟对组中其他成员的事务处理，以减少排队事务的数量。此信息还可以帮助您决定如何调整 Group Replication 插件的流量控制，请参阅
第 18.7.2 节，“流量控制”。
© Mysql 中文网
