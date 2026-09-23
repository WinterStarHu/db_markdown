# 15.9.2 InnoDB 页面压缩_MySQL 8.0 参考手册

15.9.2 InnoDB 页面压缩_MySQL 8.0 参考手册
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
15.9.1 InnoDB 表压缩1
15.9.2 InnoDB 页面压缩1
15.10 InnoDB 行格式
15.11 InnoDB磁盘I/O和文件空间管理
15.12 InnoDB和在线DDL
15.13 InnoDB静态数据加密
15.14 InnoDB 启动选项和系统变量
15.15 InnoDB INFORMATION_SCHEMA 表
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.9 InnoDB 表和页压缩  /
15.9.2 InnoDB 页面压缩
15.9.2 InnoDB 页面压缩
InnoDB支持驻留在file-per-table 表空间中的表的页级压缩
。此功能称为透明页面压缩。通过使用或
指定COMPRESSION属性
启用页面压缩。支持的压缩算法包括和
。
CREATE TABLEALTER TABLEZlibLZ4
支持的平台
页面压缩需要稀疏文件和打孔支持。带有 NTFS 的 Windows 和以下支持 MySQL 的 Linux 平台子集支持页面压缩，其中内核级别提供打孔支持：
RHEL 7 和使用内核版本 3.10.0-123 或更高版本的派生发行版
OEL 5.10 (UEK2) 内核版本 2.6.39 或更高
OEL 6.5 (UEK3) 内核版本 3.8.13 或更高
OEL 7.0 内核版本 3.8.13 或更高版本
SLE11 内核版本 3.0-x
SLE12 内核版本 3.12-x
OES11 内核版本 3.0-x
Ubuntu 14.0.4 LTS 内核版本 3.13 或更高
Ubuntu 12.0.4 LTS 内核版本 3.2 或更高
Debian 7 内核版本 3.2 或更高
笔记
给定 Linux 发行版的所有可用文件系统可能不支持打孔。
页面压缩的工作原理
写入页面时，使用指定的压缩算法对其进行压缩。压缩后的数据被写入磁盘，其中打孔机制从页面末尾释放空块。如果压缩失败，数据将按原样写出。
Linux 上的打孔尺寸
在 Linux 系统上，文件系统块大小是用于打孔的单位大小。因此，页面压缩仅在页面数据可以压缩到小于或等于
InnoDB页面大小减去文件系统块大小的大小时才有效。例如，如果
innodb_page_size=16K文件系统块大小为 4K，则页面数据必须压缩到小于或等于 12K 才能打孔。
Windows 上的打孔尺寸
在 Windows 系统上，稀疏文件的底层基础结构基于 NTFS 压缩。打孔大小是NTFS压缩单位，是NTFS簇大小的16倍。簇大小及其压缩单位如下表所示：
表 15.14 Windows NTFS 簇大小和压缩单位
簇的大小
压缩单元
512字节
8 KB
1 KB
16 KB
2 KB
32 KB
4 KB
64 KB
仅当页面数据可以压缩到小于或等于
InnoDB页面大小减去压缩单元大小的大小时，Windows 系统上的页面压缩才有效。
默认 NTFS 簇大小为 4KB，压缩单元大小为 64KB。这意味着页面压缩对于开箱即用的 Windows NTFS 配置没有任何好处，因为最大值
innodb_page_size也是 64KB。
要在 Windows 上使用页面压缩，必须使用小于 4K 的簇大小创建文件系统，并且
innodb_page_size必须至少是压缩单元大小的两倍。例如，要在 Windows 上进行页面压缩，您可以构建簇大小为 512 字节（压缩单元为 8KB）的文件系统，并使用 16K 或更大InnoDB的
innodb_page_size值进行初始化。
启用页面压缩
要启用页面压缩，请
在语句中指定COMPRESSION属性
。CREATE TABLE例如：
CREATE TABLE t1 (c1 INT) COMPRESSION="zlib";
您还可以在
ALTER TABLE语句中启用页面压缩。但是，
ALTER TABLE ...
COMPRESSION仅更新表空间压缩属性。设置新压缩算法后发生的表空间写入使用新设置，但要将新压缩算法应用于现有页面，您必须使用重建表OPTIMIZE TABLE。
ALTER TABLE t1 COMPRESSION="zlib";
OPTIMIZE TABLE t1;
禁用页面压缩
要禁用页面压缩，请
COMPRESSION=None使用
ALTER TABLE. 设置后发生的对表空间的写入
COMPRESSION=None不再使用页面压缩。OPTIMIZE TABLE要解压缩现有页面，您必须在设置后使用重建表COMPRESSION=None。
ALTER TABLE t1 COMPRESSION="None";
OPTIMIZE TABLE t1;
页面压缩元数据
页面压缩元数据可在
INFORMATION_SCHEMA.INNODB_TABLESPACES
表中的以下列中找到：
FS_BLOCK_SIZE：文件系统块大小，也就是打孔使用的单位大小。
FILE_SIZE：文件的表观大小，表示文件的最大大小，未压缩。
ALLOCATED_SIZE：文件的实际大小，即磁盘上分配的空间量。
笔记
在类 Unix 系统上，以字节为单位显示表观文件大小（相当于
）。要查看磁盘上分配的实际空间量（相当于
），请使用。该
选项以字节而不是块为单位打印分配的空间，以便可以将其与
输出进行比较。
ls -l
tablespace_name.ibdFILE_SIZEALLOCATED_SIZEdu
--block-size=1
tablespace_name.ibd--block-size=1ls -l
用于SHOW CREATE TABLE查看当前页面压缩设置（Zlib、
Lz4或None）。一个表可能包含具有不同压缩设置的混合页面。
在以下示例中，从表中检索 employees 表的页面压缩元数据
INFORMATION_SCHEMA.INNODB_TABLESPACES
。
# Create the employees table with Zlib page compression
CREATE TABLE employees (
emp_no      INT             NOT NULL,
birth_date  DATE            NOT NULL,
first_name  VARCHAR(14)     NOT NULL,
last_name   VARCHAR(16)     NOT NULL,
gender      ENUM ('M','F')  NOT NULL,
hire_date   DATE            NOT NULL,
PRIMARY KEY (emp_no)
) COMPRESSION="zlib";
# Insert data (not shown)
# Query page compression metadata in INFORMATION_SCHEMA.INNODB_TABLESPACES
mysql> SELECT SPACE, NAME, FS_BLOCK_SIZE, FILE_SIZE, ALLOCATED_SIZE FROM
INFORMATION_SCHEMA.INNODB_TABLESPACES WHERE NAME='employees/employees'\G
*************************** 1. row ***************************
SPACE: 45
NAME: employees/employees
FS_BLOCK_SIZE: 4096
FILE_SIZE: 23068672
ALLOCATED_SIZE: 19415040
employees 表的页面压缩元数据显示表观文件大小为 23068672 字节，而实际文件大小（使用页面压缩）为 19415040 字节。文件系统块大小为4096字节，这是用于打孔的块大小。
使用页面压缩识别表
要识别启用了页面压缩的表，您可以查询使用属性
定义的表的列：INFORMATION_SCHEMA.TABLES
CREATE_OPTIONSCOMPRESSIONmysql> SELECT TABLE_NAME, TABLE_SCHEMA, CREATE_OPTIONS FROM INFORMATION_SCHEMA.TABLES
WHERE CREATE_OPTIONS LIKE '%COMPRESSION=%';
+------------+--------------+--------------------+
| TABLE_NAME | TABLE_SCHEMA | CREATE_OPTIONS     |
+------------+--------------+--------------------+
| employees  | test         | COMPRESSION="zlib" |
+------------+--------------+--------------------+
SHOW CREATE TABLE还显示
COMPRESSION属性（如果使用）。
页面压缩限制和使用说明
如果文件系统块大小（或 Windows 上的压缩单元大小）* 2 > ，则禁用页面压缩
innodb_page_size。
驻留在共享表空间（包括系统表空间、临时表空间和通用表空间）中的表不支持页面压缩。
撤消日志表空间不支持页面压缩。
重做日志页面不支持页面压缩。
用于空间索引的 R 树页面未压缩。
属于压缩表 ( ROW_FORMAT=COMPRESSED) 的页面保持原样。
在恢复期间，更新的页面以未压缩的形式写出。
在不支持所用压缩算法的服务器上加载页面压缩表空间会导致 I/O 错误。
在降级到不支持页面压缩的早期版本的 MySQL 之前，解压缩使用页面压缩功能的表。要解压缩表，请运行
ALTER TABLE ...
COMPRESSION=None和OPTIMIZE
TABLE。
如果使用的压缩算法在两个服务器上都可用，则可以在 Linux 和 Windows 服务器之间复制页面压缩表空间。
在将页面压缩的表空间文件从一台主机移动到另一台主机时保留页面压缩需要一个保留稀疏文件的实用程序。
与其他平台相比，在具有 NVMFS 的 Fusion-io 硬件上可以实现更好的页面压缩，因为 NVMFS 旨在利用打孔功能。
使用具有较大
InnoDB页面大小和相对较小文件系统块大小的页面压缩功能可能会导致写入放大。例如，InnoDB64KB 的最大页面大小和 4KB 的文件系统块大小可能会提高压缩率，但也可能会增加对缓冲池的需求，从而导致 I/O 增加和潜在的写入放大。
© Mysql 中文网
