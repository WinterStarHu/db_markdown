# 23.6.9 NDB Cluster 的 MySQL 服务器使用_MySQL 8.0 参考手册

23.6.9 NDB Cluster 的 MySQL 服务器使用_MySQL 8.0 参考手册
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
23.6.1 NDB Cluster Management Client 中的命令1
23.6.2 NDB Cluster 日志消息1
23.6.3 NDB Cluster 中生成的事件报告1
23.6.4 NDB Cluster 启动阶段总结1
23.6.5 执行 NDB Cluster 的滚动重启1
23.6.6 NDB Cluster 单用户模式1
23.6.7 在线添加 NDB Cluster 数据节点1
23.6.8 NDB Cluster 在线备份1
23.6.9 NDB Cluster 的 MySQL 服务器使用1
23.6.10 NDB Cluster 磁盘数据表1
23.6.11 在 NDB Cluster 中使用 ALTER TABLE 进行在线操作1
23.6.12 权限同步和 NDB_STORED_USER1
23.6.13 NDB Cluster 的文件系统加密1
23.6.14 NDB API 统计计数器和变量1
23.6.15 ndbinfo：NDB 集群信息数据库1
23.6.16 NDB Cluster 的 INFORMATION_SCHEMA 表1
23.6.17 NDB Cluster 和性能模式1
23.6.18 快速参考：NDB Cluster SQL 语句1
23.6.19 NDB Cluster 安全问题1
23.6.9 导入数据到MySQL集群1
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.6 NDB Cluster的管理  /
23.6.9 NDB Cluster 的 MySQL 服务器使用
23.6.9 NDB Cluster 的 MySQL 服务器使用
mysqld是传统的 MySQL 服务器进程。要与 NDB Cluster 一起使用， mysqld需要构建为支持NDB
存储引擎，因为它位于https://mysql.net.cn/downloads/。如果您从源代码构建 MySQL，则必须使用 or （已弃用）选项调用CMake
以
包含对.
-DWITH_NDB=1-DWITH_NDBCLUSTER=1NDB
有关从源代码编译 NDB Cluster 的更多信息，请参阅
第 23.3.1.4 节，“在 Linux 上从源代码构建 NDB Cluster”和
第 23.3.2.2 节，“在 Windows 上从源代码编译和安装 NDB Cluster”。
（有关mysqld选项和变量的信息，除了本节中讨论的那些与 NDB Cluster 相关的信息，请参阅
第 23.4.3.9 节，“NDB Cluster 的 MySQL 服务器选项和变量”。）
如果mysqld二进制文件是用集群支持构建的，NDBCLUSTER
存储引擎默认情况下仍然是禁用的。您可以使用两个可能的选项之一来启用此引擎：
在--ndbcluster启动
mysqld时用作命令行上的启动选项。
ndbcluster在文件的
[mysqld]部分
插入一行包含my.cnf。
验证您的服务器是否在启用存储引擎的情况下运行的一种简单方法是
在 MySQL 监视器 ( mysql )NDBCLUSTER中发出SHOW ENGINES语句。您应该将值视为
行中的值。如果您看到这一行，或者如果输出中没有显示这样的行，则您没有运行
启用 -enabled 的 MySQL 版本。如果您看到这一行，则需要以刚刚描述的两种方式之一启用它。
YESSupportNDBCLUSTERNONDBDISABLED
MySQL服务器要读取集群配置数据，至少需要三个信息：
MySQL服务器自身的集群节点ID
管理服务器的主机名或 IP 地址
它可以连接到管理服务器的 TCP/IP 端口号
节点 ID 可以动态分配，因此没有必要明确指定它们。
mysqld参数
ndb-connectstring用于在启动
mysqld时或在my.cnf. 连接字符串包含可以找到管理服务器的主机名或 IP 地址，以及它使用的 TCP/IP 端口。
下面的例子中，ndb_mgmd.mysql.com是管理服务器所在的主机，管理服务器在1186端口监听集群消息：
$> mysqld --ndbcluster --ndb-connectstring=ndb_mgmd.mysql.com:1186
有关连接字符串的更多信息，请参阅第 23.4.3.3 节，“NDB Cluster 连接字符串”。
有了这些信息，MySQL 服务器就可以充当集群的完整参与者。（我们通常将以这种方式运行的
mysqld进程称为 SQL 节点。）它充分了解所有集群数据节点及其状态，并与所有数据节点建立连接。在这种情况下，它可以使用任何数据节点作为事务协调器并读取和更新节点数据。
您可以在mysql客户端中查看是否有 MySQL 服务器使用 连接到集群SHOW
PROCESSLIST。如果 MySQL 服务器连接到集群，并且您有PROCESS
权限，那么输出的第一行如下所示：
mysql> SHOW PROCESSLIST \G
*************************** 1. row ***************************
Id: 1
User: system user
Host:
db:
Command: Daemon
Time: 1
State: Waiting for event from ndbcluster
Info: NULL
重要的
要参与 NDB Cluster，mysqld
进程必须同时使用选项--ndbcluster和
--ndb-connectstring（或它们在 中的等效项my.cnf）启动。如果
mysqld仅以该
--ndbcluster选项启动，或者无法联系集群，则无法使用
NDB表，也无法创建任何新表，而不管存储引擎如何。后一个限制是一种安全措施，旨在防止创建与以下名称相同的表NDB表，而 SQL 节点未连接到集群。如果您希望在mysqld
进程未参与 NDB Cluster 时使用不同的存储引擎创建表，则必须在没有该
--ndbcluster选项的情况下重新启动服务器。
© Mysql 中文网
