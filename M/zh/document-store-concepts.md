# 20.2 文档存储概念_MySQL 8.0 参考手册

20.2 文档存储概念_MySQL 8.0 参考手册
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
20.1 MySQL文档存储的接口
20.2 文档存储概念
20.3 JavaScript 快速入门指南：用于文档存储的 MySQL Shell
20.4 Python 快速入门指南：用于文档存储的 MySQL Shell
20.5 X 插件
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
MySQL 8.0 参考手册  / 第 20 章使用 MySQL 作为文档存储  /
20.2 文档存储概念
20.2 文档存储概念
本节解释作为使用 MySQL 作为文档存储的一部分引入的概念。
JSON文件收藏增删改查操作
JSON文件
JSON文档是由键值对组成的数据结构，是使用MySQL作为文档存储的基础结构。例如，world_x 模式（在本章稍后安装）包含此文档：
{
"GNP": 4834,
"_id": "00005de917d80000000000000023",
"Code": "BWA",
"Name": "Botswana",
"IndepYear": 1966,
"geography": {
"Region": "Southern Africa",
"Continent": "Africa",
"SurfaceArea": 581730
},
"government": {
"HeadOfState": "Festus G. Mogae",
"GovernmentForm": "Republic"
},
"demographics": {
"Population": 1622000,
"LifeExpectancy": 39.29999923706055
}
}
本文档显示键的值可以是简单的数据类型，例如整数或字符串，但也可以包含其他文档、数组和文档列表。例如，
geography键的值由多个键值对组成。通过
JSONMySQL 数据类型，JSON 文档在内部使用 MySQL 二进制 JSON 对象表示。
文档与传统关系数据库中已知的表之间最重要的区别是文档的结构不必预先定义，并且集合可以包含具有不同结构的多个文档。另一方面，关系表需要定义它们的结构，并且表中的所有行必须包含相同的列。
收藏
集合是用于在 MySQL 数据库中存储 JSON 文档的容器。应用程序通常针对文档集合运行操作，例如查找特定文档。
增删改查操作
可以对集合发出的四个基本操作是创建、读取、更新和删除 (CRUD)。就 MySQL 而言，这意味着：
创建新文档（插入或添加）
阅读一份或多份文件（查询）
更新一个或多个文件
删除一个或多个文档
© Mysql 中文网
