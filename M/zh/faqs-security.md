# A.9 MySQL 8.0 FAQ：安全_MySQL 8.0 参考手册

A.9 MySQL 8.0 FAQ：安全_MySQL 8.0 参考手册
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
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
A.1 MySQL 8.0 FAQ：一般
A.2 MySQL 8.0 FAQ：存储引擎
A.3 MySQL 8.0 常见问题解答：服务器 SQL 模式
A.4 MySQL 8.0 FAQ：存储过程和函数
A.5 MySQL 8.0 FAQ：触发器
A.6 MySQL 8.0 FAQ：视图
A.7 MySQL 8.0 FAQ：INFORMATION_SCHEMA
A.8 MySQL 8.0 FAQ：迁移
A.9 MySQL 8.0 FAQ：安全
A.10 MySQL 8.0 FAQ：NDB Cluster
A.11 MySQL 8.0 FAQ：MySQL 中日韩字符集
A.12 MySQL 8.0 常见问题解答：连接器和 API
A.13 MySQL 8.0 常见问题解答：C API、libmysql
A.14 MySQL 8.0 FAQ：复制
A.15 MySQL 8.0 FAQ：MySQL 企业级线程池
A.16 MySQL 8.0 FAQ：InnoDB Change Buffer
A.17 MySQL 8.0 FAQ：InnoDB 静态数据加密
A.18 MySQL 8.0 FAQ：虚拟化支持
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 附录 A MySQL 8.0 常见问题解答  /
A.9 MySQL 8.0 FAQ：安全
A.9 MySQL 8.0 FAQ：安全
A.9.1.
在哪里可以找到解决 MySQL 安全问题的文档？
A.9.2.
MySQL 8.0 中默认的身份验证插件是什么？
A.9.3.
MySQL 8.0 是否原生支持 SSL？
A.9.4.
MySQL 二进制文件中内置了 SSL 支持，还是我必须自己重新编译二进制文件才能启用它？
A.9.5.
MySQL 8.0 是否内置了针对 LDAP 目录的身份验证？
A.9.6.
MySQL 8.0 是否包含对基于角色的访问控制 (RBAC) 的支持？
A.9.7.
MySQL 8.0 是否支持 TLS 1.0 和 1.1？
A.9.1.
在哪里可以找到解决 MySQL 安全问题的文档？
最好的起点是第 6 章，安全性。
MySQL 文档的其他部分可能对特定的安全问题有用，包括以下内容：
第 6.1.1 节，“安全准则”。
第 6.1.3 节，“使 MySQL 免受攻击”。
第 B.3.3.2 节，“如何重置根密码”。
第 6.1.5 节，“如何以普通用户身份运行 MySQL”。
第 6.1.4 节，“与安全相关的 mysqld 选项和变量”。
第 6.1.6 节，“LOAD DATA LOCAL 的安全注意事项”。
第 2.10 节，“安装后设置和测试”。
第 6.3 节，“使用加密连接”。
可加载函数安全预防措施。
还有
Secure Deployment Guide，它提供了部署 MySQL Enterprise Edition Server 的通用二进制分发的过程，具有管理 MySQL 安装安全性的功能。
A.9.2.
MySQL 8.0 中默认的身份验证插件是什么？
MySQL 8.0 中默认的身份验证插件是
caching_sha2_password. 有关此插件的信息，请参阅
第 6.4.1.2 节，“缓存 SHA-2 可插入身份验证”。
该插件提供了比插件（以前MySQL系列中的默认插件）caching_sha2_password更安全的密码加密
。mysql_native_password有关此默认插件更改对服务器操作的影响以及服务器与客户端和连接器的兼容性的信息，请参阅caching_sha2_password 作为首选身份验证插件。
有关可插入身份验证和其他可用身份验证插件的一般信息，请参阅
第 6.2.17 节，“可插入身份验证”和
第 6.4.1 节，“身份验证插件”。
A.9.3.
MySQL 8.0 是否原生支持 SSL？
大多数 8.0 二进制文件都支持客户端和服务器之间的 SSL 连接。请参阅
第 6.3 节，“使用加密连接”。
如果（例如）客户端应用程序不支持 SSL 连接，您也可以使用 SSH 隧道连接。有关示例，请参阅第 6.3.4 节，“使用 SSH 从 Windows 远程连接到 MySQL”。
A.9.4.
MySQL 二进制文件中内置了 SSL 支持，还是我必须自己重新编译二进制文件才能启用它？
大多数 8.0 二进制文件都为受保护的、已验证的或两者的客户端/服务器连接启用了 SSL。请参阅第 6.3 节，“使用加密连接”。
A.9.5.
MySQL 8.0 是否内置了针对 LDAP 目录的身份验证？
企业版包括一个
支持针对 LDAP 目录进行身份
验证的PAM 身份验证插件。A.9.6.
MySQL 8.0 是否包含对基于角色的访问控制 (RBAC) 的支持？
不是在这个时候。
A.9.7.
MySQL 8.0 是否支持 TLS 1.0 和 1.1？
从 MySQL 8.0.28 开始，删除了对 TLSv1 和 TLSv1.1 连接协议的支持。这些协议已从 MySQL 8.0.26 中弃用。有关删除的后果，请参阅
删除对 TLSv1 和 TLSv1.1 协议的支持。
删除了对 TLS 版本 1.0 和 1.1 的支持，因为这些协议版本较旧，分别于 1996 年和 2006 年发布。使用的算法薄弱且过时。
除非您使用的是非常旧版本的 MySQL 服务器或连接器，否则您不太可能使用 TLS 1.0 或 1.1 建立连接。MySQL 连接器和客户端默认选择可用的最高 TLS 版本。
MySQL Server 何时添加了对 TLS 1.2 的支持？MySQL Community Server 在 2019 年社区服务器为 MySQL 5.6、5.7 和 8.0 切换到 OpenSSL 时添加了 TLS 1.2 支持。对于 MySQL Enterprise Edition，OpenSSL 在 2015 年的 MySQL Server 5.7.10 中添加了 TLS 1.2 支持。
如何查看正在使用的 TLS 版本？对于 MySQL 5.7 或 8.0，通过运行以下查询查看是否正在使用 TLS 1.0 或 1.1：
SELECT
`session_ssl_status`.`thread_id`, `session_ssl_status`.`ssl_version`,
`session_ssl_status`.`ssl_cipher`, `session_ssl_status`.`ssl_sessions_reused`
FROM `sys`.`session_ssl_status`
WHERE ssl_version NOT IN ('TLSv1.3','TLSv1.2');
如果列出了使用 TLSv1.0 或 TLSv1.1 的线程，您可以通过运行以下查询来确定此连接的来源：
SELECT thd_id,conn_id, user, db, current_statement, program_name
FROM sys.processlist
WHERE thd_id IN (
SELECT `session_ssl_status`.`thread_id`
FROM `sys`.`session_ssl_status`
WHERE ssl_version NOT IN ('TLSv1.3','TLSv1.2')
);
或者，您可以运行此查询：
SELECT *
FROM sys.session
WHERE thd_id IN (
SELECT `session_ssl_status`.`thread_id`
FROM `sys`.`session_ssl_status`
WHERE ssl_version NOT IN ('TLSv1.3','TLSv1.2')
);
这些查询提供了确定哪个应用程序不支持 TLS 1.2 或 1.3 以及针对这些应用程序进行升级所需的详细信息。
是否有其他选项可用于测试 TLS 1.0 或 1.1？是的，您可以在将服务器升级到更新版本之前禁用这些版本。mysql.cnf
在(或mysql.ini) 中或使用
明确指定要使用的版本SET
PERSIST，例如：
--tls-version=TLSv12。
是否所有 MySQL 连接器（5.7 和 8.0）都支持 TLS 1.2 及更高版本？使用 C 和 C++ 应用程序
libmysql怎么样？对于使用社区库的 C 和 C++ 应用程序
libmysqlclient，请使用基于 OpenSSL 的库（即，不要使用YaSSL）。OpenSSL 的使用在 2018 年统一（分别在 MySQL 8.0.4 和 5.7.28 中）。这同样适用于连接器/ODBC 和连接器/C++。要确定使用了哪些库依赖项，请运行以下命令以查看是否列出了 OpenSSL。在 Linux 上，使用此命令：
$> sudo ldd usr/local/mysql/lib/libmysqlclient.a | grep -i openssl
在 MacOS 上，使用此命令：
$> sudo otool -l /usr/local/mysql/lib/libmysqlclient.a | grep -i openssl
连接器/J 呢？Java 8 在 2014 年 1 月默认迁移到 TLS 1.2；在此之前支持 TLS 1.2，因此除非您运行的是非常旧的 Connector/J 版本，否则您将获得 TLS 1.2 支持。
连接器/NET 怎么样？对于 .NET 应用程序，Microsoft 在 2020 年底停止了对 TLS 1.0 和 1.1 的支持。在 2012 年添加了对 TLS 1.2 的支持。您需要使用非常旧版本的 Connector/NET 才能不支持 TLS 1.2。
连接器/Python 呢？这取决于您运行的 Python 版本。Python 2.6 中的 SSL 模块仅支持 1.0 版以下的 TLS。在这种情况下，您需要升级到 Python 2.7.9 或更高版本，或者 Python 3.x，它们都支持更新版本的 TLS。有关详细信息，请参阅
连接器/Python 版本和
https://www.calazan.com/how-to-check-if-your-python-app-supports-tls-12/。
Connector/Node.js 或 Node MySQL2 怎么样？TLS 随附nodejs，所有受支持的 Node.js 版本都使用 OpenSSL v1.1.1（截至 2020 年 4 月），它再次支持 TLS 1.2 及更高版本。
PHP 呢？
这些 PHP 版本支持 TLS 1.2 及更高版本。
© Mysql 中文网
