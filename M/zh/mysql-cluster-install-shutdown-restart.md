# 23.3.6 NDB Cluster 的安全关闭和重启_MySQL 8.0 参考手册

23.3.6 NDB Cluster 的安全关闭和重启_MySQL 8.0 参考手册
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
23.3.6 NDB Cluster 的安全关闭和重启
23.3.6 NDB Cluster 的安全关闭和重启
要关闭集群，请在托管管理节点的机器上的 shell 中输入以下命令：
$> ndb_mgm -e shutdown
此处的-e选项用于从 shell 向ndb_mgm客户端传递命令。该命令导致ndb_mgm、
ndb_mgmd和任何ndbd或
ndbmtd进程正常终止。可以使用mysqladmin shutdown和其他方式终止任何 SQL 节点。在 Windows 平台上，假设您已将 SQL 节点安装为 Windows 服务，您可以使用SC STOP
service_name或NET STOPservice_name。
要在 Unix 平台上重新启动集群，请运行以下命令：
在管理主机上（198.51.100.10在我们的示例设置中）：
$> ndb_mgmd -f /var/lib/mysql-cluster/config.ini
在每个数据节点主机（198.51.100.30和
198.51.100.40）上：
$> ndbd
使用ndb_mgm客户端验证两个数据节点是否已成功启动。
在 SQL 主机 ( 198.51.100.20) 上：
$> mysqld_safe &
在 Windows 平台上，假设您已使用默认服务名称将所有 NDB Cluster 进程安装为 Windows 服务（请参阅
第 23.3.2.4 节，“将 NDB Cluster 进程安装为 Windows 服务”），您可以按如下方式重新启动集群：
在管理主机上（198.51.100.10在我们的示例设置中），执行以下命令：
C:\> SC START ndb_mgmd
在每个数据节点主机（198.51.100.30和
198.51.100.40）上，执行以下命令：
C:\> SC START ndbd
在管理节点主机上，使用
ndb_mgm客户端验证管理节点和两个数据节点是否已成功启动（请参阅
第 23.3.2.3 节，“Windows 上 NDB Cluster 的初始启动”）。
在 SQL 节点主机 ( 198.51.100.20) 上，执行以下命令：
C:\> SC START mysql
在生产环境中，通常不希望完全关闭集群。在许多情况下，即使在进行配置更改或对集群硬件或软件（或两者）进行升级时，都需要关闭单个主机，也可以通过执行
滚动操作而无需关闭整个集群。重启集群。有关执行此操作的更多信息，请参阅
第 23.6.5 节，“执行 NDB Cluster 的滚动重启”。
© Mysql 中文网
