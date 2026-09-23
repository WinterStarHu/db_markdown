# 20.4 Python 快速入门指南：用于文档存储的 MySQL Shell_MySQL 8.0 参考手册

20.4 Python 快速入门指南：用于文档存储的 MySQL Shell_MySQL 8.0 参考手册
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
20.4.1 MySQL 外壳1
20.4.2 下载导入world_x数据库1
20.4.3 文件和收藏1
20.4.4 关系表1
20.4.5 表格中的文件1
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
MySQL 8.0 参考手册  / 第 20 章使用 MySQL 作为文档存储  /
20.4 Python 快速入门指南：用于文档存储的 MySQL Shell
20.4 Python 快速入门指南：用于文档存储的 MySQL Shell
20.4.1 MySQL 外壳20.4.2 下载导入world_x数据库20.4.3 文件和收藏20.4.4 关系表20.4.5 表格中的文件
本快速入门指南提供了开始使用 MySQL Shell 交互地构建文档存储应用程序原型的说明。该指南包括以下主题：
介绍 MySQL 功能、MySQL Shell 和
world_x示例架构。
管理集合和文档的操作。
管理关系表的操作。
适用于表中文档的操作。
要遵循此快速入门指南，您需要一个安装了 X 插件的 MySQL 服务器（8.0 中的默认插件）和用作客户端的 MySQL Shell。MySQL Shell 包括在 JavaScript 和 Python 中实现的 X DevAPI，它使您能够使用 X 协议连接到 MySQL 服务器实例并将服务器用作文档存储。
相关信息
MySQL Shell 8.0提供了有关 MySQL Shell 的更深入的信息。
有关本快速入门指南中使用的工具的更多信息
，
请参阅安装 MySQL Shell和
第 20.5 节，“X 插件” 。有关MySQL Shell 支持的语言的更多信息，
请参阅支持的语言。
X DevAPI 用户指南提供了更多使用 X DevAPI 开发使用 MySQL 作为文档存储的应用程序的示例。
还提供了
JavaScript
快速入门指南。
© Mysql 中文网
