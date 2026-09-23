# 4.4.2 mysql_secure_installation——提高MySQL安装安全性_MySQL 8.0 参考手册

4.4.2 mysql_secure_installation——提高MySQL安装安全性_MySQL 8.0 参考手册
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
4.4.1 comp_err——编译MySQL错误信息文件1
4.4.2 mysql_secure_installation——提高MySQL安装安全性1
4.4.3 mysql_ssl_rsa_setup — 创建 SSL/RSA 文件1
4.4.4 mysql_tzinfo_to_sql — 加载时区表1
4.4.5 mysql_upgrade — 检查和升级 MySQL 表1
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.4 安装相关程序  /
4.4.2 mysql_secure_installation——提高MySQL安装安全性
4.4.2 mysql_secure_installation——提高MySQL安装安全性
该程序使您能够通过以下方式提高 MySQL 安装的安全性：
您可以为root帐户设置密码。
您可以删除root可从本地主机外部访问的帐户。
您可以删除匿名用户帐户。
您可以删除test数据库（默认情况下所有用户，甚至匿名用户都可以访问该数据库），以及允许任何人访问名称以 . 开头的数据库的权限
test_。
mysql_secure_installation帮助您实施类似于
第 2.10.4 节“保护初始 MySQL 帐户”。
正常使用是连接本地MySQL服务器；不带参数
调用
mysql_secure_installation ：mysql_secure_installation
执行时，mysql_secure_installation
会提示您确定要执行的操作。
该validate_password组件可用于密码强度检查。如果没有安装插件，
mysql_secure_installation会提示用户是否安装。如果启用，将使用插件检查稍后输入的任何密码。
大多数常用的 MySQL 客户端选项（例如
--host和
）--port都可以在命令行和选项文件中使用。例如，要使用端口 3307 通过 IPv6 连接到本地服务器，请使用以下命令：
mysql_secure_installation --host=::1 --port=3307
mysql_secure_installation支持以下选项，可以在命令行或选项文件的组中指定[mysql_secure_installation]。
[client]有关 MySQL 程序使用的选项文件的信息，请参阅
第 4.2.2.2 节，“使用选项文件”。
表 4.8 mysql_secure_installation 选项
选项名称
描述
介绍
--defaults-extra-file
除了通常的选项文件外，还读取命名的选项文件
--defaults-文件
只读命名选项文件
--defaults-group-suffix
选项组后缀值
- 帮助
显示帮助信息并退出
- 主持人
MySQL 服务器所在的主机
--no-defaults
不读取选项文件
- 密码
接受但总是被忽略。每当调用 mysql_secure_installation 时，都会提示用户输入密码，无论
- 港口
用于连接的 TCP/IP 端口号
--print-defaults
打印默认选项
- 协议
使用的传输协议
- 插座
要使用的 Unix 套接字文件或 Windows 命名管道
--ssl-ca
包含可信 SSL 证书颁发机构列表的文件
--ssl-capath
包含受信任的 SSL 证书颁发机构证书文件的目录
--ssl证书
包含 X.509 证书的文件
--ssl密码
连接加密的允许密码
--ssl-crl
包含证书吊销列表的文件
--ssl-crlpath
包含证书吊销列表文件的目录
--ssl-fips-模式
客户端是否开启FIPS模式
--ssl-密钥
包含 X.509 密钥的文件
--ssl模式
连接到服务器的所需安全状态
--ssl 会话数据
包含 SSL 会话数据的文件
8.0.29
--ssl-session-data-continue-on-failed-reuse
session重用失败是否建立连接
8.0.29
--tls-密码套件
用于加密连接的允许的 TLSv1.3 密码套件
8.0.16
--tls-版本
加密连接允许的 TLS 协议
- 默认情况下使用
在没有用户交互的情况下执行
- 用户
连接到服务器时使用的 MySQL 用户名
--help,
-?
显示帮助信息并退出。
--defaults-extra-file=file_name
在全局选项文件之后但（在 Unix 上）在用户选项文件之前读取此选项文件。如果该文件不存在或无法访问，则会发生错误。如果
file_name不是绝对路径名，则将其解释为相对于当前目录。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--defaults-file=file_name
仅使用给定的选项文件。如果该文件不存在或无法访问，则会发生错误。如果
file_name不是绝对路径名，则将其解释为相对于当前目录。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--defaults-group-suffix=str
不仅要阅读通常的选项组，还要阅读具有通常名称和后缀
str. 例如，
mysql_secure_installation通常读取[client]和
[mysql_secure_installation]组。如果此选项作为 给出
--defaults-group-suffix=_other，
mysql_secure_installation也会读取
[client_other]和
[mysql_secure_installation_other]组。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--host=host_name,
-h host_name
连接到给定主机上的 MySQL 服务器。
--no-defaults
不要读取任何选项文件。如果程序启动因从选项文件中读取未知选项而失败，
--no-defaults
可用于防止它们被读取。
例外情况是.mylogin.cnf
文件在所有情况下都会被读取（如果存在）。这允许以比在命令行上更安全的方式指定密码，即使在
--no-defaults
使用 时也是如此。要创建.mylogin.cnf，请使用mysql_config_editor实用程序。请参阅
第 4.6.7 节，“mysql_config_editor — MySQL 配置实用程序”。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--password=password,
-p password
该选项被接受但被忽略。无论是否使用此选项，mysql_secure_installation
总是提示用户输入密码。
--port=port_num,
-P port_num
对于 TCP/IP 连接，要使用的端口号。
--print-defaults
打印程序名称和它从选项文件中获取的所有选项。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--protocol={TCP|SOCKET|PIPE|MEMORY}
用于连接到服务器的传输协议。当其他连接参数通常导致使用您想要的协议以外的协议时，它很有用。有关允许值的详细信息，请参阅
第 4.2.7 节“连接传输协议”。
--socket=path,
-S path
对于与 的连接localhost，要使用的 Unix 套接字文件，或者在 Windows 上，要使用的命名管道的名称。
在 Windows 上，仅当服务器启动时named_pipe
启用了支持命名管道连接的系统变量时，此选项才适用。此外，连接必须是
named_pipe_full_access_group
系统变量指定的 Windows 组的成员。
--ssl*
以 开头的选项--ssl指定是否使用加密连接到服务器并指示在哪里可以找到 SSL 密钥和证书。请参阅
加密连接的命令选项。
--ssl-fips-mode={OFF|ON|STRICT}
控制是否在客户端启用 FIPS 模式。该
--ssl-fips-mode
选项与其他
选项的不同之处在于它不用于建立加密连接，而是用于影响允许哪些加密操作。请参见第 6.8 节 “FIPS 支持”。
--ssl-xxx
这些
--ssl-fips-mode
值是允许的：
OFF: 禁用 FIPS 模式。
ON：启用 FIPS 模式。
STRICT：启用“严格”
FIPS 模式。
笔记
如果 OpenSSL FIPS 对象模块不可用，则唯一允许的
--ssl-fips-mode
值为OFF. 在这种情况下，设置
--ssl-fips-mode
为ON或STRICT
会导致客户端在启动时发出警告并在非 FIPS 模式下运行。
--tls-ciphersuites=ciphersuite_list
使用 TLSv1.3 的加密连接的允许密码套件。该值是一个或多个以冒号分隔的密码套件名称的列表。可以为此选项命名的密码套件取决于用于编译 MySQL 的 SSL 库。有关详细信息，请参阅
第 6.3.2 节，“加密连接 TLS 协议和密码”。
这个选项是在 MySQL 8.0.16 中添加的。
--tls-version=protocol_list
加密连接允许的 TLS 协议。该值是一个或多个以逗号分隔的协议名称的列表。可以为此选项命名的协议取决于用于编译 MySQL 的 SSL 库。有关详细信息，请参阅
第 6.3.2 节，“加密连接 TLS 协议和密码”。
--use-default
以非交互方式执行。此选项可用于无人值守的安装操作。
--user=user_name,
-u user_name
用于连接到服务器的 MySQL 帐户的用户名。
© Mysql 中文网
