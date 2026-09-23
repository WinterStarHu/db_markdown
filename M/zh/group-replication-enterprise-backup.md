# 18.5.6 将 MySQL 企业备份与组复制一起使用_MySQL 8.0 参考手册

18.5.6 将 MySQL 企业备份与组复制一起使用_MySQL 8.0 参考手册
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
18.3 要求和限制
18.4 监控组复制
18.5 组复制操作
18.5.1 配置在线群组1
18.5.2 重启组1
18.5.3 交易一致性保证1
18.5.4 分布式恢复1
18.5.5 支持 IPv6 和混合 IPv6 和 IPv4 组1
18.5.6 将 MySQL 企业备份与组复制一起使用1
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
MySQL 8.0 参考手册  / 第十八章 组复制  / 18.5 组复制操作  /
18.5.6 将 MySQL 企业备份与组复制一起使用
18.5.6 将 MySQL 企业备份与组复制一起使用
MySQL Enterprise Backup是 MySQL Server 的商业许可备份实用程序，可用于
MySQL Enterprise Edition。本节介绍如何使用 MySQL Enterprise Backup 备份和随后恢复组复制成员。可以使用相同的技术将新成员快速添加到组中。
使用 MySQL Enterprise Backup 备份组复制成员
备份组复制成员类似于备份独立的 MySQL 实例。以下说明假设您已经熟悉如何使用 MySQL Enterprise Backup 执行备份；如果不是这种情况，请查看
MySQL Enterprise Backup 8.0 用户指南，尤其是
备份数据库服务器。另请注意向备份管理员授予 MySQL 权限和
使用 MySQL Enterprise Backup 进行组复制中描述的要求。
考虑以下具有三个成员的组
s1，s2， 和
s3，在具有相同名称的主机上运行：
mysql> SELECT member_host, member_port, member_state FROM performance_schema.replication_group_members;
+-------------+-------------+--------------+
| member_host | member_port | member_state |
+-------------+-------------+--------------+
| s1          |        3306 | ONLINE       |
| s2          |        3306 | ONLINE       |
| s3          |        3306 | ONLINE       |
+-------------+-------------+--------------+s2使用 MySQL Enterprise Backup，通过在其主机上发出以下命令来
创建备份：s2> mysqlbackup --defaults-file=/etc/my.cnf --backup-image=/backups/my.mbi_`date +%d%m_%H%M` \
--backup-dir=/backups/backup_`date +%d%m_%H%M` --user=root -p \
--host=127.0.0.1 backup-to-image
笔记
对于 MySQL Enterprise Backup 8.0.18 及更早版本，如果系统变量
sql_require_primary_key设置ON为组，则 MySQL Enterprise Backup 无法记录服务器上的备份进度。这是因为backup_progress服务器上的表是 CSV 表，不支持主键。在这种情况下， mysqlbackup
在备份操作期间发出以下警告：
181011 11:17:06 MAIN WARNING: MySQL query 'CREATE TABLE IF NOT EXISTS
mysql.backup_progress( `backup_id` BIGINT NOT NULL, `tool_name` VARCHAR(4096)
NOT NULL, `error_code` INT NOT NULL, `error_message` VARCHAR(4096) NOT NULL,
`current_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP               ON
UPDATE CURRENT_TIMESTAMP,`current_state` VARCHAR(200) NOT NULL ) ENGINE=CSV
DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin': 3750, Unable to create a table
without PK, when system variable 'sql_require_primary_key' is set. Add a PK
to the table or unset this variable to avoid this message. Note that tables
without PK can cause performance problems in row-based replication, so please
consult your DBA before changing this setting.
181011 11:17:06 MAIN WARNING: This backup operation's progress info cannot be
logged.
这不会阻止mysqlbackup完成备份。
对于 MySQL Enterprise Backup 8.0.20 及更早版本，在备份次要成员时，由于 MySQL Enterprise Backup 无法将备份状态和元数据写入只读服务器实例，因此在备份操作期间可能会发出类似以下警告：
181113 21:31:08 MAIN WARNING: This backup operation cannot write to backup
progress. The MySQL server is running with the --super-read-only option.
您可以通过将
--no-history-logging选项与备份命令一起使用来避免警告。这不是 MySQL Enterprise Backup 8.0.21 及更高版本的问题——有关详细信息，请参阅使用 MySQL Enterprise Backup 和 Group Replication。
恢复失败的成员
假设其中一个成员（s3在下面的示例中）被不可调和地破坏了。组成员的最新备份s2可用于恢复
s3。以下是执行还原的步骤：
将 s2 的备份复制到 s3 的主机上。复制备份的确切方法取决于您可用的操作系统和工具。在此示例中，我们假设主机都是 Linux 服务器并使用 SCP 在它们之间复制文件：
s2/backups> scp my.mbi_2206_1429 s3:/backups
恢复备份。连接到目标主机（s3本例中的主机），并使用 MySQL Enterprise Backup 恢复备份。以下是步骤：
停止损坏的服务器（如果它仍在运行）。例如，在使用 systemd 的 Linux 发行版上：
s3> systemctl stop mysqld
将这两个配置文件保存在损坏的服务器的数据目录中，auto.cnf并且
mysqld-auto.cnf（如果存在）将它们复制到数据目录之外的安全位置。这是为了保留
服务器的 UUID
和第 5.1.9.3 节“持久化系统变量”（如果使用），它们在以下步骤中是必需的。
删除.data目录下的所有内容
s3。例如：
s3> rm -rf /var/lib/mysql/*
如果系统变量
innodb_data_home_dir,
innodb_log_group_home_dir, 和innodb_undo_directory
指向除数据目录以外的任何目录，也应将它们设为空；否则，恢复操作失败。
将备份恢复s2到主机上
s3：
s3> mysqlbackup --defaults-file=/etc/my.cnf \
--datadir=/var/lib/mysql \
--backup-image=/backups/my.mbi_2206_1429  \
--backup-dir=/tmp/restore_`date +%d%m_%H%M` copy-back-and-apply-log
笔记
上面的命令假定二进制日志和中继日志在两台服务器s2上s3
具有相同的基本名称并且位于相同的位置。如果不满足这些条件，您应该使用--log-bin和
--relay-log选项将二进制日志和中继日志恢复到它们在s3. 例如，如果您知道s3二进制日志的基本名称是s3-bin并且中继日志的基本名称是s3-relay-bin，那么您的恢复命令应该如下所示：
mysqlbackup --defaults-file=/etc/my.cnf \
--datadir=/var/lib/mysql \
--backup-image=/backups/my.mbi_2206_1429  \
--log-bin=s3-bin --relay-log=s3-relay-bin \
--backup-dir=/tmp/restore_`date +%d%m_%H%M` copy-back-and-apply-log
能够将二进制日志和中继日志恢复到正确的文件路径使恢复过程更容易；如果由于某种原因无法做到这一点，请参阅
重建失败的成员以作为新成员重新加入。
恢复auto.cnfs3 的文件。要重新加入复制组，恢复的成员必须具有与
server_uuid之前加入组时相同的成员。auto.cnf通过将上面步骤 2 中保留的文件复制到已恢复成员的数据目录中来
提供旧服务器 UUID
笔记
如果无法
server_uuid通过恢复旧auto.cnf
文件的方式将失败成员的原件提供给恢复成员，则必须让恢复成员作为新成员加入群组；请参阅
下面重建失败的成员以作为新成员重新加入中的说明，了解如何执行此操作。
恢复mysqld-auto.cnf
s3 的文件（仅当 s3 使用持久系统变量时才需要）。用于配置故障成员的
第 5.1.9.3 节“持久化系统变量”的设置必须提供给恢复的成员。这些设置可以在
mysqld-auto.cnf发生故障的服务器的文件中找到，您应该在上面的第 2 步中保留该文件。将文件还原到还原服务器的数据目录。
如果您没有该文件的副本，
请参阅
恢复持久性系统变量了解该怎么做。
启动还原的服务器。例如，在使用 systemd 的 Linux 发行版上：
systemctl start mysqld
笔记
如果要还原的服务器是主要成员，请
在启动还原的服务器之前执行还原
主要成员中描述的步骤。
重新启动组复制。s3使用例如
mysql客户端连接到重新启动服务器，并发出以下命令：
mysql> START GROUP_REPLICATION;
在恢复的实例成为该组的在线成员之前，它需要应用备份后发生在该组上的任何事务；这是使用 Group Replication 的
分布式恢复机制实现的，并且该过程在
发出START GROUP_REPLICATION语句后启动。要检查已恢复实例的成员状态，请发出：
mysql> SELECT member_host, member_port, member_state FROM performance_schema.replication_group_members;
+-------------+-------------+--------------+
| member_host | member_port | member_state |
+-------------+-------------+--------------+
| s1          |        3306 | ONLINE       |
| s2          |        3306 | ONLINE       |
| s3          |        3306 | RECOVERING   |
+-------------+-------------+--------------+
这表明s3正在应用交易追赶集团。一旦它赶上了小组的其他成员，它member_state就会变为ONLINE：
mysql> SELECT member_host, member_port, member_state FROM performance_schema.replication_group_members;
+-------------+-------------+--------------+
| member_host | member_port | member_state |
+-------------+-------------+--------------+
| s1          |        3306 | ONLINE       |
| s2          |        3306 | ONLINE       |
| s3          |        3306 | ONLINE       |
+-------------+-------------+--------------+
笔记
如果您要恢复的服务器是主要成员，一旦它与组同步并成为
，请执行恢复主要成员ONLINE末尾描述的步骤
以恢复您在启动服务器之前对服务器所做的配置更改。
该成员现已从备份中完全恢复，并作为该组的普通成员发挥作用。
重建失败的成员以重新加入为新成员
有时，无法执行上述
恢复失败成员中概述的步骤，例如，因为二进制日志或中继日志已损坏，或者它只是从备份中丢失。在这种情况下，使用备份重建成员，然后将其作为新成员添加到组中。在下面的步骤中，我们假设重建的成员名为s3，与失败的成员一样，并且它与 运行在同一主机上
s3：
将 s2 的备份复制到 s3 的主机上。复制备份的确切方法取决于您可用的操作系统和工具。在此示例中，我们假设主机都是 Linux 服务器并使用 SCP 在它们之间复制文件：
s2/backups> scp my.mbi_2206_1429 s3:/backups
恢复备份。连接到目标主机（s3本例中的主机），并使用 MySQL Enterprise Backup 恢复备份。以下是步骤：
停止损坏的服务器（如果它仍在运行）。例如，在使用 systemd 的 Linux 发行版上：
s3> systemctl stop mysqld
如果在损坏的服务器的数据目录中找到配置文件
mysqld-auto.cnf，请将其复制到数据目录之外的安全位置。这是为了保留服务器的
Section 5.1.9.3, “Persisted System Variables”，稍后需要。
删除.data目录下的所有内容
s3。例如：
s3> rm -rf /var/lib/mysql/*
如果系统变量
innodb_data_home_dir,
innodb_log_group_home_dir, 和innodb_undo_directory
指向除数据目录以外的任何目录，也应将它们设为空；否则，恢复操作失败。
将 的备份还原s2到 的主机上s3。通过这种方法，我们正在重建s3为一个新成员，为此我们不需要或不想在备份中使用旧的二进制和中继日志；因此，如果这些日志已包含在您的备份中，请使用--skip-binlog和
--skip-relaylog选项排除它们：
s3> mysqlbackup --defaults-file=/etc/my.cnf \
--datadir=/var/lib/mysql \
--backup-image=/backups/my.mbi_2206_1429  \
--backup-dir=/tmp/restore_`date +%d%m_%H%M` \
--skip-binlog --skip-relaylog \
copy-back-and-apply-log
笔记
如果您的备份中有健康的二进制日志和中继日志，您可以毫无问题地传输到目标主机，建议您按照
上面恢复失败的成员中描述的更简单的过程进行操作
。
恢复mysqld-auto.cnf
s3 的文件（仅当 s3 使用持久系统变量时才需要）。用于配置故障成员的
第 5.1.9.3 节“持久化系统变量”的设置必须提供给恢复的服务器。这些设置可以在
mysqld-auto.cnf发生故障的服务器的文件中找到，您应该在上面的第 2 步中保留该文件。将文件还原到还原服务器的数据目录。
如果您没有该文件的副本，
请参阅
恢复持久性系统变量了解该怎么做。
笔记
不要将损坏的服务器
auto.cnf文件恢复到新成员的数据目录——当重建s3
的作为新成员加入组时，它将被分配一个新的服务器 UUID。
启动还原的服务器。例如，在使用 systemd 的 Linux 发行版上：
systemctl start mysqld
笔记
如果要还原的服务器是主要成员，请
在启动还原的服务器之前执行还原
主要成员中描述的步骤。
重新配置恢复的成员以加入组复制。使用mysql客户端连接到还原的服务器，
并使用以下命令重置源和副本信息：
mysql> RESET MASTER;mysql> RESET SLAVE ALL;
Or from MySQL 8.0.22:
mysql> RESET REPLICA ALL;
为了使恢复的服务器能够使用 Group Replication 的内置
分布式恢复机制自动恢复，请配置服务器的
gtid_executed变量。为此，请使用 的backup_gtid_executed.sql
备份中包含的文件，该文件s2通常在已恢复成员的数据目录下恢复。禁用二进制日志记录，使用该
backup_gtid_executed.sql文件进行配置gtid_executed，然后通过使用mysql客户端发出以下语句来重新启用二进制日志记录：
mysql> SET SQL_LOG_BIN=OFF;
mysql> SOURCE datadir/backup_gtid_executed.sql
mysql> SET SQL_LOG_BIN=ON;
然后，在成员上配置
组复制用户凭据：
mysql> CHANGE MASTER TO MASTER_USER='rpl_user', MASTER_PASSWORD='password' /
FOR CHANNEL 'group_replication_recovery';
Or from MySQL 8.0.23:
mysql> CHANGE REPLICATION SOURCE TO SOURCE_USER='rpl_user', SOURCE_PASSWORD='password' /
FOR CHANNEL 'group_replication_recovery';
重新启动组复制。使用mysql客户端向已恢复的服务器发出以下命令
：
mysql> START GROUP_REPLICATION;
在恢复的实例成为该组的在线成员之前，它需要应用备份后发生在该组上的任何事务；这是使用 Group Replication 的
分布式恢复机制实现的，并且该过程在
发出START GROUP_REPLICATION语句后启动。要检查已恢复实例的成员状态，请发出：
mysql> SELECT member_host, member_port, member_state FROM performance_schema.replication_group_members;
+-------------+-------------+--------------+
| member_host | member_port | member_state |
+-------------+-------------+--------------+
| s3          |        3306 | RECOVERING   |
| s2          |        3306 | ONLINE       |
| s1          |        3306 | ONLINE       |
+-------------+-------------+--------------+
这表明s3正在应用交易追赶集团。一旦它赶上了小组的其他成员，它member_state就会变为ONLINE：
mysql> SELECT member_host, member_port, member_state FROM performance_schema.replication_group_members;
+-------------+-------------+--------------+
| member_host | member_port | member_state |
+-------------+-------------+--------------+
| s3          |        3306 | ONLINE       |
| s2          |        3306 | ONLINE       |
| s1          |        3306 | ONLINE       |
+-------------+-------------+--------------+
笔记
如果您要恢复的服务器是主要成员，一旦它与组同步并成为
，请执行恢复主要成员ONLINE末尾描述的步骤
以恢复您在启动服务器之前对服务器所做的配置更改。
该成员现已作为新成员恢复到群组中。
恢复持久化的系统变量。
mysqlbackup不支持备份或保留
第 5.1.9.3 节，“持久化系统变量” ——该文件
mysqld-auto.cnf不包含在备份中。要使用其持久变量设置启动恢复的成员，您需要执行以下操作之一：
从损坏的服务器保留mysqld-auto.cnf
文件的副本，并将其复制到恢复的服务器的数据目录。
mysqld-auto.cnf如果该成员具有与损坏成员相同的持久系统变量设置，则将文件从该组的另一个成员
复制到恢复的服务器的数据目录中。
在恢复的服务器启动之后和重新启动组复制之前，通过mysql
客户端手动将所有系统变量设置为它们的持久值。
恢复主要成员。
如果恢复的成员是组中的主要成员，则必须注意防止在组复制分布式恢复过程中写入恢复的数据库。根据客户端访问组的方式，一旦恢复的成员可以在网络上访问，则有可能在恢复的成员完成其在离开组时错过的活动之前执行 DML 语句. 为避免这种情况，在启动恢复的服务器之前，在服务器选项文件中配置以下系统变量：
group_replication_start_on_boot=OFF
super_read_only=ON
event_scheduler=OFF
这些设置确保成员在启动时变为只读，并且在分布式恢复过程中成员追赶组时关闭事件调度程序。还必须在客户端上配置适当的错误处理，因为在此期间暂时阻止它们在恢复的成员上执行 DML 操作。一旦恢复过程完全完成并且恢复的成员与组的其余成员同步，恢复这些更改；重新启动事件调度程序：
mysql> SET global event_scheduler=ON;
在成员的选项文件中编辑以下系统变量，以便为下次启动正确配置：
group_replication_start_on_boot=ON
super_read_only=OFF
event_scheduler=ON
© Mysql 中文网
