# 8.6.2 MyISAM 表的批量数据加载_MySQL 8.0 参考手册

8.6.2 MyISAM 表的批量数据加载_MySQL 8.0 参考手册
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
8.6.1 优化 MyISAM 查询1
8.6.2 MyISAM 表的批量数据加载1
8.6.3 优化 REPAIR TABLE 语句1
8.7 优化 MEMORY 表
8.8 了解查询执行计划
8.9 控制查询优化器
8.10 缓冲和缓存
8.11 优化锁定操作
8.12 优化MySQL服务器
8.13 测量性能（基准测试）
8.14 查看服务器线程（进程）信息
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
MySQL 8.0 参考手册  / 第8章优化  / 8.6 优化 MyISAM 表  /
8.6.2 MyISAM 表的批量数据加载
8.6.2 MyISAM 表的批量数据加载
这些性能提示补充了第 8.2.5.1 节“优化 INSERT 语句”中快速插入的一般准则。
对于表，如果数据文件中间没有删除的行，则可以在语句运行MyISAM的同时使用并发插入来添加行
。SELECT请参阅第 8.11.3 节，“并发插入”。
通过一些额外的工作，
当表有很多索引时，可以使表LOAD DATA运行得更快。MyISAM使用以下过程：
执行FLUSH TABLES
语句或mysqladmin flush-tables命令。
使用myisamchk --keys-used=0 -rq
/path/to/db/tbl_name
删除表的所有索引使用。
插入数据到表中
LOAD DATA。这不会更新任何索引，因此非常快。
如果您以后只打算从表中读取，请使用myisampack对其进行压缩。请参阅
第 16.2.3.3 节，“压缩表特征”。
使用myisamchk -rq
/path/to/db/tbl_name
重新创建索引。这会在将索引树写入磁盘之前在内存中创建索引树，这比在此期间更新索引要快得多，LOAD DATA因为它避免了很多磁盘查找。生成的索引树也是完美平衡的。
执行FLUSH TABLES
语句或mysqladmin flush-tables命令。
LOAD DATAMyISAM如果插入数据的表为空，则自动执行上述优化
。自动优化和显式使用该过程之间的主要区别在于，您可以让
myisamchkLOAD DATA为索引创建分配比您希望服务器在执行语句
时为重新创建索引分配更多的临时内存
。MyISAM您还可以使用以下语句而不是myisamchk
来禁用或启用表的非唯一索引
。如果您使用这些语句，则可以跳过这些
FLUSH TABLES操作：
ALTER TABLE tbl_name DISABLE KEYS;
ALTER TABLE tbl_name ENABLE KEYS;
要加快INSERT对非事务性表使用多个语句执行的操作，请锁定您的表：
LOCK TABLES a WRITE;
INSERT INTO a VALUES (1,23),(2,34),(4,33);
INSERT INTO a VALUES (8,26),(6,29);
...
UNLOCK TABLES;INSERT这有利于性能，因为索引缓冲区仅在所有语句完成
后刷新到磁盘一次
。通常，索引缓冲区刷新次数与INSERT
语句数一样多。如果您可以使用单个 插入所有行，则不需要显式锁定语句
INSERT。
锁定还减少了多连接测试的总时间，尽管单个连接的最大等待时间可能会增加，因为它们等待锁定。假设五个客户端尝试同时执行插入，如下所示：
连接 1 执行 1000 次插入
连接 2、3 和 4 做 1 个插入
连接 5 执行 1000 次插入
如果不使用锁定，连接 2、3 和 4 在 1 和 5 之前完成。如果使用锁定，连接 2、3 和 4 可能不会在 1 或 5 之前完成，但总时间应该约为 40%快点。
INSERT、
UPDATE和
DELETE操作在 MySQL 中非常快，但是您可以通过在执行超过 5 次连续插入或更新的所有操作周围添加锁来获得更好的整体性能。如果您进行了很多连续的插入操作，则可以在一段时间LOCK
TABLES后执行
UNLOCK
TABLES一次操作（每 1,000 行左右）以允许其他线程访问表。这仍然会带来不错的性能提升。
INSERTLOAD
DATA即使使用刚刚概述的策略，
加载数据仍然比 慢得多。
为了提高MyISAM
表的性能，对于LOAD DATA
和INSERT，通过增加
key_buffer_size系统变量来扩大键缓存。请参阅第 5.1.1 节，“配置服务器”。
© Mysql 中文网
