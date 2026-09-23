# 23.5.5 ndb_mgm — NDB 集群管理客户端_MySQL 8.0 参考手册

23.5.5 ndb_mgm — NDB 集群管理客户端_MySQL 8.0 参考手册
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
23.5.5 ndb_mgm — NDB 集群管理客户端
23.5.5 ndb_mgm — NDB 集群管理客户端
运行集群实际上不需要ndb_mgm管理客户端进程
。它的价值在于提供一组用于检查集群状态、启动备份和执行其他管理功能的命令。管理客户端使用 C API 访问管理服务器。高级用户还可以使用此 API 对专用管理进程进行编程，以执行类似于ndb_mgm执行的任务。
要启动管理客户端，需要提供管理服务器的主机名和端口号：
$> ndb_mgm [host_name [port_num]]
例如：
$> ndb_mgm ndb_mgmd.mysql.com 1186
默认主机名和端口号分别为
localhost和 1186。
下表显示了
可以与ndb_mgm一起使用的所有选项。表后有其他说明。
表 23.27 与程序 ndb_mgm 一起使用的命令行选项
格式
描述
添加、弃用或删除
--backup-password-from-stdin
从 STDIN 以安全的方式获取解密密码；与 --execute 和 ndb_mgm START BACKUP 命令一起使用
添加：NDB 8.0.24
--character-sets-dir=path
包含字符集的目录
删除：8.0.31
--connect-retries=#
设置放弃前重试连接的次数；0 表示仅尝试 1 次（不重试）
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
--defaults-extra-file=path
读取全局文件后读取给定文件
（支持所有基于 MySQL 8.0 的 NDB 版本）
--defaults-file=path
仅从给定文件中读取默认选项
（支持所有基于 MySQL 8.0 的 NDB 版本）
--defaults-group-suffix=string
还阅读带有 concat(group, suffix) 的组
（支持所有基于 MySQL 8.0 的 NDB 版本）
--encrypt-backup
每当进行备份时都会导致 START BACKUP 加密，如果用户未提供则提示输入密码
添加：NDB 8.0.24
--execute=command,
-e
command
执行命令并退出
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
--try-reconnect=#,
-t
#
设置放弃前重试连接的次数；--connect-retries 的同义词
（支持所有基于 MySQL 8.0 的 NDB 版本）
--usage,
-?
显示帮助文本并退出；与 --help 相同
（支持所有基于 MySQL 8.0 的 NDB 版本）
--version,
-V
显示版本信息并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--backup-password-from-stdin[=TRUE|FALSE]
命令行格式
--backup-password-from-stdin
介绍
8.0.24-ndb-8.0.24
stdin此选项允许在使用
--execute "START BACKUP"或类似创建备份时
从系统 shell ( ) 输入备份密码。使用此选项也需要使用
--execute。
--character-sets-dir
命令行格式
--character-sets-dir=path
删除
8.0.31
包含字符集的目录。
--connect-retries=#
命令行格式
--connect-retries=#
类型
数字
默认值
3
最小值
0
最大值
4294967295
此选项指定在放弃之前第一次尝试重试连接的次数（客户端总是至少尝试连接一次）。每次尝试等待的时间长度使用 设置
--connect-retry-delay。
--try-reconnect此选项与现在已弃用
的选项同义
。
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
与 相同--ndb-connectstring。
--core-file
命令行格式
--core-file
删除
8.0.31
写入核心文件出错；在调试中使用。
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
--encrypt-backup
命令行格式
--encrypt-backup
介绍
8.0.24-ndb-8.0.24
使用时，此选项会导致对所有备份进行加密。要在运行ndb_mgm时实现这一点，请将选项放在文件的[ndb_mgm]
部分中my.cnf。
--execute=command,
-e command
命令行格式
--execute=command
此选项可用于从系统 shell 向 NDB Cluster 管理客户端发送命令。例如，以下任一项都相当于
SHOW在管理客户端中执行：
$> ndb_mgm -e "SHOW"
$> ndb_mgm --execute="SHOW"
这类似于
--executeor
-e选项如何与
mysql命令行客户端一起工作。请参阅
第 4.2.2.1 节，“在命令行上使用选项”。
笔记
如果要使用此选项传递的管理客户端命令包含任何空格字符，则该命令
必须用引号引起来。可以使用单引号或双引号。如果管理客户端命令不包含空格字符，则引号是可选的。
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
设置用于连接到
ndb_mgmd的连接字符串。语法：[ ][ ] [ ]。覆盖
和中的条目。
nodeid=id;host=hostname:portNDB_CONNECTSTRINGmy.cnf
--ndb-nodeid
命令行格式
--ndb-nodeid=#
类型
整数
默认值
[none]
为此节点设置节点 ID，覆盖由 设置的任何 ID
--ndb-connectstring。
--ndb-mgmd-host
命令行格式
--ndb-mgmd-host=connection_string
类型
细绳
默认值
[none]
与 相同--ndb-connectstring。
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
--try-reconnect=number
命令行格式
--try-reconnect=#
弃用
是的
类型
数字
类型
整数
默认值
12
默认值
3
最小值
0
最大值
4294967295
如果与管理服务器的连接中断，该节点将每 5 秒尝试重新连接一次，直到成功。number
通过使用此选项，可以限制在放弃和报告错误之前
的尝试次数。
此选项已弃用，并会在未来版本中删除。使用
--connect-retries, 代替。
--usage
命令行格式
--usage
显示帮助文本并退出；一样
--help。
--version
命令行格式
--version
显示版本信息并退出。
有关使用ndb_mgm的其他信息
可以在
第 23.6.1 节，“NDB Cluster Management Client 中的命令”中找到。
© Mysql 中文网
