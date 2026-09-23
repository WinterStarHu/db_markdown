# 23.4.1 NDB Cluster 的快速测试设置_MySQL 8.0 参考手册

23.4.1 NDB Cluster 的快速测试设置_MySQL 8.0 参考手册
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
23.1 一般信息
23.2 NDB Cluster 概述
23.3 NDB Cluster 安装
23.4 NDB Cluster的配置
23.4.1 NDB Cluster 的快速测试设置1
23.4.2 NDB Cluster 配置参数、选项和变量概述1
23.4.3 NDB Cluster 配置文件1
23.4.4 使用 NDB Cluster 的高速互连1
23.5 NDB 集群程序
23.6 NDB Cluster的管理
23.7 NDB 集群复制
23.8 NDB Cluster 发行说明
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.4 NDB Cluster的配置  /
23.4.1 NDB Cluster 的快速测试设置
23.4.1 NDB Cluster 的快速测试设置
为了让您熟悉基础知识，我们描述了功能 NDB Cluster 的最简单的配置。在此之后，您应该能够根据本章其他相关部分提供的信息设计所需的设置。
首先，您需要创建一个配置目录，例如
/var/lib/mysql-cluster，以系统root用户执行以下命令：
$> mkdir /var/lib/mysql-cluster
在此目录中，创建一个名为的文件
config.ini，其中包含以下信息。根据需要为您的系统
HostName替换适当的值
。DataDir# file "config.ini" - showing minimal setup consisting of 1 data node,
# 1 management server, and 3 MySQL servers.
# The empty default sections are not required, and are shown only for
# the sake of completeness.
# Data nodes must provide a hostname but MySQL Servers are not required
# to do so.
# If you don't know the hostname for your machine, use localhost.
# The DataDir parameter also has a default value, but it is recommended to
# set it explicitly.
# Note: [db], [api], and [mgm] are aliases for [ndbd], [mysqld], and [ndb_mgmd],
# respectively. [db] is deprecated and should not be used in new installations.
[ndbd default]
NoOfReplicas= 1
[mysqld  default]
[ndb_mgmd default]
[tcp default]
[ndb_mgmd]
HostName= myhost.example.com
[ndbd]
HostName= myhost.example.com
DataDir= /var/lib/mysql-cluster
[mysqld]
[mysqld]
[mysqld]
您现在可以启动ndb_mgmd管理服务器。默认情况下，它会尝试读取
config.ini其当前工作目录中的文件，因此将位置更改为文件所在的目录，然后调用ndb_mgmd：
$> cd /var/lib/mysql-cluster
$> ndb_mgmd然后通过运行ndbd
启动单个数据节点：
$> ndbd
默认情况下，ndbdlocalhost在端口 1186 上
查找管理服务器。
笔记
如果您从二进制 tarball 安装 MySQL，则必须明确指定ndb_mgmd和
ndbd服务器的路径。（通常，这些可以在 中找到/usr/local/mysql/bin。）
最后，将位置更改为 MySQL 数据目录（通常是
/var/lib/mysql或
/usr/local/mysql/data），并确保该my.cnf文件包含启用 NDB 存储引擎所需的选项：
[mysqld]
ndbcluster
您现在可以像往常一样启动 MySQL 服务器：
$> mysqld_safe --user=mysql &
稍等片刻，确保 MySQL 服务器正常运行。如果您看到通知mysql ended，请检查服务器的.err文件以找出问题所在。
如果到目前为止一切顺利，您现在可以开始使用集群了。连接到服务器并验证
NDBCLUSTER存储引擎是否已启用：
$> mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 1 to server version: 8.0.31
Type 'help;' or '\h' for help. Type '\c' to clear the buffer.
mysql> SHOW ENGINES\G
...
*************************** 12. row ***************************
Engine: NDBCLUSTER
Support: YES
Comment: Clustered, fault-tolerant, memory-based tables
*************************** 13. row ***************************
Engine: NDB
Support: YES
Comment: Alias for NDBCLUSTER
...
上述示例输出中显示的行号可能与系统上显示的行号不同，具体取决于服务器的配置方式。
尝试创建一个NDBCLUSTER表：
$> mysql
mysql> USE test;
Database changed
mysql> CREATE TABLE ctest (i INT) ENGINE=NDBCLUSTER;
Query OK, 0 rows affected (0.09 sec)
mysql> SHOW CREATE TABLE ctest \G
*************************** 1. row ***************************
Table: ctest
Create Table: CREATE TABLE `ctest` (
`i` int(11) default NULL
) ENGINE=ndbcluster DEFAULT CHARSET=latin1
1 row in set (0.00 sec)
要检查您的节点是否设置正确，请启动管理客户端：
$> ndb_mgm
从管理客户端中使用SHOW命令获取集群状态报告：
ndb_mgm> SHOW
Cluster Configuration
---------------------
[ndbd(NDB)]     1 node(s)
id=2    @127.0.0.1  (Version: 8.0.32-ndb-8.0.32, Nodegroup: 0, *)
[ndb_mgmd(MGM)] 1 node(s)
id=1    @127.0.0.1  (Version: 8.0.32-ndb-8.0.32)
[mysqld(API)]   3 node(s)
id=3    @127.0.0.1  (Version: 8.0.32-ndb-8.0.32)
id=4 (not connected, accepting connect from any host)
id=5 (not connected, accepting connect from any host)
此时，您已经成功设置了一个工作的 NDB Cluster 。您现在可以使用使用ENGINE=NDBCLUSTER或其别名
创建的任何表将数据存储在集群中ENGINE=NDB。
© Mysql 中文网
