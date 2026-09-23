# 13.3.4 SAVEPOINT、ROLLBACK TO SAVEPOINT 和 RELEASE SAVEPOINT 语句_MySQL 8.0 参考手册

13.3.4 SAVEPOINT、ROLLBACK TO SAVEPOINT 和 RELEASE SAVEPOINT 语句_MySQL 8.0 参考手册
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
13.3.4 SAVEPOINT、ROLLBACK TO SAVEPOINT 和 RELEASE SAVEPOINT 语句
13.3.4 SAVEPOINT、ROLLBACK TO SAVEPOINT 和 RELEASE SAVEPOINT 语句
SAVEPOINT identifier
ROLLBACK [WORK] TO [SAVEPOINT] identifier
RELEASE SAVEPOINT identifier
InnoDB支持 SQL 语句
SAVEPOINT,
ROLLBACK TO
SAVEPOINT和
RELEASE
SAVEPOINT可选WORK
关键字 for
ROLLBACK。
该SAVEPOINT语句设置一个名为 的命名事务保存点
identifier。如果当前事务有一个同名的保存点，则删除旧的保存点并设置一个新的保存点。
该ROLLBACK TO
SAVEPOINT语句将事务回滚到指定的保存点而不终止事务。当前事务在设置保存点之后对行所做的修改在回滚中被撤消，但不会InnoDB释放
在保存点之后存储在内存中的行锁。（对于新插入的行，锁信息由该行存储的事务ID携带，锁不单独存储在内存中，此时在undo中释放行锁。）晚于指定保存点的时间将被删除。
如果该ROLLBACK TO
SAVEPOINT语句返回以下错误，则表示不存在具有指定名称的保存点：
ERROR 1305 (42000): SAVEPOINT identifier does not exist
该RELEASE
SAVEPOINT语句从当前事务的保存点集中删除指定的保存点。没有提交或回滚发生。如果保存点不存在则报错。
如果执行COMMIT, 或未
ROLLBACK命名保存点的操作，则当前事务的所有保存点都将被删除。
当调用存储函数或激活触发器时，将创建一个新的保存点级别。先前级别上的保存点变得不可用，因此不会与新级别上的保存点冲突。当函数或触发器终止时，它创建的任何保存点都会被释放，并且会恢复之前的保存点级别。
© Mysql 中文网
