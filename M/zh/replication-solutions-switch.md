# 17.4.8 在故障转移期间切换源_MySQL 8.0 参考手册

17.4.8 在故障转移期间切换源_MySQL 8.0 参考手册
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
17.1 配置复制
17.2 复制实现
17.3 复制安全
17.4 复制解决方案
17.4.1 使用复制进行备份1
17.4.2 处理副本的意外停止1
17.4.3 监控基于行的复制1
17.4.4 使用不同源和副本存储引擎的复制1
17.4.5 使用复制进行横向扩展1
17.4.6 将不同的数据库复制到不同的副本1
17.4.7 提高复制性能1
17.4.8 在故障转移期间切换源1
17.4.9 使用异步连接故障转移切换源和副本1
17.4.10 半同步复制1
17.4.11 延迟复制1
17.5 复制注意事项和技巧
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
MySQL 8.0 参考手册  / 第十七章复制  / 17.4 复制解决方案  /
17.4.8 在故障转移期间切换源
17.4.8 在故障转移期间切换源
CHANGE REPLICATION SOURCE TO
您可以使用语句（来自 MySQL 8.0.23）或语句（MySQL 8.0.23 之前）
告诉副本更改为新源
CHANGE
MASTER TO。副本不检查源上的数据库是否与副本上的数据库兼容；它只是从新源的二进制日志中的指定坐标开始读取和执行事件。在故障转移情况下，组中的所有服务器通常都从同一个二进制日志文件执行相同的事件，因此更改事件源不应影响数据库的结构或完整性，前提是您在制作改变。
副本应该在启用二进制日志记录（
--log-bin选项）的情况下运行，这是默认设置。如果您不使用 GTID 进行复制，那么副本也应该运行
--log-slave-updates=OFF（默认记录副本更新）。这样，副本就可以成为源，而无需重新启动副本
mysqld。假设您的结构如图17.4 “使用复制的冗余，初始结构”所示。
图 17.4 使用复制的冗余，初始结构
在此图中，MySQL Source拥有源数据库，MySQL Replica主机是副本，Web Client机器发出数据库读写。只发出读取（并且通常会连接到副本）的 Web 客户端没有显示，因为它们在发生故障时不需要切换到新服务器。有关读/写横向扩展复制结构的更详细示例，请参阅
第 17.4.5 节，“使用复制进行横向扩展”。
每个 MySQL 副本（Replica 1、Replica
2和Replica 3）都是一个启用二进制日志记录并运行的副本
--log-slave-updates=OFF。因为指定时副本从源接收的更新没有记录在二进制日志
--log-slave-updates=OFF中，所以每个副本上的二进制日志最初是空的。如果由于某种原因MySQL Source变得不可用，您可以选择其中一个副本作为新的来源。例如，如果您选择Replica 1，则所有
内容Web Clients都应重定向到
Replica 1，它将更新写入其二进制日志。Replica 2然后Replica
3应该从复制Replica
1。
运行副本的原因
--log-slave-updates=OFF是为了防止副本在您导致其中一个副本成为新源的情况下接收两次更新。如果Replica
1已--log-slave-updates
启用（这是默认设置），它会将收到的任何更新写入Source自己的二进制日志中。这意味着，当它的来源Replica 2从
Source变为时Replica 1，它可能会收到Replica 1
它已经从 收到的更新Source。
确保所有副本都已处理其中继日志中的任何语句。在每个副本上，发出
STOP REPLICA
IO_THREAD，然后检查 的输出，
SHOW PROCESSLIST直到看到
Has read all relay log。当所有副本都如此时，可以将它们重新配置为新设置。Replica 1在被提升为源的副本上，发布STOP
REPLICA和RESET MASTER.
在其他副本Replica 2and
Replica 3上，使用
STOP
REPLICAand CHANGE REPLICATION SOURCE TO
SOURCE_HOST='Replica1'or CHANGE MASTER TO
MASTER_HOST='Replica1'（其中
'Replica1'代表 的真实主机名
Replica 1）。使用CHANGE
REPLICATION SOURCE TO| CHANGE MASTER
TO, 添加有关如何连接到
Replica 1fromReplica 2或
Replica 3( user,
password,
port) 的所有信息。在这种情况下发出语句时，无需指定
Replica 1要读取的二进制日志文件的名称或日志位置，因为第一个二进制日志文件和位置 4 是默认值。最后执行
START
REPLICAonReplica 2和
Replica 3。
一旦新的复制设置就位，您需要告诉每个
Web Client人将其语句定向到
Replica 1. 从那时起，由Web Clientto
发送的所有更新语句Replica 1都将写入 的二进制日志
Replica 1，然后包含Replica 1自
Source停止以来发送给的每个更新语句。
生成的服务器结构
如图 17.5 “源故障后使用复制的冗余”所示。
图 17.5 使用复制的冗余，源故障后
当Source再次可用时，您应该使它成为Replica 1. 为此，请在Source同一个
CHANGE REPLICATION SOURCE TO|
CHANGE MASTER TO发表于Replica 2及Replica
3之前的声明。Source然后成为其副本Replica 1并拾取
Web Client它在离线时错过的写入。
要Source再次创建源，请使用前面的过程，就好像Replica 1不可用并且Source将成为新源一样。在此过程中，不要忘记
RESET MASTER在Replica
1制作Replica 1、
Replica 2和Replica 3
的副本之前继续运行Source。如果您不这样做，副本可能会从应用程序中获取过时的写入，这些Web
Client应用程序的日期是在Source变得不可用之前。
您应该知道副本之间没有同步，即使它们共享相同的源，因此一些副本可能会远远领先于其他副本。这意味着在某些情况下，前面示例中概述的过程可能无法按预期工作。然而，在实践中，所有副本上的中继日志应该相对靠近。
让应用程序了解源位置的一种方法是为源服务器设置一个动态 DNS 条目。bind您可以使用动态
nsupdate
更新 DNS。
© Mysql 中文网
