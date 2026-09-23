# 7.4.2 重新加载 SQL 格式的备份_MySQL 8.0 参考手册

7.4.2 重新加载 SQL 格式的备份_MySQL 8.0 参考手册
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
7.1 备份和恢复类型
7.2 数据库备份方式
7.3 示例备份和恢复策略
7.4 使用 mysqldump 进行备份
7.4.1 使用 mysqldump 转储 SQL 格式的数据1
7.4.2 重新加载 SQL 格式的备份1
7.4.3 使用 mysqldump 以定界文本格式转储数据1
7.4.4 重新加载定界文本格式备份1
7.4.5 mysqldump 提示1
7.5 时间点（增量）恢复
7.6 MyISAM表维护和崩溃恢复
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
MySQL 8.0 参考手册  / 第 7 章备份与恢复  / 7.4 使用 mysqldump 进行备份  /
7.4.2 重新加载 SQL 格式的备份
7.4.2 重新加载 SQL 格式的备份
要重新加载由mysqldump
编写的包含 SQL 语句的转储文件
，请将其用作
mysql客户端的输入。如果转储文件是由
mysqldump使用
--all-databasesor
--databases选项创建的，它包含CREATE DATABASE和
USE语句，并且没有必要指定要加载数据的默认数据库：
$> mysql < dump.sql
或者，从mysql中使用
source命令：
mysql> source dump.sqlCREATE DATABASE如果文件是不包含and
语句
的单数据库转储
USE，请先创建数据库（如有必要）：
$> mysqladmin create db1
然后在加载转储文件时指定数据库名称：
$> mysql db1 < dump.sql
或者，从mysql中创建数据库，选择它作为默认数据库，然后加载转储文件：
mysql> CREATE DATABASE IF NOT EXISTS db1;
mysql> USE db1;
mysql> source dump.sql
笔记
对于 Windows PowerShell 用户：由于“<”字符保留供将来在 PowerShell 中使用，因此需要一种替代方法，例如使用引号cmd.exe /c "mysql
< dump.sql"。
© Mysql 中文网
