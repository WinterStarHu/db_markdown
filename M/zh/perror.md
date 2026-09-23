# 4.8.2 perror——显示MySQL错误信息信息_MySQL 8.0 参考手册

4.8.2 perror——显示MySQL错误信息信息_MySQL 8.0 参考手册
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
4.1 MySQL程序概述
4.2 使用 MySQL 程序
4.3 服务器和服务器启动程序
4.4 安装相关程序
4.5 客户端程序
4.6 管理和实用程序
4.7 程序开发实用程序
4.8 杂项程序
4.8.1 lz4_decompress — 解压缩 mysqlpump LZ4 压缩输出1
4.8.2 perror——显示MySQL错误信息信息1
4.8.3 zlib_decompress — 解压缩 mysqlpump ZLIB 压缩输出1
4.9 环境变量
4.10 MySQL 中的 Unix 信号处理
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.8 杂项程序  /
4.8.2 perror——显示MySQL错误信息信息
4.8.2 perror——显示MySQL错误信息信息
perror显示 MySQL 或操作系统错误代码的错误消息。像这样调用
错误：
perror [options] errorcode ...
perror试图灵活地理解它的参数。例如，对于
ER_WRONG_VALUE_FOR_VAR错误，
perror理解以下任何参数：
1231,001231,
MY-1231, orMY-001231, or
ER_WRONG_VALUE_FOR_VAR。
$> perror 1231
MySQL error code MY-001231 (ER_WRONG_VALUE_FOR_VAR): Variable '%-.64s'
can't be set to the value of '%-.200s'
如果错误编号在 MySQL 和操作系统错误重叠的范围内，则perror会显示两种错误消息：
$> perror 1 13
OS error code   1:  Operation not permitted
MySQL error code MY-000001: Can't create/write to file '%s' (OS errno %d - %s)
OS error code  13:  Permission denied
MySQL error code MY-000013: Can't get stat of '%s' (OS errno %d - %s)
要获取 MySQL 集群错误代码的错误消息，请使用ndb_perror实用程序。
系统错误消息的含义可能取决于您的操作系统。给定的错误代码在不同的操作系统上可能意味着不同的事情。
perror支持以下选项。
--help,
--info,
-I,-?
显示帮助信息并退出。
--ndb
打印 MySQL 集群错误代码的错误消息。
该选项在 MySQL 8.0.13 中被移除。请改用
ndb_perror实用程序。
--silent,-s
静音模式。仅打印错误消息。
--verbose,
-v
详细模式。打印错误代码和消息。这是默认行为。
--version,
-V
显示版本信息并退出。
© Mysql 中文网
