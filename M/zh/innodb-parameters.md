# 15.14 InnoDB 启动选项和系统变量_MySQL 8.0 参考手册

15.14 InnoDB 启动选项和系统变量_MySQL 8.0 参考手册
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
15.1 InnoDB简介
15.2 InnoDB 和 ACID 模型
15.3 InnoDB 多版本
15.4 InnoDB架构
15.5 InnoDB 内存结构
15.6 InnoDB 磁盘结构
15.7 InnoDB 锁定和事务模型
15.8 InnoDB配置
15.9 InnoDB 表和页压缩
15.10 InnoDB 行格式
15.11 InnoDB磁盘I/O和文件空间管理
15.12 InnoDB和在线DDL
15.13 InnoDB静态数据加密
15.14 InnoDB 启动选项和系统变量
15.15 InnoDB INFORMATION_SCHEMA 表
15.16 InnoDB 与 MySQL 性能模式的集成
15.17 InnoDB 监视器
15.18 InnoDB备份与恢复
15.19 InnoDB和MySQL复制
15.20 InnoDB 内存缓存插件
15.21 InnoDB 故障排除
15.22 InnoDB 限制
15.23 InnoDB 限制和限制
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
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  /
15.14 InnoDB 启动选项和系统变量
15.14 InnoDB 启动选项和系统变量
真或假的系统变量可以在服务器启动时通过命名来启用，或者通过使用
--skip-前缀来禁用。例如，要启用或禁用InnoDB自适应哈希索引，您可以
在命令行或
选项
文件中
使用--innodb-adaptive-hash-index或
。--skip-innodb-adaptive-hash-indexinnodb_adaptive_hash_indexskip_innodb_adaptive_hash_index
一些变量描述提到“启用”或
“禁用”变量。这些变量可以通过将它们设置为 或 来启用
SET
，或者通过将它们设置为 或ON来
1禁用
。布尔变量可以在启动时设置为值
、、
和（不区分大小写），以及和
。请参阅第 4.2.2.4 节，“程序选项修饰符”。
OFF0ONTRUEOFFFALSE10
可以在命令行或
选项文件
中指定采用数值的系统变量
。--var_name=valuevar_name=value
许多系统变量可以在运行时更改（请参阅
第 5.1.9.2 节，“动态系统变量”）。
有关变量作用域修饰符的信息，请参阅
GLOBAL语句
文档。
SESSIONSET
某些选项控制
InnoDB数据文件的位置和布局。
第 15.8.1 节，“InnoDB 启动配置”解释了如何使用这些选项。
一些您最初可能不会使用的选项有助于
InnoDB根据机器容量和您的数据库
工作负载调整性能特征。
有关指定选项和系统变量的更多信息，请参阅第 4.2.2 节，“指定程序选项”。
表 15.24 InnoDB 选项和变量引用
姓名
命令行
选项文件
系统变量
状态变量
可变范围
动态的
daemon_memcached_enable_binlog
是的
是的
是的
全球的
不
daemon_memcached_engine_lib_name
是的
是的
是的
全球的
不
daemon_memcached_engine_lib_path
是的
是的
是的
全球的
不
daemon_memcached_option
是的
是的
是的
全球的
不
daemon_memcached_r_batch_size
是的
是的
是的
全球的
不
daemon_memcached_w_batch_size
是的
是的
是的
全球的
不
foreign_key_checks
是的
两个都
是的
创新数据库
是的
是的
innodb_adaptive_flushing
是的
是的
是的
全球的
是的
innodb_adaptive_flushing_lwm
是的
是的
是的
全球的
是的
innodb_adaptive_hash_index
是的
是的
是的
全球的
是的
innodb_adaptive_hash_index_parts
是的
是的
是的
全球的
不
innodb_adaptive_max_sleep_delay
是的
是的
是的
全球的
是的
innodb_api_bk_commit_interval
是的
是的
是的
全球的
是的
innodb_api_disable_rowlock
是的
是的
是的
全球的
不
innodb_api_enable_binlog
是的
是的
是的
全球的
不
innodb_api_enable_mdl
是的
是的
是的
全球的
不
innodb_api_trx_level
是的
是的
是的
全球的
是的
innodb_autoextend_increment
是的
是的
是的
全球的
是的
innodb_autoinc_lock_mode
是的
是的
是的
全球的
不
innodb_background_drop_list_empty
是的
是的
是的
全球的
是的
Innodb_buffer_pool_bytes_data
是的
全球的
不
Innodb_buffer_pool_bytes_dirty
是的
全球的
不
innodb_buffer_pool_chunk_size
是的
是的
是的
全球的
不
innodb_buffer_pool_debug
是的
是的
是的
全球的
不
innodb_buffer_pool_dump_at_shutdown
是的
是的
是的
全球的
是的
innodb_buffer_pool_dump_now
是的
是的
是的
全球的
是的
innodb_buffer_pool_dump_pct
是的
是的
是的
全球的
是的
Innodb_buffer_pool_dump_status
是的
全球的
不
innodb_buffer_pool_filename
是的
是的
是的
全球的
是的
innodb_buffer_pool_in_core_file
是的
是的
是的
全球的
是的
innodb_buffer_pool_instances
是的
是的
是的
全球的
不
innodb_buffer_pool_load_abort
是的
是的
是的
全球的
是的
innodb_buffer_pool_load_at_startup
是的
是的
是的
全球的
不
innodb_buffer_pool_load_now
是的
是的
是的
全球的
是的
Innodb_buffer_pool_load_status
是的
全球的
不
Innodb_buffer_pool_pages_data
是的
全球的
不
Innodb_buffer_pool_pages_dirty
是的
全球的
不
Innodb_buffer_pool_pages_flushed
是的
全球的
不
Innodb_buffer_pool_pages_free
是的
全球的
不
Innodb_buffer_pool_pages_latched
是的
全球的
不
Innodb_buffer_pool_pages_misc
是的
全球的
不
Innodb_buffer_pool_pages_total
是的
全球的
不
Innodb_buffer_pool_read_ahead
是的
全球的
不
Innodb_buffer_pool_read_ahead_evicted
是的
全球的
不
Innodb_buffer_pool_read_ahead_rnd
是的
全球的
不
Innodb_buffer_pool_read_requests
是的
全球的
不
Innodb_buffer_pool_reads
是的
全球的
不
Innodb_buffer_pool_resize_status
是的
全球的
不
innodb_buffer_pool_size
是的
是的
是的
全球的
是的
Innodb_buffer_pool_wait_free
是的
全球的
不
Innodb_buffer_pool_write_requests
是的
全球的
不
innodb_change_buffer_max_size
是的
是的
是的
全球的
是的
innodb_change_buffering
是的
是的
是的
全球的
是的
innodb_change_buffering_debug
是的
是的
是的
全球的
是的
innodb_checkpoint_disabled
是的
是的
是的
全球的
是的
innodb_checksum_algorithm
是的
是的
是的
全球的
是的
innodb_cmp_per_index_enabled
是的
是的
是的
全球的
是的
innodb_commit_concurrency
是的
是的
是的
全球的
是的
innodb_compress_debug
是的
是的
是的
全球的
是的
innodb_compression_failure_threshold_pct
是的
是的
是的
全球的
是的
innodb_compression_level
是的
是的
是的
全球的
是的
innodb_compression_pad_pct_max
是的
是的
是的
全球的
是的
innodb_concurrency_tickets
是的
是的
是的
全球的
是的
innodb_data_file_path
是的
是的
是的
全球的
不
Innodb_data_fsyncs
是的
全球的
不
innodb_data_home_dir
是的
是的
是的
全球的
不
Innodb_data_pending_fsyncs
是的
全球的
不
Innodb_data_pending_reads
是的
全球的
不
Innodb_data_pending_writes
是的
全球的
不
Innodb_data_read
是的
全球的
不
Innodb_data_reads
是的
全球的
不
Innodb_data_writes
是的
全球的
不
Innodb_data_written
是的
全球的
不
Innodb_dblwr_pages_written
是的
全球的
不
Innodb_dblwr_writes
是的
全球的
不
innodb_ddl_buffer_size
是的
是的
是的
两个都
是的
innodb_ddl_log_crash_reset_debug
是的
是的
是的
全球的
是的
innodb_ddl_threads
是的
是的
是的
两个都
是的
innodb_deadlock_detect
是的
是的
是的
全球的
是的
innodb_dedicated_server
是的
是的
是的
全球的
不
innodb_default_row_format
是的
是的
是的
全球的
是的
innodb_directories
是的
是的
是的
全球的
不
innodb_disable_sort_file_cache
是的
是的
是的
全球的
是的
innodb_doublewrite
是的
是的
是的
全球的
变化
innodb_doublewrite_batch_size
是的
是的
是的
全球的
不
innodb_doublewrite_dir
是的
是的
是的
全球的
不
innodb_doublewrite_files
是的
是的
是的
全球的
不
innodb_doublewrite_pages
是的
是的
是的
全球的
不
innodb_fast_shutdown
是的
是的
是的
全球的
是的
innodb_fil_make_page_dirty_debug
是的
是的
是的
全球的
是的
innodb_file_per_table
是的
是的
是的
全球的
是的
innodb_fill_factor
是的
是的
是的
全球的
是的
innodb_flush_log_at_timeout
是的
是的
是的
全球的
是的
innodb_flush_log_at_trx_commit
是的
是的
是的
全球的
是的
innodb_flush_method
是的
是的
是的
全球的
不
innodb_flush_neighbors
是的
是的
是的
全球的
是的
innodb_flush_sync
是的
是的
是的
全球的
是的
innodb_flushing_avg_loops
是的
是的
是的
全球的
是的
innodb_force_load_corrupted
是的
是的
是的
全球的
不
innodb_force_recovery
是的
是的
是的
全球的
不
innodb_fsync_threshold
是的
是的
是的
全球的
是的
innodb_ft_aux_table
是的
全球的
是的
innodb_ft_cache_size
是的
是的
是的
全球的
不
innodb_ft_enable_diag_print
是的
是的
是的
全球的
是的
innodb_ft_enable_stopword
是的
是的
是的
两个都
是的
innodb_ft_max_token_size
是的
是的
是的
全球的
不
innodb_ft_min_token_size
是的
是的
是的
全球的
不
innodb_ft_num_word_optimize
是的
是的
是的
全球的
是的
innodb_ft_result_cache_limit
是的
是的
是的
全球的
是的
innodb_ft_server_stopword_table
是的
是的
是的
全球的
是的
innodb_ft_sort_pll_degree
是的
是的
是的
全球的
不
innodb_ft_total_cache_size
是的
是的
是的
全球的
不
innodb_ft_user_stopword_table
是的
是的
是的
两个都
是的
Innodb_have_atomic_builtins
是的
全球的
不
innodb_idle_flush_pct
是的
是的
是的
全球的
是的
innodb_io_capacity
是的
是的
是的
全球的
是的
innodb_io_capacity_max
是的
是的
是的
全球的
是的
innodb_limit_optimistic_insert_debug
是的
是的
是的
全球的
是的
innodb_lock_wait_timeout
是的
是的
是的
两个都
是的
innodb_log_buffer_size
是的
是的
是的
全球的
变化
innodb_log_checkpoint_fuzzy_now
是的
是的
是的
全球的
是的
innodb_log_checkpoint_now
是的
是的
是的
全球的
是的
innodb_log_checksums
是的
是的
是的
全球的
是的
innodb_log_compressed_pa​​ges
是的
是的
是的
全球的
是的
innodb_log_file_size
是的
是的
是的
全球的
不
innodb_log_files_in_group
是的
是的
是的
全球的
不
innodb_log_group_home_dir
是的
是的
是的
全球的
不
innodb_log_spin_cpu_abs_lwm
是的
是的
是的
全球的
是的
innodb_log_spin_cpu_pct_hwm
是的
是的
是的
全球的
是的
innodb_log_wait_for_flush_spin_hwm
是的
是的
是的
全球的
是的
Innodb_log_waits
是的
全球的
不
innodb_log_write_ahead_size
是的
是的
是的
全球的
是的
Innodb_log_write_requests
是的
全球的
不
innodb_log_writer_threads
是的
是的
是的
全球的
是的
Innodb_log_writes
是的
全球的
不
innodb_lru_scan_depth
是的
是的
是的
全球的
是的
innodb_max_dirty_pages_pct
是的
是的
是的
全球的
是的
innodb_max_dirty_pages_pct_lwm
是的
是的
是的
全球的
是的
innodb_max_purge_lag
是的
是的
是的
全球的
是的
innodb_max_purge_lag_delay
是的
是的
是的
全球的
是的
innodb_max_undo_log_size
是的
是的
是的
全球的
是的
innodb_merge_threshold_set_all_debug
是的
是的
是的
全球的
是的
innodb_monitor_disable
是的
是的
是的
全球的
是的
innodb_monitor_enable
是的
是的
是的
全球的
是的
innodb_monitor_reset
是的
是的
是的
全球的
是的
innodb_monitor_reset_all
是的
是的
是的
全球的
是的
Innodb_num_open_files
是的
全球的
不
innodb_numa_interleave
是的
是的
是的
全球的
不
innodb_old_blocks_pct
是的
是的
是的
全球的
是的
innodb_old_blocks_time
是的
是的
是的
全球的
是的
innodb_online_alter_log_max_size
是的
是的
是的
全球的
是的
innodb_open_files
是的
是的
是的
全球的
变化
innodb_optimize_fulltext_only
是的
是的
是的
全球的
是的
Innodb_os_log_fsyncs
是的
全球的
不
Innodb_os_log_pending_fsyncs
是的
全球的
不
Innodb_os_log_pending_writes
是的
全球的
不
Innodb_os_log_written
是的
全球的
不
innodb_page_cleaners
是的
是的
是的
全球的
不
Innodb_page_size
是的
全球的
不
innodb_page_size
是的
是的
是的
全球的
不
Innodb_pages_created
是的
全球的
不
Innodb_pages_read
是的
全球的
不
Innodb_pages_written
是的
全球的
不
innodb_parallel_read_threads
是的
是的
是的
会议
是的
innodb_print_all_deadlocks
是的
是的
是的
全球的
是的
innodb_print_ddl_logs
是的
是的
是的
全球的
是的
innodb_purge_batch_size
是的
是的
是的
全球的
是的
innodb_purge_rseg_truncate_frequency
是的
是的
是的
全球的
是的
innodb_purge_threads
是的
是的
是的
全球的
不
innodb_random_read_ahead
是的
是的
是的
全球的
是的
innodb_read_ahead_threshold
是的
是的
是的
全球的
是的
innodb_read_io_threads
是的
是的
是的
全球的
不
innodb_read_only
是的
是的
是的
全球的
不
innodb_redo_log_archive_dirs
是的
是的
是的
全球的
是的
innodb_redo_log_capacity
是的
是的
是的
全球的
是的
Innodb_redo_log_capacity_resized
是的
全球的
不
Innodb_redo_log_checkpoint_lsn
是的
全球的
不
Innodb_redo_log_current_lsn
是的
全球的
不
Innodb_redo_log_enabled
是的
全球的
不
innodb_redo_log_encrypt
是的
是的
是的
全球的
是的
Innodb_redo_log_flushed_to_disk_lsn
是的
全球的
不
Innodb_redo_log_logical_size
是的
全球的
不
Innodb_redo_log_physical_size
是的
全球的
不
Innodb_redo_log_read_only
是的
全球的
不
Innodb_redo_log_resize_status
是的
全球的
不
Innodb_redo_log_uuid
是的
全球的
不
innodb_replication_delay
是的
是的
是的
全球的
是的
innodb_rollback_on_timeout
是的
是的
是的
全球的
不
innodb_rollback_segments
是的
是的
是的
全球的
是的
Innodb_row_lock_current_waits
是的
全球的
不
Innodb_row_lock_time
是的
全球的
不
Innodb_row_lock_time_avg
是的
全球的
不
Innodb_row_lock_time_max
是的
全球的
不
Innodb_row_lock_waits
是的
全球的
不
Innodb_rows_deleted
是的
全球的
不
Innodb_rows_inserted
是的
全球的
不
Innodb_rows_read
是的
全球的
不
Innodb_rows_updated
是的
全球的
不
innodb_saved_pa​​ge_number_debug
是的
是的
是的
全球的
是的
innodb_segment_reserve_factor
是的
是的
是的
全球的
是的
innodb_sort_buffer_size
是的
是的
是的
全球的
不
innodb_spin_wait_delay
是的
是的
是的
全球的
是的
innodb_spin_wait_pause_multiplier
是的
是的
是的
全球的
是的
innodb_stats_auto_recalc
是的
是的
是的
全球的
是的
innodb_stats_include_delete_marked
是的
是的
是的
全球的
是的
innodb_stats_method
是的
是的
是的
全球的
是的
innodb_stats_on_metadata
是的
是的
是的
全球的
是的
innodb_stats_persistent
是的
是的
是的
全球的
是的
innodb_stats_persistent_sample_pages
是的
是的
是的
全球的
是的
innodb_stats_transient_sample_pages
是的
是的
是的
全球的
是的
innodb-状态文件
是的
是的
innodb_status_output
是的
是的
是的
全球的
是的
innodb_status_output_locks
是的
是的
是的
全球的
是的
innodb_strict_mode
是的
是的
是的
两个都
是的
innodb_sync_array_size
是的
是的
是的
全球的
不
innodb_sync_debug
是的
是的
是的
全球的
不
innodb_sync_spin_loops
是的
是的
是的
全球的
是的
Innodb_system_rows_deleted
是的
全球的
不
Innodb_system_rows_inserted
是的
全球的
不
Innodb_system_rows_read
是的
全球的
不
innodb_table_locks
是的
是的
是的
两个都
是的
innodb_temp_data_file_path
是的
是的
是的
全球的
不
innodb_temp_tablespaces_dir
是的
是的
是的
全球的
不
innodb_thread_concurrency
是的
是的
是的
全球的
是的
innodb_thread_sleep_delay
是的
是的
是的
全球的
是的
innodb_tmpdir
是的
是的
是的
两个都
是的
Innodb_truncated_status_writes
是的
全球的
不
innodb_trx_purge_view_update_only_debug
是的
是的
是的
全球的
是的
innodb_trx_rseg_n_slots_debug
是的
是的
是的
全球的
是的
innodb_undo_directory
是的
是的
是的
全球的
不
innodb_undo_log_encrypt
是的
是的
是的
全球的
是的
innodb_undo_log_truncate
是的
是的
是的
全球的
是的
innodb_undo_tablespaces
是的
是的
是的
全球的
变化
Innodb_undo_tablespaces_active
是的
全球的
不
Innodb_undo_tablespaces_explicit
是的
全球的
不
Innodb_undo_tablespaces_implicit
是的
全球的
不
Innodb_undo_tablespaces_total
是的
全球的
不
innodb_use_fdatasync
是的
是的
是的
全球的
是的
innodb_use_native_aio
是的
是的
是的
全球的
不
innodb_validate_tablespace_paths
是的
是的
是的
全球的
不
innodb_version
是的
全球的
不
innodb_write_io_threads
是的
是的
是的
全球的
不
独特的检查
是的
两个都
是的
InnoDB 命令选项
--innodb[=value]
命令行格式
--innodb[=value]
弃用
是的
类型
枚举
默认值
ON
有效值
OFFONFORCE
InnoDB如果服务器编译时
InnoDB支持，则
控制存储引擎的加载。此选项具有三态格式，可能的值为OFF、
ON或FORCE。请参阅
第 5.6.1 节，“安装和卸载插件”。
要禁用InnoDB，请使用
--innodb=OFF
或
--skip-innodb。在这种情况下，因为默认存储引擎是
InnoDB，服务器不会启动，除非您还使用
--default-storage-engine并将
默认值设置为永久和表
--default-tmp-storage-engine的其他引擎
。TEMPORARYInnoDB不能再禁用存储引擎，并且
和--innodb=OFF
选项
--skip-innodb
已弃用且无效。它们的使用会导致警告。期望在未来的 MySQL 版本中删除这些选项。
--innodb-status-file
命令行格式
--innodb-status-file[={OFF|ON}]
类型
布尔值
默认值
OFF
--innodb-status-file启动选项控制是否InnoDB创建一个
在数据目录中命名的文件，并大约每 15 秒向其中写入
一次输出。
innodb_status.pidSHOW ENGINE
INNODB STATUS
默认情况下不创建
该
文件。要创建它，
请使用该
选项
启动mysqld 。服务器正常关闭时删除文件。如果发生异常关机，则可能必须手动删除状态文件。
innodb_status.pid--innodb-status-fileInnoDB
该--innodb-status-file选项仅供临时使用，因为
SHOW ENGINE
INNODB STATUS输出生成会影响性能，并且
文件会随着时间的推移变得非常大。
innodb_status.pid
有关相关信息，请参阅
第 15.17.2 节，“启用 InnoDB 监视器”。
--skip-innodb
禁用InnoDB存储引擎。见说明--innodb。
InnoDB 系统变量
daemon_memcached_enable_binlog
命令行格式
--daemon-memcached-enable-binlog[={OFF|ON}]
系统变量
daemon_memcached_enable_binlog
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
在源服务器上启用此选项以将
InnoDB memcached plugin( daemon_memcached) 与 MySQL
二进制日志一起使用。此选项只能在服务器启动时设置。--log-bin您还必须使用该选项
在源服务器上启用 MySQL 二进制日志
。
有关详细信息，请参阅
第 15.20.7 节，“InnoDB memcached 插件和复制”。
daemon_memcached_engine_lib_name
命令行格式
--daemon-memcached-engine-lib-name=file_name
系统变量
daemon_memcached_engine_lib_name
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
文件名
默认值
innodb_engine.so
指定实现
InnoDB memcached插件的共享库。
有关详细信息，请参阅
第 15.20.3 节，“设置 InnoDB memcached 插件”。
daemon_memcached_engine_lib_path
命令行格式
--daemon-memcached-engine-lib-path=dir_name
系统变量
daemon_memcached_engine_lib_path
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
目录名称
默认值
NULL
包含实现InnoDB
memcached插件的共享库的目录路径。默认值为NULL，代表MySQL插件目录。memcached除非为位于 MySQL 插件目录之外的不同存储引擎
指定插件，否则不需要修改此参数
。
有关详细信息，请参阅
第 15.20.3 节，“设置 InnoDB memcached 插件”。
daemon_memcached_option
命令行格式
--daemon-memcached-option=options
系统变量
daemon_memcached_option
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
细绳
默认值
用于在启动时将以空格分隔的 memcached 选项传递给底层memcached内存对象缓存守护进程。例如，您可以更改
memcached侦听的端口、减少同时连接的最大数量、更改键值对的最大内存大小或为错误日志启用调试消息。
有关使用详细信息，请参阅第 15.20.3 节，“设置 InnoDB memcached 插件”。有关memcached
选项的信息，请参阅memcached手册页。
daemon_memcached_r_batch_size
命令行格式
--daemon-memcached-r-batch-size=#
系统变量
daemon_memcached_r_batch_size
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
整数
默认值
1
最小值
1
最大值
1073741824
指定在开始新事务之前要执行
多少memcached读取操作（ operations ）。的对口
。
getCOMMITdaemon_memcached_w_batch_size
此值默认设置为 1，因此通过 SQL 语句对表所做的任何更改都会立即对
memcached操作可见。您可能会增加它以减少在仅通过
memcached接口访问基础表的系统上频繁提交的开销。如果将值设置得太大，撤消或重做数据量可能会造成一些存储开销，就像任何长时间运行的事务一样。
有关详细信息，请参阅
第 15.20.3 节，“设置 InnoDB memcached 插件”。
daemon_memcached_w_batch_size
命令行格式
--daemon-memcached-w-batch-size=#
系统变量
daemon_memcached_w_batch_size
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
整数
默认值
1
最小值
1
最大值
1048576
指定在执行 a以启动新事务之前要执行
多少memcached写操作，例如add、
set和。的对口
。
incrCOMMITdaemon_memcached_r_batch_size
默认情况下，此值设置为 1，假设存储的数据对于在发生中断时保留很重要并且应立即提交。当存储非关键数据时，您可以增加此值以减少频繁提交的开销；N但是如果发生意外退出
，最后的
-1 未提交的写操作可能会丢失。
有关详细信息，请参阅
第 15.20.3 节，“设置 InnoDB memcached 插件”。
innodb_adaptive_flushing
命令行格式
--innodb-adaptive-flushing[={OFF|ON}]
系统变量
innodb_adaptive_flushing
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
ON
指定是否根据工作负载动态调整缓冲池中脏页的
刷新率
。动态调整刷新率旨在避免 I/O 活动的突发。默认情况下启用此设置。有关详细信息，请参阅第 15.8.3.5 节，“配置缓冲池刷新”。有关一般 I/O 调整建议，请参阅
第 8.5.8 节，“优化 InnoDB 磁盘 I/O”。
InnoDB
innodb_adaptive_flushing_lwm
命令行格式
--innodb-adaptive-flushing-lwm=#
系统变量
innodb_adaptive_flushing_lwm
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
10
最小值
0
最大值
70
定义表示启用自适应刷新的重做日志容量
百分比的低水位
线。有关详细信息，请参阅
第 15.8.3.5 节，“配置缓冲池刷新”。
innodb_adaptive_hash_index
命令行格式
--innodb-adaptive-hash-index[={OFF|ON}]
系统变量
innodb_adaptive_hash_index
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
ON
InnoDB
自适应哈希索引是启用还是禁用
。根据您的工作负载，可能需要动态启用或禁用
自适应哈希索引以提高查询性能。由于自适应哈希索引可能并非对所有工作负载都有用，因此在启用和禁用它的情况下使用实际工作负载进行基准测试。有关详细信息，请参阅
第 15.5.3 节，“自适应哈希索引”。
默认情况下启用此变量。SET GLOBAL您可以使用语句修改此参数，而无需重新启动服务器。在运行时更改设置需要足够的权限来设置全局系统变量。请参阅第 5.1.9.1 节，“系统变量权限”。您也可以--skip-innodb-adaptive-hash-index在服务器启动时使用它来禁用它。
禁用自适应哈希索引会立即清空哈希表。当哈希表被清空时，正常操作可以继续，并且执行使用哈希表的查询直接访问索引 B 树。当重新启用自适应哈希索引时，哈希表会在正常操作期间再次填充。
innodb_adaptive_hash_index_parts
命令行格式
--innodb-adaptive-hash-index-parts=#
系统变量
innodb_adaptive_hash_index_parts
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
数字
默认值
8
最小值
1
最大值
512
分区自适应散列索引搜索系统。每个索引都绑定到一个特定的分区，每个分区由一个单独的锁存器保护。
自适应哈希索引搜索系统默认分为 8 个部分。最大设置为 512。
有关相关信息，请参阅
第 15.5.3 节，“自适应哈希索引”。
innodb_adaptive_max_sleep_delay
命令行格式
--innodb-adaptive-max-sleep-delay=#
系统变量
innodb_adaptive_max_sleep_delay
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
150000
最小值
0
最大值
1000000
单元
微秒
允许根据当前工作量InnoDB自动调整向上或向下的值
。innodb_thread_sleep_delay任何非零值都可以自动动态调整
innodb_thread_sleep_delay
值，直到选项中指定的最大值
innodb_adaptive_max_sleep_delay
。该值表示微秒数。InnoDB此选项在线程数超过 16 个的繁忙系统中很有用
。（实际上，它对于具有数百或数千个同时连接的 MySQL 系统最有价值。）
有关详细信息，请参阅
第 15.8.4 节，“为 InnoDB 配置线程并发”。
innodb_api_bk_commit_interval
命令行格式
--innodb-api-bk-commit-interval=#
系统变量
innodb_api_bk_commit_interval
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
5
最小值
1
最大值
1073741824
单元
秒
以秒
为单位自动提交使用
InnoDB memcached接口的空闲连接的频率。有关更多信息，请参阅
第 15.20.6.4 节，“控制 InnoDB memcached 插件的事务行为”。
innodb_api_disable_rowlock
命令行格式
--innodb-api-disable-rowlock[={OFF|ON}]
系统变量
innodb_api_disable_rowlock
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
InnoDB 使用此选项可在memcached
执行 DML 操作
时禁用行锁
。默认情况下，
innodb_api_disable_rowlock禁用，这意味着memcached
请求行锁get和
set操作。innodb_api_disable_rowlock启用时
， memcached请求表锁而不是行锁。
innodb_api_disable_rowlock不是动态的。它必须在
mysqld命令行上指定或输入到 MySQL 配置文件中。配置在安装插件时生效，这发生在 MySQL 服务器启动时。
有关更多信息，请参阅
第 15.20.6.4 节，“控制 InnoDB memcached 插件的事务行为”。
innodb_api_enable_binlog
命令行格式
--innodb-api-enable-binlog[={OFF|ON}]
系统变量
innodb_api_enable_binlog
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
允许您将InnoDB
memcached插件与 MySQL
二进制日志一起使用。有关更多信息，请参阅
启用 InnoDB memcached 二进制日志。
innodb_api_enable_mdl
命令行格式
--innodb-api-enable-mdl[={OFF|ON}]
系统变量
innodb_api_enable_mdl
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
InnoDB
锁定memcached插件
使用的表，使其无法
通过 SQL 接口被DDL删除或更改。有关更多信息，请参阅
第 15.20.6.4 节，“控制 InnoDB memcached 插件的事务行为”。
innodb_api_trx_level
命令行格式
--innodb-api-trx-level=#
系统变量
innodb_api_trx_level
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
0
最小值
0
最大值
3
控制由memcached
接口处理的查询
的事务
隔离级别。熟悉的名字对应的常量是：
0 =READ UNCOMMITTED
1 =READ COMMITTED
2 =REPEATABLE READ
3 =SERIALIZABLE
有关更多信息，请参阅
第 15.20.6.4 节，“控制 InnoDB memcached 插件的事务行为”。
innodb_autoextend_increment
命令行格式
--innodb-autoextend-increment=#
系统变量
innodb_autoextend_increment
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
64
最小值
1
最大值
1000
单元
兆字节
InnoDB
自动扩展系统表空间文件变满时
用于扩展其大小的增量大小（以兆字节为单位） 。默认值为 64。有关相关信息，请参阅
系统表空间数据文件配置和
调整系统表空间大小。
该
innodb_autoextend_increment
设置不影响
file-per-table 表
空间文件或
通用表空间文件。无论设置如何，这些文件都会自动扩展
innodb_autoextend_increment
。最初的扩展是少量的，之后以 4MB 的增量进行扩展。
innodb_autoinc_lock_mode
命令行格式
--innodb-autoinc-lock-mode=#
系统变量
innodb_autoinc_lock_mode
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
整数
默认值
2
有效值
012
用于生成
自动增量
值
的锁定模式。允许的值为 0、1 或 2，分别表示传统、连续或交错。
从 MySQL 8.0 开始，默认设置为 2（交错），在此之前为 1（连续）。将交错锁模式更改为默认设置反映了从基于语句的复制到基于行的复制作为默认复制类型的更改，这发生在 MySQL 5.7 中。Statement-based复制需要连续的自增锁模式来保证给定的SQL语句序列的自增值按照可预测、可重复的顺序赋值，而row-based复制对SQL语句的执行顺序不敏感.
对于每种锁模式的特性，请参阅
InnoDB AUTO_INCREMENT Lock Modes。
innodb_background_drop_list_empty
命令行格式
--innodb-background-drop-list-empty[={OFF|ON}]
系统变量
innodb_background_drop_list_empty
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
启用
innodb_background_drop_list_empty
调试选项有助于通过延迟表创建直到后台下拉列表为空来避免测试用例失败。例如，如果测试用例 A 将表t1放在后台下拉列表中，则测试用例 B 会等到后台下拉列表为空后再创建表
t1。
innodb_buffer_pool_chunk_size
命令行格式
--innodb-buffer-pool-chunk-size=#
系统变量
innodb_buffer_pool_chunk_size
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
整数
默认值
134217728
最小值
1048576
最大值
innodb_buffer_pool_size / innodb_buffer_pool_instances
单元
字节
innodb_buffer_pool_chunk_size
定义InnoDB缓冲池大小调整操作的块大小。
为避免在调整大小操作期间复制所有缓冲池页面，该操作以
“块”形式执行。默认情况下，
innodb_buffer_pool_chunk_size
为 128MB（134217728 字节）。块中包含的页数取决于 的值
innodb_page_size。
innodb_buffer_pool_chunk_size
可以以 1MB（1048576 字节）为单位增加或减少。
innodb_buffer_pool_chunk_size
更改值
时适用以下条件
：
如果
innodb_buffer_pool_chunk_size*
innodb_buffer_pool_instances
大于缓冲池初始化时的当前缓冲池大小，
innodb_buffer_pool_chunk_size
则被截断为
innodb_buffer_pool_size/
innodb_buffer_pool_instances。
缓冲池大小必须始终等于
innodb_buffer_pool_chunk_size
*
或它的倍数innodb_buffer_pool_instances。如果您更改
innodb_buffer_pool_chunk_size,
innodb_buffer_pool_size
将自动四舍五入为等于
innodb_buffer_pool_chunk_size
*
或它的倍数的值innodb_buffer_pool_instances。调整发生在缓冲池初始化时。
重要的
更改时应小心
innodb_buffer_pool_chunk_size，因为更改此值会自动增加缓冲池的大小。在更改 之前
innodb_buffer_pool_chunk_size，计算其对 的影响，
innodb_buffer_pool_size以确保生成的缓冲池大小是可以接受的。
为避免潜在的性能问题，块 ( innodb_buffer_pool_size/
innodb_buffer_pool_chunk_size) 的数量不应超过 1000。
该innodb_buffer_pool_size
变量是动态的，允许在服务器在线时调整缓冲池的大小。但是，缓冲池大小必须等于
innodb_buffer_pool_chunk_size
*
或它的倍数innodb_buffer_pool_instances，并且更改这些变量设置中的任何一个都需要重新启动服务器。
有关更多信息，请参阅第 15.8.3.1 节，“配置 InnoDB 缓冲池大小”。
innodb_buffer_pool_debug
命令行格式
--innodb-buffer-pool-debug[={OFF|ON}]
系统变量
innodb_buffer_pool_debug
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
当缓冲池的大小小于 1GB 时，启用此选项允许多个缓冲池实例，忽略对 施加的 1GB 最小缓冲池大小限制
innodb_buffer_pool_instances。innodb_buffer_pool_debug
只有在使用CMake选项编译调试支持时，该选项才可用。
WITH_DEBUG
innodb_buffer_pool_dump_at_shutdown
命令行格式
--innodb-buffer-pool-dump-at-shutdown[={OFF|ON}]
系统变量
innodb_buffer_pool_dump_at_shutdown
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
ON
指定MySQL服务器关闭时
是否记录缓存在
InnoDB
缓冲池中的页面，以缩短下次重启时的预热过程。通常与 结合使用
innodb_buffer_pool_load_at_startup。该
innodb_buffer_pool_dump_pct
选项定义要转储的最近使用的缓冲池页面的百分比。
默认
情况下启用innodb_buffer_pool_dump_at_shutdown
和
innodb_buffer_pool_load_at_startup
。
有关详细信息，请参阅
第 15.8.3.6 节，“保存和恢复缓冲池状态”。
innodb_buffer_pool_dump_now
命令行格式
--innodb-buffer-pool-dump-now[={OFF|ON}]
系统变量
innodb_buffer_pool_dump_now
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
立即在
InnoDB
缓冲池中缓存页面记录。通常与 结合使用
innodb_buffer_pool_load_now。
启用
innodb_buffer_pool_dump_now
会触发记录操作但不会更改变量设置，变量设置始终保持为OFF或
0。要在触发转储后查看缓冲池转储状态，请查询
Innodb_buffer_pool_dump_status
变量。
启用
innodb_buffer_pool_dump_now
会触发转储操作但不会更改变量设置，变量设置始终保持为OFFor
0。要在触发转储后查看缓冲池转储状态，请查询
Innodb_buffer_pool_dump_status
变量。
有关详细信息，请参阅
第 15.8.3.6 节，“保存和恢复缓冲池状态”。
innodb_buffer_pool_dump_pct
命令行格式
--innodb-buffer-pool-dump-pct=#
系统变量
innodb_buffer_pool_dump_pct
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
25
最小值
1
最大值
100
指定每个缓冲池要读出和转储的最近使用页面的百分比。范围是 1 到 100。默认值是 25。例如，如果有 4 个缓冲池，每个缓冲池有 100 个页面，并且
innodb_buffer_pool_dump_pct
设置为 25，则转储每个缓冲池中最近使用的 25 个页面。
innodb_buffer_pool_filename
命令行格式
--innodb-buffer-pool-filename=file_name
系统变量
innodb_buffer_pool_filename
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
文件名
默认值
ib_buffer_pool
指定包含由
innodb_buffer_pool_dump_at_shutdown
或
生成的表空间 ID 和页面 ID 列表的文件的名称innodb_buffer_pool_dump_now。表空间 ID 和页面 ID 以以下格式保存：
space, page_id. 默认情况下，该文件已命名ib_buffer_pool并位于InnoDB数据目录中。必须指定相对于数据目录的非默认位置。
可以在运行时使用
SET
语句指定文件名：
SET GLOBAL innodb_buffer_pool_filename='file_name';
您还可以在启动时在启动字符串或 MySQL 配置文件中指定文件名。启动时指定文件名时，该文件必须存在，否则
InnoDB返回启动错误，提示不存在该文件或目录。
有关详细信息，请参阅
第 15.8.3.6 节，“保存和恢复缓冲池状态”。
innodb_buffer_pool_in_core_file
命令行格式
--innodb-buffer-pool-in-core-file[={OFF|ON}]
介绍
8.0.14
系统变量
innodb_buffer_pool_in_core_file
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
ON
禁用该
变量通过排除缓冲池页面innodb_buffer_pool_in_core_file
来减小核心文件的大小
。InnoDB要使用此变量，core_file
必须启用该变量并且操作系统必须支持对 的MADV_DONTDUMP非 POSIX 扩展
madvise()，Linux 3.4 及更高版本支持该扩展。有关详细信息，请参阅
第 15.8.3.7 节，“从核心文件中排除缓冲池页面”。
innodb_buffer_pool_instances
命令行格式
--innodb-buffer-pool-instances=#
系统变量
innodb_buffer_pool_instances
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
整数
默认值（Windows，32 位平台）
(autosized)
默认值（其他）
8 (or 1 if innodb_buffer_pool_size < 1GB)
最小值
1
最大值
64
InnoDB
缓冲池划分
的区域数。对于缓冲池在数 GB 范围内的系统，将缓冲池划分为单独的实例可以提高并发性，方法是减少不同线程读取和写入缓存页面时的争用。使用散列函数将存储在缓冲池中或从中读取的每个页面随机分配给缓冲池实例之一。每个缓冲池管理自己的空闲列表、
刷新列表、
LRU和连接到缓冲池的所有其他数据结构，并受其自己的缓冲池互斥锁保护。
innodb_buffer_pool_size此选项仅在设置为 1GB 或更大
时生效
。总缓冲池大小在所有缓冲池之间分配。为了获得最佳效率，请指定 和 的组合，
innodb_buffer_pool_instances
以便innodb_buffer_pool_size
每个缓冲池实例至少为 1GB。
32 位 Windows 系统上的默认值取决于 的值
innodb_buffer_pool_size，如下所述：
如果
innodb_buffer_pool_size
大于 1.3GB，则默认为
innodb_buffer_pool_instances
/
innodb_buffer_pool_size128MB，每个块都有单独的内存分配请求。选择 1.3GB 作为 32 位 Windows 无法分配单个缓冲池所需的连续地址空间的重大风险的边界。
否则，默认值为 1。
innodb_buffer_pool_size在所有其他平台上，当大于或等于 1GB
时，默认值为 8
。否则，默认值为 1。
有关相关信息，请参阅
第 15.8.3.1 节，“配置 InnoDB 缓冲池大小”。
innodb_buffer_pool_load_abort
命令行格式
--innodb-buffer-pool-load-abort[={OFF|ON}]
系统变量
innodb_buffer_pool_load_abort
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
中断由或
触发
的恢复InnoDB
缓冲池内容的过程。
innodb_buffer_pool_load_at_startupinnodb_buffer_pool_load_now
启用
innodb_buffer_pool_load_abort
会触发中止操作但不会更改变量设置，变量设置始终保持为OFF或
0。要在触发中止操作后查看缓冲池负载状态，请查询
Innodb_buffer_pool_load_status
变量。
有关详细信息，请参阅
第 15.8.3.6 节，“保存和恢复缓冲池状态”。
innodb_buffer_pool_load_at_startup
命令行格式
--innodb-buffer-pool-load-at-startup[={OFF|ON}]
系统变量
innodb_buffer_pool_load_at_startup
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
布尔值
默认值
ON
指定在 MySQL 服务器启动时，
InnoDB
缓冲池通过加载它在较早时间保存的相同页面来自动预热。通常与 结合使用
innodb_buffer_pool_dump_at_shutdown。
默认
情况下启用innodb_buffer_pool_dump_at_shutdown
和
innodb_buffer_pool_load_at_startup
。
有关详细信息，请参阅
第 15.8.3.6 节，“保存和恢复缓冲池状态”。
innodb_buffer_pool_load_now
命令行格式
--innodb-buffer-pool-load-now[={OFF|ON}]
系统变量
innodb_buffer_pool_load_now
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
通过加载数据页立即预热InnoDB
缓冲池，而
无需等待服务器重新启动。在基准测试期间将缓存内存恢复到已知状态或准备好 MySQL 服务器在运行报告或维护查询后恢复其正常工作负载可能很有用。
启用
innodb_buffer_pool_load_now
会触发加载操作但不会更改变量设置，变量设置始终保持为OFF或
0。要在触发加载后查看缓冲池加载进度，请查询
Innodb_buffer_pool_load_status
变量。
有关详细信息，请参阅
第 15.8.3.6 节，“保存和恢复缓冲池状态”。
innodb_buffer_pool_size
命令行格式
--innodb-buffer-pool-size=#
系统变量
innodb_buffer_pool_size
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
134217728
最小值
5242880
最大值（64 位平台）
2**64-1
最大值（32 位平台）
2**32-1
单元
字节
缓冲池
的字节大小
，InnoDB缓存表和索引数据的内存区域。默认值为 134217728 字节 (128MB)。最大值取决于 CPU 架构；在 32 位系统上最大值为 4294967295 (2 32 -1)，在 64 位系统上最大值为 18446744073709551615 (2 64 -1)。在 32 位系统上，CPU 体系结构和操作系统可能会施加比规定的最大值更低的实际最大大小。当缓冲池的大小大于 1GB 时，设置
innodb_buffer_pool_instances
为大于 1 的值可以提高繁忙服务器上的可伸缩性。
较大的缓冲池需要较少的磁盘 I/O 来多次访问相同的表数据。在专用数据库服务器上，您可以将缓冲池大小设置为机器物理内存大小的 80%。配置缓冲池大小时请注意以下潜在问题，并准备在必要时缩减缓冲池的大小。
对物理内存的竞争会导致操作系统中的分页。
InnoDB为缓冲区和控制结构保留额外的内存，以便分配的总空间比指定的缓冲池大小大约大 10%。
缓冲池的地址空间必须是连续的，这在具有加载到特定地址的 DLL 的 Windows 系统上可能是一个问题。
初始化缓冲池的时间大致与其大小成正比。在具有大型缓冲池的实例上，初始化时间可能很长。为了减少初始化周期，您可以在服务器关闭时保存缓冲池状态并在服务器启动时恢复它。请参阅第 15.8.3.6 节，“保存和恢复缓冲池状态”。
当您增加或减少缓冲池大小时，操作将以块的形式执行。块大小由
innodb_buffer_pool_chunk_size
变量定义，默认值为 128 MB。
缓冲池大小必须始终等于
innodb_buffer_pool_chunk_size
*
或它的倍数innodb_buffer_pool_instances。如果将缓冲池大小更改为不等于
innodb_buffer_pool_chunk_size
*
或倍数的值innodb_buffer_pool_instances，那么缓冲池大小会自动调整为等于
innodb_buffer_pool_chunk_size
*
或倍数的值innodb_buffer_pool_instances。
innodb_buffer_pool_size可以动态设置，这允许您在不重新启动服务器的情况下调整缓冲池的大小。Innodb_buffer_pool_resize_status
status 变量报告在线缓冲池大小调整操作的状态。
有关更多信息，请参阅
第 15.8.3.1 节，“配置 InnoDB 缓冲池大小”。
如果innodb_dedicated_server启用，
innodb_buffer_pool_size如果未明确定义该值，则会自动配置该值。有关详细信息，请参阅
第 15.8.12 节，“为专用 MySQL 服务器启用自动配置”。
innodb_change_buffer_max_size
命令行格式
--innodb-change-buffer-max-size=#
系统变量
innodb_change_buffer_max_size
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
25
最小值
0
最大值
50
InnoDB
更改缓冲区
的最大大小，以缓冲池总大小的百分比表示
。对于具有大量插入、更新和删除活动的 MySQL 服务器，您可以增加此值，或者对于具有用于报告的不变数据的 MySQL 服务器，可以减少此值。有关详细信息，请参阅第 15.5.2 节，“更改缓冲区”。有关一般 I/O 调整建议，请参阅第 8.5.8 节，“优化 InnoDB 磁盘 I/O”。
innodb_change_buffering
命令行格式
--innodb-change-buffering=value
系统变量
innodb_change_buffering
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
枚举
默认值
all
有效值
noneinsertsdeleteschangespurgesall
是否InnoDB执行
更改缓冲，这是一种延迟对二级索引的写入操作的优化，以便可以按顺序执行 I/O 操作。下表描述了允许的值。值也可以用数字指定。
表 15.25 innodb_change_buffering 的允许值
价值
数值
描述
none
0
不要缓冲任何操作。
inserts
1
缓冲区插入操作。
deletes
2
缓冲区删除标记操作；严格来说，标记索引记录以供稍后在清除操作期间删除的写入。
changes
3
缓冲区插入和删除标记操作。
purges
4
缓冲在后台发生的物理删除操作。
all
5
默认值。缓冲区插入、删除标记操作和清除。
有关详细信息，请参阅
第 15.5.2 节，“更改缓冲区”。有关一般 I/O 调整建议，请参阅第 8.5.8 节，“优化 InnoDB 磁盘 I/O”。
innodb_change_buffering_debug
命令行格式
--innodb-change-buffering-debug=#
系统变量
innodb_change_buffering_debug
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
0
最小值
0
最大值
2
InnoDB为更改缓冲
设置调试标志。值为 1 会强制对更改缓冲区进行所有更改。值为 2 会导致合并时意外退出。默认值 0 表示未设置更改缓冲调试标志。此选项仅在使用
CMake选项编译调试支持时可用。
WITH_DEBUG
innodb_checkpoint_disabled
命令行格式
--innodb-checkpoint-disabled[={OFF|ON}]
系统变量
innodb_checkpoint_disabled
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
这是一个调试选项，仅供专家调试使用。它禁用检查点，以便故意的服务器退出始终启动InnoDB
恢复。它应该只在很短的时间间隔内启用，通常是在运行 DML 操作之前启用，这些操作写入需要在服务器退出后恢复的重做日志条目。此选项仅在使用CMake选项编译调试支持时可用。
WITH_DEBUG
innodb_checksum_algorithm
命令行格式
--innodb-checksum-algorithm=value
系统变量
innodb_checksum_algorithm
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
枚举
默认值
crc32
有效值
crc32strict_crc32innodbstrict_innodbnonestrict_none
指定如何生成和验证
存储在表空间的磁盘块中的校验和。的默认
值为
。
InnoDB
innodb_checksum_algorithmcrc32高达 3.8.0 的MySQL Enterprise Backup
版本不支持备份使用 CRC32 校验和的表空间。
MySQL Enterprise Backup在 3.8.1 中添加了 CRC32 校验和支持，但有一些限制。有关详细信息，请参阅
MySQL Enterprise Backup 3.8.1 更改历史记录。
该值innodb与早期版本的 MySQL 向后兼容。该值
crc32使用一种更快的算法来计算每个修改块的校验和，并检查每个磁盘读取的校验和。它一次扫描 64 位块，比一次innodb
扫描 8 位块的校验和算法更快。该值none在校验和字段中写入一个常量值，而不是根据块数据计算一个值。表空间中的块可以混合使用旧的、新的和无校验和的值，随着数据的修改而逐渐更新；一旦表空间中的块被修改为使用crc32算法，关联的表不能被早期版本的 MySQL 读取。
如果在表空间中遇到有效但不匹配的校验和值，则校验和算法的严格形式会报告错误。建议您仅在新实例中使用严格设置，以便首次设置表空间。严格设置稍微快一些，因为它们不需要在磁盘读取期间计算所有校验和值。
none下表显示了、innodb和
crc32选项值与其严格对应值
之间的差异
。none,
innodb, 并将crc32指定类型的校验和值写入每个数据块，但为了兼容性，在读取操作期间验证块时接受其他校验和值。严格设置也接受有效的校验和值，但在遇到有效的不匹配校验和值时打印错误消息。InnoDB如果一个实例中的所有数据文件都是在相同的
innodb_checksum_algorithm
值
下创建的，则使用严格形式可以加快验证速度
。
表 15.26 允许的 innodb_checksum_algorithm 值
价值
生成的校验和（写入时）
允许的校验和（读取时）
没有任何
一个常数。
none、
innodb或生成的任何校验和crc32。
创新数据库
在软件中计算的校验和，使用来自
InnoDB.
none、
innodb或生成的任何校验和crc32。
crc32
使用该crc32算法计算的校验和，可能通过硬件辅助完成。
none、
innodb或生成的任何校验和crc32。
严格无
一个常数
none、
innodb或生成的任何校验和crc32。
InnoDB如果遇到有效但不匹配的校验和，则打印一条错误消息。
strict_innodb
在软件中计算的校验和，使用来自
InnoDB.
none、
innodb或生成的任何校验和crc32。
InnoDB如果遇到有效但不匹配的校验和，则打印一条错误消息。
strict_crc32
使用该crc32算法计算的校验和，可能通过硬件辅助完成。
none、
innodb或生成的任何校验和crc32。
InnoDB如果遇到有效但不匹配的校验和，则打印一条错误消息。
innodb_cmp_per_index_enabled
命令行格式
--innodb-cmp-per-index-enabled[={OFF|ON}]
系统变量
innodb_cmp_per_index_enabled
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
在表中启用与每个索引压缩相关的统计信息
INFORMATION_SCHEMA.INNODB_CMP_PER_INDEX
。由于收集这些统计数据的成本很高，因此在与
InnoDB
压缩表相关的性能调整期间，仅在开发、测试或副本实例上启用此选项。
有关详细信息，请参阅
第 26.4.8 节，“INFORMATIONSCHEMA INNODB_CMP_PER_INDEX 和 INNODB_CMP_PER_INDEX_RESET 表”和第 15.9.1.4 节，“在运行时监视 InnoDB 表压缩”。
innodb_commit_concurrency
命令行格式
--innodb-commit-concurrency=#
系统变量
innodb_commit_concurrency
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
0
最小值
0
最大值
1000
可以同时提交的线程
数。值 0（默认值）允许
同时提交
任意数量的事务。
的值
innodb_commit_concurrency
不能在运行时从零更改为非零，反之亦然。该值可以从一个非零值更改为另一个。
innodb_compress_debug
命令行格式
--innodb-compress-debug=value
系统变量
innodb_compress_debug
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
枚举
默认值
none
有效值
nonezliblz4lz4hc
使用指定的压缩算法压缩所有表，而不必COMPRESSION
为每个表定义属性。此选项仅在使用
CMake选项编译调试支持时可用。
WITH_DEBUG
有关相关信息，请参阅
第 15.9.2 节，“InnoDB 页面压缩”。
innodb_compression_failure_threshold_pct
命令行格式
--innodb-compression-failure-threshold-pct=#
系统变量
innodb_compression_failure_threshold_pct
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
5
最小值
0
最大值
100
定义表的压缩失败率阈值，以百分比表示，此时 MySQL 开始在压缩
页面内添加填充以避免昂贵的
压缩失败。当超过这个阈值时，MySQL 开始在每个新的压缩页面中留下额外的可用空间，动态地将可用空间量调整为由指定的页面大小的百分比
innodb_compression_pad_pct_max。零值禁用监视压缩效率和动态调整填充量的机制。
有关详细信息，请参阅
第 15.9.1.6 节，“OLTP 工作负载的压缩”。
innodb_compression_level
命令行格式
--innodb-compression-level=#
系统变量
innodb_compression_level
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
6
最小值
0
最大值
9
指定用于
InnoDB
压缩表和索引的 zlib 压缩级别。较高的值可让您将更多数据放入存储设备，但代价是在压缩期间会占用更多 CPU 开销。较低的值可以让您在存储空间不重要时减少 CPU 开销，或者您预计数据不是特别可压缩。
有关详细信息，请参阅
第 15.9.1.6 节，“OLTP 工作负载的压缩”。
innodb_compression_pad_pct_max
命令行格式
--innodb-compression-pad-pct-max=#
系统变量
innodb_compression_pad_pct_max
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
50
最小值
0
最大值
75
指定在每个压缩页
中可以保留为可用空间的最大百分比，
以便在更新压缩表或索引并且可能重新压缩数据时允许空间重新组织页面中的数据和修改日志。仅在
innodb_compression_failure_threshold_pct
设置为非零值且
压缩失败率超过截止点时适用。
有关详细信息，请参阅
第 15.9.1.6 节，“OLTP 工作负载的压缩”。
innodb_concurrency_tickets
命令行格式
--innodb-concurrency-tickets=#
系统变量
innodb_concurrency_tickets
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
5000
最小值
1
最大值
4294967295
确定
可以
并发进入的线程数。如果线程数已经达到并发限制，则线程在InnoDB尝试进入时将被放入队列中。InnoDB当一个线程被允许进入
InnoDB时，它会得到一个等于 值
的“
票”innodb_concurrency_tickets，线程可以自由进出，InnoDB
直到用完它的票。在那之后，线程在下次尝试进入时再次接受并发检查（和可能的排队）
InnoDB。默认值为 5000。
对于较小的
innodb_concurrency_tickets
值，只需要处理几行的小事务与处理多行的较大事务公平竞争。小
innodb_concurrency_tickets
值的缺点是大型事务必须在队列中循环多次才能完成，这会延长完成任务所需的时间。
对于较大的
innodb_concurrency_tickets
值，大型事务花费较少的时间等待队列末尾的位置（由 控制
innodb_thread_concurrency），而更多的时间用于检索行。大型事务还需要更少的队列行程来完成其任务。大
innodb_concurrency_tickets
值的缺点是同时运行太多的大事务会使较小的事务在执行前等待更长的时间，从而使它们饿死。
对于非零
innodb_thread_concurrency
值，您可能需要
innodb_concurrency_tickets
向上或向下调整该值以找到较大和较小事务之间的最佳平衡。该SHOW ENGINE INNODB
STATUS报告显示当前通过队列的执行交易剩余的票数。该数据也可以从表的
TRX_CONCURRENCY_TICKETS列中
获得INFORMATION_SCHEMA.INNODB_TRX
。
有关详细信息，请参阅
第 15.8.4 节，“为 InnoDB 配置线程并发”。
innodb_data_file_path
命令行格式
--innodb-data-file-path=file_name
系统变量
innodb_data_file_path
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
细绳
默认值
ibdata1:12M:autoextend
InnoDB定义系统表空间数据文件
的名称、大小和属性
。如果您没有为 指定值
innodb_data_file_path，则默认行为是创建一个自动扩展数据文件，略大于 12MB，名为
ibdata1.
数据文件规范的完整语法包括文件名、文件大小、autoextend属性和max属性：
file_name:file_size[:autoextend[:max:max_file_size]]K通过将,M或
附加G到大小值
，以千字节、兆字节或千兆字节为单位指定文件大小。如果以千字节为单位指定数据文件大小，请以 1024 的倍数进行指定。否则，KB 值将四舍五入到最接近的兆字节 (MB) 边界。文件大小总和必须至少略大于 12MB。
有关其他配置信息，请参阅
系统表空间数据文件配置。有关调整大小的说明，请参阅
调整系统表空间的大小。
innodb_data_home_dir
命令行格式
--innodb-data-home-dir=dir_name
系统变量
innodb_data_home_dir
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
目录名称
InnoDB
系统表空间数据文件
目录路径的公共部分
。默认值为 MySQL
data目录。innodb_data_file_path
除非该设置是用绝对路径定义的，否则该设置会
与该设置串联在一起
。
为 指定值时需要尾部斜杠
innodb_data_home_dir。例如：
[mysqld]
innodb_data_home_dir = /path/to/myibdata/
此设置不影响
file-per-table 表空间的位置
。
有关相关信息，请参阅
第 15.8.1 节，“InnoDB 启动配置”。
innodb_ddl_buffer_size
命令行格式
--innodb-ddl-buffer-size=#
介绍
8.0.27
系统变量
innodb_ddl_buffer_size
范围
全局，会话
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
1048576
最小值
65536
最大值
4294967295
单元
字节
定义 DDL 操作的最大缓冲区大小。默认设置为 1048576 字节（大约 1 MB）。适用于创建或重建二级索引的在线 DDL 操作。请参阅第 15.12.4 节，“在线 DDL 内存管理”。每个 DDL 线程的最大缓冲区大小是最大缓冲区大小除以 DDL 线程数 ( innodb_ddl_buffer_size/ innodb_ddl_threads)。
innodb_ddl_log_crash_reset_debug
命令行格式
--innodb-ddl-log-crash-reset-debug[={OFF|ON}]
系统变量
innodb_ddl_log_crash_reset_debug
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
启用此调试选项可将 DDL 日志崩溃注入计数器重置为 1。此选项仅在使用
CMake选项编译调试支持时可用。
WITH_DEBUG
innodb_ddl_threads
命令行格式
--innodb-ddl-threads=#
介绍
8.0.27
系统变量
innodb_ddl_threads
范围
全局，会话
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
4
最小值
1
最大值
64
定义索引创建的排序和构建阶段的最大并行线程数。适用于创建或重建二级索引的在线 DDL 操作。有关相关信息，请参阅
第 15.12.5 节，“为在线 DDL 操作配置并行线程”和第 15.12.4 节，“在线 DDL 内存管理”。
innodb_deadlock_detect
命令行格式
--innodb-deadlock-detect[={OFF|ON}]
系统变量
innodb_deadlock_detect
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
ON
此选项用于禁用死锁检测。在高并发系统上，当大量线程等待同一个锁时，死锁检测会导致速度减慢。innodb_lock_wait_timeout
有时，禁用死锁检测并依赖发生死锁时事务回滚
的设置可能更有效。
有关相关信息，请参阅
第 15.7.5.2 节，“死锁检测”。
innodb_dedicated_server
命令行格式
--innodb-dedicated-server[={OFF|ON}]
系统变量
innodb_dedicated_server
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
innodb_dedicated_server
启用时，
自动InnoDB配置以下变量：
innodb_buffer_pool_size
innodb_redo_log_capacity
或者，在 MySQL 8.0.30 之前，
innodb_log_file_size和
innodb_log_files_in_group.
笔记
innodb_log_file_size并
innodb_log_files_in_group在 MySQL 8.0.30 中弃用。这些变量被取代
innodb_redo_log_capacity。有关详细信息，请参阅第 15.6.5 节，“重做日志”。
innodb_flush_method
innodb_dedicated_server仅当 MySQL 实例驻留在可以使用所有可用系统资源的专用服务器上
时才考虑启用
。innodb_dedicated_server如果 MySQL 实例与其他应用程序共享系统资源，则不建议
启用
。
有关详细信息，请参阅
第 15.8.12 节，“为专用 MySQL 服务器启用自动配置”。
innodb_default_row_format
命令行格式
--innodb-default-row-format=value
系统变量
innodb_default_row_format
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
枚举
默认值
DYNAMIC
有效值
REDUNDANTCOMPACTDYNAMIC
该innodb_default_row_format
选项定义
InnoDB表和用户创建的临时表的默认行格式。默认设置为DYNAMIC。其他允许的值是COMPACT和
REDUNDANT。COMPRESSED不支持在
系统表空间中使用的
行格式不能定义为默认值。
新创建的表使用由未明确指定选项或使用选项innodb_default_row_format
时
定义的行格式
。
ROW_FORMATROW_FORMAT=DEFAULT
当ROW_FORMAT未明确指定选项或使用选项时ROW_FORMAT=DEFAULT，任何重建表的操作也会默默地将表的行格式更改为 定义的格式
innodb_default_row_format。有关详细信息，请参阅
定义表的行格式。
服务器创建的用于处理查询的内部InnoDB临时表使用
DYNAMIC行格式，而不管
innodb_default_row_format
设置如何。
innodb_directories
命令行格式
--innodb-directories=dir_name
系统变量
innodb_directories
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
目录名称
默认值
NULL
定义目录以在启动时扫描表空间文件。在服务器脱机时将表空间文件移动或恢复到新位置时使用此选项。它还用于指定使用绝对路径创建的或驻留在数据目录之外的表空间文件的目录。
崩溃恢复期间的表空间发现依赖于
innodb_directories识别重做日志中引用的表空间的设置。有关详细信息，请参阅
崩溃恢复期间的表空间发现。
默认值为 NULL，但
在构建启动时扫描的目录列表时，由innodb_data_home_dir,
innodb_undo_directory和
定义的目录datadir始终附加到innodb_directories
参数值。InnoDB无论是否
innodb_directories明确指定设置，都会附加这些目录。
innodb_directories可以在启动命令或 MySQL 选项文件中指定为选项。引号将参数值括起来，否则某些命令解释器会将分号 ( ;) 解释为特殊字符。（例如，Unix shell 将其视为命令终止符。）
启动命令：
mysqld --innodb-directories="directory_path_1;directory_path_2"
MySQL选项文件：
[mysqld]
innodb_directories="directory_path_1;directory_path_2"
不能使用通配符表达式来指定目录。
扫描还遍历指定目录的innodb_directories子目录。从要扫描的目录列表中丢弃重复的目录和子目录。
有关详细信息，请参阅
第 15.6.3.6 节，“在服务器离线时移动表空间文件”。
innodb_disable_sort_file_cache
命令行格式
--innodb-disable-sort-file-cache[={OFF|ON}]
系统变量
innodb_disable_sort_file_cache
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
为合并排序临时文件禁用操作系统文件系统缓存。效果是用相当于O_DIRECT.
innodb_doublewrite
命令行格式
--innodb-doublewrite=value(≥ 8.0.30)--innodb-doublewrite[={OFF|ON}](≤ 8.0.29)
系统变量
innodb_doublewrite
范围
全球的
动态 (≥ 8.0.30)
是的
动态（≤ 8.0.29）
不
SET_VAR提示适用
不
类型（≥ 8.0.30）
枚举
类型（≤ 8.0.29）
布尔值
默认值
ON
有效值
ONOFFDETECT_AND_RECOVERDETECT_ONLY
该innodb_doublewrite
变量控制双写缓冲。在大多数情况下，默认情况下启用双写缓冲。
在 MySQL 8.0.30 之前，您可以设置
innodb_doublewrite为
ON或OFF在启动服务器时分别启用或禁用双写缓冲。从 MySQL 8.0.30 开始，
innodb_doublewrite也支持DETECT_AND_RECOVER和
DETECT_ONLY设置。
设置与设置DETECT_AND_RECOVER相同ON。使用此设置，双写缓冲区完全启用，数据库页面内容写入双写缓冲区，在恢复期间访问它以修复不完整的页面写入。
通过DETECT_ONLY设置，只有元数据被写入双写缓冲区。数据库页面内容不写入双写缓冲区，恢复不使用双写缓冲区来修复不完整的页面写入。此轻量级设置仅用于检测不完整的页面写入。
MySQL 8.0.30 及更高版本支持动态更改
innodb_doublewrite启用双写缓冲区的设置，介于
ON、DETECT_AND_RECOVER和之间DETECT_ONLY。MySQL 不支持启用双写缓冲区的设置之间的动态更改，OFF反之亦然。
如果双写缓冲区位于支持原子写入的 Fusion-io 设备上，则双写缓冲区会自动禁用，并使用 Fusion-io 原子写入执行数据文件写入。但是，请注意该innodb_doublewrite
设置是全局的。当禁用双写缓冲区时，所有数据文件（包括那些不驻留在 Fusion-io 硬件上的数据文件）都会被禁用。此功能仅在 Fusion-io 硬件上受支持，并且仅在 Linux 上为 Fusion-io NVMFS 启用。要充分利用此功能，
建议innodb_flush_method设置O_DIRECT为 。
有关相关信息，请参阅
第 15.6.4 节，“双写缓冲区”。
innodb_doublewrite_batch_size
命令行格式
--innodb-doublewrite-batch-size=#
介绍
8.0.20
系统变量
innodb_doublewrite_batch_size
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
整数
默认值
0
最小值
0
最大值
256
定义要批量写入的双写页数。
有关详细信息，请参阅
第 15.6.4 节，“双写缓冲区”。
innodb_doublewrite_dir
命令行格式
--innodb-doublewrite-dir=dir_name
介绍
8.0.20
系统变量
innodb_doublewrite_dir
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
目录名称
定义双写文件的目录。如果未指定目录，则在该
innodb_data_home_dir
目录中创建双写文件，如果未指定，则默认为数据目录。
有关详细信息，请参阅
第 15.6.4 节，“双写缓冲区”。
innodb_doublewrite_files
命令行格式
--innodb-doublewrite-files=#
介绍
8.0.20
系统变量
innodb_doublewrite_files
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
整数
默认值
innodb_buffer_pool_instances * 2
最小值
2
最大值
256
定义双写文件的数量。默认情况下，为每个缓冲池实例创建两个双写文件。
至少有两个双写文件。双写文件的最大数量是缓冲池实例数量的两倍。（缓冲池实例的数量由
innodb_buffer_pool_instances
变量控制。）
有关详细信息，请参阅
第 15.6.4 节，“双写缓冲区”。
innodb_doublewrite_pages
命令行格式
--innodb-doublewrite-pages=#
介绍
8.0.20
系统变量
innodb_doublewrite_pages
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
整数
默认值
innodb_write_io_threads value
最小值
innodb_write_io_threads value
最大值
512
为批量写入定义每个线程的最大双写页数。如果未指定值，
innodb_doublewrite_pages则设置为该
innodb_write_io_threads
值。
有关详细信息，请参阅
第 15.6.4 节，“双写缓冲区”。
innodb_extend_and_initialize
命令行格式
--innodb=extend-and-initialize[={OFF|ON}]
介绍
8.0.22
系统变量
innodb_extend_and_initialize
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
ON
控制在 Linux 系统上如何将空间分配给 file-per-table 和 general 表空间。
启用后，InnoDB将 NULL 写入新分配的页面。禁用时，使用
posix_fallocate()调用分配空间，调用保留空间而无需实际写入 NULL。
有关详细信息，请参阅
第 15.6.3.8 节，“在 Linux 上优化表空间空间分配”。
innodb_fast_shutdown
命令行格式
--innodb-fast-shutdown=#
系统变量
innodb_fast_shutdown
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
1
有效值
012
InnoDB
关机模式
。如果该值为 0，InnoDB则
在关闭之前执行慢速关闭、完全清除和更改缓冲区合并。如果值为 1（默认值），则InnoDB在关机时跳过这些操作，这一过程称为
快速关机。如果值为 2，则InnoDB刷新其日志并冷关闭，就好像 MySQL 崩溃了一样；没有提交的事务丢失，但
崩溃恢复
操作使下一次启动需要更长的时间。
在仍有大量数据缓冲的极端情况下，缓慢关闭可能需要几分钟甚至几小时。在 MySQL 主要版本之间升级或降级之前使用慢关机技术，以便在升级过程更新文件格式时为所有数据文件做好充分准备。
在紧急情况或故障排除情况下使用innodb_fast_shutdown=2，以便在数据存在损坏风险时获得绝对最快的关闭。
innodb_fil_make_page_dirty_debug
命令行格式
--innodb-fil-make-page-dirty-debug=#
系统变量
innodb_fil_make_page_dirty_debug
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
0
最小值
0
最大值
2**32-1
默认情况下，设置
innodb_fil_make_page_dirty_debug
为表空间的 ID 会立即弄脏表空间的第一页。如果
innodb_saved_page_number_debug
设置为非默认值，
innodb_fil_make_page_dirty_debug
则设置会弄脏指定页面。innodb_fil_make_page_dirty_debug
只有在使用CMake选项编译调试支持时，该
选项才可用。
WITH_DEBUG
innodb_file_per_table
命令行格式
--innodb-file-per-table[={OFF|ON}]
系统变量
innodb_file_per_table
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
ON
启用时innodb_file_per_table，默认情况下在 file-per-table 表空间中创建表。禁用时，默认情况下在系统表空间中创建表。有关 file-per-table 表空间的信息，请参阅
第 15.6.3.2 节，“File-Per-Table 表空间”。有关InnoDB系统表空间的信息，请参阅第 15.6.3.1 节，“系统表空间”。
该innodb_file_per_table
变量可以在运行时使用
SET
GLOBAL语句配置，在启动时在命令行上指定，或在选项文件中指定。运行时的配置需要足够的权限来设置全局系统变量（请参阅第 5.1.9.1 节，“系统变量权限”）并立即影响所有连接的操作。
当驻留在 file-per-table 表空间中的表被截断或删除时，释放的空间将返回给操作系统。截断或删除驻留在系统表空间中的表只会释放系统表空间中的空间。系统表空间中释放的空间可以再次用于InnoDB数据，但不会返回给操作系统，因为系统表空间数据文件永远不会缩小。
该innodb_file_per-table
设置不影响临时表的创建。从 MySQL 8.0.14 开始，临时表是在会话临时表空间中创建的，在此之前是在全局临时表空间中创建的。请参阅
第 15.6.3.5 节，“临时表空间”。
innodb_fill_factor
命令行格式
--innodb-fill-factor=#
系统变量
innodb_fill_factor
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
100
最小值
10
最大值
100
InnoDB在创建或重建索引时执行批量加载。这种创建索引的方法被称为“排序索引构建”。
innodb_fill_factor定义在排序索引构建期间填充的每个 B 树页面上的空间百分比，剩余空间保留用于未来的索引增长。例如，设置
innodb_fill_factor为 80 会在每个 B 树页面上保留 20% 的空间用于未来的索引增长。实际百分比可能会有所不同。该
innodb_fill_factor设置被解释为提示而不是硬限制。
设置为 100 时，聚集索引页中有innodb_fill_factor1/16 的空间可用于将来的索引增长。
innodb_fill_factor适用于 B 树叶页和非叶页。它不适用于用于TEXT或
BLOB条目的外部页面。
有关详细信息，请参阅
第 15.6.2.3 节，“排序索引构建”。
innodb_flush_log_at_timeout
命令行格式
--innodb-flush-log-at-timeout=#
系统变量
innodb_flush_log_at_timeout
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
1
最小值
1
最大值
2700
单元
秒
每秒写入并刷新日志N
。
innodb_flush_log_at_timeout
允许增加刷新之间的超时时间，以减少刷新并避免影响二进制日志组提交的性能。默认设置为
innodb_flush_log_at_timeout
每秒一次。
innodb_flush_log_at_trx_commit
命令行格式
--innodb-flush-log-at-trx-commit=#
系统变量
innodb_flush_log_at_trx_commit
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
枚举
默认值
1
有效值
012
控制提交操作的严格ACID合规性
与重新安排和批量完成提交相关 I/O 操作时可能实现的更高性能
之间的平衡
。您可以通过更改默认值来获得更好的性能，但是您可能会在崩溃中丢失事务。
完全符合 ACID 需要默认设置 1。日志在每次提交事务时写入并刷新到磁盘。
设置为 0 时，日志每秒写入并刷新到磁盘一次。尚未刷新日志的事务可能会在崩溃中丢失。
设置为 2 时，日志在每次事务提交后写入并每秒刷新到磁盘一次。尚未刷新日志的事务可能会在崩溃中丢失。
对于设置 0 和 2，不能 100% 保证每秒刷新一次。由于 DDL 更改和其他InnoDB
导致日志独立于
innodb_flush_log_at_trx_commit
设置刷新的内部活动，刷新可能更频繁地发生，有时由于调度问题而不太频繁。如果每秒刷新一次日志，则在崩溃中可能会丢失最多一秒的事务。如果日志刷新频率高于或低于每秒一次，则可能丢失的事务量会相应变化。
日志刷新频率由 控制
innodb_flush_log_at_timeout，它允许您将日志刷新频率设置为
N秒（其中
N是1 ...
2700，默认值为 1）。但是，任何意外的mysqld进程退出都可以擦除长达N数秒的事务。
DDL 更改和其他内部InnoDB
活动独立于设置刷新日志
innodb_flush_log_at_trx_commit
。
InnoDB
无论
设置如何，崩溃恢复innodb_flush_log_at_trx_commit都有效
。事务要么被完全应用，要么被完全擦除。
InnoDB为了在与事务一起
使用的复制设置中保持持久性和一致性：
如果启用了二进制日志记录，请设置
sync_binlog=1.
总是设置
innodb_flush_log_at_trx_commit=1。
有关对意外停止最具弹性的副本设置组合的信息，请参阅
第 17.4.2 节，“处理副本的意外停止”。
警告
许多操作系统和一些磁盘硬件会欺骗刷新到磁盘的操作。他们可能会告诉
mysqld刷新已经发生，即使它没有发生。在这种情况下，即使使用推荐的设置也无法保证事务的持久性，在最坏的情况下，断电可能会损坏
InnoDB数据。在 SCSI 磁盘控制器或磁盘本身中使用电池供电的磁盘缓存可以加快文件刷新速度，并使操作更安全。您还可以尝试禁用硬件缓存中的磁盘写入缓存。
innodb_flush_method
命令行格式
--innodb-flush-method=value
系统变量
innodb_flush_method
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
细绳
默认值 (Unix)
fsync
默认值 (Windows)
unbuffered
有效值 (Unix)
fsyncO_DSYNClittlesyncnosyncO_DIRECTO_DIRECT_NO_FSYNC
有效值 (Windows)
unbufferednormal
定义用于将
数据刷新到
InnoDB 数据文件和日志文件的方法，这会影响 I/O 吞吐量。
在类 Unix 系统上，默认值为
fsync. 在 Windows 上，默认值为
unbuffered.
笔记
在 MySQL 8.0 中，
innodb_flush_method可以用数字指定选项。
innodb_flush_method
类 Unix 系统
的选项包括：
fsyncor 0：
InnoDB使用
fsync()系统调用刷新数据和日志文件。fsync是默认设置。
O_DSYNCor 1：
InnoDB用于O_SYNC
打开和刷新日志文件，以及
fsync()刷新数据文件。
InnoDB不
O_DSYNC直接使用，因为它在许多 Unix 变体上都存在问题。
littlesyncor 2：此选项用于内部性能测试，目前不受支持。使用风险自负。
nosyncor 3：此选项用于内部性能测试，目前不受支持。使用风险自负。
O_DIRECTor 4：
InnoDB用于O_DIRECT
（或directio()在 Solaris 上）打开数据文件，并用于fsync()刷新数据和日志文件。此选项在某些 GNU/Linux 版本、FreeBSD 和 Solaris 上可用。
O_DIRECT_NO_FSYNC:
在刷新 I/O 期间InnoDB使用，但在每次写入操作后
O_DIRECT
跳过
系统调用。fsync()
在 MySQL 8.0.14 之前，该设置不适用于 XFS 和 EXT4 等需要
fsync()系统调用来同步文件系统元数据更改的文件系统。如果您不确定您的文件系统是否需要fsync()系统调用来同步文件系统元数据更改，请
O_DIRECT改用。
从 MySQL 8.0.14 开始，fsync()在创建新文件、增加文件大小和关闭文件后调用，以确保同步文件系统元数据更改。fsync()
每次写操作后仍然会跳过系统调用
。
如果重做日志文件和数据文件驻留在不同的存储设备上，则可能会丢失数据，并且在数据文件写入从非电池供电的设备缓存中刷新之前会发生意外退出。如果您使用或打算将不同的存储设备用于重做日志文件和数据文件，并且您的数据文件驻留在具有非电池后备缓存的设备上，请
O_DIRECT改用。
在支持fdatasync()
系统调用的
平台上innodb_use_fdatasync
，MySQL 8.0.26 中引入的变量允许
innodb_flush_method使用的选项fsync()改为使用
fdatasync()。除非
fdatasync()后续数据检索需要，否则系统调用不会刷新对文件元数据的更改，从而提供潜在的性能优势。
Windows 系统的innodb_flush_method
选项包括：
unbufferedor 0：
InnoDB使用模拟异步 I/O 和非缓冲 I/O。
normalor 1：
InnoDB使用模拟异步 I/O 和缓冲 I/O。
每个设置如何影响性能取决于硬件配置和工作负载。对您的特定配置进行基准测试，以确定要使用的设置，或者是否保留默认设置。检查
Innodb_data_fsyncs状态变量以查看每个设置的调用总数
fsync()（或
fdatasync()调用，如果
innodb_use_fdatasync已启用）。工作负载中读写操作的混合会影响设置的执行方式。例如，在具有硬件 RAID 控制器和电池备份写缓存的系统上，O_DIRECT可以帮助避免
InnoDB缓冲池和操作系统文件系统缓存。在
InnoDB数据和日志文件位于 SAN 上的某些系统上，默认值或对于主要包含语句O_DSYNC的读取繁重的工作负载可能更快
。SELECT始终使用反映您的生产环境的硬件和工作负载测试此参数。有关一般 I/O 调整建议，请参阅
第 8.5.8 节，“优化 InnoDB 磁盘 I/O”。
如果innodb_dedicated_server启用，
innodb_flush_method如果未明确定义该值，则会自动配置该值。有关详细信息，请参阅
第 15.8.12 节，“为专用 MySQL 服务器启用自动配置”。
innodb_flush_neighbors
命令行格式
--innodb-flush-neighbors=#
系统变量
innodb_flush_neighbors
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
枚举
默认值
0
有效值
012
指定从缓冲池中刷新页面是否也刷新相同
范围内的其他脏页。
InnoDB
设置为 0 将禁用
innodb_flush_neighbors。相同范围内的脏页不会被刷新。
设置为 1 会刷新同一范围内的连续脏页。
设置为 2 会刷新相同范围内的脏页。
当表数据存储在传统
HDD存储设备上时，
与在不同时间刷新单个页面相比，在一次操作中刷新此类相邻页面可减少 I/O 开销（主要用于磁盘查找操作）。对于存储在
SSD上的表数据，寻道时间不是一个重要因素，您可以将此选项设置为 0 以分散写入操作。有关相关信息，请参阅
第 15.8.3.5 节，“配置缓冲池刷新”。
innodb_flush_sync
命令行格式
--innodb-flush-sync[={OFF|ON}]
系统变量
innodb_flush_sync
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
ON
默认情况下启用的innodb_flush_sync
变量会导致
设置在检查点innodb_io_capacity发生的 I/O 活动突发期间被忽略
。要遵守
设置定义的 I/O 速率，请禁用。
innodb_io_capacityinnodb_flush_sync
有关配置
innodb_flush_sync变量的信息，请参阅第 15.8.7 节，“配置 InnoDB I/O 容量”。
innodb_flushing_avg_loops
命令行格式
--innodb-flushing-avg-loops=#
系统变量
innodb_flushing_avg_loops
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
30
最小值
1
最大值
1000
保留先前计算的刷新状态快照的迭代次数InnoDB，控制
自适应刷新响应不断变化的
工作负载的速度。增加该值可使
刷新操作的速率随着工作负载的变化而平滑且逐渐变化。降低该值会使自适应刷新快速适应工作负载变化，如果工作负载突然增加和减少，这可能会导致刷新活动出现峰值。
有关相关信息，请参阅
第 15.8.3.5 节，“配置缓冲池刷新”。
innodb_force_load_corrupted
命令行格式
--innodb-force-load-corrupted[={OFF|ON}]
系统变量
innodb_force_load_corrupted
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
允许InnoDB在启动时加载标记为已损坏的表。仅在故障排除期间使用，以恢复否则无法访问的数据。故障排除完成后，禁用此设置并重新启动服务器。
innodb_force_recovery
命令行格式
--innodb-force-recovery=#
系统变量
innodb_force_recovery
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
整数
默认值
0
最小值
0
最大值
6
崩溃恢复
模式，通常只在严重的故障排除情况下才会改变
。可能的值是从 0 到 6。有关这些值的含义和重要信息
innodb_force_recovery，请参阅
第 15.21.3 节，“强制 InnoDB 恢复”。
警告
仅在紧急情况下将此变量设置为大于 0 的值，以便您可以启动
InnoDB和转储表。作为一项安全措施，当大于 0
时，会InnoDB阻止
INSERT、
UPDATE或
DELETE操作
。
设置为 4 或更大时，将
进入只读模式。
innodb_force_recoveryinnodb_force_recoveryInnoDB
这些限制可能会导致复制管理命令失败并出现错误，因为复制将副本状态日志存储在InnoDB表中。
innodb_fsync_threshold
命令行格式
--innodb-fsync-threshold=#
介绍
8.0.13
系统变量
innodb_fsync_threshold
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
0
最小值
0
最大值
2**64-1
默认情况下，当InnoDB创建一个新的数据文件，例如一个新的日志文件或表空间文件时，该文件在刷新到磁盘之前会被完全写入操作系统缓存，这会导致大量的磁盘写入活动发生在一次。要强制从操作系统缓存中定期刷新更小的数据，您可以使用该
innodb_fsync_threshold
变量定义阈值（以字节为单位）。当达到字节阈值时，操作系统缓存的内容被刷新到磁盘。默认值 0 强制默认行为，即仅在文件完全写入缓存后才将数据刷新到磁盘。
在多个 MySQL 实例使用相同存储设备的情况下，指定一个阈值以强制进行更小的定期刷新可能是有益的。例如，创建一个新的 MySQL 实例及其关联的数据文件可能会导致磁盘写入活动激增，从而影响使用相同存储设备的其他 MySQL 实例的性能。配置阈值有助于避免写入活动出现此类激增。
innodb_ft_aux_table
系统变量
innodb_ft_aux_table
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
细绳
指定InnoDB
包含FULLTEXT索引的表的限定名称。此变量用于诊断目的，只能在运行时设置。例如：
SET GLOBAL innodb_ft_aux_table = 'test/t1';
将此变量设置为格式中的名称后
，
表、
、
和
显示
有关指定表的搜索索引的信息。
db_name/table_nameINFORMATION_SCHEMAINNODB_FT_INDEX_TABLEINNODB_FT_INDEX_CACHEINNODB_FT_CONFIGINNODB_FT_DELETEDINNODB_FT_BEING_DELETED
有关更多信息，请参阅
第 15.15.4 节，“InnoDB INFORMATION_SCHEMA FULLTEXT 索引表”。
innodb_ft_cache_size
命令行格式
--innodb-ft-cache-size=#
系统变量
innodb_ft_cache_size
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
整数
默认值
8000000
最小值
1600000
最大值
80000000
单元
字节
为搜索索引缓存分配的内存（以字节为单位）
InnoDB FULLTEXT，它在创建InnoDB
FULLTEXT索引时将已解析的文档保存在内存中。索引插入和更新仅在
innodb_ft_cache_size达到大小限制时提交到磁盘。
innodb_ft_cache_size在每个表的基础上定义缓存大小。要为所有表设置全局限制，请参阅
innodb_ft_total_cache_size。
有关更多信息，请参阅
InnoDB 全文索引缓存。
innodb_ft_enable_diag_print
命令行格式
--innodb-ft-enable-diag-print[={OFF|ON}]
系统变量
innodb_ft_enable_diag_print
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
是否启用额外的全文搜索 (FTS) 诊断输出。此选项主要用于高级 FTS 调试，大多数用户对此并不感兴趣。输出被打印到错误日志中，包括以下信息：
FTS 索引同步进度（达到 FTS 缓存限制时）。例如：
FTS SYNC for table test, deleted count: 100 size: 10000 bytes
SYNC words: 100
FTS优化进度。例如：
FTS start optimize test
FTS_OPTIMIZE: optimize "mysql"
FTS_OPTIMIZE: processed "mysql"
FTS 索引构建进度。例如：
Number of doc processed: 1000
对于 FTS 查询，打印查询解析树、词权重、查询处理时间和内存使用情况。例如：
FTS Search Processing time: 1 secs: 100 millisec: row(s) 10000
Full Search Memory: 245666 (bytes),  Row: 10000
innodb_ft_enable_stopword
命令行格式
--innodb-ft-enable-stopword[={OFF|ON}]
系统变量
innodb_ft_enable_stopword
范围
全局，会话
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
ON
指定
在创建索引时将一组停用词与索引相关联。InnoDB FULLTEXT如果
innodb_ft_user_stopword_table
设置了该选项，则停用词将从该表中获取。否则，如果
innodb_ft_server_stopword_table
设置了该选项，则停用词将从该表中获取。否则，将使用一组内置的默认停用词。
有关详细信息，请参阅
第 12.10.4 节，“全文停用词”。
innodb_ft_max_token_size
命令行格式
--innodb-ft-max-token-size=#
系统变量
innodb_ft_max_token_size
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
整数
默认值
84
最小值
10
最大值
84
存储在
InnoDB FULLTEXT索引中的单词的最大字符长度。对该值设置限制可减少索引的大小，从而通过省略长关键字或不是真实单词且不太可能是搜索词的任意字母集合来加快查询速度。
有关详细信息，请参阅
第 12.10.6 节，“微调 MySQL 全文搜索”。
innodb_ft_min_token_size
命令行格式
--innodb-ft-min-token-size=#
系统变量
innodb_ft_min_token_size
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
整数
默认值
3
最小值
0
最大值
16
存储在
InnoDB FULLTEXT索引中的单词的最小长度。增加这个值会减少索引的大小，从而通过省略在搜索上下文中不太可能重要的常用词（例如英语单词“ a ”和“ to ” ）来加快查询速度。对于使用 CJK（中文、日语、韩语）字符集的内容，指定值 1。
有关详细信息，请参阅
第 12.10.6 节，“微调 MySQL 全文搜索”。
innodb_ft_num_word_optimize
命令行格式
--innodb-ft-num-word-optimize=#
系统变量
innodb_ft_num_word_optimize
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
2000
最小值
1000
最大值
10000
在索引的每个OPTIMIZE TABLE操作
期间要处理的单词数
。InnoDB FULLTEXT由于对包含全文搜索索引的表进行批量插入或更新操作可能需要大量索引维护以合并所有更改，因此您可能会执行一系列OPTIMIZE TABLE
语句，每个语句都从上一个停止的地方开始。
有关详细信息，请参阅
第 12.10.6 节，“微调 MySQL 全文搜索”。
innodb_ft_result_cache_limit
命令行格式
--innodb-ft-result-cache-limit=#
系统变量
innodb_ft_result_cache_limit
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
2000000000
最小值
1000000
最大值
2**32-1
单元
字节
InnoDB每个全文搜索查询或每个线程的全文搜索查询结果缓存限制（以字节为单位定义）
。中间和最终InnoDB
的全文搜索查询结果在内存中处理。用于
innodb_ft_result_cache_limit
对全文搜索查询结果缓存设置大小限制，以避免在非常大InnoDB的全文搜索查询结果（例如数百万或数亿行）的情况下消耗过多的内存。处理全文搜索查询时，会根据需要分配内存。如果达到结果缓存大小限制，则会返回一个错误，表明查询超出了最大允许内存。
innodb_ft_result_cache_limit
所有平台类型和位大小
的最大值
为 2**32-1。
innodb_ft_server_stopword_table
命令行格式
--innodb-ft-server-stopword-table=db_name/table_name
系统变量
innodb_ft_server_stopword_table
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
细绳
默认值
NULL
此选项用于为所有表
指定您自己的
InnoDB FULLTEXT索引停用词列表。InnoDB要为特定
InnoDB表配置您自己的停用词列表，请使用
innodb_ft_user_stopword_table.
设置
innodb_ft_server_stopword_table
为包含停用词列表的表的名称，格式为
.
db_name/table_name
停用词表必须在您配置之前存在
innodb_ft_server_stopword_table。
在创建索引
之前innodb_ft_enable_stopword
必须启用并且
innodb_ft_server_stopword_table
必须配置选项
。FULLTEXT
停用词表必须是一个InnoDB表，包含一个VARCHAR名为 的列
value。
有关详细信息，请参阅
第 12.10.4 节，“全文停用词”。
innodb_ft_sort_pll_degree
命令行格式
--innodb-ft-sort-pll-degree=#
系统变量
innodb_ft_sort_pll_degree
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
整数
默认值
2
最小值
1
最大值
32
InnoDB FULLTEXT
构建搜索索引时
并行使用的线程数，用于对索引中的文本进行索引和标记化。
有关相关信息，请参阅
第 15.6.2.4 节，“InnoDB 全文索引”和
innodb_sort_buffer_size。
innodb_ft_total_cache_size
命令行格式
--innodb-ft-total-cache-size=#
系统变量
innodb_ft_total_cache_size
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
整数
默认值
640000000
最小值
32000000
最大值
1600000000
单元
字节
InnoDB为所有表的全文搜索索引缓存
分配的总内存（以字节为单位）
。创建大量表，每个表都有一个
FULLTEXT搜索索引，可能会消耗很大一部分可用内存。
innodb_ft_total_cache_size
为所有全文搜索索引定义一个全局内存限制，以帮助避免过多的内存消耗。如果索引操作达到全局限制，则会触发强制同步。
有关更多信息，请参阅
InnoDB 全文索引缓存。
innodb_ft_user_stopword_table
命令行格式
--innodb-ft-user-stopword-table=db_name/table_name
系统变量
innodb_ft_user_stopword_table
范围
全局，会话
动态的
是的
SET_VAR提示适用
不
类型
细绳
默认值
NULL
此选项用于
InnoDB FULLTEXT在特定表上指定您自己的索引停用词列表。要为所有表配置您自己的停用词列表InnoDB，请使用
innodb_ft_server_stopword_table.
设置
innodb_ft_user_stopword_table
为包含停用词列表的表的名称，格式为
.
db_name/table_name
停用词表必须在您配置之前存在
innodb_ft_user_stopword_table。
innodb_ft_enable_stopword
必须
在创建索引
innodb_ft_user_stopword_table
之前启用和配置
。FULLTEXT
停用词表必须是一个InnoDB表，包含一个VARCHAR名为 的列
value。
有关详细信息，请参阅
第 12.10.4 节，“全文停用词”。
innodb_idle_flush_pct
命令行格式
--innodb-idle-flush-pct=#
介绍
8.0.18
系统变量
innodb_idle_flush_pct
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
100
最小值
0
最大值
100
InnoDB空闲
时限制页面刷新。该innodb_idle_flush_pct
值是
innodb_io_capacity设置的百分比，它定义每秒可用于 的 I/O 操作数InnoDB。有关详细信息，请参阅在空闲期间限制缓冲区刷新。
innodb_io_capacity
命令行格式
--innodb-io-capacity=#
系统变量
innodb_io_capacity
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
200
最小值
100
最大值（64 位平台）
2**64-1
最大值（32 位平台）
2**32-1
该innodb_io_capacity
变量定义后台任务可用的每秒 I/O 操作数 (IOPS) InnoDB，例如从缓冲池刷新
页面和从更改缓冲区合并数据
。
有关配置
innodb_io_capacity变量的信息，请参阅第 15.8.7 节，“配置 InnoDB I/O 容量”。
innodb_io_capacity_max
命令行格式
--innodb-io-capacity-max=#
系统变量
innodb_io_capacity_max
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
see description
最小值
100
最大值（32 位平台）
2**32-1
最大值（Unix，64 位平台）
2**64-1
最大值（Windows，64 位平台）
2**32-1
如果刷新活动落后，InnoDB
可以更积极地刷新，每秒 I/O 操作 (IOPS) 的速率高于
innodb_io_capacity变量定义的速率。该变量定义了在这种情况下后台任务
innodb_io_capacity_max
执行的最大 IOPS 数
。InnoDB
有关配置
innodb_io_capacity_max
变量的信息，请参阅
第 15.8.7 节，“配置 InnoDB I/O 容量”。
innodb_limit_optimistic_insert_debug
命令行格式
--innodb-limit-optimistic-insert-debug=#
系统变量
innodb_limit_optimistic_insert_debug
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
0
最小值
0
最大值
2**32-1
限制每个
B 树页面的记录数。默认值 0 表示不施加限制。此选项仅在使用
CMake选项编译调试支持时可用。
WITH_DEBUG
innodb_lock_wait_timeout
命令行格式
--innodb-lock-wait-timeout=#
系统变量
innodb_lock_wait_timeout
范围
全局，会话
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
50
最小值
1
最大值
1073741824
单元
秒
InnoDB
事务在放弃之前等待行锁
的时间长度（以秒为单位）。默认值为 50 秒。试图访问被另一个
InnoDB事务锁定的行的事务在发出以下错误之前最多等待这么多秒来对该行进行写访问：
ERROR 1205 (HY000): Lock wait timeout exceeded; try restarting transaction
当发生锁等待超时时，
回滚当前语句（而不是整个事务）。要使整个事务回滚，请使用该
--innodb-rollback-on-timeout
选项启动服务器。另见第 15.21.5 节，“InnoDB 错误处理”。
对于高度交互的应用程序或OLTP系统，
您可以降低此值，以快速显示用户反馈或将更新放入队列中以供稍后处理。您可以为长时间运行的后端操作增加此值，例如数据仓库中等待其他大型插入或更新操作完成的转换步骤。
innodb_lock_wait_timeout
适用于InnoDB行锁。内部不会发生MySQL
表锁InnoDB，并且此超时不适用于等待表锁。
锁定等待超时值在启用（默认）时
不适用于
死锁，因为它
会立即检测到死锁并回滚其中一个死锁事务。禁用时，依赖
于
发生死锁时的事务回滚。请参阅
第 15.7.5.2 节，“死锁检测”。
innodb_deadlock_detectInnoDBinnodb_deadlock_detectInnoDBinnodb_lock_wait_timeout
innodb_lock_wait_timeout可以在运行时使用SET GLOBALor
SET SESSION语句设置。更改
GLOBAL设置需要足够的权限来设置全局系统变量（请参阅
第 5.1.9.1 节，“系统变量权限”）并影响随后连接的所有客户端的操作。任何客户端都可以更改 的SESSION设置
innodb_lock_wait_timeout，这只会影响该客户端。
innodb_log_buffer_size
命令行格式
--innodb-log-buffer-size=#
系统变量
innodb_log_buffer_size
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
16777216
最小值
1048576
最大值
4294967295
InnoDB
用于写入磁盘上的日志文件
的缓冲区的大小（以字节为单位） 。默认值为 16MB。大型
日志缓冲区使大型事务无需在事务提交之前将日志写入磁盘即可运行。因此，如果您有更新、插入或删除许多行的事务，那么增大日志缓冲区可以节省磁盘 I/O。有关相关信息，请参阅
内存配置和
第 8.5.4 节，“优化 InnoDB 重做日志记录”。有关一般 I/O 调整建议，请参阅第 8.5.8 节，“优化 InnoDB 磁盘 I/O”.
innodb_log_checkpoint_fuzzy_now
命令行格式
--innodb-log-checkpoint-fuzzy-now[={OFF|ON}]
介绍
8.0.13
系统变量
innodb_log_checkpoint_fuzzy_now
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
启用此调试选项以强制InnoDB写入模糊检查点。此选项仅在使用
CMake选项编译调试支持时可用。
WITH_DEBUG
innodb_log_checkpoint_now
命令行格式
--innodb-log-checkpoint-now[={OFF|ON}]
系统变量
innodb_log_checkpoint_now
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
启用此调试选项以强制InnoDB写入检查点。此选项仅在使用
CMake选项编译调试支持时可用。
WITH_DEBUG
innodb_log_checksums
命令行格式
--innodb-log-checksums[={OFF|ON}]
系统变量
innodb_log_checksums
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
ON
启用或禁用重做日志页面的校验和。
innodb_log_checksums=ON
为重做日志页启用CRC-32C校验和算法。禁用时
innodb_log_checksums，重做日志页校验和字段的内容将被忽略。
永远不会禁用重做日志标题页和重做日志检查点页上的校验和。
innodb_log_compressed_pages
命令行格式
--innodb-log-compressed-pages[={OFF|ON}]
系统变量
innodb_log_compressed_pages
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
ON
指定是否将
重新压缩
页面的图像写入
重做日志。当对压缩数据进行更改时，可能会发生重新压缩。
innodb_log_compressed_pageszlib
默认情况下启用，以防止在恢复期间使用不同版本的压缩算法
时可能发生的损坏。如果您确定zlib版本不会更改，则可以禁用
innodb_log_compressed_pages
以减少修改压缩数据的工作负载的重做日志生成。
要衡量启用或禁用的效果
innodb_log_compressed_pages，请比较相同工作负载下两种设置的重做日志生成。测量重做日志生成的选项包括观察输出部分中
的Log sequence number(LSN) ，或监视
写入重做日志文件的字节数的状态。
LOGSHOW ENGINE
INNODB STATUSInnodb_os_log_written
有关相关信息，请参阅
第 15.9.1.6 节，“OLTP 工作负载的压缩”。
innodb_log_file_size
命令行格式
--innodb-log-file-size=#
弃用
8.0.30
系统变量
innodb_log_file_size
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
整数
默认值
50331648
最小值
4194304
最大值
512GB / innodb_log_files_in_group
单元
字节
笔记
innodb_log_file_size并
innodb_log_files_in_group
在 MySQL 8.0.30 中弃用。这些变量被取代
innodb_redo_log_capacity。有关详细信息，请参阅第 15.6.5 节，“重做日志”。
日志组中每个日志文件的
大小（以字节为单位）。日志文件 ( *
) 的组合大小不能超过略小于 512GB 的最大值。例如，一对 255 GB 的日志文件接近限制但未超过限制。默认值为 48MB。
innodb_log_file_sizeinnodb_log_files_in_group
通常，日志文件的组合大小应该足够大，以便服务器可以消除工作负载活动中的高峰和低谷，这通常意味着有足够的重做日志空间来处理一个多小时的写入活动。值越大，缓冲池中需要的检查点刷新活动越少，从而节省磁盘 I/O。较大的日志文件也会使崩溃恢复变慢。
最小值
innodb_log_file_size为 4MB。
有关相关信息，请参阅
重做日志配置。有关一般 I/O 调整建议，请参阅
第 8.5.8 节，“优化 InnoDB 磁盘 I/O”。
如果innodb_dedicated_server启用，
innodb_log_file_size如果未明确定义该值，则会自动配置该值。有关详细信息，请参阅
第 15.8.12 节，“为专用 MySQL 服务器启用自动配置”。
innodb_log_files_in_group
命令行格式
--innodb-log-files-in-group=#
弃用
8.0.30
系统变量
innodb_log_files_in_group
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
整数
默认值
2
最小值
2
最大值
100
笔记
innodb_log_file_size并
innodb_log_files_in_group
在 MySQL 8.0.30 中弃用。这些变量被取代
innodb_redo_log_capacity。有关详细信息，请参阅第 15.6.5 节，“重做日志”。
日志组
中
的日志文件数。
以循环方式写入文件。默认（推荐）值为 2。文件的位置由 指定
。日志文件 ( *
)的组合大小最大可达 512GB。
InnoDBinnodb_log_group_home_dirinnodb_log_file_sizeinnodb_log_files_in_group
有关相关信息，请参阅
重做日志配置。
如果innodb_dedicated_server启用，
innodb_log_files_in_group则在未明确定义时自动配置。有关详细信息，请参阅
第 15.8.12 节，“为专用 MySQL 服务器启用自动配置”。
innodb_log_group_home_dir
命令行格式
--innodb-log-group-home-dir=dir_name
系统变量
innodb_log_group_home_dir
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
目录名称
InnoDB
重做日志文件
的目录路径。
有关相关信息，请参阅
重做日志配置。
innodb_log_spin_cpu_abs_lwm
命令行格式
--innodb-log-spin-cpu-abs-lwm=#
系统变量
innodb_log_spin_cpu_abs_lwm
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
80
最小值
0
最大值
4294967295
定义最小 CPU 使用量，低于此值用户线程在等待刷新重做时不再旋转。该值表示为 CPU 核心使用率的总和。例如，默认值 80 是单个 CPU 内核的 80%。在具有多核处理器的系统上，值 150 表示一个 CPU 内核的 100% 使用率加上第二个 CPU 内核的 50% 使用率。
有关相关信息，请参阅
第 8.5.4 节，“优化 InnoDB 重做日志记录”。
innodb_log_spin_cpu_pct_hwm
命令行格式
--innodb-log-spin-cpu-pct-hwm=#
系统变量
innodb_log_spin_cpu_pct_hwm
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
50
最小值
0
最大值
100
定义最大 CPU 使用率，超过该值用户线程在等待刷新重做时不再自旋。该值表示为所有 CPU 内核的组合总处理能力的百分比。默认值为 50%。例如，两个 CPU 内核的 100% 使用率是具有四个 CPU 内核的服务器上组合 CPU 处理能力的 50%。
该
innodb_log_spin_cpu_pct_hwm
变量尊重处理器亲和力。例如，如果服务器有 48 个内核，但mysqld进程仅固定到四个 CPU 内核，则其他 44 个 CPU 内核将被忽略。
有关相关信息，请参阅
第 8.5.4 节，“优化 InnoDB 重做日志记录”。
innodb_log_wait_for_flush_spin_hwm
命令行格式
--innodb-log-wait-for-flush-spin-hwm=#
系统变量
innodb_log_wait_for_flush_spin_hwm
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
400
最小值
0
最大值（64 位平台）
2**64-1
最大值（32 位平台）
2**32-1
单元
微秒
定义最大平均日志刷新时间，超过该时间用户线程在等待刷新重做时不再旋转。默认值为 400 微秒。
有关相关信息，请参阅
第 8.5.4 节，“优化 InnoDB 重做日志记录”。
innodb_log_write_ahead_size
命令行格式
--innodb-log-write-ahead-size=#
系统变量
innodb_log_write_ahead_size
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
8192
最小值
512 (log file block size)
最大值
Equal to innodb_page_size
单元
字节
定义重做日志的预写块大小，以字节为单位。为避免“写时读”，设置
innodb_log_write_ahead_size
为与操作系统或文件系统缓存块大小相匹配。默认设置为 8192 字节。当由于重做日志的预写块大小与操作系统或文件系统缓存块大小不匹配而导致重做日志块未完全缓存到操作系统或文件系统时，会发生写时读。
的有效值为
日志文件块大小 (2 n )innodb_log_write_ahead_size
的倍数。最小值为
日志文件块大小 (512)。指定最小值时不会发生预写。最大值等于该
值。如果您为其指定的值
大于该
值，则该
设置将被截断为该
值。
InnoDBInnoDBinnodb_page_sizeinnodb_log_write_ahead_sizeinnodb_page_sizeinnodb_log_write_ahead_sizeinnodb_page_sizeinnodb_log_write_ahead_size
相对于操作系统或文件系统缓存块大小将值
设置
得太低会导致“写时读”。fsync由于一次写入多个块，
将值设置得太高可能会对日志文件写入的性能产生轻微影响。
有关相关信息，请参阅
第 8.5.4 节，“优化 InnoDB 重做日志记录”。
innodb_log_writer_threads
命令行格式
--innodb-log-writer-threads[={OFF|ON}]
介绍
8.0.22
系统变量
innodb_log_writer_threads
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
ON
启用专用日志写入器线程，用于将重做日志记录从日志缓冲区写入系统缓冲区，并将系统缓冲区刷新到重做日志文件。专用日志写入线程可以在高并发系统上提高性能，但对于低并发系统，禁用专用日志写入线程可以提供更好的性能。
有关更多信息，请参阅
第 8.5.4 节，“优化 InnoDB 重做日志记录”。
innodb_lru_scan_depth
命令行格式
--innodb-lru-scan-depth=#
系统变量
innodb_lru_scan_depth
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
1024
最小值
100
最大值（64 位平台）
2**64-1
最大值（32 位平台）
2**32-1
影响缓冲池刷新操作
的算法和试探法的参数。性能专家主要对调整 I/O 密集型工作负载感兴趣。它为每个缓冲池实例指定页面清理器线程扫描缓冲池 LRU 页面列表的多远以查找要刷新的脏页面。这是每秒执行一次的后台操作。
InnoDB
小于默认值的设置通常适用于大多数工作负载。远高于必要值的值可能会影响性能。只有在典型工作负载下有备用 I/O 容量时，才考虑增加该值。相反，如果写入密集型工作负载使您的 I/O 容量饱和，请降低该值，尤其是在大型缓冲池的情况下。
调整时
innodb_lru_scan_depth，从低值开始并向上配置设置，目标是很少看到零空闲页面。此外，
innodb_lru_scan_depth在更改缓冲池实例数时考虑进行调整，因为
innodb_lru_scan_depth*
innodb_buffer_pool_instances
定义了页面清理器线程每秒执行的工作量。
有关相关信息，请参阅
第 15.8.3.5 节，“配置缓冲池刷新”。有关一般 I/O 调整建议，请参阅第 8.5.8 节，“优化 InnoDB 磁盘 I/O”。
innodb_max_dirty_pages_pct
命令行格式
--innodb-max-dirty-pages-pct=#
系统变量
innodb_max_dirty_pages_pct
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
数字
默认值
90
最小值
0
最大值
99.99
InnoDB尝试
从缓冲池中刷新数据，以
使脏页的百分比不超过此值。
该
innodb_max_dirty_pages_pct
设置建立了冲洗活动的目标。它不影响冲洗速度。有关管理刷新率的信息，请参阅
第 15.8.3.5 节，“配置缓冲池刷新”。
有关相关信息，请参阅
第 15.8.3.5 节，“配置缓冲池刷新”。有关一般 I/O 调整建议，请参阅第 8.5.8 节，“优化 InnoDB 磁盘 I/O”。
innodb_max_dirty_pages_pct_lwm
命令行格式
--innodb-max-dirty-pages-pct-lwm=#
系统变量
innodb_max_dirty_pages_pct_lwm
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
数字
默认值
10
最小值
0
最大值
99.99
定义一个低水位线，表示启用预刷新的
脏页百分比，以控制脏页比率。值为 0 将完全禁用预刷新行为。配置值应始终低于该
innodb_max_dirty_pages_pct
值。有关详细信息，请参阅
第 15.8.3.5 节，“配置缓冲池刷新”。
innodb_max_purge_lag
命令行格式
--innodb-max-purge-lag=#
系统变量
innodb_max_purge_lag
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
0
最小值
0
最大值
4294967295
定义所需的最大清除滞后。如果超过此值，则会对 、 和 操作施加延迟
INSERT，
UPDATE以便
DELETE有时间进行清除。默认值为 0，这意味着没有最大清除滞后且没有延迟。
有关详细信息，请参阅
第 15.8.9 节，“清除配置”。
innodb_max_purge_lag_delay
命令行格式
--innodb-max-purge-lag-delay=#
系统变量
innodb_max_purge_lag_delay
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
0
最小值
0
最大值
10000000
单元
毫秒
innodb_max_purge_lag
指定超过阈值
时施加的延迟的最大延迟（以微秒为单位
）。指定
innodb_max_purge_lag_delay
值是通过公式计算的延迟时间的上限
innodb_max_purge_lag。
有关详细信息，请参阅
第 15.8.9 节，“清除配置”。
innodb_max_undo_log_size
命令行格式
--innodb-max-undo-log-size=#
系统变量
innodb_max_undo_log_size
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
1073741824
最小值
10485760
最大值
2**64-1
单元
字节
定义撤消表空间的阈值大小。如果撤消表空间超过阈值，则可以在
innodb_undo_log_truncate启用时将其标记为截断。默认值为 1073741824 字节 (1024 MiB)。
有关详细信息，请参阅
截断撤消表空间。
innodb_merge_threshold_set_all_debug
命令行格式
--innodb-merge-threshold-set-all-debug=#
系统变量
innodb_merge_threshold_set_all_debug
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
50
最小值
1
最大值
50
为索引页定义一个页面已满百分比值，该值覆盖MERGE_THRESHOLD
当前在字典缓存中的所有索引的当前设置。此选项仅在使用CMake选项编译调试支持时可用。有关相关信息，请参阅
第 15.8.11 节，“为索引页配置合并阈值”。
WITH_DEBUG
innodb_monitor_disable
命令行格式
--innodb-monitor-disable={counter|module|pattern|all}
系统变量
innodb_monitor_disable
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
细绳
此变量充当开关，禁用
InnoDB
指标计数器。可以使用该
INFORMATION_SCHEMA.INNODB_METRICS
表查询计数器数据。有关使用信息，请参阅
第 15.15.6 节，“InnoDB INFORMATION_SCHEMA 指标表”。
innodb_monitor_disable='latch'
禁用 的统计信息收集
SHOW ENGINE
INNODB MUTEX。有关详细信息，请参阅
第 13.7.7.15 节，“SHOW ENGINE 语句”。
innodb_monitor_enable
命令行格式
--innodb-monitor-enable={counter|module|pattern|all}
系统变量
innodb_monitor_enable
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
细绳
此变量充当开关，启用
InnoDB
指标计数器。可以使用该
INFORMATION_SCHEMA.INNODB_METRICS
表查询计数器数据。有关使用信息，请参阅
第 15.15.6 节，“InnoDB INFORMATION_SCHEMA 指标表”。
innodb_monitor_enable='latch'
为 启用统计信息收集
SHOW ENGINE
INNODB MUTEX。有关详细信息，请参阅
第 13.7.7.15 节，“SHOW ENGINE 语句”。
innodb_monitor_reset
命令行格式
--innodb-monitor-reset={counter|module|pattern|all}
系统变量
innodb_monitor_reset
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
枚举
默认值
NULL
有效值
countermodulepatternall
此变量充当开关，将
InnoDB
指标计数器的计数值重置
为零。可以使用该
INFORMATION_SCHEMA.INNODB_METRICS
表查询计数器数据。有关使用信息，请参阅
第 15.15.6 节，“InnoDB INFORMATION_SCHEMA 指标表”。
innodb_monitor_reset='latch'
重置 报告的统计数据
SHOW ENGINE
INNODB MUTEX。有关详细信息，请参阅
第 13.7.7.15 节，“SHOW ENGINE 语句”。
innodb_monitor_reset_all
命令行格式
--innodb-monitor-reset-all={counter|module|pattern|all}
系统变量
innodb_monitor_reset_all
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
枚举
默认值
NULL
有效值
countermodulepatternall
此变量充当开关，重置InnoDB
指标计数器的所有值（最小值、最大值等） 。可以使用该
INFORMATION_SCHEMA.INNODB_METRICS
表查询计数器数据。有关使用信息，请参阅
第 15.15.6 节，“InnoDB INFORMATION_SCHEMA 指标表”。
innodb_numa_interleave
命令行格式
--innodb-numa-interleave[={OFF|ON}]
系统变量
innodb_numa_interleave
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
InnoDB为缓冲池
的分配启用 NUMA 交错内存策略。启用时
innodb_numa_interleave，NUMA 内存策略设置为
MPOL_INTERLEAVE用于
mysqld进程。分配缓冲池后
InnoDB，NUMA 内存策略设置回MPOL_DEFAULT。要使该
innodb_numa_interleave选项可用，必须在支持 NUMA 的 Linux 系统上编译 MySQL。
CMakeWITH_NUMA根据当前平台是否NUMA支持设置默认
有关详细信息，请参阅
第 2.9.7 节，“MySQL 源配置选项”。
innodb_old_blocks_pct
命令行格式
--innodb-old-blocks-pct=#
系统变量
innodb_old_blocks_pct
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
37
最小值
5
最大值
95
指定用于旧块子列表的InnoDB
缓冲池
的近似百分比
。值的范围是 5 到 95。默认值为 37（即池的 3/8）。常与 结合使用
。
innodb_old_blocks_time
有关详细信息，请参阅
第 15.8.3.3 节，“使缓冲池具有抗扫描性”。有关缓冲池管理、
LRU算法和
驱逐策略的信息，请参阅
第 15.5.1 节，“缓冲池”。
innodb_old_blocks_time
命令行格式
--innodb-old-blocks-time=#
系统变量
innodb_old_blocks_time
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
1000
最小值
0
最大值
2**32-1
单元
毫秒
非零值可防止
缓冲池被仅在短时间内引用的数据填充，例如在全表扫描期间。增加此值可以更好地防止全表扫描干扰缓冲池中缓存的数据。
指定插入旧子列表的块在第一次访问后必须保留多长时间才能移动到新子列表。如果该值为 0，则插入旧子列表的块在第一次访问时立即移动到新子列表，无论插入后多久发生访问。如果该值大于 0，块将保留在旧子列表中，直到在第一次访问后至少那么多毫秒发生访问。例如，值为 1000 会导致块在第一次访问后在旧子列表中停留 1 秒，然后才有资格移动到新子列表。
默认值为 1000。
此变量通常与 结合使用
innodb_old_blocks_pct。有关详细信息，请参阅
第 15.8.3.3 节，“使缓冲池具有抗扫描性”。有关缓冲池管理、
LRU算法和
驱逐策略的信息，请参阅
第 15.5.1 节，“缓冲池”。
innodb_online_alter_log_max_size
命令行格式
--innodb-online-alter-log-max-size=#
系统变量
innodb_online_alter_log_max_size
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
134217728
最小值
65536
最大值
2**64-1
单元
字节
指定在表的联机 DDL操作
期间使用的临时日志文件大小的上限（以字节为单位）InnoDB。每个正在创建的索引或正在更改的表都有一个这样的日志文件。此日志文件存储在 DDL 操作期间在表中插入、更新或删除的数据。临时日志文件在需要时扩展 的值
innodb_sort_buffer_size，直到 指定的最大值
innodb_online_alter_log_max_size。如果临时日志文件超过大小上限，
ALTER TABLE操作失败，所有未提交的并发 DML 操作都将回滚。因此，此选项的较大值允许在联机 DDL 操作期间发生更多 DML，但也会延长 DDL 操作结束时表被锁定以应用日志中的数据的时间段。
innodb_open_files
命令行格式
--innodb-open-files=#
系统变量
innodb_open_files
范围
全球的
动态（≥ 8.0.28）
是的
动态（≤ 8.0.27）
不
SET_VAR提示适用
不
类型
整数
默认值
-1（表示自动调整大小；不要分配此文字值）
最小值
10
最大值
2147483647
指定
InnoDB一次可以打开的最大文件数。最小值为 10。如果
innodb_file_per_table禁用，则默认值为 300；否则，默认值为 300 或
table_open_cache设置，以较高者为准。
从 MySQL 8.0.28 开始，
innodb_open_files可以在运行时使用
语句设置限制，其中是所需的
限制；例如：
SELECT
innodb_set_open_files_limit(N)Ninnodb_open_filesmysql> SELECT innodb_set_open_files_limit(1000);
该语句执行设置新限制的存储过程。如果过程成功，它返回新设置的限制值；否则，返回失败消息。
不允许
innodb_open_files使用
SET
语句设置。要
innodb_open_files在运行时设置，请使用上述
语句。
SELECT
innodb_set_open_files_limit(N)innodb_open_files=default不支持
设置
。只允许使用整数值。
从 MySQL 8.0.28 开始，为了防止非 LRU 管理文件消耗整个
innodb_open_files限制，非 LRU 管理文件被限制为限制的 90%
innodb_open_files，这为 LRU 管理文件保留了 10% 的
innodb_open_files限制。
临时表空间文件不计入
innodb_open_files从 MySQL 8.0.24 到 MySQL 8.0.27 的限制。
innodb_optimize_fulltext_only
命令行格式
--innodb-optimize-fulltext-only[={OFF|ON}]
系统变量
innodb_optimize_fulltext_only
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
改变对表的OPTIMIZE TABLE
操作方式。InnoDB旨在在
具有索引
的InnoDB表的
维护操作期间临时启用。FULLTEXT
默认情况下，OPTIMIZE TABLE
重组表的
聚集索引中的数据。启用该选项时，
跳过表数据的重组，而是处理索引OPTIMIZE TABLE的新增、删除和更新的令牌数据
。InnoDB FULLTEXT有关更多信息，请参阅优化 InnoDB 全文索引。
innodb_page_cleaners
命令行格式
--innodb-page-cleaners=#
系统变量
innodb_page_cleaners
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
整数
默认值
4
最小值
1
最大值
64
从缓冲池实例中清除脏页的页面清理器线程数。页面清理器线程执行刷新列表和 LRU 刷新。当有多个页面清理器线程时，每个缓冲池实例的缓冲池刷新任务被分派给空闲的页面清理器线程。innodb_page_cleaners默认值为 4。如果页面清理器线程数超过缓冲池实例数，
则
innodb_page_cleaners自动设置为与 相同的值
innodb_buffer_pool_instances。
如果在将脏页从缓冲池实例刷新到数据文件时您的工作负载受写 IO 限制，并且如果您的系统硬件有可用容量，则增加页面清理器线程的数量可能有助于提高写 IO 吞吐量。
多线程页面清理器支持扩展到关闭和恢复阶段。
setpriority()系统调用在支持它的 Linux 平台上使用，并且
mysqld执行用户被授权赋予
page_cleaner线程优先于其他 MySQL 和InnoDB线程以帮助页面刷新与当前工作负载保持同步。
此启动消息
setpriority()表示支持
：InnoDB[Note] InnoDB: If the mysqld execution user is authorized, page cleaner
thread priority can be changed. See the man page of setpriority().
对于服务器启停不由systemd管理的系统，可以在.mysqld中配置mysqld执行用户授权
/etc/security/limits.conf。例如，如果mysqld在用户下运行
，您可以通过将这些行添加到来
mysql授权
用户：
mysql/etc/security/limits.confmysql              hard    nice       -20
mysql              soft    nice       -20
对于 systemd 管理的系统，同样可以通过LimitNICE=-20在本地化的 systemd 配置文件中指定来实现。例如，创建一个名为
override.confin
的文件/etc/systemd/system/mysqld.service.d/override.conf
并添加以下条目：
[Service]
LimitNICE=-20
创建或更改后override.conf，重新加载 systemd 配置，然后告诉 systemd 重新启动 MySQL 服务：
systemctl daemon-reload
systemctl restart mysqld  # RPM platforms
systemctl restart mysql   # Debian platforms
有关使用本地化 systemd 配置文件的更多信息，请参阅
为 MySQL 配置 systemd。
授权mysqld执行用户后，使用cat命令验证mysqld进程
的配置Nice限制
：$> cat /proc/mysqld_pid/limits | grep nice
Max nice priority         18446744073709551596 18446744073709551596
innodb_page_size
命令行格式
--innodb-page-size=#
系统变量
innodb_page_size
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
枚举
默认值
16384
有效值
40968192163843276865536
指定表空间的页面大小
。可以字节或千字节为单位指定值。例如，16 KB 的页面大小值可以指定为 16384、16KB 或 16k。
InnoDB
innodb_page_size只能在初始化 MySQL 实例之前配置，之后不能更改。如果未指定值，则使用默认页面大小初始化实例。请参阅
第 15.8.1 节，“InnoDB 启动配置”。
对于 32KB 和 64KB 页面大小，最大行长度约为 16000 字节。
设置为 32KB 或 64KBROW_FORMAT=COMPRESSED时不支持
。innodb_page_size对于
innodb_page_size=32KB，扩展区大小为 2MB。对于
innodb_page_size=64KB，扩展区大小为 4MB。
innodb_log_buffer_size使用 32KB 或 64KB 页面大小时，应至少设置为 16M（默认值）。
默认的 16KB 页面大小或更大适用于范围广泛的工作负载，特别是涉及表扫描的查询和涉及批量更新的 DML 操作。对于涉及许多小写入的OLTP工作负载，较小的页面大小可能更有效，
当单个页面包含许多行时，争用可能成为一个问题。较小的页面对于通常使用较小块大小的SSD存储设备也可能很有效
。使
InnoDB页面大小接近存储设备块大小可以最大限度地减少重写到磁盘的未更改数据量。
第一个系统表空间数据文件 ( ibdata1)
的最小文件大小因innodb_page_size值而异。有关详细信息，请参阅innodb_data_file_path
选项说明。
使用特定InnoDB
页面大小的 MySQL 实例不能使用来自使用不同页面大小的实例的数据文件或日志文件。
有关一般 I/O 调整建议，请参阅
第 8.5.8 节，“优化 InnoDB 磁盘 I/O”。
innodb_parallel_read_threads
命令行格式
--innodb-parallel-read-threads=#
介绍
8.0.14
系统变量
innodb_parallel_read_threads
范围
会议
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
4
最小值
1
最大值
256
定义可用于并行聚集索引读取的线程数。从 MySQL 8.0.17 开始支持分区的并行扫描。并行读取线程可以提高CHECK TABLE
性能。InnoDB在操作期间读取聚集索引两次CHECK
TABLE。第二次读取可以并行执行。此功能不适用于二级索引扫描。innodb_parallel_read_threads
会话变量必须设置为大于 1 的值才能进行并行聚集索引读取。
用于执行并行聚集索引读取的实际线程数由
innodb_parallel_read_threads
设置或要扫描的索引子树的数量，以较小者为准。在扫描过程中读入缓冲池的页面被保存在缓冲池 LRU 列表的尾部，以便在需要空闲缓冲池页面时可以快速丢弃它们。
从 MySQL 8.0.17 开始，并行读取线程的最大数量 (256) 是所有客户端连接的线程总数。如果达到线程限制，连接将退回到使用单个线程。
innodb_print_all_deadlocks
命令行格式
--innodb-print-all-deadlocks[={OFF|ON}]
系统变量
innodb_print_all_deadlocks
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
启用此选项后，有关用户事务中所有
死锁的
信息InnoDB将记录在
mysqld 错误日志中。SHOW ENGINE INNODB
STATUS否则，您只能使用该命令查看有关最后一个死锁的信息。偶尔的
InnoDB死锁不一定是问题，因为InnoDB立即检测条件并自动回滚其中一个事务。如果应用程序没有适当的错误处理逻辑来检测回滚并重试其操作，您可以使用此选项来解决死锁发生的原因。大量的死锁可能表明需要重组为多个表发出
DML或SELECT ... FOR
UPDATE语句的事务，以便每个事务以相同的顺序访问表，从而避免死锁情况。
有关相关信息，请参阅
第 15.7.5 节，“InnoDB 中的死锁”。
innodb_print_ddl_logs
命令行格式
--innodb-print-ddl-logs[={OFF|ON}]
系统变量
innodb_print_ddl_logs
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
启用此选项会导致 MySQL 将 DDL 日志写入
stderr. 有关详细信息，请参阅
查看 DDL 日志。
innodb_purge_batch_size
命令行格式
--innodb-purge-batch-size=#
系统变量
innodb_purge_batch_size
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
300
最小值
1
最大值
5000
定义从历史列表
中清除一批分析和处理的撤消日志页数
。在多线程清除配置中，协调器清除线程除以
innodb_purge_batch_size该
innodb_purge_threads页数并将其分配给每个清除线程。该
innodb_purge_batch_size
变量还定义了在通过撤消日志每 128 次迭代后清除释放的撤消日志页数。
该innodb_purge_batch_size
选项旨在结合
innodb_purge_threads设置进行高级性能调整。大多数用户不需要更改
innodb_purge_batch_size其默认值。
有关相关信息，请参阅
第 15.8.9 节，“清除配置”。
innodb_purge_threads
命令行格式
--innodb-purge-threads=#
系统变量
innodb_purge_threads
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
整数
默认值
4
最小值
1
最大值
32
专用于
InnoDB
清除操作的后台线程数。增加该值会创建额外的清除线程，这可以提高
对多个表执行
DML操作的系统的效率。
有关相关信息，请参阅
第 15.8.9 节，“清除配置”。
innodb_purge_rseg_truncate_frequency
命令行格式
--innodb-purge-rseg-truncate-frequency=#
系统变量
innodb_purge_rseg_truncate_frequency
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
128
最小值
1
最大值
128
根据调用清除的次数定义清除系统释放回滚段的频率。在释放回滚段之前，无法截断撤消表空间。通常，清除系统每调用清除 128 次就会释放一次回滚段。默认值为 128。减小此值会增加清除线程释放回滚段的频率。
innodb_purge_rseg_truncate_frequency
旨在与 一起使用
innodb_undo_log_truncate。有关详细信息，请参阅
截断撤消表空间。
innodb_random_read_ahead
命令行格式
--innodb-random-read-ahead[={OFF|ON}]
系统变量
innodb_random_read_ahead
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
启用用于优化I/O
的随机
预读技术。InnoDB
有关不同类型预读请求的性能注意事项的详细信息，请参阅
第 15.8.3.4 节，“配置 InnoDB 缓冲池预取（预读）”。有关一般 I/O 调整建议，请参阅
第 8.5.8 节，“优化 InnoDB 磁盘 I/O”。
innodb_read_ahead_threshold
命令行格式
--innodb-read-ahead-threshold=#
系统变量
innodb_read_ahead_threshold
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
56
最小值
0
最大值
64
控制用于将页面预取到
缓冲
池中
的线性
预读的灵敏度。如果
从一个范围（64 页）中至少
顺序
读取页面，它会启动对整个后续范围的异步读取。允许的值范围是 0 到 64。值 0 禁用预读。对于默认值 56，
必须从一个盘区连续读取至少 56 页才能启动对后续盘区的异步读取。
InnoDBInnoDBinnodb_read_ahead_thresholdInnoDB
了解通过预读机制读取了多少页，以及其中有多少页在未访问的情况下从缓冲池中逐出，在微调
innodb_read_ahead_threshold
设置时非常有用。
输出显示来自和
全局状态变量SHOW
ENGINE INNODB STATUS的计数器信息
，它们分别报告预读请求
带入缓冲池的页数，以及从缓冲池中逐出而从未被访问的页数。状态变量报告自上次服务器重新启动以来的全局值。
Innodb_buffer_pool_read_aheadInnodb_buffer_pool_read_ahead_evicted
SHOW ENGINE
INNODB STATUS还显示了读取预读页面的速率以及此类页面在未被访问的情况下被逐出的速率。每秒平均值基于自上次调用以来收集的统计数据，
SHOW ENGINE INNODB STATUS并显示在输出
BUFFER POOL AND MEMORY部分。SHOW ENGINE
INNODB STATUS
有关更多信息，请参阅
第 15.8.3.4 节，“配置 InnoDB 缓冲池预取（预读）”。有关一般 I/O 调整建议，请参阅
第 8.5.8 节，“优化 InnoDB 磁盘 I/O”。
innodb_read_io_threads
命令行格式
--innodb-read-io-threads=#
系统变量
innodb_read_io_threads
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
整数
默认值
4
最小值
1
最大值
64
中读取操​​作的 I/O 线程数
InnoDB。其对应的写线程是innodb_write_io_threads. 有关更多信息，请参阅
第 15.8.5 节，“配置后台 InnoDB I/O 线程的数量”。有关一般 I/O 调整建议，请参阅
第 8.5.8 节，“优化 InnoDB 磁盘 I/O”。
笔记
innodb_read_io_threads在 Linux 系统上，
使用innodb_write_io_threads、 和 Linux 设置的
默认设置运行多个 MySQL 服务器（通常超过 12 个）
aio-max-nr可能会超出系统限制。理想情况下，增加
aio-max-nr设置；作为解决方法，您可以减少一个或两个 MySQL 变量的设置。
innodb_read_only
命令行格式
--innodb-read-only[={OFF|ON}]
系统变量
innodb_read_only
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
InnoDB以只读模式
启动。用于在只读介质上分发数据库应用程序或数据集。也可以用在数据仓库中，在多个实例之间共享同一个数据目录。有关更多信息，请参阅第 15.8.2 节，“为只读操作配置 InnoDB”。
以前，启用
系统变量会阻止仅为存储引擎innodb_read_only创建和删除表
。InnoDB从 MySQL 8.0 开始，启用会
innodb_read_only阻止所有存储引擎的这些操作。任何存储引擎的建表和删除操作都会修改mysql系统数据库中的数据字典表，但这些表使用存储引擎并且在启用InnoDB时无法修改
。innodb_read_only同样的原理也适用于其他需要修改数据字典表的表操作。例子：
如果innodb_read_only
启用了系统变量，ANALYZE
TABLE可能会失败，因为它无法更新数据字典中使用
InnoDB. 对于
ANALYZE TABLE更新键分布的操作，即使操作更新表本身（例如，如果它是一个MyISAM表）也可能会失败。要获取更新的分布统计信息，请设置
information_schema_stats_expiry=0.
ALTER TABLE
tbl_name
ENGINE=engine_name
失败，因为它更新了存储在数据字典中的存储引擎名称。
另外，mysql
系统数据库中的其他表使用了InnoDBMySQL 8.0中的存储引擎。将这些表设置为只读会导致对修改它们的操作的限制。例子：
诸如
CREATE USER和
之类的帐户管理语句GRANT失败，因为授权表使用InnoDB.
和
插件管理语句失败，因为
INSTALL PLUGIN系统
表使用
.
UNINSTALL PLUGINmysql.pluginInnoDB
和
CREATE
FUNCTION可
DROP
FUNCTION加载函数管理语句失败，因为mysql.func系统表使用InnoDB.
innodb_redo_log_archive_dirs
命令行格式
--innodb-redo-log-archive-dirs
介绍
8.0.17
系统变量
innodb_redo_log_archive_dirs
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
细绳
默认值
NULL
定义可以创建重做日志存档文件的标记目录。您可以在以分号分隔的列表中定义多个带标签的目录。例如：
innodb_redo_log_archive_dirs='label1:/backups1;label2:/backups2'
标签可以是任何字符串，但不允许使用冒号 (:)。也允许使用空标签，但在这种情况下仍需要冒号 (:)。
必须指定路径，并且目录必须存在。路径可以包含冒号 (':')，但不允许包含分号 (;)。
innodb_redo_log_capacity
命令行格式
--innodb-redo-log-capacity=#
介绍
8.0.30
系统变量
innodb_redo_log_capacity
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
104857600
最小值
8388608
最大值
137438953472
单元
字节
定义重做日志文件占用的磁盘空间量。
此变量取代
innodb_log_files_in_group和
innodb_log_file_size
变量。innodb_redo_log_capacity
定义
设置时，将忽略innodb_log_files_in_group和
设置；innodb_log_file_size否则，这些设置用于计算
innodb_redo_log_capacity
设置 ( innodb_log_files_in_group*
innodb_log_file_size=
innodb_redo_log_capacity)。如果没有设置这些变量，重做日志容量将设置为
innodb_redo_log_capacity默认值。
有关详细信息，请参阅第 15.6.5 节，“重做日志”。
innodb_redo_log_encrypt
命令行格式
--innodb-redo-log-encrypt[={OFF|ON}]
系统变量
innodb_redo_log_encrypt
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
InnoDB
控制使用静态数据加密功能
加密的表的重做日志数据的加密。默认情况下禁用重做日志数据的加密。有关详细信息，请参阅
重做日志加密。
innodb_replication_delay
命令行格式
--innodb-replication-delay=#
系统变量
innodb_replication_delay
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
0
最小值
0
最大值
4294967295
单元
毫秒
innodb_thread_concurrency如果达到
副本服务器上的复制线程延迟（以毫秒为单位
）。
innodb_rollback_on_timeout
命令行格式
--innodb-rollback-on-timeout[={OFF|ON}]
系统变量
innodb_rollback_on_timeout
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
InnoDB 默认情况下只回滚事务超时的最后一条语句。如果
--innodb-rollback-on-timeout指定，事务超时会导致
InnoDB中止并回滚整个事务。
有关更多信息，请参阅
第 15.21.5 节，“InnoDB 错误处理”。
innodb_rollback_segments
命令行格式
--innodb-rollback-segments=#
系统变量
innodb_rollback_segments
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
128
最小值
1
最大值
128
innodb_rollback_segments
定义分配给每个撤消表空间的
回滚段数
和生成撤消记录的事务的全局临时表空间。每个回滚段支持的事务数取决于InnoDB页面大小和分配给每个事务的撤消日志数。有关详细信息，请参阅第 15.6.6 节，“撤消日志”。
有关相关信息，请参阅
第 15.3 节，“InnoDB 多版本控制”。有关撤消表空间的信息，请参阅
第 15.6.3.4 节，“撤消表空间”。
innodb_saved_page_number_debug
命令行格式
--innodb-saved-page-number-debug=#
系统变量
innodb_saved_page_number_debug
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
0
最小值
0
最大值
2**23-1
保存页码。设置该
innodb_fil_make_page_dirty_debug
选项会弄脏由 定义的页面
innodb_saved_page_number_debug。innodb_saved_page_number_debug
只有在使用CMake选项编译调试支持时，该
选项才可用。
WITH_DEBUG
innodb_segment_reserve_factor
命令行格式
--innodb-segment-reserve-factor=#
介绍
8.0.26
系统变量
innodb_segment_reserve_factor
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
数字
默认值
12.5
最小值
0.03
最大值
40
定义保留为空页的表空间文件段页的百分比。该设置适用于 file-per-table 和通用表空间。默认设置为 12.5%，与
innodb_segment_reserve_factor
以前的 MySQL 版本中保留的页面百分比相同。
有关详细信息，请参阅
配置保留文件段页面的百分比。
innodb_sort_buffer_size
命令行格式
--innodb-sort-buffer-size=#
系统变量
innodb_sort_buffer_size
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
整数
默认值
1048576
最小值
65536
最大值
67108864
单元
字节
该变量定义：
创建或重建二级索引的在线 DDL 操作的排序缓冲区大小。但是，从 MySQL 8.0.27 开始，此职责由
innodb_ddl_buffer_size
变量承担。
在线DDL操作
记录并发DML时临时日志文件的扩展量
，以及临时日志文件读缓冲区和写缓冲区的大小。
有关相关信息，请参阅
第 15.12.3 节，“在线 DDL 空间要求”。
innodb_spin_wait_delay
命令行格式
--innodb-spin-wait-delay=#
系统变量
innodb_spin_wait_delay
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
6
最小值
0
最大值（64 位平台，≤ 8.0.13）
2**64-1
最大值（32 位平台，≤ 8.0.13）
2**32-1
最大值 (≥ 8.0.14)
1000
自旋锁
轮询之间的最大延迟
。该机制的底层实现因硬件和操作系统的组合而异，因此延迟不对应固定的时间间隔。
可以与
innodb_spin_wait_pause_multiplier
变量结合使用，以更好地控制自旋锁轮询延迟的持续时间。
有关详细信息，请参阅
第 15.8.8 节，“配置自旋锁轮询”。
innodb_spin_wait_pause_multiplier
命令行格式
--innodb-spin-wait-pause-multiplier=#
介绍
8.0.16
系统变量
innodb_spin_wait_pause_multiplier
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
50
最小值
1
最大值
100
定义一个乘数值，用于确定在线程等待获取互斥锁或读写锁时发生的自旋等待循环中的 PAUSE 指令数。
有关详细信息，请参阅
第 15.8.8 节，“配置自旋锁轮询”。
innodb_stats_auto_recalc
命令行格式
--innodb-stats-auto-recalc[={OFF|ON}]
系统变量
innodb_stats_auto_recalc
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
ON
导致在表中的数据发生实质性更改后InnoDB自动重新计算
持久统计信息。阈值是表中行的 10%。此设置适用于
innodb_stats_persistent
启用该选项时创建的表。也可以通过
STATS_PERSISTENT=1在
CREATE TABLEor
ALTER TABLE语句中指定来配置自动统计重新计算。用于生成统计数据的采样数据量由
innodb_stats_persistent_sample_pages
变量控制。
有关详细信息，请参阅
第 15.8.10.1 节，“配置持久优化器统计参数”。
innodb_stats_include_delete_marked
命令行格式
--innodb-stats-include-delete-marked[={OFF|ON}]
系统变量
innodb_stats_include_delete_marked
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
默认情况下，InnoDB在计算统计信息时读取未提交的数据。在从表中删除行的未提交事务的情况下，
InnoDB在计算行估计和索引统计信息时排除被删除标记的记录，这可能导致同时使用表操作的其他事务的非最佳执行计划以外的事务隔离级别
READ UNCOMMITTED。为避免这种情况，
innodb_stats_include_delete_marked
可以启用以确保InnoDB
在计算持久优化器统计信息时包括删除标记的记录。
innodb_stats_include_delete_marked
启用时，
在
ANALYZE TABLE
重新计算统计信息时考虑删除标记的记录。
innodb_stats_include_delete_marked
是影响所有InnoDB
表的全局设置。它仅适用于持久优化器统计信息。
有关相关信息，请参阅
第 15.8.10.1 节，“配置持久优化器统计参数”。
innodb_stats_method
命令行格式
--innodb-stats-method=value
系统变量
innodb_stats_method
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
枚举
默认值
nulls_equal
有效值
nulls_equalnulls_unequalnulls_ignored
服务器NULL在收集有关表
的索引值分布的
统计InnoDB信息时如何处理值。允许的值为
nulls_equal、
nulls_unequal和
nulls_ignored。对于
nulls_equal，所有NULL
索引值都被认为是相等的，并形成一个大小等于值数的
NULL值组。对于
nulls_unequal，NULL
值被认为是不相等的，并且每个
NULL值形成一个大小为 1 的不同值组。对于nulls_ignored，
NULL值被忽略。
用于生成表统计信息的方法会影响优化器如何为查询执行选择索引，如第 8.3.8 节，“InnoDB 和 MyISAM 索引统计信息收集”中所述。
innodb_stats_on_metadata
命令行格式
--innodb-stats-on-metadata[={OFF|ON}]
系统变量
innodb_stats_on_metadata
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
此选项仅在优化器
统计信息配置为非持久性时适用。innodb_stats_persistent禁用时或使用创建或更改单个表
时，优化器统计信息不会持久保存到磁盘
STATS_PERSISTENT=0。有关详细信息，请参阅第 15.8.10.2 节，“配置非持久性优化器统计参数”。
innodb_stats_on_metadata
启用时，
在元数据语句（例如访问
或
表时）InnoDB更新非持久
统计信息。（这些更新类似于 发生的情况
。）禁用时，
不会在这些操作期间更新统计信息。禁用该设置可以提高具有大量表或索引的模式的访问速度。它还可以提高
涉及
表
的查询的执行计划的稳定性。SHOW TABLE
STATUSINFORMATION_SCHEMA.TABLESINFORMATION_SCHEMA.STATISTICSANALYZE TABLEInnoDBInnoDB
要更改设置，请发出语句，其中是or （或
or ）。更改设置需要足够的权限来设置全局系统变量（请参阅第 5.1.9.1 节，“系统变量权限”）并立即影响所有连接的操作。
SET GLOBAL
innodb_stats_on_metadata=modemodeONOFF10
innodb_stats_persistent
命令行格式
--innodb-stats-persistent[={OFF|ON}]
系统变量
innodb_stats_persistent
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
ON
指定InnoDB索引统计信息是否持久保存到磁盘。否则，可能会频繁地重新计算统计信息，从而导致
查询执行计划发生变化。创建表时，此设置与每个表一起存储。您可以
innodb_stats_persistent在创建表之前在全局级别设置，或者使用
and
语句的STATS_PERSISTENT子句
覆盖系统范围的设置并为单个表配置持久统计信息。
CREATE TABLEALTER TABLE
有关详细信息，请参阅
第 15.8.10.1 节，“配置持久优化器统计参数”。
innodb_stats_persistent_sample_pages
命令行格式
--innodb-stats-persistent-sample-pages=#
系统变量
innodb_stats_persistent_sample_pages
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
20
最小值
1
最大值
18446744073709551615
估计索引列的基数和其他
统计信息时要采样
的索引页数，例如由 计算的那些
。增加该值可以提高索引统计的准确性，这可以改进查询执行计划，但代价是在执行表时增加 I/
O 。有关详细信息，请参阅第 15.8.10.1 节，“配置持久优化器统计参数”。
ANALYZE TABLEANALYZE TABLEInnoDB
笔记
为 设置高值
innodb_stats_persistent_sample_pages
可能会导致ANALYZE
TABLE执行时间过长。要估计访问的数据库页面数ANALYZE
TABLE，请参阅
第 15.8.10.3 节，“估计 InnoDB 表的分析表复杂性”。
innodb_stats_persistent_sample_pages
仅在
innodb_stats_persistent为表启用时适用；当
innodb_stats_persistent被禁用时，
innodb_stats_transient_sample_pages
改为应用。
innodb_stats_transient_sample_pages
命令行格式
--innodb-stats-transient-sample-pages=#
系统变量
innodb_stats_transient_sample_pages
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
8
最小值
1
最大值
18446744073709551615
估计索引列的基数和其他
统计信息时要采样
的索引页数，例如由 计算的那些
。默认值为 8。增加该值可以提高索引统计的准确性，这可以改进
查询执行计划，但代价是在打开
表或重新计算统计时增加 I/O。有关详细信息，请参阅
第 15.8.10.2 节，“配置非持久性优化器统计参数”。
ANALYZE TABLEInnoDB
笔记
为 设置高值
innodb_stats_transient_sample_pages
可能会导致ANALYZE
TABLE执行时间过长。要估计访问的数据库页面数ANALYZE
TABLE，请参阅
第 15.8.10.3 节，“估计 InnoDB 表的分析表复杂性”。
innodb_stats_transient_sample_pages
仅在
innodb_stats_persistent对表禁用时适用；innodb_stats_persistent启用
时
，innodb_stats_persistent_sample_pages
改为应用。代替
innodb_stats_sample_pages. 有关详细信息，请参阅
第 15.8.10.2 节，“配置非持久性优化器统计参数”。
innodb_status_output
命令行格式
--innodb-status-output[={OFF|ON}]
系统变量
innodb_status_output
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
启用或禁用标准
InnoDB监视器的定期输出。还与 结合使用
innodb_status_output_locks以启用或禁用
InnoDB锁定监视器的定期输出。有关详细信息，请参阅第 15.17.2 节，“启用 InnoDB 监视器”。
innodb_status_output_locks
命令行格式
--innodb-status-output-locks[={OFF|ON}]
系统变量
innodb_status_output_locks
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
启用或禁用InnoDB锁定监视器。启用后，InnoDB锁定监视器会在
SHOW ENGINE INNODB STATUS输出中打印有关锁定的附加信息，并在定期输出中打印到 MySQL 错误日志。InnoDB锁定监视器的定期输出作为标准InnoDB
监视器输出的一部分打印。InnoDB因此，必须为 Lock Monitor 启用标准MonitorInnoDB
以定期将数据打印到 MySQL 错误日志。有关详细信息，请参阅
第 15.17.2 节，“启用 InnoDB 监视器”。
innodb_strict_mode
命令行格式
--innodb-strict-mode[={OFF|ON}]
系统变量
innodb_strict_mode
范围
全局，会话
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
ON
innodb_strict_mode启用时，
在InnoDB检查无效或不兼容的表选项时返回错误而不是警告。
它检查 、KEY_BLOCK_SIZE、
ROW_FORMAT、DATA
DIRECTORY和TEMPORARY选项
TABLESPACE是否相互兼容以及是否与其他设置兼容。
innodb_strict_mode=ON还可以在创建或更改表时启用行大小检查，以防止
INSERT或UPDATE由于记录对于所选页面大小来说太大而失败。
innodb_strict_mode您可以在启动时在命令行上mysqld或在 MySQL配置文件
中启用或禁用
。您还可以
innodb_strict_mode在运行时使用语句启用或禁用，其中is either or 。更改设置需要足够的权限来设置全局系统变量（请参阅
第 5.1.9.1 节，“系统变量权限”）并影响随后连接的所有客户端的操作。任何客户端都可以更改 的设置
，并且该设置仅影响该客户端。
SET [GLOBAL|SESSION]
innodb_strict_mode=modemodeONOFFGLOBALSESSIONinnodb_strict_mode
从 MySQL 8.0.26 开始，设置这个系统变量的会话值是一个受限操作。会话用户必须具有足以设置受限会话变量的权限。请参阅
第 5.1.9.1 节，“系统变量权限”。
innodb_sync_array_size
命令行格式
--innodb-sync-array-size=#
系统变量
innodb_sync_array_size
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
整数
默认值
1
最小值
1
最大值
1024
定义互斥锁/锁等待数组的大小。增加该值会拆分用于协调线程的内部数据结构，以便在具有大量等待线程的工作负载中实现更高的并发性。此设置必须在 MySQL 实例启动时配置，之后无法更改。对于经常产生大量等待线程（通常大于 768）的工作负载，建议增加该值。
innodb_sync_spin_loops
命令行格式
--innodb-sync-spin-loops=#
系统变量
innodb_sync_spin_loops
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
30
最小值
0
最大值
4294967295
InnoDB线程挂起之前
等待释放互斥锁的次数
。
innodb_sync_debug
命令行格式
--innodb-sync-debug[={OFF|ON}]
系统变量
innodb_sync_debug
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
InnoDB
为存储引擎
启用同步调试检查。此选项仅在使用
CMake选项编译调试支持时可用。
WITH_DEBUG
innodb_table_locks
命令行格式
--innodb-table-locks[={OFF|ON}]
系统变量
innodb_table_locks
范围
全局，会话
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
ON
如果autocommit = 0，
InnoDB荣誉LOCK
TABLES；LOCK
TABLES ... WRITE直到所有其他线程都释放了对表的所有锁后，MySQL 才会返回。的默认值为
innodb_table_locks1，这意味着如果 ，则LOCK TABLES
导致 InnoDB 在内部锁定表
autocommit = 0。
innodb_table_locks = 0对使用 显式锁定的表没有影响
LOCK TABLES ...
WRITE。LOCK TABLES ...
WRITE它确实对通过隐式（例如，通过触发器）或通过锁定以供读取或写入的表有影响
LOCK TABLES
... READ。
有关相关信息，请参阅
第 15.7 节，“InnoDB 锁定和事务模型”。
innodb_temp_data_file_path
命令行格式
--innodb-temp-data-file-path=file_name
系统变量
innodb_temp_data_file_path
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
细绳
默认值
ibtmp1:12M:autoextend
定义全局临时表空间数据文件的相对路径、名称、大小和属性。全局临时表空间存储回滚段，用于对用户创建的临时表所做的更改。
如果没有为 指定值
，则默认行为是创建一个在
目录中innodb_temp_data_file_path命名的单个自动扩展数据文件
。初始文件大小略大于 12MB。
ibtmp1innodb_data_home_dir
全局临时表空间数据文件规范的语法包括文件名、文件大小
autoextend和max
属性：
file_name:file_size[:autoextend[:max:max_file_size]]
全局临时表空间数据文件不能与另一个InnoDB数据文件同名。创建全局临时表空间数据文件的任何无能或错误都被视为致命的，并且服务器启动被拒绝。
K通过将,M或
附加G到大小值
，以 KB、MB 或 GB 为单位指定文件大小
。文件大小总和必须略大于 12MB。
单个文件的大小限制由操作系统决定。在支持大文件的操作系统上，文件大小可以超过 4GB。不支持对全局临时表空间数据文件使用原始磁盘分区。
和
属性只能用于设置中最后指定的数据
autoextend文件
。例如：
maxinnodb_temp_data_file_path[mysqld]
innodb_temp_data_file_path=ibtmp1:50M;ibtmp2:12M:autoextend:max:500M
该autoextend选项会导致数据文件在可用空间不足时自动增加大小。autoextend默认增量为 64MB 。要修改增量，请更改
innodb_autoextend_increment
变量设置。
全局临时表空间数据文件的目录路径是通过连接 和 定义的路径形成
innodb_data_home_dir的
innodb_temp_data_file_path。
InnoDB在以只读模式
运行之前，设置innodb_temp_data_file_path为数据目录之外的位置。该路径必须相对于数据目录。例如：
--innodb-temp-data-file-path=../../../tmp/ibtmp1:12M:autoextend
有关详细信息，请参阅
全局临时表空间。
innodb_temp_tablespaces_dir
命令行格式
--innodb-temp-tablespaces-dir=dir_name
介绍
8.0.13
系统变量
innodb_temp_tablespaces_dir
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
目录名称
默认值
#innodb_temp
InnoDB定义在启动时创建会话临时表空间池
的位置。默认位置是#innodb_temp数据目录中的目录。允许使用完全限定路径或相对于数据目录的路径。
从 MySQL 8.0.16 开始，会话临时表空间始终存储用户创建的临时表和优化器使用InnoDB. （以前，内部临时表的磁盘存储引擎由
internal_tmp_disk_storage_engine
系统变量确定，不再支持。请参阅
磁盘内部临时表的存储引擎。）
有关详细信息，请参阅
会话临时表空间。
innodb_thread_concurrency
命令行格式
--innodb-thread-concurrency=#
系统变量
innodb_thread_concurrency
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
0
最小值
0
最大值
1000
定义内部允许的最大线程数
InnoDB。值 0（默认值）被解释为无限并发（无限制）。该变量用于在高并发系统上进行性能调优。
InnoDB试图保持内部线程数InnoDB小于或等于
innodb_thread_concurrency
限制。一旦达到限制，额外的线程将被放入“先进先出” (FIFO) 队列中等待线程。等待锁的线程不计入并发执行线程数。
正确的设置取决于工作负载和计算环境。如果您的 MySQL 实例与其他应用程序共享 CPU 资源，或者如果您的工作负载或并发用户数在增长，请考虑设置此变量。测试一系列值以确定提供最佳性能的设置。
innodb_thread_concurrency是一个动态变量，它允许在实时测试系统上试验不同的设置。如果某个特定设置表现不佳，您可以快速设置
innodb_thread_concurrency
回 0。
使用以下准则来帮助查找和维护适当的设置：
如果工作负载的并发用户线程数一直很小并且不影响性能，则设置
innodb_thread_concurrency=0
（无限制）。
如果您的工作负载一直很重或偶尔会出现峰值，请设置一个
innodb_thread_concurrency
值并对其进行调整，直到找到可提供最佳性能的线程数。例如，假设您的系统通常有 40 到 50 个用户，但这个数字会定期增加到 60、70 或更多。通过测试，你发现在80个并发用户的限制下，性能基本保持稳定。在这种情况下，设置
innodb_thread_concurrency
为 80。
如果您不想InnoDB为用户线程使用超过一定数量的虚拟 CPU（例如 20 个虚拟 CPU），请设置
innodb_thread_concurrency
为该数量（或可能更低，具体取决于性能测试）。mysqld如果您的目标是将 MySQL 与其他应用程序隔离开来，请考虑将进程专门绑定
到虚拟 CPU。但是请注意，如果
mysqld进程不是一直很忙，独占绑定可能会导致硬件使用不佳。在这种情况下，您可以将
mysqld进程绑定到虚拟 CPU，但允许其他应用程序使用部分或全部虚拟 CPU。
笔记
从操作系统的角度来看，使用资源管理解决方案来管理如何在应用程序之间共享 CPU 时间可能比绑定
mysqld进程更可取。例如，您可以在其他关键进程未运行时将 90% 的虚拟 CPU 时间分配给给定应用程序，并在其他关键进程运行时将该值缩减为 40%
。
在某些情况下，最佳
innodb_thread_concurrency
设置可能小于虚拟 CPU 的数量。
innodb_thread_concurrency
由于对系统内部和资源的争用增加，太高
的
值可能会导致性能下降。
定期监控和分析您的系统。工作负载、用户数量或计算环境的更改可能需要您调整
innodb_thread_concurrency
设置。
值为 0 将禁用输出
部分中
的queries inside
InnoDB和queries in queue
计数器。ROW OPERATIONSSHOW ENGINE INNODB STATUS
有关相关信息，请参阅
第 15.8.4 节，“为 InnoDB 配置线程并发”。
innodb_thread_sleep_delay
命令行格式
--innodb-thread-sleep-delay=#
系统变量
innodb_thread_sleep_delay
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
10000
最小值
0
最大值
1000000
单元
微秒
InnoDB线程在加入InnoDB队列之前休眠
多长时间，以微秒为单位。默认值为 10000。值为 0 将禁用睡眠。您可以设置
innodb_adaptive_max_sleep_delay
为允许的最高值
innodb_thread_sleep_delay，并根据当前线程调度活动InnoDB自动向上或向下调整
。innodb_thread_sleep_delay这种动态调整有助于线程调度机制在系统负载较轻或接近满负荷运行时平稳工作。
有关详细信息，请参阅
第 15.8.4 节，“为 InnoDB 配置线程并发”。
innodb_tmpdir
命令行格式
--innodb-tmpdir=dir_name
系统变量
innodb_tmpdir
范围
全局，会话
动态的
是的
SET_VAR提示适用
不
类型
目录名称
默认值
NULL
用于为ALTER
TABLE重建表的联机操作期间创建的临时排序文件定义备用目录。
重建表的联机ALTER TABLE操作还会
在与原始表相同的目录中创建一个中间表文件。该
innodb_tmpdir选项不适用于中间表文件。
有效值是 MySQL 数据目录路径以外的任何目录路径。如果该值为 NULL（默认值），临时文件将创建 MySQL 临时目录（$TMPDIR在 Unix 上，在 Windows 上，或配置选项%TEMP%
指定的目录
）。--tmpdir如果指定目录，则仅在
innodb_tmpdir使用
SET
语句配置时检查目录和权限的存在。如果在目录字符串中提供符号链接，则符号链接将被解析并存储为绝对路径。路径不应超过 512 字节。如果在线
ALTER TABLE操作报告错误innodb_tmpdir设置为无效目录。
innodb_tmpdir覆盖 MySQLtmpdir设置，但仅用于在线ALTER TABLE
操作。
配置FILE需要权限
innodb_tmpdir。
引入该innodb_tmpdir选项是为了帮助避免溢出位于tmpfs文件系统上的临时文件目录。此类溢出可能是在ALTER
TABLE重建表的联机操作期间创建的大型临时排序文件的结果。
在复制环境中，仅
innodb_tmpdir当所有服务器都具有相同的操作系统环境时才考虑复制设置。否则，复制innodb_tmpdir
设置可能会导致在运行ALTER TABLE重建表的联机操作时复制失败。如果服务器运行环境不同，建议您
innodb_tmpdir在每台服务器上单独配置。
有关详细信息，请参阅
第 15.12.3 节，“在线 DDL 空间要求”。有关在线ALTER
TABLE操作的信息，请参阅
第 15.12 节，“InnoDB 和在线 DDL”。
innodb_trx_purge_view_update_only_debug
命令行格式
--innodb-trx-purge-view-update-only-debug[={OFF|ON}]
系统变量
innodb_trx_purge_view_update_only_debug
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
暂停清除标记为删除的记录，同时允许更新清除视图。此选项人为地创建了清除视图已更新但尚未执行清除的情况。此选项仅在使用
CMake选项编译调试支持时可用。
WITH_DEBUG
innodb_trx_rseg_n_slots_debug
命令行格式
--innodb-trx-rseg-n-slots-debug=#
系统变量
innodb_trx_rseg_n_slots_debug
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
0
最小值
0
最大值
1024
设置一个调试标志，该标志限制
为为撤消日志段寻找空闲槽TRX_RSEG_N_SLOTS的函数的给定值
。trx_rsegf_undo_find_free此选项仅在使用
CMake选项编译调试支持时可用。
WITH_DEBUG
innodb_undo_directory
命令行格式
--innodb-undo-directory=dir_name
系统变量
innodb_undo_directory
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
目录名称
InnoDB创建撤消表空间
的路径。通常用于将撤消表空间放置在不同的存储设备上。
没有默认值（它是 NULL）。如果
innodb_undo_directory
变量未定义，则在数据目录中创建撤消表空间。
初始化 MySQL 实例时创建的默认撤消表空间（innodb_undo_001和
innodb_undo_002）始终驻留在innodb_undo_directory
变量定义的目录中。
如果未指定不同的路径，则
使用CREATE UNDO
TABLESPACE语法创建的
撤消表空间将
在变量定义的目录中创建。innodb_undo_directory
有关详细信息，请参阅
第 15.6.3.4 节，“撤消表空间”。
innodb_undo_log_encrypt
命令行格式
--innodb-undo-log-encrypt[={OFF|ON}]
系统变量
innodb_undo_log_encrypt
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
InnoDB
控制使用静态数据加密功能
加密的表的撤消日志数据的加密。仅适用于驻留在单独的撤消表空间中的撤消日志。请参阅
第 15.6.3.4 节，“撤消表空间”。驻留在系统表空间中的撤消日志数据不支持加密。有关详细信息，请参阅
撤消日志加密。
innodb_undo_log_truncate
命令行格式
--innodb-undo-log-truncate[={OFF|ON}]
系统变量
innodb_undo_log_truncate
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
ON
启用后，超过定义的阈值的撤消表空间将
innodb_max_undo_log_size被标记为截断。只能截断撤消表空间。不支持截断驻留在系统表空间中的撤消日志。要发生截断，必须至少有两个撤消表空间。
该
innodb_purge_rseg_truncate_frequency
变量可用于加快撤消表空间的截断。
有关详细信息，请参阅
截断撤消表空间。
innodb_undo_tablespaces
命令行格式
--innodb-undo-tablespaces=#
弃用
是的
系统变量
innodb_undo_tablespaces
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
2
最小值
2
最大值
127
定义 所
使用的撤消表空间InnoDB的数量。默认和最小值为 2。
笔记
从 MySQL 8.0.14 开始，该innodb_undo_tablespaces
变量已弃用并且不再可配置。预计它会在未来的版本中被删除。
有关详细信息，请参阅
第 15.6.3.4 节，“撤消表空间”。
innodb_use_fdatasync
命令行格式
--innodb-use-fdatasync[={OFF|ON}]
介绍
8.0.26
系统变量
innodb_use_fdatasync
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
在支持fdatasync()
系统调用的平台上，启用
innodb_use_fdatasync变量允许使用fdatasync()而不是
fsync()系统调用来进行操作系统刷新。除非fdatasync()后续数据检索需要，否则调用不会刷新对文件元数据的更改，从而提供潜在的性能优势。
设置的子集，
innodb_flush_method例如fsync、O_DSYNC和O_DIRECTusefsync()
系统调用。该
innodb_use_fdatasync变量在使用这些设置时适用。
innodb_use_native_aio
命令行格式
--innodb-use-native-aio[={OFF|ON}]
系统变量
innodb_use_native_aio
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
布尔值
默认值
ON
指定是否使用 Linux 异步 I/O 子系统。此变量仅适用于 Linux 系统，并且在服务器运行时无法更改。通常情况下，您不需要配置此选项，因为它默认处于启用状态。
在 Windows 系统上具有的异步 I/O功能InnoDB在 Linux 系统上可用。（其他类 Unix 系统继续使用同步 I/O 调用。）此功能提高了严重 I/O 绑定系统的可扩展性，这些系统通常在
SHOW ENGINE INNODB STATUS\G输出中显示许多挂起的读/写。
运行大量InnoDBI/O 线程，尤其是在同一台服务器上运行多个此类实例，可能会超出 Linux 系统的容量限制。在这种情况下，您可能会收到以下错误：
EAGAIN: The specified maxevents exceeds the user's limit of available events.
您通常可以通过将更高的限制写入 来解决此错误/proc/sys/fs/aio-max-nr。
但是，如果操作系统中的异步 I/O 子系统出现问题而无法InnoDB启动，您可以使用 启动服务器
innodb_use_native_aio=0。InnoDB如果检测到潜在问题（例如tmpdir位置、
tmpfs文件系统和不支持 AIO on 的 Linux 内核的组合），此选项也可能在启动期间自动禁用
tmpfs。
有关详细信息，请参阅
第 15.8.6 节，“在 Linux 上使用异步 I/O”。
innodb_validate_tablespace_paths
命令行格式
--innodb-validate-tablespace-paths[={OFF|ON}]
介绍
8.0.21
系统变量
innodb_validate_tablespace_paths
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
布尔值
默认值
ON
控制表空间文件路径验证。在启动时，
InnoDB根据存储在数据字典中的表空间文件路径验证已知表空间文件的路径，以防表空间文件已移动到其他位置。该
innodb_validate_tablespace_paths
变量允许禁用表空间路径验证。此功能适用于不移动表空间文件的环境。禁用路径验证可以缩短具有大量表空间文件的系统的启动时间。
警告
在移动表空间文件后启动禁用表空间路径验证的服务器可能会导致未定义的行为。
有关详细信息，请参阅
第 15.6.3.7 节，“禁用表空间路径验证”。
innodb_version
InnoDB版本号
。在 MySQL 8.0 中，
InnoDB不适用单独的版本编号，该值与version服务器编号相同。
innodb_write_io_threads
命令行格式
--innodb-write-io-threads=#
系统变量
innodb_write_io_threads
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
整数
默认值
4
最小值
1
最大值
64
中写入操作的 I/O 线程数
InnoDB。默认值为 4。读取线程对应的是
innodb_read_io_threads. 有关更多信息，请参阅
第 15.8.5 节，“配置后台 InnoDB I/O 线程的数量”。有关一般 I/O 调整建议，请参阅
第 8.5.8 节，“优化 InnoDB 磁盘 I/O”。
笔记
innodb_read_io_threads在 Linux 系统上，
使用innodb_write_io_threads、 和 Linux 设置的
默认设置运行多个 MySQL 服务器（通常超过 12 个）
aio-max-nr可能会超出系统限制。理想情况下，增加
aio-max-nr设置；作为解决方法，您可以减少一个或两个 MySQL 变量的设置。
还要考虑 的值
sync_binlog，它控制二进制日志到磁盘的同步。
有关一般 I/O 调整建议，请参阅
第 8.5.8 节，“优化 InnoDB 磁盘 I/O”。
© Mysql 中文网
