# 4.4.1 comp_err——编译MySQL错误信息文件_MySQL 8.0 参考手册

4.4.1 comp_err——编译MySQL错误信息文件_MySQL 8.0 参考手册
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
4.4.1 comp_err——编译MySQL错误信息文件1
4.4.2 mysql_secure_installation——提高MySQL安装安全性1
4.4.3 mysql_ssl_rsa_setup — 创建 SSL/RSA 文件1
4.4.4 mysql_tzinfo_to_sql — 加载时区表1
4.4.5 mysql_upgrade — 检查和升级 MySQL 表1
4.5 客户端程序
4.6 管理和实用程序
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.4 安装相关程序  /
4.4.1 comp_err——编译MySQL错误信息文件
4.4.1 comp_err——编译MySQL错误信息文件
comp_err创建
errmsg.sys文件，
mysqld使用该文件来确定针对不同错误代码显示的错误消息。comp_err
通常在构建 MySQL 时自动运行。errmsg.sys它根据 MySQL 源代码分发中的文本格式错误信息
编译
从MySQL 8.0.19开始，错误信息来自目录下的
messages_to_error_log.txt和
messages_to_clients.txt文件
share。
有关定义错误消息的更多信息，请参阅这些文件中的注释以及该
errmsg_readme.txt文件。
MySQL 8.0.19之前的错误信息来自目录下的
errmsg-utf8.txt文件
sql/share。
comp_err还生成
mysqld_error.h、
mysqld_ername.h和
mysqld_errmsg.h头文件。
像这样调用comp_err：
comp_err [options]
comp_err支持以下选项。
--help,-?
显示帮助信息并退出。
--charset=dir_name,
-C dir_name
字符集目录。默认值为
../sql/share/charsets。
--debug=debug_options,
-# debug_options
写调试日志。典型的
debug_options字符串是
. 默认值为。
d:t:O,file_named:t:O,/tmp/comp_err.trace
--debug-info,
-T
程序退出时打印一些调试信息。
--errmsg-file=file_name,
-H file_name
错误消息文件的名称。默认值为
mysqld_errmsg.h。这个选项是在 MySQL 8.0.18 中添加的。
--header-file=file_name,
-H file_name
错误头文件的名称。默认值为
mysqld_error.h。
--in-file=file_name,
-F file_name
输入文件的名称。默认值为
../share/errmsg-utf8.txt。
该选项在 MySQL 8.0.19 中被移除，取而代之的是
--in-file-errlogand
--in-file-toclient选项。
--in-file-errlog=file_name,
-e file_name
定义要写入错误日志的错误消息的输入文件的名称。默认值为
../share/messages_to_error_log.txt。
这个选项是在 MySQL 8.0.19 中添加的。
--in-file-toclient=file_name,
-c file_name
定义要写入客户端的错误消息的输入文件的名称。默认值为
../share/messages_to_clients.txt。
这个选项是在 MySQL 8.0.19 中添加的。
--name-file=file_name,
-N file_name
错误名称文件的名称。默认值为
mysqld_ername.h。
--out-dir=dir_name,
-D dir_name
输出基目录的名称。默认值为
../sql/share/。
--out-file=file_name,
-O file_name
输出文件的名称。默认值为
errmsg.sys。
--version,
-V
显示版本信息并退出。
© Mysql 中文网
