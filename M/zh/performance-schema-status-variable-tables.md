# 27.12.15 性能模式状态变量表_MySQL 8.0 参考手册

27.12.15 性能模式状态变量表_MySQL 8.0 参考手册
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
27.12.15 性能模式状态变量表
27.12.15 性能模式状态变量表
MySQL 服务器维护许多提供有关其操作信息的状态变量（请参阅
第 5.1.10 节，“服务器状态变量”）。这些性能模式表中提供了状态变量信息：
global_status：全局状态变量。只需要全局值的应用程序应该使用此表。
session_status：当前会话的状态变量。需要其自己的会话的所有状态变量值的应用程序应使用此表。它包括其会话的会话变量，以及没有会话对应项的全局变量的值。
status_by_thread：每个活动会话的会话状态变量。想要了解特定会话的会话变量值的应用程序应该使用此表。它仅包含会话变量，由线程 ID 标识。
还有汇总表提供按帐户、主机名和用户名聚合的状态变量信息。请参阅
第 27.12.20.12 节，“状态变量汇总表”。
会话变量表 ( session_status,
status_by_thread) 仅包含活动会话的信息，不包含终止会话的信息。
INSTRUMENTED性能模式仅为值YES
在threads表中
的线程收集全局状态变量的统计信息
。始终收集会话状态变量的统计信息，无论其INSTRUMENTED值如何。
Performance Schema 不收集
状态变量表中状态变量的统计信息。要获取全局和每会话语句执行计数，请分别使用
和
表。例如：
Com_xxxevents_statements_summary_global_by_event_nameevents_statements_summary_by_thread_by_event_nameSELECT EVENT_NAME, COUNT_STAR
FROM performance_schema.events_statements_summary_global_by_event_name
WHERE EVENT_NAME LIKE 'statement/sql/%';global_status和
session_status表有以下列
：
VARIABLE_NAME
状态变量名称。
VARIABLE_VALUE
状态变量值。对于
global_status，此列包含全局值。对于
session_status，此列包含当前会话的变量值。
global_status和
表具有
以下session_status索引：
VARIABLE_NAME( )
上的主键
该status_by_thread表包含每个活动线程的状态。它有这些列：
THREAD_ID
定义状态变量的会话的线程标识符。
VARIABLE_NAME
状态变量名称。
VARIABLE_VALUE
列命名的会话的会话变量值
THREAD_ID。
该status_by_thread表具有以下索引：
THREAD_ID( ,
VARIABLE_NAME)
上的主键
该status_by_thread表仅包含有关前台线程的状态变量信息。如果
performance_schema_max_thread_instances
系统变量不是自动缩放的（由值 −1 ​​表示）并且检测线程对象的最大允许数量不大于后台线程的数量，则该表为空。
性能模式支持TRUNCATE
TABLE状态变量表如下：
global_status：重置线程、帐户、主机和用户状态。重置全局状态变量，服务器从不重置的变量除外。
session_status： 不支持。
status_by_thread：将所有线程的状态聚合到全局状态和帐户状态，然后重置线程状态。如果不收集帐户统计信息，如果收集了主机和用户状态，则将会话状态添加到主机和用户状态。
performance_schema_accounts_size如果、
performance_schema_hosts_size和
performance_schema_users_size
系统变量分别设置为 0，
则不会收集帐户、主机和用户统计信息
。
FLUSH STATUS将所有活动会话的会话状态添加到全局状态变量，重置所有活动会话的状态，并重置从断开连接的会话聚合的帐户、主机和用户状态值。
© Mysql 中文网
