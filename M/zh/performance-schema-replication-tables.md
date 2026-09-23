# 27.12.11 性能模式复制表_MySQL 8.0 参考手册

27.12.11 性能模式复制表_MySQL 8.0 参考手册
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
第24章分区
第25章存储对象
第 26 章 INFORMATION_SCHEMA 表
第 27 章 MySQL 性能模式
27.1 性能模式快速入门
27.2 性能模式构建配置
27.3 性能模式启动配置
27.4 性能模式运行时配置
27.5 性能模式查询
27.6 性能模式工具命名约定
27.7 性能模式状态监控
27.8 性能模式原子和分子事件
27.9 当前和历史事件的性能模式表
27.10 性能模式语句摘要和采样
27.11 性能模式总表特征
27.12 性能模式表描述
27.12.1 性能模式表参考1
27.12.2 性能模式设置表1
27.12.3 性能模式实例表1
27.12.4 性能模式等待事件表1
27.12.5 性能模式阶段事件表1
27.12.6 性能模式语句事件表1
27.12.7 性能模式事务表1
27.12.8 性能模式连接表1
27.12.9 性能模式连接属性表1
27.12.10 性能模式用户定义的变量表1
27.12.11 性能模式复制表1
27.12.11.1 复制连接配置表
27.12.11.2 复制连接状态表
27.12.11.3 replication_asynchronous_connection_failover 表
27.12.11.4 replication_asynchronous_connection_failover_managed 表
27.12.11.5 replication_applier_configuration 表
27.12.11.6 replication_applier_status 表
27.12.11.7 replication_applier_status_by_coordinator 表
27.12.11.8 replication_applier_status_by_worker 表
27.12.11.9 replication_applier_global_filters 表
27.12.11.10 replication_applier_filters 表
27.12.11.11 复制组成员表
27.12.11.12 replication_group_member_stats 表
27.12.11.13 replication_group_member_actions 表
27.12.11.14 复制组配置版本表
27.12.11.15 复制组通信信息表
27.12.11.16 binary_log_transaction_compression_stats 表
27.12.12 Performance Schema NDB 集群表1
27.12.13 性能模式锁表1
27.12.14 性能模式系统变量表1
27.12.15 性能模式状态变量表1
27.12.16 性能模式线程池表1
27.12.17 性能模式防火墙表1
27.12.18 性能模式密钥环表1
27.12.19 性能模式克隆表1
27.12.20 性能模式汇总表1
27.12.21 性能模式杂表1
27.13 性能模式选项和变量引用
27.14 性能模式命令选项
27.15 性能模式系统变量
27.16 性能模式状态变量
27.17性能模式内存分配模型
27.18 性能模式和插件
27.19 使用性能模式诊断问题
27.20 性能模式的限制
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 27 章 MySQL 性能模式  / 27.12 性能模式表描述  /
27.12.11 性能模式复制表
27.12.11 性能模式复制表
27.12.11.1 复制连接配置表27.12.11.2 复制连接状态表27.12.11.3 replication_asynchronous_connection_failover 表27.12.11.4 replication_asynchronous_connection_failover_managed 表27.12.11.5 replication_applier_configuration 表27.12.11.6 replication_applier_status 表27.12.11.7 replication_applier_status_by_coordinator 表27.12.11.8 replication_applier_status_by_worker 表27.12.11.9 replication_applier_global_filters 表27.12.11.10 replication_applier_filters 表27.12.11.11 复制组成员表27.12.11.12 replication_group_member_stats 表27.12.11.13 replication_group_member_actions 表27.12.11.14 复制组配置版本表27.12.11.15 复制组通信信息表27.12.11.16 binary_log_transaction_compression_stats 表
性能模式提供公开复制信息的表。这类似于SHOW
REPLICA STATUS语句中可用的信息，但表格形式的表示更易于访问并且具有可用性优势：
SHOW
REPLICA STATUSoutput 对于目视检查很有用，但对于编程用途则没有那么多。相比之下，使用 Performance Schema 表，可以使用一般
SELECT查询来搜索有关副本状态的信息，包括复杂WHERE条件、连接等。
查询结果可以保存在表中以供进一步分析，或分配给变量，从而在存储过程中使用。
复制表提供更好的诊断信息。对于多线程副本操作，
使用
和字段SHOW
REPLICA STATUS报告所有协调器和工作线程错误，因此只有最近的这些错误是可见的，信息可能会丢失。复制表以每个线程为基础存储错误，不会丢失信息。
Last_SQL_ErrnoLast_SQL_Error
最后看到的事务在每个工作人员的复制表中是可见的。这是无法从 获得的信息
SHOW
REPLICA STATUS。
熟悉 Performance Schema 接口的开发人员可以扩展复制表，通过向表中添加行来提供额外的信息。
复制表说明
Performance Schema 提供了以下与复制相关的表：
包含有关副本与源的连接信息的表：
replication_connection_configuration: 连接源的配置参数
replication_connection_status：与源连接的当前状态
replication_asynchronous_connection_failover: 异步连接故障转移机制的源列表
包含有关事务应用程序的一般（非线程特定）信息的表：
replication_applier_configuration：副本上事务应用程序的配置参数。
replication_applier_status：副本上事务应用程序的当前状态。
包含有关负责应用从源接收的事务的特定线程的信息的表：
replication_applier_status_by_coordinator：协调器线程的状态（除非副本是多线程的，否则为空）。
replication_applier_status_by_worker：如果副本是多线程的，应用程序线程或工作线程的状态。
包含有关基于通道的复制过滤器信息的表：
replication_applier_filters：提供有关在特定复制通道上配置的复制过滤器的信息。
replication_applier_global_filters：提供有关适用于所有复制通道的全局复制过滤器的信息。
包含有关组复制成员信息的表：
replication_group_members：提供群组成员的网络和状态信息。
replication_group_member_stats：提供有关群组成员及其参与的交易的统计信息。
有关详细信息，请参阅
第 18.4 节，“监控组复制”。
禁用性能模式时，将继续填充以下性能模式复制表：
replication_connection_configuration
replication_connection_status
replication_asynchronous_connection_failover
replication_applier_configuration
replication_applier_status
replication_applier_status_by_coordinator
replication_applier_status_by_worker
replication_connection_status例外是复制表、
replication_applier_status_by_coordinator和
中的本地计时信息（事务的开始和结束时间戳）
replication_applier_status_by_worker。禁用性能模式时不会收集此信息。
以下部分更详细地描述了每个复制表，包括生成的
SHOW
REPLICA STATUS列与出现相同信息的复制表列之间的对应关系。
复制表介绍的其余部分描述了性能模式如何填充它们以及
SHOW
REPLICA STATUS表中未表示的字段。
复制表生命周期
性能模式按如下方式填充复制表：
在执行CHANGE
REPLICATION SOURCE TO|
之前 CHANGE MASTER TO，表是空的。
之后CHANGE REPLICATION SOURCE
TO| CHANGE MASTER
TO, 配置参数可以在表中看到。此时，没有活动的复制线程，因此THREAD_ID列为
NULL并且
SERVICE_STATE列的值为
OFF。
在 MySQL 8.0.22之后START
REPLICA（或之前
），可以看到START
SLAVE非值。NULL
THREAD_ID空闲或活动线程的
SERVICE_STATE值为
ON。CONNECTING连接到源的线程在建立连接时具有值，ON
此后只要连接持续。
之后STOP
REPLICA，THREAD_ID列变为NULL并且
SERVICE_STATE不再存在的线程的列的值为OFF。
这些表在
STOP
REPLICA线程因错误而停止后或线程停止后被保留。
replication_applier_status_by_worker
仅当副本在多线程模式下运行时，
该
表才为非空。即如果
replica_parallel_workersor
slave_parallel_workers
系统变量大于0，START
REPLICA则执行时填充此表，行数显示worker数。
副本状态信息不在复制表中
Performance Schema 复制表中的信息与可用信息有些不同，
SHOW
REPLICA STATUS因为这些表面向使用全局事务标识符 (GTID)，而不是文件名和位置，并且它们表示服务器 UUID 值，而不是服务器 ID 值。由于这些差异，
SHOW
REPLICA STATUS性能模式复制表中没有保留几个列，或者以不同的方式表示：
以下字段引用文件名和位置，不会保留：
Master_Log_File
Read_Master_Log_Pos
Relay_Log_File
Relay_Log_Pos
Relay_Master_Log_File
Exec_Master_Log_Pos
Until_Condition
Until_Log_File
Until_Log_Pos
该Master_Info_File字段未保留。它指的是master.info
用于副本的源元数据存储库的文件，该文件已被存储库的崩溃安全表所取代。
以下字段基于
server_id、不是
server_uuid且不保留：
Master_Server_Id
Replicate_Ignore_Server_Ids
该Skip_Counter字段基于事件计数，而不是 GTID，并且不会保留。
这些错误字段是 和 的别名
Last_SQL_Errno，
Last_SQL_Error因此不会保留它们：
Last_Errno
Last_Error
在 Performance Schema 中，此错误信息在表的LAST_ERROR_NUMBER和
LAST_ERROR_MESSAGE列中
可用replication_applier_status_by_worker
（
replication_applier_status_by_coordinator
如果副本是多线程的）。这些表提供了比 和 提供的更具体的每线程错误
Last_Errno信息
Last_Error。
不保留提供有关命令行过滤选项信息的字段：
Replicate_Do_DB
Replicate_Ignore_DB
Replicate_Do_Table
Replicate_Ignore_Table
Replicate_Wild_Do_Table
Replicate_Wild_Ignore_Table
和Replica_IO_State字段
Replica_SQL_Running_State不会保留。THREAD_ID
如果需要，可以通过使用适当复制表的列并将其与表中的ID列
连接INFORMATION_SCHEMA
PROCESSLIST以选择后表的
列，从进程列表中获取这些值STATE。
该Executed_Gtid_Set字段可以显示包含大量文本的大集合。相反，性能模式表显示副本当前正在应用的事务的 GTID。或者，可以从gtid_executed系统变量的值中获取一组已执行的 GTID。
和字段处于待定状态，不保留
Seconds_Behind_Master。
Relay_Log_Space
复制通道
复制性能模式表的第一列是
CHANNEL_NAME. 这使得可以按复制通道查看表。在非多源复制设置中，只有一个默认复制通道。当您在副本上使用多个复制通道时，您可以过滤每个复制通道的表以监视特定的复制通道。有关更多信息，请参阅第 17.2.2 节，“复制通道”
和第 17.1.5.8 节，“监视多源复制”。
© Mysql 中文网
