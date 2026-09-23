# 26.6.2 INFORMATION_SCHEMA CONNECTION_CONTROL_FAILED_LOGIN_ATTEMPTS 表_MySQL 8.0 参考手册

26.6.2 INFORMATION_SCHEMA CONNECTION_CONTROL_FAILED_LOGIN_ATTEMPTS 表_MySQL 8.0 参考手册
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
26.6.1 INFORMATION_SCHEMA 连接控制表参考1
26.6.2 INFORMATION_SCHEMA CONNECTION_CONTROL_FAILED_LOGIN_ATTEMPTS 表1
26.7 INFORMATION_SCHEMA MySQL 企业防火墙表
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
MySQL 8.0 参考手册  / 第 26 章 INFORMATION_SCHEMA 表  / 26.6 INFORMATION_SCHEMA 连接控制表  /
26.6.2 INFORMATION_SCHEMA CONNECTION_CONTROL_FAILED_LOGIN_ATTEMPTS 表
26.6.2 INFORMATION_SCHEMA CONNECTION_CONTROL_FAILED_LOGIN_ATTEMPTS 表
此表提供有关每个帐户（用户/主机组合）的当前连续失败连接尝试次数的信息。
CONNECTION_CONTROL_FAILED_LOGIN_ATTEMPTS
有这些列：
USERHOST
用户/主机组合，以格式
表示连接尝试失败的帐户
。'user_name'@'host_name'
FAILED_ATTEMPTS
该值的当前连续失败连接尝试次数USERHOST。这会计算所有失败的尝试，无论它们是否被延迟。服务器为其响应添加延迟的尝试次数是该
FAILED_ATTEMPTS值与
connection_control_failed_connections_threshold
系统变量值之间的差值。
笔记
必须激活插件才能使该
CONNECTION_CONTROL_FAILED_LOGIN_ATTEMPTS
表可用，并且CONNECTION_CONTROL必须激活插件或表内容始终为空。请参阅
第 6.4.2 节，“连接控制插件”。
该表仅包含具有一次或多次连续失败连接尝试而没有后续成功尝试的帐户的行。当一个帐户成功连接时，其失败连接计数将重置为零，并且服务器会删除与该帐户对应的任何行。
在运行时为
connection_control_failed_connections_threshold
系统变量赋值会将所有累积的失败连接计数器重置为零，这会导致表变为空。
© Mysql 中文网
