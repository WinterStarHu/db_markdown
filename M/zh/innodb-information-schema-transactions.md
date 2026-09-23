# 15.15.2 InnoDB INFORMATION_SCHEMA 事务和锁定信息_MySQL 8.0 参考手册

15.15.2 InnoDB INFORMATION_SCHEMA 事务和锁定信息_MySQL 8.0 参考手册
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
第14章MySQL数据字典
第 15 章 InnoDB 存储引擎
15.1 InnoDB简介
15.2 InnoDB 和 ACID 模型
15.3 InnoDB 多版本
15.4 InnoDB架构
15.5 InnoDB 内存结构
15.6 InnoDB 磁盘结构
15.7 InnoDB 锁定和事务模型
15.8 InnoDB配置
15.9 InnoDB 表和页压缩
15.10 InnoDB 行格式
15.11 InnoDB磁盘I/O和文件空间管理
15.12 InnoDB和在线DDL
15.13 InnoDB静态数据加密
15.14 InnoDB 启动选项和系统变量
15.15 InnoDB INFORMATION_SCHEMA 表
15.15.1 InnoDB INFORMATION_SCHEMA 表压缩1
15.15.2 InnoDB INFORMATION_SCHEMA 事务和锁定信息1
15.15.2.1 使用 InnoDB 事务和锁定信息
15.15.2.2 InnoDB 锁定和锁定等待信息
15.15.2.3 InnoDB事务和锁定信息的持久化和一致性
15.15.3 InnoDB INFORMATION_SCHEMA 模式对象表1
15.15.4 InnoDB INFORMATION_SCHEMA FULLTEXT 索引表1
15.15.5 InnoDB INFORMATION_SCHEMA 缓冲池表1
15.15.6 InnoDB INFORMATION_SCHEMA 指标表1
15.15.7 InnoDB INFORMATION_SCHEMA临时表信息表1
15.15.8 从 INFORMATION_SCHEMA.FILES 检索 InnoDB 表空间元数据1
15.16 InnoDB 与 MySQL 性能模式的集成
15.17 InnoDB 监视器
15.18 InnoDB备份与恢复
15.19 InnoDB和MySQL复制
15.20 InnoDB 内存缓存插件
15.21 InnoDB 故障排除
15.22 InnoDB 限制
15.23 InnoDB 限制和限制
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.15 InnoDB INFORMATION_SCHEMA 表  /
15.15.2 InnoDB INFORMATION_SCHEMA 事务和锁定信息
15.15.2 InnoDB INFORMATION_SCHEMA 事务和锁定信息
15.15.2.1 使用 InnoDB 事务和锁定信息15.15.2.2 InnoDB 锁定和锁定等待信息15.15.2.3 InnoDB事务和锁定信息的持久化和一致性
笔记
本节描述了性能模式data_locks和
data_lock_waits表公开的锁定信息，它们取代了MySQL 8.0 中的INFORMATION_SCHEMA
INNODB_LOCKS和
INNODB_LOCK_WAITS表。有关根据旧INFORMATION_SCHEMA表编写的类似讨论，请参阅
MySQL 5.7 参考手册中的InnoDB INFORMATION_SCHEMA 事务和锁定信息。
一个INFORMATION_SCHEMA表和两个 Performance Schema 表使您能够监控
InnoDB事务并诊断潜在的锁定问题：
INNODB_TRX：该
INFORMATION_SCHEMA表提供了当前在其中执行的每个事务的信息
InnoDB，包括事务状态（例如，它是在运行还是在等待锁）、事务何时开始以及事务正在执行的特定 SQL 语句。
data_locks：此 Performance Schema 表包含每个持有锁的行和每个被阻止等待释放持有的锁的锁请求：
INNODB_TRX.TRX_STATE无论持有锁的事务处于什么状态（是
RUNNING、或
）
LOCK WAIT，
每个持有的锁都有一行。ROLLING BACKCOMMITTING
InnoDB 中等待另一个事务释放锁的每个事务 ( INNODB_TRX.TRX_STATEis LOCK
WAIT) 都被恰好一个阻塞锁请求阻塞。该阻塞锁请求是针对另一个事务在不兼容模式下持有的行或表锁。锁定请求的模式始终与阻止请求的持有锁的模式不兼容（读与写，共享与独占）。
在另一个事务提交或回滚，从而释放请求的锁之前，被阻塞的事务无法继续。对于每个阻塞的事务，
data_locks包含一行描述事务请求的每个锁，以及它正在等待的锁。
data_lock_waits：此性能模式表指示哪些事务正在等待给定的锁，或者给定的事务正在等待哪个锁。该表包含每个阻塞事务的一行或多行，指示它已请求的锁以及阻塞该请求的任何锁。该
REQUESTING_ENGINE_LOCK_ID值是指一个事务请求的锁，该
BLOCKING_ENGINE_LOCK_ID值是指阻止第一个事务继续进行的锁（由另一个事务持有）。对于任何给定的阻塞事务，中的所有行都
data_lock_waits具有相同的值REQUESTING_ENGINE_LOCK_ID和不同的值
BLOCKING_ENGINE_LOCK_ID。
有关前面表的更多信息，请参阅
第 26.4.28 节，“INFORMATION_SCHEMA INNODB_TRX 表”，
第 27.12.13.1 节，“data_locks 表”和
第 27.12.13.2 节，“data_lock_waits 表”。
© Mysql 中文网
