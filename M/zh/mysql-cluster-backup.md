# 23.6.8 NDB Cluster 在线备份_MySQL 8.0 参考手册

23.6.8 NDB Cluster 在线备份_MySQL 8.0 参考手册
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
23.6.8.1 NDB Cluster 备份概念
23.6.8.2 使用 NDB Cluster Management Client 创建备份
23.6.8.3 NDB Cluster 备份的配置
23.6.8.4 NDB Cluster 备份故障排除
23.6.8.5 使用并行数据节点进行 NDB 备份
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.6 NDB Cluster的管理  /
23.6.8 NDB Cluster 在线备份
23.6.8 NDB Cluster 在线备份
23.6.8.1 NDB Cluster 备份概念23.6.8.2 使用 NDB Cluster Management Client 创建备份23.6.8.3 NDB Cluster 备份的配置23.6.8.4 NDB Cluster 备份故障排除23.6.8.5 使用并行数据节点进行 NDB 备份
接下来的几节描述了如何使用在ndb_mgm管理客户端
中找到的用于此目的的功能来准备然后创建 NDB Cluster 备份。为了将这种类型的备份与使用
mysqldump进行的备份区分开来，我们有时将其称为
“本机” NDB Cluster 备份。（有关使用mysqldump创建备份的信息，请参阅
第 4.5.4 节，“mysqldump — 数据库备份程序”。）NDB Cluster 备份的恢复是使用NDB Cluster 发行版提供的ndb_restore实用程序完成的；有关
ndb_restore的信息及其在恢复 NDB Cluster 备份中的用途，请参阅
第 23.5.23 节，“ndb_restore - 恢复 NDB Cluster 备份”。
NDB 8.0 可以使用多个 LDM 创建备份以实现数据节点上的并行性。请参阅
第 23.6.8.5 节，“使用并行数据节点进行 NDB 备份”。
© Mysql 中文网
