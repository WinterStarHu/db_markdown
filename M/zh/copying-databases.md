# 2.11.14 复制MySQL数据库到另一台机器_MySQL 8.0 参考手册

2.11.14 复制MySQL数据库到另一台机器_MySQL 8.0 参考手册
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
2.11.1 开始之前1
2.11.2 升级路径1
2.11.3 MySQL升级过程升级了什么1
2.11.4 MySQL 8.0 的变化1
2.11.5 准备升级安装1
2.11.6 在 Unix/Linux 上升级 MySQL 二进制或基于包的安装1
2.11.7 使用 MySQL Yum 仓库升级 MySQL1
2.11.8 使用MySQL APT Repository升级MySQL1
2.11.9 使用 MySQL SLES 存储库升级 MySQL1
2.11.10 Windows 升级MySQL1
2.11.11 升级MySQL的Docker安装1
2.11.12 升级故障处理1
2.11.13 重建或修复表或索引1
2.11.14 复制MySQL数据库到另一台机器1
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.11 升级MySQL  /
2.11.14 复制MySQL数据库到另一台机器
2.11.14 复制MySQL数据库到另一台机器
如果需要在不同体系结构之间传输数据库，可以使用mysqldump创建一个包含 SQL 语句的文件。然后您可以将该文件传输到另一台机器并将其作为输入提供给
mysql客户端。
使用mysqldump --help查看可用的选项。
笔记
如果在创建转储 ( gtid_mode=ON) 的服务器上正在使用 GTID，则默认情况下，
mysqldump在转储中包含集合的内容，
gtid_executed以将这些内容传输到新机器。其结果可能因所涉及的 MySQL 服务器版本而异。查看mysqldump
--set-gtid-purged选项的描述，了解您正在使用的版本会发生什么，以及如果默认行为的结果不适合您的情况，如何更改行为。
在两台机器之间移动数据库的最简单（虽然不是最快）方法是在数据库所在的机器上运行以下命令：
mysqladmin -h 'other_hostname' create db_name
mysqldump db_name | mysql -h 'other_hostname' db_name
如果你想通过慢速网络从远程机器复制数据库，你可以使用这些命令：
mysqladmin create db_name
mysqldump -h 'other_hostname' --compress db_name | mysql db_name
您还可以将转储存储在文件中，将文件传输到目标机器，然后将文件加载到那里的数据库中。例如，您可以像这样将数据库转储到源计算机上的压缩文件中：
mysqldump --quick db_name | gzip > db_name.gz
将包含数据库内容的文件传输到目标机器并在那里运行这些命令：
mysqladmin create db_name
gunzip < db_name.gz | mysql db_name
您还可以使用mysqldump和
mysqlimport来传输数据库。对于大表，这比简单地使用mysqldump快得多
。在以下命令中，
DUMPDIR表示用于存储
mysqldump输出的目录的完整路径名。
首先，为输出文件创建目录并转储数据库：
mkdir DUMPDIR
mysqldump --tab=DUMPDIR
db_name
然后将DUMPDIR
目录中的文件传输到目标机器上的某个相应目录，并将文件加载到那里的 MySQL 中：
mysqladmin create db_name           # create database
cat DUMPDIR/*.sql | mysql db_name   # create tables in database
mysqlimport db_name
DUMPDIR/*.txt   # load data into tables
不要忘记复制mysql数据库，因为那是存储授权表的地方。您可能必须root在新机器上以 MySQL 用户身份运行命令，直到您准备好mysql数据库。
在新机器上导入mysql数据库后，执行mysqladmin flush-privileges，让服务器重新加载授权表信息。
© Mysql 中文网
