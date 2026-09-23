# 23.2.5 NDB 8.0 中添加、弃用或删除的选项、变量和参数_MySQL 8.0 参考手册

23.2.5 NDB 8.0 中添加、弃用或删除的选项、变量和参数_MySQL 8.0 参考手册
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
23.2.1 NDB Cluster 核心概念1
23.2.2 NDB Cluster 节点、节点组、片段副本和分区1
23.2.3 NDB Cluster 硬件、软件和网络要求1
23.2.4 NDB Cluster 中的新功能1
23.2.5 NDB 8.0 中添加、弃用或删除的选项、变量和参数1
23.2.6 使用 InnoDB 的 MySQL 服务器与 NDB Cluster 比较1
23.2.7 NDB Cluster 的已知限制1
23.3 NDB Cluster 安装
23.4 NDB Cluster的配置
23.5 NDB 集群程序
23.6 NDB Cluster的管理
23.7 NDB 集群复制
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.2 NDB Cluster 概述  /
23.2.5 NDB 8.0 中添加、弃用或删除的选项、变量和参数
23.2.5 NDB 8.0 中添加、弃用或删除的选项、变量和参数
NDB 8.0 中引入的参数NDB 8.0 中弃用的参数NDB 8.0 中删除的参数NDB 8.0 中引入的选项和变量NDB 8.0 中弃用的选项和变量NDB 8.0 中删除的选项和变量
接下来的几节包含有关
NDB节点配置参数和特定于 NDB 的mysqld选项和变量的信息，这些选项和变量已添加到 NDB 8.0 中、已弃用或已从中删除。
NDB 8.0 中引入的参数
NDB 8.0 中添加了以下节点配置参数。
AllowUnresolvedHostNames：当为false（默认）时，管理节点解析主机名失败导致致命错误；当为 true 时，未解析的主机名仅作为警告报告。在 NDB 8.0.22 中添加。
AutomaticThreadConfig：使用自动线程配置；覆盖 ThreadConfig 和 MaxNoOfExecutionThreads 的任何设置，并禁用 ClassicFragmentation。在 NDB 8.0.23 中添加。
ClassicFragmentation：为true时，使用传统的表分片；设置为 false 以启用在 LDM 之间灵活分配片段。由 AutomaticThreadConfig 禁用。在 NDB 8.0.23 中添加。
DiskDataUsingSameDisk：如果磁盘数据表空间位于单独的物理磁盘上，则设置为 false。在 NDB 8.0.19 中添加。
EnableMultithreadedBackup：启用多线程备份。在 NDB 8.0.16 中添加。
EncryptedFileSystem：加密本地检查点和表空间文件。实验性的；不支持生产。在 NDB 8.0.29 中添加。
KeepAliveSendInterval：数据节点之间链路上的保持活动信号之间的时间，以毫秒为单位。设置为 0 以禁用。在 NDB 8.0.27 中添加。
MaxDiskDataLatency：开始中止事务之前允许的最大磁盘访问平均延迟（毫秒）。在 NDB 8.0.19 中添加。
NodeGroupTransporters：同一节点组中节点之间使用的传输器数量。在 NDB 8.0.20 中添加。
NumCPUs: 指定与 AutomaticThreadConfig 一起使用的 CPU 数量。在 NDB 8.0.23 中添加。
PartitionsPerNode：决定了每个数据节点上创建的表分区数；如果启用了 ClassicFragmentation，则不使用。在 NDB 8.0.23 中添加。
PreferIPVersion：指示 IP 版本 4 或 6 的 DNS 解析器首选项。在 NDB 8.0.26 中添加。
RequireEncryptedBackup：是否必须加密备份（1 = 需要加密，否则为 0）。在 NDB 8.0.22 中添加。
ReservedConcurrentIndexOperations：在一个数据节点上具有专用资源的同时索引操作数。在 NDB 8.0.16 中添加。
ReservedConcurrentOperations：在一个数据节点上的事务协调器中具有专用资源的同时操作数。在 NDB 8.0.16 中添加。
ReservedConcurrentScans：在一个数据节点上具有专用资源的同时扫描数。在 NDB 8.0.16 中添加。
ReservedConcurrentTransactions：在一个数据节点上具有专用资源的同时事务数。在 NDB 8.0.16 中添加。
ReservedFiredTriggers：在一个数据节点上具有专用资源的触发器数。在 NDB 8.0.16 中添加。
ReservedLocalScans：在一个数据节点上具有专用资源的同时片段扫描数。在 NDB 8.0.16 中添加。
ReservedTransactionBufferMemory：分配给每个数据节点的键和属性数据的动态缓冲区空间（以字节为单位）。在 NDB 8.0.16 中添加。
SpinMethod：确定数据节点使用的自旋方法；有关详细信息，请参阅文档。在 NDB 8.0.20 中添加。
TcpSpinTime：接收时睡觉前旋转的时间。在 NDB 8.0.20 中添加。
TransactionMemory：为每个数据节点上的事务分配的内存。在 NDB 8.0.19 中添加。
NDB 8.0 中弃用的参数
NDB 8.0 中已弃用以下节点配置参数。
BatchSizePerLocalScan: 用于计算持有锁扫描的锁记录数。在 NDB 8.0.19 中已弃用。
MaxAllocate: 不再使用；没有效果。在 NDB 8.0.27 中已弃用。
MaxNoOfConcurrentIndexOperations：可以在一个数据节点上同时执行的索引操作总数。在 NDB 8.0.19 中已弃用。
MaxNoOfConcurrentTransactions: 该数据节点上并发执行的最大事务数，可以并发执行的事务总数是该值乘以集群中的数据节点数。在 NDB 8.0.19 中已弃用。
MaxNoOfFiredTriggers：可以在一个数据节点上同时触发的触发器总数。在 NDB 8.0.19 中已弃用。
MaxNoOfLocalOperations：在此数据节点上定义的最大操作记录数。在 NDB 8.0.19 中已弃用。
MaxNoOfLocalScans：在此数据节点上并行扫描的最大片段数。在 NDB 8.0.19 中已弃用。
ReservedTransactionBufferMemory：分配给每个数据节点的键和属性数据的动态缓冲区空间（以字节为单位）。在 NDB 8.0.19 中已弃用。
UndoDataBuffer： 没用过; 没有效果。在 NDB 8.0.27 中已弃用。
UndoIndexBuffer： 没用过; 没有效果。在 NDB 8.0.27 中已弃用。
NDB 8.0 中删除的参数
NDB 8.0 中没有删除任何节点配置参数。
NDB 8.0 中引入的选项和变量
NDB 8.0 中添加了以下系统变量、状态变量和服务器选项。
Ndb_api_adaptive_send_deferred_count_replica：此副本实际未发送的自适应发送调用数。在 NDB 8.0.23 中添加。
Ndb_api_adaptive_send_forced_count_replica：此副本发送的具有强制发送集的自适应发送数。在 NDB 8.0.23 中添加。
Ndb_api_adaptive_send_unforced_count_replica：此副本发送的无强制发送的自适应发送数。在 NDB 8.0.23 中添加。
Ndb_api_bytes_received_count_replica：此副本从数据节点接收的数据量（以字节为单位）。在 NDB 8.0.23 中添加。
Ndb_api_bytes_sent_count_replica：此副本发送到数据节点的数据量（以字节为单位）。在 NDB 8.0.23 中添加。
Ndb_api_pk_op_count_replica：此副本基于或使用主键的操作数。在 NDB 8.0.23 中添加。
Ndb_api_pruned_scan_count_replica：已被此副本修剪为一个分区的扫描数。在 NDB 8.0.23 中添加。
Ndb_api_range_scan_count_replica：此副本已启动的范围扫描数。在 NDB 8.0.23 中添加。
Ndb_api_read_row_count_replica：此副本已读取的总行数。在 NDB 8.0.23 中添加。
Ndb_api_scan_batch_count_replica：此副本接收的批次行数。在 NDB 8.0.23 中添加。
Ndb_api_table_scan_count_replica：已启动的表扫描数，包括此副本的内部表扫描。在 NDB 8.0.23 中添加。
Ndb_api_trans_abort_count_replica：此副本中止的事务数。在 NDB 8.0.23 中添加。
Ndb_api_trans_close_count_replica：此副本中止的事务数（可能大于 TransCommitCount 和 TransAbortCount 的总和）。在 NDB 8.0.23 中添加。
Ndb_api_trans_commit_count_replica：此副本提交的事务数。在 NDB 8.0.23 中添加。
Ndb_api_trans_local_read_row_count_replica：此副本已读取的总行数。在 NDB 8.0.23 中添加。
Ndb_api_trans_start_count_replica：此副本启动的事务数。在 NDB 8.0.23 中添加。
Ndb_api_uk_op_count_replica：此副本基于或使用唯一键的操作数。在 NDB 8.0.23 中添加。
Ndb_api_wait_exec_complete_count_replica：线程在等待此副本完成操作执行时被阻塞的次数。在 NDB 8.0.23 中添加。
Ndb_api_wait_meta_request_count_replica：线程被此副本阻塞等待基于元数据的信号的次数。在 NDB 8.0.23 中添加。
Ndb_api_wait_nanos_count_replica：此副本等待来自数据节点的某种类型信号所花费的总时间（以纳秒为单位）。在 NDB 8.0.23 中添加。
Ndb_api_wait_scan_result_count_replica：线程在等待此副本基于扫描的信号时被阻塞的次数。在 NDB 8.0.23 中添加。
Ndb_config_generation: 集群当前配置的代号。在 NDB 8.0.24 中添加。
Ndb_conflict_fn_max_del_win_ins：基于 NDB$MAX_DEL_WIN_INS() 结果的 NDB 复制冲突解决方案已应用于插入操作的次数。在 NDB 8.0.30 中添加。
Ndb_conflict_fn_max_ins：基于“更大时间戳获胜”的 NDB 复制冲突解决已应用于插入操作的次数。在 NDB 8.0.30 中添加。
Ndb_metadata_blacklist_size：NDB binlog 线程未能同步的 NDB 元数据对象数；在 NDB 8.0.22 中重命名为 Ndb_metadata_excluded_count。在 NDB 8.0.18 中添加。
Ndb_metadata_detected_count：NDB 元数据更改监视器线程检测到更改的次数。在 NDB 8.0.16 中添加。
Ndb_metadata_excluded_count：NDB binlog 线程未能同步的 NDB 元数据对象数。在 NDB 8.0.22 中添加。
Ndb_metadata_synced_count：已同步的 NDB 元数据对象数。在 NDB 8.0.18 中添加。
Ndb_trans_hint_count_session：使用此会话中已启动的提示的事务数。在 NDB 8.0.17 中添加。
ndb-applier-allow-skip-epoch：让复制应用程序跳过纪元。在 NDB 8.0.28 中添加。
ndb-log-fail-terminate：如果无法完整记录所有找到的行事件，则终止 mysqld 进程。在 NDB 8.0.21 中添加。
ndb-schema-dist-timeout：在架构分发期间检测超时之前要等待多长时间。在 NDB 8.0.17 中添加。
ndb_conflict_role：副本在冲突检测和解决中扮演的角色。值为 PRIMARY、SECONDARY、PASS 或 NONE 之一（默认值）。仅当复制 SQL 线程停止时才能更改。有关详细信息，请参阅文档。在 NDB 8.0.23 中添加。
ndb_dbg_check_shares：检查是否有任何挥之不去的共享（仅限调试版本）。在 NDB 8.0.13 中添加。
ndb_log_transaction_compression: 是否压缩 NDB 二进制日志；也可以通过启用 --binlog-transaction-compression 选项在启动时启用。在 NDB 8.0.31 中添加。
ndb_log_transaction_compression_level_zstd：将压缩事务写入 NDB 二进制日志时使用的 ZSTD 压缩级别。在 NDB 8.0.31 中添加。
ndb_metadata_check：启用自动检测关于 MySQL 数据字典的 NDB 元数据更改；默认启用。在 NDB 8.0.16 中添加。
ndb_metadata_check_interval：以秒为单位执行检查 NDB 元数据更改相对于 MySQL 数据字典的时间间隔。在 NDB 8.0.16 中添加。
ndb_metadata_sync：触发​​立即同步NDB字典和MySQL数据字典之间的所有变化；导致 ndb_metadata_check 和 ndb_metadata_check_interval 值被忽略。同步完成后重置为 false。在 NDB 8.0.19 中添加。
ndb_replica_batch_size：副本应用程序的批量大小（以字节为单位）。在 NDB 8.0.30 中添加。
ndb_schema_dist_lock_wait_timeout：模式分发期间等待锁定返回错误之前的时间。在 NDB 8.0.18 中添加。
ndb_schema_dist_timeout：在架构分发期间检测超时之前等待的时间。在 NDB 8.0.16 中添加。
ndb_schema_dist_upgrade_allowed：连接到 NDB 时允许模式分布表升级。在 NDB 8.0.17 中添加。
ndbinfo：启用 ndbinfo 插件（如果支持）。在 NDB 8.0.13 中添加。
replica_allow_batching：打开和关闭副本的更新批处理。在 NDB 8.0.26 中添加。
NDB 8.0 中弃用的选项和变量
NDB 8.0 中已弃用以下系统变量、状态变量和选项。
Ndb_api_adaptive_send_deferred_count_slave：此副本实际未发送的自适应发送调用数。在 NDB 8.0.23 中已弃用。
Ndb_api_adaptive_send_forced_count_slave：此副本发送的具有强制发送集的自适应发送数。在 NDB 8.0.23 中已弃用。
Ndb_api_adaptive_send_unforced_count_slave：此副本发送的无强制发送的自适应发送数。在 NDB 8.0.23 中已弃用。
Ndb_api_bytes_received_count_slave：此副本从数据节点接收的数据量（以字节为单位）。在 NDB 8.0.23 中已弃用。
Ndb_api_bytes_sent_count_slave：此副本发送到数据节点的数据量（以字节为单位）。在 NDB 8.0.23 中已弃用。
Ndb_api_pk_op_count_slave：此副本基于或使用主键的操作数。在 NDB 8.0.23 中已弃用。
Ndb_api_pruned_scan_count_slave：已被此副本修剪为一个分区的扫描数。在 NDB 8.0.23 中已弃用。
Ndb_api_range_scan_count_slave：此副本已启动的范围扫描数。在 NDB 8.0.23 中已弃用。
Ndb_api_read_row_count_slave：此副本已读取的总行数。在 NDB 8.0.23 中已弃用。
Ndb_api_scan_batch_count_slave：此副本接收的批次行数。在 NDB 8.0.23 中已弃用。
Ndb_api_table_scan_count_slave：已启动的表扫描数，包括此副本的内部表扫描。在 NDB 8.0.23 中已弃用。
Ndb_api_trans_abort_count_slave：此副本中止的事务数。在 NDB 8.0.23 中已弃用。
Ndb_api_trans_close_count_slave：此副本中止的事务数（可能大于 TransCommitCount 和 TransAbortCount 的总和）。在 NDB 8.0.23 中已弃用。
Ndb_api_trans_commit_count_slave：此副本提交的事务数。在 NDB 8.0.23 中已弃用。
Ndb_api_trans_local_read_row_count_slave：此副本已读取的总行数。在 NDB 8.0.23 中已弃用。
Ndb_api_trans_start_count_slave：此副本启动的事务数。在 NDB 8.0.23 中已弃用。
Ndb_api_uk_op_count_slave：此副本基于或使用唯一键的操作数。在 NDB 8.0.23 中已弃用。
Ndb_api_wait_exec_complete_count_slave：线程在等待此副本完成操作执行时被阻塞的次数。在 NDB 8.0.23 中已弃用。
Ndb_api_wait_meta_request_count_slave：线程被此副本阻塞等待基于元数据的信号的次数。在 NDB 8.0.23 中已弃用。
Ndb_api_wait_nanos_count_slave：此副本等待来自数据节点的某种类型信号所花费的总时间（以纳秒为单位）。在 NDB 8.0.23 中已弃用。
Ndb_api_wait_scan_result_count_slave：线程在等待此副本基于扫描的信号时被阻塞的次数。在 NDB 8.0.23 中已弃用。
Ndb_metadata_blacklist_size：NDB binlog 线程未能同步的 NDB 元数据对象数；在 NDB 8.0.22 中重命名为 Ndb_metadata_excluded_count。在 NDB 8.0.21 中已弃用。
Ndb_replica_max_replicated_epoch：最近在此副本上提交的 NDB 纪元。当这个值大于或等于 Ndb_conflict_last_conflict_epoch 时，还没有检测到冲突。在 NDB 8.0.23 中已弃用。
ndb_slave_conflict_role：副本在冲突检测和解决中扮演的角色。值为 PRIMARY、SECONDARY、PASS 或 NONE 之一（默认值）。仅当复制 SQL 线程停止时才能更改。有关详细信息，请参阅文档。在 NDB 8.0.23 中已弃用。
slave_allow_batching：打开和关闭副本的更新批处理。在 NDB 8.0.26 中已弃用。
NDB 8.0 中删除的选项和变量
NDB 8.0 中删除了以下系统变量、状态变量和选项。
Ndb_metadata_blacklist_size：NDB binlog 线程未能同步的 NDB 元数据对象数；在 NDB 8.0.22 中重命名为 Ndb_metadata_excluded_count。在 NDB 8.0.22 中删除。
© Mysql 中文网
