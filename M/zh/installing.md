# 第 2 章安装和升级 MySQL_MySQL 8.0 参考手册

第 2 章安装和升级 MySQL_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  /
第 2 章安装和升级 MySQL
第 2 章安装和升级 MySQL
目录2.1 一般安装指南2.1.1 支持的平台2.1.2 安装哪个MySQL版本和发行版2.1.3 如何获取MySQL2.1.4 使用 MD5 校验和或 GnuPG 验证包完整性2.1.5 安装布置2.1.6 特定于编译器的构建特性2.2 使用通用二进制文件在 Unix/Linux 上安装 MySQL2.3 在 Microsoft Windows 上安装 MySQL2.3.1 MySQL 在Microsoft Windows 上的安装布局2.3.2 选择安装包2.3.3 Windows 版 MySQL 安装程序2.3.4 使用
noinstallZIP 存档在 Microsoft Windows 上安装 MySQL2.3.5 Microsoft Windows MySQL 服务器安装故障排除2.3.6 Windows 安装后程序2.3.7 Windows 平台限制2.4 在 macOS 上安装 MySQL2.4.1 macOS 安装MySQL 一般注意事项2.4.2 在 macOS 上使用原生包安装 MySQL2.4.3 安装和使用MySQL Launch Daemon2.4.4 安装和使用 MySQL 首选项面板2.5 在 Linux 上安装 MySQL2.5.1 使用 MySQL Yum 存储库在 Linux 上安装 MySQL2.5.2 使用 MySQL APT 存储库在 Linux 上安装 MySQL2.5.3 使用 MySQL SLES 存储库在 Linux 上安装 MySQL2.5.4 使用来自 Oracle 的 RPM 包在 Linux 上安装 MySQL2.5.5 使用 Oracle 的 Debian 软件包在 Linux 上安装 MySQL2.5.6 使用Docker在Linux上部署MySQL2.5.7 从本机软件存储库在 Linux 上安装 MySQL2.5.8 在 Linux 上使用 Juju 安装 MySQL2.5.9 使用 systemd 管理 MySQL 服务器2.6 使用坚不可摧的Linux网络（ULN）安装MySQL2.7 在 Solaris 上安装 MySQL2.7.1 使用 Solaris PKG 在 Solaris 上安装 MySQL2.8 在 FreeBSD 上安装 MySQL2.9 从源码安装MySQL2.9.1 源码安装方式2.9.2 源安装先决条件2.9.3 MySQL源码安装布局2.9.4 使用标准源代码分发安装 MySQL2.9.5 使用开发源树安装MySQL2.9.6 配置 SSL 库支持2.9.7 MySQL 源配置选项2.9.8 处理编译MySQL的问题2.9.9 MySQL配置和第三方工具2.9.10 生成MySQL Doxygen文档内容2.10 安装后设置和测试2.10.1 初始化数据目录2.10.2 启动服务器2.10.3 测试服务器2.10.4 保护初始 MySQL 帐户2.10.5 自动启动和停止MySQL2.11 升级MySQL2.11.1 开始之前2.11.2 升级路径2.11.3 MySQL升级过程升级了什么2.11.4 MySQL 8.0 的变化2.11.5 准备升级安装2.11.6 在 Unix/Linux 上升级 MySQL 二进制或基于包的安装2.11.7 使用 MySQL Yum 仓库升级 MySQL2.11.8 使用MySQL APT Repository升级MySQL2.11.9 使用 MySQL SLES 存储库升级 MySQL2.11.10 Windows 升级MySQL2.11.11 升级MySQL的Docker安装2.11.12 升级故障处理2.11.13 重建或修复表或索引2.11.14 复制MySQL数据库到另一台机器2.12 降级MySQL2.13 Perl 安装注意事项2.13.1 在 Unix 上安装 Perl2.13.2 在 Windows 上安装 ActiveState Perl2.13.3 使用 Perl DBI/DBD 接口的问题
本章介绍如何获取和安装 MySQL。该过程的摘要如下，后面的部分提供了详细信息。如果您计划将现有版本的 MySQL 升级到更新版本而不是第一次安装 MySQL，请参阅
第 2.11 节，“升级 MySQL”，了解有关升级过程和升级前应考虑的问题的信息。
如果您有兴趣从另一个数据库系统迁移到 MySQL，请参阅第 A.8 节，“MySQL 8.0 常见问题解答：迁移”，其中包含有关迁移问题的一些常见问题的答案。
MySQL 的安装通常遵循此处概述的步骤：
确定 MySQL 是否在您的平台上运行和受支持。
请注意，并非所有平台都同样适合运行 MySQL，而且并非所有已知运行 MySQL 的平台都得到 Oracle Corporation 的正式支持。有关官方支持的平台的信息，请参阅MySQL 网站上的
https://www.mysql.com/support/supportedplatforms/database.html 。
选择要安装的发行版。
有多个版本的 MySQL 可用，并且大多数都以多种分发格式提供。您可以从包含二进制（预编译）程序或源代码的预打包发行版中进行选择。如有疑问，请使用二进制分发。Oracle 还为那些想要查看最新开发和测试新代码的人提供了对 MySQL 源代码的访问。要确定您应该使用哪个版本和类型的发行版，请参阅第 2.1.2 节，“安装哪个 MySQL 版本和发行版”。
下载您要安装的发行版。
有关说明，请参阅第 2.1.3 节，“如何获取 MySQL”。要验证分发的完整性，请使用
第 2.1.4 节“使用 MD5 校验和或 GnuPG 验证包完整性”中的说明。
安装发行版。
要从二进制分发版安装 MySQL，请使用第 2.2 节“使用通用二进制文件在 Unix/Linux 上安装 MySQL”中的说明。或者，使用
Secure Deployment Guide，它提供了部署 MySQL Enterprise Edition Server 的通用二进制分发的过程，具有管理 MySQL 安装安全性的功能。
要从源代码分发或当前开发源代码树安装 MySQL，请使用
第 2.9 节“从源代码安装 MySQL”中的说明。
执行任何必要的安装后设置。
安装 MySQL 后，请参阅第 2.10 节“安装后设置和测试”
以获取有关确保 MySQL 服务器正常工作的信息。另请参阅
第 2.10.4 节“保护初始 MySQL 帐户”中提供的信息。本节介绍如何保护初始 MySQLroot用户帐户，在您分配一个密码之前，该帐户没有密码。无论您是使用二进制还是源代码分发安装 MySQL，本节都适用。
如果您想运行 MySQL 基准测试脚本，则必须提供对 MySQL 的 Perl 支持。请参见第 2.13 节 “Perl 安装说明”。
在不同平台和环境中安装 MySQL 的说明可在不同平台的基础上获得：
Unix、Linux、FreeBSD
有关使用通用二进制文件（例如，
.tar.gz软件包）在大多数 Linux 和 Unix 平台上安装 MySQL 的说明，请参阅
第 2.2 节，“使用通用二进制文件在 Unix/Linux 上安装 MySQL”。
有关完全从源代码分发或源代码存储库构建 MySQL 的信息，请参阅
第 2.9 节，“从源代码安装 MySQL”
有关从源代码安装、配置和构建的特定平台帮助，请参阅相应的平台部分：
Linux，包括关于分发特定方法的注释，请参阅
第 2.5 节，“在 Linux 上安装 MySQL”。
IBM AIX，请参阅第 2.7 节，“在 Solaris 上安装 MySQL”。
FreeBSD，请参阅第 2.8 节，“在 FreeBSD 上安装 MySQL”。
微软Windows
有关使用 MySQL 安装程序或压缩二进制文件在 Microsoft Windows 上安装 MySQL 的说明，请参阅
第 2.3 节，“在 Microsoft Windows 上安装 MySQL”。
有关使用 Microsoft Visual Studio 从源代码构建 MySQL 的详细信息和说明，请参阅
第 2.9 节，“从源代码安装 MySQL”。
苹果系统
对于 macOS 上的安装，包括使用二进制包和本机 PKG 格式，请参阅
第 2.4 节，“在 macOS 上安装 MySQL”。
有关使用 macOS 启动守护程序自动启动和停止 MySQL 的信息，请参阅
第 2.4.3 节，“安装和使用 MySQL 启动守护程序”。
有关 MySQL 首选项面板的信息，请参阅
第 2.4.4 节，“安装和使用 MySQL 首选项面板”。
© Mysql 中文网
