# 23.4.3 NDB Cluster 配置文件_MySQL 8.0 参考手册

23.4.3 NDB Cluster 配置文件_MySQL 8.0 参考手册
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
23.4.1 NDB Cluster 的快速测试设置1
23.4.2 NDB Cluster 配置参数、选项和变量概述1
23.4.3 NDB Cluster 配置文件1
23.4.3.1 NDB Cluster 配置：基本示例
23.4.3.2 NDB Cluster 的推荐启动配置
23.4.3.3 NDB Cluster 连接字符串
23.4.3.4 在 NDB Cluster 中定义计算机
23.4.3.5 定义 NDB Cluster 管理服务器
23.4.3.6 定义 NDB Cluster 数据节点
23.4.3.7 在 NDB Cluster 中定义 SQL 和其他 API 节点
23.4.3.8 定义系统
23.4.3.9 NDB Cluster 的 MySQL 服务器选项和变量
23.4.3.10 NDB Cluster TCP/IP 连接
23.4.3.11 使用直接连接的 NDB Cluster TCP/IP 连接
23.4.3.12 NDB Cluster 共享内存连接
23.4.3.13 数据节点内存管理
23.4.3.14 配置 NDB Cluster 发送缓冲区参数
23.4.4 使用 NDB Cluster 的高速互连1
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.4 NDB Cluster的配置  /
23.4.3 NDB Cluster 配置文件
23.4.3 NDB Cluster 配置文件
23.4.3.1 NDB Cluster 配置：基本示例23.4.3.2 NDB Cluster 的推荐启动配置23.4.3.3 NDB Cluster 连接字符串23.4.3.4 在 NDB Cluster 中定义计算机23.4.3.5 定义 NDB Cluster 管理服务器23.4.3.6 定义 NDB Cluster 数据节点23.4.3.7 在 NDB Cluster 中定义 SQL 和其他 API 节点23.4.3.8 定义系统23.4.3.9 NDB Cluster 的 MySQL 服务器选项和变量23.4.3.10 NDB Cluster TCP/IP 连接23.4.3.11 使用直接连接的 NDB Cluster TCP/IP 连接23.4.3.12 NDB Cluster 共享内存连接23.4.3.13 数据节点内存管理23.4.3.14 配置 NDB Cluster 发送缓冲区参数
配置 NDB Cluster 需要使用两个文件：
my.cnf：指定所有 NDB Cluster 可执行文件的选项。您在之前使用 MySQL 的工作中应该熟悉该文件，集群中运行的每个可执行文件都必须可以访问该文件。
config.ini：该文件，有时称为全局配置文件，仅由 NDB Cluster 管理服务器读取，然后将其中包含的信息分发给参与集群的所有进程。
config.ini包含集群中涉及的每个节点的描述。这包括数据节点的配置参数和集群中所有节点之间连接的配置参数。有关可以出现在该文件中的部分的快速参考，以及可以在每个部分中放置哪些配置参数，请参阅
文件的部分config.ini。
缓存配置数据。
NDB使用状态配置。不是每次重新启动管理服务器时都读取全局配置文件，而是管理服务器在第一次启动时缓存配置，此后，仅当以下条件之一为真时才读取全局配置文件：
管理服务器使用 --initial 选项启动。
使用时--initial，重新读取全局配置文件，删除任何现有的缓存文件，管理服务器创建新的配置缓存。
管理服务器使用 --reload 选项启动。
该--reload选项使管理服务器将其缓存与全局配置文件进行比较。如果不同，管理服务器创建一个新的配置缓存；任何现有的配置缓存都会被保留，但不会被使用。如果管理服务器的缓存和全局配置文件包含相同的配置数据，则使用现有的缓存，并且不创建新的缓存。
管理服务器使用 --config-cache=FALSE 启动。
这将禁用
--config-cache（默认情况下启用），并可用于强制管理服务器完全绕过配置缓存。在这种情况下，管理服务器会忽略可能存在的任何配置文件，
config.ini而是始终从文件中读取其配置数据。
未找到配置缓存。
在这种情况下，管理服务器读取全局配置文件并创建一个缓存，其中包含与文件中相同的配置数据。
配置缓存文件。 mysql-cluster默认情况下，管理服务器在 MySQL 安装目录中
命名的目录中创建配置缓存文件。（如果您在 Unix 系统上从源代码构建 NDB Cluster，则默认位置为
/usr/local/mysql-cluster。）这可以在运行时通过使用该
--configdir选项启动管理服务器来覆盖。配置缓存文件是根据模式命名的二进制文件
，其中是管理服务器在集群中的节点 ID，
是缓存标识符。缓存文件使用顺序编号
ndb_node_id_config.bin.seq_idnode_idseq_idseq_id, 按照它们的创建顺序。管理服务器使用由seq_id.
笔记
可以通过删除后面的配置缓存文件或重命名较早的缓存文件以使其具有更高的
seq_id. 但是，由于配置缓存文件是以二进制格式编写的，因此您不应尝试手动编辑它们的内容。
有关 NDB Cluster 管理服务器的 、 、 和选项的更多信息
--configdir，
--config-cache请
--initial参阅
--reload第
23.5.4 节，“ndb_mgmd — NDB Cluster 管理服务器守护程序”。
我们不断改进 NDB Cluster 配置并尝试简化此过程。尽管我们努力保持向后兼容性，但有时可能会引入不兼容的更改。在这种情况下，如果更改不向后兼容，我们会尝试让 NDB Cluster 用户提前知道。如果您发现这样的更改而我们没有记录它，请使用第 1.6 节“如何报告错误或问题”中给出的说明在 MySQL 错误数据库中报告它。
© Mysql 中文网
