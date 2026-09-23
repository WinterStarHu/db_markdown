# 13.1.24 DROP DATABASE 语句_MySQL 8.0 参考手册

13.1.24 DROP DATABASE 语句_MySQL 8.0 参考手册
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
13.1.24 DROP DATABASE 语句
13.1.24 DROP DATABASE 语句
DROP {DATABASE | SCHEMA} [IF EXISTS] db_name
DROP DATABASE删除数据库中的所有表并删除数据库。请务必
谨慎对待此声明！要使用
DROP DATABASE，您需要
DROP数据库的权限。
DROP
SCHEMA是的同义词DROP
DATABASE。
重要的
删除数据库时，不会自动删除
专门为该数据库授予的权限。它们必须手动删除。请参阅第 13.7.1.6 节，“GRANT 语句”。
IF EXISTS用于防止数据库不存在时发生错误。
如果删除默认数据库，则取消设置默认数据库（DATABASE()函数返回
NULL）。
如果DROP DATABASE在符号链接的数据库上使用，链接和原始数据库都会被删除。
DROP DATABASE返回已删除的表数。
该DROP DATABASE语句从给定的数据库目录中删除 MySQL 本身在正常操作期间可能创建的那些文件和目录。这包括具有以下列表中显示的扩展名的所有文件：
.BAK
.DAT
.HSH
.MRG
.MYD
.MYI
.cfg
.db
.ibd
.ndb
如果MySQL删除刚刚列出的文件或目录后，数据库目录中还有其他文件或目录，则无法删除数据库目录。在这种情况下，您必须手动删除任何剩余的文件或目录并
DROP DATABASE再次发出该语句。
删除数据库不会删除
TEMPORARY在该数据库中创建的任何表。TEMPORARY当创建它们的会话结束时，表会自动删除。请参阅
第 13.1.20.2 节，“CREATE TEMPORARY TABLE 语句”。
您还可以使用mysqladmin删除数据库。请参阅第 4.5.2 节，“mysqladmin — 一个 MySQL 服务器管理程序”。
© Mysql 中文网
