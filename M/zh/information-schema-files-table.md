# 26.3.15 INFORMATION_SCHEMA 文件表_MySQL 8.0 参考手册

26.3.15 INFORMATION_SCHEMA 文件表_MySQL 8.0 参考手册
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
26.1 简介
26.2 INFORMATION_SCHEMA 表参考
26.3 INFORMATION_SCHEMA 总表
26.3.1 INFORMATION_SCHEMA 通用表参考1
26.3.2 INFORMATION_SCHEMA ADMINISTRABLE_ROLE_AUTHORIZATIONS 表1
26.3.3 INFORMATION_SCHEMA APPLICABLE_ROLES 表1
26.3.4 INFORMATION_SCHEMA CHARACTER_SETS 表1
26.3.5 INFORMATION_SCHEMA CHECK_CONSTRAINTS 表1
26.3.6 INFORMATION_SCHEMA COLLATIONS 表1
26.3.7 INFORMATION_SCHEMA COLLATION_CHARACTER_SET_APPLICABILITY 表1
26.3.8 INFORMATION_SCHEMA COLUMNS 表1
26.3.9 INFORMATION_SCHEMA COLUMNS_EXTENSIONS 表1
26.3.10 INFORMATION_SCHEMA COLUMN_PRIVILEGES 表1
26.3.11 INFORMATION_SCHEMA COLUMN_STATISTICS 表1
26.3.12 INFORMATION_SCHEMA ENABLED_ROLES 表1
26.3.13 INFORMATION_SCHEMA 引擎表1
26.3.14 INFORMATION_SCHEMA 事件表1
26.3.15 INFORMATION_SCHEMA 文件表1
26.3.16 INFORMATION_SCHEMA KEY_COLUMN_USAGE 表1
26.3.17 INFORMATION_SCHEMA KEYWORDS 表1
26.3.18 INFORMATION_SCHEMA ndb_transid_mysql_connection_map 表1
26.3.19 INFORMATION_SCHEMA OPTIMIZER_TRACE 表1
26.3.20 INFORMATION_SCHEMA 参数表1
26.3.21 INFORMATION_SCHEMA 分区表1
26.3.22 INFORMATION_SCHEMA PLUGINS 表1
26.3.23 INFORMATION_SCHEMA PROCESSLIST 表1
26.3.24 INFORMATION_SCHEMA PROFILING 表1
26.3.25 INFORMATION_SCHEMA REFERENTIAL_CONSTRAINTS 表1
26.3.26 INFORMATION_SCHEMA RESOURCE_GROUPS 表1
26.3.27 INFORMATION_SCHEMA ROLE_COLUMN_GRANTS 表1
26.3.28 INFORMATION_SCHEMA ROLE_ROUTINE_GRANTS 表1
26.3.29 INFORMATION_SCHEMA ROLE_TABLE_GRANTS 表1
26.3.30 INFORMATION_SCHEMA ROUTINES 表1
26.3.31 INFORMATION_SCHEMA SCHEMATA 表1
26.3.32 INFORMATION_SCHEMA SCHEMATA_EXTENSIONS 表1
26.3.33 INFORMATION_SCHEMA SCHEMA_PRIVILEGES 表1
26.3.34 INFORMATION_SCHEMA 统计表1
26.3.35 INFORMATION_SCHEMA ST_GEOMETRY_COLUMNS 表1
26.3.36 INFORMATION_SCHEMA ST_SPATIAL_REFERENCE_SYSTEMS 表1
26.3.37 INFORMATION_SCHEMA ST_UNITS_OF_MEASURE 表1
26.3.38 INFORMATION_SCHEMA TABLES 表1
26.3.39 INFORMATION_SCHEMA TABLES_EXTENSIONS 表1
26.3.40 INFORMATION_SCHEMA TABLESPACES 表1
26.3.41 INFORMATION_SCHEMA TABLESPACES_EXTENSIONS 表1
26.3.42 INFORMATION_SCHEMA TABLE_CONSTRAINTS 表1
26.3.43 INFORMATION_SCHEMA TABLE_CONSTRAINTS_EXTENSIONS 表1
26.3.44 INFORMATION_SCHEMA TABLE_PRIVILEGES 表1
26.3.45 INFORMATION_SCHEMA 触发器表1
26.3.46 INFORMATION_SCHEMA USER_ATTRIBUTES 表1
26.3.47 INFORMATION_SCHEMA USER_PRIVILEGES 表1
26.3.48 INFORMATION_SCHEMA VIEWS 表1
26.3.49 INFORMATION_SCHEMA VIEW_ROUTINE_USAGE 表1
26.3.50 INFORMATION_SCHEMA VIEW_TABLE_USAGE 表1
26.4 INFORMATION_SCHEMA InnoDB 表
26.5 INFORMATION_SCHEMA线程池表
26.6 INFORMATION_SCHEMA 连接控制表
26.7 INFORMATION_SCHEMA MySQL 企业防火墙表
26.8 SHOW 语句的扩展
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
MySQL 8.0 参考手册  / 第 26 章 INFORMATION_SCHEMA 表  / 26.3 INFORMATION_SCHEMA 总表  /
26.3.15 INFORMATION_SCHEMA 文件表
26.3.15 INFORMATION_SCHEMA 文件表
该FILES表提供了有关存储 MySQL 表空间数据的文件的信息。
该FILES表提供有关
InnoDB数据文件的信息。在 NDB Cluster 中，此表还提供有关存储 NDB Cluster 磁盘数据表的文件的信息。有关特定于 的其他信息InnoDB，请参阅
本节后面的InnoDB 注释；有关特定于 NDB Cluster 的其他信息，请参阅
NDB Notes。
该FILES表有以下列：
FILE_ID
For InnoDB：表空间 ID，也称为space_idor
fil_space_t::id。
对于NDB：文件标识符。
FILE_ID列值是自动生成的。
FILE_NAME
For InnoDB: 数据文件的名称。File-per-table 和 general 表空间有一个
.ibd文件扩展名。撤消表空间以undo. 系统表空间以ibdata. 全局临时表空间以
ibtmp. 文件名包含文件路径，可能是相对于MySQL数据目录（datadir系统变量的值）。
For NDB：由 or 创建的撤消日志文件的名称，或由orCREATE LOGFILE GROUP
创建ALTER LOGFILE GROUP的数据文件的名称。在 NDB 8.0 中，文件名以相对路径显示；对于撤消日志文件，此路径是相对于目录的
；对于数据文件，它是相对于目录的
。这意味着，例如，创建的数据文件的名称显示为
.
CREATE
TABLESPACEALTER
TABLESPACEDataDir/ndb_NodeId_fs/LGDataDir/ndb_NodeId_fs/TSALTER TABLESPACE ts ADD DATAFILE 'data_2.dat'
INITIAL SIZE 256M./data_2.dat
FILE_TYPE
对于InnoDB：表空间文件类型。文件有三种可能的文件类型InnoDB
。TABLESPACE是保存表、索引或其他形式的用户数据的任何系统文件、通用文件或 file-per-table 表空间文件的文件类型。
TEMPORARY是临时表空间的文件类型。UNDO LOG是撤消表空间的文件类型，它保存撤消记录。
对于NDB：值之一UNDO
LOG或DATAFILE。在 NDB 8.0.13 之前，TABLESPACE也是一个可能的值。
TABLESPACE_NAME
与文件关联的表空间的名称。
对于InnoDB：一般表空间名称在创建时指定。File-per-table 表空间名称以下列格式显示：
. 系统表空间名称是
. 全局临时表空间名称是. 默认撤消表空间名称是
和
。用户创建的撤消表空间名称与创建时指定的一样。
schema_name/table_nameInnoDBinnodb_systeminnodb_temporaryinnodb_undo_001innodb_undo_002
TABLE_CATALOG
该值始终为空。
TABLE_SCHEMA
这总是NULL。
TABLE_NAME
这总是NULL。
LOGFILE_GROUP_NAME
对于InnoDB：这总是
NULL。
For NDB：日志文件或数据文件所属的日志文件组的名称。
LOGFILE_GROUP_NUMBER
对于InnoDB：这总是
NULL。
For NDB：对于磁盘数据撤消日志文件，日志文件所属的日志文件组的自动生成的 ID 号。这与为表中的列
以及
此撤消日志文件
的表中的id列
显示的值相同
。ndbinfo.dict_obj_infolog_idndbinfo.logspacesndbinfo.logspaces
ENGINE
对于InnoDB：此值始终为
InnoDB。
对于NDB：此值始终为
ndbcluster。
FULLTEXT_KEYS
这总是NULL。
DELETED_ROWS
这总是NULL。
UPDATE_COUNT
这总是NULL。
FREE_EXTENTS
For InnoDB：当前数据文件中完全空闲的区数。
For NDB：文件尚未使用的范围数。
TOTAL_EXTENTS
For InnoDB：当前数据文件中使用的完整范围数。不计算文件末尾的任何部分范围。
For NDB：分配给文件的盘区总数。
EXTENT_SIZE
对于InnoDB：对于页面大小为 4KB、8KB 或 16KB 的文件，扩展区大小为 1048576 (1MB)。对于页面大小为 32KB 的文件，扩展区大小为 2097152 字节 (2MB)，对于页面大小为 64KB 的文件，扩展区大小为 4194304 (4MB)。
FILES不报告
InnoDB页面大小。页面大小由innodb_page_size系统变量定义。也可以从INNODB_TABLESPACES表 where中检索范围大小信息FILES.FILE_ID =
INNODB_TABLESPACES.SPACE。
For NDB：文件范围的大小（以字节为单位）。
INITIAL_SIZE
For InnoDB：文件的初始大小（以字节为单位）。
For NDB：文件的大小（以字节为单位）。这与用于创建文件
的,
,
, or
语句的INITIAL_SIZE子句中
使用的值相同
。CREATE LOGFILE GROUPALTER LOGFILE GROUPCREATE TABLESPACEALTER TABLESPACE
MAXIMUM_SIZE
For InnoDB：文件中允许的最大字节数。该值NULL
适用于除预定义系统表空间数据文件之外的所有数据文件。最大系统表空间文件大小由
innodb_data_file_path. 最大全局临时表空间文件大小由
innodb_temp_data_file_path. 预定义系统表空间数据文件的
NULL值表示未明确定义文件大小限制。
For NDB：此值始终与INITIAL_SIZE值相同。
AUTOEXTEND_SIZE
表空间的自动扩展大小。对于
NDB，AUTOEXTEND_SIZE总是NULL。
CREATION_TIME
这总是NULL。
LAST_UPDATE_TIME
这总是NULL。
LAST_ACCESS_TIME
这总是NULL。
RECOVER_TIME
这总是NULL。
TRANSACTION_COUNTER
这总是NULL。
VERSION
对于InnoDB：这总是
NULL。
For NDB: 文件的版本号。
ROW_FORMAT
对于InnoDB：这总是
NULL。
对于NDB：FIXED或
之一DYNAMIC。
TABLE_ROWS
这总是NULL。
AVG_ROW_LENGTH
这总是NULL。
DATA_LENGTH
这总是NULL。
MAX_DATA_LENGTH
这总是NULL。
INDEX_LENGTH
这总是NULL。
DATA_FREE
For InnoDB：整个表空间的可用空间总量（以字节为单位）。预定义的系统表空间，包括系统表空间和临时表表空间，可能有一个或多个数据文件。
对于NDB：这总是
NULL。
CREATE_TIME
这总是NULL。
UPDATE_TIME
这总是NULL。
CHECK_TIME
这总是NULL。
CHECKSUM
这总是NULL。
STATUS
对于InnoDB：此值为
NORMAL默认值。
InnoDBfile-per-table tablespaces 可能会报告IMPORTING，这表明该表空间尚不可用。
对于NDB：对于 NDB Cluster 磁盘数据文件，此值始终为NORMAL。
EXTRA
对于InnoDB：这总是
NULL。
For NDB: ( NDB 8.0.15 and later ) 对于undo log文件，该列显示undo log buffer size；对于数据文件，它总是
NULL。在接下来的几段中提供了更详细的解释。
NDBCLUSTER在集群中的每个数据节点上存储每个数据文件和每个撤消日志文件的副本。在 NDB 8.0.13 及更高版本中，FILES
表中每个此类文件仅包含一行。假设您在具有四个数据节点的 NDB Cluster 上运行以下两个语句：
CREATE LOGFILE GROUP mygroup
ADD UNDOFILE 'new_undo.dat'
INITIAL_SIZE 2G
ENGINE NDBCLUSTER;
CREATE TABLESPACE myts
ADD DATAFILE 'data_1.dat'
USE LOGFILE GROUP mygroup
INITIAL_SIZE 256M
ENGINE NDBCLUSTER;
成功运行这两个语句后，您应该会看到类似于此处显示的针对FILES表的此查询的结果：
mysql> SELECT LOGFILE_GROUP_NAME, FILE_TYPE, EXTRA
->     FROM INFORMATION_SCHEMA.FILES
->     WHERE ENGINE = 'ndbcluster';
+--------------------+-----------+--------------------------+
| LOGFILE_GROUP_NAME | FILE_TYPE | EXTRA                    |
+--------------------+-----------+--------------------------+
| mygroup            | UNDO LOG  | UNDO_BUFFER_SIZE=8388608 |
| mygroup            | DATAFILE  | NULL                     |
+--------------------+-----------+--------------------------+
撤消日志缓冲区大小信息在 NDB 8.0.13 中被无意中删除，但在 NDB 8.0.15 中恢复。（缺陷 #92796，缺陷 #28800252）
在 NDB 8.0.13 之前，该FILES表包含文件所属的每个数据节点上的每个文件的一行，以及其撤消缓冲区的大小。在这些版本中，同一查询的结果包含每个数据节点一行，如下所示：
+--------------------+-----------+-----------------------------------------+
| LOGFILE_GROUP_NAME | FILE_TYPE | EXTRA                                   |
+--------------------+-----------+-----------------------------------------+
| mygroup            | UNDO LOG  | CLUSTER_NODE=5;UNDO_BUFFER_SIZE=8388608 |
| mygroup            | UNDO LOG  | CLUSTER_NODE=6;UNDO_BUFFER_SIZE=8388608 |
| mygroup            | UNDO LOG  | CLUSTER_NODE=7;UNDO_BUFFER_SIZE=8388608 |
| mygroup            | UNDO LOG  | CLUSTER_NODE=8;UNDO_BUFFER_SIZE=8388608 |
| mygroup            | DATAFILE  | CLUSTER_NODE=5                          |
| mygroup            | DATAFILE  | CLUSTER_NODE=6                          |
| mygroup            | DATAFILE  | CLUSTER_NODE=7                          |
| mygroup            | DATAFILE  | CLUSTER_NODE=8                          |
+--------------------+-----------+-----------------------------------------+
笔记
FILES是一个非标准
INFORMATION_SCHEMA表。
从 MySQL 8.0.21 开始，您必须具有
PROCESS查询此表的权限。
InnoDB 注释
以下注释适用于InnoDB数据文件。
上报的信息FILES是从InnoDB打开文件的内存缓存中INNODB_DATAFILES
获取的，而其数据是从InnoDB
SYS_DATAFILES内部数据字典表中获取的。
提供的信息FILES
包括全局临时表空间信息，这些信息在InnoDB
SYS_DATAFILES内部数据字典表中不可用，因此不包含在
INNODB_DATAFILES.
当存在单独的撤消表空间时，撤消表空间信息显示
FILES在 MySQL 8.0 中默认情况下。
以下查询返回与表空间FILES
相关的所有表信息InnoDB
。
SELECT
FILE_ID, FILE_NAME, FILE_TYPE, TABLESPACE_NAME, FREE_EXTENTS,
TOTAL_EXTENTS, EXTENT_SIZE, INITIAL_SIZE, MAXIMUM_SIZE,
AUTOEXTEND_SIZE, DATA_FREE, STATUS
FROM INFORMATION_SCHEMA.FILES
WHERE ENGINE='InnoDB'\G
新开发银行票据
该FILES表仅提供有关磁盘数据文件的信息；您不能使用它来确定单个NDB表的磁盘空间分配或可用性。但是，可以使用ndb_descNDB查看为每个将数据存储在磁盘上的表
分配了多少空间
，以及该表的磁盘上剩余多少空间可用于存储数据。
从 NDB 8.0.29 开始，表中的许多信息
FILES也可以在
ndbinfo.files表中找到。
、和
值由操作系统报告，而不是由
CREATION_TIME存储
引擎提供。如果操作系统未提供任何值，这些列将显示。
LAST_UPDATE_TIMELAST_ACCESSEDNDBNULLTOTAL EXTENTS
和列
之间的区别FREE_EXTENTS是文件当前使用的范围数：
SELECT TOTAL_EXTENTS - FREE_EXTENTS AS extents_used
FROM INFORMATION_SCHEMA.FILES
WHERE FILE_NAME = './myfile.dat';
要估计文件使用的磁盘空间量，请将该差值乘以
EXTENT_SIZE列的值，该值给出文件的范围大小（以字节为单位）：
SELECT (TOTAL_EXTENTS - FREE_EXTENTS) * EXTENT_SIZE AS bytes_used
FROM INFORMATION_SCHEMA.FILES
WHERE FILE_NAME = './myfile.dat';FREE_EXTENTS同样，您可以通过乘以
来估算给定文件中剩余的可用空间量
EXTENT_SIZE：
SELECT FREE_EXTENTS * EXTENT_SIZE AS bytes_free
FROM INFORMATION_SCHEMA.FILES
WHERE FILE_NAME = './myfile.dat';
重要的
前面查询产生的字节值只是近似值，它们的精度与 的值成反比
EXTENT_SIZE。也就是说，
EXTENT_SIZE变得越大，近似值就越不准确。
同样重要的是要记住，一旦使用了一个盘区，如果不删除它所属的数据文件，就不能再次释放它。这意味着从磁盘数据表中删除不会释放磁盘空间。
extent 大小可以在CREATE
TABLESPACE语句中设置。有关详细信息，请参阅
第 13.1.21 节，“CREATE TABLESPACE 语句”。
FILES在 NDB 8.0.13 之前，在创建日志文件组后，表
中会出现一个额外的行
，NULL
在FILE_NAME列中。在NDB 8.0.13及之后的版本中，该行不对应任何文件，不再显示，需要ndbinfo.logspaces
查表获取undo log文件使用信息。有关更多信息，请参阅此表的描述以及
第 23.6.10.1 节，“NDB Cluster Disk Data Objects”。
此项目中的其余讨论仅适用于 NDB 8.0.12 及更早版本。对于列
NULL中有的行，FILE_NAME
列的值FILE_ID总是0，
FILE_TYPE列的值总是UNDO
LOG，STATUS
列的值总是NORMAL。该
ENGINE列的值始终为
ndbcluster。
此行中的FREE_EXTENTS列显示属于给定日志文件组的所有撤消文件可用的空闲盘区总数，其名称和编号分别显示在LOGFILE_GROUP_NAME和
LOGFILE_GROUP_NUMBER列中。
假设您的 NDB Cluster 上没有现有的日志文件组，并且您使用以下语句创建一个：
mysql> CREATE LOGFILE GROUP lg1
ADD UNDOFILE 'undofile.dat'
INITIAL_SIZE = 16M
UNDO_BUFFER_SIZE = 1M
ENGINE = NDB;
您现在可以在查询表
NULL时看到这一行：FILESmysql> SELECT DISTINCT
FILE_NAME AS File,
FREE_EXTENTS AS Free,
TOTAL_EXTENTS AS Total,
EXTENT_SIZE AS Size,
INITIAL_SIZE AS Initial
FROM INFORMATION_SCHEMA.FILES;
+--------------+---------+---------+------+----------+
| File         | Free    | Total   | Size | Initial  |
+--------------+---------+---------+------+----------+
| undofile.dat |    NULL | 4194304 |    4 | 16777216 |
| NULL         | 4184068 |    NULL |    4 |     NULL |
+--------------+---------+---------+------+----------+TOTAL_EXTENTS由于维护撤消文件所需的开销，
可用于撤消日志记录的空闲盘区总数总是略小于日志文件组中所有撤消文件的列值的总和
。这可以通过将第二个撤消文件添加到日志文件组，然后对
FILES表重复之前的查询来看出：
mysql> ALTER LOGFILE GROUP lg1
ADD UNDOFILE 'undofile02.dat'
INITIAL_SIZE = 4M
ENGINE = NDB;
mysql> SELECT DISTINCT
FILE_NAME AS File,
FREE_EXTENTS AS Free,
TOTAL_EXTENTS AS Total,
EXTENT_SIZE AS Size,
INITIAL_SIZE AS Initial
FROM INFORMATION_SCHEMA.FILES;
+----------------+---------+---------+------+----------+
| File           | Free    | Total   | Size | Initial  |
+----------------+---------+---------+------+----------+
| undofile.dat   |    NULL | 4194304 |    4 | 16777216 |
| undofile02.dat |    NULL | 1048576 |    4 |  4194304 |
| NULL           | 5223944 |    NULL |    4 |     NULL |
+----------------+---------+---------+------+----------+
使用此日志文件组的磁盘数据表可用于撤消日志记录的可用空间量（以字节为单位）可以通过将可用范围数乘以初始大小来估算：
mysql> SELECT
FREE_EXTENTS AS 'Free Extents',
FREE_EXTENTS * EXTENT_SIZE AS 'Free Bytes'
FROM INFORMATION_SCHEMA.FILES
WHERE LOGFILE_GROUP_NAME = 'lg1'
AND FILE_NAME IS NULL;
+--------------+------------+
| Free Extents | Free Bytes |
+--------------+------------+
|      5223944 |   20895776 |
+--------------+------------+
如果您创建一个 NDB Cluster Disk Data 表，然后向其中插入一些行，您可以看到大约还有多少空间用于之后的撤消日志记录，例如：
mysql> CREATE TABLESPACE ts1
ADD DATAFILE 'data1.dat'
USE LOGFILE GROUP lg1
INITIAL_SIZE 512M
ENGINE = NDB;
mysql> CREATE TABLE dd (
c1 INT NOT NULL PRIMARY KEY,
c2 INT,
c3 DATE
)
TABLESPACE ts1 STORAGE DISK
ENGINE = NDB;
mysql> INSERT INTO dd VALUES
(NULL, 1234567890, '2007-02-02'),
(NULL, 1126789005, '2007-02-03'),
(NULL, 1357924680, '2007-02-04'),
(NULL, 1642097531, '2007-02-05');
mysql> SELECT
FREE_EXTENTS AS 'Free Extents',
FREE_EXTENTS * EXTENT_SIZE AS 'Free Bytes'
FROM INFORMATION_SCHEMA.FILES
WHERE LOGFILE_GROUP_NAME = 'lg1'
AND FILE_NAME IS NULL;
+--------------+------------+
| Free Extents | Free Bytes |
+--------------+------------+
|      5207565 |   20830260 |
+--------------+------------+FILES在 NDB 8.0.13 之前，每个 NDB Cluster Disk Data 表空间
的表中都有一个额外的行
。因为它不对应于实际文件，所以它在 NDB 8.0.13 中被删除。此行具有列的NULL值，
FILE_NAME列的值
FILE_ID始终是
0，
FILE_TYPE列
的值始终TABLESPACE是，
STATUS列的值始终是
NORMAL，列的值
ENGINE始终是
NDBCLUSTER。
在 NDB 8.0.13 及更高版本中，您可以使用ndb_desc
实用程序
获取有关磁盘数据表空间的信息。有关更多信息，请参阅
第 23.6.10.1 节，“NDB Cluster Disk Data Objects”，以及ndb_desc的描述。
有关其他信息以及创建、删除和获取有关 NDB Cluster 磁盘数据对象的信息的示例，请参阅第 23.6.10 节，“NDB Cluster 磁盘数据表”。
© Mysql 中文网
