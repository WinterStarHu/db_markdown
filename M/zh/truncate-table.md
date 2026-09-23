# 13.1.37 TRUNCATE TABLE 语句_MySQL 8.0 参考手册

13.1.37 TRUNCATE TABLE 语句_MySQL 8.0 参考手册
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
13.1.37 TRUNCATE TABLE 语句
13.1.37 TRUNCATE TABLE 语句
TRUNCATE [TABLE] tbl_name
TRUNCATE TABLE完全清空一张桌子。它需要DROP
特权。从逻辑上讲，TRUNCATE
TABLE类似于
DELETE删除所有行的语句，或一系列DROP TABLE
andCREATE TABLE语句。
为了实现高性能，TRUNCATE
TABLE绕过了删除数据的DML方法。因此，它不会导致ON DELETE触发器触发，不能对InnoDB具有父子外键关系的表执行，也不能像 DML 操作一样回滚。但是，TRUNCATE
TABLE如果服务器在操作期间停止，则对使用支持原子 DDL 的存储引擎的表的操作要么完全提交，要么回滚。有关详细信息，请参阅第 13.1.1 节，“原子数据定义语句支持”。
虽然TRUNCATE TABLE类似于DELETE，但它被归类为 DDL 语句而不是 DML 语句。它
DELETE在以下方面有所不同：
截断操作删除并重新创建表，这比一行一行地删除行要快得多，特别是对于大表。
截断操作会导致隐式提交，因此无法回滚。请参阅第 13.3.3 节，“导致隐式提交的语句”。
如果会话持有活动表锁，则无法执行截断操作。
TRUNCATE TABLE如果存在
来自引用该表的其他表的任何约束，则该InnoDB表或
表将失败
。允许同一个表的列之间的外键约束。
NDBFOREIGN KEY
截断操作不会为已删除的行数返回有意义的值。通常的结果是“ 0 行受影响”，这应该被解释为“没有信息。”
只要表定义有效，就可以使用 将表重新创建为空表
TRUNCATE TABLE，即使数据或索引文件已损坏。
任何AUTO_INCREMENT值都将重置为其起始值。即使对于通常不重用序列值
的MyISAM
和也是如此。InnoDB
与分区表一起使用时，
TRUNCATE TABLE保留分区；也就是说，数据和索引文件被删除并重新创建，而分区定义不受影响。
该TRUNCATE TABLE语句不调用ON DELETE触发器。
支持截断损坏的InnoDB表。
TRUNCATE TABLE出于二进制日志记录和复制的目的被视为 DDL 而不是 DML，并且始终记录为语句。
TRUNCATE TABLEfor a table 关闭用打开的表的所有处理程序
HANDLER OPEN。
在 MySQL 5.7 及更早版本中，在具有大型缓冲池并
innodb_adaptive_hash_index
启用的系统上TRUNCATE TABLE，由于在删除表的自适应哈希索引条目时发生的 LRU 扫描，操作可能会导致系统性能暂时下降（错误＃68184）。TRUNCATE
TABLEtoDROP TABLE和
in MySQL 8.0的重新映射CREATE TABLE避免了有问题的 LRU 扫描。
TRUNCATE TABLE可以与 Performance Schema 汇总表一起使用，但效果是将汇总列重置为 0 或NULL，而不是删除行。请参阅第 27.12.20 节，“性能模式摘要表”。
截断InnoDB驻留在 file-per-table 表空间中的表会删除现有表空间并创建一个新表空间。从 MySQL 8.0.21 开始，如果表空间是使用较早版本创建的并且位于未知目录中，InnoDB则在默认位置创建新表空间并将以下警告写入错误日志：DATA DIRECTORY location must be in a known目录。DATA DIRECTORY 位置将被忽略，文件将被放入默认的 datadir 位置。已知目录是由
datadir、
innodb_data_home_dir和
innodb_directories变量定义的目录。要TRUNCATE TABLE在其当前位置创建表空间，请将目录添加到
innodb_directories运行前设置TRUNCATE TABLE。
© Mysql 中文网
