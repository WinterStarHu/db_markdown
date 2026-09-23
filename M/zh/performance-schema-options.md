# 27.14 性能模式命令选项_MySQL 8.0 参考手册

27.14 性能模式命令选项_MySQL 8.0 参考手册
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
27.14 性能模式命令选项
27.14 性能模式命令选项
Performance Schema 参数可以在服务器启动时在命令行或选项文件中指定，以配置 Performance Schema 工具和消费者。在许多情况下，运行时配置也是可能的（请参阅
第 27.4 节，“性能模式运行时配置”），但是当运行时配置来不及影响在启动过程中已经初始化的工具时，必须使用启动配置。
可以使用以下语法在启动时配置 Performance Schema 消费者和工具。有关其他详细信息，请参阅
第 27.3 节，“性能模式启动配置”。
--performance-schema-consumer-consumer_name=value
配置 Performance Schema 消费者。表中的消费者名称
setup_consumers使用下划线，但对于启动时设置的消费者，名称中的破折号和下划线是等效的。用于配置单个消费者的选项将在本节后面详细介绍。
--performance-schema-instrument=instrument_name=value
配置性能模式工具。该名称可以作为模式给出，以配置与该模式匹配的工具。
以下项目配置个人消费者：
--performance-schema-consumer-events-stages-current=value
配置events-stages-current
消费者。
--performance-schema-consumer-events-stages-history=value
配置events-stages-history
消费者。
--performance-schema-consumer-events-stages-history-long=value
配置events-stages-history-long
消费者。
--performance-schema-consumer-events-statements-cpu=value
配置events-statements-cpu
消费者。
--performance-schema-consumer-events-statements-current=value
配置events-statements-current
消费者。
--performance-schema-consumer-events-statements-history=value
配置events-statements-history
消费者。
--performance-schema-consumer-events-statements-history-long=value
配置
events-statements-history-long消费者。
--performance-schema-consumer-events-transactions-current=value
配置性能模式
events-transactions-current消费者。
--performance-schema-consumer-events-transactions-history=value
配置性能模式
events-transactions-history消费者。
--performance-schema-consumer-events-transactions-history-long=value
配置性能模式
events-transactions-history-long消费者。
--performance-schema-consumer-events-waits-current=value
配置events-waits-current
消费者。
--performance-schema-consumer-events-waits-history=value
配置events-waits-history
消费者。
--performance-schema-consumer-events-waits-history-long=value
配置events-waits-history-long
消费者。
--performance-schema-consumer-global-instrumentation=value
配置global-instrumentation
消费者。
--performance-schema-consumer-statements-digest=value
配置statements-digest消费者。
--performance-schema-consumer-thread-instrumentation=value
配置thread-instrumentation
消费者。
© Mysql 中文网
