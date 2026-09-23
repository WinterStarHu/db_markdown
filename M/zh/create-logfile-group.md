# 13.1.16 CREATE LOGFILE GROUP 语句_MySQL 8.0 参考手册

13.1.16 CREATE LOGFILE GROUP 语句_MySQL 8.0 参考手册
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
13.1.16 CREATE LOGFILE GROUP 语句
13.1.16 CREATE LOGFILE GROUP 语句
CREATE LOGFILE GROUP logfile_group
ADD UNDOFILE 'undo_file'
[INITIAL_SIZE [=] initial_size]
[UNDO_BUFFER_SIZE [=] undo_buffer_size]
[REDO_BUFFER_SIZE [=] redo_buffer_size]
[NODEGROUP [=] nodegroup_id]
[WAIT]
[COMMENT [=] 'string']
ENGINE [=] engine_name
此语句创建一个名为的新日志文件组
logfile_group，其中包含一个
UNDO名为“ undo_file”的文件。一个
CREATE LOGFILE GROUP语句只有一个ADD UNDOFILE子句。有关日志文件组命名的规则，请参阅
第 9.2 节，“模式对象名称”。
笔记
所有 NDB Cluster 磁盘数据对象共享相同的命名空间。这意味着每个磁盘数据对象必须唯一命名（而不仅仅是给定类型的每个磁盘数据对象）。例如，表空间和日志文件组不能同名，表空间和数据文件不能同名。
在任何给定时间，每个 NDB Cluster 实例只能有一个日志文件组。
可选INITIAL_SIZE参数设置
UNDO文件的初始大小；如果未指定，则默认为128M（128 兆字节）。可选
UNDO_BUFFER_SIZE参数设置UNDO日志文件组缓冲区使用的大小；默认值为UNDO_BUFFER_SIZE（
8M八兆字节）；该值不能超过可用的系统内存量。这两个参数都以字节为单位指定。您可以选择在其中一个或两个后面加上一个数量级的单字母缩写，类似于my.cnf. 通常，这是字母M（兆字节）或G（千兆字节）之一。
用于的内存UNDO_BUFFER_SIZE来自全局池，其大小由
SharedGlobalMemory数据节点配置参数的值决定。InitialLogFileGroup这包括数据节点配置参数
的设置为此选项隐含的任何默认值
。
允许的最大值为UNDO_BUFFER_SIZE629145600 (600 MB)。
在 32 位系统上，支持的最大值为
INITIAL_SIZE4294967296 (4 GB)。（漏洞 #29186）
允许的最小值为INITIAL_SIZE1048576 (1 MB)。
该ENGINE选项决定了该日志文件组使用的存储引擎，with
engine_name是存储引擎的名称。在 MySQL 8.0 中，这必须是
NDB(or
NDBCLUSTER)。如果
ENGINE未设置，MySQL 会尝试使用
default_storage_engine服务器系统变量指定的引擎（以前称为
storage_engine）。在任何情况下，如果未将引擎指定为NDB或
NDBCLUSTER，则该CREATE
LOGFILE GROUP语句看似成功但实际上无法创建日志文件组，如下所示：
mysql> CREATE LOGFILE GROUP lg1
->     ADD UNDOFILE 'undo.dat' INITIAL_SIZE = 10M;
Query OK, 0 rows affected, 1 warning (0.00 sec)
mysql> SHOW WARNINGS;
+-------+------+------------------------------------------------------------------------------------------------+
| Level | Code | Message                                                                                        |
+-------+------+------------------------------------------------------------------------------------------------+
| Error | 1478 | Table storage engine 'InnoDB' does not support the create option 'TABLESPACE or LOGFILE GROUP' |
+-------+------+------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)
mysql> DROP LOGFILE GROUP lg1 ENGINE = NDB;
ERROR 1529 (HY000): Failed to drop LOGFILE GROUP
mysql> CREATE LOGFILE GROUP lg1
->     ADD UNDOFILE 'undo.dat' INITIAL_SIZE = 10M
->     ENGINE = NDB;
Query OK, 0 rows affected (2.97 sec)
事实上，CREATE LOGFILE GROUP
当一个非存储引擎被命名时，该语句实际上并没有返回错误NDB，而是看起来成功了，这是一个已知问题，我们希望在未来的 NDB Cluster 版本中解决这个问题。
REDO_BUFFER_SIZE、
NODEGROUP、WAIT和
COMMENT被解析但被忽略，因此在 MySQL 8.0 中没有影响。这些选项旨在用于未来的扩展。
与 一起使用时，会在每个 Cluster 数据节点上创建ENGINE [=] NDB一个日志文件组和关联的日志文件。您可以通过查询表UNDO来验证
UNDO文件是否已创建并获取有关它们的信息
。INFORMATION_SCHEMA.FILES例如：
mysql> SELECT LOGFILE_GROUP_NAME, LOGFILE_GROUP_NUMBER, EXTRA
-> FROM INFORMATION_SCHEMA.FILES
-> WHERE FILE_NAME = 'undo_10.dat';
+--------------------+----------------------+----------------+
| LOGFILE_GROUP_NAME | LOGFILE_GROUP_NUMBER | EXTRA          |
+--------------------+----------------------+----------------+
| lg_3               |                   11 | CLUSTER_NODE=3 |
| lg_3               |                   11 | CLUSTER_NODE=4 |
+--------------------+----------------------+----------------+
2 rows in set (0.06 sec)
CREATE LOGFILE GROUP仅对 NDB Cluster 的磁盘数据存储有用。请参阅
第 23.6.10 节，“NDB Cluster 磁盘数据表”。
© Mysql 中文网
