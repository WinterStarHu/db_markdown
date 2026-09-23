# 15.12.8 在线 DDL 限制_MySQL 8.0 参考手册

15.12.8 在线 DDL 限制_MySQL 8.0 参考手册
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
15.12.8 在线 DDL 限制
15.12.8 在线 DDL 限制
以下限制适用于联机 DDL 操作：
在 上创建索引时会复制该表
TEMPORARY TABLE。
如果表上有或约束，则
不允许使用
该ALTER TABLE子句
。LOCK=NONEON...CASCADEON...SET
NULL
在就地在线 DDL 操作完成之前，它必须等待在表上持有元数据锁的事务提交或回滚。在线 DDL 操作在其执行阶段可能会短暂地需要对表进行独占元数据锁定，并且在更新表定义时在操作的最后阶段始终需要一个。因此，在表上持有元数据锁的事务可能会导致联机 DDL 操作阻塞。在表上持有元数据锁的事务可能在联机 DDL 操作之前或期间启动。对表持有元数据锁的长时间运行或非活动事务可能会导致在线 DDL 操作超时。
运行就地在线 DDL 操作时，运行该ALTER TABLE语句的线程应用在线 DML 操作日志，这些操作在其他连接线程的同一表上同时运行。应用 DML 操作时，可能会遇到重复键条目错误 ( ERROR 1062 (23000): Duplicate entry )，即使重复条目只是暂时的，并且会被在线日志中的后续条目恢复。这类似于外键约束检查的想法，InnoDB其中约束必须在事务期间保持。
OPTIMIZE TABLE对于一个
InnoDB表，映射到一个
ALTER TABLE操作以重建表并更新索引统计信息和释放聚簇索引中未使用的空间。二级索引的创建效率不高，因为键是按照它们在主键中出现的顺序插入的。
OPTIMIZE TABLE通过添加在线 DDL 支持来支持重建常规表和分区InnoDB表。
不支持
在 MySQL 5.6 之前创建的包含临时列（DATE或
DATETIME）
TIMESTAMP且尚未重建的表。在这种情况下，
操作会返回以下错误：
ALGORITHM=COPYALGORITHM=INPLACEALTER TABLE ...
ALGORITHM=INPLACEERROR 1846 (0A000): ALGORITHM=INPLACE is not supported.
Reason: Cannot change column type INPLACE. Try ALGORITHM=COPY.
以下限制通常适用于涉及重建表的大型表的在线 DDL 操作：
没有暂停联机 DDL 操作或限制联机 DDL 操作的 I/O 或 CPU 使用率的机制。
如果操作失败，在线 DDL 操作的回滚可能代价高昂。
长时间运行在线 DDL 操作会导致复制滞后。联机 DDL 操作必须先在源上完成运行，然后才能在副本上运行。此外，在副本上并发处理的 DML 仅在副本上的 DDL 操作完成后才在副本上处理。
有关在大型表上运行在线 DDL 操作的其他信息，请参阅
第 15.12.2 节，“在线 DDL 性能和并发性”。
© Mysql 中文网
