# 18.5.2 重启组_MySQL 8.0 参考手册

18.5.2 重启组_MySQL 8.0 参考手册
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
18.5.2 重启组
18.5.2 重启组
Group Replication 旨在确保数据库服务持续可用，即使组成该组的某些服务器当前由于计划维护或计划外问题而无法参与其中。只要剩下的成员是该组的大多数，他们就可以选举一个新的主要成员并继续作为一个组运行。但是，如果复制组的每个成员都离开该组，并且通过STOP
GROUP_REPLICATION语句或系统关闭在每个成员上停止组复制，则该组现在仅在理论上存在，作为成员的配置。在那种情况下，要重新创建组，必须像第一次启动一样通过引导启动它。
第一次引导一个组和第二次或以后引导组之间的区别在于，在后一种情况下，被关闭的组的成员可能具有彼此不同的事务集，这取决于关闭的顺序他们被阻止或失败了。如果成员具有其他组成员不存在的事务，则该成员不能加入组。对于 Group Replication，这包括已提交和应用的gtid_executed事务（在 GTID 集中）和已认证但尚未应用的事务（在
group_replication_applier渠道。提交事务的确切点取决于为组设置的事务一致性级别（请参阅
第 18.5.3 节，“事务一致性保证”）。但是，Group Replication 组成员永远不会删除已经过认证的事务，这是成员提交事务的意图声明。
因此，复制组必须从最新的成员开始重新启动，即执行和认证的事务最多的成员。事务较少的成员然后可以加入并通过分布式恢复追上他们丢失的事务。假设组中最后一个已知的主要成员是组中最新的成员是不正确的，因为比主要成员更晚关闭的成员可能有更多事务。因此，您必须重新启动每个成员以检查事务、比较所有事务集并确定最新的成员。然后可以使用该成员来引导该组。
按照此过程在每个成员关闭后安全地重新启动复制组。
以任何顺序依次为每个组成员：
将客户端连接到组成员。如果 Group Replication 尚未停止，请发出STOP
GROUP_REPLICATION语句并等待 Group Replication 停止。
编辑 MySQL 服务器配置文件（通常
my.cnf在 Linux 和 Unix 系统或
my.iniWindows 系统上命名）并设置系统变量
group_replication_start_on_boot=OFF. 此设置可防止 Group Replication 在 MySQL Server 启动时启动，这是默认设置。
如果您无法更改系统上的该设置，您可以只允许服务器尝试启动组复制，这将失败，因为该组已完全关闭且尚未启动。如果您采用这种方法，请不要
group_replication_bootstrap_group=ON
在此阶段在任何服务器上进行设置。
启动 MySQL Server 实例，并验证 Group Replication 尚未启动（或启动失败）。不要在这个阶段开始组复制。
从小组成员那里收集以下信息：
gtid_executedGTID 集
的内容
。您可以通过发出以下语句来获取此信息：
mysql> SELECT @@GLOBAL.GTID_EXECUTEDgroup_replication_applier通道
上经过认证的交易集
。您可以通过发出以下语句来获取此信息：
mysql> SELECT received_transaction_set FROM \
performance_schema.replication_connection_status WHERE \
channel_name="group_replication_applier";
当您收集了所有组成员的交易集后，将它们进行比较以找出总体上哪个成员的交易集最大，包括已执行的交易（gtid_executed）和已认证的交易（在
group_replication_applier通道上）。您可以通过查看 GTID 手动执行此操作，也可以使用存储函数比较 GTID 集，如
第 17.1.3.8 节“操作 GTID 的存储函数示例”中所述。
通过将客户端连接到组成员并发出以下语句，使用具有最大事务集的成员来引导组：
mysql> SET GLOBAL group_replication_bootstrap_group=ON;
mysql> START GROUP_REPLICATION;
mysql> SET GLOBAL group_replication_bootstrap_group=OFF;
重要的是不要将设置存储
group_replication_bootstrap_group=ON
在配置文件中，否则当服务器再次重新启动时，会设置第二个同名的组。
要验证该组现在是否存在并包含该创始人成员，请对引导它的成员发出以下语句：
mysql> SELECT * FROM performance_schema.replication_group_members;START
GROUP_REPLICATION通过对每个成员发出声明
，以任何顺序将每个其他成员添加回组中：mysql> START GROUP_REPLICATION;
要验证每个成员都已加入该组，请对任何成员发出此语句：
mysql> SELECT * FROM performance_schema.replication_group_members;
当成员重新加入群组时，如果您将他们的配置文件编辑为 set
group_replication_start_on_boot=OFF，则可以再次编辑它们以进行设置ON（或删除系统变量，因为ON是默认设置）。
© Mysql 中文网
