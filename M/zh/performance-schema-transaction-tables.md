# 27.12.7 性能模式事务表_MySQL 8.0 参考手册

27.12.7 性能模式事务表_MySQL 8.0 参考手册
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
27.12.7.1 events_transactions_current 表
27.12.7.2 events_transactions_history 表
27.12.7.3 events_transactions_history_long 表
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
27.12.7 性能模式事务表
27.12.7 性能模式事务表
27.12.7.1 events_transactions_current 表27.12.7.2 events_transactions_history 表27.12.7.3 events_transactions_history_long 表
性能模式工具交易。在事件层次结构中，等待事件嵌套在阶段事件中，阶段事件嵌套在语句事件中，语句事件嵌套在事务事件中。
这些表存储事务事件：
events_transactions_current：每个线程的当前事务事件。
events_transactions_history：每个线程结束的最近事务事件。
events_transactions_history_long：最近全局结束的事务事件（跨所有线程）。
以下部分描述事务事件表。还有汇总有关交易事件信息的汇总表；请参阅
第 27.12.20.5 节，“事务摘要表”。
有关三个事务事件表之间关系的更多信息，请参阅
第 27.9 节，“当前和历史事件的性能模式表”。
配置交易事件收集交易边界交易工具事务和嵌套事件事务和存储程序事务和保存点事务和错误
配置交易事件收集
控制是否采集交易事件，设置相关工具和消费者的状态：
该setup_instruments表包含一个名为transaction. 使用此工具启用或禁用单个事务事件类的收集。
该setup_consumers表包含名称与当前和历史交易事件表名称相对应的消费者值。使用这些消费者来过滤交易事件的集合。
默认情况下启用transaction仪器和
events_transactions_current交易
events_transactions_history消费者：
mysql> SELECT NAME, ENABLED, TIMED
FROM performance_schema.setup_instruments
WHERE NAME = 'transaction';
+-------------+---------+-------+
| NAME        | ENABLED | TIMED |
+-------------+---------+-------+
| transaction | YES     | YES   |
+-------------+---------+-------+
mysql> SELECT *
FROM performance_schema.setup_consumers
WHERE NAME LIKE 'events_transactions%';
+----------------------------------+---------+
| NAME                             | ENABLED |
+----------------------------------+---------+
| events_transactions_current      | YES     |
| events_transactions_history      | YES     |
| events_transactions_history_long | NO      |
+----------------------------------+---------+
要在服务器启动时控制事务事件收集，请在您的my.cnf文件中使用如下行：
使能够：
[mysqld]
performance-schema-instrument='transaction=ON'
performance-schema-consumer-events-transactions-current=ON
performance-schema-consumer-events-transactions-history=ON
performance-schema-consumer-events-transactions-history-long=ON
禁用：
[mysqld]
performance-schema-instrument='transaction=OFF'
performance-schema-consumer-events-transactions-current=OFF
performance-schema-consumer-events-transactions-history=OFF
performance-schema-consumer-events-transactions-history-long=OFF
要在运行时控制事务事件收集，请更新
setup_instruments和
setup_consumers表：
使能够：
UPDATE performance_schema.setup_instruments
SET ENABLED = 'YES', TIMED = 'YES'
WHERE NAME = 'transaction';
UPDATE performance_schema.setup_consumers
SET ENABLED = 'YES'
WHERE NAME LIKE 'events_transactions%';
禁用：
UPDATE performance_schema.setup_instruments
SET ENABLED = 'NO', TIMED = 'NO'
WHERE NAME = 'transaction';
UPDATE performance_schema.setup_consumers
SET ENABLED = 'NO'
WHERE NAME LIKE 'events_transactions%';
要仅为特定事务事件表收集事务事件，请启用transaction
工具，但仅启用与所需表对应的事务消费者。
有关配置事件收集的其他信息，请参阅第 27.3 节，“性能模式启动配置”和第 27.4 节，“性能模式运行时配置”。
交易边界
在 MySQL 服务器中，事务以这些语句显式开始：
START TRANSACTION | BEGIN | XA START | XA BEGIN
交易也隐含地开始。例如，
autocommit启用系统变量时，每条语句的开始都会启动一个新的事务。
禁用时autocommit，已提交事务后的第一条语句标记新事务的开始。后续语句是事务的一部分，直到它被提交。
事务以这些语句明确结束：
COMMIT | ROLLBACK | XA COMMIT | XA ROLLBACK
事务也通过执行 DDL 语句、锁定语句和服务器管理语句隐式结束。
在以下讨论中，对 的引用
START
TRANSACTION也适用于
BEGIN、
XA
START和
XA
BEGIN。同样，对 和 的引用
COMMIT分别
ROLLBACK适用于XA
COMMIT和
XA
ROLLBACK。
Performance Schema 定义事务边界类似于服务器边界。事务事件的开始和结束与服务器中相应的状态转换紧密匹配：
对于显式启动的事务，事务事件在
START
TRANSACTION语句处理期间启动。
对于隐式启动的事务，事务事件从前一个事务结束后使用事务引擎的第一条语句开始。
COMMIT对于任何事务，无论是显式还是隐式结束，当服务器在处理或
期间转换出活动事务状态时，事务事件结束
ROLLBACK。
这种方法有一些微妙的含义：
Performance Schema 中的事务事件不完全包括与相应的START
TRANSACTION,
COMMIT, 或
ROLLBACK
statements 关联的 statement events。事务事件和这些语句之间存在少量时间重叠。
使用非事务引擎的语句对连接的事务状态没有影响。对于隐式事务，事务事件从使用事务引擎的第一条语句开始。这意味着仅在非事务表上运行的语句将被忽略，即使是在
START
TRANSACTION.
为了说明，请考虑以下场景：
1. SET autocommit = OFF;
2. CREATE TABLE t1 (a INT) ENGINE = InnoDB;
3. START TRANSACTION;                       -- Transaction 1 START
4. INSERT INTO t1 VALUES (1), (2), (3);
5. CREATE TABLE t2 (a INT) ENGINE = MyISAM; -- Transaction 1 COMMIT
-- (implicit; DDL forces commit)
6. INSERT INTO t2 VALUES (1), (2), (3);     -- Update nontransactional table
7. UPDATE t2 SET a = a + 1;                 -- ... and again
8. INSERT INTO t1 VALUES (4), (5), (6);     -- Write to transactional table
-- Transaction 2 START (implicit)
9. COMMIT;                                  -- Transaction 2 COMMIT
从服务器的角度来看，Transaction 1 在t2创建表时结束。事务 2 在访问事务表之前不会启动，尽管中间有对非事务表的更新。
从性能模式的角度来看，事务 2 在服务器转换为活动事务状态时启动。Statement 6 和 7 不在 Transaction 2 的边界内，这与服务器将事务写入二进制日志的方式一致。
交易工具
三个属性定义事务：
访问模式（只读、读写）
隔离级别（SERIALIZABLE、
REPEATABLE READ等）
隐式（autocommit
启用）或显式（autocommit禁用）
为了降低事务检测的复杂性并确保收集的事务数据提供完整、有意义的结果，所有事务都独立于访问模式、隔离级别或自动提交模式进行检测。
要有选择地检查交易历史，请使用交易事件表中的属性列：
ACCESS_MODE、
ISOLATION_LEVEL和
AUTOCOMMIT。
可以通过多种方式降低事务检测的成本，例如根据用户、帐户、主机或线程（客户端连接）启用或禁用事务检测。
事务和嵌套事件
事务事件的父级是启动事务的事件。对于显式启动的事务，这包括START
TRANSACTION和
COMMIT AND
CHAIN语句。对于隐式启动的事务，它是前一个事务结束后使用事务引擎的第一条语句。
通常，事务是事务期间启动的所有事件的顶级父级，包括显式结束事务的语句，例如
COMMIT和
ROLLBACK。异常是隐式结束事务的语句，例如 DDL 语句，在这种情况下，必须在执行新语句之前提交当前事务。
事务和存储程序
事务和存储程序事件的关系如下：
存储过程
存储过程独立于事务运行。存储过程可以在事务中启动，事务可以从存储过程中启动或结束。如果从事务中调用，存储过程可以执行强制提交父事务的语句，然后启动新事务。
如果存储过程在事务中启动，则该事务是存储过程事件的父级。
如果事务由存储过程启动，则存储过程是事务事件的父级。
存储函数
存储函数被限制不会导致显式或隐式提交或回滚。存储函数事件可以驻留在父事务事件中。
触发器
触发器作为访问与其关联的表的语句的一部分激活，因此触发器事件的父级始终是激活它的语句。
触发器不能发出导致显式或隐式提交或回滚事务的语句。
预定活动
计划事件主体中语句的执行发生在新连接中。在父事务中嵌套预定事件是不适用的。
事务和保存点
保存点语句被记录为单独的语句事件。事务事件包括在事务期间发出的 、 和 语句
SAVEPOINT的
ROLLBACK TO
SAVEPOINT单独
计数器
。RELEASE
SAVEPOINT
事务和错误
事务中发生的错误和警告记录在语句事件中，但不记录在相应的事务事件中。这包括特定于事务的错误和警告，例如非事务表上的回滚或 GTID 一致性错误。
© Mysql 中文网
