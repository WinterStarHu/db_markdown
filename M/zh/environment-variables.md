# 4.9 环境变量_MySQL 8.0 参考手册

4.9 环境变量_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  /
4.9 环境变量
4.9 环境变量
本节列出了 MySQL 直接或间接使用的环境变量。其中大部分也可以在本手册的其他地方找到。
命令行上的选项优先于选项文件和环境变量中指定的值，选项文件中的值优先于环境变量中的值。在许多情况下，最好使用选项文件而不是环境变量来修改 MySQL 的行为。请参见
第 4.2.2.2 节，“使用选项文件”。
多变的
描述
AUTHENTICATION_KERBEROS_CLIENT_LOG
Kerberos 身份验证日志记录级别。
AUTHENTICATION_LDAP_CLIENT_LOG
客户端 LDAP 身份验证日志记录级别。
AUTHENTICATION_PAM_LOG
PAM
身份验证插件调试日志记录设置。
CC
C 编译器的名称（用于运行CMake）。
CXX
C++ 编译器的名称（用于运行CMake）。
CC
C 编译器的名称（用于运行CMake）。
DBI_USER
Perl DBI 的默认用户名。
DBI_TRACE
Perl DBI 的跟踪选项。
HOME
mysql历史文件
的默认路径是$HOME/.mysql_history.
LD_RUN_PATH
用于指定 的位置libmysqlclient.so。
LIBMYSQL_ENABLE_CLEARTEXT_PLUGIN
启用mysql_clear_password身份验证插件；请参阅第 6.4.1.4 节，“客户端明文可插入身份验证”。
LIBMYSQL_PLUGIN_DIR
在其中查找客户端插件的目录。
LIBMYSQL_PLUGINS
要预加载的客户端插件。
MYSQL_DEBUG
调试时调试跟踪选项。
MYSQL_GROUP_SUFFIX
选项组后缀值（如指定
--defaults-group-suffix）。
MYSQL_HISTFILE
mysql历史文件的路径。如果设置了此变量，其值将覆盖 的默认值
$HOME/.mysql_history。
MYSQL_HISTIGNORE
指定mysql不应记录到的语句的模式$HOME/.mysql_history，或者
syslog如果
--syslog给出。
MYSQL_HOME
服务器特定
my.cnf文件所在目录的路径。
MYSQL_HOST
mysql命令行客户端使用的默认主机名。
MYSQL_OPENSSL_UDF_DH_BITS_THRESHOLD
的最大密钥长度
create_dh_parameters()。请参阅
第 6.6.3 节，“MySQL 企业加密用法和示例”。
MYSQL_OPENSSL_UDF_DSA_BITS_THRESHOLD
的最大 DSA 密钥长度
create_asymmetric_priv_key()。请参阅第 6.6.3 节，“MySQL 企业加密用法和示例”。
MYSQL_OPENSSL_UDF_RSA_BITS_THRESHOLD
的最大 RSA 密钥长度
create_asymmetric_priv_key()。请参阅第 6.6.3 节，“MySQL 企业加密用法和示例”。
MYSQL_PS1
在mysql命令行客户端中使用的命令提示符。
MYSQL_PWD
连接到mysqld时的默认密码。使用它是不安全的。见下表注释。
MYSQL_TCP_PORT
默认的 TCP/IP 端口号。
MYSQL_TEST_LOGIN_FILE
.mylogin.cnf登录路径文件的名称。
MYSQL_TEST_TRACE_CRASH
测试协议跟踪插件是否使客户端崩溃。见下表注释。
MYSQL_TEST_TRACE_DEBUG
测试协议跟踪插件是否产生输出。见下表注释。
MYSQL_UNIX_PORT
默认的 Unix 套接字文件名；用于连接到
localhost.
MYSQLX_TCP_PORT
X Plugin 默认的 TCP/IP 端口号。
MYSQLX_UNIX_PORT
X Plugin 默认的 Unix socket 文件名；用于连接到
localhost.
NOTIFY_SOCKET
mysqld用于与 systemd 通信的套接字。
PATH
由 shell 用来查找 MySQL 程序。
PKG_CONFIG_PATH
mysqlclient.pc
pkg-config文件的位置。见下表注释。
TMPDIR
创建临时文件的目录。
TZ
这应该设置为您当地的时区。请参阅
第 B.3.3.7 节，“时区问题”。
UMASK
创建文件时的用户文件创建模式。见下表注释。
UMASK_DIR
创建目录时的用户目录创建模式。见下表注释。
USER
连接到mysqld时 Windows 上的默认用户名
。
有关mysql历史文件的信息，请参阅
第 4.5.1.3 节，“mysql 客户端日志记录”。
使用MYSQL_PWD指定 MySQL 密码必须被认为是极不安全的，不应使用。某些版本的ps包含一个选项来显示正在运行的进程的环境。在某些系统上，如果您设置了MYSQL_PWD，您的密码将暴露给运行ps的任何其他用户。即使在没有这种版本的ps的系统上，假设用户没有其他方法可以检查进程环境也是不明智的。
MYSQL_PWD自 MySQL 8.0 起已弃用；希望在未来的 MySQL 版本中将其删除。
MYSQL_TEST_LOGIN_FILE是登录路径文件（由
mysql_config_editor创建的文件）的路径名。如果未设置，则默认值为%APPDATA%\MySQL\.mylogin.cnfWindows 和$HOME/.mylogin.cnf非 Windows 系统上的目录。请参阅第 4.6.7 节，“mysql_config_editor — MySQL 配置实用程序”。
和变量控制测试协议跟踪客户端插件，如果 MySQL 是在启用该插件的情况下构建的MYSQL_TEST_TRACE_DEBUG。
MYSQL_TEST_TRACE_CRASH有关详细信息，请参阅
使用测试协议跟踪插件。
默认值UMASK和
UMASK_DIR值分别是0640和
0750。UMASK如果or的值UMASK_DIR以零开头，则MySQL 假定它是八进制的。例如，设置
UMASK=0600等同于
UMASK=384因为 0600 八进制是 384 十进制。
TheUMASK和UMASK_DIR
变量，尽管它们的名称，用作模式，而不是掩码：
如果UMASK设置，mysqld
将($UMASK | 0600)用作文件创建的模式，以便新创建的文件具有从 0600 到 0666 范围内的模式（所有值都是八进制）。
如果UMASK_DIR设置，
mysqld将($UMASK_DIR |
0700)用作目录创建的基本模式，然后与 AND 运算~(~$UMASK & 0666)，以便新创建的目录具有 0700 到 0777 范围内的模式（所有值都是八进制）。AND 操作可能会删除目录模式的读写权限，但不会删除执行权限。
另见第 B.3.3.1 节，“文件权限问题”。
PKG_CONFIG_PATH如果您使用pkg-config构建 MySQL 程序，则
可能需要进行设置。请参阅
使用 pkg-config 构建 C API 客户端程序。
© Mysql 中文网
