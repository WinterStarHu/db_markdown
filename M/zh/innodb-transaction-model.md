# 15.7.2 InnoDB 事务模型_MySQL 8.0 参考手册

15.7.2 InnoDB 事务模型_MySQL 8.0 参考手册
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
15.7.2.1 事务隔离级别
15.7.2.2 自动提交、提交和回滚
15.7.2.3 一致的非锁定读取
15.7.2.4 锁定读取
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
15.7.2 InnoDB 事务模型
15.7.2 InnoDB 事务模型
15.7.2.1 事务隔离级别15.7.2.2 自动提交、提交和回滚15.7.2.3 一致的非锁定读取15.7.2.4 锁定读取
事务InnoDB模型旨在将
多版本数据库的最佳属性与传统的两阶段锁定相结合。InnoDB在行级执行锁定，默认情况下以非锁定
一致读取方式运行查询，采用 Oracle 的风格。中的锁信息以
InnoDB节省空间的方式存储，因此不需要锁升级。通常，允许多个用户锁定InnoDB表中的每一行或行的任何随机子集，而不会导致
InnoDB内存耗尽。
© Mysql 中文网
