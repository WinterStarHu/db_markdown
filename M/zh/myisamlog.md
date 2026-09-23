# 4.6.5 myisamlog——显示MyISAM日志文件内容_MySQL 8.0 参考手册

4.6.5 myisamlog——显示MyISAM日志文件内容_MySQL 8.0 参考手册
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
4.6.1 ibd2sdi — InnoDB 表空间 SDI 提取实用程序1
4.6.2 innochecksum — 离线 InnoDB 文件校验和工具1
4.6.3 myisam_ftdump——显示全文索引信息1
4.6.4 myisamchk — MyISAM 表维护实用程序1
4.6.5 myisamlog——显示MyISAM日志文件内容1
4.6.6 myisampack——生成压缩的、只读的 MyISAM 表1
4.6.7 mysql_config_editor — MySQL 配置实用程序1
4.6.8 mysql_migrate_keyring — 密钥环密钥迁移实用程序1
4.6.9 mysqlbinlog — 处理二进制日志文件的实用程序1
4.6.10 mysqldumpslow——总结慢查询日志文件1
4.7 程序开发实用程序
4.8 杂项程序
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.6 管理和实用程序  /
4.6.5 myisamlog——显示MyISAM日志文件内容
4.6.5 myisamlog——显示MyISAM日志文件内容
myisamlog处理
MyISAM日志文件的内容。要创建这样的文件，请使用一个
选项启动服务器。
--log-isam=log_file
像这样调用myisamlog：
myisamlog [options] [file_name [tbl_name] ...]
默认操作是更新（-u）。如果恢复完成 ( -r)，则所有写入以及可能的更新和删除都已完成，并且仅计算错误。默认日志文件名是myisam.log如果没有
log_file给出参数。如果表在命令行上命名，则仅更新这些表。
myisamlog支持以下选项：
-?,-I
显示帮助信息并退出。
-c N
只执行N命令。
-f N
指定打开文件的最大数量。
-F filepath/
使用尾部斜杠指定文件路径。
-i
退出前显示额外信息。
-o offset
指定起始偏移量。
-p N
N从路径中
删除组件。
-r
执行恢复操作。
-R record_pos_file
record_pos
指定记录位置文件和记录位置。
-u
执行更新操作。
-v
详细模式。打印更多关于程序做什么的输出。可以多次给出此选项以产生越来越多的输出。
-w write_file
指定写入文件。
-V
显示版本信息。
© Mysql 中文网
