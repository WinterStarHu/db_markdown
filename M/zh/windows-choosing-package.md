# 2.3.2 选择安装包_MySQL 8.0 参考手册

2.3.2 选择安装包_MySQL 8.0 参考手册
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
2.3.2 选择安装包
2.3.2 选择安装包
对于MySQL 8.0，在Windows上安装MySQL时有多种安装包格式可供选择。本节中描述的包格式是：
MySQL安装程序MySQL noinstall ZIP 存档MySQL Docker 图像
程序数据库 (PDB) 文件（带有文件扩展名
pdb）提供在出现问题时调试 MySQL 安装的信息。这些文件包含在 MySQL 的 ZIP 存档分发版（但不包括 MSI 分发版）中。
MySQL安装程序
该软件包的文件名类似于
mysql-installer-community-8.0.31.0.msi
或
mysql-installer-commercial-8.0.31.0.msi，并利用 MSI 自动安装 MySQL 服务器和其他产品。MySQL Installer 下载并应用更新到自身，以及每个已安装的产品。它还配置已安装的 MySQL 服务器（包括沙箱 InnoDB 集群测试设置）和 MySQL 路由器。推荐大多数用户使用 MySQL Installer。
MySQL Installer 可以安装和管理（添加、修改、升级和删除）许多其他 MySQL 产品，包括：
应用程序——MySQL Workbench、MySQL for Visual Studio、MySQL Shell 和 MySQL Router（参见
https://mysql.net.cn/doc/mysql-compat-matrix/en/）
连接器——MySQL 连接器/C++、MySQL 连接器/NET、连接器/ODBC、MySQL 连接器/Python、MySQL 连接器/J、MySQL 连接器/Node.js
文档 – MySQL 手册（PDF 格式）、示例和示例
MySQL Installer 在所有支持 MySQL 的 Windows 版本上运行（参见
https://www.mysql.com/support/supportedplatforms/database.html）。
笔记
因为 MySQL Installer 不是 Microsoft Windows 的本机组件并且依赖于 .NET，所以它不适用于像 Windows Server 的 Server Core 版本这样的最小安装选项。
有关如何使用 MySQL Installer 安装 MySQL 的说明，请参阅
第 2.3.3 节，“Windows 的 MySQL 安装程序”。
MySQL noinstall ZIP 存档
这些包包含在完整的 MySQL 服务器安装包中找到的文件，GUI 除外。这种格式不包括自动安装程序，必须手动安装和配置。
noinstallZIP 档案被分成两个单独的压缩文件
。主包名为
. 这包含在您的系统上使用 MySQL 所需的组件。可选的 MySQL 测试套件、MySQL 基准套件和调试二进制文件/信息组件（包括 PDB 文件）位于一个名为
.
mysql-VERSION-winx64.zipmysql-VERSION-winx64-debug-test.zip
如果您选择安装noinstallZIP 存档，请参阅第 2.3.4 节，“使用
noinstallZIP 存档在 Microsoft Windows 上安装 MySQL”。
MySQL Docker 图像
有关在 Windows 平台上使用 Oracle 提供的 MySQL Docker 映像的信息，请参阅
第 2.5.6.3 节“使用 Docker 在 Windows 和其他非 Linux 平台上部署 MySQL”。
警告
Oracle 提供的 MySQL Docker 镜像是专门为 Linux 平台构建的。不支持其他平台，在这些平台上运行来自 Oracle 的 MySQL Docker 映像的用户需自行承担风险。
© Mysql 中文网
