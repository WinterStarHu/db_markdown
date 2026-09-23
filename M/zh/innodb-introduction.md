# 15.1 InnoDB简介_MySQL 8.0 参考手册

15.1 InnoDB简介_MySQL 8.0 参考手册
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
15.1.1 使用 InnoDB 表的好处1
15.1.2 InnoDB 表的最佳实践1
15.1.3 验证 InnoDB 是默认存储引擎1
15.1.4 使用 InnoDB 进行测试和基准测试1
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
15.1 InnoDB简介
15.1 InnoDB简介
15.1.1 使用 InnoDB 表的好处15.1.2 InnoDB 表的最佳实践15.1.3 验证 InnoDB 是默认存储引擎15.1.4 使用 InnoDB 进行测试和基准测试
InnoDB是一个兼顾高可靠性和高性能的通用存储引擎。在 MySQL 8.0 中，InnoDB是默认的 MySQL 存储引擎。除非您配置了不同的默认存​​储引擎，否则发出CREATE
TABLE不带ENGINE
子句的语句会创建一个InnoDB表。
InnoDB 的主要优势
它的 DML 操作遵循 ACID 模型，事务具有提交、回滚和崩溃恢复功能以保护用户数据。请参阅第 15.2 节，“InnoDB 和 ACID 模型”。
行级锁定和 Oracle 风格的一致性读取提高了多用户并发性和性能。请参阅
第 15.7 节，“InnoDB 锁定和事务模型”。
InnoDB表将您的数据排列在磁盘上以优化基于主键的查询。每个
InnoDB表都有一个称为聚簇索引的主键索引，它组织数据以最小化主键查找的 I/O。请参阅第 15.6.2.1 节，“聚簇索引和二级索引”。
为了保持数据完整性，InnoDB支持
FOREIGN KEY约束。对于外键，检查插入、更新和删除以确保它们不会导致相关表之间的不一致。请参阅
第 13.1.20.5 节，“外键约束”。
表 15.1 InnoDB 存储引擎特性
特征
支持
B树索引
是的
备份/时间点恢复（在服务器中实现，而不是在存储引擎中。）
是的
集群数据库支持
不
聚簇索引
是的
压缩数据
是的
数据缓存
是的
加密数据
是（通过加密函数在服务器中实现；在MySQL 5.7及更高版本中，支持静态数据加密。）
外键支持
是的
全文搜索索引
是（对 FULLTEXT 索引的支持在 MySQL 5.6 及更高版本中可用。）
地理空间数据类型支持
是的
地理空间索引支持
是（对地理空间索引的支持在 MySQL 5.7 及更高版本中可用。）
哈希索引
否（InnoDB 在内部利用哈希索引来实现其自适应哈希索引功能。）
索引缓存
是的
锁定粒度
排
MVCC
是的
复制支持（在服务器中实现，而不是在存储引擎中。）
是的
存储限制
64TB
T树索引
不
交易
是的
更新数据字典的统计信息
是的
要InnoDB与 MySQL 提供的其他存储引擎的功能进行比较，请参阅第 16 章，替代存储引擎中的存储引擎功能表
。
InnoDB 增强功能和新功能
有关InnoDB增强功能和新功能的信息，请参阅：
第 1.3 节“MySQL 8.0 中的新功能”中
的InnoDB增强列表
。
发行
说明。
其他 InnoDB 信息和资源
有关InnoDB相关术语和定义，请参阅MySQL 词汇表。
有关专门用于InnoDB存储引擎的论坛，请参阅
MySQL Forums::InnoDB。
InnoDB与 MySQL 在相同的 GNU GPL 许可版本 2（1991 年 6 月）下发布。有关 MySQL 许可的更多信息，请参阅
http://www.mysql.com/company/legal/licensing/。
© Mysql 中文网
