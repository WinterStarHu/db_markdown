# 23.5.9 ndb_desc — 描述 NDB 表_MySQL 8.0 参考手册

23.5.9 ndb_desc — 描述 NDB 表_MySQL 8.0 参考手册
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
23.1 一般信息
23.2 NDB Cluster 概述
23.3 NDB Cluster 安装
23.4 NDB Cluster的配置
23.5 NDB 集群程序
23.5.1 ndbd — NDB Cluster 数据节点守护进程1
23.5.2 ndbinfo_select_all — 从 ndbinfo 表中选择1
23.5.3 ndbmtd — NDB Cluster 数据节点守护进程（多线程）1
23.5.4 ndb_mgmd — NDB 集群管理服务器守护进程1
23.5.5 ndb_mgm — NDB 集群管理客户端1
23.5.6 ndb_blob_tool — 检查和修复 NDB 集群表的 BLOB 和 TEXT 列1
23.5.7 ndb_config — 提取 NDB Cluster 配置信息1
23.5.8 ndb_delete_all — 从 NDB 表中删除所有行1
23.5.9 ndb_desc — 描述 NDB 表1
23.5.10 ndb_drop_index — 从 NDB 表中删除索引1
23.5.11 ndb_drop_table — 删除 NDB 表1
23.5.12 ndb_error_reporter — NDB 错误报告实用程序1
23.5.13 ndb_import — 将 CSV 数据导入 NDB1
23.5.14 ndb_index_stat — NDB 索引统计实用程序1
23.5.15 ndb_move_data — NDB 数据复制实用程序1
23.5.16 ndb_perror — 获取 NDB 错误消息信息1
23.5.17 ndb_print_backup_file — 打印 NDB 备份文件内容1
23.5.18 ndb_print_file — 打印 NDB 磁盘数据文件内容1
23.5.19 ndb_print_frag_file — 打印 NDB 片段列表文件内容1
23.5.20 ndb_print_schema_file — 打印 NDB 模式文件内容1
23.5.21 ndb_print_sys_file — 打印 NDB 系统文件内容1
23.5.22 ndb_redo_log_reader - 检查和打印集群重做日志的内容1
23.5.23 ndb_restore — 恢复 NDB Cluster 备份1
23.5.24 ndb_secretsfile_reader — 从加密的 NDB 数据文件中获取密钥信息1
23.5.25 ndb_select_all — 从 NDB 表打印行1
23.5.26 ndb_select_count — 打印 NDB 表的行数1
23.5.27 ndb_show_tables — 显示 NDB 表列表1
23.5.28 ndb_size.pl — NDBCLUSTER 大小需求估计器1
23.5.29 ndb_top — 查看 NDB 线程的 CPU 使用信息1
23.5.30 ndb_waiter — 等待 NDB Cluster 达到给定状态1
23.5.31 ndbxfrm — 压缩、解压缩、加密和解密 NDB Cluster 创建的文件1
23.6 NDB Cluster的管理
23.7 NDB 集群复制
23.8 NDB Cluster 发行说明
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.5 NDB 集群程序  /
23.5.9 ndb_desc — 描述 NDB 表
23.5.9 ndb_desc — 描述 NDB 表
ndb_desc提供一个或多个NDB表的详细描述。
用法
ndb_desc -c connection_string tbl_name -d db_name [options]
ndb_desc -c connection_string index_name -d db_name -t tbl_name本节后面列出
了可以与
ndb_desc一起使用的其他选项。
示例输出
MySQL建表和填充语句：
USE test;
CREATE TABLE fish (
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(20) NOT NULL,
length_mm INT NOT NULL,
weight_gm INT NOT NULL,
PRIMARY KEY pk (id),
UNIQUE KEY uk (name)
) ENGINE=NDB;
INSERT INTO fish VALUES
(NULL, 'guppy', 35, 2), (NULL, 'tuna', 2500, 150000),
(NULL, 'shark', 3000, 110000), (NULL, 'manta ray', 1500, 50000),
(NULL, 'grouper', 900, 125000), (NULL ,'puffer', 250, 2500);
来自ndb_desc的输出：
$> ./ndb_desc -c localhost fish -d test -p
-- fish --
Version: 2
Fragment type: HashMapPartition
K Value: 6
Min load factor: 78
Max load factor: 80
Temporary table: no
Number of attributes: 4
Number of primary keys: 1
Length of frm data: 337
Max Rows: 0
Row Checksum: 1
Row GCI: 1
SingleUserMode: 0
ForceVarPart: 1
PartitionCount: 2
FragmentCount: 2
PartitionBalance: FOR_RP_BY_LDM
ExtraRowGciBits: 0
ExtraRowAuthorBits: 0
TableStatus: Retrieved
Table options:
HashMap: DEFAULT-HASHMAP-3840-2
-- Attributes --
id Int PRIMARY KEY DISTRIBUTION KEY AT=FIXED ST=MEMORY AUTO_INCR
name Varchar(20;latin1_swedish_ci) NOT NULL AT=SHORT_VAR ST=MEMORY DYNAMIC
length_mm Int NOT NULL AT=FIXED ST=MEMORY DYNAMIC
weight_gm Int NOT NULL AT=FIXED ST=MEMORY DYNAMIC
-- Indexes --
PRIMARY KEY(id) - UniqueHashIndex
PRIMARY(id) - OrderedIndex
uk(name) - OrderedIndex
uk$unique(name) - UniqueHashIndex
-- Per partition info --
Partition       Row count       Commit count    Frag fixed memory       Frag varsized memory    Extent_space    Free extent_space
0               2               2               32768                   32768                   0               0
1               4               4               32768                   32768                   0               0
NDBT_ProgramExit: 0 - OK
关于多个表的信息可以通过使用它们的名称在一次ndb_desc调用中获得，以空格分隔。所有表必须在同一个数据库中。
--table您可以使用(short form:
-t) 选项并提供索引名称作为ndb_desc的第一个参数来
获取有关特定索引的其他信息，如下所示：
$> ./ndb_desc uk -d test -t fish
-- uk --
Version: 2
Base table: fish
Number of attributes: 1
Logging: 0
Index type: OrderedIndex
Index status: Retrieved
-- Attributes --
name Varchar(20;latin1_swedish_ci) NOT NULL AT=SHORT_VAR ST=MEMORY
-- IndexTable 10/uk --
Version: 2
Fragment type: FragUndefined
K Value: 6
Min load factor: 78
Max load factor: 80
Temporary table: yes
Number of attributes: 2
Number of primary keys: 1
Length of frm data: 0
Max Rows: 0
Row Checksum: 1
Row GCI: 1
SingleUserMode: 2
ForceVarPart: 0
PartitionCount: 2
FragmentCount: 2
FragmentCountType: ONE_PER_LDM_PER_NODE
ExtraRowGciBits: 0
ExtraRowAuthorBits: 0
TableStatus: Retrieved
Table options:
-- Attributes --
name Varchar(20;latin1_swedish_ci) NOT NULL AT=SHORT_VAR ST=MEMORY
NDB$TNODE Unsigned [64] PRIMARY KEY DISTRIBUTION KEY AT=FIXED ST=MEMORY
-- Indexes --
PRIMARY KEY(NDB$TNODE) - UniqueHashIndex
NDBT_ProgramExit: 0 - OK
当以这种方式指定索引时，
--extra-partition-info和
--extra-node-info选项无效。
输出中的Version列包含表的架构对象版本。有关解释此值的信息，请参阅
导航台模式对象版本。
可以使用
NDB_TABLE嵌入在语句中的注释
CREATE TABLE设置
的三个表属性在ndb_desc输出ALTER TABLE中也可见。表格
始终显示在
列中。
和
，如果设置为 1，则显示在列中。在mysql客户端执行如下语句就可以看到
：
FRAGMENT_COUNT_TYPEFragmentCountTypeREAD_ONLYFULLY_REPLICATEDTable optionsALTER
TABLEmysql> ALTER TABLE fish COMMENT='NDB_TABLE=READ_ONLY=1,FULLY_REPLICATED=1';
1 row in set, 1 warning (0.00 sec)
mysql> SHOW WARNINGS\G
+---------+------+---------------------------------------------------------------------------------------------------------+
| Level   | Code | Message                                                                                                 |
+---------+------+---------------------------------------------------------------------------------------------------------+
| Warning | 1296 | Got error 4503 'Table property is FRAGMENT_COUNT_TYPE=ONE_PER_LDM_PER_NODE but not in comment' from NDB |
+---------+------+---------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)
发出警告是因为READ_ONLY=1
要求表的片段计数类型为（或设置为）ONE_PER_LDM_PER_NODE_GROUP；
NDB在这种情况下自动设置。您可以使用以下方法检查该ALTER TABLE语句是否具有预期的效果SHOW CREATE
TABLE：
mysql> SHOW CREATE TABLE fish\G
*************************** 1. row ***************************
Table: fish
Create Table: CREATE TABLE `fish` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`name` varchar(20) NOT NULL,
`length_mm` int(11) NOT NULL,
`weight_gm` int(11) NOT NULL,
PRIMARY KEY (`id`),
UNIQUE KEY `uk` (`name`)
) ENGINE=ndbcluster DEFAULT CHARSET=latin1
COMMENT='NDB_TABLE=READ_BACKUP=1,FULLY_REPLICATED=1'
1 row in set (0.01 sec)
由于FRAGMENT_COUNT_TYPE未明确设置，其值未显示在 打印的注释文本中SHOW CREATE TABLE。
然而， ndb_desc显示该属性的更新值。该Table options列显示刚刚启用的二进制属性。您可以在此处显示的输出中看到这一点（强调文本）：
$> ./ndb_desc -c localhost fish -d test -p
-- fish --
Version: 4
Fragment type: HashMapPartition
K Value: 6
Min load factor: 78
Max load factor: 80
Temporary table: no
Number of attributes: 4
Number of primary keys: 1
Length of frm data: 380
Max Rows: 0
Row Checksum: 1
Row GCI: 1
SingleUserMode: 0
ForceVarPart: 1
PartitionCount: 1
FragmentCount: 1
FragmentCountType: ONE_PER_LDM_PER_NODE_GROUP
ExtraRowGciBits: 0
ExtraRowAuthorBits: 0
TableStatus: Retrieved
Table options: readbackup, fullyreplicated
HashMap: DEFAULT-HASHMAP-3840-1
-- Attributes --
id Int PRIMARY KEY DISTRIBUTION KEY AT=FIXED ST=MEMORY AUTO_INCR
name Varchar(20;latin1_swedish_ci) NOT NULL AT=SHORT_VAR ST=MEMORY DYNAMIC
length_mm Int NOT NULL AT=FIXED ST=MEMORY DYNAMIC
weight_gm Int NOT NULL AT=FIXED ST=MEMORY DYNAMIC
-- Indexes --
PRIMARY KEY(id) - UniqueHashIndex
PRIMARY(id) - OrderedIndex
uk(name) - OrderedIndex
uk$unique(name) - UniqueHashIndex
-- Per partition info --
Partition       Row count       Commit count    Frag fixed memory       Frag varsized memory    Extent_space    Free extent_space
NDBT_ProgramExit: 0 - OK
有关这些表属性的更多信息，请参阅
第 13.1.20.12 节，“设置 NDB 注释选项”。
Extent_space和Free
extent_space列仅适用
NDB于磁盘上有列的表
；对于只有内存中列的表，这些列总是包含值0。
为了说明它们的使用，我们修改了前面的例子。首先，我们必须创建必要的磁盘数据对象，如下所示：
CREATE LOGFILE GROUP lg_1
ADD UNDOFILE 'undo_1.log'
INITIAL_SIZE 16M
UNDO_BUFFER_SIZE 2M
ENGINE NDB;
ALTER LOGFILE GROUP lg_1
ADD UNDOFILE 'undo_2.log'
INITIAL_SIZE 12M
ENGINE NDB;
CREATE TABLESPACE ts_1
ADD DATAFILE 'data_1.dat'
USE LOGFILE GROUP lg_1
INITIAL_SIZE 32M
ENGINE NDB;
ALTER TABLESPACE ts_1
ADD DATAFILE 'data_2.dat'
INITIAL_SIZE 48M
ENGINE NDB;
（有关刚刚显示的语句及其创建的对象的更多信息，请参阅
第 23.6.10.1 节，“NDB Cluster Disk Data Objects”，以及
第 13.1.16 节，“CREATE LOGFILE GROUP 语句”和
第 13.1.21 节, “CREATE TABLESPACE 语句”。）
现在我们可以创建并填充一个版本的
fish表，该版本在磁盘上存储其 2 个列（如果表的先前版本已经存在，请先删除该版本）：
DROP TABLE IF EXISTS fish;
CREATE TABLE fish (
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(20) NOT NULL,
length_mm INT NOT NULL,
weight_gm INT NOT NULL,
PRIMARY KEY pk (id),
UNIQUE KEY uk (name)
) TABLESPACE ts_1 STORAGE DISK
ENGINE=NDB;
INSERT INTO fish VALUES
(NULL, 'guppy', 35, 2), (NULL, 'tuna', 2500, 150000),
(NULL, 'shark', 3000, 110000), (NULL, 'manta ray', 1500, 50000),
(NULL, 'grouper', 900, 125000), (NULL ,'puffer', 250, 2500);
针对此版本的表运行时，
ndb_desc显示以下输出：
$> ./ndb_desc -c localhost fish -d test -p
-- fish --
Version: 1
Fragment type: HashMapPartition
K Value: 6
Min load factor: 78
Max load factor: 80
Temporary table: no
Number of attributes: 4
Number of primary keys: 1
Length of frm data: 1001
Max Rows: 0
Row Checksum: 1
Row GCI: 1
SingleUserMode: 0
ForceVarPart: 1
PartitionCount: 2
FragmentCount: 2
PartitionBalance: FOR_RP_BY_LDM
ExtraRowGciBits: 0
ExtraRowAuthorBits: 0
TableStatus: Retrieved
Table options: readbackup
HashMap: DEFAULT-HASHMAP-3840-2
Tablespace id: 16
Tablespace: ts_1
-- Attributes --
id Int PRIMARY KEY DISTRIBUTION KEY AT=FIXED ST=MEMORY AUTO_INCR
name Varchar(80;utf8mb4_0900_ai_ci) NOT NULL AT=SHORT_VAR ST=MEMORY
length_mm Int NOT NULL AT=FIXED ST=DISK
weight_gm Int NOT NULL AT=FIXED ST=DISK
-- Indexes --
PRIMARY KEY(id) - UniqueHashIndex
PRIMARY(id) - OrderedIndex
uk(name) - OrderedIndex
uk$unique(name) - UniqueHashIndex
-- Per partition info --
Partition       Row count       Commit count    Frag fixed memory       Frag varsized memory    Extent_space    Free extent_space
0               2               2               32768                   32768                   1048576         1044440
1               4               4               32768                   32768                   1048576         1044400
NDBT_ProgramExit: 0 - OK
这意味着在每个分区上从该表的表空间中分配了 1048576 字节，其中 1044440 字节可用于额外存储。换句话说，每个分区 1048576 - 1044440 = 4136 字节当前用于存储来自该表的基于磁盘的列的数据。显示为的字节数Free extent_space仅可用于存储表中的磁盘列数据fish
；因此，从INFORMATION_SCHEMA.FILES
表中选择时它是不可见的。
Tablespace id并
Tablespace显示从 NDB 8.0.21 开始的磁盘数据表。
对于完全复制的表，ndb_desc仅显示持有主分区片段副本的节点；具有复制片段副本（仅）的节点将被忽略。您可以使用mysql
客户端从数据库中的
table_distribution_status、
table_fragments、
table_info和
table_replicas表中
获取此类信息ndbinfo。
下表显示了
可以与ndb_desc一起使用的所有选项。表后有其他说明。
表 23.31 与程序 ndb_desc 一起使用的命令行选项
格式
描述
添加、弃用或删除
--auto-inc,
-a
如果表有一个，则显示 AUTO_INCREMENT 列的下一个值
添加：NDB 8.0.21
--blob-info,
-b
在输出中包含 BLOB 表的分区信息。要求同时使用 -p 选项
（支持所有基于 MySQL 8.0 的 NDB 版本）
--character-sets-dir=path
包含字符集的目录
删除：8.0.31
--connect-retries=#
放弃前重试连接的次数
（支持所有基于 MySQL 8.0 的 NDB 版本）
--connect-retry-delay=#
尝试联系管理服务器之间等待的秒数
（支持所有基于 MySQL 8.0 的 NDB 版本）
--connect-string=connection_string,
-c
connection_string
与 --ndb-connectstring 相同
（支持所有基于 MySQL 8.0 的 NDB 版本）
--context,
-x
显示表的额外信息，例如数据库、模式、名称和内部 ID
添加：NDB 8.0.21
--core-file
写入核心文件出错；用于调试
删除：8.0.31
--database=name,
-d
name
包含表的数据库名称
（支持所有基于 MySQL 8.0 的 NDB 版本）
--defaults-extra-file=path
读取全局文件后读取给定文件
（支持所有基于 MySQL 8.0 的 NDB 版本）
--defaults-file=path
仅从给定文件中读取默认选项
（支持所有基于 MySQL 8.0 的 NDB 版本）
--defaults-group-suffix=string
还阅读带有 concat(group, suffix) 的组
（支持所有基于 MySQL 8.0 的 NDB 版本）
--extra-node-info,
-n
在输出中包含分区到数据节点的映射；需要 --extra-partition-info
（支持所有基于 MySQL 8.0 的 NDB 版本）
--extra-partition-info,
-p
显示有关分区的信息
（支持所有基于 MySQL 8.0 的 NDB 版本）
--help,
-?
显示帮助文本并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--login-path=path
从登录文件中读取给定路径
（支持所有基于 MySQL 8.0 的 NDB 版本）
--ndb-connectstring=connection_string,
-c
connection_string
设置用于连接到 ndb_mgmd 的连接字符串。语法：“[nodeid=id;][host=]hostname[:port]”。覆盖 NDB_CONNECTSTRING 和 my.cnf 中的条目
（支持所有基于 MySQL 8.0 的 NDB 版本）
--ndb-mgmd-host=connection_string,
-c
connection_string
与 --ndb-connectstring 相同
（支持所有基于 MySQL 8.0 的 NDB 版本）
--ndb-nodeid=#
为此节点设置节点 ID，覆盖 --ndb-connectstring 设置的任何 ID
（支持所有基于 MySQL 8.0 的 NDB 版本）
--ndb-optimized-node-selection
为交易节点的选择启用优化。默认启用；使用 --skip-ndb-optimized-node-selection 禁用
删除：8.0.31
--no-defaults
不要从登录文件以外的任何选项文件中读取默认选项
（支持所有基于 MySQL 8.0 的 NDB 版本）
--print-defaults
打印程序参数列表并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--retries=#,
-r
#
重试连接的次数（每秒一次）
（支持所有基于 MySQL 8.0 的 NDB 版本）
--table=name,
-t
name
指定要在其中查找索引的表。使用此选项时，-p 和 -n 无效并被忽略
（支持所有基于 MySQL 8.0 的 NDB 版本）
--unqualified,
-u
使用不合格的表名
（支持所有基于 MySQL 8.0 的 NDB 版本）
--usage,
-?
显示帮助文本并退出；与 --help 相同
（支持所有基于 MySQL 8.0 的 NDB 版本）
--version,
-V
显示版本信息并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--auto-inc,
-a
显示表列的下一个值
AUTO_INCREMENT（如果有）。
--blob-info,
-b
包括有关下属
BLOB和
TEXT列的信息。
使用此选项还需要使用
--extra-partition-info
( -p) 选项。
--character-sets-dir
命令行格式
--character-sets-dir=path
删除
8.0.31
包含字符集的目录。
--connect-retries
命令行格式
--connect-retries=#
类型
整数
默认值
12
最小值
0
最大值
12
放弃前重试连接的次数。
--connect-retry-delay
命令行格式
--connect-retry-delay=#
类型
整数
默认值
5
最小值
0
最大值
5
尝试联系管理服务器之间等待的秒数。
--connect-string
命令行格式
--connect-string=connection_string
类型
细绳
默认值
[none]
与 相同
--ndb-connectstring。
--context,
-x
显示表的其他上下文信息，例如架构、数据库名称、表名称和表的内部 ID。
--core-file
命令行格式
--core-file
删除
8.0.31
写入核心文件出错；在调试中使用。
--database=db_name,
-d
指定应在其中找到表的数据库。
--defaults-extra-file
命令行格式
--defaults-extra-file=path
类型
细绳
默认值
[none]
读取全局文件后读取给定文件。
--defaults-file
命令行格式
--defaults-file=path
类型
细绳
默认值
[none]
仅从给定文件中读取默认选项。
--defaults-group-suffix
命令行格式
--defaults-group-suffix=string
类型
细绳
默认值
[none]
还可以阅读带有 concat(group, suffix) 的组。
--extra-node-info,
-n
包括有关表分区和它们所在的数据节点之间的映射的信息。此信息可用于验证分布感知机制并支持更有效的应用程序访问存储在 NDB Cluster 中的数据。
使用此选项还需要使用
--extra-partition-info
( -p) 选项。
--extra-partition-info,
-p
打印有关表分区的附加信息。
--help
命令行格式
--help
显示帮助文本并退出。
--login-path
命令行格式
--login-path=path
类型
细绳
默认值
[none]
从登录文件中读取给定路径。
--ndb-connectstring
命令行格式
--ndb-connectstring=connection_string
类型
细绳
默认值
[none]
设置用于连接到 ndb_mgmd 的连接字符串。语法：“[nodeid=id;][host=]hostname[:port]”。覆盖 NDB_CONNECTSTRING 和 my.cnf 中的条目。
--ndb-mgmd-host
命令行格式
--ndb-mgmd-host=connection_string
类型
细绳
默认值
[none]
与 相同
--ndb-connectstring。
--ndb-nodeid
命令行格式
--ndb-nodeid=#
类型
整数
默认值
[none]
为此节点设置节点 ID，覆盖由 设置的任何 ID
--ndb-connectstring。
--ndb-optimized-node-selection
命令行格式
--ndb-optimized-node-selection
删除
8.0.31
为交易节点的选择启用优化。默认启用；用于
--skip-ndb-optimized-node-selection禁用。
--no-defaults
命令行格式
--no-defaults
不要从登录文件以外的任何选项文件中读取默认选项。
--print-defaults
命令行格式
--print-defaults
打印程序参数列表并退出。
--retries=#,
-r
在放弃之前尝试多次连接。每秒进行一次连接尝试。
--table=tbl_name,
-t
指定要在其中查找索引的表。
--unqualified,
-u
使用不合格的表名。
--usage
命令行格式
--usage
显示帮助文本并退出；一样
--help。
--version
命令行格式
--version
显示版本信息并退出。
输出中列出的表索引按 ID 排序。
© Mysql 中文网
