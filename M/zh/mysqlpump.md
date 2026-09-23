# 4.5.6 mysqlpump——数据库备份程序_MySQL 8.0 参考手册

4.5.6 mysqlpump——数据库备份程序_MySQL 8.0 参考手册
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
4.1 MySQL程序概述
4.2 使用 MySQL 程序
4.3 服务器和服务器启动程序
4.4 安装相关程序
4.5 客户端程序
4.5.1 mysql——MySQL 命令行客户端1
4.5.2 mysqladmin——一个 MySQL 服务器管理程序1
4.5.3 mysqlcheck——表维护程序1
4.5.4 mysqldump——数据库备份程序1
4.5.5 mysqlimport——一个数据导入程序1
4.5.6 mysqlpump——数据库备份程序1
4.5.7 mysqlshow——显示数据库、表和列信息1
4.5.8 mysqlslap — 负载仿真客户端1
4.6 管理和实用程序
4.7 程序开发实用程序
4.8 杂项程序
4.9 环境变量
4.10 MySQL 中的 Unix 信号处理
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.5 客户端程序  /
4.5.6 mysqlpump——数据库备份程序
4.5.6 mysqlpump——数据库备份程序
mysqlpump 调用语法mysqlpump 选项总结mysqlpump 选项说明mysqlpump 对象选择mysqlpump 并行处理mysqlpump 限制
mysqlpump客户端实用程序执行
逻辑备份，生成一组可执行的 SQL 语句以重现原始数据库对象定义和表数据。它转储一个或多个 MySQL 数据库以进行备份或传输到另一台 SQL 服务器。
小费
考虑使用MySQL Shell 转储实用程序，它提供多线程并行转储、文件压缩和进度信息显示，以及 Oracle Cloud Infrastructure 对象存储流和 MySQL 数据库服务兼容性检查和修改等云功能。使用MySQL Shell 负载转储实用程序可以轻松地将转储导入 MySQL 服务器实例或 MySQL 数据库服务数据库系统。可以在此处找到 MySQL Shell 的安装说明。
mysqlpump功能包括：
并行处理数据库和数据库中的对象，以加速转储过程
更好地控制转储哪些数据库和数据库对象（表、存储程序、用户帐户）
将用户帐户转储为帐户管理语句 ( CREATE USER,
GRANT) 而不是插入到mysql系统数据库
中
创建压缩输出的能力
进度指示器（值是估计值）
InnoDB对于转储文件重新加载，通过在插入行后添加索引
来更快地为表创建二级索引
笔记
mysqlpump使用 MySQL 5.7 中引入的 MySQL 功能，因此假定使用 MySQL 5.7 或更高版本。
mysqlpump至少需要
SELECT转储表、SHOW VIEW转储视图、TRIGGER转储触发器以及未使用LOCK TABLES该
转储用户定义需要系统数据库--single-transaction的SELECT权限mysql某些选项可能需要其他权限，如选项说明中所述。
要重新加载转储文件，您必须具有执行它包含的语句所需的权限，例如对
CREATE这些语句创建的对象的适当权限。
笔记
在 Windows 上使用 PowerShell 进行输出重定向的转储创建了一个具有 UTF-16 编码的文件：
mysqlpump [options] > dump.sql
但是，不允许将 UTF-16 作为连接字符集（请参阅第 10.4 节，“连接字符集和排序规则”），因此无法正确加载转储文件。要解决此问题，请使用
--result-file以 ASCII 格式创建输出的选项：
mysqlpump [options] --result-file=dump.sql
mysqlpump 调用语法
默认情况下，mysqlpump转储所有数据库（
mysqlpump 限制中指出的某些例外）。要明确指定此行为，请使用以下
--all-databases选项：
mysqlpump --all-databases
要转储单个数据库或该数据库中的某些表，请在命令行上命名数据库，可选地后跟表名：
mysqlpump db_name
mysqlpump db_name tbl_name1 tbl_name2 ...
要将所有名称参数视为数据库名称，请使用以下
--databases选项：
mysqlpump --databases db_name1 db_name2 ...
默认情况下，mysqlpump不会转储用户帐户定义，即使转储
mysql包含授权表的系统数据库也是如此。CREATE USER要以and
GRANT语句
的形式将授权表内容转储为逻辑定义，请使用该--users选项并禁止所有数据库转储：
mysqlpump --exclude-databases=% --users
在前面的命令中，%是一个匹配该
--exclude-databases选项的所有数据库名称的通配符。
mysqlpump支持多个用于包含或排除数据库、表、存储程序和用户定义的选项。请参阅mysqlpump 对象选择。
要重新加载转储文件，请执行它包含的语句。例如使用mysql客户端：
mysqlpump [options] > dump.sql
mysql < dump.sql
以下讨论提供了额外的
mysqlpump用法示例。
要查看mysqlpump
支持的选项列表，请发出命令mysqlpump --help。
mysqlpump 选项总结
mysqlpump支持以下选项，可以在命令行或
选项文件的组中指定[mysqlpump]。[client]（在 MySQL 8.0.20 之前，
mysqlpump读取
[mysql_dump]组而不是
[mysqlpump]。截至 8.0.20，
[mysql_dump]仍然被接受但已弃用。）有关 MySQL 程序使用的选项文件的信息，请参阅第 4.2.2.2 节，“使用选项文件”.
表 4.16 mysqlpump 选项
选项名称
描述
介绍
弃用
--添加删除数据库
在每个 CREATE DATABASE 语句之前添加 DROP DATABASE 语句
--添加删除表
在每个 CREATE TABLE 语句之前添加 DROP TABLE 语句
--添加删除用户
在每个 CREATE USER 语句之前添加 DROP USER 语句
--添加锁
用 LOCK TABLES 和 UNLOCK TABLES 语句围绕每个表转储
--所有数据库
转储所有数据库
--绑定地址
使用指定的网络接口连接到 MySQL 服务器
--字符集目录
安装字符集的目录
--列统计
编写 ANALYZE TABLE 语句以生成统计直方图
--complete-插入
使用包含列名的完整 INSERT 语句
- 压缩
压缩客户端和服务器之间发送的所有信息
8.0.18
--压缩输出
输出压缩算法
--压缩算法
允许的服务器连接压缩算法
8.0.18
--数据库
将所有名称参数解释为数据库名称
--调试
写调试日志
--调试检查
程序退出时打印调试信息
- 调试信息
程序退出时打印调试信息、内存和 CPU 统计信息
--default-auth
要使用的身份验证插件
--默认字符集
指定默认字符集
--默认并行
并行处理的默认线程数
--defaults-extra-file
除了通常的选项文件外，还读取命名的选项文件
--defaults-文件
只读命名选项文件
--defaults-group-suffix
选项组后缀值
--defer-table-indexes
对于重新加载，将索引创建推迟到加载表行之后
--事件
从转储数据库中转储事件
--exclude-数据库
要从转储中排除的数据库
--排除事件
要从转储中排除的事件
--exclude-routines
从转储中排除的例程
--排除表
从转储中排除的表
--exclude-触发器
从转储中排除的触发器
--exclude-用户
要从转储中排除的用户
--扩展插入
使用多行 INSERT 语法
--get-server-public-key
从服务器请求 RSA 公钥
- 帮助
显示帮助信息并退出
--hex-blob
使用十六进制表示法转储二进制列
- 主持人
MySQL 服务器所在的主机
--include-数据库
要包含在转储中的数据库
--include-事件
要包含在转储中的事件
--include-routines
包含在转储中的例程
--include-tables
要包含在转储中的表
--include-触发器
要包含在转储中的触发器
--include-用户
要包含在转储中的用户
--插入忽略
编写 INSERT IGNORE 而不是 INSERT 语句
--日志错误文件
将警告和错误附加到命名文件
--登录路径
从 .mylogin.cnf 读取登录路径选项
--最大允许数据包
发送到服务器或从服务器接收的最大数据包长度
--net-buffer-length
TCP/IP 和套接字通信的缓冲区大小
--no-create-db
不要编写 CREATE DATABASE 语句
--no-create-info
不要编写重新创建每个转储表的 CREATE TABLE 语句
--no-defaults
不读取选项文件
--parallel-schemas
指定模式处理并行性
- 密码
连接到服务器时使用的密码
--密码1
连接到服务器时使用的第一个多因素身份验证密码
8.0.27
--密码2
连接到服务器时使用的第二个多因素身份验证密码
8.0.27
--密码3
连接到服务器时使用的第三个多重身份验证密码
8.0.27
--插件目录
安装插件的目录
- 港口
用于连接的 TCP/IP 端口号
--print-defaults
打印默认选项
- 协议
使用的传输协议
- 代替
编写 REPLACE 语句而不是 INSERT 语句
--结果文件
直接输出到给定文件
--例程
从转储的数据库中转储存储的例程（过程和函数）
--server-public-key-path
包含 RSA 公钥的文件的路径名
--set-字符集
将 SET NAMES default_character_set 添加到输出
--set-gtid-清除
是否在输出中添加 SET @@GLOBAL.GTID_PURGED
--单笔交易
在单个事务中转储表
--skip-定义器
从视图和存储程序 CREATE 语句中省略 DEFINER 和 SQL SECURITY 子句
--skip-dump-rows
不要转储表行
--skip-generated-invisible-primary-key
不要转储有关生成的不可见主键的信息
8.0.30
- 插座
要使用的 Unix 套接字文件或 Windows 命名管道
--ssl-ca
包含可信 SSL 证书颁发机构列表的文件
--ssl-capath
包含受信任的 SSL 证书颁发机构证书文件的目录
--ssl证书
包含 X.509 证书的文件
--ssl密码
连接加密的允许密码
--ssl-crl
包含证书吊销列表的文件
--ssl-crlpath
包含证书吊销列表文件的目录
--ssl-fips-模式
客户端是否开启FIPS模式
--ssl-密钥
包含 X.509 密钥的文件
--ssl模式
连接到服务器的所需安全状态
--ssl 会话数据
包含 SSL 会话数据的文件
8.0.29
--ssl-session-data-continue-on-failed-reuse
session重用失败是否建立连接
8.0.29
--tls-密码套件
用于加密连接的允许的 TLSv1.3 密码套件
8.0.16
--tls-版本
加密连接允许的 TLS 协议
--触发器
每个转储表的转储触发器
--tz-utc
将 SET TIME_ZONE='+00:00' 添加到转储文件
- 用户
连接到服务器时使用的 MySQL 用户名
--用户
转储用户帐户
- 版本
显示版本信息并退出
--watch-progress
显示进度指示器
--zstd-压缩级别
使用 zstd 压缩的服务器连接的压缩级别
8.0.18
mysqlpump 选项说明
--help,
-?
显示帮助信息并退出。
--add-drop-database
DROP DATABASE
在每个陈述之前
写一个CREATE
DATABASE陈述。
笔记
在 MySQL 8.0 中，mysql
模式被认为是最终用户不能删除的系统模式。如果
--add-drop-database与
--all-databases或一起使用
--databaseswhere the list of schemas to be dumped includes
mysql，则转储文件包含一条
DROP DATABASE `mysql`语句，该语句会在重新加载转储文件时导致错误。
相反，要使用
--add-drop-database，
--databases请与要转储的模式列表一起使用，其中该列表不包括
mysql.
--add-drop-table
DROP TABLE在每个陈述之前
写一个CREATE TABLE
陈述。
--add-drop-user
DROP USER在每个陈述之前
写一个CREATE USER
陈述。
--add-locks
LOCK
TABLES用and
UNLOCK
TABLES语句
包围每个表转储。重新加载转储文件时，这会导致更快的插入。请参阅
第 8.2.5.1 节，“优化 INSERT 语句”。
此选项不适用于并行性，因为
INSERT来自不同表的语句可以交错，并且
UNLOCK
TABLES在一个表的插入结束后可以释放对保留插入的表的锁定。
--add-locks并且
--single-transaction是互斥的。
--all-databases,
-A
转储所有数据库（
mysqlpump Restrictions中注明的某些例外情况）。如果没有明确指定其他行为，则这是默认行为。
--all-databases并且
--databases是互斥的。
笔记
--add-drop-database
有关该选项与 不兼容的信息，
请参阅
说明--all-databases。
在 MySQL 8.0 之前，
mysqldump和
mysqlpump--routines的和
--events选项
在使用选项时不需要包括存储的例程和事件
：转储包括系统数据库，因此也
包括包含存储例程和事件定义的和
表。从 MySQL 8.0 开始，和
--all-databasesmysqlmysql.procmysql.eventmysql.eventmysql.proc不使用表格。相应对象的定义存储在数据字典表中，但不会转储这些表。要在使用 生成的转储中包含存储的例程和事件，
请明确--all-databases使用
--routines和
--events选项。
--bind-address=ip_address
在具有多个网络接口的计算机上，使用此选项来选择用于连接到 MySQL 服务器的接口。
--character-sets-dir=path
安装字符集的目录。请参阅
第 10.15 节，“字符集配置”。
--column-statistics
将ANALYZE TABLE语句添加到输出以在重新加载转储文件时为转储表生成直方图统计信息。默认情况下禁用此选项，因为大型表的直方图生成可能需要很长时间。
--complete-insert
编写INSERT
包含列名的完整语句。
--compress,
-C
如果可能，压缩客户端和服务器之间发送的所有信息。请参阅
第 4.2.8 节，“连接压缩控制”。
从 MySQL 8.0.18 开始，不推荐使用此选项。预计它会在 MySQL 的未来版本中被删除。请参阅
配置传统连接压缩。
--compress-output=algorithm
默认情况下，mysqlpump不压缩输出。此选项指定使用指定算法的输出压缩。允许的算法是
LZ4和ZLIB。
要解压缩压缩的输出，您必须具有适当的实用程序。如果系统命令
lz4和openssl zlib
不可用，则 MySQL 发行版包括
lz4_decompress和
zlib_decompress实用程序，可用于解压缩使用
和
选项压缩的mysqlpump输出。有关详细信息，请参阅
第 4.8.1 节，“lz4_decompress — 解压缩 mysqlpump LZ4 压缩输出”和
第 4.8.3 节，“zlib_decompress — 解压缩 mysqlpump ZLIB 压缩输出”--compress-output=LZ4--compress-output=ZLIB.
--compression-algorithms=value
允许的连接到服务器的压缩算法。可用算法与
protocol_compression_algorithms
系统变量相同。默认值为
uncompressed。
有关更多信息，请参阅
第 4.2.8 节，“连接压缩控制”。
这个选项是在 MySQL 8.0.18 中添加的。
--databases,
-B
通常，mysqlpump将命令行上的第一个名称参数视为数据库名称，并将任何后续名称视为表名。使用此选项，它将所有名称参数视为数据库名称。
CREATE DATABASE语句包含在每个新数据库之前的输出中。
--all-databases并且
--databases是互斥的。
笔记
--add-drop-database
有关该选项与 不兼容的信息，
请参阅
说明--databases。
--debug[=debug_options],
-#
[debug_options]
写调试日志。典型的
debug_options字符串是
. 默认值为
。
d:t:o,file_named:t:O,/tmp/mysqlpump.trace
仅当 MySQL 是使用
WITH_DEBUG. Oracle 提供的 MySQL 发布二进制文件不是
使用此选项构建的。
--debug-check
程序退出时打印一些调试信息。
仅当 MySQL 是使用
WITH_DEBUG. Oracle 提供的 MySQL 发布二进制文件不是
使用此选项构建的。
--debug-info,
-T
程序退出时打印调试信息以及内存和 CPU 使用统计信息。
仅当 MySQL 是使用
WITH_DEBUG. Oracle 提供的 MySQL 发布二进制文件不是
使用此选项构建的。
--default-auth=plugin
关于使用哪个客户端身份验证插件的提示。请参阅第 6.2.17 节，“可插入身份验证”。
--default-character-set=charset_name
用作charset_name默认字符集。请参阅第 10.15 节，“字符集配置”。如果没有指定字符集，
mysqlpump使用
utf8mb4.
--default-parallelism=N
每个并行处理队列的默认线程数。默认值为 2。
该--parallel-schemas
选项还会影响并行度，可用于覆盖默认线程数。有关详细信息，请参阅
mysqlpump 并行处理。
无论有
--default-parallelism=0
没有--parallel-schemas
选项，mysqlpump 都作为单线程进程运行并且不创建队列。
启用并行性后，可以交错来自不同数据库的输出。
--defaults-extra-file=file_name
在全局选项文件之后但（在 Unix 上）在用户选项文件之前读取此选项文件。如果该文件不存在或无法访问，则会发生错误。如果
file_name不是绝对路径名，则将其解释为相对于当前目录。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--defaults-file=file_name
仅使用给定的选项文件。如果该文件不存在或无法访问，则会发生错误。如果
file_name不是绝对路径名，则将其解释为相对于当前目录。
例外：即使有
--defaults-file，客户端程序也会读取.mylogin.cnf.
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--defaults-group-suffix=str
不仅要阅读通常的选项组，还要阅读具有通常名称和后缀
str. 例如，
mysqlpump通常读取
[client]和
[mysqlpump]组。如果此选项作为 给出
--defaults-group-suffix=_other，
则 mysqlpump还会读取
[client_other]和
[mysqlpump_other]组。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--defer-table-indexes
在转储输出中，将每个表的索引创建推迟到其行已加载之后。这适用于所有存储引擎，但InnoDB仅适用于二级索引。
默认情况下启用此选项；用于
--skip-defer-table-indexes
禁用它。
--events
在输出中包括转储数据库的事件计划程序事件。事件转储需要
EVENT这些数据库的权限。
通过使用
--eventscontains
CREATE EVENT语句创建事件而生成的输出。
默认情况下启用此选项；用于
--skip-events
禁用它。
--exclude-databases=db_list
不要转储 中的数据库
db_list，它是一个或多个以逗号分隔的数据库名称的列表。此选项的多个实例是相加的。有关详细信息，请参阅
mysqlpump 对象选择。
--exclude-events=event_list
不要将数据库转储到 中
event_list，它是一个或多个以逗号分隔的事件名称的列表。此选项的多个实例是相加的。有关详细信息，请参阅
mysqlpump 对象选择。
--exclude-routines=routine_list
不要转储 中的事件
routine_list，它是一个或多个以逗号分隔的例程（存储过程或函数）名称的列表。此选项的多个实例是相加的。有关详细信息，请参阅
mysqlpump 对象选择。
--exclude-tables=table_list
不要转储 中的表
table_list，它是一个或多个以逗号分隔的表名的列表。此选项的多个实例是相加的。有关详细信息，请参阅
mysqlpump 对象选择。
--exclude-triggers=trigger_list
不要将触发器转储到 中
trigger_list，它是一个或多个以逗号分隔的触发器名称的列表。此选项的多个实例是相加的。有关详细信息，请参阅mysqlpump 对象选择。
--exclude-users=user_list
不要将用户帐户转储到 中
user_list，它是一个或多个以逗号分隔的帐户名称的列表。此选项的多个实例是相加的。有关详细信息，请参阅
mysqlpump 对象选择。
--extended-insert=N
INSERT使用包含多个
VALUES列表的多行语法
编写语句。这会导致转储文件更小，并在重新加载文件时加快插入速度。
选项值指示要包含在每个INSERT语句中的行数。默认值为 250。值为 1 时，
INSERT每个表行生成一条语句。
--get-server-public-key
从服务器请求基于 RSA 密钥对的密码交换所需的公钥。此选项适用于使用
caching_sha2_password身份验证插件进行身份验证的客户端。对于该插件，除非请求，否则服务器不会发送公钥。对于未使用该插件进行身份验证的帐户，将忽略此选项。如果不使用基于 RSA 的密码交换，它也会被忽略，就像客户端使用安全连接连接到服务器时的情况一样。
如果
给出并指定一个有效的公钥文件，它优先于
.
--server-public-key-path=file_name--get-server-public-key
有关
caching_sha2_password插件的信息，请参阅
第 6.4.1.2 节，“缓存 SHA-2 可插入身份验证”。
--hex-blob
使用十六进制表示法转储二进制列（例如，
'abc'变成
0x616263）。受影响的数据类型是
BINARY,
VARBINARY,
BLOBtypes,
, 所有空间数据类型，以及与
字符集BIT一起使用时的其他非二进制数据类型
。
binary
--host=host_name,
-h host_name
从给定主机上的 MySQL 服务器转储数据。
--include-databases=db_list
将数据库转储到 中db_list，这是一个或多个以逗号分隔的数据库名称的列表。转储包括指定数据库中的所有对象。此选项的多个实例是相加的。有关详细信息，请参阅mysqlpump 对象选择。
--include-events=event_list
将事件转储到 中event_list，这是一个或多个以逗号分隔的事件名称的列表。此选项的多个实例是相加的。有关详细信息，请参阅mysqlpump 对象选择。
--include-routines=routine_list
将例程转储到 中
routine_list，这是一个或多个以逗号分隔的例程（存储过程或函数）名称的列表。此选项的多个实例是相加的。有关详细信息，请参阅
mysqlpump 对象选择。
--include-tables=table_list
将表转储到 中table_list，这是一个或多个以逗号分隔的表名的列表。此选项的多个实例是相加的。有关详细信息，请参阅mysqlpump 对象选择。
--include-triggers=trigger_list
将触发器转储到 中
trigger_list，这是一个或多个以逗号分隔的触发器名称的列表。此选项的多个实例是相加的。有关详细信息，请参阅mysqlpump 对象选择。
--include-users=user_list
将用户帐户转储到 中
user_list，这是一个或多个以逗号分隔的用户名的列表。此选项的多个实例是相加的。有关详细信息，请参阅
mysqlpump 对象选择。
--insert-ignore
写INSERT
IGNORE陈述而不是
INSERT陈述。
--log-error-file=file_name
通过将它们附加到命名文件来记录警告和错误。如果未给出此选项，mysqlpump
会将警告和错误写入标准错误输出。
--login-path=name
从登录路径文件中指定的登录路径读取选项
.mylogin.cnf。“
登录路径”是一个选项组，其中包含指定要连接到哪个 MySQL 服务器以及要以哪个帐户进行身份验证的选项。要创建或修改登录路径文件，请使用
mysql_config_editor实用程序。请参阅
第 4.6.7 节，“mysql_config_editor — MySQL 配置实用程序”。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--max-allowed-packet=N
客户端/服务器通信缓冲区的最大大小。默认为 24​​MB，最大为 1GB。
--net-buffer-length=N
客户端/服务器通信缓冲区的初始大小。当创建多行
INSERT语句时（与--extended-insert
选项一样），mysqlpump创建最多
N字节长的行。如果使用此选项来增加值，请确保 MySQL 服务器
net_buffer_length系统变量的值至少有这么大。
--no-create-db
抑制CREATE DATABASE
可能包含在输出中的任何语句。
--no-create-info,
-t
不要编写CREATE TABLE
创建每个转储表的语句。
--no-defaults
不要读取任何选项文件。如果程序启动因从选项文件中读取未知选项而失败，
--no-defaults可用于防止它们被读取。
例外情况是.mylogin.cnf
文件在所有情况下都会被读取（如果存在）。这允许以比在命令行上更安全的方式指定密码，即使在
--no-defaults使用 时也是如此。要创建.mylogin.cnf，请使用
mysql_config_editor实用程序。请参阅
第 4.6.7 节，“mysql_config_editor — MySQL 配置实用程序”。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--parallel-schemas=[N:]db_list
创建一个队列来处理 中的数据库
db_list，它是一个或多个以逗号分隔的数据库名称的列表。如果
N给出，队列使用
N线程。如果
N未给出，则该
--default-parallelism
选项确定队列线程的数量。
此选项的多个实例创建多个队列。
mysqlpump还创建一个默认队列，用于未在任何
--parallel-schemas选项中命名的数据库，以及如果命令选项选择它们，则用于转储用户定义。有关详细信息，请参阅
mysqlpump 并行处理。
--password[=password],
-p[password]
用于连接到服务器的 MySQL 帐户的密码。密码值是可选的。如果没有给出，
mysqlpump会提示输入一个。如果给定，则后面
的密码之间
不能有空格。如果未指定密码选项，则默认为不发送密码。
--password=-p
在命令行上指定密码应该被认为是不安全的。为避免在命令行中提供密码，请使用选项文件。请参阅
第 6.1.2.1 节，“密码安全的最终用户指南”。
要明确指定没有密码并且
mysqlpump不应提示输入密码，请使用该
--skip-password
选项。
--password1[=pass_val]
用于连接服务器的 MySQL 帐户的多因素身份验证因子 1 的密码。密码值是可选的。如果没有给出，
mysqlpump会提示输入一个。如果给定，则后面的密码和密码之间
不能有空格--password1=。如果未指定密码选项，则默认为不发送密码。
在命令行上指定密码应该被认为是不安全的。为避免在命令行中提供密码，请使用选项文件。请参阅
第 6.1.2.1 节，“密码安全的最终用户指南”。
要明确指定没有密码并且
mysqlpump不应提示输入密码，请使用该
--skip-password1
选项。
--password1and
--password是同义词，就像
--skip-password1
and
一样--skip-password。
--password2[=pass_val]
用于连接到服务器的 MySQL 帐户的多因素身份验证因子 2 的密码。此选项的语义类似于 ; 的语义
--password1。有关详细信息，请参阅该选项的说明。
--password3[=pass_val]
用于连接服务器的 MySQL 帐户的多重身份验证因子 3 的密码。此选项的语义类似于 ; 的语义
--password1。有关详细信息，请参阅该选项的说明。
--plugin-dir=dir_name
在其中查找插件的目录。如果该
--default-auth选项用于指定身份验证插件但
mysqlpump未找到它，请指定此选项。请参阅
第 6.2.17 节，“可插入身份验证”。
--port=port_num,
-P port_num
对于 TCP/IP 连接，要使用的端口号。
--print-defaults
打印程序名称和它从选项文件中获取的所有选项。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--protocol={TCP|SOCKET|PIPE|MEMORY}
用于连接到服务器的传输协议。当其他连接参数通常导致使用您想要的协议以外的协议时，它很有用。有关允许值的详细信息，请参阅
第 4.2.7 节“连接传输协议”。
--replace
写REPLACE陈述而不是INSERT
陈述。
--result-file=file_name
直接输出到命名文件。即使在生成转储时发生错误，也会创建结果文件并覆盖其先前的内容。
此选项应该在 Windows 上使用，以防止换行符
\n被转换为
\r\n回车/换行符序列。
--routines
在输出中包括转储数据库的存储例程（过程和函数）。此选项需要全局SELECT权限。
通过使用
--routinescontains
CREATE PROCEDURE和
CREATE FUNCTION语句创建例程生成的输出。
默认情况下启用此选项；用于
--skip-routines
禁用它。
--server-public-key-path=file_name
PEM 格式文件的路径名，其中包含服务器所需的公钥客户端副本，用于基于 RSA 密钥对的密码交换。此选项适用于使用
sha256_password或
caching_sha2_password身份验证插件进行身份验证的客户端。对于未使用其中一个插件进行身份验证的帐户，将忽略此选项。如果不使用基于 RSA 的密码交换，它也会被忽略，就像客户端使用安全连接连接到服务器时的情况一样。
如果
给出并指定一个有效的公钥文件，它优先于
.
--server-public-key-path=file_name--get-server-public-key
对于sha256_password，此选项仅适用于使用 OpenSSL 构建 MySQL 的情况。
有关sha256_password
和caching_sha2_password插件的信息，请参阅
第 6.4.1.3 节，“SHA-256 可插入身份验证”和
第 6.4.1.2 节，“缓存 SHA-2 可插入身份验证”。
--set-charset
写入
输出。
SET NAMES
default_character_set
默认情况下启用此选项。要禁用它并禁止该SET NAMES
语句，请使用
--skip-set-charset.
--set-gtid-purged=value
SET
@@GLOBAL.gtid_purged此选项通过指示是否向输出添加语句来
控制写入转储文件的全局事务 ID (GTID) 信息
。此选项还可能导致在重新加载转储文件时将语句写入禁用二进制日志记录的输出。
下表显示了允许的选项值。默认值为AUTO。
价值
意义
OFF
SET不向输出添加语句。
ON
在输出中添加SET语句。如果服务器上未启用 GTID，则会发生错误。
AUTO
SET如果在服务器上启用了 GTID，则在输出中添加一条语句。
重新加载转储文件时，该--set-gtid-purged选项对二进制日志记录有以下影响：
--set-gtid-purged=OFF:SET
@@SESSION.SQL_LOG_BIN=0;不会添加到输出中。
--set-gtid-purged=ON:SET
@@SESSION.SQL_LOG_BIN=0;添加到输出。
--set-gtid-purged=AUTO:SET
@@SESSION.SQL_LOG_BIN=0;如果在您正在备份的服务器上启用了 GTID，则添加到输出中（即，如果AUTO
评估为ON）。
--single-transaction
此选项将事务隔离模式设置为
REPEATABLE READ并在转储数据之前向服务器发送START
TRANSACTIONSQL 语句。它仅对诸如 之类的事务表有用InnoDB，因为它会在发布时转储数据库的一致状态，
START
TRANSACTION而不会阻止任何应用程序。
使用此选项时，您应该记住，只有
InnoDB表会以一致的状态转储。例如，使用此选项时转储
的任何MyISAM或
表可能仍会更改状态。MEMORY
在
--single-transaction转储过程中，为确保转储文件有效（正确的表内容和二进制日志坐标），其他任何连接都不应使用以下语句：
ALTER TABLE,
CREATE TABLE,
DROP TABLE,
RENAME TABLE,
TRUNCATE TABLE。一致性读取并不与这些语句隔离，因此在要转储的表上使用它们可能会导致
mysqlpumpSELECT执行的
检索表内容的操作获取不正确的内容或失败。
--add-locks并且
--single-transaction是互斥的。
--skip-definer
从视图和存储程序的语句中
省略DEFINER和SQL
SECURITY子句
。CREATE转储文件在重新加载时会创建使用默认值DEFINER和SQL
SECURITY值的对象。请参阅
第 25.6 节，“存储对象访问控制”。
--skip-dump-rows,
-d
不要转储表行。
--skip-generated-invisible-primary-key
此选项从 MySQL 8.0.30 开始可用，并导致生成的不可见主键 (GIPK) 从转储中排除。有关 GIPK 和 GIPK 模式的更多信息，
请参阅
第 13.1.20.11 节，“生成不可见的主键” 。
--socket=path,
-S path
对于与 的连接localhost，要使用的 Unix 套接字文件，或者在 Windows 上，要使用的命名管道的名称。
在 Windows 上，仅当服务器启动时named_pipe
启用了支持命名管道连接的系统变量时，此选项才适用。此外，进行连接的用户必须是
named_pipe_full_access_group
系统变量指定的 Windows 组的成员。
--ssl*
以 开头的选项--ssl指定是否使用加密连接到服务器并指示在哪里可以找到 SSL 密钥和证书。请参阅
加密连接的命令选项。
--ssl-fips-mode={OFF|ON|STRICT}
控制是否在客户端启用 FIPS 模式。该
--ssl-fips-mode选项与其他
选项的不同之处在于它不用于建立加密连接，而是用于影响允许哪些加密操作。请参见第 6.8 节 “FIPS 支持”。
--ssl-xxx
这些--ssl-fips-mode
值是允许的：
OFF: 禁用 FIPS 模式。
ON：启用 FIPS 模式。
STRICT：启用“严格”
FIPS 模式。
笔记
如果 OpenSSL FIPS 对象模块不可用，则唯一允许的
--ssl-fips-mode值为
OFF. 在这种情况下，设置
--ssl-fips-mode为
ON或STRICT会导致客户端在启动时发出警告并在非 FIPS 模式下运行。
--tls-ciphersuites=ciphersuite_list
使用 TLSv1.3 的加密连接的允许密码套件。该值是一个或多个以冒号分隔的密码套件名称的列表。可以为此选项命名的密码套件取决于用于编译 MySQL 的 SSL 库。有关详细信息，请参阅
第 6.3.2 节，“加密连接 TLS 协议和密码”。
这个选项是在 MySQL 8.0.16 中添加的。
--tls-version=protocol_list
加密连接允许的 TLS 协议。该值是一个或多个以逗号分隔的协议名称的列表。可以为此选项命名的协议取决于用于编译 MySQL 的 SSL 库。有关详细信息，请参阅
第 6.3.2 节，“加密连接 TLS 协议和密码”。
--triggers
在输出中包含每个转储表的触发器。
默认情况下启用此选项；用于
--skip-triggers
禁用它。
--tz-utc
此选项允许TIMESTAMP
在不同时区的服务器之间转储和重新加载列。mysqlpump将其连接时区设置为 UTC 并添加SET
TIME_ZONE='+00:00'到转储文件中。如果没有此选项，TIMESTAMP列将在源服务器和目标服务器的本地时区转储和重新加载，如果服务器位于不同的时区，这可能会导致值发生变化。
--tz-utc还可以防止由于夏令时而发生的变化。
默认情况下启用此选项；用于
--skip-tz-utc
禁用它。
--user=user_name,
-u user_name
用于连接到服务器的 MySQL 帐户的用户名。
如果您将Rewriter插件与 MySQL 8.0.31 或更高版本一起使用，则应授予此用户
SKIP_QUERY_REWRITE权限。
--users
CREATE USER以和
GRANT语句
的形式将用户帐户转储为逻辑定义
。
用户定义存储在
mysql系统数据库的授权表中。默认情况下，
mysqlpump不在mysql数据库转储中包含授权表。要将授权表的内容转储为逻辑定义，请使用该--users选项并禁止所有数据库转储：
mysqlpump --exclude-databases=% --users
--version,
-V
显示版本信息并退出。
--watch-progress
定期显示进度指示器，提供有关表、行和其他对象的已完成和总数的信息。
默认情况下启用此选项；用于
--skip-watch-progress
禁用它。
--zstd-compression-level=level
用于连接到使用zstd压缩算法的服务器的压缩级别。允许的级别从 1 到 22，值越大表示压缩级别越高。默认
zstd压缩级别为 3。压缩级别设置对不使用zstd压缩的连接没有影响。
有关更多信息，请参阅
第 4.2.8 节，“连接压缩控制”。
这个选项是在 MySQL 8.0.18 中添加的。
mysqlpump 对象选择
mysqlpump有一组包含和排除选项，可以过滤多种对象类型并提供对要转储的对象的灵活控制：
--include-databases并
--exclude-databases应用于数据库和其中的所有对象。
--include-tables并
--exclude-tables应用于表格。这些选项也会影响与表关联的触发器，除非给出特定于触发器的选项。
--include-triggers并
--exclude-triggers应用于触发器。
--include-routines并
--exclude-routines应用于存储过程和函数。如果例程选项与存储过程名称匹配，它也会与同名的存储函数匹配。
--include-events并
--exclude-events应用于 Event Scheduler 事件。
--include-users并
--exclude-users应用于用户帐户。
可以多次给出任何包含或排除选项。效果是叠加的。这些选项的顺序无关紧要。
每个包含和排除选项的值是适当对象类型的逗号分隔名称列表。例如：
--exclude-databases=test,world
--include-tables=customer,invoice
对象名称中允许使用通配符：
%匹配零个或多个字符的任何序列。
_匹配任何单个字符。
例如，
--include-tables=t%,__tmp
匹配所有以 开头的表名t和所有以 . 结尾的五个字符的表名
tmp。
对于用户，没有主机部分的指定名称被解释为隐含主机%. 例如，
u1和u1@%是等价的。这与通常在 MySQL 中应用的相同（请参阅第 6.2.4 节，“指定帐户名称”）。
包含和排除选项相互作用如下：
默认情况下，没有包含或排除选项，
mysqlpump转储所有数据库（
mysqlpump Restrictions中注明的某些例外情况）。
如果在没有排除选项的情况下给出包含选项，则仅转储命名为包含的对象。
如果在没有包含选项的情况下给出了排除选项，则所有对象都将被转储，除了那些命名为排除的对象。
如果给出了包含和排除选项，则不会转储所有命名为排除的和未命名为包含的对象。所有其他对象都被转储。
如果正在转储多个数据库，则可以通过使用数据库名称限定对象名称来命名特定数据库中的表、触发器和例程。以下命令转储数据库db1和
db2，但不包括表
db1.t1和db2.t2：
mysqlpump --include-databases=db1,db2 --exclude-tables=db1.t1,db2.t2
以下选项提供了指定要转储的数据库的替代方法：
该--all-databases选项转储所有数据库（
mysqlpump Restrictions中注明的某些例外情况）。它相当于根本不指定任何对象选项（默认的
mysqlpump操作是转储所有内容）。
--include-databases=%类似于
--all-databases，但选择所有数据库进行转储，甚至是那些
--all-databases.
该--databases选项使mysqlpump将所有名称参数视为要转储的数据库名称。它等效于--include-databases
命名相同数据库的选项。
mysqlpump 并行处理
mysqlpump可以利用并行性来实现并发处理。您可以选择数据库之间的并发（同时转储多个数据库）和数据库内的并发（同时从给定数据库转储多个对象）。
默认情况下，mysqlpump设置一个队列和两个线程。您可以创建额外的队列并控制分配给每个队列的线程数，包括默认队列：
--default-parallelism=N
指定用于每个队列的默认线程数。如果没有此选项，N
则为 2。
默认队列始终使用默认线程数。除非您另外指定，否则附加队列使用默认线程数。
--parallel-schemas=[N:]db_list
设置一个处理队列以转储命名的数据库，db_list并可选择指定队列使用的线程数。
db_list是以逗号分隔的数据库名称列表。如果选项参数以 开头
N:，则队列使用N线程。否则，该
--default-parallelism
选项确定队列线程数。
该选项的多个实例
--parallel-schemas创建多个队列。
数据库列表中的名称允许包含
过滤选项支持的相同字符
%和通配符（请参阅mysqlpump 对象选择）。
_
mysqlpump使用默认队列来处理任何未使用
--parallel-schemas选项明确命名的数据库，并在命令选项选择它们时转储用户定义。
通常，对于多个队列，mysqlpump
使用队列处理的数据库集之间的并行性来同时转储多个数据库。对于使用多线程的队列，mysqlpump在数据库中使用并行机制，同时从给定数据库中转储多个对象。可能会发生异常；例如，mysqlpump在从服务器获取数据库中的对象列表时可能会阻塞队列。
启用并行性后，可以交错来自不同数据库的输出。例如，
INSERT并行转储的多个表中的语句可以交错；这些陈述没有按任何特定顺序书写。这不会影响重新加载，因为输出语句使用数据库名称限定对象名称或
USE根据需要在语句之前。
并行性的粒度是单个数据库对象。例如，无法使用多个线程并行转储单个表。
例子：
mysqlpump --parallel-schemas=db1,db2 --parallel-schemas=db3
mysqlpump设置一个队列来处理
db1和db2，另一个队列来处理db3，以及一个默认队列来处理所有其他数据库。所有队列都使用两个线程。
mysqlpump --parallel-schemas=db1,db2 --parallel-schemas=db3
--default-parallelism=4
这与前面的示例相同，只是所有队列都使用四个线程。
mysqlpump --parallel-schemas=5:db1,db2 --parallel-schemas=3:db3db1和
的队列db2
使用5个线程，for的队列db3使用3个线程，default队列默认使用2个线程。
作为一种特殊情况，无论有
--default-parallelism=0没有
--parallel-schemas选项，
mysqlpump作为单线程进程运行并且不创建队列。
mysqlpump 限制
默认情况下， mysqlpump不会转储
performance_schema、
ndbinfo或sys模式。要转储其中任何一个，请在命令行上明确命名它们。您也可以使用
--databases或
--include-databases选项命名它们。
mysqlpump不转储
INFORMATION_SCHEMA模式。
mysqlpump不转储
InnoDB CREATE
TABLESPACE语句。
mysqlpumpCREATE USER使用and
以逻辑形式转储用户帐户GRANT（例如，当您使用
--include-usersor
--users选项时）。出于这个原因，系统数据库的转储在默认情况
mysql下不包括包含用户定义的授权表：
、、、、、、或
。要转储任何授权表，请在数据库后跟表名命名：
userdbtables_privcolumns_privprocs_privproxies_privmysqlmysqlpump mysql user db ...
© Mysql 中文网
