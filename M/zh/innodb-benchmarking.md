# 15.1.4 使用 InnoDB 进行测试和基准测试_MySQL 8.0 参考手册

15.1.4 使用 InnoDB 进行测试和基准测试_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.1 InnoDB简介  /
15.1.4 使用 InnoDB 进行测试和基准测试
15.1.4 使用 InnoDB 进行测试和基准测试
如果InnoDB不是默认存储引擎，您可以通过
在命令行上
定义或在 MySQL 服务器选项文件部分中
定义InnoDB重新启动服务器
来确定您的数据库服务器和应用程序是否正常工作。--default-storage-engine=InnoDBdefault-storage-engine=innodb[mysqld]
由于更改默认存储引擎只会影响新创建的表，因此运行应用程序安装和设置步骤以确认一切安装正确，然后运行应用程序功能以确保数据加载、编辑和查询功能正常工作。如果表依赖于特定于另一个存储引擎的功能，您会收到错误消息。在这种情况下，将
子句添加到
语句中以避免错误。
ENGINE=other_engine_nameCREATE TABLE
如果您没有对存储引擎做出有意的决定，并且想要预览某些表在使用创建时的工作方式InnoDB，请为每个表发出命令
ALTER TABLE
table_name ENGINE=InnoDB;。或者，要在不影响原始表的情况下运行测试查询和其他语句，请制作一个副本：
CREATE TABLE ... ENGINE=InnoDB AS SELECT * FROM other_engine_table;
要在实际工作负载下评估完整应用程序的性能，请安装最新的 MySQL 服务器并运行基准测试。
测试整个应用程序生命周期，从安装到大量使用，再到服务器重启。数据库繁忙时kill服务器进程模拟掉电，重启服务器时验证数据是否恢复成功。
测试任何复制配置，特别是如果您在源服务器和副本上使用不同的 MySQL 版本和选项。
© Mysql 中文网
