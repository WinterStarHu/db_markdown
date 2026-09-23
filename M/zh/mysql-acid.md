# 15.2 InnoDB 和 ACID 模型_MySQL 8.0 参考手册

15.2 InnoDB 和 ACID 模型_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  /
15.2 InnoDB 和 ACID 模型
15.2 InnoDB 和 ACID 模型
ACID模型是一组数据库设计原则，强调对业务数据和关键任务应用程序很重要的可靠性方面
。MySQL 包括诸如InnoDB严格遵守 ACID 模型的存储引擎，因此数据不会损坏，结果也不会因软件崩溃和硬件故障等异常情况而失真。当您依赖 ACID 兼容功能时，您不需要重新发明一致性检查和崩溃恢复机制。如果您有额外的软件保护措施、超可靠的硬件或可以容忍少量数据丢失或不一致的应用程序，您可以调整 MySQL 设置以牺牲一些 ACID 可靠性来换取更高的性能或吞吐量。
以下部分讨论 MySQL 特性，特别是
InnoDB存储引擎，如何与 ACID 模型的类别交互：
答：原子性。
C：一致性。
我：：隔离。
D：耐久性。
原子性
ACID 模型的原子性方面主要涉及InnoDB
事务。相关的 MySQL 特性包括：
autocommit设置
。COMMIT声明
。ROLLBACK
声明
。
一致性
ACID 模型的一致性方面主要涉及内部InnoDB处理以防止数据崩溃。相关的 MySQL 特性包括：
双InnoDB写缓冲区。请参见
第 15.6.4 节，“双写缓冲区”。
InnoDB崩溃恢复。请参阅
InnoDB 崩溃恢复。
隔离
ACID 模型的隔离方面主要涉及InnoDB
事务，特别是应用于每个事务的隔离级别。相关的 MySQL 特性包括：
autocommit设置
。
事务隔离级别和SET
TRANSACTION声明。请参阅
第 15.7.2.1 节，“事务隔离级别”。
InnoDB
锁定
的底层细节。可以在INFORMATION_SCHEMA表（请参阅
第 15.15.2 节，“InnoDB INFORMATION_SCHEMA 事务和锁定信息”）和性能模式data_locks和
data_lock_waits表中查看详细信息。
耐用性
ACID 模型的持久性方面涉及与特定硬件配置交互的 MySQL 软件功能。由于有多种可能性取决于您的 CPU、网络和存储设备的能力，因此在这方面提供具体指导方针是最复杂的。（这些指导方针可能采取
“购买新硬件”的形式。）相关的 MySQL 功能包括：
双InnoDB写缓冲区。请参见
第 15.6.4 节，“双写缓冲区”。
innodb_flush_log_at_trx_commit
变量
。
sync_binlog变量
。innodb_file_per_table
变量
。
存储设备（例如磁盘驱动器、SSD 或 RAID 阵列）中的写入缓冲区。
存储设备中的电池供电缓存。
用于运行 MySQL 的操作系统，特别是它对fsync()系统调用的支持。
不间断电源 (UPS) 保护运行 MySQL 服务器和存储 MySQL 数据的所有计算机服务器和存储设备的电力。
您的备份策略，例如备份频率和类型，以及备份保留期。
对于分布式或托管数据应用程序，MySQL 服务器硬件所在的数据中心的特定特征，以及数据中心之间的网络连接。
© Mysql 中文网
