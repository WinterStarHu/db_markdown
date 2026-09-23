# 15.16 InnoDB 与 MySQL 性能模式的集成_MySQL 8.0 参考手册

15.16 InnoDB 与 MySQL 性能模式的集成_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  /
15.16 InnoDB 与 MySQL 性能模式的集成
15.16 InnoDB 与 MySQL 性能模式的集成
15.16.1 使用性能模式监视 InnoDB 表的 ALTER TABLE 进度15.16.2 使用性能模式监控 InnoDB Mutex 等待
本节简要介绍
InnoDB与 Performance Schema 的集成。有关全面的性能模式文档，请参阅
第 27 章，MySQL 性能模式。
InnoDB
您可以使用 MySQL
Performance Schema 功能
分析某些内部操作。这种类型的调优主要面向评估优化策略以克服性能瓶颈的专家用户。DBA 还可以使用此功能进行容量规划，以查看他们的典型工作负载是否遇到特定 CPU、RAM 和磁盘存储组合的性能瓶颈；如果是，判断是否可以通过增加系统某部分的容量来提高性能。
要使用此功能检查InnoDB
性能：
您必须大致熟悉如何使用
性能模式功能。例如，您应该知道如何启用工具和消费者，以及如何查询
performance_schema表以检索数据。有关介绍性概述，请参阅
第 27.1 节，“性能模式快速入门”。
您应该熟悉可用于InnoDB. 要查看
InnoDB- 相关的工具，您可以在
setup_instruments表中查询包含“ innodb”的工具名称。
mysql> SELECT *
FROM performance_schema.setup_instruments
WHERE NAME LIKE '%innodb%';
+-------------------------------------------------------+---------+-------+
| NAME                                                  | ENABLED | TIMED |
+-------------------------------------------------------+---------+-------+
| wait/synch/mutex/innodb/commit_cond_mutex             | NO      | NO    |
| wait/synch/mutex/innodb/innobase_share_mutex          | NO      | NO    |
| wait/synch/mutex/innodb/autoinc_mutex                 | NO      | NO    |
| wait/synch/mutex/innodb/buf_pool_mutex                | NO      | NO    |
| wait/synch/mutex/innodb/buf_pool_zip_mutex            | NO      | NO    |
| wait/synch/mutex/innodb/cache_last_read_mutex         | NO      | NO    |
| wait/synch/mutex/innodb/dict_foreign_err_mutex        | NO      | NO    |
| wait/synch/mutex/innodb/dict_sys_mutex                | NO      | NO    |
| wait/synch/mutex/innodb/recalc_pool_mutex             | NO      | NO    |
...
| wait/io/file/innodb/innodb_data_file                  | YES     | YES   |
| wait/io/file/innodb/innodb_log_file                   | YES     | YES   |
| wait/io/file/innodb/innodb_temp_file                  | YES     | YES   |
| stage/innodb/alter table (end)                        | YES     | YES   |
| stage/innodb/alter table (flush)                      | YES     | YES   |
| stage/innodb/alter table (insert)                     | YES     | YES   |
| stage/innodb/alter table (log apply index)            | YES     | YES   |
| stage/innodb/alter table (log apply table)            | YES     | YES   |
| stage/innodb/alter table (merge sort)                 | YES     | YES   |
| stage/innodb/alter table (read PK and internal sort)  | YES     | YES   |
| stage/innodb/buffer pool load                         | YES     | YES   |
| memory/innodb/buf_buf_pool                            | NO      | NO    |
| memory/innodb/dict_stats_bg_recalc_pool_t             | NO      | NO    |
| memory/innodb/dict_stats_index_map_t                  | NO      | NO    |
| memory/innodb/dict_stats_n_diff_on_level              | NO      | NO    |
| memory/innodb/other                                   | NO      | NO    |
| memory/innodb/row_log_buf                             | NO      | NO    |
| memory/innodb/row_merge_sort                          | NO      | NO    |
| memory/innodb/std                                     | NO      | NO    |
| memory/innodb/sync_debug_latches                      | NO      | NO    |
| memory/innodb/trx_sys_t::rw_trx_ids                   | NO      | NO    |
...
+-------------------------------------------------------+---------+-------+
155 rows in set (0.00 sec)
有关检测
InnoDB对象的其他信息，您可以查询 Performance Schema
实例表，它提供有关检测对象的其他信息。相关实例表
InnoDB包括：
mutex_instances桌子
_rwlock_instances桌子
_cond_instances桌子
_file_instances桌子
_
笔记
与缓冲池相关的互斥锁和 RW 锁InnoDB
不在此范围内；这同样适用于SHOW ENGINE INNODB
MUTEX命令的输出。
例如，要查看有关
InnoDB在执行文件 I/O 检测时性能模式看到的检测文件对象的信息，您可以发出以下查询：
mysql> SELECT *
FROM performance_schema.file_instances
WHERE EVENT_NAME LIKE '%innodb%'\G
*************************** 1. row ***************************
FILE_NAME: /home/dtprice/mysql-8.0/data/ibdata1
EVENT_NAME: wait/io/file/innodb/innodb_data_file
OPEN_COUNT: 3
*************************** 2. row ***************************
FILE_NAME: /home/dtprice/mysql-8.0/data/#ib_16384_0.dblwr
EVENT_NAME: wait/io/file/innodb/innodb_dblwr_file
OPEN_COUNT: 2
*************************** 3. row ***************************
FILE_NAME: /home/dtprice/mysql-8.0/data/#ib_16384_1.dblwr
EVENT_NAME: wait/io/file/mysql-8.0/innodb_dblwr_file
OPEN_COUNT: 2
...
您应该熟悉
performance_schema存储
InnoDB事件数据的表。与相关事件相关的表格
InnoDB包括：
等待事件
表，用于存储等待事件。
摘要
表，提供随时间推移终止的事件的汇总信息。汇总表包括
文件 I/O 汇总表，它汇总了有关 I/O 操作的信息。
阶段事件表，存储事件数据
InnoDB ALTER
TABLE和缓冲池加载操作。有关详细信息，请参阅
第 15.16.1 节，“使用性能模式监视 InnoDB 表的 ALTER TABLE 进度”和
使用性能模式监视缓冲池加载进度。
如果您只对 - 相关的对象感兴趣，请在查询这些表时
InnoDB使用子句WHERE EVENT_NAME LIKE
'%innodb%'或（根据需要）。WHERE NAME LIKE
'%innodb%'
© Mysql 中文网
