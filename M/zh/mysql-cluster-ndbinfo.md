# 23.6.15 ndbinfo：NDB 集群信息数据库_MySQL 8.0 参考手册

23.6.15 ndbinfo：NDB 集群信息数据库_MySQL 8.0 参考手册
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
23.6.15.1 ndbinfo arbitrator_validity_detail 表
23.6.15.2 ndbinfo arbitrator_validity_summary 表
23.6.15.3 ndbinfo backup_id 表
23.6.15.4 ndbinfo blob 表
23.6.15.5 ndbinfo 块表
23.6.15.6 ndbinfo cluster_locks 表
23.6.15.7 ndbinfo cluster_operations 表
23.6.15.8 ndbinfo cluster_transactions 表
23.6.15.9 ndbinfo config_nodes 表
23.6.15.10 ndbinfo config_params 表
23.6.15.11 ndbinfo config_values 表
23.6.15.12 ndbinfo 计数器表
23.6.15.13 ndbinfo cpudata 表
23.6.15.14 ndbinfo cpudata_1sec 表
23.6.15.15 ndbinfo cpudata_20sec 表
23.6.15.16 ndbinfo cpudata_50ms 表
23.6.15.17 ndbinfo cpuinfo 表
23.6.15.18 ndbinfo cpustat 表
23.6.15.19 ndbinfo cpustat_50ms 表
23.6.15.20 ndbinfo cpustat_1sec 表
23.6.15.21 ndbinfo cpustat_20sec 表
23.6.15.22 ndbinfo dictionary_columns 表
23.6.15.23 ndbinfo dictionary_tables 表
23.6.15.24 ndbinfo dict_obj_info 表
23.6.15.25 ndbinfo dict_obj_tree 表
23.6.15.26 ndbinfo dict_obj_types 表
23.6.15.27 ndbinfo disk_write_speed_base 表
23.6.15.28 ndbinfo disk_write_speed_aggregate 表
23.6.15.29 ndbinfo disk_write_speed_aggregate_node 表
23.6.15.30 ndbinfo diskpagebuffer 表
23.6.15.31 ndbinfo diskstat 表
23.6.15.32 ndbinfo diskstats_1sec 表
23.6.15.33 ndbinfo error_messages 表
23.6.15.34 ndbinfo 事件表
23.6.15.35 ndbinfo 文件表
23.6.15.36 ndbinfo foreign_keys 表
23.6.15.37 ndbinfo hash_maps 表
23.6.15.38 ndbinfo hwinfo 表
23.6.15.39 ndbinfo index_columns 表
23.6.15.40 ndbinfo index_stats 表
23.6.15.41 ndbinfo locks_per_fragment 表
23.6.15.42 ndbinfo 日志缓冲区表
23.6.15.43 ndbinfo 日志空间表
23.6.15.44 ndbinfo 成员表
23.6.15.45 ndbinfo 内存使用表
23.6.15.46 ndbinfo memory_per_fragment 表
23.6.15.47 ndbinfo 节点表
23.6.15.48 ndbinfo operations_per_fragment 表
23.6.15.49 ndbinfo pgman_time_track_stats 表
23.6.15.50 ndbinfo 进程表
23.6.15.51 ndbinfo 资源表
23.6.15.52 ndbinfo restart_info 表
23.6.15.53 ndbinfo server_locks 表
23.6.15.54 ndbinfo server_operations 表
23.6.15.55 ndbinfo server_transactions 表
23.6.15.56 ndbinfo table_distribution_status 表
23.6.15.57 ndbinfo table_fragments 表
23.6.15.58 ndbinfo table_info 表
23.6.15.59 ndbinfo table_replicas 表
23.6.15.60 ndbinfo tc_time_track_stats 表
23.6.15.61 ndbinfo 线程块表
23.6.15.62 ndbinfo 线程表
23.6.15.63 ndbinfo threadstat 表
23.6.15.64 ndbinfo 传输器表
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
23.6.15 ndbinfo：NDB 集群信息数据库
23.6.15 ndbinfo：NDB 集群信息数据库
23.6.15.1 ndbinfo arbitrator_validity_detail 表23.6.15.2 ndbinfo arbitrator_validity_summary 表23.6.15.3 ndbinfo backup_id 表23.6.15.4 ndbinfo blob 表23.6.15.5 ndbinfo 块表23.6.15.6 ndbinfo cluster_locks 表23.6.15.7 ndbinfo cluster_operations 表23.6.15.8 ndbinfo cluster_transactions 表23.6.15.9 ndbinfo config_nodes 表23.6.15.10 ndbinfo config_params 表23.6.15.11 ndbinfo config_values 表23.6.15.12 ndbinfo 计数器表23.6.15.13 ndbinfo cpudata 表23.6.15.14 ndbinfo cpudata_1sec 表23.6.15.15 ndbinfo cpudata_20sec 表23.6.15.16 ndbinfo cpudata_50ms 表23.6.15.17 ndbinfo cpuinfo 表23.6.15.18 ndbinfo cpustat 表23.6.15.19 ndbinfo cpustat_50ms 表23.6.15.20 ndbinfo cpustat_1sec 表23.6.15.21 ndbinfo cpustat_20sec 表23.6.15.22 ndbinfo dictionary_columns 表23.6.15.23 ndbinfo dictionary_tables 表23.6.15.24 ndbinfo dict_obj_info 表23.6.15.25 ndbinfo dict_obj_tree 表23.6.15.26 ndbinfo dict_obj_types 表23.6.15.27 ndbinfo disk_write_speed_base 表23.6.15.28 ndbinfo disk_write_speed_aggregate 表23.6.15.29 ndbinfo disk_write_speed_aggregate_node 表23.6.15.30 ndbinfo diskpagebuffer 表23.6.15.31 ndbinfo diskstat 表23.6.15.32 ndbinfo diskstats_1sec 表23.6.15.33 ndbinfo error_messages 表23.6.15.34 ndbinfo 事件表23.6.15.35 ndbinfo 文件表23.6.15.36 ndbinfo foreign_keys 表23.6.15.37 ndbinfo hash_maps 表23.6.15.38 ndbinfo hwinfo 表23.6.15.39 ndbinfo index_columns 表23.6.15.40 ndbinfo index_stats 表23.6.15.41 ndbinfo locks_per_fragment 表23.6.15.42 ndbinfo 日志缓冲区表23.6.15.43 ndbinfo 日志空间表23.6.15.44 ndbinfo 成员表23.6.15.45 ndbinfo 内存使用表23.6.15.46 ndbinfo memory_per_fragment 表23.6.15.47 ndbinfo 节点表23.6.15.48 ndbinfo operations_per_fragment 表23.6.15.49 ndbinfo pgman_time_track_stats 表23.6.15.50 ndbinfo 进程表23.6.15.51 ndbinfo 资源表23.6.15.52 ndbinfo restart_info 表23.6.15.53 ndbinfo server_locks 表23.6.15.54 ndbinfo server_operations 表23.6.15.55 ndbinfo server_transactions 表23.6.15.56 ndbinfo table_distribution_status 表23.6.15.57 ndbinfo table_fragments 表23.6.15.58 ndbinfo table_info 表23.6.15.59 ndbinfo table_replicas 表23.6.15.60 ndbinfo tc_time_track_stats 表23.6.15.61 ndbinfo 线程块表23.6.15.62 ndbinfo 线程表23.6.15.63 ndbinfo threadstat 表23.6.15.64 ndbinfo 传输器表
ndbinfo是一个包含 NDB Cluster 特定信息的数据库。
该数据库包含许多表，每个表提供有关 NDB Cluster 节点状态、资源使用情况和操作的不同类型的数据。您可以在接下来的几节中找到有关每个表的更多详细信息。
ndbinfo包含在 MySQL 服务器中的 NDB Cluster 支持中；不需要特殊的编译或配置步骤；这些表由 MySQL 服务器在连接到集群时创建。您可以验证
ndbinfo支持在给定的 MySQL 服务器实例中使用SHOW PLUGINS；如果ndbinfo启用了支持，您应该会看到包含ndbinfo在
Name列中和列ACTIVE中的Status行，如下所示（强调文本）：
mysql> SHOW PLUGINS;
+----------------------------------+--------+--------------------+---------+---------+
| Name                             | Status | Type               | Library | License |
+----------------------------------+--------+--------------------+---------+---------+
| binlog                           | ACTIVE | STORAGE ENGINE     | NULL    | GPL     |
| mysql_native_password            | ACTIVE | AUTHENTICATION     | NULL    | GPL     |
| sha256_password                  | ACTIVE | AUTHENTICATION     | NULL    | GPL     |
| caching_sha2_password            | ACTIVE | AUTHENTICATION     | NULL    | GPL     |
| sha2_cache_cleaner               | ACTIVE | AUDIT              | NULL    | GPL     |
| daemon_keyring_proxy_plugin      | ACTIVE | DAEMON             | NULL    | GPL     |
| CSV                              | ACTIVE | STORAGE ENGINE     | NULL    | GPL     |
| MEMORY                           | ACTIVE | STORAGE ENGINE     | NULL    | GPL     |
| InnoDB                           | ACTIVE | STORAGE ENGINE     | NULL    | GPL     |
| INNODB_TRX                       | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_CMP                       | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_CMP_RESET                 | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_CMPMEM                    | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_CMPMEM_RESET              | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_CMP_PER_INDEX             | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_CMP_PER_INDEX_RESET       | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_BUFFER_PAGE               | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_BUFFER_PAGE_LRU           | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_BUFFER_POOL_STATS         | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_TEMP_TABLE_INFO           | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_METRICS                   | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_FT_DEFAULT_STOPWORD       | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_FT_DELETED                | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_FT_BEING_DELETED          | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_FT_CONFIG                 | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_FT_INDEX_CACHE            | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_FT_INDEX_TABLE            | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_TABLES                    | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_TABLESTATS                | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_INDEXES                   | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_TABLESPACES               | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_COLUMNS                   | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_VIRTUAL                   | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_CACHED_INDEXES            | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_SESSION_TEMP_TABLESPACES  | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| MyISAM                           | ACTIVE | STORAGE ENGINE     | NULL    | GPL     |
| MRG_MYISAM                       | ACTIVE | STORAGE ENGINE     | NULL    | GPL     |
| PERFORMANCE_SCHEMA               | ACTIVE | STORAGE ENGINE     | NULL    | GPL     |
| TempTable                        | ACTIVE | STORAGE ENGINE     | NULL    | GPL     |
| ARCHIVE                          | ACTIVE | STORAGE ENGINE     | NULL    | GPL     |
| BLACKHOLE                        | ACTIVE | STORAGE ENGINE     | NULL    | GPL     |
| ndbcluster                       | ACTIVE | STORAGE ENGINE     | NULL    | GPL     |
| ndbinfo                          | ACTIVE | STORAGE ENGINE     | NULL    | GPL     |
| ndb_transid_mysql_connection_map | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| ngram                            | ACTIVE | FTPARSER           | NULL    | GPL     |
| mysqlx_cache_cleaner             | ACTIVE | AUDIT              | NULL    | GPL     |
| mysqlx                           | ACTIVE | DAEMON             | NULL    | GPL     |
+----------------------------------+--------+--------------------+---------+---------+
47 rows in set (0.00 sec)
您还可以通过检查
SHOW ENGINES包含
ndbinfo在Engine列中和列YES中的行的输出来执行此操作Support
，如此处所示（强调文本）：
mysql> SHOW ENGINES\G
*************************** 1. row ***************************
Engine: ndbcluster
Support: YES
Comment: Clustered, fault-tolerant tables
Transactions: YES
XA: NO
Savepoints: NO
*************************** 2. row ***************************
Engine: CSV
Support: YES
Comment: CSV storage engine
Transactions: NO
XA: NO
Savepoints: NO
*************************** 3. row ***************************
Engine: InnoDB
Support: DEFAULT
Comment: Supports transactions, row-level locking, and foreign keys
Transactions: YES
XA: YES
Savepoints: YES
*************************** 4. row ***************************
Engine: BLACKHOLE
Support: YES
Comment: /dev/null storage engine (anything you write to it disappears)
Transactions: NO
XA: NO
Savepoints: NO
*************************** 5. row ***************************
Engine: MyISAM
Support: YES
Comment: MyISAM storage engine
Transactions: NO
XA: NO
Savepoints: NO
*************************** 6. row ***************************
Engine: MRG_MYISAM
Support: YES
Comment: Collection of identical MyISAM tables
Transactions: NO
XA: NO
Savepoints: NO
*************************** 7. row ***************************
Engine: ARCHIVE
Support: YES
Comment: Archive storage engine
Transactions: NO
XA: NO
Savepoints: NO
*************************** 8. row ***************************
Engine: ndbinfo
Support: YES
Comment: NDB Cluster system information storage engine
Transactions: NO
XA: NO
Savepoints: NO
*************************** 9. row ***************************
Engine: PERFORMANCE_SCHEMA
Support: YES
Comment: Performance Schema
Transactions: NO
XA: NO
Savepoints: NO
*************************** 10. row ***************************
Engine: MEMORY
Support: YES
Comment: Hash based, stored in memory, useful for temporary tables
Transactions: NO
XA: NO
Savepoints: NO
10 rows in set (0.00 sec)
如果ndbinfo启用了支持，那么您可以在mysql或其他 MySQL 客户端ndbinfo中使用 SQL 语句
访问。例如，您可以在 的输出中看到 listed
，如下所示（强调文本）：
ndbinfoSHOW DATABASESmysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| ndbinfo            |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.04 sec)
如果mysqld进程未使用该
--ndbcluster选项启动，
ndbinfo则不可用且不显示SHOW DATABASES。如果
mysqld以前连接到 NDB Cluster 但集群变得不可用（由于集群关闭、网络连接丢失等事件），
ndbinfo并且其表仍然可见，但尝试访问任何表（除了blocks
或config_params) 失败并从 NDBINFO 得到错误 157 'Connection to NDB failed'。
除了表blocks
和config_params表之外，我们所说的ndbinfo “表”
实际上是从
NDB通常对 MySQL 服务器不可见的内部表生成的视图。ndbinfo_show_hidden您可以通过将系统变量设置为ON（或）使这些表可见
1，但这通常不是必需的。
所有ndbinfo表都是只读的，在查询时按需生成。因为它们中的许多是由数据节点并行生成的，而其他的则特定于给定的 SQL 节点，因此不能保证它们提供一致的快照。
此外，表不支持下推连接
ndbinfo；因此连接大型
ndbinfo表可能需要将大量数据传输到请求 API 节点，即使查询使用了WHERE子句也是如此。
ndbinfo表不包含在查询缓存中。（漏洞 #59831）
您可以使用语句选择ndbinfo数据库
USE，然后发出
SHOW TABLES语句以获取表列表，就像任何其他数据库一样，如下所示：
mysql> USE ndbinfo;
Database changed
mysql> SHOW TABLES;
+---------------------------------+
| Tables_in_ndbinfo               |
+---------------------------------+
| arbitrator_validity_detail      |
| arbitrator_validity_summary     |
| backup_id                       |
| blobs                           |
| blocks                          |
| cluster_locks                   |
| cluster_operations              |
| cluster_transactions            |
| config_nodes                    |
| config_params                   |
| config_values                   |
| counters                        |
| cpudata                         |
| cpudata_1sec                    |
| cpudata_20sec                   |
| cpudata_50ms                    |
| cpuinfo                         |
| cpustat                         |
| cpustat_1sec                    |
| cpustat_20sec                   |
| cpustat_50ms                    |
| dict_obj_info                   |
| dict_obj_tree                   |
| dict_obj_types                  |
| dictionary_columns              |
| dictionary_tables               |
| disk_write_speed_aggregate      |
| disk_write_speed_aggregate_node |
| disk_write_speed_base           |
| diskpagebuffer                  |
| diskstat                        |
| diskstats_1sec                  |
| error_messages                  |
| events                          |
| files                           |
| foreign_keys                    |
| hash_maps                       |
| hwinfo                          |
| index_columns                   |
| index_stats                     |
| locks_per_fragment              |
| logbuffers                      |
| logspaces                       |
| membership                      |
| memory_per_fragment             |
| memoryusage                     |
| nodes                           |
| operations_per_fragment         |
| pgman_time_track_stats          |
| processes                       |
| resources                       |
| restart_info                    |
| server_locks                    |
| server_operations               |
| server_transactions             |
| table_distribution_status       |
| table_fragments                 |
| table_info                      |
| table_replicas                  |
| tc_time_track_stats             |
| threadblocks                    |
| threads                         |
| threadstat                      |
| transporters                    |
+---------------------------------+
64 rows in set (0.00 sec)
在 NDB 8.0 中，所有ndbinfo表都使用
NDB存储引擎；但是，
如前所述
，ndbinfo条目仍会出现在
SHOW ENGINESand
的输出中。SHOW PLUGINS
您可以对这些表执行SELECT语句，就像您通常期望的那样：
mysql> SELECT * FROM memoryusage;
+---------+---------------------+--------+------------+------------+-------------+
| node_id | memory_type         | used   | used_pages | total      | total_pages |
+---------+---------------------+--------+------------+------------+-------------+
|       5 | Data memory         | 425984 |         13 | 2147483648 |       65536 |
|       5 | Long message buffer | 393216 |       1536 |   67108864 |      262144 |
|       6 | Data memory         | 425984 |         13 | 2147483648 |       65536 |
|       6 | Long message buffer | 393216 |       1536 |   67108864 |      262144 |
|       7 | Data memory         | 425984 |         13 | 2147483648 |       65536 |
|       7 | Long message buffer | 393216 |       1536 |   67108864 |      262144 |
|       8 | Data memory         | 425984 |         13 | 2147483648 |       65536 |
|       8 | Long message buffer | 393216 |       1536 |   67108864 |      262144 |
+---------+---------------------+--------+------------+------------+-------------+
8 rows in set (0.09 sec)
更复杂的查询，例如以下两个
SELECT使用该
memoryusage表的语句，是可能的：
mysql> SELECT SUM(used) as 'Data Memory Used, All Nodes'
>     FROM memoryusage
>     WHERE memory_type = 'Data memory';
+-----------------------------+
| Data Memory Used, All Nodes |
+-----------------------------+
|                        6460 |
+-----------------------------+
1 row in set (0.09 sec)
mysql> SELECT SUM(used) as 'Long Message Buffer, All Nodes'
>     FROM memoryusage
>     WHERE memory_type = 'Long message buffer';
+-------------------------------------+
| Long Message Buffer Used, All Nodes |
+-------------------------------------+
|                             1179648 |
+-------------------------------------+
1 row in set (0.08 sec)
ndbinfo表名和列名区分大小写（ndbinfo
数据库本身的名称也是如此）。这些标识符是小写的。尝试使用错误的字母大小写会导致错误，如本例所示：
mysql> SELECT * FROM nodes;
+---------+--------+---------+-------------+-------------------+
| node_id | uptime | status  | start_phase | config_generation |
+---------+--------+---------+-------------+-------------------+
|       5 |  17707 | STARTED |           0 |                 1 |
|       6 |  17706 | STARTED |           0 |                 1 |
|       7 |  17705 | STARTED |           0 |                 1 |
|       8 |  17704 | STARTED |           0 |                 1 |
+---------+--------+---------+-------------+-------------------+
4 rows in set (0.06 sec)
mysql> SELECT * FROM Nodes;
ERROR 1146 (42S02): Table 'ndbinfo.Nodes' doesn't exist
mysqldump完全忽略
ndbinfo数据库，并将其从任何输出中排除。即使使用
--databasesor
--all-databases选项也是如此。
NDB Cluster 还在
INFORMATION_SCHEMA信息数据库中维护表，包括FILES包含有关用于 NDB Cluster 磁盘数据存储的文件信息的
ndb_transid_mysql_connection_map
表，以及显示事务、事务协调器和 NDB Cluster API 节点之间关系的表。有关更多信息，请参阅表的描述或
第 23.6.16 节，“NDB Cluster 的 INFORMATION_SCHEMA 表”。
© Mysql 中文网
