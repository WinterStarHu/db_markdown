# 27.4.8 消费者配置示例_MySQL 8.0 参考手册

27.4.8 消费者配置示例_MySQL 8.0 参考手册
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
27.4.1 性能模式事件时序1
27.4.2 性能模式事件过滤1
27.4.3 事件预过滤1
27.4.4 按仪器预过滤1
27.4.5 按对象预过滤1
27.4.6 按线程预过滤1
27.4.7 消费者预过滤1
27.4.8 消费者配置示例1
27.4.9 过滤操作的命名工具或消费者1
27.4.10 确定检测的是什么1
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
MySQL 8.0 参考手册  / 第 27 章 MySQL 性能模式  / 27.4 性能模式运行时配置  /
27.4.8 消费者配置示例
27.4.8 消费者配置示例
表中的消费者设置
setup_consumers形成了从高到低的层次结构。以下讨论描述了消费者如何工作，显示了特定配置及其在消费者设置从高到低逐渐启用时的效果。显示的消费者价值具有代表性。此处描述的一般原则适用于其他可用的消费者价值观。
配置描述按照增加的功能和开销的顺序出现。如果您不需要通过启用较低级别设置提供的信息，请禁用它们，以便性能模式代表您执行更少的代码，并且需要筛选的信息更少。
该setup_consumers表包含以下值层次结构：
global_instrumentation
thread_instrumentation
events_waits_current
events_waits_history
events_waits_history_long
events_stages_current
events_stages_history
events_stages_history_long
events_statements_current
events_statements_history
events_statements_history_long
events_transactions_current
events_transactions_history
events_transactions_history_long
statements_digest
笔记
在消费者层次结构中，等待、阶段、语句和事务的消费者都在同一级别。这不同于事件嵌套层次结构，等待事件嵌套在阶段事件中，嵌套在语句事件中，嵌套在事务事件中。
如果给定的消费者设置为NO，则性能模式会禁用与消费者关联的检测并忽略所有较低级别的设置。如果给定设置为YES，则性能模式启用与其关联的检测并检查下一个最低级别的设置。有关每个消费者规则的描述，请参阅
第 27.4.7 节，“消费者预过滤”。
例如，如果global_instrumentation启用，thread_instrumentation则选中。如果thread_instrumentation启用，
则检查消费者。如果
启用了这些，
并
进行了检查。
events_xxx_currentevents_waits_currentevents_waits_historyevents_waits_history_long
以下每个配置描述都指示性能模式检查哪些设置元素以及它维护哪些输出表（即，它为哪些表收集信息）。
无仪表仅限全球仪器仅限全局和线程检测全局、线程和当前事件检测全局、线程、当前事件和事件历史检测
无仪表
服务器配置状态：
mysql> SELECT * FROM performance_schema.setup_consumers;
+---------------------------+---------+
| NAME                      | ENABLED |
+---------------------------+---------+
| global_instrumentation    | NO      |
...
+---------------------------+---------+
在此配置中，未检测任何内容。
检查设置元素：
表setup_consumers，消费者global_instrumentation
维护的输出表：
没有任何
仅限全球仪器
服务器配置状态：
mysql> SELECT * FROM performance_schema.setup_consumers;
+---------------------------+---------+
| NAME                      | ENABLED |
+---------------------------+---------+
| global_instrumentation    | YES     |
| thread_instrumentation    | NO      |
...
+---------------------------+---------+
在此配置中，仅为全局状态维护检测。每线程检测被禁用。
相对于前面的配置，检查了其他设置元素：
表setup_consumers，消费者thread_instrumentation
桌子setup_instruments
桌子setup_objects
相对于前面的配置，保留了额外的输出表：
mutex_instances
rwlock_instances
cond_instances
file_instances
users
hosts
accounts
socket_summary_by_event_name
file_summary_by_instance
file_summary_by_event_name
objects_summary_global_by_type
memory_summary_global_by_event_name
table_lock_waits_summary_by_table
table_io_waits_summary_by_index_usage
table_io_waits_summary_by_table
events_waits_summary_by_instance
events_waits_summary_global_by_event_name
events_stages_summary_global_by_event_name
events_statements_summary_global_by_event_name
events_transactions_summary_global_by_event_name
仅限全局和线程检测
服务器配置状态：
mysql> SELECT * FROM performance_schema.setup_consumers;
+----------------------------------+---------+
| NAME                             | ENABLED |
+----------------------------------+---------+
| global_instrumentation           | YES     |
| thread_instrumentation           | YES     |
| events_waits_current             | NO      |
...
| events_stages_current            | NO      |
...
| events_statements_current        | NO      |
...
| events_transactions_current      | NO      |
...
+----------------------------------+---------+
在此配置中，检测是全局和每个线程维护的。当前事件或事件历史表中不收集任何单个事件。
相对于前面的配置，检查了其他设置元素：
表setup_consumers, 消费者
, 在哪里
, ,
,
events_xxx_currentxxxwaitsstagesstatementstransactions
桌子setup_actors
柱子threads.instrumented
相对于前面的配置，保留了额外的输出表：
events_xxx_summary_by_yyy_by_event_name,其中xxx,
waits, stages,
statements;
transactions并且
yyy是
thread, user,
host,account
全局、线程和当前事件检测
服务器配置状态：
mysql> SELECT * FROM performance_schema.setup_consumers;
+----------------------------------+---------+
| NAME                             | ENABLED |
+----------------------------------+---------+
| global_instrumentation           | YES     |
| thread_instrumentation           | YES     |
| events_waits_current             | YES     |
| events_waits_history             | NO      |
| events_waits_history_long        | NO      |
| events_stages_current            | YES     |
| events_stages_history            | NO      |
| events_stages_history_long       | NO      |
| events_statements_current        | YES     |
| events_statements_history        | NO      |
| events_statements_history_long   | NO      |
| events_transactions_current      | YES     |
| events_transactions_history      | NO      |
| events_transactions_history_long | NO      |
...
+----------------------------------+---------+
在此配置中，检测是全局和每个线程维护的。个别事件收集在当前事件表中，但不在事件历史表中。
相对于前面的配置，检查了其他设置元素：
消费者
, 在哪里
, ,
,
events_xxx_historyxxxwaitsstagesstatementstransactions
消费者
, 在哪里
, ,
,
events_xxx_history_longxxxwaitsstagesstatementstransactions
相对于前面的配置，保留了额外的输出表：
events_xxx_current, 在xxx哪里
waits, stages,
statements,
transactions
全局、线程、当前事件和事件历史检测
前面的配置不收集事件历史记录，因为
和
消费者被禁用。这些消费者可以单独或一起启用，以收集每个线程、全局或两者的事件历史记录。
events_xxx_historyevents_xxx_history_long
此配置收集每个线程的事件历史记录，但不是全局收集：
mysql> SELECT * FROM performance_schema.setup_consumers;
+----------------------------------+---------+
| NAME                             | ENABLED |
+----------------------------------+---------+
| global_instrumentation           | YES     |
| thread_instrumentation           | YES     |
| events_waits_current             | YES     |
| events_waits_history             | YES     |
| events_waits_history_long        | NO      |
| events_stages_current            | YES     |
| events_stages_history            | YES     |
| events_stages_history_long       | NO      |
| events_statements_current        | YES     |
| events_statements_history        | YES     |
| events_statements_history_long   | NO      |
| events_transactions_current      | YES     |
| events_transactions_history      | YES     |
| events_transactions_history_long | NO      |
...
+----------------------------------+---------+
为此配置维护的事件历史表：
events_xxx_history, 在xxx哪里
waits, stages,
statements,
transactions
此配置全局收集事件历史记录，但不是每个线程：
mysql> SELECT * FROM performance_schema.setup_consumers;
+----------------------------------+---------+
| NAME                             | ENABLED |
+----------------------------------+---------+
| global_instrumentation           | YES     |
| thread_instrumentation           | YES     |
| events_waits_current             | YES     |
| events_waits_history             | NO      |
| events_waits_history_long        | YES     |
| events_stages_current            | YES     |
| events_stages_history            | NO      |
| events_stages_history_long       | YES     |
| events_statements_current        | YES     |
| events_statements_history        | NO      |
| events_statements_history_long   | YES     |
| events_transactions_current      | YES     |
| events_transactions_history      | NO      |
| events_transactions_history_long | YES     |
...
+----------------------------------+---------+
为此配置维护的事件历史表：
events_xxx_history_long, 在xxx哪里
waits, stages,
statements,
transactions
此配置收集每个线程和全局的事件历史记录：
mysql> SELECT * FROM performance_schema.setup_consumers;
+----------------------------------+---------+
| NAME                             | ENABLED |
+----------------------------------+---------+
| global_instrumentation           | YES     |
| thread_instrumentation           | YES     |
| events_waits_current             | YES     |
| events_waits_history             | YES     |
| events_waits_history_long        | YES     |
| events_stages_current            | YES     |
| events_stages_history            | YES     |
| events_stages_history_long       | YES     |
| events_statements_current        | YES     |
| events_statements_history        | YES     |
| events_statements_history_long   | YES     |
| events_transactions_current      | YES     |
| events_transactions_history      | YES     |
| events_transactions_history_long | YES     |
...
+----------------------------------+---------+
为此配置维护的事件历史表：
events_xxx_history, 在xxx哪里
waits, stages,
statements,
transactions
events_xxx_history_long, 在xxx哪里
waits, stages,
statements,
transactions
© Mysql 中文网
