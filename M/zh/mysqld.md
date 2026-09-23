# 4.3.1 mysqld——MySQL 服务器_MySQL 8.0 参考手册

4.3.1 mysqld——MySQL 服务器_MySQL 8.0 参考手册
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
4.1 MySQL程序概述
4.2 使用 MySQL 程序
4.3 服务器和服务器启动程序
4.3.1 mysqld——MySQL 服务器1
4.3.2 mysqld_safe — MySQL 服务器启动脚本1
4.3.3 mysql.server——MySQL服务器启动脚本1
4.3.4 mysqld_multi — 管理多个 MySQL 服务器1
4.4 安装相关程序
4.5 客户端程序
4.6 管理和实用程序
4.7 程序开发实用程序
4.8 杂项程序
4.9 环境变量
4.10 MySQL 中的 Unix 信号处理
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.3 服务器和服务器启动程序  /
4.3.1 mysqld——MySQL 服务器
4.3.1 mysqld——MySQL 服务器
mysqld也称为 MySQL 服务器，是一个单一的多线程程序，它完成 MySQL 安装中的大部分工作。它不会产生额外的进程。MySQL 服务器管理对包含数据库和表的 MySQL 数据目录的访问。数据目录也是其他信息（如日志文件和状态文件）的默认位置。
笔记
一些安装包包含名为mysqld-debug的服务器调试版本。调用此版本而不是mysqld以获得调试支持、内存分配检查和跟踪文件支持（请参阅第 5.9.1.2 节，“创建跟踪文件”）。
当 MySQL 服务器启动时，它会侦听来自客户端程序的网络连接并代表这些客户端管理对数据库的访问。
mysqld程序有许多可以在启动时指定的选项
。如需完整的选项列表，请运行以下命令：
mysqld --verbose --help
MySQL Server 也有一组系统变量，在它运行时会影响它的操作。系统变量可以在服务器启动时设置，其中许多可以在运行时更改以实现动态服务器重新配置。MySQL 服务器还有一组状态变量，提供有关其操作的信息。您可以监视这些状态变量以访问运行时性能特征。
有关 MySQL 服务器命令选项、系统变量和状态变量的完整描述，请参阅
第 5.1 节，“MySQL 服务器”。有关安装 MySQL 和设置初始配置的信息，请参阅
第 2 章，安装和升级 MySQL。
© Mysql 中文网
