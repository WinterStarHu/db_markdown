# 2.3.1 MySQL 在Microsoft Windows 上的安装布局_MySQL 8.0 参考手册

2.3.1 MySQL 在Microsoft Windows 上的安装布局_MySQL 8.0 参考手册
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
2.3.1 MySQL 在Microsoft Windows 上的安装布局1
2.3.2 选择安装包1
2.3.3 Windows 版 MySQL 安装程序1
2.3.4 使用 noinstall ZIP 存档在 Microsoft Windows 上安装 MySQL1
2.3.5 Microsoft Windows MySQL 服务器安装故障排除1
2.3.6 Windows 安装后程序1
2.3.7 Windows 平台限制1
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.3 在 Microsoft Windows 上安装 MySQL  /
2.3.1 MySQL 在Microsoft Windows 上的安装布局
2.3.1 MySQL 在Microsoft Windows 上的安装布局
对于 Windows 上的 MySQL 8.0，默认安装目录C:\Program Files\MySQL\MySQL Server
8.0用于使用 MySQL Installer 执行的安装。如果您使用 ZIP 存档方法安装 MySQL，您可能更喜欢安装在C:\mysql. 但是，子目录的布局保持不变。
所有文件都位于此父目录中，使用下表所示的结构。
表 2.4 Microsoft Windows 的默认 MySQL 安装布局
目录
目录内容
笔记
bin
mysqld服务器、客户端和实用程序
%PROGRAMDATA%\MySQL\MySQL Server 8.0\
日志文件、数据库
Windows 系统变量%PROGRAMDATA%默认为
C:\ProgramData.
docs
发布文档
使用 MySQL Installer，使用Modify操作来选择这个可选的文件夹。
include
包含（头）文件
lib
图书馆
share
其他支持文件，包括错误消息、字符集文件、示例配置文件、用于数据库安装的 SQL
© Mysql 中文网
