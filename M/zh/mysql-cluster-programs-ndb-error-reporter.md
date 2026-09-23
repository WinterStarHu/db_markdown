# 23.5.12 ndb_error_reporter — NDB 错误报告实用程序_MySQL 8.0 参考手册

23.5.12 ndb_error_reporter — NDB 错误报告实用程序_MySQL 8.0 参考手册
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
23.5.12 ndb_error_reporter — NDB 错误报告实用程序
23.5.12 ndb_error_reporter — NDB 错误报告实用程序
ndb_error_reporter从数据节点和管理节点日志文件创建存档，可用于帮助诊断错误或集群的其他问题。强烈建议您在提交 NDB Cluster 中的错误报告时使用此实用程序。
下表显示了
可与
ndb_error_reporter一起使用的选项。表后有其他说明。
表 23.34 与程序 ndb_error_reporter 一起使用的命令行选项
格式
描述
添加、弃用或删除
--connection-timeout=#
超时前连接到节点时等待的秒数
（支持所有基于 MySQL 8.0 的 NDB 版本）
--dry-scp
禁用远程主机的 scp；仅用于测试
（支持所有基于 MySQL 8.0 的 NDB 版本）
--fs
在错误报告中包含文件系统数据；可以使用大量的磁盘空间
（支持所有基于 MySQL 8.0 的 NDB 版本）
--help,
-?
显示帮助文本并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--skip-nodegroup=#
跳过节点组中具有此 ID 的所有节点
（支持所有基于 MySQL 8.0 的 NDB 版本）
用法
ndb_error_reporter path/to/config-file [username] [options]
此实用程序旨在用于管理节点主机，并且需要管理主机配置文件（通常名为config.ini）的路径。或者，您可以提供能够使用 SSH 访问集群数据节点的用户名，以复制数据节点日志文件。
然后， ndb_error_reporter将所有这些文件包含在在运行它的同一目录中创建的存档中。存档名为
，其中是日期时间字符串。
ndb_error_report_YYYYMMDDhhmmss.tar.bz2YYYYMMDDhhmmss
ndb_error_reporter也接受此处列出的选项：
--connection-timeout=timeout
命令行格式
--connection-timeout=#
类型
整数
默认值
0
在超时之前尝试连接到节点时等待这么多秒。
--dry-scp
命令行格式
--dry-scp
在不使用来自远程主机的 scp 的情况下
运行ndb_error_reporter 。仅用于测试。
--help
命令行格式
--help
显示帮助文本并退出。
--fs
命令行格式
--fs
将数据节点文件系统复制到管理主机并将它们包含在存档中。
因为数据节点文件系统可能非常大，即使在压缩之后，我们要求您不要
将使用此选项创建的存档发送给 Oracle，除非您被特别要求这样做。
--skip-nodegroup=nodegroup_id
命令行格式
--connection-timeout=#
类型
整数
默认值
0
跳过属于具有提供的节点组 ID 的节点组的所有节点。
© Mysql 中文网
