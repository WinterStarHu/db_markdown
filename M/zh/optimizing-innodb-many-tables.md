# 8.5.10 为多表系统优化 InnoDB_MySQL 8.0 参考手册

8.5.10 为多表系统优化 InnoDB_MySQL 8.0 参考手册
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
8.1 优化概述
8.2 优化SQL语句
8.3 优化和索引
8.4 优化数据库结构
8.5 优化 InnoDB 表
8.5.1 优化 InnoDB 表的存储布局1
8.5.2 优化 InnoDB 事务管理1
8.5.3 优化 InnoDB 只读事务1
8.5.4 优化 InnoDB 重做日志记录1
8.5.5 InnoDB 表的批量数据加载1
8.5.6 优化 InnoDB 查询1
8.5.7 优化 InnoDB DDL 操作1
8.5.8 优化 InnoDB 磁盘 I/O1
8.5.9 优化 InnoDB 配置变量1
8.5.10 为多表系统优化 InnoDB1
8.6 优化 MyISAM 表
8.7 优化 MEMORY 表
8.8 了解查询执行计划
8.9 控制查询优化器
8.10 缓冲和缓存
8.11 优化锁定操作
8.12 优化MySQL服务器
8.13 测量性能（基准测试）
8.14 查看服务器线程（进程）信息
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
MySQL 词汇表
MySQL 8.0 参考手册  / 第8章优化  / 8.5 优化 InnoDB 表  /
8.5.10 为多表系统优化 InnoDB
8.5.10 为多表系统优化 InnoDB
如果您配置
了非持久优化器统计信息（非默认配置），
则在启动后第一次访问该表时InnoDB计算该表的索引
基数值，而不是将此类值存储在表中。在将数据分区到许多表中的系统上，此步骤可能会花费大量时间。由于此开销仅适用于初始表打开操作，要“预热”
表供以后使用，请在启动后立即通过发出诸如.
SELECT 1 FROM
tbl_name LIMIT 1
优化器统计信息默认保存到磁盘，由
innodb_stats_persistent
配置选项启用。有关持久优化器统计信息的信息，请参阅
第 15.8.10.1 节，“配置持久优化器统计参数”。
© Mysql 中文网
