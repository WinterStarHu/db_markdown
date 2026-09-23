# 27.17性能模式内存分配模型_MySQL 8.0 参考手册

27.17性能模式内存分配模型_MySQL 8.0 参考手册
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
27.17性能模式内存分配模型
27.17性能模式内存分配模型
Performance Schema 使用此内存分配模型：
可以在服务器启动时分配内存
可能在服务器运行期间分配额外的内存
在服务器运行期间永远不要释放内存（尽管它可能会被回收）
释放关机时使用的所有内存
结果是放宽了内存限制，以便可以使用更少的配置来使用性能模式，并减少内存占用，以便消耗随服务器负载而扩展。使用的内存取决于实际看到的负载，而不是估计或明确配置的负载。
几个 Performance Schema 大小调整参数是自动缩放的，不需要显式配置，除非您想对内存分配建立显式限制：
performance_schema_accounts_size
performance_schema_hosts_size
performance_schema_max_cond_instances
performance_schema_max_file_instances
performance_schema_max_index_stat
performance_schema_max_metadata_locks
performance_schema_max_mutex_instances
performance_schema_max_prepared_statements_instances
performance_schema_max_program_instances
performance_schema_max_rwlock_instances
performance_schema_max_socket_instances
performance_schema_max_table_handles
performance_schema_max_table_instances
performance_schema_max_table_lock_stat
performance_schema_max_thread_instances
performance_schema_users_size
对于自动缩放参数，配置工作如下：
将值设置为 -1（默认值）时，参数会自动缩放：
相应的内部缓冲区最初是空的，没有分配内存。
当 Performance Schema 收集数据时，会在相应的缓冲区中分配内存。缓冲区大小是无限的，可能会随着负载的增加而增长。
值设置为 0：
相应的内部缓冲区最初是空的，没有分配内存。
值设置为N> 0：
相应的内部缓冲区最初是空的，没有分配内存。
随着 Performance Schema 收集数据，在相应的缓冲区中分配内存，直到缓冲区大小达到N.
一旦缓冲区大小达到N，就不再分配内存。性能模式为此缓冲区收集的数据丢失，并且任何相应的“丢失实例”计数器都会增加。
要查看性能模式使用了多少内存，请检查为此目的设计的工具。Performance Schema 在内部分配内存并将每个缓冲区与专用仪器相关联，以便可以将内存消耗跟踪到各个缓冲区。以前缀命名的仪器
memory/performance_schema/公开了为这些内部缓冲区分配了多少内存。缓冲区对服务器来说是全局的，因此仪器仅显示在
memory_summary_global_by_event_name
表中，而不显示在其他
表中。
memory_summary_by_xxx_by_event_name
此查询显示与记忆仪器相关的信息：
SELECT * FROM performance_schema.memory_summary_global_by_event_name
WHERE EVENT_NAME LIKE 'memory/performance_schema/%';
© Mysql 中文网
