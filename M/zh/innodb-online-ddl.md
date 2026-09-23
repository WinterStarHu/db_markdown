# 15.12 InnoDB和在线DDL_MySQL 8.0 参考手册

15.12 InnoDB和在线DDL_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  /
15.12 InnoDB和在线DDL
15.12 InnoDB和在线DDL
15.12.1 在线DDL操作15.12.2 在线 DDL 性能和并发15.12.3 在线 DDL 空间要求15.12.4 在线DDL内存管理15.12.5 为在线 DDL 操作配置并行线程15.12.6 使用在线 DDL 简化 DDL 语句15.12.7 在线 DDL 失败条件15.12.8 在线 DDL 限制
在线 DDL 功能支持即时和就地表更改以及并发 DML。此功能的好处包括：
在繁忙的生产环境中提高了响应能力和可用性，在这种情况下，让表格在几分钟或几小时内不可用是不切实际的。
对于就地操作，能够使用LOCK子句在 DDL 操作期间调整性能和并发性之间的平衡。请参阅
LOCK 子句。
比表复制方法更少的磁盘空间使用和 I/O 开销。
笔记
ALGORITHM=INSTANTADD COLUMNMySQL 8.0.12 中
的支持和其他操作可用
。
通常，您无需执行任何特殊操作即可启用在线 DDL。默认情况下，MySQL 在允许的情况下立即或就地执行操作，并尽可能少地锁定。
ALGORITHM您可以使用语句的andLOCK子句
控制 DDL 操作的各个方面
ALTER TABLE。这些子句放在语句的末尾，用逗号与表和列规范分开。例如：
ALTER TABLE tbl_name ADD PRIMARY KEY (column), ALGORITHM=INPLACE, LOCK=NONE;
该LOCK子句可用于就地执行的操作，可用于微调操作期间对表的并发访问程度。仅
LOCK=DEFAULT支持立即执行的操作。该ALGORITHM子句主要用于性能比较，并在您遇到任何问题时作为对旧表复制行为的回退。例如：
为避免在就地ALTER
TABLE操作期间意外使表不可用于读取、写入或两者，请在语句中指定一个子句，
ALTER TABLE例如
LOCK=NONE（允许读取和写入）或
LOCK=SHARED（允许读取）。如果请求的并发级别不可用，操作将立即停止。
要比较算法之间的性能，请运行包含
ALGORITHM=INSTANT、
ALGORITHM=INPLACE和
的语句ALGORITHM=COPY。您还可以在old_alter_table
启用配置选项的情况下运行语句以强制使用
ALGORITHM=COPY.
ALTER
TABLE为避免复制表
的操作占用服务器，请包含ALGORITHM=INSTANT或
ALGORITHM=INPLACE。如果语句不能使用指定的算法，它会立即停止。
© Mysql 中文网
