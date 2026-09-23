# 16.4.1 修复和检查 CSV 表_MySQL 8.0 参考手册

16.4.1 修复和检查 CSV 表_MySQL 8.0 参考手册
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
16.4.1 修复和检查 CSV 表
16.4.1 修复和检查 CSV 表
CSV存储引擎支持
CHECK TABLE和
REPAIR TABLE语句来验证并在可能的情况下修复损坏的
表CSV。
运行该CHECK TABLE
语句时，CSV通过查找正确的字段分隔符、转义字段（匹配或缺少引号）、与表定义相比正确的字段数以及是否存在相应的CSV图元文件来检查文件的有效性。发现的第一个无效行会导致错误。检查有效表会产生如下所示的输出：
mysql> CHECK TABLE csvtest;
+--------------+-------+----------+----------+
| Table        | Op    | Msg_type | Msg_text |
+--------------+-------+----------+----------+
| test.csvtest | check | status   | OK       |
+--------------+-------+----------+----------+
对损坏的表的检查会返回错误，例如
mysql> CHECK TABLE csvtest;
+--------------+-------+----------+----------+
| Table        | Op    | Msg_type | Msg_text |
+--------------+-------+----------+----------+
| test.csvtest | check | error    | Corrupt  |
+--------------+-------+----------+----------+
要修复表，请使用REPAIR
TABLE，它会从现有
CSV数据中复制尽可能多的有效行，然后用CSV恢复的行替换现有文件。损坏数据之外的任何行都将丢失。
mysql> REPAIR TABLE csvtest;
+--------------+--------+----------+----------+
| Table        | Op     | Msg_type | Msg_text |
+--------------+--------+----------+----------+
| test.csvtest | repair | status   | OK       |
+--------------+--------+----------+----------+
警告
在修复期间，只有从CSV
文件到第一个损坏行的行被复制到新表中。从第一个损坏的行到表末尾的所有其他行都将被删除，即使是有效行。
© Mysql 中文网
