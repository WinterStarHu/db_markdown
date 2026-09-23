# 23.6.5 执行 NDB Cluster 的滚动重启_MySQL 8.0 参考手册

23.6.5 执行 NDB Cluster 的滚动重启_MySQL 8.0 参考手册
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
23.6.5 执行 NDB Cluster 的滚动重启
23.6.5 执行 NDB Cluster 的滚动重启
本节讨论如何执行 NDB Cluster 安装的
滚动重启，之所以这样称呼是因为它涉及依次停止和启动（或重启）每个节点，以便集群本身保持运行。这通常作为
滚动升级或
滚动降级的一部分完成，其中集群的高可用性是强制性的，并且不允许整个集群停机。在我们提到升级的地方，此处提供的信息通常也适用于降级。
滚动重启可能是可取的，原因有很多。这些将在接下来的几段中进行描述。
配置更改。
更改集群的配置，例如向集群添加 SQL 节点，或将配置参数设置为新值。
NDB Cluster 软件升级或降级。
将集群升级到更新版本的 NDB Cluster 软件（或将其降级到旧版本）。这通常称为“滚动升级”（或
“滚动降级”，当恢复到旧版本的 NDB Cluster 时）。
在节点主机上更改。
更改运行一个或多个 NDB Cluster 节点进程的硬件或操作系统。
系统重置（集群重置）。
重置集群，因为它已达到不希望的状态。在这种情况下，通常需要重新加载一个或多个数据节点的数据和元数据。这可以通过以下三种方式中的任何一种来完成：
使用选项启动每个数据节点进程（ndbd或可能的ndbmtd）
--initial，这会强制数据节点清除其文件系统并从其他数据节点重新加载所有 NDB Cluster 数据和元数据。
从 NDB 8.0.21 开始，这也强制删除所有磁盘数据对象和与这些对象关联的文件。
在执行重新启动之前使用ndb_mgm客户端
命令
创建备份。升级后，使用ndb_restoreSTART BACKUP恢复一个或多个节点。
有关更多信息，请参阅第 23.6.8 节，“NDB Cluster 的在线备份”和
第 23.5.23 节，“ndb_restore - 恢复 NDB Cluster 备份”。
在升级之前使用mysqldump创建备份；之后，使用 恢复转储
LOAD DATA。
资源回收。 INSERT释放先前由连续和
操作
分配给表的内存
DELETE，以供其他 NDB Cluster 表重用。
执行滚动重启的过程可以概括如下：
停止所有集群管理节点（ndb_mgmd
进程），重新配置它们，然后重新启动它们。（请参阅
使用多个管理服务器滚动重启。）
停止、重新配置，然后依次重启每个集群数据节点（ndbd进程）。
可以通过在上一步之后为ndb_mgmRESTART客户端中的每个数据节点
发布来更新一些节点配置参数
。其他参数要求使用管理客户端命令完全停止数据节点
，然后通过
适当地调用ndbd或ndbmtd可执行文件从系统 shell 重新启动
。（在大多数 Unix 系统上也可以使用
诸如
kill之类的 shell 命令来停止数据节点进程，但该命令是首选，而且通常更简单。）
STOPSTOP
笔记
在 Windows 上，您还可以使用SC STOP和
SC START命令NET
STOP和NET START命令，或 Windows 服务管理器来停止和启动已安装为 Windows 服务的节点（请参阅
第 23.3.2.4 节，“将 NDB Cluster 进程安装为 Windows 服务” ).
所需的重启类型在每个节点配置参数的文档中指明。请参阅
第 23.4.3 节，“NDB Cluster 配置文件”。
停止、重新配置，然后依次重新启动每个集群 SQL 节点（mysqld进程）。
NDB Cluster 支持某种程度上灵活的节点升级顺序。升级 NDB Cluster 时，您可以在升级管理节点、数据节点或两者之前升级 API 节点（包括 SQL 节点）。换句话说，您可以按任何顺序升级 API 和 SQL 节点。须遵守下列规定：
此功能仅用作在线升级的一部分。来自不同 NDB Cluster 版本的节点二进制文件的混合既不打算也不支持在生产环境中连续、长期使用。
在升级任何不同类型的节点之前，您必须升级所有相同类型的节点（管理、数据或 API 节点）。无论节点升级的顺序如何，这都是正确的。
在升级任何数据节点之前，您必须升级所有管理节点。无论您升级集群的 API 和 SQL 节点的顺序如何，这都是正确的。
在升级所有管理节点和数据节点之前，不得使用
特定于“新”版本的功能。
这也适用于任何可能适用的 MySQL 服务器版本更改，以及 NDB 引擎版本更改，因此在计划升级时不要忘记考虑这一点。（一般来说，这对于 NDB Cluster 的在线升级是正确的。）
任何 API 节点都不可能在节点重启期间执行模式操作（例如数据定义语句）。部分由于此限制，在线升级或降级期间也不支持模式操作。此外，升级或降级正在进行时无法执行本机备份。
使用多个管理服务器滚动重启。
当执行具有多个管理节点的 NDB Cluster 的滚动重启时，您应该记住
ndb_mgmd检查是否有任何其他管理节点正在运行，如果是，则尝试使用该节点的配置数据。为了防止这种情况发生，并强制ndb_mgmd重新读取其配置文件，请执行以下步骤：
停止所有 NDB Cluster ndb_mgmd进程。
更新所有config.ini文件。
根据需要使用
、
或两个选项
启动单个ndb_mgmd 。--reload--initial
如果您使用该
选项启动了第一个ndb_mgmd--initial ，则还必须使用 启动任何剩余的ndb_mgmd进程--initial。
无论启动第一个
ndb_mgmd时使用的任何其他选项如何，您都不应该在第一个使用后启动任何剩余的ndb_mgmd--reload进程。
正常完成数据节点和 API 节点的滚动重启。
当执行滚动重启以更新集群的配置时，您可以使用该
表的config_generation列
ndbinfo.nodes来跟踪哪些数据节点已使用新配置成功重启。请参阅
第 23.6.15.47 节，“ndbinfo 节点表”。
© Mysql 中文网
