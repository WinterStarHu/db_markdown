# 15.17.3 InnoDB 标准监视器和锁定监视器输出_MySQL 8.0 参考手册

15.17.3 InnoDB 标准监视器和锁定监视器输出_MySQL 8.0 参考手册
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
15.17.1 InnoDB 监视器类型1
15.17.2 启用 InnoDB 监视器1
15.17.3 InnoDB 标准监视器和锁定监视器输出1
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.17 InnoDB 监视器  /
15.17.3 InnoDB 标准监视器和锁定监视器输出
15.17.3 InnoDB 标准监视器和锁定监视器输出
Lock Monitor 与 Standard Monitor 相同，只是它包含额外的锁信息。为周期性输出启用任一监视器会打开相同的输出流，但如果启用锁定监视器，则该流包含额外信息。例如，如果启用标准监视器和锁定监视器，则会打开单个输出流。在您禁用锁定监视器之前，该流包含额外的锁定信息。
SHOW ENGINE INNODB
STATUS使用该语句
生成时，标准监视器输出限制为 1MB
。此限制不适用于写入服务器标准错误输出 ( stderr) 的输出。
示例标准监视器输出：
mysql> SHOW ENGINE INNODB STATUS\G
*************************** 1. row ***************************
Type: InnoDB
Name:
Status:
=====================================
2018-04-12 15:14:08 0x7f971c063700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 4 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 15 srv_active, 0 srv_shutdown, 1122 srv_idle
srv_master_thread log flush and writes: 0
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 24
OS WAIT ARRAY INFO: signal count 24
RW-shared spins 4, rounds 8, OS waits 4
RW-excl spins 2, rounds 60, OS waits 2
RW-sx spins 0, rounds 0, OS waits 0
Spin rounds per wait: 2.00 RW-shared, 30.00 RW-excl, 0.00 RW-sx
------------------------
LATEST FOREIGN KEY ERROR
------------------------
2018-04-12 14:57:24 0x7f97a9c91700 Transaction:
TRANSACTION 7717, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
4 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 3
MySQL thread id 8, OS thread handle 140289365317376, query id 14 localhost root update
INSERT INTO child VALUES (NULL, 1), (NULL, 2), (NULL, 3), (NULL, 4), (NULL, 5), (NULL, 6)
Foreign key constraint fails for table `test`.`child`:
,
CONSTRAINT `child_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `parent` (`id`) ON DELETE
CASCADE ON UPDATE CASCADE
Trying to add in child table, in index par_ind tuple:
DATA TUPLE: 2 fields;
0: len 4; hex 80000003; asc     ;;
1: len 4; hex 80000003; asc     ;;
But in parent table `test`.`parent`, in index PRIMARY,
the closest match we can find is record:
PHYSICAL RECORD: n_fields 3; compact format; info bits 0
0: len 4; hex 80000004; asc     ;;
1: len 6; hex 000000001e19; asc       ;;
2: len 7; hex 81000001110137; asc       7;;
------------
TRANSACTIONS
------------
Trx id counter 7748
Purge done for trx's n:o < 7747 undo n:o < 0 state: running but idle
History list length 19
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 421764459790000, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 7747, ACTIVE 23 sec starting index read
mysql tables in use 1, locked 1
LOCK WAIT 2 lock struct(s), heap size 1136, 1 row lock(s)
MySQL thread id 9, OS thread handle 140286987249408, query id 51 localhost root updating
DELETE FROM t WHERE i = 1
------- TRX HAS BEEN WAITING 23 SEC FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 4 page no 4 n bits 72 index GEN_CLUST_INDEX of table `test`.`t`
trx id 7747 lock_mode X waiting
Record lock, heap no 3 PHYSICAL RECORD: n_fields 4; compact format; info bits 0
0: len 6; hex 000000000202; asc       ;;
1: len 6; hex 000000001e41; asc      A;;
2: len 7; hex 820000008b0110; asc        ;;
3: len 4; hex 80000001; asc     ;;
------------------
TABLE LOCK table `test`.`t` trx id 7747 lock mode IX
RECORD LOCKS space id 4 page no 4 n bits 72 index GEN_CLUST_INDEX of table `test`.`t`
trx id 7747 lock_mode X waiting
Record lock, heap no 3 PHYSICAL RECORD: n_fields 4; compact format; info bits 0
0: len 6; hex 000000000202; asc       ;;
1: len 6; hex 000000001e41; asc      A;;
2: len 7; hex 820000008b0110; asc        ;;
3: len 4; hex 80000001; asc     ;;
--------
FILE I/O
--------
I/O thread 0 state: waiting for i/o request (insert buffer thread)
I/O thread 1 state: waiting for i/o request (log thread)
I/O thread 2 state: waiting for i/o request (read thread)
I/O thread 3 state: waiting for i/o request (read thread)
I/O thread 4 state: waiting for i/o request (read thread)
I/O thread 5 state: waiting for i/o request (read thread)
I/O thread 6 state: waiting for i/o request (write thread)
I/O thread 7 state: waiting for i/o request (write thread)
I/O thread 8 state: waiting for i/o request (write thread)
I/O thread 9 state: waiting for i/o request (write thread)
Pending normal aio reads: [0, 0, 0, 0] , aio writes: [0, 0, 0, 0] ,
ibuf aio reads:, log i/o's:, sync i/o's:
Pending flushes (fsync) log: 0; buffer pool: 0
833 OS file reads, 605 OS file writes, 208 OS fsyncs
0.00 reads/s, 0 avg bytes/read, 0.00 writes/s, 0.00 fsyncs/s
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 0, seg size 2, 0 merges
merged operations:
insert 0, delete mark 0, delete 0
discarded operations:
insert 0, delete mark 0, delete 0
Hash table size 553253, node heap has 0 buffer(s)
Hash table size 553253, node heap has 1 buffer(s)
Hash table size 553253, node heap has 3 buffer(s)
Hash table size 553253, node heap has 0 buffer(s)
Hash table size 553253, node heap has 0 buffer(s)
Hash table size 553253, node heap has 0 buffer(s)
Hash table size 553253, node heap has 0 buffer(s)
Hash table size 553253, node heap has 0 buffer(s)
0.00 hash searches/s, 0.00 non-hash searches/s
---
LOG
---
Log sequence number          19643450
Log buffer assigned up to    19643450
Log buffer completed up to   19643450
Log written up to            19643450
Log flushed up to            19643450
Added dirty pages up to      19643450
Pages flushed up to          19643450
Last checkpoint at           19643450
129 log i/o's done, 0.00 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 2198863872
Dictionary memory allocated 409606
Buffer pool size   131072
Free buffers       130095
Database pages     973
Old database pages 0
Modified db pages  0
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 0, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 810, created 163, written 404
0.00 reads/s, 0.00 creates/s, 0.00 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 973, unzip_LRU len: 0
I/O sum[0]:cur[0], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   65536
Free buffers       65043
Database pages     491
Old database pages 0
Modified db pages  0
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 0, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 411, created 80, written 210
0.00 reads/s, 0.00 creates/s, 0.00 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 491, unzip_LRU len: 0
I/O sum[0]:cur[0], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   65536
Free buffers       65052
Database pages     482
Old database pages 0
Modified db pages  0
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 0, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 399, created 83, written 194
0.00 reads/s, 0.00 creates/s, 0.00 writes/s
No buffer pool page gets since the last printout
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 482, unzip_LRU len: 0
I/O sum[0]:cur[0], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
0 read views open inside InnoDB
Process ID=5772, Main thread ID=140286437054208 , state=sleeping
Number of rows inserted 57, updated 354, deleted 4, read 4421
0.00 inserts/s, 0.00 updates/s, 0.00 deletes/s, 0.00 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================
标准监听输出部分
有关标准监视器报告的每个指标的说明，请参阅
Oracle Enterprise Manager for MySQL Database 用户指南中的指标
一章
。
Status
此部分显示时间戳、监视器名称和每秒平均值所基于的秒数。秒数是当前时间和最后一次InnoDB打印监视器输出之间经过的时间。
BACKGROUND THREAD
这些srv_master_thread线显示了主后台线程完成的工作。
SEMAPHORES
本节报告等待信号量的线程以及有关线程需要自旋或等待互斥锁或 rw-lock 信号量的次数的统计信息。大量线程等待信号量可能是磁盘 I/O 的结果，或者是内部的争用问题InnoDB。争用可能是由于查询的严重并行性或操作系统线程调度中的问题。在这种情况下，将系统变量设置为
innodb_thread_concurrency
小于默认值可能会有所帮助。该Spin rounds per wait
行显示每个操作系统等待互斥锁的自旋锁轮数。
互斥指标由 报告
SHOW ENGINE
INNODB MUTEX。
LATEST FOREIGN KEY ERROR
本节提供有关最近的外键约束错误的信息。如果没有发生此类错误，则它不存在。内容包括失败的语句以及有关失败的约束以及引用和引用表的信息。
LATEST DETECTED DEADLOCK
本节提供有关最近死锁的信息。如果没有发生死锁，则它不存在。内容显示涉及哪些事务、每个试图执行的语句、它们拥有和需要的锁，以及InnoDB
决定回滚以打破死锁的事务。本节中报告的锁定模式在
第 15.7.1 节，“InnoDB 锁定”中进行了解释。
TRANSACTIONS
如果此部分报告锁等待，则您的应用程序可能存在锁争用。输出还可以帮助追踪事务死锁的原因。
FILE I/O
本节提供有关
InnoDB用于执行各种类型 I/O 的线程的信息。其中前几个专门用于一般
InnoDB处理。内容还显示挂起的 I/O 操作的信息和 I/O 性能的统计信息。
这些线程的数量由
innodb_read_io_threads和
innodb_write_io_threads
参数控制。请参阅第 15.14 节，“InnoDB 启动选项和系统变量”。
INSERT BUFFER AND ADAPTIVE HASH INDEX
此部分显示
InnoDB插入缓冲区（也称为更改缓冲区）和自适应哈希索引的状态。
有关相关信息，请参阅
第 15.5.2 节，“更改缓冲区”和
第 15.5.3 节，“自适应哈希索引”。
LOG
此部分显示有关
InnoDB日志的信息。内容包括当前日志序列号、日志已刷新到磁盘的距离以及
InnoDB最后一个检查点的位置。（请参阅
第 15.11.3 节，“InnoDB 检查点”。）该部分还显示有关挂起写入和写入性能统计信息的信息。
BUFFER POOL AND MEMORY
本节为您提供有关已读取和已写入页面的统计信息。您可以根据这些数字计算您的查询当前正在执行多少数据文件 I/O 操作。
有关缓冲池统计信息的描述，请参阅
使用 InnoDB 标准监视器监视缓冲池。有关缓冲池操作的其他信息，请参阅第 15.5.1 节，“缓冲池”。
ROW OPERATIONS
此部分显示主线程正在做什么，包括每种类型的行操作的数量和性能率。
© Mysql 中文网
