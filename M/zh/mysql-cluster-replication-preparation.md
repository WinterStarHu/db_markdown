# 23.7.5 准备 NDB Cluster 进行复制_MySQL 8.0 参考手册

23.7.5 准备 NDB Cluster 进行复制_MySQL 8.0 参考手册
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
23.7.5 准备 NDB Cluster 进行复制
23.7.5 准备 NDB Cluster 进行复制
准备 NDB Cluster 进行复制包括以下步骤：
检查所有 MySQL 服务器的版本兼容性（请参阅
第 23.7.2 节，“NDB Cluster 复制的一般要求”）。
使用以下两条 SQL 语句在具有适当权限的源集群上创建一个复制帐户：
mysqlS> CREATE USER 'replica_user'@'replica_host'
-> IDENTIFIED BY 'replica_password';
mysqlS> GRANT REPLICATION SLAVE ON *.*
-> TO 'replica_user'@'replica_host';
在前面的语句中，
replica_user是复制帐户用户名，replica_host是副本的主机名或 IP 地址，
replica_password是分配给该帐户的密码。
例如，要创建一个名为 的副本用户帐户，
myreplica从名为 的主机登录
replica-host并使用密码
53cr37，请使用以下
CREATE USER和
GRANT语句：
mysqlS> CREATE USER 'myreplica'@'replica-host'
-> IDENTIFIED BY '53cr37';
mysqlS> GRANT REPLICATION SLAVE ON *.*
-> TO 'myreplica'@'replica-host';
出于安全原因，最好为复制帐户使用唯一的用户帐户（不用于任何其他目的）。
设置副本以使用源。使用
mysql客户端，这可以通过CHANGE REPLICATION SOURCE
TO语句（从 NDB 8.0.23 开始）或
CHANGE MASTER TO语句（在 NDB 8.0.23 之前）完成：
mysqlR> CHANGE MASTER TO
-> MASTER_HOST='source_host',
-> MASTER_PORT=source_port,
-> MASTER_USER='replica_user',
-> MASTER_PASSWORD='replica_password';
从 NDB 8.0.23 开始，您还可以使用以下语句：
mysqlR> CHANGE REPLICATION SOURCE TO
-> SOURCE_HOST='source_host',
-> SOURCE_PORT=source_port,
-> SOURCE_USER='replica_user',
-> SOURCE_PASSWORD='replica_password';
在前面的语句中，
source_host是复制源的主机名或IP地址，
source_port是副本连接到源时使用的端口，是在源
replica_user上为副本设置的用户名
，是为副本replica_password设置的密码该用户帐户在上一步中。
例如，要告诉副本使用主机名为rep-source上一步创建的复制帐户的 MySQL 服务器，请使用以下语句：
mysqlR> CHANGE MASTER TO
-> MASTER_HOST='rep-source',
-> MASTER_PORT=3306,
-> MASTER_USER='myreplica',
-> MASTER_PASSWORD='53cr37';
从 NDB 8.0.23 开始，您还可以使用以下语句：
mysqlR> CHANGE REPLICATION SOURCE TO
-> SOURCE_HOST='rep-source',
-> SOURCE_PORT=3306,
-> SOURCE_USER='myreplica',
-> SOURCE_PASSWORD='53cr37';
有关可与此语句一起使用的选项的完整列表，请参阅第 13.4.2.1 节，“CHANGE MASTER TO 语句”。
要提供复制备份功能，您还需要在开始复制过程之前向--ndb-connectstring副本的文件添加一个选项。my.cnf有关详细信息，请参阅
第 23.7.9 节，“使用 NDB Cluster 复制的 NDB Cluster 备份”。
有关可以
my.cnf为副本设置的其他选项，请参阅
第 17.1.6 节，“复制和二进制日志记录选项和变量”。
如果源集群已在使用中，您可以创建源的备份并将其加载到副本上，以减少副本与源同步所需的时间。如果副本也在运行 NDB Cluster，这可以使用
第 23.7.9 节，“使用 NDB Cluster 复制的 NDB Cluster 备份”中描述的备份和恢复过程来完成。
ndb-connectstring=management_host[:port]
如果您没有在副本上使用 NDB Cluster，则可以在源上使用此命令创建备份：
shellS> mysqldump --master-data=1
然后通过将转储文件复制到副本，将生成的数据转储导入副本。在此之后，您可以使用
mysql客户端将转储文件中的数据导入副本数据库，如下所示，其中
是在源上使用mysqldumpdump_file生成的文件的名称，是要复制的数据库的名称:
db_nameshellR> mysql -u root -p db_name < dump_file有关与mysqldump
一起使用的选项的完整列表
，请参阅第 4.5.4 节，“mysqldump — 数据库备份程序”。
笔记
如果以这种方式将数据复制到副本，请确保在加载所有数据之前停止副本尝试连接到源以开始复制。您可以通过
--skip-slave-start在命令行上使用选项启动副本来执行此操作，包括
skip-slave-start在副本的
my.cnf文件中，或者从 NDB 8.0.24 开始，通过设置
skip_slave_start系统变量。从 NDB 8.0.26 开始，使用
--skip-replica-startor
skip_replica_start代替。数据加载完成后，请按照接下来两节中概述的其他步骤进行操作。
确保为每个充当复制源的 MySQL 服务器分配一个唯一的服务器 ID，并使用基于行的格式启用二进制日志记录。（请参阅
第 17.2.1 节，“复制格式”。）此外，我们强烈建议启用
replica_allow_batching系统变量（NDB 8.0.26 及更高版本；在 NDB 8.0.26 之前，使用
slave_allow_batching）。从 NDB 8.0.30 开始，默认情况下启用此功能。
如果您使用的是 NDB 8.0.30 之前的 NDB Cluster 版本，您还应该考虑增加与
--ndb-batch-size和
--ndb-blob-write-batch-bytes
选项一起使用的值。在 NDB 8.0.30 及更高版本中，用于
--ndb-replica-batch-size设置用于在副本上写入的批大小而不是
--ndb-batch-size，
--ndb-replica-blob-write-batch-bytes
而不是--ndb-blob-write-batch-bytes确定复制应用程序用于写入 blob 数据的批大小。所有这些选项都可以在源服务器的my.cnf文件中设置，或者在启动源
mysqld进程时在命令行上设置。看
第 23.7.6 节，“启动 NDB Cluster 复制（单一复制通道）”，了解更多信息。
© Mysql 中文网
