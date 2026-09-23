# 23.1 一般信息_MySQL 8.0 参考手册

23.1 一般信息_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  /
23.1 一般信息
23.1 一般信息
MySQL NDB Cluster 使用带有
NDB存储引擎的 MySQL 服务器。NDBOracle 构建的标准 MySQL Server 8.0 二进制文件中不包含对存储引擎的支持
。相反，来自 Oracle 的 NDB Cluster 二进制文件的用户应该升级到支持平台的 NDB Cluster 的最新二进制版本——这些包括应该适用于大多数 Linux 发行版的 RPM。从源构建的 NDB Cluster 8.0 用户应该使用为 MySQL 8.0 提供的源，并使用提供 NDB 支持所需的选项进行构建。（可以获取资源的位置在本节后面列出。）
重要的
MySQL NDB Cluster 不支持 InnoDB Cluster，它必须使用带有
InnoDB存储引擎的 MySQL Server 8.0 以及 NDB Cluster 发行版中未包含的其他应用程序进行部署。MySQL Server 8.0 二进制文件不能与 MySQL NDB Cluster 一起使用。有关部署和使用 InnoDB Cluster 的更多信息，请参阅MySQL AdminAPI。
第 23.2.6 节，“使用 InnoDB 的 MySQL 服务器与 NDB Cluster 相比”NDB ，讨论了和InnoDB
存储引擎
之间的差异。
支持的平台。
NDB Cluster 目前在许多平台上可用并受支持。有关操作系统版本、操作系统发行版和硬件平台的特定组合的确切支持级别，请参阅
https://www.mysql.com/support/supportedplatforms/cluster.html。
可用性。
NDB Cluster 二进制文件和源包可从https://mysql.net.cn/downloads/cluster/获得支持的平台。
NDB Cluster 版本号。
NDB 8.0 遵循与 MySQL Server 8.0 系列版本相同的发布模式，从 MySQL 8.0.13 和 MySQL NDB Cluster 8.0.13 开始。在本手册和其他 MySQL 文档中，我们使用以“ NDB ”开头的版本号来标识这些和以后的 NDB Cluster 版本
。此版本号是
NDBCLUSTERNDB 8.0 版本中使用的存储引擎的版本号，与 NDB Cluster 8.0 版本所基于的 MySQL 8.0 服务器版本相同。
NDB Cluster 软件中使用的版本字符串。
MySQL NDB Cluster 发行版提供
的mysql客户端
显示的版本字符串使用以下格式：mysql-mysql_server_version-cluster
mysql_server_version表示 NDB Cluster 版本所基于的 MySQL 服务器的版本。对于所有 NDB Cluster 8.0 版本，这是
，版本号在哪里
。使用或等效的源代码构建将后缀添加到版本字符串。（请参阅
第 23.3.1.4 节，“在 Linux 上从源代码构建 NDB Cluster”和
第 23.3.2.2 节，“在 Windows 上从源代码编译和安装 NDB Cluster”。）您可以在mysql客户端中看到这种格式，如下所示:
8.0.nn-DWITH_NDB-cluster$> mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 2
Server version: 8.0.32-cluster Source distribution
Type 'help;' or '\h' for help. Type '\c' to clear the buffer.
mysql> SELECT VERSION()\G
*************************** 1. row ***************************
VERSION(): 8.0.32-cluster
1 row in set (0.00 sec)
使用 MySQL 8.0 的 NDB Cluster 的第一个通用版本是 NDB 8.0.19，使用 MySQL 8.0.19。
通常不包含在 MySQL 8.0 发行版中的其他 NDB Cluster 程序显示的版本字符串使用以下格式：
mysql-mysql_server_version ndb-ndb_engine_version
mysql_server_version表示 NDB Cluster 版本所基于的 MySQL 服务器的版本。对于所有 NDB Cluster 8.0 版本，这是
，版本号在哪里
。
是此版本
的 NDB Cluster 软件使用的存储引擎版本。对于所有 NDB 8.0 版本，此数字与 MySQL 服务器版本相同。您可以在ndb_mgm客户端的命令
输出中看到这种格式，如下所示：
8.0.nnndb_engine_versionNDBSHOWndb_mgm> SHOW
Connected to Management Server at: localhost:1186
Cluster Configuration
---------------------
[ndbd(NDB)]     2 node(s)
id=1    @10.0.10.6  (mysql-8.0.32 ndb-8.0.32, Nodegroup: 0, *)
id=2    @10.0.10.8  (mysql-8.0.32 ndb-8.0.32, Nodegroup: 0)
[ndb_mgmd(MGM)] 1 node(s)
id=3    @10.0.10.2  (mysql-8.0.32 ndb-8.0.32)
[mysqld(API)]   2 node(s)
id=4    @10.0.10.10  (mysql-8.0.32 ndb-8.0.32)
id=5 (not connected, accepting connect from any host)与标准 MySQL 8.0 版本的兼容性。
虽然许多标准的 MySQL 模式和应用程序可以使用 NDB Cluster 工作，但未修改的应用程序和数据库模式在使用 NDB Cluster 运行时可能会稍微不兼容或性能不佳（请参阅
第 23.2.7 节，“NDB Cluster 的已知限制”） ). 大多数这些问题都可以克服，但这也意味着您不太可能能够切换现有的应用程序数据存储——例如，当前使用的，MyISAM
或者——在不允许更改模式的可能性的情况下InnoDB使用
存储引擎NDB、查询和应用程序。没有编译
的mysqldNDB支持（即，不使用
-DWITH_NDBor
构建-DWITH_NDBCLUSTER_STORAGE_ENGINE）不能作为
使用它构建
的mysqld的直接替代品。NDB Cluster 开发源代码树。
NDB Cluster 开发树也可以从
https://github.com/mysql/mysql-server访问。
在https://github.com/mysql/mysql-server
维护的 NDB Cluster 开发源
是根据 GPL 许可的。有关使用 Git 获取 MySQL 源代码并自行构建它们的信息，请参阅
第 2.9.5 节，“使用开发源代码树安装 MySQL”。
笔记
与 MySQL Server 8.0 一样，NDB Cluster 8.0 版本是使用
CMake构建的。
NDB Cluster 8.0 从 NDB 8.0.19 开始作为一般可用性版本提供，建议用于新部署。NDB Cluster 7.6 和 7.5 是之前的 GA 版本，在生产中仍然受支持；有关 NDB Cluster 7.6 的信息，请参阅 NDB Cluster 7.6
中的新增功能。有关 NDB Cluster 7.5 的类似信息，请参阅
What is New in NDB Cluster 7.5。NDB Cluster 7.4 和 7.3 是以前的 GA 版本，在生产中仍然支持，尽管我们建议新的生产部署使用 NDB Cluster 8.0；请参阅
MySQL NDB Cluster 7.3 和 NDB Cluster 7.4。
随着 NDB Cluster 的不断发展，本章的内容可能会进行修订。有关 NDB Cluster 的其他信息可以在 MySQL 网站
http://www.mysql.com/products/cluster/上找到。
其他资源。
可以在以下位置找到有关 NDB Cluster 的更多信息：
有关 NDB Cluster 的一些常见问题的答案，请参阅第 A.10 节，“MySQL 8.0 FAQ：NDB Cluster”。
NDB 集群论坛：https ://forums.mysql.com/list.php?25 。
许多 NDB Cluster 用户和开发人员在博客上记录了他们使用 NDB Cluster 的经验，并通过
PlanetMySQL提供了这些信息。
© Mysql 中文网
