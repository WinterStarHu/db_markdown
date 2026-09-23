# 7.3 示例备份和恢复策略_MySQL 8.0 参考手册

7.3 示例备份和恢复策略_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 7 章备份与恢复  /
7.3 示例备份和恢复策略
7.3 示例备份和恢复策略
7.3.1 建立备份策略7.3.2 使用备份进行恢复7.3.3 备份策略总结
本节讨论执行备份的过程，使您能够在几种类型的崩溃后恢复数据：
操作系统崩溃
电源（检测）失败
文件系统崩溃
硬件问题（硬盘驱动器、主板等）
示例命令不包括诸如
--user和
--password用于
mysqldump和mysql客户端程序的选项。您应该包括使客户端程序能够连接到 MySQL 服务器所需的选项。
假设数据存储在InnoDB
存储引擎中，它支持事务和自动崩溃恢复。还假设 MySQL 服务器在崩溃时处于负载状态。如果不是，则永远不需要恢复。
对于操作系统崩溃或电源故障的情况，我们可以假设重启后 MySQL 的磁盘数据可用。由于
InnoDB崩溃，数据文件可能不包含一致的数据，但InnoDB会读取其日志并在其中找到尚未刷新到数据文件的待处理已提交和未提交事务的列表。InnoDB自动回滚那些未提交的事务，并将那些已提交的事务刷新到其数据文件。有关此恢复过程的信息通过 MySQL 错误日志传达给用户。以下是示例日志摘录：
InnoDB: Database was not shut down normally.
InnoDB: Starting recovery from log files...
InnoDB: Starting log scan based on checkpoint at
InnoDB: log sequence number 0 13674004
InnoDB: Doing recovery: scanned up to log sequence number 0 13739520
InnoDB: Doing recovery: scanned up to log sequence number 0 13805056
InnoDB: Doing recovery: scanned up to log sequence number 0 13870592
InnoDB: Doing recovery: scanned up to log sequence number 0 13936128
...
InnoDB: Doing recovery: scanned up to log sequence number 0 20555264
InnoDB: Doing recovery: scanned up to log sequence number 0 20620800
InnoDB: Doing recovery: scanned up to log sequence number 0 20664692
InnoDB: 1 uncommitted transaction(s) which must be rolled back
InnoDB: Starting rollback of uncommitted transactions
InnoDB: Rolling back trx no 16745
InnoDB: Rolling back of trx no 16745 completed
InnoDB: Rollback of uncommitted transactions completed
InnoDB: Starting an apply batch of log records to the database...
InnoDB: Apply batch completed
InnoDB: Started
mysqld: ready for connections
对于文件系统崩溃或硬件问题的情况，我们可以假设
重启后MySQL磁盘数据不可用。这意味着 MySQL 无法成功启动，因为某些磁盘数据块不再可读。在这种情况下，有必要重新格式化磁盘、安装新磁盘或以其他方式更正根本问题。然后需要从备份中恢复我们的 MySQL 数据，这意味着必须已经进行了备份。为确保是这种情况，请设计并实施备份策略。
© Mysql 中文网
