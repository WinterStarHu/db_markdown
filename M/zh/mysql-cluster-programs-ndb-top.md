# 23.5.29 ndb_top — 查看 NDB 线程的 CPU 使用信息_MySQL 8.0 参考手册

23.5.29 ndb_top — 查看 NDB 线程的 CPU 使用信息_MySQL 8.0 参考手册
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
23.5.29 ndb_top — 查看 NDB 线程的 CPU 使用信息
23.5.29 ndb_top — 查看 NDB 线程的 CPU 使用信息
ndb_top在终端中显示有关 NDB Cluster 数据节点上 NDB 线程 CPU 使用情况的运行信息。每个线程在输出中由两行表示，第一行显示系统统计信息，第二行显示线程的测量统计信息。
ndb_top从 MySQL NDB Cluster 7.6.3 开始可用。
用法
ndb_top [-h hostname] [-t port] [-u user] [-p pass] [-n node_id]
ndb_top连接到作为集群的 SQL 节点运行的 MySQL 服务器。默认情况下，它会尝试连接到运行在
端口 3306 上的mysqldlocalhost，作为未指定密码的 MySQL
root用户。您可以分别使用
--host(-h) 和
--port(-t) 覆盖默认主机和端口。要指定 MySQL 用户和密码，请使用
--user(-u) 和
--passwd(-p) 选项。该用户必须能够读取
ndbinfo数据库中的表（ ndb_top使用来自
ndbinfo.cpustat相关表的信息）。
有关 MySQL 用户帐户和密码的更多信息，请参阅第 6.2 节，“访问控制和帐户管理”。
输出以纯文本或 ASCII 图形形式提供；您可以分别使用--text
( -x) 和
--graph( -g) 选项指定它。这两种显示模式提供相同的信息；它们可以同时使用。必须至少使用一种显示模式。
默认情况下支持并启用图形的颜色显示（--color或-c
选项）。启用颜色支持后，图形显示以蓝色显示 OS 用户时间，以绿色显示 OS 系统时间，以空白显示空闲时间。对于测量的负载，蓝色用于执行时间，黄色用于发送时间，红色用于发送缓冲区已满等待时间，空白用于空闲时间。图形显示中显示的百分比是所有非空闲线程的百分比总和。颜色目前不可配置；您可以使用灰度代替使用
--skip-color.
排序视图 ( --sort,
-r) 基于测量负载的最大值和操作系统报告的负载。可以使用
--measured-load
( -m) 和
--os-load( -o) 选项启用和禁用这些显示。必须启用至少其中一个负载的显示。
该程序尝试从具有
--node-id( -n) 选项给出的节点 ID 的数据节点获取统计信息；如果未指定，则为1。ndb_top
无法提供有关其他类型节点的信息。
视图根据终端窗口的高度和宽度自行调整；支持的最小宽度为 76 个字符。
一旦启动，ndb_top将持续运行，直到被迫退出；您可以使用退出程序
Ctrl-C。显示每秒更新一次；要设置不同的延迟间隔，请使用
--sleep-time
( -s)。
笔记
ndb_top在 macOS、Linux 和 Solaris 上可用。Windows 平台目前不支持它。
下表包括特定于 NDB Cluster 程序ndb_top的所有选项。表后有其他说明。
表 23.50 与程序 ndb_top 一起使用的命令行选项
格式
描述
添加、弃用或删除
--color,
-c
以彩色显示 ASCII 图形；使用 --skip-colors 禁用
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
--graph,
-g
使用图表显示数据；使用 --skip-graphs 禁用
（支持所有基于 MySQL 8.0 的 NDB 版本）
--help
显示程序使用信息
（支持所有基于 MySQL 8.0 的 NDB 版本）
--host=string,
-h
string
要连接的 MySQL 服务器的主机名或 IP 地址
（支持所有基于 MySQL 8.0 的 NDB 版本）
--login-path=path
从登录文件中读取给定路径
（支持所有基于 MySQL 8.0 的 NDB 版本）
--measured-load,
-m
按线程显示测量的负载
（支持所有基于 MySQL 8.0 的 NDB 版本）
--no-defaults
不要从登录文件以外的任何选项文件中读取默认选项
（支持所有基于 MySQL 8.0 的 NDB 版本）
--node-id=#,
-n
#
具有此节点 ID 的监视节点
（支持所有基于 MySQL 8.0 的 NDB 版本）
--os-load,
-o
显示操作系统测量的负载
（支持所有基于 MySQL 8.0 的 NDB 版本）
--password=password,
-p
password
使用此密码连接
（支持所有基于 MySQL 8.0 的 NDB 版本）
--port=#,
-P
#(>=7.6.6)
连接到 MySQL 服务器时使用的端口号
（支持所有基于 MySQL 8.0 的 NDB 版本）
--print-defaults
打印程序参数列表并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--sleep-time=#,
-s
#
显示刷新之间等待的时间，以秒为单位
（支持所有基于 MySQL 8.0 的 NDB 版本）
--socket=path,
-S
path
用于连接的套接字文件
（支持所有基于 MySQL 8.0 的 NDB 版本）
--sort,
-r
按用途对线程进行排序；使用 --skip-sort 禁用
（支持所有基于 MySQL 8.0 的 NDB 版本）
--text,
-t
(>=7.6.6)
使用文本显示数据
（支持所有基于 MySQL 8.0 的 NDB 版本）
--usage
显示程序使用信息；与 --help 相同
（支持所有基于 MySQL 8.0 的 NDB 版本）
--user=name,
-u
name
以此 MySQL 用户身份连接
（支持所有基于 MySQL 8.0 的 NDB 版本）
附加选项
--color,-c
命令行格式
--color
以彩色显示 ASCII 图形；用于
--skip-colors禁用。
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
--graph,-g
命令行格式
--graph
使用图表显示数据；用于
--skip-graphs禁用。此选项或
--text必须为真；这两个选项都可能是正确的。
--help,-?
命令行格式
--help
显示程序使用信息。
--host[= name],
-h
命令行格式
--host=string
类型
细绳
默认值
localhost
要连接的 MySQL 服务器的主机名或 IP 地址。
--login-path
命令行格式
--login-path=path
类型
细绳
默认值
[none]
从登录文件中读取给定路径。
--measured-load,
-m
命令行格式
--measured-load
按线程显示测量的负载。此选项或
--os-load必须为真；这两个选项都可能是正确的。
--no-defaults
命令行格式
--no-defaults
不要从登录文件以外的任何选项文件中读取默认选项。
--node-id[= #],
-n
命令行格式
--node-id=#
类型
整数
默认值
1
观察具有此节点 ID 的数据节点。
--os-load,
-o
命令行格式
--os-load
显示操作系统测量的负载。此选项或
--measured-load必须为真；这两个选项都可能是正确的。
--password[= password],
-p
命令行格式
--password=password
类型
细绳
默认值
NULL
使用此密码和 指定的 MySQL 用户连接到 MySQL 服务器--user。
此密码仅与 MySQL 用户帐户相关联，与加密NDB备份使用的密码没有任何关系。
--port[= #],
-P
命令行格式
--port=#
类型
整数
默认值
3306
连接到 MySQL 服务器时使用的端口号。
（以前，此选项的缩写形式是
-t，现在改用为 的缩写形式--text。）
--print-defaults
命令行格式
--print-defaults
打印程序参数列表并退出。
--sleep-time[= seconds],
-s
命令行格式
--sleep-time=#
类型
整数
默认值
1
显示刷新之间等待的时间，以秒为单位。
--socket=path/to/file,
-S
命令行格式
--socket=path
类型
路径名
默认值
[none]
使用指定的套接字文件进行连接。
--sort,-r
命令行格式
--sort
按用途对线程进行排序；用于--skip-sort禁用。
--text,-t
命令行格式
--text
使用文本显示数据。此选项或
--graph必须为真；这两个选项都可能是正确的。
（此选项的缩写形式出现-x在以前版本的 NDB Cluster 中，但不再受支持。）
--usage
命令行格式
--usage
显示帮助文本并退出；一样
--help。
--user[= name],
-u
命令行格式
--user=name
类型
细绳
默认值
root
以此 MySQL 用户身份连接。通常需要--password
选项提供的密码。
示例输出。
下图显示了ndb_top在 Linux 系统的终端窗口中运行，其中有一个
ndbmtd数据节点处于中等负载下。在这里，已使用
ndb_top
调用程序以提供文本和图形输出：
-n8
-x
图 23.5 终端中运行的 ndb_top
从 NDB 8.0.20 开始，ndb_top还显示线程的自旋时间，以绿色显示。
© Mysql 中文网
