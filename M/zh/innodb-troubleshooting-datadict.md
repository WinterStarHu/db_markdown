# 15.21.4 InnoDB 数据字典操作故障排除_MySQL 8.0 参考手册

15.21.4 InnoDB 数据字典操作故障排除_MySQL 8.0 参考手册
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
15.16 InnoDB 与 MySQL 性能模式的集成
15.17 InnoDB 监视器
15.18 InnoDB备份与恢复
15.19 InnoDB和MySQL复制
15.20 InnoDB 内存缓存插件
15.21 InnoDB 故障排除
15.21.1 排除 InnoDB I/O 问题1
15.21.2 故障排除恢复失败1
15.21.3 强制 InnoDB 恢复1
15.21.4 InnoDB 数据字典操作故障排除1
15.21.5 InnoDB 错误处理1
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.21 InnoDB 故障排除  /
15.21.4 InnoDB 数据字典操作故障排除
15.21.4 InnoDB 数据字典操作故障排除
有关表定义的信息存储在 InnoDB
数据字典中。如果您四处移动数据文件，字典数据可能会变得不一致。
如果数据字典损坏或一致性问题阻止您启动InnoDB，请参阅
第 15.21.3 节，“强制 InnoDB 恢复”以获取有关手动恢复的信息。
无法打开数据文件
启用（默认）后，如果缺少
file-per-table 表
空间文件 ( file)，则innodb_file_per_table
启动时可能会出现以下消息
：.ibd[ERROR] InnoDB: Operating system error number 2 in a file operation.
[ERROR] InnoDB: The error means the system cannot find the path specified.
[ERROR] InnoDB: Cannot open datafile for read-only: './test/t1.ibd' OS error: 71
[Warning] InnoDB: Ignoring tablespace `test/t1` because it could not be opened.
要解决这些消息，请发出DROP
TABLE语句以从数据字典中删除有关缺失表的数据。
恢复孤立文件每表 ibd 文件
此过程描述了如何将孤立
的 file-per-table
.ibd文件恢复到另一个 MySQL 实例。如果系统表空间丢失或不可恢复并且您希望.ibd
在新的 MySQL 实例上恢复文件备份，则可以使用此过程。
一般表空间 .ibd文件
不支持该过程
。
该过程假设您只有
.ibd文件备份，您正在恢复到最初创建孤立
.ibd文件的同一版本的 MySQL，并且
.ibd文件备份是干净的。有关创建干净备份的信息，请参阅
第 15.6.1.4 节，“移动或复制 InnoDB 表”。
第 15.6.1.3 节“导入 InnoDB 表”中
概述的表导入限制
适用于此过程。
在新的 MySQL 实例上，在同名数据库中重新创建表。
mysql> CREATE DATABASE sakila;
mysql> USE sakila;
mysql> CREATE TABLE actor (
actor_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
first_name VARCHAR(45) NOT NULL,
last_name VARCHAR(45) NOT NULL,
last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY  (actor_id),
KEY idx_actor_last_name (last_name)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
丢弃新创建表的表空间。
mysql> ALTER TABLE sakila.actor DISCARD TABLESPACE;
将孤立.ibd文件从备份目录复制到新的数据库目录。
$> cp /backup_directory/actor.ibd path/to/mysql-5.7/data/sakila/
确保该.ibd文件具有必要的文件权限。
导入孤立.ibd文件。发出一条警告，指示InnoDB正在尝试在没有模式验证的情况下导入文件。
mysql> ALTER TABLE sakila.actor IMPORT TABLESPACE; SHOW WARNINGS;
Query OK, 0 rows affected, 1 warning (0.15 sec)
Warning | 1810 | InnoDB: IO Read error: (2, No such file or directory)
Error opening './sakila/actor.cfg', will attempt to import
without schema verification
查询表以验证.ibd
文件是否已成功恢复。
mysql> SELECT COUNT(*) FROM sakila.actor;
+----------+
| count(*) |
+----------+
|      200 |
+----------+
© Mysql 中文网
