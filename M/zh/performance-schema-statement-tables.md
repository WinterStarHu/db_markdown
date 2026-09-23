# 27.12.6 性能模式语句事件表_MySQL 8.0 参考手册

27.12.6 性能模式语句事件表_MySQL 8.0 参考手册
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
27.12.6.1 events_statements_current 表
27.12.6.2 events_statements_history 表
27.12.6.3 events_statements_history_long 表
27.12.6.4 prepared_statements_instances 表
27.12.7 性能模式事务表1
27.12.8 性能模式连接表1
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
27.12.6 性能模式语句事件表
27.12.6 性能模式语句事件表
27.12.6.1 events_statements_current 表27.12.6.2 events_statements_history 表27.12.6.3 events_statements_history_long 表27.12.6.4 prepared_statements_instances 表
Performance Schema 工具语句执行。语句事件发生在事件层次结构的高层。在事件层次结构中，等待事件嵌套在阶段事件中，阶段事件嵌套在语句事件中，语句事件嵌套在事务事件中。
这些表存储语句事件：
events_statements_current：每个线程的当前语句事件。
events_statements_history：每个线程结束的最近语句事件。
events_statements_history_long：最近全局结束的语句事件（跨所有线程）。
prepared_statements_instances: 准备语句实例和统计
以下部分描述语句事件表。还有汇总表，汇总了语句事件的信息；参见
第 27.12.20.3 节，“语句汇总表”。
有关三个事件表
之间关系的更多信息
，请参阅第 27.9 节，“当前和历史事件的性能模式表”。
events_statements_xxx
配置语句事件收集报表监控
配置语句事件收集
控制是否收集statement事件，设置相关instruments和consumers的状态：
该setup_instruments表包含名称以 开头的工具
statement。使用这些工具来启用或禁用单个语句事件类的收集。
该setup_consumers表包含名称与当前和历史语句事件表名称对应的消费者值，以及语句摘要消费者。使用这些消费者来过滤语句事件和语句摘要的集合。
默认情况下启用语句工具，并且默认启用
events_statements_current、
events_statements_history和
statements_digest语句消费者：
mysql> SELECT NAME, ENABLED, TIMED
FROM performance_schema.setup_instruments
WHERE NAME LIKE 'statement/%';
+---------------------------------------------+---------+-------+
| NAME                                        | ENABLED | TIMED |
+---------------------------------------------+---------+-------+
| statement/sql/select                        | YES     | YES   |
| statement/sql/create_table                  | YES     | YES   |
| statement/sql/create_index                  | YES     | YES   |
...
| statement/sp/stmt                           | YES     | YES   |
| statement/sp/set                            | YES     | YES   |
| statement/sp/set_trigger_field              | YES     | YES   |
| statement/scheduler/event                   | YES     | YES   |
| statement/com/Sleep                         | YES     | YES   |
| statement/com/Quit                          | YES     | YES   |
| statement/com/Init DB                       | YES     | YES   |
...
| statement/abstract/Query                    | YES     | YES   |
| statement/abstract/new_packet               | YES     | YES   |
| statement/abstract/relay_log                | YES     | YES   |
+---------------------------------------------+---------+-------+mysql> SELECT *
FROM performance_schema.setup_consumers
WHERE NAME LIKE '%statements%';
+--------------------------------+---------+
| NAME                           | ENABLED |
+--------------------------------+---------+
| events_statements_current      | YES     |
| events_statements_history      | YES     |
| events_statements_history_long | NO      |
| statements_digest              | YES     |
+--------------------------------+---------+
要在服务器启动时控制语句事件收集，请在my.cnf文件中使用如下行：
使能够：
[mysqld]
performance-schema-instrument='statement/%=ON'
performance-schema-consumer-events-statements-current=ON
performance-schema-consumer-events-statements-history=ON
performance-schema-consumer-events-statements-history-long=ON
performance-schema-consumer-statements-digest=ON
禁用：
[mysqld]
performance-schema-instrument='statement/%=OFF'
performance-schema-consumer-events-statements-current=OFF
performance-schema-consumer-events-statements-history=OFF
performance-schema-consumer-events-statements-history-long=OFF
performance-schema-consumer-statements-digest=OFF
要在运行时控制语句事件收集，请更新
setup_instruments和
setup_consumers表：
使能够：
UPDATE performance_schema.setup_instruments
SET ENABLED = 'YES', TIMED = 'YES'
WHERE NAME LIKE 'statement/%';
UPDATE performance_schema.setup_consumers
SET ENABLED = 'YES'
WHERE NAME LIKE '%statements%';
禁用：
UPDATE performance_schema.setup_instruments
SET ENABLED = 'NO', TIMED = 'NO'
WHERE NAME LIKE 'statement/%';
UPDATE performance_schema.setup_consumers
SET ENABLED = 'NO'
WHERE NAME LIKE '%statements%';
要仅收集特定的语句事件，请仅启用相应的语句工具。要仅为特定语句事件表收集语句事件，请启用语句工具，但仅启用与所需表对应的语句消费者。
有关配置事件收集的其他信息，请参阅第 27.3 节，“性能模式启动配置”和第 27.4 节，“性能模式运行时配置”。
报表监控
语句监视从服务器看到线程上请求活动的那一刻开始，到所有活动停止的那一刻。通常，这意味着从服务器从客户端收到第一个数据包到服务器完成发送响应的时间。存储程序中的语句像其他语句一样受到监视。
当性能模式检测请求（服务器命令或 SQL 语句）时，它使用从更一般（或“抽象”）到更具体的阶段进行的仪器名称，直到到达最终仪器名称。
最终仪器名称对应服务器命令和SQL语句：
服务器命令对应
于头文件中
定义并在. 例子是和
。命令工具的名称以 开头，例如和
。
COM_xxx codesmysql_com.hsql/sql_parse.ccCOM_PINGCOM_QUITstatement/comstatement/com/Pingstatement/com/Quit
SQL 语句以文本形式表示，例如
DELETE FROM t1or SELECT * FROM
t2。SQL 语句的工具名称以 开头statement/sql，例如
statement/sql/deleteand
statement/sql/select。
一些最终的仪器名称特定于错误处理：
statement/com/Error说明服务器收到的带外消息。它可用于检测服务器不理解的客户端发送的命令。这可能有助于识别配置错误的客户端或使用比服务器版本更新的 MySQL 版本或试图攻击服务器的客户端。
statement/sql/error无法解析的 SQL 语句的帐户。它可用于检测客户端发送的格式错误的查询。解析失败的查询不同于解析但由于执行过程中的错误而失败的查询。例如，SELECT *
FROM格式不正确，并且
statement/sql/error使用了仪器。相比之下，SELECT *解析但失败并出现No tables used错误。在这种情况下，statement/sql/select使用了并且语句 event 包含指示错误性质的信息。
可以从以下任何来源获得请求：
作为来自客户端的命令或语句请求，客户端将请求作为数据包发送
作为从副本上的中继日志读取的语句字符串
作为 Event Scheduler 中的事件
请求的详细信息最初是未知的，并且 Performance Schema 按照取决于请求源的顺序从抽象到特定的工具名称进行处理。
对于从客户端收到的请求：
当服务器在套接字级别检测到新数据包时，将以抽象工具名称开始一个新语句
statement/abstract/new_packet。
当服务器读取数据包编号时，它会更多地了解收到的请求类型，并且 Performance Schema 会细化仪器名称。例如，如果请求是一个COM_PING数据包，则仪器名称变为statement/com/Ping最终名称。如果请求是一个
COM_QUERY数据包，则已知它对应于一条 SQL 语句而不是特定类型的语句。在这种情况下，仪器从一个抽象名称更改为一个更具体但仍然抽象的名称
statement/abstract/Query，并且该请求需要进一步分类。
如果请求是语句，则读取语句文本并将其提供给解析器。解析后，确切的语句类型是已知的。例如，如果请求是一条
INSERT语句，则 Performance Schema 会将工具名称从
最终名称
细化statement/abstract/Query为
。statement/sql/insert
对于从副本上的中继日志中读取为语句的请求：
中继日志中的语句以文本形式存储并按原样读取。没有网络协议，所以
statement/abstract/new_packet没有使用仪器。相反，初始工具是
statement/abstract/relay_log.
当语句被解析时，确切的语句类型是已知的。例如，如果请求是一条
INSERT语句，则 Performance Schema 会将工具名称从
最终名称
细化statement/abstract/Query为
。statement/sql/insert
前面的描述仅适用于基于语句的复制。对于基于行的复制，可以检测在副本处理行更改时在副本上完成的表 I/O，但中继日志中的行事件不会显示为离散语句。
对于从 Event Scheduler 收到的请求：
事件执行使用名称进行检测
statement/scheduler/event。这是最后的名字。
在事件主体内执行的语句使用
statement/sql/*名称进行检测，而不使用任何前面的抽象工具。事件是存储的程序，存储的程序在执行前在内存中预编译。因此，在运行时没有解析，并且每个语句的类型在它执行时就知道了。
在事件主体中执行的语句是子语句。例如，如果一个事件执行一条
INSERT语句，则事件本身的执行是父级，使用 进行检测
statement/scheduler/event，而 the
INSERT是子级，使用 进行检测statement/sql/insert。父/子关系在单独的检测操作之间存在。这不同于在单个检测操作中发生的细化顺序，从抽象到最终仪器名称。
statement/sql/*对于要为报表收集的统计信息，仅启用用于单个报表类型
的最终工具是不够的
。statement/abstract/*还必须启用抽象
工具。这通常不是问题，因为默认情况下会启用所有语句工具。但是，有选择地启用或禁用报表工具的应用程序必须考虑到禁用抽象工具也会禁用单个报表工具的统计信息收集。例如，要收集INSERT语句的统计信息，
statement/sql/insert必须启用，但也statement/abstract/new_packet和
statement/abstract/Query. 同样，对于要检测的复制语句，
statement/abstract/relay_log必须启用。
没有为抽象工具汇总统计数据，例如
statement/abstract/Query因为没有任何语句被分类为抽象工具作为最终语句名称。
© Mysql 中文网
