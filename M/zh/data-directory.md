# 5.2 MySQL数据目录_MySQL 8.0 参考手册

5.2 MySQL数据目录_MySQL 8.0 参考手册
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
5.1 MySQL 服务器
5.2 MySQL数据目录
5.3 mysql系统架构
5.4 MySQL 服务器日志
5.5 MySQL组件
5.6 MySQL 服务器插件
5.7 MySQL 服务器可加载函数
5.8 在一台机器上运行多个MySQL实例
5.9 调试 MySQL
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
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 5 章 MySQL 服务器管理  /
5.2 MySQL数据目录
5.2 MySQL数据目录
MySQL 服务器管理的信息存储在称为数据目录的目录下。以下列表简要描述了通常在数据目录中找到的项目，并提供了其他信息的交叉引用：
数据目录子目录。数据目录下的每个子目录都是一个数据库目录，对应服务器管理的一个数据库。所有 MySQL 安装都有特定的标准数据库：
该mysql目录对应于
mysql系统架构，其中包含 MySQL 服务器运行时所需的信息。该数据库包含数据字典表和系统表。参见第 5.3 节，“mysql 系统模式”。
该performance_schema目录对应于 Performance Schema，它提供了用于在运行时检查服务器内部执行的信息。请参阅
第 27 章，MySQL 性能模式。
sys目录对应于
模式sys，它提供了一组对象来帮助更轻松地解释性能模式信息。请参阅第 28 章，MySQL 系统模式。
该ndbinfo目录对应于ndbinfo存储特定于 NDB Cluster 的信息的数据库（仅适用于为包含 NDB Cluster 而构建的安装）。请参阅
第 23.6.15 节，“ndbinfo：NDB Cluster 信息数据库”。
其他子目录对应于用户或应用程序创建的数据库。
笔记
INFORMATION_SCHEMA是一个标准的数据库，但它的实现没有使用相应的数据库目录。
服务器写入的日志文件。请参阅
第 5.4 节，“MySQL 服务器日志”。
InnoDB表空间和日志文件。请参阅
第 15 章，InnoDB 存储引擎。
默认/自动生成的 SSL 和 RSA 证书和密钥文件。请参阅第 6.3.3 节，“创建 SSL 和 RSA 证书和密钥”。
服务器进程 ID 文件（当服务器运行时）。
mysqld-auto.cnf存储持久全局系统变量设置
的文件。请参阅
第 13.7.6.1 节，“变量赋值的 SET 语法”。
通过重新配置服务器，可以将前面列表中的某些项目重新定位到别处。此外，该
--datadir选项允许更改数据目录本身的位置。对于给定的 MySQL 安装，检查服务器配置以确定项目是否已移动。
© Mysql 中文网
