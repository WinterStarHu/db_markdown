# 23.5.22 ndb_redo_log_reader - 检查和打印集群重做日志的内容_MySQL 8.0 参考手册

23.5.22 ndb_redo_log_reader - 检查和打印集群重做日志的内容_MySQL 8.0 参考手册
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
23.5.22 ndb_redo_log_reader - 检查和打印集群重做日志的内容
23.5.22 ndb_redo_log_reader - 检查和打印集群重做日志的内容
读取重做日志文件，检查它是否有错误，以人类可读的格式打印其内容，或两者兼而有之。
ndb_redo_log_reader主要供 NDB Cluster 开发人员和支持人员在调试和诊断问题时使用。
此实用程序仍在开发中，其语法和行为可能会在未来的 NDB Cluster 版本中发生变化。
ndb_redo_log_reader
的 C++ 源文件
可以在目录中找到
/storage/ndb/src/kernel/blocks/dblqh/redoLogReader。
下表显示了
可与
ndb_redo_log_reader一起使用的选项。表后有其他说明。
表 23.41 与程序 ndb_redo_log_reader 一起使用的命令行选项
格式
描述
添加、弃用或删除
-dump
打印转储信息
（支持所有基于 MySQL 8.0 的 NDB 版本）
--file-key=key,
-K
key
提供解密密钥
添加：NDB 8.0.31
--file-key-from-stdin
使用标准输入提供解密密钥
添加：NDB 8.0.31
-filedescriptors
仅打印文件描述符
（支持所有基于 MySQL 8.0 的 NDB 版本）
--help
打印使用信息（没有缩写形式）
（支持所有基于 MySQL 8.0 的 NDB 版本）
-lap
提供单圈信息，最大 GCI 开始和完成
（支持所有基于 MySQL 8.0 的 NDB 版本）
-mbyte
#
起始兆字节
（支持所有基于 MySQL 8.0 的 NDB 版本）
-mbyteheaders
仅显示文件中每兆字节的首页标题
（支持所有基于 MySQL 8.0 的 NDB 版本）
-nocheck
不要检查记录是否有错误
（支持所有基于 MySQL 8.0 的 NDB 版本）
-noprint
不打印记录
（支持所有基于 MySQL 8.0 的 NDB 版本）
-page
#
从这个页面开始
（支持所有基于 MySQL 8.0 的 NDB 版本）
-pageheaders
仅显示页眉
（支持所有基于 MySQL 8.0 的 NDB 版本）
-pageindex
#
从这个页面索引开始
（支持所有基于 MySQL 8.0 的 NDB 版本）
-twiddle
移位转储
（支持所有基于 MySQL 8.0 的 NDB 版本）
用法
ndb_redo_log_reader file_name [options]
file_name是集群重做日志文件的名称。重做日志文件位于数据节点数据目录 ( DataDir) 下的编号目录中；此目录下重做日志文件的路径与模式匹配
。
是数据节点的节点 ID。每个的两个实例代表一个数字（不一定是相同的数字）；后面的数字在 8-39 之间；后面的数字范围根据
配置参数的值而变化，默认值为16；因此，文件名中数字的默认范围是 0-15（含）。有关详细信息，请参阅
ndb_nodeid_fs/D#/DBLQH/S#.FragLognodeid#DSNoOfFragmentLogFilesNDB Cluster 数据节点文件系统目录。
要读取的文件的名称后面可能跟有此处列出的一个或多个选项：
-dump
命令行格式
-dump
打印转储信息。
--file-key,
-K
命令行格式
--file-key=key
介绍
8.0.31-ndb-8.0.31
stdin使用、
tty或文件
提供文件解密密钥my.cnf
。
--file-key-from-stdin
命令行格式
--file-key-from-stdin
介绍
8.0.31-ndb-8.0.31
使用 提供文件解密密钥stdin。
命令行格式
-filedescriptors
-filedescriptors：仅打印文件描述符。
命令行格式
--help
--help：打印使用信息。
-lap
命令行格式
-lap
提供单圈信息，最大 GCI 开始和完成。
命令行格式
-mbyte #
类型
数字
默认值
0
最小值
0
最大值
15
-mbyte
#: 起始兆字节。
#是 0 到 15 之间的整数，包括 0 到 15。
命令行格式
-mbyteheaders
-mbyteheaders：只显示文件中每兆字节的首页页眉。
命令行格式
-noprint
-noprint：不打印日志文件的内容。
命令行格式
-nocheck
-nocheck: 不要检查日志文件是否有错误。
命令行格式
-page #
类型
整数
默认值
0
最小值
0
最大值
31
-page
#: 从此页面开始。
#是 0 到 31（含）范围内的整数。
命令行格式
-pageheaders
-pageheaders：仅显示页眉。
命令行格式
-pageindex #
类型
整数
默认值
12
最小值
12
最大值
8191
-pageindex
#: 从此页索引开始。
#是 12 到 8191 之间的整数，包括在内。
-twiddle
命令行格式
-twiddle
位移转储。
像ndb_print_backup_file和
ndb_print_schema_file（与大多数
NDB旨在在管理服务器主机上运行或连接到管理服务器的实用程序不同）ndb_redo_log_reader必须在集群数据节点上运行，因为它直接访问数据节点文件系统。因为它不使用管理服务器，所以可以在管理服务器未运行时使用此实用程序，甚至在集群已完全关闭时也可以使用。
© Mysql 中文网
