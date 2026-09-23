# 17.4.11 延迟复制_MySQL 8.0 参考手册

17.4.11 延迟复制_MySQL 8.0 参考手册
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
17.1 配置复制
17.2 复制实现
17.3 复制安全
17.4 复制解决方案
17.4.1 使用复制进行备份1
17.4.2 处理副本的意外停止1
17.4.3 监控基于行的复制1
17.4.4 使用不同源和副本存储引擎的复制1
17.4.5 使用复制进行横向扩展1
17.4.6 将不同的数据库复制到不同的副本1
17.4.7 提高复制性能1
17.4.8 在故障转移期间切换源1
17.4.9 使用异步连接故障转移切换源和副本1
17.4.10 半同步复制1
17.4.11 延迟复制1
17.5 复制注意事项和技巧
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
MySQL 8.0 参考手册  / 第十七章复制  / 17.4 复制解决方案  /
17.4.11 延迟复制
17.4.11 延迟复制
MySQL 支持延迟复制，这样副本服务器故意比源服务器晚至少指定的时间执行事务。本节介绍如何在副本上配置复制延迟，以及如何监控复制延迟。
在 MySQL 8.0 中，延迟复制的方法取决于两个时间戳，
immediate_commit_timestamp和
original_commit_timestamp（请参阅
复制延迟时间戳）。如果复制拓扑中的所有服务器都运行 MySQL 8.0 或更高版本，则使用这些时间戳测量延迟复制。如果直接源或副本未使用这些时间戳，则使用 MySQL 5.7 的延迟复制实现（请参阅
延迟复制）。本节描述了所有使用这些时间戳的服务器之间的延迟复制。
默认复制延迟为 0 秒。使用
语句（从MySQL 8.0.23开始）或语句（MySQL 8.0.23之前）将延迟设置为
秒。从源接收到的事务直到至少
比它在直接源上的提交晚几秒才会执行。延迟发生在每个事务（不像以前的 MySQL 版本中的事件），实际延迟仅强加于or
。交易中的其他事件总是跟在这些事件之后，没有任何等待时间强加给它们。
CHANGE
REPLICATION SOURCE TO
SOURCE_DELAY=NCHANGE MASTER TO
MASTER_DELAY=NNNgtid_log_eventanonymous_gtid_log_event
笔记
START
REPLICA并
STOP
REPLICA立即生效，忽略任何延迟。
RESET
REPLICA将延迟重置为 0。
replication_applier_configuration
Performance Schema 表包含
显示使用|
DESIRED_DELAY配置的延迟
的列 选项。
性能模式表包含
显示剩余延迟秒数的列
。
SOURCE_DELAYMASTER_DELAYreplication_applier_statusREMAINING_DELAY
延迟复制可用于多种目的：
防止用户在源上犯错。通过延迟，您可以将延迟的副本回滚到错误之前的时间。
测试系统在出现滞后时的行为。例如，在应用程序中，滞后可能是由副本上的负载过重引起的。但是，可能很难生成此负载级别。延迟复制可以模拟滞后，而不必模拟负载。它还可用于调试与滞后副本相关的条件。
检查数据库过去的样子，而无需重新加载备份。例如，通过将副本配置为延迟一周，如果您随后需要查看数据库在最近几天的开发之前的样子，则可以检查延迟的副本。
复制延迟时间戳
MySQL 8.0 提供了一种新的方法来测量复制拓扑中的延迟（也称为复制滞后），该方法取决于与写入二进制日志的每个事务（而不是每个事件）的 GTID 关联的以下时间戳。
original_commit_timestamp：自纪元以来事务被写入（提交）到原始源的二进制日志的微秒数。
immediate_commit_timestamp：自纪元以来事务被写入（提交）到直接源的二进制日志的微秒数。
mysqlbinlog
的输出以两种格式显示这些时间戳，一种是纪元微秒，另
TIMESTAMP一种是基于用户定义的时区以提高可读性的格式。例如：
#170404 10:48:05 server id 1  end_log_pos 233 CRC32 0x016ce647     GTID    last_committed=0
\ sequence_number=1    original_committed_timestamp=1491299285661130    immediate_commit_timestamp=1491299285843771
# original_commit_timestamp=1491299285661130 (2017-04-04 10:48:05.661130 WEST)
# immediate_commit_timestamp=1491299285843771 (2017-04-04 10:48:05.843771 WEST)
/*!80001 SET @@SESSION.original_commit_timestamp=1491299285661130*//*!*/;
SET @@SESSION.GTID_NEXT= 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa:1'/*!*/;
# at 233
通常，在original_commit_timestamp应用事务的所有副本上始终相同。在源副本复制
中， original_commit_timestamp（原始）源的二进制日志中事务的 始终与其相同
immediate_commit_timestamp。在副本的中继日志中，事务的
original_commit_timestamp和
immediate_commit_timestamp与源的二进制日志中的相同；而在它自己的二进制日志中，事务
immediate_commit_timestamp对应于副本提交事务的时间。
在组复制设置中，当原始源是组的成员时，将
original_commit_timestamp在事务准备好提交时生成。换句话说，当它完成对原始源的执行并且它的写集准备好发送给组的所有成员以进行认证时。当原始来源是组外的服务器时，将original_commit_timestamp保留。特定事务的相同original_commit_timestamp
内容将复制到组中的所有服务器，以及从成员复制的组外的任何副本。从 MySQL 8.0.26 开始，事务的每个接收者还使用immediate_commit_timestamp.
Group Replication 独有的视图更改事件是一种特殊情况。包含这些事件的事务由每个组成员生成，但共享相同的 GTID（因此，它们不是首先在源中执行然后复制到组，而是组的所有成员执行并应用相同的事务）。在 MySQL 8.0.26 之前，这些事务都
original_commit_timestamp设置为零，并且它们以这种方式出现在可见的输出中。从 MySQL 8.0.26 开始，为了提高可观察性，组成员为与视图更改事件关联的事务设置本地时间戳值。
监控复制延迟
Seconds_Behind_Master在以前的 MySQL 版本中，监视复制延迟（滞后）的最常见方法之一
是依赖
SHOW REPLICA
STATUS. 但是，当使用比传统的源副本设置更复杂的复制拓扑时（例如组复制），此指标不适用。向 MySQL 8添加
immediate_commit_timestamp和
original_commit_timestamp提供了有关复制延迟的更精细程度的信息。在支持这些时间戳的拓扑中监视复制延迟的推荐方法是使用以下性能模式表。
replication_connection_status：与源连接的当前状态，提供有关连接线程排队到中继日志的最后一个和当前事务的信息。
replication_applier_status_by_coordinator：协调器线程的当前状态，仅在使用多线程副本时显示信息，提供有关协调器线程缓冲到工作队列的最后一个事务的信息，以及它当前正在缓冲的事务。
replication_applier_status_by_worker：应用从源接收的事务的线程的当前状态，提供有关复制 SQL 线程或每个工作线程在使用多线程副本时应用的事务的信息。
使用这些表，您可以监视有关相应线程处理的最后一个事务和该线程当前正在处理的事务的信息。该信息包括：
事务的 GTID
事务的original_commit_timestamp
and immediate_commit_timestamp，从副本的中继日志中检索
线程开始处理事务的时间
对于最后处理的事务，线程完成处理它的时间
除了 Performance Schema 表之外，输出
SHOW
REPLICA STATUS还有三个字段显示：
SQL_Delay：一个非负整数，表示使用
（从 MySQL 8.0.23 开始）或（在 MySQL 8.0.23 之前）配置的复制延迟，以秒为单位。
CHANGE
REPLICATION SOURCE TO
SOURCE_DELAY=NCHANGE MASTER TO
MASTER_DELAY=N
SQL_Remaining_Delay：当
Replica_SQL_Running_State为
时Waiting until MASTER_DELAY seconds after master
executed event，此字段包含一个整数，指示延迟剩余的秒数。在其他时候，这个字段是NULL。
Replica_SQL_Running_State：指示 SQL 线程状态的字符串（类似于
Replica_IO_State）。该值与State显示的 SQL 线程的值相同SHOW
PROCESSLIST。
当复制 SQL 线程在执行事件之前等待延迟结束时，SHOW
PROCESSLIST将其State
值显示为Waiting until MASTER_DELAY seconds after
master executed event。
© Mysql 中文网
