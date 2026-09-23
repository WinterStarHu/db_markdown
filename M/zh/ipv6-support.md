# 5.1.13 IPv6 支持_MySQL 8.0 参考手册

5.1.13 IPv6 支持_MySQL 8.0 参考手册
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
5.1.1 配置服务器1
5.1.2 服务器配置默认值1
5.1.3 服务器配置验证1
5.1.4 服务器选项、系统变量、状态变量参考1
5.1.5 服务器系统变量引用1
5.1.6 服务器状态变量参考1
5.1.7 服务器命令选项1
5.1.8 服务器系统变量1
5.1.9 使用系统变量1
5.1.10 服务器状态变量1
5.1.11 服务器 SQL 模式1
5.1.12 连接管理1
5.1.13 IPv6 支持1
5.1.13.1 验证系统对 IPv6 的支持
5.1.13.2 配置 MySQL 服务器以允许 IPv6 连接
5.1.13.3 使用 IPv6 本地主机地址连接
5.1.13.4 使用 IPv6 非本地主机地址连接
5.1.13.5 从 Broker 获取 IPv6 地址
5.1.14 网络命名空间支持1
5.1.15 MySQL 服务器时区支持1
5.1.16 资源组1
5.1.17 服务器端帮助支持1
5.1.18 服务器跟踪客户端会话状态1
5.1.19 服务器关机流程1
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
MySQL 8.0 参考手册  / 第 5 章 MySQL 服务器管理  / 5.1 MySQL 服务器  /
5.1.13 IPv6 支持
5.1.13 IPv6 支持
5.1.13.1 验证系统对 IPv6 的支持5.1.13.2 配置 MySQL 服务器以允许 IPv6 连接5.1.13.3 使用 IPv6 本地主机地址连接5.1.13.4 使用 IPv6 非本地主机地址连接5.1.13.5 从 Broker 获取 IPv6 地址
MySQL 中对 IPv6 的支持包括以下功能：
MySQL 服务器可以接受来自通过 IPv6 连接的客户端的 TCP/IP 连接。例如，此命令通过 IPv6 连接到本地主机上的 MySQL 服务器：
$> mysql -h ::1
要使用此功能，必须满足以下两点：
您的系统必须配置为支持 IPv6。请参阅
第 5.1.13.1 节，“验证系统对 IPv6 的支持”。
除了 IPv4 连接之外，默认的 MySQL 服务器配置还允许 IPv6 连接。要更改默认配置，请将
bind_address系统变量设置为适当的值来启动服务器。请参阅
第 5.1.8 节，“服务器系统变量”。
MySQL 帐户名允许使用 IPv6 地址，使 DBA 能够为通过 IPv6 连接到服务器的客户端指定权限。请参阅第 6.2.4 节，“指定帐户名称”。可以在诸如 、 和 等语句中的帐户名中指定
CREATE USERIPv6
GRANT地址
REVOKE。例如：
mysql> CREATE USER 'bill'@'::1' IDENTIFIED BY 'secret';
mysql> GRANT SELECT ON mydb.* TO 'bill'@'::1';
IPv6 函数支持字符串和内部格式 IPv6 地址格式之间的转换，并检查值是否表示有效的 IPv6 地址。例如，
INET6_ATON()and
INET6_NTOA()类似于
INET_ATON()and
INET_NTOA()，但除了处理 IPv4 地址外，还处理 IPv6 地址。请参见
第 12.24 节，“杂项函数”。
从 MySQL 8.0.14 开始，Group Replication 组成员可以使用 IPv6 地址在组内进行通信。一个组可以同时包含使用 IPv6 的成员和使用 IPv4 的成员。请参阅第 18.5.5 节，“支持 IPv6 以及混合 IPv6 和 IPv4 组”。
以下部分描述了如何设置 MySQL，以便客户端可以通过 IPv6 连接到服务器。
© Mysql 中文网
