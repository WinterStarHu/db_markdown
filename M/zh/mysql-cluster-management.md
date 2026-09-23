# 23.6 NDB Cluster的管理_MySQL 8.0 参考手册

23.6 NDB Cluster的管理_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  /
23.6 NDB Cluster的管理
23.6 NDB Cluster的管理
23.6.1 NDB Cluster Management Client 中的命令23.6.2 NDB Cluster 日志消息23.6.3 NDB Cluster 中生成的事件报告23.6.4 NDB Cluster 启动阶段总结23.6.5 执行 NDB Cluster 的滚动重启23.6.6 NDB Cluster 单用户模式23.6.7 在线添加 NDB Cluster 数据节点23.6.8 NDB Cluster 在线备份23.6.9 NDB Cluster 的 MySQL 服务器使用23.6.10 NDB Cluster 磁盘数据表23.6.11 在 NDB Cluster 中使用 ALTER TABLE 进行在线操作23.6.12 权限同步和 NDB_STORED_USER23.6.13 NDB Cluster 的文件系统加密23.6.14 NDB API 统计计数器和变量23.6.15 ndbinfo：NDB 集群信息数据库23.6.16 NDB Cluster 的 INFORMATION_SCHEMA 表23.6.17 NDB Cluster 和性能模式23.6.18 快速参考：NDB Cluster SQL 语句23.6.19 NDB Cluster 安全问题
管理 NDB Cluster 涉及许多任务，第一个是配置和启动 NDB Cluster。这在
第 23.4 节，“NDB Cluster 的配置”和
第 23.5 节，“NDB Cluster 程序”中有所介绍。
接下来的几节介绍了正在运行的 NDB Cluster 的管理。
有关与 NDB Cluster 的管理和部署相关的安全问题的信息，请参阅
第 23.6.19 节，“NDB Cluster 安全问题”。
基本上有两种主动管理正在运行的 NDB Cluster 的方法。第一个是通过使用输入到管理客户端的命令来检查集群状态、更改日志级别、启动和停止备份以及停止和启动节点。第二种方法涉及研究集群日志的内容
；这通常位于管理服务器的
目录中，但可以使用该
选项覆盖此位置。（回想一下，它表示正在记录其活动的节点的唯一标识符。）集群日志包含由
ndbd生成的事件报告。也可以将集群日志条目发送到 Unix 系统日志。
ndb_node_id_cluster.logDataDirLogDestinationnode_id
还可以使用该
SHOW ENGINE NDB
STATUS语句从 SQL 节点监视集群操作的某些方面。
有关 NDB Cluster 操作的更多详细信息可通过使用数据库的 SQL 接口实时获得
ndbinfo。有关更多信息，请参阅第 23.6.15 节，“ndbinfo：NDB Cluster 信息数据库”。
NDB 统计计数器使用
mysql客户端提供改进的监视。这些计数器在 NDB 内核中实现，与对象执行或影响
Ndb对象的操作相关，例如开始、关闭和中止事务；主键和唯一键操作；表、范围和修剪扫描；等待各种操作完成的阻塞线程；NDB Cluster 发送和接收的数据和事件。每当进行 NDB API 调用或将数据发送到数据节点或由数据节点接收数据时，NDB 内核都会增加计数器。
mysqld将 NDB API 统计计数器公开为系统状态变量，可以从它们所有名称的公共前缀 (Ndb_api_) 中识别出来。这些变量的值可以在
mysql客户端中从
SHOW STATUS语句的输出中读取，或者通过查询性能模式
session_status或
global_status表来读取。通过比较某条作用于表的SQL语句执行前后状态变量的值，NDB可以观察到该语句对应的NDB API层面的动作，有利于NDB的监控和性能调优簇。
MySQL Cluster Manager 提供了一个高级命令行界面，可以简化许多其他复杂的 NDB Cluster 管理任务，例如启动、停止或重新启动具有大量节点的 NDB Cluster。MySQL Cluster Manager 客户端还支持用于获取和设置大多数节点配置参数值的命令，以及
与 NDB Cluster 相关的mysqld服务器选项和变量。MySQL Cluster Manager 版本 1.4.8 为 NDB 8.0 提供实验性支持。有关详细信息，请参阅MySQL Cluster Manager 1.4.8 用户手册。
© Mysql 中文网
