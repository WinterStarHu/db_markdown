# 第十九章MySQL Shell_MySQL 8.0 参考手册

第十九章MySQL Shell_MySQL 8.0 参考手册
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
第十九章MySQL Shell
第十九章MySQL Shell
MySQL Shell 是 MySQL Server 的高级客户端和代码编辑器。除了提供的 SQL 功能外，类似于
mysql，MySQL Shell 还为 JavaScript 和 Python 提供脚本功能，并包括用于与 MySQL 一起工作的 API。MySQL Shell 是一个可以单独安装的组件。
下面的讨论简要描述了 MySQL Shell 的功能。有关详细信息，请参阅 MySQL Shell 手册，网址为https://mysql.net.cn/doc/mysql-shell/en/。
MySQL Shell 包括以下用 JavaScript 和 Python 实现的 API，您可以使用它们来开发与 MySQL 交互的代码。
当 MySQL Shell 使用 X 协议连接到 MySQL 服务器时，X DevAPI 使开发人员能够处理关系数据和文档数据。这使您能够将 MySQL 用作文档存储，有时称为“使用 NoSQL ”。有关详细信息，请参阅
第 20 章，使用 MySQL 作为文档存储。有关在 MySQL Shell 中实现的 X DevAPI 的概念和用法的文档，请参阅X DevAPI 用户指南。
AdminAPI 使数据库管理员能够使用 InnoDB Cluster，它使用基于 InnoDB 的 MySQL 数据库提供了高可用性和可扩展性的集成解决方案，而无需高级 MySQL 专业知识。AdminAPI 还包括对 InnoDB ReplicaSet 的支持，这使您能够以类似于 InnoDB Cluster 的方式管理一组运行基于 GTID 的异步复制的 MySQL 实例。此外，AdminAPI 使 MySQL Router 的管理更加容易，包括与 InnoDB Cluster 和 InnoDB ReplicaSet 的集成。请参阅MySQL 管理 API。
MySQL Shell 有两个版本，社区版和商业版。社区版是免费提供的。商业版以低成本提供额外的企业功能。
© Mysql 中文网
