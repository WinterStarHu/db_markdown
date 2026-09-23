# 5.5 MySQL组件_MySQL 8.0 参考手册

5.5 MySQL组件_MySQL 8.0 参考手册
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
5.1 MySQL 服务器
5.2 MySQL数据目录
5.3 mysql系统架构
5.4 MySQL 服务器日志
5.5 MySQL组件
5.5.1 安装和卸载组件1
5.5.2 获取组件信息1
5.5.3 错误日志组件1
5.5.4 查询属性组件1
5.6 MySQL 服务器插件
5.7 MySQL 服务器可加载函数
5.8 在一台机器上运行多个MySQL实例
5.9 调试 MySQL
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
MySQL 8.0 参考手册  / 第 5 章 MySQL 服务器管理  /
5.5 MySQL组件
5.5 MySQL组件
5.5.1 安装和卸载组件5.5.2 获取组件信息5.5.3 错误日志组件5.5.4 查询属性组件
MySQL 服务器包括一个基于组件的基础架构，用于扩展服务器功能。组件提供服务器和其他组件可用的服务。（就服务使用而言，服务器是一个组件，与其他组件是平等的。）组件之间仅通过它们提供的服务进行交互。
MySQL 发行版包括几个实现服务器扩展的组件：
用于配置错误日志记录的组件。请参阅
第 5.4.2 节，“错误日志”和
第 5.5.3 节，“错误日志组件”。
检查密码的组件。请参阅
第 6.4.3 节，“密码验证组件”。
Keyring 组件为敏感信息提供安全存储。请参阅第 6.4.4 节，“MySQL 密钥环”。
使应用程序能够将自己的消息事件添加到审核日志的组件。请参阅
第 6.4.6 节，“审计消息组件”。
实现用于访问查询属性的可加载函数的组件。请参阅第 9.6 节，“查询属性”。
组件实现的系统变量和状态变量在安装组件时公开，并且名称以特定于组件的前缀开头。例如，
log_filter_dragnet错误日志过滤组件实现了一个名为 的系统变量
log_error_filter_rules，全名是
dragnet.log_error_filter_rules。要引用此变量，请使用全名。
以下部分描述了如何安装和卸载组件，以及如何在运行时确定安装了哪些组件并获取有关它们的信息。
有关组件内部实现的信息，请参阅 MySQL Server Doxygen 文档，网址为
https://mysql.net.cn/doc/index-other.html。例如，如果您打算编写自己的组件，则此信息对于理解组件的工作原理很重要。
© Mysql 中文网
