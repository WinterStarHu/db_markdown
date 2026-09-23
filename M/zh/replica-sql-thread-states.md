# 8.14.6 复制 SQL 线程状态_MySQL 8.0 参考手册

8.14.6 复制 SQL 线程状态_MySQL 8.0 参考手册
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
8.1 优化概述
8.2 优化SQL语句
8.3 优化和索引
8.4 优化数据库结构
8.5 优化 InnoDB 表
8.6 优化 MyISAM 表
8.7 优化 MEMORY 表
8.8 了解查询执行计划
8.9 控制查询优化器
8.10 缓冲和缓存
8.11 优化锁定操作
8.12 优化MySQL服务器
8.13 测量性能（基准测试）
8.14 查看服务器线程（进程）信息
8.14.1 访问进程列表1
8.14.2 线程命令值1
8.14.3 一般线程状态1
8.14.4 复制源线程状态1
8.14.5 复制 I/O（接收器）线程状态1
8.14.6 复制 SQL 线程状态1
8.14.7 复制连接线程状态1
8.14.8 NDB Cluster 线程状态1
8.14.9 事件调度器线程状态1
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
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第8章优化  / 8.14 查看服务器线程（进程）信息  /
8.14.6 复制 SQL 线程状态
8.14.6 复制 SQL 线程状态
以下列表显示了您可能会在State副本服务器上的复制 SQL 线程的列中看到的最常见状态。
在 MySQL 8.0.26 中，对仪器名称进行了不兼容的更改，包括线程阶段的名称，其中包含术语“ master ”更改为
“ source ”，“ slave ”更改为
“ replica ”，以及“ mts ”（代表
“多线程从机”），改为
“ mta ”（代表“多线程应用程序”). 使用这些工具名称的监视工具可能会受到影响。如果不兼容的更改对您有影响，请将
terminology_use_previous系统变量设置为BEFORE_8_0_26以使 MySQL 服务器使用先前列表中指定的对象的旧版本名称。这使得依赖旧名称的监视工具能够继续工作，直到它们可以更新为使用新名称。
将
terminology_use_previous具有会话范围的系统变量设置为支持单个函数，或将全局范围设置为所有新会话的默认值。使用全局范围时，慢速查询日志包含名称的旧版本。
Making temporary file (append) before replaying
LOAD DATA INFILE
该线程正在执行一条LOAD
DATA语句并将数据附加到包含副本从中读取行的数据的临时文件。
Making temporary file (create) before replaying
LOAD DATA INFILE
该线程正在执行一条LOAD
DATA语句并正在创建一个临时文件，其中包含副本从中读取行的数据。LOAD DATA仅当原始语句由运行低于 MySQL 5.0.3 版本的 MySQL 的源记录
时，才会遇到此状态
。
Reading event from the relay log
该线程已从中继日志中读取了一个事件，以便可以处理该事件。
Slave has read all relay log; waiting for more
updates
从 MySQL 8.0.26 开始：Replica has read all relay log;
waiting for more updates
该线程已处理中继日志文件中的所有事件，现在正在等待 I/O（接收方）线程将新事件写入中继日志。
Waiting for an event from Coordinator
使用多线程副本（replica_parallel_workers
或slave_parallel_workers
大于 1），其中一个副本工作线程正在等待来自协调器线程的事件。
Waiting for slave mutex on exit
从 MySQL 8.0.26 开始：Waiting for replica mutex on
exit
线程停止时出现的非常短暂的状态。
Waiting for Slave Workers to free pending
events
从 MySQL 8.0.26 开始：Waiting for Replica Workers to
free pending events
当 Workers 正在处理的事件的总大小超过
replica_pending_jobs_size_max
or
slave_pending_jobs_size_max
系统变量的大小时，就会发生此等待操作。当大小低于此限制时，协调器将恢复调度。仅当
replica_parallel_workers或
slave_parallel_workers设置为大于 0 时才会出现此状态。
Waiting for the next event in relay log
之前的初始状态Reading event from the
relay log。
Waiting until MASTER_DELAY seconds after master
executed event
从 MySQL 8.0.26 开始：Waiting until SOURCE_DELAY
seconds after master executed event
SQL 线程已读取一个事件，但正在等待副本延迟结束。此延迟设置为
SOURCE_DELAY|
MASTER_DELAY语句的选项
CHANGE REPLICATION SOURCE TO
（来自 MySQL 8.0.23）或CHANGE
MASTER TO语句（MySQL 8.0.23 之前）。
SQL 线程的Info列也可能显示语句的文本。这表明线程已经从中继日志中读取了一个事件，从中提取了语句，并且可能正在执行它。
© Mysql 中文网
