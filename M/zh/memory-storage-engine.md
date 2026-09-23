# 16.3 MEMORY存储引擎_MySQL 8.0 参考手册

16.3 MEMORY存储引擎_MySQL 8.0 参考手册
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
16.1 设置存储引擎
16.2 MyISAM 存储引擎
16.3 MEMORY存储引擎
16.4 CSV存储引擎
16.5 ARCHIVE存储引擎
16.6 BLACKHOLE存储引擎
16.7 MERGE存储引擎
16.8 联合存储引擎
16.9 示例存储引擎
16.10 其他存储引擎
16.11 MySQL存储引擎架构概述
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
MySQL 8.0 参考手册  / 第 16 章替代存储引擎  /
16.3 MEMORY存储引擎
16.3 MEMORY存储引擎
MEMORY存储引擎（以前称为
）创建具有存储在内存中的内容
的HEAP专用表。由于数据容易受到崩溃、硬件问题或断电的影响，因此只能将这些表用作临时工作区或从其他表中提取的数据的只读缓存。
表 16.4 MEMORY 存储引擎特性
特征
支持
B树索引
是的
备份/时间点恢复（在服务器中实现，而不是在存储引擎中。）
是的
集群数据库支持
不
聚簇索引
不
压缩数据
不
数据缓存
不适用
加密数据
是（通过加密功能在服务器中实现。）
外键支持
不
全文搜索索引
不
地理空间数据类型支持
不
地理空间索引支持
不
哈希索引
是的
索引缓存
不适用
锁定粒度
桌子
MVCC
不
复制支持（在服务器中实现，而不是在存储引擎中。）
有限（参见本节后面的讨论。）
存储限制
内存
T树索引
不
交易
不
更新数据字典的统计信息
是的
何时使用 MEMORY 或 NDB Cluster分区性能特点MEMORY表的特点MEMORY 表的 DDL 操作索引用户创建的临时表加载数据中内存表和复制管理内存使用其他资源
何时使用 MEMORY 或 NDB Cluster
希望部署使用
MEMORY存储引擎存储重要、高可用性或频繁更新数据的应用程序的开发人员应该考虑 NDB Cluster 是否是更好的选择。MEMORY引擎
的典型用例
涉及以下特征：
涉及瞬态、非关键数据的操作，例如会话管理或缓存。当 MySQL 服务器停止或重新启动时，MEMORY表中的数据会丢失。
用于快速访问和低延迟的内存存储。数据量可以完全适合内存，而不会导致操作系统换出虚拟内存页面。
只读或以读为主的数据访问模式（有限更新）。
NDB Cluster 提供与具有更高性能级别的引擎相同的功能
MEMORY，并提供不可用的附加功能
MEMORY：
行级锁定和多线程操作以降低客户端之间的争用。
可扩展性，即使是包含写入的语句混合。
可选的磁盘支持操作以实现数据持久性。
无共享架构和多主机操作，无单点故障，可实现 99.999% 的可用性。
跨节点自动分发数据；应用程序开发人员无需设计自定义分片或分区解决方案。
支持 . 不支持的可变长度数据类型（包括
BLOB和
TEXT）
MEMORY。
分区
MEMORY表不能分区。
性能特点
MEMORY性能受到单线程执行争用和处理更新时表锁开销的限制。这会在负载增加时限制可伸缩性，尤其是对于包含写入的语句混合。
尽管表在内存中处理MEMORY
，但它们不一定比
InnoDB繁忙服务器上的表、通用查询或读/写工作负载下的表更快。特别是，执行更新所涉及的表锁定会减慢MEMORY多个会话中表的并发使用。
根据对
MEMORY表执行的查询类型，您可以将索引创建为默认哈希数据结构（用于根据唯一键查找单个值）或通用 B 树数据结构（用于所有类型的涉及相等、不等或范围运算符（如小于或大于）的查询。以下部分说明了创建这两种索引的语法。一个常见的性能问题是在 B 树索引更高效的工作负载中使用默认哈希索引。
MEMORY表的特点
MEMORY存储引擎不会在磁盘上创建任何文件
。表定义存储在 MySQL 数据字典中。
MEMORY表格具有以下特点：
表的空间以MEMORY小块的形式分配。表对插入使用 100% 动态哈希。不需要溢出区域或额外的密钥空间。空闲列表不需要额外的空间。删除的行放在一个链接列表中，并在您将新数据插入表中时重新使用。
MEMORY表也​​没有通常与哈希表中的删除加插入相关的问题。
MEMORY表使用固定长度的行存储格式。可变长度类型例如
VARCHAR使用固定长度存储。
MEMORY表不能包含
BLOB或
TEXT列。
MEMORY包括对
AUTO_INCREMENT列的支持。
非TEMPORARY MEMORY
表在所有客户端之间共享，就像任何其他非TEMPORARY表一样。
MEMORY 表的 DDL 操作
要创建表，请在
语句MEMORY中指定子句
。
ENGINE=MEMORYCREATE TABLECREATE TABLE t (i INT) ENGINE = MEMORY;
如引擎名称所示，MEMORY表存储在内存中。它们默认使用散列索引，这使得它们对于单值查找非常快，并且对于创建临时表非常有用。但是，当服务器关闭时，存储在MEMORY表中的所有行都将丢失。表本身继续存在，因为它们的定义存储在 MySQL 数据字典中，但是当服务器重新启动时它们是空的。
此示例显示您可以如何创建、使用和删除
MEMORY表：
mysql> CREATE TABLE test ENGINE=MEMORY
SELECT ip,SUM(downloads) AS down
FROM log_table GROUP BY ip;
mysql> SELECT COUNT(ip),AVG(down) FROM test;
mysql> DROP TABLE test;
表的最大大小MEMORY受max_heap_table_size系统变量限制，默认值为 16MB。要对MEMORY表实施不同的大小限制，请更改此变量的值。对
CREATE TABLE或后续
ALTER TABLEor
有效TRUNCATE TABLE的值是用于表生命周期的值。服务器重新启动还会将现有MEMORY表的最大大小设置为全局
max_heap_table_size值。您可以设置单个表的大小，如本节后面所述。
索引
存储引擎同时MEMORY支持
HASH和BTREE索引。您可以通过添加子句为给定索引指定一个或另一个，
USING如下所示：
CREATE TABLE lookup
(id INT, INDEX USING HASH (id))
ENGINE = MEMORY;
CREATE TABLE lookup
(id INT, INDEX USING BTREE (id))
ENGINE = MEMORY;
对于 B 树和散列索引的一般特征，请参阅
第 8.3.1 节，“MySQL 如何使用索引”。
MEMORY每个表最多可以有 64 个索引，每个索引 16 列，最大键长度为 3072 字节。
如果MEMORY表哈希索引具有高度的键重复（许多索引条目包含相同的值），则影响键值的表更新和所有删除都会显着变慢。这种减速的程度与重复的程度成正比（或者，与索引基数成反比）。您可以使用BTREE索引来避免此问题。
MEMORY表可以有非唯一键。（对于哈希索引的实现来说，这是一个不常见的特性。）
索引的列可以包含NULL
值。
用户创建的临时表
MEMORYMEMORY表内容存储在内存中，这是表与服务器在处理查询时动态创建的内部临时表共享的属性。但是，这两种表的不同之处在于MEMORY表不受存储转换的影响，而内部临时表是：
如果内部临时表变得太大，服务器会自动将其转换为磁盘存储，如
第 8.4.4 节，“MySQL 中的内部临时表使用”中所述。
用户创建的MEMORY表永远不会转换为磁盘表。
加载数据中
要在 MySQL 服务器启动时填充MEMORY表，可以使用
init_file系统变量。例如，您可以将
INSERT INTO ...
SELECTor之类的语句LOAD DATA放入文件中以从持久数据源加载表，并用于
init_file命名文件。请参阅
第 5.1.8 节，“服务器系统变量”和
第 13.2.7 节，“加载数据语句”。
内存表和复制
当复制源服务器关闭并重新启动时，其
MEMORY表变为空。为了将这种效果复制到副本，源MEMORY在启动后第一次使用给定表时，它会记录一个事件，通知副本必须通过将该表的DELETE
or （来自 MySQL 8.0.22）TRUNCATE
TABLE语句写入到二进制日志。当副本服务器关闭并重新启动时，它的
MEMORY表也变为空，并且它向自己的二进制日志
写入一个DELETE或（从 MySQL 8.0.22 开始）语句，该日志将传递给任何下游副本。TRUNCATE TABLE
在复制拓扑中使用MEMORY表时，在某些情况下，源上的表和副本上的表可能不同。有关处理每种情况以防止过时读取或错误的信息，请参阅第 17.5.1.21 节，“复制和 MEMORY 表”。
管理内存使用
服务器需要足够的内存来维护
MEMORY同时使用的所有表。
MEMORY如果您从表中
删除单个行，则不会回收内存
。只有在删除整个表时才会回收内存。先前用于已删除行的内存将重新用于同一表中的新行。MEMORY要在不再需要表的内容时
释放表使用的所有内存，请执行DELETE或
TRUNCATE TABLE删除所有行，或者使用DROP
TABLE. 要释放已删除行使用的内存，请使用
ALTER TABLE ENGINE=MEMORY强制重建表。
表中一行所需的内存MEMORY使用以下表达式计算：
SUM_OVER_ALL_BTREE_KEYS(max_length_of_key + sizeof(char*) * 4)
+ SUM_OVER_ALL_HASH_KEYS(sizeof(char*) * 2)
+ ALIGN(length_of_row+1, sizeof(char*))
ALIGN()表示一个向上舍入因子，使行长度正好是
char指针大小的倍数。
sizeof(char*)在 32 位机器上是 4，在 64 位机器上是 8。
如前所述，
max_heap_table_size系统变量设置表的最大大小限制
MEMORY。要控制单个表的最大大小，请在创建每个表之前设置此变量的会话值。（不要更改全局
max_heap_table_size值，除非您打算将该值用于MEMORY
所有客户端创建的表。）以下示例创建两个
MEMORY表，最大大小分别为 1MB 和 2MB：
mysql> SET max_heap_table_size = 1024*1024;
Query OK, 0 rows affected (0.00 sec)
mysql> CREATE TABLE t1 (id INT, UNIQUE(id)) ENGINE = MEMORY;
Query OK, 0 rows affected (0.01 sec)
mysql> SET max_heap_table_size = 1024*1024*2;
Query OK, 0 rows affected (0.00 sec)
mysql> CREATE TABLE t2 (id INT, UNIQUE(id)) ENGINE = MEMORY;
Query OK, 0 rows affected (0.00 sec)
如果服务器重新启动，这两个表都将恢复为服务器的全局
max_heap_table_size值。
您还可以在表的语句中
指定一个MAX_ROWS表选项，
以提供有关您计划在其中存储的行数的提示。这不会使表增长超过该
值，该值仍然充当最大表大小的约束。为了能够使用 的最大灵活性，请至少将值设置
为您希望每个
表能够增长到的值。
CREATE TABLEMEMORYmax_heap_table_sizeMAX_ROWSmax_heap_table_sizeMEMORY
其他资源
专用于MEMORY存储引擎的论坛可在https://forums.mysql.com/list.php?92找到。
© Mysql 中文网
