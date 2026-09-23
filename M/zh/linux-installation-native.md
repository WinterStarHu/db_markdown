# 2.5.7 从本机软件存储库在 Linux 上安装 MySQL_MySQL 8.0 参考手册

2.5.7 从本机软件存储库在 Linux 上安装 MySQL_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.5 在 Linux 上安装 MySQL  /
2.5.7 从本机软件存储库在 Linux 上安装 MySQL
2.5.7 从本机软件存储库在 Linux 上安装 MySQL
许多 Linux 发行版在其本地软件存储库中包含一个版本的 MySQL 服务器、客户端工具和开发组件，并且可以与平台的标准包管理系统一起安装。本节提供使用这些包管理系统安装 MySQL 的基本说明。
重要的
本机包通常比当前可用版本落后几个版本。您通常也无法安装开发里程碑版本 (DMR)，因为这些通常不会在本机存储库中提供。在继续之前，我们建议您查看
第 2.5 节“在 Linux 上安装 MySQL”中描述的其他安装选项。
具体分配说明如下：
红帽 Linux、Fedora、CentOS
笔记
对于许多 Linux 发行版，您可以使用 MySQL Yum 存储库而不是平台的本机软件存储库来安装 MySQL。有关详细信息，请参阅
第 2.5.1 节，“使用 MySQL Yum 存储库在 Linux 上安装 MySQL”。
对于 Red Hat 和类似的发行版，MySQL 发行版分为许多单独的包，
mysql用于客户端工具、
mysql-server服务器和相关工具以及mysql-libs库。如果您想提供来自不同语言和环境（例如 Perl、Python 和其他语言）的连接，则需要这些库。
要安装，请使用yum命令指定要安装的包。例如：
#> yum install mysql mysql-server mysql-libs mysql-server
Loaded plugins: presto, refresh-packagekit
Setting up Install Process
Resolving Dependencies
--> Running transaction check
---> Package mysql.x86_64 0:5.1.48-2.fc13 set to be updated
---> Package mysql-libs.x86_64 0:5.1.48-2.fc13 set to be updated
---> Package mysql-server.x86_64 0:5.1.48-2.fc13 set to be updated
--> Processing Dependency: perl-DBD-MySQL for package: mysql-server-5.1.48-2.fc13.x86_64
--> Running transaction check
---> Package perl-DBD-MySQL.x86_64 0:4.017-1.fc13 set to be updated
--> Finished Dependency Resolution
Dependencies Resolved
================================================================================
Package               Arch          Version               Repository      Size
================================================================================
Installing:
mysql                 x86_64        5.1.48-2.fc13         updates        889 k
mysql-libs            x86_64        5.1.48-2.fc13         updates        1.2 M
mysql-server          x86_64        5.1.48-2.fc13         updates        8.1 M
Installing for dependencies:
perl-DBD-MySQL        x86_64        4.017-1.fc13          updates        136 k
Transaction Summary
================================================================================
Install       4 Package(s)
Upgrade       0 Package(s)
Total download size: 10 M
Installed size: 30 M
Is this ok [y/N]: y
Downloading Packages:
Setting up and reading Presto delta metadata
Processing delta metadata
Package(s) data still to download: 10 M
(1/4): mysql-5.1.48-2.fc13.x86_64.rpm                    | 889 kB     00:04
(2/4): mysql-libs-5.1.48-2.fc13.x86_64.rpm               | 1.2 MB     00:06
(3/4): mysql-server-5.1.48-2.fc13.x86_64.rpm             | 8.1 MB     00:40
(4/4): perl-DBD-MySQL-4.017-1.fc13.x86_64.rpm            | 136 kB     00:00
--------------------------------------------------------------------------------
Total                                           201 kB/s |  10 MB     00:52
Running rpm_check_debug
Running Transaction Test
Transaction Test Succeeded
Running Transaction
Installing     : mysql-libs-5.1.48-2.fc13.x86_64                          1/4
Installing     : mysql-5.1.48-2.fc13.x86_64                               2/4
Installing     : perl-DBD-MySQL-4.017-1.fc13.x86_64                       3/4
Installing     : mysql-server-5.1.48-2.fc13.x86_64                        4/4
Installed:
mysql.x86_64 0:5.1.48-2.fc13            mysql-libs.x86_64 0:5.1.48-2.fc13
mysql-server.x86_64 0:5.1.48-2.fc13
Dependency Installed:
perl-DBD-MySQL.x86_64 0:4.017-1.fc13
Complete!
现在应该安装 MySQL 和 MySQL 服务器。示例配置文件安装到
/etc/my.cnf. 要启动 MySQL 服务器，请使用systemctl：
$> systemctl start mysqld
如果数据库表尚不存在，则会自动为您创建它们。但是，您应该运行
mysql_secure_installation以在您的服务器上设置 root 密码。
Debian、Ubuntu、Kubuntu
笔记
对于受支持的 Debian 和 Ubuntu 版本，可以使用
MySQL APT 存储库而不是平台的本机软件存储库来安装 MySQL。有关详细信息，请参阅
第 2.5.2 节，“使用 MySQL APT 存储库在 Linux 上安装 MySQL”。
在 Debian 和相关发行版上，它们的软件存储库中有两个 MySQL 包，
mysql-client分别
mysql-server用于客户端和服务器组件。例如，您应该指定一个明确的版本，mysql-client-5.1以确保安装所需的 MySQL 版本。
要下载和安装，包括任何依赖项，请使用
apt-get命令，指定要安装的包。
笔记
安装之前，请确保更新
apt-get索引文件以确保下载最新的可用版本。
笔记
apt-get命令安装许多包，包括 MySQL 服务器，以提供典型的工具和应用程序环境
。这可能意味着除了主要的 MySQL 包之外，您还安装了大量的包。
在安装过程中，会创建初始数据库，并提示您输入 MySQL root 密码（并确认）。配置文件创建在
/etc/mysql/my.cnf. 在中创建了一个初始化脚本/etc/init.d/mysql。
服务器应该已经启动。您可以使用以下方法手动启动和停止服务器：
#> service mysql [start|stop]
服务自动添加到2、3、4运行级别，在single、shutdown和restart级别有停止脚本。
© Mysql 中文网
