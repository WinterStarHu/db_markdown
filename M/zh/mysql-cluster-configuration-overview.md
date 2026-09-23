# 23.4.2 NDB Cluster 配置参数、选项和变量概述_MySQL 8.0 参考手册

23.4.2 NDB Cluster 配置参数、选项和变量概述_MySQL 8.0 参考手册
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
23.4.2.1 NDB Cluster 数据节点配置参数
23.4.2.2 NDB Cluster 管理节点配置参数
23.4.2.3 NDB Cluster SQL 节点和 API 节点配置参数
23.4.2.4 其他 NDB Cluster 配置参数
23.4.2.5 NDB Cluster mysqld 选项和变量参考
23.4.3 NDB Cluster 配置文件1
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
23.4.2 NDB Cluster 配置参数、选项和变量概述
23.4.2 NDB Cluster 配置参数、选项和变量概述
23.4.2.1 NDB Cluster 数据节点配置参数23.4.2.2 NDB Cluster 管理节点配置参数23.4.2.3 NDB Cluster SQL 节点和 API 节点配置参数23.4.2.4 其他 NDB Cluster 配置参数23.4.2.5 NDB Cluster mysqld 选项和变量参考
接下来的几节提供
config.ini文件中用于管理节点行为的各个方面的 NDB Cluster 节点配置参数的汇总表，以及
mysqldmy.cnf在作为 NDB Cluster 进程运行时从文件或命令行读取的选项和变量的汇总表. 每个节点参数表都列出了给定类型的参数（ndbd、ndb_mgmd、
mysqld、computer、
tcp或shm）。所有表格都包括参数、选项或变量的数据类型，以及适用的默认值、最小值和最大值。
重新启动节点时的注意事项。
对于节点参数，这些表还指示需要哪种类型的重启（节点重启或系统重启）——以及重启是否必须完成
--initial——以更改给定配置参数的值。在执行节点重启或初始节点重启时，必须依次重启集群的所有数据节点（也称为
滚动重启）。可以用这种方式更新标记为
node在线的集群配置参数——也就是说，无需关闭集群。初始节点重启需要使用该选项
重启每个ndbd进程。--initial
系统重启需要完全关闭并重启整个集群。初始系统重启需要对集群进行备份，关闭后擦除集群文件系统，然后在重启后从备份中恢复。
在任何集群重启中，集群的所有管理服务器都必须重启才能读取更新的配置参数值。
重要的
数字集群参数的值通常可以毫无问题地增加，尽管建议逐步这样做，以相对较小的增量进行此类调整。其中许多可以使用滚动重启在线增加。
然而，降低这些参数的值——无论是使用节点重启、节点初始重启，还是集群的整个系统重启——都不是轻率的；建议您仅在仔细规划和测试后才这样做。对于那些与内存使用和磁盘空间相关的参数（例如
MaxNoOfTables、
MaxNoOfOrderedIndexes和
）尤其如此MaxNoOfUniqueHashIndexes。此外，通常情况下，与内存和磁盘使用相关的配置参数可以通过简单的节点重启来提高，但它们需要初始节点重启才能降低。
因为其中一些参数可用于配置不止一种类型的集群节点，所以它们可能出现在多个表中。
笔记
4294967039在这些表中通常显示为最大值。此值在
NDBCLUSTER源中定义为
MAX_INT_RNIL并且等于
0xFFFFFEFF，或
。
232 −
28 − 1
© Mysql 中文网
