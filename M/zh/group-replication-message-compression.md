# 18.7.4 消息压缩_MySQL 8.0 参考手册

18.7.4 消息压缩_MySQL 8.0 参考手册
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
18.7.4 消息压缩
18.7.4 消息压缩
对于在线组成员之间发送的消息，Group Replication 默认启用消息压缩。是否压缩特定消息取决于您使用
group_replication_compression_threshold
系统变量配置的阈值。有效负载大于指定字节数的消息将被压缩。
默认压缩阈值为 1000000 字节。您可以使用以下语句将压缩阈值增加到 2MB，例如：
STOP GROUP_REPLICATION;
SET GLOBAL group_replication_compression_threshold = 2097152;
START GROUP_REPLICATION;
如果设置
group_replication_compression_threshold
为零，则禁用消息压缩。
Group Replication 使用 LZ4 压缩算法来压缩组中发送的消息。请注意，LZ4 压缩算法支持的最大输入大小为 2113929216 字节。此限制低于
group_replication_compression_threshold
系统变量的最大可能值，该值与 XCom 接受的最大消息大小相匹配。因此，LZ4 最大输入大小是消息压缩的实际限制，启用消息压缩时无法提交超过此大小的事务。使用 LZ4 压缩算法时，不要为 . 设置大于 2113929216 字节的值
group_replication_compression_threshold。
group_replication_compression_threshold
Group Replication 不要求
的值
在所有组成员上都相同。但是，建议为所有组成员设置相同的值，以避免不必要的事务回滚、消息传递失败或消息恢复失败。
从 MySQL 8.0.18 开始，您还可以通过来自捐赠者二进制日志的状态传输方法为分布式恢复发送的消息配置压缩。group_replication_recovery_compression_algorithms
这些消息的压缩是从已经在组中的捐赠者发送到加入成员的，使用和
group_replication_recovery_zstd_compression_level
系统变量单独控制
。有关更多信息，请参阅
第 4.2.8 节，“连接压缩控制”。
由系统变量激活的二进制日志事务压缩（自 MySQL 8.0.20 起可用）
binlog_transaction_compression
也可用于节省带宽。当交易有效负载在组成员之间传输时，它们会保持压缩状态。如果您将二进制日志事务压缩与 Group Replication 的消息压缩结合使用，则消息压缩对数据起作用的机会较少，但仍可以压缩标头以及那些未压缩的事件和事务有效负载。有关二进制日志事务压缩的更多信息，请参阅
第 5.4.4.5 节，“二进制日志事务压缩”。
在组中发送的消息的压缩发生在组通信引擎级别，在数据移交给组通信线程之前，因此它发生在mysql用户会话线程的上下文中。如果消息负载大小超过 设置的阈值
group_replication_compression_threshold，事务负载在发送到组之前被压缩，并在接收时解压缩。收到消息后，成员检查消息信封以验证它是否被压缩。如果需要，则成员解压缩事务，然后再将其传递给上层。这个过程如下图所示。
图 18.13 压缩支持
当网络带宽成为瓶颈时，消息压缩可以在组通信级别提供高达 30-40% 的吞吐量提升。这在负载大量服务器的情况下尤为重要。组中N个参与者之间互连的 TCP 点对点性质
使得发送方发送相同数量的数据N次。此外，二进制日志很可能表现出高压缩率。这使得压缩成为包含大型事务的组复制工作负载的一项引人注目的功能。
© Mysql 中文网
