# 27.12.5 性能模式阶段事件表_MySQL 8.0 参考手册

27.12.5 性能模式阶段事件表_MySQL 8.0 参考手册
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
27.12.5.1 events_stages_current 表
27.12.5.2 events_stages_history 表
27.12.5.3 events_stages_history_long 表
27.12.6 性能模式语句事件表1
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
27.12.5 性能模式阶段事件表
27.12.5 性能模式阶段事件表
27.12.5.1 events_stages_current 表27.12.5.2 events_stages_history 表27.12.5.3 events_stages_history_long 表
Performance Schema 仪器阶段，它们是语句执行过程中的步骤，例如解析语句、打开表或执行
filesort操作。阶段对应于表中显示的SHOW
PROCESSLIST或可见
的线程状态INFORMATION_SCHEMA.PROCESSLIST
。当状态值改变时，阶段开始和结束。
在事件层次结构中，等待事件嵌套在阶段事件中，阶段事件嵌套在语句事件中，语句事件嵌套在事务事件中。
这些表存储阶段事件：
events_stages_current：每个线程的当前阶段事件。
events_stages_history：每个线程结束的最近阶段事件。
events_stages_history_long：全局结束的最新阶段事件（跨所有线程）。
以下部分描述阶段事件表。也有汇集阶段事件信息的汇总表；参见
第 27.12.20.2 节，“阶段汇总表”。
有关三个阶段事件表之间关系的更多信息，请参阅
第 27.9 节，“当前和历史事件的性能模式表”。
配置阶段事件收集舞台活动进度信息
配置阶段事件收集
控制是否采集stage事件，设置相关instruments和consumer的状态：
该setup_instruments表包含名称以 开头的工具
stage。使用这些工具来启用或禁用各个阶段事件类的收集。
该setup_consumers表包含名称与当前和历史阶段事件表名称相对应的消费者值。使用这些消费者来过滤阶段事件的集合。
除了那些提供语句进度信息的工具外，阶段工具默认是禁用的。例如：
mysql> SELECT NAME, ENABLED, TIMED
FROM performance_schema.setup_instruments
WHERE NAME RLIKE 'stage/sql/[a-c]';
+----------------------------------------------------+---------+-------+
| NAME                                               | ENABLED | TIMED |
+----------------------------------------------------+---------+-------+
| stage/sql/After create                             | NO      | NO    |
| stage/sql/allocating local table                   | NO      | NO    |
| stage/sql/altering table                           | NO      | NO    |
| stage/sql/committing alter table to storage engine | NO      | NO    |
| stage/sql/Changing master                          | NO      | NO    |
| stage/sql/Checking master version                  | NO      | NO    |
| stage/sql/checking permissions                     | NO      | NO    |
| stage/sql/cleaning up                              | NO      | NO    |
| stage/sql/closing tables                           | NO      | NO    |
| stage/sql/Connecting to master                     | NO      | NO    |
| stage/sql/converting HEAP to MyISAM                | NO      | NO    |
| stage/sql/Copying to group table                   | NO      | NO    |
| stage/sql/Copying to tmp table                     | NO      | NO    |
| stage/sql/copy to tmp table                        | NO      | NO    |
| stage/sql/Creating sort index                      | NO      | NO    |
| stage/sql/creating table                           | NO      | NO    |
| stage/sql/Creating tmp table                       | NO      | NO    |
+----------------------------------------------------+---------+-------+
提供语句进度信息的阶段事件工具默认启用和计时：
mysql> SELECT NAME, ENABLED, TIMED
FROM performance_schema.setup_instruments
WHERE ENABLED='YES' AND NAME LIKE "stage/%";
+------------------------------------------------------+---------+-------+
| NAME                                                 | ENABLED | TIMED |
+------------------------------------------------------+---------+-------+
| stage/sql/copy to tmp table                          | YES     | YES   |
| stage/sql/Applying batch of row changes (write)      | YES     | YES   |
| stage/sql/Applying batch of row changes (update)     | YES     | YES   |
| stage/sql/Applying batch of row changes (delete)     | YES     | YES   |
| stage/innodb/alter table (end)                       | YES     | YES   |
| stage/innodb/alter table (flush)                     | YES     | YES   |
| stage/innodb/alter table (insert)                    | YES     | YES   |
| stage/innodb/alter table (log apply index)           | YES     | YES   |
| stage/innodb/alter table (log apply table)           | YES     | YES   |
| stage/innodb/alter table (merge sort)                | YES     | YES   |
| stage/innodb/alter table (read PK and internal sort) | YES     | YES   |
| stage/innodb/buffer pool load                        | YES     | YES   |
| stage/innodb/clone (file copy)                       | YES     | YES   |
| stage/innodb/clone (redo copy)                       | YES     | YES   |
| stage/innodb/clone (page copy)                       | YES     | YES   |
+------------------------------------------------------+---------+-------+
默认情况下禁用阶段消费者：
mysql> SELECT *
FROM performance_schema.setup_consumers
WHERE NAME LIKE 'events_stages%';
+----------------------------+---------+
| NAME                       | ENABLED |
+----------------------------+---------+
| events_stages_current      | NO      |
| events_stages_history      | NO      |
| events_stages_history_long | NO      |
+----------------------------+---------+
要在服务器启动时控制阶段事件收集，请在my.cnf文件中使用如下行：
使能够：
[mysqld]
performance-schema-instrument='stage/%=ON'
performance-schema-consumer-events-stages-current=ON
performance-schema-consumer-events-stages-history=ON
performance-schema-consumer-events-stages-history-long=ON
禁用：
[mysqld]
performance-schema-instrument='stage/%=OFF'
performance-schema-consumer-events-stages-current=OFF
performance-schema-consumer-events-stages-history=OFF
performance-schema-consumer-events-stages-history-long=OFF
要在运行时控制阶段事件收集，请更新
setup_instruments和
setup_consumers表：
使能够：
UPDATE performance_schema.setup_instruments
SET ENABLED = 'YES', TIMED = 'YES'
WHERE NAME LIKE 'stage/%';
UPDATE performance_schema.setup_consumers
SET ENABLED = 'YES'
WHERE NAME LIKE 'events_stages%';
禁用：
UPDATE performance_schema.setup_instruments
SET ENABLED = 'NO', TIMED = 'NO'
WHERE NAME LIKE 'stage/%';
UPDATE performance_schema.setup_consumers
SET ENABLED = 'NO'
WHERE NAME LIKE 'events_stages%';
要仅收集特定的舞台事件，请仅启用相应的舞台乐器。要仅为特定阶段事件表收集阶段事件，请启用阶段工具，但仅启用与所需表对应的阶段消费者。
有关配置事件收集的其他信息，请参阅第 27.3 节，“性能模式启动配置”和第 27.4 节，“性能模式运行时配置”。
舞台活动进度信息
Performance Schema 阶段事件表包含两列，它们一起为每一行提供阶段进度指示器：
WORK_COMPLETED：该阶段完成的工作单元数
WORK_ESTIMATED：阶段期望的工作单元数
NULL如果没有为仪器提供进度信息，则
每一列都是。信息的解释（如果可用）完全取决于仪器的实施。Performance Schema 表提供了一个容器来存储进度数据，但不对指标本身的语义做出任何假设：
“工作单元”是一个整数度量，它在执行期间随时间增加，例如处理的字节数、行数、文件数或表数。特定仪器的“工作单位”定义
留给提供数据的仪器代码。
该WORK_COMPLETED值可以一次增加一个或多个单位，具体取决于检测代码。
该WORK_ESTIMATED值可以在此阶段更改，具体取决于检测代码。
阶段事件进度指示器的检测可以实现以下任何行为：
没有进度检测
这是最典型的情况，没有提供进度数据。和WORK_COMPLETED列
WORK_ESTIMATED都是
NULL。
无限进度检测
只有WORK_COMPLETED列是有意义的。该列未提供任何数据
WORK_ESTIMATED，显示为 0。
通过查询
events_stages_current受监视会话的表，监视应用程序可以报告到目前为止执行了多少工作，但不能报告该阶段是否接近完成。目前，没有像这样的阶段。
有界进度检测
和WORK_COMPLETED列
WORK_ESTIMATED都有意义。
这种类型的进度指示器适用于具有定义的完成标准的操作，例如稍后描述的表格复制工具。通过查询
events_stages_current受监视会话的表，监视应用程序可以报告到目前为止已经执行了多少工作，并且可以通过计算WORK_COMPLETED/
WORK_ESTIMATED比率来报告该阶段的总体完成百分比。
该stage/sql/copy to tmp table工具说明了进度指标的工作原理。在执行
ALTER TABLE语句期间，
stage/sql/copy to tmp table会使用该阶段，该阶段可能会执行很长时间，具体取决于要复制的数据的大小。
表复制任务有一个定义的终止（复制所有行），并且该stage/sql/copy to tmp table阶段被检测以提供有界的进度信息：使用的工作单元是复制的行数，
WORK_COMPLETED并且
WORK_ESTIMATED都是有意义的，它们的比率表示任务完成百分比。
要启用仪器和相关消费者，请执行以下语句：
UPDATE performance_schema.setup_instruments
SET ENABLED='YES'
WHERE NAME='stage/sql/copy to tmp table';
UPDATE performance_schema.setup_consumers
SET ENABLED='YES'
WHERE NAME LIKE 'events_stages_%';
要查看正在进行的ALTER
TABLE语句的进度，请从
events_stages_current表中选择。
© Mysql 中文网
