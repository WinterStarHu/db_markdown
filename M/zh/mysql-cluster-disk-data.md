# 23.6.10 NDB Cluster 磁盘数据表_MySQL 8.0 参考手册

23.6.10 NDB Cluster 磁盘数据表_MySQL 8.0 参考手册
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
23.6.1 NDB Cluster Management Client 中的命令1
23.6.2 NDB Cluster 日志消息1
23.6.3 NDB Cluster 中生成的事件报告1
23.6.4 NDB Cluster 启动阶段总结1
23.6.5 执行 NDB Cluster 的滚动重启1
23.6.6 NDB Cluster 单用户模式1
23.6.7 在线添加 NDB Cluster 数据节点1
23.6.8 NDB Cluster 在线备份1
23.6.9 NDB Cluster 的 MySQL 服务器使用1
23.6.10 NDB Cluster 磁盘数据表1
23.6.10.1 NDB Cluster 磁盘数据对象
23.6.10.2 NDB Cluster 磁盘数据存储要求
23.6.11 在 NDB Cluster 中使用 ALTER TABLE 进行在线操作1
23.6.12 权限同步和 NDB_STORED_USER1
23.6.13 NDB Cluster 的文件系统加密1
23.6.14 NDB API 统计计数器和变量1
23.6.15 ndbinfo：NDB 集群信息数据库1
23.6.16 NDB Cluster 的 INFORMATION_SCHEMA 表1
23.6.17 NDB Cluster 和性能模式1
23.6.18 快速参考：NDB Cluster SQL 语句1
23.6.19 NDB Cluster 安全问题1
23.6.9 导入数据到MySQL集群1
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.6 NDB Cluster的管理  /
23.6.10 NDB Cluster 磁盘数据表
23.6.10 NDB Cluster 磁盘数据表
23.6.10.1 NDB Cluster 磁盘数据对象23.6.10.2 NDB Cluster 磁盘数据存储要求
NDB Cluster 支持将表的非索引列存储
NDB在磁盘上，而不是 RAM 中。列数据和日志记录元数据保存在数据文件和撤消日志文件中，概念化为表空间和日志文件组，如下一节所述 - 请参阅
第 23.6.10.1 节，“NDB Cluster Disk Data Objects”。
NDB Cluster 磁盘数据性能会受到许多配置参数的影响。有关这些参数及其影响的信息，请参阅
磁盘数据配置参数和
磁盘数据和 GCP 停止错误。
当磁盘数据文件使用单独的磁盘时，
您还应该将
DiskDataUsingSameDisk数据节点配置参数设置为。false
另请参阅
磁盘数据文件系统参数。
NDB 8.0 在将磁盘数据表与固态驱动器一起使用时提供改进的支持，尤其是那些使用 NVMe 的驱动器。有关详细信息，请参阅以下文档：
磁盘数据延迟参数
第 23.6.15.31 节，“ndbinfo diskstat 表”
第 23.6.15.32 节，“ndbinfo diskstats_1sec 表”
第 23.6.15.49 节，“ndbinfo pgman_time_track_stats 表”
© Mysql 中文网
