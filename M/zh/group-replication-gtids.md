# 18.4.1 GTID 和组复制_MySQL 8.0 参考手册

18.4.1 GTID 和组复制_MySQL 8.0 参考手册
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
18.4.1 GTID 和组复制1
18.4.2 组复制服务器状态1
18.4.3 replication_group_members 表1
18.4.4 replication_group_member_stats 表1
18.5 组复制操作
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
MySQL 8.0 参考手册  / 第十八章 组复制  / 18.4 监控组复制  /
18.4.1 GTID 和组复制
18.4.1 GTID 和组复制
Group Replication 使用 GTID（全局事务标识符）来准确跟踪在每个服务器实例上提交了哪些事务。所有组成员都需要设置
gtid_mode=ON和
。enforce_gtid_consistency=ON来自客户端的传入事务由接收它们的组成员分配一个 GTID。组成员在异步复制通道上从组外的源服务器接收到的任何复制事务都会保留它们到达组成员时的 GTID。
分配给来自客户端的传入事务的 GTID 使用
group_replication_group_name
系统变量指定的组名称作为标识符的 UUID 部分，而不是接收事务的单个组成员的服务器 UUID。因此，可以识别组直接接收的所有事务，并将它们组合在 GTID 集中，并且最初接收到它们的成员无关紧要。每个组成员都有一个连续的 GTID 块，供其使用，当这些被消耗时，它会保留更多。系统变量设置块的
group_replication_gtid_assignment_block_size
大小，每个块默认有 100 万个 GTID。
View_change_log_event当新成员加入时由组本身生成的
视图更改事件 ( ) 在记录在二进制日志中时会被赋予 GTID。默认情况下，这些事件的 GTID 还使用
group_replication_group_name
系统变量指定的组名作为标识符的 UUID 部分。从 MySQL 8.0.26 开始，您可以设置 Group Replication 系统变量
group_replication_view_change_uuid
在 GTID 中使用替代 UUID 来查看更改事件，以便它们很容易与组从客户端接收的事务区分开来。如果您的设置允许在组之间进行故障转移，并且您需要识别和丢弃特定于备份组的事务，这将很有用。备用 UUID 必须不同于成员的服务器 UUID。它还必须不同于使用
语句
ASSIGN_GTIDS_TO_ANONYMOUS_TRANSACTIONS选项应用于匿名事务的 GTID 中的任何 UUID。CHANGE REPLICATION SOURCE TO
从 MySQL 8.0.27 开始，设置GTID_ONLY=1、
REQUIRE_ROW_FORMAT = 1和
SOURCE_AUTO_POSITION = 1应用于组复制通道
group_replication_applier和
group_replication_recovery。创建组复制通道时，或者当复制组中的成员服务器升级到 8.0.27 或更高版本时，这些设置会自动在组复制通道上进行。这些选项通常使用CHANGE REPLICATION SOURCE
TO语句设置，但请注意，您不能为组复制通道禁用它们。设置这些选项后，组成员不会在这些通道的复制元数据存储库中保留文件名和文件位置。GTID 自动定位和 GTID 自动跳过用于在必要时定位正确的接收器和应用器位置。
额外交易
如果加入的成员在其 GTID 集中有事务，而该事务不存在于该组的现有成员上，则不允许它完成分布式恢复过程，也不能加入该组。如果执行了远程克隆操作，这些事务将被删除和丢失，因为加入成员上的数据目录已被删除。如果从捐助者的二进制日志执行状态传输，这些交易可能会与该组的交易发生冲突。
如果在组复制停止时在实例上执行管理事务，则成员上可能存在额外事务。为避免以这种方式引入新事务，请始终
在发出管理语句之前将sql_log_bin系统变量
的值设置为，然后再设置为：
OFFONSET SQL_LOG_BIN=0;
<administrator action>
SET SQL_LOG_BIN=1;
将此系统变量设置为OFF意味着从那时起直到您将其设置回之前发生的事务ON不会写入二进制日志，并且不会为它们分配 GTID。
如果加入成员上存在额外事务，请检查受影响服务器的二进制日志以查看额外事务实际包含的内容。将加入成员的数据和 GTID 集与当前组中的成员进行协调的最安全方法是使用 MySQL 的克隆功能将内容从组中的服务器传输到受影响的服务器。有关执行此操作的说明，请参阅
第 5.6.7.3 节，“克隆远程数据”。如果需要事务，请在成员成功重新加入后重新运行它。
© Mysql 中文网
