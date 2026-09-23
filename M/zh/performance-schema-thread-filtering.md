# 27.4.6 按线程预过滤_MySQL 8.0 参考手册

27.4.6 按线程预过滤_MySQL 8.0 参考手册
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
27.4.1 性能模式事件时序1
27.4.2 性能模式事件过滤1
27.4.3 事件预过滤1
27.4.4 按仪器预过滤1
27.4.5 按对象预过滤1
27.4.6 按线程预过滤1
27.4.7 消费者预过滤1
27.4.8 消费者配置示例1
27.4.9 过滤操作的命名工具或消费者1
27.4.10 确定检测的是什么1
27.5 性能模式查询
27.6 性能模式工具命名约定
27.7 性能模式状态监控
27.8 性能模式原子和分子事件
27.9 当前和历史事件的性能模式表
27.10 性能模式语句摘要和采样
27.11 性能模式总表特征
27.12 性能模式表描述
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
MySQL 8.0 参考手册  / 第 27 章 MySQL 性能模式  / 27.4 性能模式运行时配置  /
27.4.6 按线程预过滤
27.4.6 按线程预过滤
该threads表包含每个服务器线程的一行。每行包含有关线程的信息，并指示是否为其启用监控。对于监视线程的性能模式，这些事情必须是真实的：
表中的thread_instrumentation消费者setup_consumers必须是YES。
该threads.INSTRUMENTED列必须是
YES.
仅对表中启用的工具生成的那些线程事件进行监视
setup_instruments。
该threads表还指示每个服务器线程是否执行历史事件记录。这包括等待、阶段、语句和事务事件，并影响到这些表的日志记录：
events_waits_history
events_waits_history_long
events_stages_history
events_stages_history_long
events_statements_history
events_statements_history_long
events_transactions_history
events_transactions_history_long
要进行历史事件记录，必须满足以下条件：
setup_consumers必须启用表
中适当的与历史相关的消费者
。events_waits_history比如and
events_waits_history_long
表
中的wait事件记录
需要对应的events_waits_historyand
events_waits_history_long消费者是
YES.
该threads.HISTORY列必须是
YES.
仅对表中启用的仪器产生的线程事件进行记录
setup_instruments。
对于前台线程（由客户端连接产生），表行中的INSTRUMENTED和
HISTORY列
的初始值threads取决于与线程关联的用户帐户是否与表中的任何行匹配setup_actors。这些值来自匹配
表行
的ENABLED和
列。HISTORYsetup_actors
对于后台线程，没有关联的用户。
INSTRUMENTED并且默认情况下
HISTORY
不被咨询。
YESsetup_actors
初始setup_actors内容如下所示：
mysql> SELECT * FROM performance_schema.setup_actors;
+------+------+------+---------+---------+
| HOST | USER | ROLE | ENABLED | HISTORY |
+------+------+------+---------+---------+
| %    | %    | %    | YES     | YES     |
+------+------+------+---------+---------+
和列应包含文字主机名或用户名，或
HOST匹配任何名称。
USER'%'
和
列指示是否为匹配的线程启用检测和历史事件日志记录，取决于前面描述的其他条件
ENABLED。HISTORY
当 Performance Schema 检查每个新前台线程的匹配项时setup_actors，它会尝试首先使用
USER和HOST列（ROLE未使用）找到更具体的匹配项：
行
与
。
USER='literal'HOST='literal'
行
与。
USER='literal'HOST='%'
行USER='%'与
。
HOST='literal'
行USER='%'与
HOST='%'。
匹配发生的顺序很重要，因为不同的匹配setup_actors行可以有不同USER的HOST
值。这使得检测和历史事件日志记录能够根据ENABLED和
HISTORY列值有选择地应用于每个主机、用户或帐户（用户和主机组合）：
当最匹配的行是 时
，线程
ENABLED=YES的
值变为。当最匹配的行是 时
，线程
的
值变为。
INSTRUMENTEDYESHISTORY=YESHISTORYYES
当最匹配的行是 时
，线程
ENABLED=NO的
值变为。当最匹配的行是 时
，线程
的
值变为。
INSTRUMENTEDNOHISTORY=NOHISTORYNO
当找不到匹配项时，线程的INSTRUMENTED
和HISTORY值变为
NO。
行中的ENABLED和HISTORY
列setup_actors可以相互设置YES或NO
相互独立。这意味着您可以独立于是否收集历史事件来启用检测。
默认情况下，会为所有新的前台线程启用监视和历史事件收集，因为该
setup_actors表最初包含一个包含'%'和
HOST的行USER。要执行更有限的匹配，例如仅对某些前台线程启用监视，您必须更改此行，因为它匹配任何连接，并为更具体的
HOST/USER组合添加行。
假设你修改
setup_actors如下：
UPDATE performance_schema.setup_actors
SET ENABLED = 'NO', HISTORY = 'NO'
WHERE HOST = '%' AND USER = '%';
INSERT INTO performance_schema.setup_actors
(HOST,USER,ROLE,ENABLED,HISTORY)
VALUES('localhost','joe','%','YES','YES');
INSERT INTO performance_schema.setup_actors
(HOST,USER,ROLE,ENABLED,HISTORY)
VALUES('hosta.example.com','joe','%','YES','NO');
INSERT INTO performance_schema.setup_actors
(HOST,USER,ROLE,ENABLED,HISTORY)
VALUES('%','sam','%','NO','YES');
该UPDATE语句更改默认匹配以禁用检测和历史事件收集。这些INSERT语句为更具体的匹配项添加行。
现在 Performance Schema 确定如何为新连接线程设置
INSTRUMENTED和HISTORY
值，如下所示：
如果joe从本地主机连接，连接匹配第一个插入的行。线程的
INSTRUMENTED和
HISTORY值变为
YES。
如果joe从 连接
hosta.example.com，则连接匹配第二个插入的行。INSTRUMENTED
线程的值变为值
变为
YES。
HISTORYNO
如果joe从任何其他主机连接，则没有匹配项。线程的INSTRUMENTED和
HISTORY值变为
NO。
如果sam从任何主机连接，连接匹配第三个插入的行。INSTRUMENTED线程
的
值变为值
变为NO。HISTORYYES
对于任何其他连接，具有
HOST和USER设置为
'%'匹配的行。该行现在已
设置为，因此线程的
和
ENABLED值变为
。
HISTORYNOINSTRUMENTEDHISTORYNO
对setup_actors
表的修改仅影响修改后创建的前台线程，而不影响现有线程。要影响现有线程，请修改表行的INSTRUMENTED和
HISTORY列
threads。
© Mysql 中文网
