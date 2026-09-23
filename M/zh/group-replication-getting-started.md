# 18.2 开始_MySQL 8.0 参考手册

18.2 开始_MySQL 8.0 参考手册
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
18.1 组复制背景
18.2 开始
18.2.1 在单主模式下部署组复制1
18.2.2 在本地部署组复制1
18.3 要求和限制
18.4 监控组复制
18.5 组复制操作
18.6 组复制安全
18.7 组复制性能和故障排除
18.8 升级组复制
18.9 组复制系统变量
18.10 常见问题
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
MySQL 8.0 参考手册  / 第十八章 组复制  /
18.2 开始
18.2 开始
18.2.1 在单主模式下部署组复制18.2.2 在本地部署组复制
MySQL Group Replication 作为 MySQL 服务器的插件提供，组中的每个服务器都需要配置和安装插件。本节提供详细教程，其中包含创建至少包含三个成员的复制组所需的步骤。
小费
要部署多个 MySQL 实例，您可以使用InnoDB Cluster ，它使您可以轻松地在MySQL Shell中管理一组 MySQL 服务器实例。InnoDB Cluster 将 MySQL Group Replication 包装在一个编程环境中，使您能够轻松部署 MySQL 实例集群以实现高可用性。此外，InnoDB Cluster 与MySQL Router无缝连接，使您的应用程序无需编写自己的故障转移过程即可连接到集群。但是，对于不需要高可用性的类似用例，您可以使用InnoDB ReplicaSet。可以在此处找到 MySQL Shell 的安装说明。
© Mysql 中文网
