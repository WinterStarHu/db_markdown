# 7.6 MyISAM表维护和崩溃恢复_MySQL 8.0 参考手册

7.6 MyISAM表维护和崩溃恢复_MySQL 8.0 参考手册
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
7.1 备份和恢复类型
7.2 数据库备份方式
7.3 示例备份和恢复策略
7.4 使用 mysqldump 进行备份
7.5 时间点（增量）恢复
7.6 MyISAM表维护和崩溃恢复
7.6.1 使用 myisamchk 进行崩溃恢复1
7.6.2 如何检查 MyISAM 表的错误1
7.6.3 如何修复 MyISAM 表1
7.6.4 MyISAM表优化1
7.6.5 设置 MyISAM 表维护计划1
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
MySQL 8.0 参考手册  / 第 7 章备份与恢复  /
7.6 MyISAM表维护和崩溃恢复
7.6 MyISAM表维护和崩溃恢复
7.6.1 使用 myisamchk 进行崩溃恢复7.6.2 如何检查 MyISAM 表的错误7.6.3 如何修复 MyISAM 表7.6.4 MyISAM表优化7.6.5 设置 MyISAM 表维护计划
本节讨论如何使用myisamchk检查或修复MyISAM表（具有
存储数据和索引的表.MYD和文件）。.MYI对于一般的
myisamchk背景，请参阅
第 4.6.4 节，“myisamchk — MyISAM 表维护实用程序”。其他表修复信息可以在第 2.11.13 节“重建或修复表或索引”中找到。
您可以使用myisamchk检查、修复或优化数据库表。以下部分描述了如何执行这些操作以及如何设置表维护计划。有关使用myisamchk
获取有关表的信息的信息，请参阅
第 4.6.4.5 节，“使用 myisamchk 获取表信息”。
尽管使用myisamchk进行表修复非常安全，但
在进行修复或任何可能对表进行大量更改的维护操作
之前进行备份始终是一个好主意。
影响索引的myisamchk操作会导致MyISAM FULLTEXT
使用与 MySQL 服务器使用的值不兼容的全文参数重建索引。为避免此问题，请遵循
第 4.6.4.1 节“myisamchk 常规选项”。
MyISAM表维护也可以使用执行类似于
myisamchk可以执行的操作的 SQL 语句来完成：
要检查MyISAM表，请使用
CHECK TABLE.
要修复MyISAM表，请使用
REPAIR TABLE.
要优化MyISAM表，请使用
OPTIMIZE TABLE.
要分析MyISAM表，请使用
ANALYZE TABLE.
有关这些语句的其他信息，请参阅
第 13.7.3 节，“表维护语句”。
这些语句可以直接使用，也可以通过
mysqlcheck客户端程序使用。与myisamchk相比，这些语句的优势之一是服务器完成所有工作。使用myisamchk时，您必须确保服务器不会同时使用这些表，这样
myisamchk和服务器之间就不会发生不必要的交互。
© Mysql 中文网
