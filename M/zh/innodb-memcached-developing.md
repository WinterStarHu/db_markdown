# 15.20.6 为 InnoDB memcached 插件编写应用程序_MySQL 8.0 参考手册

15.20.6 为 InnoDB memcached 插件编写应用程序_MySQL 8.0 参考手册
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
15.20.6.1 为 InnoDB memcached 插件调整现有的 MySQL 模式
15.20.6.2 为 InnoDB memcached 插件调整 memcached 应用程序
15.20.6.3 调整 InnoDB memcached 插件性能
15.20.6.4 控制 InnoDB memcached 插件的事务行为
15.20.6.5 使 DML 语句适应 memcached 操作
15.20.6.6 对底层 InnoDB 表执行 DML 和 DDL 语句
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.20 InnoDB 内存缓存插件  /
15.20.6 为 InnoDB memcached 插件编写应用程序
15.20.6 为 InnoDB memcached 插件编写应用程序
15.20.6.1 为 InnoDB memcached 插件调整现有的 MySQL 模式15.20.6.2 为 InnoDB memcached 插件调整 memcached 应用程序15.20.6.3 调整 InnoDB memcached 插件性能15.20.6.4 控制 InnoDB memcached 插件的事务行为15.20.6.5 使 DML 语句适应 memcached 操作15.20.6.6 对底层 InnoDB 表执行 DML 和 DDL 语句
InnoDB 通常，为memcached插件
编写应用程序
涉及某种程度的重写或改编使用 MySQL 或memcached API 的现有代码。
使用该插件，而不是在低功率机器上运行
daemon_memcached的许多传统内存缓存服务器，您拥有与 MySQL 服务器相同数量的内存缓存服务器，在具有大量磁盘存储和内存的相对高功率机器上运行。您可能会重用一些与memcached API 一起使用的现有代码，但由于服务器配置不同，可能需要进行调整。
通过
daemon_memcached插件存储的数据进入
VARCHAR、
TEXT或
BLOB列，必须转换才能进行数字运算。您可以在应用程序端执行转换，也可以在查询中使用该
CAST()函数。
如果您有数据库背景，您可能习惯于使用具有许多列的通用 SQL 表。memcached代码访问的表可能只有少数甚至单个列保存数据值。
您可以调整应用程序中执行单行查询、插入、更新或删除的部分，以提高代码关键部分的性能。当通过memcached
接口执行时，查询（读取）和
DML （写入）操作都
可以大大加快
。写入的性能改进通常大于读取的性能改进，因此您可能会专注于调整在网站上执行日志记录或记录交互选择的代码。
InnoDB
以下各节将更详细地探讨这些要点。
© Mysql 中文网
