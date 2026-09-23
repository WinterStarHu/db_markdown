# 8.12.2 使用符号链接_MySQL 8.0 参考手册

8.12.2 使用符号链接_MySQL 8.0 参考手册
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
8.12.1 优化磁盘 I/O1
8.12.2 使用符号链接1
8.12.2.1 在 Unix 上使用数据库的符号链接
8.12.2.2 在 Unix 上为 MyISAM 表使用符号链接
8.12.2.3 在 Windows 上使用数据库的符号链接
8.12.3 优化内存使用1
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
MySQL 8.0 参考手册  / 第8章优化  / 8.12 优化MySQL服务器  /
8.12.2 使用符号链接
8.12.2 使用符号链接
8.12.2.1 在 Unix 上使用数据库的符号链接8.12.2.2 在 Unix 上为 MyISAM 表使用符号链接8.12.2.3 在 Windows 上使用数据库的符号链接
您可以将数据库或表从数据库目录移动到其他位置，并将它们替换为指向新位置的符号链接。例如，您可能希望将数据库移动到具有更多可用空间的文件系统，或者通过将表分布到不同磁盘来提高系统速度。
对于InnoDB表，使用语句的DATA
DIRECTORY子句CREATE
TABLE而不是符号链接，如第 15.6.1.2 节“从外部创建表”中所述。此新功能是一种受支持的跨平台技术。
推荐的方法是将整个数据库目录符号链接到不同的磁盘。符号链接
MyISAM表仅作为最后的手段。
要确定数据目录的位置，请使用以下语句：
SHOW VARIABLES LIKE 'datadir';
© Mysql 中文网
