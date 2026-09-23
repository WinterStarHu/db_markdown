# 18.3.1 组复制要求_MySQL 8.0 参考手册

18.3.1 组复制要求_MySQL 8.0 参考手册
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
18.3.1 组复制要求
18.3.1 组复制要求
基础设施服务器实例配置
要用于组复制的服务器实例必须满足以下要求。
基础设施
InnoDB 存储引擎。
数据必须存储在
InnoDB事务存储引擎中。事务以乐观的方式执行，然后在提交时检查冲突。如果有冲突，为了保持整个组的一致性，一些事务被回滚。这意味着需要一个事务存储引擎。此外，
InnoDB
还提供了一些额外的功能，可以在与 Group Replication 一起运行时更好地管理和处理冲突。使用其他存储引擎，包括临时
MEMORY存储引擎，可能会导致组复制错误。InnoDB
在将实例与组复制一起使用之前，转换其他存储引擎中的任何表以供
使用。您可以通过在组成员上设置系统变量来阻止使用其他存储引擎
disabled_storage_engines
，例如：
disabled_storage_engines="MyISAM,BLACKHOLE,FEDERATED,ARCHIVE,MEMORY"主键。
该组要复制的每个表都必须有一个已定义的主键，或主键等效项，其中等效项是非空唯一键。需要这样的键作为表中每一行的唯一标识符，使系统能够通过准确识别每个事务修改了哪些行来确定哪些事务发生冲突。Group Replication 有自己内置的主键或主键等效检查集，并且不使用
sql_require_primary_key
系统变量执行的检查。你可以设置
sql_require_primary_key=ON对于运行 Group Replication 的服务器实例，您可以设置|的REQUIRE_TABLE_PRIMARY_KEY_CHECK
选项 组复制通道的语句 。但是，请注意，您可能会发现某些在组复制的内置检查下允许的事务在您设置
或
时执行的检查下是不允许的。
CHANGE REPLICATION
SOURCE TOCHANGE MASTER
TOONsql_require_primary_key=ONREQUIRE_TABLE_PRIMARY_KEY_CHECK=ON网络性能。
MySQL Group Replication 旨在部署在服务器实例彼此非常接近的集群环境中。组的性能和稳定性会受到网络延迟和网络带宽的影响。所有小组成员之间必须始终保持双向沟通。如果服务器实例的入站或出站通信被阻止（例如，被防火墙或连接问题），则该成员无法在组中运行，并且组成员（包括有问题的成员）可能无法为受影响的服务器实例报告正确的成员状态。
从 MySQL 8.0.14 开始，您可以使用 IPv4 或 IPv6 网络基础设施，或两者的混合，用于远程组复制服务器之间的 TCP 通信。也没有什么可以阻止组复制在虚拟专用网络 (VPN) 上运行。
同样从 MySQL 8.0.14 开始，Group Replication 服务器实例位于同一位置并共享本地组通信引擎 (XCom) 实例，尽可能使用具有较低开销的专用输入通道而不是 TCP 套接字进行通信。对于某些需要在远程 XCom 实例之间进行通信的 Group Replication 任务，例如加入一个组，仍然使用 TCP 网络，因此网络性能会影响组的性能。
服务器实例配置
以下选项必须配置为组成员的服务器实例上所示。
唯一服务器标识符。
根据复制拓扑中所有服务器的需要，使用server_id系统变量为服务器配置唯一的服务器 ID。服务器 ID 必须是介于 1 和 (2 32 )−1 之间的正整数，并且它必须不同于复制拓扑中任何其他服务器使用的每个其他服务器 ID。
二进制日志活动。
设置
--log-bin[=log_file_name]。从 MySQL 8.0 开始，二进制日志默认启用，除非您想更改二进制日志文件的名称，否则无需指定此选项。Group Replication 复制二进制日志的内容，因此二进制日志需要打开才能运行。请参阅
第 5.4.4 节，“二进制日志”。
已记录副本更新。
设置
log_replica_updates=ON
（从 MySQL 8.0.26 开始）或
log_slave_updates=ON
（在 MySQL 8.0.26 之前）。从 MySQL 8.0 开始，这个设置是默认的，所以你不需要指定它。组成员需要记录在加入时从捐赠者那里收到并通过复制应用程序应用的事务，并记录他们从组中收到和应用的所有事务。这使得 Group Replication 能够通过从现有组成员的二进制日志进行状态传输来执行分布式恢复。
二进制日志行格式。
设置binlog_format=row。此设置为默认设置，因此您无需指定。Group Replication 依靠基于行的复制格式在组中的服务器之间一致地传播更改，并提取必要的信息来检测在组中的不同服务器中并发执行的事务之间的冲突。从 MySQL 8.0.19 开始，该REQUIRE_ROW_FORMAT设置会自动添加到组复制的通道中，以在应用事务时强制使用基于行的复制。请参阅
第 17.2.1 节，“复制格式”和
第 17.3.3 节，“复制权限检查”。
二进制日志校验和关闭（到 MySQL 8.0.20）。
直到并包括 MySQL 8.0.20，设置
binlog_checksum=NONE. 在这些版本中，Group Replication 无法使用校验和并且不支持它们存在于二进制日志中。从 MySQL 8.0.21 开始，Group Replication 支持 checksums，所以 group 成员可以使用默认设置
binlog_checksum=CRC32，不需要你指定。
全局事务标识符打开。
设置gtid_mode=ON和
enforce_gtid_consistency=ON。这些设置不是默认设置。组复制需要基于 GTID 的复制，它使用全局事务标识符来跟踪已在组中每个服务器实例上提交的事务。请参阅第 17.1.3 节，“使用全局事务标识符进行复制”。
复制信息存储库。
设置
master_info_repository=TABLE
和
relay_log_info_repository=TABLE。在 MySQL 8.0 中，这些设置是默认设置，并且该
FILE设置已弃用。从 MySQL 8.0.23 开始，不推荐使用这些系统变量，因此省略系统变量并只允许默认值。复制应用程序需要将复制元数据写入
系统表mysql.slave_master_info，
mysql.slave_relay_log_info以确保组复制插件具有一致的可恢复性和复制元数据的事务管理。看
第 17.2.4.2 节，“复制元数据存储库”。
事务写集提取。
设置
transaction_write_set_extraction=XXHASH64
以便在收集行以将它们记录到二进制日志时，服务器也收集写集。在 MySQL 8.0 中，此设置是默认设置，从 MySQL 8.0.26 开始，系统变量的使用已被弃用。写入集基于每行的主键，是一个简化且紧凑的标签视图，可以唯一标识已更改的行。组复制使用此信息对所有组成员进行冲突检测和认证。
默认表加密。 default_table_encryption
对所有组成员
设置
相同的值。默认架构和表空间加密可以启用 ( ON) 或禁用（OFF，默认值），只要所有成员的设置都相同。
小写表名称。 lower_case_table_names对所有组成员
设置
相同的值。设置为 1 对于存储引擎的使用是正确的
InnoDB，这是组复制所必需的。请注意，此设置并非所有平台上的默认设置。
二进制日志依赖跟踪。
设置
binlog_transaction_dependency_tracking=WRITESET_SESSION
可以提高组成员的性能，具体取决于组的工作量。当从中继日志应用事务时，Group Replication 在认证后执行自己的并行化，独立于为 设置的值
binlog_transaction_dependency_tracking。然而，价值
binlog_transaction_dependency_tracking
确实会影响将事务写入组复制成员上的二进制日志的方式。这些日志中的依赖信息用于协助从捐赠者的二进制日志进行状态传输以进行分布式恢复，每当成员加入或重新加入组时都会发生这种情况。
多线程应用程序。
Group Replication 成员可以配置为多线程副本，使事务能够并行应用。从 MySQL 8.0.27 开始，所有副本默认配置为多线程。系统变量的非零值
replica_parallel_workers
（来自 MySQL 8.0.26）或
slave_parallel_workers
（在 MySQL 8.0.26 之前）在成员上启用多线程应用程序。MySQL 8.0.27 默认是 4 个并行应用程序线程，最多可以指定 1024 个并行应用程序线程。对于多线程副本，还需要以下设置，这是 MySQL 8.0.27 的默认设置：
replica_preserve_commit_order=ON
（来自 MySQL 8.0.26）或
slave_preserve_commit_order=ON
（MySQL 8.0.26 之前）
需要此设置以确保并行事务的最终提交与原始事务的顺序相同。Group Replication 依赖于围绕所有参与成员以相同顺序接收和应用已提交事务的保证而构建的一致性机制。
replica_parallel_type=LOGICAL_CLOCK
（来自 MySQL 8.0.26）或
slave_parallel_type=LOGICAL_CLOCK
（MySQL 8.0.26 之前）
replica_preserve_commit_order=ON
使用或
需要此设置
slave_preserve_commit_order=ON。它指定用于决定允许哪些事务在副本上并行执行的策略。
设置
replica_parallel_workers=0
或slave_parallel_workers=0
禁用并行执行并为副本提供单个应用程序线程而没有协调程序线程。使用该设置，replica_parallel_type
orslave_parallel_type和
replica_preserve_commit_order
or
slave_preserve_commit_order
选项无效并被忽略。从 MySQL 8.0.27 开始，如果在副本上使用 GTID 时禁用并行执行，则副本实际上使用一个并行工作程序，以利用在不访问文件位置的情况下重试事务的方法。但是，此行为不会为用户改变任何内容。
分离的 XA 事务。
MySQL 8.0.29 及更高版本支持分离的 XA 事务。分离事务是一种一旦准备好就不再连接到当前会话的事务。这作为执行的一部分自动发生
XA
PREPARE。准备好的 XA 事务可以被另一个连接提交或回滚，然后当前会话可以发起另一个 XA 事务或本地事务，而无需等待刚刚准备好的事务完成。
当启用分离的 XA 事务支持 ( xa_detach_on_prepare = ON) 时，到此服务器的任何连接都可以列出（使用XA
RECOVER）、回滚或提交任何准备好的 XA 事务。此外，您不能在分离的 XA 事务中使用临时表。
xa_detach_on_prepare您可以通过设置为
禁用对分离的 XA 事务的支持
OFF，但不建议这样做。特别是，如果此服务器被设置为 MySQL 组复制中的一个实例，则应将此变量设置为其默认值 ( ON)。
有关详细信息，请参阅第 13.3.8.2 节，“XA 事务状态”。
© Mysql 中文网
