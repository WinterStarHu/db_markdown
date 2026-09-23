# 13.3.5 LOCK INSTANCE FOR BACKUP 和 UNLOCK INSTANCE 语句_MySQL 8.0 参考手册

13.3.5 LOCK INSTANCE FOR BACKUP 和 UNLOCK INSTANCE 语句_MySQL 8.0 参考手册
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
13.3.5 LOCK INSTANCE FOR BACKUP 和 UNLOCK INSTANCE 语句
13.3.5 LOCK INSTANCE FOR BACKUP 和 UNLOCK INSTANCE 语句
LOCK INSTANCE FOR BACKUP
UNLOCK INSTANCE
LOCK INSTANCE FOR BACKUP获取实例级备份锁，允许在线备份期间的 DML，同时防止可能导致快照不一致的操作。
执行该LOCK INSTANCE FOR BACKUP
语句需要BACKUP_ADMIN
特权。当从早期版本执行到 MySQL 8.0 的就地升级时，
该BACKUP_ADMIN
权限会自动授予具有权限的用户
。RELOAD
多个会话可以同时持有备份锁。
UNLOCK INSTANCE释放当前会话持有的备份锁。如果会话终止，会话持有的备份锁也会被释放。
LOCK INSTANCE FOR BACKUP防止文件被创建、重命名或删除。,
, 和帐户管理语句被阻止。参见
第 13.7.1 节，“账户管理声明”。修改未记录在重做日志中的文件的操作也会被阻止。
REPAIR
TABLE TRUNCATE TABLEOPTIMIZE TABLEInnoDBInnoDB
LOCK INSTANCE FOR BACKUP允许仅影响用户创建的临时表的 DDL 操作。实际上，属于用户创建的临时表的文件可以在持有备份锁时创建、重命名或删除。还允许创建二进制日志文件。
PURGE BINARY LOGS当语句对实例有效时不应发出LOCK INSTANCE FOR
BACKUP，因为它通过从服务器中删除文件违反了备份锁的规则。从 MySQL 8.0.28 开始，这是不允许的。
由 获取的备份锁LOCK INSTANCE FOR
BACKUP独立于事务锁和由
获取的锁，并且允许以下语句序列：
FLUSH
TABLES tbl_name [,
tbl_name] ... WITH READ LOCKLOCK INSTANCE FOR BACKUP;
FLUSH TABLES tbl_name [, tbl_name] ... WITH READ LOCK;
UNLOCK TABLES;
UNLOCK INSTANCE;FLUSH TABLES tbl_name [, tbl_name] ... WITH READ LOCK;
LOCK INSTANCE FOR BACKUP;
UNLOCK INSTANCE;
UNLOCK TABLES;
该lock_wait_timeout设置定义LOCK INSTANCE FOR
BACKUP语句在放弃之前等待获取锁的时间量。
© Mysql 中文网
