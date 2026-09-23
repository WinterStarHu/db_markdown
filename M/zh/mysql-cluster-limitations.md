# 23.2.7 NDB Cluster 的已知限制_MySQL 8.0 参考手册

23.2.7 NDB Cluster 的已知限制_MySQL 8.0 参考手册
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
23.1 一般信息
23.2 NDB Cluster 概述
23.2.1 NDB Cluster 核心概念1
23.2.2 NDB Cluster 节点、节点组、片段副本和分区1
23.2.3 NDB Cluster 硬件、软件和网络要求1
23.2.4 NDB Cluster 中的新功能1
23.2.5 NDB 8.0 中添加、弃用或删除的选项、变量和参数1
23.2.6 使用 InnoDB 的 MySQL 服务器与 NDB Cluster 比较1
23.2.7 NDB Cluster 的已知限制1
23.2.7.1 NDB Cluster 中不符合 SQL 语法
23.2.7.2 NDB Cluster 与标准 MySQL 限制的限制和差异
23.2.7.3 与 NDB Cluster 中事务处理相关的限制
23.2.7.4 NDB Cluster 错误处理
23.2.7.5 与 NDB Cluster 中的数据库对象关联的限制
23.2.7.6 NDB Cluster 中不支持或缺失的功能
23.2.7.7 与 NDB Cluster 中的性能相关的限制
23.2.7.8 NDB Cluster 独有的问题
23.2.7.9 与 NDB Cluster 磁盘数据存储相关的限制
23.2.7.10 与多个 NDB Cluster 节点相关的限制
23.2.7.11 NDB Cluster 8.0 中已解决的先前 NDB Cluster 问题
23.3 NDB Cluster 安装
23.4 NDB Cluster的配置
23.5 NDB 集群程序
23.6 NDB Cluster的管理
23.7 NDB 集群复制
23.8 NDB Cluster 发行说明
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.2 NDB Cluster 概述  /
23.2.7 NDB Cluster 的已知限制
23.2.7 NDB Cluster 的已知限制
23.2.7.1 NDB Cluster 中不符合 SQL 语法23.2.7.2 NDB Cluster 与标准 MySQL 限制的限制和差异23.2.7.3 与 NDB Cluster 中事务处理相关的限制23.2.7.4 NDB Cluster 错误处理23.2.7.5 与 NDB Cluster 中的数据库对象关联的限制23.2.7.6 NDB Cluster 中不支持或缺失的功能23.2.7.7 与 NDB Cluster 中的性能相关的限制23.2.7.8 NDB Cluster 独有的问题23.2.7.9 与 NDB Cluster 磁盘数据存储相关的限制23.2.7.10 与多个 NDB Cluster 节点相关的限制23.2.7.11 NDB Cluster 8.0 中已解决的先前 NDB Cluster 问题
MyISAM在接下来的部分中，我们讨论了当前版本的 NDB Cluster 中的已知限制，并与使用和
InnoDB存储引擎
时可用的功能进行了比较。如果您查看
位于http://bugs.mysql.com的 MySQL 错误数据库中的“ Cluster ”类别
，您可以在位于http://bugs的 MySQL 错误数据库中的“ MySQL 服务器： ”下找到以下类别中的已知错误.mysql.com，我们打算在即将发布的 NDB Cluster 版本中更正：
NDB集群
集群直接 API (NDBAPI)
集群磁盘数据
集群复制
集群J
此信息旨在针对刚刚规定的条件提供完整信息。您可以使用第 1.6 节“如何报告错误或问题”中给出的说明向 MySQL 错误数据库报告您遇到的任何差异。我们不打算在 NDB Cluster 8.0 中修复的任何问题都已添加到列表中。
有关早期版本中已在 NDB Cluster 8.0 中解决的问题列表，
请参阅第 23.2.7.11 节，“NDB Cluster 8.0 中已解决的先前 NDB Cluster 问题” 。
笔记
第 23.7.3 节，“NDB Cluster 复制中的已知问题”
中描述了特定于 NDB Cluster 复制的限制和其他问题
。
© Mysql 中文网
