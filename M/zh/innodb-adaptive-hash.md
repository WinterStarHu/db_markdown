# 15.5.3 自适应哈希索引_MySQL 8.0 参考手册

15.5.3 自适应哈希索引_MySQL 8.0 参考手册
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
15.5.1 缓冲池1
15.5.2 更改缓冲区1
15.5.3 自适应哈希索引1
15.5.4 日志缓冲区1
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.5 InnoDB 内存结构  /
15.5.3 自适应哈希索引
15.5.3 自适应哈希索引
自适应哈希索引能够InnoDB在具有适当的工作负载组合和足够的缓冲池内存的系统上更像内存数据库，而不会牺牲事务功能或可靠性。自适应哈希索引由
innodb_adaptive_hash_index
变量启用，或在服务器启动时由 关闭
--skip-innodb-adaptive-hash-index。
基于观察到的搜索模式，使用索引键的前缀构建哈希索引。前缀可以是任意长度，也可能只是B树中的某些值出现在哈希索引中。哈希索引是针对经常访问的索引页面按需构建的。
如果一个表几乎完全适合主内存，则哈希索引通过启用对任何元素的直接查找来加速查询，将索引值转换为一种指针。
InnoDB有一个监控索引搜索的机制。如果InnoDB注意到查询可以从构建哈希索引中获益，它会自动这样做。
对于某些工作负载，哈希索引查找的加速大大超过了监视索引查找和维护哈希索引结构的额外工作。在繁重的工作负载（例如多个并发连接）下，访问自适应哈希索引有时会成为争用的源头。带有
LIKE运算符和%
通配符的查询也往往不会受益。对于无法从自适应哈希索引中获益的工作负载，将其关闭可减少不必要的性能开销。由于很难提前预测自适应哈希索引是否适合特定系统和工作负载，因此请考虑在启用和禁用它的情况下运行基准测试。
自适应散列索引功能是分区的。每个索引都绑定到一个特定的分区，每个分区都由一个单独的锁存器保护。分区由
innodb_adaptive_hash_index_parts
变量控制。默认情况下，该
innodb_adaptive_hash_index_parts
变量设置为 8。最大设置为 512。
您可以在输出SEMAPHORES部分
监视自适应哈希索引的使用和争用
。SHOW ENGINE INNODB
STATUS如果有大量线程在等待创建的 rw-latches btr0sea.c，请考虑增加自适应哈希索引分区的数量或禁用自适应哈希索引。
有关散列索引的性能特征的信息，请参阅第 8.3.9 节，“B 树和散列索引的比较”。
© Mysql 中文网
