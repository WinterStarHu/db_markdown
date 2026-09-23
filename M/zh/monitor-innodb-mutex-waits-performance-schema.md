# 15.16.2 使用性能模式监控 InnoDB Mutex 等待_MySQL 8.0 参考手册

15.16.2 使用性能模式监控 InnoDB Mutex 等待_MySQL 8.0 参考手册
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
15.16.1 使用性能模式监视 InnoDB 表的 ALTER TABLE 进度1
15.16.2 使用性能模式监控 InnoDB Mutex 等待1
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.16 InnoDB 与 MySQL 性能模式的集成  /
15.16.2 使用性能模式监控 InnoDB Mutex 等待
15.16.2 使用性能模式监控 InnoDB Mutex 等待
互斥量是代码中使用的一种同步机制，用于强制在给定时间只有一个线程可以访问公共资源。当在服务器中执行的两个或多个线程需要访问同一资源时，这些线程就会相互竞争。第一个获得互斥量锁的线程会导致其他线程等待锁被释放。
对于InnoDB被检测的互斥量，可以使用
性能模式监视互斥量等待。例如，在 Performance Schema 表中收集的等待事件数据可以帮助识别等待最多或总等待时间最长的互斥量。
以下示例演示了如何启用
InnoDB互斥等待工具、如何启用关联消费者以及如何查询等待事件数据。
要查看可用InnoDB的互斥等待工具，请查询性能模式
setup_instruments表。InnoDB默认情况下禁用
所有
互斥等待工具。mysql> SELECT *
FROM performance_schema.setup_instruments
WHERE NAME LIKE '%wait/synch/mutex/innodb%';
+---------------------------------------------------------+---------+-------+
| NAME                                                    | ENABLED | TIMED |
+---------------------------------------------------------+---------+-------+
| wait/synch/mutex/innodb/commit_cond_mutex               | NO      | NO    |
| wait/synch/mutex/innodb/innobase_share_mutex            | NO      | NO    |
| wait/synch/mutex/innodb/autoinc_mutex                   | NO      | NO    |
| wait/synch/mutex/innodb/autoinc_persisted_mutex         | NO      | NO    |
| wait/synch/mutex/innodb/buf_pool_flush_state_mutex      | NO      | NO    |
| wait/synch/mutex/innodb/buf_pool_LRU_list_mutex         | NO      | NO    |
| wait/synch/mutex/innodb/buf_pool_free_list_mutex        | NO      | NO    |
| wait/synch/mutex/innodb/buf_pool_zip_free_mutex         | NO      | NO    |
| wait/synch/mutex/innodb/buf_pool_zip_hash_mutex         | NO      | NO    |
| wait/synch/mutex/innodb/buf_pool_zip_mutex              | NO      | NO    |
| wait/synch/mutex/innodb/cache_last_read_mutex           | NO      | NO    |
| wait/synch/mutex/innodb/dict_foreign_err_mutex          | NO      | NO    |
| wait/synch/mutex/innodb/dict_persist_dirty_tables_mutex | NO      | NO    |
| wait/synch/mutex/innodb/dict_sys_mutex                  | NO      | NO    |
| wait/synch/mutex/innodb/recalc_pool_mutex               | NO      | NO    |
| wait/synch/mutex/innodb/fil_system_mutex                | NO      | NO    |
| wait/synch/mutex/innodb/flush_list_mutex                | NO      | NO    |
| wait/synch/mutex/innodb/fts_bg_threads_mutex            | NO      | NO    |
| wait/synch/mutex/innodb/fts_delete_mutex                | NO      | NO    |
| wait/synch/mutex/innodb/fts_optimize_mutex              | NO      | NO    |
| wait/synch/mutex/innodb/fts_doc_id_mutex                | NO      | NO    |
| wait/synch/mutex/innodb/log_flush_order_mutex           | NO      | NO    |
| wait/synch/mutex/innodb/hash_table_mutex                | NO      | NO    |
| wait/synch/mutex/innodb/ibuf_bitmap_mutex               | NO      | NO    |
| wait/synch/mutex/innodb/ibuf_mutex                      | NO      | NO    |
| wait/synch/mutex/innodb/ibuf_pessimistic_insert_mutex   | NO      | NO    |
| wait/synch/mutex/innodb/log_sys_mutex                   | NO      | NO    |
| wait/synch/mutex/innodb/log_sys_write_mutex             | NO      | NO    |
| wait/synch/mutex/innodb/mutex_list_mutex                | NO      | NO    |
| wait/synch/mutex/innodb/page_zip_stat_per_index_mutex   | NO      | NO    |
| wait/synch/mutex/innodb/purge_sys_pq_mutex              | NO      | NO    |
| wait/synch/mutex/innodb/recv_sys_mutex                  | NO      | NO    |
| wait/synch/mutex/innodb/recv_writer_mutex               | NO      | NO    |
| wait/synch/mutex/innodb/redo_rseg_mutex                 | NO      | NO    |
| wait/synch/mutex/innodb/noredo_rseg_mutex               | NO      | NO    |
| wait/synch/mutex/innodb/rw_lock_list_mutex              | NO      | NO    |
| wait/synch/mutex/innodb/rw_lock_mutex                   | NO      | NO    |
| wait/synch/mutex/innodb/srv_dict_tmpfile_mutex          | NO      | NO    |
| wait/synch/mutex/innodb/srv_innodb_monitor_mutex        | NO      | NO    |
| wait/synch/mutex/innodb/srv_misc_tmpfile_mutex          | NO      | NO    |
| wait/synch/mutex/innodb/srv_monitor_file_mutex          | NO      | NO    |
| wait/synch/mutex/innodb/buf_dblwr_mutex                 | NO      | NO    |
| wait/synch/mutex/innodb/trx_undo_mutex                  | NO      | NO    |
| wait/synch/mutex/innodb/trx_pool_mutex                  | NO      | NO    |
| wait/synch/mutex/innodb/trx_pool_manager_mutex          | NO      | NO    |
| wait/synch/mutex/innodb/srv_sys_mutex                   | NO      | NO    |
| wait/synch/mutex/innodb/lock_mutex                      | NO      | NO    |
| wait/synch/mutex/innodb/lock_wait_mutex                 | NO      | NO    |
| wait/synch/mutex/innodb/trx_mutex                       | NO      | NO    |
| wait/synch/mutex/innodb/srv_threads_mutex               | NO      | NO    |
| wait/synch/mutex/innodb/rtr_active_mutex                | NO      | NO    |
| wait/synch/mutex/innodb/rtr_match_mutex                 | NO      | NO    |
| wait/synch/mutex/innodb/rtr_path_mutex                  | NO      | NO    |
| wait/synch/mutex/innodb/rtr_ssn_mutex                   | NO      | NO    |
| wait/synch/mutex/innodb/trx_sys_mutex                   | NO      | NO    |
| wait/synch/mutex/innodb/zip_pad_mutex                   | NO      | NO    |
| wait/synch/mutex/innodb/master_key_id_mutex             | NO      | NO    |
+---------------------------------------------------------+---------+-------+
一些InnoDB互斥锁实例是在服务器启动时创建的，并且只有在服务器启动时也启用了相关仪器时才会被检测。为确保InnoDB检测和启用所有互斥锁实例，请将以下
performance-schema-instrument规则添加到您的 MySQL 配置文件中：
performance-schema-instrument='wait/synch/mutex/innodb/%=ON'
如果您不需要所有
InnoDB互斥锁的等待事件数据，您可以通过向
performance-schema-instrumentMySQL 配置文件添加额外的规则来禁用特定的工具。例如，要禁用
InnoDB与全文搜索相关的互斥等待事件工具，请添加以下规则：
performance-schema-instrument='wait/synch/mutex/innodb/fts%=OFF'
笔记
具有较长前缀的规则（例如 ）
wait/synch/mutex/innodb/fts%优先于具有较短前缀的规则（例如
wait/synch/mutex/innodb/%.
将
performance-schema-instrument规则添加到配置文件后，重新启动服务器。InnoDB除与全文搜索相关的互斥锁外，所有
互斥锁都已启用。要验证，请查询该
setup_instruments表。和
ENABLED列TIMED
应该设置YES为您启用的工具。
mysql> SELECT *
FROM performance_schema.setup_instruments
WHERE NAME LIKE '%wait/synch/mutex/innodb%';
+-------------------------------------------------------+---------+-------+
| NAME                                                  | ENABLED | TIMED |
+-------------------------------------------------------+---------+-------+
| wait/synch/mutex/innodb/commit_cond_mutex             | YES     | YES   |
| wait/synch/mutex/innodb/innobase_share_mutex          | YES     | YES   |
| wait/synch/mutex/innodb/autoinc_mutex                 | YES     | YES   |
...
| wait/synch/mutex/innodb/master_key_id_mutex           | YES     | YES   |
+-------------------------------------------------------+---------+-------+
49 rows in set (0.00 sec)setup_consumers通过更新表
启用等待事件消费者
。默认情况下禁用等待事件消费者。
mysql> UPDATE performance_schema.setup_consumers
SET enabled = 'YES'
WHERE name like 'events_waits%';
Query OK, 3 rows affected (0.00 sec)
Rows matched: 3  Changed: 3  Warnings: 0setup_consumers
您可以通过查询表
来验证等待事件使用者是否已启用。、events_waits_current和
消费者应该被启用
events_waits_history。
events_waits_history_longmysql> SELECT * FROM performance_schema.setup_consumers;
+----------------------------------+---------+
| NAME                             | ENABLED |
+----------------------------------+---------+
| events_stages_current            | NO      |
| events_stages_history            | NO      |
| events_stages_history_long       | NO      |
| events_statements_current        | YES     |
| events_statements_history        | YES     |
| events_statements_history_long   | NO      |
| events_transactions_current      | YES     |
| events_transactions_history      | YES     |
| events_transactions_history_long | NO      |
| events_waits_current             | YES     |
| events_waits_history             | YES     |
| events_waits_history_long        | YES     |
| global_instrumentation           | YES     |
| thread_instrumentation           | YES     |
| statements_digest                | YES     |
+----------------------------------+---------+
15 rows in set (0.00 sec)
启用仪器和消费者后，运行您要监控的工作负载。在此示例中，
mysqlslap负载仿真客户端用于模拟工作负载。
$> ./mysqlslap --auto-generate-sql --concurrency=100 --iterations=10
--number-of-queries=1000 --number-char-cols=6 --number-int-cols=6;
查询等待事件数据。在此示例中，等待事件数据是从表中查询的，该
events_waits_summary_global_by_event_name
表汇总了在 、 和 表中找到
events_waits_current的
events_waits_history数据
events_waits_history_long。数据按事件名称 ( EVENT_NAME) 汇总，事件名称是产生事件的仪器的名称。汇总数据包括：
COUNT_STAR
汇总等待事件的数量。
SUM_TIMER_WAIT
汇总的定时等待事件的总等待时间。
MIN_TIMER_WAIT
汇总的定时等待事件的最短等待时间。
AVG_TIMER_WAIT
汇总的定时等待事件的平均等待时间。
MAX_TIMER_WAIT
汇总的定时等待事件的最大等待时间。
以下查询返回仪器名称 ( EVENT_NAME)、等待事件数 ( COUNT_STAR) 以及该仪器事件的总等待时间 ( SUM_TIMER_WAIT)。因为默认情况下等待时间以皮秒（万亿分之一秒）为单位，所以等待时间除以 1000000000 以显示以毫秒为单位的等待时间。数据按汇总等待事件的数量 ( ) 降序显示COUNT_STAR。您可以调整
ORDER BY子句以按总等待时间对数据进行排序。
mysql> SELECT EVENT_NAME, COUNT_STAR, SUM_TIMER_WAIT/1000000000 SUM_TIMER_WAIT_MS
FROM performance_schema.events_waits_summary_global_by_event_name
WHERE SUM_TIMER_WAIT > 0 AND EVENT_NAME LIKE 'wait/synch/mutex/innodb/%'
ORDER BY COUNT_STAR DESC;
+---------------------------------------------------------+------------+-------------------+
| EVENT_NAME                                              | COUNT_STAR | SUM_TIMER_WAIT_MS |
+---------------------------------------------------------+------------+-------------------+
| wait/synch/mutex/innodb/trx_mutex                       |     201111 |           23.4719 |
| wait/synch/mutex/innodb/fil_system_mutex                |      62244 |            9.6426 |
| wait/synch/mutex/innodb/redo_rseg_mutex                 |      48238 |            3.1135 |
| wait/synch/mutex/innodb/log_sys_mutex                   |      46113 |            2.0434 |
| wait/synch/mutex/innodb/trx_sys_mutex                   |      35134 |         1068.1588 |
| wait/synch/mutex/innodb/lock_mutex                      |      34872 |         1039.2589 |
| wait/synch/mutex/innodb/log_sys_write_mutex             |      17805 |         1526.0490 |
| wait/synch/mutex/innodb/dict_sys_mutex                  |      14912 |         1606.7348 |
| wait/synch/mutex/innodb/trx_undo_mutex                  |      10634 |            1.1424 |
| wait/synch/mutex/innodb/rw_lock_list_mutex              |       8538 |            0.1960 |
| wait/synch/mutex/innodb/buf_pool_free_list_mutex        |       5961 |            0.6473 |
| wait/synch/mutex/innodb/trx_pool_mutex                  |       4885 |         8821.7496 |
| wait/synch/mutex/innodb/buf_pool_LRU_list_mutex         |       4364 |            0.2077 |
| wait/synch/mutex/innodb/innobase_share_mutex            |       3212 |            0.2650 |
| wait/synch/mutex/innodb/flush_list_mutex                |       3178 |            0.2349 |
| wait/synch/mutex/innodb/trx_pool_manager_mutex          |       2495 |            0.1310 |
| wait/synch/mutex/innodb/buf_pool_flush_state_mutex      |       1318 |            0.2161 |
| wait/synch/mutex/innodb/log_flush_order_mutex           |       1250 |            0.0893 |
| wait/synch/mutex/innodb/buf_dblwr_mutex                 |        951 |            0.0918 |
| wait/synch/mutex/innodb/recalc_pool_mutex               |        670 |            0.0942 |
| wait/synch/mutex/innodb/dict_persist_dirty_tables_mutex |        345 |            0.0414 |
| wait/synch/mutex/innodb/lock_wait_mutex                 |        303 |            0.1565 |
| wait/synch/mutex/innodb/autoinc_mutex                   |        196 |            0.0213 |
| wait/synch/mutex/innodb/autoinc_persisted_mutex         |        196 |            0.0175 |
| wait/synch/mutex/innodb/purge_sys_pq_mutex              |        117 |            0.0308 |
| wait/synch/mutex/innodb/srv_sys_mutex                   |         94 |            0.0077 |
| wait/synch/mutex/innodb/ibuf_mutex                      |         22 |            0.0086 |
| wait/synch/mutex/innodb/recv_sys_mutex                  |         12 |            0.0008 |
| wait/synch/mutex/innodb/srv_innodb_monitor_mutex        |          4 |            0.0009 |
| wait/synch/mutex/innodb/recv_writer_mutex               |          1 |            0.0005 |
+---------------------------------------------------------+------------+-------------------+
笔记
上述结果集中包括启动过程中产生的等待事件数据。要排除此数据，您可以
events_waits_summary_global_by_event_name
在启动后和运行工作负载之前立即截断该表。但是，截断操作本身可能会产生可忽略不计的等待事件数据。
mysql> TRUNCATE performance_schema.events_waits_summary_global_by_event_name;
© Mysql 中文网
