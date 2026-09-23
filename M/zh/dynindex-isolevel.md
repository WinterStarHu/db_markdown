# 事务隔离级别索引_MySQL 8.0 参考手册

事务隔离级别索引_MySQL 8.0 参考手册
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
General Index
C函数索引
命令索引
功能索引
INFORMATION_SCHEMA 索引
连接类型索引
运营商指数
期权指数
特权索引
SQL 模式索引
语句/语法索引
状态变量索引
系统变量索引
事务隔离级别索引
MySQL 词汇表
MySQL 8.0 参考手册  / 附录 C 索引  /
事务隔离级别索引
事务隔离级别索引
右| 小号
R
[索引顶部]
读已提交
第 15.7.2.3 节，“一致的非锁定读取”第 23.4.3.6 节，“定义 NDB Cluster 数据节点”第 23.2.6.1 节，“NDB 和 InnoDB 存储引擎之间的差异”第 18.3.2 节，“组复制限制”第 15.7.5.3 节，“如何最小化和处理死锁”第 15.7.1 节，“InnoDB 锁定”第 15.14 节，“InnoDB 启动选项和系统变量”第 23.2.7.3 节，“与 NDB Cluster 中事务处理相关的限制”第 15.7.3 节，“InnoDB 中不同 SQL 语句设置的锁”第 A.1 节，“MySQL 8.0 FAQ：一般”第 A.10 节，“MySQL 8.0 常见问题解答：NDB Cluster”第 23.2.6.3 节，“NDB 和 InnoDB 功能使用摘要”第 8.5.2 节，“优化 InnoDB 事务管理”第 13.3.7 节，“SET TRANSACTION 语句”第 5.4.4.2 节，“设置二进制日志格式”第 27.12.7.1 节，“events_transactions_current 表”第 15.7.2.1 节，“事务隔离级别”第 1.3 节，“MySQL 8.0 中的新功能”第 23.2.4 节，“NDB Cluster 中的新功能”
读未提交
第 15.7.2.3 节，“一致的非锁定读取”第 15.8.10.1.4 节，“在持久统计计算中包含删除标记的记录”第 15.20.2 节，“InnoDB memcached 架构”第 15.14 节，“InnoDB 启动选项和系统变量”第 23.2.7.3 节，“与 NDB Cluster 中事务处理相关的限制”第 15.20.6.6 节，“在基础 InnoDB 表上执行 DML 和 DDL 语句”第 13.3.7 节，“SET TRANSACTION 语句”第 5.4.4.2 节，“设置二进制日志格式”第 27.12.7.1 节，“events_transactions_current 表”第 15.7.2.1 节，“事务隔离级别”
已提交读
第 5.1.7 节，“服务器命令选项”第 13.3.7 节，“SET TRANSACTION 语句”
读未提交
第 5.1.7 节，“服务器命令选项”第 13.3.7 节，“SET TRANSACTION 语句”
可重复读
第 15.7.2.3 节，“一致的非锁定读取”第 15.20.6.4 节，“控制 InnoDB memcached 插件的事务行为”第 18.3.2 节，“组复制限制”第 15.7.1 节，“InnoDB 锁定”第 15.14 节，“InnoDB 启动选项和系统变量”第 23.2.7.3 节，“与 NDB Cluster 中事务处理相关的限制”第 5.4.4.3 节，“混合二进制日志记录格式”第 4.5.4 节，“mysqldump — 数据库备份程序”第 4.5.6 节，“mysqlpump — 数据库备份程序”第 8.5.2 节，“优化 InnoDB 事务管理”第 27.12.7 节，“性能模式事务表”第 13.3.7 节，“SET TRANSACTION 语句”第 13.3.1 节，“START TRANSACTION、COMMIT 和 ROLLBACK 语句”第 27.12.7.1 节，“events_transactions_current 表”第 15.7.2.1 节，“事务隔离级别”第 1.3 节，“MySQL 8.0 中的新功能”第 13.3.8 节，“XA 事务”
可重复读
第 5.1.7 节，“服务器命令选项”第 5.1.8 节，“服务器系统变量”第 13.3.7 节，“SET TRANSACTION 语句”
小号
[索引顶部]
可序列化
第 18.3.2 节，“组复制限制”第 15.7.1 节，“InnoDB 锁定”第 15.14 节，“InnoDB 启动选项和系统变量”第 23.2.7.3 节，“与 NDB Cluster 中事务处理相关的限制”第 15.7.3 节，“InnoDB 中不同 SQL 语句设置的锁”第 5.4.4.3 节，“混合二进制日志记录格式”第 27.12.7 节，“性能模式事务表”第 5.1.7 节，“服务器命令选项”第 13.3.7 节，“SET TRANSACTION 语句”第 13.3.1 节，“START TRANSACTION、COMMIT 和 ROLLBACK 语句”第 27.12.7.1 节，“events_transactions_current 表”第 15.7.2.1 节，“事务隔离级别”第 13.3.8 节，“XA 事务”
© Mysql 中文网
