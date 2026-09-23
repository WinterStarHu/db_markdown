# 23.6.17 NDB Cluster 和性能模式_MySQL 8.0 参考手册

23.6.17 NDB Cluster 和性能模式_MySQL 8.0 参考手册
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
23.6.17 NDB Cluster 和性能模式
23.6.17 NDB Cluster 和性能模式
NDB 8.0 在 MySQL Performance Schema 中提供了有关线程和事务内存使用的信息；NDB 8.0.29 添加了
ndbcluster插件线程，NDB 8.0.30 添加了事务批处理内存检测。这些功能将在以下各节中进行更详细的描述。
ndbcluster 插件线程
从 NDB 8.0.29 开始，ndbcluster插件线程在 Performance Schema
threads表中可见，如以下查询所示：
mysql> SELECT name, type, thread_id, thread_os_id
-> FROM performance_schema.threads
-> WHERE name LIKE '%ndbcluster%'\G
+----------------------------------+------------+-----------+--------------+
| name                             | type       | thread_id | thread_os_id |
+----------------------------------+------------+-----------+--------------+
| thread/ndbcluster/ndb_binlog     | BACKGROUND |        30 |        11980 |
| thread/ndbcluster/ndb_index_stat | BACKGROUND |        31 |        11981 |
| thread/ndbcluster/ndb_metadata   | BACKGROUND |        32 |        11982 |
+----------------------------------+------------+-----------+--------------+
该threads表显示了此处列出的所有三个线程：
ndb_binlog：二进制日志记录线程
ndb_index_stat: 索引统计线程
ndb_metadata：元数据线程
这些线程也在
setup_threads表中按名称显示。
线程名称使用格式
显示在和
表的name列中。
，由引擎确定的对象类型，用于插件线程（请参阅
线程工具元素）。的是
。
是线程的独立名称（、
或
）。
threadssetup_threadsprefix/plugin_name/thread_nameprefixperformance_schemathreadplugin_namendbclusterthread_namendb_binlogndb_index_statndb_metadatathreads使用或表
中给定线程的线程 ID 或操作系统线程 ID，
setup_threads
可以从 Performance Schema 中获取有关插件执行和资源使用情况的大量信息。此示例显示如何通过连接和
表
从arena
获取ndbcluster
插件创建的线程分配的内存量：mem_rootthreadsmemory_summary_by_thread_by_event_namemysql> SELECT
->   t.name,
->   m.sum_number_of_bytes_alloc,
->   IF(m.sum_number_of_bytes_alloc > 0, "true", "false") AS 'Has allocated memory'
-> FROM performance_schema.memory_summary_by_thread_by_event_name m
-> JOIN performance_schema.threads t
-> ON m.thread_id = t.thread_id
-> WHERE t.name LIKE '%ndbcluster%'
->   AND event_name LIKE '%THD::main_mem_root%';
+----------------------------------+---------------------------+----------------------+
| name                             | sum_number_of_bytes_alloc | Has allocated memory |
+----------------------------------+---------------------------+----------------------+
| thread/ndbcluster/ndb_binlog     |                     20576 | true                 |
| thread/ndbcluster/ndb_index_stat |                         0 | false                |
| thread/ndbcluster/ndb_metadata   |                      8240 | true                 |
+----------------------------------+---------------------------+----------------------+
事务内存使用
从 NDB 8.0.30 开始，您可以通过查询 Performance Schema 表来查看用于事务批处理的内存量
memory_summary_by_thread_by_event_name
，类似于此处显示的内容：
mysql> SELECT EVENT_NAME
->   FROM performance_schema.memory_summary_by_thread_by_event_name
->   WHERE THREAD_ID = PS_CURRENT_THREAD_ID()
->     AND EVENT_NAME LIKE 'memory/ndbcluster/%';
+-------------------------------------------+
| EVENT_NAME                                |
+-------------------------------------------+
| memory/ndbcluster/Thd_ndb::batch_mem_root |
+-------------------------------------------+
1 row in set (0.01 sec)
事务ndbcluster内存工具在 Performance Schema 表中也可见
setup_instruments，如下所示：
mysql> SELECT * from performance_schema.setup_instruments
->   WHERE NAME LIKE '%ndb%'\G
*************************** 1. row ***************************
NAME: memory/ndbcluster/Thd_ndb::batch_mem_root
ENABLED: YES
TIMED: NULL
PROPERTIES:
VOLATILITY: 0
DOCUMENTATION: Memory used for transaction batching
1 row in set (0.01 sec)
© Mysql 中文网
