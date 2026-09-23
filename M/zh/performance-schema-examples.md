# 27.19 使用性能模式诊断问题_MySQL 8.0 参考手册

27.19 使用性能模式诊断问题_MySQL 8.0 参考手册
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
27.19.1 使用性能模式进行查询分析1
27.19.2 获取父事件信息1
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
27.19 使用性能模式诊断问题
27.19 使用性能模式诊断问题
27.19.1 使用性能模式进行查询分析27.19.2 获取父事件信息
Performance Schema 是一种工具，可帮助 DBA 通过进行实际测量而不是“胡乱猜测”
来进行性能调优。”本节演示为此目的使用性能模式的一些方法。这里的讨论依赖于事件过滤的使用，这在
第 27.4.2 节，“性能模式事件过滤”中有描述。
以下示例提供了一种可用于分析可重复问题的方法，例如调查性能瓶颈。首先，您应该有一个可重复的用例，其中性能被认为“太慢”并且需要优化，并且您应该启用所有检测（根本没有预过滤）。
运行用例。
使用性能模式表，分析性能问题的根本原因。此分析在很大程度上依赖于后过滤。
对于排除的问题区域，禁用相应的工具。例如，如果分析表明问题与特定存储引擎中的文件 I/O 无关，则禁用该引擎的文件 I/O 工具。然后截断历史和摘要表以删除以前收集的事件。
重复步骤 1 中的过程。
在每次迭代中，Performance Schema 输出，尤其是
events_waits_history_long表格，包含越来越少的由无关紧要的仪器引起的“噪音”，并且鉴于该表格具有固定大小，包含越来越多与手头问题分析相关的数据。
在每次迭代中，随着“信噪比”的提高
，调查应该越来越接近问题的根本原因
，从而使分析更加容易。
一旦确定了性能瓶颈的根本原因，就采取适当的纠正措施，例如：
调整服务器参数（缓存大小、内存等）。
通过不同的方式编写查询来调整查询，
调整数据库架构（表、索引等）。
调整代码（这仅适用于存储引擎或服务器开发人员）。
从第 1 步重新开始，查看更改对性能的影响。
和
列对于调查性能瓶颈或死锁极为重要mutex_instances.LOCKED_BY_THREAD_ID。
rwlock_instances.WRITE_LOCKED_BY_THREAD_ID这是通过 Performance Schema 检测实现的，如下所示：
假设线程 1 在等待互斥锁时卡住了。
您可以确定线程正在等待什么：
SELECT * FROM performance_schema.events_waits_current
WHERE THREAD_ID = thread_1;
假设查询结果标识线程正在等待在 中找到的互斥量
events_waits_current.OBJECT_INSTANCE_BEGINA。
您可以确定哪个线程持有互斥量 A：
SELECT * FROM performance_schema.mutex_instances
WHERE OBJECT_INSTANCE_BEGIN = mutex_A;
假设查询结果标识它是持有互斥量 A 的线程 2，如中所见
mutex_instances.LOCKED_BY_THREAD_ID。
你可以看到线程 2 在做什么：
SELECT * FROM performance_schema.events_waits_current
WHERE THREAD_ID = thread_2;
© Mysql 中文网
