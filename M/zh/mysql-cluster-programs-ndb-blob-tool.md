# 23.5.6 ndb_blob_tool — 检查和修复 NDB 集群表的 BLOB 和 TEXT 列_MySQL 8.0 参考手册

23.5.6 ndb_blob_tool — 检查和修复 NDB 集群表的 BLOB 和 TEXT 列_MySQL 8.0 参考手册
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
23.5.6 ndb_blob_tool — 检查和修复 NDB 集群表的 BLOB 和 TEXT 列
23.5.6 ndb_blob_tool — 检查和修复 NDB 集群表的 BLOB 和 TEXT 列
此工具可用于检查和删除NDB表中孤立的 BLOB 列部分，以及生成列出所有孤立部分的文件。它有时可用于诊断和修复NDB包含
BLOB或
TEXT列的损坏或损坏的表。
ndb_blob_tool
的基本语法如下所示：
ndb_blob_tool [options] table [column, ...]
除非您使用该选项，否则您必须通过包含一个或多个选项、
或
--help
来指定要执行的操作
。这些选项导致ndb_blob_tool检查孤立的 BLOB 部分，删除任何孤立的 BLOB 部分，并分别生成列出孤立的 BLOB 部分的转储文件，本节后面将对此进行更详细的描述。
--check-orphans--delete-orphans--dump-file您还必须在调用ndb_blob_tool
时指定表的名称
。此外，您可以选择在表名后面加上该表中一个或多个列的（逗号分隔）BLOB名称
TEXT。如果未列出任何列，则该工具适用于所有表
BLOB和
TEXT列。如果需要指定数据库，请使用
--database
( -d) 选项。
该--verbose选项在输出中提供有关工具进度的附加信息。
下表显示了
可以与ndb_mgmd一起使用的所有选项。表后有其他说明。
表 23.28 与程序 ndb_blob_tool 一起使用的命令行选项
格式
描述
添加、弃用或删除
--add-missing
编写虚拟 blob 部分以取代那些丢失的部分
添加：NDB 8.0.20
--character-sets-dir=path
包含字符集的目录
删除：8.0.31
--check-missing
检查具有内联部件但缺少部件表中的一个或多个部件的 blob
添加：NDB 8.0.20
--check-orphans
检查没有相应内联部分的 blob 部分
（支持所有基于 MySQL 8.0 的 NDB 版本）
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
--core-file
写入核心文件出错；用于调试
删除：8.0.31
--database=name,
-d
name
要在其中查找表的数据库
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
--delete-orphans
删除没有相应内联部分的 blob 部分
（支持所有基于 MySQL 8.0 的 NDB 版本）
--dump-file=file
将孤立键写入指定文件
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
--usage,
-?
显示帮助文本并退出；与 --help 相同
（支持所有基于 MySQL 8.0 的 NDB 版本）
--verbose,
-v
详细输出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--version,
-V
显示版本信息并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--add-missing
命令行格式
--add-missing
介绍
8.0.20-ndb-8.0.20
对于没有相应 BLOB 部分的 NDB Cluster 表中的每个内联部分，写一个所需长度的虚拟 BLOB 部分，由空格组成。
--character-sets-dir
命令行格式
--character-sets-dir=path
删除
8.0.31
包含字符集的目录。
--check-missing
命令行格式
--check-missing
介绍
8.0.20-ndb-8.0.20
检查 NDB Cluster 表中没有相应 BLOB 部分的内联部分。
--check-orphans
命令行格式
--check-orphans
检查 NDB Cluster 表中没有相应内联部分的 BLOB 部分。
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
--core-file
命令行格式
--core-file
删除
8.0.31
写入核心文件出错；在调试中使用。
--database=db_name,
-d
命令行格式
--database=name
类型
细绳
默认值
[none]
指定要在其中查找表的数据库。
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
--delete-orphans
命令行格式
--delete-orphans
从没有相应内联部分的 NDB Cluster 表中删除 BLOB 部分。
--dump-file=file
命令行格式
--dump-file=file
类型
文件名
默认值
[none]
将孤立的 BLOB 列部分列表写入
file. 写入文件的信息包括每个孤立的 BLOB 部分的表键和 BLOB 部分号。
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
为此节点设置节点 ID，覆盖 --ndb-connectstring 设置的任何 ID。
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
--usage
命令行格式
--usage
显示帮助文本并退出；与 --help 相同。
--verbose
命令行格式
--verbose
在工具的输出中提供有关其进度的额外信息。
--version
命令行格式
--version
显示版本信息并退出。
例子
首先，我们使用此处显示的语句
在数据库
中
创建一个NDB表
：testCREATE TABLEUSE test;
CREATE TABLE btest (
c0 BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
c1 TEXT,
c2 BLOB
)   ENGINE=NDB;
然后我们使用一系列类似于此的语句向该表中插入几行：
INSERT INTO btest VALUES (NULL, 'x', REPEAT('x', 1000));--check-orphans针对此表
运行时
， ndb_blob_tool生成以下输出：
$> ndb_blob_tool --check-orphans --verbose -d test btest
connected
processing 2 blobs
processing blob #0 c1 NDB$BLOB_19_1
NDB$BLOB_19_1: nextResult: res=1
total parts: 0
orphan parts: 0
processing blob #1 c2 NDB$BLOB_19_2
NDB$BLOB_19_2: nextResult: res=0
NDB$BLOB_19_2: nextResult: res=0
NDB$BLOB_19_2: nextResult: res=0
NDB$BLOB_19_2: nextResult: res=0
NDB$BLOB_19_2: nextResult: res=0
NDB$BLOB_19_2: nextResult: res=0
NDB$BLOB_19_2: nextResult: res=0
NDB$BLOB_19_2: nextResult: res=0
NDB$BLOB_19_2: nextResult: res=0
NDB$BLOB_19_2: nextResult: res=0
NDB$BLOB_19_2: nextResult: res=1
total parts: 10
orphan parts: 0
disconnected
NDBT_ProgramExit: 0 - OK
该工具报告没有NDB与 column 关联的 BLOB 列部分c1，即使c1是一个
TEXT列。这是因为，在一个NDB表中，只有前 256 个字节的BLOBor
TEXT列值被内联存储，只有多余的部分（如果有的话）被单独存储；因此，如果在这些类型之一的给定列中没有使用超过 256 字节的值，则不会为该列BLOB创建任何列部分。NDB有关详细信息，请参阅
第 11.7 节，“数据类型存储要求”。
© Mysql 中文网
