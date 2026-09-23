# 15.7.5 InnoDB 中的死锁_MySQL 8.0 参考手册

15.7.5 InnoDB 中的死锁_MySQL 8.0 参考手册
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
15.7.5.1 InnoDB 死锁示例
15.7.5.2 死锁检测
15.7.5.3 如何最小化和处理死锁
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
15.7.5 InnoDB 中的死锁
15.7.5 InnoDB 中的死锁
15.7.5.1 InnoDB 死锁示例15.7.5.2 死锁检测15.7.5.3 如何最小化和处理死锁
死锁是不同的事务无法继续进行的情况，因为每个事务都持有另一个需要的锁。因为两个事务都在等待资源可用，所以都不会释放它持有的锁。
当事务锁定多个表中的行（通过
UPDATEor
之类的语句SELECT ... FOR
UPDATE）但顺序相反时，可能会发生死锁。当这样的语句锁定索引记录和间隙的范围时，也会发生死锁，由于时间问题，每个事务都会获取一些锁而不是其他锁。有关死锁示例，请参阅
第 15.7.5.1 节，“InnoDB 死锁示例”。
为了减少死锁的可能性，使用事务而不是LOCK TABLES语句；保持插入或更新数据的事务足够小，以至于它们不会长时间保持打开状态；SELECT ... FOR
UPDATE当不同的事务更新多个表或大范围的行时，在每个事务中使用相同的操作顺序（例如
）；SELECT ...
FOR UPDATE在和
UPDATE ... WHERE
语句中使用的列上创建索引。死锁的可能性不受隔离级别的影响，因为隔离级别改变了读操作的行为，而死锁的发生是因为写操作。有关避免死锁情况和从死锁情况中恢复的详细信息，请参阅
第 15.7.5.3 节，“如何最小化和处理死锁”。
当启用死锁检测（默认）并且确实发生死锁时，InnoDB检测条件并回滚其中一个事务（受害者）。如果使用
innodb_deadlock_detect变量禁用死锁检测，
则InnoDB依赖
innodb_lock_wait_timeout设置在出现死锁时回滚事务。因此，即使您的应用程序逻辑正确，您仍然必须处理必须重试事务的情况。InnoDB要查看用户事务
中的最后一个死锁，请使用SHOW ENGINE INNODB
STATUS。如果频繁的死锁突出了事务结构或应用程序错误处理的问题，启用
innodb_print_all_deadlocks将有关所有死锁的信息打印到
mysqld错误日志。有关如何自动检测和处理死锁的更多信息，请参阅
第 15.7.5.2 节，“死锁检测”。
© Mysql 中文网
