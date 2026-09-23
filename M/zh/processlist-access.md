# 8.14.1 访问进程列表_MySQL 8.0 参考手册

8.14.1 访问进程列表_MySQL 8.0 参考手册
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
8.14.1 访问进程列表
8.14.1 访问进程列表
下面的讨论列举了进程信息的来源、查看进程信息所需的权限，并描述了进程列表条目的内容。
过程信息来源访问进程列表所需的权限进程列表条目的内容
过程信息来源
过程信息可从以下来源获得：
SHOW PROCESSLIST
声明：
第13.7.7.29 节，“SHOW PROCESSLIST 声明”
mysqladmin processlist命令：
第4.5.2 节，“mysqladmin — 一个 MySQL 服务器管理程序”
表INFORMATION_SCHEMA
PROCESSLIST：
第 26.3.23 节，“INFORMATION_SCHEMA PROCESSLIST 表”
性能模式
processlist表：
第 27.12.21.6 节，“进程表”
名称前缀为Performance Schema
threads表列PROCESSLIST_：
第 27.12.21.7 节，“线程表”
sys架构
processlist和
session视图：
第28.4.3.22 节，“进程列表和 x$processlist 视图”，以及
第 28.4.3.33 节，“会话和 x$session 视图”
该threads表与
SHOW PROCESSLIST、
INFORMATION_SCHEMA
PROCESSLIST和
mysqladmin processlist的比较如下：
访问该threads表不需要互斥锁，并且对服务器性能的影响最小。其他来源对性能有负面影响，因为它们需要互斥量。
笔记
SHOW PROCESSLIST从 MySQL 8.0.22 开始，基于 Performance Schema
processlist表
的替代实现
是可用的，它与threads表一样不需要互斥锁，并且具有更好的性能特征。有关详细信息，请参阅
第 27.12.21.6 节，“进程列表”。
该threads表显示了后台线程，而其他来源则没有。它还为每个线程提供其他来源不提供的附加信息，例如线程是前台线程还是后台线程，以及与线程关联的服务器内的位置。这意味着该
threads表可用于监视其他来源无法监视的线程活动。
您可以启用或禁用 Performance Schema 线程监视，如
第 27.12.21.7 节，“线程表”中所述。
由于这些原因，使用其他线程信息源之一执行服务器监视的 DBA 可能希望改为使用该threads表进行监视。
sys架构
视图以更易于访问的格式processlist显示来自性能架构表的信息
。模式
视图显示有关用户会话的信息，如
threads模式视图
，但过滤掉了后台进程。
syssessionsysprocesslist
访问进程列表所需的权限
对于大多数进程信息源，如果您有
PROCESS权限，您可以看到所有线程，甚至是属于其他用户的线程。否则（没有PROCESS
特权），非匿名用户可以访问关于他们自己的线程的信息，但不能访问其他用户的线程，而匿名用户则不能访问线程信息。
Performance Schemathreads
表也提供线程信息，但表访问使用不同的权限模型。请参阅
第 27.12.21.7 节，“线程表”。
进程列表条目的内容
每个进程列表条目包含几条信息。以下列表使用SHOW PROCESSLIST
输出中的标签描述了它们。其他过程信息源使用类似的标签。
Id是与线程关联的客户端的连接标识符。
User并Host
指明与线程关联的帐户。
db是线程的默认数据库，或者NULL如果未选择任何数据库。
Command并State
指出线程正在做什么。
大多数状态对应于非常快速的操作。如果线程在给定状态下停留数秒，则可能存在需要调查的问题。
以下部分列出了可能的
Command值，以及
State按类别分组的值。其中一些值的含义是不言而喻的。对于其他人，提供了额外的描述。
笔记
检查进程列表信息的应用程序应该知道命令和状态可能会发生变化。
Time指示线程处于其当前状态的时间。在某些情况下，线程的当前时间概念可能会改变：线程可以使用 更改时间
。对于副本 SQL 线程，该值是最后一个复制事件的时间戳与副本主机的实际时间之间的秒数。请参阅
第 17.2.3 节，“复制线程”。
SET
TIMESTAMP = value
Info指示线程正在执行的语句，或者NULL它是否正在执行任何语句。对于SHOW
PROCESSLIST，此值仅包含语句的前 100 个字符。要查看完整的语句，请使用
SHOW
FULL PROCESSLIST（或查询不同的流程信息源）。
© Mysql 中文网
