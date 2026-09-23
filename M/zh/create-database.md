# 13.1.12 CREATE DATABASE 语句_MySQL 8.0 参考手册

13.1.12 CREATE DATABASE 语句_MySQL 8.0 参考手册
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
13.1.12 CREATE DATABASE 语句
13.1.12 CREATE DATABASE 语句
CREATE {DATABASE | SCHEMA} [IF NOT EXISTS] db_name
[create_option] ...
create_option: [DEFAULT] {
CHARACTER SET [=] charset_name
| COLLATE [=] collation_name
| ENCRYPTION [=] {'Y' | 'N'}
}
CREATE DATABASE使用给定的名称创建一个数据库。要使用此语句，您需要
CREATE数据库的权限。
CREATE
SCHEMA是的同义词CREATE
DATABASE。
如果数据库存在而您没有指定 ，则会发生错误
IF NOT EXISTS。
CREATE DATABASELOCK
TABLES在具有活动语句
的会话中不允许。
每个create_option指定一个数据库特征。数据库特征存储在数据字典中。
该CHARACTER SET选项指定默认数据库字符集。该COLLATE
选项指定默认数据库排序规则。有关字符集和排序规则名称的信息，请参阅
第 10 章，字符集、排序规则、Unicode。
要查看可用的字符集和排序规则，请分别使用 theSHOW CHARACTER SET和
SHOW COLLATION语句。请参阅第 13.7.7.3 节，“SHOW CHARACTER SET 语句”和
第 13.7.7.4 节，“SHOW COLLATION 语句”。
该ENCRYPTION选项在 MySQL 8.0.16 中引入，定义了默认的数据库加密，由数据库中创建的表继承。允许的值为'Y'（启用加密）和
'N'（禁用加密）。如果
ENCRYPTION未指定该选项，则
default_table_encryption
系统变量的值定义默认数据库加密。如果
table_encryption_privilege_check
启用了系统变量，
TABLE_ENCRYPTION_ADMIN
则需要指定与该设置不同的默认加密设置的权限
default_table_encryption
。有关详细信息，请参阅
为架构和通用表空间定义加密默认值.
MySQL 中的数据库被实现为包含与数据库中的表相对应的文件的目录。因为最初创建数据库时没有表，所以该
CREATE DATABASE语句只在MySQL数据目录下创建一个目录。允许的数据库名称的规则在
第 9.2 节“模式对象名称”中给出。如果数据库名称包含特殊字符，则数据库目录的名称包含这些字符的编码版本，如
第 9.2.4 节“标识符到文件名的映射”中所述。
MySQL 8.0 不支持
通过在数据目录下手动创建目录（例如使用
mkdir ）来创建数据库目录。
创建数据库时，让服务器管理目录和其中的文件。直接操作数据库目录和文件可能会导致不一致和意外结果。
MySQL 对数据库的数量没有限制。底层文件系统可能对目录数量有限制。
您还可以使用mysqladmin程序来创建数据库。请参阅第 4.5.2 节，“mysqladmin — 一个 MySQL 服务器管理程序”。
© Mysql 中文网
