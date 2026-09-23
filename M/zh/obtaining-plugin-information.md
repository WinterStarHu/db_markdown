# 5.6.2 获取服务器插件信息_MySQL 8.0 参考手册

5.6.2 获取服务器插件信息_MySQL 8.0 参考手册
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
5.1 MySQL 服务器
5.2 MySQL数据目录
5.3 mysql系统架构
5.4 MySQL 服务器日志
5.5 MySQL组件
5.6 MySQL 服务器插件
5.6.1 安装和卸载插件1
5.6.2 获取服务器插件信息1
5.6.3 MySQL企业级线程池1
5.6.4 重写器查询重写插件1
5.6.5 ddl_rewriter 插件1
5.6.6 版本令牌1
5.6.7 克隆插件1
5.6.8 密钥环代理桥插件1
5.6.9 MySQL 插件服务1
5.7 MySQL 服务器可加载函数
5.8 在一台机器上运行多个MySQL实例
5.9 调试 MySQL
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
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 5 章 MySQL 服务器管理  / 5.6 MySQL 服务器插件  /
5.6.2 获取服务器插件信息
5.6.2 获取服务器插件信息
有几种方法可以确定服务器中安装了哪些插件：
该INFORMATION_SCHEMA.PLUGINS
表为每个加载的插件包含一行。任何
PLUGIN_LIBRARY值为 的
NULL都是内置的，不能卸载。
mysql> SELECT * FROM INFORMATION_SCHEMA.PLUGINS\G
*************************** 1. row ***************************
PLUGIN_NAME: binlog
PLUGIN_VERSION: 1.0
PLUGIN_STATUS: ACTIVE
PLUGIN_TYPE: STORAGE ENGINE
PLUGIN_TYPE_VERSION: 50158.0
PLUGIN_LIBRARY: NULL
PLUGIN_LIBRARY_VERSION: NULL
PLUGIN_AUTHOR: Oracle Corporation
PLUGIN_DESCRIPTION: This is a pseudo storage engine to represent the binlog in a transaction
PLUGIN_LICENSE: GPL
LOAD_OPTION: FORCE
...
*************************** 10. row ***************************
PLUGIN_NAME: InnoDB
PLUGIN_VERSION: 1.0
PLUGIN_STATUS: ACTIVE
PLUGIN_TYPE: STORAGE ENGINE
PLUGIN_TYPE_VERSION: 50158.0
PLUGIN_LIBRARY: ha_innodb_plugin.so
PLUGIN_LIBRARY_VERSION: 1.0
PLUGIN_AUTHOR: Oracle Corporation
PLUGIN_DESCRIPTION: Supports transactions, row-level locking,
and foreign keys
PLUGIN_LICENSE: GPL
LOAD_OPTION: ON
...
该SHOW PLUGINS语句为每个加载的插件显示一行。任何
Library值为 的NULL
都是内置的，不能卸载。
mysql> SHOW PLUGINS\G
*************************** 1. row ***************************
Name: binlog
Status: ACTIVE
Type: STORAGE ENGINE
Library: NULL
License: GPL
...
*************************** 10. row ***************************
Name: InnoDB
Status: ACTIVE
Type: STORAGE ENGINE
Library: ha_innodb_plugin.so
License: GPL
...
该mysql.plugin表显示了哪些插件已在INSTALL
PLUGIN. 该表仅包含插件名称和库文件名，因此它提供的信息不如PLUGINS表或
SHOW PLUGINS语句多。
© Mysql 中文网
