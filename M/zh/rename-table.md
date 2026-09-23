# 13.1.36 RENAME TABLE 语句_MySQL 8.0 参考手册

13.1.36 RENAME TABLE 语句_MySQL 8.0 参考手册
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
13.1.36 RENAME TABLE 语句
13.1.36 RENAME TABLE 语句
RENAME TABLE
tbl_name TO new_tbl_name
[, tbl_name2 TO new_tbl_name2] ...
RENAME TABLE重命名一个或多个表。您必须拥有原始表的权限和新
ALTER表
的权限。
DROPCREATEINSERT
例如，要重命名名为 的表old_table
，请new_table使用以下语句：
RENAME TABLE old_table TO new_table;
该语句等效于以下
ALTER TABLE语句：
ALTER TABLE old_table RENAME new_table;
RENAME TABLE与 不同ALTER
TABLE，可以在一条语句中重命名多个表：
RENAME TABLE old_table1 TO new_table1,
old_table2 TO new_table2,
old_table3 TO new_table3;
重命名操作从左到右执行。因此，要交换两个表名，请执行以下操作（假设具有中间名称的表tmp_table尚不存在）：
RENAME TABLE old_table TO tmp_table,
new_table TO old_table,
tmp_table TO new_table;
表上的元数据锁是按名称顺序获取的，在某些情况下，当多个事务并发执行时，这可能会对操作结果产生影响。请参阅
第 8.11.4 节，“元数据锁定”。
从 MySQL 8.0.13 开始，您可以重命名用
LOCK TABLES语句锁定的表，前提是它们是用WRITE锁锁定的，或者是WRITE在多表重命名操作的早期步骤中重命名 -locked 表的产物。例如，这是允许的：
LOCK TABLE old_table1 WRITE;
RENAME TABLE old_table1 TO new_table1,
new_table1 TO new_table2;
这是不允许的：
LOCK TABLE old_table1 READ;
RENAME TABLE old_table1 TO new_table1,
new_table1 TO new_table2;
在 MySQL 8.0.13 之前，要执行RENAME TABLE，必须没有被锁定的表LOCK
TABLES。
在满足事务表锁定条件的情况下，重命名操作以原子方式完成；在重命名过程中，没有其他会话可以访问任何表。
如果在 a 期间发生任何错误RENAME TABLE，则该语句将失败并且不进行任何更改。
您可以使用RENAME TABLE将表从一个数据库移动到另一个数据库：
RENAME TABLE current_db.tbl_name TO other_db.tbl_name;
使用此方法将所有表从一个数据库移动到另一个数据库实际上重命名了数据库（MySQL 没有单个语句的操作），除了原始数据库继续存在，尽管没有表。
像RENAME TABLE,ALTER TABLE ...
RENAME也可用于将表移动到不同的数据库。无论使用何种语句，如果重命名操作会将表移动到位于不同文件系统上的数据库，则结果的成功与否取决于平台，并且取决于用于移动表文件的底层操作系统调用。
如果表有触发器，尝试将表重命名为不同的数据库会失败，并出现Trigger in wrong schema
( ER_TRG_IN_WRONG_SCHEMA) 错误。
未加密的表可以移动到启用加密的数据库，反之亦然。但是，如果
table_encryption_privilege_check
启用该变量，
TABLE_ENCRYPTION_ADMIN并且表加密设置与默认数据库加密不同，则需要该权限。
重命名TEMPORARY表，RENAME
TABLE不起作用。改用ALTER
TABLE。
RENAME TABLE适用于视图，除了不能将视图重命名为不同的数据库。
专门为重命名的表或视图授予的任何权限都不会迁移到新名称。它们必须手动更改。
RENAME TABLE tbl_name TO
new_tbl_name更改内部生成的外键约束名称和以字符串“ tbl_name_ibfk_ ”开头的用户定义的外键约束名称
以反映新的表名称。将以字符串“ _ibfk_ ”InnoDB开头的外键约束名称解释
为内部生成的名称。
tbl_name
指向重命名表的外键约束名称会自动更新，除非存在冲突，在这种情况下语句会因错误而失败。如果重命名的约束名称已经存在，则会发生冲突。在这种情况下，您必须删除并重新创建外键才能使它们正常运行。
RENAME TABLE tbl_name TO
new_tbl_name更改以字符串“ _chk_ ”CHECK
开头的
内部生成的和用户定义的约束名称以反映新的表名称。MySQL将以字符串“ _chk_ ”
开头的约束名称
解释为内部生成的名称。例子：
tbl_nameCHECKtbl_namemysql> SHOW CREATE TABLE t1\G
*************************** 1. row ***************************
Table: t1
Create Table: CREATE TABLE `t1` (
`i1` int(11) DEFAULT NULL,
`i2` int(11) DEFAULT NULL,
CONSTRAINT `t1_chk_1` CHECK ((`i1` > 0)),
CONSTRAINT `t1_chk_2` CHECK ((`i2` < 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.02 sec)
mysql> RENAME TABLE t1 TO t3;
Query OK, 0 rows affected (0.03 sec)
mysql> SHOW CREATE TABLE t3\G
*************************** 1. row ***************************
Table: t3
Create Table: CREATE TABLE `t3` (
`i1` int(11) DEFAULT NULL,
`i2` int(11) DEFAULT NULL,
CONSTRAINT `t3_chk_1` CHECK ((`i1` > 0)),
CONSTRAINT `t3_chk_2` CHECK ((`i2` < 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.01 sec)
© Mysql 中文网
