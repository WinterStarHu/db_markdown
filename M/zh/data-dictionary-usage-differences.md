# 14.7 数据字典使用差异_MySQL 8.0 参考手册

14.7 数据字典使用差异_MySQL 8.0 参考手册
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
14.1 数据字典模式
14.2 删除基于文件的元数据存储
14.3 字典数据的事务存储
14.4 字典对象缓存
14.5 INFORMATION_SCHEMA 与数据字典集成
14.6 序列化词典信息（SDI）
14.7 数据字典使用差异
14.8 数据字典限制
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
MySQL 8.0 参考手册  / 第14章MySQL数据字典  /
14.7 数据字典使用差异
14.7 数据字典使用差异
与没有数据字典的服务器相比，使用启用数据字典的 MySQL 服务器需要一些操作差异：
以前，启用
系统变量会阻止仅为存储引擎innodb_read_only创建和删除表
。InnoDB从 MySQL 8.0 开始，启用会
innodb_read_only阻止所有存储引擎的这些操作。任何存储引擎的建表和删除操作都会修改mysql系统数据库中的数据字典表，但这些表使用存储引擎并且在启用InnoDB时无法修改
。innodb_read_only同样的原理也适用于其他需要修改数据字典表的表操作。例子：
ANALYZE TABLE失败，因为它更新了存储在数据字典中的表统计信息。
ALTER TABLE
tbl_name
ENGINE=engine_name
失败，因为它更新了存储在数据字典中的存储引擎名称。
笔记
启用对系统数据库innodb_read_only
中的非数据字典表也有重要影响。mysql详见
第 15.14 节“InnoDB 启动选项和系统变量”innodb_read_only中
的描述
以前，mysql系统数据库中的表对 DML 和 DDL 语句可见。从 MySQL 8.0 开始，数据字典表是不可见的，不能直接修改或查询。但是，在大多数情况下INFORMATION_SCHEMA
，可以查询相应的表。这使得底层数据字典表能够随着服务器开发的进行而改变，同时保持
INFORMATION_SCHEMA应用程序使用的稳定接口。
INFORMATION_SCHEMAMySQL 8.0 中的表与数据字典紧密相关，导致一些使用差异：
以前，INFORMATION_SCHEMA查询
STATISTICS和
表中的TABLES表统计信息直接从存储引擎中检索统计信息。从 MySQL 8.0 开始，默认使用缓存表统计信息。系统变量定义缓存表统计信息过期之前的
information_schema_stats_expiry
时间段。默认值为 86400 秒（24 小时）。（要随时更新给定表的缓存值，请使用ANALYZE
TABLE.) 如果没有缓存统计信息或统计信息已过期，则在查询表统计信息列时从存储引擎中检索统计信息。要始终直接从存储引擎检索最新统计信息，请设置
information_schema_stats_expiry
为0. 有关详细信息，请参阅
第 8.2.3 节，“优化 INFORMATION_SCHEMA 查询”。
多个INFORMATION_SCHEMA表是数据字典表的视图，这使优化器能够在这些基础表上使用索引。因此，根据优化器的选择，INFORMATION_SCHEMA
查询结果的行顺序可能与以前的结果不同。如果查询结果必须具有特定的行排序特征，请包含一个ORDER BY子句。
对INFORMATION_SCHEMA表的查询可能会返回与早期 MySQL 系列不同的字母大小写的列名。应用程序应该以不区分大小写的方式测试结果集列名。如果这不可行，解决方法是在选择列表中使用列别名，以按要求的字母大小写返回列名。例如：
SELECT TABLE_SCHEMA AS table_schema, TABLE_NAME AS table_name
FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'users';
mysqldump和
mysqlpump不再转储
INFORMATION_SCHEMA数据库，即使在命令行上明确命名也是如此。
CREATE
TABLE dst_tbl LIKE
src_tbl要求它
src_tbl是一个基表，如果它是一个INFORMATION_SCHEMA
基于数据字典表的视图的表，则失败。
以前，从
INFORMATION_SCHEMA表中选择的列的结果集标题使用查询中指定的大写。此查询生成一个标题为 的结果集
table_name：
SELECT table_name FROM INFORMATION_SCHEMA.TABLES;
从 MySQL 8.0 开始，这些标头都是大写的；前面的查询生成一个标题为 的结果集TABLE_NAME。如有必要，可以使用列别名来实现不同的字母大小写。例如：
SELECT table_name AS 'table_name' FROM INFORMATION_SCHEMA.TABLES;
数据目录影响mysqldump
和mysqlpumpmysql从系统数据库
转储信息的
方式：
以前，可以转储
mysql系统数据库中的所有表。从 MySQL 8.0 开始，mysqldump和
mysqlpump仅转储该数据库中的非数据字典表。
以前，在
使用选项时，--routines和
--events选项不需要包括存储的例程和事件
--all-databases：转储包括mysql系统数据库，因此也包括包含存储的例程和事件定义的proc
和表。event从 MySQL 8.0 开始，不使用event和
表。proc相应对象的定义存储在数据字典表中，但不会转储这些表。要在使用创建的转储中包含存储的例程和事件
--all-databases，请使用
--routines和
--events选项明确。
以前，该
--routines选项需要表的SELECT
权限proc。从 MySQL 8.0 开始，该表未被使用；
--routines而是需要全局SELECT权限。
proc以前，可以通过转储和表
来转储存储的例程和事件定义及其创建和修改时间戳
event
。从 MySQL 8.0 开始，不使用这些表，因此无法转储时间戳。
以前，创建包含非法字符的存储例程会产生警告。从 MySQL 8.0 开始，这是一个错误。
© Mysql 中文网
