# 16.11.1 可插拔存储引擎架构_MySQL 8.0 参考手册

16.11.1 可插拔存储引擎架构_MySQL 8.0 参考手册
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
16.9 示例存储引擎
16.10 其他存储引擎
16.11 MySQL存储引擎架构概述
16.11.1 可插拔存储引擎架构1
16.11.2 公共数据库服务器层1
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
MySQL 8.0 参考手册  / 第 16 章替代存储引擎  / 16.11 MySQL存储引擎架构概述  /
16.11.1 可插拔存储引擎架构
16.11.1 可插拔存储引擎架构
MySQL 服务器使用可插拔存储引擎架构，使存储引擎能够加载到正在运行的 MySQL 服务器或从中卸载。
插入存储引擎
在可以使用存储引擎之前，必须使用
INSTALL PLUGIN语句将存储引擎插件共享库加载到 MySQL 中。例如，如果EXAMPLE引擎插件名为 namedexample并且共享库名为
ha_example.so，则使用以下语句加载它：
INSTALL PLUGIN example SONAME 'ha_example.so';
要安装可插拔存储引擎，插件文件必须位于 MySQL 插件目录中，并且发出该
INSTALL PLUGIN语句的用户必须对该表具有INSERT权限
mysql.plugin。
共享库必须位于 MySQL 服务器插件目录中，其位置由
plugin_dir系统变量指定。
拔掉存储引擎
要拔出存储引擎，请使用以下
UNINSTALL PLUGIN语句：
UNINSTALL PLUGIN example;
如果拔下现有表所需的存储引擎，这些表将无法访问，但仍存在于磁盘上（如果适用）。在拔下存储引擎之前，请确保没有使用存储引擎的表。
© Mysql 中文网
