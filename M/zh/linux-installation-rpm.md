# 2.5.4 使用来自 Oracle 的 RPM 包在 Linux 上安装 MySQL_MySQL 8.0 参考手册

2.5.4 使用来自 Oracle 的 RPM 包在 Linux 上安装 MySQL_MySQL 8.0 参考手册
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
2.5.4 使用来自 Oracle 的 RPM 包在 Linux 上安装 MySQL
2.5.4 使用来自 Oracle 的 RPM 包在 Linux 上安装 MySQL
在基于 RPM 的 Linux 发行版上安装 MySQL 的推荐方法是使用 Oracle 提供的 RPM 包。对于 MySQL Community Edition，有两个获取它们的来源：
来自 MySQL 软件存储库：
MySQL Yum 存储库（有关详细信息，请参阅
第 2.5.1 节“使用 MySQL Yum 存储库在 Linux 上安装 MySQL”）。
MySQL SLES 存储库（有关详细信息，请参阅
第 2.5.3 节“使用 MySQL SLES 存储库在 Linux 上安装 MySQL”）。
从MySQL 开发人员专区的下载 MySQL 社区服务器页面
。
笔记
MySQL 的 RPM 发行版也由其他供应商提供。请注意，它们在特性、功能和约定（包括通信设置）方面可能与 Oracle 构建的不同，并且本手册中的安装说明不一定适用于它们。相反，应参考供应商的说明。
MySQL RPM 包
表 2.9 MySQL Community Edition 的 RPM 包
包裹名字
概括
mysql-community-client
MySQL 客户端应用程序和工具
mysql-community-common
服务器和客户端库的通用文件
mysql-community-devel
MySQL 数据库客户端应用程序的开发头文件和库
mysql-community-embedded-compat
MySQL 服务器作为嵌入式库，与使用该库版本 18 的应用程序兼容
mysql-community-libs
MySQL 数据库客户端应用程序的共享库
mysql-community-libs-compat
以前 MySQL 安装的共享兼容性库
mysql-community-server
数据库服务器及相关工具
mysql-community-server-debug
调试服务器和插件二进制文件
mysql-community-test
MySQL 服务器的测试套件
mysql-community
源代码 RPM 看起来类似于 mysql-community-8.0.31-1.el7.src.rpm，具体取决于所选操作系统
额外的 *debuginfo* RPM
有几个debuginfo包：mysql-community-client-debuginfo、mysql-community-libs-debuginfo mysql-community-server-debug-debuginfo mysql-community-server-debuginfo 和 mysql-community-test-debuginfo。
表 2.10 MySQL 企业版的 RPM 包
包裹名字
概括
mysql-commercial-backup
MySQL Enterprise Backup（8.0.11新增）
mysql-commercial-client
MySQL 客户端应用程序和工具
mysql-commercial-common
服务器和客户端库的通用文件
mysql-commercial-devel
MySQL 数据库客户端应用程序的开发头文件和库
mysql-commercial-embedded-compat
MySQL 服务器作为嵌入式库，与使用该库版本 18 的应用程序兼容
mysql-commercial-libs
MySQL 数据库客户端应用程序的共享库
mysql-commercial-libs-compat
以前 MySQL 安装的共享兼容性库；库的版本与您使用的发行版默认安装的库的版本相匹配
mysql-commercial-server
数据库服务器及相关工具
mysql-commercial-test
MySQL 服务器的测试套件
额外的 *debuginfo* RPM
有几个debuginfo软件包：mysql-commercial-client-debuginfo、mysql-commercial-libs-debuginfo mysql-commercial-server-debug-debuginfo mysql-commercial-server-debuginfo 和 mysql-commercial-test-debuginfo。
RPM 的全名具有以下语法：
packagename-version-distribution-arch.rpm
和值指示 Linux 发行版distribution和
arch构建包所针对的处理器类型。有关分发标识符的列表，请参见下表：
表 2.11 MySQL Linux RPM 包分发标识符
分配价值
有可能的使用
el{version}其中
{version}是主要的 Enterprise Linux 版本，例如el8
基于EL6、EL7、EL8、EL9的平台（例如对应版本的Oracle Linux、Red Hat Enterprise Linux、CentOS）
fc主要的 Fedora 版本{version}在哪里
{version}，比如fc34
Fedora 34 和 35
sles12
SUSE Linux 企业服务器 12
要查看 RPM 包中的所有文件（例如，
mysql-community-server），请使用以下命令：
$> rpm -qpl mysql-community-server-version-distribution-arch.rpm
本节其余部分的讨论仅适用于使用直接从 Oracle 下载的 RPM 包的安装过程，而不是通过 MySQL 存储库。
一些包之间存在依赖关系。如果您计划安装许多包，您可能希望下载 RPM 包tar文件，它包含上面列出的所有 RPM 包，这样您就不需要单独下载它们。
在大多数情况下，您需要安装
mysql-community-server、
mysql-community-client、
mysql-community-libs、
mysql-community-common和
mysql-community-libs-compat包以获得功能性的标准 MySQL 安装。要执行此类标准的基本安装，请转至包含所有这些包的文件夹（最好不要包含具有相似名称的其他 RPM 包），并发出以下命令：
$> sudo yum install mysql-community-{server,client,common,libs}-*对于 SLES，用zypper
替换yum ，对于 Fedora
，用dnf 。
虽然最好使用像yum这样的高级包管理工具来安装包，但更喜欢直接rpm命令的用户可以用rpm -Uvh命令替换
yum install命令；但是，使用rpm -Uvh
反而会使安装过程更容易失败，因为安装过程可能会遇到潜在的依赖性问题。
要仅安装客户端程序，您可以跳过
mysql-community-server要安装的软件包列表；发出以下命令：
$> sudo yum install mysql-community-{client,common,libs}-*对于 SLES，用zypper
替换yum ，对于 Fedora
，用dnf 。
使用 RPM 包的 MySQL 标准安装会导致在系统目录下创建文件和资源，如下表所示。
表 2.12 MySQL 开发人员专区的 Linux RPM 包的 MySQL 安装布局
文件或资源
地点
客户端程序和脚本
/usr/bin
mysqld服务器
/usr/sbin
配置文件
/etc/my.cnf
数据目录
/var/lib/mysql
错误日志文件
对于 RHEL、Oracle Linux、CentOS 或 Fedora 平台：
/var/log/mysqld.log
对于 SLES：/var/log/mysql/mysqld.log
的价值secure_file_priv
/var/lib/mysql-files
System V 初始化脚本
对于 RHEL、Oracle Linux、CentOS 或 Fedora 平台：
/etc/init.d/mysqld
对于 SLES：/etc/init.d/mysql
系统服务
对于 RHEL、Oracle Linux、CentOS 或 Fedora 平台：
mysqld
对于 SLES：mysql
文件
/var/run/mysql/mysqld.pid
插座
/var/lib/mysql/mysql.sock
密钥环目录
/var/lib/mysql-keyring
Unix 手册页
/usr/share/man
包含（头）文件
/usr/include/mysql
图书馆
/usr/lib/mysql
杂项支持文件（例如，错误消息和字符集文件）
/usr/share/mysql
安装还会在系统上创建一个名为的用户
mysql和一个名为的组
mysql。
笔记
使用旧包安装以前版本的 MySQL 可能会创建一个名为
/usr/my.cnf. 强烈建议您检查文件的内容并将所需的设置迁移到文件/etc/my.cnf
文件中，然后删除/usr/my.cnf.
MySQL 不会在安装过程结束时自动启动。对于 Red Hat Enterprise Linux、Oracle Linux、CentOS 和 Fedora 系统，使用以下命令启动 MySQL：
$> systemctl start mysqld
对于SLES系统，命令相同，只是服务名称不同：
$> systemctl start mysql
如果操作系统启用了 systemd，则应使用标准
systemctl（或者
参数相反的服务）命令（例如停止、启动、
状态和重启）来管理 MySQL 服务器服务。该
mysqld服务默认启用，并在系统重启时启动。请注意，某些事情在 systemd 平台上可能会有所不同：例如，更改数据目录的位置可能会导致问题。有关更多信息，请参阅
第 2.5.9 节，“使用 systemd 管理 MySQL 服务器”。
在使用 RPM 和 DEB 包进行升级安装期间，如果升级发生时 MySQL 服务器正在运行，则 MySQL 服务器停止，升级发生，MySQL 服务器重新启动。一个例外：如果版本在升级期间也发生了变化（例如社区到商业，反之亦然），则 MySQL 服务器不会重新启动。
在服务器的初始启动时，如果服务器的数据目录为空，则会发生以下情况：
服务器已初始化。
在数据目录中生成 SSL 证书和密钥文件。
validate_password
已安装并启用。
创建一个超级用户帐户'root'@'localhost'。超级用户的密码已设置并存储在错误日志文件中。要显示它，请对 RHEL、Oracle Linux、CentOS 和 Fedora 系统使用以下命令：
$> sudo grep 'temporary password' /var/log/mysqld.log
对 SLES 系统使用以下命令：
$> sudo grep 'temporary password' /var/log/mysql/mysqld.log
下一步是使用生成的临时密码登录并为超级用户帐户设置自定义密码：
$> mysql -uroot -pmysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass4!';
笔记
validate_password
默认安装。实现的默认密码策略validate_password要求密码至少包含1个大写字母、1个小写字母、1个数字和1个特殊字符，密码总长度至少为8个字符。
如果在安装期间出现问题，您可能会在错误日志文件中找到调试信息
/var/log/mysqld.log。
对于某些 Linux 发行版，可能需要增加对mysqld
可用的文件描述符数量的限制
。请参见
第 B.3.2.16 节，“未找到文件和类似错误”
从多个 MySQL 版本安装客户端库。
可以安装多个客户端库版本，例如您希望保持与链接到以前库的旧应用程序的兼容性的情况。要安装较旧的客户端库，请使用--oldpackage
带有rpm的选项。例如，要
在 MySQL 8.0mysql-community-libs-5.5的 EL6 系统上安装libmysqlclient.21，请使用如下命令：
$> rpm --oldpackage -ivh mysql-community-libs-5.5.50-2.el6.x86_64.rpm调试包。 使用调试包
编译的 MySQL 服务器的特殊变体
已包含在服务器 RPM 包中。它执行调试和内存分配检查，并在服务器运行时生成跟踪文件。要使用该调试版本，请使用 启动 MySQL
/usr/sbin/mysqld-debug，而不是将其作为服务启动或使用/usr/sbin/mysqld. 有关您可以使用的调试选项
，请参见第 5.9.4 节 “DBUG 包” 。
笔记
调试构建的默认插件目录
在 MySQL 8.0.4 中从更改/usr/lib64/mysql/plugin为
。/usr/lib64/mysql/plugin/debug以前，必须更改
plugin_dir为以
/usr/lib64/mysql/plugin/debug进行调试构建。
从源 SRPM 重建 RPM。
MySQL 的源代码 SRPM 包可供下载。它们可以按原样使用，通过标准的rpmbuild工具链重建 MySQL RPM。
© Mysql 中文网
