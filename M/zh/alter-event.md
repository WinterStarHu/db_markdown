# 13.1.3 ALTER EVENT 语句_MySQL 8.0 参考手册

13.1.3 ALTER EVENT 语句_MySQL 8.0 参考手册
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
13.1.3 ALTER EVENT 语句
13.1.3 ALTER EVENT 语句
ALTER
[DEFINER = user]
EVENT event_name
[ON SCHEDULE schedule]
[ON COMPLETION [NOT] PRESERVE]
[RENAME TO new_event_name]
[ENABLE | DISABLE | DISABLE ON SLAVE]
[COMMENT 'string']
[DO event_body]
该ALTER EVENT语句更改现有事件的一个或多个特征，而无需删除并重新创建它。每个
DEFINER、ON SCHEDULE、
ON COMPLETION、COMMENT、
ENABLE/DISABLE和
DO子句的语法与与 一起使用时完全相同CREATE EVENT。（请参阅
第 13.1.13 节，“CREATE EVENT 语句”。）
任何用户都可以更改在该用户拥有EVENT权限的数据库上定义的事件。当用户执行成功的ALTER
EVENT语句时，该用户将成为受影响事件的定义者。
ALTER EVENT仅适用于现有事件：
mysql> ALTER EVENT no_such_event
>     ON SCHEDULE
>       EVERY '2:3' DAY_HOUR;
ERROR 1517 (HY000): Unknown event 'no_such_event'
在以下每个示例中，假设命名事件
myevent的定义如下所示：
CREATE EVENT myevent
ON SCHEDULE
EVERY 6 HOUR
COMMENT 'A sample comment.'
DO
UPDATE myschema.mytable SET mycol = mycol + 1;
以下语句将计划
myevent从立即开始的每六小时一次更改为每十二小时一次，从语句运行后的四个小时开始：
ALTER EVENT myevent
ON SCHEDULE
EVERY 12 HOUR
STARTS CURRENT_TIMESTAMP + INTERVAL 4 HOUR;
可以在单个语句中更改事件的多个特征。此示例将执行的 SQL 语句更改为myevent从中删除所有记录
的语句mytable；ALTER EVENT它还会更改事件的计划，使其在该语句运行
一天后执行一次
。ALTER EVENT myevent
ON SCHEDULE
AT CURRENT_TIMESTAMP + INTERVAL 1 DAY
DO
TRUNCATE TABLE myschema.mytable;ALTER
EVENT仅在语句中为您要更改的那些特征
指定选项；省略的选项保留其现有值。这包括任何默认值，CREATE
EVENT例如ENABLE.
要禁用myevent，请使用以下
ALTER EVENT语句：
ALTER EVENT myevent
DISABLE;
该ON SCHEDULE子句可以使用涉及内置 MySQL 函数和用户变量的表达式来获取它包含的任何timestamp或
值。interval您不能在此类表达式中使用存储例程或可加载函数，也不能使用任何表引用；但是，您可以使用SELECT FROM DUAL. 对于
ALTER EVENTand
CREATE EVENT语句都是如此。在这种情况下，对存储例程、可加载函数和表的引用是明确不允许的，并且会因错误而失败（参见错误 #22830）。
尽管
在其子句ALTER EVENT中包含另一个语句的语句似乎成功，但当服务器尝试执行生成的计划事件时，执行会失败并出现错误。
ALTER EVENTDO
要重命名事件，请使用ALTER
EVENT语句的RENAME TO子句。此语句将事件重命名myevent为
yourevent：
ALTER EVENT myevent
RENAME TO yourevent;
您还可以使用
ALTER EVENT ... RENAME TO ...和
db_name.event_name
符号将事件移动到不同的数据库，如下所示：
ALTER EVENT olddb.myevent
RENAME TO newdb.myevent;
要执行前面的语句，执行它的用户必须同时拥有和数据库
的EVENT权限
。olddbnewdb
笔记
没有RENAME EVENT声明。
该值DISABLE ON SLAVE用于副本而不是ENABLE或DISABLE
指示在复制源服务器上创建并复制到副本但不在副本上执行的事件。正常情况下，DISABLE ON SLAVE根据需要自动设置；但是，在某些情况下您可能希望或需要手动更改它。有关详细信息，请参阅
第 17.5.1.16 节，“调用功能的复制”。
© Mysql 中文网
