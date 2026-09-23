# 23.7.8 使用 NDB Cluster 复制实现故障转移_MySQL 8.0 参考手册

23.7.8 使用 NDB Cluster 复制实现故障转移_MySQL 8.0 参考手册
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
23.1 一般信息
23.2 NDB Cluster 概述
23.3 NDB Cluster 安装
23.4 NDB Cluster的配置
23.5 NDB 集群程序
23.6 NDB Cluster的管理
23.7 NDB 集群复制
23.7.1 NDB Cluster 复制：缩写和符号1
23.7.2 NDB Cluster 复制的一般要求1
23.7.3 NDB Cluster 复制中的已知问题1
23.7.4 NDB Cluster 复制模式和表1
23.7.5 准备 NDB Cluster 进行复制1
23.7.6 启动 NDB Cluster 复制（单复制通道）1
23.7.7 使用两个复制通道进行 NDB Cluster 复制1
23.7.8 使用 NDB Cluster 复制实现故障转移1
23.7.9 使用 NDB Cluster 复制的 NDB Cluster 备份1
23.7.10 NDB Cluster 复制：双向和循环复制1
23.7.11 NDB Cluster 复制冲突解决1
23.8 NDB Cluster 发行说明
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.7 NDB 集群复制  /
23.7.8 使用 NDB Cluster 复制实现故障转移
23.7.8 使用 NDB Cluster 复制实现故障转移
如果主集群复制过程失败，可以切换到辅助复制通道。以下过程描述了完成此操作所需的步骤。
获取最近的全局检查点 (GCP) 的时间。也就是说，您需要从副本集群上的表中确定最近的纪元
ndb_apply_status，可以使用以下查询找到它：
mysqlR'> SELECT @latest:=MAX(epoch)
->        FROM mysql.ndb_apply_status;
在循环复制拓扑中，在每个主机上运行一个源和一个副本，当您使用时
ndb_log_apply_status=1，NDB Cluster 纪元被写入副本的二进制日志中。这意味着该ndb_apply_status表包含此主机上的副本以及充当此主机上运行的复制源服务器副本的任何其他主机的信息。
在这种情况下，您需要确定此副本上的最新纪元，以排除此副本的二进制日志中未在
|
的IGNORE_SERVER_IDS选项中
列出的任何其他副本的任何纪元。用于设置此副本的语句。排除此类纪元的原因是表中的行的服务器 ID 在|
的列表中
匹配。
用于准备此副本源的语句也被认为来自本地服务器，除了那些具有副本自己的服务器 ID 的服务器。您可以
从输出中检索此列表CHANGE REPLICATION SOURCE TOCHANGE MASTER TOmysql.ndb_apply_statusIGNORE_SERVER_IDSCHANGE REPLICATION SOURCE TOCHANGE MASTER TOReplicate_Ignore_Server_IdsSHOW REPLICA STATUS. 我们假设您已获得此列表并将其替换为ignore_server_ids此处显示的查询，与之前版本的查询一样，将最大纪元选择到名为 的变量中
@latest：
mysqlR'> SELECT @latest:=MAX(epoch)
->        FROM mysql.ndb_apply_status
->        WHERE server_id NOT IN (ignore_server_ids);在某些情况下，在
前面的查询条件中
使用要包含的服务器 ID 列表可能更简单或更有效（或两者兼而有之）
。server_id IN
server_id_listWHERE
使用从步骤 1 中显示的查询中获得的信息，从
ndb_binlog_index源集群上的表中获取相应的记录。
您可以使用以下查询从源上的表中获取所需的记录ndb_binlog_index：
mysqlS'> SELECT
->     @file:=SUBSTRING_INDEX(next_file, '/', -1),
->     @pos:=next_position
-> FROM mysql.ndb_binlog_index
-> WHERE epoch = @latest;
这些是自主复制通道发生故障后保存在源上的记录。我们在这里使用了一个用户变量来表示在步骤1中获得的值。当然，一个mysqld实例@latest不可能直接访问在另一个服务器实例上设置的用户变量。这些值必须手动或通过应用程序
“插入”到第二个查询。
重要的
您必须确保副本mysqld--slave-skip-errors=ddl_exist_errors
在执行之前
已启动
START
REPLICA。否则，复制可能会因重复的 DDL 错误而停止。
现在可以通过在辅助副本服务器上运行以下查询来同步辅助通道：
mysqlR'> CHANGE MASTER TO
->     MASTER_LOG_FILE='@file',
->     MASTER_LOG_POS=@pos;
在 NDB 8.0.23 及更高版本中，您还可以使用此处显示的语句：
mysqlR'> CHANGE REPLICATION SOURCE TO
->     SOURCE_LOG_FILE='@file',
->     SOURCE_LOG_POS=@pos;
我们再次使用用户变量（在本例中
为@file和@pos）来表示在步骤 2 中获得并在步骤 3 中应用的值；实际上，这些值必须手动插入或使用可以访问所涉及的两个服务器的应用程序插入。
笔记
@file是一个字符串值，例如
'/var/log/mysql/replication-source-bin.00001', 因此在 SQL 或应用程序代码中使用时必须用引号引起来。但是，不得引用所代表@pos
的值。尽管 MySQL 通常会尝试将字符串转换为数字，但这种情况是一个例外。
您现在可以通过在辅助副本
mysqld上发出适当的命令来启动辅助通道上的复制：
mysqlR'> START SLAVE;
在 NDB 8.0.22 或更高版本中，您还可以使用以下语句：
mysqlR'> START REPLICA;
一旦辅助复制通道处于活动状态，您就可以调查主要故障和影响修复。执行此操作所需的精确操作取决于主通道失败的原因。
警告
仅当主复制通道发生故障时才启动辅助复制通道。同时运行多个复制通道可能会导致在副本上创建不需要的重复记录。
如果故障仅限于单个服务器，理论上应该可以从复制S到
R'，或从
复制S'到R。
© Mysql 中文网
