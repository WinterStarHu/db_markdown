# 13.3.3 导致隐式提交的语句_MySQL 8.0 参考手册

13.3.3 导致隐式提交的语句_MySQL 8.0 参考手册
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
13.2 数据操作语句
13.3 事务和锁定语句
13.3.1 START TRANSACTION、COMMIT 和 ROLLBACK 语句1
13.3.2 不能回滚的语句1
13.3.3 导致隐式提交的语句1
13.3.4 SAVEPOINT、ROLLBACK TO SAVEPOINT 和 RELEASE SAVEPOINT 语句1
13.3.5 LOCK INSTANCE FOR BACKUP 和 UNLOCK INSTANCE 语句1
13.3.6 LOCK TABLES 和 UNLOCK TABLES 语句1
13.3.7 SET TRANSACTION语句1
13.3.8 XA 事务1
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
MySQL 8.0 参考手册  / 第 13 章 SQL 语句  / 13.3 事务和锁定语句  /
13.3.3 导致隐式提交的语句
13.3.3 导致隐式提交的语句
本节中列出的语句（以及它们的任何同义词）隐式结束当前会话中任何活动的事务，就好像您COMMIT在执行该语句之前执行了操作一样。
大多数这些语句在执行后也会导致隐式提交。目的是在其自己的特殊事务中处理每个此类语句。事务控制和锁定语句是例外：如果隐式提交发生在执行之前，则另一个不会发生在执行之后。
定义或修改数​​据库对象的数据定义语言 (DDL) 语句。
ALTER EVENT,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
ALTER FUNCTION_
ALTER PROCEDURE_
ALTER SERVER_
ALTER TABLE_
ALTER TABLESPACE_
ALTER VIEW_
CREATE DATABASE_
CREATE EVENT_
CREATE FUNCTION_
CREATE INDEX_
CREATE PROCEDURE_
CREATE ROLE_
CREATE SERVER_
CREATE SPATIAL REFERENCE
SYSTEM_CREATE TABLE_
CREATE TABLESPACE_
CREATE TRIGGER_
CREATE VIEW_
DROP DATABASE_
DROP EVENT_
DROP FUNCTION_
DROP INDEX_
DROP PROCEDURE_
DROP ROLE_
DROP SERVER_
DROP SPATIAL REFERENCE SYSTEM_
DROP TABLE_
DROP TABLESPACE_
DROP TRIGGER_
DROP VIEW,,,,
.
INSTALL PLUGIN_
RENAME TABLE_
TRUNCATE TABLE_
UNINSTALL PLUGIN
CREATE TABLE
如果使用关键字，and
DROP TABLE语句不会提交事务。TEMPORARY（这不适用于临时表上的其他操作，例如ALTER
TABLEand CREATE
INDEX，它们确实会导致提交。）但是，虽然没有隐式提交发生，但语句也不能回滚，这意味着使用此类语句会导致事务原子性被侵犯。例如，如果您使用CREATE
TEMPORARY TABLE然后回滚事务，该表仍然存在。
中的CREATE TABLE语句
InnoDB作为单个事务处理。这意味着
ROLLBACK
来自用户的 a 不会撤消CREATE
TABLE用户在该事务期间所做的语句。
CREATE TABLE ...
SELECT当您创建非临时表时，会在执行语句之前和之后导致隐式提交。（没有提交发生CREATE TEMPORARY TABLE
... SELECT。）
隐式使用或修改数据库中表的语句mysql。
ALTER USER,,,,,,
.
CREATE USER_
DROP USER_
GRANT_
RENAME USER_
REVOKE_
SET PASSWORD
事务控制和锁定语句。
BEGIN,
LOCK TABLES,SET
autocommit = 1（如果值还不是 1），
START
TRANSACTION,
UNLOCK
TABLES.
UNLOCK
TABLES仅当当前已锁定任何表LOCK
TABLES以获取非事务表锁时才提交事务。UNLOCK
TABLES后续不会发生提交，
FLUSH TABLES
WITH READ LOCK因为后一条语句不获取表级锁。
事务不能嵌套。这是在您发出START
TRANSACTION语句或其同义词之一时对任何当前事务执行的隐式提交的结果。
ACTIVE当事务处于某个状态
时，导致隐式提交的语句不能在 XA 事务中使用
。
该BEGIN
语句不同于开始复合语句的BEGIN
关键字
的使用。BEGIN ...
END后者不会导致隐式提交。请参阅第 13.6.1 节，“BEGIN ... END 复合语句”。
数据加载语句。
LOAD DATA.
LOAD DATA仅对使用
NDB存储引擎的表进行隐式提交。
行政报表。
ANALYZE TABLE,
CACHE INDEX,
CHECK TABLE,
FLUSH,
LOAD INDEX INTO
CACHE,OPTIMIZE
TABLE,REPAIR TABLE,
RESET（但不是
RESET PERSIST）。
复制控制语句。
START
REPLICA,,,,
.STOP
REPLICA_
RESET
REPLICA_CHANGE REPLICATION
SOURCE TO_ CHANGE MASTER
TOSLAVE 关键字在 MySQL 8.0.22 中被替换为 REPLICA。
© Mysql 中文网
