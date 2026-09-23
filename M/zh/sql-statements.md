# 第 13 章 SQL 语句_MySQL 8.0 参考手册

第 13 章 SQL 语句_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  /
第 13 章 SQL 语句
第 13 章 SQL 语句
目录13.1 数据定义语句13.1.1 原子数据定义语句支持13.1.2 ALTER DATABASE 语句13.1.3 ALTER EVENT 语句13.1.4 ALTER FUNCTION 语句13.1.5 ALTER INSTANCE 语句13.1.6 ALTER LOGFILE GROUP 语句13.1.7 ALTER PROCEDURE 语句13.1.8 ALTER SERVER 语句13.1.9 ALTER TABLE 语句13.1.10 ALTER TABLESPACE 语句13.1.11 ALTER VIEW 语句13.1.12 CREATE DATABASE 语句13.1.13 CREATE EVENT 语句13.1.14 CREATE FUNCTION 语句13.1.15 CREATE INDEX 语句13.1.16 CREATE LOGFILE GROUP 语句13.1.17 CREATE PROCEDURE 和 CREATE FUNCTION 语句13.1.18 CREATE SERVER 语句13.1.19 CREATE SPATIAL REFERENCE SYSTEM 语句13.1.20 CREATE TABLE 语句13.1.21 CREATE TABLESPACE 语句13.1.22 CREATE TRIGGER 语句13.1.23 CREATE VIEW 语句13.1.24 DROP DATABASE 语句13.1.25 DROP EVENT 语句13.1.26 DROP FUNCTION 语句13.1.27 DROP INDEX 语句13.1.28 DROP LOGFILE GROUP 语句13.1.29 DROP PROCEDURE 和 DROP FUNCTION 语句13.1.30 DROP SERVER 语句13.1.31 DROP SPATIAL REFERENCE SYSTEM 语句13.1.32 DROP TABLE 语句13.1.33 DROP TABLESPACE 语句13.1.34 DROP TRIGGER 语句13.1.35 DROP VIEW 语句13.1.36 RENAME TABLE 语句13.1.37 TRUNCATE TABLE 语句13.2 数据操作语句13.2.1 CALL 语句13.2.2 删除语句13.2.3 DO 声明13.2.4 HANDLER 语句13.2.5 导入表语句13.2.6 插入语句13.2.7 加载数据语句13.2.8 加载 XML 语句13.2.9 REPLACE 语句13.2.10 SELECT 语句13.2.11 子查询13.2.12 TABLE 语句13.2.13 更新语句13.2.14 VALUES 语句13.2.15 WITH（公用表表达式）13.3 事务和锁定语句13.3.1 START TRANSACTION、COMMIT 和 ROLLBACK 语句13.3.2 不能回滚的语句13.3.3 导致隐式提交的语句13.3.4 SAVEPOINT、ROLLBACK TO SAVEPOINT 和 RELEASE SAVEPOINT 语句13.3.5 LOCK INSTANCE FOR BACKUP 和 UNLOCK INSTANCE 语句13.3.6 LOCK TABLES 和 UNLOCK TABLES 语句13.3.7 SET TRANSACTION语句13.3.8 XA 事务13.4 复制语句13.4.1 控制源服务器的SQL语句13.4.2 控制副本服务器的SQL语句13.4.3 控制组复制的SQL语句13.5 准备好的语句13.5.1 PREPARE 语句13.5.2 执行语句13.5.3 解除分配准备语句13.6 复合语句语法13.6.1 BEGIN ... END 复合语句13.6.2 声明标签13.6.3 DECLARE 语句13.6.4 存储程序中的变量13.6.5 流量控制语句13.6.6 游标13.6.7 条件处理13.6.8 条件处理的限制13.7 数据库管理语句13.7.1 账户管理报表13.7.2 资源组管理语句13.7.3 表维护语句13.7.4 组件、插件和可加载函数语句13.7.5 CLONE 语句13.7.6 SET 语句13.7.7 显示语句13.7.8 其他行政报表13.8 效用语句13.8.1 描述语句13.8.2 EXPLAIN 语句13.8.3 帮助声明13.8.4 USE 语句
本章描述了 MySQL 支持的
SQL语句的语法。
© Mysql 中文网
