# 第 29 章连接器和 API_MySQL 8.0 参考手册

第 29 章连接器和 API_MySQL 8.0 参考手册
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
29.1 MySQL 连接器/C++
29.2 MySQL连接器/J
29.3 MySQL 连接器/NET
29.4 MySQL 连接器/ODBC
29.5 MySQL 连接器/Python
29.6 MySQL 连接器/Node.js
29.7 MySQL C API
29.8 MySQL PHP API
29.9 MySQL Perl API
29.10 MySQL Python API
29.11 MySQL Ruby API
29.12 MySQL Tcl API
29.13 MySQL埃菲尔包装器
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  /
第 29 章连接器和 API
第 29 章连接器和 API
目录29.1 MySQL 连接器/C++29.2 MySQL连接器/J29.3 MySQL 连接器/NET29.4 MySQL 连接器/ODBC29.5 MySQL 连接器/Python29.6 MySQL 连接器/Node.js29.7 MySQL C API29.8 MySQL PHP API29.9 MySQL Perl API29.10 MySQL Python API29.11 MySQL Ruby API29.11.1 MySQL/Ruby API29.11.2 Ruby/MySQL API29.12 MySQL Tcl API29.13 MySQL埃菲尔包装器
MySQL 连接器为客户端程序提供到 MySQL 服务器的连接。API 使用经典的 MySQL 协议或 X 协议提供对 MySQL 资源的低级访问。连接器和 API 都使您能够从其他语言或环境连接和执行 MySQL 语句，包括 ODBC、Java (JDBC)、C++、Python、Node.js、PHP、Perl、Ruby 和 C。
MySQL 连接器
Oracle 开发了许多连接器：
Connector/C++
使 C++ 应用程序能够连接到 MySQL。
Connector/J为使用标准 Java 数据库连接 (JDBC) API 从 Java 应用程序连接到 MySQL 提供驱动程序支持。
Connector/NET使开发人员能够创建连接到 MySQL 的 .NET 应用程序。Connector/NET 实现了一个全功能的 ADO.NET 接口，并提供了与 ADO.NET 感知工具一起使用的支持。使用 Connector/NET 的应用程序可以用任何受支持的 .NET 语言编写。
MySQL for Visual Studio可与 Connector/NET 和 Microsoft Visual Studio 2012、2013、2015 和 2017 配合使用。MySQL for Visual Studio 提供从 Visual Studio 访问 MySQL 对象和数据的功能。作为一个 Visual Studio 包，它直接集成到 Server Explorer 中，提供创建新连接和使用 MySQL 数据库对象的能力。
连接器/ODBC为使用开放式数据库连接 (ODBC) API 连接到 MySQL 提供驱动程序支持。支持来自 Windows、Unix 和 macOS 平台的 ODBC 连接。
连接器/Python
提供驱动程序支持，使用符合
Python DB API 2.0 版的 API 从 Python 应用程序连接到 MySQL 。不需要额外的 Python 模块或 MySQL 客户端库。
Connector/Node.js提供异步 API，用于使用 X 协议从 Node.js 应用程序连接到 MySQL。Connector/Node.js 支持管理数据库会话和模式、使用 MySQL 文档存储集合以及使用原始 SQL 语句。
MySQL C API
为了在 C 应用程序中直接访问本地使用 MySQL，C APIlibmysqlclient通过客户端库提供对 MySQL 客户端/服务器协议的低级访问
。这是用于连接到 MySQL 服务器实例的主要方法，由 MySQL 命令行客户端和此处详述的许多 MySQL 连接器和第三方 API 使用。
libmysqlclient包含在 MySQL 发行版中。
另请参阅MySQL C API 实现。
要从 C 应用程序访问 MySQL，或者为本章中的连接器或 API 不支持的语言构建 MySQL 的接口，C API是开始的地方。许多程序员的实用程序可用于帮助完成该过程；请参阅第 4.7 节，“程序开发实用程序”。
第三方 MySQL API
本章中描述的其余 API 提供了从特定应用程序语言到 MySQL 的接口。这些第三方解决方案不是由 Oracle 开发或支持的。此处提供有关它们的用法和能力的基本信息，仅供参考。
所有第三方语言 API 都是使用以下两种方法之一开发的，使用libmysqlclient或通过实现本机驱动程序。这两种解决方案具有不同的优势：
使用libmysqlclient
提供与 MySQL 的完全兼容性，因为它使用与 MySQL 客户端应用程序相同的库。但是，功能集仅限于实现和公开的接口，libmysqlclient并且由于数据在本机语言和 MySQL API 组件之间复制，性能可能会降低。
本机驱动程序是完全在宿主语言或环境中实现的 MySQL 网络协议。本机驱动程序速度很快，因为组件之间的数据复制较少，并且它们可以提供标准 MySQL API 无法提供的高级功能。最终用户也更容易构建和部署本地驱动程序，因为构建本地驱动程序组件不需要 MySQL 客户端库的副本。
表 29.1，“MySQL API 和接口”列出了许多可用于 MySQL 的库和接口。
表 29.1 MySQL API 和接口
环境
应用程序接口
类型
笔记
阿达
GNU Ada MySQL 绑定
libmysqlclient
请参阅GNU Ada 的 MySQL 绑定
C
语言接口
libmysqlclient
请参阅MySQL 8.0 C API 开发人员指南。
C++
连接器/C++
libmysqlclient
请参阅MySQL 连接器/C++ 8.0 开发人员指南。
MySQL++
libmysqlclient
请参阅MySQL++ 网站。
MySQL 包装
libmysqlclient
请参阅MySQL 包装。
可可
MySQL-Cocoa
libmysqlclient
与 Objective-C Cocoa 环境兼容。参见
http://mysql-cocoa.sourceforge.net/
丁
MySQL for D
libmysqlclient
参见MySQL 的 D。
埃菲尔铁塔
艾菲尔MySQL
libmysqlclient
请参阅第 29.13 节，“MySQL Eiffel Wrapper”。
二郎
erlang-mysql-driver
libmysqlclient
看
erlang-mysql-driver。
哈斯克尔
Haskell MySQL 绑定
本机驱动程序
请参阅Brian O'Sullivan 的纯 Haskell MySQL 绑定。
hsql-mysql
libmysqlclient
请参阅
Haskell 的 MySQL 驱动程序。
Java/JDBC
接头/J
本机驱动程序
请参阅MySQL Connector/J 8.0 开发人员指南。
卡亚
数据库
libmysqlclient
请参阅MyDB。
Lua
LuaSQL
libmysqlclient
请参阅
LuaSQL。
.NET/单声道
连接器/网络
本机驱动程序
请参阅MySQL 连接器/NET 开发人员指南。
目标凸轮
目标 Caml MySQL 绑定
libmysqlclient
请参阅Objective Caml 的 MySQL 绑定。
八度
GNU Octave 的数据库绑定
libmysqlclient
请参阅
GNU Octave 的数据库绑定。
ODBC
连接器/ODBC
libmysqlclient
请参阅MySQL 连接器/ODBC 开发人员指南。
Perl
DBI/DBD::mysql
libmysqlclient
请参阅第 29.9 节，“MySQL Perl API”。
Net::MySQL
本机驱动程序
见
Net::MySQL
CPAN
PHP
mysql,ext/mysql接口（已弃用）
libmysqlclient
请参阅MySQL 和 PHP。
mysqli,ext/mysqli接口
libmysqlclient
请参阅MySQL 和 PHP。
PDO_MYSQL
libmysqlclient
请参阅MySQL 和 PHP。
PDO mysqlnd
本机驱动程序
Python
连接器/蟒蛇
本机驱动程序
请参阅MySQL 连接器/Python 开发人员指南。
Python
连接器/Python C 扩展
libmysqlclient
请参阅MySQL 连接器/Python 开发人员指南。
MySQL数据库
libmysqlclient
请参阅第 29.10 节，“MySQL Python API”。
红宝石
mysql2
libmysqlclient
使用libmysqlclient。请参阅第 29.11 节，“MySQL Ruby API”。
方案
Myscsh
libmysqlclient
看
Myscsh。
声压级
sql_mysql
libmysqlclient
请参阅
sql_mysql
SPL。
TCL
MySQLtcl
libmysqlclient
请参阅第 29.12 节，“MySQL Tcl API”。
© Mysql 中文网
