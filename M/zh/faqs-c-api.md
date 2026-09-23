# A.13 MySQL 8.0 常见问题解答：C API、libmysql_MySQL 8.0 参考手册

A.13 MySQL 8.0 常见问题解答：C API、libmysql_MySQL 8.0 参考手册
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
A.13 MySQL 8.0 常见问题解答：C API、libmysql
A.13 MySQL 8.0 常见问题解答：C API、libmysql
有关 MySQL C API 和 libmysql 的常见问题。
A.13.1。
什么是“MySQL Native C API”？典型的好处和用例是什么？
A.13.2。
我应该使用哪个版本的 libmysql？
A.13.3.
如果我想使用“NoSQL”X DevAPI 怎么办？
A.13.4.
如何下载 libmysql？
A.13.5。
文档在哪里？
A.13.6.
我如何报告错误？
A.13.7。
是否可以自己编译库？
A.13.1。
什么是“ MySQL Native C API ”？典型的好处和用例是什么？
libmysql 是一个基于 C 的 API，您可以在 C 应用程序中使用它来连接 MySQL 数据库服务器。它本身也用作标准数据库 API（如 ODBC、Perl 的 DBI 和 Python 的 DB API）驱动程序的基础。
A.13.2。
我应该使用哪个版本的 libmysql？
对于 MySQL 8.0、5.7、5.6 和 5.5，我们建议使用 libmysql 8.0。
A.13.3.
如果我想使用“ NoSQL ” X DevAPI 怎么办？
对于 MySQL 8.0 的 C 语言和 X DevApi 文档存储，我们推荐 MySQL Connector/C++。Connector/C++ 8.0 具有兼容的 C 头文件。（这不适用于 MySQL 5.7 或之前的版本。）
A.13.4.
如何下载 libmysql？
Linux：客户端实用程序包可从
MySQL Community Server下载页面获得。
Repos：客户端实用程序包可从
Yum、
APT、
SuSE 存储库获得。
Windows：客户端实用程序包可从
Windows Installer获得。
A.13.5。
文档在哪里？
请参阅MySQL 8.0 C API 开发人员指南。
A.13.6.
我如何报告错误？
请向我们的错误数据库
报告您观察到的任何错误或不一致
。选择 C ​​API Client，如图所示。
A.13.7。
是否可以自己编译库？
编译 MySQL Server 也会编译 libmysqlclient；没有办法只编译 libmysqlclient。有关相关信息，请参阅MySQL C API 实现。
© Mysql 中文网
