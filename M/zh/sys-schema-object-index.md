# 28.4.1 sys 架构对象索引_MySQL 8.0 参考手册

28.4.1 sys 架构对象索引_MySQL 8.0 参考手册
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
第 28 章 MySQL 系统模式
28.1 使用 sys 模式的先决条件
28.2 使用系统模式
28.3 sys Schema 进度报告
28.4 sys 模式对象参考
28.4.1 sys 架构对象索引1
28.4.2 sys 模式表和触发器1
28.4.3 sys 架构视图1
28.4.4 sys 模式存储过程1
28.4.5 sys 模式存储函数1
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 28 章 MySQL 系统模式  / 28.4 sys 模式对象参考  /
28.4.1 sys 架构对象索引
28.4.1 sys 架构对象索引
下表列出sys
了模式对象并提供了每个对象的简短描述。
表 28.1 sys 模式表和触发器
表或触发器名称
描述
sys_config
sys 架构配置选项表
sys_config_insert_set_user
sys_config 插入触发器
sys_config_update_set_user
sys_config 更新触发器
表 28.2 sys 模式视图
查看名称
描述
弃用
host_summary,x$host_summary
语句活动、文件 I/O 和连接，按主机分组
host_summary_by_file_io,x$host_summary_by_file_io
文件 I/O，按主机分组
host_summary_by_file_io_type,x$host_summary_by_file_io_type
文件 I/O，按主机和事件类型分组
host_summary_by_stages,x$host_summary_by_stages
语句阶段，按主机分组
host_summary_by_statement_latency,x$host_summary_by_statement_latency
语句统计信息，按主机分组
host_summary_by_statement_type,x$host_summary_by_statement_type
执行的语句，按主机和语句分组
innodb_buffer_stats_by_schema,x$innodb_buffer_stats_by_schema
InnoDB 缓冲区信息，按模式分组
innodb_buffer_stats_by_table,x$innodb_buffer_stats_by_table
InnoDB 缓冲区信息，按模式和表分组
innodb_lock_waits,x$innodb_lock_waits
InnoDB 锁信息
io_by_thread_by_latency,x$io_by_thread_by_latency
I/O 消费者，按线程分组
io_global_by_file_by_bytes,x$io_global_by_file_by_bytes
全局 I/O 消费者，按文件和字节分组
io_global_by_file_by_latency,x$io_global_by_file_by_latency
全局 I/O 消费者，按文件和延迟分组
io_global_by_wait_by_bytes,x$io_global_by_wait_by_bytes
全局 I/O 消费者，按字节分组
io_global_by_wait_by_latency,x$io_global_by_wait_by_latency
全局 I/O 消费者，按延迟分组
latest_file_io,x$latest_file_io
最近的 I/O，按文件和线程分组
memory_by_host_by_current_bytes,x$memory_by_host_by_current_bytes
内存使用，按主机分组
memory_by_thread_by_current_bytes,x$memory_by_thread_by_current_bytes
内存使用，按线程分组
memory_by_user_by_current_bytes,x$memory_by_user_by_current_bytes
内存使用，按用户分组
memory_global_by_current_bytes,x$memory_global_by_current_bytes
内存使用，按分配类型分组
memory_global_total,x$memory_global_total
总内存使用
metrics
服务器指标
processlist,x$processlist
进程列表信息
ps_check_lost_instrumentation
丢失仪器的变量
schema_auto_increment_columns
AUTO_INCREMENT 列信息
schema_index_statistics,x$schema_index_statistics
指标统计
schema_object_overview
每个模式中的对象类型
schema_redundant_indexes
重复或冗余索引
schema_table_lock_waits,x$schema_table_lock_waits
等待元数据锁的会话
schema_table_statistics,x$schema_table_statistics
表统计
schema_table_statistics_with_buffer,x$schema_table_statistics_with_buffer
表统计信息，包括 InnoDB 缓冲池统计信息
schema_tables_with_full_table_scans,x$schema_tables_with_full_table_scans
通过全扫描访问的表
schema_unused_indexes
未使用的索引
session,x$session
用户会话的进程列表信息
session_ssl_status
连接 SSL 信息
statement_analysis,x$statement_analysis
报表汇总统计
statements_with_errors_or_warnings,x$statements_with_errors_or_warnings
产生错误或警告的语句
statements_with_full_table_scans,x$statements_with_full_table_scans
做过全表扫描的语句
statements_with_runtimes_in_95th_percentile,x$statements_with_runtimes_in_95th_percentile
平均运行时间最高的语句
statements_with_sorting,x$statements_with_sorting
执行排序的语句
statements_with_temp_tables,x$statements_with_temp_tables
使用临时表的语句
user_summary,x$user_summary
用户声明和连接活动
user_summary_by_file_io,x$user_summary_by_file_io
文件 I/O，按用户分组
user_summary_by_file_io_type,x$user_summary_by_file_io_type
文件 I/O，按用户和事件分组
user_summary_by_stages,x$user_summary_by_stages
阶段事件，按用户分组
user_summary_by_statement_latency,x$user_summary_by_statement_latency
语句统计，按用户分组
user_summary_by_statement_type,x$user_summary_by_statement_type
执行的语句，按用户和语句分组
version
当前的 sys 模式和 MySQL 服务器版本
8.0.18
wait_classes_global_by_avg_latency,x$wait_classes_global_by_avg_latency
等待类平均延迟，按事件类分组
wait_classes_global_by_latency,x$wait_classes_global_by_latency
等待类总延迟，按事件类分组
waits_by_host_by_latency,x$waits_by_host_by_latency
等待事件，按主机和事件分组
waits_by_user_by_latency,x$waits_by_user_by_latency
等待事件，按用户和事件分组
waits_global_by_latency,x$waits_global_by_latency
等待事件，按事件分组
x$ps_digest_95th_percentile_by_avg_us
95% 视图的辅助视图
x$ps_digest_avg_latency_distribution
95% 视图的辅助视图
x$ps_schema_table_statistics_io
表统计视图的助手视图
x$schema_flattened_keys
schema_redundant_indexes 的帮助视图
表 28.3 sys 模式存储过程
过程名称
描述
create_synonym_db()
为架构创建同义词
diagnostics()
收集系统诊断信息
execute_prepared_stmt()
执行准备好的语句
ps_setup_disable_background_threads()
禁用后台线程检测
ps_setup_disable_consumer()
禁用消费者
ps_setup_disable_instrument()
禁用仪器
ps_setup_disable_thread()
禁用线程检测
ps_setup_enable_background_threads()
启用后台线程检测
ps_setup_enable_consumer()
赋能消费者
ps_setup_enable_instrument()
启用仪器
ps_setup_enable_thread()
为线程启用检测
ps_setup_reload_saved()
重新加载保存的性能模式配置
ps_setup_reset_to_default()
重置保存的性能架构配置
ps_setup_save()
保存性能架构配置
ps_setup_show_disabled()
显示禁用的性能架构配置
ps_setup_show_disabled_consumers()
显示禁用的 Performance Schema 消费者
ps_setup_show_disabled_instruments()
显示禁用的 Performance Schema 工具
ps_setup_show_enabled()
显示启用的性能架构配置
ps_setup_show_enabled_consumers()
显示启用的 Performance Schema 消费者
ps_setup_show_enabled_instruments()
显示启用的 Performance Schema 工具
ps_statement_avg_latency_histogram()
显示语句延迟直方图
ps_trace_statement_digest()
用于摘要的跟踪性能模式检测
ps_trace_thread()
转储线程的性能模式数据
ps_truncate_all_tables()
截断性能模式汇总表
statement_performance_analyzer()
服务器上运行的语句的报告
table_exists()
表是否存在
表 28.4 sys 模式存储函数
函数名称
描述
弃用
extract_schema_from_file_name()
提取文件名的架构名称部分
extract_table_from_file_name()
提取文件名的表名部分
format_bytes()
将字节数转换为带单位的值
8.0.16
format_path()
用符号系统变量名替换路径名中的目录
format_statement()
将长语句截断为固定长度
format_time()
将皮秒时间转换为带单位的值
8.0.16
list_add()
将项目添加到列表
list_drop()
从列表中删除项目
ps_is_account_enabled()
是否启用帐户的性能模式检测
ps_is_consumer_enabled()
Performance Schema 消费者是否启用
ps_is_instrument_default_enabled()
默认情况下是否启用 Performance Schema instrument
ps_is_instrument_default_timed()
Performance Schema instrument 是否默认定时
ps_is_thread_instrumented()
是否启用连接 ID 的性能模式检测
ps_thread_account()
与 Performance Schema 线程 ID 关联的帐户
ps_thread_id()
与连接 ID 关联的性能架构线程 ID
8.0.16
ps_thread_stack()
连接 ID 的事件信息
ps_thread_trx_info()
线程 ID 的事务信息
quote_identifier()
引用字符串作为标识符
sys_get_config()
sys 架构配置选项值
version_major()
MySQL 服务器主版本号
version_minor()
MySQL 服务器次要版本号
version_patch()
MySQL服务器补丁发布版本号
© Mysql 中文网
