# 2.11.7 使用 MySQL Yum 仓库升级 MySQL_MySQL 8.0 参考手册

2.11.7 使用 MySQL Yum 仓库升级 MySQL_MySQL 8.0 参考手册
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
2.11.7 使用 MySQL Yum 仓库升级 MySQL
2.11.7 使用 MySQL Yum 仓库升级 MySQL
对于受支持的基于 Yum 的平台（请参阅
第 2.5.1 节“使用 MySQL Yum 存储库在 Linux 上安装 MySQL”以获得列表），您可以对 MySQL 执行就地升级（即替换旧版本，然后使用旧数据文件运行新版本）与 MySQL Yum 存储库。
笔记
在对 MySQL 执行任何更新之前，请仔细按照第 2.11 节“升级 MySQL”中的说明进行操作。在那里讨论的其他说明中，在更新之前备份数据库尤为重要。
以下说明假设您已经使用 MySQL Yum 存储库或直接从
MySQL Developer Zone 的 MySQL 下载页面下载的 RPM 包安装了 MySQL ；如果不是这种情况，请按照
使用 MySQL Yum 存储库替换 MySQL 的第三方分发中的说明进行操作。
选择目标系列
默认情况下，MySQL Yum 存储库将 MySQL 更新到您在安装期间选择的发布系列中的最新版本（有关详细信息，请参阅选择发布系列
），这意味着，例如，5.7.x 安装不会
更新到8.0.x。 x 自动释放。要更新到另一个发布系列，您必须首先禁用已选择的系列的子存储库（默认情况下，或您自己）并为您的目标系列启用子存储库。为此，请参阅选择发布系列中给出的一般说明。要从 MySQL 5.7 升级到 8.0，请执行与选择发布系列中所示的步骤相反，禁用 MySQL 5.7 系列的子存储库并为 MySQL 8.0 系列启用它。
作为一般规则，要从一个发布系列升级到另一个发布系列，请转到下一个系列而不是跳过一个系列。例如，如果您当前正在运行 MySQL 5.6 并希望升级到 8.0，请先升级到 MySQL 5.7，然后再升级到 8.0。
重要的
有关从 MySQL 5.7 升级到 8.0 的重要信息，请参阅
从 MySQL 5.7 升级到 8.0。
升级 MySQL
对于未启用 dnf 的平台，通过以下命令升级 MySQL 及其组件：
sudo yum update mysql-server
对于支持 dnf 的平台：
sudo dnf upgrade mysql-server
或者，您可以通过告诉 Yum 更新您系统上的所有内容来更新 MySQL，这可能需要相当多的时间。对于未启用 dnf 的平台：
sudo yum update
对于支持 dnf 的平台：
sudo dnf upgrade
重启MySQL
MySQL 服务器总是在 Yum 更新后重新启动。在 MySQL 8.0.16 之前，在服务器重新启动后运行mysql_upgrade
以检查并可能解决旧数据与升级软件之间的任何不兼容问题。mysql_upgrade还执行其他功能；有关详细信息，请参阅
第 4.4.5 节，“mysql_upgrade — 检查和升级 MySQL 表”。从 MySQL 8.0.16 开始，不需要此步骤，因为服务器执行以前由mysql_upgrade处理的所有任务。
您也可以仅更新特定组件。使用以下命令列出 MySQL 组件的所有已安装包（对于启用 dnf 的系统，
将命令中的
yum替换为dnf）：
sudo yum list installed | grep "^mysql"
确定您选择的组件的包名称后，使用以下命令更新包，替换
package-name为包的名称。对于未启用 dnf 的平台：
sudo yum update package-name
对于支持 dnf 的平台：
sudo dnf upgrade package-name
升级共享客户端库
使用 Yum 存储库更新 MySQL 后，使用旧版本共享客户端库编译的应用程序应该可以继续工作。
如果您重新编译应用程序并将它们与更新的库动态链接：作为典型的共享库的新版本，新旧库之间的符号版本控制存在差异或添加（例如，在较新的标准 8.0 共享客户端库和一些较旧的共享库版本（先前或变体）之间本地由 Linux 发行版的软件存储库或来自其他来源），任何使用更新的、较新的共享库编译的应用程序都需要在部署应用程序的系统上使用这些更新的库。正如预期的那样，如果这些库没有到位，则需要共享库的应用程序将失败。出于这个原因，请务必在这些系统上部署来自 MySQL 的共享库的包。去做这个，添加 MySQL Yum 存储库）并使用使用Yum 安装其他 MySQL 产品和组件中给出的说明安装最新的共享库
。
© Mysql 中文网
