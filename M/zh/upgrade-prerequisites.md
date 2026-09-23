# 2.11.5 准备升级安装_MySQL 8.0 参考手册

2.11.5 准备升级安装_MySQL 8.0 参考手册
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
2.1 一般安装指南
2.2 使用通用二进制文件在 Unix/Linux 上安装 MySQL
2.3 在 Microsoft Windows 上安装 MySQL
2.4 在 macOS 上安装 MySQL
2.5 在 Linux 上安装 MySQL
2.6 使用坚不可摧的Linux网络（ULN）安装MySQL
2.7 在 Solaris 上安装 MySQL
2.8 在 FreeBSD 上安装 MySQL
2.9 从源码安装MySQL
2.10 安装后设置和测试
2.11 升级MySQL
2.11.1 开始之前1
2.11.2 升级路径1
2.11.3 MySQL升级过程升级了什么1
2.11.4 MySQL 8.0 的变化1
2.11.5 准备升级安装1
2.11.6 在 Unix/Linux 上升级 MySQL 二进制或基于包的安装1
2.11.7 使用 MySQL Yum 仓库升级 MySQL1
2.11.8 使用MySQL APT Repository升级MySQL1
2.11.9 使用 MySQL SLES 存储库升级 MySQL1
2.11.10 Windows 升级MySQL1
2.11.11 升级MySQL的Docker安装1
2.11.12 升级故障处理1
2.11.13 重建或修复表或索引1
2.11.14 复制MySQL数据库到另一台机器1
2.12 降级MySQL
2.13 Perl 安装注意事项
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.11 升级MySQL  /
2.11.5 准备升级安装
2.11.5 准备升级安装
在升级到最新的 MySQL 8.0 版本之前，通过执行下述初步检查确保当前 MySQL 5.7 或 MySQL 8.0 服务器实例的升级准备就绪。否则升级过程可能会失败。
小费
考虑使用MySQL Shell 升级检查器实用程序，使您能够验证 MySQL 服务器实例是否已准备好升级。您可以选择计划升级到的目标 MySQL Server 版本，范围从 MySQL Server 8.0.11 到与当前 MySQL Shell 版本号匹配的 MySQL Server 版本号。升级检查器实用程序执行与指定目标版本相关的自动检查，并建议您进行进一步的相关检查，您应该手动进行这些检查。升级检查器适用于 MySQL 5.7 和 8.0 的所有 GA 版本。可以在此处找到 MySQL Shell 的安装说明。
初步检查：
不得存在以下问题：
不得有使用过时数据类型或函数的表。
TIME如果表包含 5.6.4 之前格式的旧时间列（ 、
DATETIME和
TIMESTAMP不支持小数秒精度的列）
，则不支持就地升级到 MySQL 8.0 。如果您的表仍然使用旧的临时列格式，请REPAIR TABLE在尝试就地升级到 MySQL 8.0 之前使用升级它们。有关详细信息，请参阅
MySQL 5.7 参考手册中的
服务器更改。
不得有孤立.frm文件。
触发器不得有缺失的或空的定义器或无效的创建上下文（由表中显示的
,
character_set_client,
collation_connection属性Database
Collation指示
）。必须转储和恢复任何此类触发器以解决问题。
SHOW TRIGGERSINFORMATION_SCHEMA
TRIGGERS
要检查这些问题，请执行以下命令：
mysqlcheck -u root -p --all-databases --check-upgrade
如果mysqlcheck报告任何错误，请更正问题。
不得有使用不支持本机分区的存储引擎的分区表。要识别此类表，请执行此查询：
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE ENGINE NOT IN ('innodb', 'ndbcluster')
AND CREATE_OPTIONS LIKE '%partitioned%';
查询报告的任何表都必须更改为使用
InnoDB或使其成为非分区的。要将表存储引擎更改为InnoDB，请执行以下语句：
ALTER TABLE table_name ENGINE = INNODB;
有关将MyISAM
表转换为 的信息InnoDB，请参阅
第 15.6.1.5 节，“将表从 MyISAM 转换为 InnoDB”。
要使分区表成为非分区表，请执行以下语句：
ALTER TABLE table_name REMOVE PARTITIONING;
一些关键字可能在 MySQL 8.0 中保留，以前没有保留。请参阅第 9.3 节，“关键字和保留字”。这可能会导致以前用作标识符的词变得非法。要修复受影响的语句，请使用标识符引用。请参阅第 9.2 节，“模式对象名称”。
MySQL 5.7
mysql系统数据库中不能有与MySQL 8.0数据字典使用的表同名的表。要识别具有这些名称的表，请执行此查询：
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE LOWER(TABLE_SCHEMA) = 'mysql'
and LOWER(TABLE_NAME) IN
(
'catalogs',
'character_sets',
'check_constraints',
'collations',
'column_statistics',
'column_type_elements',
'columns',
'dd_properties',
'events',
'foreign_key_column_usage',
'foreign_keys',
'index_column_usage',
'index_partitions',
'index_stats',
'indexes',
'parameter_type_elements',
'parameters',
'resource_groups',
'routines',
'schemata',
'st_spatial_reference_systems',
'table_partition_values',
'table_partitions',
'table_stats',
'tables',
'tablespace_files',
'tablespaces',
'triggers',
'view_routine_usage',
'view_table_usage'
);
查询报告的任何表都必须删除或重命名（使用RENAME TABLE）。这也可能需要更改使用受影响表的应用程序。
不得有外键约束名称超过 64 个字符的表。使用此查询来识别具有太长约束名称的表：
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME IN
(SELECT LEFT(SUBSTR(ID,INSTR(ID,'/')+1),
INSTR(SUBSTR(ID,INSTR(ID,'/')+1),'_ibfk_')-1)
FROM INFORMATION_SCHEMA.INNODB_SYS_FOREIGN
WHERE LENGTH(SUBSTR(ID,INSTR(ID,'/')+1))>64);
对于约束名称超过 64 个字符的表，删除约束并使用不超过 64 个字符的约束名称将其添加回来（使用ALTER
TABLE）。
sql_mode不能有系统变量
定义的过时 SQL 模式
。尝试使用过时的 SQL 模式会阻止 MySQL 8.0 启动。应修改使用过时 SQL 模式的应用程序以避免它们。有关 MySQL 8.0 中删除的 SQL 模式的信息，请参阅
服务器更改。
不能有超过 64 个字符的显式定义列名的视图（MySQL 5.7 中允许列名最多 255 个字符的视图）。为避免升级错误，应在升级前更改此类视图。目前，识别列名超过 64 个字符的视图的唯一方法是使用SHOW CREATE VIEW. 您还可以通过查询
INFORMATION_SCHEMA.VIEWS表来检查视图定义。
不得有包含长度超过 255 个字符或 1020 个字节的单个
ENUM或SET列元素的表或存储过程。在 MySQL 8.0 之前，ENUM或SET列元素的最大组合长度为 64K。在MySQL 8.0中，单个ENUM或
SET列元素的最大字符长度为255个字符，最大字节长度为1020字节。（1020 字节限制支持多字节字符集）。在升级到 MySQL 8.0 之前，修改任何超过新​​限制的ENUM或
SET列元素。否则会导致升级失败并出现错误。
在升级到 MySQL 8.0.13 或更高版本之前，共享
InnoDB表空间中必须没有表分区，包括系统表空间和通用表空间。通过查询识别共享表空间中的表分区
INFORMATION_SCHEMA：
如果从 MySQL 5.7 升级，请运行此查询：
SELECT DISTINCT NAME, SPACE, SPACE_TYPE FROM INFORMATION_SCHEMA.INNODB_SYS_TABLES
WHERE NAME LIKE '%#P#%' AND SPACE_TYPE NOT LIKE 'Single';
如果从较早的 MySQL 8.0 版本升级，请运行此查询：
SELECT DISTINCT NAME, SPACE, SPACE_TYPE FROM INFORMATION_SCHEMA.INNODB_TABLES
WHERE NAME LIKE '%#P#%' AND SPACE_TYPE NOT LIKE 'Single';
使用以下命令将表分区从共享表空间移动到 file-per-table 表空间
ALTER TABLE ...
REORGANIZE PARTITION：
ALTER TABLE table_name REORGANIZE PARTITION partition_name
INTO (partition_definition TABLESPACE=innodb_file_per_table);
不得有来自 MySQL 8.0.12 或更低版本的查询和存储的程序定义使用ASCor
子句DESC限定符。GROUP
BY否则，升级到 MySQL 8.0.13 或更高版本可能会失败，复制到 MySQL 8.0.13 或更高版本的副本服务器也可能会失败。有关其他详细信息，请参阅
SQL 更改。
您的 MySQL 5.7 安装不得使用 MySQL 8.0 不支持的功能。此处的任何更改都必须特定于安装，但以下示例说明了要查找的内容：
MySQL 8.0 中删除了一些服务器启动选项和系统变量。请参阅
MySQL 8.0 中删除的功能和
第 1.4 节，“MySQL 8.0 中添加、弃用或删除的服务器和状态变量和选项”。如果您使用其中任何一个，则升级需要更改配置。
示例：因为数据字典提供了有关数据库对象的信息，所以服务器不再检查数据目录中的目录名来查找数据库。因此，该--ignore-db-dir选项是无关紧要的，已被删除。--ignore-db-dir要处理此问题，请从启动配置中删除任何实例
。此外，在升级到 MySQL 8.0 之前删除或移动命名数据目录的子目录。（或者，让 8.0 服务器将这些目录作为数据库添加到数据字典，然后使用删除每个数据库
DROP DATABASE。）
如果您打算
lower_case_table_names
在升级时将设置更改为 1，请确保架构和表名在升级前是小写的。否则，可能会由于架构或表名字母大小写不匹配而发生故障。您可以使用以下查询来检查包含大写字符的架构和表名：
mysql> select TABLE_NAME, if(sha(TABLE_NAME) !=sha(lower(TABLE_NAME)),'Yes','No') as UpperCase from information_schema.tables;
从 MySQL 8.0.19 开始，如果
lower_case_table_names=1，升级过程会检查表和模式名称，以确保所有字符都是小写的。如果发现表或模式名称包含大写字符，则升级过程会失败并出现错误。
笔记
lower_case_table_names
不建议在升级时
更改
设置。
如果由于上述任何问题升级到 MySQL 8.0 失败，服务器将恢复对数据目录的所有更改。在这种情况下，删除所有重做日志文件并在现有数据目录上重新启动 MySQL 5.7 服务器以解决错误。默认情况下，重做日志文件 ( ib_logfile*) 驻留在 MySQL 数据目录中。修复错误后，在
innodb_fast_shutdown=0再次尝试升级之前执行缓慢关闭（通过设置）。
© Mysql 中文网
