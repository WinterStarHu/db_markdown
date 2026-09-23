# 2.5.9 使用 systemd 管理 MySQL 服务器_MySQL 8.0 参考手册

2.5.9 使用 systemd 管理 MySQL 服务器_MySQL 8.0 参考手册
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
2.5.9 使用 systemd 管理 MySQL 服务器
2.5.9 使用 systemd 管理 MySQL 服务器
如果您在以下 Linux 平台上使用 RPM 或 Debian 软件包安装 MySQL，则服务器启动和关闭由 systemd 管理：
RPM 包平台：
Enterprise Linux 变体版本 7 及更高版本
SUSE Linux Enterprise Server 12 及更高版本
Fedora 29 及更高版本
Debian 系列平台：
Debian 平台
Ubuntu 平台
如果您在使用 systemd 的平台上从通用二进制分发版安装 MySQL，则可以按照MySQL 8.0 安全部署指南
的安装后设置部分中提供的说明手动配置对 MySQL 的 systemd 支持
。
如果您从使用 systemd 的平台上的源分发安装 MySQL，请通过使用
CMake选项配置分发来获得对 MySQL 的 systemd 支持。请参阅
第 2.9.7 节，“MySQL 源配置选项”。
-DWITH_SYSTEMD=1
以下讨论涵盖了这些主题：
系统概述为 MySQL 配置 systemd使用 systemd 配置多个 MySQL 实例从 mysqld_safe 迁移到 systemd
笔记
在安装了对 MySQL 的 systemd 支持的平台上，mysqld_safe和 System V 初始化脚本等脚本是不必要的，因此不会安装。例如，mysqld_safe可以处理服务器重启，但 systemd 提供相同的功能，并且以与其他服务的管理一致的方式执行此操作，而不是使用特定于应用程序的程序。
在使用 systemd 进行服务器管理的平台上不使用mysqld_safe
的一个含义是不支持在选项文件中使用[mysqld_safe]或
[safe_mysqld]部分，并且可能导致意外行为。
因为 systemd 能够在安装了 systemd 对 MySQL 支持的平台上管理多个 MySQL 实例，所以 mysqld_multi和
mysqld_multi.server是不必要的，因此没有安装。
系统概述
systemd 提供自动 MySQL 服务器启动和关闭。它还使用
systemctl命令启用手动服务器管理。例如：
$> systemctl {start|stop|restart|status} mysqld
或者，使用与 System V 系统兼容的服务命令（参数颠倒）：
$> service mysqld {start|stop|restart|status}
笔记
对于systemctl命令（和替代服务命令），如果 MySQL 服务名称不是mysqld，则使用适当的名称。例如，在基于 Debian 和 SLES 的系统上
使用mysql
而不是。mysqld
对 systemd 的支持包括以下文件：
mysqld.service（RPM 平台），
mysql.service（Debian 平台）：systemd 服务单元配置文件，包含有关 MySQL 服务的详细信息。
mysqld@.service（RPM 平台），
mysql@.service（Debian 平台）：类似
mysqld.service或
mysql.service，但用于管理多个 MySQL 实例。
mysqld.tmpfiles.d：包含支持该tmpfiles
功能的信息的文件。此文件安装在名称下
mysql.conf。
mysqld_pre_systemd（RPM 平台），
mysql-system-start（Debian 平台）：单元文件的支持脚本。/var/log/mysql*.log仅当日志位置匹配模式（对于 RPM 平台，/var/log/mysql/*.log对于 Debian 平台）时，此脚本才有助于创建错误日志文件。在其他情况下，错误日志目录必须是可写的，或者错误日志必须存在并且对于运行mysqld
进程的用户是可写的。
为 MySQL 配置 systemd
要为 MySQL 添加或更改 systemd 选项，可以使用以下方法：
使用本地化的 systemd 配置文件。
安排 systemd 为 MySQL 服务器进程设置环境变量。
设置MYSQLD_OPTS系统变量。
要使用本地化的 systemd 配置文件，请创建该
/etc/systemd/system/mysqld.service.d
目录（如果它不存在）。在该目录中，创建一个文件，其中包含[Service]列出所需设置的部分。例如：
[Service]
LimitNOFILE=max_open_files
Nice=nice_level
LimitCore=core_file_limit
Environment="LD_PRELOAD=/path/to/malloc/library"
Environment="TZ=time_zone_setting"
这里的讨论使用override.conf作为这个文件的名称。较新版本的 systemd 支持以下命令，它会打开一个编辑器并允许您编辑文件：
systemctl edit mysqld  # RPM platforms
systemctl edit mysql   # Debian platforms
每当您创建或更改
override.conf时，重新加载 systemd 配置，然后告诉 systemd 重新启动 MySQL 服务：
systemctl daemon-reload
systemctl restart mysqld  # RPM platforms
systemctl restart mysql   # Debian platforms
对于 systemd，override.conf
配置方法必须用于某些参数，而不是MySQL 选项文件中的 、 或组中的
[mysqld]设置
[mysqld_safe]：
[safe_mysqld]
对于某些参数，override.conf必须使用，因为 systemd 本身必须知道它们的值并且它无法读取 MySQL 选项文件来获取它们。
指定值的参数必须使用 systemd 指定，否则只能使用mysqld_safe已知的选项设置，因为没有相应的
mysqld参数。
有关使用 systemd 而不是
mysqld_safe的更多信息，请参阅
从 mysqld_safe 迁移到 systemd。
您可以在 中设置以下参数
override.conf：
要设置 MySQL 服务器可用的文件描述符的数量，请使用LimitNOFILEin
override.conf而不是
mysqldopen_files_limit的系统变量或
mysqld_safe的
选项。
--open-files-limit
要设置最大核心文件大小，请使用
LimitCorein
override.conf而不是
mysqld_safe--core-file-size的选项。
要设置 MySQL 服务器的调度优先级，请使用
Nicein
override.conf而不是
mysqld_safe--nice的选项
。
一些 MySQL 参数是使用环境变量配置的：
LD_PRELOAD：如果 MySQL 服务器应使用特定的内存分配库，则设置此变量。
NOTIFY_SOCKET：此环境变量指定mysqld用于与 systemd 通信启动完成和服务状态更改通知的套接字。它是在
mysqld服务启动时由 systemd 设置的。mysqld服务读取变量设置并写入定义的位置
。
在 MySQL 8.0 中，mysqld使用Type=notify进程启动类型。（Type=forking在 MySQL 5.7 中使用。）Type=notifysystemd 自动配置套接字文件并将路径导出到
NOTIFY_SOCKET环境变量。
TZ：设置此变量以指定服务器的默认时区。
有多种方法可以指定由 systemd 管理的 MySQL 服务器进程使用的环境变量值：
使用文件Environment中的行
override.conf。有关语法，请参阅前面讨论中描述如何使用此文件的示例。
指定
/etc/sysconfig/mysql文件中的值（如果不存在则创建文件）。使用以下语法分配值：
LD_PRELOAD=/path/to/malloc/library
TZ=time_zone_setting
修改/etc/sysconfig/mysql后重启服务器使修改生效：
systemctl restart mysqld  # RPM platforms
systemctl restart mysql   # Debian platforms
要在不直接修改 systemd 配置文件
的情况下为mysqld
指定选项，请设置或取消设置MYSQLD_OPTSsystemd 变量。例如：
systemctl set-environment MYSQLD_OPTS="--general_log=1"
systemctl unset-environment MYSQLD_OPTS
MYSQLD_OPTS也可以在
/etc/sysconfig/mysql文件中设置。
修改systemd环境后，重启服务器使修改生效：
systemctl restart mysqld  # RPM platforms
systemctl restart mysql   # Debian platforms
对于使用 systemd 的平台，如果数据目录在服务器启动时为空，则会进行初始化。如果数据目录是一个暂时消失的远程挂载，这可能是一个问题：挂载点将显示为一个空数据目录，然后将其初始化为一个新的数据目录。要抑制这种自动初始化行为，请在文件中指定以下行
/etc/sysconfig/mysql（如果文件不存在则创建该文件）：
NO_INIT=true
使用 systemd 配置多个 MySQL 实例
本节介绍如何为多个 MySQL 实例配置 systemd。
笔记
因为 systemd 具有在安装了 systemd 支持的平台上管理多个 MySQL 实例的能力，
所以不需要
安装mysqld_multi和
mysqld_multi.server 。
要使用多实例功能，请修改
my.cnf选项文件以包括每个实例的关键选项配置。这些文件位置是典型的：
/etc/my.cnf或
/etc/mysql/my.cnf（RPM 平台）
/etc/mysql/mysql.conf.d/mysqld.cnf
（Debian 平台）
例如，要管理两个名为
replica01and的实例replica02，请将如下内容添加到选项文件中：
RPM 平台：
[mysqld@replica01]
datadir=/var/lib/mysql-replica01
socket=/var/lib/mysql-replica01/mysql.sock
port=3307
log-error=/var/log/mysqld-replica01.log
[mysqld@replica02]
datadir=/var/lib/mysql-replica02
socket=/var/lib/mysql-replica02/mysql.sock
port=3308
log-error=/var/log/mysqld-replica02.log
Debian 平台：
[mysqld@replica01]
datadir=/var/lib/mysql-replica01
socket=/var/lib/mysql-replica01/mysql.sock
port=3307
log-error=/var/log/mysql/replica01.log
[mysqld@replica02]
datadir=/var/lib/mysql-replica02
socket=/var/lib/mysql-replica02/mysql.sock
port=3308
log-error=/var/log/mysql/replica02.log
此处显示的副本名称@用作分隔符，因为这是 systemd 支持的唯一分隔符。
然后实例由正常的 systemd 命令管理，例如：
systemctl start mysqld@replica01
systemctl start mysqld@replica02
要使实例在启动时运行，请执行以下操作：
systemctl enable mysqld@replica01
systemctl enable mysqld@replica02
还支持使用通配符。例如，此命令显示所有副本实例的状态：
systemctl status 'mysqld@replica*'
为了在同一台机器上管理多个 MySQL 实例，systemd 自动使用不同的单元文件：
mysqld@.service而不是
mysqld.service（RPM 平台）
mysql@.service而不是
mysql.service（Debian 平台）
在单元文件中，%I引用
%i标记后传入的参数，@用于管理具体的实例。对于这样的命令：
systemctl start mysqld@replica01
systemd 使用如下命令启动服务器：
mysqld --defaults-group-suffix=@%I ...
结果是[server]、
[mysqld]和
[mysqld@replica01]选项组被读取并用于该服务实例。
笔记
在 Debian 平台上，AppArmor 会阻止服务器读取或写入/var/lib/mysql-replica*，或默认位置以外的任何内容。要解决此问题，您必须自定义或禁用 中的配置文件
/etc/apparmor.d/usr.sbin.mysqld。
笔记
在 Debian 平台上，MySQL 卸载的打包脚本目前无法处理
mysqld@实例。在删除或升级包之前，您必须先手动停止任何额外的实例。
从 mysqld_safe 迁移到 systemd
由于mysqld_safe未安装在使用 systemd 管理 MySQL 的平台上，因此必须以另一种方式指定
先前为该程序指定的选项（例如，在
[mysqld_safe]or
选项组中）：[safe_mysqld]
一些mysqld_safe选项也被mysqld理解并且可以从[mysqld_safe]or
[safe_mysqld]选项组移动到
[mysqld]组。这
不包括
--pid-file、
--open-files-limit或
--nice。要指定这些选项，请使用override.confsystemd 文件，如前所述。
笔记
在 systemd 平台上，不支持使用
[mysqld_safe]和
[safe_mysqld]选项组，这可能会导致意外行为。
对于某些mysqld_safe选项，有替代的mysqld过程。例如，用于启用日志记录
的mysqld_safe选项是，它已被弃用。要将错误日志输出写入系统日志，请使用第 5.4.2.8 节“将错误记录到系统日志”中的说明。
syslog--syslog
mysqld不理解的
mysqld_safe选项可以在
override.conf或 环境变量中指定。例如，对于mysqld_safe，如果服务器应使用特定的内存分配库，则使用该
--malloc-lib选项指定。对于使用 systemd 管理服务器的安装，安排设置LD_PRELOAD环境变量，如前所述。
© Mysql 中文网
