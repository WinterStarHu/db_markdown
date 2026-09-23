# 27.12.8 性能模式连接表_MySQL 8.0 参考手册

27.12.8 性能模式连接表_MySQL 8.0 参考手册
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
第24章分区
第25章存储对象
第 26 章 INFORMATION_SCHEMA 表
第 27 章 MySQL 性能模式
27.1 性能模式快速入门
27.2 性能模式构建配置
27.3 性能模式启动配置
27.4 性能模式运行时配置
27.5 性能模式查询
27.6 性能模式工具命名约定
27.7 性能模式状态监控
27.8 性能模式原子和分子事件
27.9 当前和历史事件的性能模式表
27.10 性能模式语句摘要和采样
27.11 性能模式总表特征
27.12 性能模式表描述
27.12.1 性能模式表参考1
27.12.2 性能模式设置表1
27.12.3 性能模式实例表1
27.12.4 性能模式等待事件表1
27.12.5 性能模式阶段事件表1
27.12.6 性能模式语句事件表1
27.12.7 性能模式事务表1
27.12.8 性能模式连接表1
27.12.8.1 账户表
27.12.8.2 主机表
27.12.8.3 用户表
27.12.9 性能模式连接属性表1
27.12.10 性能模式用户定义的变量表1
27.12.11 性能模式复制表1
27.12.12 Performance Schema NDB 集群表1
27.12.13 性能模式锁表1
27.12.14 性能模式系统变量表1
27.12.15 性能模式状态变量表1
27.12.16 性能模式线程池表1
27.12.17 性能模式防火墙表1
27.12.18 性能模式密钥环表1
27.12.19 性能模式克隆表1
27.12.20 性能模式汇总表1
27.12.21 性能模式杂表1
27.13 性能模式选项和变量引用
27.14 性能模式命令选项
27.15 性能模式系统变量
27.16 性能模式状态变量
27.17性能模式内存分配模型
27.18 性能模式和插件
27.19 使用性能模式诊断问题
27.20 性能模式的限制
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 27 章 MySQL 性能模式  / 27.12 性能模式表描述  /
27.12.8 性能模式连接表
27.12.8 性能模式连接表
27.12.8.1 账户表27.12.8.2 主机表27.12.8.3 用户表
当客户端连接到 MySQL 服务器时，它会使用特定的用户名和特定的主机进行连接。Performance Schema 提供有关这些连接的统计信息，使用这些表按帐户（用户和主机组合）以及按用户名和主机名单独跟踪它们：
accounts：每个客户帐户的连接统计
hosts：每个客户端主机名的连接统计
users：每个客户端用户名的连接统计
连接表中“帐户”
的含义类似于
mysql系统数据库中 MySQL 授权表中的含义，在这个意义上，该术语指的是用户和主机值的组合。它们的不同之处在于，对于授权表，帐户的主机部分可以是模式，而对于性能模式表，主机值始终是特定的非模式主机名。
每个连接表都有CURRENT_CONNECTIONS
和列来跟踪每个“跟踪值”TOTAL_CONNECTIONS的当前连接数和总连接数，其统计信息基于此。这些表的不同之处在于它们用于跟踪值的内容。该
表有
和列来跟踪每个用户和主机组合的连接。和
表分别有一个
和
列，用于跟踪每个用户名和主机名的连接。
accountsUSERHOSTusershostsUSERHOST
Performance Schema 还计算内部线程和未通过身份验证的用户会话的线程，
USER使用HOST具有NULL.
假设名为user1和
的客户端分别从和user2连接一次
。性能模式跟踪连接如下：
hostahostb
该accounts表有四行，用于
user1/ hosta、
user1/ hostb、
user2/hosta和
user2/hostb帐户值，每行计算每个帐户一个连接。
该hosts表有两行，分别为hosta和hostb，每行为每个主机名计算两个连接。
该users表有两行，分别为user1和user2，每行为每个用户名计算两个连接。
当客户端连接时，性能模式使用适合每个表的跟踪值来确定每个连接表中的哪一行适用。如果没有这样的行，则添加一个。然后 Performance Schema 在该行中增加一个
CURRENT_CONNECTIONS和
TOTAL_CONNECTIONS列。
当客户端断开连接时，Performance SchemaCURRENT_CONNECTIONS将行中的列递减一个并保持该TOTAL_CONNECTIONS列不变。
TRUNCATE TABLE允许用于连接表。它具有以下效果：
对于没有当前连接的帐户、主机或用户（带有 的行CURRENT_CONNECTIONS
= 0），行已删除。
未删除的行被重置为仅计算当前连接：对于带有 的行CURRENT_CONNECTIONS > 0，
TOTAL_CONNECTIONS重置为
CURRENT_CONNECTIONS。
依赖于连接表的汇总表被隐式截断，如本节后面所述。
性能模式维护汇总表，按帐户、主机或用户聚合各种事件类型的连接统计信息。这些表的名称中包含
_summary_by_account、
_summary_by_host或
_summary_by_user。要识别它们，请使用此查询：
mysql> SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'performance_schema'
AND TABLE_NAME REGEXP '_summary_by_(account|host|user)'
ORDER BY TABLE_NAME;
+------------------------------------------------------+
| TABLE_NAME                                           |
+------------------------------------------------------+
| events_errors_summary_by_account_by_error            |
| events_errors_summary_by_host_by_error               |
| events_errors_summary_by_user_by_error               |
| events_stages_summary_by_account_by_event_name       |
| events_stages_summary_by_host_by_event_name          |
| events_stages_summary_by_user_by_event_name          |
| events_statements_summary_by_account_by_event_name   |
| events_statements_summary_by_host_by_event_name      |
| events_statements_summary_by_user_by_event_name      |
| events_transactions_summary_by_account_by_event_name |
| events_transactions_summary_by_host_by_event_name    |
| events_transactions_summary_by_user_by_event_name    |
| events_waits_summary_by_account_by_event_name        |
| events_waits_summary_by_host_by_event_name           |
| events_waits_summary_by_user_by_event_name           |
| memory_summary_by_account_by_event_name              |
| memory_summary_by_host_by_event_name                 |
| memory_summary_by_user_by_event_name                 |
+------------------------------------------------------+
有关各个连接摘要表的详细信息，请参阅描述摘要事件类型表的部分：
等待事件摘要：
第 27.12.20.1 节，“等待事件摘要表”
阶段事件摘要：
第 27.12.20.2 节，“阶段摘要表”
语句事件摘要：
第 27.12.20.3 节，“语句摘要表”
事务事件摘要：
第 27.12.20.5 节，“事务摘要表”
内存事件摘要：
第 27.12.20.10 节，“内存摘要表”
错误事件摘要：
第 27.12.20.11 节，“错误摘要表”
TRUNCATE TABLE允许用于连接汇总表。它删除没有连接的帐户、主机或用户的行，并将剩余行的摘要列重置为零。此外，每个按帐户、主机、用户或线程聚合的汇总表都会被它所依赖的连接表的截断隐式截断。下表描述了连接表截断和隐式截断表之间的关系。
表 27.2 连接表截断的隐式影响
截断连接表
隐式截断的汇总表
accounts
名称包含_summary_by_account,
_summary_by_thread
hosts
名称包含_summary_by_account,
_summary_by_host,
_summary_by_thread
users
名称包含_summary_by_account,
_summary_by_user,
_summary_by_thread
截断_summary_global汇总表也会隐式截断其对应的连接和线程汇总表。例如，截断
events_waits_summary_global_by_event_name
会隐式截断按帐户、主机、用户或线程聚合的等待事件摘要表。
© Mysql 中文网
