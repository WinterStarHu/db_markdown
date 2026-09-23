# 18.7.9 使用性能模式内存检测监控组复制内存使用情况_MySQL 8.0 参考手册

18.7.9 使用性能模式内存检测监控组复制内存使用情况_MySQL 8.0 参考手册
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
18.6 组复制安全
18.7 组复制性能和故障排除
18.7.1 微调群组通信线程1
18.7.2 流量控制1
18.7.3 单一共识领导者1
18.7.4 消息压缩1
18.7.5 消息分片1
18.7.6 XCom缓存管理1
18.7.7 对故障检测和网络分区的响应1
18.7.8 处理网络分区和仲裁丢失1
18.7.9 使用性能模式内存检测监控组复制内存使用情况1
18.7.9.1 启用或禁用组复制检测
18.7.9.2 示例查询
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
MySQL 8.0 参考手册  / 第十八章 组复制  / 18.7 组复制性能和故障排除  /
18.7.9 使用性能模式内存检测监控组复制内存使用情况
18.7.9 使用性能模式内存检测监控组复制内存使用情况
18.7.9.1 启用或禁用组复制检测18.7.9.2 示例查询
从 MySQL 8.0.30 开始，Performance Schema提供了用于对 Group Replication 内存使用情况进行性能监控的工具。要查看可用的组复制工具，请发出以下查询：
mysql> SELECT NAME,ENABLED FROM performance_schema.setup_instruments
WHERE NAME LIKE 'memory/group_rpl/%';
+-------------------------------------------------------------------+---------+
| NAME                                                              | ENABLED |
+-------------------------------------------------------------------+---------+
| memory/group_rpl/write_set_encoded                                | YES     |
| memory/group_rpl/certification_data                               | YES     |
| memory/group_rpl/certification_data_gc                            | YES     |
| memory/group_rpl/certification_info                               | YES     |
| memory/group_rpl/transaction_data                                 | YES     |
| memory/group_rpl/sql_service_command_data                         | YES     |
| memory/group_rpl/mysql_thread_queued_task                         | YES     |
| memory/group_rpl/message_service_queue                            | YES     |
| memory/group_rpl/message_service_received_message                 | YES     |
| memory/group_rpl/group_member_info                                | YES     |
| memory/group_rpl/consistent_members_that_must_prepare_transaction | YES     |
| memory/group_rpl/consistent_transactions                          | YES     |
| memory/group_rpl/consistent_transactions_prepared                 | YES     |
| memory/group_rpl/consistent_transactions_waiting                  | YES     |
| memory/group_rpl/consistent_transactions_delayed_view_change      | YES     |
| memory/group_rpl/GCS_XCom::xcom_cache                             | YES     |
| memory/group_rpl/Gcs_message_data::m_buffer                       | YES     |
+-------------------------------------------------------------------+---------+
有关 Performance Schema 的内存检测和事件的更多信息，请参阅
第 27.12.20.10 节，“内存摘要表”。
Performance Schema Group Replication 为 Group Replication 分配内存。
memory/group_rpl/性能模式检测在 8.0.30 中进行了更新，以扩展对组复制内存使用情况的监视
。memory/group_rpl/包含以下仪器：
write_set_encoded：分配给写入集的内存在广播给组成员之前对其进行编码。
Gcs_message_data::m_buffer：为发送到网络的交易数据有效载荷分配的内存。
certification_data：分配用于验证传入交易的内存。
certification_data_gc: 为每个成员发送的用于垃圾收集的 GTID_EXECUTED 分配的内存。
certification_info：分配用于存储认证信息的内存分配用于解决并发事务之间的冲突。
transaction_data：为排队等待插件管道的传入事务分配的内存。
message_service_received_message: 分配给从组复制传递消息服务接收消息的内存。
sql_service_command_data: 为处理内部 SQL 服务命令队列分配的内存。
mysql_thread_queued_task: 当一个 MySQL 线程相关的任务被添加到处理队列时分配的内存。
message_service_queue: 为组复制传递消息服务的排队消息分配的内存。
GCS_XCom::xcom_cache：分配给 XCOM 缓存的内存，用于作为共识协议的一部分在组成员之间交换消息和元数据。
consistent_members_that_must_prepare_transaction：分配的内存用于保存为组复制事务一致性保证准备事务的成员列表。
consistent_transactions：分配的内存用于保存事务和必须为组复制事务一致性保证准备该事务的成员列表。
consistent_transactions_prepared：分配的内存用于保存为组复制事务一致性保证准备的事务信息列表。
consistent_transactions_waiting: 分配内存以保存事务列表的信息，同时处理之前准备好的事务的一致性
AFTER和
BEFORE_AND_AFTER被处理。
consistent_transactions_delayed_view_change: 分配的内存用于保存视图更改事件列表 ( view_change_log_event)，这些事件因等待准备确认的准备一致事务而延迟。
group_member_info：分配的内存用于保存组成员属性。主机名、端口、成员权重和角色等属性。
分组中的以下工具memory/sql/
也用于监视 Group Replication 内存：
Log_event：分配给写集生成过程的内存。
write_set_extraction：在提交之前分配给事务生成的写集的内存。
Gtid_set::to_string: 分配给存储 GTID 集的字符串表示的内存。
Gtid_set::Interval_chunk: 分配给存储 GTID 对象的内存。
© Mysql 中文网
