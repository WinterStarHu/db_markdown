# 8.14.5 复制 I/O（接收器）线程状态_MySQL 8.0 参考手册

8.14.5 复制 I/O（接收器）线程状态_MySQL 8.0 参考手册
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
8.1 优化概述
8.2 优化SQL语句
8.3 优化和索引
8.4 优化数据库结构
8.5 优化 InnoDB 表
8.6 优化 MyISAM 表
8.7 优化 MEMORY 表
8.8 了解查询执行计划
8.9 控制查询优化器
8.10 缓冲和缓存
8.11 优化锁定操作
8.12 优化MySQL服务器
8.13 测量性能（基准测试）
8.14 查看服务器线程（进程）信息
8.14.1 访问进程列表1
8.14.2 线程命令值1
8.14.3 一般线程状态1
8.14.4 复制源线程状态1
8.14.5 复制 I/O（接收器）线程状态1
8.14.6 复制 SQL 线程状态1
8.14.7 复制连接线程状态1
8.14.8 NDB Cluster 线程状态1
8.14.9 事件调度器线程状态1
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
MySQL 8.0 参考手册  / 第8章优化  / 8.14 查看服务器线程（进程）信息  /
8.14.5 复制 I/O（接收器）线程状态
8.14.5 复制 I/O（接收器）线程状态
以下列表显示了您在
State副本服务器上的复制 I/O（接收方）线程的列中看到的最常见状态。该状态也出现在
Replica_IO_State显示的列中
SHOW
REPLICA STATUS（或在 MySQL 8.0.22 之前
SHOW
REPLICA STATUS），因此您可以通过使用该语句很好地了解正在发生的情况。
在 MySQL 8.0.26 中，对仪器名称进行了不兼容的更改，包括线程阶段的名称，其中包含术语“ master ”更改为
“ source ”，“ slave ”更改为
“ replica ”，以及“ mts ”（代表
“多线程从机”），改为
“ mta ”（代表“多线程应用程序”). 使用这些工具名称的监视工具可能会受到影响。如果不兼容的更改对您有影响，请将
terminology_use_previous系统变量设置为BEFORE_8_0_26以使 MySQL 服务器使用先前列表中指定的对象的旧版本名称。这使得依赖旧名称的监视工具能够继续工作，直到它们可以更新为使用新名称。
将
terminology_use_previous具有会话范围的系统变量设置为支持单个函数，或将全局范围设置为所有新会话的默认值。使用全局范围时，慢速查询日志包含名称的旧版本。
Checking master version
从 MySQL 8.0.26 开始：Checking source
version
在与源建立连接后出现的非常短暂的状态。
Connecting to master
从 MySQL 8.0.26 开始：Connecting to source
该线程正在尝试连接到源。
Queueing master event to the relay log
从 MySQL 8.0.26 开始：Queueing source event to the
relay log
线程已读取事件并将其复制到中继日志，以便 SQL 线程可以处理它。
Reconnecting after a failed binlog dump
request
该线程正在尝试重新连接到源。
Reconnecting after a failed master event
read
从 MySQL 8.0.26 开始：Reconnecting after a failed
source event read
该线程正在尝试重新连接到源。当再次建立连接时，状态变为
Waiting for master to send event。
Registering slave on master
从 MySQL 8.0.26 开始：Registering replica on
source
在与源建立连接后非常短暂地出现的状态。
Requesting binlog dump
在与源建立连接后出现的非常短暂的状态。线程向源发送对其二进制日志内容的请求，从请求的二进制日志文件名和位置开始。
Waiting for its turn to commit
replica_preserve_commit_order
如果启用或
启用
，当副本线程正在等待较旧的工作线程提交时发生的状态
slave_preserve_commit_order
。
Waiting for master to send event
从 MySQL 8.0.26 开始：Waiting for source to send
event
线程已连接到源并正在等待二进制日志事件到达。如果源空闲，这可能会持续很长时间。如果等待持续
replica_net_timeout或
slave_net_timeout秒，则会发生超时。此时，线程认为连接已断开并尝试重新连接。
Waiting for master update
从 MySQL 8.0.26 开始：Waiting for source
update
Connecting to
master或
之前的初始状态Connecting to source。
Waiting for slave mutex on exit
从 MySQL 8.0.26 开始：Waiting for replica mutex on
exit
线程停止时短暂出现的状态。
Waiting for the slave SQL thread to free enough
relay log space
从 MySQL 8.0.26 开始：Waiting for the replica SQL
thread to free enough relay log space
您正在使用一个非零
relay_log_space_limit
值，并且中继日志已经变得足够大以至于它们的组合大小超过了这个值。I/O（接收者）线程正在等待，直到 SQL（应用程序）线程通过处理中继日志内容释放足够的空间，以便它可以删除一些中继日志文件。
Waiting to reconnect after a failed binlog dump
request
如果二进制日志转储请求失败（由于断开连接），则线程在休眠时进入此状态，然后定期尝试重新连接。可以使用
CHANGE REPLICATION SOURCE TO
语句（MySQL 8.0.23 开始）或CHANGE
MASTER TO语句（MySQL 8.0.23 之前）指定重试间隔。
Waiting to reconnect after a failed master event
read
从 MySQL 8.0.26 开始：Waiting to reconnect after a
failed source event read
读取时发生错误（由于断开连接）。在尝试重新连接之前，
线程正在休眠
CHANGE REPLICATION SOURCE TO
语句（从 MySQL 8.0.23 开始）或语句（MySQL 8.0.23 之前）设置的秒数，默认为 60。CHANGE
MASTER TO
© Mysql 中文网
