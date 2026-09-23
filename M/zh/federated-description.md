# 16.8.1 联合存储引擎概述_MySQL 8.0 参考手册

16.8.1 联合存储引擎概述_MySQL 8.0 参考手册
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
16.8.1 联合存储引擎概述
16.8.1 联合存储引擎概述
当您使用标准存储引擎之一（例如MyISAM,CSV或
InnoDB）创建表时，该表由表定义和关联数据组成。创建
FEDERATED表时，表定义是相同的，但数据的物理存储是在远程服务器上处理的。
一个FEDERATED表由两个元素组成：
具有数据库表的远程服务器，该数据库表又由表定义（存储在 MySQL 数据字典中）和关联表组成。远程表的表类型可以是远程mysqld服务器支持的任何类型，包括
MyISAM或InnoDB。
具有数据库表的本地服务器，其中表定义与远程服务器上相应表的定义相匹配。表定义存储在数据字典中。本地服务器上没有数据文件。相反，表定义包括指向远程表的连接字符串。
当对本地服务器上的表执行查询和语句时
FEDERATED，通常会从本地数据文件插入、更新或删除信息的操作被发送到远程服务器执行，在那里它们更新远程服务器上的数据文件或从远程服务器返回匹配的行。
FEDERATED表设置
的基本结构如图 16.2 “FEDERATED Table Structure”所示。
图 16.2 FEDERATED 表结构
当客户端发出引用
FEDERATED表的 SQL 语句时，本地服务器（执行 SQL 语句的地方）和远程服务器（物理存储数据的地方）之间的信息流如下：
存储引擎查看表中的每一列，
FEDERATED并构建引用远程表的适当 SQL 语句。
该语句使用 MySQL 客户端 API 发送到远程服务器。
远程服务器处理语句，本地服务器检索语句产生的任何结果（受影响的行计数或结果集）。
如果语句生成结果集，则每一列都将转换为
FEDERATED引擎期望的内部存储引擎格式，并可用于将结果显示给发出原始语句的客户端。
本地服务器使用 MySQL 客户端 C API 函数与远程服务器通信。它调用
mysql_real_query()发送语句。要读取结果集，它会
mysql_store_result()使用
mysql_fetch_row().
© Mysql 中文网
