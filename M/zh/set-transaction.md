# 13.3.7 SET TRANSACTION语句_MySQL 8.0 参考手册

13.3.7 SET TRANSACTION语句_MySQL 8.0 参考手册
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
13.2 数据操作语句
13.3 事务和锁定语句
13.3.1 START TRANSACTION、COMMIT 和 ROLLBACK 语句1
13.3.2 不能回滚的语句1
13.3.3 导致隐式提交的语句1
13.3.4 SAVEPOINT、ROLLBACK TO SAVEPOINT 和 RELEASE SAVEPOINT 语句1
13.3.5 LOCK INSTANCE FOR BACKUP 和 UNLOCK INSTANCE 语句1
13.3.6 LOCK TABLES 和 UNLOCK TABLES 语句1
13.3.7 SET TRANSACTION语句1
13.3.8 XA 事务1
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
MySQL 8.0 参考手册  / 第 13 章 SQL 语句  / 13.3 事务和锁定语句  /
13.3.7 SET TRANSACTION语句
13.3.7 SET TRANSACTION语句
SET [GLOBAL | SESSION] TRANSACTION
transaction_characteristic [, transaction_characteristic] ...
transaction_characteristic: {
ISOLATION LEVEL level
| access_mode
}
level: {
REPEATABLE READ
| READ COMMITTED
| READ UNCOMMITTED
| SERIALIZABLE
}
access_mode: {
READ WRITE
| READ ONLY
}
该语句指定
事务
特征。它采用以逗号分隔的一个或多个特征值的列表。每个特征值设置事务隔离级别或访问模式。隔离级别用于InnoDB表上的操作。访问模式指定事务是在读/写模式还是只读模式下运行。
此外，SET TRANSACTION可以包括一个可选的GLOBAL或
SESSION关键字来指示语句的范围。
事务隔离级别事务访问模式交易特征范围
事务隔离级别
要设置事务隔离级别，请使用
子句。不允许
在同一语句中指定多个子句。
ISOLATION LEVEL
levelISOLATION LEVELSET
TRANSACTION
默认隔离级别为
REPEATABLE READ. 其他允许的值是READ
COMMITTED、READ
UNCOMMITTED和
SERIALIZABLE。有关这些隔离级别的信息，请参阅
第 15.7.2.1 节，“事务隔离级别”。
事务访问模式
要设置事务访问模式，请使用READ
WRITEorREAD ONLY子句。不允许在同一SET TRANSACTION语句中指定多个访问模式子句。
默认情况下，事务以读/写模式进行，允许对事务中使用的表进行读取和写入。可以使用
SET TRANSACTION访问模式显式指定此模式READ WRITE。
如果事务访问模式设置为READ
ONLY，则禁止更改表。这可能使存储引擎能够在不允许写入时进行性能改进。
在只读模式下，仍然可以TEMPORARY使用 DML 语句更改使用关键字创建的表。不允许使用 DDL 语句进行更改，就像永久表一样。
和访问模式READ WRITE也READ
ONLY可以使用
START
TRANSACTION语句为单个事务指定。
交易特征范围
您可以为当前会话或仅为下一个交易全局设置交易特征：
使用GLOBAL关键字：
该声明在全球范围内适用于所有后续会议。
现有会话不受影响。
使用SESSION关键字：
该语句适用于当前会话中执行的所有后续事务。
该语句在事务中是允许的，但不影响当前正在进行的事务。
如果在事务之间执行，该语句将覆盖任何前面设置命名特征的下一个事务值的语句。
没有任何SESSION或
GLOBAL关键字：
该语句仅适用于会话中执行的下一个事务。
后续事务恢复使用指定特征的会话值。
交易中不允许使用以下语句：
mysql> START TRANSACTION;
Query OK, 0 rows affected (0.02 sec)
mysql> SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
ERROR 1568 (25001): Transaction characteristics can't be changed
while a transaction is in progress
对全局事务特征的更改需要
CONNECTION_ADMIN特权（或已弃用的SUPER特权）。任何会话都可以自由更改其会话特征（即使在事务的中间）或其下一个事务的特征（在该事务开始之前）。
要在服务器启动时设置全局隔离级别，请
在命令行或选项文件中使用该选项。此选项的值
使用破折号而不是空格，因此允许的值为
、
、
或
。
--transaction-isolation=levellevelREAD-UNCOMMITTEDREAD-COMMITTEDREPEATABLE-READSERIALIZABLE
同样，要在服务器启动时设置全局事务访问模式，请使用该
--transaction-read-only选项。默认值为OFF（读/写模式），但该值可以设置ON为只读模式。
例如，要将隔离级别设置为
REPEATABLE READ并将访问模式设置为，请在选项文件的部分中
READ WRITE使用以下行：[mysqld][mysqld]
transaction-isolation = REPEATABLE-READ
transaction-read-only = OFF
在运行时，可以使用
SET TRANSACTION语句间接设置全局、会话和下一个事务范围级别的特征，如前所述。它们也可以直接使用
SET
语句来设置，为
transaction_isolation和
transaction_read_only系统变量赋值：
SET TRANSACTION允许在不同范围级别设置事务特征的可选GLOBAL和
SESSION关键字。
SET
为
transaction_isolation和
系统变量赋值
的
语句transaction_read_only
具有在不同范围级别设置这些变量的语法。
下表显示了每个SET TRANSACTION语法和变量赋值语法设置的特征范围级别。
表 13.9 事务特征的 SET TRANSACTION 语法
句法
受影响的特性范围
SET GLOBAL TRANSACTION
transaction_characteristic
全球的
SET SESSION TRANSACTION
transaction_characteristic
会议
SET TRANSACTION
transaction_characteristic
仅下一次交易
表 13.10 事务特征的 SET 语法
句法
受影响的特性范围
SET GLOBAL var_name =
value
全球的
SET @@GLOBAL.var_name =
value
全球的
SET PERSIST var_name =
value
全球的
SET @@PERSIST.var_name =
value
全球的
SET PERSIST_ONLY var_name =
value
无运行时效果
SET @@PERSIST_ONLY.var_name =
value
无运行时效果
SET SESSION var_name =
value
会议
SET @@SESSION.var_name =
value
会议
SET var_name =
value
会议
SET @@var_name =
value
仅下一次交易
可以在运行时检查事务特征的全局值和会话值：
SELECT @@GLOBAL.transaction_isolation, @@GLOBAL.transaction_read_only;
SELECT @@SESSION.transaction_isolation, @@SESSION.transaction_read_only;
© Mysql 中文网
