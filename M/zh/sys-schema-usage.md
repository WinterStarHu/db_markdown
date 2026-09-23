# 28.2 使用系统模式_MySQL 8.0 参考手册

28.2 使用系统模式_MySQL 8.0 参考手册
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
28.1 使用 sys 模式的先决条件
28.2 使用系统模式
28.3 sys Schema 进度报告
28.4 sys 模式对象参考
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 28 章 MySQL 系统模式  /
28.2 使用系统模式
28.2 使用系统模式
您可以将sys模式设为默认模式，这样对其对象的引用就不需要使用模式名称进行限定：
mysql> USE sys;
Database changed
mysql> SELECT * FROM version;
+-------------+---------------+
| sys_version | mysql_version |
+-------------+---------------+
| 2.1.1       | 8.0.26-debug  |
+-------------+---------------+
（该version视图显示
sys模式和 MySQL 服务器版本。）
要访问sys模式对象，而不同的模式是默认的（或简单地明确），请使用模式名称限定对象引用：
mysql> SELECT * FROM sys.version;
+-------------+---------------+
| sys_version | mysql_version |
+-------------+---------------+
| 2.1.1       | 8.0.26-debug  |
+-------------+---------------+
该sys模式包含许多以各种方式总结性能模式表的视图。大多数这些视图都是成对出现的，这样一对中的一个成员与另一个成员具有相同的名称，加上一个x$前缀。例如，该host_summary_by_file_io
视图汇总了按主机分组的文件 I/O，并显示从皮秒转换为更易读的值（带单位）的延迟；
mysql> SELECT * FROM sys.host_summary_by_file_io;
+------------+-------+------------+
| host       | ios   | io_latency |
+------------+-------+------------+
| localhost  | 67570 | 5.38 s     |
| background |  3468 | 4.18 s     |
+------------+-------+------------+
该x$host_summary_by_file_io视图汇总了相同的数据，但显示了未格式化的皮秒延迟：
mysql> SELECT * FROM sys.x$host_summary_by_file_io;
+------------+-------+---------------+
| host       | ios   | io_latency    |
+------------+-------+---------------+
| localhost  | 67574 | 5380678125144 |
| background |  3474 | 4758696829416 |
+------------+-------+---------------+
没有x$前缀的视图旨在提供对用户更友好且更易于人们阅读的输出。带有以原始形式显示相同值的前缀的视图x$更多地用于与对数据执行自己的处理的其他工具一起使用。x$有关非视图和视图之间差异的其他信息x$，请参阅
第 28.4.3 节，“sys 模式视图”。
要检查sys架构对象定义，请使用适当的
SHOW语句或
INFORMATION_SCHEMA查询。例如，要检查
session视图和
format_bytes()函数的定义，请使用以下语句：
mysql> SHOW CREATE VIEW sys.session;
mysql> SHOW CREATE FUNCTION sys.format_bytes;
但是，这些语句以相对未格式化的形式显示定义。要查看具有更易读格式的对象定义，请访问在 MySQL 源代码分发中找到的各个.sql文件。在 MySQL 8.0.18 之前，源代码在模式开发网站
https://github.com/mysql/mysql-sysscripts/sys_schema的单独分发中维护
。
sys默认情况下， mysqldump和
mysqlpump
都不会转储
sys模式。要生成转储文件，请sys使用以下任一命令在命令行上显式命名架构：
mysqldump --databases --routines sys > sys_dump.sql
mysqlpump sys > sys_dump.sql
要从转储文件重新安装架构，请使用以下命令：
mysql < sys_dump.sql
© Mysql 中文网
