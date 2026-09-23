# 23.6.18 快速参考：NDB Cluster SQL 语句_MySQL 8.0 参考手册

23.6.18 快速参考：NDB Cluster SQL 语句_MySQL 8.0 参考手册
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
23.3 NDB Cluster 安装
23.4 NDB Cluster的配置
23.5 NDB 集群程序
23.6 NDB Cluster的管理
23.6.1 NDB Cluster Management Client 中的命令1
23.6.2 NDB Cluster 日志消息1
23.6.3 NDB Cluster 中生成的事件报告1
23.6.4 NDB Cluster 启动阶段总结1
23.6.5 执行 NDB Cluster 的滚动重启1
23.6.6 NDB Cluster 单用户模式1
23.6.7 在线添加 NDB Cluster 数据节点1
23.6.8 NDB Cluster 在线备份1
23.6.9 NDB Cluster 的 MySQL 服务器使用1
23.6.10 NDB Cluster 磁盘数据表1
23.6.11 在 NDB Cluster 中使用 ALTER TABLE 进行在线操作1
23.6.12 权限同步和 NDB_STORED_USER1
23.6.13 NDB Cluster 的文件系统加密1
23.6.14 NDB API 统计计数器和变量1
23.6.15 ndbinfo：NDB 集群信息数据库1
23.6.16 NDB Cluster 的 INFORMATION_SCHEMA 表1
23.6.17 NDB Cluster 和性能模式1
23.6.18 快速参考：NDB Cluster SQL 语句1
23.6.19 NDB Cluster 安全问题1
23.6.9 导入数据到MySQL集群1
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.6 NDB Cluster的管理  /
23.6.18 快速参考：NDB Cluster SQL 语句
23.6.18 快速参考：NDB Cluster SQL 语句
本节讨论几个 SQL 语句，这些语句可以证明在管理和监视连接到 NDB Cluster 的 MySQL 服务器方面很有用，并且在某些情况下提供有关集群本身的信息。
SHOW ENGINE NDB
STATUS,
SHOW ENGINE
NDBCLUSTER STATUS
此语句的输出包含有关服务器与集群的连接、NDB Cluster 对象的创建和使用以及 NDB Cluster 复制的二进制日志记录的信息。
有关用法示例和更多详细信息，
请参阅第 13.7.7.15 节，“SHOW ENGINE 语句” 。
SHOW ENGINES
此语句可用于确定是否在 MySQL 服务器中启用了集群支持，如果启用，则它是否处于活动状态。
有关更多详细信息，
请参阅第 13.7.7.16 节，“SHOW ENGINES 语句” 。
笔记
此语句不支持
LIKE子句。但是，您可以使用LIKE该表来过滤查询
INFORMATION_SCHEMA.ENGINES
，这将在下一项中讨论。
SELECT * FROM INFORMATION_SCHEMA.ENGINES [WHERE
ENGINE LIKE 'NDB%']
这相当于SHOW
ENGINES，但使用数据库的
ENGINES表
INFORMATION_SCHEMA。与SHOW ENGINES
语句的情况不同，可以使用
LIKE子句过滤结果，并选择特定的列以获取可能在脚本中使用的信息。例如，以下查询显示服务器是否NDB支持构建，如果是，是否启用：
mysql> SELECT ENGINE, SUPPORT FROM INFORMATION_SCHEMA.ENGINES
->   WHERE ENGINE LIKE 'NDB%';
+------------+---------+
| ENGINE     | SUPPORT |
+------------+---------+
| ndbcluster | YES     |
| ndbinfo    | YES     |
+------------+---------+
如果NDB未启用支持，则前面的查询将返回一个空集。有关更多信息，请参阅
第 26.3.13 节，“INFORMATION_SCHEMA ENGINES 表”。
SHOW VARIABLES LIKE 'NDB%'
该语句提供了与NDB存储引擎相关的大多数服务器系统变量及其值的列表，如下所示：
mysql> SHOW VARIABLES LIKE 'NDB%';
+--------------------------------------+---------------------------------------+
| Variable_name                        | Value                                 |
+--------------------------------------+---------------------------------------+
| ndb_allow_copying_alter_table        | ON                                    |
| ndb_autoincrement_prefetch_sz        | 512                                   |
| ndb_batch_size                       | 32768                                 |
| ndb_blob_read_batch_bytes            | 65536                                 |
| ndb_blob_write_batch_bytes           | 65536                                 |
| ndb_clear_apply_status               | ON                                    |
| ndb_cluster_connection_pool          | 1                                     |
| ndb_cluster_connection_pool_nodeids  |                                       |
| ndb_connectstring                    | 127.0.0.1                             |
| ndb_data_node_neighbour              | 0                                     |
| ndb_default_column_format            | FIXED                                 |
| ndb_deferred_constraints             | 0                                     |
| ndb_distribution                     | KEYHASH                               |
| ndb_eventbuffer_free_percent         | 20                                    |
| ndb_eventbuffer_max_alloc            | 0                                     |
| ndb_extra_logging                    | 1                                     |
| ndb_force_send                       | ON                                    |
| ndb_fully_replicated                 | OFF                                   |
| ndb_index_stat_enable                | ON                                    |
| ndb_index_stat_option                | loop_enable=1000ms,loop_idle=1000ms,
loop_busy=100ms,update_batch=1,read_batch=4,idle_batch=32,check_batch=8,
check_delay=10m,delete_batch=8,clean_delay=1m,error_batch=4,error_delay=1m,
evict_batch=8,evict_delay=1m,cache_limit=32M,cache_lowpct=90,zero_total=0      |
| ndb_join_pushdown                    | ON                                    |
| ndb_log_apply_status                 | OFF                                   |
| ndb_log_bin                          | OFF                                   |
| ndb_log_binlog_index                 | ON                                    |
| ndb_log_empty_epochs                 | OFF                                   |
| ndb_log_empty_update                 | OFF                                   |
| ndb_log_exclusive_reads              | OFF                                   |
| ndb_log_orig                         | OFF                                   |
| ndb_log_transaction_id               | OFF                                   |
| ndb_log_update_as_write              | ON                                    |
| ndb_log_update_minimal               | OFF                                   |
| ndb_log_updated_only                 | ON                                    |
| ndb_metadata_check                   | ON                                    |
| ndb_metadata_check_interval          | 60                                    |
| ndb_metadata_sync                    | OFF                                   |
| ndb_mgmd_host                        | 127.0.0.1                             |
| ndb_nodeid                           | 0                                     |
| ndb_optimization_delay               | 10                                    |
| ndb_optimized_node_selection         | 3                                     |
| ndb_read_backup                      | ON                                    |
| ndb_recv_thread_activation_threshold | 8                                     |
| ndb_recv_thread_cpu_mask             |                                       |
| ndb_report_thresh_binlog_epoch_slip  | 10                                    |
| ndb_report_thresh_binlog_mem_usage   | 10                                    |
| ndb_row_checksum                     | 1                                     |
| ndb_schema_dist_lock_wait_timeout    | 30                                    |
| ndb_schema_dist_timeout              | 120                                   |
| ndb_schema_dist_upgrade_allowed      | ON                                    |
| ndb_show_foreign_key_mock_tables     | OFF                                   |
| ndb_slave_conflict_role              | NONE                                  |
| ndb_table_no_logging                 | OFF                                   |
| ndb_table_temporary                  | OFF                                   |
| ndb_use_copying_alter_table          | OFF                                   |
| ndb_use_exact_count                  | OFF                                   |
| ndb_use_transactions                 | ON                                    |
| ndb_version                          | 524308                                |
| ndb_version_string                   | ndb-8.0.32                            |
| ndb_wait_connected                   | 30                                    |
| ndb_wait_setup                       | 30                                    |
| ndbinfo_database                     | ndbinfo                               |
| ndbinfo_max_bytes                    | 0                                     |
| ndbinfo_max_rows                     | 10                                    |
| ndbinfo_offline                      | OFF                                   |
| ndbinfo_show_hidden                  | OFF                                   |
| ndbinfo_table_prefix                 | ndb$                                  |
| ndbinfo_version                      | 524308                                |
+--------------------------------------+---------------------------------------+
有关详细信息，请参阅第 5.1.8 节，“服务器系统变量”。
SELECT * FROM performance_schema.global_variables
WHERE VARIABLE_NAME LIKE 'NDB%'
此语句等同于
SHOW VARIABLES上一项中描述的语句，并提供几乎相同的输出，如下所示：
mysql> SELECT * FROM performance_schema.global_variables
->   WHERE VARIABLE_NAME LIKE 'NDB%';
+--------------------------------------+---------------------------------------+
| VARIABLE_NAME                        | VARIABLE_VALUE                        |
+--------------------------------------+---------------------------------------+
| ndb_allow_copying_alter_table        | ON                                    |
| ndb_autoincrement_prefetch_sz        | 512                                   |
| ndb_batch_size                       | 32768                                 |
| ndb_blob_read_batch_bytes            | 65536                                 |
| ndb_blob_write_batch_bytes           | 65536                                 |
| ndb_clear_apply_status               | ON                                    |
| ndb_cluster_connection_pool          | 1                                     |
| ndb_cluster_connection_pool_nodeids  |                                       |
| ndb_connectstring                    | 127.0.0.1                             |
| ndb_data_node_neighbour              | 0                                     |
| ndb_default_column_format            | FIXED                                 |
| ndb_deferred_constraints             | 0                                     |
| ndb_distribution                     | KEYHASH                               |
| ndb_eventbuffer_free_percent         | 20                                    |
| ndb_eventbuffer_max_alloc            | 0                                     |
| ndb_extra_logging                    | 1                                     |
| ndb_force_send                       | ON                                    |
| ndb_fully_replicated                 | OFF                                   |
| ndb_index_stat_enable                | ON                                    |
| ndb_index_stat_option                | loop_enable=1000ms,loop_idle=1000ms,
loop_busy=100ms,update_batch=1,read_batch=4,idle_batch=32,check_batch=8,
check_delay=10m,delete_batch=8,clean_delay=1m,error_batch=4,error_delay=1m,
evict_batch=8,evict_delay=1m,cache_limit=32M,cache_lowpct=90,zero_total=0      |
| ndb_join_pushdown                    | ON                                    |
| ndb_log_apply_status                 | OFF                                   |
| ndb_log_bin                          | OFF                                   |
| ndb_log_binlog_index                 | ON                                    |
| ndb_log_empty_epochs                 | OFF                                   |
| ndb_log_empty_update                 | OFF                                   |
| ndb_log_exclusive_reads              | OFF                                   |
| ndb_log_orig                         | OFF                                   |
| ndb_log_transaction_id               | OFF                                   |
| ndb_log_update_as_write              | ON                                    |
| ndb_log_update_minimal               | OFF                                   |
| ndb_log_updated_only                 | ON                                    |
| ndb_metadata_check                   | ON                                    |
| ndb_metadata_check_interval          | 60                                    |
| ndb_metadata_sync                    | OFF                                   |
| ndb_mgmd_host                        | 127.0.0.1                             |
| ndb_nodeid                           | 0                                     |
| ndb_optimization_delay               | 10                                    |
| ndb_optimized_node_selection         | 3                                     |
| ndb_read_backup                      | ON                                    |
| ndb_recv_thread_activation_threshold | 8                                     |
| ndb_recv_thread_cpu_mask             |                                       |
| ndb_report_thresh_binlog_epoch_slip  | 10                                    |
| ndb_report_thresh_binlog_mem_usage   | 10                                    |
| ndb_row_checksum                     | 1                                     |
| ndb_schema_dist_lock_wait_timeout    | 30                                    |
| ndb_schema_dist_timeout              | 120                                   |
| ndb_schema_dist_upgrade_allowed      | ON                                    |
| ndb_show_foreign_key_mock_tables     | OFF                                   |
| ndb_slave_conflict_role              | NONE                                  |
| ndb_table_no_logging                 | OFF                                   |
| ndb_table_temporary                  | OFF                                   |
| ndb_use_copying_alter_table          | OFF                                   |
| ndb_use_exact_count                  | OFF                                   |
| ndb_use_transactions                 | ON                                    |
| ndb_version                          | 524308                                |
| ndb_version_string                   | ndb-8.0.32                            |
| ndb_wait_connected                   | 30                                    |
| ndb_wait_setup                       | 30                                    |
| ndbinfo_database                     | ndbinfo                               |
| ndbinfo_max_bytes                    | 0                                     |
| ndbinfo_max_rows                     | 10                                    |
| ndbinfo_offline                      | OFF                                   |
| ndbinfo_show_hidden                  | OFF                                   |
| ndbinfo_table_prefix                 | ndb$                                  |
| ndbinfo_version                      | 524308                                |
+--------------------------------------+---------------------------------------+
与SHOW
VARIABLES语句的情况不同，可以选择单独的列。例如：
mysql> SELECT VARIABLE_VALUE
->   FROM performance_schema.global_variables
->   WHERE VARIABLE_NAME = 'ndb_force_send';
+----------------+
| VARIABLE_VALUE |
+----------------+
| ON             |
+----------------+
此处显示了一个更有用的查询：
mysql> SELECT VARIABLE_NAME AS Name, VARIABLE_VALUE AS Value
>   FROM performance_schema.global_variables
>   WHERE VARIABLE_NAME
>     IN ('version', 'ndb_version',
>       'ndb_version_string', 'ndbinfo_version');
+--------------------+----------------+
| Name               | Value          |
+--------------------+----------------+
| ndb_version        | 524317         |
| ndb_version_string | ndb-8.0.29     |
| ndbinfo_version    | 524317         |
| version            | 8.0.29-cluster |
+--------------------+----------------+
4 rows in set (0.00 sec)
有关详细信息，请参阅
第 27.12.15 节，“性能模式状态变量表”和第 5.1.8 节，“服务器系统变量”。
SHOW STATUS LIKE 'NDB%'
该语句一目了然地显示了MySQL服务器是否充当集群SQL节点，如果是，它提供了MySQL服务器的集群节点ID，它所连接的集群管理服务器的主机名和端口，以及集群中数据节点的数量，如下所示：
mysql> SHOW STATUS LIKE 'NDB%';
+----------------------------------------------+-------------------------------+
| Variable_name                                | Value                         |
+----------------------------------------------+-------------------------------+
| Ndb_metadata_detected_count                  | 0                             |
| Ndb_cluster_node_id                          | 100                           |
| Ndb_config_from_host                         | 127.0.0.1                     |
| Ndb_config_from_port                         | 1186                          |
| Ndb_number_of_data_nodes                     | 2                             |
| Ndb_number_of_ready_data_nodes               | 2                             |
| Ndb_connect_count                            | 0                             |
| Ndb_execute_count                            | 0                             |
| Ndb_scan_count                               | 0                             |
| Ndb_pruned_scan_count                        | 0                             |
| Ndb_schema_locks_count                       | 0                             |
| Ndb_api_wait_exec_complete_count_session     | 0                             |
| Ndb_api_wait_scan_result_count_session       | 0                             |
| Ndb_api_wait_meta_request_count_session      | 1                             |
| Ndb_api_wait_nanos_count_session             | 163446                        |
| Ndb_api_bytes_sent_count_session             | 60                            |
| Ndb_api_bytes_received_count_session         | 28                            |
| Ndb_api_trans_start_count_session            | 0                             |
| Ndb_api_trans_commit_count_session           | 0                             |
| Ndb_api_trans_abort_count_session            | 0                             |
| Ndb_api_trans_close_count_session            | 0                             |
| Ndb_api_pk_op_count_session                  | 0                             |
| Ndb_api_uk_op_count_session                  | 0                             |
| Ndb_api_table_scan_count_session             | 0                             |
| Ndb_api_range_scan_count_session             | 0                             |
| Ndb_api_pruned_scan_count_session            | 0                             |
| Ndb_api_scan_batch_count_session             | 0                             |
| Ndb_api_read_row_count_session               | 0                             |
| Ndb_api_trans_local_read_row_count_session   | 0                             |
| Ndb_api_adaptive_send_forced_count_session   | 0                             |
| Ndb_api_adaptive_send_unforced_count_session | 0                             |
| Ndb_api_adaptive_send_deferred_count_session | 0                             |
| Ndb_trans_hint_count_session                 | 0                             |
| Ndb_sorted_scan_count                        | 0                             |
| Ndb_pushed_queries_defined                   | 0                             |
| Ndb_pushed_queries_dropped                   | 0                             |
| Ndb_pushed_queries_executed                  | 0                             |
| Ndb_pushed_reads                             | 0                             |
| Ndb_last_commit_epoch_server                 | 37632503447571                |
| Ndb_last_commit_epoch_session                | 0                             |
| Ndb_system_name                              | MC_20191126162038             |
| Ndb_api_event_data_count_injector            | 0                             |
| Ndb_api_event_nondata_count_injector         | 0                             |
| Ndb_api_event_bytes_count_injector           | 0                             |
| Ndb_api_wait_exec_complete_count_slave       | 0                             |
| Ndb_api_wait_scan_result_count_slave         | 0                             |
| Ndb_api_wait_meta_request_count_slave        | 0                             |
| Ndb_api_wait_nanos_count_slave               | 0                             |
| Ndb_api_bytes_sent_count_slave               | 0                             |
| Ndb_api_bytes_received_count_slave           | 0                             |
| Ndb_api_trans_start_count_slave              | 0                             |
| Ndb_api_trans_commit_count_slave             | 0                             |
| Ndb_api_trans_abort_count_slave              | 0                             |
| Ndb_api_trans_close_count_slave              | 0                             |
| Ndb_api_pk_op_count_slave                    | 0                             |
| Ndb_api_uk_op_count_slave                    | 0                             |
| Ndb_api_table_scan_count_slave               | 0                             |
| Ndb_api_range_scan_count_slave               | 0                             |
| Ndb_api_pruned_scan_count_slave              | 0                             |
| Ndb_api_scan_batch_count_slave               | 0                             |
| Ndb_api_read_row_count_slave                 | 0                             |
| Ndb_api_trans_local_read_row_count_slave     | 0                             |
| Ndb_api_adaptive_send_forced_count_slave     | 0                             |
| Ndb_api_adaptive_send_unforced_count_slave   | 0                             |
| Ndb_api_adaptive_send_deferred_count_slave   | 0                             |
| Ndb_slave_max_replicated_epoch               | 0                             |
| Ndb_api_wait_exec_complete_count             | 4                             |
| Ndb_api_wait_scan_result_count               | 7                             |
| Ndb_api_wait_meta_request_count              | 172                           |
| Ndb_api_wait_nanos_count                     | 1083548094028                 |
| Ndb_api_bytes_sent_count                     | 4640                          |
| Ndb_api_bytes_received_count                 | 109356                        |
| Ndb_api_trans_start_count                    | 4                             |
| Ndb_api_trans_commit_count                   | 1                             |
| Ndb_api_trans_abort_count                    | 1                             |
| Ndb_api_trans_close_count                    | 4                             |
| Ndb_api_pk_op_count                          | 2                             |
| Ndb_api_uk_op_count                          | 0                             |
| Ndb_api_table_scan_count                     | 1                             |
| Ndb_api_range_scan_count                     | 1                             |
| Ndb_api_pruned_scan_count                    | 0                             |
| Ndb_api_scan_batch_count                     | 1                             |
| Ndb_api_read_row_count                       | 3                             |
| Ndb_api_trans_local_read_row_count           | 2                             |
| Ndb_api_adaptive_send_forced_count           | 1                             |
| Ndb_api_adaptive_send_unforced_count         | 5                             |
| Ndb_api_adaptive_send_deferred_count         | 0                             |
| Ndb_api_event_data_count                     | 0                             |
| Ndb_api_event_nondata_count                  | 0                             |
| Ndb_api_event_bytes_count                    | 0                             |
| Ndb_metadata_excluded_count                  | 0                             |
| Ndb_metadata_synced_count                    | 0                             |
| Ndb_conflict_fn_max                          | 0                             |
| Ndb_conflict_fn_old                          | 0                             |
| Ndb_conflict_fn_max_del_win                  | 0                             |
| Ndb_conflict_fn_epoch                        | 0                             |
| Ndb_conflict_fn_epoch_trans                  | 0                             |
| Ndb_conflict_fn_epoch2                       | 0                             |
| Ndb_conflict_fn_epoch2_trans                 | 0                             |
| Ndb_conflict_trans_row_conflict_count        | 0                             |
| Ndb_conflict_trans_row_reject_count          | 0                             |
| Ndb_conflict_trans_reject_count              | 0                             |
| Ndb_conflict_trans_detect_iter_count         | 0                             |
| Ndb_conflict_trans_conflict_commit_count     | 0                             |
| Ndb_conflict_epoch_delete_delete_count       | 0                             |
| Ndb_conflict_reflected_op_prepare_count      | 0                             |
| Ndb_conflict_reflected_op_discard_count      | 0                             |
| Ndb_conflict_refresh_op_count                | 0                             |
| Ndb_conflict_last_conflict_epoch             | 0                             |
| Ndb_conflict_last_stable_epoch               | 0                             |
| Ndb_index_stat_status                        | allow:1,enable:1,busy:0,
loop:1000,list:(new:0,update:0,read:0,idle:0,check:0,delete:0,error:0,total:0),
analyze:(queue:0,wait:0),stats:(nostats:0,wait:0),total:(analyze:(all:0,error:0),
query:(all:0,nostats:0,error:0),event:(act:0,skip:0,miss:0),cache:(refresh:0,
clean:0,pinned:0,drop:0,evict:0)),cache:(query:0,clean:0,drop:0,evict:0,
usedpct:0.00,highpct:0.00)                                                     |
| Ndb_index_stat_cache_query                   | 0                             |
| Ndb_index_stat_cache_clean                   | 0                             |
+----------------------------------------------+-------------------------------+
如果 MySQL 服务器是在NDB
支持下构建的，但它当前未连接到集群，则此语句输出中的每一行都包含一个零或一个空字符串作为该Value列。
另见第 13.7.7.37 节，“SHOW STATUS 语句”。
SELECT * FROM performance_schema.global_status WHERE
VARIABLE_NAME LIKE 'NDB%'
SHOW STATUS此语句提供与上一项中讨论
的语句类似的输出
。与 的情况不同
SHOW STATUS，可以使用SELECT语句来提取 SQL 中的值，以便在用于监视和自动化目的的脚本中使用。
有关详细信息，请参阅
第 27.12.15 节，“性能模式状态变量表”。
SELECT * FROM INFORMATION_SCHEMA.PLUGINS WHERE
PLUGIN_NAME LIKE 'NDB%'
此语句显示
INFORMATION_SCHEMA.PLUGINS表中有关与 NDB Cluster 关联的插件的信息，例如版本、作者和许可证，如下所示：
mysql> SELECT * FROM INFORMATION_SCHEMA.PLUGINS
>     WHERE PLUGIN_NAME LIKE 'NDB%'\G
*************************** 1. row ***************************
PLUGIN_NAME: ndbcluster
PLUGIN_VERSION: 1.0
PLUGIN_STATUS: ACTIVE
PLUGIN_TYPE: STORAGE ENGINE
PLUGIN_TYPE_VERSION: 80031.0
PLUGIN_LIBRARY: NULL
PLUGIN_LIBRARY_VERSION: NULL
PLUGIN_AUTHOR: Oracle Corporation
PLUGIN_DESCRIPTION: Clustered, fault-tolerant tables
PLUGIN_LICENSE: GPL
LOAD_OPTION: ON
*************************** 2. row ***************************
PLUGIN_NAME: ndbinfo
PLUGIN_VERSION: 0.1
PLUGIN_STATUS: ACTIVE
PLUGIN_TYPE: STORAGE ENGINE
PLUGIN_TYPE_VERSION: 80031.0
PLUGIN_LIBRARY: NULL
PLUGIN_LIBRARY_VERSION: NULL
PLUGIN_AUTHOR: Oracle Corporation
PLUGIN_DESCRIPTION: MySQL Cluster system information storage engine
PLUGIN_LICENSE: GPL
LOAD_OPTION: ON
*************************** 3. row ***************************
PLUGIN_NAME: ndb_transid_mysql_connection_map
PLUGIN_VERSION: 0.1
PLUGIN_STATUS: ACTIVE
PLUGIN_TYPE: INFORMATION SCHEMA
PLUGIN_TYPE_VERSION: 80031.0
PLUGIN_LIBRARY: NULL
PLUGIN_LIBRARY_VERSION: NULL
PLUGIN_AUTHOR: Oracle Corporation
PLUGIN_DESCRIPTION: Map between MySQL connection ID and NDB transaction ID
PLUGIN_LICENSE: GPL
LOAD_OPTION: ON
您也可以使用该SHOW
PLUGINS语句来显示此信息，但无法轻易过滤该语句的输出。另请参阅MySQL 插件 API，它描述了从何处以及如何获取
PLUGINS表中的信息。
您还可以查询
ndbinfo信息数据库中的表以获取有关许多 NDB Cluster 操作的实时数据。请参阅
第 23.6.15 节，“ndbinfo：NDB Cluster 信息数据库”。
© Mysql 中文网
