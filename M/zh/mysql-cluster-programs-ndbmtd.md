# 23.5.3 ndbmtd — NDB Cluster 数据节点守护进程（多线程）_MySQL 8.0 参考手册

23.5.3 ndbmtd — NDB Cluster 数据节点守护进程（多线程）_MySQL 8.0 参考手册
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
23.5.1 ndbd — NDB Cluster 数据节点守护进程1
23.5.2 ndbinfo_select_all — 从 ndbinfo 表中选择1
23.5.3 ndbmtd — NDB Cluster 数据节点守护进程（多线程）1
23.5.4 ndb_mgmd — NDB 集群管理服务器守护进程1
23.5.5 ndb_mgm — NDB 集群管理客户端1
23.5.6 ndb_blob_tool — 检查和修复 NDB 集群表的 BLOB 和 TEXT 列1
23.5.7 ndb_config — 提取 NDB Cluster 配置信息1
23.5.8 ndb_delete_all — 从 NDB 表中删除所有行1
23.5.9 ndb_desc — 描述 NDB 表1
23.5.10 ndb_drop_index — 从 NDB 表中删除索引1
23.5.11 ndb_drop_table — 删除 NDB 表1
23.5.12 ndb_error_reporter — NDB 错误报告实用程序1
23.5.13 ndb_import — 将 CSV 数据导入 NDB1
23.5.14 ndb_index_stat — NDB 索引统计实用程序1
23.5.15 ndb_move_data — NDB 数据复制实用程序1
23.5.16 ndb_perror — 获取 NDB 错误消息信息1
23.5.17 ndb_print_backup_file — 打印 NDB 备份文件内容1
23.5.18 ndb_print_file — 打印 NDB 磁盘数据文件内容1
23.5.19 ndb_print_frag_file — 打印 NDB 片段列表文件内容1
23.5.20 ndb_print_schema_file — 打印 NDB 模式文件内容1
23.5.21 ndb_print_sys_file — 打印 NDB 系统文件内容1
23.5.22 ndb_redo_log_reader - 检查和打印集群重做日志的内容1
23.5.23 ndb_restore — 恢复 NDB Cluster 备份1
23.5.24 ndb_secretsfile_reader — 从加密的 NDB 数据文件中获取密钥信息1
23.5.25 ndb_select_all — 从 NDB 表打印行1
23.5.26 ndb_select_count — 打印 NDB 表的行数1
23.5.27 ndb_show_tables — 显示 NDB 表列表1
23.5.28 ndb_size.pl — NDBCLUSTER 大小需求估计器1
23.5.29 ndb_top — 查看 NDB 线程的 CPU 使用信息1
23.5.30 ndb_waiter — 等待 NDB Cluster 达到给定状态1
23.5.31 ndbxfrm — 压缩、解压缩、加密和解密 NDB Cluster 创建的文件1
23.6 NDB Cluster的管理
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.5 NDB 集群程序  /
23.5.3 ndbmtd — NDB Cluster 数据节点守护进程（多线程）
23.5.3 ndbmtd — NDB Cluster 数据节点守护进程（多线程）
ndbmtd是
ndbd的多线程版本，该进程用于使用
NDBCLUSTER存储引擎处理表中的所有数据。
ndbmtd旨在用于具有多个 CPU 内核的主机。除非另有说明，否则
ndbmtd的功能与ndbd相同
；因此，在本节中，我们专注于ndbmtd
与ndbd的不同之处，您应该查阅
第 23.5.1 节，“ndbd — NDB Cluster 数据节点守护程序”，有关运行适用于数据节点进程的单线程和多线程版本的 NDB Cluster 数据节点的其他信息。
与ndbd
一起使用的命令行选项和配置参数
也适用于ndbmtd。有关这些选项和参数的更多信息，请分别参阅
第 23.5.1 节，“ndbd - NDB Cluster 数据节点守护程序”和
第 23.4.3.6 节，“定义 NDB Cluster 数据节点”。
ndbmtd也与文件系统兼容
ndbd。换句话说，
可以停止
运行ndbd的数据节点，用ndbmtd替换二进制文件，然后重新启动而不会丢失任何数据。（但是，在执行此操作时，如果您希望ndbmtd以多线程方式运行必须确保
MaxNoOfExecutionThreads
在重新启动节点之前将其设置为适当的值只需停止节点即可将ndbmtd二进制文件替换为ndbd并且然后启动ndbd代替多线程二进制文件。在两者之间切换时没有必要使用启动数据节点二进制文件
--initial。
在两个关键方面
使用ndbmtd与使用
ndbd不同：
因为ndbmtd默认以单线程模式运行（也就是说，它的行为类似于
ndbd），您必须将其配置为使用多线程。这可以通过在config.ini文件中为
MaxNoOfExecutionThreads
配置参数或
ThreadConfig
配置参数设置适当的值来完成。使用
起来MaxNoOfExecutionThreads更简单，但
ThreadConfig提供了更大的灵活性。有关这些配置参数及其使用的更多信息，请参阅
多线程配置参数 (ndbmtd)。
跟踪文件是由
ndbmtd进程中的严重错误生成的，其方式与ndbd故障生成这些文件的方式有些不同
。这些差异将在接下来的几段中进行更详细的讨论。
与ndbd一样，ndbmtd
生成一组日志文件，这些文件放置在配置文件中指定的目录DataDir中config.ini。除了跟踪文件，这些文件的生成方式和名称与ndbd生成的文件相同。
如果出现严重错误，ndbmtd 会
生成跟踪文件，描述错误发生之前发生的情况。这些文件可以在数据节点中找到，
DataDir对于 NDB Cluster 开发和支持团队分析问题很有用。为每个
ndbmtd线程生成一个跟踪文件。这些文件的名称具有以下模式：
ndb_node_id_trace.log.trace_id_tthread_id,
在这个模式中，node_id代表数据节点在集群中的唯一节点ID，
trace_id是跟踪序列号，thread_id是线程ID。例如，如果
作为节点 ID 为 3 且
等于 4的 NDB Cluster 数据节点运行
的ndbmtd进程出现故障，则会在数据节点的数据目录中生成四个跟踪文件。MaxNoOfExecutionThreads如果这是此节点第一次出现故障，则这些文件将命名为
ndb_3_trace.log.1_t1、
ndb_3_trace.log.1_t2、
ndb_3_trace.log.1_t3和
ndb_3_trace.log.1_t4。在内部，这些跟踪文件遵循与ndbd跟踪文件相同的格式
。
ndbmtd也使用数据节点进程过早关闭时生成
的ndbd退出代码和消息。有关这些的列表，
请参阅
数据节点错误消息。
笔记
可以在同一 NDB Cluster 中的不同数据节点上同时
使用ndbd和
ndbmtd 。但是，此类配置尚未经过广泛测试；因此，我们目前不建议在生产环境中这样做。
© Mysql 中文网
