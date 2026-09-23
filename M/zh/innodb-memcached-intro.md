# 15.20.2 InnoDB 内存缓存架构_MySQL 8.0 参考手册

15.20.2 InnoDB 内存缓存架构_MySQL 8.0 参考手册
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
15.20.1 InnoDB memcached 插件的好处1
15.20.2 InnoDB 内存缓存架构1
15.20.3 设置 InnoDB memcached 插件1
15.20.4 InnoDB memcached 多获取和范围查询支持1
15.20.5 InnoDB memcached 插件的安全注意事项1
15.20.6 为 InnoDB memcached 插件编写应用程序1
15.20.7 InnoDB memcached 插件和复制1
15.20.8 InnoDB memcached 插件内部1
15.20.9 InnoDB memcached 插件故障排除1
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.20 InnoDB 内存缓存插件  /
15.20.2 InnoDB 内存缓存架构
15.20.2 InnoDB 内存缓存架构
InnoDB memcached插件
将memcached实现为 MySQL 插件守护进程，它InnoDB绕过 MySQL SQL 层直接访问存储引擎。
下图说明了daemon_memcached与 SQL 相比，应用程序如何通过插件访问数据。
图 15.4 带有集成memcached服务器的 MySQL 服务器
该daemon_memcached插件的特点：
memcached作为
mysqld的守护进程插件。mysqld和
memcached都在同一个进程空间中运行，对数据的访问延迟非常低。
直接访问InnoDB表，绕过 SQL 解析器、优化器，甚至 Handler API 层。
标准memcached协议，包括基于文本的协议和二进制协议。该
插件通过了memcapable
命令
daemon_memcached的所有 55 项兼容性测试。
多列支持。您可以将多个列映射到键值存储的
“值”部分，列值由用户指定的分隔符分隔。
默认情况下，memcached协议用于直接读取和写入数据InnoDB，让 MySQL 使用
InnoDB
缓冲池管理内存缓存。默认设置代表了数据库应用程序的高可靠性和最少意外的组合。例如，默认设置避免数据库端未提交的数据，或为
memcached get请求返回的陈旧数据。
高级用户可以将系统配置为传统的
memcached服务器，所有数据仅缓存在memcached引擎（内存缓存）中，或者使用
“ memcached引擎”（内存缓存）和InnoDB
memcached引擎（InnoDB
作为后端持久化）的组合贮存）。
通过、
InnoDB和
配置选项控制数据在memcached
操作
之间来回传递的频率
。
批量大小选项默认值为 1 以获得最大可靠性。
innodb_api_bk_commit_intervaldaemon_memcached_r_batch_sizedaemon_memcached_w_batch_size
通过配置参数指定memcached选项
的能力。daemon_memcached_option例如，您可以更改memcached侦听的端口、减少同时连接的最大数量、更改键值对的最大内存大小或为错误日志启用调试消息。
配置选项控制memcached处理的查询
的innodb_api_trx_level
事务
隔离级别。虽然
memcached没有
事务的概念，但您可以使用此选项来控制
memcached多长时间才能看到由在daemon_memcached插件使用的表上发出的 SQL 语句引起的更改
。默认情况下，
设置为。
innodb_api_trx_levelREAD UNCOMMITTED
该选项可用于在 MySQL 级别锁定表，以便DDLinnodb_api_enable_mdl
无法
通过 SQL 接口删除或更改映射表。如果没有锁，表可以从 MySQL 层中删除，但会保留在存储中，直到
memcached或其他一些用户停止使用它。“ MDL ”代表“元数据锁定”。
InnoDB
InnoDB memcached 和传统 memcached 的区别
您可能已经熟悉将
memcached与 MySQL 结合使用，如将
MySQL 与memcached结合使用中所述。本节介绍集成InnoDB
memcached插件的功能与传统
memcached.
安装：memcached库随MySQL 服务器一起提供，安装和设置相对容易。安装包括运行
innodb_memcached_config.sql脚本以创建demo_test供
memcached使用的表、发出
INSTALL PLUGIN语句以启用daemon_memcached插件，以及将所需的memcached选项添加到 MySQL 配置文件或启动脚本。您可能仍会安装传统的memcached
发行版以获取其他实用程序，例如
memcp、memcat和
memcapable.
要与传统的
memcached进行比较，请参阅
安装memcached。
部署：使用传统的memcached时，通常会运行大量低容量的
memcached服务器。然而，该插件的典型部署daemon_memcached涉及少量已经运行 MySQL 的中等或高性能服务器。这种配置的好处在于提高单个数据库服务器的效率，而不是利用未使用的内存或在大量服务器之间分布查找。在默认配置中， memcached使用的内存非常少
，内存中查找由InnoDB
缓冲池提供，它会自动缓存最近和经常使用的数据。与传统的 MySQL 服务器实例一样，保持
innodb_buffer_pool_size
配置选项的值尽可能高（不会导致操作系统级别的分页），以便在内存中执行尽可能多的工作。
有关与传统
memcached的比较，请参阅
memcached部署。
Expiry：默认情况下（即使用
innodb_only缓存策略），始终返回表中的最新数据InnoDB，因此过期选项没有实际作用。如果将缓存策略更改为caching
或cache_only，过期选项将照常工作，但如果请求的数据在从内存缓存中过期之前在基础表中进行了更新，则请求的数据可能会过时。
有关与传统
memcached的比较，请参阅
数据过期。
命名空间：memcached就像一个大目录，您可以在其中为文件指定带有前缀和后缀的详细名称，以防止文件冲突。该
daemon_memcached插件允许您对键使用类似的命名约定，但增加了一个。格式中的键名
。
使用表中的映射数据被解码以引用特定的
表。在指定表中查找或写入。
@@table_id.keytable_idinnodb_memcache.containerskey
该@@表示法仅适用于对 、 和 函数的单独调用get，add但
set不适用于其他调用，例如
incr或delete。要为会话中的后续memcached操作指定默认表，
请使用带有 的符号
执行get请求
，但不包含密钥部分。例如：
@@table_idget @@table_id
后续get、set、
incr、delete等操作使用列中指定的
table_id表innodb_memcache.containers.name
。
要与传统的
memcached进行比较，请参阅
使用命名空间。
散列和分发：默认配置，使用innodb_only缓存策略，适用于所有数据在所有服务器上可用的传统部署配置，例如一组副本服务器。
如果您在物理上划分数据，如在分片配置中，您可以在运行插件的多台机器上拆分数据daemon_memcached，并使用传统的memcached哈希机制将请求路由到特定机器。在 MySQL 端，您通常会通过
对memcachedadd的请求
插入所有数据，以便将适当的值存储在适当服务器上的数据库中。
要与传统的
memcached进行比较，请参阅
memcached哈希/分布类型。
内存使用：默认情况下（使用
innodb_only缓存策略），
memcachedInnoDB协议通过表来回传递信息，InnoDB缓冲池处理内存中查找，而不是memcached内存使用量的增长和收缩。memcached端
使用的内存相对较少。
如果将缓存策略切换为
caching或，则适用memcached内存使用cache_only的正常规则。memcached数据值的内存是根据“ slabs ”分配的。您可以控制用于
memcached的 slab 大小和最大内存。
无论哪种方式，您都可以使用熟悉的统计系统
监控和排除
daemon_memcached插件
故障，通过标准协议访问
，例如，通过telnet会话。该插件不包含额外的实用程序
。您可以使用该
脚本来安装完整的memcached
发行版。
daemon_memcachedmemcached-tool
要与传统的
memcached进行比较，请参阅
memcached中的内存分配。
线程使用：MySQL 线程和memcached
线程共存于同一台服务器上。操作系统对线程施加的限制适用于线程总数。
要与传统的
memcached进行比较，请参阅
memcached线程支持。
日志使用：因为memcached守护进程与 MySQL 服务器一起运行并写入
stderr，用于记录写入输出到 MySQL
错误日志-v的、
-vv和选项。
-vvv
有关与传统
memcached的比较，请参阅
memcached日志。
memcached操作：可以使用熟悉
的memcached操作，例如
get、set、
add和delete。序列化（即表示复杂数据结构的确切字符串格式）取决于语言接口。
要与传统的
memcached进行比较，请参阅
Basic memcached Operations。
使用memcached作为 MySQL 前端：这是InnoDB
memcached插件的主要目的。集成的
memcached守护进程提高了应用程序性能，InnoDB处理内存和磁盘之间的数据传输简化了应用程序逻辑。
有关与传统
memcached的比较，请参阅
使用memcached作为 MySQL 缓存层。
实用程序：MySQL 服务器包括
libmemcached库但不包括其他命令行实用程序。要使用
memcp、memcat和
memcapable命令等命令，请安装完整的
memcached发行版。当
memrm和memflush
从缓存中删除项目时，这些项目也会从基础InnoDB表中删除。
要与传统
memcached进行比较，请参阅
libmemcached命令行实用程序。
编程接口：您可以daemon_memcached使用所有支持的语言通过插件访问 MySQL 服务器：
C 和 C++、
Java、
Perl、
Python和PHP。与传统的memcached服务器一样指定服务器主机名和端口
。默认情况下，
daemon_memcached插件侦听端口
11211。您可以同时使用
文本和二进制协议。您可以自定义
memcached
的行为在运行时运行。序列化（即表示复杂数据结构的确切字符串格式）取决于语言接口。
有关与传统
memcached的比较，请参阅
开发memcached应用程序。
常见问题解答：MySQL 有针对传统memcached的广泛常见问题解答。FAQ 大部分适用，除了使用InnoDB
表作为memcached
数据的存储介质意味着您可以将memcached用于比以前写入密集型应用程序更多，而不是作为只读缓存。
请参阅memcached常见问题解答。
© Mysql 中文网
