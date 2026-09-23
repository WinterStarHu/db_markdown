# 14.5 INFORMATION_SCHEMA 与数据字典集成_MySQL 8.0 参考手册

14.5 INFORMATION_SCHEMA 与数据字典集成_MySQL 8.0 参考手册
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
14.1 数据字典模式
14.2 删除基于文件的元数据存储
14.3 字典数据的事务存储
14.4 字典对象缓存
14.5 INFORMATION_SCHEMA 与数据字典集成
14.6 序列化词典信息（SDI）
14.7 数据字典使用差异
14.8 数据字典限制
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
MySQL 8.0 参考手册  / 第14章MySQL数据字典  /
14.5 INFORMATION_SCHEMA 与数据字典集成
14.5 INFORMATION_SCHEMA 与数据字典集成
随着数据字典的引入，下
INFORMATION_SCHEMA表被实现为数据字典表的视图：
CHARACTER_SETS
CHECK_CONSTRAINTS
COLLATIONS
COLLATION_CHARACTER_SET_APPLICABILITY
COLUMNS
COLUMN_STATISTICS
EVENTS
FILES
INNODB_COLUMNS
INNODB_DATAFILES
INNODB_FIELDS
INNODB_FOREIGN
INNODB_FOREIGN_COLS
INNODB_INDEXES
INNODB_TABLES
INNODB_TABLESPACES
INNODB_TABLESPACES_BRIEF
INNODB_TABLESTATS
KEY_COLUMN_USAGE
KEYWORDS
PARAMETERS
PARTITIONS
REFERENTIAL_CONSTRAINTS
RESOURCE_GROUPS
ROUTINES
SCHEMATA
STATISTICS
ST_GEOMETRY_COLUMNS
ST_SPATIAL_REFERENCE_SYSTEMS
TABLES
TABLE_CONSTRAINTS
TRIGGERS
VIEWS
VIEW_ROUTINE_USAGE
VIEW_TABLE_USAGE
现在对这些表的查询更加高效，因为它们从数据字典表中获取信息，而不是通过其他更慢的方式。特别是，对于
INFORMATION_SCHEMA作为数据字典表视图的每个表：
服务器不再必须为表的每个查询创建一个临时INFORMATION_SCHEMA表。
当底层数据字典表存储以前通过目录扫描（例如，枚举数据库名称或数据库中的表名称）或文件打开操作（例如，从
.frm文件中读取信息）获得的值时，
INFORMATION_SCHEMA对这些值的查询现在使用表查找代替。（此外，即使对于非视图INFORMATION_SCHEMA表，数据库和表名等值也是通过从数据字典中查找来检索的，不需要目录或文件扫描。）
基础数据字典表上的索引允许优化器构建高效的查询执行计划，这对于以前的INFORMATION_SCHEMA每个查询使用临时表处理表的实现来说是不正确的。
上述改进也适用于
SHOW显示与作为
INFORMATION_SCHEMA数据字典表视图的表相对应的信息的语句。例如，显示与表格
SHOW
DATABASES相同的信息
。SCHEMATA
除了在数据字典表上引入视图之外，
STATISTICSand
TABLES表中包含的表统计信息现在被缓存以提高INFORMATION_SCHEMA查询性能。系统变量定义缓存表统计信息过期之前的
information_schema_stats_expiry
时间段。默认值为 86400 秒（24 小时）。如果没有缓存统计信息或统计信息已过期，则在查询表统计信息列时从存储引擎中检索统计信息。要随时更新给定表的缓存值，请使用ANALYZE TABLE
information_schema_stats_expiry
可以设置为0让
INFORMATION_SCHEMA查询直接从存储引擎检索最新的统计信息，这不如检索缓存的统计信息快。
有关详细信息，请参阅
第 8.2.3 节，“优化 INFORMATION_SCHEMA 查询”。
INFORMATION_SCHEMAMySQL 8.0 中的表与数据字典紧密相关，导致了一些用法上的差异。请参阅
第 14.7 节，“数据字典用法差异”。
© Mysql 中文网
