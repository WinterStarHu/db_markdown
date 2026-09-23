# 第 20 章使用 MySQL 作为文档存储_MySQL 8.0 参考手册

第 20 章使用 MySQL 作为文档存储_MySQL 8.0 参考手册
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
20.1 MySQL文档存储的接口
20.2 文档存储概念
20.3 JavaScript 快速入门指南：用于文档存储的 MySQL Shell
20.4 Python 快速入门指南：用于文档存储的 MySQL Shell
20.5 X 插件
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
第 20 章使用 MySQL 作为文档存储
第 20 章使用 MySQL 作为文档存储
目录20.1 MySQL文档存储的接口20.2 文档存储概念20.3 JavaScript 快速入门指南：用于文档存储的 MySQL Shell20.3.1 MySQL 外壳20.3.2 下载导入world_x数据库20.3.3 文件和收藏20.3.4 关系表20.3.5 表格中的文件20.4 Python 快速入门指南：用于文档存储的 MySQL Shell20.4.1 MySQL 外壳20.4.2 下载导入world_x数据库20.4.3 文件和收藏20.4.4 关系表20.4.5 表格中的文件20.5 X 插件20.5.1 检查 X 插件安装20.5.2 禁用 X 插件20.5.3 使用 X 插件的加密连接20.5.4 将 X 插件与缓存 SHA-2 身份验证插件一起使用20.5.5 使用 X 插件进行连接压缩20.5.6 X 插件选项和变量20.5.7 监控 X 插件
本章介绍另一种将 MySQL 用作文档存储的方法，有时称为“使用 NoSQL ”。如果您打算以传统 (SQL) 方式使用 MySQL，那么本章可能与您无关。
传统上，关系数据库（如 MySQL）通常需要在存储文档之前定义模式。本节中描述的功能使您能够将 MySQL 用作文档存储，它是一种无模式的文档存储系统，因此模式灵活。例如，当您创建描述产品的文档时，您不需要在存储和操作文档之前了解和定义任何产品的所有可能属性。这不同于使用关系数据库并将产品存储在表中，后者在将任何产品添加到数据库之前必须知道并定义表的所有列。本章中描述的特性使您能够选择如何配置 MySQL，仅使用文档存储模型，
要将 MySQL 用作文档存储，您可以使用以下服务器功能：
X Plugin 使 MySQL Server 能够使用 X 协议与客户端通信，这是使用 MySQL 作为文档存储的先决条件。从 MySQL 8.0 开始，X 插件在 MySQL 服务器中默认启用。有关验证 X 插件安装以及配置和监视 X 插件的说明，请参阅
第 20.5 节 “X 插件”。
X 协议支持 CRUD 和 SQL 操作，通过 SASL 进行身份验证，允许流式传输（流水线）命令，并且在协议和消息层上是可扩展的。与 X 协议兼容的客户端包括 MySQL Shell 和 MySQL 8.0 连接器。
使用 X 协议与 MySQL 服务器通信的客户端可以使用 X DevAPI 来开发应用程序。X DevAPI 提供现代编程接口，其设计简单但功能强大，支持已建立的行业标准概念。本章介绍如何开始使用 MySQL Shell 中 X DevAPI 的 JavaScript 或 Python 实现作为客户端。有关使用 X DevAPI 的深入教程，
请参阅
X DevAPI 用户指南。
© Mysql 中文网
