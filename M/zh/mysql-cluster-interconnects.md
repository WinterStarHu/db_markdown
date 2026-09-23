# 23.4.4 使用 NDB Cluster 的高速互连_MySQL 8.0 参考手册

23.4.4 使用 NDB Cluster 的高速互连_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.4 NDB Cluster的配置  /
23.4.4 使用 NDB Cluster 的高速互连
23.4.4 使用 NDB Cluster 的高速互连
甚至NDBCLUSTER
在 1996 年开始设计之前，很明显在构建并行数据库时遇到的主要问题之一就是网络中节点之间的通信。出于这个原因，
NDBCLUSTER从一开始就设计为允许使用多种不同的数据传输机制。在本手册中，我们对这些使用术语
转运体。
NDB Cluster 代码库提供四种不同的传输器：
使用 100 Mbps 或千兆位以太网的 TCP/IP，如
第 23.4.3.10 节，“NDB Cluster TCP/IP 连接”中所述。
直接（机器对机器）TCP/IP；尽管此传输器使用与上一项中提到的相同的 TCP/IP 协议，但它需要以不同方式设置硬件，并且配置也不同。因此，它被认为是 NDB Cluster 的单独传输机制。有关详细信息，请参阅
第 23.4.3.11 节，“使用直接连接的 NDB Cluster TCP/IP 连接”。
共享内存 (SHM)。有关 SHM 的更多信息，请参阅第 23.4.3.12 节，“NDB Cluster 共享内存连接”。
可扩展相干接口 (SCI)。
笔记
在 NDB Cluster 中使用 SCI 传输器需要专门的硬件、软件和 MySQL 二进制文件，NDB 8.0 不可用。
现在大多数用户都在以太网上使用 TCP/IP，因为它无处不在。TCP/IP 也是迄今为止经过最佳测试的与 NDB Cluster 一起使用的传输器。
无论使用何种传输器，NDB
都应尝试确保使用尽可能大的块与数据节点进程进行通信，因为这有利于所有类型的数据传输。
© Mysql 中文网
