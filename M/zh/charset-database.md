# 10.3.3 数据库字符集和排序规则_MySQL 8.0 参考手册

10.3.3 数据库字符集和排序规则_MySQL 8.0 参考手册
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
10.1 一般字符集和排序规则
10.2 MySQL 中的字符集和排序规则
10.3 指定字符集和归类
10.3.1 归类命名约定1
10.3.2 服务器字符集和排序规则1
10.3.3 数据库字符集和排序规则1
10.3.4 表字符集和排序规则1
10.3.5 列字符集和排序规则1
10.3.6 字符串文字字符集和排序规则1
10.3.7 国家字符集1
10.3.8 字符集介绍者1
10.3.9 字符集和归类分配示例1
10.3.10 与其他 DBMS 的兼容性1
10.4 连接字符集和排序规则
10.5 配置应用程序字符集和排序规则
10.6 错误信息字符集
10.7 列字符集转换
10.8 整理问题
10.9 Unicode 支持
10.10 支持的字符集和归类
10.11 字符集限制
10.12 设置错误信息语言
10.13 添加字符集
10.14 向字符集添加归类
10.15 字符集配置
10.16 MySQL 服务器语言环境支持
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
MySQL 8.0 参考手册  / 第 10 章字符集、排序规则、Unicode  / 10.3 指定字符集和归类  /
10.3.3 数据库字符集和排序规则
10.3.3 数据库字符集和排序规则
每个数据库都有一个数据库字符集和一个数据库排序规则。CREATE DATABASE
andALTER DATABASE语句具有用于指定数据库字符集和排序规则的可选子句
：CREATE DATABASE db_name
[[DEFAULT] CHARACTER SET charset_name]
[[DEFAULT] COLLATE collation_name]
ALTER DATABASE db_name
[[DEFAULT] CHARACTER SET charset_name]
[[DEFAULT] COLLATE collation_name]SCHEMA可以使用
关键字代替DATABASE.
CHARACTER SETand
COLLATE子句使得在同一个 MySQL 服务器上创建具有不同字符集和排序规则的数据库成为可能
。
数据库选项存储在数据字典中，可以通过检查
INFORMATION_SCHEMA.SCHEMATA表来检查。
例子：
CREATE DATABASE db_name CHARACTER SET latin1 COLLATE latin1_swedish_ci;
MySQL 通过以下方式选择数据库字符集和数据库排序规则：
如果同时指定了和
，则使用字符集
和排序规则
。
CHARACTER SET
charset_nameCOLLATE
collation_namecharset_namecollation_name
如果没有指定，则使用字符集
及其默认排序规则。要查看每个字符集的默认排序规则，请使用语句或查询
表。
CHARACTER SET
charset_nameCOLLATEcharset_nameSHOW CHARACTER
SETINFORMATION_SCHEMA
CHARACTER_SETS
如果没有指定，则使用关联的字符集
和排序规则
。
COLLATE
collation_nameCHARACTER SETcollation_namecollation_name
否则（既未指定CHARACTER SET也未
COLLATE指定），将使用服务器字符集和服务器排序规则。
默认数据库的字符集和排序规则可以根据
character_set_database和
collation_database系统变量的值确定。每当默认数据库更改时，服务器都会设置这些变量。如果没有默认数据库，则变量与相应的服务器级系统变量具有相同的值，character_set_server
并且collation_server.
要查看给定数据库的默认字符集和排序规则，请使用以下语句：
USE db_name;
SELECT @@character_set_database, @@collation_database;
或者，要在不更改默认数据库的情况下显示值：
SELECT DEFAULT_CHARACTER_SET_NAME, DEFAULT_COLLATION_NAME
FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'db_name';
数据库字符集和排序规则影响服务器操作的这些方面：
对于CREATE TABLE语句，如果未指定表字符集和排序规则，则数据库字符集和排序规则用作表定义的默认值。要覆盖它，请提供显式CHARACTER SET和
COLLATE表格选项。
对于LOAD DATA不包含CHARACTER SET子句的语句，服务器使用
character_set_database
系统变量指示的字符集来解释文件中的信息。要覆盖它，请提供一个明确的CHARACTER
SET条款。
对于存储例程（过程和函数），在例程创建时有效的数据库字符集和排序规则用作字符数据参数的字符集和排序规则，其声明不包含CHARACTER SET或
COLLATE属性。要覆盖它，请CHARACTER SET明确
COLLATE提供。
© Mysql 中文网
