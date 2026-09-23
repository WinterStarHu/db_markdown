# 23.6.14 NDB API 统计计数器和变量_MySQL 8.0 参考手册

23.6.14 NDB API 统计计数器和变量_MySQL 8.0 参考手册
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
23.6.14 NDB API 统计计数器和变量
23.6.14 NDB API 统计计数器和变量
可以使用多种类型的与对象执行的或影响Ndb
对象的动作相关的统计计数器。此类操作包括开始和关闭（或中止）交易；主键和唯一键操作；表、范围和修剪扫描；线程在等待各种操作完成时被阻塞；发送和接收的数据和事件NDBCLUSTER。每当进行 NDB API 调用或将数据发送到数据节点或由数据节点接收数据时，计数器就会在 NDB 内核中递增。
mysqld将这些计数器公开为系统状态变量；它们的值可以在 的输出中读取
SHOW STATUS，或者通过查询 Performance Schemasession_status或
global_status桌子。通过比较操作表的语句前后的值
NDB，您可以观察到在 API 级别采取的相应操作，从而观察执行语句的成本。
您可以使用以下
SHOW STATUS语句列出所有这些状态变量：
mysql> SHOW STATUS LIKE 'ndb_api%';
+----------------------------------------------+-----------+
| Variable_name                                | Value     |
+----------------------------------------------+-----------+
| Ndb_api_wait_exec_complete_count             | 297       |
| Ndb_api_wait_scan_result_count               | 0         |
| Ndb_api_wait_meta_request_count              | 321       |
| Ndb_api_wait_nanos_count                     | 228438645 |
| Ndb_api_bytes_sent_count                     | 33988     |
| Ndb_api_bytes_received_count                 | 66236     |
| Ndb_api_trans_start_count                    | 148       |
| Ndb_api_trans_commit_count                   | 148       |
| Ndb_api_trans_abort_count                    | 0         |
| Ndb_api_trans_close_count                    | 148       |
| Ndb_api_pk_op_count                          | 151       |
| Ndb_api_uk_op_count                          | 0         |
| Ndb_api_table_scan_count                     | 0         |
| Ndb_api_range_scan_count                     | 0         |
| Ndb_api_pruned_scan_count                    | 0         |
| Ndb_api_scan_batch_count                     | 0         |
| Ndb_api_read_row_count                       | 147       |
| Ndb_api_trans_local_read_row_count           | 37        |
| Ndb_api_adaptive_send_forced_count           | 3         |
| Ndb_api_adaptive_send_unforced_count         | 294       |
| Ndb_api_adaptive_send_deferred_count         | 0         |
| Ndb_api_event_data_count                     | 0         |
| Ndb_api_event_nondata_count                  | 0         |
| Ndb_api_event_bytes_count                    | 0         |
| Ndb_api_wait_exec_complete_count_slave       | 0         |
| Ndb_api_wait_scan_result_count_slave         | 0         |
| Ndb_api_wait_meta_request_count_slave        | 0         |
| Ndb_api_wait_nanos_count_slave               | 0         |
| Ndb_api_bytes_sent_count_slave               | 0         |
| Ndb_api_bytes_received_count_slave           | 0         |
| Ndb_api_trans_start_count_slave              | 0         |
| Ndb_api_trans_commit_count_slave             | 0         |
| Ndb_api_trans_abort_count_slave              | 0         |
| Ndb_api_trans_close_count_slave              | 0         |
| Ndb_api_pk_op_count_slave                    | 0         |
| Ndb_api_uk_op_count_slave                    | 0         |
| Ndb_api_table_scan_count_slave               | 0         |
| Ndb_api_range_scan_count_slave               | 0         |
| Ndb_api_pruned_scan_count_slave              | 0         |
| Ndb_api_scan_batch_count_slave               | 0         |
| Ndb_api_read_row_count_slave                 | 0         |
| Ndb_api_trans_local_read_row_count_slave     | 0         |
| Ndb_api_adaptive_send_forced_count_slave     | 0         |
| Ndb_api_adaptive_send_unforced_count_slave   | 0         |
| Ndb_api_adaptive_send_deferred_count_slave   | 0         |
| Ndb_api_wait_exec_complete_count_replica     | 0         |
| Ndb_api_wait_scan_result_count_replica       | 0         |
| Ndb_api_wait_meta_request_count_replica      | 0         |
| Ndb_api_wait_nanos_count_replica             | 0         |
| Ndb_api_bytes_sent_count_replica             | 0         |
| Ndb_api_bytes_received_count_replica         | 0         |
| Ndb_api_trans_start_count_replica            | 0         |
| Ndb_api_trans_commit_count_replica           | 0         |
| Ndb_api_trans_abort_count_replica            | 0         |
| Ndb_api_trans_close_count_replica            | 0         |
| Ndb_api_pk_op_count_replica                  | 0         |
| Ndb_api_uk_op_count_replica                  | 0         |
| Ndb_api_table_scan_count_replica             | 0         |
| Ndb_api_range_scan_count_replica             | 0         |
| Ndb_api_pruned_scan_count_replica            | 0         |
| Ndb_api_scan_batch_count_replica             | 0         |
| Ndb_api_read_row_count_replica               | 0         |
| Ndb_api_trans_local_read_row_count_replica   | 0         |
| Ndb_api_adaptive_send_forced_count_replica   | 0         |
| Ndb_api_adaptive_send_unforced_count_replica | 0         |
| Ndb_api_adaptive_send_deferred_count_replica | 0         |
| Ndb_api_event_data_count_injector            | 0         |
| Ndb_api_event_nondata_count_injector         | 0         |
| Ndb_api_event_bytes_count_injector           | 0         |
| Ndb_api_wait_exec_complete_count_session     | 0         |
| Ndb_api_wait_scan_result_count_session       | 0         |
| Ndb_api_wait_meta_request_count_session      | 0         |
| Ndb_api_wait_nanos_count_session             | 0         |
| Ndb_api_bytes_sent_count_session             | 0         |
| Ndb_api_bytes_received_count_session         | 0         |
| Ndb_api_trans_start_count_session            | 0         |
| Ndb_api_trans_commit_count_session           | 0         |
| Ndb_api_trans_abort_count_session            | 0         |
| Ndb_api_trans_close_count_session            | 0         |
| Ndb_api_pk_op_count_session                  | 0         |
| Ndb_api_uk_op_count_session                  | 0         |
| Ndb_api_table_scan_count_session             | 0         |
| Ndb_api_range_scan_count_session             | 0         |
| Ndb_api_pruned_scan_count_session            | 0         |
| Ndb_api_scan_batch_count_session             | 0         |
| Ndb_api_read_row_count_session               | 0         |
| Ndb_api_trans_local_read_row_count_session   | 0         |
| Ndb_api_adaptive_send_forced_count_session   | 0         |
| Ndb_api_adaptive_send_unforced_count_session | 0         |
| Ndb_api_adaptive_send_deferred_count_session | 0         |
+----------------------------------------------+-----------+
90 rows in set (0.01 sec)
这些状态变量也可从性能模式session_status和
global_status表中获得，如下所示：
mysql> SELECT * FROM performance_schema.session_status
->   WHERE VARIABLE_NAME LIKE 'ndb_api%';
+----------------------------------------------+----------------+
| VARIABLE_NAME                                | VARIABLE_VALUE |
+----------------------------------------------+----------------+
| Ndb_api_wait_exec_complete_count             | 617            |
| Ndb_api_wait_scan_result_count               | 0              |
| Ndb_api_wait_meta_request_count              | 649            |
| Ndb_api_wait_nanos_count                     | 335663491      |
| Ndb_api_bytes_sent_count                     | 65764          |
| Ndb_api_bytes_received_count                 | 86940          |
| Ndb_api_trans_start_count                    | 308            |
| Ndb_api_trans_commit_count                   | 308            |
| Ndb_api_trans_abort_count                    | 0              |
| Ndb_api_trans_close_count                    | 308            |
| Ndb_api_pk_op_count                          | 311            |
| Ndb_api_uk_op_count                          | 0              |
| Ndb_api_table_scan_count                     | 0              |
| Ndb_api_range_scan_count                     | 0              |
| Ndb_api_pruned_scan_count                    | 0              |
| Ndb_api_scan_batch_count                     | 0              |
| Ndb_api_read_row_count                       | 307            |
| Ndb_api_trans_local_read_row_count           | 77             |
| Ndb_api_adaptive_send_forced_count           | 3              |
| Ndb_api_adaptive_send_unforced_count         | 614            |
| Ndb_api_adaptive_send_deferred_count         | 0              |
| Ndb_api_event_data_count                     | 0              |
| Ndb_api_event_nondata_count                  | 0              |
| Ndb_api_event_bytes_count                    | 0              |
| Ndb_api_wait_exec_complete_count_slave       | 0              |
| Ndb_api_wait_scan_result_count_slave         | 0              |
| Ndb_api_wait_meta_request_count_slave        | 0              |
| Ndb_api_wait_nanos_count_slave               | 0              |
| Ndb_api_bytes_sent_count_slave               | 0              |
| Ndb_api_bytes_received_count_slave           | 0              |
| Ndb_api_trans_start_count_slave              | 0              |
| Ndb_api_trans_commit_count_slave             | 0              |
| Ndb_api_trans_abort_count_slave              | 0              |
| Ndb_api_trans_close_count_slave              | 0              |
| Ndb_api_pk_op_count_slave                    | 0              |
| Ndb_api_uk_op_count_slave                    | 0              |
| Ndb_api_table_scan_count_slave               | 0              |
| Ndb_api_range_scan_count_slave               | 0              |
| Ndb_api_pruned_scan_count_slave              | 0              |
| Ndb_api_scan_batch_count_slave               | 0              |
| Ndb_api_read_row_count_slave                 | 0              |
| Ndb_api_trans_local_read_row_count_slave     | 0              |
| Ndb_api_adaptive_send_forced_count_slave     | 0              |
| Ndb_api_adaptive_send_unforced_count_slave   | 0              |
| Ndb_api_adaptive_send_deferred_count_slave   | 0              |
| Ndb_api_wait_exec_complete_count_replica     | 0              |
| Ndb_api_wait_scan_result_count_replica       | 0              |
| Ndb_api_wait_meta_request_count_replica      | 0              |
| Ndb_api_wait_nanos_count_replica             | 0              |
| Ndb_api_bytes_sent_count_replica             | 0              |
| Ndb_api_bytes_received_count_replica         | 0              |
| Ndb_api_trans_start_count_replica            | 0              |
| Ndb_api_trans_commit_count_replica           | 0              |
| Ndb_api_trans_abort_count_replica            | 0              |
| Ndb_api_trans_close_count_replica            | 0              |
| Ndb_api_pk_op_count_replica                  | 0              |
| Ndb_api_uk_op_count_replica                  | 0              |
| Ndb_api_table_scan_count_replica             | 0              |
| Ndb_api_range_scan_count_replica             | 0              |
| Ndb_api_pruned_scan_count_replica            | 0              |
| Ndb_api_scan_batch_count_replica             | 0              |
| Ndb_api_read_row_count_replica               | 0              |
| Ndb_api_trans_local_read_row_count_replica   | 0              |
| Ndb_api_adaptive_send_forced_count_replica   | 0              |
| Ndb_api_adaptive_send_unforced_count_replica | 0              |
| Ndb_api_adaptive_send_deferred_count_replica | 0              |
| Ndb_api_event_data_count_injector            | 0              |
| Ndb_api_event_nondata_count_injector         | 0              |
| Ndb_api_event_bytes_count_injector           | 0              |
| Ndb_api_wait_exec_complete_count_session     | 0              |
| Ndb_api_wait_scan_result_count_session       | 0              |
| Ndb_api_wait_meta_request_count_session      | 0              |
| Ndb_api_wait_nanos_count_session             | 0              |
| Ndb_api_bytes_sent_count_session             | 0              |
| Ndb_api_bytes_received_count_session         | 0              |
| Ndb_api_trans_start_count_session            | 0              |
| Ndb_api_trans_commit_count_session           | 0              |
| Ndb_api_trans_abort_count_session            | 0              |
| Ndb_api_trans_close_count_session            | 0              |
| Ndb_api_pk_op_count_session                  | 0              |
| Ndb_api_uk_op_count_session                  | 0              |
| Ndb_api_table_scan_count_session             | 0              |
| Ndb_api_range_scan_count_session             | 0              |
| Ndb_api_pruned_scan_count_session            | 0              |
| Ndb_api_scan_batch_count_session             | 0              |
| Ndb_api_read_row_count_session               | 0              |
| Ndb_api_trans_local_read_row_count_session   | 0              |
| Ndb_api_adaptive_send_forced_count_session   | 0              |
| Ndb_api_adaptive_send_unforced_count_session | 0              |
| Ndb_api_adaptive_send_deferred_count_session | 0              |
+----------------------------------------------+----------------+
90 rows in set (0.01 sec)
mysql> SELECT * FROM performance_schema.global_status
->     WHERE VARIABLE_NAME LIKE 'ndb_api%';
+----------------------------------------------+----------------+
| VARIABLE_NAME                                | VARIABLE_VALUE |
+----------------------------------------------+----------------+
| Ndb_api_wait_exec_complete_count             | 741            |
| Ndb_api_wait_scan_result_count               | 0              |
| Ndb_api_wait_meta_request_count              | 777            |
| Ndb_api_wait_nanos_count                     | 373888309      |
| Ndb_api_bytes_sent_count                     | 78124          |
| Ndb_api_bytes_received_count                 | 94988          |
| Ndb_api_trans_start_count                    | 370            |
| Ndb_api_trans_commit_count                   | 370            |
| Ndb_api_trans_abort_count                    | 0              |
| Ndb_api_trans_close_count                    | 370            |
| Ndb_api_pk_op_count                          | 373            |
| Ndb_api_uk_op_count                          | 0              |
| Ndb_api_table_scan_count                     | 0              |
| Ndb_api_range_scan_count                     | 0              |
| Ndb_api_pruned_scan_count                    | 0              |
| Ndb_api_scan_batch_count                     | 0              |
| Ndb_api_read_row_count                       | 369            |
| Ndb_api_trans_local_read_row_count           | 93             |
| Ndb_api_adaptive_send_forced_count           | 3              |
| Ndb_api_adaptive_send_unforced_count         | 738            |
| Ndb_api_adaptive_send_deferred_count         | 0              |
| Ndb_api_event_data_count                     | 0              |
| Ndb_api_event_nondata_count                  | 0              |
| Ndb_api_event_bytes_count                    | 0              |
| Ndb_api_wait_exec_complete_count_slave       | 0              |
| Ndb_api_wait_scan_result_count_slave         | 0              |
| Ndb_api_wait_meta_request_count_slave        | 0              |
| Ndb_api_wait_nanos_count_slave               | 0              |
| Ndb_api_bytes_sent_count_slave               | 0              |
| Ndb_api_bytes_received_count_slave           | 0              |
| Ndb_api_trans_start_count_slave              | 0              |
| Ndb_api_trans_commit_count_slave             | 0              |
| Ndb_api_trans_abort_count_slave              | 0              |
| Ndb_api_trans_close_count_slave              | 0              |
| Ndb_api_pk_op_count_slave                    | 0              |
| Ndb_api_uk_op_count_slave                    | 0              |
| Ndb_api_table_scan_count_slave               | 0              |
| Ndb_api_range_scan_count_slave               | 0              |
| Ndb_api_pruned_scan_count_slave              | 0              |
| Ndb_api_scan_batch_count_slave               | 0              |
| Ndb_api_read_row_count_slave                 | 0              |
| Ndb_api_trans_local_read_row_count_slave     | 0              |
| Ndb_api_adaptive_send_forced_count_slave     | 0              |
| Ndb_api_adaptive_send_unforced_count_slave   | 0              |
| Ndb_api_adaptive_send_deferred_count_slave   | 0              |
| Ndb_api_wait_exec_complete_count_replica     | 0              |
| Ndb_api_wait_scan_result_count_replica       | 0              |
| Ndb_api_wait_meta_request_count_replica      | 0              |
| Ndb_api_wait_nanos_count_replica             | 0              |
| Ndb_api_bytes_sent_count_replica             | 0              |
| Ndb_api_bytes_received_count_replica         | 0              |
| Ndb_api_trans_start_count_replica            | 0              |
| Ndb_api_trans_commit_count_replica           | 0              |
| Ndb_api_trans_abort_count_replica            | 0              |
| Ndb_api_trans_close_count_replica            | 0              |
| Ndb_api_pk_op_count_replica                  | 0              |
| Ndb_api_uk_op_count_replica                  | 0              |
| Ndb_api_table_scan_count_replica             | 0              |
| Ndb_api_range_scan_count_replica             | 0              |
| Ndb_api_pruned_scan_count_replica            | 0              |
| Ndb_api_scan_batch_count_replica             | 0              |
| Ndb_api_read_row_count_replica               | 0              |
| Ndb_api_trans_local_read_row_count_replica   | 0              |
| Ndb_api_adaptive_send_forced_count_replica   | 0              |
| Ndb_api_adaptive_send_unforced_count_replica | 0              |
| Ndb_api_adaptive_send_deferred_count_replica | 0              |
| Ndb_api_event_data_count_injector            | 0              |
| Ndb_api_event_nondata_count_injector         | 0              |
| Ndb_api_event_bytes_count_injector           | 0              |
| Ndb_api_wait_exec_complete_count_session     | 0              |
| Ndb_api_wait_scan_result_count_session       | 0              |
| Ndb_api_wait_meta_request_count_session      | 0              |
| Ndb_api_wait_nanos_count_session             | 0              |
| Ndb_api_bytes_sent_count_session             | 0              |
| Ndb_api_bytes_received_count_session         | 0              |
| Ndb_api_trans_start_count_session            | 0              |
| Ndb_api_trans_commit_count_session           | 0              |
| Ndb_api_trans_abort_count_session            | 0              |
| Ndb_api_trans_close_count_session            | 0              |
| Ndb_api_pk_op_count_session                  | 0              |
| Ndb_api_uk_op_count_session                  | 0              |
| Ndb_api_table_scan_count_session             | 0              |
| Ndb_api_range_scan_count_session             | 0              |
| Ndb_api_pruned_scan_count_session            | 0              |
| Ndb_api_scan_batch_count_session             | 0              |
| Ndb_api_read_row_count_session               | 0              |
| Ndb_api_trans_local_read_row_count_session   | 0              |
| Ndb_api_adaptive_send_forced_count_session   | 0              |
| Ndb_api_adaptive_send_unforced_count_session | 0              |
| Ndb_api_adaptive_send_deferred_count_session | 0              |
+----------------------------------------------+----------------+
90 rows in set (0.01 sec)
每个Ndb对象都有自己的计数器。NDB API 应用程序可以读取计数器的值以用于优化或监视。对于同时使用多个Ndb
对象的多线程客户端，还可以Ndb从属于给定
Ndb_cluster_connection.
暴露了四组这样的计数器。一组仅适用于当前会话；其他 3 个是全球性的。尽管事实上它们的值可以作为mysql
客户端中的会话或全局状态变量获得。这意味着指定
SESSIONorGLOBAL关键字SHOW STATUS对为 NDB API 统计状态变量报告的值没有影响，并且这些变量中的每一个的值是相同的，无论该值是从
session_statusor
global_status表的等效列获得的。
会话计数器（特定于会话）
会话计数器与
Ndb（仅）当前会话使用的对象相关。其他 MySQL 客户端使用此类对象不会影响这些计数。
为了尽量减少与标准 MySQL 会话变量的混淆，我们将与这些 NDB API 会话计数器对应的变量称为“_session
变量”，并带有前导下划线。
副本计数器（全局）
这组计数器与
Ndb副本 SQL 线程使用的对象相关，如果有的话。如果这个mysqld
不充当副本，或者不使用
NDB表，那么所有这些计数都是 0。
我们将相关的状态变量称为
“_slave变量”（带前导下划线）。
喷油器计数器（全球）
注入器计数器与
Ndb二进制日志注入器线程用于侦听集群事件的对象有关。即使不写入二进制日志，附加到 NDB Cluster 的mysqld进程也会继续侦听某些事件，例如模式更改。
我们将与 NDB API 注入器计数器对应的状态变量称为“_injector
变量”（带有前导下划线）。
服务器（全局）计数器（全局）
这组计数器与
该mysqldNdb当前使用的所有对象相关。这包括所有 MySQL 客户端应用程序、副本 SQL 线程（如果有）、二进制日志注入器和实用程序线程。
NDB
我们将与这些计数器对应的状态变量称为“全局变量”或
“ mysqld级变量”。
session您可以通过额外过滤子字符串、slave或
injector变量名称（连同公共前缀Ndb_api）
来获取一组特定变量的值
。对于
_session变量，这可以如下所示完成：
mysql> SHOW STATUS LIKE 'ndb_api%session';
+--------------------------------------------+---------+
| Variable_name                              | Value   |
+--------------------------------------------+---------+
| Ndb_api_wait_exec_complete_count_session   | 2       |
| Ndb_api_wait_scan_result_count_session     | 0       |
| Ndb_api_wait_meta_request_count_session    | 1       |
| Ndb_api_wait_nanos_count_session           | 8144375 |
| Ndb_api_bytes_sent_count_session           | 68      |
| Ndb_api_bytes_received_count_session       | 84      |
| Ndb_api_trans_start_count_session          | 1       |
| Ndb_api_trans_commit_count_session         | 1       |
| Ndb_api_trans_abort_count_session          | 0       |
| Ndb_api_trans_close_count_session          | 1       |
| Ndb_api_pk_op_count_session                | 1       |
| Ndb_api_uk_op_count_session                | 0       |
| Ndb_api_table_scan_count_session           | 0       |
| Ndb_api_range_scan_count_session           | 0       |
| Ndb_api_pruned_scan_count_session          | 0       |
| Ndb_api_scan_batch_count_session           | 0       |
| Ndb_api_read_row_count_session             | 1       |
| Ndb_api_trans_local_read_row_count_session | 1       |
+--------------------------------------------+---------+
18 rows in set (0.50 sec)
要获取 NDB API mysqld级状态变量的列表，请过滤以开头
ndb_api和结尾
的变量名称_count，如下所示：
mysql> SELECT * FROM performance_schema.session_status
->     WHERE VARIABLE_NAME LIKE 'ndb_api%count';
+------------------------------------+----------------+
| VARIABLE_NAME                      | VARIABLE_VALUE |
+------------------------------------+----------------+
| NDB_API_WAIT_EXEC_COMPLETE_COUNT   | 4              |
| NDB_API_WAIT_SCAN_RESULT_COUNT     | 3              |
| NDB_API_WAIT_META_REQUEST_COUNT    | 28             |
| NDB_API_WAIT_NANOS_COUNT           | 53756398       |
| NDB_API_BYTES_SENT_COUNT           | 1060           |
| NDB_API_BYTES_RECEIVED_COUNT       | 9724           |
| NDB_API_TRANS_START_COUNT          | 3              |
| NDB_API_TRANS_COMMIT_COUNT         | 2              |
| NDB_API_TRANS_ABORT_COUNT          | 0              |
| NDB_API_TRANS_CLOSE_COUNT          | 3              |
| NDB_API_PK_OP_COUNT                | 2              |
| NDB_API_UK_OP_COUNT                | 0              |
| NDB_API_TABLE_SCAN_COUNT           | 1              |
| NDB_API_RANGE_SCAN_COUNT           | 0              |
| NDB_API_PRUNED_SCAN_COUNT          | 0              |
| NDB_API_SCAN_BATCH_COUNT           | 0              |
| NDB_API_READ_ROW_COUNT             | 2              |
| NDB_API_TRANS_LOCAL_READ_ROW_COUNT | 2              |
| NDB_API_EVENT_DATA_COUNT           | 0              |
| NDB_API_EVENT_NONDATA_COUNT        | 0              |
| NDB_API_EVENT_BYTES_COUNT          | 0              |
+------------------------------------+----------------+
21 rows in set (0.09 sec)
并非所有计数器都反映在所有 4 组状态变量中。对于事件计数器DataEventsRecvdCount、
NondataEventsRecvdCount和
EventBytesRecvdCount，只有
_injector和mysqld级别的 NDB API 状态变量可用：
mysql> SHOW STATUS LIKE 'ndb_api%event%';
+--------------------------------------+-------+
| Variable_name                        | Value |
+--------------------------------------+-------+
| Ndb_api_event_data_count_injector    | 0     |
| Ndb_api_event_nondata_count_injector | 0     |
| Ndb_api_event_bytes_count_injector   | 0     |
| Ndb_api_event_data_count             | 0     |
| Ndb_api_event_nondata_count          | 0     |
| Ndb_api_event_bytes_count            | 0     |
+--------------------------------------+-------+
6 rows in set (0.00 sec)
_injector没有为任何其他 NDB API 计数器实现状态变量，如下所示：
mysql> SHOW STATUS LIKE 'ndb_api%injector%';
+--------------------------------------+-------+
| Variable_name                        | Value |
+--------------------------------------+-------+
| Ndb_api_event_data_count_injector    | 0     |
| Ndb_api_event_nondata_count_injector | 0     |
| Ndb_api_event_bytes_count_injector   | 0     |
+--------------------------------------+-------+
3 rows in set (0.00 sec)
状态变量的名称可以很容易地与相应计数器的名称相关联。每个 NDB API 统计计数器在下表中列出，并带有描述以及与此计数器对应的任何 MySQL 服务器状态变量的名称。
表 23.67 NDB API 统计计数器
柜台名称
描述
状态变量（按统计类型）：
会议
奴隶（复制品）
注射器
服务器
WaitExecCompleteCount
在等待操作执行完成时线程被阻塞的次数。包括所有
execute()
调用以及对客户端不可见的 blob 操作和自动增量的隐式执行。
Ndb_api_wait_exec_complete_count_session
Ndb_api_wait_exec_complete_count_slave
[没有任何]
Ndb_api_wait_exec_complete_count
WaitScanResultCount
线程在等待基于扫描的信号时被阻塞的次数，例如等待其他结果或扫描关闭。
Ndb_api_wait_scan_result_count_session
Ndb_api_wait_scan_result_count_slave
[没有任何]
Ndb_api_wait_scan_result_count
WaitMetaRequestCount
线程被阻塞等待基于元数据的信号的次数；这可能发生在等待 DDL 操作或开始（或结束）纪元时。
Ndb_api_wait_meta_request_count_session
Ndb_api_wait_meta_request_count_slave
[没有任何]
Ndb_api_wait_meta_request_count
WaitNanosCount
等待来自数据节点的某种类型的信号所花费的总时间（以纳秒为单位）。
Ndb_api_wait_nanos_count_session
Ndb_api_wait_nanos_count_slave
[没有任何]
Ndb_api_wait_nanos_count
BytesSentCount
发送到数据节点的数据量（以字节为单位）
Ndb_api_bytes_sent_count_session
Ndb_api_bytes_sent_count_slave
[没有任何]
Ndb_api_bytes_sent_count
BytesRecvdCount
从数据节点接收的数据量（以字节为单位）
Ndb_api_bytes_received_count_session
Ndb_api_bytes_received_count_slave
[没有任何]
Ndb_api_bytes_received_count
TransStartCount
开始的事务数。
Ndb_api_trans_start_count_session
Ndb_api_trans_start_count_slave
[没有任何]
Ndb_api_trans_start_count
TransCommitCount
提交的事务数。
Ndb_api_trans_commit_count_session
Ndb_api_trans_commit_count_slave
[没有任何]
Ndb_api_trans_commit_count
TransAbortCount
中止的事务数。
Ndb_api_trans_abort_count_session
Ndb_api_trans_abort_count_slave
[没有任何]
Ndb_api_trans_abort_count
TransCloseCount
中止的事务数。（此值可能大于 和 的总和TransCommitCount。
TransAbortCount）
Ndb_api_trans_close_count_session
Ndb_api_trans_close_count_slave
[没有任何]
Ndb_api_trans_close_count
PkOpCount
基于或使用主键的操作数。此计数包括 blob 部分表操作、隐式解锁操作和自动增量操作，以及通常对 MySQL 客户端可见的主键操作。
Ndb_api_pk_op_count_session
Ndb_api_pk_op_count_slave
[没有任何]
Ndb_api_pk_op_count
UkOpCount
基于或使用唯一键的操作数。
Ndb_api_uk_op_count_session
Ndb_api_uk_op_count_slave
[没有任何]
Ndb_api_uk_op_count
TableScanCount
已启动的表扫描数。这包括内部表的扫描。
Ndb_api_table_scan_count_session
Ndb_api_table_scan_count_slave
[没有任何]
Ndb_api_table_scan_count
RangeScanCount
已开始的范围扫描数。
Ndb_api_range_scan_count_session
Ndb_api_range_scan_count_slave
[没有任何]
Ndb_api_range_scan_count
PrunedScanCount
已修剪为单个分区的扫描数。
Ndb_api_pruned_scan_count_session
Ndb_api_pruned_scan_count_slave
[没有任何]
Ndb_api_pruned_scan_count
ScanBatchCount
收到的批次行数。（此上下文中的
批次是来自单个片段的一组扫描结果。）
Ndb_api_scan_batch_count_session
Ndb_api_scan_batch_count_slave
[没有任何]
Ndb_api_scan_batch_count
ReadRowCount
已读取的总行数。包括使用主键、唯一键和扫描操作读取的行。
Ndb_api_read_row_count_session
Ndb_api_read_row_count_slave
[没有任何]
Ndb_api_read_row_count
TransLocalReadRowCount
从运行事务的同一节点的数据读取的行数。
Ndb_api_trans_local_read_row_count_session
Ndb_api_trans_local_read_row_count_slave
[没有任何]
Ndb_api_trans_local_read_row_count
DataEventsRecvdCount
收到的行更改事件数。
[没有任何]
[没有任何]
Ndb_api_event_data_count_injector
Ndb_api_event_data_count
NondataEventsRecvdCount
收到的事件数，行更改事件除外。
[没有任何]
[没有任何]
Ndb_api_event_nondata_count_injector
Ndb_api_event_nondata_count
EventBytesRecvdCount
接收到的事件的字节数。
[没有任何]
[没有任何]
Ndb_api_event_bytes_count_injector
Ndb_api_event_bytes_count
要查看已提交事务的所有计数（即所有
TransCommitCount计数器状态变量），您可以过滤
SHOW STATUSsubstring
的结果trans_commit_count，如下所示：
mysql> SHOW STATUS LIKE '%trans_commit_count%';
+------------------------------------+-------+
| Variable_name                      | Value |
+------------------------------------+-------+
| Ndb_api_trans_commit_count_session | 1     |
| Ndb_api_trans_commit_count_slave   | 0     |
| Ndb_api_trans_commit_count         | 2     |
+------------------------------------+-------+
3 rows in set (0.00 sec)
由此可以确定，在当前mysql客户端会话中已经提交了1个事务，
自从上次重启后，
在这个mysqld上已经提交了2个事务。_session通过比较执行语句前后
相应状态变量的值，您可以看到给定 SQL 语句如何增加各种 NDB API 计数器
。在此示例中，从 获取初始值后SHOW
STATUS，我们在test
数据库中创建一个NDB名为 的表，
该表t只有一列：
mysql> SHOW STATUS LIKE 'ndb_api%session%';
+--------------------------------------------+--------+
| Variable_name                              | Value  |
+--------------------------------------------+--------+
| Ndb_api_wait_exec_complete_count_session   | 2      |
| Ndb_api_wait_scan_result_count_session     | 0      |
| Ndb_api_wait_meta_request_count_session    | 3      |
| Ndb_api_wait_nanos_count_session           | 820705 |
| Ndb_api_bytes_sent_count_session           | 132    |
| Ndb_api_bytes_received_count_session       | 372    |
| Ndb_api_trans_start_count_session          | 1      |
| Ndb_api_trans_commit_count_session         | 1      |
| Ndb_api_trans_abort_count_session          | 0      |
| Ndb_api_trans_close_count_session          | 1      |
| Ndb_api_pk_op_count_session                | 1      |
| Ndb_api_uk_op_count_session                | 0      |
| Ndb_api_table_scan_count_session           | 0      |
| Ndb_api_range_scan_count_session           | 0      |
| Ndb_api_pruned_scan_count_session          | 0      |
| Ndb_api_scan_batch_count_session           | 0      |
| Ndb_api_read_row_count_session             | 1      |
| Ndb_api_trans_local_read_row_count_session | 1      |
+--------------------------------------------+--------+
18 rows in set (0.00 sec)
mysql> USE test;
Database changed
mysql> CREATE TABLE t (c INT) ENGINE NDBCLUSTER;
Query OK, 0 rows affected (0.85 sec)
现在您可以执行一条新SHOW
STATUS语句并观察更改，如下所示（更改的行在输出中突出显示）：
mysql> SHOW STATUS LIKE 'ndb_api%session%';
+--------------------------------------------+-----------+
| Variable_name                              | Value     |
+--------------------------------------------+-----------+
| Ndb_api_wait_exec_complete_count_session   | 8         |
| Ndb_api_wait_scan_result_count_session     | 0         |
| Ndb_api_wait_meta_request_count_session    | 17        |
| Ndb_api_wait_nanos_count_session           | 706871709 |
| Ndb_api_bytes_sent_count_session           | 2376      |
| Ndb_api_bytes_received_count_session       | 3844      |
| Ndb_api_trans_start_count_session          | 4         |
| Ndb_api_trans_commit_count_session         | 4         |
| Ndb_api_trans_abort_count_session          | 0         |
| Ndb_api_trans_close_count_session          | 4         |
| Ndb_api_pk_op_count_session                | 6         |
| Ndb_api_uk_op_count_session                | 0         |
| Ndb_api_table_scan_count_session           | 0         |
| Ndb_api_range_scan_count_session           | 0         |
| Ndb_api_pruned_scan_count_session          | 0         |
| Ndb_api_scan_batch_count_session           | 0         |
| Ndb_api_read_row_count_session             | 2         |
| Ndb_api_trans_local_read_row_count_session | 1         |
+--------------------------------------------+-----------+
18 rows in set (0.00 sec)
同样，您可以看到将行插入到 NDB API 统计计数器中的变化t：插入行，然后运行与SHOW
STATUS上一个示例相同的语句，如下所示：
mysql> INSERT INTO t VALUES (100);
Query OK, 1 row affected (0.00 sec)
mysql> SHOW STATUS LIKE 'ndb_api%session%';
+--------------------------------------------+-----------+
| Variable_name                              | Value     |
+--------------------------------------------+-----------+
| Ndb_api_wait_exec_complete_count_session   | 11        |
| Ndb_api_wait_scan_result_count_session     | 6         |
| Ndb_api_wait_meta_request_count_session    | 20        |
| Ndb_api_wait_nanos_count_session           | 707370418 |
| Ndb_api_bytes_sent_count_session           | 2724      |
| Ndb_api_bytes_received_count_session       | 4116      |
| Ndb_api_trans_start_count_session          | 7         |
| Ndb_api_trans_commit_count_session         | 6         |
| Ndb_api_trans_abort_count_session          | 0         |
| Ndb_api_trans_close_count_session          | 7         |
| Ndb_api_pk_op_count_session                | 8         |
| Ndb_api_uk_op_count_session                | 0         |
| Ndb_api_table_scan_count_session           | 1         |
| Ndb_api_range_scan_count_session           | 0         |
| Ndb_api_pruned_scan_count_session          | 0         |
| Ndb_api_scan_batch_count_session           | 0         |
| Ndb_api_read_row_count_session             | 3         |
| Ndb_api_trans_local_read_row_count_session | 2         |
+--------------------------------------------+-----------+
18 rows in set (0.00 sec)
我们可以从这些结果中得出一些结论：
尽管我们创建t时没有显式主键，但这样做执行了 5 次主键操作（“之前”和
“之后”值
的差异Ndb_api_pk_op_count_session，或 6 减 1）。这反映了隐藏主键的创建，这是使用
NDB存储引擎的所有表的一个特性。
通过比较 的连续值
Ndb_api_wait_nanos_count_session，我们可以看到实现
CREATE TABLE语句的 NDB API 操作等待数据节点响应的时间比
INSERT（707370418 - 706871709 = 498709 ns 或大约 0.0005 秒）。在mysql客户端中报告的这些语句的执行时间
与这些数字大致相关。
在没有足够（纳秒）时间分辨率的平台上，由于执行速度非常快的 SQL 语句导致的 NDB API 计数器值的微小变化
WaitNanosCount可能并不总是在 、 或 的值
Ndb_api_wait_nanos_count_session中
Ndb_api_wait_nanos_count_slave可见Ndb_api_wait_nanos_count。
该INSERT语句增加了ReadRowCount和
TransLocalReadRowCountNDB API 统计计数器，这反映在 和 的增加值
Ndb_api_read_row_count_session
上
Ndb_api_trans_local_read_row_count_session。
© Mysql 中文网
