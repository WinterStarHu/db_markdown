# 3.4 获取有关数据库和表的信息_MySQL 8.0 参考手册

3.4 获取有关数据库和表的信息_MySQL 8.0 参考手册
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
3.1 连接和断开服务器
3.2 输入查询
3.3 创建和使用数据库
3.4 获取有关数据库和表的信息
3.5 在批处理模式下使用 mysql
3.6 常见查询示例
3.7 在 Apache 中使用 MySQL
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
MySQL 8.0 参考手册  / 第 3 章教程  /
3.4 获取有关数据库和表的信息
3.4 获取有关数据库和表的信息
如果您忘记了数据库或表的名称，或者给定表的结构是什么（例如，它的列叫什么）怎么办？MySQL 通过提供有关它支持的数据库和表的信息的几个语句来解决这个问题。
您之前已经看到SHOW
DATABASES，其中列出了服务器管理的数据库。要找出当前选择了哪个数据库，请使用以下
DATABASE()函数：
mysql> SELECT DATABASE();
+------------+
| DATABASE() |
+------------+
| menagerie  |
+------------+
如果您尚未选择任何数据库，则结果为
NULL。
要找出默认数据库包含哪些表（例如，当您不确定表名时），请使用以下语句：
mysql> SHOW TABLES;
+---------------------+
| Tables_in_menagerie |
+---------------------+
| event               |
| pet                 |
+---------------------+
此语句生成的输出中列的名称始终为
，其中是数据库的名称。有关详细信息，请参阅第 13.7.7.39 节，“SHOW TABLES 语句”。
Tables_in_db_namedb_name
如果你想了解一个表的结构，
DESCRIBE语句是有用的；它显示有关表的每个列的信息：
mysql> DESCRIBE pet;
+---------+-------------+------+-----+---------+-------+
| Field   | Type        | Null | Key | Default | Extra |
+---------+-------------+------+-----+---------+-------+
| name    | varchar(20) | YES  |     | NULL    |       |
| owner   | varchar(20) | YES  |     | NULL    |       |
| species | varchar(20) | YES  |     | NULL    |       |
| sex     | char(1)     | YES  |     | NULL    |       |
| birth   | date        | YES  |     | NULL    |       |
| death   | date        | YES  |     | NULL    |       |
+---------+-------------+------+-----+---------+-------+
Field表示列名，
Type是该列的数据类型，
NULL表示该列是否可以包含
NULL值，Key表示该列是否被索引，并Default
指定该列的默认值。Extra
显示有关列的特殊信息：如果列是使用该AUTO_INCREMENT选项创建的，则该值auto_increment不是空的。
DESC是 的缩写形式
DESCRIBE。有关更多信息，请参阅
第 13.8.1 节，“DESCRIBE 语句”。
您可以获得CREATE TABLE
使用该语句创建现有表所需的
SHOW CREATE TABLE语句。参见
第 13.7.7.10 节，“SHOW CREATE TABLE 语句”。
如果您在表上有索引，则生成有关它们的信息。有关此语句的更多信息，请参阅第 13.7.7.22 节，“SHOW INDEX 语句”。
SHOW INDEX FROM
tbl_name
© Mysql 中文网
