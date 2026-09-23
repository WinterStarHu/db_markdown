# 13.1.32 DROP TABLE 语句_MySQL 8.0 参考手册

13.1.32 DROP TABLE 语句_MySQL 8.0 参考手册
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
13.1.32 DROP TABLE 语句
13.1.32 DROP TABLE 语句
DROP [TEMPORARY] TABLE [IF EXISTS]
tbl_name [, tbl_name] ...
[RESTRICT | CASCADE]
DROP TABLE删除一个或多个表。您必须拥有DROP
每个表的权限。
小心这个声明！对于每个表，它删除表定义和所有表数据。如果表已分区，则该语句会删除表定义、其所有分区、存储在这些分区中的所有数据以及与删除的表关联的所有分区定义。
删除表也会删除表的所有触发器。
DROP TABLE导致隐式提交，除非与TEMPORARY
关键字一起使用。请参阅第 13.3.3 节，“导致隐式提交的语句”。
重要的
删除表时，不会自动删除
专门为该表授予的权限。它们必须手动删除。请参阅第 13.7.1.6 节，“GRANT 语句”。
如果在参数列表中命名的任何表都不存在，则
DROP TABLE行为取决于是否IF EXISTS给出了子句：
如果没有IF EXISTS，该语句将失败并显示错误，指示它无法删除哪些不存在的表，并且不会进行任何更改。
使用IF EXISTS，不存在的表不会发生错误。该语句删除所有确实存在的命名表，并NOTE为每个不存在的表生成一个诊断。这些注释可以用 显示
SHOW WARNINGS。请参阅
第 13.7.7.42 节，“显示警告声明”。
IF EXISTS也可用于在异常情况下删除表，在这种情况下，数据字典中有条目但存储引擎没有管理表。（例如，如果在从存储引擎中删除表之后但在删除数据字典条目之前发生服务器异常退出。）
该TEMPORARY关键字具有以下作用：
该语句仅删除TEMPORARY表。
该语句不会导致隐式提交。
不检查访问权限。表仅在创建它的TEMPORARY
会话中可见，因此无需检查。
包括TEMPORARY关键字是防止意外删除非TEMPORARY
表的好方法。
和
关键字什么都不做RESTRICT。CASCADE他们被允许更容易地从其他数据库系统移植。
DROP TABLE并非所有innodb_force_recovery
设置都支持。请参阅第 15.21.3 节，“强制 InnoDB 恢复”。
© Mysql 中文网
