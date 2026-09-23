# 15.8.9 清除配置_MySQL 8.0 参考手册

15.8.9 清除配置_MySQL 8.0 参考手册
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
15.8.1 InnoDB启动配置1
15.8.2 为只读操作配置 InnoDB1
15.8.3 InnoDB缓冲池配置1
15.8.4 为 InnoDB 配置线程并发1
15.8.5 配置后台InnoDB I/O线程数1
15.8.6 在 Linux 上使用异步 I/O1
15.8.7 配置 InnoDB I/O 容量1
15.8.8 配置自旋锁轮询1
15.8.9 清除配置1
15.8.10 为 InnoDB 配置优化器统计信息1
15.8.11 配置索引页的合并阈值1
15.8.12 为专用 MySQL 服务器启用自动配置1
15.9 InnoDB 表和页压缩
15.10 InnoDB 行格式
15.11 InnoDB磁盘I/O和文件空间管理
15.12 InnoDB和在线DDL
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.8 InnoDB配置  /
15.8.9 清除配置
15.8.9 清除配置
InnoDB当您使用 SQL 语句删除行时，它不会立即从数据库中物理删除行。InnoDB只有在丢弃为删除而写的撤销日志记录时，一行及其索引记录才会被物理
删除。此删除操作仅在多版本并发控制 (MVCC) 或回滚不再需要该行之后发生，称为清除。
清除按定期计划运行。它从历史列表中解析和处理撤消日志页，历史列表是
InnoDB事务系统维护的已提交事务的撤消日志页列表。Purge 在处理完撤消日志页面后将其从历史列表中释放。
配置清除线程
清除操作由一个或多个清除线程在后台执行。清除线程的数量由
innodb_purge_threads变量控制。默认值为 4。
如果 DML 操作集中在单个表上，则表的清除操作由单个清除线程执行，如果 DML 操作涉及大对象值，这可能会导致清除操作变慢、清除滞后增加以及表空间文件大小增加。从 MySQL 8.0.26 开始，如果
innodb_max_purge_lag超过设置，清除工作会自动在可用的清除线程之间重新分配。在这种情况下，过多的活动清除线程会导致与用户线程争用，因此请
innodb_purge_threads相应地管理设置。该
innodb_max_purge_lag变量默认设置为 0，这意味着默认情况下没有最大清除滞后。
如果 DML 操作集中在几个表上，请保持
innodb_purge_threads较低的设置，以便线程不会相互竞争以访问繁忙的表。如果 DML 操作分布在许多表中，请考虑更高的
innodb_purge_threads设置。最大清除线程数为 32。
该innodb_purge_threads设置是允许的最大清除线程数。清除系统自动调整使用的清除线程数。
配置清除批量大小
该innodb_purge_batch_size
变量定义了从历史列表中清除一批解析和处理的撤消日志页数。默认值为 300。在多线程清除配置中，协调器清除线程除以
innodb_purge_batch_size该
innodb_purge_threads页数并将其分配给每个清除线程。
清除系统还释放不再需要的撤消日志页面。它通过撤消日志每 128 次迭代执行一次。除了定义批量解析和处理的撤消日志页数之外，该
innodb_purge_batch_size变量还定义了通过撤消日志每 128 次迭代清除释放的撤消日志页数。
该innodb_purge_batch_size
变量用于高级性能调整和实验。大多数用户不需要更改
innodb_purge_batch_size其默认值。
配置最大清除滞后
该innodb_max_purge_lag变量定义了所需的最大清除滞后。当清除滞后超过阈值时，将对、
和
操作innodb_max_purge_lag
施加延迟
，以便清除操作有时间赶上。默认值为 0，这意味着没有最大清除滞后且没有延迟。
INSERTUPDATEDELETE
事务系统维护一个事务列表，这些InnoDB事务具有由
UPDATE或
DELETE操作标记为删除的索引记录。列表的长度是清除滞后。在 MySQL 8.0.14 之前，清除滞后延迟是通过以下公式计算的，其结果是最小延迟为 5000 微秒：
(purge lag/innodb_max_purge_lag - 0.5) * 10000
从 MySQL 8.0.14 开始，清除滞后延迟通过以下修改后的公式计算，将最小延迟减少到 5 微秒。5 微秒的延迟更适合现代系统。
(purge_lag/innodb_max_purge_lag - 0.9995) * 10000
延迟是在清除批次开始时计算的。
有问题的工作负载的典型innodb_max_purge_lag
设置可能是 1000000（一百万），假设事务很小，大小只有 100 字节，并且允许有 100MB 的未清除表行。
清除滞后显示为输出
部分中的History list
length值。TRANSACTIONSSHOW
ENGINE INNODB STATUSmysql> SHOW ENGINE INNODB STATUS;
...
------------
TRANSACTIONS
------------
Trx id counter 0 290328385
Purge done for trx's n:o < 0 290315608 undo n:o < 0 17
History list length 20
该History list length值通常较低，通常小于几千，但写入繁重的工作负载或长时间运行的事务可能会导致它增加，即使对于只读事务也是如此。长时间运行的事务可能导致History list
length增加的原因是，在一致的读取事务隔离级别（例如 ）下
REPEATABLE READ，事务必须返回与创建该事务的读取视图时相同的结果。因此，
InnoDB多版本并发控制 (MVCC) 系统必须在撤消日志中保留数据的副本，直到依赖于该数据的所有事务都已完成。以下是可能导致History list length增加的长时间运行事务的示例：
在存在大量并发 DML 时
使用该
选项
的mysqldump操作。--single-transactionSELECT禁用后
运行查询autocommit，忘记发出显式COMMIT或
ROLLBACK。
为了防止在清除延迟变得巨大的极端情况下出现过度延迟，您可以通过设置
innodb_max_purge_lag_delay
变量来限制延迟。该
变量指定超过阈值innodb_max_purge_lag_delay
时施加的延迟的最大延迟（以微秒为单位
）。innodb_max_purge_lag指定
innodb_max_purge_lag_delay值是通过公式计算的延迟时间的上限
innodb_max_purge_lag。
清除和撤消表空间截断
清除系统还负责截断撤消表空间。您可以配置该
innodb_purge_rseg_truncate_frequency
变量来控制清除系统查找要截断的撤消表空间的频率。有关详细信息，请参阅
截断撤消表空间。
© Mysql 中文网
