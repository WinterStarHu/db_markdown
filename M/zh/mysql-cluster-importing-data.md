# 23.6.9 导入数据到MySQL集群_MySQL 8.0 参考手册

23.6.9 导入数据到MySQL集群_MySQL 8.0 参考手册
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
23.6.9 导入数据到MySQL集群
23.6.9 导入数据到MySQL集群
在设置 NDB Cluster 的新实例时，通常需要从现有的 NDB Cluster、MySQL 实例或其他源导入数据。此数据通常以以下一种或多种格式提供：
由
mysqldump或mysqlpump生成的 SQL 转储文件。这可以使用mysql
客户端导入，如本节后面所示。
由mysqldump或其他导出程序生成的 CSV 文件。可以将此类文件导入到
mysql客户NDB端中使用，或者使用NDB Cluster 发行版提供的ndb_import实用程序。有关后者的更多信息，请参阅
第 23.5.13 节，“ndb_import — 将 CSV 数据导入 NDB”。
LOAD DATA
INFILE在
管理客户端中使用生成
的本机NDB备份
。要导入本机备份，您必须使用作为 NDB Cluster 一部分的ndb_restore
程序。有关使用此程序的更多信息，
请参阅
第 23.5.23 节，“ndb_restore - 恢复 NDB Cluster 备份” 。START BACKUPNDB
从 SQL 文件导入数据时，通常不需要强制执行事务或外键，暂时禁用这些功能可以大大加快导入过程。这可以使用mysql客户端从客户端会话或通过在命令行上调用它来完成。在
mysql客户端会话中，您可以使用以下 SQL 语句执行导入：
SET ndb_use_transactions=0;
SET foreign_key_checks=0;
source path/to/dumpfile;
SET ndb_use_transactions=1;
SET foreign_key_checks=1;
以这种方式执行导入时，您
必须在执行mysql客户端
命令ndb_use_transaction后
foreign_key_checks再次启用
。否则，同一会话中后面的语句也可能在不执行事务或外键约束的情况下执行，这可能导致数据不一致。
source在系统 shell 中，您可以导入 SQL 文件，同时通过使用带有
选项的mysql客户端
来禁用事务和外键的强制执行
--init-command，如下所示：
$> mysql --init-command='SET ndb_use_transactions=0; SET foreign_key_checks=0' < path/to/dumpfile
也可以将数据加载到
InnoDB表中，然后使用 ALTER TABLE ... ENGINE NDB 将其转换为使用 NDB 存储引擎。您应该考虑到，这可能需要许多这样的操作，尤其是对于许多表；此外，如果使用外键，您必须注意
ALTER TABLE语句的顺序，因为外键在使用不同MySQL存储引擎的表之间不起作用。
您应该知道，本节前面描述的方法并未针对非常大的数据集或大型事务进行优化。如果应用程序确实需要大事务或许多并发事务作为正常操作的一部分，您可能希望增加
MaxNoOfConcurrentOperations
数据节点配置参数的值，这会保留更多内存以允许数据节点在其事务协调器停止时接管事务不料。
在 NDB Cluster 表上执行批量DELETE或
操作
时，您可能还希望这样做
。UPDATE如果可能，请尝试让应用程序以块的形式执行这些操作，例如，通过添加
LIMIT到此类语句。
如果数据导入操作没有成功完成，无论出于何种原因，您应该准备执行任何必要的清理，包括可能的一个或多个DROP
TABLE语句、DROP
DATABASE语句或两者。否则可能会使数据库处于不一致状态。
© Mysql 中文网
