# 8.4.4 MySQL内部临时表的使用_MySQL 8.0 参考手册

8.4.4 MySQL内部临时表的使用_MySQL 8.0 参考手册
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
8.4.1 优化数据大小1
8.4.2 优化MySQL数据类型1
8.4.3 优化多表1
8.4.4 MySQL内部临时表的使用1
8.4.5 数据库和表的数量限制1
8.4.6 表大小限制1
8.4.7 表列数和行大小的限制1
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
MySQL 8.0 参考手册  / 第8章优化  / 8.4 优化数据库结构  /
8.4.4 MySQL内部临时表的使用
8.4.4 MySQL内部临时表的使用
在某些情况下，服务器在处理语句时创建内部临时表。用户无法直接控制何时发生这种情况。
服务器在以下条件下创建临时表：
UNION
语句的
评估，有一些例外情况将在后面描述。
评估某些视图，例如使用
TEMPTABLE算法
UNION、 或聚合的视图。
派生表的评估（请参阅
第 13.2.11.8 节，“派生表”）。
公用表表达式的评估（请参阅
第 13.2.15 节，“WITH（公用表表达式）”）。
为子查询或半连接具体化创建的表（请参阅
第 8.2.2 节，“优化子查询、派生表、视图引用和公用表表达式”）。
评估包含ORDER
BY子句和不同GROUP
BY子句的语句，ORDER
BY或GROUP BY包含连接队列中第一个表以外的表的列的语句。
DISTINCT结合
评估ORDER BY可能需要一个临时表。
对于使用SQL_SMALL_RESULT
修饰符的查询，MySQL 使用内存中的临时表，除非查询还包含需要磁盘存储的元素（稍后描述）。
为了评估
INSERT ...
SELECT从同一个表中选择并插入到同一个表中的语句，MySQL 创建一个内部临时表来保存来自 的行
SELECT，然后将这些行插入到目标表中。请参阅
第 13.2.6.1 节，“INSERT ... SELECT 语句”。
多表
UPDATE语句的评估。
GROUP_CONCAT()
或COUNT(DISTINCT)
表达式
的评估。
窗口函数的评估（请参阅
第 12.21 节，“窗口函数”）根据需要使用临时表。
要确定语句是否需要临时表，请使用
EXPLAIN并检查该
Extra列以查看它是否表示
Using temporary（请参阅
第 8.8.1 节，“使用 EXPLAIN 优化查询”）。EXPLAIN
不一定说Using temporary派生或具体化的临时表。对于使用窗口函数的语句，EXPLAIN
withFORMAT=JSON始终提供有关窗口化步骤的信息。如果窗口函数使用临时表，则会为每个步骤指明。
某些查询条件会阻止使用内存中的临时表，在这种情况下，服务器会改用磁盘上的表：
表中存在一个BLOB或
TEXT列。但是，TempTable存储引擎是 MySQL 8.0 中内存内部临时表的默认存储引擎，从 MySQL 8.0.13 开始支持二进制大对象类型。请参阅
内部临时表存储引擎。
如果使用或
SELECT，则列表中
存在最大长度大于 512（二进制字符串为字节，非二进制字符串为字符）的任何字符串列
。
UNIONUNION ALLSHOW COLUMNSand
DESCRIBE语句
用作某些列
的BLOB类型，因此用于结果的临时表是磁盘表。
服务器不会为
UNION满足特定条件的语句使用临时表。相反，它从临时表创建中仅保留执行结果列类型转换所需的数据结构。该表未完全实例化，也没有向其中写入或读取任何行；行直接发送给客户端。结果是减少了内存和磁盘需求，并且第一行发送到客户端之前的延迟更小，因为服务器不需要等到最后一个查询块被执行。EXPLAIN优化器跟踪输出反映了这种执行策略：
UNION RESULT查询块不存在，因为该块对应于从临时表读取的部分。
这些条件有资格在UNION没有临时表的情况下进行评估：
工会是UNION ALL，不是
UNION或UNION
DISTINCT。
没有全局ORDER BY条款。
联合不是语句的顶级查询块
{INSERT | REPLACE} ... SELECT ...
。
内部临时表存储引擎
内部临时表可以保存在内存中并由存储引擎TempTable或
MEMORY存储引擎处理，或者由存储引擎存储在磁盘上InnoDB。
内存内部临时表的存储引擎
该
internal_tmp_mem_storage_engine
变量定义用于内存内部临时表的存储引擎。允许的值为
TempTable（默认值）和
MEMORY.
笔记
从 MySQL 8.0.27 开始，配置会话设置
internal_tmp_mem_storage_engine
需要
SESSION_VARIABLES_ADMIN或
SYSTEM_VARIABLES_ADMIN
权限。
从MySQL 8.0.13 开始，TempTable存储引擎为VARCHAR
和VARBINARY列以及其他二进制大对象类型提供高效存储。
以下变量控制 TempTable 存储引擎限制和行为：
tmp_table_size：从 MySQL 8.0.28 开始，
tmp_table_size定义了由 TempTable 存储引擎创建的任何单个内存内部临时表的最大大小。当tmp_table_size
达到限制时，MySQL 自动将内存内部临时表转换为
InnoDB磁盘内部临时表。默认
tmp_table_size设置为 16777216 字节 (16 MiB)。
该tmp_table_size限制旨在防止单个查询消耗过多的全局 TempTable 资源，这可能会影响需要 TempTable 资源的并发查询的性能。全局 TempTable 资源由
temptable_max_ram和
temptable_max_mmap
设置控制。
如果tmp_table_size
限制小于
temptable_max_ram限制，内存临时表不可能包含超过
tmp_table_size限制允许的数据。如果tmp_table_size限制大于限制之
temptable_max_ram和
temptable_max_mmap
，则内存临时表不可能包含超过限制之
temptable_max_ram和
的内容temptable_max_mmap
。
temptable_max_ramTempTable：定义存储引擎在开始从内存映射文件分配空间之前或在 MySQL 开始使用磁盘内部临时表之前可以使用的最大 RAM 量
InnoDB，具体取决于您的配置。默认
temptable_max_ram设置为 1073741824 字节 (1GiB)。
笔记
该temptable_max_ram
设置不考虑分配给使用
TempTable存储引擎的每个线程的线程本地内存块。线程本地内存块的大小取决于线程的第一个内存分配请求的大小。如果请求小于 1MB（大多数情况下是这样），则线程本地内存块大小为 1MB。如果请求大于 1MB，则线程本地内存块的大小与初始内存请求的大小大致相同。线程本地内存块保存在线程本地存储中，直到线程退出。
temptable_use_mmap：控制TempTable存储引擎是否从内存映射文件分配空间或 MySQL在超过限制InnoDB时使用磁盘内部临时表
temptable_max_ram。默认设置为
temptable_use_mmap=ON。
笔记
该temptable_use_mmap
变量在 MySQL 8.0.16 中引入，在 MySQL 8.0.26 中弃用；希望在未来版本的 MySQL 中删除对它的支持。设置
temptable_max_mmap=0等同于设置
temptable_use_mmap=OFF。
temptable_max_mmap: 在 MySQL 8.0.23 中引入。InnoDB定义在 MySQL 开始使用磁盘内部临时表之前，允许 TempTable 存储引擎从内存映射文件分配的最大内存量。默认设置为 1073741824 字节 (1GiB)。tmpdir该限制旨在解决内存映射文件在临时目录 ( )中使用过多空间的风险。无论设置如何，设置都会禁用内存映射文件的
temptable_max_mmap=0
分配，从而有效地禁用它们的使用
temptable_use_mmap
。
存储引擎对内存映射文件的使用TempTable
受以下规则约束：
临时文件在tmpdir变量定义的目录中创建。
临时文件在创建和打开后立即被删除，因此不会在tmpdir目录中保持可见。临时文件占用的空间在临时文件打开时由操作系统保留。TempTable当存储引擎
关闭临时文件
或mysqld进程关闭时，空间将被回收。
数据永远不会在 RAM 和临时文件之间、RAM 内或临时文件之间移动。
如果空间在定义的限制内可用，则新数据将存储在 RAM 中
temptable_max_ram。否则，新数据将存储在临时文件中。
如果在将表的一些数据写入临时文件后 RAM 中有可用空间，则可以将剩余的表数据存储在 RAM 中。
当使用MEMORY内存临时表 ( ) 的存储引擎时，如果internal_tmp_mem_storage_engine=MEMORY内存临时表变得太大，MySQL 会自动将内存临时表转换为磁盘表。内存中临时表的最大大小由
tmp_table_size或
max_heap_table_size值定义，以较小者为准。这不同于使用
MEMORY显式创建的表
CREATE TABLE。对于此类表，只有max_heap_table_size
变量决定了表可以增长到多大，并且没有转换为磁盘格式。
磁盘内部临时表的存储引擎
在 MySQL 8.0.15 及更早版本中，该
internal_tmp_disk_storage_engine
变量定义了用于磁盘内部临时表的存储引擎。支持的存储引擎是
InnoDB和MyISAM。
从 MySQL 8.0.16 开始，MySQL 只使用
InnoDB磁盘内部临时表的存储引擎。MYISAM为此，不再支持存储引擎
。
InnoDB默认情况下，磁盘内部临时表是在驻留在数据目录中的会话临时表空间中创建的。有关详细信息，请参阅
第 15.6.3.5 节，“临时表空间”。
在 MySQL 8.0.15 及更早版本中：
对于公用表表达式 (CTE)，用于磁盘内部临时表的存储引擎不能是
MyISAM. 如果
internal_tmp_disk_storage_engine=MYISAM，则任何使用磁盘临时表实现 CTE 的尝试都会出错。
使用
internal_tmp_disk_storage_engine=INNODB时，生成超过InnoDB行或列限制的磁盘内部临时表的查询会返回行大小太大或
列太多错误。解决方法是设置
internal_tmp_disk_storage_engine
为MYISAM.
内部临时表存储格式
当内存内部临时表由
TempTable存储引擎管理时，包含
VARCHAR列、
VARBINARY列和其他二进制大对象类型列（从 MySQL 8.0.13 开始支持）的行在内存中由单元格数组表示，每个单元格包含 NULL 标志、数据长度和数据指针。列值在数组之后按连续顺序放置在单个内存区域中，没有填充。数组中的每个单元格使用 16 个字节的存储空间。当TempTable存储引擎从内存映射文件分配空间时，同样的存储格式适用。
当内存内部临时表由
MEMORY存储引擎管理时，使用固定长度的行格式。VARCHAR和
VARBINARY列值被填充到最大列长度，实际上将它们存储为
CHAR和BINARY列。
在 MySQL 8.0.16 之前，磁盘内部临时表由InnoDB或
MyISAM存储引擎管理（取决于
internal_tmp_disk_storage_engine
设置）。两个引擎都使用动态宽度行格式存储内部临时表。列只占用所需的存储空间，与使用固定长度行的磁盘表相比，这减少了磁盘 I/O、空间需求和处理时间。从 MySQL 8.0.16 开始，
internal_tmp_disk_storage_engine
不支持，磁盘上的内部临时表始终由InnoDB.
使用MEMORY存储引擎时，语句最初可以在内存中创建一个内部临时表，然后在表变得太大时将其转换为磁盘表。在这种情况下，可以通过跳过转换并首先在磁盘上创建内部临时表来实现更好的性能。该
big_tables变量可用于强制内部临时表的磁盘存储。
监控内部临时表创建
当在内存或磁盘上创建内部临时表时，服务器会递增该
Created_tmp_tables值。在磁盘上创建内部临时表时，服务器会递增该
Created_tmp_disk_tables
值。如果在磁盘上创建了太多内部临时表，请考虑调整内部临时表存储引擎中描述的特定于引擎的限制。
笔记
由于已知限制，
Created_tmp_disk_tables
不计算在内存映射文件中创建的磁盘临时表。默认情况下，TempTable 存储引擎溢出机制会在内存映射文件中创建内部临时表。请参阅
内部临时表存储引擎。
和Performance Schema 工具可用于监视
内存memory/temptable/physical_ram和
磁盘的空间分配。报告分配的 RAM 数量。
报告当内存映射文件用作 TempTable 溢出机制时从磁盘分配的空间量。如果
仪器报告的值不是 0，并且内存映射文件用作 TempTable 溢出机制，则在某个时间点达到了 TempTable 内存限制。可以在 Performance Schema 内存汇总表中查询数据，例如
. 请参阅
第 27.12.20.10 节，“内存汇总表”。
memory/temptable/physical_diskTempTablememory/temptable/physical_rammemory/temptable/physical_diskphysical_diskmemory_summary_global_by_event_name
© Mysql 中文网
