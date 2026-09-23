# 2.4 在 macOS 上安装 MySQL_MySQL 8.0 参考手册

2.4 在 macOS 上安装 MySQL_MySQL 8.0 参考手册
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
2.4.1 macOS 安装MySQL 一般注意事项1
2.4.2 在 macOS 上使用原生包安装 MySQL1
2.4.3 安装和使用MySQL Launch Daemon1
2.4.4 安装和使用 MySQL 首选项面板1
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
2.4 在 macOS 上安装 MySQL
2.4 在 macOS 上安装 MySQL
2.4.1 macOS 安装MySQL 一般注意事项2.4.2 在 macOS 上使用原生包安装 MySQL2.4.3 安装和使用MySQL Launch Daemon2.4.4 安装和使用 MySQL 首选项面板
有关 MySQL 服务器支持的 macOS 版本列表，请参阅
https://www.mysql.com/support/supportedplatforms/database.html。
用于 macOS 的 MySQL 有多种不同的形式：
本机包安装程序，它使用本机 macOS 安装程序 (DMG) 引导您完成 MySQL 的安装。有关更多信息，请参阅第 2.4.2 节，“使用本机包在 macOS 上安装 MySQL”。您可以将软件包安装程序与 macOS 一起使用。用于执行安装的用户必须具有管理员权限。
压缩的 TAR 存档，它使用使用 Unix tar和gzip
命令打包的文件。要使用此方法，您需要打开一个
终端窗口。使用此方法不需要管理员权限；您可以使用此方法在任何地方安装 MySQL 服务器。有关使用此方法的更多信息，您可以使用使用 tarball 的通用说明，第 2.2 节，“使用通用二进制文件在 Unix/Linux 上安装 MySQL”。
除了核心安装之外，Package Installer 还包括第 2.4.3 节“安装和使用 MySQL 启动守护程序”和
第 2.4.4 节“安装和使用 MySQL 首选项面板”以简化安装管理。
有关在 macOS 上使用 MySQL 的其他信息，请参阅
第 2.4.1 节，“在 macOS 上安装 MySQL 的一般说明”。
© Mysql 中文网
