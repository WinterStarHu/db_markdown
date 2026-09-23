# 23.7.6 启动 NDB Cluster 复制（单复制通道）_MySQL 8.0 参考手册

23.7.6 启动 NDB Cluster 复制（单复制通道）_MySQL 8.0 参考手册
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
23.7.1 NDB Cluster 复制：缩写和符号1
23.7.2 NDB Cluster 复制的一般要求1
23.7.3 NDB Cluster 复制中的已知问题1
23.7.4 NDB Cluster 复制模式和表1
23.7.5 准备 NDB Cluster 进行复制1
23.7.6 启动 NDB Cluster 复制（单复制通道）1
23.7.7 使用两个复制通道进行 NDB Cluster 复制1
23.7.8 使用 NDB Cluster 复制实现故障转移1
23.7.9 使用 NDB Cluster 复制的 NDB Cluster 备份1
23.7.10 NDB Cluster 复制：双向和循环复制1
23.7.11 NDB Cluster 复制冲突解决1
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.7 NDB 集群复制  /
23.7.6 启动 NDB Cluster 复制（单复制通道）
23.7.6 启动 NDB Cluster 复制（单复制通道）
本节概述了使用单个复制通道启动 NDB Cluster 复制的过程。
通过发出此命令启动 MySQL 复制源服务器，id此服务器的唯一 ID 在哪里（请参阅
第 23.7.2 节，“NDB Cluster 复制的一般要求”）：
shellS> mysqld --ndbcluster --server-id=id \
--log-bin --ndb-log-bin &
这将启动服务器的mysqld
进程，并使用正确的日志记录格式启用二进制日志记录。在 NDB 8.0 中也有必要NDB使用
--ndb-log-bin选项显式地启用对表更新的日志记录；这是对以前版本的 NDB Cluster 的更改，在该版本中默认启用此选项。
笔记
您还可以使用 启动源
--binlog-format=MIXED，在这种情况下，在集群之间复制时会自动使用基于行的复制。NDB Cluster 复制不支持基于语句的二进制日志记录（请参阅
第 23.7.2 节，“NDB Cluster 复制的一般要求”）。
启动 MySQL 副本服务器，如下所示：
shellR> mysqld --ndbcluster --server-id=id &
在刚刚显示的命令中，id是副本服务器的唯一 ID。没有必要在副本上启用日志记录。
笔记
除非您希望立即开始复制，否则请延迟复制线程的启动，直到
START REPLICA发出适当的语句，如下面的第 4 步所述。您可以通过
--skip-slave-start在命令行上使用选项启动副本来执行此操作，包括
skip-slave-start在副本的
my.cnf文件中，或者在 NDB 8.0.24 及更高版本中，通过设置
skip_slave_start系统变量。在 NDB 8.0.26 及更高版本中，使用
--skip-replica-startand
skip_replica_start。
有必要将副本服务器与源服务器的复制二进制日志同步。如果二进制日志记录以前没有在源上运行，请在副本上运行以下语句：
mysqlR> CHANGE MASTER TO
-> MASTER_LOG_FILE='',
-> MASTER_LOG_POS=4;
从 NDB 8.0.23 开始，您还可以使用以下语句：
mysqlR> CHANGE REPLICATION SOURCE TO
-> SOURCE_LOG_FILE='',
-> SOURCE_LOG_POS=4;
这指示副本从日志的起点开始读取源服务器的二进制日志。否则 - 也就是说，如果您使用备份从源加载数据 - 请参阅
第 23.7.8 节，“使用 NDB Cluster 复制实现故障转移”，以获取有关如何获取用于
SOURCE_LOG_FILE|
的正确值的信息。MASTER_LOG_FILE和
SOURCE_LOG_POS|
MASTER_LOG_POS在这种情况下。
最后，通过从副本上的mysql客户端
发出此命令来指示副本开始应用复制：
mysqlR> START SLAVE;
在 NDB 8.0.22 及之后的版本中，还可以使用如下语句：
mysqlR> START REPLICA;
这也启动了从源到副本的数据传输和更改。
也可以使用两个复制通道，其方式类似于下一节中描述的过程；这与使用单个复制通道之间的区别在
第 23.7.7 节，“为 NDB Cluster 复制使用两个复制通道”中介绍。
还可以通过启用批量更新来提高集群复制性能。这可以通过
在副本的mysqld
进程上设置系统变量replica_allow_batching（NDB 8.0.26 及更高版本）或
（在 NDB 8.0.26 之前）来完成。通常，更新会在收到后立即应用。但是，批处理的使用会导致更新以每批 32 KB 为单位进行应用；这可以导致更高的吞吐量和更少的 CPU 使用率，特别是在单个更新相对较小的情况下。
slave_allow_batching
笔记
批处理以每个时期为基础；属于多个事务的更新可以作为同一批次的一部分发送。
当到达纪元末尾时，将应用所有未完成的更新，即使更新总计小于 32 KB。
可以在运行时打开和关闭批处理。要在运行时激活它，您可以使用以下两个语句之一：
SET GLOBAL slave_allow_batching = 1;
SET GLOBAL slave_allow_batching = ON;
从 NDB 8.0.26 开始，您可以（并且应该）使用以下语句之一：
SET GLOBAL replica_allow_batching = 1;
SET GLOBAL replica_allow_batching = ON;
如果特定批次导致问题（例如其效果似乎没有被正确复制的语句），则可以使用以下任一语句停用批处理：
SET GLOBAL slave_allow_batching = 0;
SET GLOBAL slave_allow_batching = OFF;
从 NDB 8.0.26 开始，您可以（并且应该）使用以下语句之一：
SET GLOBAL replica_allow_batching = 0;
SET GLOBAL replica_allow_batching = OFF;SHOW VARIABLES
您可以通过适当的语句
检查当前是否正在使用批处理，例如：mysql> SHOW VARIABLES LIKE 'slave%';
在 ŃDB 8.0.26 及更高版本中，使用以下语句：
mysql> SHOW VARIABLES LIKE 'replica%';
© Mysql 中文网
