# 第 23 章 MySQL NDB Cluster 8.0_MySQL 8.0 参考手册

第 23 章 MySQL NDB Cluster 8.0_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  /
第 23 章 MySQL NDB Cluster 8.0
第 23 章 MySQL NDB Cluster 8.0
目录23.1 一般信息23.2 NDB Cluster 概述23.2.1 NDB Cluster 核心概念23.2.2 NDB Cluster 节点、节点组、片段副本和分区23.2.3 NDB Cluster 硬件、软件和网络要求23.2.4 NDB Cluster 中的新功能23.2.5 NDB 8.0 中添加、弃用或删除的选项、变量和参数23.2.6 使用 InnoDB 的 MySQL 服务器与 NDB Cluster 比较23.2.7 NDB Cluster 的已知限制23.3 NDB Cluster 安装23.3.1 在 Linux 上安装 NDB Cluster23.3.2 在 Windows 上安装 NDB Cluster23.3.3 NDB Cluster 的初始配置23.3.4 NDB Cluster 初始启动23.3.5 带有表和数据的 NDB Cluster 示例23.3.6 NDB Cluster 的安全关闭和重启23.3.7 升级和降级 NDB Cluster23.3.8 NDB Cluster 自动安装程序（不再支持）23.4 NDB Cluster的配置23.4.1 NDB Cluster 的快速测试设置23.4.2 NDB Cluster 配置参数、选项和变量概述23.4.3 NDB Cluster 配置文件23.4.4 使用 NDB Cluster 的高速互连23.5 NDB 集群程序23.5.1 ndbd — NDB Cluster 数据节点守护进程23.5.2 ndbinfo_select_all — 从 ndbinfo 表中选择23.5.3 ndbmtd — NDB Cluster 数据节点守护进程（多线程）23.5.4 ndb_mgmd — NDB 集群管理服务器守护进程23.5.5 ndb_mgm — NDB 集群管理客户端23.5.6 ndb_blob_tool — 检查和修复 NDB 集群表的 BLOB 和 TEXT 列23.5.7 ndb_config — 提取 NDB Cluster 配置信息23.5.8 ndb_delete_all — 从 NDB 表中删除所有行23.5.9 ndb_desc — 描述 NDB 表23.5.10 ndb_drop_index — 从 NDB 表中删除索引23.5.11 ndb_drop_table — 删除 NDB 表23.5.12 ndb_error_reporter — NDB 错误报告实用程序23.5.13 ndb_import — 将 CSV 数据导入 NDB23.5.14 ndb_index_stat — NDB 索引统计实用程序23.5.15 ndb_move_data — NDB 数据复制实用程序23.5.16 ndb_perror — 获取 NDB 错误消息信息23.5.17 ndb_print_backup_file — 打印 NDB 备份文件内容23.5.18 ndb_print_file — 打印 NDB 磁盘数据文件内容23.5.19 ndb_print_frag_file — 打印 NDB 片段列表文件内容23.5.20 ndb_print_schema_file — 打印 NDB 模式文件内容23.5.21 ndb_print_sys_file — 打印 NDB 系统文件内容23.5.22 ndb_redo_log_reader - 检查和打印集群重做日志的内容23.5.23 ndb_restore — 恢复 NDB Cluster 备份23.5.24 ndb_secretsfile_reader — 从加密的 NDB 数据文件中获取密钥信息23.5.25 ndb_select_all — 从 NDB 表打印行23.5.26 ndb_select_count — 打印 NDB 表的行数23.5.27 ndb_show_tables — 显示 NDB 表列表23.5.28 ndb_size.pl — NDBCLUSTER 大小需求估计器23.5.29 ndb_top — 查看 NDB 线程的 CPU 使用信息23.5.30 ndb_waiter — 等待 NDB Cluster 达到给定状态23.5.31 ndbxfrm — 压缩、解压缩、加密和解密 NDB Cluster 创建的文件23.6 NDB Cluster的管理23.6.1 NDB Cluster Management Client 中的命令23.6.2 NDB Cluster 日志消息23.6.3 NDB Cluster 中生成的事件报告23.6.4 NDB Cluster 启动阶段总结23.6.5 执行 NDB Cluster 的滚动重启23.6.6 NDB Cluster 单用户模式23.6.7 在线添加 NDB Cluster 数据节点23.6.8 NDB Cluster 在线备份23.6.9 NDB Cluster 的 MySQL 服务器使用23.6.10 NDB Cluster 磁盘数据表23.6.11 在 NDB Cluster 中使用 ALTER TABLE 进行在线操作23.6.12 权限同步和 NDB_STORED_USER23.6.13 NDB Cluster 的文件系统加密23.6.14 NDB API 统计计数器和变量23.6.15 ndbinfo：NDB 集群信息数据库23.6.16 NDB Cluster 的 INFORMATION_SCHEMA 表23.6.17 NDB Cluster 和性能模式23.6.18 快速参考：NDB Cluster SQL 语句23.6.19 NDB Cluster 安全问题23.7 NDB 集群复制23.7.1 NDB Cluster 复制：缩写和符号23.7.2 NDB Cluster 复制的一般要求23.7.3 NDB Cluster 复制中的已知问题23.7.4 NDB Cluster 复制模式和表23.7.5 准备 NDB Cluster 进行复制23.7.6 启动 NDB Cluster 复制（单复制通道）23.7.7 使用两个复制通道进行 NDB Cluster 复制23.7.8 使用 NDB Cluster 复制实现故障转移23.7.9 使用 NDB Cluster 复制的 NDB Cluster 备份23.7.10 NDB Cluster 复制：双向和循环复制23.7.11 NDB Cluster 复制冲突解决23.8 NDB Cluster 发行说明
本章提供有关 MySQL
NDB Cluster的信息，这是一个适用于分布式计算环境的高可用性、高冗余版本的 MySQL。最新的 NDB Cluster 版本系列使用版本 8 的
NDB存储引擎（也称为
NDBCLUSTER）来支持在集群中运行带有 MySQL 服务器和其他软件的多台计算机。NDB Cluster 8.0，现在作为一般可用性 (GA) 版本提供（从版本 8.0.19 开始），包含
NDB存储引擎的版本 8.0。NDB Cluster 7.6 和 NDB Cluster 7.5，仍然作为 GA 版本提供，使用 7.6 和 7.5 版本NDB， 分别。以前的 GA 版本仍然可用于生产，NDB Cluster 7.4 和 NDB Cluster 7.3，NDB分别包含版本 7.4 和 7.3。不再支持或维护 NDB 7.2 和更早版本系列。
本章包含有关 NDB Cluster 8.0 版本到 8.0.32 的信息。NDB Cluster 8.0 现在（从 NDB 8.0.19 开始）作为一般可用性版本可用，并推荐用于新部署；最新的可用版本是 NDB 8.0.31。NDB Cluster 7.6 和 7.5 是之前的 GA 版本，在生产中仍然受支持；有关 NDB Cluster 7.6 的信息，请参阅 NDB Cluster 7.6
中的新增功能。有关 NDB Cluster 7.5 的类似信息，请参阅
What is New in NDB Cluster 7.5。NDB Cluster 7.4 和 7.3 是以前的 GA 版本，在生产中仍然支持，尽管我们建议新的生产部署使用 NDB Cluster 8.0；请参阅
MySQL NDB Cluster 7.3 和 NDB Cluster 7.4。
© Mysql 中文网
