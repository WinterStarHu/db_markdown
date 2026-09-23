# 15.7.6 事务调度_MySQL 8.0 参考手册

15.7.6 事务调度_MySQL 8.0 参考手册
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
15.7.1 InnoDB 锁定1
15.7.2 InnoDB 事务模型1
15.7.3 InnoDB中不同SQL语句设置的锁1
15.7.4 虚线1
15.7.5 InnoDB 中的死锁1
15.7.6 事务调度1
15.8 InnoDB配置
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.7 InnoDB 锁定和事务模型  /
15.7.6 事务调度
15.7.6 事务调度
InnoDB使用竞争感知事务调度 (CATS) 算法来确定等待锁的事务的优先级。当多个事务在等待同一对象上的锁时，CATS 算法确定哪个事务先获得锁。
CATS 算法通过分配调度权重来确定等待事务的优先级，调度权重是根据事务阻塞的事务数计算的。例如，如果两个事务正在等待同一对象上的锁，则阻塞最多事务的事务将分配更大的调度权重。如果权重相等，则优先考虑等待时间最长的事务。
笔记
在 MySQL 8.0.20 之前，InnoDB也使用先进先出 (FIFO) 算法来调度事务，而 CATS 算法仅在严重的锁争用下使用。MySQL 8.0.20 中的 CATS 算法增强功能使 FIFO 算法变得冗余，允许将其删除。从 MySQL 8.0.20 开始，以前由 FIFO 算法执行的事务调度由 CATS 算法执行。在某些情况下，此更改可能会影响事务被授予锁的顺序。
TRX_SCHEDULE_WEIGHT您可以通过查询表中的列
来查看事务调度权重
INFORMATION_SCHEMA.INNODB_TRX。仅为等待交易计算权重。等待事务是那些处于LOCK WAIT
事务执行状态的事务，如
TRX_STATE列中所报告的那样。不等待锁定的事务报告 NULL
TRX_SCHEDULE_WEIGHT值。
INNODB_METRICS提供计数器用于监视代码级事务调度事件。有关使用
INNODB_METRICS计数器的信息，请参阅
第 15.15.6 节，“InnoDB INFORMATION_SCHEMA 指标表”。
lock_rec_release_attempts
尝试释放记录锁的次数。一次尝试可能导致释放零个或多个记录锁，因为在单个结构中可能有零个或多个记录锁。
lock_rec_grant_attempts
尝试授予记录锁的次数。一次尝试可能会导致授予零个或多个记录锁。
lock_schedule_refreshes
分析等待图以更新预定事务权重的次数。
© Mysql 中文网
