# 16.8.2 如何创建 FEDERATED 表_MySQL 8.0 参考手册

16.8.2 如何创建 FEDERATED 表_MySQL 8.0 参考手册
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
16.1 设置存储引擎
16.2 MyISAM 存储引擎
16.3 MEMORY存储引擎
16.4 CSV存储引擎
16.5 ARCHIVE存储引擎
16.6 BLACKHOLE存储引擎
16.7 MERGE存储引擎
16.8 联合存储引擎
16.8.1 联合存储引擎概述1
16.8.2 如何创建 FEDERATED 表1
16.8.2.1 使用 CONNECTION 创建 FEDERATED 表
16.8.2.2 使用 CREATE SERVER 创建 FEDERATED 表
16.8.3 FEDERATED 存储引擎注释和提示1
16.8.4 联合存储引擎资源1
16.9 示例存储引擎
16.10 其他存储引擎
16.11 MySQL存储引擎架构概述
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
MySQL 8.0 参考手册  / 第 16 章替代存储引擎  / 16.8 联合存储引擎  /
16.8.2 如何创建 FEDERATED 表
16.8.2 如何创建 FEDERATED 表
16.8.2.1 使用 CONNECTION 创建 FEDERATED 表16.8.2.2 使用 CREATE SERVER 创建 FEDERATED 表
要创建FEDERATED表，您应该遵循以下步骤：
在远程服务器上创建表。或者，记下现有表的表定义，也许使用SHOW CREATE TABLE
语句。
使用相同的表定义在本地服务器上创建表，但添加将本地表链接到远程表的连接信息。
例如，您可以在远程服务器上创建下表：
CREATE TABLE test_table (
id     INT(20) NOT NULL AUTO_INCREMENT,
name   VARCHAR(32) NOT NULL DEFAULT '',
other  INT(20) NOT NULL DEFAULT '0',
PRIMARY KEY  (id),
INDEX name (name),
INDEX other_key (other)
)
ENGINE=MyISAM
DEFAULT CHARSET=utf8mb4;
要创建联合到远程表的本地表，有两个选项可用。您可以创建本地表并指定连接字符串（包含服务器名称、登录名、密码）以使用 连接到远程表CONNECTION，或者您可以使用之前使用该
CREATE SERVER语句创建的现有连接。
重要的
创建本地表时，它必须
具有与远程表相同的字段定义。
笔记
您可以
FEDERATED通过向主机上的表添加索引来提高表的性能。发生优化是因为发送到远程服务器的查询包含
WHERE子句的内容，并发送到远程服务器并随后在本地执行。这减少了网络流量，否则会从服务器请求整个表以进行本地处理。
© Mysql 中文网
