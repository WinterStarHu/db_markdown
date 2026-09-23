# 27.12.1 性能模式表参考_MySQL 8.0 参考手册

27.12.1 性能模式表参考_MySQL 8.0 参考手册
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
27.12.1 性能模式表参考1
27.12.2 性能模式设置表1
27.12.3 性能模式实例表1
27.12.4 性能模式等待事件表1
27.12.5 性能模式阶段事件表1
27.12.6 性能模式语句事件表1
27.12.7 性能模式事务表1
27.12.8 性能模式连接表1
27.12.9 性能模式连接属性表1
27.12.10 性能模式用户定义的变量表1
27.12.11 性能模式复制表1
27.12.12 Performance Schema NDB 集群表1
27.12.13 性能模式锁表1
27.12.14 性能模式系统变量表1
27.12.15 性能模式状态变量表1
27.12.16 性能模式线程池表1
27.12.17 性能模式防火墙表1
27.12.18 性能模式密钥环表1
27.12.19 性能模式克隆表1
27.12.20 性能模式汇总表1
27.12.21 性能模式杂表1
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
MySQL 8.0 参考手册  / 第 27 章 MySQL 性能模式  / 27.12 性能模式表描述  /
27.12.1 性能模式表参考
27.12.1 性能模式表参考
下表总结了所有可用的性能模式表。有关更多详细信息，请参阅各个表的说明。
表 27.1 性能模式表
表名
描述
介绍
accounts
每个客户帐户的连接统计
binary_log_transaction_compression_stats
二进制日志事务压缩
8.0.20
clone_progress
克隆操作进度
8.0.17
clone_status
克隆操作状态
8.0.17
cond_instances
同步对象实例
data_lock_waits
数据锁等待关系
data_locks
持有和请求的数据锁
error_log
服务器错误日志最近条目
8.0.22
events_errors_summary_by_account_by_error
每个帐户的错误和错误代码
events_errors_summary_by_host_by_error
每个主机的错误和错误代码
events_errors_summary_by_thread_by_error
每个线程的错误和错误代码
events_errors_summary_by_user_by_error
每个用户的错误和错误代码
events_errors_summary_global_by_error
每个错误代码的错误
events_stages_current
现阶段活动
events_stages_history
每个线程的最新阶段事件
events_stages_history_long
最近的舞台活动总体
events_stages_summary_by_account_by_event_name
每个帐户和事件名称的阶段事件
events_stages_summary_by_host_by_event_name
每个主机名和事件名称的阶段事件
events_stages_summary_by_thread_by_event_name
每个线程和事件名称的阶段等待
events_stages_summary_by_user_by_event_name
每个用户名和事件名称的舞台事件
events_stages_summary_global_by_event_name
每个事件名称的阶段等待
events_statements_current
当前语句事件
events_statements_histogram_by_digest
每个模式和摘要值的语句直方图
events_statements_histogram_global
全局汇总的语句直方图
events_statements_history
每个线程最近的语句事件
events_statements_history_long
总体上最近的声明事件
events_statements_summary_by_account_by_event_name
每个账户的报表事件和事件名称
events_statements_summary_by_digest
每个模式和摘要值的语句事件
events_statements_summary_by_host_by_event_name
每个主机名和事件名称的语句事件
events_statements_summary_by_program
每个存储程序的语句事件
events_statements_summary_by_thread_by_event_name
每个线程的语句事件和事件名称
events_statements_summary_by_user_by_event_name
每个用户名和事件名称的语句事件
events_statements_summary_global_by_event_name
每个事件名称的语句事件
events_transactions_current
当前交易事件
events_transactions_history
每个线程的最新事务事件
events_transactions_history_long
整体最近的交易事件
events_transactions_summary_by_account_by_event_name
每个账户的交易事件和事件名称
events_transactions_summary_by_host_by_event_name
每个主机名和事件名称的事务事件
events_transactions_summary_by_thread_by_event_name
每个线程的事务事件和事件名称
events_transactions_summary_by_user_by_event_name
每个用户名和事件名称的交易事件
events_transactions_summary_global_by_event_name
每个事件名称的交易事件
events_waits_current
当前等待事件
events_waits_history
每个线程最近的等待事件
events_waits_history_long
总体上最近的等待事件
events_waits_summary_by_account_by_event_name
每个帐户和事件名称的等待事件
events_waits_summary_by_host_by_event_name
每个主机名和事件名称的等待事件
events_waits_summary_by_instance
每个实例的等待事件
events_waits_summary_by_thread_by_event_name
每个线程和事件名称的等待事件
events_waits_summary_by_user_by_event_name
每个用户名和事件名称的等待事件
events_waits_summary_global_by_event_name
每个事件名称的等待事件
file_instances
文件实例
file_summary_by_event_name
每个事件名称的文件事件
file_summary_by_instance
每个文件实例的文件事件
firewall_group_allowlist
组配置文件白名单的防火墙内存数据
8.0.23
firewall_groups
组配置文件的防火墙内存数据
8.0.23
firewall_membership
组配置文件成员的防火墙内存数据
8.0.23
global_status
全局状态变量
global_variables
全局系统变量
host_cache
来自内部主机缓存的信息
hosts
每个客户端主机名的连接统计
keyring_component_status
已安装密钥环组件的状态信息
8.0.24
keyring_keys
密钥环密钥的元数据
8.0.16
log_status
有关用于备份目的的服务器日志的信息
memory_summary_by_account_by_event_name
每个帐户和事件名称的内存操作
memory_summary_by_host_by_event_name
每个主机和事件名称的内存操作
memory_summary_by_thread_by_event_name
每个线程和事件名称的内存操作
memory_summary_by_user_by_event_name
每个用户和事件名称的内存操作
memory_summary_global_by_event_name
每个事件名称的全局内存操作
metadata_locks
元数据锁和锁请求
mutex_instances
互斥同步对象实例
ndb_sync_excluded_objects
无法同步的 NDB 对象
8.0.21
ndb_sync_pending_objects
等待同步的 NDB 对象
8.0.21
objects_summary_global_by_type
对象摘要
performance_timers
哪些事件计时器可用
persisted_variables
mysqld-auto.cnf 文件的内容
prepared_statements_instances
准备好的语句实例和统计信息
processlist
进程列表信息
8.0.22
replication_applier_configuration
副本上复制应用程序的配置参数
replication_applier_filters
当前副本上特定于通道的复制过滤器
replication_applier_global_filters
当前副本上的全局复制过滤器
replication_applier_status
副本上复制应用程序的当前状态
replication_applier_status_by_coordinator
SQL 或协调器线程应用程序状态
replication_applier_status_by_worker
工作线程应用程序状态
replication_asynchronous_connection_failover
异步连接故障转移机制的源列表
8.0.22
replication_asynchronous_connection_failover_managed
异步连接故障转移机制的托管源列表
8.0.23
replication_connection_configuration
连接源的配置参数
replication_connection_status
与源连接的当前状态
replication_group_member_stats
复制组成员统计
replication_group_members
复制组成员网络和状态
rwlock_instances
锁定同步对象实例
session_account_connect_attrs
当前会话的每个连接属性
session_connect_attrs
所有会话的连接属性
session_status
当前会话的状态变量
session_variables
当前会话的系统变量
setup_actors
如何为新的前台线程初始化监控
setup_consumers
可以为其存储事件信息的消费者
setup_instruments
可以为其收集事件的检测对象的类
setup_objects
应该监控哪些对象
setup_threads
检测线程名称和属性
socket_instances
活动连接实例
socket_summary_by_event_name
每个事件名称的套接字等待和 I/O
socket_summary_by_instance
每个实例的套接字等待和 I/O
status_by_account
每个帐户的会话状态变量
status_by_host
每个主机名的会话状态变量
status_by_thread
每个会话的会话状态变量
status_by_user
每个用户名的会话状态变量
table_handles
表锁和锁请求
table_io_waits_summary_by_index_usage
每个索引的表 I/O 等待
table_io_waits_summary_by_table
每个表的表 I/O 等待
table_lock_waits_summary_by_table
每个表的表锁等待
threads
有关服务器线程的信息
tls_channel_status
每个连接接口的 TLS 状态
8.0.21
tp_thread_group_state
线程池线程组状态
8.0.14
tp_thread_group_stats
线程池线程组统计
8.0.14
tp_thread_state
线程池线程信息
8.0.14
user_defined_functions
注册的可加载函数
user_variables_by_thread
每个线程的用户定义变量
users
每个客户端用户名的连接统计
variables_by_thread
每个会话的会话系统变量
variables_info
最近如何设置系统变量
© Mysql 中文网
