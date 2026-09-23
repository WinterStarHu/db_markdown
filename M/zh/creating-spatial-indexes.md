# 11.4.10 创建空间索引_MySQL 8.0 参考手册

11.4.10 创建空间索引_MySQL 8.0 参考手册
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
11.1 数值数据类型
11.2 日期和时间数据类型
11.3 字符串数据类型
11.4 空间数据类型
11.4.1 空间数据类型1
11.4.2 OpenGIS 几何模型1
11.4.3 支持的空间数据格式1
11.4.4 几何的良构性和有效性1
11.4.5 空间参考系统支持1
11.4.6 创建空间柱1
11.4.7 填充空间列1
11.4.8 获取空间数据1
11.4.9 优化空间分析1
11.4.10 创建空间索引1
11.4.11 使用空间索引1
11.5 JSON数据类型
11.6 数据类型默认值
11.7 数据类型存储要求
11.8 为列选择正确的类型
11.9 使用来自其他数据库引擎的数据类型
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
MySQL 8.0 参考手册  / 第 11 章数据类型  / 11.4 空间数据类型  /
11.4.10 创建空间索引
11.4.10 创建空间索引
对于InnoDB和MyISAM
表，MySQL 可以使用类似于创建常规索引的语法创建空间索引，但使用
SPATIAL关键字。必须声明空间索引中的列NOT NULL。以下示例演示了如何创建空间索引：
与CREATE TABLE：
CREATE TABLE geom (g GEOMETRY NOT NULL SRID 4326, SPATIAL INDEX(g));
与ALTER TABLE：
CREATE TABLE geom (g GEOMETRY NOT NULL SRID 4326);
ALTER TABLE geom ADD SPATIAL INDEX(g);
与CREATE INDEX：
CREATE TABLE geom (g GEOMETRY NOT NULL SRID 4326);
CREATE SPATIAL INDEX g ON geom (g);
SPATIAL INDEX创建 R 树索引。对于支持空间列的非空间索引的存储引擎，引擎会创建 B 树索引。空间值的 B 树索引对精确值查找很有用，但对范围扫描没有用。
优化器可以使用在受 SRID 限制的列上定义的空间索引。有关详细信息，请参阅
第 11.4.1 节，“空间数据类型”和
第 8.3.3 节，“SPATIAL 索引优化”。
有关索引空间列的更多信息，请参阅
第 13.1.15 节，“CREATE INDEX 语句”。
要删除空间索引，请使用ALTER
TABLEor DROP INDEX：
与ALTER TABLE：
ALTER TABLE geom DROP INDEX g;
与DROP INDEX：
DROP INDEX g ON geom;
示例：假设一个表geom包含 32,000 多个几何图形，这些几何图形存储在
gtype 的列中GEOMETRY。该表还有一个用于存储对象 ID 值
的AUTO_INCREMENT列
。fidmysql> DESCRIBE geom;
+-------+----------+------+-----+---------+----------------+
| Field | Type     | Null | Key | Default | Extra          |
+-------+----------+------+-----+---------+----------------+
| fid   | int(11)  |      | PRI | NULL    | auto_increment |
| g     | geometry |      |     |         |                |
+-------+----------+------+-----+---------+----------------+
2 rows in set (0.00 sec)
mysql> SELECT COUNT(*) FROM geom;
+----------+
| count(*) |
+----------+
|    32376 |
+----------+
1 row in set (0.00 sec)
要在列上添加空间索引g，请使用以下语句：
mysql> ALTER TABLE geom ADD SPATIAL INDEX(g);
Query OK, 32376 rows affected (4.05 sec)
Records: 32376  Duplicates: 0  Warnings: 0
© Mysql 中文网
