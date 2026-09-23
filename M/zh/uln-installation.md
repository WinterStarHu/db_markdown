# 2.6 使用坚不可摧的Linux网络（ULN）安装MySQL_MySQL 8.0 参考手册

2.6 使用坚不可摧的Linux网络（ULN）安装MySQL_MySQL 8.0 参考手册
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
2.6 使用坚不可摧的Linux网络（ULN）安装MySQL
2.6 使用坚不可摧的Linux网络（ULN）安装MySQL
Linux 支持许多不同的安装 MySQL 的解决方案，在第 2.5 节“在 Linux 上安装 MySQL”中有介绍。本节介绍的方法之一是从 Oracle 的 Unbreakable Linux Network (ULN) 安装。您可以在http://linux.oracle.com/下找到有关 Oracle Linux 和 ULN 的信息。
要使用 ULN，您需要获得 ULN 登录名并使用 ULN 注册用于安装的机器。这在
ULN FAQ中有详细描述。该页面还介绍了如何安装和更新软件包。
支持社区包和商业包，每个包都提供三个 MySQL 渠道：
Server: MySQL 服务器
Connectors：MySQL 连接器/C++、MySQL 连接器/J、MySQL 连接器/ODBC 和 MySQL 连接器/Python。
Tools：MySQL Router、MySQL Shell 和 MySQL Workbench
社区频道可供所有 ULN 用户使用。
在 oracle.linux.com 上访问商业 MySQL ULN 包需要您提供 CSI 以及 MySQL（企业版或标准版）的有效商业许可证。在撰写本文时，有效的购买是 60944、60945、64911 和 64912。适当的 CSI 使商业 MySQL 订阅频道在您的 ULN GUI 界面中可用。
使用 ULN 安装 MySQL 后，您可以在第 2.5.7 节“从本机软件存储库在 Linux 上安装 MySQL”，特别是
第 2.5.4 节“安装 MySQL”
中找到有关启动和停止服务器等的信息
在 Linux 上使用来自 Oracle 的 RPM 包”。
如果您正在更改您的包源以使用 ULN 而不是更改您正在使用的 MySQL 版本，那么备份您的数据，删除现有的二进制文件，并将它们替换为来自 ULN 的二进制文件。如果涉及构建更改，我们建议备份为转储（mysqldump或mysqlpump或来自
MySQL Shell 的备份实用程序），以防万一您需要在新二进制文件就位后重建数据。如果向 ULN 的转变跨越版本边界，请在继续之前查阅本节：
第 2.11 节，“升级 MySQL”。
笔记
从 MySQL 8.0.17 开始支持 Oracle Linux 8，并且在 MySQL 8.0.24 版本中添加了社区工具和连接器频道。
© Mysql 中文网
