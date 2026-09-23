# 23.7.2 NDB Cluster 复制的一般要求_MySQL 8.0 参考手册

23.7.2 NDB Cluster 复制的一般要求_MySQL 8.0 参考手册
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
23.7.1 NDB Cluster 复制：缩写和符号1
23.7.2 NDB Cluster 复制的一般要求1
23.7.3 NDB Cluster 复制中的已知问题1
23.7.4 NDB Cluster 复制模式和表1
23.7.5 准备 NDB Cluster 进行复制1
23.7.6 启动 NDB Cluster 复制（单复制通道）1
23.7.7 使用两个复制通道进行 NDB Cluster 复制1
23.7.8 使用 NDB Cluster 复制实现故障转移1
23.7.9 使用 NDB Cluster 复制的 NDB Cluster 备份1
23.7.10 NDB Cluster 复制：双向和循环复制1
23.7.11 NDB Cluster 复制冲突解决1
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.7 NDB 集群复制  /
23.7.2 NDB Cluster 复制的一般要求
23.7.2 NDB Cluster 复制的一般要求
复制通道需要两个 MySQL 服务器充当复制服务器（源和副本各一个）。例如，这意味着在具有两个复制通道（为冗余提供额外通道）的复制设置的情况下，总共应该有四个复制节点，每个集群两个。
本节和以下部分中描述的 NDB Cluster 的复制依赖于基于行的复制。这意味着复制源 MySQL 服务器必须使用
--binlog-format=ROW或
运行--binlog-format=MIXED，如第 23.7.6 节，“启动 NDB Cluster 复制（单复制通道）”中所述。有关基于行的复制的一般信息，请参阅
第 17.2.1 节，“复制格式”。
重要的
如果您尝试将 NDB Cluster Replication 与 一起使用
--binlog-format=STATEMENT，复制将无法正常工作，因为
ndb_binlog_index源 cluster上的表和副本 cluster 上epoch的表的列
ndb_apply_status未更新（请参阅
第 23.7.4 节，“NDB Cluster 复制模式和表” ). 相反，只有作为复制源的 MySQL 服务器上的更新才会传播到副本，而不会复制来自源集群中任何其他 SQL 节点的更新。
该
--binlog-format选项
的默认值为MIXED。
任一集群中用于复制的每个 MySQL 服务器必须在参与任一集群的所有 MySQL 复制服务器中唯一标识（源集群和副本集群上的复制服务器不能共享相同的 ID）。这可以通过使用
选项启动每个 SQL 节点来完成，其中是一个唯一的整数。尽管这不是绝对必要的，但出于本次讨论的目的，我们假设所有 NDB Cluster 二进制文件都具有相同的发行版本。
--server-id=idid
在 MySQL 复制中通常是这样的，涉及的两个 MySQL 服务器（mysqld进程）必须在使用的复制协议版本和它们支持的 SQL 功能集方面相互兼容（参见第 17.5.2 节，“复制MySQL 版本之间的兼容性”）。由于 NDB Cluster 和 MySQL Server 8.0 发行版中的二进制文件之间存在这种差异，NDB Cluster Replication 有额外的要求，即两个
mysqld二进制文件都来自 NDB Cluster 发行版。确保
mysqld的最简单和最容易的方法服务器兼容是为所有源和副本
mysqld二进制文件使用相同的 NDB Cluster 分布。
我们假设副本服务器或集群专用于源集群的复制，并且没有其他数据存储在其上。
所有NDB被复制的表都必须使用 MySQL 服务器和客户端创建。使用 NDB API（例如，
Dictionary::createTable()）创建的表和其他数据库对象对 MySQL 服务器不可见，因此不会被复制。可以复制 NDB API 应用程序对使用 MySQL 服务器创建的现有表的更新。
笔记
可以使用基于语句的复制来复制 NDB Cluster。但是，在这种情况下，以下限制适用：
作为源的集群上对数据行的所有更新都必须定向到单个 MySQL 服务器。
不可能使用多个同步的 MySQL 复制进程来复制集群。
仅复制在 SQL 级别所做的更改。
这些是基于语句的复制相对于基于行的复制的其他限制的补充；有关这两种复制格式之间差异的更多具体信息，
请参阅第 17.2.1.1 节，“基于语句和基于行的复制的优点和缺点” 。
© Mysql 中文网
