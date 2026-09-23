# 26.4.28 INFORMATION_SCHEMA INNODB_TRX 表_MySQL 8.0 参考手册

26.4.28 INFORMATION_SCHEMA INNODB_TRX 表_MySQL 8.0 参考手册
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
26.1 简介
26.2 INFORMATION_SCHEMA 表参考
26.3 INFORMATION_SCHEMA 总表
26.4 INFORMATION_SCHEMA InnoDB 表
26.4.1 INFORMATION_SCHEMA InnoDB 表参考1
26.4.2 INFORMATION_SCHEMA INNODB_BUFFER_PAGE 表1
26.4.3 INFORMATION_SCHEMA INNODB_BUFFER_PAGE_LRU 表1
26.4.4 INFORMATION_SCHEMA INNODB_BUFFER_POOL_STATS 表1
26.4.5 INFORMATION_SCHEMA INNODB_CACHED_INDEXES 表1
26.4.6 INFORMATION_SCHEMA INNODB_CMP 和 INNODB_CMP_RESET 表1
26.4.7 INFORMATION_SCHEMA INNODB_CMPMEM 和 INNODB_CMPMEM_RESET 表1
26.4.8 INFORMATION_SCHEMA INNODB_CMP_PER_INDEX 和 INNODB_CMP_PER_INDEX_RESET 表1
26.4.9 INFORMATION_SCHEMA INNODB_COLUMNS 表1
26.4.10 INFORMATION_SCHEMA INNODB_DATAFILES 表1
26.4.11 INFORMATION_SCHEMA INNODB_FIELDS 表1
26.4.12 INFORMATION_SCHEMA INNODB_FOREIGN 表1
26.4.13 INFORMATION_SCHEMA INNODB_FOREIGN_COLS 表1
26.4.14 INFORMATION_SCHEMA INNODB_FT_BEING_DELETED 表1
26.4.15 INFORMATION_SCHEMA INNODB_FT_CONFIG 表1
26.4.16 INFORMATION_SCHEMA INNODB_FT_DEFAULT_STOPWORD 表1
26.4.17 INFORMATION_SCHEMA INNODB_FT_DELETED 表1
26.4.18 INFORMATION_SCHEMA INNODB_FT_INDEX_CACHE 表1
26.4.19 INFORMATION_SCHEMA INNODB_FT_INDEX_TABLE 表1
26.4.20 INFORMATION_SCHEMA INNODB_INDEXES 表1
26.4.21 INFORMATION_SCHEMA INNODB_METRICS 表1
26.4.22 INFORMATION_SCHEMA INNODB_SESSION_TEMP_TABLESPACES 表1
26.4.23 INFORMATION_SCHEMA INNODB_TABLES 表1
26.4.24 INFORMATION_SCHEMA INNODB_TABLESPACES 表1
26.4.25 INFORMATION_SCHEMA INNODB_TABLESPACES_BRIEF 表1
26.4.26 INFORMATION_SCHEMA INNODB_TABLESTATS 视图1
26.4.27 INFORMATION_SCHEMA INNODB_TEMP_TABLE_INFO 表1
26.4.28 INFORMATION_SCHEMA INNODB_TRX 表1
26.4.29 INFORMATION_SCHEMA INNODB_VIRTUAL 表1
26.5 INFORMATION_SCHEMA线程池表
26.6 INFORMATION_SCHEMA 连接控制表
26.7 INFORMATION_SCHEMA MySQL 企业防火墙表
26.8 SHOW 语句的扩展
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
MySQL 8.0 参考手册  / 第 26 章 INFORMATION_SCHEMA 表  / 26.4 INFORMATION_SCHEMA InnoDB 表  /
26.4.28 INFORMATION_SCHEMA INNODB_TRX 表
26.4.28 INFORMATION_SCHEMA INNODB_TRX 表
该INNODB_TRX表提供了当前在其中执行的每个事务的信息
InnoDB，包括事务是否正在等待锁、事务何时开始以及事务正在执行的 SQL 语句（如果有的话）。
有关使用信息，请参阅
第 15.15.2.1 节，“使用 InnoDB 事务和锁定信息”。
该INNODB_TRX表有以下列：
TRX_ID
内部的唯一交易 ID 号
InnoDB。这些 ID 不是为只读和非锁定的事务创建的。有关详细信息，请参阅第 8.5.3 节，“优化 InnoDB 只读事务”。
TRX_WEIGHT
事务的权重，反映（但不一定是确切的计数）更改的行数和事务锁定的行数。为了解决死锁，
InnoDB选择权重最小的事务作为“受害者”进行回滚。已更改非事务表的事务被认为比其他事务更重，无论更改和锁定的行数如何。
TRX_STATE
事务执行状态。允许的值为
RUNNING、LOCK WAIT、
ROLLING BACK和
COMMITTING。
TRX_STARTED
交易开始时间。
TRX_REQUESTED_LOCK_ID
事务当前正在等待的锁的 ID，如果TRX_STATE是LOCK
WAIT; 否则NULL。要获取有关锁的详细信息，请将此列与
ENGINE_LOCK_IDPerformance Schemadata_locks表的列连接起来。
TRX_WAIT_STARTED
事务开始等待锁的时间，如果
TRX_STATE是LOCK WAIT；否则NULL。
TRX_MYSQL_THREAD_ID
MySQL 线程 ID。要获取有关线程的详细信息，请将此列与表的列连接起来ID，
INFORMATION_SCHEMA
PROCESSLIST但请参阅
第 15.15.2.3 节，“InnoDB 事务和锁定信息的持久性和一致性”。
TRX_QUERY
事务正在执行的 SQL 语句。
TRX_OPERATION_STATE
交易的当前操作，如果有的话；否则
NULL。
TRX_TABLES_IN_USE
InnoDB处理此事务的当前 SQL 语句时使用
的表数。
TRX_TABLES_LOCKED
InnoDB当前 SQL 语句具有行锁
的表的数量。（因为这些是行锁，而不是表锁，所以尽管某些行被锁定，但表通常仍然可以由多个事务读取和写入。）
TRX_LOCK_STRUCTS
事务保留的锁数。
TRX_LOCK_MEMORY_BYTES
此事务的锁结构在内存中占用的总大小。
TRX_ROWS_LOCKED
此事务锁定的大概行数。该值可能包括物理上存在但对事务不可见的删除标记行。
TRX_ROWS_MODIFIED
此事务中修改和插入的行数。
TRX_CONCURRENCY_TICKETS
一个值，表示当前事务在被换出之前可以做多少工作，由
innodb_concurrency_tickets
系统变量指定。
TRX_ISOLATION_LEVEL
当前事务的隔离级别。
TRX_UNIQUE_CHECKS
是否为当前事务打开或关闭唯一检查。例如，它们可能会在批量数据加载期间关闭。
TRX_FOREIGN_KEY_CHECKS
是否为当前事务打开或关闭外键检查。例如，它们可能会在批量数据加载期间关闭。
TRX_LAST_FOREIGN_KEY_ERROR
最后一个外键错误的详细错误消息，如果有的话；否则NULL。
TRX_ADAPTIVE_HASH_LATCHED
自适应哈希索引是否被当前事务锁定。当自适应哈希索引搜索系统分区时，单个事务不会锁定整个自适应哈希索引。自适应哈希索引分区由 控制
innodb_adaptive_hash_index_parts，默认设置为 8。
TRX_ADAPTIVE_HASH_TIMEOUT
是立即放弃自适应哈希索引的搜索锁存器，还是在 MySQL 的调用中保留它。当没有自适应散列索引争用时，该值保持为零并且语句保留闩锁直到它们完成。在争用期间，它倒数到零，语句在每次查找行后立即释放锁存器。当自适应哈希索引搜索系统被分区（由 控制
innodb_adaptive_hash_index_parts）时，该值保持为 0。
TRX_IS_READ_ONLY
值为 1 表示事务是只读的。
TRX_AUTOCOMMIT_NON_LOCKING
值为 1 表示该事务是一条
SELECT不使用FOR UPDATEorLOCK IN
SHARED MODE子句的语句，并且在启用的情况下执行，
autocommit因此该事务仅包含这一条语句。当此列 和TRX_IS_READ_ONLY都为 1 时，
InnoDB优化事务以减少与更改表数据的事务相关的开销。
TRX_SCHEDULE_WEIGHT
争用感知事务调度 (CATS) 算法分配给等待锁定的事务的事务调度权重。该价值是相对于其他交易的价值而言的。较高的值具有较大的权重。LOCK WAIT仅为列报告
的状态中的事务计算值
TRX_STATE。不等待锁定的事务会报告 NULL 值。TRX_SCHEDULE_WEIGHT值与值不同，
TRX_WEIGHT是为了不同的目的，用不同的算法计算出来的。
例子
mysql> SELECT * FROM INFORMATION_SCHEMA.INNODB_TRX\G
*************************** 1. row ***************************
trx_id: 1510
trx_state: RUNNING
trx_started: 2014-11-19 13:24:40
trx_requested_lock_id: NULL
trx_wait_started: NULL
trx_weight: 586739
trx_mysql_thread_id: 2
trx_query: DELETE FROM employees.salaries WHERE salary > 65000
trx_operation_state: updating or deleting
trx_tables_in_use: 1
trx_tables_locked: 1
trx_lock_structs: 3003
trx_lock_memory_bytes: 450768
trx_rows_locked: 1407513
trx_rows_modified: 583736
trx_concurrency_tickets: 0
trx_isolation_level: REPEATABLE READ
trx_unique_checks: 1
trx_foreign_key_checks: 1
trx_last_foreign_key_error: NULL
trx_adaptive_hash_latched: 0
trx_adaptive_hash_timeout: 10000
trx_is_read_only: 0
trx_autocommit_non_locking: 0
trx_schedule_weight: NULL
笔记
使用此表可帮助诊断在高并发负载期间出现的性能问题。其内容如
第 15.15.2.3 节“InnoDB 事务和锁定信息的持久性和一致性”中所述进行了更新。
您必须具有PROCESS
查询此表的权限。
使用INFORMATION_SCHEMA
COLUMNS表或
SHOW COLUMNS语句查看有关此表的列的其他信息，包括数据类型和默认值。
© Mysql 中文网
