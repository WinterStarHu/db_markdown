# 13.1.1 原子数据定义语句支持_MySQL 8.0 参考手册

13.1.1 原子数据定义语句支持_MySQL 8.0 参考手册
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
13.1.1 原子数据定义语句支持
13.1.1 原子数据定义语句支持
MySQL 8.0 支持原子数据定义语言 (DDL) 语句。此功能称为原子 DDL。原子 DDL 语句将与 DDL 操作关联的数据字典更新、存储引擎操作和二进制日志写入组合到单个原子操作中。操作要么提交，将适用的更改持久保存到数据字典、存储引擎和二进制日志，要么回滚，即使服务器在操作期间停止。
笔记
原子 DDL不是事务性 DDL。DDL 语句，无论是原子语句还是其他语句，都会隐式结束当前会话中处于活动状态的任何事务，就好像您COMMIT在执行该语句之前已经完成了操作一样。这意味着 DDL 语句不能在另一个事务中执行，不能在事务控制语句（例如 ）中执行，也不能
START TRANSACTION ...
COMMIT与同一事务中的其他语句结合使用。
通过在 MySQL 8.0 中引入 MySQL 数据字典，原子 DDL 成为可能。在早期的 MySQL 版本中，元数据存储在元数据文件、非事务表和特定于存储引擎的字典中，这需要中间提交。MySQL 数据字典提供的集中式事务性元数据存储消除了这一障碍，使得将 DDL 语句操作重构为原子操作成为可能。
原子 DDL 功能在本节的以下主题下进行了描述：
支持的 DDL 语句原子 DDL 特征DDL 语句行为的变化存储引擎支持查看 DDL 日志
支持的 DDL 语句
原子 DDL 功能支持表和非表 DDL 语句。与表相关的 DDL 操作需要存储引擎支持，而非表的 DDL 操作则不需要。目前只有InnoDB存储引擎支持原子 DDL。
支持的表 DDL 语句包括
数据库CREATE、表空间、表和索引的 、 和语句，以及
ALTER语句
。
DROPTRUNCATE TABLE
支持的非表 DDL 语句包括：
CREATE和DROP
语句，以及（如果适用）ALTER
存储程序、触发器、视图和可加载函数的语句。
帐户管理报表：
CREATE、ALTER、
DROP和（如果适用）
RENAME用户和角色的报表，以及GRANT
和REVOKE报表。
原子 DDL 功能不支持以下语句：
涉及 . 以外的存储引擎的表相关 DDL 语句InnoDB。
INSTALL PLUGIN和
UNINSTALL PLUGIN
声明。
INSTALL COMPONENT和
UNINSTALL COMPONENT
声明。
CREATE SERVER,
ALTER SERVER, 和
DROP SERVER语句。
原子 DDL 特征
原子 DDL 语句的特征包括：
元数据更新、二进制日志写入和存储引擎操作（如果适用）被组合到一个原子操作中。
在 DDL 操作期间，SQL 层没有中间提交。
适用时：
数据字典、例程、事件和可加载函数缓存的状态与 DDL 操作的状态一致，这意味着更新缓存以反映 DDL 操作是成功完成还是回滚。
DDL 操作中涉及的存储引擎方法不执行中间提交，存储引擎将自身注册为 DDL 操作的一部分。
存储引擎支持DDL操作的重做和回滚，在DDL操作的
Post-DDL阶段进行。
DDL操作的可见行为是原子的，它改变了一些DDL语句的行为。请参阅
DDL 语句行为的变化。
DDL 语句行为的变化
本节介绍由于引入原子 DDL 支持而导致的 DDL 语句行为的变化。
DROP TABLE如果所有命名表都使用支持原子 DDL 的存储引擎，则操作是完全原子的。该语句要么成功删除所有表，要么被回滚。
DROP TABLE如果命名表不存在，则失败并出现错误，并且无论存储引擎如何，都不会进行任何更改。下面的示例演示了这种行为更改，其中
DROP TABLE语句失败是因为命名表不存在：
mysql> CREATE TABLE t1 (c1 INT);
mysql> DROP TABLE t1, t2;
ERROR 1051 (42S02): Unknown table 'test.t2'
mysql> SHOW TABLES;
+----------------+
| Tables_in_test |
+----------------+
| t1             |
+----------------+
在引入原子DDL之前，
DROP TABLE对不存在的命名表报错，对存在的命名表成功：
mysql> CREATE TABLE t1 (c1 INT);
mysql> DROP TABLE t1, t2;
ERROR 1051 (42S02): Unknown table 'test.t2'
mysql> SHOW TABLES;
Empty set (0.00 sec)
笔记
由于这种行为变化，
DROP TABLEMySQL 5.7 复制源服务器上部分完成的语句在 MySQL 8.0 副本上复制时会失败。为避免这种故障情况，请IF EXISTS在语句中使用语法
DROP TABLE来防止针对不存在的表发生错误。
DROP DATABASE如果所有表都使用支持原子 DDL 的存储引擎，则它是原子的。该语句要么成功删除所有对象，要么被回滚。但是，从文件系统中删除数据库目录是最后发生的，不是原子操作的一部分。如果由于文件系统错误或服务器停止而导致删除数据库目录失败，
DROP DATABASE则不会回滚事务。
对于不使用支持原子 DDL 的存储引擎的表，表删除发生在原子
DROP TABLE或
DROP DATABASE事务之外。这样的表删除是单独写入二进制日志的，这就限制了在中断
DROP TABLE或
DROP DATABASE操作的情况下，存储引擎、数据字典和二进制日志之间的差异最多只能写入一张表。对于删除多个表的操作，不使用支持原子 DDL 的存储引擎的表将在使用的表之前被删除。
CREATE TABLE,
ALTER TABLE,
RENAME TABLE,
TRUNCATE TABLE,
CREATE TABLESPACE和
DROP TABLESPACE使用支持原子 DDL 的存储引擎的表的操作要么完全提交，要么在服务器在操作期间停止时回滚。在早期的 MySQL 版本中，这些操作的中断可能会导致存储引擎、数据字典和二进制日志之间存在差异，或者留下孤立文件。RENAME
TABLE只有所有命名表都使用支持原子 DDL 的存储引擎时，操作才是原子的。
从 MySQL 8.0.21 开始，在支持原子 DDL 的存储引擎上，
CREATE
TABLE ... SELECT当使用基于行的复制时，语句在二进制日志中记录为一个事务。以前，它被记录为两个事务，一个用于创建表，另一个用于插入数据。两个事务之间或插入数据时的服务器故障可能导致复制空表。随着原子 DDL 支持的引入，
CREATE
TABLE ... SELECT语句现在对于基于行的复制是安全的，并且允许与基于 GTID 的复制一起使用。
在同时支持原子 DDL 和外键约束的存储引擎上，当使用基于行的复制时，不允许在
CREATE
TABLE ... SELECT语句中创建外键。稍后可以使用添加外键约束ALTER TABLE。
当
CREATE
TABLE ... SELECT作为原子操作应用时，在插入数据时会在表上持有元数据锁，这会阻止在操作期间对表进行并发访问。
DROP VIEW如果命名视图不存在且未进行任何更改，则失败。此示例演示了行为的变化，其中
DROP VIEW语句失败是因为命名视图不存在：
mysql> CREATE VIEW test.viewA AS SELECT * FROM t;
mysql> DROP VIEW test.viewA, test.viewB;
ERROR 1051 (42S02): Unknown table 'test.viewB'
mysql> SHOW FULL TABLES IN test WHERE TABLE_TYPE LIKE 'VIEW';
+----------------+------------+
| Tables_in_test | Table_type |
+----------------+------------+
| viewA          | VIEW       |
+----------------+------------+
在引入原子 DDL 之前，
DROP VIEW为不存在的命名视图返回错误，但为存在的命名视图返回成功：
mysql> CREATE VIEW test.viewA AS SELECT * FROM t;
mysql> DROP VIEW test.viewA, test.viewB;
ERROR 1051 (42S02): Unknown table 'test.viewB'
mysql> SHOW FULL TABLES IN test WHERE TABLE_TYPE LIKE 'VIEW';
Empty set (0.00 sec)
笔记
由于这种行为变化，
DROP VIEW在 MySQL 5.7 复制源服务器上部分完成的操作在 MySQL 8.0 副本上复制时会失败。为避免这种失败情况，请IF EXISTS在语句中使用语法
DROP VIEW来防止不存在的视图发生错误。
不再允许部分执行账户管理报表。帐户管理语句要么对所有指定用户成功，要么回滚并且在发生错误时无效。在早期的 MySQL 版本中，命名多个用户的帐户管理语句可能对某些用户成功而对其他用户失败。
此示例演示了行为的变化，其中第二条CREATE USER
语句返回错误但失败，因为它无法对所有指定用户成功。
mysql> CREATE USER userA;
mysql> CREATE USER userA, userB;
ERROR 1396 (HY000): Operation CREATE USER failed for 'userA'@'%'
mysql> SELECT User FROM mysql.user WHERE User LIKE 'user%';
+-------+
| User  |
+-------+
| userA |
+-------+
在引入原子 DDL 之前，第二条
CREATE USER语句为不存在的命名用户返回错误，但为存在的命名用户返回成功：
mysql> CREATE USER userA;
mysql> CREATE USER userA, userB;
ERROR 1396 (HY000): Operation CREATE USER failed for 'userA'@'%'
mysql> SELECT User FROM mysql.user WHERE User LIKE 'user%';
+-------+
| User  |
+-------+
| userA |
| userB |
+-------+
笔记
由于这种行为变化，MySQL 5.7 复制源服务器上部分完成的帐户管理语句在 MySQL 8.0 副本上复制时会失败。为避免这种失败情况，请在帐户管理语句中酌情使用IF
EXISTS或IF NOT EXISTS
语法，以防止与命名用户相关的错误。
存储引擎支持
目前只有InnoDB存储引擎支持原子 DDL。不支持原子 DDL 的存储引擎不受 DDL 原子性的约束。涉及豁免存储引擎的 DDL 操作仍然能够引入操作中断或仅部分完成时可能发生的不一致。
为了支持DDL操作的重做和回滚，
InnoDB将DDL日志写入到
mysql.innodb_ddl_log表中，该表是驻留在
mysql.ibd数据字典表空间中的隐藏数据字典表。
要查看在 DDL 操作期间写入
mysql.innodb_ddl_log表的 DDL 日志，请启用
innodb_print_ddl_logs
配置选项。有关详细信息，请参阅
查看 DDL 日志。
笔记
mysql.innodb_ddl_log无论设置如何，表
更改的重做日志
都会立即刷新到磁盘innodb_flush_log_at_trx_commit
。立即刷新重做日志避免了数据文件被 DDL 操作修改但
mysql.innodb_ddl_log由这些操作导致的表更改的重做日志不会持久保存到磁盘的情况。这种情况可能会导致回滚或恢复期间出错。
InnoDB存储引擎分阶段执行 DDL 操作
。DDL 操作
ALTER TABLE可能会
在Commit阶段
之前多次执行Prepare和Perform阶段
。
准备：创建所需的对象并将 DDL 日志写入
mysql.innodb_ddl_log表。DDL 日志定义了如何前滚和回滚 DDL 操作。
执行：执行 DDL 操作。例如，执行CREATE
TABLE操作的创建例程。
提交：更新数据字典并提交数据字典事务。
Post-DDL：重放并从mysql.innodb_ddl_log表中删除 DDL 日志。为了确保可以安全地执行回滚而不引入不一致，在这个最后阶段执行文件操作，例如重命名或删除数据文件。mysql.innodb_dynamic_metadata此阶段还从数据字典表中删除动态元
DROP
TABLE、TRUNCATE
TABLE和其他重建表的 DDL 操作。
无论 DDL 操作是提交还是回滚， DDL 日志都会在Post-DDL阶段
重放并从
mysql.innodb_ddl_log表中
删除。只有当服务器在 DDL 操作期间停止时，DDL 日志才应保留在表中。在这种情况下，DDL 日志会在恢复后重放并删除。
mysql.innodb_ddl_log
在恢复情况下，DDL 操作可能会在服务器重新启动时提交或回滚。如果在 DDL 操作的提交阶段执行的数据字典事务
存在于重做日志和二进制日志中，则认为该操作成功并前滚。否则，在重放数据字典重做日志时回滚不完整的数据字典事务，回滚
InnoDBDDL操作。
查看 DDL 日志
mysql.innodb_ddl_log查看涉及
InnoDB存储引擎
的原子DDL操作时
写入
数据字典表的DDL日志，开启innodb_print_ddl_logsMySQL将DDL日志写入stderr. 根据主机操作系统和 MySQL 配置，
stderr可能是错误日志、终端或控制台窗口。请参阅
第 5.4.2.2 节，“默认错误日志目标配置”。
InnoDB将DDL日志写入
mysql.innodb_ddl_log表中，支持DDL操作的重做和回滚。该
mysql.innodb_ddl_log表是驻留在
mysql.ibd数据字典表空间中的隐藏数据字典表。与其他隐藏数据字典表一样，该
mysql.innodb_ddl_log表不能在非调试版本的 MySQL 中直接访问。（请参阅
第 14.1 节，“数据字典模式”。）
mysql.innodb_ddl_log表的结构对应于此定义：
CREATE TABLE mysql.innodb_ddl_log (
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
thread_id BIGINT UNSIGNED NOT NULL,
type INT UNSIGNED NOT NULL,
space_id INT UNSIGNED,
page_no INT UNSIGNED,
index_id BIGINT UNSIGNED,
table_id BIGINT UNSIGNED,
old_file_path VARCHAR(512) COLLATE utf8mb4_bin,
new_file_path VARCHAR(512) COLLATE utf8mb4_bin,
KEY(thread_id)
);
id：DDL 日志记录的唯一标识符。
thread_id: 每条 DDL 日志记录都分配了一个thread_id, 用于重放和删除属于特定 DDL 操作的 DDL 日志。涉及多个数据文件操作的DDL操作会产生多条DDL日志记录。
type: DDL 操作类型。类型包括FREE（删除索引树）、
DELETE（删除文件）、
RENAME（重命名文件）或
DROP（从
mysql.innodb_dynamic_metadata数据字典表中删除元数据）。
space_id：表空间ID。
page_no：包含分配信息的页面；例如，索引树根页面。
index_id: 索引 ID。
table_id：表ID。
old_file_path: 旧的表空间文件路径。由创建或删除表空间文件的 DDL 操作使用；也被重命名表空间的 DDL 操作使用。
new_file_path: 新的表空间文件路径。由重命名表空间文件的 DDL 操作使用。
此示例演示如何启用
查看为
操作innodb_print_ddl_logs写入的 DDL 日志。
strderrCREATE TABLEmysql> SET GLOBAL innodb_print_ddl_logs=1;
mysql> CREATE TABLE t1 (c1 INT) ENGINE = InnoDB;[Note] [000000] InnoDB: DDL log insert : [DDL record: DELETE SPACE, id=18, thread_id=7,
space_id=5, old_file_path=./test/t1.ibd]
[Note] [000000] InnoDB: DDL log delete : by id 18
[Note] [000000] InnoDB: DDL log insert : [DDL record: REMOVE CACHE, id=19, thread_id=7,
table_id=1058, new_file_path=test/t1]
[Note] [000000] InnoDB: DDL log delete : by id 19
[Note] [000000] InnoDB: DDL log insert : [DDL record: FREE, id=20, thread_id=7,
space_id=5, index_id=132, page_no=4]
[Note] [000000] InnoDB: DDL log delete : by id 20
[Note] [000000] InnoDB: DDL log post ddl : begin for thread id : 7
[Note] [000000] InnoDB: DDL log post ddl : end for thread id : 7
© Mysql 中文网
