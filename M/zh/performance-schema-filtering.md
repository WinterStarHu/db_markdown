# 27.4.2 性能模式事件过滤_MySQL 8.0 参考手册

27.4.2 性能模式事件过滤_MySQL 8.0 参考手册
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
27.4.2 性能模式事件过滤
27.4.2 性能模式事件过滤
事件以生产者/消费者的方式处理：
插桩代码是事件的来源并生成要收集的事件。该
setup_instruments表列出了可以为其收集事件的仪器，它们是否已启用，以及（对于已启用的仪器）是否收集计时信息：
mysql> SELECT NAME, ENABLED, TIMED
FROM performance_schema.setup_instruments;
+---------------------------------------------------+---------+-------+
| NAME                                              | ENABLED | TIMED |
+---------------------------------------------------+---------+-------+
...
| wait/synch/mutex/sql/LOCK_global_read_lock        | YES     | YES   |
| wait/synch/mutex/sql/LOCK_global_system_variables | YES     | YES   |
| wait/synch/mutex/sql/LOCK_lock_db                 | YES     | YES   |
| wait/synch/mutex/sql/LOCK_manager                 | YES     | YES   |
...
该setup_instruments表提供了对事件生成的最基本控制形式。为了根据正在监视的对象或线程的类型进一步细化事件生成，可以使用其他表，如
第 27.4.3 节，“事件预过滤”中所述。
Performance Schema 表是事件和消费事件的目的地。该
setup_consumers表列出了事件信息可以发送到的消费者类型以及它们是否已启用：
mysql> SELECT * FROM performance_schema.setup_consumers;
+----------------------------------+---------+
| NAME                             | ENABLED |
+----------------------------------+---------+
| events_stages_current            | NO      |
| events_stages_history            | NO      |
| events_stages_history_long       | NO      |
| events_statements_cpu            | NO      |
| events_statements_current        | YES     |
| events_statements_history        | YES     |
| events_statements_history_long   | NO      |
| events_transactions_current      | YES     |
| events_transactions_history      | YES     |
| events_transactions_history_long | NO      |
| events_waits_current             | NO      |
| events_waits_history             | NO      |
| events_waits_history_long        | NO      |
| global_instrumentation           | YES     |
| thread_instrumentation           | YES     |
| statements_digest                | YES     |
+----------------------------------+---------+
过滤可以在性能监控的不同阶段进行：
预过滤。
这是通过修改 Performance Schema 配置来完成的，以便仅从生产者收集某些类型的事件，并且收集的事件仅更新某些消费者。为此，启用或禁用仪器或消费者。预过滤由性能模式完成，具有适用于所有用户的全局效果。
使用预过滤的原因：
以减少开销。即使启用了所有工具，性能模式开销也应该是最小的，但也许你想进一步减少它。或者您不关心时序事件并希望禁用时序代码以消除时序开销。
避免用您不感兴趣的事件填充当前事件或历史表。预过滤在这些表中为启用的仪器类型的行实例留下更多“空间” 。如果您仅启用带有预过滤的文件工具，则不会为非文件工具收集任何行。通过后过滤，收集非文件事件，为文件事件留下更少的行。
避免维护某些类型的事件表。如果禁用消费者，则服务器不会花时间维护该消费者的目的地。例如，如果您不关心事件历史记录，则可以禁用历史表消费者以提高性能。
过滤后。
这涉及在WHERE从性能模式表中选择信息的查询中使用子句，以指定您想要查看哪些可用事件。后过滤是在每个用户的基础上执行的，因为各个用户选择感兴趣的可用事件。
使用后置过滤的原因：
避免为单个用户做出有关哪些事件信息感兴趣的决定。
当事先不知道使用预过滤施加的限制时，使用性能模式来调查性能问题。
以下部分提供了有关预过滤的更多详细信息，并提供了在过滤操作中命名工具或消费者的指南。有关编写查询以检索信息（后过滤）的信息，请参阅
第 27.5 节，“性能模式查询”。
© Mysql 中文网
