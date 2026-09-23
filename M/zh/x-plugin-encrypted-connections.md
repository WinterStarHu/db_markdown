# 20.5.3 使用 X 插件的加密连接_MySQL 8.0 参考手册

20.5.3 使用 X 插件的加密连接_MySQL 8.0 参考手册
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
20.1 MySQL文档存储的接口
20.2 文档存储概念
20.3 JavaScript 快速入门指南：用于文档存储的 MySQL Shell
20.4 Python 快速入门指南：用于文档存储的 MySQL Shell
20.5 X 插件
20.5.1 检查 X 插件安装1
20.5.2 禁用 X 插件1
20.5.3 使用 X 插件的加密连接1
20.5.4 将 X 插件与缓存 SHA-2 身份验证插件一起使用1
20.5.5 使用 X 插件进行连接压缩1
20.5.6 X 插件选项和变量1
20.5.7 监控 X 插件1
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
MySQL 8.0 参考手册  / 第 20 章使用 MySQL 作为文档存储  / 20.5 X 插件  /
20.5.3 使用 X 插件的加密连接
20.5.3 使用 X 插件的加密连接
本节介绍如何配置 X 插件以使用加密连接。有关更多背景信息，请参阅
第 6.3 节 “使用加密连接”。
为了启用对加密连接的配置支持，X Plugin 具有系统变量，它可以具有与 MySQL 服务器使用
的系统变量不同的值
。例如，X Plugin 可以具有 SSL 密钥、证书和证书授权文件，这些文件与用于 MySQL 服务器的文件不同。这些变量在
第 20.5.6.2 节“X 插件选项和系统变量”中进行了描述。同样，X Plugin 有自己的
状态变量，对应于 MySQL 服务器加密连接
状态变量。请参阅第 20.5.6.3 节，“X 插件状态变量”。
mysqlx_ssl_xxxssl_xxxMysqlx_ssl_xxxSsl_xxx
在初始化时，X Plugin 确定其加密连接的 TLS 上下文，如下所示：
如果所有
的系统变量都有默认值，X Plugin使用与MySQL Server主连接接口相同的TLS上下文，由
系统变量的值决定。
mysqlx_ssl_xxxssl_xxx
如果任何
变量具有非默认值，X 插件将使用由其自身系统变量的值定义的 TLS 上下文。（如果任何
系统变量设置为与其默认值不同的值，就会出现这种情况。）
mysqlx_ssl_xxxmysqlx_ssl_xxx
这意味着，在启用了 X 插件的服务器上，您可以通过仅设置变量来选择让 MySQL 协议和 X 协议连接共享相同的加密配置
，或者通过配置和
为 MySQL 协议和 X 协议连接设置单独的加密配置
变量分开。
ssl_xxxssl_xxxmysqlx_ssl_xxx
要让 MySQL 协议和 X 协议连接使用相同的加密配置，请仅设置
系统变量：
ssl_xxxmy.cnf[mysqld]
ssl_ca=ca.pem
ssl_cert=server-cert.pem
ssl_key=server-key.pem
要为 MySQL 协议和 X 协议连接单独配置加密，请在 中设置
和
系统变量：
ssl_xxxmysqlx_ssl_xxxmy.cnf[mysqld]
ssl_ca=ca1.pem
ssl_cert=server-cert1.pem
ssl_key=server-key1.pem
mysqlx_ssl_ca=ca2.pem
mysqlx_ssl_cert=server-cert2.pem
mysqlx_ssl_key=server-key2.pem
有关配置连接加密支持的一般信息，请参阅第 6.3.1 节，“配置 MySQL 以使用加密连接”。该讨论是为 MySQL 服务器编写的，但 X 插件的参数名称相似。（X Plugin
系统变量名称对应于 MySQL Server
系统变量名称。）
mysqlx_ssl_xxxssl_xxx
确定 MySQL 协议连接允许的 TLS 版本的tls_version系统变量也适用于 X 协议连接。因此，两种连接类型允许的 TLS 版本是相同的。
每个连接的加密是可选的，但是通过在创建用户的语句中
包含适当的REQUIRE
子句，可以要求特定用户对 X 协议和 MySQL 协议连接使用加密。CREATE USER有关详细信息，请参阅
第 13.7.1.3 节，“CREATE USER 语句”。或者，要要求所有用户对 X 协议和 MySQL 协议连接使用加密，请启用
require_secure_transport系统变量。有关其他信息，请参阅将
加密连接配置为强制性。
© Mysql 中文网
