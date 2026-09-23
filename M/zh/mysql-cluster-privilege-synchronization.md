# 23.6.12 权限同步和 NDB_STORED_USER_MySQL 8.0 参考手册

23.6.12 权限同步和 NDB_STORED_USER_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.6 NDB Cluster的管理  /
23.6.12 权限同步和 NDB_STORED_USER
23.6.12 权限同步和 NDB_STORED_USER
NDB 8.0 引入了一种新机制，用于在连接到 NDB Cluster 的 SQL 节点之间共享和同步用户、角色和权限。这可以通过授予
NDB_STORED_USER特权来启用。有关使用信息，请参阅权限说明。
NDB_STORED_USER与任何其他特权一样打印在输出中
SHOW GRANTS，如下所示：
mysql> SHOW GRANTS for 'jon'@'localhost';
+---------------------------------------------------+
| Grants for jon@localhost                          |
+---------------------------------------------------+
| GRANT USAGE ON *.* TO `jon`@`localhost`           |
| GRANT NDB_STORED_USER ON *.* TO `jon`@`localhost` |
+---------------------------------------------------+您还可以使用 NDB Cluster 提供的ndb_select_all实用程序
验证此帐户是否共享特权，如下所示（一些输出包装以保留格式）：
$> ndb_select_all -d mysql ndb_sql_metadata | grep '`jon`@`localhost`'
12      "'jon'@'localhost'"     0       [NULL]  "GRANT USAGE ON *.* TO `jon`@`localhost`"
11      "'jon'@'localhost'"     0       2       "CREATE USER `jon`@`localhost`
IDENTIFIED WITH 'caching_sha2_password' AS
0x2441243030352466014340225A107D590E6E653B5D587922306102716D752E6656772F3038512F
6C5072776D30376D37347A384B557A4C564F70495158656A31382E45324E33
REQUIRE NONE PASSWORD EXPIRE DEFAULT ACCOUNT UNLOCK PASSWORD HISTORY DEFAULT
PASSWORD REUSE INTERVAL DEFAULT PASSWORD REQUIRE CURRENT DEFAULT"
12      "'jon'@'localhost'"     1       [NULL]  "GRANT NDB_STORED_USER ON *.* TO `jon`@`localhost`"
ndb_sql_metadata是使用mysql或其他 MySQL 客户端
NDB不可见
的特殊
表。
授予
NDB_STORED_USER权限的语句（例如
GRANT NDB_STORED_USER ON *.* TO
'cluster_app_user'@'localhost'）通过指示
NDB使用查询
SHOW CREATE USER cluster_app_user@localhost和
创建快照SHOW GRANTS FOR cluster_app_user@localhost，然后将结果存储在中来工作ndb_sql_metadata。然后请求任何其他 SQL 节点读取和应用快照。每当 MySQL 服务器启动并作为 SQL 节点加入集群时，它都会执行这些存储
CREATE USER的
GRANT语句，作为集群模式同步过程的一部分。
每当 SQL 语句在其起源节点以外的 SQL 节点上执行时，该语句都会在NDBCLUSTER存储引擎的实用程序线程中运行；这是在与 MySQL 复制副本应用程序线程等效的安全环境中完成的。
从 NDB 8.0.27 开始，执行更改用户权限的 SQL 节点在执行此操作之前需要全局锁，这可以防止在不同 SQL 节点上并发 ACL 操作造成死锁。在 NDB 8.0.27 之前，对 users 的更改以
NDB_STORED_USER完全异步的方式更新，没有采取任何锁定。
您应该记住，因为共享模式更改操作是同步执行的，所以在对任何一个或多个共享用户进行更改后的下一个共享模式更改将用作同步点。在架构更改分发开始之前，任何待处理的用户更改都会运行完成；在此之后，架构更改本身会同步运行。例如，如果
DROP DATABASE语句跟在
DROP USER分布式用户的 a 之后，则只有在所有 SQL 节点上完成用户删除后，才能删除数据库。
如果来自多个 SQL 节点的多个GRANT、
REVOKE或其他用户管理语句导致给定用户的权限在不同的 SQL 节点上发生分歧，您可以通过GRANT NDB_STORED_USER
在权限已知的 SQL 节点上为该用户发出命令来解决此问题正确的; 这会导致获取权限的新快照并将其同步到其他 SQL 节点。
NDB Cluster 8.0 不支持通过更改 MySQL 权限表在 NDB Cluster 中跨 SQL 节点分配 MySQL 用户和权限，以便它们使用
NDBNDB 7.6 和早期版本中的存储引擎（请参阅
使用共享授权表的分布式权限）。有关此更改对从先前版本升级到 NDB 8.0 的影响的信息，请参阅
第 23.3.7 节，“升级和降级 NDB Cluster”。
© Mysql 中文网
