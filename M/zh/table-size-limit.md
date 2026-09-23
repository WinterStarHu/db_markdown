# 8.4.6 表大小限制_MySQL 8.0 参考手册

8.4.6 表大小限制_MySQL 8.0 参考手册
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
8.4.6 表大小限制
8.4.6 表大小限制
MySQL 数据库的有效最大表大小通常由操作系统对文件大小的限制决定，而不是由 MySQL 内部限制决定。有关操作系统文件大小限制的最新信息，请参阅特定于您的操作系统的文档。
Windows 用户请注意，FAT 和 VFAT (FAT32)
不适合用于 MySQL 的生产环境。请改用 NTFS。
如果遇到全表错误，可能有以下几种原因：
磁盘可能已满。
您正在使用表并且表空间文件InnoDB中的空间已用完。InnoDB最大表空间大小也是表的最大大小。有关表空间大小限制，请参阅
第 15.22 节，“InnoDB 限制”。
通常，对于大小超过 1TB 的表，建议将表分区为多个表空间文件。
您已达到操作系统文件大小限制。例如，您MyISAM在仅支持最大 2GB 文件大小的操作系统上使用表，并且您已达到数据文件或索引文件的此限制。
您正在使用一个MyISAM表，并且该表所需的空间超出了内部指针大小所允许的范围。MyISAM默认情况下允许数据和索引文件增长到 256TB，但可以将此限制更改为最大允许大小 65,536TB（256 7 − 1 字节）。
如果您需要一个MyISAM大于默认限制的表并且您的操作系统支持大文件，则该CREATE TABLE
语句支持AVG_ROW_LENGTH和
MAX_ROWS选项。请参阅
第 13.1.20 节，“CREATE TABLE 语句”。服务器使用这些选项来确定允许的表有多大。
如果指针大小对于现有表来说太小，您可以更改选项ALTER
TABLE以增加表的最大允许大小。请参阅第 13.1.9 节，“ALTER TABLE 语句”。
ALTER TABLE tbl_name MAX_ROWS=1000000000 AVG_ROW_LENGTH=nnn;
您必须AVG_ROW_LENGTH仅指定具有BLOB或
TEXT列的表；在这种情况下，MySQL 无法仅根据行数来优化所需的空间。
要更改
MyISAM表的默认大小限制，请设置
myisam_data_pointer_size，它设置用于内部行指针的字节数。MAX_ROWS
如果您未指定该选项，则该值用于设置新表的指针大小。的值
myisam_data_pointer_size
可以是2到7。例如，对于使用动态存储格式的表，值4允许表最大4GB；值 6 允许表高达 256TB。使用固定存储格式的表具有更大的最大数据长度。有关存储格式特征，请参阅
第 16.2.3 节，“MyISAM 表存储格式”。
您可以使用以下语句检查最大数据和索引大小：
SHOW TABLE STATUS FROM db_name LIKE 'tbl_name';
您也可以使用myisamchk -dv /path/to/table-index-file。请参阅
第 13.7.7 节，“SHOW 语句”或第 4.6.4 节，“myisamchk — MyISAM 表维护实用程序”。
解决
MyISAM表文件大小限制的其他方法如下：
如果你的大表是只读的，你可以使用
myisampack来压缩它。
myisampack通常将表压缩至少 50%，因此您实际上可以拥有更大的表。myisampack还可以将多个表合并为一个表。请参阅
第 4.6.6 节，“myisampack — 生成压缩的只读 MyISAM 表”。
MySQL 包含一个MERGE库，使您能够处理
MyISAM具有与单个MERGE表相同结构的表的集合。请参阅第 16.7 节，“MERGE 存储引擎”。
您正在使用MEMORY
( HEAP) 存储引擎；在这种情况下，您需要增加
max_heap_table_size系统变量的值。请参阅第 5.1.8 节，“服务器系统变量”。
© Mysql 中文网
