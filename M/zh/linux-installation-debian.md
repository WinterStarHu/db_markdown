# 2.5.5 使用 Oracle 的 Debian 软件包在 Linux 上安装 MySQL_MySQL 8.0 参考手册

2.5.5 使用 Oracle 的 Debian 软件包在 Linux 上安装 MySQL_MySQL 8.0 参考手册
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
2.5.5 使用 Oracle 的 Debian 软件包在 Linux 上安装 MySQL
2.5.5 使用 Oracle 的 Debian 软件包在 Linux 上安装 MySQL
Oracle 提供了 Debian 软件包，用于在 Debian 或类似 Debian 的 Linux 系统上安装 MySQL。这些软件包可通过两个不同的渠道获得：
MySQL APT 存储
库。这是在类 Debian 系统上安装 MySQL 的首选方法，因为它提供了一种安装和更新 MySQL 产品的简单方便的方法。有关详细信息，请参阅
第 2.5.2 节，“使用 MySQL APT 存储库在 Linux 上安装 MySQL”。
MySQL 开发人员专区的下载区。有关详细信息，请参阅
第 2.1.3 节，“如何获取 MySQL”。以下是有关那里可用的 Debian 软件包的一些信息以及安装它们的说明：
MySQL Developer Zone 中提供了各种 Debian 软件包，用于在当前的 Debian 和 Ubuntu 平台上安装 MySQL 的不同组件。首选方法是使用 tarball 包，其中包含 MySQL 基本设置所需的包。tarball 包的名称格式为
.
是MySQL版本，
是Linux发行版。该值指示为其构建程序包的处理器类型或系列，如下表所示：
mysql-server_MVER-DVER_CPU.deb-bundle.tarMVERDVERCPU
表 2.13 MySQL Debian 和 Ubuntu 安装包 CPU 标识符
CPU价值
预期的处理器类型或系列
i386
奔腾处理器或更好，32 位
amd64
64 位 x86 处理器
下载 tarball 后，使用以下命令将其解压缩：
$> tar -xvf mysql-server_MVER-DVER_CPU.deb-bundle.tar
libaio
如果您的系统上尚未存在
该库，
您可能需要安装该库：$> sudo apt-get install libaio1
使用以下命令预配置 MySQL 服务器包：
$> sudo dpkg-preconfigure mysql-community-server_*.deb
系统会要求您为 MySQL 安装的 root 用户提供密码。您可能还会被问及有关安装的其他问题。
重要的
确保记住您设置的 root 密码。以后要设置密码的用户可以将
对话框中的密码字段留空，然后按确定即可；在这种情况下，对于使用 Unix 套接字文件的连接，使用MySQL Socket Peer-Credential Authentication Plugin对服务器的 root 访问进行身份
验证。您可以稍后使用
mysql_secure_installation设置 root 密码。
对于 MySQL 服务器的基本安装，安装数据库公共文件包、客户端包、客户端元包、服务器包和服务器元包（按顺序）；你可以用一个命令来做到这一点：
$> sudo dpkg -i mysql-{common,community-client-plugins,community-client-core,community-client,client,community-server-core,community-server,server}_*.deb
还有包名中有
server-core和
client-core的包。这些仅包含二进制文件，并由标准包自动安装。单独安装它们不会导致正常运行的 MySQL 安装程序。
如果dpkg（例如 libmecab2）
警告您存在未满足的依赖
项，您可以使用apt-get修复它们：
sudo apt-get -f install
以下是文件在系统上的安装位置：
所有配置文件（如
my.cnf）都在
/etc/mysql
所有二进制文件、库、标头等都在
/usr/bin和
/usr/sbin
数据目录在
/var/lib/mysql
笔记
MySQL 的 Debian 发行版也由其他供应商提供。请注意，它们在特性、功能和约定（包括通信设置）方面可能与 Oracle 构建的不同，并且本手册中的说明不一定适用于安装它们。相反，应参考供应商的说明。
© Mysql 中文网
