# 13.1.27 DROP INDEX 语句_MySQL 8.0 参考手册

13.1.27 DROP INDEX 语句_MySQL 8.0 参考手册
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
13.1.27 DROP INDEX 语句
13.1.27 DROP INDEX 语句
DROP INDEX index_name ON tbl_name
[algorithm_option | lock_option] ...
algorithm_option:
ALGORITHM [=] {DEFAULT | INPLACE | COPY}
lock_option:
LOCK [=] {DEFAULT | NONE | SHARED | EXCLUSIVE}
DROP INDEXindex_name删除表中
命名的索引
tbl_name。此语句映射ALTER TABLE到删除索引的语句。请参阅第 13.1.9 节，“ALTER TABLE 语句”。
要删除主键，索引名称始终是
PRIMARY，必须将其指定为带引号的标识符，因为PRIMARY它是保留字：
DROP INDEX `PRIMARY` ON t;
表的可变宽度列上的索引
NDB被联机删除；也就是说，没有任何表复制。该表未被锁定以防止来自其他 NDB Cluster API 节点的访问，尽管在操作期间它被锁定以防止同一API 节点上的其他操作。只要服务器确定可以这样做，它就会自动完成；您不必使用任何特殊的 SQL 语法或服务器选项来使其发生。
ALGORITHMLOCK可以给出和子句来影响表的复制方法和在修改表的索引时读取和写入表的并发级别。它们的含义与
ALTER TABLE语句相同。有关详细信息，请参阅第 13.1.9 节，“ALTER TABLE 语句”
ALGORITHM=INPLACEMySQL NDB Cluster 使用标准 MySQL 服务器支持的相同语法
支持在线操作
。有关更多信息，请参阅
第 23.6.11 节，“在 NDB Cluster 中使用 ALTER TABLE 进行在线操作”。
© Mysql 中文网
