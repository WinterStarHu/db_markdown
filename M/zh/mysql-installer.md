# 2.3.3 Windows 版 MySQL 安装程序_MySQL 8.0 参考手册

2.3.3 Windows 版 MySQL 安装程序_MySQL 8.0 参考手册
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
2.3.3.1 MySQL 安装程序初始设置
2.3.3.2 使用 MySQL 安装程序设置备用服务器路径
2.3.3.3 使用 MySQL Installer 的安装工作流程
2.3.3.4 MySQL 安装程序产品目录和仪表板
2.3.3.5 MySQL 安装程序控制台参考
2.3.4 使用 noinstall ZIP 存档在 Microsoft Windows 上安装 MySQL1
2.3.5 Microsoft Windows MySQL 服务器安装故障排除1
2.3.6 Windows 安装后程序1
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.3 在 Microsoft Windows 上安装 MySQL  /
2.3.3 Windows 版 MySQL 安装程序
2.3.3 Windows 版 MySQL 安装程序
2.3.3.1 MySQL 安装程序初始设置2.3.3.2 使用 MySQL 安装程序设置备用服务器路径2.3.3.3 使用 MySQL Installer 的安装工作流程2.3.3.4 MySQL 安装程序产品目录和仪表板2.3.3.5 MySQL 安装程序控制台参考
MySQL Installer 是一个独立的应用程序，旨在简化安装和配置在 Microsoft Windows 上运行的 MySQL 产品的复杂性。它支持以下 MySQL 产品：
MySQL 服务器
MySQL Installer 可以同时在同一主机上安装和管理多个独立的 MySQL 服务器实例。例如，MySQL Installer 可以在同一主机上安装、配置和升级 MySQL 5.6、MySQL 5.7 和 MySQL 8.0 的单独实例。MySQL Installer 不允许在主要版本号和次要版本号之间进行服务器升级，但允许在发布系列（例如 8.0.21 到 8.0.22）内进行升级。
笔记
MySQL 安装程序无法在同一台主机上同时安装MySQL 服务器的社区版和
商业版。如果您需要在同一台主机上使用这两个版本，请考虑使用
ZIP 存档分发来安装其中一个版本。
MySQL应用程序
MySQL Workbench、MySQL Shell、MySQL Router 和 MySQL for Visual Studio。
MySQL 连接器
MySQL 连接器/NET、MySQL 连接器/Python、MySQL 连接器/ODBC、MySQL 连接器/J 和 MySQL 连接器/C++。要安装 MySQL Connector/Node.js，请参阅
https://mysql.net.cn/downloads/connector/nodejs/。
文档和示例
PDF 格式的 MySQL 参考手册（按版本）和 MySQL 数据库示例（按版本）。
安装要求
MySQL 安装程序需要 Microsoft .NET Framework 4.5.2 或更高版本。如果主机上未安装此版本，您可以访问
Microsoft 网站进行下载。
需要互联网连接才能下载包含最新 MySQL 产品元数据的清单，这些产品不属于完整捆绑包。当您第一次启动应用程序时，MySQL Installer 会尝试下载清单，然后以可配置的时间间隔定期下载（请参阅MySQL Installer 选项）。或者，您可以通过单击MySQL 安装程序仪表板中的
目录来手动检索更新的清单。
笔记
如果第一次或随后的清单下载不成功，则会记录一个错误，并且您在会话期间对 MySQL 产品的访问可能会受到限制。MySQL Installer 尝试在每次启动时下载清单，直到更新初始清单结构。如需查找产品的帮助，请参阅
查找要安装的产品。
MySQL 安装程序社区发布
从https://mysql.net.cn/downloads/installer/
下载软件
以安装适用于 Windows 的所有 MySQL 产品的社区版本。选择以下 MySQL 安装程序包选项之一：
Web：仅包含 MySQL 安装程序和配置文件。Web 包选项仅下载您选择安装的 MySQL 产品，但每次下载都需要互联网连接。该文件的大小约为 2 MB。文件名格式
为MySQL 服务器版本号，如 8.0 和
包号，从 0 开始。
mysql-installer-community-web-VERSION.N.msiVERSIONN
Full or Current Bundle：捆绑所有适用于 Windows 的 MySQL 产品（包括 MySQL 服务器）。文件大小超过300MB，名称格式
为MySQL Server版本号，如8.0，
为包号，从0开始。
mysql-installer-community-VERSION.N.msiVERSIONN
MySQL 安装程序商业版
从https://edelivery.oracle.com/
下载软件
以安装适用于 Windows 的 MySQL 产品的商业版本（标准版或企业版）。如果您登录到您的 My Oracle Support (MOS) 帐户，商业版本包括社区版本中可用的所有当前和以前的 GA 版本，但不包括开发里程碑版本。未登录时，您只会看到已下载的捆绑产品列表。
商业版还包括以下产品：
工作台SE/EE
MySQL 企业备份
MySQL 企业防火墙
商业版与您的 MOS 帐户集成。有关知识库内容和补丁，请参阅
My Oracle Support。
© Mysql 中文网
