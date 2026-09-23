# 第 7 章备份与恢复_MySQL 8.0 参考手册

第 7 章备份与恢复_MySQL 8.0 参考手册
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
7.1 备份和恢复类型
7.2 数据库备份方式
7.3 示例备份和恢复策略
7.4 使用 mysqldump 进行备份
7.5 时间点（增量）恢复
7.6 MyISAM表维护和崩溃恢复
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
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  /
第 7 章备份与恢复
第 7 章备份与恢复
目录7.1 备份和恢复类型7.2 数据库备份方式7.3 示例备份和恢复策略7.3.1 建立备份策略7.3.2 使用备份进行恢复7.3.3 备份策略总结7.4 使用 mysqldump 进行备份7.4.1 使用 mysqldump 转储 SQL 格式的数据7.4.2 重新加载 SQL 格式的备份7.4.3 使用 mysqldump 以定界文本格式转储数据7.4.4 重新加载定界文本格式备份7.4.5 mysqldump 提示7.5 时间点（增量）恢复7.5.1 使用二进制日志进行时间点恢复7.5.2 使用事件位置的时间点恢复7.6 MyISAM表维护和崩溃恢复7.6.1 使用 myisamchk 进行崩溃恢复7.6.2 如何检查 MyISAM 表的错误7.6.3 如何修复 MyISAM 表7.6.4 MyISAM表优化7.6.5 设置 MyISAM 表维护计划
备份数据库非常重要，这样您就可以恢复数据并在出现问题（例如系统崩溃、硬件故障或用户误删除数据）时重新启动并运行。在升级 MySQL 安装之前，备份也是必不可少的保护措施，它们可用于将 MySQL 安装转移到另一个系统或设置副本服务器。
MySQL 提供了多种备份策略，您可以从中选择最适合您的安装要求的方法。本章讨论您应该熟悉的几个备份和恢复主题：
备份类型：逻辑备份与物理备份、完整备份与增量备份等。
创建备份的方法。
恢复方法，包括时间点恢复。
备份调度、压缩和加密。
表维护，以启用损坏表的恢复。
其他资源
与备份或维护数据可用性相关的资源包括：
MySQL Enterprise Edition 的客户可以使用 MySQL Enterprise Backup 产品进行备份。有关 MySQL Enterprise Backup 产品的概述，请参阅第 30.2 节，“MySQL Enterprise Backup 概述”。
https://forums.mysql.com/list.php?28
上有一个专门讨论备份问题的论坛
。
mysqldump的
详细信息可以在
第 4 章MySQL 程序中找到。
此处描述的 SQL 语句的语法在
第 13 章SQL 语句中给出。
有关InnoDB
备份过程的其他信息，请参阅第 15.18.1 节，“InnoDB 备份”。
复制使您能够在多个服务器上维护相同的数据。这有几个好处，例如使客户端查询负载能够分布在服务器上，即使给定服务器脱机或发生故障，数据也可用，以及能够通过使用副本进行备份而不影响源。请参阅第 17 章，复制。
MySQL InnoDB Cluster 是一组协同工作以提供高可用性解决方案的产品。可以将一组 MySQL 服务器配置为使用 MySQL Shell 创建集群。服务器集群只有一个源，称为主服务器，充当读写源。多个辅助服务器是源的副本。创建高可用性集群至少需要三台服务器。客户端应用程序通过 MySQL 路由器连接到主应用程序。如果主要失败，次要角色将自动提升为主要角色，MySQL 路由器将请求路由到新的主要角色。
NDB Cluster 提供了一个适用于分布式计算环境的高可用、高冗余版本的 MySQL。请参阅第 23 章，MySQL NDB Cluster 8.0，其中提供了有关 MySQL NDB Cluster 8.0 的信息。
© Mysql 中文网
