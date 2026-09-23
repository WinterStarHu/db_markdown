# 7.4 使用 mysqldump 进行备份_MySQL 8.0 参考手册

7.4 使用 mysqldump 进行备份_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 7 章备份与恢复  /
7.4 使用 mysqldump 进行备份
7.4 使用 mysqldump 进行备份
7.4.1 使用 mysqldump 转储 SQL 格式的数据7.4.2 重新加载 SQL 格式的备份7.4.3 使用 mysqldump 以定界文本格式转储数据7.4.4 重新加载定界文本格式备份7.4.5 mysqldump 提示
小费
考虑使用MySQL Shell 转储实用程序，它提供多线程并行转储、文件压缩和进度信息显示，以及 Oracle Cloud Infrastructure 对象存储流和 MySQL 数据库服务兼容性检查和修改等云功能。使用MySQL Shell 负载转储实用程序可以轻松地将转储导入 MySQL 服务器实例或 MySQL 数据库服务数据库系统。可以在此处找到 MySQL Shell 的安装说明。
本节介绍如何使用mysqldump生成转储文件，以及如何重新加载转储文件。可以通过多种方式使用转储文件：
作为备份以在数据丢失时启用数据恢复。
作为设置副本的数据源。
作为实验数据来源：
在不更改原始数据的情况下制作可以使用的数据库副本。
测试潜在的升级不兼容性。
mysqldump产生两种类型的输出，这取决于是否--tab
给出选项：
如果没有--tab，
mysqldump将 SQL 语句写入标准输出。此输出包含
CREATE创建转储对象（数据库、表、存储例程等）的
INSERT语句，以及将数据加载到表中的语句。输出可以保存在文件中，稍后使用
mysql重新加载以重新创建转储的对象。选项可用于修改 SQL 语句的格式，并控制转储哪些对象。
使用--tab，
mysqldump为每个转储表生成两个输出文件。服务器将一个文件作为制表符分隔的文本写入，每个表行一行。tbl_name.txt
该文件在输出目录中命名
。服务器还将
CREATE TABLE表的语句发送到mysqldumptbl_name.sql ，后者将其写入
输出目录中
命名的文件
。
© Mysql 中文网
