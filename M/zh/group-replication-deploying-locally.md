# 18.2.2 在本地部署组复制_MySQL 8.0 参考手册

18.2.2 在本地部署组复制_MySQL 8.0 参考手册
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
18.1 组复制背景
18.2 开始
18.2.1 在单主模式下部署组复制1
18.2.2 在本地部署组复制1
18.3 要求和限制
18.4 监控组复制
18.5 组复制操作
18.6 组复制安全
18.7 组复制性能和故障排除
18.8 升级组复制
18.9 组复制系统变量
18.10 常见问题
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
MySQL 8.0 参考手册  / 第十八章 组复制  / 18.2 开始  /
18.2.2 在本地部署组复制
18.2.2 在本地部署组复制
部署组复制的最常见方法是使用多个服务器实例，以提供高可用性。也可以在本地部署组复制，例如用于测试目的。本节介绍如何在本地部署组复制。
重要的
Group Replication 通常部署在多台主机上，因为这样可以确保提供高可用性。本节中的说明不适用于生产部署，因为所有 MySQL 服务器实例都在同一台主机上运行。如果此主机发生故障，则整个组都会发生故障。因此，此信息应用于测试目的，不应在生产环境中使用。
本节介绍如何在一台物理机上创建一个包含三个 MySQL Server 实例的复制组。这意味着需要三个数据目录，每个服务器实例一个，并且您需要独立配置每个实例。此过程假定 MySQL 服务器已下载并解压缩到名为的目录mysql-8.0中。每个 MySQL 服务器实例都需要一个特定的数据目录。创建一个名为 的目录data，然后在该目录中为每个服务器实例（例如 s1、s2 和 s3）创建一个子目录，并初始化每个实例。
mysql-8.0/bin/mysqld --initialize-insecure --basedir=$PWD/mysql-8.0 --datadir=$PWD/data/s1
mysql-8.0/bin/mysqld --initialize-insecure --basedir=$PWD/mysql-8.0 --datadir=$PWD/data/s2
mysql-8.0/bin/mysqld --initialize-insecure --basedir=$PWD/mysql-8.0 --datadir=$PWD/data/s3
里面是
初始化数据目录data/s1，包含mysql系统数据库和相关表等等。要了解有关初始化过程的更多信息，请参阅
第 2.10.1 节，“初始化数据目录”。
data/s2data/s3
警告
不要-initialize-insecure在生产环境中使用，这里只是为了简化教程。有关安全设置的更多信息，请参阅
第 18.6 节，“组复制安全”。
本地组复制成员的配置
当您在执行
第 18.2.1.2 节“为组复制配置实例”时，您需要为上一节添加的数据目录添加配置。例如：
[mysqld]
# server configuration
datadir=<full_path_to_data>/data/s1
basedir=<full_path_to_bin>/mysql-8.0/
port=24801
socket=<full_path_to_sock_dir>/s1.sock
这些设置将 MySQL 服务器配置为使用之前创建的数据目录以及服务器应打开哪个端口并开始侦听传入连接。
笔记
使用非默认端口 24801 是因为在本教程中三个服务器实例使用相同的主机名。在具有三台不同机器的设置中，这不是必需的。
组复制需要成员之间的网络连接，这意味着每个成员必须能够解析所有其他成员的网络地址。例如，在本教程中，所有三个实例都在一台机器上运行，因此要确保成员可以相互联系，您可以在选项文件中添加一行，例如
report_host=127.0.0.1.
然后每个成员都需要能够连接到他们的其他成员
group_replication_local_address。例如在成员 s1 的选项文件中添加：
group_replication_local_address= "127.0.0.1:24901"
group_replication_group_seeds= "127.0.0.1:24901,127.0.0.1:24902,127.0.0.1:24903"
这会将 s1 配置为使用端口 24901 与种子成员进行内部组通信。对于要添加到组中的每个服务器实例，在成员的选项文件中进行这些更改。对于每个成员，您必须确保指定了一个唯一的地址，因此为每个实例使用一个唯一的端口
group_replication_local_address。通常，您希望所有成员都能够作为加入该组但尚未获得该组处理的交易的成员的种子。在这种情况下，将所有端口添加到
group_replication_group_seeds
如上所示。
第 18.2.1 节“在单主模式下部署组复制”
的其余步骤
同样适用于您以这种方式在本地部署的组。
© Mysql 中文网
