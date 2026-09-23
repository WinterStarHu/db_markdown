# 18.3.2 组复制限制_MySQL 8.0 参考手册

18.3.2 组复制限制_MySQL 8.0 参考手册
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
18.3.1 组复制要求1
18.3.2 组复制限制1
18.4 监控组复制
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
MySQL 8.0 参考手册  / 第十八章 组复制  / 18.3 要求和限制  /
18.3.2 组复制限制
18.3.2 组复制限制
团体人数限制交易规模限制
组复制存在以下已知限制。请注意，在故障转移事件期间，针对多主模式组描述的限制和问题也适用于单主模式集群，而新选出的主模式会从旧主模式中清除其应用程序队列。
小费
组复制建立在基于 GTID 的复制之上，因此您还应该了解
第 17.1.3.7 节，“使用 GTID 进行复制的限制”。
--upgrade=MINIMAL选项。
在使用 MINIMAL 选项 ( ) 的 MySQL 服务器升级后，无法启动组复制--upgrade=MINIMAL，这不会升级复制内部所依赖的系统表。
缝隙锁。
Group Replication 的并发事务认证过程不考虑
间隙锁，因为关于间隙锁的信息在 之外不可用
InnoDB。有关详细信息，请参阅
间隙锁。
笔记
REPEATABLE READ对于多主模式下的组，除非您在应用程序中
依赖
语义，否则我们建议使用READ COMMITTEDGroup Replication 的隔离级别。InnoDB 不使用间隙锁READ COMMITTED，这使得 InnoDB 内部的本地冲突检测与 Group Replication 执行的分布式冲突检测保持一致。对于单主模式的组，只有主接受写入，因此READ
COMMITTED隔离级别对组复制并不重要。
表锁和命名锁。
认证过程不考虑表锁（请参阅第 13.3.6 节，“LOCK TABLES 和 UNLOCK TABLES 语句”）或命名锁（请参阅参考资料GET_LOCK()）。
二进制日志校验和。
在 MySQL 8.0.20 之前，Group Replication 无法使用校验和，也不支持它们存在于二进制日志中，因此您必须
binlog_checksum=NONE在配置服务器实例时设置为组成员。从 MySQL 8.0.21 开始，Group Replication 支持校验和，因此组成员可以使用默认设置
binlog_checksum=CRC32。组的所有成员的设置binlog_checksum
不必相同。
当校验和可用时，Group Replication 不会使用它们来验证
group_replication_applier通道上的传入事件，因为事件从多个源写入中继日志，并且在它们实际写入原始服务器的二进制日志之前，即生成校验和时. 校验和用于验证
group_replication_recovery通道和组成员上任何其他复制通道上事件的完整性。
可串行化隔离级别。
SERIALIZABLE默认情况下，多主组不支持隔离级别。设置事务隔离级别来
SERIALIZABLE配置 Group Replication 以拒绝提交事务。
并发 DDL 与 DML 操作。
使用多主模式时，不支持针对同一对象但在不同服务器上执行的并发数据定义语句和数据操作语句。在对象上执行数据定义语言 (DDL) 语句期间，在同一对象但在不同的服务器实例上执行并发数据操作语言 (DML) 存在在未检测到的不同实例上执行的冲突 DDL 的风险。
具有级联约束的外键。
多主模式组（成员都配置了
group_replication_single_primary_mode=OFF）不支持多级外键依赖的表，特别是定义了
CASCADING
外键约束的表。这是因为导致多主模式组执行级联操作的外键约束可能导致未检测到的冲突，并导致组成员之间的数据不一致。因此，我们建议
group_replication_enforce_update_everywhere_checks=ON
在多主模式组中使用的服务器实例上进行设置，以避免未检测到的冲突。
在单主模式下，这不是问题，因为它不允许并发写入组的多个成员，因此不存在未检测到的冲突风险。
多主模式死锁。
当一个组在多主模式下运行时，
SELECT .. FOR UPDATE语句可能会导致死锁。这是因为锁未在组成员之间共享，因此可能无法达到对此类语句的期望。
复制过滤器。
全局复制过滤器不能在为组复制配置的 MySQL 服务器实例上使用，因为在某些服务器上过滤事务会使组无法就一致状态达成一致。特定于通道的复制过滤器可用于不直接与组复制相关的复制通道，例如组成员也充当组外源的副本。它们不能用于group_replication_applier
或group_replication_recovery频道。
加密连接。
从 MySQL 8.0.16 开始，MySQL 服务器支持 TLSv1.3 协议，前提是 MySQL 是使用 OpenSSL 1.1.1 或更高版本编译的。在 MySQL 8.0.16 和 MySQL 8.0.17 中，如果服务器支持 TLSv1.3，则该协议在 group 通信引擎中不支持，无法被 Group Replication 使用。Group Replication 从 MySQL 8.0.18 开始支持 TLSv1.3，可用于组通信连接和分布式恢复连接。
在 MySQL 8.0.18 中，TLSv1.3 可以用于 Group Replication 用于分布式恢复连接，但是
group_replication_recovery_tls_version
和
group_replication_recovery_tls_ciphersuites
系统变量不可用。因此，捐赠者服务器必须允许使用至少一个默认启用的 TLSv1.3 密码套件，如
第 6.3.2 节“加密连接 TLS 协议和密码”中所列。从 MySQL 8.0.19 开始，您可以使用选项为任何选择的密码套件配置客户端支持，如果需要，仅包括非默认密码套件。
克隆操作。
Group Replication 启动和管理用于分布式恢复的克隆操作，但已设置为支持克隆的组成员也可以参与用户手动启动的克隆操作。在 MySQL 8.0.20 之前的版本中，如果操作涉及正在运行组复制的组成员，则无法手动启动克隆操作。从 MySQL 8.0.20 开始，您可以执行此操作，前提是克隆操作不会删除和替换收件人上的数据。因此，启动克隆操作的语句必须包含
DATA DIRECTORYif Group Replication is running 子句。看
第 18.5.4.2.4 节，“为其他目的克隆”。
团体人数限制
可以成为单个复制组成员的 MySQL 服务器的最大数量是 9。如果更多成员试图加入该组，他们的请求将被拒绝。这个限制已经从测试和基准测试中确定为一个安全边界，在该边界中，该组可以在稳定的局域网上可靠地运行。
交易规模限制
如果单个事务导致消息内容大到无法在 5 秒窗口内通过网络在组成员之间复制消息，则成员可以被怀疑失败，然后被驱逐，因为他们正忙于处理事务交易。由于内存分配问题，大型事务也可能导致系统变慢。为避免这些问题，请使用以下缓解措施：
如果由于大量消息而发生不必要的驱逐，请使用系统变量
group_replication_member_expel_timeout
在被怀疑失败的成员被驱逐之前留出额外的时间。在最初的 5 秒检测期之后，您最多可以等待一个小时，然后才能将可疑成员从组中驱逐出去。从 MySQL 8.0.21 开始，默认允许额外 5 秒。
在可能的情况下，在 Group Replication 处理事务之前尝试限制事务的大小。例如，将使用的文件拆分LOAD DATA成更小的块。
使用系统变量
group_replication_transaction_size_limit
指定组接受的最大交易大小。在 MySQL 8.0 中，此系统变量默认为最大事务大小 150000000 字节（约 143 MB）。超过此大小的事务将被回滚，并且不会发送到组复制的组通信系统（GCS）以分发给组。根据您需要组容忍的最大消息大小调整此变量的值，请记住处理事务所花费的时间与其大小成正比。
使用系统变量
group_replication_compression_threshold
指定消息大小，超过该大小应用压缩。此系统变量默认为 1000000 字节 (1 MB)，因此会自动压缩大消息。Group Replication 的 Group Communication System (GCS) 在收到
group_replication_transaction_size_limit
设置允许但超出
group_replication_compression_threshold
设置的消息时执行压缩。有关详细信息，请参阅
第 18.7.4 节，“消息压缩”。
使用系统变量
group_replication_communication_max_message_size
指定一个消息大小，超过该大小的消息将被分段。此系统变量默认为 10485760 字节 (10 MiB)，因此大消息会自动分段。如果压缩后的消息仍然超过
group_replication_communication_max_message_size
限制，GCS 会在压缩后进行分片。一个复制组要使用分片，所有组成员必须是 MySQL 8.0.16 或更高版本，并且该组使用的组复制通信协议版本必须允许分片。有关详细信息，请参阅
第 18.7.5 节，“消息碎片”。
最大事务大小、消息压缩和消息碎片都可以通过为相关系统变量指定零值来停用。如果您已停用所有这些保护措施，则复制组成员上的应用程序线程可以处理的消息的大小上限是成员的
replica_max_allowed_packet或
slave_max_allowed_packet系统变量，默认值和最大值为 1073741824 字节 (1 GB)。当接收成员尝试处理超过此限制的消息时，该消息将失败。组成员可以发起并尝试传输到组的消息的大小上限为 4294967295 字节（大约 4 GB）。这是组复制的组通信引擎（XCom，一种 Paxos 变体）接受的数据包大小的硬性限制，它在 GCS 处理消息后接收消息。超过此限制的消息在发起成员尝试广播时失败。
© Mysql 中文网
