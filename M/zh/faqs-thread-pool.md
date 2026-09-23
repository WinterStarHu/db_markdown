# A.15 MySQL 8.0 FAQ：MySQL 企业级线程池_MySQL 8.0 参考手册

A.15 MySQL 8.0 FAQ：MySQL 企业级线程池_MySQL 8.0 参考手册
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
A.15 MySQL 8.0 FAQ：MySQL 企业级线程池
A.15 MySQL 8.0 FAQ：MySQL 企业级线程池
A.15.1。
什么是线程池，它解决什么问题？
A.15.2。
线程池如何限制和管理并发会话和事务以获得最佳性能和吞吐量？
A.15.3.
线程池与客户端连接池有何不同？
A.15.4。
什么时候应该使用线程池？
A.15.5。
是否有推荐的线程池配置？
A.15.1。
什么是线程池，它解决什么问题？
MySQL 线程池是一个 MySQL 服务器插件，它扩展了 MySQL 服务器的默认连接处理功能，以限制并发执行的语句/查询和事务的数量，以确保每个语句/查询和事务都有足够的 CPU 和内存资源来完成其任务。对于 MySQL 8.0，Thread Pool 插件包含在商业产品 MySQL Enterprise Edition 中。
MySQL 服务器中的默认线程处理模型为每个客户端连接使用一个线程来执行语句。随着越来越多的客户端连接到服务器并执行语句，整体性能会下降。线程池插件提供了另一种线程处理模型，旨在减少开销并提高性能。线程池插件通过有效管理大量客户端连接的语句执行线程来提高服务器性能，尤其是在现代多 CPU/核心系统上。
有关详细信息，请参阅第 5.6.3 节，“MySQL 企业线程池”。
A.15.2。
线程池如何限制和管理并发会话和事务以获得最佳性能和吞吐量？
线程池使用“分而治之”
的方法来限制和平衡并发。与 MySQL Server 的默认连接处理不同，线程池将连接和线程分开，因此连接和执行从这些连接接收到的语句的线程之间没有固定的关系。然后，线程池在可配置的线程组中管理客户端连接，在这些线程组中，它们根据提交要完成的工作的性质进行优先排序和排队。
有关详细信息，请参阅
第 5.6.3.3 节，“线程池操作”。
A.15.3.
线程池与客户端连接池有何不同？
MySQL 连接池运行在客户端，确保 MySQL 客户端不会不断地连接和断开 MySQL 服务器。它旨在缓存 MySQL 客户端中的空闲连接，以供其他用户在需要时使用。这最大限度地减少了在将查询提交到 MySQL 服务器时建立和断开连接的开销和费用。MySQL 连接池对后端 MySQL 服务器的查询处理能力或负载没有可见性。相比之下，线程池在 MySQL 服务器端运行，旨在管理从访问后端 MySQL 数据库的客户端连接接收到的入站并发连接和查询的执行。
通过 MySQL 连接器的 MySQL 连接池在
第 29 章，连接器和 API中介绍。
A.15.4。
什么时候应该使用线程池？
对于最佳线程池用例，需要考虑一些经验法则：
MySQLThreads_running
变量跟踪当前在 MySQL 服务器中执行的并发语句数。如果此变量持续超过服务器无法最佳运行的区域（对于 InnoDB 工作负载通常超过 40），线程池应该是有益的，尤其是在极端并行过载的情况下。
如果您使用
innodb_thread_concurrency来限制并发执行语句的数量，您应该会发现线程池通过将连接分配给线程组，然后根据事务内容、用户定义的名称等对执行进行排队来解决同样的问题，而且效果更好向前。
最后，如果您的工作负载主要包括短查询，线程池应该是有益的。
要了解更多信息，请参阅第 5.6.3.4 节，“线程池调整”。
A.15.5。
是否有推荐的线程池配置？
线程池有许多影响其性能的用户案例驱动的配置参数。要了解这些和调优技巧，请参阅第 5.6.3.4 节，“线程池调优”。
© Mysql 中文网
