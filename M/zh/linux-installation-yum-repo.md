# 2.5.1 使用 MySQL Yum 存储库在 Linux 上安装 MySQL_MySQL 8.0 参考手册

2.5.1 使用 MySQL Yum 存储库在 Linux 上安装 MySQL_MySQL 8.0 参考手册
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
2.5.1 使用 MySQL Yum 存储库在 Linux 上安装 MySQL
2.5.1 使用 MySQL Yum 存储库在 Linux 上安装 MySQL
用于 Oracle Linux、Red Hat Enterprise Linux、CentOS 和 Fedora
的MySQL Yum 存储库提供了用于安装 MySQL 服务器、客户端、MySQL Workbench、MySQL Utilities、MySQL Router、MySQL Shell、Connector/ODBC、Connector/Python 等的 RPM 包（并非所有软件包都适用于所有发行版；有关详细信息，请参阅
使用 Yum 安装其他 MySQL 产品和组件）。
在你开始之前
作为一种流行的开源软件，MySQL以其原始或重新打包的形式被广泛安装在许多系统上，来源多种多样，包括不同的软件下载站点、软件存储库等。以下说明假定 MySQL 尚未使用第三方分发的 RPM 软件包安装在您的系统上；如果不是这种情况，请按照
第 2.11.7 节“使用 MySQL Yum 存储库升级 MySQL”或
使用 MySQL Yum 存储库替换 MySQL 的第三方分发中给出的说明进行操作。
全新安装 MySQL 的步骤
按照以下步骤使用 MySQL Yum 存储库安装最新的 MySQL GA 版本：
添加 MySQL Yum 存储库
首先，将 MySQL Yum 存储库添加到系统的存储库列表中。这是一次性的操作，可以通过安装MySQL提供的RPM来完成。按着这些次序：
转到 MySQL 开发人员专区中的下载 MySQL Yum 存储库页面 ( https://mysql.net.cn/downloads/repo/yum/ )。
选择并下载适用于您的平台的发布包。
使用以下命令安装下载的发布包，替换
platform-and-version-specific-package-name
为下载的 RPM 包的名称：
$> sudo yum install platform-and-version-specific-package-name.rpm
对于基于 EL6 的系统，命令的形式为：
$> sudo yum install mysql80-community-release-el6-{version-number}.noarch.rpm
对于基于 EL7 的系统：
$> sudo yum install mysql80-community-release-el7-{version-number}.noarch.rpm
对于基于 EL8 的系统：
$> sudo yum install mysql80-community-release-el8-{version-number}.noarch.rpm
对于基于 EL9 的系统：
$> sudo yum install mysql80-community-release-el9-{version-number}.noarch.rpm
对于 Fedora 35：
$> sudo dnf install mysql80-community-release-fc35-{version-number}.noarch.rpm
对于 Fedora 34：
$> sudo dnf install mysql80-community-release-fc34-{version-number}.noarch.rpm
安装命令将 MySQL Yum 存储库添加到系统的存储库列表中，并下载 GnuPG 密钥以检查软件包的完整性。有关GnuPG 密钥检查的详细信息，
请参阅
第 2.1.4.2 节 “使用 GnuPG 进行签名检查” 。
您可以通过以下命令检查是否已成功添加 MySQL Yum 存储库（对于启用了 dnf 的系统，请将命令中的yum替换为dnf）：
$> yum repolist enabled | grep "mysql.*-community.*"
笔记
在您的系统上启用 MySQL Yum 存储库后，通过yum update
命令（或dnf upgrade对于启用 dnf 的系统）进行的任何系统范围更新都会升级您系统上的 MySQL 包并替换任何本机第三方包，如果 Yum 找到替代品在 MySQL Yum 存储库中为他们提供；请参阅
第 2.11.7 节，“使用 MySQL Yum 存储库升级 MySQL”，有关这对您系统的一些可能影响的讨论，请参阅
升级共享客户端库。
选择发布系列
使用MySQL Yum仓库时，默认选择最新的GA系列（目前为MySQL 8.0）进行安装。如果这是您想要的，您可以跳到下一步，
安装 MySQL。
在 MySQL Yum 存储库中，MySQL Community Server 的不同版本系列托管在不同的子存储库中。最新GA系列（目前MySQL 8.0）的子仓库默认开启，其他所有系列（如MySQL 8.0系列）的子仓库默认关闭。使用此命令查看 MySQL Yum 存储库中的所有子存储库，并查看其中哪些已启用或已禁用（对于启用 dnf 的系统，请将命令中的
yum替换为dnf）：
$> yum repolist all | grep mysql
要安装最新 GA 系列的最新版本，无需配置。要安装最新 GA 系列以外的特定系列的最新版本，请在运行安装命令之前禁用最新 GA 系列的子存储库并启用特定系列的子存储库。如果您的平台支持
yum-config-manager，您可以通过发出这些命令来实现，这些命令禁用 5.7 系列的子存储库并启用 8.0 系列的子存储库：
$> sudo yum-config-manager --disable mysql57-community
$> sudo yum-config-manager --enable mysql80-community
对于支持 dnf 的平台：
$> sudo dnf config-manager --disable mysql57-community
$> sudo dnf config-manager --enable mysql80-community
除了使用yum-config-manager或
dnf config-manager命令外，您还可以通过手动编辑
/etc/yum.repos.d/mysql-community.repo
文件来选择发布系列。这是文件中发布系列子存储库的典型条目：
[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/6/$basearch/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql-2022
file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql
找到您要配置的子存储库的条目，然后编辑该enabled选项。指定
enabled=0禁用子存储库或
enabled=1启用子存储库。例如，要安装 MySQL 8.0，请确保您拥有
enabled=0MySQL 5.7 的上述子存储库条目，以及
enabled=18.0 系列的条目：
# Enable to use MySQL 8.0
[mysql80-community]
name=MySQL 8.0 Community Server
baseurl=http://repo.mysql.com/yum/mysql-8.0-community/el/6/$basearch/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql-2022
file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql
您应该在任何时候只为一个发布系列启用子存储库。当启用多个发布系列的子存储库时，Yum 使用最新的系列。
通过运行以下命令并检查其输出来验证是否已启用和禁用正确的子存储库（对于启用 dnf 的系统，
将命令中的
yum替换为dnf）：
$> yum repolist enabled | grep mysql
禁用默认的 MySQL 模块
（仅限 EL8 系统）基于 EL8 的系统（例如 RHEL8 和 Oracle Linux 8）包括默认启用的 MySQL 模块。除非禁用此模块，否则它会屏蔽 MySQL 存储库提供的包。要禁用包含的模块并使 MySQL 存储库包可见，请使用以下命令（对于启用 dnf 的系统，
将命令中的
yum替换为dnf）：
$> sudo yum module disable mysql
安装 MySQL
通过以下命令安装 MySQL（对于启用了 dnf 的系统，将命令中的
yum替换为dnf）：
$> sudo yum install mysql-community-server
这将安装 MySQL 服务器包 ( mysql-community-server) 以及运行服务器所需组件的包，包括客户端包 ( mysql-community-client)、客户端和服务器的常见错误消息和字符集 ( mysql-community-common) 以及共享客户端库 ( mysql-community-libs) .
启动 MySQL 服务器
使用以下命令启动 MySQL 服务器：
$> systemctl start mysqld
您可以使用以下命令检查 MySQL 服务器的状态：
$> systemctl status mysqld
如果操作系统启用了 systemd，则应使用标准
systemctl（或者
参数相反的服务）命令（例如停止、启动、
状态和重启）来管理 MySQL 服务器服务。该
mysqld服务默认启用，并在系统重启时启动。有关更多信息，请参阅第 2.5.9 节，“使用 systemd 管理 MySQL 服务器”。
在服务器的初始启动时，如果服务器的数据目录为空，则会发生以下情况：
服务器已初始化。
SSL 证书和密钥文件在数据目录中生成。
validate_password
已安装并启用。
创建一个超级用户帐户'root'@'localhost。超级用户的密码已设置并存储在错误日志文件中。要显示它，请使用以下命令：
$> sudo grep 'temporary password' /var/log/mysqld.log
通过使用生成的临时密码登录并为超级用户帐户设置自定义密码，尽快更改 root 密码：
$> mysql -uroot -pmysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass4!';
笔记
validate_password
默认安装。实现的默认密码策略validate_password要求密码至少包含1个大写字母、1个小写字母、1个数字和1个特殊字符，密码总长度至少为8个字符。
有关安装后过程的更多信息，请参阅
第 2.10 节 “安装后设置和测试”。
笔记
基于 EL7 的平台的兼容性信息：来自平台本机软件存储库的以下 RPM 包与安装 MySQL 服务器的 MySQL Yum 存储库中的包不兼容。一旦使用 MySQL Yum 存储库安装了 MySQL，就无法安装这些包（反之亦然）。
akonadi-mysql
使用 Yum 安装其他 MySQL 产品和组件
您可以使用 Yum 安装和管理 MySQL 的各个组件。其中一些组件托管在 MySQL Yum 存储库的子存储库中：例如，MySQL Connectors 位于 MySQL Connectors Community 子存储库中，而 MySQL Workbench 位于 MySQL Tools Community 中。您可以使用以下命令从 MySQL Yum 存储库中列出适用于您的平台的所有 MySQL 组件的包（对于启用 dnf 的系统，
将命令中的
yum替换为dnf）：
$> sudo yum --disablerepo=\* --enablerepo='mysql*-community*' list available
使用以下命令安装您选择的任何包，替换package-name为包的名称（对于启用 dnf 的系统，
将命令中的yum替换为dnf）：
$> sudo yum install package-name
例如，要在 Fedora 上安装 MySQL Workbench：
$> sudo dnf install mysql-workbench-community
要安装共享客户端库（对于启用 dnf 的系统，请将命令中的
yum替换为dnf）：
$> sudo yum install mysql-community-libs
平台特定说明
ARM支持
Oracle Linux 7 支持 ARM 64 位 (aarch64)，并且需要 Oracle Linux 7 软件集合信息库 (ol7_software_collections)。例如，要安装服务器：
$> yum-config-manager --enable ol7_software_collections
$> yum install mysql-community-server
笔记
从 MySQL 8.0.12 开始，Oracle Linux 7 支持 ARM 64 位 (aarch64)。
已知限制
8.0.12版本需要
在执行该步骤
后通过执行调整libstdc++7路径。ln -s
/opt/oracle/oracle-armtoolset-1/root/usr/lib64
/usr/lib64/gcc7yum
install
使用 Yum 更新 MySQL
除了安装之外，您还可以使用 MySQL Yum 存储库对 MySQL 产品和组件执行更新。有关详细信息，请参阅
第 2.11.7 节 “使用 MySQL Yum 存储库升级 MySQL”。
© Mysql 中文网
