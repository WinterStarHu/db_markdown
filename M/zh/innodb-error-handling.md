# 15.21.5 InnoDB 错误处理_MySQL 8.0 参考手册

15.21.5 InnoDB 错误处理_MySQL 8.0 参考手册
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
15.21 InnoDB 故障排除
15.21.1 排除 InnoDB I/O 问题1
15.21.2 故障排除恢复失败1
15.21.3 强制 InnoDB 恢复1
15.21.4 InnoDB 数据字典操作故障排除1
15.21.5 InnoDB 错误处理1
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.21 InnoDB 故障排除  /
15.21.5 InnoDB 错误处理
15.21.5 InnoDB 错误处理
以下项目描述了如何InnoDB
执行错误处理。InnoDB有时只回滚失败的语句，有时回滚整个事务。
如果表空间中的文件空间
不足，则会发生MySQL
Table is full错误并
InnoDB回滚 SQL 语句。
事务死锁
导致回滚整个
事务。InnoDB_
发生这种情况时重试整个事务。
锁等待超时导致InnoDB回滚当前语句（等待锁并遇到超时的语句）。要使整个事务回滚，请在
--innodb-rollback-on-timeout
启用的情况下启动服务器。--innodb-rollback-on-timeout如果使用默认行为，则重试语句；如果启用
，则重试整个事务
。
死锁和锁等待超时在繁忙的服务器上都是正常的，应用程序有必要意识到它们可能发生并通过重试来处理它们。您可以通过在事务期间对数据的第一次更改和提交之间做尽可能少的工作来降低它们的可能性，因此锁定的时间尽可能短，行数也尽可能少。有时在不同事务之间拆分工作可能是实用且有帮助的。
IGNORE如果您未在语句中指定该选项
，则重复键错误会回滚 SQL语句。
Arow too long error回滚 SQL 语句。
其他错误大多由MySQL代码层（InnoDB存储引擎层以上）检测到，并回滚相应的SQL语句。单个 SQL 语句的回滚不会释放锁。
在隐式回滚期间，以及在执行显式
ROLLBACKSQL 语句期间，SHOW PROCESSLIST
显示Rolling back在
State相关连接的列中。
© Mysql 中文网
