# 23.3.1 在 Linux 上安装 NDB Cluster_MySQL 8.0 参考手册

23.3.1 在 Linux 上安装 NDB Cluster_MySQL 8.0 参考手册
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
23.3.1 在 Linux 上安装 NDB Cluster1
23.3.1.1 在 Linux 上安装 NDB Cluster 二进制版本
23.3.1.2 从 RPM 安装 NDB Cluster
23.3.1.3 使用 .deb 文件安装 NDB Cluster
23.3.1.4 在 Linux 上从源构建 NDB Cluster
23.3.2 在 Windows 上安装 NDB Cluster1
23.3.3 NDB Cluster 的初始配置1
23.3.4 NDB Cluster 初始启动1
23.3.5 带有表和数据的 NDB Cluster 示例1
23.3.6 NDB Cluster 的安全关闭和重启1
23.3.7 升级和降级 NDB Cluster1
23.3.8 NDB Cluster 自动安装程序（不再支持）1
23.4 NDB Cluster的配置
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.3 NDB Cluster 安装  /
23.3.1 在 Linux 上安装 NDB Cluster
23.3.1 在 Linux 上安装 NDB Cluster
23.3.1.1 在 Linux 上安装 NDB Cluster 二进制版本23.3.1.2 从 RPM 安装 NDB Cluster23.3.1.3 使用 .deb 文件安装 NDB Cluster23.3.1.4 在 Linux 上从源构建 NDB Cluster
本节介绍 Linux 和其他类 Unix 操作系统上 NDB Cluster 的安装方法。虽然接下来的几节涉及 Linux 操作系统，但那里给出的说明和过程应该很容易适应其他受支持的类 Unix 平台。有关特定于 Windows 系统的手动安装和设置说明，请参阅
第 23.3.2 节，“在 Windows 上安装 NDB Cluster”。
每个 NDB Cluster 主机计算机都必须安装正确的可执行程序。运行 SQL 节点的主机必须在其上安装 MySQL 服务器二进制文件 ( mysqld )。管理节点需要管理服务器守护进程（ndb_mgmd）；数据节点需要数据节点守护进程（ndbd或ndbmtd）。没有必要在管理节点主机和数据节点主机上安装 MySQL 服务器二进制文件。建议您还在管理服务器主机上
安装管理客户端 ( ndb_mgm )。
在 Linux 上安装 NDB Cluster 可以使用来自 Oracle 的预编译二进制文件（作为 .tar.gz 存档下载）、RPM 包（也可以从 Oracle 获得）或源代码来完成。所有这三种安装方法都在下面的部分中进行了描述。
无论使用何种方法，在启动集群之前，安装 NDB Cluster 二进制文件后仍然需要为所有集群节点创建配置文件。请参阅
第 23.3.3 节，“NDB Cluster 的初始配置”。
© Mysql 中文网
