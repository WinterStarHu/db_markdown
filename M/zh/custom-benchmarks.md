# 8.13.2 使用你自己的基准_MySQL 8.0 参考手册

8.13.2 使用你自己的基准_MySQL 8.0 参考手册
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
8.1 优化概述
8.2 优化SQL语句
8.3 优化和索引
8.4 优化数据库结构
8.5 优化 InnoDB 表
8.6 优化 MyISAM 表
8.7 优化 MEMORY 表
8.8 了解查询执行计划
8.9 控制查询优化器
8.10 缓冲和缓存
8.11 优化锁定操作
8.12 优化MySQL服务器
8.13 测量性能（基准测试）
8.13.1 Measuring the Speed of Expressions and Functions1
8.13.2 使用你自己的基准1
8.13.3 使用 performance_schema 测量性能1
8.14 查看服务器线程（进程）信息
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
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第8章优化  / 8.13 测量性能（基准测试）  /
8.13.2 使用你自己的基准
8.13.2 使用你自己的基准
对您的应用程序和数据库进行基准测试，找出瓶颈所在。修复一个瓶颈后（或用“虚拟”模块替换它），您可以继续识别下一个瓶颈。即使你的应用程序目前的整体性能是可以接受的，你至少应该为每个瓶颈制定一个计划，并决定如果有一天你真的需要额外的性能如何解决它。
免费的基准套件是开源数据库基准，可从http://osdb.sourceforge.net/获得。
仅当系统负载非常大时才会出现问题是很常见的。我们有许多客户在生产中有（经过测试的）系统并遇到负载问题时与我们联系。在大多数情况下，性能问题是由于基本数据库设计问题（例如，表扫描在高负载下表现不佳）或操作系统或库问题所致。大多数时候，如果系统尚未投入生产，这些问题会更容易解决。
为避免此类问题，请在可能的最坏负载下对整个应用程序进行基准测试：
mysqlslap程序有助于模拟多个客户端同时发出查询所产生的高负载。请参阅第 4.5.8 节，“mysqlslap — 负载仿真客户端”。
您还可以尝试基准测试包，例如 SysBench 和 DBT2，可从
https://launchpad.net/sysbench和
http://osdldbt.sourceforge.net/#dbt2获得。
这些程序或包可能会使系统崩溃，因此请确保仅在您的开发系统上使用它们。
© Mysql 中文网
