# 8.2.5 优化数据变更语句_MySQL 8.0 参考手册

8.2.5 优化数据变更语句_MySQL 8.0 参考手册
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
8.1 优化概述
8.2 优化SQL语句
8.2.1 优化 SELECT 语句1
8.2.2 优化子查询、派生表、视图引用和公用表表达式1
8.2.3 优化 INFORMATION_SCHEMA 查询1
8.2.4 优化性能模式查询1
8.2.5 优化数据变更语句1
8.2.5.1 优化 INSERT 语句
8.2.5.2 优化更新语句
8.2.5.3 优化 DELETE 语句
8.2.6 优化数据库权限1
8.2.7 其他优化技巧1
8.3 优化和索引
8.4 优化数据库结构
8.5 优化 InnoDB 表
8.6 优化 MyISAM 表
8.7 优化 MEMORY 表
8.8 了解查询执行计划
8.9 控制查询优化器
8.10 缓冲和缓存
8.11 优化锁定操作
8.12 优化MySQL服务器
8.13 测量性能（基准测试）
8.14 查看服务器线程（进程）信息
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
MySQL 8.0 参考手册  / 第8章优化  / 8.2 优化SQL语句  /
8.2.5 优化数据变更语句
8.2.5 优化数据变更语句
8.2.5.1 优化 INSERT 语句8.2.5.2 优化更新语句8.2.5.3 优化 DELETE 语句
本节介绍如何加速数据更改语句：
INSERT、
UPDATE和
DELETE。传统的 OLTP 应用程序和现代 Web 应用程序通常会执行许多小的数据更改操作，其中并发性至关重要。数据分析和报告应用程序通常运行一次影响多行的数据更改操作，其中主要考虑因素是 I/O 以写入大量数据并使索引保持最新。为了插入和更新大量数据（业内称为 ETL，表示
“提取-转换-加载”），有时您会使用其他 SQL 语句或外部命令来模拟以下效果
INSERT，
UPDATE, 和
DELETE陈述。
© Mysql 中文网
