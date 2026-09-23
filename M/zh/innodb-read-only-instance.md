# 15.8.2 为只读操作配置 InnoDB_MySQL 8.0 参考手册

15.8.2 为只读操作配置 InnoDB_MySQL 8.0 参考手册
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
15.8.1 InnoDB启动配置1
15.8.2 为只读操作配置 InnoDB1
15.8.3 InnoDB缓冲池配置1
15.8.4 为 InnoDB 配置线程并发1
15.8.5 配置后台InnoDB I/O线程数1
15.8.6 在 Linux 上使用异步 I/O1
15.8.7 配置 InnoDB I/O 容量1
15.8.8 配置自旋锁轮询1
15.8.9 清除配置1
15.8.10 为 InnoDB 配置优化器统计信息1
15.8.11 配置索引页的合并阈值1
15.8.12 为专用 MySQL 服务器启用自动配置1
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.8 InnoDB配置  /
15.8.2 为只读操作配置 InnoDB
15.8.2 为只读操作配置 InnoDB
您可以通过在服务器启动时
InnoDB启用配置选项来查询 MySQL 数据目录位于只读介质上的表
。--innodb-read-only
如何启用
要为只读操作准备实例，请确保在将所有必要信息
存储到只读介质之前将其刷新到数据文件中。在禁用更改缓冲 ( innodb_change_buffering=0) 的情况下运行服务器并缓慢关闭。
要为整个 MySQL 实例启用只读模式，请在服务器启动时指定以下配置选项：
--innodb-read-only=1
如果实例位于 DVD 或 CD 等只读介质上，或者/var目录不是所有人都可写的：
和
--pid-file=path_on_writeable_media--event-scheduler=disabled
--innodb-temp-data-file-path. 该选项指定
InnoDB临时表空间数据文件的路径、文件名和文件大小。默认设置为ibtmp1:12M:autoextend，即在数据目录中创建ibtmp1临时表空间数据文件。要为只读操作准备实例，请设置
innodb_temp_data_file_path为数据目录之外的位置。该路径必须相对于数据目录。例如：
--innodb-temp-data-file-path=../../../tmp/ibtmp1:12M:autoextend
从 MySQL 8.0 开始，启用
innodb_read_only会阻止所有存储引擎的表创建和删除操作。这些操作修改
mysql系统数据库中的数据字典表，但这些表使用
存储引擎并且在启用InnoDB时不能修改。innodb_read_only同样的限制适用于任何修改数据字典表的操作，例如ANALYZE
TABLEand
。
ALTER TABLE
tbl_name
ENGINE=engine_name
另外，mysql系统数据库中的其他表使用了InnoDBMySQL 8.0中的存储引擎。将这些表设置为只读会导致对修改它们的操作的限制。例如，
CREATE USER、
GRANT、
REVOKE和
INSTALL PLUGIN操作在只读模式下是不允许的。
使用场景
这种操作模式适用于以下情况：
在只读存储介质（如 DVD 或 CD）上分发 MySQL 应用程序或一组 MySQL 数据。
多个 MySQL 实例同时查询同一数据目录，通常在数据仓库配置中。您可以使用此技术来避免
重载 MySQL 实例可能出现的
瓶颈，或者您可以对各种实例使用不同的配置选项来针对特定类型的查询调整每个实例。
查询出于安全或数据完整性原因而处于只读状态的数据，例如存档的备份数据。
笔记
此功能主要用于分发和部署的灵活性，而不是基于只读方面的原始性能。有关调整只读查询性能的方法，请参阅
第 8.5.3 节，“优化 InnoDB 只读事务”，这不需要将整个服务器设置为只读。
这个怎么运作
当服务器通过该选项以只读模式运行时
--innodb-read-only，某些InnoDB功能和组件会减少或完全关闭：
没有更改缓冲，特别是没有来自更改缓冲区的合并。为只读操作准备实例时，要确保更改缓冲区为空，请禁用更改缓冲 ( innodb_change_buffering=0) 并先进行缓慢关闭。
启动时没有崩溃恢复阶段。在进入只读状态之前，
实例必须执行缓慢关闭。
因为重做日志不用于只读操作，所以您可以
innodb_log_file_size在将实例设置为只读之前将其设置为尽可能小的大小 (1 MB)。
大多数后台线程已关闭。保留 I/O 读取线程，以及 I/O 写入线程和用于写入临时文件的页面刷新协调器线程，这在只读模式下是允许的。缓冲池大小调整线程也保持活动状态以启用缓冲池的在线大小调整。
有关死锁、监视器输出等的信息不会写入临时文件。因此，
SHOW ENGINE
INNODB STATUS不会产生任何输出。
当服务器处于只读模式时，通常会更改写操作行为的配置选项设置更改无效。
强制执行隔离级别
的MVCC处理已关闭。所有查询都读取最新版本的记录，因为更新和删除是不可能的。
未使用
撤消日志。innodb_undo_tablespaces禁用和
innodb_undo_directory
配置选项
的任何设置
。
© Mysql 中文网
