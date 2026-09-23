# 32.5 维护_MySQL 8.0 参考手册

32.5 维护_MySQL 8.0 参考手册
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
第24章分区
第25章存储对象
第 26 章 INFORMATION_SCHEMA 表
第 27 章 MySQL 性能模式
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
32.1 在 Oracle Cloud Infrastructure 上部署 MySQL EE 的先决条件
32.2 在 Oracle 云基础设施上部署 MySQL EE
32.3 配置网络访问
32.4 连接
32.5 维护
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 32 章 OCI 市场上的 MySQL  /
32.5 维护
32.5 维护
本产品由用户管理，这意味着您负责升级和维护。
升级 MySQL
现有安装是基于 RPM 的，要升级 MySQL 服务器，请参阅第 2.11.6 节，“在 Unix/Linux 上升级 MySQL 二进制或基于包的安装”。
您可以使用scp将所需的 RPM 复制到 OCI 计算实例，或从 OCI 对象存储复制它，如果您配置了对它的访问。文件存储也是一种选择。有关详细信息，请参阅
文件存储和 NFS。
备份还原
MySQL Enterprise Backup 是首选的备份和恢复解决方案。有关详细信息，请参阅
备份到云存储。
有关 MySQL Enterprise Backup 的信息，请参阅 MySQL Enterprise Backup
入门。
有关默认 MySQL 备份和恢复的信息，请参阅
第 7 章，备份和恢复。
© Mysql 中文网
