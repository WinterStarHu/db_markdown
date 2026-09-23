# 2.9.6 配置 SSL 库支持_MySQL 8.0 参考手册

2.9.6 配置 SSL 库支持_MySQL 8.0 参考手册
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
2.1 一般安装指南
2.2 使用通用二进制文件在 Unix/Linux 上安装 MySQL
2.3 在 Microsoft Windows 上安装 MySQL
2.4 在 macOS 上安装 MySQL
2.5 在 Linux 上安装 MySQL
2.6 使用坚不可摧的Linux网络（ULN）安装MySQL
2.7 在 Solaris 上安装 MySQL
2.8 在 FreeBSD 上安装 MySQL
2.9 从源码安装MySQL
2.9.1 源码安装方式1
2.9.2 源安装先决条件1
2.9.3 MySQL源码安装布局1
2.9.4 使用标准源代码分发安装 MySQL1
2.9.5 使用开发源树安装MySQL1
2.9.6 配置 SSL 库支持1
2.9.7 MySQL 源配置选项1
2.9.8 处理编译MySQL的问题1
2.9.9 MySQL配置和第三方工具1
2.9.10 生成MySQL Doxygen文档内容1
2.10 安装后设置和测试
2.11 升级MySQL
2.12 降级MySQL
2.13 Perl 安装注意事项
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
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.9 从源码安装MySQL  /
2.9.6 配置 SSL 库支持
2.9.6 配置 SSL 库支持
需要一个 SSL 库来支持加密连接、随机数生成的熵以及其他与加密相关的操作。
如果您从源代码分发版编译 MySQL，
CMake 会将分发版配置为默认使用已安装的 OpenSSL 库。
要使用 OpenSSL 进行编译，请使用以下过程：
确保您的系统上安装了 OpenSSL 1.0.1 或更高版本。如果安装的 OpenSSL 版本低于 1.0.1，
CMake在 MySQL 配置时会产生错误。如果需要获取 OpenSSL，请访问http://www.openssl.org。
CMake选项确定
使用哪个 SSL 库来编译 MySQL（请参阅
第 2.9.7 节，“MySQL 源配置选项”）。默认值为，它使用 OpenSSL。要明确这一点，请在
CMake命令行上指定该选项。例如：
WITH_SSL
-DWITH_SSL=systemcmake . -DWITH_SSL=system
该命令将分发配置为使用已安装的 OpenSSL 库。或者，要显式指定 OpenSSL 安装的路径名，请使用以下语法。如果您安装了多个版本的 OpenSSL，这将很有用，以防止CMake选择错误的版本：
cmake . -DWITH_SSL=path_name通过在 EL7 上使用WITH_SSL=openssl11或在 EL8上使用 WITH_SSL=openssl3，
从 v8.0.30 开始支持替代 OpenSSL 系统包。身份验证插件（例如 LDAP 和 Kerberos）被禁用，因为它们不支持这些替代版本的 OpenSSL。
编译并安装发行版。
要检查mysqld服务器是否支持加密连接，请检查
have_ssl系统变量的值：
mysql> SHOW VARIABLES LIKE 'have_ssl';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| have_ssl      | YES   |
+---------------+-------+
如果值为YES，则服务器支持加密连接。如果值为
DISABLED，则服务器能够支持加密连接，但未使用适当的
选项启动以启用要使用的加密连接；参见
第 6.3.1 节，“配置 MySQL 以使用加密连接”。
--ssl-xxx
© Mysql 中文网
