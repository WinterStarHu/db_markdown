# 26.7.3 INFORMATION_SCHEMA MYSQL_FIREWALL_WHITELIST 表_MySQL 8.0 参考手册

26.7.3 INFORMATION_SCHEMA MYSQL_FIREWALL_WHITELIST 表_MySQL 8.0 参考手册
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
26.1 简介
26.2 INFORMATION_SCHEMA 表参考
26.3 INFORMATION_SCHEMA 总表
26.4 INFORMATION_SCHEMA InnoDB 表
26.5 INFORMATION_SCHEMA线程池表
26.6 INFORMATION_SCHEMA 连接控制表
26.7 INFORMATION_SCHEMA MySQL 企业防火墙表
26.7.1 INFORMATION_SCHEMA 防火墙表参考1
26.7.2 INFORMATION_SCHEMA MYSQL_FIREWALL_USERS 表1
26.7.3 INFORMATION_SCHEMA MYSQL_FIREWALL_WHITELIST 表1
26.8 SHOW 语句的扩展
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
MySQL 8.0 参考手册  / 第 26 章 INFORMATION_SCHEMA 表  / 26.7 INFORMATION_SCHEMA MySQL 企业防火墙表  /
26.7.3 INFORMATION_SCHEMA MYSQL_FIREWALL_WHITELIST 表
26.7.3 INFORMATION_SCHEMA MYSQL_FIREWALL_WHITELIST 表
该MYSQL_FIREWALL_WHITELIST表提供了 MySQL Enterprise Firewall 的内存数据缓存视图。它列出了已注册防火墙帐户配置文件的白名单规则。它与
mysql.firewall_whitelist提供防火墙数据持久存储的系统表一起使用；请参阅
MySQL 企业防火墙表。
该MYSQL_FIREWALL_WHITELIST表有以下列：
USERHOST
帐户配置文件名称。每个帐户名的格式都是
.
user_name@host_name
RULE
规范化语句，指示配置文件可接受的语句模式。配置文件白名单是其规则的集合。
从 MySQL 8.0.26 开始，此表已弃用，并可能在未来的 MySQL 版本中删除。请参阅
将帐户配置文件迁移到组配置文件。
© Mysql 中文网
