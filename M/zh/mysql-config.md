# 4.7.1 mysql_config——编译客户端的显示选项_MySQL 8.0 参考手册

4.7.1 mysql_config——编译客户端的显示选项_MySQL 8.0 参考手册
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
4.7.1 mysql_config——编译客户端的显示选项1
4.7.2 my_print_defaults — 显示选项文件中的选项1
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.7 程序开发实用程序  /
4.7.1 mysql_config——编译客户端的显示选项
4.7.1 mysql_config——编译客户端的显示选项
mysql_config为您提供了编译 MySQL 客户端并将其连接到 MySQL 的有用信息。它是一个 shell 脚本，因此只能在 Unix 和类 Unix 系统上使用。
笔记
pkg-config可用作
mysql_config的替代品，用于获取编译器标志或编译 MySQL 应用程序所需的链接库等信息。有关详细信息，请参阅
使用 pkg-config 构建 C API 客户端程序。
mysql_config支持以下选项。
--cflags
C 编译器标志，用于查找包含文件和关键编译器标志，并定义编译
libmysqlclient库时使用的。返回的选项与创建库时使用的特定编译器相关，并且可能与您自己的编译器的设置冲突。用于
--include仅包含包含路径的更多可移植选项。
--cxxflags
像--cflags，但用于 C++ 编译器标志。
--include
查找 MySQL 包含文件的编译器选项。
--libs
与 MySQL 客户端库链接所需的库和选项。
--libs_r
与线程安全的 MySQL 客户端库链接所需的库和选项。在 MySQL 8.0 中，所有客户端库都是线程安全的，因此不需要使用此选项。该--libs选项可用于所有情况。
--plugindir
默认插件目录路径名，在配置 MySQL 时定义。
--port
默认的 TCP/IP 端口号，在配置 MySQL 时定义。
--socket
默认的 Unix 套接字文件，在配置 MySQL 时定义。
--variable=var_name
显示命名配置变量的值。允许的var_name值为
pkgincludedir（头文件目录）、pkglibdir（库目录）和plugindir（插件目录）。
--version
MySQL 发行版的版本号。
如果不带任何选项调用mysql_config，它会显示它支持的所有选项及其值的列表：
$> mysql_config
Usage: /usr/local/mysql/bin/mysql_config [options]
Options:
--cflags         [-I/usr/local/mysql/include/mysql -mcpu=pentiumpro]
--cxxflags       [-I/usr/local/mysql/include/mysql -mcpu=pentiumpro]
--include        [-I/usr/local/mysql/include/mysql]
--libs           [-L/usr/local/mysql/lib/mysql -lmysqlclient
-lpthread -lm -lrt -lssl -lcrypto -ldl]
--libs_r         [-L/usr/local/mysql/lib/mysql -lmysqlclient_r
-lpthread -lm -lrt -lssl -lcrypto -ldl]
--plugindir      [/usr/local/mysql/lib/plugin]
--socket         [/tmp/mysql.sock]
--port           [3306]
--version        [5.8.0-m17]
--variable=VAR   VAR is one of:
pkgincludedir [/usr/local/mysql/include]
pkglibdir     [/usr/local/mysql/lib]
plugindir     [/usr/local/mysql/lib/plugin]
您可以在命令行中使用mysql_config，使用反引号来包含它为特定选项生成的输出。例如，要编译和链接一个 MySQL 客户端程序，使用mysql_config如下：
gcc -c `mysql_config --cflags` progname.c
gcc -o progname progname.o `mysql_config --libs`
© Mysql 中文网
