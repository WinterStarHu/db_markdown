# 15.12.3 在线 DDL 空间要求_MySQL 8.0 参考手册

15.12.3 在线 DDL 空间要求_MySQL 8.0 参考手册
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
15.12.3 在线 DDL 空间要求
15.12.3 在线 DDL 空间要求
下面概述了联机 DDL 操作的磁盘空间要求。这些要求不适用于立即执行的操作。
临时日志文件：
当在线 DDL 操作创建索引或更改表时，临时日志文件会记录并发 DML。临时日志文件根据需要扩展
innodb_sort_buffer_size到由 指定的最大值
innodb_online_alter_log_max_size。如果操作耗时较长，并发 DML 对表的修改过多，导致临时日志文件的大小超过 的值
innodb_online_alter_log_max_size，则在线 DDL 操作失败并
DB_ONLINE_LOG_TOO_BIG报错，未提交的并发 DML 操作将回滚。一个大的
innodb_online_alter_log_max_size
设置允许在线 DDL 操作期间有更多 DML，但它也会延长 DDL 操作结束时表被锁定以应用记录的 DML 的时间段。
该innodb_sort_buffer_size
变量还定义了临时日志文件读取缓冲区和写入缓冲区的大小。
临时排序文件：
重建表的在线 DDL 操作将临时排序文件写入 MySQL 临时目录（$TMPDIR在 Unix 上，%TEMP%
在 Windows 上，或由
--tmpdir) 在索引创建期间。临时排序文件不会在包含原始表的目录中创建。每个临时排序文件都足够大以容纳一列数据，并且每个排序文件在其数据合并到最终表或索引中时被删除。涉及临时排序文件的操作可能需要等于表中数据量加上索引的临时空间。如果联机 DDL 操作使用了数据目录所在文件系统上的所有可用磁盘空间，则会报告错误。
如果 MySQL 临时目录不足以容纳排序文件，请设置tmpdir为不同的目录。或者，使用 为在线 DDL 操作定义一个单独的临时目录
innodb_tmpdir。引入此选项是为了帮助避免由于大型临时排序文件而可能发生的临时目录溢出。
中间表文件：
一些重建表的在线 DDL 操作会在与原始表相同的目录中创建一个临时中间表文件。中间表文件可能需要与原始表大小相等的空间。中间表文件名以前缀开头，#sql-ib只在在线DDL操作中短暂出现。
该innodb_tmpdir选项不适用于中间表文件。
© Mysql 中文网
