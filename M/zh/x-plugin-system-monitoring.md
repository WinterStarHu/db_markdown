# 20.5.7 监控 X 插件_MySQL 8.0 参考手册

20.5.7 监控 X 插件_MySQL 8.0 参考手册
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
20.1 MySQL文档存储的接口
20.2 文档存储概念
20.3 JavaScript 快速入门指南：用于文档存储的 MySQL Shell
20.4 Python 快速入门指南：用于文档存储的 MySQL Shell
20.5 X 插件
20.5.1 检查 X 插件安装1
20.5.2 禁用 X 插件1
20.5.3 使用 X 插件的加密连接1
20.5.4 将 X 插件与缓存 SHA-2 身份验证插件一起使用1
20.5.5 使用 X 插件进行连接压缩1
20.5.6 X 插件选项和变量1
20.5.7 监控 X 插件1
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
MySQL 8.0 参考手册  / 第 20 章使用 MySQL 作为文档存储  / 20.5 X 插件  /
20.5.7 监控 X 插件
20.5.7 监控 X 插件
对于一般的 X 插件监控，使用它公开的状态变量。请参阅第 20.5.6.3 节，“X 插件状态变量”。有关监视消息压缩效果的具体信息，请参阅
监视 X 插件的连接压缩。
监控 X 插件生成的 SQL
本节介绍如何监控 X Plugin 在运行 X DevAPI 操作时生成的 SQL 语句。当您执行 CRUD 语句时，它会被翻译成 SQL 并针对服务器执行。为了能够监控生成的 SQL，必须启用 Performance Schema 表。SQL 注册在
performance_schema.events_statements_current、
performance_schema.events_statements_history和
performance_schema.events_statements_history_long
表下。以下示例使用
world_x作为本部分快速入门教程的一部分导入的架构。我们在Python模式下使用MySQL Shell，而\sql命令，使您能够在不更改为 SQL 模式的情况下发出 SQL 语句。这很重要，因为如果您改为尝试切换到 SQL 模式，该过程将显示此操作的结果而不是 X DevAPI 操作的结果。\sql
如果您在 JavaScript 模式下使用 MySQL Shell，则以相同的方式使用
该命令。
检查events_statements_history
消费者是否已启用。问题：
mysql-py> \sql SELECT enabled FROM performance_schema.setup_consumers WHERE NAME = 'events_statements_history'
+---------+
| enabled |
+---------+
| YES     |
+---------+
检查所有仪器是否向消费者报告数据。问题：
mysql-py> \sql SELECT NAME, ENABLED, TIMED FROM performance_schema.setup_instruments WHERE NAME LIKE 'statement/%' AND NOT (ENABLED and TIMED)
如果此语句至少报告一行，则需要启用仪器。请参阅
第 27.4 节，“性能模式运行时配置”。
获取当前连接的线程 ID。问题：
mysql-py> \sql SELECT thread_id INTO @id FROM performance_schema.threads WHERE processlist_id=connection_id()
执行要查看生成的 SQL 的 X DevAPI CRUD 操作。例如，问题：
mysql-py> db.CountryInfo.find("Name = :country").bind("country", "Italy")
您不得为下一步发出任何进一步的操作以显示正确的结果。
显示此线程 ID 进行的最后一个 SQL 查询。问题：
mysql-py> \sql SELECT THREAD_ID, MYSQL_ERRNO,SQL_TEXT FROM performance_schema.events_statements_history WHERE THREAD_ID=@id ORDER BY TIMER_START DESC LIMIT 1;
+-----------+-------------+--------------------------------------------------------------------------------------+
| THREAD_ID | MYSQL_ERRNO | SQL_TEXT                                                                             |
+-----------+-------------+--------------------------------------------------------------------------------------+
|        29 |           0 | SELECT doc FROM `world_x`.`CountryInfo` WHERE (JSON_EXTRACT(doc,'$.Name') = 'Italy') |
+-----------+-------------+--------------------------------------------------------------------------------------+
结果显示 X Plugin 根据最近的语句生成的 SQL，在本例中是上一步的 X DevAPI CRUD 操作。
© Mysql 中文网
