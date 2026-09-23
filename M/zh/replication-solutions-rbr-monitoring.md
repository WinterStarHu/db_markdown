# 17.4.3 监控基于行的复制_MySQL 8.0 参考手册

17.4.3 监控基于行的复制_MySQL 8.0 参考手册
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
17.4.3 监控基于行的复制
17.4.3 监控基于行的复制
使用基于行的复制时复制应用程序 (SQL) 线程的当前进度通过 Performance Schema 工具阶段进行监视，使您能够跟踪操作的处理并检查已完成的工作量和估计的工作量。当启用这些 Performance Schema 仪器阶段时，该events_stages_current
表显示应用程序线程的阶段及其进度。有关背景信息，请参阅
第 27.12.5 节，“性能模式阶段事件表”。
要跟踪所有三种基于行的复制事件类型（写入、更新、删除）的进度：
通过发出以下命令启用三个 Performance Schema 阶段：
mysql> UPDATE performance_schema.setup_instruments SET ENABLED = 'YES'
-> WHERE NAME LIKE 'stage/sql/Applying batch of row changes%';
等待复制应用程序线程处理一些事件，然后通过查看
events_stages_current表来检查进度。例如，获取update事件问题的进展：
mysql> SELECT WORK_COMPLETED, WORK_ESTIMATED FROM performance_schema.events_stages_current
-> WHERE EVENT_NAME LIKE 'stage/sql/Applying batch of row changes (update)'
如果
binlog_rows_query_log_events
启用，有关查询的信息将存储在二进制日志中，并在processlist_info
字段中公开。要查看触发此事件的原始查询：
mysql> SELECT db, processlist_state, processlist_info FROM performance_schema.threads
-> WHERE processlist_state LIKE 'stage/sql/Applying batch of row changes%' AND thread_id = N;
© Mysql 中文网
