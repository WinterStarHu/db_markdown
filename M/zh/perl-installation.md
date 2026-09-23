# 2.13.1 在 Unix 上安装 Perl_MySQL 8.0 参考手册

2.13.1 在 Unix 上安装 Perl_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.13 Perl 安装注意事项  /
2.13.1 在 Unix 上安装 Perl
2.13.1 在 Unix 上安装 Perl
MySQL Perl 支持要求您安装了 MySQL 客户端编程支持（库和头文件）。大多数安装方法都会安装必要的文件。如果在 Linux 上从 RPM 文件安装 MySQL，请确保同时安装开发人员 RPM。客户端程序在客户端 RPM 中，但客户端编程支持在开发人员 RPM 中。
Perl 支持所需的文件可以从位于
http://search.cpan.org的 CPAN（Comprehensive Perl Archive Network）获得。
在 Unix 上安装 Perl 模块的最简单方法是使用
CPAN模块。例如：
$> perl -MCPAN -e shell
cpan> install DBI
cpan> install DBD::mysqlDBD::mysql安装运行许多测试
。这些测试尝试使用默认用户名和密码连接到本地 MySQL 服务器。（默认用户名是您在 Unix 和ODBCWindows 上的登录名。默认密码是“无密码” 。 ）如果您无法使用这些值连接到服务器（例如，如果您的帐户有密码），测试失败。您可以使用
force install DBD::mysql忽略失败的测试。
DBI需要
Data::Dumper模块。可以安装；如果没有，你应该在安装之前安装它
DBI。
也可以下载压缩的tar存档形式的模块分发并手动构建模块。例如，要解压并构建 DBI 分发，请使用如下过程：
将发行版解压到当前目录：
$> gunzip < DBI-VERSION.tar.gz | tar xvf -
此命令创建一个名为
.
DBI-VERSION
将位置更改为解压缩分发的顶级目录：
$> cd DBI-VERSION
构建发行版并编译所有内容：
$> perl Makefile.PL
$> make
$> make test
$> make install
make test命令很重要
，因为它验证模块是否正常工作。请注意，在DBD::mysql安装过程中运行该命令以测试接口代码时，MySQL 服务器必须处于运行状态，否则测试将失败。
DBD::mysql每当您安装新版本的 MySQL 时
，重建并重新安装发行版是个好主意
。这可确保正确安装最新版本的 MySQL 客户端库。
如果您没有在系统目录中安装 Perl 模块的访问权限，或者如果您想安装本地 Perl 模块，以下参考资料可能会有用：
http ://learn.perl.org/faq/perlfaq8.html#How- do-I-keep-my-own-module-library-directory-
© Mysql 中文网
