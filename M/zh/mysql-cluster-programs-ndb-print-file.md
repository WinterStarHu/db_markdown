# 23.5.18 ndb_print_file — 打印 NDB 磁盘数据文件内容_MySQL 8.0 参考手册

23.5.18 ndb_print_file — 打印 NDB 磁盘数据文件内容_MySQL 8.0 参考手册
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
23.5.18 ndb_print_file — 打印 NDB 磁盘数据文件内容
23.5.18 ndb_print_file — 打印 NDB 磁盘数据文件内容
ndb_print_file从 NDB Cluster Disk Data 文件获取信息。
用法
ndb_print_file [-v] [-q] file_name+
file_name是 NDB Cluster 磁盘数据文件的名称。接受多个文件名，以空格分隔。
与ndb_print_schema_file和
ndb_print_sys_file一样（与大多数NDB旨在在管理服务器主机上运行或连接到管理服务器的其他实用程序不同）ndb_print_file必须在 NDB Cluster 数据节点上运行，因为它访问数据节点文件系统直接地。因为它不使用管理服务器，所以可以在管理服务器未运行时使用此实用程序，甚至在集群已完全关闭时也可以使用。
选项
表 23.40 与程序 ndb_print_file 一起使用的命令行选项
格式
描述
添加、弃用或删除
--file-key=hex_data,
-K
hex_data
使用 stdin、tty 或 my.cnf 文件提供加密密钥
添加：NDB 8.0.31
--file-key-from-stdin
使用标准输入提供加密密钥
添加：NDB 8.0.31
--help,
-?
显示帮助文本并退出；与 --usage 相同
（支持所有基于 MySQL 8.0 的 NDB 版本）
--quiet,
-q
减少输出的冗长
（支持所有基于 MySQL 8.0 的 NDB 版本）
--usage,
-?
显示帮助文本并退出；与 --help 相同
（支持所有基于 MySQL 8.0 的 NDB 版本）
--verbose,
-v
增加输出的详细程度
（支持所有基于 MySQL 8.0 的 NDB 版本）
--version,
-V
显示版本信息并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
ndb_print_file支持以下选项：
--file-key,
-K
命令行格式
--file-key=hex_data
介绍
8.0.31-ndb-8.0.31
stdin从、tty或
文件
提供文件系统加密或解密密钥
my.cnf。
--file-key-from-stdin
命令行格式
--file-key-from-stdin
介绍
8.0.31-ndb-8.0.31
类型
布尔值
默认值
FALSE
有效值
TRUE
从 提供文件系统加密或解密密钥
stdin。
--help,
-h,-?
命令行格式
--help
打印帮助信息并退出。
--quiet,
-q
命令行格式
--quiet
抑制输出（安静模式）。
--usage,
-?
命令行格式
--usage
打印帮助信息并退出。
--verbose,
-v
命令行格式
--verbose
使输出冗长。
--version,
-v
命令行格式
--version
打印版本信息并退出。
有关更多信息，请参阅
第 23.6.10 节，“NDB Cluster 磁盘数据表”。
© Mysql 中文网
