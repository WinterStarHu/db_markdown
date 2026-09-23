# 2.11 升级MySQL_MySQL 8.0 参考手册

2.11 升级MySQL_MySQL 8.0 参考手册
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
2.1 一般安装指南
2.2 使用通用二进制文件在 Unix/Linux 上安装 MySQL
2.3 在 Microsoft Windows 上安装 MySQL
2.4 在 macOS 上安装 MySQL
2.5 在 Linux 上安装 MySQL
2.6 使用坚不可摧的Linux网络（ULN）安装MySQL
2.7 在 Solaris 上安装 MySQL
2.8 在 FreeBSD 上安装 MySQL
2.9 从源码安装MySQL
2.10 安装后设置和测试
2.11 升级MySQL
2.11.1 开始之前1
2.11.2 升级路径1
2.11.3 MySQL升级过程升级了什么1
2.11.4 MySQL 8.0 的变化1
2.11.5 准备升级安装1
2.11.6 在 Unix/Linux 上升级 MySQL 二进制或基于包的安装1
2.11.7 使用 MySQL Yum 仓库升级 MySQL1
2.11.8 使用MySQL APT Repository升级MySQL1
2.11.9 使用 MySQL SLES 存储库升级 MySQL1
2.11.10 Windows 升级MySQL1
2.11.11 升级MySQL的Docker安装1
2.11.12 升级故障处理1
2.11.13 重建或修复表或索引1
2.11.14 复制MySQL数据库到另一台机器1
2.12 降级MySQL
2.13 Perl 安装注意事项
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  /
2.11 升级MySQL
2.11 升级MySQL
2.11.1 开始之前2.11.2 升级路径2.11.3 MySQL升级过程升级了什么2.11.4 MySQL 8.0 的变化2.11.5 准备升级安装2.11.6 在 Unix/Linux 上升级 MySQL 二进制或基于包的安装2.11.7 使用 MySQL Yum 仓库升级 MySQL2.11.8 使用MySQL APT Repository升级MySQL2.11.9 使用 MySQL SLES 存储库升级 MySQL2.11.10 Windows 升级MySQL2.11.11 升级MySQL的Docker安装2.11.12 升级故障处理2.11.13 重建或修复表或索引2.11.14 复制MySQL数据库到另一台机器
本节介绍升级 MySQL 安装的步骤。
升级是一个常见的过程，因为您在同一个 MySQL 版本系列中获取错误修复或在主要 MySQL 版本之间获取重要功能。您首先在一些测试系统上执行此过程以确保一切顺利，然后在生产系统上执行。
笔记
在下面的讨论中，必须使用具有管理权限的 MySQL 帐户运行的 MySQL 命令包括在命令行中以指定 MySQL用户。需要密码的命令还包括一个
选项。因为后面没有选项值，所以此类命令提示输入密码。出现提示时键入密码，然后按 Enter。
-u
root rootroot-p-p
可以使用mysql
命令行客户端执行 SQL 语句（连接 asroot以确保您具有必要的权限）。
© Mysql 中文网
