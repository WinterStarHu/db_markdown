# 27.4.7 消费者预过滤_MySQL 8.0 参考手册

27.4.7 消费者预过滤_MySQL 8.0 参考手册
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
27.4.7 消费者预过滤
27.4.7 消费者预过滤
该setup_consumers表列出了可用的消费者类型以及哪些已启用：
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
修改setup_consumers表以影响消费者阶段的预过滤并确定事件发送到的目的地。要启用或禁用消费者，请将其ENABLED值设置为
YES或NO。
对
setup_consumers表的修改会立即影响监控。
如果禁用消费者，则服务器不会花时间维护该消费者的目的地。例如，如果您不关心历史事件信息，请禁用历史消费者：
UPDATE performance_schema.setup_consumers
SET ENABLED = 'NO'
WHERE NAME LIKE '%history%';
表中的消费者设置
setup_consumers形成了从高到低的层次结构。以下原则适用：
与消费者关联的目的地不会收到任何事件，除非性能模式检查消费者并且消费者已启用。
一个消费者只有在它依赖的所有消费者（如果有的话）都被启用时才会被检查。
如果一个消费者没有被选中，或者被选中但被禁用，那么依赖它的其他消费者也不会被选中。
依赖消费者可能有自己的依赖消费者。
如果事件不会发送到任何目的地，则性能模式不会产生它。
以下列表描述了可用的消费者值。有关几种代表性消费者配置及其对仪器的影响的讨论，请参阅
第 27.4.8 节，“示例消费者配置”。
全局和线程消费者等待事件消费者舞台活动消费者声明事件消费者事务事件消费者语句摘要消费者
全局和线程消费者
global_instrumentation是最高级别的消费者。如果
global_instrumentation是
NO，它会禁用全局检测。所有其他设置都是较低级别的，未检查；它们的设置无关紧要。当前事件或事件历史表中没有维护全局或每个线程信息，也没有收集单个事件。如果global_instrumentation是
YES，则性能模式维护全局状态的信息并检查
thread_instrumentation消费者。
thread_instrumentation仅当global_instrumentation是
时才检查YES。否则，如果
thread_instrumentation是
NO，它会禁用特定于线程的检测并忽略所有较低级别的设置。每个线程都不会维护任何信息，并且不会在当前事件或事件历史表中收集任何单独的事件。如果
thread_instrumentation是
YES，则性能模式维护特定于线程的信息并检查
消费者。
events_xxx_current
等待事件消费者
这些消费者需要同时进行
global_instrumentation和
thread_instrumentation进行
检查，YES或者不进行检查。如果选中，它们的行为如下：
events_waits_current, 如果
NO, 禁用表中单个等待事件的收集
events_waits_current。如果YES，它启用等待事件收集并且性能模式检查
events_waits_history和
events_waits_history_long消费者。
events_waits_historyevent_waits_current如果是
则不检查
NO。否则， or 的
值events_waits_history将
禁用或启用表中等待事件的收集
。
NOYESevents_waits_history
events_waits_history_longevent_waits_current如果是
则不检查NO。否则， or 的
值events_waits_history_long将
禁用或启用表中等待事件的收集
。
NOYESevents_waits_history_long
舞台活动消费者
这些消费者需要同时进行
global_instrumentation和
thread_instrumentation进行
检查，YES或者不进行检查。如果选中，它们的行为如下：
events_stages_current，如果
NO，禁用表中各个阶段事件的收集
events_stages_current。如果YES，它启用阶段事件收集并且性能模式检查
events_stages_history和
events_stages_history_long消费者。
events_stages_historyevent_stages_current如果是
则不检查
NO。否则， or 的
值events_stages_history将
禁用或启用表中阶段事件的收集
。
NOYESevents_stages_history
events_stages_history_longevent_stages_current如果是
则不检查NO。否则， or 的
值events_stages_history_long将
禁用或启用表中阶段事件的收集
。
NOYESevents_stages_history_long
声明事件消费者
这些消费者需要同时进行
global_instrumentation和
thread_instrumentation进行
检查，YES或者不进行检查。如果选中，它们的行为如下：
events_statements_cpu, 如果
NO, 禁用 的测量
CPU_TIME。如果YES，并且仪器已启用并计时，
CPU_TIME则被测量。
events_statements_current, 如果
NO, 禁用表中单个语句事件的收集
events_statements_current
。如果YES，它启用语句事件收集并且性能模式检查
events_statements_history和
events_statements_history_long
消费者。
events_statements_historyevents_statements_current如果是
则不检查NO。否则， or 的
值events_statements_history将
禁用或启用表中语句事件的集合
。
NOYESevents_statements_history
events_statements_history_longevents_statements_current如果是
则不检查NO。否则， or 的
值events_statements_history_long将
禁用或启用表中语句事件的集合
。
NOYESevents_statements_history_long
事务事件消费者
这些消费者需要同时进行
global_instrumentation和
thread_instrumentation进行
检查，YES或者不进行检查。如果选中，它们的行为如下：
events_transactions_current，如果
NO，禁用表中单个事务事件的收集
events_transactions_current
。如果YES，它启用事务事件收集并且性能模式检查
events_transactions_history和
events_transactions_history_long
消费者。
events_transactions_historyevents_transactions_current
如果是则不检查NO。否则， or 的
值events_transactions_history将
禁用或启用表中事务事件的收集
。
NOYESevents_transactions_history
events_transactions_history_longevents_transactions_current
如果是则不检查NO。否则， or 的
值events_transactions_history_long将
禁用或启用表中事务事件的收集
。
NOYESevents_transactions_history_long
语句摘要消费者
statements_digest消费者要求
global_instrumentation或
不YES检查。不依赖于语句事件消费者，因此您可以获取每个摘要的统计信息，而无需在 中收集统计信息
events_statements_current，这在开销方面是有利的。相反，您可以在
events_statements_current没有摘要的情况下获得详细的陈述（在这种情况下是DIGEST和
DIGEST_TEXT列
NULL）。
有关语句摘要的更多信息，请参阅
第 27.10 节，“性能模式语句摘要和采样”。
© Mysql 中文网
