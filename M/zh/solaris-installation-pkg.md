# 2.7.1 使用 Solaris PKG 在 Solaris 上安装 MySQL_MySQL 8.0 参考手册

2.7.1 使用 Solaris PKG 在 Solaris 上安装 MySQL_MySQL 8.0 参考手册
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
2.7.1 使用 Solaris PKG 在 Solaris 上安装 MySQL1
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.7 在 Solaris 上安装 MySQL  /
2.7.1 使用 Solaris PKG 在 Solaris 上安装 MySQL
2.7.1 使用 Solaris PKG 在 Solaris 上安装 MySQL
您可以使用本机 Solaris PKG 格式的二进制包而不是二进制 tarball 分发在 Solaris 上安装 MySQL。
笔记
MySQL 5.7 依赖于 Oracle Developer Studio Runtime Libraries；但这不适用于 MySQL 8.0。
要使用这个包，请下载相应的
mysql-VERSION-solaris11-PLATFORM.pkg.gz文件，然后解压缩。例如：
$> gunzip mysql-8.0.31-solaris11-x86_64.pkg.gz
要安装新包，请使用pkgadd并按照屏幕上的提示进行操作。您必须具有 root 权限才能执行此操作：
$> pkgadd -d mysql-8.0.31-solaris11-x86_64.pkg
The following packages are available:
1  mysql     MySQL Community Server (GPL)
(i86pc) 8.0.31
Select package(s) you wish to process (or 'all' to process
all packages). (default: all) [?,??,q]:
PKG 安装程序安装所有需要的文件和工具，然后初始化您的数据库（如果不存在）。要完成安装，您应该按照安装结束时的说明设置 MySQL 的根密码。或者，您可以运行
安装附带
的mysql_secure_installation脚本。
默认情况下，PKG 包将 MySQL 安装在根路径下
/opt/mysql。使用pkgadd时只能更改安装根路径，它可用于在不同的 Solaris 区域中安装 MySQL。如果需要在特定目录中安装，请使用二进制
tar文件分发。
安装程序将pkg适合 MySQL 的启动脚本复制到/etc/init.d/mysql. 要使 MySQL 能够自动启动和关闭，您应该在该文件和 init 脚本目录之间创建一个链接。例如，为确保 MySQL 的安全启动和关闭，您可以使用以下命令添加正确的链接：
$> ln /etc/init.d/mysql /etc/rc3.d/S91mysql
$> ln /etc/init.d/mysql /etc/rc0.d/K02mysql
要删除 MySQL，安装的包名称是
mysql. 您可以将它与
pkgrm命令结合使用来删除安装。
要在使用 Solaris 软件包文件格式时进行升级，您必须先删除现有安装，然后再安装更新的软件包。删除软件包不会删除现有的数据库信息，只会删除服务器、二进制文件和支持文件。因此，典型的升级顺序是：
$> mysqladmin shutdown
$> pkgrm mysql
$> pkgadd -d mysql-8.0.31-solaris11-x86_64.pkg
$> mysqld_safe &
$> mysql_upgrade   # prior to MySQL 8.0.16 only在执行任何升级之前
，
您应该查看第 2.11 节“升级 MySQL”中的注意事项。
© Mysql 中文网
