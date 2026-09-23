# 23.3.4 NDB Cluster 初始启动_MySQL 8.0 参考手册

23.3.4 NDB Cluster 初始启动_MySQL 8.0 参考手册
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
23.3.1 在 Linux 上安装 NDB Cluster1
23.3.2 在 Windows 上安装 NDB Cluster1
23.3.3 NDB Cluster 的初始配置1
23.3.4 NDB Cluster 初始启动1
23.3.5 带有表和数据的 NDB Cluster 示例1
23.3.6 NDB Cluster 的安全关闭和重启1
23.3.7 升级和降级 NDB Cluster1
23.3.8 NDB Cluster 自动安装程序（不再支持）1
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.3 NDB Cluster 安装  /
23.3.4 NDB Cluster 初始启动
23.3.4 NDB Cluster 初始启动
集群配置好后启动起来不是很困难。每个集群节点进程必须单独启动，并在它所在的主机上启动。管理节点应该首先启动，然后是数据节点，最后是任何 SQL 节点：
在管理主机上，从系统 shell 发出以下命令以启动管理节点进程：
$> ndb_mgmd --initial -f /var/lib/mysql-cluster/config.ini
第一次启动时，
必须使用
或
选项告诉ndb_mgmd在哪里可以找到它的配置文件。此选项需要
指定or
；有关详细信息，请参阅第 23.5.4 节，“ndb_mgmd - NDB Cluster Management Server Daemon”。
-f--config-file--initial--reload
在每个数据节点主机上，运行此命令以启动
ndbd进程：
$> ndbd
如果您使用 RPM 文件在 SQL 节点所在的集群主机上安装 MySQL，您可以（并且应该）使用提供的启动脚本在 SQL 节点上启动 MySQL 服务器进程。
如果一切顺利，并且集群设置正确，集群现在应该可以运行了。您可以通过调用ndb_mgm管理节点客户端来测试它。输出应与此处所示类似，但根据您使用的 MySQL 的确切版本，您可能会在输出中看到一些细微差别：
$> ndb_mgm
-- NDB Cluster -- Management Client --
ndb_mgm> SHOW
Connected to Management Server at: localhost:1186
Cluster Configuration
---------------------
[ndbd(NDB)]     2 node(s)
id=2    @198.51.100.30  (Version: 8.0.32-ndb-8.0.32, Nodegroup: 0, *)
id=3    @198.51.100.40  (Version: 8.0.32-ndb-8.0.32, Nodegroup: 0)
[ndb_mgmd(MGM)] 1 node(s)
id=1    @198.51.100.10  (Version: 8.0.32-ndb-8.0.32)
[mysqld(API)]   1 node(s)
id=4    @198.51.100.20  (Version: 8.0.32-ndb-8.0.32)
SQL 节点在这里引用为
[mysqld(API)]，这反映了
mysqld进程充当 NDB Cluster API 节点的事实。
笔记
在输出中为给定的 NDB Cluster SQL 或其他 API 节点显示的 IP 地址SHOW
是 SQL 或 API 节点用于连接到集群数据节点的地址，而不是连接到任何管理节点的地址。
您现在应该准备好在 NDB Cluster 中使用数据库、表和数据。有关简短讨论，
请参阅
第 23.3.5 节，“带有表和数据的 NDB Cluster 示例” 。
© Mysql 中文网
