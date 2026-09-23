# 13.1.22 CREATE TRIGGER 语句_MySQL 8.0 参考手册

13.1.22 CREATE TRIGGER 语句_MySQL 8.0 参考手册
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
13.1.22 CREATE TRIGGER 语句
13.1.22 CREATE TRIGGER 语句
CREATE
[DEFINER = user]
TRIGGER [IF NOT EXISTS] trigger_name
trigger_time trigger_event
ON tbl_name FOR EACH ROW
[trigger_order]
trigger_body
trigger_time: { BEFORE | AFTER }
trigger_event: { INSERT | UPDATE | DELETE }
trigger_order: { FOLLOWS | PRECEDES } other_trigger_name
此语句创建一个新触发器。触发器是与表关联的命名数据库对象，当表发生特定事件时激活。触发器与名为 的表相关联，该表
tbl_name必须引用永久表。您不能将触发器与
TEMPORARY表或视图相关联。
触发器名称存在于模式命名空间中，这意味着所有触发器在模式中必须具有唯一名称。不同模式中的触发器可以具有相同的名称。
IF NOT EXISTS如果同一个表上的同名触发器存在于同一个模式中，则可以防止发生错误。CREATE
TRIGGER从 MySQL 8.0.29 开始
支持此选项。
本节介绍CREATE
TRIGGER语法。有关其他讨论，请参阅
第 25.3.1 节，“触发器语法和示例”。
CREATE TRIGGER需要
TRIGGER与触发器关联的表的特权。如果DEFINER
存在该子句，则所需的权限取决于
user值，如
第 25.6 节“存储对象访问控制”中所述。如果启用二进制日志记录，CREATE TRIGGER可能需要SUPER权限，如第 25.7 节“存储程序二进制日志记录”中所述。
该DEFINER子句确定在触发器激活时检查访问权限时要使用的安全上下文，如本节后面所述。
trigger_time是触发动作时间。它可以是BEFORE或
AFTER表示触发器在要修改的每一行之前或之后激活。
基本列值检查发生在触发器激活之前，因此您不能使用BEFORE触发器将不适合列类型的值转换为有效值。
trigger_event指示激活触发器的操作类型。这些
trigger_event值是允许的：
INSERT：只要有新行插入表中（例如，通过 、 和 语句），触发器INSERT就会
LOAD DATA激活
REPLACE。
UPDATE：只要一行被修改（例如，通过
UPDATE语句），触发器就会激活。
DELETE：只要从表中删除一行（例如，通过
DELETE和
REPLACE语句），触发器就会激活。
DROP TABLE表上的和
TRUNCATE TABLE语句不会激活此触发器，因为它们不使用DELETE. 删除分区也不会激活
DELETE触发器。
trigger_event与其说它代表了一种表操作类型，不如说它代表了激活触发器的一种文字类型的 SQL 语句
。例如，
INSERT触发器不仅对INSERT语句激活，而且
对语句也激活，LOAD DATA因为这两个语句都将行插入到表中。
一个可能令人困惑的例子是INSERT
INTO ... ON DUPLICATE KEY UPDATE ...语法：一个
BEFORE INSERT触发器激活每一行，然后是一个AFTER INSERT触发器或两个触发器BEFORE UPDATE，AFTER
UPDATE这取决于该行是否有重复的键。
笔记
级联的外键操作不会激活触发器。
可以为具有相同触发事件和动作时间的给定表定义多个触发器。例如，您可以BEFORE UPDATE为一个表设置两个触发器。默认情况下，具有相同触发事件和动作时间的触发器按创建顺序激活。要影响触发器顺序，请指定一个trigger_order子句，该子句指示FOLLOWS或
PRECEDES以及也具有相同触发器事件和操作时间的现有触发器的名称。使用
FOLLOWS，新触发器在现有触发器之后激活。使用PRECEDES，新触发器在现有触发器之前激活。
trigger_body是触发器激活时要执行的语句。要执行多个语句，请使用
BEGIN ... END
复合语句构造。这也使您能够使用存储例程中允许的相同语句。请参阅
第 13.6.1 节，“BEGIN ... END 复合语句”。触发器中不允许使用某些语句；参见第 25.8 节，“存储程序的限制”。
OLD在触发器主体中，您可以使用别名和
引用主题表（与触发器关联的表）中的列
NEW。
在更新或删除之前引用现有行的列。
指要插入的新行或更新后的现有行的列。
OLD.col_nameNEW.col_name
触发器不能使用
或用于
引用生成的列。有关生成的列的信息，请参阅第 13.1.20.8 节，“CREATE TABLE 和生成的列”。
NEW.col_nameOLD.col_name
MySQLsql_mode在创建触发器时存储有效的系统变量设置，并始终执行具有此设置的触发器主体，
而不管触发器开始执行时当前服务器 SQL 模式如何。
该DEFINER子句指定在触发器激活时检查访问权限时要使用的 MySQL 帐户。如果DEFINER存在该子句，则该
user值应该是指定为 、 或 的
MySQL
帐户
。允许的
值取决于您拥有的权限，如
第 25.6 节“存储对象访问控制”中所述。另请参阅该部分以获取有关触发器安全性的其他信息。
'user_name'@'host_name'CURRENT_USERCURRENT_USER()user
如果DEFINER省略该子句，则默认定义者是执行该CREATE
TRIGGER语句的用户。这与明确指定相同
DEFINER = CURRENT_USER。
MySQLDEFINER在检查触发器权限时会考虑用户，如下所示：
有时CREATE TRIGGER，发出该语句的用户必须具有
TRIGGER权限。
在触发器激活时，会检查
DEFINER用户的权限。此用户必须具有以下权限：
主题表的TRIGGER权限。
如果使用或
在触发器主体中
SELECT引用表列，则主题表
的权限。OLD.col_nameNEW.col_nameUPDATE如果表列是
触发器主体中分配的
目标，则主题表
的特权。SET NEW.col_name =
value
触发器执行的语句通常需要任何其他特权。
在触发器体内，该
CURRENT_USER函数返回用于在触发器激活时检查权限的帐户。这是DEFINER用户，而不是其操作导致触发器被激活的用户。有关触发器内用户审计的信息，请参阅
第 6.2.23 节，“基于 SQL 的帐户活动审计”。
如果您使用LOCK TABLES锁定具有触发器的表，则触发器中使用的表也会被锁定，如
锁定表和触发器中所述。
有关触发器使用的其他讨论，请参阅
第 25.3.1 节，“触发器语法和示例”。
© Mysql 中文网
