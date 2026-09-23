# 15.16.1 使用性能模式监视 InnoDB 表的 ALTER TABLE 进度_MySQL 8.0 参考手册

15.16.1 使用性能模式监视 InnoDB 表的 ALTER TABLE 进度_MySQL 8.0 参考手册
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
15.13 InnoDB静态数据加密
15.14 InnoDB 启动选项和系统变量
15.15 InnoDB INFORMATION_SCHEMA 表
15.16 InnoDB 与 MySQL 性能模式的集成
15.16.1 使用性能模式监视 InnoDB 表的 ALTER TABLE 进度1
15.16.2 使用性能模式监控 InnoDB Mutex 等待1
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.16 InnoDB 与 MySQL 性能模式的集成  /
15.16.1 使用性能模式监视 InnoDB 表的 ALTER TABLE 进度
15.16.1 使用性能模式监视 InnoDB 表的 ALTER TABLE 进度
您可以使用
Performance Schema
监视表ALTER TABLE
的进度。
InnoDB
有七个阶段事件代表不同的阶段
ALTER TABLE。每个阶段事件都会报告整个
操作在其不同阶段中
WORK_COMPLETED的
运行总和。使用考虑到所有
执行工作的公式计算，并可能在
处理过程中进行修改。和
values 是 . 执行的所有工作的抽象表示
。
WORK_ESTIMATEDALTER TABLEWORK_ESTIMATEDALTER TABLEALTER TABLEWORK_COMPLETEDWORK_ESTIMATEDALTER TABLE
按发生顺序，ALTER TABLE
舞台事件包括：
stage/innodb/alter table (read PK and internal
sort)：这个阶段
ALTER TABLE在read-primary-key阶段有效。它以主键中的估计页数开始
WORK_COMPLETED=0并
设置为。WORK_ESTIMATED当该阶段完成时，
WORK_ESTIMATED更新为主键中的实际页数。
stage/innodb/alter table (merge sort)：对操作添加的每个索引重复此阶段
ALTER TABLE。
stage/innodb/alter table (insert)：对操作添加的每个索引重复此阶段
ALTER TABLE。
stage/innodb/alter table (log apply index)：这个阶段包括应用
ALTER TABLE运行时产生的DML日志。
stage/innodb/alter table (flush)：在此阶段开始之前WORK_ESTIMATED，根据刷新列表的长度更新更准确的估计。
stage/innodb/alter table (log apply table)：这个阶段包括应用ALTER TABLE运行时产生的并发DML日志。此阶段的持续时间取决于表格更改的范围。如果没有在表上运行并发 DML，则此阶段是即时的。
stage/innodb/alter table (end)：包括在刷新阶段之后出现的任何剩余工作，例如重新应用在
ALTER TABLE运行时在表上执行的 DML。
笔记
InnoDB ALTER
TABLE阶段事件目前不考虑添加空间索引。
使用 Performance Schema 的 ALTER TABLE 监控示例
以下示例演示如何启用
stage/innodb/alter table%阶段事件工具和相关消费者表来监控
ALTER TABLE进度。有关性能模式阶段事件工具和相关消费者的信息，请参阅
第 27.12.5 节，“性能模式阶段事件表”。
启用stage/innodb/alter%仪器：
mysql> UPDATE performance_schema.setup_instruments
SET ENABLED = 'YES'
WHERE NAME LIKE 'stage/innodb/alter%';
Query OK, 7 rows affected (0.00 sec)
Rows matched: 7  Changed: 7  Warnings: 0
启用阶段事件消费者表，其中包括
events_stages_current、
events_stages_history和
events_stages_history_long。
mysql> UPDATE performance_schema.setup_consumers
SET ENABLED = 'YES'
WHERE NAME LIKE '%stages%';
Query OK, 3 rows affected (0.00 sec)
Rows matched: 3  Changed: 3  Warnings: 0
运行一个ALTER TABLE操作。在此示例中，将一middle_name列添加到员工示例数据库的员工表中。
mysql> ALTER TABLE employees.employees ADD COLUMN middle_name varchar(14) AFTER first_name;
Query OK, 0 rows affected (9.27 sec)
Records: 0  Duplicates: 0  Warnings: 0ALTER
TABLE通过查询 Performance Schema
events_stages_current表来
检查操作的进度。显示的阶段事件因
ALTER TABLE当前正在进行的阶段而异。该WORK_COMPLETED列显示已完成的工作。该
WORK_ESTIMATED列提供了对剩余工作的估计。
mysql> SELECT EVENT_NAME, WORK_COMPLETED, WORK_ESTIMATED
FROM performance_schema.events_stages_current;
+------------------------------------------------------+----------------+----------------+
| EVENT_NAME                                           | WORK_COMPLETED | WORK_ESTIMATED |
+------------------------------------------------------+----------------+----------------+
| stage/innodb/alter table (read PK and internal sort) |            280 |           1245 |
+------------------------------------------------------+----------------+----------------+
1 row in set (0.01 sec)如果操作已完成，
该events_stages_current表将返回一个空集。ALTER
TABLE在这种情况下，您可以检查events_stages_history
表以查看已完成操作的事件数据。例如：
mysql> SELECT EVENT_NAME, WORK_COMPLETED, WORK_ESTIMATED
FROM performance_schema.events_stages_history;
+------------------------------------------------------+----------------+----------------+
| EVENT_NAME                                           | WORK_COMPLETED | WORK_ESTIMATED |
+------------------------------------------------------+----------------+----------------+
| stage/innodb/alter table (read PK and internal sort) |            886 |           1213 |
| stage/innodb/alter table (flush)                     |           1213 |           1213 |
| stage/innodb/alter table (log apply table)           |           1597 |           1597 |
| stage/innodb/alter table (end)                       |           1597 |           1597 |
| stage/innodb/alter table (log apply table)           |           1981 |           1981 |
+------------------------------------------------------+----------------+----------------+
5 rows in set (0.00 sec)
如上所示，该WORK_ESTIMATED值在ALTER TABLE处理过程中被修改。初始阶段完成后的估计工作量为 1213。ALTER TABLE处理完成后，WORK_ESTIMATED设置为实际值，即 1981。
© Mysql 中文网
