# 2.10 安装后设置和测试_MySQL 8.0 参考手册

2.10 安装后设置和测试_MySQL 8.0 参考手册
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
2.10 安装后设置和测试
2.10 安装后设置和测试
2.10.1 初始化数据目录2.10.2 启动服务器2.10.3 测试服务器2.10.4 保护初始 MySQL 帐户2.10.5 自动启动和停止MySQL
本节讨论安装 MySQL 后应执行的任务：
如有必要，初始化数据目录并创建 MySQL 授权表。对于某些 MySQL 安装方法，可能会自动为您完成数据目录初始化：
由 MySQL Installer 执行的 Windows 安装操作。
使用服务器 RPM 或 Oracle 的 Debian 发行版在 Linux 上安装。
在许多平台上使用本机打包系统进行安装，包括 Debian Linux、Ubuntu Linux、Gentoo Linux 等。
使用 DMG 发行版在 macOS 上安装。
对于其他平台和安装类型，您必须手动初始化数据目录。这些包括在 Unix 和类 Unix 系统上从通用二进制和源代码分发安装，以及在 Windows 上从 ZIP 存档包安装。有关说明，请参阅
第 2.10.1 节，“初始化数据目录”。
启动服务器并确保它可以被访问。有关说明，请参阅第 2.10.2 节“启动服务器”和
第 2.10.3 节“测试服务器”。
将密码分配给授权表中的初始root帐户（如果在数据目录初始化期间尚未完成）。密码可防止未经授权访问 MySQL 服务器。有关说明，请参阅
第 2.10.4 节，“保护初始 MySQL 帐户”。
或者，安排服务器在系统启动和停止时自动启动和停止。有关说明，请参阅第 2.10.5 节，“自动启动和停止 MySQL”。
（可选）填充时区表以启用命名时区的识别。有关说明，请参阅
第 5.1.15 节，“MySQL 服务器时区支持”。
当您准备好创建其他用户帐户时，您可以在第 6.2 节“访问控制和帐户管理”
中找到有关 MySQL 访问控制系统和帐户管理的信息。
© Mysql 中文网
