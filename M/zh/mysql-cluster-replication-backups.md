# 23.7.9 使用 NDB Cluster 复制的 NDB Cluster 备份_MySQL 8.0 参考手册

23.7.9 使用 NDB Cluster 复制的 NDB Cluster 备份_MySQL 8.0 参考手册
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
23.7.9.1 NDB Cluster 复制：自动将副本同步到源二进制日志
23.7.9.2 使用 NDB Cluster 复制的时间点恢复
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
23.7.9 使用 NDB Cluster 复制的 NDB Cluster 备份
23.7.9 使用 NDB Cluster 复制的 NDB Cluster 备份
23.7.9.1 NDB Cluster 复制：自动将副本同步到源二进制日志23.7.9.2 使用 NDB Cluster 复制的时间点恢复
本节讨论使用 NDB Cluster 复制进行备份和恢复。我们假设复制服务器已经如前所述进行了配置（请参阅
第 23.7.5 节，“为复制准备 NDB Cluster”，以及紧随其后的部分）。完成后，进行备份然后从中恢复的过程如下：
有两种不同的方法可以启动备份。
方法 A。
此方法要求在开始复制过程之前，先前在源服务器上启用了集群备份过程。这可以通过在 的一个
[mysql_cluster]部分中
包含以下行来完成my.cnf file，其中
是源集群management_host的管理服务器的 IP 地址或主机名，
是管理服务器的端口号：
NDBportndb-connectstring=management_host[:port]
笔记
仅当未使用默认端口 (1186) 时才需要指定端口号。有关 NDB Cluster中的端口和端口分配的更多信息，
请参阅
第 23.3.3 节，“NDB Cluster 的初始配置” 。
在这种情况下，可以通过在复制源上执行以下语句来启动备份：
shellS> ndb_mgm -e "START BACKUP"方法 B。
如果my.cnf文件没有指定在哪里可以找到管理主机，您可以通过将此信息
NDB作为START
BACKUP命令的一部分传递给管理客户端来启动备份过程。这可以如此处所示完成，其中management_host
和port是管理服务器的主机名和端口号：
shellS> ndb_mgm management_host:port -e "START BACKUP"
在我们前面概述的场景中（请参阅
第 23.7.5 节，“为复制准备 NDB Cluster”），这将按如下方式执行：
shellS> ndb_mgm rep-source:1186 -e "START BACKUP"
将集群备份文件复制到正在联机的副本。为源集群运行
ndbd进程的每个系统上都有集群备份文件，
所有这些文件都必须复制到副本以确保成功恢复。可以将备份文件复制到副本管理主机所在的计算机上的任何目录，只要 MySQL 和 NDB 二进制文件在该目录中具有读取权限即可。在这种情况下，我们假设这些文件已被复制到目录/var/BACKUPS/BACKUP-1中。
虽然副本集群不必具有与源相同数量的数据节点，但强烈建议该数量相同。有
必要在副本服务器启动时阻止复制进程启动。您可以通过
--skip-slave-start在命令行上使用选项启动副本来执行此操作，包括
skip-slave-start在副本的
my.cnf文件中，或者在 NDB 8.0.24 或更高版本中，通过设置
skip_slave_start系统变量。
在副本集群上创建存在于源集群上并且要被复制的任何数据库。
重要的
必须在副本集群中的每个 SQL 节点上执行与每个要复制的数据库对应
的CREATE DATABASE（或
）语句。CREATE
SCHEMA
在mysql客户端
中使用此语句重置副本集群
：
mysqlR> RESET SLAVE;
在 NDB 8.0.22 或更高版本中，您还可以使用此语句：
mysqlR> RESET REPLICA;
您现在可以依次对每个备份文件使用ndb_restore命令在副本上启动集群恢复过程。对于其中的第一个，有必要包括-m恢复集群元数据的选项，如下所示：
shellR> ndb_restore -c replica_host:port -n node-id \
-b backup-id -m -r dir
dir是副本上放置备份文件的目录的路径。对于与剩余备份文件对应的ndb_restore命令，不应-m使用该选项。
为了从具有四个数据节点的源集群（如
第 23.7 节，“NDB 集群复制”中的图中所示）恢复，其中备份文件已复制到目录
/var/BACKUPS/BACKUP-1，要在副本上执行的正确命令序列可能看起来像这样：
shellR> ndb_restore -c replica-host:1186 -n 2 -b 1 -m \
-r ./var/BACKUPS/BACKUP-1
shellR> ndb_restore -c replica-host:1186 -n 3 -b 1 \
-r ./var/BACKUPS/BACKUP-1
shellR> ndb_restore -c replica-host:1186 -n 4 -b 1 \
-r ./var/BACKUPS/BACKUP-1
shellR> ndb_restore -c replica-host:1186 -n 5 -b 1 -e \
-r ./var/BACKUPS/BACKUP-1
重要的
此示例中最终调用ndb_restore中
的-e(or
) 选项是确保将纪元写入副本
表所必需的。没有此信息，副本无法与源正确同步。（请参阅
第 23.5.23 节，“ndb_restore - 恢复 NDB Cluster 备份”。）
--restore-epochmysql.ndb_apply_status
ndb_apply_status现在您需要从副本上的表
中获取最新的纪元
（如第 23.7.8 节，“使用 NDB Cluster 复制实现故障转移”中所讨论的）：
mysqlR> SELECT @latest:=MAX(epoch)
FROM mysql.ndb_apply_status;
将@latest上一步得到的epoch值作为源上的
表，就可以得到@pos正确二进制日志文件中的正确起始位置。
此处显示的查询从逻辑恢复位置之前应用的最后一个纪元
的和列中获取这些信息
：@filemysql.ndb_binlog_indexPositionFilemysqlS> SELECT
->     @file:=SUBSTRING_INDEX(File, '/', -1),
->     @pos:=Position
-> FROM mysql.ndb_binlog_index
-> WHERE epoch > @latest
-> ORDER BY epoch ASC LIMIT 1;
如果当前没有复制流量，您可以通过
SHOW MASTER STATUS在源上运行并使用
Position文件输出列中显示的值来获取类似的信息，该文件的名称具有在所有文件中显示的最大值的后缀File柱子。在这种情况下，您必须确定这是哪个文件，并在下一步中手动或通过使用脚本解析输出来提供名称。
使用在上一步中获得的值，您现在可以在副本的
mysql客户端中发出适当的命令。在 NDB 8.0.23 及更高版本中，使用以下CHANGE REPLICATION SOURCE
TO语句：
mysqlR> CHANGE REPLICATION SOURCE TO
->     SOURCE_LOG_FILE='@file',
->     SOURCE_LOG_POS=@pos;
在 NDB 8.0.23 之前，您必须使用
CHANGE MASTER TO此处显示的语句：
mysqlR> CHANGE MASTER TO
->     MASTER_LOG_FILE='@file',
->     MASTER_LOG_POS=@pos;
现在副本知道从哪个二进制日志文件中的哪个点开始从源读取数据，您可以使用以下语句使副本开始复制：
mysqlR> START SLAVE;
从 NDB 8.0.22 开始，您还可以使用以下语句：
mysqlR> START REPLICA;
要在第二个复制通道上执行备份和恢复，只需重复这些步骤，在适当的地方用次要源和副本的主机名和 ID 替换主要源和副本服务器的主机名和 ID，并运行前面的语句在他们。
有关执行 Cluster 备份和从备份恢复 Cluster 的其他信息，请参阅
第 23.6.8 节，“NDB Cluster 的在线备份”。
© Mysql 中文网
