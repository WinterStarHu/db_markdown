# 13.1.10 ALTER TABLESPACE 语句_MySQL 8.0 参考手册

13.1.10 ALTER TABLESPACE 语句_MySQL 8.0 参考手册
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
13.1.10 ALTER TABLESPACE 语句
13.1.10 ALTER TABLESPACE 语句
ALTER [UNDO] TABLESPACE tablespace_name
NDB only:
{ADD | DROP} DATAFILE 'file_name'
[INITIAL_SIZE [=] size]
[WAIT]
InnoDB and NDB:
[RENAME TO tablespace_name]
InnoDB only:
[AUTOEXTEND_SIZE [=] 'value']
[SET {ACTIVE | INACTIVE}]
[ENCRYPTION [=] {'Y' | 'N'}]
InnoDB and NDB:
[ENGINE [=] engine_name]
Reserved for future use:
[ENGINE_ATTRIBUTE [=] 'string']
此语句NDB与
InnoDB表空间一起使用。它可用于向表空间添加新数据文件或从
NDB表空间删除数据文件。它还可用于重命名 NDB Cluster Disk Data 表空间、重命名
InnoDB通用表空间、加密
InnoDB通用表空间或将
InnoDB撤消表空间标记为活动或非活动。
该UNDO关键字在 MySQL 8.0.14 中引入，与SET {ACTIVE | INACTIVE}子句一起用于将InnoDB撤消表空间标记为活动或非活动。有关详细信息，请参阅
第 15.6.3.4 节，“撤消表空间”。
该变体使您能够使用子句
指定磁盘数据表空间ADD DATAFILE的初始大小，其中以字节为单位；默认值为 134217728 (128 MB)。您可以选择
在一个数量级后跟一个单字母缩写，类似于
. 通常，这是字母
(megabytes) 或
(gigabytes) 之一。
NDBINITIAL_SIZEsizesizemy.cnfMG
在 32 位系统上，支持的最大值为
INITIAL_SIZE4294967296 (4 GB)。（漏洞 #29186）
INITIAL_SIZE明确地四舍五入，至于
CREATE TABLESPACE。
数据文件一旦创建，其大小就无法更改；ALTER TABLESPACE ... ADD DATAFILE
但是，您可以使用其他语句
将更多数据文件添加到 NDB 表空间。ALTER TABLESPACE ... ADD DATAFILE与 一起使用时
，在每个 Cluster 数据节点上创建一个数据文件，但在表ENGINE = NDB中只生成一行
。INFORMATION_SCHEMA.FILES有关更多信息，请参阅此表的描述以及
第 23.6.10.1 节，“NDB Cluster Disk Data Objects”。ADD DATAFILE表空间不支持
InnoDB。
使用DROP DATAFILEwith
从 NDB 表空间中ALTER TABLESPACE删除数据文件 ' '。file_name您不能从任何表正在使用的表空间中删除数据文件；换句话说，数据文件必须是空的（没有使用范围）。请参阅
第 23.6.10.1 节，“NDB Cluster 磁盘数据对象”。此外，任何要删除的数据文件之前必须已使用CREATE TABLESPACE
或添加到表空间中ALTER TABLESPACE。DROP
DATAFILE表空间不支持InnoDB
。
WAIT被解析但被忽略。它旨在用于未来的扩展。
指定表空间使用的存储引擎的ENGINE子句已弃用；希望在未来的版本中将其删除。数据字典知道表空间存储引擎，使该ENGINE
子句过时。如果指定了存储引擎，则必须匹配数据字典中定义的表空间存储引擎。engine_name与表空间兼容的唯一值NDB是
NDB和NDBCLUSTER。
RENAME TOautocommit无论设置如何，操作都在模式中隐式执行autocommit。
对于驻留在表空间中的表，
RENAME TO无法执行操作
LOCK TABLES或
对表有效。FLUSH TABLES WITH READ
LOCK
在重命名表空间时，对驻留在通用表空间中的表采用
独占元数据锁，从而防止并发 DDL。支持并发 DML。
重命名通用表空间
需要CREATE TABLESPACE特权。InnoDB
该AUTOEXTEND_SIZE选项定义InnoDB当表空间变满时扩展表空间大小的量。在 MySQL 8.0.23 中引入。该设置必须是 4MB 的倍数。默认设置为 0，这会导致表空间根据隐式默认行为进行扩展。有关详细信息，请参阅
第 15.6.3.9 节，“表空间 AUTOEXTEND_SIZE 配置”。
该子句为
通用表空间或系统表空间ENCRYPTION启用或禁用页级数据加密。MySQL 8.0.13 中引入了对通用表空间的加密支持。MySQL 8.0.16 中引入了
对系统表空间的加密支持
。InnoDBmysqlmysql
在启用加密之前，必须安装和配置密钥环插件。
从 MySQL 8.0.16 开始，如果
table_encryption_privilege_check
启用了该变量，
则需要特权才能使用不同于该
设置TABLE_ENCRYPTION_ADMIN的子句设置来更改通用表空间
。
ENCRYPTIONdefault_table_encryption
如果表空间中的任何表属于用 定义的架构，则为通用表空间启用加密会失败
DEFAULT
ENCRYPTION='N'。同样，如果通用表空间中的任何表属于用定义的架构，则禁用加密会失败DEFAULT
ENCRYPTION='Y'。DEFAULT
ENCRYPTION模式选项是在 MySQL 8.0.16 中引入的
。
如果ALTER TABLESPACE在通用表空间上执行的语句不包含
ENCRYPTION子句，则表空间将保留其当前的加密状态，而不管
default_table_encryption设置如何。
当对通用表空间或mysql系统表空间进行加密时，驻留在该表空间中的所有表都将被加密。同样，在加密表空间中创建的表也是加密的。
在更改通用表空间或系统表空间的属性时使用
该INPLACE算法
。该
算法允许对驻留在表空间中的表进行并发 DML。并发 DDL 被阻止。
ENCRYPTIONmysqlINPLACE
有关更多信息，请参阅
第 15.13 节，“InnoDB 静态数据加密”。
该ENGINE_ATTRIBUTE选项（自 MySQL 8.0.21 起可用）用于指定主存储引擎的表空间属性。该选项保留供将来使用。
允许的值是包含有效
JSON文档或空字符串 ('') 的字符串文字。无效
JSON被拒绝。
ALTER TABLESPACE ts1 ENGINE_ATTRIBUTE='{"key":"value"}';
ENGINE_ATTRIBUTE值可以重复而不会出错。在这种情况下，使用最后指定的值。
ENGINE_ATTRIBUTE服务器不检查值，也不会在表的存储引擎更改时清除它们。
不允许更改 JSON 属性值的单个元素。您只能添加或替换一个属性。
© Mysql 中文网
