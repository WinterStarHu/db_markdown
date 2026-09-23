# 27.12.20 性能模式汇总表_MySQL 8.0 参考手册

27.12.20 性能模式汇总表_MySQL 8.0 参考手册
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
27.12.20.1 等待事件汇总表
27.12.20.2 阶段汇总表
27.12.20.3 语句汇总表
27.12.20.4 语句直方图汇总表
27.12.20.5 交易汇总表
27.12.20.6 对象等待汇总表
27.12.20.7 文件 I/O 汇总表
27.12.20.8 表 I/O 和锁定等待汇总表
27.12.20.9 套接字汇总表
27.12.20.10 内存汇总表
27.12.20.11 错误汇总表
27.12.20.12 状态变量汇总表
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
27.12.20 性能模式汇总表
27.12.20 性能模式汇总表
27.12.20.1 等待事件汇总表27.12.20.2 阶段汇总表27.12.20.3 语句汇总表27.12.20.4 语句直方图汇总表27.12.20.5 交易汇总表27.12.20.6 对象等待汇总表27.12.20.7 文件 I/O 汇总表27.12.20.8 表 I/O 和锁定等待汇总表27.12.20.9 套接字汇总表27.12.20.10 内存汇总表27.12.20.11 错误汇总表27.12.20.12 状态变量汇总表
摘要表提供了随时间推移终止的事件的汇总信息。该组中的表以不同方式总结事件数据。
每个汇总表都具有确定如何对要聚合的数据进行分组的分组列，以及包含聚合值的汇总列。以类似方式汇总事件的表通常具有相似的汇总列集，并且仅在用于确定事件聚合方式的分组列方面有所不同。
可以使用 截断汇总表
TRUNCATE TABLE。通常，效果是将汇总列重置为 0 或
NULL，而不是删除行。这使您能够清除收集的值并重新启动聚合。这可能很有用，例如，在您更改了运行时配置之后。此截断行为的例外情况在各个汇总表部分中注明。
等待事件摘要
表 27.7 性能模式等待事件汇总表
表名
描述
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
阶段总结
表 27.8 性能模式阶段事件汇总表
表名
描述
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
报表摘要
表 27.9 性能模式语句事件汇总表
表名
描述
events_statements_histogram_by_digest
每个模式和摘要值的语句直方图
events_statements_histogram_global
全局汇总的语句直方图
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
prepared_statements_instances
准备好的语句实例和统计信息
交易摘要
表 27.10 性能模式事务事件汇总表
表名
描述
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
对象等待摘要
表 27.11 性能模式对象事件汇总表
表名
描述
objects_summary_global_by_type
对象摘要
文件 I/O 总结
表 27.12 性能模式文件 I/O 事件汇总表
表名
描述
file_summary_by_event_name
每个事件名称的文件事件
file_summary_by_instance
每个文件实例的文件事件
表 I/O 和锁定等待摘要
表 27.13 性能模式表 I/O 和锁定等待事件汇总表
表名
描述
table_io_waits_summary_by_index_usage
每个索引的表 I/O 等待
table_io_waits_summary_by_table
每个表的表 I/O 等待
table_lock_waits_summary_by_table
每个表的表锁等待
套接字摘要
表 27.14 性能模式套接字事件汇总表
表名
描述
socket_summary_by_event_name
每个事件名称的套接字等待和 I/O
socket_summary_by_instance
每个实例的套接字等待和 I/O
记忆摘要
表 27.15 性能模式内存操作汇总表
表名
描述
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
错误摘要
表 27.16 性能模式错误汇总表
表名
描述
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
状态变量摘要
表 27.17 性能模式错误状态变量汇总表
表名
描述
status_by_account
每个帐户的会话状态变量
status_by_host
每个主机名的会话状态变量
status_by_user
每个用户名的会话状态变量
© Mysql 中文网
