# 27.7 性能模式状态监控_MySQL 8.0 参考手册

27.7 性能模式状态监控_MySQL 8.0 参考手册
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
27.7 性能模式状态监控
27.7 性能模式状态监控
有几个与性能模式相关的状态变量：
mysql> SHOW STATUS LIKE 'perf%';
+-----------------------------------------------+-------+
| Variable_name                                 | Value |
+-----------------------------------------------+-------+
| Performance_schema_accounts_lost              | 0     |
| Performance_schema_cond_classes_lost          | 0     |
| Performance_schema_cond_instances_lost        | 0     |
| Performance_schema_digest_lost                | 0     |
| Performance_schema_file_classes_lost          | 0     |
| Performance_schema_file_handles_lost          | 0     |
| Performance_schema_file_instances_lost        | 0     |
| Performance_schema_hosts_lost                 | 0     |
| Performance_schema_locker_lost                | 0     |
| Performance_schema_memory_classes_lost        | 0     |
| Performance_schema_metadata_lock_lost         | 0     |
| Performance_schema_mutex_classes_lost         | 0     |
| Performance_schema_mutex_instances_lost       | 0     |
| Performance_schema_nested_statement_lost      | 0     |
| Performance_schema_program_lost               | 0     |
| Performance_schema_rwlock_classes_lost        | 0     |
| Performance_schema_rwlock_instances_lost      | 0     |
| Performance_schema_session_connect_attrs_lost | 0     |
| Performance_schema_socket_classes_lost        | 0     |
| Performance_schema_socket_instances_lost      | 0     |
| Performance_schema_stage_classes_lost         | 0     |
| Performance_schema_statement_classes_lost     | 0     |
| Performance_schema_table_handles_lost         | 0     |
| Performance_schema_table_instances_lost       | 0     |
| Performance_schema_thread_classes_lost        | 0     |
| Performance_schema_thread_instances_lost      | 0     |
| Performance_schema_users_lost                 | 0     |
+-----------------------------------------------+-------+
Performance Schema 状态变量提供有关由于内存限制而无法加载或创建的检测的信息。这些变量的名称有多种形式：
Performance_schema_xxx_classes_lostxxx指示无法加载
多少类型的仪器
。
Performance_schema_xxx_instances_lost
表示有多少对象类型的实例
xxx无法创建。
Performance_schema_xxx_handles_lost
表示有多少对象类型的实例
xxx无法打开。
Performance_schema_locker_lost表示有多少事件“丢失”或未记录。
例如，如果在服务器源中检测了互斥锁，但服务器无法在运行时为检测分配内存，它会递增
Performance_schema_mutex_classes_lost. 互斥量仍然作为同步对象（即服务器继续正常运行），但不会收集它的性能数据。如果可以分配仪器，则可以将其用于初始化检测互斥实例。对于全局互斥锁这样的单例互斥锁，只有一个实例。其他互斥量在各种缓存和数据缓冲区中的每个连接或每个页面都有一个实例，因此实例的数量会随时间变化。增加最大连接数或某些缓冲区的最大大小会增加一次可能分配的最大实例数。如果服务器无法创建给定的检测互斥锁实例，它会递增
Performance_schema_mutex_instances_lost.
假设满足以下条件：
服务器以
--performance_schema_max_mutex_classes=200
选项启动，因此有空间容纳 200 个互斥工具。
已经加载了 150 个互斥工具。
名为的插件plugin_a包含 40 个互斥工具。
命名的插件plugin_b包含 20 个互斥工具。
服务器根据插件需要的数量和可用的数量为插件分配互斥工具，如以下语句序列所示：
INSTALL PLUGIN plugin_a
服务器现在有 150+40 = 190 个互斥工具。
UNINSTALL PLUGIN plugin_a;
服务器仍然有 190 个仪器。插件代码生成的所有历史数据仍然可用，但不会收集仪器的新事件。
INSTALL PLUGIN plugin_a;
服务器检测到这 40 个 instruments 已经被定义，所以没有创建新的 instruments，并且重新使用之前分配的内部内存缓冲区。服务器仍然有 190 个仪器。
INSTALL PLUGIN plugin_b;
服务器有空间容纳 200-190 = 10 个工具（在本例中为互斥类），并看到插件包含 20 个新工具。装载了 10 台仪器，丢弃或
“丢失”了 10 台。”指示丢失的
Performance_schema_mutex_classes_lost
工具（互斥类）数量：
mysql> SHOW STATUS LIKE "perf%mutex_classes_lost";
+---------------------------------------+-------+
| Variable_name                         | Value |
+---------------------------------------+-------+
| Performance_schema_mutex_classes_lost | 10    |
+---------------------------------------+-------+
1 row in set (0.10 sec)
检测仍然有效并为 收集（部分）数据
plugin_b。
当服务器无法创建互斥工具时，会出现以下结果：
没有仪器的行被插入到
setup_instruments表中。
Performance_schema_mutex_classes_lost
增加 1。
Performance_schema_mutex_instances_lost
没有改变。（当未创建互斥工具时，它不能用于稍后创建检测互斥实例。）
刚刚描述的模式适用于所有类型的工具，而不仅仅是互斥锁。
Performance_schema_mutex_classes_lost
在两种情况下可能会出现大于 0
的值
：
为了节省几个字节的内存，您可以使用 启动服务器
，其中小于默认值。选择的默认值足以加载 MySQL 发行版中提供的所有插件，但如果从未加载某些插件，则可以减少此值。例如，您可能选择不加载发行版中的某些存储引擎。
--performance_schema_max_mutex_classes=NN
您加载了为性能模式检测的第三方插件，但在启动服务器时不允许插件的检测内存要求。因为它来自第三方，所以该引擎的仪器内存消耗未计入为 所选的默认值
performance_schema_max_mutex_classes。
如果服务器没有足够的资源用于插件的乐器，并且您没有明确分配更多 using
，则加载插件会导致乐器饥饿。
--performance_schema_max_mutex_classes=N
如果选择的值
performance_schema_max_mutex_classes
太小，错误日志中不会报告错误，运行时也不会失败。但是，数据库中表的内容
performance_schema丢失了事件。状态变量是唯一可见的
Performance_schema_mutex_classes_lost
标志，表明某些事件由于未能创建仪器而在内部被丢弃。
如果仪器没有丢失，性能模式就会知道它，并在检测实例时使用。例如，
wait/synch/mutex/sql/LOCK_delete是
setup_instruments表中互斥工具的名称。在代码中创建互斥体时使用这个单一工具（在 中
THD::LOCK_delete），但是在服务器运行时需要互斥体的许多实例。在这种情况下，
LOCK_delete是每个连接 ( THD) 的互斥锁，因此如果服务器有 1000 个连接，则有 1000 个线程和 1000 个检测
LOCK_delete互斥锁实例 ( THD::LOCK_delete)。
如果服务器没有空间容纳所有这 1000 个经过检测的互斥锁（实例），则一些互斥锁是使用检测创建的​​，而另一些互斥锁是在没有检测的情况下创建的。如果服务器只能创建 800 个实例，则将丢失 200 个实例。服务器继续运行，但增加
Performance_schema_mutex_instances_lost
200 以指示无法创建实例。
Performance_schema_mutex_instances_lost
当代码在运行时初始化的互斥量多于为 分配的互斥量时，可能会出现大于 0
的值
。
--performance_schema_max_mutex_instances=N
最重要的是，如果
SHOW STATUS LIKE
'perf%'说没有丢失任何东西（所有值均为零），则性能模式数据是准确的并且可以依赖。如果丢失了某些东西，则数据不完整，并且由于分配给它的内存量不足，Performance Schema 无法记录所有内容。在这种情况下，特定
变量指示问题区域。
Performance_schema_xxx_lost
在某些情况下，故意造成仪器饥饿可能是合适的。例如，如果您不关心文件 I/O 的性能数据，则可以将与文件 I/O 相关的所有 Performance Schema 参数设置为 0 来启动服务器。不为文件相关的类、实例或句柄，所有文件事件都将丢失。
用于SHOW ENGINE
PERFORMANCE_SCHEMA STATUS检查 Performance Schema 代码的内部运行：
mysql> SHOW ENGINE PERFORMANCE_SCHEMA STATUS\G
...
*************************** 3. row ***************************
Type: performance_schema
Name: events_waits_history.size
Status: 76
*************************** 4. row ***************************
Type: performance_schema
Name: events_waits_history.count
Status: 10000
*************************** 5. row ***************************
Type: performance_schema
Name: events_waits_history.memory
Status: 760000
...
*************************** 57. row ***************************
Type: performance_schema
Name: performance_schema.memory
Status: 26459600
...
此声明旨在帮助 DBA 了解不同的性能模式选项对内存需求的影响。有关字段含义的说明，请参阅
第 13.7.7.15 节，“SHOW ENGINE 语句”。
© Mysql 中文网
