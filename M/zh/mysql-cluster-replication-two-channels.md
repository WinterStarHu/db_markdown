# 23.7.7 使用两个复制通道进行 NDB Cluster 复制_MySQL 8.0 参考手册

23.7.7 使用两个复制通道进行 NDB Cluster 复制_MySQL 8.0 参考手册
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
23.7.7 使用两个复制通道进行 NDB Cluster 复制
23.7.7 使用两个复制通道进行 NDB Cluster 复制
在一个更完整的示例场景中，我们设想了两个复制通道来提供冗余，从而防止单个复制通道可能出现故障。这总共需要四台复制服务器，源集群上有两台源服务器，副本集群上有两台副本服务器。为了接下来的讨论，我们假设唯一标识符的分配如下所示：
表 23.73 文中描述的 NDB Cluster 复制服务器
服务器编号
描述
1个
源 - 主复制通道 ( S )
2个
源 - 辅助复制通道 ( S' )
3个
副本 - 主复制通道 ( R )
4个
replica - 辅助复制通道 ( R' )
使用两个通道设置复制与设置单个复制通道没有根本区别。首先，
必须启动主要和次要复制源服务器的mysqld进程，然后是主要和次要副本的进程。复制过程可以通过START
REPLICA在每个副本上发出语句来启动。命令和它们需要发出的顺序如下所示：
启动主复制源：
shellS> mysqld --ndbcluster --server-id=1 \
--log-bin &
启动辅助复制源：
shellS'> mysqld --ndbcluster --server-id=2 \
--log-bin &
启动主副本服务器：
shellR> mysqld --ndbcluster --server-id=3 \
--skip-slave-start &
启动辅助副本服务器：
shellR'> mysqld --ndbcluster --server-id=4 \
--skip-slave-start &
最后，通过在主副本上执行START REPLICA
语句来启动主通道上的复制，如下所示：
mysqlR> START SLAVE;
从 NDB 8.0.22 开始，您还可以使用以下语句：
mysqlR> START REPLICA;
警告
此时只有主通道必须启动。仅在主复制通道发生故障时才需要启动辅助复制通道，如
第 23.7.8 节，“使用 NDB Cluster 复制实现故障转移”中所述。同时运行多个复制通道可能会导致在副本上创建不需要的重复记录。
如前所述，没有必要在副本上启用二进制日志记录。
© Mysql 中文网
