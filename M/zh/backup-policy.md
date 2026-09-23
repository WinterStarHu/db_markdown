# 7.3.1 建立备份策略_MySQL 8.0 参考手册

7.3.1 建立备份策略_MySQL 8.0 参考手册
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
7.1 备份和恢复类型
7.2 数据库备份方式
7.3 示例备份和恢复策略
7.3.1 建立备份策略1
7.3.2 使用备份进行恢复1
7.3.3 备份策略总结1
7.4 使用 mysqldump 进行备份
7.5 时间点（增量）恢复
7.6 MyISAM表维护和崩溃恢复
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
MySQL 8.0 参考手册  / 第 7 章备份与恢复  / 7.3 示例备份和恢复策略  /
7.3.1 建立备份策略
7.3.1 建立备份策略
为了有用，必须定期安排备份。可以使用多种工具在 MySQL 中完成完整备份（某个时间点的数据快照）。例如，
MySQL Enterprise Backup可以执行整个实例的
物理备份，并通过优化来最小化开销并避免备份InnoDB数据文件时的中断；mysqldump提供在线
逻辑备份。此讨论使用mysqldump。
假设我们
InnoDB在周日下午 1 点负载较低时使用以下命令对所有数据库中的所有表进行完整备份：
$> mysqldump --all-databases --master-data --single-transaction > backup_sunday_1_PM.sqlmysqldump
生成的结果.sql文件
包含一组 SQL
语句，可用于稍后重新加载转储的表。
INSERT
此备份操作在转储开始时获取所有表的全局读锁（使用FLUSH
TABLES WITH READ LOCK）。一旦获得此锁，就会读取二进制日志坐标并释放锁。如果在
FLUSH发出语句时正在运行长更新语句，则备份操作可能会停止，直到这些语句完成。在那之后，转储变得无锁并且不会干扰表上的读取和写入。
前面假设要备份的表是
InnoDB表，所以
使用一致读，保证mysqldump--single-transaction看到的数据
不变。（其他客户端对表所做的更改不会被mysqldump进程看到。）如果备份操作包括非事务表，则一致性要求它们在备份期间不更改。例如，对于数据库中的
表，
在备份期间不得对 MySQL 帐户进行管理更改。
InnoDBMyISAMmysql
完整备份是必要的，但创建它们并不总是很方便。它们会产生大型备份文件并需要时间来生成。它们不是最佳的，因为每个连续的完整备份都包括所有数据，即使是自上次完整备份以来未更改的部分。进行初始完整备份，然后进行增量备份效率更高。增量备份更小，生成时间更短。权衡是，在恢复时，您不能仅通过重新加载完整备份来恢复数据。您还必须处理增量备份以恢复增量更改。
要进行增量备份，我们需要保存增量更改。在 MySQL 中，这些更改在二进制日志中表示，因此 MySQL 服务器应始终
--log-bin以启用该日志的选项启动。启用二进制日志记录后，服务器在更新数据时将每个数据更改写入文件。查看运行了几天的 MySQL 服务器的数据目录，我们发现这些 MySQL 二进制日志文件：
-rw-rw---- 1 guilhem  guilhem   1277324 Nov 10 23:59 gbichot2-bin.000001
-rw-rw---- 1 guilhem  guilhem         4 Nov 10 23:59 gbichot2-bin.000002
-rw-rw---- 1 guilhem  guilhem        79 Nov 11 11:06 gbichot2-bin.000003
-rw-rw---- 1 guilhem  guilhem       508 Nov 11 11:08 gbichot2-bin.000004
-rw-rw---- 1 guilhem  guilhem 220047446 Nov 12 16:47 gbichot2-bin.000005
-rw-rw---- 1 guilhem  guilhem    998412 Nov 14 10:08 gbichot2-bin.000006
-rw-rw---- 1 guilhem  guilhem       361 Nov 14 10:07 gbichot2-bin.index
每次重新启动时，MySQL 服务器都会使用序列中的下一个数字创建一个新的二进制日志文件。FLUSH LOGS当服务器正在运行时，您还可以通过发出SQL 语句或使用mysqladmin flush-logs命令
告诉它关闭当前二进制日志文件并手动开始一个新文件
。mysqldump还有一个刷新日志的选项。数据目录中的.index文件包含目录中所有 MySQL 二进制日志的列表。
MySQL 二进制日志对于恢复很重要，因为它们形成了一组增量备份。如果您确保在进行完整备份时刷新日志，则之后创建的二进制日志文件将包含自备份以来所做的所有数据更改。让我们稍微修改一下前面的mysqldump
命令，让它在完整备份时刷新 MySQL 二进制日志，并且转储文件包含新的当前二进制日志的名称：
$> mysqldump --single-transaction --flush-logs --master-data=2 \
--all-databases > backup_sunday_1_PM.sql
执行此命令后，数据目录包含一个新的二进制日志文件gbichot2-bin.000007，因为该--flush-logs
选项会导致服务器刷新其日志。该
--master-data选项导致
mysqldump将二进制日志信息写入其输出，因此生成的.sql转储文件包括以下行：
-- Position to start replication or point-in-time recovery from
-- CHANGE MASTER TO MASTER_LOG_FILE='gbichot2-bin.000007',MASTER_LOG_POS=4;
因为mysqldump命令进行了完整备份，所以这些行意味着两件事：
gbichot2-bin.000007
转储文件包含在写入二进制日志文件或更高版本
的任何更改之前所做的所有更改。
备份后记录的所有数据更改都不会出现在转储文件中，但会出现在
gbichot2-bin.000007二进制日志文件或更高版本中。
星期一下午 1 点，我们可以通过刷新日志以开始一个新的二进制日志文件来创建增量备份。例如，执行mysqladmin flush-logs命令会创建gbichot2-bin.000008. 周日下午 1 点完整备份和周一下午 1 点之间的所有更改都写入gbichot2-bin.000007. 这个增量备份很重要，所以最好将它复制到一个安全的地方。（例如，将其备份到磁带或 DVD 上，或将其复制到另一台机器上。）星期二下午 1 点，执行另一个mysqladmin flush-logs命令。星期一下午 1 点到星期二下午 1 点之间的所有更改都写在
gbichot2-bin.000008（也应该复制到安全的地方）。
MySQL 二进制日志占用磁盘空间。要释放空间，请不时清除它们。一种方法是删除不再需要的二进制日志，例如当我们进行完整备份时：
$> mysqldump --single-transaction --flush-logs --master-data=2 \
--all-databases --delete-master-logs > backup_sunday_1_PM.sql
笔记
如果您的服务器是复制源服务器，使用mysqldump --delete-master-logs
删除 MySQL 二进制日志可能很危险，因为副本可能尚未完全处理二进制日志的内容。该PURGE BINARY
LOGS语句的描述解释了在删除 MySQL 二进制日志之前应该验证的内容。参见
第 13.4.1.1 节，“PURGE BINARY LOGS 语句”。
© Mysql 中文网
