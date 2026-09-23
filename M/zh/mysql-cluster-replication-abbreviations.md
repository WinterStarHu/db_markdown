# 23.7.1 NDB Cluster 复制：缩写和符号_MySQL 8.0 参考手册

23.7.1 NDB Cluster 复制：缩写和符号_MySQL 8.0 参考手册
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
23.7.1 NDB Cluster 复制：缩写和符号
23.7.1 NDB Cluster 复制：缩写和符号
在本节中，我们使用以下缩写或符号来指代源和副本集群，以及在集群或集群节点上运行的进程和命令：
表 23.69 本节中使用的缩写指的是源和副本集群，以及在集群节点上运行的进程和命令
符号或缩写
说明（指...）
S
作为（主）复制源的集群
R
作为（主）副本的集群
shellS>
要在源集群上发出的 Shell 命令
mysqlS>
在源集群上作为 SQL 节点运行的单个 MySQL 服务器上发出的 MySQL 客户端命令
mysqlS*>
在参与复制源集群的所有 SQL 节点上发出 MySQL 客户端命令
shellR>
要在副本集群上发出的 Shell 命令
mysqlR>
在作为副本集群上的 SQL 节点运行的单个 MySQL 服务器上发出 MySQL 客户端命令
mysqlR*>
在参与副本集群的所有 SQL 节点上发出 MySQL 客户端命令
C
主复制通道
C'
二级复制通道
S'
辅助复制源
R'
次要副本
© Mysql 中文网
