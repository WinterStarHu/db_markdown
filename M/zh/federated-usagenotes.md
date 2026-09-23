# 16.8.3 FEDERATED 存储引擎注释和提示_MySQL 8.0 参考手册

16.8.3 FEDERATED 存储引擎注释和提示_MySQL 8.0 参考手册
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
16.1 设置存储引擎
16.2 MyISAM 存储引擎
16.3 MEMORY存储引擎
16.4 CSV存储引擎
16.5 ARCHIVE存储引擎
16.6 BLACKHOLE存储引擎
16.7 MERGE存储引擎
16.8 联合存储引擎
16.8.1 联合存储引擎概述1
16.8.2 如何创建 FEDERATED 表1
16.8.3 FEDERATED 存储引擎注释和提示1
16.8.4 联合存储引擎资源1
16.9 示例存储引擎
16.10 其他存储引擎
16.11 MySQL存储引擎架构概述
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
MySQL 8.0 参考手册  / 第 16 章替代存储引擎  / 16.8 联合存储引擎  /
16.8.3 FEDERATED 存储引擎注释和提示
16.8.3 FEDERATED 存储引擎注释和提示
使用
FEDERATED存储引擎需要注意以下几点：
FEDERATED表可以复制到其他副本，但您必须确保副本服务器能够使用CONNECTION字符串（或
mysql.servers表中的行）中定义的用户/密码组合来连接到远程服务器。
以下各项表示
FEDERATED存储引擎支持和不支持的功能：
远程服务器必须是 MySQL 服务器。
在尝试通过表访问表之前，FEDERATED表指向
的远程表必须FEDERATED存在
。
一个FEDERATED表可以指向另一个表，但必须注意不要形成循环。
FEDERATED表不支持通常意义上的索引
；因为对表数据的访问是远程处理的，所以实际上是使用索引的远程表。这意味着，对于不能使用任何索引且因此需要全表扫描的查询，服务器会从远程表中获取所有行并在本地过滤它们。无论是否与此声明一起使用，都会发生
WHERE这种LIMIT情况SELECT；这些子句在本地应用于返回的行。
因此，未能使用索引的查询可能会导致性能不佳和网络过载。此外，由于返回的行必须存储在内存中，这样的查询也会导致本地服务器交换，甚至挂起。
创建表时应小心，
因为可能不支持FEDERATED来自等效表或其他表的索引定义。MyISAM例如，
如果表在任何或
列FEDERATED上使用索引前缀，则创建表将失败VARCHAR。
使用以下定义是有效的：
TEXTBLOBMyISAMCREATE TABLE `T1`(`A` VARCHAR(100),UNIQUE KEY(`A`(30))) ENGINE=MYISAM;
此示例中的键前缀与引擎不兼容，
FEDERATED等效语句失败：
CREATE TABLE `T1`(`A` VARCHAR(100),UNIQUE KEY(`A`(30))) ENGINE=FEDERATED
CONNECTION='MYSQL://127.0.0.1:3306/TEST/T1';
如果可能，您应该在远程服务器和本地服务器上创建表时尝试将列和索引定义分开，以避免这些索引问题。
在内部，实现使用
SELECT、
INSERT、
UPDATE和
DELETE，但不
使用HANDLER。
FEDERATED存储引擎支持
, SELECT,
INSERT,
UPDATE,
DELETE,
TRUNCATE TABLE和 索引。它不支持ALTER TABLE, 或任何直接影响表结构的数据定义语言语句，除了
DROP TABLE. 当前的实现不使用准备好的语句。
FEDERATED接受
INSERT
... ON DUPLICATE KEY UPDATE语句，但如果发生重复键违规，语句将失败并出现错误。
不支持交易。
FEDERATED执行批量插入处理，以便将多行批量发送到远程表，从而提高性能。此外，如果远程表是事务性的，它使远程存储引擎能够在发生错误时正确执行语句回滚。此功能具有以下限制：
插入的大小不能超过服务器之间的最大数据包大小。如果插入超过此大小，它会被分成多个数据包，并且可能会出现回滚问题。
不会发生批量插入处理
INSERT
... ON DUPLICATE KEY UPDATE。
引擎无法FEDERATED知道远程表是否已更改。这样做的原因是这个表必须像一个数据文件一样工作，除了数据库系统之外，其他任何东西都不会写入它。如果对远程数据库进行任何更改，则可能会破坏本地表中数据的完整性。
使用CONNECTION字符串时，不能在密码中使用“@”字符。CREATE
SERVER您可以通过使用语句创建服务器连接来
绕过此限制。
和选项不会传播到数据提供者
insert_id。
timestampDROP TABLE针对表发出的
任何语句FEDERATED只删除本地表，而不删除远程表。
表不支持用户定义的分区
FEDERATED。
© Mysql 中文网
