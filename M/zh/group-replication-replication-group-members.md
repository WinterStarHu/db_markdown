# 18.4.3 replication_group_members 表_MySQL 8.0 参考手册

18.4.3 replication_group_members 表_MySQL 8.0 参考手册
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
18.4.3 replication_group_members 表
18.4.3 replication_group_members 表
该
performance_schema.replication_group_members
表用于监视作为组成员的不同服务器实例的状态。只要有视图更改，表中的信息就会更新，例如当新成员加入时组的配置动态更改时。届时，服务器会交换一些元数据以同步自身并继续协同合作。该信息在作为复制组成员的所有服务器实例之间共享，因此可以从任何成员查询有关所有组成员的信息。此表可用于获取复制组状态的高级视图，例如通过发出：
SELECT * FROM performance_schema.replication_group_members;
+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+----------------------------+
| CHANNEL_NAME              | MEMBER_ID                            | MEMBER_HOST | MEMBER_PORT | MEMBER_STATE | MEMBER_ROLE | MEMBER_VERSION | MEMBER_COMMUNICATION_STACK |
+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+----------------------------+
| group_replication_applier | d391e9ee-2691-11ec-bf61-00059a3c7a00 | example1    |        4410 | ONLINE       | PRIMARY     | 8.0.27         | XCom                       |
| group_replication_applier | e059ce5c-2691-11ec-8632-00059a3c7a00 | example2    |        4420 | ONLINE       | SECONDARY   | 8.0.27         | XCom                       |
| group_replication_applier | ecd9ad06-2691-11ec-91c7-00059a3c7a00 | example3    |        4430 | ONLINE       | SECONDARY   | 8.0.27         | XCom                       |
+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+----------------------------+
3 rows in set (0.0007 sec)
基于此结果，我们可以看到该组由三名成员组成。表中显示的是每个成员的
server_uuid，以及成员的主机名和端口号，客户端使用这些来连接到它。该MEMBER_STATE列显示
第 18.4.2 节“组复制服务器状态”之一，在这种情况下，它显示该组中的所有三个成员都是
ONLINE，并且该MEMBER_ROLE
列显示有两个辅助节点和一个主节点。因此，该组必须以单主模式运行。当您升级组并组合运行不同 MySQL 版本的成员时，该
MEMBER_VERSION列可能很有用。这MEMBER_COMMUNICATION_STACK
列显示用于该组的通信堆栈。
有关该MEMBER_HOST
值及其对分布式恢复过程的影响的更多信息，请参阅
第 18.2.1.3 节，“分布式恢复的用户凭证”。
© Mysql 中文网
