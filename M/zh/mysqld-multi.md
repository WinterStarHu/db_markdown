# 4.3.4 mysqld_multi — 管理多个 MySQL 服务器_MySQL 8.0 参考手册

4.3.4 mysqld_multi — 管理多个 MySQL 服务器_MySQL 8.0 参考手册
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
第 3 章教程
第 4 章 MySQL 程序
4.1 MySQL程序概述
4.2 使用 MySQL 程序
4.3 服务器和服务器启动程序
4.3.1 mysqld——MySQL 服务器1
4.3.2 mysqld_safe — MySQL 服务器启动脚本1
4.3.3 mysql.server——MySQL服务器启动脚本1
4.3.4 mysqld_multi — 管理多个 MySQL 服务器1
4.4 安装相关程序
4.5 客户端程序
4.6 管理和实用程序
4.7 程序开发实用程序
4.8 杂项程序
4.9 环境变量
4.10 MySQL 中的 Unix 信号处理
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.3 服务器和服务器启动程序  /
4.3.4 mysqld_multi — 管理多个 MySQL 服务器
4.3.4 mysqld_multi — 管理多个 MySQL 服务器
mysqld_multi旨在管理多个
mysqld进程，这些进程侦听不同 Unix 套接字文件和 TCP/IP 端口上的连接。它可以启动或停止服务器，或报告它们的当前状态。
笔记
对于某些 Linux 平台，从 RPM 或 Debian 软件包安装 MySQL 包括用于管理 MySQL 服务器启动和关闭的 systemd 支持。在这些平台上，
mysqld_multi没有安装，因为它是不必要的。有关使用 systemd 处理多个 MySQL 实例的信息，请参阅第 2.5.9 节，“使用 systemd 管理 MySQL 服务器”。
mysqld_multi搜索
在
（或在
选项命名的文件中）命名的组。
可以是任何正整数。此编号在以下讨论中称为选项组编号，或。组号将选项组彼此区分开来，并用作mysqld_multi的参数以指定要启动、停止或获取状态报告的服务器。这些组中列出的选项与您在用于启动
mysqld的组中使用的相同。（参见，例如，
第 2.10.5 节，“自动启动和停止 MySQL”[mysqldN]my.cnf--defaults-fileNGNR[mysqld].) 但是，当使用多个服务器时，每个服务器都必须使用自己的选项值，例如 Unix 套接字文件和 TCP/IP 端口号。有关在多服务器环境中每个服务器哪些选项必须唯一的更多信息，请参阅
第 5.8 节，“在一台机器上运行多个 MySQL 实例”。
要调用mysqld_multi，请使用以下语法：
mysqld_multi [options] {start|stop|reload|report} [GNR[,GNR] ...]
start, stop,
reload（停止和重新启动），并
report指示要执行的操作。您可以对单个服务器或多个服务器执行指定的操作，具体取决于
GNR选项名称后面的列表。如果没有列表，mysqld_multi
对选项文件中的所有服务器执行操作。
每个GNR值代表一个选项组号或组号范围。该值应该是选项文件中组名末尾的数字。例如，GNR名为 的组
[mysqld17]的17。要指定一个数字范围，请用破折号分隔第一个和最后一个数字。该GNR值
10-13表示
[mysqld10]通过
的组[mysqld13]。可以在命令行上指定多个组或组范围，以逗号分隔。列表中不能有空白字符（空格或制表符）
GNR；空白字符之后的任何内容都将被忽略。
此命令使用选项组启动单个服务器
[mysqld17]：
mysqld_multi start 17
此命令停止多个服务器，使用选项组
[mysqld8]并[mysqld10]
通过[mysqld13]：
mysqld_multi stop 8,10-13
有关如何设置选项文件的示例，请使用以下命令：
mysqld_multi --example
mysqld_multi搜索选项文件如下：
使用--no-defaults，不读取任何选项文件。
使用
，只读取指定的文件。
--defaults-file=file_name
否则，将读取标准位置列表中的选项文件，包括选项命名的任何文件（
如果有的话）。（如果多次给出该选项，则使用最后一个值。）
--defaults-extra-file=file_name
有关这些选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
搜索读取的选项文件
[mysqld_multi]和
选项组。该组可用于mysqld_multi本身的选项。
组可用于传递给特定
mysqld实例的选项。
[mysqldN][mysqld_multi][mysqldN][mysqld]或
[mysqld_safe]组可用于mysqld或
mysqld_safe的所有实例读取
的公共选项。您可以指定一个
选项来为该实例使用不同的配置文件，在这种情况下，该文件中的或
组将用于该实例。
--defaults-file=file_name[mysqld][mysqld_safe]
mysqld_multi支持以下选项。
--help
显示帮助信息并退出。
--example
显示示例选项文件。
--log=file_name
指定日志文件的名称。如果该文件存在，则将日志输出附加到它。
--mysqladmin=prog_name
用于停止服务器
的mysqladmin二进制文件。
--mysqld=prog_name
要使用
的mysqld二进制文件。请注意，您也可以将mysqld_safe指定为该选项的值。如果使用
mysqld_safe启动服务器，可以在相应的
选项组中包含mysqld或
选项。这些选项指示mysqld_safe应该启动的服务器的名称和服务器所在目录的路径名。（请参阅第 4.3.2 节“mysqld_safe — MySQL 服务器启动脚本”中对这些选项的描述
。）示例：
ledir[mysqldN][mysqld38]
mysqld = mysqld-debug
ledir  = /opt/local/mysql/libexec
--no-log
将日志信息打印到stdout而不是日志文件。默认情况下，输出转到日志文件。
--password=password
调用mysqladmin
时要使用的 MySQL 帐户的密码
。请注意，与其他 MySQL 程序不同，此选项的密码值不是可选的。
--silent
静音模式; 禁用警告。
--tcp-ip
通过 TCP/IP 端口而不是 Unix 套接字文件连接到每个 MySQL 服务器。（如果缺少套接字文件，服务器可能仍在运行，但只能通过 TCP/IP 端口访问。）默认情况下，使用 Unix 套接字文件建立连接。此选项影响
stop和report
操作。
--user=user_name
调用mysqladmin
时要使用的 MySQL 帐户的用户名
。
--verbose
更冗长。
--version
显示版本信息并退出。
关于mysqld_multi 的一些注意事项：
最重要的是：在使用mysqld_multi之前，请确保您了解传递给mysqld服务器的选项的含义以及
为什么您希望拥有单独的
mysqld进程。当心使用具有相同数据目录的多个mysqld服务器的危险。使用单独的数据目录，除非您知道自己在做什么。使用相同的数据目录启动多个服务器
不会给线程系统带来额外的性能。看第 5.8 节，“在一台机器上运行多个 MySQL 实例”。
重要的
确保启动特定
mysqld进程的 Unix 帐户可以完全访问每个服务器的数据目录。
不要为此使用 Unix
root帐户，除非您知道自己在做什么。请参阅
第 6.1.5 节，“如何以普通用户身份运行 MySQL”。
确保用于停止
mysqld服务器（使用
mysqladmin程序）的 MySQL 帐户对每个服务器具有相同的用户名和密码。另外，请确保该帐户具有SHUTDOWN
权限。如果您要管理的服务器具有不同的管理帐户用户名或密码，您可能希望在每台服务器上创建一个具有相同用户名和密码的帐户。例如，您可以multi_admin通过为每个服务器执行以下命令来设置一个公共帐户：
$> mysql -u root -S /tmp/mysql.sock -p
Enter password:
mysql> CREATE USER 'multi_admin'@'localhost' IDENTIFIED BY 'multipass';
mysql> GRANT SHUTDOWN ON *.* TO 'multi_admin'@'localhost';
请参阅第 6.2 节，“访问控制和帐户管理”。您必须为每个mysqld服务器执行此操作。连接到每一个时适当地更改连接参数。请注意，帐户名的主机名部分必须允许您multi_admin从要运行
mysqld_multi的主机进行连接。
每个mysqld
的 Unix 套接字文件和 TCP/IP 端口号必须不同。（或者，如果主机有多个网络地址，您可以设置
bind_address系统变量使不同的服务器监听不同的接口。）
如果您使用mysqld_safe启动
mysqld（例如，
），
该--pid-file选项非常重要
。每个mysqld都应该有自己的进程 ID 文件。使用
mysqld_safe而不是
mysqld的优点是
mysqld_safe监视其
mysqld进程并在进程由于使用发送的信号或其他原因（例如分段错误）而终止时重新启动它。
--mysqld=mysqld_safekill
-9
您可能想使用
mysqld--user的选项
，但要做到这一点，您需要以 Unix 超级用户 () 身份运行mysqld_multi脚本。选项文件中的选项无关紧要；如果您不是超级用户并且mysqld
进程是在您自己的 Unix 帐户下启动的，您只会收到警告。
root
以下示例显示了如何设置选项文件以与mysqld_multi一起使用。mysqld程序启动或停止的顺序取决于它们在选项文件中出现的顺序。组号不需要形成一个完整的序列。示例中有意省略了第一组和第五
组，以说明选项文件中可以有“间隙”。这为您提供了更大的灵活性。
[mysqldN]# This is an example of a my.cnf file for mysqld_multi.
# Usually this file is located in home dir ~/.my.cnf or /etc/my.cnf
[mysqld_multi]
mysqld     = /usr/local/mysql/bin/mysqld_safe
mysqladmin = /usr/local/mysql/bin/mysqladmin
user       = multi_admin
password   = my_password
[mysqld2]
socket     = /tmp/mysql.sock2
port       = 3307
pid-file   = /usr/local/mysql/data2/hostname.pid2
datadir    = /usr/local/mysql/data2
language   = /usr/local/mysql/share/mysql/english
user       = unix_user1
[mysqld3]
mysqld     = /path/to/mysqld_safe
ledir      = /path/to/mysqld-binary/
mysqladmin = /path/to/mysqladmin
socket     = /tmp/mysql.sock3
port       = 3308
pid-file   = /usr/local/mysql/data3/hostname.pid3
datadir    = /usr/local/mysql/data3
language   = /usr/local/mysql/share/mysql/swedish
user       = unix_user2
[mysqld4]
socket     = /tmp/mysql.sock4
port       = 3309
pid-file   = /usr/local/mysql/data4/hostname.pid4
datadir    = /usr/local/mysql/data4
language   = /usr/local/mysql/share/mysql/estonia
user       = unix_user3
[mysqld6]
socket     = /tmp/mysql.sock6
port       = 3311
pid-file   = /usr/local/mysql/data6/hostname.pid6
datadir    = /usr/local/mysql/data6
language   = /usr/local/mysql/share/mysql/japanese
user       = unix_user4
请参见第 4.2.2.2 节，“使用选项文件”。
© Mysql 中文网
