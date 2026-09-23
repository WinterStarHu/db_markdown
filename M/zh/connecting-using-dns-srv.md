# 4.2.6 使用 DNS SRV 记录连接到服务器_MySQL 8.0 参考手册

4.2.6 使用 DNS SRV 记录连接到服务器_MySQL 8.0 参考手册
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
4.1 MySQL程序概述
4.2 使用 MySQL 程序
4.2.1 调用MySQL程序1
4.2.2 指定程序选项1
4.2.3 连接服务器的命令选项1
4.2.4 使用命令选项连接到 MySQL 服务器1
4.2.5 使用类似 URI 的字符串或键值对连接到服务器1
4.2.6 使用 DNS SRV 记录连接到服务器1
4.2.7 连接传输协议1
4.2.8 连接压缩控制1
4.2.9 设置环境变量1
4.3 服务器和服务器启动程序
4.4 安装相关程序
4.5 客户端程序
4.6 管理和实用程序
4.7 程序开发实用程序
4.8 杂项程序
4.9 环境变量
4.10 MySQL 中的 Unix 信号处理
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
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.2 使用 MySQL 程序  /
4.2.6 使用 DNS SRV 记录连接到服务器
4.2.6 使用 DNS SRV 记录连接到服务器
在域名系统 (DNS) 中，SRV 记录（服务位置记录）是一种资源记录，它使客户端能够指定表示服务、协议和域的名称。对该名称的 DNS 查找返回一个回复，其中包含域中提供所需服务的多个可用服务器的名称。有关 DNS SRV 的信息，包括记录如何定义所列服务器的优先顺序，请参阅
RFC 2782。
MySQL 支持使用 DNS SRV 记录连接到服务器。收到 DNS SRV 查找结果的客户端会根据 DNS 管理员分配给每个主机的优先级和权重，尝试按优先顺序连接到每个列出的主机上的 MySQL 服务器。仅当客户端无法连接到任何服务器时才会发生连接失败。
当多个 MySQL 实例（例如服务器集群）为您的应用程序提供相同的服务时，DNS SRV 记录可用于协助故障转移、负载平衡和复制服务。应用程序直接管理连接尝试的候选服务器集很麻烦，DNS SRV 记录提供了一种替代方法：
DNS SRV 记录使 DNS 管理员能够将单个 DNS 域映射到多个服务器。当在配置中添加或删除服务器或更改主机名时，管理员也可以集中更新 DNS SRV 记录。
DNS SRV 记录的集中管理消除了单个客户端识别连接请求中每个可能的主机的需要，或者连接由附加软件组件处理的需要。应用程序可以使用 DNS SRV 记录来获取有关候选 MySQL 服务器的信息，而不是自己管理服务器信息。
DNS SRV 记录可以与连接池结合使用，在这种情况下，与不再在当前 DNS SRV 记录列表中的主机的连接在空闲时从池中删除。
MySQL 支持在这些上下文中使用 DNS SRV 记录连接到服务器：
多个 MySQL 连接器实现了 DNS SRV 支持；特定于连接器的选项允许为 X 协议连接和经典 MySQL 协议连接请求 DNS SRV 记录查找。有关一般信息，请参阅
使用 DNS SRV 记录的连接。有关详细信息，请参阅各个 MySQL 连接器的文档。
C API 提供了一个
mysql_real_connect_dns_srv()
类似于 的函数
mysql_real_connect()，只是参数列表没有指定要连接的 MySQL 服务器的特定主机。相反，它命名一个指定一组服务器的 DNS SRV 记录。请参阅
mysql_real_connect_dns_srv()。
mysql客户端有一个
--dns-srv-name选项来指示指定一组服务器的 DNS SRV 记录
。请参阅第 4.5.1 节，“mysql — MySQL 命令行客户端”。
DNS SRV 名称由服务、协议和域组成，服务和协议均以下划线为前缀：
_service._protocol.domain
以下 DNS SRV 记录标识多个候选服务器，例如客户端可能用于建立 X 协议连接：
Name                      TTL   Class  Priority Weight Port  Target
_mysqlx._tcp.example.com. 86400 IN SRV 0        5      33060 server1.example.com.
_mysqlx._tcp.example.com. 86400 IN SRV 0        10     33060 server2.example.com.
_mysqlx._tcp.example.com. 86400 IN SRV 10       5      33060 server3.example.com.
_mysqlx._tcp.example.com. 86400 IN SRV 20       5      33060 server4.example.com.
这里，mysqlx表示X Protocol服务，tcp表示TCP协议。客户端可以使用名称请求此 DNS SRV 记录
_mysqlx._tcp.example.com。在连接请求中指定名称的特定语法取决于客户端的类型。例如，客户端可能支持在类似 URI 的连接字符串中或作为键值对指定名称。
经典协议连接的 DNS SRV 记录可能如下所示：
Name                     TTL   Class  Priority Weight  Port Target
_mysql._tcp.example.com. 86400 IN SRV 0        5       3306 server1.example.com.
_mysql._tcp.example.com. 86400 IN SRV 0        10      3306 server2.example.com.
_mysql._tcp.example.com. 86400 IN SRV 10       5       3306 server3.example.com.
_mysql._tcp.example.com. 86400 IN SRV 20       5       3306 server4.example.com.
这里的名称mysql指定经典MySQL协议服务，端口为3306（默认经典MySQL协议端口），而不是33060（默认X协议端口）。
使用 DNS SRV 记录查找时，客户端通常必须对连接请求应用这些规则（可能存在客户端或连接器特定的例外情况）：
该请求必须指定完整的 DNS SRV 记录名称，服务和协议名称以下划线为前缀。
该请求不得指定多个主机名。
该请求不得指定端口号。
仅支持 TCP 连接。无法使用 Unix 套接字文件、Windows 命名管道和共享内存。
有关在 X DevAPI 中使用基于 DNS SRV 的连接的更多信息，请参阅使用 DNS SRV 记录的连接。
© Mysql 中文网
