# 18.7.5 消息分片_MySQL 8.0 参考手册

18.7.5 消息分片_MySQL 8.0 参考手册
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
18.7.5 消息分片
18.7.5 消息分片
当 Group Replication 组成员之间发送异常大的消息时，可能会导致部分组成员被报告为失败并被驱逐出组。这是因为 Group Replication 的组通信引擎（XCom，Paxos 的变体）使用的单线程被占用处理消息的时间太长，因此部分组成员可能会报告接收者失败。从 MySQL 8.0.16 开始，默认情况下，大消息会自动拆分为单独发送的片段，并由收件人重新组装。
系统变量
group_replication_communication_max_message_size
指定组复制通信的最大消息大小，超过该大小的消息将被分段。默认最大消息大小为 10485760 字节 (10 MiB)。最大允许值与
replica_max_allowed_packet和
slave_max_allowed_packet
系统变量的最大值相同，为 1073741824 字节 (1 GB)。的设置
group_replication_communication_max_message_size
必须小于
replica_max_allowed_packet或
slave_max_allowed_packet
设置，因为应用程序线程无法处理大于最大允许数据包大小的消息片段。要关闭碎片，请为 指定一个零值
group_replication_communication_max_message_size。
与大多数其他 Group Replication 系统变量一样，您必须重新启动 Group Replication 插件才能使更改生效。例如：
STOP GROUP_REPLICATION;
SET GLOBAL group_replication_communication_max_message_size= 5242880;
START GROUP_REPLICATION;
当消息的所有片段都已被所有组成员接收并重新组装时，片段消息的消息传递被认为是完整的。分段消息在其标头中包含信息，使成员能够在消息传输期间加入以恢复在其加入之前发送的较早片段。如果加入的成员未能恢复碎片，它将自己从该组中驱逐。
一个复制组要使用分片，所有组成员必须是 MySQL 8.0.16 或更高版本，并且该组使用的组复制通信协议版本必须允许分片。您可以使用该函数检查组正在使用的通信协议，该
group_replication_get_communication_protocol()
函数返回该组支持的最旧的 MySQL 服务器版本。MySQL 5.7.14 版本允许消息压缩，MySQL 8.0.16 版本也允许消息分片。如果所有群成员都是MySQL 8.0.16及以上版本，并且没有要求允许早期版本的成员加入，可以使用
group_replication_set_communication_protocol()
函数设置通信协议版本为MySQL 8.0.16或以上，以允许分片。有关详细信息，请参阅第 18.5.1.4 节，“设置组的通信协议版本”。
如果一个复制组因为某些成员不支持而不能使用分片，系统变量
group_replication_transaction_size_limit
可以用来限制该组接受的事务的最大大小。在 MySQL 8.0 中，默认设置约为 143 MB。回滚超过此大小的事务。您还可以使用系统变量
group_replication_member_expel_timeout
在怀疑失败的成员被驱逐出组之前允许额外的时间（最多一个小时）。
© Mysql 中文网
