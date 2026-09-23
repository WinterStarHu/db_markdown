# 13.1.6 ALTER LOGFILE GROUP 语句_MySQL 8.0 参考手册

13.1.6 ALTER LOGFILE GROUP 语句_MySQL 8.0 参考手册
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
13.1.6 ALTER LOGFILE GROUP 语句
13.1.6 ALTER LOGFILE GROUP 语句
ALTER LOGFILE GROUP logfile_group
ADD UNDOFILE 'file_name'
[INITIAL_SIZE [=] size]
[WAIT]
ENGINE [=] engine_name
此语句将UNDO名为“ file_name”的文件添加到现有日志文件组logfile_group。一个
ALTER LOGFILE GROUP语句只有一个ADD UNDOFILE子句。DROP UNDOFILE目前不支持
任何
子句。
笔记
所有 NDB Cluster 磁盘数据对象共享相同的命名空间。这意味着每个磁盘数据对象必须唯一命名（而不仅仅是给定类型的每个磁盘数据对象）。例如，表空间和撤消日志文件不能同名，撤消日志文件和数据文件不能同名。
可选INITIAL_SIZE参数
UNDO以字节为单位设置文件的初始大小；如果未指定，初始大小默认为 134217728 (128 MB)。您可以选择size在一个数量级后跟一个单字母缩写，类似于my.cnf. 通常，这是字母M(megabytes) 或
G(gigabytes) 之一。（错误#13116514、错误#16104705、错误#62858）
在 32 位系统上，支持的最大值为
INITIAL_SIZE4294967296 (4 GB)。（漏洞 #29186）
允许的最小值为INITIAL_SIZE1048576 (1 MB)。（漏洞 #29574）
笔记
WAIT被解析但被忽略。此关键字目前没有任何作用，供将来扩展使用。
参数（必填）决定了该ENGINE日志文件组使用的
engine_name存储引擎，为存储引擎的名称。目前，唯一接受的值
engine_name是
“ NDBCLUSTER”和
“ NDB”。这两个值是等价的。
这是一个示例，它假设
lg_3已经使用
CREATE LOGFILE GROUP（请参阅
第 13.1.16 节，“CREATE LOGFILE GROUP 语句”）创建了日志文件组：
ALTER LOGFILE GROUP lg_3
ADD UNDOFILE 'undo_10.dat'
INITIAL_SIZE=32M
ENGINE=NDBCLUSTER;
当ALTER LOGFILE GROUP与ENGINE = NDBCLUSTER（或者，
ENGINE = NDB）一起使用时，将UNDO在每个 NDB Cluster 数据节点上创建一个日志文件。您可以通过查询表来验证UNDO文件是否已创建并获取有关它们的信息
。INFORMATION_SCHEMA.FILES例如：
mysql> SELECT FILE_NAME, LOGFILE_GROUP_NUMBER, EXTRA
-> FROM INFORMATION_SCHEMA.FILES
-> WHERE LOGFILE_GROUP_NAME = 'lg_3';
+-------------+----------------------+----------------+
| FILE_NAME   | LOGFILE_GROUP_NUMBER | EXTRA          |
+-------------+----------------------+----------------+
| newdata.dat |                    0 | CLUSTER_NODE=3 |
| newdata.dat |                    0 | CLUSTER_NODE=4 |
| undo_10.dat |                   11 | CLUSTER_NODE=3 |
| undo_10.dat |                   11 | CLUSTER_NODE=4 |
+-------------+----------------------+----------------+
4 rows in set (0.01 sec)
（参见第 26.3.15 节，“INFORMATION_SCHEMA FILES 表”。）
用于的内存UNDO_BUFFER_SIZE来自全局池，其大小由
SharedGlobalMemory数据节点配置参数的值决定。InitialLogFileGroup这包括数据节点配置参数
的设置为此选项隐含的任何默认值
。
ALTER LOGFILE GROUP仅对 NDB Cluster 的磁盘数据存储有用。有关更多信息，请参阅
第 23.6.10 节，“NDB Cluster 磁盘数据表”。
© Mysql 中文网
