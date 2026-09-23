# 26.3.38 INFORMATION_SCHEMA TABLES 表_MySQL 8.0 参考手册

26.3.38 INFORMATION_SCHEMA TABLES 表_MySQL 8.0 参考手册
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
26.3.38 INFORMATION_SCHEMA TABLES 表
26.3.38 INFORMATION_SCHEMA TABLES 表
该TABLES表提供有关数据库中表的信息。
TABLES表示表统计信息
的列保存缓存值。系统变量定义缓存表统计信息过期之前的
information_schema_stats_expiry
时间段。默认值为 86400 秒（24 小时）。如果没有缓存统计信息或统计信息已过期，则在查询表统计信息列时从存储引擎中检索统计信息。要随时更新给定表的缓存值，请使用ANALYZE TABLE. 要始终直接从存储引擎检索最新统计信息，请设置
information_schema_stats_expiry
为0. 有关详细信息，请参阅
第 8.2.3 节，“优化 INFORMATION_SCHEMA 查询”。
笔记
如果innodb_read_only启用了系统变量，ANALYZE
TABLE可能会失败，因为它无法更新数据字典中使用
InnoDB. 对于ANALYZE
TABLE更新键分布的操作，即使操作更新表本身（例如，如果它是一个MyISAM表）也可能会失败。要获取更新的分布统计信息，请设置
information_schema_stats_expiry=0.
该TABLES表有以下列：
TABLE_CATALOG
表所属目录的名称。该值始终为def.
TABLE_SCHEMA
表所属的模式（数据库）的名称。
TABLE_NAME
表的名称。
TABLE_TYPE
BASE TABLE对于表、
VIEW视图或
表。
SYSTEM
VIEWINFORMATION_SCHEMA
该TABLES表不列出
TEMPORARY表。
ENGINE
表的存储引擎。请参阅
第 15 章，InnoDB 存储引擎和
第 16 章，替代存储引擎。
对于分区表，ENGINE显示所有分区使用的存储引擎的名称。
VERSION
此列未使用。随着
.frmMySQL 8.0 中文件的删除，此列现在报告硬编码值10，这是 MySQL 5.7 中使用的最后一个.frm文件版本。
ROW_FORMAT
行存储格式 ( Fixed,
Dynamic, Compressed,
Redundant, Compact)。对于
MyISAM表，Dynamic
对应于myisamchk -dvv报告的内容Packed。
TABLE_ROWS
行数。一些存储引擎（例如
MyISAM）存储确切的计数。对于其他存储引擎，例如InnoDB，该值是一个近似值，可能与实际值相差 40% 到 50%。在这种情况下，使用SELECT
COUNT(*)以获得准确的计数。
TABLE_ROWS用于表格
NULL。
INFORMATION_SCHEMA
对于InnoDB表，行数只是 SQL 优化中使用的粗略估计。（如果InnoDB表已分区，也是如此。）
AVG_ROW_LENGTH
平均行长度。
DATA_LENGTH
对于MyISAM，DATA_LENGTH
是数据文件的长度，以字节为单位。
对于InnoDB，DATA_LENGTH
是为聚集索引分配的近似空间量，以字节为单位。具体来说，它是聚簇索引大小（以页为单位）乘以InnoDB页面大小。
有关其他存储引擎的信息，请参阅本节末尾的注释。
MAX_DATA_LENGTH
对于MyISAM,
MAX_DATA_LENGTH是数据文件的最大长度。在给定所用数据指针大小的情况下，这是可以存储在表中的数据的总字节数。
未用于InnoDB。
有关其他存储引擎的信息，请参阅本节末尾的注释。
INDEX_LENGTH
对于MyISAM，INDEX_LENGTH
是索引文件的长度，以字节为单位。
对于InnoDB，INDEX_LENGTH
是为非聚集索引分配的近似空间量，以字节为单位。具体来说，它是非聚集索引大小的总和（以页为单位）乘以
InnoDB页面大小。
有关其他存储引擎的信息，请参阅本节末尾的注释。
DATA_FREE
已分配但未使用的字节数。
InnoDBtables 报告表所属的表空间的可用空间。对于位于共享表空间中的表，这是共享表空间的可用空间。如果您使用多个表空间并且该表有自己的表空间，则可用空间仅供该表使用。空闲空间是指完全空闲区中的字节数减去安全余量。即使可用空间显示为 0，也可以插入行，只要不需要分配新的盘区。
对于 NDB Cluster，DATA_FREE显示磁盘上为磁盘数据表或磁盘片段分配但未使用的空间。（内存中数据资源使用情况按DATA_LENGTH列报告。）
对于分区表，这个值只是一个估计值，可能不是绝对正确的。在这种情况下，获取此信息的更准确方法是查询
INFORMATION_SCHEMA
PARTITIONS表，如本例所示：
SELECT SUM(DATA_FREE)
FROM  INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = 'mydb'
AND   TABLE_NAME   = 'mytable';
有关详细信息，请参阅
第 26.3.21 节，“INFORMATION_SCHEMA PARTITIONS 表”。
AUTO_INCREMENT
下一个AUTO_INCREMENT值。
CREATE_TIME
创建表时。
UPDATE_TIME
上次更新数据文件的时间。对于某些存储引擎，此值为NULL. 例如，
在其系统表空间InnoDB中存储多个表，
并且数据文件时间戳不适用。即使使用
file-per-table模式，每个表都在一个单独的
文件中，
更改缓冲
也会延迟写入数据文件，因此文件修改时间与上次插入、更新或删除的时间不同。对于，使用数据文件时间戳；但是，在 Windows 上，时间戳不会被更新更新，因此该值不准确。
InnoDB.ibdMyISAM
UPDATE_TIME显示在未分区的表上最后一次UPDATE、、
INSERT或
DELETE执行
的时间戳值。InnoDB对于 MVCC，时间戳值反映了
COMMIT时间，这被认为是最后更新时间。InnoDB当服务器重新启动或表从数据字典缓存
中逐出时，时间戳不会保留。
CHECK_TIME
上次检查表格的时间。这次并非所有存储引擎都更新，在这种情况下，值始终为
NULL。
对于分区InnoDB表，
CHECK_TIME总是
NULL.
TABLE_COLLATION
表默认排序规则。输出没有明确列出表默认字符集，但排序规则名称以字符集名称开头。
CHECKSUM
实时校验和值（如果有）。
CREATE_OPTIONS
与 一起使用的额外选项CREATE
TABLE。
CREATE_OPTIONS显示
partitioned分区表。
在 MySQL 8.0.16 之前，CREATE_OPTIONS显示ENCRYPTION为在 file-per-table 表空间中创建的表指定的子句。从 MySQL 8.0.16 开始，如果表已加密或指定的加密与模式加密不同，它会显示 file-per-table 表空间的加密子句。对于在一般表空间中创建的表，不显示加密子句。要识别加密的 file-per-table 和通用表空间，请查询该
列。
INNODB_TABLESPACES
ENCRYPTION在禁用严格模式的情况下
创建表时
，如果不支持指定的行格式，则使用存储引擎的默认行格式。表的实际行格式在ROW_FORMAT
列中报告。CREATE_OPTIONS显示CREATE
TABLE语句中指定的行格式。
当更改表的存储引擎时，不适用于新存储引擎的表选项将保留在表定义中，以便在必要时将表及其先前定义的选项恢复为原始存储引擎。该CREATE_OPTIONS列可能会显示保留的选项。
TABLE_COMMENT
创建表时使用的注释（或有关 MySQL 无法访问表信息的原因的信息）。
笔记
对于NDB表，此语句的输出显示
AVG_ROW_LENGTH和
列的适当值，但不考虑列
DATA_LENGTH除外。BLOB
对于NDB表格，
DATA_LENGTH仅包括存储在主内存中的数据；和MAX_DATA_LENGTH列
DATA_FREE适用于磁盘数据。
对于 NDB Cluster 磁盘数据表，
MAX_DATA_LENGTH显示为磁盘数据表或片段的磁盘部分分配的空间。（内存中数据资源使用情况按
DATA_LENGTH列报告。）
对于MEMORY表，
DATA_LENGTH、
MAX_DATA_LENGTH和
INDEX_LENGTH值近似于实际分配的内存量。分配算法大量保留内存以减少分配操作的次数。
对于视图，大多数TABLES列为 0 或NULL除了
TABLE_NAME表示视图名称、
CREATE_TIME表示创建时间和TABLE_COMMENT表示
VIEW。
表信息也可从
SHOW TABLE STATUSand
SHOW TABLES语句中获得。请参阅
第 13.7.7.38 节，“SHOW TABLE STATUS 语句”和
第 13.7.7.39 节，“SHOW TABLES 语句”。以下语句是等效的：
SELECT
TABLE_NAME, ENGINE, VERSION, ROW_FORMAT, TABLE_ROWS, AVG_ROW_LENGTH,
DATA_LENGTH, MAX_DATA_LENGTH, INDEX_LENGTH, DATA_FREE, AUTO_INCREMENT,
CREATE_TIME, UPDATE_TIME, CHECK_TIME, TABLE_COLLATION, CHECKSUM,
CREATE_OPTIONS, TABLE_COMMENT
FROM INFORMATION_SCHEMA.TABLES
WHERE table_schema = 'db_name'
[AND table_name LIKE 'wild']
SHOW TABLE STATUS
FROM db_name
[LIKE 'wild']
以下语句是等效的：
SELECT
TABLE_NAME, TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES
WHERE table_schema = 'db_name'
[AND table_name LIKE 'wild']
SHOW FULL TABLES
FROM db_name
[LIKE 'wild']
© Mysql 中文网
