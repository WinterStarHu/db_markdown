# 28.4.3 sys 架构视图_MySQL 8.0 参考手册

28.4.3 sys 架构视图_MySQL 8.0 参考手册
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
28.4.3.1 host_summary 和 x$host_summary 视图
28.4.3.2 host_summary_by_file_io 和 x$host_summary_by_file_io 视图
28.4.3.3 host_summary_by_file_io_type 和 x$host_summary_by_file_io_type 视图
28.4.3.4 host_summary_by_stages 和 x$host_summary_by_stages 视图
28.4.3.5 host_summary_by_statement_latency 和 x$host_summary_by_statement_latency 视图
28.4.3.6 host_summary_by_statement_type 和 x$host_summary_by_statement_type 视图
28.4.3.7 innodb_buffer_stats_by_schema 和 x$innodb_buffer_stats_by_schema 视图
28.4.3.8 innodb_buffer_stats_by_table 和 x$innodb_buffer_stats_by_table 视图
28.4.3.9 innodb_lock_waits 和 x$innodb_lock_waits 视图
28.4.3.10 io_by_thread_by_latency 和 x$io_by_thread_by_latency 视图
28.4.3.11 io_global_by_file_by_bytes 和 x$io_global_by_file_by_bytes 视图
28.4.3.12 io_global_by_file_by_latency 和 x$io_global_by_file_by_latency 视图
28.4.3.13 io_global_by_wait_by_bytes 和 x$io_global_by_wait_by_bytes 视图
28.4.3.14 io_global_by_wait_by_latency 和 x$io_global_by_wait_by_latency 视图
28.4.3.15 latest_file_io 和 x$latest_file_io 视图
28.4.3.16 memory_by_host_by_current_bytes 和 x$memory_by_host_by_current_bytes 视图
28.4.3.17 memory_by_thread_by_current_bytes 和 x$memory_by_thread_by_current_bytes 视图
28.4.3.18 memory_by_user_by_current_bytes 和 x$memory_by_user_by_current_bytes 视图
28.4.3.19 memory_global_by_current_bytes 和 x$memory_global_by_current_bytes 视图
28.4.3.20 memory_global_total 和 x$memory_global_total 视图
28.4.3.21 指标视图
28.4.3.22 processlist 和 x$processlist 视图
28.4.3.23 ps_check_lost_instrumentation 视图
28.4.3.24 schema_auto_increment_columns 视图
28.4.3.25 schema_index_statistics 和 x$schema_index_statistics 视图
28.4.3.26 schema_object_overview 视图
28.4.3.27 schema_redundant_indexes 和 x$schema_flattened_keys 视图
28.4.3.28 schema_table_lock_waits 和 x$schema_table_lock_waits 视图
28.4.3.29 schema_table_statistics 和 x$schema_table_statistics 视图
28.4.3.30 schema_table_statistics_with_buffer 和 x$schema_table_statistics_with_buffer 视图
28.4.3.31 schema_tables_with_full_table_scans 和 x$schema_tables_with_full_table_scans 视图
28.4.3.32 schema_unused_indexes 视图
28.4.3.33 session 和 x$session 视图
28.4.3.34 session_ssl_status 视图
28.4.3.35 statement_analysis 和 x$statement_analysis 视图
28.4.3.36 statements_with_errors_or_warnings 和 x$statements_with_errors_or_warnings 视图
28.4.3.37 statements_with_full_table_scans 和 x$statements_with_full_table_scans 视图
28.4.3.38 statements_with_runtimes_in_95th_percentile 和 x$statements_with_runtimes_in_95th_percentile 视图
28.4.3.39 statements_with_sorting 和 x$statements_with_sorting 视图
28.4.3.40 statements_with_temp_tables 和 x$statements_with_temp_tables 视图
28.4.3.41 user_summary 和 x$user_summary 视图
28.4.3.42 user_summary_by_file_io 和 x$user_summary_by_file_io 视图
28.4.3.43 user_summary_by_file_io_type 和 x$user_summary_by_file_io_type 视图
28.4.3.44 user_summary_by_stages 和 x$user_summary_by_stages 视图
28.4.3.45 user_summary_by_statement_latency 和 x$user_summary_by_statement_latency 视图
28.4.3.46 user_summary_by_statement_type 和 x$user_summary_by_statement_type 视图
28.4.3.47版本查看
28.4.3.48 wait_classes_global_by_avg_latency 和 x$wait_classes_global_by_avg_latency 视图
28.4.3.49 wait_classes_global_by_latency 和 x$wait_classes_global_by_latency 视图
28.4.3.50 waits_by_host_by_latency 和 x$waits_by_host_by_latency 视图
28.4.3.51 waits_by_user_by_latency 和 x$waits_by_user_by_latency 视图
28.4.3.52 waits_global_by_latency 和 x$waits_global_by_latency 视图
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
28.4.3 sys 架构视图
28.4.3 sys 架构视图
28.4.3.1 host_summary 和 x$host_summary 视图28.4.3.2 host_summary_by_file_io 和 x$host_summary_by_file_io 视图28.4.3.3 host_summary_by_file_io_type 和 x$host_summary_by_file_io_type 视图28.4.3.4 host_summary_by_stages 和 x$host_summary_by_stages 视图28.4.3.5 host_summary_by_statement_latency 和 x$host_summary_by_statement_latency 视图28.4.3.6 host_summary_by_statement_type 和 x$host_summary_by_statement_type 视图28.4.3.7 innodb_buffer_stats_by_schema 和 x$innodb_buffer_stats_by_schema 视图28.4.3.8 innodb_buffer_stats_by_table 和 x$innodb_buffer_stats_by_table 视图28.4.3.9 innodb_lock_waits 和 x$innodb_lock_waits 视图28.4.3.10 io_by_thread_by_latency 和 x$io_by_thread_by_latency 视图28.4.3.11 io_global_by_file_by_bytes 和 x$io_global_by_file_by_bytes 视图28.4.3.12 io_global_by_file_by_latency 和 x$io_global_by_file_by_latency 视图28.4.3.13 io_global_by_wait_by_bytes 和 x$io_global_by_wait_by_bytes 视图28.4.3.14 io_global_by_wait_by_latency 和 x$io_global_by_wait_by_latency 视图28.4.3.15 latest_file_io 和 x$latest_file_io 视图28.4.3.16 memory_by_host_by_current_bytes 和 x$memory_by_host_by_current_bytes 视图28.4.3.17 memory_by_thread_by_current_bytes 和 x$memory_by_thread_by_current_bytes 视图28.4.3.18 memory_by_user_by_current_bytes 和 x$memory_by_user_by_current_bytes 视图28.4.3.19 memory_global_by_current_bytes 和 x$memory_global_by_current_bytes 视图28.4.3.20 memory_global_total 和 x$memory_global_total 视图28.4.3.21 指标视图28.4.3.22 processlist 和 x$processlist 视图28.4.3.23 ps_check_lost_instrumentation 视图28.4.3.24 schema_auto_increment_columns 视图28.4.3.25 schema_index_statistics 和 x$schema_index_statistics 视图28.4.3.26 schema_object_overview 视图28.4.3.27 schema_redundant_indexes 和 x$schema_flattened_keys 视图28.4.3.28 schema_table_lock_waits 和 x$schema_table_lock_waits 视图28.4.3.29 schema_table_statistics 和 x$schema_table_statistics 视图28.4.3.30 schema_table_statistics_with_buffer 和 x$schema_table_statistics_with_buffer 视图28.4.3.31 schema_tables_with_full_table_scans 和 x$schema_tables_with_full_table_scans 视图28.4.3.32 schema_unused_indexes 视图28.4.3.33 session 和 x$session 视图28.4.3.34 session_ssl_status 视图28.4.3.35 statement_analysis 和 x$statement_analysis 视图28.4.3.36 statements_with_errors_or_warnings 和 x$statements_with_errors_or_warnings 视图28.4.3.37 statements_with_full_table_scans 和 x$statements_with_full_table_scans 视图28.4.3.38 statements_with_runtimes_in_95th_percentile 和 x$statements_with_runtimes_in_95th_percentile 视图28.4.3.39 statements_with_sorting 和 x$statements_with_sorting 视图28.4.3.40 statements_with_temp_tables 和 x$statements_with_temp_tables 视图28.4.3.41 user_summary 和 x$user_summary 视图28.4.3.42 user_summary_by_file_io 和 x$user_summary_by_file_io 视图28.4.3.43 user_summary_by_file_io_type 和 x$user_summary_by_file_io_type 视图28.4.3.44 user_summary_by_stages 和 x$user_summary_by_stages 视图28.4.3.45 user_summary_by_statement_latency 和 x$user_summary_by_statement_latency 视图28.4.3.46 user_summary_by_statement_type 和 x$user_summary_by_statement_type 视图28.4.3.47版本查看28.4.3.48 wait_classes_global_by_avg_latency 和 x$wait_classes_global_by_avg_latency 视图28.4.3.49 wait_classes_global_by_latency 和 x$wait_classes_global_by_latency 视图28.4.3.50 waits_by_host_by_latency 和 x$waits_by_host_by_latency 视图28.4.3.51 waits_by_user_by_latency 和 x$waits_by_user_by_latency 视图28.4.3.52 waits_global_by_latency 和 x$waits_global_by_latency 视图
以下部分描述了
sys架构视图。
该sys模式包含许多以各种方式总结性能模式表的视图。大多数这些视图都是成对出现的，这样一对中的一个成员与另一个成员具有相同的名称，加上一个x$
前缀。例如，该
host_summary_by_file_io视图汇总了按主机分组的文件 I/O，并显示从皮秒转换为更易读的值（带单位）的延迟；
mysql> SELECT * FROM sys.host_summary_by_file_io;
+------------+-------+------------+
| host       | ios   | io_latency |
+------------+-------+------------+
| localhost  | 67570 | 5.38 s     |
| background |  3468 | 4.18 s     |
+------------+-------+------------+
该x$host_summary_by_file_io视图汇总了相同的数据，但显示了未格式化的皮秒延迟：
mysql> SELECT * FROM sys.x$host_summary_by_file_io;
+------------+-------+---------------+
| host       | ios   | io_latency    |
+------------+-------+---------------+
| localhost  | 67574 | 5380678125144 |
| background |  3474 | 4758696829416 |
+------------+-------+---------------+
没有x$前缀的视图旨在提供对用户更友好且更易于阅读的输出。带有以原始形式显示相同值的前缀的视图x$更多地用于与对数据执行自己的处理的其他工具一起使用。
没有前缀的视图在这些方面
x$与相应的视图不同：x$
字节数使用大小单位格式化
format_bytes()。
时间值使用时间单位格式化
format_time()。
SQL 语句被截断为最大显示宽度，使用format_statement().
路径名使用
format_path().
© Mysql 中文网
