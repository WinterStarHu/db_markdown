# 23.3.3 NDB Cluster 的初始配置_MySQL 8.0 参考手册

23.3.3 NDB Cluster 的初始配置_MySQL 8.0 参考手册
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
23.3.3 NDB Cluster 的初始配置
23.3.3 NDB Cluster 的初始配置
在本节中，我们讨论通过创建和编辑配置文件来手动配置已安装的 NDB Cluster。
对于我们的四节点、四主机 NDB Cluster（请参阅
集群节点和主机计算机），有必要编写四个配置文件，每个节点主机一个。
每个数据节点或 SQL 节点都需要一个
my.cnf提供两部分信息的文件：一个连接字符串，告诉节点在哪里可以找到管理节点，还有一行告诉该主机（托管数据节点的机器）上的 MySQL 服务器启用NDBCLUSTER存储引擎
。
有关连接字符串的更多信息，请参阅
第 23.4.3.3 节，“NDB Cluster 连接字符串”。
管理节点需要一个config.ini
文件来告诉它要维护多少分片副本，每个数据节点上要为数据和索引分配多少内存，到哪里找数据节点，每个数据节点上要将数据保存到磁盘的什么位置，从哪里去找到任何 SQL 节点。
配置数据节点和 SQL 节点。 my.cnf数据节点所需
的文件非常简单。配置文件应位于/etc目录中，并且可以使用任何文本编辑器进行编辑。（如果该文件不存在，则创建该文件。）例如：
$> vi /etc/my.cnf
笔记
我们在这里展示了vi是用来创建文件的，但是任何文本编辑器都应该可以正常工作。
对于我们示例设置中的每个数据节点和 SQL 节点，
my.cnf应该如下所示：
[mysqld]
# Options for mysqld process:
ndbcluster                      # run NDB storage engine
[mysql_cluster]
# Options for NDB Cluster processes:
ndb-connectstring=198.51.100.10  # location of management server
输入上述信息后，保存此文件并退出文本编辑器。为托管数据节点
“ A ”、数据节点“ B ”和 SQL 节点的机器执行此操作。
重要的
如前所示，一旦您使用文件的and
部分中
的and
参数
启动了mysqld进程，您就无法在没有实际启动集群的情况下执行任何or
语句。否则，这些语句会因错误而失败。这是设计使然。
ndbclusterndb-connectstring[mysqld][mysql_cluster]my.cnfCREATE TABLEALTER TABLE
配置管理节点。
配置管理节点的第一步是创建可以在其中找到配置文件的目录，然后创建文件本身。例如（运行为
root）：
$> mkdir /var/lib/mysql-cluster
$> cd /var/lib/mysql-cluster
$> vi config.ini
对于我们的代表性设置，该config.ini
文件应如下所示：
[ndbd default]
# Options affecting ndbd processes on all data nodes:
NoOfReplicas=2    # Number of fragment replicas
DataMemory=98M    # How much memory to allocate for data storage
[ndb_mgmd]
# Management process options:
HostName=198.51.100.10          # Hostname or IP address of management node
DataDir=/var/lib/mysql-cluster  # Directory for management node log files
[ndbd]
# Options for data node "A":
# (one [ndbd] section per data node)
HostName=198.51.100.30          # Hostname or IP address
NodeId=2                        # Node ID for this data node
DataDir=/usr/local/mysql/data   # Directory for this data node's data files
[ndbd]
# Options for data node "B":
HostName=198.51.100.40          # Hostname or IP address
NodeId=3                        # Node ID for this data node
DataDir=/usr/local/mysql/data   # Directory for this data node's data files
[mysqld]
# SQL node options:
HostName=198.51.100.20          # Hostname or IP address
# (additional mysqld connections can be
# specified for this node for various
# purposes such as running ndb_restore)
笔记
该world数据库可以从
https://mysql.net.cn/doc/index-other.html下载。
创建所有配置文件并指定这些最少的选项后，您就可以继续启动集群并验证所有进程是否都在运行。我们在第 23.3.4 节，“NDB Cluster 的初始启动”中讨论了这是如何完成的
。
有关可用的 NDB Cluster 配置参数及其用途的更多详细信息，请参阅
第 23.4.3 节，“NDB Cluster 配置文件”和
第 23.4 节，“NDB Cluster 的配置”。有关与备份相关的 NDB Cluster 配置，请参阅
第 23.6.8.3 节，“NDB Cluster 备份的配置”。
笔记
Cluster管理节点默认端口为1186；数据节点的默认端口是2202。但是，集群可以自动从已经空闲的数据节点中分配端口给数据节点。
© Mysql 中文网
