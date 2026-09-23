# 26.5.3 INFORMATION_SCHEMA TP_THREAD_GROUP_STATS 表_MySQL 8.0 参考手册

26.5.3 INFORMATION_SCHEMA TP_THREAD_GROUP_STATS 表_MySQL 8.0 参考手册
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
26.5.1 INFORMATION_SCHEMA线程池表参考1
26.5.2 INFORMATION_SCHEMA TP_THREAD_GROUP_STATE 表1
26.5.3 INFORMATION_SCHEMA TP_THREAD_GROUP_STATS 表1
26.5.4 INFORMATION_SCHEMA TP_THREAD_STATE 表1
26.6 INFORMATION_SCHEMA 连接控制表
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
MySQL 8.0 参考手册  / 第 26 章 INFORMATION_SCHEMA 表  / 26.5 INFORMATION_SCHEMA线程池表  /
26.5.3 INFORMATION_SCHEMA TP_THREAD_GROUP_STATS 表
26.5.3 INFORMATION_SCHEMA TP_THREAD_GROUP_STATS 表
笔记
从 MySQL 8.0.14 开始，线程池
INFORMATION_SCHEMA表也可用作性能模式表。（请参阅
第 27.12.16 节，“性能模式线程池表”。）这些
INFORMATION_SCHEMA表已弃用；希望它们在未来版本的 MySQL 中被删除。应用程序应该从旧表过渡到新表。例如，如果应用程序使用此查询：
SELECT * FROM INFORMATION_SCHEMA.TP_THREAD_GROUP_STATS;
应用程序应改用此查询：
SELECT * FROM performance_schema.tp_thread_group_stats;
该TP_THREAD_GROUP_STATS表报告每个线程组的统计信息。每组一行。
有关表中列的说明
INFORMATION_SCHEMA
TP_THREAD_GROUP_STATS，请参阅
第 27.12.16.2 节，“tp_thread_group_stats 表”。Performance Schema
tp_thread_group_stats表具有等效的列。
© Mysql 中文网
