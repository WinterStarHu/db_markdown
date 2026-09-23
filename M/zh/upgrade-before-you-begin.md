# 2.11.1 开始之前_MySQL 8.0 参考手册

2.11.1 开始之前_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.11 升级MySQL  /
2.11.1 开始之前
2.11.1 开始之前
升级前查看本节中的信息。执行任何建议的操作。
了解升级过程中可能发生的情况。请参阅
第 2.11.3 节，“MySQL 升级过程升级了什么”。
通过创建备份来保护您的数据。备份应包括mysql系统数据库，其中包含 MySQL 数据字典表和系统表。请参阅第 7.2 节，“数据库备份方法”。
重要的
不支持从 MySQL 8.0 降级到 MySQL 5.7，或从 MySQL 8.0 版本降级到以前的 MySQL 8.0 版本。唯一受支持的替代方法是恢复升级前的备份。因此，您必须在开始升级过程之前备份您的数据。
查看第 2.11.2 节“升级路径”以确保支持您预期的升级路径。
查看第 2.11.4 节，“MySQL 8.0中的更改”以了解升级前应注意的更改。某些更改可能需要采取行动。
查看第 1.3 节，“MySQL 8.0 中的新功能”以了解已弃用和删除的功能。如果您使用其中任何功能，升级可能需要对这些功能进行更改。
查看第 1.4 节，“MySQL 8.0 中添加、弃用或删除的服务器和状态变量和选项”。如果您使用已弃用或已删除的变量，升级可能需要更改配置。
查看
发行说明以获取有关修复、更改和新功能的信息。
如果您使用复制，请查看
第 17.5.3 节，“升级复制拓扑”。
升级过程因平台和初始安装的执行方式而异。使用适用于当前 MySQL 安装的过程：
对于非 Windows 平台上的二进制和基于包的安装，请参阅
第 2.11.6 节，“在 Unix/Linux 上升级 MySQL 二进制或基于包的安装”。
笔记
对于受支持的 Linux 发行版，升级基于包的安装的首选方法是使用 MySQL 软件存储库（MySQL Yum 存储库、MySQL APT 存储库和 MySQL SLES 存储库）。
对于使用 MySQL Yum 存储库在 Enterprise Linux 平台或 Fedora 上的安装，请参阅
第 2.11.7 节“使用 MySQL Yum 存储库升级 MySQL”。
对于使用 MySQL APT 存储库在 Ubuntu 上进行的安装，请参阅第 2.11.8 节“使用 MySQL APT 存储库升级 MySQL”。
对于使用 MySQL SLES 存储库在 SLES 上进行的安装，请参阅第 2.11.9 节“使用 MySQL SLES 存储库升级 MySQL”。
对于使用 Docker 执行的安装，请参阅
第 2.11.11 节，“升级 MySQL 的 Docker 安装”。
对于 Windows 上的安装，请参阅
第 2.11.10 节，“在 Windows 上升级 MySQL”。
如果您的 MySQL 安装包含大量数据，在就地升级后可能需要很长时间才能转换，那么创建一个测试实例来评估所需的转换以及执行这些转换所涉及的工作可能会很有用。要创建测试实例，请复制包含
mysql数据库和其他没有数据的数据库的 MySQL 实例。在测试实例上运行升级过程以评估执行实际数据转换所涉及的工作。
当您安装或升级到新版本的 MySQL 时，建议重建和重新安装 MySQL 语言界面。这适用于 MySQL 接口，例如 PHP
mysql扩展和 Perl
DBD::mysql模块。
© Mysql 中文网
