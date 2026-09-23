# 23.5.14 ndb_index_stat — NDB 索引统计实用程序_MySQL 8.0 参考手册

23.5.14 ndb_index_stat — NDB 索引统计实用程序_MySQL 8.0 参考手册
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
23.5.14 ndb_index_stat — NDB 索引统计实用程序
23.5.14 ndb_index_stat — NDB 索引统计实用程序
ndb_index_stat提供有关NDB
表索引的每个片段的统计信息。这包括缓存版本和年龄、每个分区的索引条目数以及索引的内存消耗。
用法
要获取有关给定表的基本索引统计信息
NDB，请调用
ndb_index_stat，如此处所示，将表的名称作为第一个参数，并使用--database
( -d) 选项紧随其后指定包含此表的数据库的名称：
ndb_index_stat table -d database
在这个例子中，我们使用ndb_index_statNDB来获取有关数据库中命名表mytable的此类信息test
：
$> ndb_index_stat -d test mytable
table:City index:PRIMARY fragCount:2
sampleVersion:3 loadTime:1399585986 sampleCount:1994 keyBytes:7976
query cache: valid:1 sampleCount:1994 totalBytes:27916
times in ms: save: 7.133 sort: 1.974 sort per sample: 0.000
NDBT_ProgramExit: 0 - OK
sampleVersion是从中获取统计数据的缓存的版本号。使用该
选项运行
ndb_index_stat--update会导致 sampleVersion 增加。
loadTime显示上次更新缓存的时间。这表示为自 Unix 纪元以来的秒数。
sampleCount是每个分区找到的索引条目数。您可以通过将其乘以片段数（显示为
fragCount）来估算条目总数。
sampleCount可以与SHOW INDEXor
的基数进行比较INFORMATION_SCHEMA.STATISTICS，尽管后两者提供了整个表的视图，而ndb_index_stat提供了每个片段的平均值。
keyBytes是索引使用的字节数。在这个例子中，主键是一个整数，每个索引需要四个字节，所以
keyBytes在这种情况下可以计算如下：
keyBytes = sampleCount * (4 bytes per index) = 1994 * 4 = 7976
也可以使用相应的列定义从中获取此信息
INFORMATION_SCHEMA.COLUMNS（这需要 MySQL 服务器和 MySQL 客户端应用程序）。
totalBytes是表上所有索引消耗的总内存，以字节为单位。
前面示例中显示的时间特定于每次调用ndb_index_stat。
该--verbose选项提供了一些额外的输出，如下所示：
$> ndb_index_stat -d test mytable --verbose
random seed 1337010518
connected
loop 1 of 1
table:mytable index:PRIMARY fragCount:4
sampleVersion:2 loadTime:1336751773 sampleCount:0 keyBytes:0
read stats
query cache created
query cache: valid:1 sampleCount:0 totalBytes:0
times in ms: save: 20.766 sort: 0.001
disconnected
NDBT_ProgramExit: 0 - OK
$>
如果程序的唯一输出是
NDBT_ProgramExit: 0 - OK，这可能表明尚无统计数据存在。要强制创建它们（或更新它们，如果它们已经存在），
请使用该
选项调用ndb_index_stat ，或在mysql客户端的表上执行。
--updateANALYZE TABLE
选项
下表包括特定于 NDB Cluster ndb_index_stat实用程序的选项。表后列出了其他说明。
表 23.36 与程序 ndb_index_stat 一起使用的命令行选项
格式
描述
添加、弃用或删除
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
--delete
删除表的索引统计信息，停止之前配置的任何自动更新
（支持所有基于 MySQL 8.0 的 NDB 版本）
--dump
打印查询缓存
（支持所有基于 MySQL 8.0 的 NDB 版本）
--help,
-?
显示帮助文本并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--login-path=path
从登录文件中读取给定路径
（支持所有基于 MySQL 8.0 的 NDB 版本）
--loops=#
设置执行给定命令的次数；默认为 0
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
--query=#
对第一个键属性执行随机范围查询（必须是 int unsigned）
（支持所有基于 MySQL 8.0 的 NDB 版本）
--sys-drop
删除 NDB 内核中的任何统计表和事件（所有统计信息都将丢失）
（支持所有基于 MySQL 8.0 的 NDB 版本）
--sys-create
在 NDB 内核中创建所有统计表和事件，如果它们都不存在的话
（支持所有基于 MySQL 8.0 的 NDB 版本）
--sys-create-if-not-exist
在 NDB 内核中创建任何尚不存在的统计表和事件
（支持所有基于 MySQL 8.0 的 NDB 版本）
--sys-create-if-not-valid
在删除任何无效的之后，创建 NDB 内核中尚不存在的任何统计表或事件
（支持所有基于 MySQL 8.0 的 NDB 版本）
--sys-check
验证 NDB 系统索引统计信息和事件表是否存在
（支持所有基于 MySQL 8.0 的 NDB 版本）
--sys-skip-tables
不要将 sys-* 选项应用于表
（支持所有基于 MySQL 8.0 的 NDB 版本）
--sys-skip-events
不要将 sys-* 选项应用于事件
（支持所有基于 MySQL 8.0 的 NDB 版本）
--update
更新表的索引统计信息，重新启动之前配置的任何自动更新
（支持所有基于 MySQL 8.0 的 NDB 版本）
--usage,
-?
显示帮助文本并退出；与 --help 相同
（支持所有基于 MySQL 8.0 的 NDB 版本）
--verbose,
-v
打开详细输出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--version,
-V
显示版本信息并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
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
--core-file
命令行格式
--core-file
删除
8.0.31
写入核心文件出错；在调试中使用。
--database=name,
-d name
命令行格式
--database=name
类型
细绳
默认值
[none]
最小值
最大值
包含要查询的表的数据库的名称。
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
--delete
命令行格式
--delete
删除给定表的索引统计信息，停止之前配置的任何自动更新。
--dump
命令行格式
--dump
转储查询缓存的内容。
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
--loops=#
命令行格式
--loops=#
类型
数字
默认值
0
最小值
0
最大值
MAX_INT
重复此命令次数（用于测试）。
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
--query=#
命令行格式
--query=#
类型
数字
默认值
0
最小值
0
最大值
MAX_INT
对第一个键属性执行随机范围查询（必须是 int unsigned）。
--sys-drop
命令行格式
--sys-drop
删除 NDB 内核中的所有统计表和事件。
这会导致所有统计信息丢失。
--sys-create
命令行格式
--sys-create
在 NDB 内核中创建所有统计表和事件。仅当它们以前都不存在时才有效。
--sys-create-if-not-exist
命令行格式
--sys-create-if-not-exist
创建调用程序时尚不存在的任何 NDB 系统统计表或事件（或两者）。
--sys-create-if-not-valid
命令行格式
--sys-create-if-not-valid
在删除任何无效的之后，创建任何尚不存在的 NDB 系统统计表或事件。
--sys-check
命令行格式
--sys-check
验证 NDB 内核中是否存在所有必需的系统统计表和事件。
--sys-skip-tables
命令行格式
--sys-skip-tables
不要将任何--sys-*选项应用于任何统计表。
--sys-skip-events
命令行格式
--sys-skip-events
不要将任何--sys-*选项应用于任何事件。
--update
命令行格式
--update
更新给定表的索引统计信息，并重新启动之前配置的任何自动更新。
--usage
命令行格式
--usage
显示帮助文本并退出；一样
--help。
--verbose
命令行格式
--verbose
打开详细输出。
--version
命令行格式
--version
显示版本信息并退出。
ndb_index_stat 系统选项。
以下选项用于生成和更新 NDB 内核中的统计表。这些选项都不能与统计选项混合使用（请参阅
ndb_index_stat 统计选项）。
--sys-drop
--sys-create
--sys-create-if-not-exist
--sys-create-if-not-valid
--sys-check
--sys-skip-tables
--sys-skip-events
ndb_index_stat 统计选项。
此处列出的选项用于生成索引统计信息。他们使用给定的表和数据库。它们不能与系统选项混合使用（请参阅
ndb_index_stat 系统选项）。
--database
--delete
--update
--dump
--query
© Mysql 中文网
