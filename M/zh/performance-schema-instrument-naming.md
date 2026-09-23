# 27.6 性能模式工具命名约定_MySQL 8.0 参考手册

27.6 性能模式工具命名约定_MySQL 8.0 参考手册
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
27.1 性能模式快速入门
27.2 性能模式构建配置
27.3 性能模式启动配置
27.4 性能模式运行时配置
27.5 性能模式查询
27.6 性能模式工具命名约定
27.7 性能模式状态监控
27.8 性能模式原子和分子事件
27.9 当前和历史事件的性能模式表
27.10 性能模式语句摘要和采样
27.11 性能模式总表特征
27.12 性能模式表描述
27.13 性能模式选项和变量引用
27.14 性能模式命令选项
27.15 性能模式系统变量
27.16 性能模式状态变量
27.17性能模式内存分配模型
27.18 性能模式和插件
27.19 使用性能模式诊断问题
27.20 性能模式的限制
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 27 章 MySQL 性能模式  /
27.6 性能模式工具命名约定
27.6 性能模式工具命名约定
仪器名称由一系列由
'/'字符分隔的元素组成。示例名称：
wait/io/file/myisam/log
wait/io/file/mysys/charset
wait/lock/table/sql/handler
wait/synch/cond/mysys/COND_alarm
wait/synch/cond/sql/BINLOG::update_cond
wait/synch/mutex/mysys/BITMAP_mutex
wait/synch/mutex/sql/LOCK_delete
wait/synch/rwlock/sql/Query_cache_query::lock
stage/sql/closing tables
stage/sql/Sorting result
statement/com/Execute
statement/com/Query
statement/sql/create_table
statement/sql/lock_tables
errors
仪器名称空间具有树状结构。乐器名称的元素从左到右提供了从更一般到更具体的进展。名称中元素的数量取决于乐器的类型。
名称中给定元素的解释取决于其左侧的元素。例如，myisam
出现在以下两个名称中，但
myisam第一个名称与文件 I/O 相关，而第二个名称与同步工具相关：
wait/io/file/myisam/log
wait/synch/cond/myisam/MI_SORT_INFO::cond
仪器名称由具有由性能模式实现定义的结构的前缀和由实现仪器代码的开发人员定义的后缀组成。仪器前缀的顶级元素表示仪器的类型。此元素还确定
performance_timers表中的哪个事件计时器适用于仪器。对于仪器名称的前缀部分，顶层表示仪器的类型。
乐器名称的后缀部分来自乐器本身的代码。后缀可能包括以下级别：
主要元素的名称（服务器模块，例如
myisam、innodb、
mysys或sql）或插件名称。
代码中变量的名称，形式
XXX为（全局变量）或
（类中
的成员）。例子：
,
,
。
CCC::MMMMMMCCCCOND_thread_cacheTHR_LOCK_myisamBINLOG::LOCK_index
顶级仪器元件空闲乐器元素误差仪器元件记忆仪器元件舞台乐器元素声明工具元素螺纹仪表元件等待乐器元素
顶级仪器元件
idle：检测空闲事件。该仪器没有其他元素。
error：检测错误事件。该仪器没有其他元素。
memory：一个检测内存事件。
stage: 仪器舞台活动。
statement：一个检测语句事件。
transaction：一个检测交易事件。该仪器没有其他元素。
wait：检测等待事件。
空闲乐器元素
该idle仪器用于空闲事件，如第 27.12.3.5 节，“socket_instances 表”socket_instances.STATE中的
列
描述中所讨论的那样，Performance Schema 会生成这些事件。
误差仪器元件
该error仪器指示是否收集服务器错误和警告的信息。默认情况下启用此仪器。表中行的
列TIMED
不适用，因为未收集时间信息。
errorsetup_instruments
记忆仪器元件
默认情况下启用内存检测。内存检测可以在启动时启用或禁用，或者在运行时动态地通过更新
表ENABLED中相关仪器的列来启用或禁用setup_instruments。记忆仪器具有形式的名称，
其中是一个值，例如
或，并且
是仪器详细信息。
memory/code_area/instrument_namecode_areasqlmyisaminstrument_name
以前缀命名的仪器
memory/performance_schema/公开了为性能模式中的内部缓冲区分配了多少内存。这些memory/performance_schema/
仪器是内置的，始终启用，并且不能在启动或运行时禁用。内置记忆仪器仅在
memory_summary_global_by_event_name
表格中显示。有关详细信息，请参阅
第 27.17 节，“性能模式内存分配模型”。
舞台乐器元素
阶段工具的名称形式为
，其中是一个值，例如
或，
表示语句处理的阶段，例如
或。阶段对应于表中显示的或可见
的线程状态
。
stage/code_area/stage_namecode_areasqlmyisamstage_nameSorting resultSending dataSHOW
PROCESSLISTINFORMATION_SCHEMA.PROCESSLIST
声明工具元素
statement/abstract/*: 语句操作的抽象工具。在确切语句类型未知之前，在语句分类的早期阶段使用抽象工具，然后在类型已知时更改为更具体的语句工具。有关此过程的描述，请参阅
第 27.12.6 节，“性能模式语句事件表”。
statement/com：检测命令操作。这些具有与操作对应的名称
（请参阅头文件和。例如，和
工具对应于和
命令。
COM_xxxmysql_com.hsql/sql_parse.ccstatement/com/Connectstatement/com/Init DBCOM_CONNECTCOM_INIT_DB
statement/scheduler/event：用于跟踪事件调度程序执行的所有事件的单一工具。当预定事件开始执行时，该工具开始发挥作用。
statement/sp：由存储程序执行的检测内部指令。例如，
statement/sp/cfetch和
statement/sp/freturn工具用于游标提取和函数返回指令。
statement/sql：检测的 SQL 语句操作。例如，
statement/sql/create_dband
statement/sql/select工具用于CREATE DATABASEand
SELECT语句。
螺纹仪表元件
检测线程显示在
setup_threads表中，它公开了线程类名称和属性。
thread螺纹工具以（例如，thread/sql/parser_service或
）
开头thread/performance_schema/setup。
插件线程的线程工具名称
以;ndbcluster开头
thread/ndbcluster/有关这些的更多信息，请参阅ndbcluster 插件线程。
等待乐器元素
wait/io
检测 I/O 操作。
wait/io/file
检测文件 I/O 操作。对于文件，等待是等待文件操作完成的时间（例如，调用fwrite()）。由于缓存，磁盘上的物理文件 I/O 可能不会在此调用中发生。
wait/io/socket
检测套接字操作。套接字工具的名称为
. 服务器为其支持的每个网络协议都有一个侦听套接字。与用于 TCP/IP 或 Unix 套接字文件连接的侦听套接字关联的工具分别具有
或
值
。当侦听套接字检测到连接时，服务器会将连接传输到由单独线程管理的新套接字。新连接螺纹的仪器
值为.
wait/io/socket/sql/socket_typesocket_typeserver_tcpip_socketserver_unix_socketsocket_typeclient_connection
wait/io/table
检测表 I/O 操作。这些包括对持久基表或临时表的行级访问。影响行的操作是获取、插入、更新和删除。对于视图，等待与视图引用的基表相关联。
与大多数等待不同，表 I/O 等待可以包括其他等待。例如，表 I/O 可能包括文件 I/O 或内存操作。因此，
events_waits_current对于表 I/O 等待通常有两行。有关详细信息，请参阅
第 27.8 节，“性能模式原子和分子事件”。
某些行操作可能会导致多个表 I/O 等待。例如，插入可能会激活导致更新的触发器。
wait/lock
检测锁定操作。
wait/lock/table
检测表锁定操作。
wait/lock/metadata/sql/mdl
检测元数据锁定操作。
wait/synch
一个检测的同步对象。对于同步对象，该TIMER_WAIT时间包括尝试获取对象锁时阻塞的时间量（如果有）。
wait/synch/cond
一个线程使用一个条件来向其他线程发出信号，表明它们正在等待的事情已经发生。如果单个线程正在等待一个条件，它可以唤醒并继续执行。如果有多个线程在等待，它们都可以醒来并竞争它们正在等待的资源。
wait/synch/mutex
一种互斥对象，用于允许访问资源（例如一段可执行代码）同时防止其他线程访问该资源。
wait/synch/prlock
优先级rwlock
锁对象。
wait/synch/rwlock
一个普通的读/写锁对象，用于锁定特定变量以供访问，同时防止其他线程使用它。一个共享读锁可以被多个线程同时获取。独占写锁一次只能由一个线程获取。
wait/synch/sxlock
共享独占 (SX) 锁是一种
rwlock锁对象，它提供对公共资源的写访问，同时允许其他线程进行不一致的读取。
sxlocks优化并发性并提高读写工作负载的可扩展性。
© Mysql 中文网
