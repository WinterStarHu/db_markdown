# 15.12.7 在线 DDL 失败条件_MySQL 8.0 参考手册

15.12.7 在线 DDL 失败条件_MySQL 8.0 参考手册
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
15.12.7 在线 DDL 失败条件
15.12.7 在线 DDL 失败条件
在线 DDL 操作失败通常是由于以下情况之一：
ALGORITHM子句指定与特定类型的 DDL 操作或存储引擎不兼容的算法
。子句指定与特定类型的 DDL 操作不兼容
的LOCK低程度锁定（SHARED或）。NONE
在等待表上的
独占锁时发生超时，在 DDL 操作的初始和最后阶段可能会短暂需要。
tmpdir或
innodb_tmpdir文件系统耗尽磁盘空间，而 MySQL 在创建索引期间将临时排序文件写入磁盘
。有关详细信息，请参阅
第 15.12.3 节，“在线 DDL 空间要求”。
操作耗时较长，并发DML修改表过多，导致临时在线日志的大小超过
innodb_online_alter_log_max_size
配置选项的值。这种情况会导致
DB_ONLINE_LOG_TOO_BIG错误。
并发 DML 对原始表定义允许的表进行更改，但不允许使用新表定义。当 MySQL 尝试应用来自并发 DML 语句的所有更改时，操作只会在最后失败。例如，您可能会在创建唯一索引时将重复值插入列中，或者您可能会
NULL在列上创建
主键索引时将值插入列中。并发 DML 所做的更改优先，并且ALTER TABLE
操作被有效地回滚。
© Mysql 中文网
