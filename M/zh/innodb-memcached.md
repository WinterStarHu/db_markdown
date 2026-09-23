# 15.20 InnoDB 内存缓存插件_MySQL 8.0 参考手册

15.20 InnoDB 内存缓存插件_MySQL 8.0 参考手册
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
15.20.1 InnoDB memcached 插件的好处1
15.20.2 InnoDB 内存缓存架构1
15.20.3 设置 InnoDB memcached 插件1
15.20.4 InnoDB memcached 多获取和范围查询支持1
15.20.5 InnoDB memcached 插件的安全注意事项1
15.20.6 为 InnoDB memcached 插件编写应用程序1
15.20.7 InnoDB memcached 插件和复制1
15.20.8 InnoDB memcached 插件内部1
15.20.9 InnoDB memcached 插件故障排除1
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
15.20 InnoDB 内存缓存插件
15.20 InnoDB 内存缓存插件
15.20.1 InnoDB memcached 插件的好处15.20.2 InnoDB 内存缓存架构15.20.3 设置 InnoDB memcached 插件15.20.4 InnoDB memcached 多获取和范围查询支持15.20.5 InnoDB memcached 插件的安全注意事项15.20.6 为 InnoDB memcached 插件编写应用程序15.20.7 InnoDB memcached 插件和复制15.20.8 InnoDB memcached 插件内部15.20.9 InnoDB memcached 插件故障排除
笔记
从MySQL 8.0.22 开始不推荐使用InnoDB memcached插件；希望在未来版本的 MySQL 中删除对它的支持。
InnoDB memcached插件 ( daemon_memcached) 提供了一个集成的
memcached守护进程，可以自动存储和检索InnoDB表中的数据，将 MySQL 服务器变成一个快速的“键值存储”。您可以使用简单
get的set、 和
incr操作来避免与 SQL 解析和构建查询优化计划相关的性能开销，而不是在 SQL 中制定查询。您还可以
InnoDB通过 SQL 访问相同的表，以实现方便、复杂查询、批量操作和传统数据库软件的其他优势。
这种“ NoSQL 风格”的接口使用
memcached API 来加速数据库操作，让使用其缓冲池机制InnoDB处理内存缓存
。通过、和
等memcached操作
修改的数据存储到磁盘中的
表中。memcached简单性与
可靠性和一致性的结合
为用户提供了两全其美的体验，如
第 15.20.1 节“InnoDB memcached 插件的优势”中所述。有关架构概述，请参阅第 15.20.2 节，“InnoDB memcached 架构”addsetincrInnoDBInnoDB.
© Mysql 中文网
