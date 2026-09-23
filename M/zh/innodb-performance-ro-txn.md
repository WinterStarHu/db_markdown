# 8.5.3 优化 InnoDB 只读事务_MySQL 8.0 参考手册

8.5.3 优化 InnoDB 只读事务_MySQL 8.0 参考手册
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
8.1 优化概述
8.2 优化SQL语句
8.3 优化和索引
8.4 优化数据库结构
8.5 优化 InnoDB 表
8.5.1 优化 InnoDB 表的存储布局1
8.5.2 优化 InnoDB 事务管理1
8.5.3 优化 InnoDB 只读事务1
8.5.4 优化 InnoDB 重做日志记录1
8.5.5 InnoDB 表的批量数据加载1
8.5.6 优化 InnoDB 查询1
8.5.7 优化 InnoDB DDL 操作1
8.5.8 优化 InnoDB 磁盘 I/O1
8.5.9 优化 InnoDB 配置变量1
8.5.10 为多表系统优化 InnoDB1
8.6 优化 MyISAM 表
8.7 优化 MEMORY 表
8.8 了解查询执行计划
8.9 控制查询优化器
8.10 缓冲和缓存
8.11 优化锁定操作
8.12 优化MySQL服务器
8.13 测量性能（基准测试）
8.14 查看服务器线程（进程）信息
第9章语言结构
第 10 章字符集、排序规则、Unicode
第 11 章数据类型
第 12 章函数和运算符
第 13 章 SQL 语句
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
MySQL 8.0 参考手册  / 第8章优化  / 8.5 优化 InnoDB 表  /
8.5.3 优化 InnoDB 只读事务
8.5.3 优化 InnoDB 只读事务
InnoDB可以避免为已知为只读的事务设置事务 ID（字段）相关的开销。只有可能执行写操作或
锁定读取的事务TRX_ID才需要事务 ID ，例如
. 消除不必要的事务 ID 可以减少每次查询或数据更改语句构造读取视图时查询的内部数据结构的大小。
SELECT ... FOR UPDATE
InnoDB在以下情况下检测只读事务：
事务以
START TRANSACTION
READ ONLY语句开始。在这种情况下，尝试对数据库进行更改（对于InnoDB、
MyISAM或其他类型的表）会导致错误，并且事务将继续处于只读状态：
ERROR 1792 (25006): Cannot execute statement in a READ ONLY transaction.
您仍然可以在只读事务中更改特定于会话的临时表，或为它们发出锁定查询，因为这些更改和锁定对任何其他事务都是不可见的。
开启设置，autocommit保证事务是单语句，组成事务的单语句是“非锁”
SELECT语句。即，
SELECT不使用FOR
UPDATEorLOCK IN SHARED MODE
子句的 a。
事务在没有READ
ONLY选项的情况下启动，但尚未执行明确锁定行的更新或语句。在需要更新或显式锁定之前，事务将保持只读模式。
因此，对于诸如报告生成器之类的读取密集型应用程序，您可以InnoDB
通过将它们分组在
START TRANSACTION READ
ONLYand
中来调整查询序列，或者通过
在运行语句之前COMMIT打开设置，或者简单地避免任何数据更改语句散布在查询中.
autocommitSELECT
有关
START
TRANSACTION和
的信息autocommit，请参阅
第 13.3.1 节，“START TRANSACTION、COMMIT 和 ROLLBACK 语句”。
笔记
符合自动提交、非锁定和只读 (AC-NL-RO) 条件的事务被保留在某些内部
InnoDB数据结构之外，因此不会在
SHOW ENGINE
INNODB STATUS输出中列出。
© Mysql 中文网
