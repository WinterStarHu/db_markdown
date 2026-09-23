# 5.8.4 在多服务器环境中使用客户端程序_MySQL 8.0 参考手册

5.8.4 在多服务器环境中使用客户端程序_MySQL 8.0 参考手册
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
5.8.4 在多服务器环境中使用客户端程序
5.8.4 在多服务器环境中使用客户端程序
要将客户端程序连接到正在侦听与编译到客户端中的网络接口不同的网络接口的 MySQL 服务器，您可以使用以下方法之一：
启动客户端
使用 TCP/IP 连接到远程服务器，
使用 TCP/IP 连接到本地服务器，或者
使用 Unix 套接字文件或 Windows 命名管道连接到本地服务器。
--host=host_name
--port=port_number--host=127.0.0.1
--port=port_number--host=localhost
--socket=file_name
启动客户端
--protocol=TCP以使用 TCP/IP
--protocol=SOCKET连接、使用 Unix 套接字文件
--protocol=PIPE连接、使用命名管道
--protocol=MEMORY连接或使用共享内存连接。对于 TCP/IP 连接，您可能还需要指定--host和
--port选项。对于其他类型的连接，您可能需要指定一个
--socket选项来指定 Unix 套接字文件或 Windows 命名管道名称，或者指定一个
--shared-memory-base-name
选项来指定共享内存名称。共享内存连接仅在 Windows 上受支持。
在 Unix 上，在启动客户端之前，将MYSQL_UNIX_PORT和
MYSQL_TCP_PORT环境变量设置为指向 Unix 套接字文件和 TCP/IP 端口号。如果您通常使用特定的套接字文件或端口号，您可以在.login文件中放置命令来设置这些环境变量，以便它们在您每次登录时应用。请参见
第 4.9 节，“环境变量”。
[client]在选项文件组中
指定默认的 Unix 套接字文件和 TCP/IP 端口号。例如，您可以C:\my.cnf在 Windows 上使用，或.my.cnf在 Unix 上使用您主目录中的文件。请参见第 4.2.2.2 节，“使用选项文件”。
在 C 程序中，您可以在
mysql_real_connect()调用中指定套接字文件或端口号参数。您还可以通过调用让程序读取选项文件
mysql_options()。请参阅
C API 基本功能说明。
如果您使用的是 PerlDBD::mysql
模块，则可以从 MySQL 选项文件中读取选项。例如：
$dsn = "DBI:mysql:test;mysql_read_default_group=client;"
. "mysql_read_default_file=/usr/local/mysql/data/my.cnf";
$dbh = DBI->connect($dsn, $user, $password);
请参阅第 29.9 节，“MySQL Perl API”。
其他编程接口可能提供类似的功能来读取选项文件。
© Mysql 中文网
