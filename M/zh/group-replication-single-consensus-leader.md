# 18.7.3 单一共识领导者_MySQL 8.0 参考手册

18.7.3 单一共识领导者_MySQL 8.0 参考手册
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
18.5 组复制操作
18.6 组复制安全
18.7 组复制性能和故障排除
18.7.1 微调群组通信线程1
18.7.2 流量控制1
18.7.3 单一共识领导者1
18.7.4 消息压缩1
18.7.5 消息分片1
18.7.6 XCom缓存管理1
18.7.7 对故障检测和网络分区的响应1
18.7.8 处理网络分区和仲裁丢失1
18.7.9 使用性能模式内存检测监控组复制内存使用情况1
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
MySQL 8.0 参考手册  / 第十八章 组复制  / 18.7 组复制性能和故障排除  /
18.7.3 单一共识领导者
18.7.3 单一共识领导者
默认情况下，组复制的组通信引擎（XCom，一种 Paxos 变体）使用复制组的每个成员作为领导者运行。从 MySQL 8.0.27 开始，当组处于单主模式时，组通信引擎可以使用单个领导者来驱动共识。与单个共识领导者一起运行可以提高单主模式下的性能和弹性，尤其是当该组的某些次要成员当前无法访问时。
要使用单个共识领导者，该组必须配置如下：
该组必须处于单主模式。
系统
group_replication_paxos_single_leader
变量必须设置为ON。使用默认设置OFF，该行为被禁用。您必须完全重新启动复制组（引导程序），以便组复制获取对此设置的更改。
Group Replication通信协议版本必须设置为8.0.27或以上。使用该
group_replication_get_communication_protocol()
功能可以查看群组的通讯协议版本。如果正在使用较低版本，则该组不能使用此行为。如果所有群组成员都支持，您可以使用该
group_replication_set_communication_protocol()
功能将群组的通信协议设置为更高版本。MySQL InnoDB Cluster 自动管理通信协议版本。有关详细信息，请参阅
第 18.5.1.4 节，“设置组的通信协议版本”。
当此配置到位时，组复制指示组通信引擎使用组的主要作为单一领导者来推动共识。When a new primary is elected, Group Replication tells the group communication engine to use it instead. 如果主要成员当前不健康，则组通信引擎将使用替代成员作为共识领导者。Performance Schema 表
replication_group_communication_information
显示了当前首选和实际的共识领导者，首选领导者是 Group Replication 的选择，实际领导者是群组通信引擎选择的领导者。
如果该组处于多主模式，具有较低的通信协议版本，或者该行为被
group_replication_paxos_single_leader
设置禁用，则所有成员都被用作领导者以推动共识。在这种情况下，性能模式表
replication_group_communication_information
将所有成员显示为首选领导者和实际领导者。
WRITE_CONSENSUS_SINGLE_LEADER_CAPABLE
Performance Schema 表
中
的字段replication_group_communication_information
显示该组是否支持使用单个领导者，即使
group_replication_paxos_single_leader
当前OFF在查询的成员上设置为。如果组启动时
group_replication_paxos_single_leader
设置为ON，并且其通信协议版本为 MySQL 8.0.27 或更高版本，则该字段设置为 1。此信息仅针对ONLINE或
RECOVERING州的群组成员返回。
© Mysql 中文网
