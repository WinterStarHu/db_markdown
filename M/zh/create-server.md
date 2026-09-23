# 13.1.18 CREATE SERVER 语句_MySQL 8.0 参考手册

13.1.18 CREATE SERVER 语句_MySQL 8.0 参考手册
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
13.1.18 CREATE SERVER 语句
13.1.18 CREATE SERVER 语句
CREATE SERVER server_name
FOREIGN DATA WRAPPER wrapper_name
OPTIONS (option [, option] ...)
option: {
HOST character-literal
| DATABASE character-literal
| USER character-literal
| PASSWORD character-literal
| SOCKET character-literal
| OWNER character-literal
| PORT numeric-literal
}
此语句创建用于
FEDERATED存储引擎的服务器定义。该语句在
数据库的表中CREATE
SERVER创建一个新行
。此语句需要
权限。
serversmysqlSUPERserver_name
应该是对服务器的唯一引用
。服务器定义在服务器范围内是全局的，不可能将服务器定义限定为特定数据库。
server_name最大长度为 64 个字符（超过 64 个字符的名称将被自动截断），并且不区分大小写。您可以将名称指定为带引号的字符串。
Thewrapper_name是一个标识符，可以用单引号引起来。
对于每个option，您必须指定字符文字或数字文字。字符文字是 UTF-8，支持最大长度为 64 个字符，默认为空白（空）字符串。字符串文字被静默截断为 64 个字符。数字文字必须是 0 到 9999 之间的数字，默认值为 0。
笔记
该OWNER选项当前未应用，并且对创建的服务器连接的所有权或操作没有影响。
该CREATE SERVER语句在表中创建一个条目，mysql.servers稍后可以CREATE TABLE在创建FEDERATED表时与该语句一起使用。您指定的选项用于填充表中的列
mysql.servers。表格
列为
Server_name、Host、
Db、Username、
Password和。
PortSocket
例如：
CREATE SERVER s
FOREIGN DATA WRAPPER mysql
OPTIONS (USER 'Remote', HOST '198.51.100.106', DATABASE 'test');
请务必指定与服务器建立连接所需的所有选项。用户名、主机名和数据库名是必需的。可能还需要其他选项，例如密码。
创建与表的连接时，可以使用存储在表中的数据FEDERATED：
CREATE TABLE t (s1 INT) ENGINE=FEDERATED CONNECTION='s';
有关详细信息，请参阅
第 16.8 节，“联邦存储引擎”。
CREATE SERVER导致隐式提交。请参阅
第 13.3.3 节，“导致隐式提交的语句”。
CREATE SERVER无论使用何种日志记录格式，都不会写入二进制日志。
© Mysql 中文网
