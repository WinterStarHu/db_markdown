# 2.8 在 FreeBSD 上安装 MySQL_MySQL 8.0 参考手册

2.8 在 FreeBSD 上安装 MySQL_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  /
2.8 在 FreeBSD 上安装 MySQL
2.8 在 FreeBSD 上安装 MySQL
本节提供有关在 FreeBSD Unix 变体上安装 MySQL 的信息。
您可以使用 Oracle 提供的二进制分发版在 FreeBSD 上安装 MySQL。有关详细信息，请参阅
第 2.2 节，“使用通用二进制文件在 Unix/Linux 上安装 MySQL”。
安装 MySQL 的最简单（也是首选）方法是使用
http://www.freebsd.org/上提供的mysql-server和mysql-client
端口。使用这些端口可为您带来以下好处：
一个工作的 MySQL，它启用了所有已知的可以在您的 FreeBSD 版本上工作的优化。
自动配置和构建。
安装在
/usr/local/etc/rc.d.
pkg_info -L用于查看安装了哪些文件
的能力。pkg_delete如果您不再需要在您的机器上使用 MySQL，则可以
使用它来删除它。
MySQL 构建过程需要 GNU make ( gmake ) 才能工作。如果 GNU make不可用，则必须在编译 MySQL 之前先安装它。
笔记
根据ldd mysqld的先决条件库：libthr、libcrypt、libkrb5、libm、librt、libexecinfo、libunwind 和 libssl。
使用 ports 系统安装：
# cd /usr/ports/databases/mysql80-server
# make
...
# cd /usr/ports/databases/mysql80-client
# make
...
标准端口安装将服务器放入
/usr/local/libexec/mysqld，MySQL 服务器的启动脚本放在
/usr/local/etc/rc.d/mysql-server.
关于 BSD 实现的一些附加说明：
使用 ports 系统在安装后删除 MySQL：
# cd /usr/ports/databases/mysql80-server
# make deinstall
...
# cd /usr/ports/databases/mysql80-client
# make deinstall
...
如果您在 MySQL 中遇到有关当前日期的问题，设置
TZ变量应该会有所帮助。请参阅
第 4.9 节，“环境变量”。
© Mysql 中文网
