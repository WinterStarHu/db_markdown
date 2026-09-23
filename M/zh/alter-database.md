# 13.1.2 ALTER DATABASE 语句_MySQL 8.0 参考手册

13.1.2 ALTER DATABASE 语句_MySQL 8.0 参考手册
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
13.1.2 ALTER DATABASE 语句
13.1.2 ALTER DATABASE 语句
ALTER {DATABASE | SCHEMA} [db_name]
alter_option ...
alter_option: {
[DEFAULT] CHARACTER SET [=] charset_name
| [DEFAULT] COLLATE [=] collation_name
| [DEFAULT] ENCRYPTION [=] {'Y' | 'N'}
| READ ONLY [=] {DEFAULT | 0 | 1}
}
ALTER DATABASE使您能够更改数据库的整体特征。这些特征存储在数据字典中。此语句需要ALTER对数据库的特权。ALTER
SCHEMA是的同义词ALTER
DATABASE。
如果省略数据库名称，则该语句适用于默认数据库。在这种情况下，如果没有默认数据库，则会发生错误。
对于alter_option语句中省略的任何内容，数据库保留其当前选项值，但更改字符集可能会更改排序规则，反之亦然。
字符集和排序规则选项加密选项只读选项
字符集和排序规则选项
该CHARACTER SET选项更改默认数据库字符集。该COLLATE选项更改默认数据库排序规则。有关字符集和排序规则名称的信息，请参阅第 10 章，字符集、排序规则、Unicode。
要查看可用的字符集和排序规则，请分别使用
SHOW CHARACTER SET和
SHOW COLLATION语句。请参阅第 13.7.7.3 节，“SHOW CHARACTER SET 语句”和
第 13.7.7.4 节，“SHOW COLLATION 语句”。
创建例程时使用数据库默认值的存储例程包括这些默认值作为其定义的一部分。（在存储例程中，如果未明确指定字符集或排序规则，则具有字符数据类型的变量使用数据库默认值。请参阅第 13.1.17 节，“CREATE PROCEDURE 和 CREATE FUNCTION 语句”。）如果更改默认字符集或对于数据库的排序规则，必须删除并重新创建任何要使用新默认值的存储例程。
加密选项
该ENCRYPTION选项在 MySQL 8.0.16 中引入，定义了默认的数据库加密，由数据库中创建的表继承。允许的值为'Y'（启用加密）和
'N'（禁用加密）。只有新创建的表才会继承默认的数据库加密。对于与数据库关联的现有表，它们的加密保持不变。如果
table_encryption_privilege_check
启用了系统变量，
TABLE_ENCRYPTION_ADMIN则需要指定与
default_table_encryption系统变量值不同的默认加密设置的权限。有关详细信息，请参阅
为模式和通用表空间定义加密默认值。
只读选项
该READ ONLY选项在 MySQL 8.0.22 中引入，控制是否允许修改数据库和其中的对象。允许的值为
DEFAULTor 0（非只读）和1（只读）。此选项对于数据库迁移很有用，因为READ
ONLY可以将启用的数据库迁移到另一个 MySQL 实例，而无需担心数据库在操作过程中可能会发生更改。
使用 NDB Cluster，使一个mysqld服务器
上的数据库只读
同步到同一集群中的其他
mysqld服务器，以便数据库在所有mysqld
服务器
上变为只读。READ ONLY如果启用，
该选项将显示在INFORMATION_SCHEMA
SCHEMATA_EXTENSIONS表中。请参阅
第 26.3.32 节，“INFORMATION_SCHEMA SCHEMATA_EXTENSIONS 表”。
READ ONLY无法为这些系统架构启用
该选项：
mysql、、
information_schema。
performance_schema
在ALTER DATABASE语句中，
READ ONLY选项与自身的其他实例以及其他选项交互，如下所示：
如果多个实例发生READ
ONLY冲突（例如READ ONLY = 1
READ ONLY = 0），则会发生错误。
即使对于只读数据库，也允许
ALTER DATABASE包含仅（非冲突）选项
的语句。READ
ONLYREAD ONLY如果语句之前或之后数据库的只读状态允许修改，则允许
（非冲突）选项与其他选项的混合。如果之前和之后的只读状态都禁止更改，则会发生错误。
无论数据库是否只读，此语句都会成功：
ALTER DATABASE mydb READ ONLY = 0 DEFAULT COLLATE utf8mb4_bin;
如果数据库不是只读的，则此语句成功，但如果它已经是只读的，则失败：
ALTER DATABASE mydb READ ONLY = 1 DEFAULT COLLATE utf8mb4_bin;
启用READ ONLY会影响数据库的所有用户，但这些例外情况不受只读检查的影响：
服务器在服务器初始化、重新启动、升级或复制过程中执行的语句。
init_file服务器启动时由系统变量
命名的文件中的语句
。
TEMPORARY表格；TEMPORARY可以在只读数据库
中创建、更改、删​​除和写入表。
NDB Cluster 非 SQL 插入和更新。
除了刚刚列出的例外操作，启用
READ ONLY禁止对数据库及其对象（包括它们的定义、数据和元数据）的写操作。以下列表详细说明了受影响的 SQL 语句和操作：
数据库本身：
CREATE DATABASE
ALTER DATABASE（除了改变READ ONLY选项）
DROP DATABASE
意见：
CREATE VIEW
ALTER VIEW
DROP VIEW
从调用具有副作用的函数的视图中进行选择。
更新可更新的视图。
如果在只读数据库中影响视图的元数据（例如，通过使视图有效或无效），则在可写数据库中创建或删除对象的语句将被拒绝。
存储例程：
CREATE PROCEDURE
DROP PROCEDURE
CALL（有副作用的程序）
CREATE FUNCTION
DROP FUNCTION
SELECT（有副作用的函数）
对于过程和函数，只读检查遵循预锁定行为。对于
CALL语句，只读检查是在每个语句的基础上完成的，因此如果某些写入只读数据库的条件执行语句实际上没有执行，调用仍然会成功。另一方面，对于在 aSELECT中调用的函数，函数体的执行发生在预锁定模式下。只要函数中的某条语句写入只读数据库，无论该语句是否实际执行，函数的执行都会失败并出现错误。
触发器：
CREATE TRIGGER
DROP TRIGGER
触发调用。
事件：
CREATE EVENT
ALTER EVENT
DROP EVENT
事件执行：
执行数据库中的事件失败，因为这会更改上次执行时间戳，这是存储在数据字典中的事件元数据。事件执行失败也会导致事件调度程序停止。
如果事件写入只读数据库中的对象，则事件执行失败并出现错误，但事件调度程序不会停止。
表：
CREATE TABLE
ALTER TABLE
CREATE INDEX
DROP INDEX
RENAME TABLE
TRUNCATE TABLE
DROP TABLE
DELETE
INSERT
IMPORT TABLE
LOAD DATA
LOAD XML
REPLACE
UPDATE
对于子表在只读数据库中的级联外键，即使子表没有直接受到影响，对父表的更新和删除也会被拒绝。
对于MERGE诸如 之类的表
CREATE TABLE s1.t(i int) ENGINE MERGE UNION
(s2.t, s3.t), INSERT_METHOD=...，以下行为适用：
如果,
,中至少有一个是只读的，无论插入方法如何，插入
表MERGE( ) 都会失败。插入被拒绝，即使它实际上最终会出现在可写表中。
INSERT into s1.ts1s2s3只要表不是只读
的，删除MERGE表 ( ) 就会成功。允许删除引用只读数据库的表。
DROP TABLE s1.ts1MERGE
语句阻塞，直到所有已经访问正在更改的数据库中的对象的ALTER DATABASE并发事务都已提交。相反，访问数据库中对象的写入事务在并发ALTER DATABASE
块中被更改，直到ALTER DATABASE提交。
如果克隆插件用于克隆本地或远程数据目录，克隆中的数据库将保留它们在源数据目录中的只读状态。只读状态不会影响克隆过程本身。如果不希望在克隆中具有相同的数据库只读状态，则必须在克隆过程完成后使用ALTER DATABASE
对克隆的操作显式更改克隆的选项。
从捐赠者克隆到接受者时，如果接受者的用户数据库是只读的，克隆将失败并显示一条错误消息。使数据库可写后，可以重试克隆。
READ ONLY允许用于
ALTER DATABASE，但不允许用于
CREATE DATABASE。但是，对于只读数据库，由 生成的语句
SHOW CREATE DATABASE确实包含
READ ONLY=1在注释中以指示其只读状态：
mysql> ALTER DATABASE mydb READ ONLY = 1;
mysql> SHOW CREATE DATABASE mydb\G
*************************** 1. row ***************************
Database: mydb
Create Database: CREATE DATABASE `mydb`
/*!40100 DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci */
/*!80016 DEFAULT ENCRYPTION='N' */
/* READ ONLY = 1 */
如果服务器执行CREATE
DATABASE包含此类注释的语句，则服务器将忽略该注释并且READ ONLY不处理该选项。这对
mysqldump和mysqlpump 有影响，它们用于在转储输出
SHOW CREATE DATABASE中生成语句：CREATE DATABASE
在转储文件中，CREATE
DATABASE只读数据库的语句包含注释READ ONLY选项。
转储文件可以像往常一样恢复，但由于服务器忽略了注释READ ONLY选项，因此恢复的数据库不是只读的。如果数据库在恢复后是只读的，则必须ALTER DATABASE手动执行以使其如此。
假设它mydb是只读的并且您将其转储如下：
$> mysqldump --databases mydb > mydb.sqlALTER DATABASE如果
mydb仍应为只读
，则
稍后必须执行恢复操作
：$> mysql
mysql> SOURCE mydb.sql;
mysql> ALTER DATABASE mydb READ ONLY = 1;
MySQL Enterprise Backup 不受此问题的影响。它像任何其他数据库一样备份和恢复只读数据库，但READ
ONLY如果在备份时启用该选项，则在恢复时启用该选项。
ALTER DATABASE被写入二进制日志，因此READ ONLY复制源服务器上的选项更改也会影响副本。为防止这种情况发生，必须在执行ALTER DATABASE
语句之前禁用二进制日志记录。例如，要准备在不影响副本的情况下迁移数据库，请执行以下操作：
在单个会话中，禁用二进制日志记录并
READ ONLY为数据库启用：
mysql> SET sql_log_bin = OFF;
mysql> ALTER DATABASE mydb READ ONLY = 1;
转储数据库，例如，使用
mysqldump或mysqlpump：
$> mysqldump --databases mydb > mydb.sql
在单个会话中，禁用二进制日志记录并禁用
READ ONLY数据库：
mysql> SET sql_log_bin = OFF;
mysql> ALTER DATABASE mydb READ ONLY = 0;
© Mysql 中文网
