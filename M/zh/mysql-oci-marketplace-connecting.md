# 32.4 连接_MySQL 8.0 参考手册

32.4 连接_MySQL 8.0 参考手册
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
32.4 连接
32.4 连接
本节介绍用于连接到 OCI 计算实例上已部署的 MySQL 服务器的各种连接方法。
使用 SSH 连接
本节提供有关从类 UNIX 平台连接到 OCI 计算的一些详细信息。有关使用 SSH 连接的更多信息，请参阅
使用 SSH 访问 Oracle Linux 实例并
连接到您的实例。
要使用 SSH 连接到在计算实例上运行的 Oracle Linux，请运行以下命令：
ssh opc@computeIP
其中opc是计算用户，
computeIP是您的计算实例的 IP 地址。
要查找为 root 用户创建的临时 root 密码，请运行以下命令：
sudo grep 'temporary password' /var/log/mysqld.log
要更改您的默认密码，请使用生成的临时密码登录服务器，使用以下命令：
mysql -uroot -p。然后运行以下命令：
ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass4!';
与 MySQL 客户端连接
笔记
要从本地 MySQL 客户端连接，您必须首先在 MySQL 服务器上创建一个允许远程登录的用户。
要从本地 MySQL 客户端连接到 MySQL 服务器，请从 shell 会话运行以下命令：
mysql -uroot -p -hcomputeIPcomputeIP您的计算实例的 IP 地址
在哪里。
连接 MySQL Shell
要从本地 MySQL Shell 连接到 MySQL 服务器，请运行以下命令以启动 shell 会话：
mysqlsh \connect root@computeIPcomputeIP您的计算实例的 IP 地址
在哪里。
有关 MySQL Shell 连接的更多信息，请参阅
MySQL Shell 连接。
与工作台连接
要从 MySQL Workbench 连接到 MySQL 服务器，请参阅
MySQL Workbench 中的连接。
© Mysql 中文网
