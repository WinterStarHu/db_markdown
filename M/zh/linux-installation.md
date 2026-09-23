# 2.5 在 Linux 上安装 MySQL_MySQL 8.0 参考手册

2.5 在 Linux 上安装 MySQL_MySQL 8.0 参考手册
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
2.5.1 使用 MySQL Yum 存储库在 Linux 上安装 MySQL1
2.5.2 使用 MySQL APT 存储库在 Linux 上安装 MySQL1
2.5.3 使用 MySQL SLES 存储库在 Linux 上安装 MySQL1
2.5.4 使用来自 Oracle 的 RPM 包在 Linux 上安装 MySQL1
2.5.5 使用 Oracle 的 Debian 软件包在 Linux 上安装 MySQL1
2.5.6 使用Docker在Linux上部署MySQL1
2.5.7 从本机软件存储库在 Linux 上安装 MySQL1
2.5.8 在 Linux 上使用 Juju 安装 MySQL1
2.5.9 使用 systemd 管理 MySQL 服务器1
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
2.5 在 Linux 上安装 MySQL
2.5 在 Linux 上安装 MySQL
2.5.1 使用 MySQL Yum 存储库在 Linux 上安装 MySQL2.5.2 使用 MySQL APT 存储库在 Linux 上安装 MySQL2.5.3 使用 MySQL SLES 存储库在 Linux 上安装 MySQL2.5.4 使用来自 Oracle 的 RPM 包在 Linux 上安装 MySQL2.5.5 使用 Oracle 的 Debian 软件包在 Linux 上安装 MySQL2.5.6 使用Docker在Linux上部署MySQL2.5.7 从本机软件存储库在 Linux 上安装 MySQL2.5.8 在 Linux 上使用 Juju 安装 MySQL2.5.9 使用 systemd 管理 MySQL 服务器
Linux 支持多种不同的 MySQL 安装解决方案。我们建议您使用 Oracle 的其中一种发行版，它有多种安装方法：
表 2.8 Linux 安装方法和信息
类型
设置方法
附加信息
易于
启用MySQL Apt 存储库
文档
百胜
启用MySQL Yum 存储库
文档
赛珀
启用MySQL SLES 存储库
文档
转速
下载特定包
文档
DEB
下载特定包
文档
通用的
下载通用包
文档
资源
从源代码编译
文档
码头工人
使用Oracle 容器注册表。您还可以使用适用于 MySQL 社区版的 Docker Hub 和
适用于 MySQL 企业版的My Oracle Support。
文档
Oracle 坚不可摧的 Linux 网络
使用 ULN 频道
文档
作为替代方案，您可以使用系统上的包管理器从 Linux 发行版的本机软件存储库中自动下载和安装 MySQL 包。这些本机包通常比当前可用版本落后几个版本。您通常也无法安装开发里程碑版本 (DMR)，因为这些通常不会在本机存储库中提供。有关使用本机软件包安装程序的更多信息，请参阅
第 2.5.7 节，“从本机软件存储库在 Linux 上安装 MySQL”。
笔记
对于许多 Linux 安装，您希望将 MySQL 设置为在您的机器启动时自动启动。许多本机包安装会为您执行此操作，但对于源代码、二进制和 RPM 解决方案，您可能需要单独进行设置。所需的脚本mysql.server可以在support-filesMySQL 安装目录下的目录或 MySQL 源代码树中找到。您可以像/etc/init.d/mysql自动启动和关闭 MySQL 一样安装它。请参阅
第 4.3.3 节，“mysql.server — MySQL 服务器启动脚本”。
© Mysql 中文网
