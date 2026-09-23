# 15.11 InnoDB磁盘I/O和文件空间管理_MySQL 8.0 参考手册

15.11 InnoDB磁盘I/O和文件空间管理_MySQL 8.0 参考手册
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
15.11.1 InnoDB 磁盘 I/O1
15.11.2 文件空间管理1
15.11.3 InnoDB 检查点1
15.11.4 对表进行碎片整理1
15.11.5 使用 TRUNCATE TABLE 回收磁盘空间1
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
15.11 InnoDB磁盘I/O和文件空间管理
15.11 InnoDB磁盘I/O和文件空间管理
15.11.1 InnoDB 磁盘 I/O15.11.2 文件空间管理15.11.3 InnoDB 检查点15.11.4 对表进行碎片整理15.11.5 使用 TRUNCATE TABLE 回收磁盘空间
作为 DBA，您必须管理磁盘 I/O 以防止 I/O 子系统变得饱和，并管理磁盘空间以避免填满存储设备。ACID设计模型需要一定数量的 I/O，这看似多余，但有助于确保数据可靠性。在这些约束下，
InnoDB尝试优化数据库工作和磁盘文件的组织以最小化磁盘 I/O 量。有时，I/O 会被推迟到数据库不忙时，或者直到一切都需要达到一致状态时，例如在快速关闭后重新启动数据库期间。
本节讨论使用默认类型的 MySQL 表（也称为
InnoDB表）的 I/O 和磁盘空间的主要注意事项：
控制用于提高查询性能的后台 I/O 量。
启用或禁用以额外 I/O 为代价提供额外耐用性的功能。
将表格组织成许多小文件、几个大文件或两者的组合。
平衡重做日志文件的大小与日志文件变满时发生的 I/O 活动。
如何重组表以获得最佳查询性能。
© Mysql 中文网
