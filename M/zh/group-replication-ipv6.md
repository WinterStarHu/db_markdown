# 18.5.5 支持 IPv6 和混合 IPv6 和 IPv4 组_MySQL 8.0 参考手册

18.5.5 支持 IPv6 和混合 IPv6 和 IPv4 组_MySQL 8.0 参考手册
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
18.1 组复制背景
18.2 开始
18.3 要求和限制
18.4 监控组复制
18.5 组复制操作
18.5.1 配置在线群组1
18.5.2 重启组1
18.5.3 交易一致性保证1
18.5.4 分布式恢复1
18.5.5 支持 IPv6 和混合 IPv6 和 IPv4 组1
18.5.6 将 MySQL 企业备份与组复制一起使用1
18.6 组复制安全
18.7 组复制性能和故障排除
18.8 升级组复制
18.9 组复制系统变量
18.10 常见问题
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
MySQL 8.0 参考手册  / 第十八章 组复制  / 18.5 组复制操作  /
18.5.5 支持 IPv6 和混合 IPv6 和 IPv4 组
18.5.5 支持 IPv6 和混合 IPv6 和 IPv4 组
从 MySQL 8.0.14 开始，Group Replication 组成员可以使用 IPv6 地址替代 IPv4 地址进行组内通信。要使用 IPv6 地址，服务器主机上的操作系统和 MySQL 服务器实例都必须配置为支持 IPv6。有关为服务器实例设置 IPv6 支持的说明，请参阅第 5.1.13 节，“IPv6 支持”。
IPv6 地址或解析到它们的主机名可以指定为成员在
group_replication_local_address
其他成员的连接选项中提供的网络地址。当使用端口号指定时，必须在方括号中指定 IPv6 地址，例如：
group_replication_local_address= "[2001:db8:85a3:8d3:1319:8a2e:370:7348]:33061"
Group Replication 使用中指定的网络地址或主机名
group_replication_local_address
作为复制组内组成员的唯一标识符。如果指定为服务器实例的组复制本地地址的主机名同时解析为 IPv4 和 IPv6 地址，则 IPv4 地址始终用于组复制连接。指定为组复制本地地址的地址或主机名与 MySQL 服务器 SQL 协议主机和端口不同，并且未在bind_address
服务器实例的系统变量中指定。出于组复制的 IP 地址权限的目的（请参阅
第 18.6.4 节，“组复制 IP 地址权限”)，您为每个组成员指定的地址
group_replication_local_address
必须添加到
复制组中其他服务器上
的group_replication_ip_allowlist
（来自 MySQL 8.0.22）或
系统变量的列表中。group_replication_ip_whitelist
复制组可以包含提供 IPv6 地址作为其组复制本地地址的成员和提供 IPv4 地址的成员的组合。当服务器加入这样的混合组时，它必须使用种子成员在
group_replication_group_seeds
选项中通告的协议（无论是 IPv4 还是 IPv6）与种子成员进行初始联系。如果该组的任何种子成员列在
group_replication_group_seeds
当加入成员具有 IPv4 组复制本地地址时使用 IPv6 地址选项，反之亦然，您还必须为加入成员设置并允许所需协议的替代地址（或解析为地址的主机名该协议）。如果加入成员没有适当协议的允许地址，则拒绝其连接尝试。备用地址或主机名只需要添加到复制组中其他服务器上的
group_replication_ip_allowlist
（从 MySQL 8.0.22 开始）或
group_replication_ip_whitelist
系统变量，而不是
group_replication_local_address
加入成员的值（只能包含一个地址）。
例如，服务器 A 是组的种子成员，并且具有以下组复制配置设置，因此它在
group_replication_group_seeds
选项中通告 IPv6 地址：
group_replication_bootstrap_group=on
group_replication_local_address= "[2001:db8:85a3:8d3:1319:8a2e:370:7348]:33061"
group_replication_group_seeds= "[2001:db8:85a3:8d3:1319:8a2e:370:7348]:33061"
服务器 B 是该组的加入成员，并且具有以下组复制配置设置，因此它具有 IPv4 组复制本地地址：
group_replication_bootstrap_group=off
group_replication_local_address= "203.0.113.21:33061"
group_replication_group_seeds= "[2001:db8:85a3:8d3:1319:8a2e:370:7348]:33061"
服务器 B 也有一个备用 IPv6 地址
2001:db8:8b0:40:3d9c:cc43:e006:19e8。为使服务器 B 成功加入该组，其 IPv4 组复制本地地址及其备用 IPv6 地址都必须列在服务器 A 的白名单中，如以下示例所示：
group_replication_ip_allowlist=
"203.0.113.0/24,2001:db8:85a3:8d3:1319:8a2e:370:7348,
2001:db8:8b0:40:3d9c:cc43:e006:19e8"
作为组复制 IP 地址权限的最佳实践，服务器 B（和所有其他组成员）应该具有与服务器 A 相同的白名单，除非安全要求另有要求。
如果复制组的任何或所有成员正在使用不支持使用 IPv6 地址进行组复制的旧 MySQL 服务器版本，则成员不能使用 IPv6 地址（或解析为一个的主机名）参与该组作为其组复制本地地址。这适用于以下情况：至少一个现有成员使用 IPv6 地址，而一个不支持该地址的新成员尝试加入；以及一个新成员尝试使用 IPv6 地址加入但该组至少包括一个不支持这个的成员。在每种情况下，新成员都不能加入。要使加入成员为组通信提供 IPv4 地址，您可以更改
group_replication_local_address
到 IPv4 地址，或配置您的 DNS 以将加入成员的现有主机名解析为 IPv4 地址。将每个组成员升级到支持组复制的 IPv6 的 MySQL 服务器版本后，您可以将
group_replication_local_address
每个成员的值更改为 IPv6 地址，或配置 DNS 以提供 IPv6 地址。更改值
group_replication_local_address
仅在您停止并重新启动 Group Replication 时生效。
IPv6 地址也可以用作分布式恢复端点，可以使用
group_replication_advertise_recovery_endpoints
系统变量从 MySQL 8.0.21 指定。相同的规则适用于此列表中使用的地址。请参阅
第 18.5.4.1 节，“分布式恢复的连接”。
© Mysql 中文网
