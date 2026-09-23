# A.1 MySQL 8.0 FAQ：一般_MySQL 8.0 参考手册

A.1 MySQL 8.0 FAQ：一般_MySQL 8.0 参考手册
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
A.1 MySQL 8.0 FAQ：一般
A.2 MySQL 8.0 FAQ：存储引擎
A.3 MySQL 8.0 常见问题解答：服务器 SQL 模式
A.4 MySQL 8.0 FAQ：存储过程和函数
A.5 MySQL 8.0 FAQ：触发器
A.6 MySQL 8.0 FAQ：视图
A.7 MySQL 8.0 FAQ：INFORMATION_SCHEMA
A.8 MySQL 8.0 FAQ：迁移
A.9 MySQL 8.0 FAQ：安全
A.10 MySQL 8.0 FAQ：NDB Cluster
A.11 MySQL 8.0 FAQ：MySQL 中日韩字符集
A.12 MySQL 8.0 常见问题解答：连接器和 API
A.13 MySQL 8.0 常见问题解答：C API、libmysql
A.14 MySQL 8.0 FAQ：复制
A.15 MySQL 8.0 FAQ：MySQL 企业级线程池
A.16 MySQL 8.0 FAQ：InnoDB Change Buffer
A.17 MySQL 8.0 FAQ：InnoDB 静态数据加密
A.18 MySQL 8.0 FAQ：虚拟化支持
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 附录 A MySQL 8.0 常见问题解答  /
A.1 MySQL 8.0 FAQ：一般
A.1 MySQL 8.0 FAQ：一般
A.1.1.
哪个版本的 MySQL 是生产就绪 (GA)？
A.1.2.
为什么 MySQL 版本编号会跳过版本 6 和 7 而直接进入 8.0？
A.1.3.
MySQL 8.0 可以做子查询吗？
A.1.4.
MySQL 8.0 能否实现多表插入、更新、删除？
A.1.5.
MySQL 8.0 有序列吗？
A.1.6.
MySQL 8.0 是否具有带几分之一秒的 NOW() 函数？
A.1.7.
MySQL 8.0 是否支持多核处理器？
A.1.8。
为什么我看到 mysqld 有多个进程？
A.1.9.
MySQL 8.0 可以执行 ACID 事务吗？
A.1.1.
哪个版本的 MySQL 是生产就绪 (GA)？
支持 MySQL 8.0、5.7 和 MySQL 5.6 用于生产。
MySQL 8.0 与 MySQL 8.0.11 一起获得普遍可用性 (GA) 状态，MySQL 8.0.11 于 2018 年 4 月 19 日发布用于生产用途。
MySQL 5.7 与 MySQL 5.7.9 一起获得普遍可用性 (GA) 状态，MySQL 5.7.9 于 2015 年 10 月 21 日发布用于生产用途。
MySQL 5.6 与 MySQL 5.6.10 一起获得普遍可用性 (GA) 状态，MySQL 5.6.10 于 2013 年 2 月 5 日发布用于生产用途。
MySQL 5.5 与 MySQL 5.5.8 一起获得普遍可用性 (GA) 状态，MySQL 5.5.8 于 2010 年 12 月 3 日发布用于生产用途。MySQL 5.5 的积极开发已经结束。
MySQL 5.1 与 MySQL 5.1.30 一起获得普遍可用性 (GA) 状态，MySQL 5.1.30 于 2008 年 11 月 14 日发布用于生产。MySQL 5.1 的积极开发已经结束。
MySQL 5.0 与 MySQL 5.0.15 一起获得普遍可用性 (GA) 状态，MySQL 5.0.15 于 2005 年 10 月 19 日发布用于生产。MySQL 5.0 的积极开发已经结束。
A.1.2.
为什么 MySQL 版本编号会跳过版本 6 和 7 而直接进入 8.0？
由于我们在此 MySQL 版本中引入了许多新的和重要的特性，我们决定开始一个全新的系列。由于系列号 6 和 7 之前实际上已被 MySQL 使用，因此我们使用了 8.0。
A.1.3.
MySQL 8.0 可以做子查询吗？
是的。请参阅第 13.2.11 节，“子查询”。
A.1.4.
MySQL 8.0 能否实现多表插入、更新、删除？
是的。有关执行多表更新所需的语法，请参阅第 13.2.13 节，“UPDATE 语句”；对于执行多表删除所需的，请参阅第 13.2.2 节，“DELETE 语句”。
可以使用触发器来完成多表插入，触发器的FOR EACH ROW子句
在一个块中包含多个INSERT语句
。BEGIN ... END请参阅
第 25.3 节，“使用触发器”。
A.1.5.
MySQL 8.0 有序列吗？
不可以。但是，MySQL 有一个AUTO_INCREMENT
系统，在 MySQL 8.0 中也可以处理多源复制设置中的插入。使用
auto_increment_increment和
auto_increment_offset系统变量，您可以设置每个服务器生成不与其他服务器冲突的自动增量值。该
auto_increment_increment值应该大于服务器的数量，并且每个服务器应该有一个唯一的偏移量。
A.1.6.
MySQL 8.0 是否具有
NOW()秒的小数部分的功能？
是的，请参阅第 11.2.6 节，“时间值中的小数秒”。
A.1.7.
MySQL 8.0 是否支持多核处理器？
是的。MySQL 是完全多线程的，并利用所有可用的 CPU。并非所有 CPU 都可用；现代操作系统应该能够利用所有底层 CPU，但也可以将进程限制为特定 CPU 或 CPU 集。
在 Windows 上，目前对mysqld可以使用的（逻辑）处理器的数量有限制：单个处理器组，限制为最多 64 个逻辑处理器。
可以通过以下方式看到多核的使用：
单个内核通常用于服务从一个会话发出的命令。
一些后台线程对额外核心的使用有限；例如，保持后台 I/O 任务的移动。
如果数据库受 I/O 限制（CPU 消耗小于容量），添加更多 CPU 是徒劳的。如果数据库被划分为 I/O 绑定部分和 CPU 绑定部分，添加 CPU 可能仍然有用。
A.1.8。
为什么我看到mysqld有多个进程？
mysqld是单进程程序，而不是多进程程序，并且不会派生或启动其他进程。然而， mysqld是多线程的，一些进程报告系统实用程序为多线程进程的每个线程显示单独的条目，这可能导致出现多个mysqld
进程，而实际上只有一个。
A.1.9.
MySQL 8.0 可以执行 ACID 事务吗？
是的。所有当前的 MySQL 版本都支持事务。InnoDB存储引擎提供具有行级锁定、多版本控制、非锁定可重复读取和所有四个 SQL 标准隔离级别的完整 ACID 事务
。
NDB存储引擎只支持
事务READ COMMITTED隔离级别。
© Mysql 中文网
