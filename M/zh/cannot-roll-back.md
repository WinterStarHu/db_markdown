# 13.3.2 不能回滚的语句_MySQL 8.0 参考手册

13.3.2 不能回滚的语句_MySQL 8.0 参考手册
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
13.3.2 不能回滚的语句
13.3.2 不能回滚的语句
有些语句不能回滚。通常，这些包括数据定义语言 (DDL) 语句，例如创建或删除数据库的语句，创建、删除或更改表或存储例程的语句。
你应该设计你的交易不包括这样的声明。如果您在无法回滚的事务早期发出语句，然后另一个语句稍后失败，则在这种情况下无法通过发出
ROLLBACK
语句来回滚事务的全部效果。
© Mysql 中文网
