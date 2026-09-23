# 16.4.2 CSV 限制_MySQL 8.0 参考手册

16.4.2 CSV 限制_MySQL 8.0 参考手册
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
16.4.1 修复和检查 CSV 表1
16.4.2 CSV 限制1
16.5 ARCHIVE存储引擎
16.6 BLACKHOLE存储引擎
16.7 MERGE存储引擎
16.8 联合存储引擎
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
MySQL 8.0 参考手册  / 第 16 章替代存储引擎  / 16.4 CSV存储引擎  /
16.4.2 CSV 限制
16.4.2 CSV 限制
CSV存储引擎不支持索引
。CSV存储引擎不支持分区
。
您使用CSV
存储引擎创建的所有表的所有列都必须具有该NOT NULL属性。
© Mysql 中文网
