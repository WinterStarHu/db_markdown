# 23.4 NDB Cluster的配置_MySQL 8.0 参考手册

23.4 NDB Cluster的配置_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  /
23.4 NDB Cluster的配置
23.4 NDB Cluster的配置
23.4.1 NDB Cluster 的快速测试设置23.4.2 NDB Cluster 配置参数、选项和变量概述23.4.3 NDB Cluster 配置文件23.4.4 使用 NDB Cluster 的高速互连
作为 NDB Cluster 一部分的 MySQL 服务器在一个主要方面与普通（非集群）MySQL 服务器不同，因为它使用NDB存储引擎。该引擎有时也称为
NDBCLUSTER，尽管
NDB是首选。
为了避免不必要的资源分配，服务器默认配置为NDB
禁用存储引擎。要启用NDB，您必须修改服务器的my.cnf
配置文件，或者使用该
--ndbcluster选项启动服务器。
这个MySQL服务器是集群的一部分，所以它也必须知道如何访问管理节点来获取集群配置数据。默认行为是在 上查找管理节点
localhost。但是，如果您需要指定它的位置在别处，这可以在 中
my.cnf或使用mysql
客户端完成。在NDB可以使用存储引擎之前，至少有一个管理节点以及任何所需的数据节点必须处于运行状态。
有关特定于 NDB Cluster 的
--ndbcluster其他
mysqld选项
的更多信息
，请参阅第 23.4.3.9.1 节，“NDB Cluster 的 MySQL 服务器选项”。
有关安装 NDB Cluster 的一般信息，请参阅
第 23.3 节，“NDB Cluster 安装”。
© Mysql 中文网
