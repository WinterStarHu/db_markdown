# 8.14.2 线程命令值_MySQL 8.0 参考手册

8.14.2 线程命令值_MySQL 8.0 参考手册
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
8.6 优化 MyISAM 表
8.7 优化 MEMORY 表
8.8 了解查询执行计划
8.9 控制查询优化器
8.10 缓冲和缓存
8.11 优化锁定操作
8.12 优化MySQL服务器
8.13 测量性能（基准测试）
8.14 查看服务器线程（进程）信息
8.14.1 访问进程列表1
8.14.2 线程命令值1
8.14.3 一般线程状态1
8.14.4 复制源线程状态1
8.14.5 复制 I/O（接收器）线程状态1
8.14.6 复制 SQL 线程状态1
8.14.7 复制连接线程状态1
8.14.8 NDB Cluster 线程状态1
8.14.9 事件调度器线程状态1
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
MySQL 8.0 参考手册  / 第8章优化  / 8.14 查看服务器线程（进程）信息  /
8.14.2 线程命令值
8.14.2 线程命令值
线程可以具有以下任何
Command值：
Binlog Dump
这是复制源上的一个线程，用于将二进制日志内容发送到副本。
Change user
该线程正在执行更改用户操作。
Close stmt
线程正在关闭准备好的语句。
Connect
由连接到源的复制接收器线程和复制工作线程使用。
Connect Out
副本正在连接到其源。
Create DB
该线程正在执行创建数据库操作。
Daemon
该线程在服务器内部，而不是为客户端连接提供服务的线程。
Debug
线程正在生成调试信息。
Delayed insert
该线程是延迟插入处理程序。
Drop DB
该线程正在执行删除数据库操作。
Error
Execute
线程正在执行准备好的语句。
Fetch
该线程正在获取执行准备好的语句的结果。
Field List
该线程正在检索表列的信息。
Init DB
该线程正在选择默认数据库。
Kill
该线程正在杀死另一个线程。
Long Data
线程正在检索执行准备好的语句的结果中的长数据。
Ping
该线程正在处理服务器 ping 请求。
Prepare
线程正在准备准备好的语句。
Processlist
该线程正在生成有关服务器线程的信息。
Query
在由单线程复制应用程序线程以及复制协调器线程执行查询时用于用户客户端。
Quit
线程正在终止。
Refresh
线程正在刷新表、日志或缓存，或者重置状态变量或复制服务器信息。
Register Slave
该线程正在注册副本服务器。
Reset stmt
线程正在重置准备好的语句。
Set option
线程正在设置或重置客户端语句执行选项。
Shutdown
线程正在关闭服务器。
Sleep
该线程正在等待客户端向它发送新的语句。
Statistics
该线程正在生成服务器状态信息。
Time
没用过。
© Mysql 中文网
