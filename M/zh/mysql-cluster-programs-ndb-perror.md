# 23.5.16 ndb_perror — 获取 NDB 错误消息信息_MySQL 8.0 参考手册

23.5.16 ndb_perror — 获取 NDB 错误消息信息_MySQL 8.0 参考手册
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
23.1 一般信息
23.2 NDB Cluster 概述
23.3 NDB Cluster 安装
23.4 NDB Cluster的配置
23.5 NDB 集群程序
23.5.1 ndbd — NDB Cluster 数据节点守护进程1
23.5.2 ndbinfo_select_all — 从 ndbinfo 表中选择1
23.5.3 ndbmtd — NDB Cluster 数据节点守护进程（多线程）1
23.5.4 ndb_mgmd — NDB 集群管理服务器守护进程1
23.5.5 ndb_mgm — NDB 集群管理客户端1
23.5.6 ndb_blob_tool — 检查和修复 NDB 集群表的 BLOB 和 TEXT 列1
23.5.7 ndb_config — 提取 NDB Cluster 配置信息1
23.5.8 ndb_delete_all — 从 NDB 表中删除所有行1
23.5.9 ndb_desc — 描述 NDB 表1
23.5.10 ndb_drop_index — 从 NDB 表中删除索引1
23.5.11 ndb_drop_table — 删除 NDB 表1
23.5.12 ndb_error_reporter — NDB 错误报告实用程序1
23.5.13 ndb_import — 将 CSV 数据导入 NDB1
23.5.14 ndb_index_stat — NDB 索引统计实用程序1
23.5.15 ndb_move_data — NDB 数据复制实用程序1
23.5.16 ndb_perror — 获取 NDB 错误消息信息1
23.5.17 ndb_print_backup_file — 打印 NDB 备份文件内容1
23.5.18 ndb_print_file — 打印 NDB 磁盘数据文件内容1
23.5.19 ndb_print_frag_file — 打印 NDB 片段列表文件内容1
23.5.20 ndb_print_schema_file — 打印 NDB 模式文件内容1
23.5.21 ndb_print_sys_file — 打印 NDB 系统文件内容1
23.5.22 ndb_redo_log_reader - 检查和打印集群重做日志的内容1
23.5.23 ndb_restore — 恢复 NDB Cluster 备份1
23.5.24 ndb_secretsfile_reader — 从加密的 NDB 数据文件中获取密钥信息1
23.5.25 ndb_select_all — 从 NDB 表打印行1
23.5.26 ndb_select_count — 打印 NDB 表的行数1
23.5.27 ndb_show_tables — 显示 NDB 表列表1
23.5.28 ndb_size.pl — NDBCLUSTER 大小需求估计器1
23.5.29 ndb_top — 查看 NDB 线程的 CPU 使用信息1
23.5.30 ndb_waiter — 等待 NDB Cluster 达到给定状态1
23.5.31 ndbxfrm — 压缩、解压缩、加密和解密 NDB Cluster 创建的文件1
23.6 NDB Cluster的管理
23.7 NDB 集群复制
23.8 NDB Cluster 发行说明
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.5 NDB 集群程序  /
23.5.16 ndb_perror — 获取 NDB 错误消息信息
23.5.16 ndb_perror — 获取 NDB 错误消息信息
ndb_perror显示有关 NDB 错误的信息，给出其错误代码。这包括错误消息、错误类型以及错误是永久性错误还是暂时性错误。这旨在作为
perror --ndb的替代品，后者不再受支持。
用法
ndb_perror [options] error_code
ndb_perror不需要访问正在运行的 NDB Cluster 或任何节点（包括 SQL 节点）。要查看有关给定 NDB 错误的信息，请使用错误代码作为参数调用该程序，如下所示：
$> ndb_perror 323
NDB error code 323: Invalid nodegroup id, nodegroup already existing: Permanent error: Application error
要仅显示错误消息，
请使用
选项（缩写形式
）调用ndb_perror，如下所示：
--silent-s$> ndb_perror -s 323
Invalid nodegroup id, nodegroup already existing: Permanent error: Application error
与perror一样，ndb_perror
接受多个错误代码：
$> ndb_perror 321 1001
NDB error code 321: Invalid nodegroup id: Permanent error: Application error
NDB error code 1001: Illegal connect stringndb_perror的
其他程序选项将在本节后面介绍。
ndb_perror替换了perror
--ndb，NDB Cluster 不再支持它。为了使脚本和其他可能依赖perror获取 NDB 错误信息的应用程序更容易替换， ndb_perror
支持它自己的“ dummy ”
--ndb选项，它什么都不做。
下表包括特定于 NDB Cluster 程序ndb_perror的所有选项。表后有其他说明。
表 23.38 与程序 ndb_perror 一起使用的命令行选项
格式
描述
添加、弃用或删除
--defaults-extra-file=path
读取全局文件后读取给定文件
（支持所有基于 MySQL 8.0 的 NDB 版本）
--defaults-file=path
仅从给定文件中读取默认选项
（支持所有基于 MySQL 8.0 的 NDB 版本）
--defaults-group-suffix=string
还阅读带有 concat(group, suffix) 的组
（支持所有基于 MySQL 8.0 的 NDB 版本）
--help,
-?
显示帮助文本
（支持所有基于 MySQL 8.0 的 NDB 版本）
--login-path=path
从登录文件中读取给定路径
（支持所有基于 MySQL 8.0 的 NDB 版本）
--ndb
为了与依赖旧版本 perror 的应用程序兼容；什么也没做
（支持所有基于 MySQL 8.0 的 NDB 版本）
--no-defaults
不要从登录文件以外的任何选项文件中读取默认选项
（支持所有基于 MySQL 8.0 的 NDB 版本）
--print-defaults
打印程序参数列表并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--silent,
-s
仅显示错误信息
（支持所有基于 MySQL 8.0 的 NDB 版本）
--version,
-V
打印程序版本信息并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--verbose,
-v
详细输出；用 --silent 禁用
（支持所有基于 MySQL 8.0 的 NDB 版本）
附加选项
--defaults-extra-file
命令行格式
--defaults-extra-file=path
类型
细绳
默认值
[none]
读取全局文件后读取给定文件。
--defaults-file
命令行格式
--defaults-file=path
类型
细绳
默认值
[none]
仅从给定文件中读取默认选项。
--defaults-group-suffix
命令行格式
--defaults-group-suffix=string
类型
细绳
默认值
[none]
还可以阅读带有 concat(group, suffix) 的组。
--help,
-?
命令行格式
--help
显示程序帮助文本并退出。
--login-path
命令行格式
--login-path=path
类型
细绳
默认值
[none]
从登录文件中读取给定路径。
--ndb
命令行格式
--ndb
为了与依赖于使用该程序选项的旧版本perror的应用程序兼容。--ndb与ndb_perror一起使用时的选项什么都不做，并被它忽略。
--no-defaults
命令行格式
--no-defaults
不要从登录文件以外的任何选项文件中读取默认选项。
--print-defaults
命令行格式
--print-defaults
打印程序参数列表并退出。
--silent,
-s
命令行格式
--silent
仅显示错误消息。
--version,
-V
命令行格式
--version
打印程序版本信息并退出。
--verbose,
-v
命令行格式
--verbose
详细输出；禁用
--silent。
© Mysql 中文网
