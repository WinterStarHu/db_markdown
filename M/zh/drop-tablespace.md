# 13.1.33 DROP TABLESPACE 语句_MySQL 8.0 参考手册

13.1.33 DROP TABLESPACE 语句_MySQL 8.0 参考手册
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
13.1 数据定义语句
13.1.1 原子数据定义语句支持1
13.1.2 ALTER DATABASE 语句1
13.1.3 ALTER EVENT 语句1
13.1.4 ALTER FUNCTION 语句1
13.1.5 ALTER INSTANCE 语句1
13.1.6 ALTER LOGFILE GROUP 语句1
13.1.7 ALTER PROCEDURE 语句1
13.1.8 ALTER SERVER 语句1
13.1.9 ALTER TABLE 语句1
13.1.10 ALTER TABLESPACE 语句1
13.1.11 ALTER VIEW 语句1
13.1.12 CREATE DATABASE 语句1
13.1.13 CREATE EVENT 语句1
13.1.14 CREATE FUNCTION 语句1
13.1.15 CREATE INDEX 语句1
13.1.16 CREATE LOGFILE GROUP 语句1
13.1.17 CREATE PROCEDURE 和 CREATE FUNCTION 语句1
13.1.18 CREATE SERVER 语句1
13.1.19 CREATE SPATIAL REFERENCE SYSTEM 语句1
13.1.20 CREATE TABLE 语句1
13.1.21 CREATE TABLESPACE 语句1
13.1.22 CREATE TRIGGER 语句1
13.1.23 CREATE VIEW 语句1
13.1.24 DROP DATABASE 语句1
13.1.25 DROP EVENT 语句1
13.1.26 DROP FUNCTION 语句1
13.1.27 DROP INDEX 语句1
13.1.28 DROP LOGFILE GROUP 语句1
13.1.29 DROP PROCEDURE 和 DROP FUNCTION 语句1
13.1.30 DROP SERVER 语句1
13.1.31 DROP SPATIAL REFERENCE SYSTEM 语句1
13.1.32 DROP TABLE 语句1
13.1.33 DROP TABLESPACE 语句1
13.1.34 DROP TRIGGER 语句1
13.1.35 DROP VIEW 语句1
13.1.36 RENAME TABLE 语句1
13.1.37 TRUNCATE TABLE 语句1
13.2 数据操作语句
13.3 事务和锁定语句
13.4 复制语句
13.5 准备好的语句
13.6 复合语句语法
13.7 数据库管理语句
13.8 效用语句
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
MySQL 8.0 参考手册  / 第 13 章 SQL 语句  / 13.1 数据定义语句  /
13.1.33 DROP TABLESPACE 语句
13.1.33 DROP TABLESPACE 语句
DROP [UNDO] TABLESPACE tablespace_name
[ENGINE [=] engine_name]
此语句删除以前使用创建的表空间CREATE TABLESPACE。它由NDB和
InnoDB存储引擎支持。
MySQL 8.0.14 引入的UNDO关键字，必须指定删除undo 表空间。CREATE UNDO
TABLESPACE只能删除使用语法创建的撤消表空间
。撤消表空间必须处于empty可以删除之前的状态。有关详细信息，请参阅
第 15.6.3.4 节，“撤消表空间”。
ENGINE设置使用表空间的存储引擎，其中engine_name是存储引擎的名称。当前，值
InnoDB和NDB受支持。如果未设置，
default_storage_engine则使用的值。如果它与用于创建表空间的存储引擎不同，则DROP TABLESPACE语句失败。
tablespace_name是 MySQL 中区分大小写的标识符。
对于InnoDB通用表空间，必须在DROP
TABLESPACE操作之前从表空间中删除所有表。如果表空间不为空，则
DROP TABLESPACE返回错误。
要删除的NDB表空间不得包含任何数据文件；换句话说，在删除
NDB表空间之前，必须先使用
ALTER TABLESPACE
... DROP DATAFILE.
笔记
InnoDB删除表空间中的最后一个表时，不会自动删除
通用表空间。必须使用 显式删除表空间
。
DROP TABLESPACE
tablespace_name
操作可以删除属于通用表空间的DROP DATABASE表，但不能删除表空间，即使该操作删除了属于该表空间的所有表。必须使用 显式删除表空间。
DROP TABLESPACE
tablespace_name
与系统表空间类似，截断或删除存储在通用表空间中的表会在通用表空间
.ibd 数据文件内部创建只能用于新InnoDB数据的可用空间。空间不会像 file-per-table 表空间那样释放回操作系统。
InnoDB 示例
此示例演示如何删除InnoDB
通用表空间。通用表空间ts1
是用单个表创建的。在删除表空间之前，必须先删除表。
mysql> CREATE TABLESPACE `ts1` ADD DATAFILE 'ts1.ibd' Engine=InnoDB;
mysql> CREATE TABLE t1 (c1 INT PRIMARY KEY) TABLESPACE ts1 Engine=InnoDB;
mysql> DROP TABLE t1;
mysql> DROP TABLESPACE ts1;
此示例演示删除撤消表空间。撤消表空间必须处于empty可以删除之前的状态。有关详细信息，请参阅
第 15.6.3.4 节，“撤消表空间”。
mysql> DROP UNDO TABLESPACE undo_003;
新开发银行示例
此示例显示如何删除具有在首次创建表NDB
空间后myts命名的数据文件
mydata-1.dat的表空间，并假设存在名为的日志文件组
mylg（请参阅
第 13.1.16 节，“CREATE LOGFILE GROUP 语句”）。
mysql> CREATE TABLESPACE myts
->     ADD DATAFILE 'mydata-1.dat'
->     USE LOGFILE GROUP mylg
->     ENGINE=NDB;
您必须使用 删除表空间中的所有数据文件
ALTER TABLESPACE，如此处所示，然后才能将其删除：
mysql> ALTER TABLESPACE myts
->     DROP DATAFILE 'mydata-1.dat'
->     ENGINE=NDB;
mysql> DROP TABLESPACE myts;
© Mysql 中文网
