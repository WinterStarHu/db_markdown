# 23.5.23 ndb_restore — 恢复 NDB Cluster 备份_MySQL 8.0 参考手册

23.5.23 ndb_restore — 恢复 NDB Cluster 备份_MySQL 8.0 参考手册
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
23.5.23.1 将 NDB 备份恢复到不同版本的 NDB Cluster
23.5.23.2 恢复到不同数量的数据节点
23.5.23.3 从并行备份恢复
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
23.5.23 ndb_restore — 恢复 NDB Cluster 备份
23.5.23 ndb_restore — 恢复 NDB Cluster 备份
23.5.23.1 将 NDB 备份恢复到不同版本的 NDB Cluster23.5.23.2 恢复到不同数量的数据节点23.5.23.3 从并行备份恢复
NDB Cluster 恢复程序作为单独的命令行实用程序ndb_restore 实现，通常可以在 MySQLbin
目录中找到。该程序读取作为备份结果创建的文件，并将存储的信息插入数据库。
在 NDB 7.6 及更早版本
中，由于对
测试库的不必要依赖，此程序在其运行完成时打印。此依赖项已在 NDB 8.0 中删除，从而消除了无关的输出。
NDBT_ProgramExit -
statusNDBT
ndb_restore必须为
START BACKUP用于创建备份的命令创建的每个备份文件执行一次（请参阅
第 23.6.8.2 节，“使用 NDB Cluster Management Client 创建备份”）。这等于创建备份时集群中的数据节点数。
笔记
在使用ndb_restore之前，建议集群以单用户模式运行，除非您并行恢复多个数据节点。有关更多信息，请参阅
第 23.6.6 节，“NDB Cluster 单用户模式”。
下表显示了
可与ndb_restore一起使用的选项。表后有其他说明。
表 23.42 与程序 ndb_restore 一起使用的命令行选项
格式
描述
添加、弃用或删除
--allow-pk-changes[=0|1]
允许更改构成表主键的列集
添加：NDB 8.0.21
--append
将数据附加到制表符分隔的文件
（支持所有基于 MySQL 8.0 的 NDB 版本）
--backup-password=password
使用 --decrypt 提供用于解密加密备份的密码；查看允许值的文档
添加：NDB 8.0.22
--backup-password-from-stdin
从 STDIN 以安全的方式获取解密密码；与 --decrypt 选项一起使用
添加：NDB 8.0.24
--backup-path=path
备份文件目录的路径
（支持所有基于 MySQL 8.0 的 NDB 版本）
--backupid=#,
-b
#
从具有此 ID 的备份中恢复
（支持所有基于 MySQL 8.0 的 NDB 版本）
--character-sets-dir=path
包含字符集的目录
删除：8.0.31
--connect=connection_string,
-c
connection_string
--connectstring 的别名
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
（支持所有基于 MySQL 8.0 的 NDB 版本）
--decrypt
解密加密备份；需要--备份密码
添加：NDB 8.0.22
--defaults-extra-file=path
读取全局文件后读取给定文件
（支持所有基于 MySQL 8.0 的 NDB 版本）
--defaults-file=path
仅从给定文件中读取默认选项
（支持所有基于 MySQL 8.0 的 NDB 版本）
--defaults-group-suffix=string
还阅读带有 concat(group, suffix) 的组
（支持所有基于 MySQL 8.0 的 NDB 版本）
--disable-indexes
导致备份中的索引被忽略；可能会减少恢复数据所需的时间
（支持所有基于 MySQL 8.0 的 NDB 版本）
--dont-ignore-systab-0,
-f
恢复时不要忽略系统表；仅限实验；不用于生产
（支持所有基于 MySQL 8.0 的 NDB 版本）
--exclude-databases=list
要排除的一个或多个数据库的列表（包括那些未命名的）
（支持所有基于 MySQL 8.0 的 NDB 版本）
--exclude-intermediate-sql-tables[=TRUE|FALSE]
不要恢复复制 ALTER TABLE 操作遗留下来的任何中间表（名称以“#sql-”为前缀）；指定 FALSE 以恢复此类表
（支持所有基于 MySQL 8.0 的 NDB 版本）
--exclude-missing-columns
导致数据库中表版本中缺少的表备份版本中的列被忽略
（支持所有基于 MySQL 8.0 的 NDB 版本）
--exclude-missing-tables
导致数据库中缺少的备份表被忽略
（支持所有基于 MySQL 8.0 的 NDB 版本）
--exclude-tables=list
要排除的一个或多个表的列表（包括同一数据库中未命名的表）；每个表引用必须包含数据库名称
（支持所有基于 MySQL 8.0 的 NDB 版本）
--fields-enclosed-by=char
字段被这个字符包围
（支持所有基于 MySQL 8.0 的 NDB 版本）
--fields-optionally-enclosed-by
字段可选地由这个字符括起来
（支持所有基于 MySQL 8.0 的 NDB 版本）
--fields-terminated-by=char
字段以此字符终止
（支持所有基于 MySQL 8.0 的 NDB 版本）
--help,
-?
显示帮助文本并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--hex
以十六进制格式打印二进制类型
（支持所有基于 MySQL 8.0 的 NDB 版本）
--ignore-extended-pk-updates[=0|1]
忽略包含对现在包含在扩展主键中的列的更新的日志条目
添加：NDB 8.0.21
--include-databases=list
要恢复的一个或多个数据库的列表（不包括未命名的数据库）
（支持所有基于 MySQL 8.0 的 NDB 版本）
--include-stored-grants
将共享用户和授权恢复到 ndb_sql_metadata 表
添加：NDB 8.0.19
--include-tables=list
要恢复的一个或多个表的列表（不包括同一数据库中未命名的表）；每个表引用必须包含数据库名称
（支持所有基于 MySQL 8.0 的 NDB 版本）
--lines-terminated-by=char
行以此字符结束
（支持所有基于 MySQL 8.0 的 NDB 版本）
--login-path=path
从登录文件中读取给定路径
（支持所有基于 MySQL 8.0 的 NDB 版本）
--lossy-conversions,
-L
从备份恢复数据时允许列值的有损转换（类型降级或符号更改）
（支持所有基于 MySQL 8.0 的 NDB 版本）
--no-binlog
如果连接了 mysqld 并使用二进制日志记录，则不记录恢复的数据
（支持所有基于 MySQL 8.0 的 NDB 版本）
--no-defaults
不要从登录文件以外的任何选项文件中读取默认选项
（支持所有基于 MySQL 8.0 的 NDB 版本）
--no-restore-disk-objects,
-d
不要恢复与磁盘数据相关的对象
（支持所有基于 MySQL 8.0 的 NDB 版本）
--no-upgrade,
-u
不要升级尚未调整 VAR 数据大小的 varsize 属性的数组类型，也不要更改列属性
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
--ndb-nodegroup-map=map,
-z
指定节点组映射；未使用，不受支持
（支持所有基于 MySQL 8.0 的 NDB 版本）
--ndb-nodeid=#
为此节点设置节点 ID，覆盖 --ndb-connectstring 设置的任何 ID
（支持所有基于 MySQL 8.0 的 NDB 版本）
--ndb-optimized-node-selection
为交易节点的选择启用优化。默认启用；使用 --skip-ndb-optimized-node-selection 禁用
删除：8.0.31
--nodeid=#,
-n
#
进行备份的节点 ID
（支持所有基于 MySQL 8.0 的 NDB 版本）
--num-slices=#
按切片恢复时要应用的切片数
添加：NDB 8.0.20
--parallelism=#,
-p
#
恢复数据时使用的并行事务数
（支持所有基于 MySQL 8.0 的 NDB 版本）
--preserve-trailing-spaces,
-P
将固定宽度字符串类型提升为可变宽度类型时允许保留尾随空格（包括填充）
（支持所有基于 MySQL 8.0 的 NDB 版本）
--print
将元数据、数据和日志打印到标准输出（相当于 --print-meta --print-data --print-log）
（支持所有基于 MySQL 8.0 的 NDB 版本）
--print-data
将数据打印到标准输出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--print-defaults
打印程序参数列表并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--print-log
将日志打印到标准输出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--print-meta
将元数据打印到标准输出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--print-sql-log
将 SQL 日志写入标准输出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--progress-frequency=#
每个给定秒数的恢复打印状态
（支持所有基于 MySQL 8.0 的 NDB 版本）
--promote-attributes,
-A
从备份恢复数据时允许提升属性
（支持所有基于 MySQL 8.0 的 NDB 版本）
--rebuild-indexes
导致备份中找到的有序索引的多线程重建；使用的线程数由设置 BuildIndexThreads 决定
（支持所有基于 MySQL 8.0 的 NDB 版本）
--remap-column=string
使用指示的函数和参数将偏移量应用于指定列的值。格式为 [db].[tbl].[col]:[fn]:[args]；有关详细信息，请参阅文档
添加：NDB 8.0.21
--restore-data,
-r
使用 NDB API 将表数据和日志恢复到 NDB Cluster
（支持所有基于 MySQL 8.0 的 NDB 版本）
--restore-epoch,
-e
将 epoch 信息恢复到状态表中；在副本集群上用于启动复制很有用；在 mysql.ndb_apply_status 中更新或插入 ID 为 0 的行
（支持所有基于 MySQL 8.0 的 NDB 版本）
--restore-meta,
-m
使用 NDB API 将元数据还原到 NDB Cluster
（支持所有基于 MySQL 8.0 的 NDB 版本）
--restore-privilege-tables
恢复之前移动到 NDB 的 MySQL 特权表
已弃用：NDB 8.0.16
--rewrite-database=string
恢复到不同名称的数据库；格式为 olddb,newdb
（支持所有基于 MySQL 8.0 的 NDB 版本）
--skip-broken-objects
忽略备份文件中丢失的 blob 表
（支持所有基于 MySQL 8.0 的 NDB 版本）
--skip-table-check,
-s
还原期间跳过表结构检查
（支持所有基于 MySQL 8.0 的 NDB 版本）
--skip-unknown-objects
导致在将从较新的 NDB 版本制作的备份还原到旧版本时忽略 ndb_restore 无法识别的模式对象
（支持所有基于 MySQL 8.0 的 NDB 版本）
--slice-id=#
切片ID，按切片恢复时
添加：NDB 8.0.20
--tab=path,
-T
path
为提供的路径中的每个表创建一个制表符分隔的 .txt 文件
（支持所有基于 MySQL 8.0 的 NDB 版本）
--usage,
-?
显示帮助文本并退出；与 --help 相同
（支持所有基于 MySQL 8.0 的 NDB 版本）
--verbose=#
输出的冗长程度
（支持所有基于 MySQL 8.0 的 NDB 版本）
--version,
-V
显示版本信息并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--with-apply-status
恢复 ndb_apply_status 表。需要 --restore-data
添加：NDB 8.0.29
--allow-pk-changes
命令行格式
--allow-pk-changes[=0|1]
介绍
8.0.21-ndb-8.0.21
类型
整数
默认值
0
最小值
0
最大值
1
当此选项设置为时1，
ndb_restore允许表定义中的主键与备份中同一表的主键不同。当在一个或多个表上的主键更改的不同模式版本之间备份和恢复时，这可能是可取的，并且看起来使用 ndb_restore 执行恢复操作比
ALTER TABLE在恢复表模式和数据后发出许多语句更简单或更有效。
支持主键定义的以下更改--allow-pk-changes：
扩展主键：备份中表架构中存在的不可为空的列成为数据库中表主键的一部分。
重要的
扩展表的主键时，在进行备份时不得更新任何成为主键一部分的列；ndb_restore发现的任何此类更新都会导致恢复操作失败，即使值没有发生变化也是如此。在某些情况下，可以使用
--ignore-extended-pk-updates
选项覆盖此行为；有关详细信息，请参阅此选项的说明。
收缩主键（1）：在备份模式中已经是表主键一部分的列不再是主键的一部分，但保留在表中。
收缩主键 (2)：在备份模式中已经是表主键一部分的列从表中完全删除。
这些差异可以与ndb_restore支持的其他模式差异相结合，包括对需要使用暂存表的 blob 和文本列的更改。
此处列出了使用主键架构更改的典型场景中的基本步骤：
使用ndb_restore
恢复表模式
--restore-meta
将模式更改为所需的模式，或创建它
备份所需的模式
使用上一步的备份
运行ndb_restore ，以删除索引和约束
--disable-indexes
运行ndb_restore
--allow-pk-changes
（可能连同
--ignore-extended-pk-updates,
--disable-indexes和其他可能需要的选项）来恢复所有数据
使用使用所需模式制作的备份
运行ndb_restore ，以重建索引和约束
--rebuild-indexes
扩展主键时， ndb_restore
可能需要
在还原操作期间使用临时辅助唯一索引从旧主键映射到新主键。仅当需要将备份日志中的事件应用到具有扩展主键的表时才创建此类索引。这个索引被命名为
NDB$RESTORE_PK_MAPPING，并在每个需要它的表上创建；如有必要，它可以由
并行运行的多个ndb_restore实例共享。（在恢复过程结束时
运行
ndb_restore会导致该索引被删除。）
--rebuild-indexes
--append
命令行格式
--append
当与--tab
和--print-data
选项一起使用时，这会导致数据附加到任何具有相同名称的现有文件。
--backup-path=dir_name
命令行格式
--backup-path=path
类型
目录名称
默认值
./
备份目录的路径是必需的；这是使用
选项提供给ndb_restore--backup-path的，并且必须包括与要恢复的备份的 ID 备份对应的子目录。例如，如果数据节点的
DataDir是
/var/lib/mysql-cluster，那么备份目录是
/var/lib/mysql-cluster/BACKUP，ID 为 3 的备份的备份文件可以在
/var/lib/mysql-cluster/BACKUP/BACKUP-3. 该路径可以是绝对路径或相对于ndb_restore可执行文件所在目录的路径，并且可以选择以
backup-path=.
可以将备份恢复到具有与创建时不同的配置的数据库。例如，假设备份 ID 为 的备份
12是在具有两个节点 ID为2和
的存储节点的集群中创建的3，要恢复到具有四个节点的集群。然后ndb_restore必须运行两次——对集群中进行备份的每个存储节点运行一次。但是，
ndb_restore不能总是将运行一个版本的 MySQL 的集群所做的备份还原到运行不同 MySQL 版本的集群。看
第 23.3.7 节，“升级和降级 NDB Cluster”，了解更多信息。
重要的
无法使用旧版本的
ndb_restore恢复从新版本的 NDB Cluster 制作的备份。您可以将由较新版本的 MySQL 制作的备份还原到较旧的集群，但您必须使用
来自较新 NDB Cluster 版本
的ndb_restore副本才能执行此操作。
例如，要将从运行 NDB Cluster 8.0.32 的集群中获取的集群备份恢复到运行 NDB Cluster 7.6.25 的集群，您必须使用NDB Cluster 7.6.25发行版附带的 ndb_restore。
为了更快速地恢复，可以并行恢复数据，前提是有足够数量的可用集群连接。也就是说，当并行恢复到多个节点时，您必须
在集群文件中有一个[api]或部分可用于每个并发的ndb_restore
进程。但是，数据文件必须始终在日志之前应用。
[mysqld]config.ini
--backup-password=password
命令行格式
--backup-password=password
介绍
8.0.22-ndb-8.0.22
类型
细绳
默认值
[none]
此选项指定使用该选项解密加密备份时要使用的密码
--decrypt。这必须与用于加密备份的密码相同。
密码长度为1～256个字符，必须用单引号或双引号括起来。它可以包含字符代码为 32、35、38、40-91、93、95 和 97-126 的任何 ASCII 字符；换句话说，它可以使用除
!, ',
", $,
%, \, 和
之外的任何可打印的 ASCII 字符^。
在 MySQL 8.0.24 及更高版本中，可以省略密码，在这种情况下，ndb_restore
等待它从.
stdin--backup-password-from-stdin
--backup-password-from-stdin[=TRUE|FALSE]
命令行格式
--backup-password-from-stdin
介绍
8.0.24-ndb-8.0.24
当用于代替 时
--backup-password，此选项启用从系统 shell ( stdin) 输入备份密码，类似于
在不在命令行上提供密码
的情况下使用 以
交互方式向mysql提供密码时的做法。--password
--backupid= #,
-b
命令行格式
--backupid=#
类型
数字
默认值
none
此选项用于指定备份的 ID 或序列号，与管理客户端在
备份完成时显示的消息中显示的编号相同。（请参阅
第 23.6.8.2 节，“使用 NDB Cluster Management Client 创建备份”。）
Backup
backup_id completed
重要的
还原集群备份时，必须确保从具有相同备份 ID 的备份中还原所有数据节点。使用来自不同备份的文件充其量只能将集群恢复到不一致的状态，并且很可能完全失败。
在 NDB 8.0 中，此选项是必需的。
--character-sets-dir
命令行格式
--character-sets-dir=path
删除
8.0.31
包含字符集的目录。
--connect,
-c
命令行格式
--connect=connection_string
类型
细绳
默认值
localhost:1186
的别名
--ndb-connectstring。
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
写入核心文件出错；在调试中使用。
--decrypt
命令行格式
--decrypt
介绍
8.0.22-ndb-8.0.22
使用选项提供的密码解密加密备份--backup-password
。
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
--disable-indexes
命令行格式
--disable-indexes
NDB在从本机备份
恢复数据期间禁用索引恢复。之后，您可以使用 多线程索引构建一次恢复所有表的索引
--rebuild-indexes，这应该比同时为非常大的表重建索引更快。
在 NDB 8.0.27 及更高版本中，此选项还会删除备份中指定的任何外键。
在 NDB 8.0.29 之前，尝试从 MySQL 访问
NDB一个无法找到一个或多个索引的表总是被拒绝并返回错误
Index not found。从 NDB 8.0.29 开始，MySQL 可以打开这样的表，前提是查询不使用任何受影响的索引；否则查询被拒绝
。
在后一种情况下，您可以通过执行如下语句
暂时解决该问题：4243 ER_NOT_KEYFILEALTER TABLEALTER TABLE tbl ALTER INDEX idx INVISIBLE;
这会导致 MySQL 忽略idx
表上的索引tbl。有关详细信息，请参阅
主键和索引。
--dont-ignore-systab-0,
-f
命令行格式
--dont-ignore-systab-0
通常，在恢复表数据和元数据时，
ndb_restore 会NDB忽略备份中存在的系统表
副本
。--dont-ignore-systab-0导致系统表被恢复。此选项仅供实验和开发使用，不建议在生产环境中使用。
--exclude-databases=db-list
命令行格式
--exclude-databases=list
类型
细绳
默认值
不应恢复的一个或多个数据库的逗号分隔列表。
此选项通常与
--exclude-tables;结合使用 有关更多信息和示例，请参阅该选项的描述。
--exclude-intermediate-sql-tables[=TRUE|FALSE]
命令行格式
--exclude-intermediate-sql-tables[=TRUE|FALSE]
类型
布尔值
默认值
TRUE
执行复制ALTER
TABLE操作时，mysqld
创建中间表（其名称以 为前缀
#sql-）。当 时TRUE，该
--exclude-intermediate-sql-tables选项会阻止ndb_restore恢复这些操作可能遗留下来的此类表。这个选项是TRUE默认的。
--exclude-missing-columns
命令行格式
--exclude-missing-columns
可以使用此选项仅还原选定的表列，这会导致ndb_restore忽略与备份中找到的那些表的版本相比，正在还原的表中丢失的任何列。此选项适用于所有正在恢复的表。如果您希望仅将此选项应用于选定的表或数据库，您可以将它与本节其他地方描述的一个或多个选项结合使用--include-*，
--exclude-*然后使用这些的补充集将数据恢复到其余表选项。
--exclude-missing-tables
命令行格式
--exclude-missing-tables
可以使用此选项仅还原选定的表，这会导致ndb_restore忽略备份中未在目标数据库中找到的任何表。
--exclude-tables=table-list
命令行格式
--exclude-tables=list
类型
细绳
默认值
要排除的一个或多个表的列表；每个表引用必须包含数据库名称。常与 一起使用
--exclude-databases。
使用--exclude-databases
or时--exclude-tables，只排除选项命名的那些数据库或表；所有其他数据库和表都由
ndb_restore恢复。
此 table 显示了
使用
选项的ndb_restore--exclude-*的几个调用（为清楚起见，省略了可能需要的其他选项），以及这些选项对从 NDB Cluster 备份恢复的影响：
表 23.43 使用 --exclude-* 选项的 ndb_restore 的几次调用，以及这些选项对从 NDB Cluster 备份恢复的影响。
选项
结果
--exclude-databases=db1
所有数据库中的所有表都db1被恢复；中没有表db1被恢复
--exclude-databases=db1,db2（或
--exclude-databases=db1
--exclude-databases=db2）
所有数据库中除db1和
之外的所有表都db2被恢复；没有表
db1或未db2恢复
--exclude-tables=db1.t1
除t1数据库
中的所有表db1都已恢复；中的所有其他表db1都已恢复；恢复所有其他数据库中的所有表
--exclude-tables=db1.t2,db2.t1（或者
--exclude-tables=db1.t2
--exclude-tables=db2.t1)
数据库中db1除表外的
t2所有表和数据库中
db2除表
外的所有表t1都被恢复；没有其他表
db1或被db2恢复；恢复所有其他数据库中的所有表
您可以同时使用这两个选项。例如，以下会导致所有数据库中的所有表
被恢复
，除了数据库
db1和，以及数据库中的db2表t1和：t2db3$> ndb_restore [...] --exclude-databases=db1,db2 --exclude-tables=db3.t1,db3.t2
（同样，为了清楚和简洁起见，我们从刚刚显示的示例中省略了其他可能必要的选项。）
您可以一起使用--include-*和
--exclude-*选项，但要遵守以下规则：
all--include-*和
--exclude-*options 的动作是累积的。
所有--include-*和
--exclude-*选项都按照传递给 ndb_restore 的顺序进行评估，从右到左。
如果选项发生冲突，第一个（最右边）的选项优先。换句话说，与给定数据库或表匹配的第一个选项（从右到左）“获胜”。
例如，以下选项集导致
ndb_restore从数据库中恢复所有表，db1除了
db1.t1，同时不从任何其他数据库恢复其他表：
--include-databases=db1 --exclude-tables=db1.t1
然而，颠倒刚刚给出的选项的顺序只会导致数据库
db1中的所有表被恢复（包括
db1.t1，但不包括任何其他数据库中的表），因为
--include-databases
最右边的选项是与数据库的第一个匹配项db1，因此需要优先于匹配的任何其他选项
db1或任何表
db1：
--exclude-tables=db1.t1 --include-databases=db1
--fields-enclosed-by=char
命令行格式
--fields-enclosed-by=char
类型
细绳
默认值
每个列值都包含在传递给此选项的字符串中（无论数据类型如何；请参阅 的说明
--fields-optionally-enclosed-by）。
--fields-optionally-enclosed-by
命令行格式
--fields-optionally-enclosed-by
类型
细绳
默认值
传递给此选项的字符串用于包含包含字符数据（例如
CHAR、
VARCHAR、
BINARY、
TEXT或
ENUM）的列值。
--fields-terminated-by=char
命令行格式
--fields-terminated-by=char
类型
细绳
默认值
\t (tab)
传递给此选项的字符串用于分隔列值。默认值为制表符 ( \t)。
--help
命令行格式
--help
显示帮助文本并退出。
--hex
命令行格式
--hex
如果使用此选项，所有二进制值都以十六进制格式输出。
--ignore-extended-pk-updates
命令行格式
--ignore-extended-pk-updates[=0|1]
介绍
8.0.21-ndb-8.0.21
类型
整数
默认值
0
最小值
0
最大值
1
使用 时
--allow-pk-changes，在进行备份时不得更新成为表主键一部分的列；这些列应该保持相同的值，从时间值插入到它们，直到包含值的行被删除。如果ndb_restore在还原备份时遇到对这些列的更新，则还原失败。因为某些应用程序可能会在更新行时为所有列设置值，即使某些列值未更改，备份也可能包括看似更新列但实际上并未修改的日志事件。在这种情况下，您可以设置
--ignore-extended-pk-updates为
1，强制ndb_restore
忽略此类更新。
重要的
当导致这些更新被忽略时，用户有责任确保没有更新成为主键一部分的任何列的值。
有关详细信息，请参阅 的说明
--allow-pk-changes。
--include-databases=db-list
命令行格式
--include-databases=list
类型
细绳
默认值
要恢复的一个或多个数据库的逗号分隔列表。经常与
--include-tables;一起使用 有关更多信息和示例，请参阅该选项的描述。
--include-stored-grants
命令行格式
--include-stored-grants
介绍
8.0.19-ndb-8.0.19
在 NDB 8.0 中，ndb_restore默认情况下不会将共享用户和授权（请参阅
第 23.6.12 节，“权限同步和 NDB_STORED_USER”）恢复到ndb_sql_metadata表中。指定此选项会导致它这样做。
--include-tables=table-list
命令行格式
--include-tables=list
类型
细绳
默认值
要恢复的表的逗号分隔列表；每个表引用必须包含数据库名称。
当使用--include-databases或
时--include-tables，只恢复那些以该选项命名的数据库或表；所有其他数据库和表都被
ndb_restore排除，并且不会被恢复。
下表显示了
使用
选项的ndb_restore--include-*的几个调用（为清楚起见，省略了可能需要的其他选项），以及这些对从 NDB Cluster 备份恢复的影响：
表 23.44 使用 --include-* 选项对 ndb_restore 的几次调用，以及它们对从 NDB Cluster 备份恢复的影响。
选项
结果
--include-databases=db1
db1只恢复数据库中的表；所有其他数据库中的所有表都被忽略
--include-databases=db1,db2（或
--include-databases=db1
--include-databases=db2）
仅恢复数据库中的表db1和
；db2所有其他数据库中的所有表都被忽略
--include-tables=db1.t1
只恢复t1数据库中的表；没有恢复任何其他数据库db1中或任何其他数据库中的其他表db1
--include-tables=db1.t2,db2.t1（或
--include-tables=db1.t2
--include-tables=db2.t1）
只恢复数据库中的表和数据库
t2中db1
的表；、或任何其他数据库中的其他表均未恢复t1db2db1db2
您也可以同时使用这两个选项。例如，以下导致数据库
db1和中的所有表以及
数据库db2中的表和表都被还原（而不是其他数据库或表）：
t1t2db3$> ndb_restore [...] --include-databases=db1,db2 --include-tables=db3.t1,db3.t2
（在刚刚显示的示例中，我们再次省略了其他可能需要的选项。）
也可以仅恢复选定的数据库或从单个数据库中选定的表，而无需任何
--include-*（或
--exclude-*）选项，使用此处显示的语法：
ndb_restore other_options db_name,[db_name[,...] | tbl_name[,tbl_name][,...]]
换句话说，您可以指定要恢复的以下任一项：
来自一个或多个数据库的所有表
来自单个数据库的一个或多个表
--lines-terminated-by=char
命令行格式
--lines-terminated-by=char
类型
细绳
默认值
\n (linebreak)
指定用于结束每行输出的字符串。默认为换行符 ( \n)。
--login-path
命令行格式
--login-path=path
类型
细绳
默认值
[none]
从登录文件中读取给定路径。
--lossy-conversions,
-L
命令行格式
--lossy-conversions
该选项旨在补充该
--promote-attributes
选项。使用--lossy-conversions允许在从备份恢复数据时对列值进行有损转换（类型降级或符号更改）。除了一些例外，管理降级的规则与 MySQL 复制相同；有关属性降级当前支持的特定类型转换的信息，
请参阅
第 17.5.1.9.2 节，“具有不同数据类型的列的复制” 。
从 NDB 8.0.26 开始，此选项还可以将NULL列还原为
NOT NULL. 该列不得包含任何
NULL条目；否则
ndb_restore会因错误而停止。
ndb_restore报告它在每个属性和列的有损转换期间执行的任何数据截断。
--no-binlog
命令行格式
--no-binlog
此选项可防止任何连接的 SQL 节点将ndb_restore恢复的数据写入其二进制日志。
--no-restore-disk-objects,
-d
命令行格式
--no-restore-disk-objects
此选项阻止ndb_restore恢复任何 NDB Cluster 磁盘数据对象，例如表空间和日志文件组；有关这些的更多信息，
请参阅
第 23.6.10 节，“NDB Cluster 磁盘数据表” 。
--no-upgrade,
-u
命令行格式
--no-upgrade
当使用ndb_restore恢复备份时，VARCHAR使用旧的固定格式创建的列将使用现在使用的可变宽度格式调整大小并重新创建。可以通过指定来覆盖此行为
--no-upgrade。
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
--ndb-nodegroup-map= map,
-z
命令行格式
--ndb-nodegroup-map=map
旨在将一个节点组的备份恢复到另一个节点组，但从未完全实现；不受支持。
NDB 8.0.27 中删除了所有支持此选项的代码；在此版本和更高版本中，为它设置的任何值都将被忽略，并且该选项本身不执行任何操作。
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
--nodeid= #,
-n
命令行格式
--nodeid=#
类型
数字
默认值
none
指定在其上进行备份的数据节点的节点 ID。
当还原到具有与进行备份的数据节点数量不同的数据节点的集群时，此信息有助于识别要还原到给定节点的正确的一组或多组文件。（在这种情况下，通常需要将多个文件恢复到单个数据节点。）有关
其他信息和示例，
请参阅第 23.5.23.2 节，“恢复到不同数量的数据节点” 。
在 NDB 8.0 中，此选项是必需的。
--num-slices=#
命令行格式
--num-slices=#
介绍
8.0.20-ndb-8.0.20
类型
整数
默认值
1
最小值
1
最大值
1024
按切片还原备份时，此选项设置要将备份划分为的切片数。这允许ndb_restore的多个实例
并行恢复不相交的子集，从而可能减少执行恢复操作所需的时间。
切片是给定备份中数据的子集
；也就是说，它是一组具有相同切片 ID 的片段，使用
--slice-id选项指定。这两个选项必须始终一起使用，并且设置的值--slice-id必须始终小于切片数。
ndb_restore遇到片段并为每个片段分配一个片段计数器。按分片恢复时，为每个分片分配一个分片ID；此切片 ID 在 0 到 1 的范围内，小于切片数。对于不是表的
BLOB表，使用此处显示的公式确定给定片段所属的切片：
[slice_ID] = [fragment_counter] % [number_of_slices]
对于BLOB表，不使用分片计数器；而是使用片段号以及表的主表 ID
BLOB（回想一下，
在内部NDB将
BLOB值存储在单独的表中）。在这种情况下，给定片段的切片 ID 的计算方式如下所示：
[slice_ID] =
([main_table_ID] + [fragment_ID]) % [number_of_slices]
因此，通过N切片恢复意味着运行ndb_restoreN的实例
，所有实例都带有
（连同任何其他必要的选项）并且每个都带有
,
,
, 等等
。
--num-slices=N--slice-id=1--slice-id=2--slice-id=3slice-id=N-1例子。
假设您要将
在每个数据节点上的节点文件系统BACKUP-1的默认目录中找到的
名为 的备份还原/var/lib/mysql-cluster/BACKUP/BACKUP-3
到具有节点 ID 为 1、2、3 和 4 的四个数据节点的集群。五片，执行以下列表中显示的命令集：
使用ndb_restore
恢复集群元数据
，如下所示：
$> ndb_restore -b 1 -n 1 -m --disable-indexes --backup-path=/home/ndbuser/backups
将集群数据还原到调用
ndb_restore的数据节点，如下所示：
$> ndb_restore -b 1 -n 1 -r --num-slices=5 --slice-id=0 --backup-path=/var/lib/mysql-cluster/BACKUP/BACKUP-1
$> ndb_restore -b 1 -n 1 -r --num-slices=5 --slice-id=1 --backup-path=/var/lib/mysql-cluster/BACKUP/BACKUP-1
$> ndb_restore -b 1 -n 1 -r --num-slices=5 --slice-id=2 --backup-path=/var/lib/mysql-cluster/BACKUP/BACKUP-1
$> ndb_restore -b 1 -n 1 -r --num-slices=5 --slice-id=3 --backup-path=/var/lib/mysql-cluster/BACKUP/BACKUP-1
$> ndb_restore -b 1 -n 1 -r --num-slices=5 --slice-id=4 --backup-path=/var/lib/mysql-cluster/BACKUP/BACKUP-1
$> ndb_restore -b 1 -n 2 -r --num-slices=5 --slice-id=0 --backup-path=/var/lib/mysql-cluster/BACKUP/BACKUP-1
$> ndb_restore -b 1 -n 2 -r --num-slices=5 --slice-id=1 --backup-path=/var/lib/mysql-cluster/BACKUP/BACKUP-1
$> ndb_restore -b 1 -n 2 -r --num-slices=5 --slice-id=2 --backup-path=/var/lib/mysql-cluster/BACKUP/BACKUP-1
$> ndb_restore -b 1 -n 2 -r --num-slices=5 --slice-id=3 --backup-path=/var/lib/mysql-cluster/BACKUP/BACKUP-1
$> ndb_restore -b 1 -n 2 -r --num-slices=5 --slice-id=4 --backup-path=/var/lib/mysql-cluster/BACKUP/BACKUP-1
$> ndb_restore -b 1 -n 3 -r --num-slices=5 --slice-id=0 --backup-path=/var/lib/mysql-cluster/BACKUP/BACKUP-1
$> ndb_restore -b 1 -n 3 -r --num-slices=5 --slice-id=1 --backup-path=/var/lib/mysql-cluster/BACKUP/BACKUP-1
$> ndb_restore -b 1 -n 3 -r --num-slices=5 --slice-id=2 --backup-path=/var/lib/mysql-cluster/BACKUP/BACKUP-1
$> ndb_restore -b 1 -n 3 -r --num-slices=5 --slice-id=3 --backup-path=/var/lib/mysql-cluster/BACKUP/BACKUP-1
$> ndb_restore -b 1 -n 3 -r --num-slices=5 --slice-id=4 --backup-path=/var/lib/mysql-cluster/BACKUP/BACKUP-1
$> ndb_restore -b 1 -n 4 -r --num-slices=5 --slice-id=0 --backup-path=/var/lib/mysql-cluster/BACKUP/BACKUP-1
$> ndb_restore -b 1 -n 4 -r --num-slices=5 --slice-id=1 --backup-path=/var/lib/mysql-cluster/BACKUP/BACKUP-1
$> ndb_restore -b 1 -n 4 -r --num-slices=5 --slice-id=2 --backup-path=/var/lib/mysql-cluster/BACKUP/BACKUP-1
$> ndb_restore -b 1 -n 4 -r --num-slices=5 --slice-id=3 --backup-path=/var/lib/mysql-cluster/BACKUP/BACKUP-1
$> ndb_restore -b 1 -n 4 -r --num-slices=5 --slice-id=4 --backup-path=/var/lib/mysql-cluster/BACKUP/BACKUP-1
如果有足够的插槽用于连接到集群（请参阅--backup-path
选项说明），则可以并行执行此步骤中刚刚显示的所有命令。
像往常一样恢复索引，如下所示：
$> ndb_restore -b 1 -n 1 --rebuild-indexes --backup-path=/var/lib/mysql-cluster/BACKUP/BACKUP-1
最后，使用此处显示的命令恢复纪元：
$> ndb_restore -b 1 -n 1 --restore-epoch --backup-path=/var/lib/mysql-cluster/BACKUP/BACKUP-1
您应该只使用切片来恢复集群数据；恢复元数据、索引或时代信息时不需要使用
--num-slices或
。--slice-id如果这些选项中的一个或两个与控制这些恢复的
ndb_restore选项一起使用，程序将忽略它们。
使用该
--parallelism选项对恢复速度的影响独立于使用多个ndb_restore实例
（--parallelism指定
单个 ndb_restore
线程执行的并行事务的数量）切片或并行恢复所产生的效果，但它可以与 or 一起使用这两个。您应该知道，增加
--parallelism会导致
ndb_restore对集群施加更大的负载；如果系统可以处理这个问题，恢复应该会更快完成。
的值--num-slices不直接取决于与硬件相关的值，例如 CPU 或 CPU 内核的数量、RAM 的数量等，也不取决于 LDM 的数量。
作为同一恢复的一部分，可以在不同的数据节点上为此选项使用不同的值；这样做本身不应产生任何不良影响。
--parallelism= #,
-p
命令行格式
--parallelism=#
类型
数字
默认值
128
最小值
1
最大值
1024
ndb_restore使用单行事务同时应用多行。此参数确定ndb_restore实例尝试使用的并行事务（并发行）的数量默认情况下，这是 128；最小为 1，最大为 1024。
执行插入的工作在所涉及的数据节点中的线程之间并行进行。该机制用于从
.Data文件中恢复批量数据——即数据的模糊快照；它不用于构建或重建索引。更改日志是串行应用的；索引删除和构建是 DDL 操作并单独处理。还原的客户端没有线程级并行性。
--preserve-trailing-spaces,
-P
命令行格式
--preserve-trailing-spaces
CHAR在将固定宽度字符数据类型提升为其等价的可变宽度字符数据类型时，即在将列值提升为
VARCHAR，或将
BINARY列值
提升为 时，导致保留尾随空格
VARBINARY。否则，在将这些列值插入新列时，将从这些列值中删除任何尾随空格。
笔记
尽管您可以
CHAR将列提升为
VARCHAR和
BINARY列提升为
VARBINARY，但不能VARCHAR将列提升为
CHAR或
VARBINARY列提升为
BINARY。
--print
命令行格式
--print
导致ndb_restore将所有数据、元数据和日志打印到stdout. 相当于同时使用
--print-data、
--print-meta和
--print-log选项。
笔记
使用--print或任何
--print_*选项实际上是在执行空运行。包含一个或多个这些选项会导致任何输出被重定向到stdout；在这种情况下，ndb_restore不会尝试将数据或元数据还原到 NDB Cluster。
--print-data
命令行格式
--print-data
导致ndb_restore将其输出定向到
stdout. 通常与--tab、
--fields-enclosed-by、
--fields-optionally-enclosed-by、
--fields-terminated-by、
--hex和
中的一个或多个一起使用--append。
TEXT并且
BLOB列值总是被截断。此类值在输出中被截断为前 256 个字节。这在使用时目前不能被覆盖--print-data。
--print-defaults
命令行格式
--print-defaults
打印程序参数列表并退出。
--print-log
命令行格式
--print-log
导致ndb_restore将其日志输出到
stdout.
--print-meta
命令行格式
--print-meta
将所有元数据打印到stdout.
print-sql-log
命令行格式
--print-sql-log
将 SQL 语句记录到stdout. 使用选项启用；通常此行为被禁用。该选项在尝试记录之前检查是否所有正在恢复的表都明确定义了主键；对仅具有隐藏主键的表的查询NDB无法转换为有效的 SQL。
此选项不适用于具有
BLOB列的表。
--progress-frequency=N
命令行格式
--progress-frequency=#
类型
数字
默认值
0
最小值
0
最大值
65535
N
在备份过程中每秒钟
打印一份状态报告。0（默认值）导致不打印状态报告。最大值为 65535。
--promote-attributes,
-A
命令行格式
--promote-attributes
ndb_restore支持有限
属性提升，其方式与 MySQL 复制支持的方式大致相同；也就是说，从给定类型的列备份的数据通常可以恢复到使用“更大、相似”类型的列。例如，
CHAR(20)列中的数据可以恢复到声明为VARCHAR(20)、
VARCHAR(30)或
CHAR(30)；列中的数据
MEDIUMINT可以恢复到类型为
INT或
BIGINT。请参阅
第 17.5.1.9.2 节，“复制具有不同数据类型的列”，对于属性提升当前支持的类型转换表。
从 NDB 8.0.26 开始，此选项还可以将NOT NULL列还原为
NULL.
必须显式启用ndb_restore
的属性提升，如下所示：
准备要恢复备份的表。
ndb_restore不能用于重新创建具有与原始定义不同的表；ALTER TABLE
这意味着您必须手动创建表，或者在恢复表元数据之后但在恢复数据之前
更改您希望使用的列。恢复表数据时使用
选项（缩写形式）
调用ndb_restore 。如果不使用此选项，则不会发生属性提升；相反，还原操作因错误而失败。
--promote-attributes-A
字符数据类型和
TEXT或BLOB之间转换时，只能同时进行字符类型（CHARand
VARCHAR）和二进制类型（BINARYand
VARBINARY）之间的转换。例如，您不能
在对ndb_restore
的同一调用中将列提升INT到
的BIGINT同时将
VARCHAR列提升到。
TEXT
不支持在使​​用不同字符集的列之间进行转换TEXT
，并且明确禁止这样做。
当执行字符或二进制类型到
ndb_restoreTEXT或BLOB使用
ndb_restore的转换时，您可能会注意到它创建并使用一个或多个名为
. 之后不需要这些表，并且通常在成功恢复
后由ndb_restore删除。table_name$STnode_id
--rebuild-indexes
命令行格式
--rebuild-indexes
NDB在恢复本机备份
时启用有序索引的多线程重建。使用此选项
的ndb_restore用于构建有序索引的线程数
由BuildIndexThreads
数据节点配置参数和 LDM 数控制。
仅在首次运行ndb_restore
时才需要使用此选项
；--rebuild-indexes这会导致在恢复后续节点时无需再次使用而重建所有有序索引
。您应该在将新行插入数据库之前使用此选项；否则，插入的行可能会在稍后尝试重建索引时导致违反唯一约束。
默认情况下，有序索引的构建与 LDM 的数量并行。BuildIndexThreads
使用数据节点配置参数可以更快地在节点和系统重启期间执行离线索引构建
；此参数对联机执行的ndb_restore删除和重建索引没有影响
。
唯一索引的重建使用磁盘写入带宽进行重做日志记录和本地检查点。此带宽量不足会导致重做缓冲区过载或日志过载错误。在这种情况下，您可以再次运行
ndb_restore
--rebuild-indexes；该过程从发生错误的地方恢复。您也可以在遇到临时错误时执行此操作。您可以无限期地重复执行ndb_restore
--rebuild-indexes；您可以通过减小 的值来阻止此类错误
--parallelism。如果问题是空间不足，可以增加重做日志的大小（FragmentLogFileSize
节点配置参数），或者您可以提高执行 LCP 的速度（MaxDiskWriteSpeed
以及相关参数），以便更快地释放空间。
--remap-column=db.tbl.col:fn:args
命令行格式
--remap-column=string
介绍
8.0.21-ndb-8.0.21
类型
细绳
默认值
[none]
当与 一起使用时
--restore-data，此选项将函数应用于指定列的值。此处列出了参数字符串中的值：
db: 数据库名称，跟在由 执行的任何重命名之后
--rewrite-database。
tbl：表名。
col：要更新的列的名称。此列的类型必须是
INT或
BIGINT。该列也可以但不是必需的
UNSIGNED。
fn：函数名称；目前，唯一支持的名称是offset.
args：提供给函数的参数。目前，仅支持一个参数，即
offset函数要添加的偏移量的大小。支持负值。参数的大小不能超过列类型的有符号变体的大小；例如，如果
col是一
列，则传递给
函数INT的参数的允许范围是
（请参阅
第 11.1.2 节，“整数类型（精确值）- INTEGER、INT、SMALLINT、TINYINT、MEDIUMINT、BIGINT”）。
offset-21474836482147483647
如果将偏移值应用于列会导致上溢或下溢，则还原操作将失败。这可能发生，例如，如果列是
BIGINT，并且该选项尝试在列值为 4294967291 的行上应用偏移值 8，因为4294967291 + 8
= 4294967299 > 4294967295.
当您希望使用 NDB 本机备份将存储在 NDB Cluster 的多个源实例（全部使用相同模式）中的数据合并到单个目标 NDB Cluster 时，此选项可能很有用（请参阅
第 23.6.8.2 节，“使用 NDB Cluster 管理客户端创建备份”）和ndb_restore合并数据，其中主键值和唯一键值在源集群之间重叠，并且作为过程的一部分，有必要将这些值重新映射到不重叠的范围。可能还需要保留表之间的其他关系。为了满足这些要求，可以在同
一次 ndb_restore调用中多次使用该选项来重新映射不同表的列，如下所示：
$> ndb_restore --restore-data --remap-column=hr.employee.id:offset:1000 \
--remap-column=hr.manager.id:offset:1000 --remap-column=hr.firstaiders.id:offset:1000
（也可以使用此处未显示的其他选项。）
--remap-column也可用于更新同一个表的多个列。多个表和列的组合是可能的。同一张表的不同列也可以使用不同的偏移值，像这样：
$> ndb_restore --restore-data --remap-column=hr.employee.salary:offset:10000 \
--remap-column=hr.employee.hours:offset:-10
当源备份包含不应合并的重复表时，您可以通过在应用程序中使用 、 或其他方式来处理此
--exclude-tables问题
--exclude-databases。
可以使用 ; 获取有关要合并的表的结构和其他特征的信息
SHOW CREATE TABLE；ndb_desc
工具；和
MAX()、
MIN()、
LAST_INSERT_ID()和其他 MySQL 函数。
不支持在 NDB Cluster 的单独实例中将更改从合并表复制到未合并表，或从未合并表复制到合并表。
--restore-data,
-r
命令行格式
--restore-data
输出NDB表数据和日志。
--restore-epoch,
-e
命令行格式
--restore-epoch
向集群复制状态表添加（或恢复）纪元信息。这对于在 NDB Cluster 副本上启动复制很有用。使用此选项时，如果列中的
mysql.ndb_apply_statushaving
0中的行id已经存在，则更新；如果该行尚不存在，则插入该行。（请参阅
第 23.7.9 节，“使用 NDB Cluster 复制的 NDB Cluster 备份”。）
--restore-meta,
-m
命令行格式
--restore-meta
此选项导致ndb_restore打印
NDB表元数据。
第一次运行ndb_restore
恢复程序时，还需要恢复元数据。换句话说，您必须重新创建数据库表——这可以通过使用
--restore-meta( -m) 选项运行它来完成。恢复元数据只需要在单个数据节点上完成；这足以将其恢复到整个集群。
在旧版本的 NDB Cluster 中，使用此选项恢复模式的表使用与原始集群相同数量的分区，即使它与新集群的数据节点数量不同。在 NDB 8.0 中，恢复元数据时，这不再是问题；ndb_restore现在使用目标集群的默认分区数，除非本地数据管理器线程的数量也从原始集群中的数据节点改变。
在 NDB 8.0 中使用此选项时，建议通过设置禁用自动同步，
ndb_metadata_check=OFF
直到ndb_restore完成恢复元数据，之后它可以再次打开以同步 NDB 字典中新创建的对象。
笔记
开始恢复备份时，集群应该有一个空数据库。（换句话说，您应该--initial
在执行恢复之前启动数据节点。）
--restore-privilege-tables
命令行格式
--restore-privilege-tables
弃用
8.0.16-ndb-8.0.16
默认情况下， ndb_restore不会恢复在 8.0 版之前的 NDB Cluster 版本中创建的分布式 MySQL 特权表，它不支持 NDB 7.6 及更早版本中实现的分布式特权。此选项导致ndb_restore
恢复它们。
在 NDB 8.0 中，此类表不用于访问控制；作为 MySQL 服务器升级过程的一部分，服务器会InnoDB在其本地创建这些表的副本。有关更多信息，请参阅
第 23.3.7 节，“升级和降级 NDB Cluster”，以及第 6.2.3 节，“授权表”。
--rewrite-database=olddb,newdb
命令行格式
--rewrite-database=string
类型
细绳
默认值
none
此选项可以恢复到与备份中使用的名称不同的数据库。例如，如果备份由名为 的数据库组成
products，您可以将其包含的数据恢复到名为 的数据库inventory，使用此选项如下所示（省略可能需要的任何其他选项）：
$> ndb_restore --rewrite-database=product,inventory
该选项可以在一次ndb_restore调用中多次使用。因此，可以同时从一个名为 的数据库恢复到一个名为
db1的数据库
db2，以及从一个名为 的
数据库恢复db3到一个名为db4
using的数据库--rewrite-database=db1,db2
--rewrite-database=db3,db4。其他
ndb_restore选项可以在多次出现之间使用--rewrite-database。
如果多个选项之间发生冲突
--rewrite-database，则最后
--rewrite-database使用的选项（从左到右阅读）生效。例如，如果--rewrite-database=db1,db2
--rewrite-database=db1,db3被使用，则只有
--rewrite-database=db1,db3被尊重，
--rewrite-database=db1,db2被忽略。也可以从多个数据库还原到单个数据库，以便--rewrite-database=db1,db3
--rewrite-database=db2,db3将所有表和数据从数据库还原db1到
db2数据库db3中。
重要的
使用 将多个备份数据库恢复到单个目标数据库
--rewrite-database时，不会检查表名或其他对象名之间的冲突，并且不保证恢复行的顺序。这意味着在这种情况下，行可能会被覆盖，更新可能会丢失。
--skip-broken-objects
命令行格式
--skip-broken-objects
此选项导致ndb_restore在读取本机备份时忽略损坏的表
NDB，并继续恢复任何剩余的表（未损坏的表）。目前，该
--skip-broken-objects选项仅在缺少 blob 部分表的情况下有效。
--skip-table-check,
-s
命令行格式
--skip-table-check
可以在不恢复表元数据的情况下恢复数据。默认情况下，如果在表数据和表模式之间发现不匹配，
则ndb_restore 会失败并出现错误；此选项会覆盖该行为。
放宽了使用ndb_restore
恢复数据时对列定义不匹配的一些限制；当遇到其中一种类型的不匹配时，ndb_restore不会像以前那样因错误而停止，而是接受数据并将其插入到目标表中，同时向用户发出警告，表明正在这样做。无论是否正在使用任一选项
--skip-table-check或
，都会出现此行为--promote-attributes。列定义中的这些差异具有以下类型：
不同的COLUMN_FORMAT设置 ( FIXED, DYNAMIC,
DEFAULT)
不同的STORAGE设置 ( MEMORY, DISK)
不同的默认值
不同的分发键设置
--skip-unknown-objects
命令行格式
--skip-unknown-objects
此选项导致ndb_restoreNDB在读取本机备份时忽略它无法识别的任何模式对象。这可用于恢复从运行（例如）NDB 7.6 的集群到运行 NDB Cluster 7.5 的集群的备份。
--slice-id=#
命令行格式
--slice-id=#
介绍
8.0.20-ndb-8.0.20
类型
整数
默认值
0
最小值
0
最大值
1023
按切片恢复时，这是要恢复的切片的 ID。此选项始终与 一起使用
--num-slices，并且其值必须始终小于 的值
--num-slices。
更多信息请参见
--num-slices本节其他部分的描述。
--tab= dir_name,
-T dir_name
命令行格式
--tab=path
类型
目录名称
导致--print-data创建转储文件，每个表一个，每个名为
tbl_name.txt. 它需要将文件保存目录的路径作为参数；用于.当前目录。
--usage
命令行格式
--usage
显示帮助文本并退出；一样
--help。
--verbose=#
命令行格式
--verbose=#
类型
数字
默认值
1
最小值
0
最大值
255
设置输出的详细级别。最小为0；最大值为 255。默认值为 1。
--version
命令行格式
--version
显示版本信息并退出。
--with-apply-status
命令行格式
--with-apply-status
介绍
8.0.29-ndb-8.0.29
从备份
ndb_apply_status表中恢复所有行（具有 的行除外server_id = 0，它是使用 生成的
--restore-epoch）。此选项要求
--restore-data也被使用。
如果ndb_apply_status备份中的表已经包含带有 的行server_id =
0，则 ndb_restore
--with-apply-status将其删除。因此，我们建议您在使用
选项
调用 ndb_restore 后
使用
ndb_restore。您还可以与用于恢复集群
的ndb_restore的最后一次调用同时使用。--restore-epoch--with-apply-status--restore-epoch
--with-apply-status
有关详细信息，请参阅
ndb_apply_status 表。
此实用程序的典型选项如下所示：
ndb_restore [-c connection_string] -n node_id -b backup_id \
[-m] -r --backup-path=/path/to/backup/files
通常，从 NDB Cluster 备份恢复时，
ndb_restore至少需要
--nodeid(short form:
-n)、
--backupid(short form:
-b) 和
--backup-path选项。
该-c选项用于指定一个连接字符串，该字符串告诉ndb_restore在哪里可以找到集群管理服务器（请参阅
第 23.4.3.3 节，“NDB 集群连接字符串”）。如果未使用此选项，则ndb_restore 会尝试连接到 上的管理服务器
localhost:1186。该实用程序充当集群 API 节点，因此需要一个空闲连接
“插槽”来连接到集群管理服务器。这意味着在簇文件中必须至少有一个
[api]或[mysqld]部分可以被它使用
。config.ini至少保留一个空的是个好主意[api]由于这个原因，其中的或
[mysqld]部分
config.ini未用于 MySQL 服务器或其他应用程序（请参阅
第 23.4.3.7 节，“在 NDB Cluster 中定义 SQL 和其他 API 节点”）。
在 NDB 8.0.22 及更高版本中，ndb_restore--decrypt可以使用和
解密加密的备份
--backup-password。必须指定这两个选项才能执行解密。START
BACKUP有关创建加密备份的信息，
请参阅管理客户端命令的文档。您可以使用ndb_mgm管理客户端中的命令
验证ndb_restore是否已连接到集群
。您也可以从系统 shell 完成此操作，如下所示：
SHOW$> ndb_mgm -e "SHOW"报错。
ndb_restore报告临时和永久错误。在临时错误的情况下，它可能能够从中恢复，并Restore successful,
but encountered temporary error, please look at
configuration在这种情况下报告。
重要的
使用ndb_restore初始化 NDB Cluster 以用于循环复制后，不会自动创建充当副本的 SQL 节点上的二进制日志，您必须手动创建它们。要创建二进制日志，请
SHOW TABLES在运行之前在该 SQL 节点上发出一条语句START
SLAVE。这是 NDB Cluster 中的一个已知问题。
© Mysql 中文网
