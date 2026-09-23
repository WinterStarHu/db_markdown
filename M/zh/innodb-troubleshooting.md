# 15.21 InnoDB 故障排除_MySQL 8.0 参考手册

15.21 InnoDB 故障排除_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  /
15.21 InnoDB 故障排除
15.21 InnoDB 故障排除
15.21.1 排除 InnoDB I/O 问题15.21.2 故障排除恢复失败15.21.3 强制 InnoDB 恢复15.21.4 InnoDB 数据字典操作故障排除15.21.5 InnoDB 错误处理
以下一般准则适用于解决
InnoDB问题：
当操作失败或您怀疑有错误时，请查看 MySQL 服务器错误日志（请参阅第 5.4.2 节，“错误日志”）。
Server Error Message Reference提供了一些
InnoDB您可能遇到的常见特定错误的故障排除信息。
如果失败与
死锁有关，请在启用该选项的情况下运行，
innodb_print_all_deadlocks
以便将有关每个死锁的详细信息打印到 MySQL 服务器错误日志中。有关死锁的信息，请参阅第 15.7.5 节，“InnoDB 中的死锁”。
如果问题与InnoDB数据字典有关，请参阅
第 15.21.4 节，“InnoDB 数据字典操作故障排除”。
排除故障时，通常最好从命令提示符运行 MySQL 服务器，而不是通过
mysqld_safe或作为 Windows 服务运行。然后您可以看到mysqld打印到控制台的内容，从而更好地了解正在发生的事情。在 Windows 上，使用将输出定向到控制台窗口
的
选项启动mysqld 。--console
启用InnoDB监视器以获取有关问题的信息（请参阅
第 15.17 节，“InnoDB 监视器”）。如果问题与性能有关，或者您的服务器似乎挂起，您应该启用标准监视器来打印有关InnoDB. 如果问题出在锁上，请启用锁监视器。如果问题与表创建、表空间或数据字典操作有关，请参阅
InnoDB 信息架构系统表以检查InnoDB内部数据字典的内容。
InnoDBInnoDB在以下条件下
暂时启用标准
监视器输出：
长时间的信号量等待
InnoDB在缓冲池中找不到空闲块
超过 67% 的缓冲池被锁堆或自适应哈希索引占用
如果您怀疑某个表已损坏，请
CHECK TABLE在该表上运行。
© Mysql 中文网
