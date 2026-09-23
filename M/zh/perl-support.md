# 2.13 Perl 安装注意事项_MySQL 8.0 参考手册

2.13 Perl 安装注意事项_MySQL 8.0 参考手册
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
2.13.1 在 Unix 上安装 Perl1
2.13.2 在 Windows 上安装 ActiveState Perl1
2.13.3 使用 Perl DBI/DBD 接口的问题1
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
2.13 Perl 安装注意事项
2.13 Perl 安装注意事项
2.13.1 在 Unix 上安装 Perl2.13.2 在 Windows 上安装 ActiveState Perl2.13.3 使用 Perl DBI/DBD 接口的问题
PerlDBI模块为数据库访问提供了一个通用接口。您可以编写DBI无需更改即可与许多不同数据库引擎一起使用的脚本。要使用DBI，您必须为要访问的每种类型的数据库服务器安装该
DBI模块以及数据库驱动程序 (DBD) 模块。对于 MySQL，这个驱动程序就是DBD::mysql模块。
笔记
MySQL 发行版不包含 Perl 支持。对于 Unix，您可以从http://search.cpan.org获得必要的模块
，或者在 Windows 上使用 ActiveState ppm程序。以下部分描述了如何执行此操作。
/接口需要 Perl 5.6.0 DBI，DBD首选 5.6.1 或更高版本。如果您使用的是旧版本的 Perl，则DBI不起作用。您应该使用
DBD::mysql4.009 或更高版本。虽然早期版本可用，但它们不支持 MySQL 8.0 的全部功能。
© Mysql 中文网
