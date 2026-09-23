# 5.8.3 在 Unix 上运行多个 MySQL 实例_MySQL 8.0 参考手册

5.8.3 在 Unix 上运行多个 MySQL 实例_MySQL 8.0 参考手册
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
第 5 章 MySQL 服务器管理
5.1 MySQL 服务器
5.2 MySQL数据目录
5.3 mysql系统架构
5.4 MySQL 服务器日志
5.5 MySQL组件
5.6 MySQL 服务器插件
5.7 MySQL 服务器可加载函数
5.8 在一台机器上运行多个MySQL实例
5.8.1 设置多个数据目录1
5.8.2 在 Windows 上运行多个 MySQL 实例1
5.8.3 在 Unix 上运行多个 MySQL 实例1
5.8.4 在多服务器环境中使用客户端程序1
5.9 调试 MySQL
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
MySQL 8.0 参考手册  / 第 5 章 MySQL 服务器管理  / 5.8 在一台机器上运行多个MySQL实例  /
5.8.3 在 Unix 上运行多个 MySQL 实例
5.8.3 在 Unix 上运行多个 MySQL 实例
笔记
这里的讨论使用mysqld_safe启动多个 MySQL 实例。对于使用 RPM 分发的 MySQL 安装，服务器启动和关闭由多个 Linux 平台上的 systemd 管理。在这些平台上，
没有安装mysqld_safe，因为它是不必要的。有关使用 systemd 处理多个 MySQL 实例的信息，请参阅第 2.5.9 节，“使用 systemd 管理 MySQL 服务器”。
一种方法是在 Unix 上运行多个 MySQL 实例，即编译具有不同默认 TCP/IP 端口和 Unix 套接字文件的不同服务器，以便每个服务器监听不同的网络接口。为每个安装在不同的基本目录中编译也会自动为每个服务器生成一个单独的编译数据目录、日志文件和 PID 文件位置。
假设现有的 5.7 服务器配置了默认的 TCP/IP 端口号 (3306) 和 Unix 套接字文件 ( /tmp/mysql.sock)。要将新的 8.0.31 服务器配置为具有不同的操作参数，请使用如下所示的CMake命令：
$> cmake . -DMYSQL_TCP_PORT=port_number \
-DMYSQL_UNIX_ADDR=file_name \
-DCMAKE_INSTALL_PREFIX=/usr/local/mysql-8.0.31
这里，port_numberand
file_name必须不同于默认的TCP/IP 端口号和Unix socket 文件路径名，并且该
CMAKE_INSTALL_PREFIX值应指定一个不同于现有MySQL 安装所在目录的安装目录。
如果你有一个 MySQL 服务器监听给定的端口号，你可以使用下面的命令来找出它对几个重要的可配置变量使用的操作参数，包括基本目录和 Unix 套接字文件名：
$> mysqladmin --host=host_name --port=port_number variables
通过该命令显示的信息，您可以知道在配置附加服务器时
不要使用哪些选项值。
如果指定localhost为主机名，
mysqladmin默认使用 Unix 套接字文件而不是 TCP/IP。要明确指定传输协议，请使用该
--protocol={TCP|SOCKET|PIPE|MEMORY}
选项。
您不需要仅仅为了使用不同的 Unix 套接字文件和 TCP/IP 端口号而编译一个新的 MySQL 服务器。也可以使用相同的服务器二进制文件并在运行时使用不同的参数值启动它的每次调用。一种方法是使用命令行选项：
$> mysqld_safe --socket=file_name --port=port_number
要启动第二个服务器，提供不同
--socket的
--port选项值，并将
选项传递给mysqld_safe，以便服务器使用不同的数据目录。
--datadir=dir_name
Alternatively, put the options for each server in a different option file, then start each server using a
--defaults-fileoption that specifies the path to the appropriate option file. 例如，如果两个服务器实例的选项文件名为
/usr/local/mysql/my.cnfand
/usr/local/mysql/my.cnf2，则像这样启动服务器：命令：
$> mysqld_safe --defaults-file=/usr/local/mysql/my.cnf
$> mysqld_safe --defaults-file=/usr/local/mysql/my.cnf2
实现类似效果的另一种方法是使用环境变量来设置 Unix 套接字文件名和 TCP/IP 端口号：
$> MYSQL_UNIX_PORT=/tmp/mysqld-new.sock
$> MYSQL_TCP_PORT=3307
$> export MYSQL_UNIX_PORT MYSQL_TCP_PORT
$> bin/mysqld --initialize --user=mysql
$> mysqld_safe --datadir=/path/to/datadir &
这是启动第二个服务器用于测试的快速方法。这种方法的好处是环境变量设置适用于您从同一个 shell 调用的任何客户端程序。因此，这些客户端的连接会自动定向到第二个服务器。
第 4.9 节，“环境变量”，包括可用于影响 MySQL 程序的其他环境变量列表。
在 Unix 上，mysqld_multi脚本提供了另一种启动多个服务器的方法。参见
第 4.3.4 节，“mysqld_multi — 管理多个 MySQL 服务器”。
© Mysql 中文网
