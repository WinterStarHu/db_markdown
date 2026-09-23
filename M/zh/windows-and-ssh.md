# 6.3.4 使用 SSH 从 Windows 远程连接到 MySQL_MySQL 8.0 参考手册

6.3.4 使用 SSH 从 Windows 远程连接到 MySQL_MySQL 8.0 参考手册
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
6.1 一般安全问题
6.2 访问控制和账户管理
6.3 使用加密连接
6.3.1 配置 MySQL 使用加密连接1
6.3.2 加密连接 TLS 协议和密码1
6.3.3 创建 SSL 和 RSA 证书和密钥1
6.3.4 使用 SSH 从 Windows 远程连接到 MySQL1
6.3.5 重用 SSL 会话1
6.4 安全组件和插件
6.5 MySQL 企业数据屏蔽和去标识化
6.6 MySQL企业加密
6.7 SELinux
6.8 FIPS 支持
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
MySQL 8.0 参考手册  / 第 6 章 安全  / 6.3 使用加密连接  /
6.3.4 使用 SSH 从 Windows 远程连接到 MySQL
6.3.4 使用 SSH 从 Windows 远程连接到 MySQL
本节介绍如何使用 SSH 获取到远程 MySQL 服务器的加密连接。该信息由 David Carlson 提供。
<dcarlson@mplcomm.com>
在 Windows 计算机上安装 SSH 客户端。有关 SSH 客户端的比较，请参阅
http://en.wikipedia.org/wiki/Comparison_of_SSH_clients。
启动 Windows SSH 客户端。设置。设置
为登录到您的服务器。此值可能与您的 MySQL 帐户的用户名不同。
Host_Name =
yourmysqlserver_URL_or_IPuserid=your_useriduserid
设置端口转发。执行远程转发 (Set
local_port: 3306, ,
) 或本地转发 (Set
, , )。
remote_host:
yourmysqlservername_or_ipremote_port: 3306port: 3306host:
localhostremote port: 3306
保存所有内容，否则下次必须重做。
使用刚刚创建的 SSH 会话登录到您的服务器。
在您的 Windows 机器上，启动一些 ODBC 应用程序（例如 Access）。
在 Windows 中创建一个新文件，并像通常一样使用 ODBC 驱动程序链接到 MySQL，除了键入
localhostMySQL 主机服务器，而不是
yourmysqlservername.
此时，您应该有一个到 MySQL 的 ODBC 连接，使用 SSH 加密。
© Mysql 中文网
