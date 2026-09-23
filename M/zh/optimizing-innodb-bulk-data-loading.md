# 8.5.5 InnoDB 表的批量数据加载_MySQL 8.0 参考手册

8.5.5 InnoDB 表的批量数据加载_MySQL 8.0 参考手册
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
8.5.5 InnoDB 表的批量数据加载
8.5.5 InnoDB 表的批量数据加载
这些性能提示补充了第 8.2.5.1 节“优化 INSERT 语句”中快速插入的一般准则。
将数据导入InnoDB时，关闭自动提交模式，因为它会为每次插入执行日志刷新到磁盘。要在导入操作期间禁用自动提交，请用
SET
autocommitand
COMMIT语句将其括起来：
SET autocommit=0;
... SQL import statements ...
COMMIT;mysqldump选项
--opt创建可以快速导入到表中的转储文件
，即使不使用and
语句
InnoDB
包装它们也是如此
。SET
autocommitCOMMIT
如果您UNIQUE对辅助键有限制，您可以通过在导入会话期间暂时关闭唯一性检查来加速表导入：
SET unique_checks=0;
... SQL import statements ...
SET unique_checks=1;
对于大表，这可以节省大量的磁盘 I/O，因为
InnoDB可以使用它的更改缓冲区来批量写入二级索引记录。确保数据不包含重复键。
如果您FOREIGN KEY的表中有约束，您可以通过在导入会话期间关闭外键检查来加速表导入：
SET foreign_key_checks=0;
... SQL import statements ...
SET foreign_key_checks=1;
对于大表，这可以节省大量磁盘 I/O。
INSERT
如果需要插入多行，
请使用多行语法来减少客户端和服务器之间的通信开销：INSERT INTO yourtable VALUES (1,2), (5,5), ...;
此技巧适用于插入任何表，而不仅仅是
InnoDB表。
在对具有自动递增列的表进行批量插入时，设置
innodb_autoinc_lock_mode为 2（交错）而不是 1（连续）。有关详细信息，请参阅
第 15.6.1.6 节，“InnoDB 中的 AUTO_INCREMENT 处理”。
PRIMARY KEY执行批量插入时，按顺序
插入行会更快
。InnoDB表使用
聚集索引，这使得按PRIMARY KEY. PRIMARY KEY对于不能完全容纳在缓冲池中的表，
按顺序执行批量插入尤为重要。
为了在将数据加载到
InnoDB FULLTEXT索引时获得最佳性能，请遵循以下步骤：
FTS_DOC_ID在表创建时
定义一个类型为 的列BIGINT UNSIGNED NOT
NULL，其唯一索引名为
FTS_DOC_ID_INDEX。例如：
CREATE TABLE t1 (
FTS_DOC_ID BIGINT unsigned NOT NULL AUTO_INCREMENT,
title varchar(255) NOT NULL DEFAULT '',
text mediumtext NOT NULL,
PRIMARY KEY (`FTS_DOC_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE UNIQUE INDEX FTS_DOC_ID_INDEX on t1(FTS_DOC_ID);
将数据加载到表中。
FULLTEXT加载数据后
创建索引。
笔记
在创建表时添加FTS_DOC_ID列时，请确保在
更新索引列FTS_DOC_ID时更新该
列，因为必须随着每个
或
单调增加。如果您选择不在表创建时添加 at 并为您管理 DOC ID，请在下次调用时将其添加
为隐藏列。但是，这种方法需要重建表，这会影响性能。
FULLTEXTFTS_DOC_IDINSERTUPDATEFTS_DOC_IDInnoDBInnoDBFTS_DOC_IDCREATE
FULLTEXT INDEX
如果将数据加载到新ALTER
INSTANCE {ENABLE|DISABLE} INNODB REDO_LOG的 MySQL 实例中，请考虑使用语法禁用重做日志记录
。禁用重做日志记录有助于通过避免重做日志写入来加快数据加载。有关详细信息，请参阅
禁用重做日志记录。
警告
此功能仅用于将数据加载到新的 MySQL 实例中。不要在生产系统上禁用重做日志记录。允许在禁用重做日志记录时关闭并重新启动服务器，但是在禁用重做日志记录时服务器意外停止可能会导致数据丢失和实例损坏。
使用 MySQL Shell 导入数据。MySQL Shell 的并行表导入实用程序util.importTable()
为大型数据文件提供快速数据导入到 MySQL 关系表。MySQL Shell 的转储加载实用程序
util.loadDump()还提供并行加载功能。请参阅MySQL Shell 实用程序。
© Mysql 中文网
