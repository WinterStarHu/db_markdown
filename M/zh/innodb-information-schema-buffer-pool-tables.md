# 15.15.5 InnoDB INFORMATION_SCHEMA 缓冲池表_MySQL 8.0 参考手册

15.15.5 InnoDB INFORMATION_SCHEMA 缓冲池表_MySQL 8.0 参考手册
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
15.15.1 InnoDB INFORMATION_SCHEMA 表压缩1
15.15.2 InnoDB INFORMATION_SCHEMA 事务和锁定信息1
15.15.3 InnoDB INFORMATION_SCHEMA 模式对象表1
15.15.4 InnoDB INFORMATION_SCHEMA FULLTEXT 索引表1
15.15.5 InnoDB INFORMATION_SCHEMA 缓冲池表1
15.15.6 InnoDB INFORMATION_SCHEMA 指标表1
15.15.7 InnoDB INFORMATION_SCHEMA临时表信息表1
15.15.8 从 INFORMATION_SCHEMA.FILES 检索 InnoDB 表空间元数据1
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.15 InnoDB INFORMATION_SCHEMA 表  /
15.15.5 InnoDB INFORMATION_SCHEMA 缓冲池表
15.15.5 InnoDB INFORMATION_SCHEMA 缓冲池表
InnoDB
INFORMATION_SCHEMA缓冲池表提供缓冲池状态信息和有关缓冲池内页面的元
数据InnoDB。
InnoDB
INFORMATION_SCHEMA缓冲池表包括下面列出的那些
：mysql> SHOW TABLES FROM INFORMATION_SCHEMA LIKE 'INNODB_BUFFER%';
+-----------------------------------------------+
| Tables_in_INFORMATION_SCHEMA (INNODB_BUFFER%) |
+-----------------------------------------------+
| INNODB_BUFFER_PAGE_LRU                        |
| INNODB_BUFFER_PAGE                            |
| INNODB_BUFFER_POOL_STATS                      |
+-----------------------------------------------+
表格概览
INNODB_BUFFER_PAGE：保存有关InnoDB
缓冲池中每个页面的信息。
INNODB_BUFFER_PAGE_LRU：保存有关InnoDB
缓冲池中页面的信息，特别是它们在 LRU 列表中的排序方式，该列表确定缓冲池变满时要从缓冲池中逐出哪些页面。该
INNODB_BUFFER_PAGE_LRU表与表的列相同
INNODB_BUFFER_PAGE，只是INNODB_BUFFER_PAGE_LRU
表有LRU_POSITION列而不是BLOCK_ID列。
INNODB_BUFFER_POOL_STATS：提供缓冲池状态信息。许多相同的信息由
SHOW ENGINE
INNODB STATUS输出提供，或者可以使用
InnoDB缓冲池服务器状态变量获得。
警告
查询INNODB_BUFFER_PAGE或
INNODB_BUFFER_PAGE_LRU表会影响性能。不要在生产系统上查询这些表，除非您了解性能影响并确定它是可以接受的。为避免影响生产系统的性能，请重现您要调查的问题并在测试实例上查询缓冲池统计信息。
示例 15.6 在 INNODB_BUFFER_PAGE 表中查询系统数据
TABLE_NAME此查询通过排除值是
NULL或在表名称中包含斜杠/
或句.点（表示用户定义的表
）的页面来提供包含系统数据的页面的近似计数
。mysql> SELECT COUNT(*) FROM INFORMATION_SCHEMA.INNODB_BUFFER_PAGE
WHERE TABLE_NAME IS NULL OR (INSTR(TABLE_NAME, '/') = 0 AND INSTR(TABLE_NAME, '.') = 0);
+----------+
| COUNT(*) |
+----------+
|     1516 |
+----------+
此查询返回包含系统数据的页面的大致数量、缓冲池页面的总数以及包含系统数据的页面的大致百分比。
mysql> SELECT
(SELECT COUNT(*) FROM INFORMATION_SCHEMA.INNODB_BUFFER_PAGE
WHERE TABLE_NAME IS NULL OR (INSTR(TABLE_NAME, '/') = 0 AND INSTR(TABLE_NAME, '.') = 0)
) AS system_pages,
(
SELECT COUNT(*)
FROM INFORMATION_SCHEMA.INNODB_BUFFER_PAGE
) AS total_pages,
(
SELECT ROUND((system_pages/total_pages) * 100)
) AS system_page_percentage;
+--------------+-------------+------------------------+
| system_pages | total_pages | system_page_percentage |
+--------------+-------------+------------------------+
|          295 |        8192 |                      4 |
+--------------+-------------+------------------------+PAGE_TYPE通过查询该值
可以确定缓冲池中系统数据的类型。例如，以下查询
PAGE_TYPE在包含系统数据的页面中返回八个不同的值：
mysql> SELECT DISTINCT PAGE_TYPE FROM INFORMATION_SCHEMA.INNODB_BUFFER_PAGE
WHERE TABLE_NAME IS NULL OR (INSTR(TABLE_NAME, '/') = 0 AND INSTR(TABLE_NAME, '.') = 0);
+-------------------+
| PAGE_TYPE         |
+-------------------+
| SYSTEM            |
| IBUF_BITMAP       |
| UNKNOWN           |
| FILE_SPACE_HEADER |
| INODE             |
| UNDO_LOG          |
| ALLOCATED         |
+-------------------+
示例 15.7 查询 INNODB_BUFFER_PAGE 表中的用户数据
TABLE_NAME此查询通过计算值为NOT
NULL和
的页面来提供包含用户数据的页面的近似计数
NOT LIKE
'%INNODB_TABLES%'。
mysql> SELECT COUNT(*) FROM INFORMATION_SCHEMA.INNODB_BUFFER_PAGE
WHERE TABLE_NAME IS NOT NULL AND TABLE_NAME NOT LIKE '%INNODB_TABLES%';
+----------+
| COUNT(*) |
+----------+
|     7897 |
+----------+
此查询返回包含用户数据的页面的大致数量、缓冲池页面的总数以及包含用户数据的页面的大致百分比。
mysql> SELECT
(SELECT COUNT(*) FROM INFORMATION_SCHEMA.INNODB_BUFFER_PAGE
WHERE TABLE_NAME IS NOT NULL AND (INSTR(TABLE_NAME, '/') > 0 OR INSTR(TABLE_NAME, '.') > 0)
) AS user_pages,
(
SELECT COUNT(*)
FROM information_schema.INNODB_BUFFER_PAGE
) AS total_pages,
(
SELECT ROUND((user_pages/total_pages) * 100)
) AS user_page_percentage;
+------------+-------------+----------------------+
| user_pages | total_pages | user_page_percentage |
+------------+-------------+----------------------+
|       7897 |        8192 |                   96 |
+------------+-------------+----------------------+
此查询标识具有缓冲池中页面的用户定义表：
mysql> SELECT DISTINCT TABLE_NAME FROM INFORMATION_SCHEMA.INNODB_BUFFER_PAGE
WHERE TABLE_NAME IS NOT NULL AND (INSTR(TABLE_NAME, '/') > 0 OR INSTR(TABLE_NAME, '.') > 0)
AND TABLE_NAME NOT LIKE '`mysql`.`innodb_%';
+-------------------------+
| TABLE_NAME              |
+-------------------------+
| `employees`.`salaries`  |
| `employees`.`employees` |
+-------------------------+
示例 15.8 查询 INNODB_BUFFER_PAGE 表中的索引数据
有关索引页的信息，请
INDEX_NAME使用索引名称查询列。emp_no例如，以下查询返回表中定义
的索引的页数和页的总数据大小
employees.salaries：
mysql> SELECT INDEX_NAME, COUNT(*) AS Pages,
ROUND(SUM(IF(COMPRESSED_SIZE = 0, @@GLOBAL.innodb_page_size, COMPRESSED_SIZE))/1024/1024)
AS 'Total Data (MB)'
FROM INFORMATION_SCHEMA.INNODB_BUFFER_PAGE
WHERE INDEX_NAME='emp_no' AND TABLE_NAME = '`employees`.`salaries`';
+------------+-------+-----------------+
| INDEX_NAME | Pages | Total Data (MB) |
+------------+-------+-----------------+
| emp_no     |  1609 |              25 |
+------------+-------+-----------------+
此查询返回表上定义的所有索引的页数和页的总数据大小
employees.salaries：
mysql> SELECT INDEX_NAME, COUNT(*) AS Pages,
ROUND(SUM(IF(COMPRESSED_SIZE = 0, @@GLOBAL.innodb_page_size, COMPRESSED_SIZE))/1024/1024)
AS 'Total Data (MB)'
FROM INFORMATION_SCHEMA.INNODB_BUFFER_PAGE
WHERE TABLE_NAME = '`employees`.`salaries`'
GROUP BY INDEX_NAME;
+------------+-------+-----------------+
| INDEX_NAME | Pages | Total Data (MB) |
+------------+-------+-----------------+
| emp_no     |  1608 |              25 |
| PRIMARY    |  6086 |              95 |
+------------+-------+-----------------+
示例 15.9 查询 INNODB_BUFFER_PAGE_LRU 表中的 LRU_POSITION 数据
该INNODB_BUFFER_PAGE_LRU表包含有关
InnoDB缓冲池中页面的信息，特别是它们的排序方式决定了当缓冲池变满时要从缓冲池中逐出哪些页面。此页面的定义与 for 相同INNODB_BUFFER_PAGE，只是此表有一个LRU_POSITION列而不是一个BLOCK_ID列。
该查询统计表的页面在 LRU 列表中特定位置的位置数
employees.employees。
mysql> SELECT COUNT(LRU_POSITION) FROM INFORMATION_SCHEMA.INNODB_BUFFER_PAGE_LRU
WHERE TABLE_NAME='`employees`.`employees`' AND LRU_POSITION < 3072;
+---------------------+
| COUNT(LRU_POSITION) |
+---------------------+
|                 548 |
+---------------------+
示例 15.10 查询 INNODB_BUFFER_POOL_STATS 表
该INNODB_BUFFER_POOL_STATS表提供类似于
缓冲池状态变量
SHOW ENGINE INNODB
STATUS的信息。InnoDBmysql> SELECT * FROM information_schema.INNODB_BUFFER_POOL_STATS \G
*************************** 1. row ***************************
POOL_ID: 0
POOL_SIZE: 8192
FREE_BUFFERS: 1
DATABASE_PAGES: 8173
OLD_DATABASE_PAGES: 3014
MODIFIED_DATABASE_PAGES: 0
PENDING_DECOMPRESS: 0
PENDING_READS: 0
PENDING_FLUSH_LRU: 0
PENDING_FLUSH_LIST: 0
PAGES_MADE_YOUNG: 15907
PAGES_NOT_MADE_YOUNG: 3803101
PAGES_MADE_YOUNG_RATE: 0
PAGES_MADE_NOT_YOUNG_RATE: 0
NUMBER_PAGES_READ: 3270
NUMBER_PAGES_CREATED: 13176
NUMBER_PAGES_WRITTEN: 15109
PAGES_READ_RATE: 0
PAGES_CREATE_RATE: 0
PAGES_WRITTEN_RATE: 0
NUMBER_PAGES_GET: 33069332
HIT_RATE: 0
YOUNG_MAKE_PER_THOUSAND_GETS: 0
NOT_YOUNG_MAKE_PER_THOUSAND_GETS: 0
NUMBER_PAGES_READ_AHEAD: 2713
NUMBER_READ_AHEAD_EVICTED: 0
READ_AHEAD_RATE: 0
READ_AHEAD_EVICTED_RATE: 0
LRU_IO_TOTAL: 0
LRU_IO_CURRENT: 0
UNCOMPRESS_TOTAL: 0
UNCOMPRESS_CURRENT: 0
为了进行比较，
SHOW ENGINE INNODB
STATUS输出和InnoDB缓冲池状态变量输出如下所示，基于相同的数据集。
有关
SHOW ENGINE INNODB
STATUS输出的更多信息，请参阅
第 15.17.3 节，“InnoDB 标准监视器和锁定监视器输出”。
mysql> SHOW ENGINE INNODB STATUS \G
...
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 137428992
Dictionary memory allocated 579084
Buffer pool size   8192
Free buffers       1
Database pages     8173
Old database pages 3014
Modified db pages  0
Pending reads 0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 15907, not young 3803101
0.00 youngs/s, 0.00 non-youngs/s
Pages read 3270, created 13176, written 15109
0.00 reads/s, 0.00 creates/s, 0.00 writes/s
No buffer pool page gets since the last printout
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 8173, unzip_LRU len: 0
I/O sum[0]:cur[0], unzip sum[0]:cur[0]
...
有关状态变量的描述，请参阅
第 5.1.10 节，“服务器状态变量”。
mysql> SHOW STATUS LIKE 'Innodb_buffer%';
+---------------------------------------+-------------+
| Variable_name                         | Value       |
+---------------------------------------+-------------+
| Innodb_buffer_pool_dump_status        | not started |
| Innodb_buffer_pool_load_status        | not started |
| Innodb_buffer_pool_resize_status      | not started |
| Innodb_buffer_pool_pages_data         | 8173        |
| Innodb_buffer_pool_bytes_data         | 133906432   |
| Innodb_buffer_pool_pages_dirty        | 0           |
| Innodb_buffer_pool_bytes_dirty        | 0           |
| Innodb_buffer_pool_pages_flushed      | 15109       |
| Innodb_buffer_pool_pages_free         | 1           |
| Innodb_buffer_pool_pages_misc         | 18          |
| Innodb_buffer_pool_pages_total        | 8192        |
| Innodb_buffer_pool_read_ahead_rnd     | 0           |
| Innodb_buffer_pool_read_ahead         | 2713        |
| Innodb_buffer_pool_read_ahead_evicted | 0           |
| Innodb_buffer_pool_read_requests      | 33069332    |
| Innodb_buffer_pool_reads              | 558         |
| Innodb_buffer_pool_wait_free          | 0           |
| Innodb_buffer_pool_write_requests     | 11985961    |
+---------------------------------------+-------------+
© Mysql 中文网
