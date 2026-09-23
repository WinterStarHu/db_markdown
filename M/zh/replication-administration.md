# 17.1.7 常见的复制管理任务_MySQL 8.0 参考手册

17.1.7 常见的复制管理任务_MySQL 8.0 参考手册
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
17.1 配置复制
17.1.1 基于二进制日志文件位置的复制配置概述1
17.1.2 设置基于二进制日志文件位置的复制1
17.1.3 使用全局事务标识符进行复制1
17.1.4 在在线服务器上更改 GTID 模式1
17.1.5 MySQL多源复制1
17.1.6 复制和二进制日志选项和变量1
17.1.7 常见的复制管理任务1
17.1.7.1 检查复制状态
17.1.7.2 在副本上暂停复制
17.1.7.3 跳过交易
17.2 复制实现
17.3 复制安全
17.4 复制解决方案
17.5 复制注意事项和技巧
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
MySQL 8.0 参考手册  / 第十七章复制  / 17.1 配置复制  /
17.1.7 常见的复制管理任务
17.1.7 常见的复制管理任务
17.1.7.1 检查复制状态17.1.7.2 在副本上暂停复制17.1.7.3 跳过交易
一旦复制开始，它就可以执行，而不需要太多的定期管理。本节介绍如何检查复制状态、如何暂停副本以及如何跳过副本上的失败事务。
小费
要部署多个 MySQL 实例，您可以使用InnoDB Cluster ，它使您可以轻松地在MySQL Shell中管理一组 MySQL 服务器实例。InnoDB Cluster 将 MySQL Group Replication 包装在一个编程环境中，使您能够轻松部署 MySQL 实例集群以实现高可用性。此外，InnoDB Cluster 与MySQL Router无缝连接，使您的应用程序无需编写自己的故障转移过程即可连接到集群。但是，对于不需要高可用性的类似用例，您可以使用InnoDB ReplicaSet。可以在此处找到 MySQL Shell 的安装说明。
© Mysql 中文网
