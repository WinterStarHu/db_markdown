# 2.10.5 自动启动和停止MySQL_MySQL 8.0 参考手册

2.10.5 自动启动和停止MySQL_MySQL 8.0 参考手册
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
2.3.1 MySQL 在Microsoft Windows 上的安装布局1
2.3.2 选择安装包1
2.3.3 Windows 版 MySQL 安装程序1
2.3.4 使用 noinstall ZIP 存档在 Microsoft Windows 上安装 MySQL1
2.3.5 Microsoft Windows MySQL 服务器安装故障排除1
2.3.6 Windows 安装后程序1
2.10.1 初始化数据目录
2.10.2 启动服务器
2.10.3 测试服务器
2.10.4 保护初始 MySQL 帐户
2.10.5 自动启动和停止MySQL
2.3.7 Windows 平台限制1
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.3 在 Microsoft Windows 上安装 MySQL  / 2.3.6 Windows 安装后程序  /
2.10.5 自动启动和停止MySQL
2.10.5 自动启动和停止MySQL
本节讨论启动和停止 MySQL 服务器的方法。
通常，您可以通过以下方式之一
启动mysqld服务器：
直接调用mysqld。这适用于任何平台。
在 Windows 上，您可以设置在 Windows 启动时自动运行的 MySQL 服务。请参阅
第 2.3.4.8 节，“将 MySQL 作为 Windows 服务启动”。
在 Unix 和类 Unix 系统上，您可以调用
mysqld_safe，它会尝试确定mysqld的正确选项，然后使用这些选项运行它。参见第 4.3.2 节，“mysqld_safe — MySQL 服务器启动脚本”。
在支持 systemd 的 Linux 系统上，您可以使用它来控制服务器。请参阅第 2.5.9 节，“使用 systemd 管理 MySQL 服务器”。
在使用 System V 风格运行目录（即
/etc/init.d运行级别特定目录）的系统上，调用mysql.server。该脚本主要用于系统启动和关闭。它通常安装在名称下mysql。mysql.server脚本通过调用mysqld_safe启动服务器。请参阅
第 4.3.3 节，“mysql.server — MySQL 服务器启动脚本”。
在 macOS 上，安装 launchd 守护进程以在系统启动时启用 MySQL 自动启动。守护进程通过调用mysqld_safe启动服务器。有关详细信息，请参阅
第 2.4.3 节，“安装和使用 MySQL 启动守护程序”。MySQL 首选项面板还提供了通过系统首选项启动和停止 MySQL 的控制。请参阅
第 2.4.4 节，“安装和使用 MySQL 首选项面板”。
在 Solaris 上，使用服务管理框架 (SMF) 系统来启动和控制 MySQL 的启动。
systemd、mysqld_safe和
mysql.server脚本、Solaris SMF 和 macOS 启动项（或 MySQL 首选项窗格）可用于手动启动服务器，或在系统启动时自动启动。systemd、mysql.server和启动项也可用于停止服务器。
下表显示了服务器和启动脚本从选项文件中读取的选项组。
表 2.15 MySQL 启动脚本和支持的服务器选项组
脚本
选项组
mysqld
[mysqld], [server],
[mysqld-major_version]
mysqld_safe
[mysqld], [server],
[mysqld_safe]
mysql.server
[mysqld], [mysql.server],
[server]
[mysqld-major_version]
表示
具有 5.7.x、8.0.x 等版本的服务器读取名称类似于[mysqld-5.7]和
的组。[mysqld-8.0]此功能可用于指定只能由给定版本系列中的服务器读取的选项。
为了向后兼容，mysql.server也读取该[mysql_server]组，
mysqld_safe也读取该
[safe_mysqld]组。要保持最新状态，您应该更新您的选项文件以改为使用
[mysql.server]和
[mysqld_safe]组。
有关 MySQL 配置文件及其结构和内容的更多信息，请参阅第 4.2.2.2 节，“使用选项文件”。
© Mysql 中文网
