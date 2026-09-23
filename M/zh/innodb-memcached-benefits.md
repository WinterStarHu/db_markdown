# 15.20.1 InnoDB memcached 插件的好处_MySQL 8.0 参考手册

15.20.1 InnoDB memcached 插件的好处_MySQL 8.0 参考手册
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
15.20.1 InnoDB memcached 插件的好处
15.20.1 InnoDB memcached 插件的好处
本节概述了
daemon_memcached插件的优点。InnoDB表和memcached的组合
提供了优于单独使用它们的优势。
直接访问InnoDB存储引擎，避免了SQL的解析和规划开销。
在与 MySQL 服务器相同的进程空间中运行memcached避免了来回传递请求的网络开销。
使用memcached协议写入的数据是透明写入InnoDB
表的，不经过 MySQL SQL 层。您可以控制写入频率，以在更新非关键数据时实现更高的原始性能。
通过memcached协议
请求的数据
是透明地从
InnoDB表中查询的，无需通过 MySQL SQL 层。
对相同数据的后续请求由
InnoDB缓冲池提供。缓冲池处理内存缓存。InnoDB
您可以使用配置选项
调整数据密集型操作的性能。
数据可以是非结构化的或结构化的，具体取决于应用程序的类型。您可以为数据创建新表，或使用现有表。
InnoDB可以处理将多个列值组合和分解为单个
memcached项值，从而减少应用程序中所需的字符串解析和连接量。例如，您可以将字符串值存储
2|4|6|8在memcached
缓存中，并InnoDB根据分隔符拆分该值，然后将结果存储在四个数字列中。
内存和磁盘之间的传输是自动处理的，简化了应用程序逻辑。
数据存储在 MySQL 数据库中，以防止崩溃、中断和损坏。
您可以通过 SQL 访问底层InnoDB表，以进行报告、分析、即席查询、批量加载、多步事务计算、并集和交集等集合操作，以及其他适合 SQL 的表现力和灵活性的操作。
daemon_memcached您可以通过将源服务器上的插件与 MySQL 复制结合
使用来确保高可用性
。
memcached与 MySQL
的集成提供了一种使内存中数据持久化的方法，因此您可以将其用于更重要的数据类型。您可以在应用程序中使用 more
add、incr和类似的写入操作，而不必担心数据可能会丢失。您可以停止和启动
memcached服务器而不会丢失对缓存数据所做的更新。为防止意外中断，您可以利用InnoDB崩溃恢复、复制和备份功能。
InnoDB快速
主键查找
的方式非常适合memcached单项查询。插件使用的直接、低级数据库访问路径daemon_memcached对于键值查找比等效的 SQL 查询更有效。
memcached
的序列化功能可以将复杂的数据结构、二进制文件甚至代码块转换为可存储的字符串，提供了一种将此类对象放入数据库的简单方法。
因为可以通过 SQL 访问底层数据，所以可以生成报告，跨多个键搜索或更新，以及调用memcached数据上的AVG()和
MAX()等函数。使用memcached本身，
所有这些操作都非常昂贵或复杂
。
您不需要在启动时手动将数据加载到
memcached中。当应用程序请求特定键时，会自动从数据库中检索值，并使用
InnoDB
缓冲池将其缓存在内存中。
因为memcached消耗的 CPU 相对较少，而且它的内存占用很容易控制，所以它可以在同一系统上与 MySQL 实例一起舒适地运行。
因为数据一致性是由用于常规InnoDB表的机制强制执行的，所以您不必担心过时的memcached数据或在缺少键的情况下查询数据库的回退逻辑。
© Mysql 中文网
