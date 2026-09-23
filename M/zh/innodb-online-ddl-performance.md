# 15.12.2 在线 DDL 性能和并发_MySQL 8.0 参考手册

15.12.2 在线 DDL 性能和并发_MySQL 8.0 参考手册
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
15.1 InnoDB简介
15.2 InnoDB 和 ACID 模型
15.3 InnoDB 多版本
15.4 InnoDB架构
15.5 InnoDB 内存结构
15.6 InnoDB 磁盘结构
15.7 InnoDB 锁定和事务模型
15.8 InnoDB配置
15.9 InnoDB 表和页压缩
15.10 InnoDB 行格式
15.11 InnoDB磁盘I/O和文件空间管理
15.12 InnoDB和在线DDL
15.12.1 在线DDL操作1
15.12.2 在线 DDL 性能和并发1
15.12.3 在线 DDL 空间要求1
15.12.4 在线DDL内存管理1
15.12.5 为在线 DDL 操作配置并行线程1
15.12.6 使用在线 DDL 简化 DDL 语句1
15.12.7 在线 DDL 失败条件1
15.12.8 在线 DDL 限制1
15.13 InnoDB静态数据加密
15.14 InnoDB 启动选项和系统变量
15.15 InnoDB INFORMATION_SCHEMA 表
15.16 InnoDB 与 MySQL 性能模式的集成
15.17 InnoDB 监视器
15.18 InnoDB备份与恢复
15.19 InnoDB和MySQL复制
15.20 InnoDB 内存缓存插件
15.21 InnoDB 故障排除
15.22 InnoDB 限制
15.23 InnoDB 限制和限制
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.12 InnoDB和在线DDL  /
15.12.2 在线 DDL 性能和并发
15.12.2 在线 DDL 性能和并发
在线 DDL 改进了 MySQL 操作的几个方面：
访问该表的应用程序响应更快，因为在 DDL 操作正在进行时可以继续对表进行查询和 DML 操作。减少锁定和等待 MySQL 服务器资源导致更大的可伸缩性，即使对于 DDL 操作中不涉及的操作也是如此。
即时操作仅修改数据字典中的元数据。在操作的执行阶段可能会短暂地获取表上的独占元数据锁。表数据不受影响，使操作即时进行。允许并发 DML。
联机操作避免了与表复制方法相关的磁盘 I/O 和 CPU 周期，从而最大限度地减少了数据库的总体负载。最小化负载有助于在 DDL 操作期间保持良好的性能和高吞吐量。
与表复制操作相比，联机操作将更少的数据读入缓冲池，从而减少了从内存中清除频繁访问的数据。清除频繁访问的数据可能会导致 DDL 操作后出现暂时的性能下降。
LOCK 子句
默认情况下，MySQL 在 DDL 操作期间使用尽可能少的锁定。LOCK如果需要，可以为就地操作和一些复制操作指定该子句以强制实施更严格的锁定。如果该
LOCK子句指定的锁定级别低于特定 DDL 操作所允许的级别，则该语句将失败并出现错误。
LOCK条款如下所述，按限制性从最少到最多的顺序排列：
LOCK=NONE:
允许并发查询和 DML。
例如，将此子句用于涉及客户注册或购买的表，以避免在冗长的 DDL 操作期间使表不可用。
LOCK=SHARED:
允许并发查询但阻止 DML。
例如，在数据仓库表上使用此子句，您可以在其中延迟数据加载操作直到 DDL 操作完成，但不能长时间延迟查询。
LOCK=DEFAULT:
允许尽可能多的并发（并发查询、DML 或两者）。省略LOCK子句与指定相同LOCK=DEFAULT。
当您不希望 DDL 语句的默认锁定级别导致表出现任何可用性问题时，请使用此子句。
LOCK=EXCLUSIVE:
阻止并发查询和 DML。
如果主要关注点是在尽可能短的时间内完成 DDL 操作，并且不需要并发查询和 DML 访问，则使用此子句。如果服务器应该空闲，您也可以使用此子句，以避免意外的表访问。
联机 DDL 和元数据锁
在线 DDL 操作可以看作具有三个阶段：
第一阶段：初始化
在初始化阶段，服务器确定在操作期间允许多少并发，同时考虑存储引擎能力、语句中指定的操作以及用户指定的
ALGORITHM和LOCK
选项。在此阶段，采用共享的可升级元数据锁来保护当前表定义。
第二阶段：执行
在此阶段，准备并执行语句。元数据锁是否升级为独占取决于初始化阶段评估的因素。如果需要独占元数据锁，则只会在语句准备期间短暂使用。
阶段 3：提交表定义
在提交表定义阶段，元数据锁升级为独占锁以驱逐旧表定义并提交新表定义。一旦授予，独占元数据锁的持续时间很短。
由于上面列出的独占元数据锁要求，联机 DDL 操作可能必须等待在表上持有元数据锁的并发事务提交或回滚。在 DDL 操作之前或期间启动的事务可以在被更改的表上持有元数据锁。在长时间运行或非活动事务的情况下，联机 DDL 操作可能会在等待独占元数据锁时超时。此外，联机 DDL 操作请求的未决独占元数据锁会阻止表上的后续事务。
以下示例演示了等待排他元数据锁的在线 DDL 操作，以及挂起的元数据锁如何阻止表上的后续事务。
第 1 节：
mysql> CREATE TABLE t1 (c1 INT) ENGINE=InnoDB;
mysql> START TRANSACTION;
mysql> SELECT * FROM t1;
会话 1SELECT语句在表 t1 上获取共享元数据锁。
第 2 节：
mysql> ALTER TABLE t1 ADD COLUMN x INT, ALGORITHM=INPLACE, LOCK=NONE;
会话 2 中的在线 DDL 操作需要表 t1 上的独占元数据锁来提交表定义更改，必须等待会话 1 事务提交或回滚。
第 3 节：
mysql> SELECT * FROM t1;
会话 3 中发出的SELECT语句被阻塞，等待会话 2 中的操作请求的独占元数据锁ALTER TABLE
被授予。
您可以使用它
SHOW FULL
PROCESSLIST来确定事务是否正在等待元数据锁。
mysql> SHOW FULL PROCESSLIST\G
...
*************************** 2. row ***************************
Id: 5
User: root
Host: localhost
db: test
Command: Query
Time: 44
State: Waiting for table metadata lock
Info: ALTER TABLE t1 ADD COLUMN x INT, ALGORITHM=INPLACE, LOCK=NONE
...
*************************** 4. row ***************************
Id: 7
User: root
Host: localhost
db: test
Command: Query
Time: 5
State: Waiting for table metadata lock
Info: SELECT * FROM t1
4 rows in set (0.00 sec)
元数据锁信息也通过 Performance Schemametadata_locks
表公开，该表提供有关会话之间的元数据锁依赖关系、会话正在等待的元数据锁以及当前持有元数据锁的会话的信息。有关详细信息，请参阅
第 27.12.13.3 节，“metadata_locks 表”。
在线 DDL 性能
DDL操作的性能很大程度上取决于操作是否即时、原地、是否重建表。
要评估 DDL 操作的相对性能，您可以使用ALGORITHM=INSTANT、
ALGORITHM=INPLACE和
比较结果ALGORITHM=COPY。还可以在old_alter_table启用的情况下运行语句以强制使用ALGORITHM=COPY.
对于修改表数据的 DDL 操作，您可以通过查看命令完成后显示的“受影响的行数”值
来确定 DDL 操作是就地执行更改还是执行表复制。例如：
更改列的默认值（快速，不影响表数据）：
Query OK, 0 rows affected (0.07 sec)
添加索引（耗时，但0 rows
affected显示表未复制）：
Query OK, 0 rows affected (21.42 sec)
更改列的数据类型（需要大量时间并且需要重建表的所有行）：
Query OK, 1671168 rows affected (1 min 35.54 sec)
在对大表运行 DDL 操作之前，检查操作是快还是慢，如下所示：
克隆表结构。
用少量数据填充克隆表。
在克隆表上运行 DDL 操作。
检查“受影响的行”值是否为零。非零值表示操作复制表数据，这可能需要特殊规划。例如，您可能会在计划停机期间执行 DDL 操作，或者一次在每个副本服务器上执行一个操作。
笔记
为了更好地了解与 DDL 操作相关的 MySQL 处理，请检查性能模式和
与DDL 操作前后
INFORMATION_SCHEMA相关的表，
以查看物理读取、写入、内存分配等的数量。InnoDB
Performance Schema 阶段事件可用于监控
ALTER TABLE进度。请参阅
第 15.16.1 节，“使用性能模式监视 InnoDB 表的 ALTER TABLE 进度”。
因为有一些处理工作涉及记录并发 DML 操作所做的更改，然后在最后应用这些更改，所以在线 DDL 操作总体上可能比阻止其他会话访问表的表复制机制花费更长的时间。原始性能的降低与使用该表的应用程序更好的响应能力相平衡。在评估更改表结构的技术时，根据网页加载时间等因素考虑最终用户对性能的看法。
© Mysql 中文网
