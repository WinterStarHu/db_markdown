# 23.5.13 ndb_import — 将 CSV 数据导入 NDB_MySQL 8.0 参考手册

23.5.13 ndb_import — 将 CSV 数据导入 NDB_MySQL 8.0 参考手册
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
23.5.13 ndb_import — 将 CSV 数据导入 NDB
23.5.13 ndb_import — 将 CSV 数据导入 NDB
ndb_import 将CSV 格式的数据（例如mysqldump
--tab生成的数据）直接导入
NDB使用 NDB API。
ndb_import需要连接到导航台管理服务器（ ndb_mgmd）才能运行；它不需要连接到 MySQL 服务器。
用法
ndb_import db_name file_name options
ndb_import需要两个参数。
db_name是要导入数据的表所在的数据库的名称；
file_name是要从中读取数据的 CSV 文件的名称；如果该文件不在当前目录中，则必须包含该文件的路径。文件名必须与表名相匹配；不考虑文件的扩展名（如果有）。ndb_import支持的选项
包括用于指定字段分隔符、转义符和行终止符的选项，本节后面将对此进行描述。
在 NDB 8.0.30 之前，ndb_import拒绝它从 CSV 文件中读取的任何空行。从 NDB 8.0.30 开始，当导入单个列时，可以用作列值的空值，ndb_import 以与LOAD DATA语句相同的方式处理它。
ndb_import必须能够连接到 NDB Cluster 管理服务器；因此，[api]簇
config.ini文件中必须有一个未使用的槽。
要将使用不同存储引擎的现有表复制为表，例如InnoDB，
NDB使用mysql
客户端执行
SELECT INTO
OUTFILE将现有表导出到 CSV 文件的
CREATE TABLE
LIKE语句，然后执行创建具有相同的新表的语句结构为现有表，然后
ALTER TABLE ...
ENGINE=NDB在新表上执行；此后，从系统 shell 调用ndb_import将数据加载到新NDB表中。例如，可以将名为的数据库中
的现有InnoDB表
导出到
名为
myinnodb_tablemyinnodbNDBmyndb_table在如下所示命名的数据库
myndb中，假设您已经以具有适当权限的 MySQL 用户身份登录：
在mysql客户端中：
mysql> USE myinnodb;
mysql> SELECT * INTO OUTFILE '/tmp/myndb_table.csv'
>  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '\\'
>  LINES TERMINATED BY '\n'
>  FROM myinnodbtable;
mysql> CREATE DATABASE myndb;
mysql> USE myndb;
mysql> CREATE TABLE myndb_table LIKE myinnodb.myinnodb_table;
mysql> ALTER TABLE myndb_table ENGINE=NDB;
mysql> EXIT;
Bye
$>
一旦创建了目标数据库和表，就不再需要正在运行的mysqld 。如果您愿意，可以在继续之前
使用mysqladmin shutdown或其他方法停止它。
在系统外壳中：
# if you are not already in the MySQL bin directory:
$> cd path-to-mysql-bin-dir
$> ndb_import myndb /tmp/myndb_table.csv --fields-optionally-enclosed-by='"' \
--fields-terminated-by="," --fields-escaped-by='\\'
输出应类似于此处显示的内容：
job-1 import myndb.myndb_table from /tmp/myndb_table.csv
job-1 [running] import myndb.myndb_table from /tmp/myndb_table.csv
job-1 [success] import myndb.myndb_table from /tmp/myndb_table.csv
job-1 imported 19984 rows in 0h0m9s at 2277 rows/s
jobs summary: defined: 1 run: 1 with success: 1 with failure: 0
$>
下表显示了
可以与ndb_import一起使用的所有选项。表后有其他说明。
表 23.35 与程序 ndb_import 一起使用的命令行选项
格式
描述
添加、弃用或删除
--abort-on-error
发生任何致命错误时转储核心；用于调试
（支持所有基于 MySQL 8.0 的 NDB 版本）
--ai-increment=#
对于隐藏PK的表，指定autoincrement增量。见 mysqld
（支持所有基于 MySQL 8.0 的 NDB 版本）
--ai-offset=#
对于具有隐藏 PK 的表，指定自动增量偏移量。见 mysqld
（支持所有基于 MySQL 8.0 的 NDB 版本）
--ai-prefetch-sz=#
对于具有隐藏 PK 的表，指定预取的自动增量值的数量。见 mysqld
（支持所有基于 MySQL 8.0 的 NDB 版本）
--character-sets-dir=path
包含字符集的目录
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
--connections=#
要创建的集群连接数
（支持所有基于 MySQL 8.0 的 NDB 版本）
--continue
当工作失败时，继续下一个工作
（支持所有基于 MySQL 8.0 的 NDB 版本）
--core-file
写入核心文件出错；用于调试
（支持所有基于 MySQL 8.0 的 NDB 版本）
--csvopt=opts
用于设置典型 CSV 选项值的速记选项。有关语法和其他信息，请参阅文档
（支持所有基于 MySQL 8.0 的 NDB 版本）
--db-workers=#
每个数据节点的线程数，执行数据库操作
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
--errins-type=name
错误插入类型，用于测试目的；使用“列表”获取所有可能的值
（支持所有基于 MySQL 8.0 的 NDB 版本）
--errins-delay=#
以毫秒为单位的错误插入延迟；添加了随机变化
（支持所有基于 MySQL 8.0 的 NDB 版本）
--fields-enclosed-by=char
与 LOAD DATA 语句的 FIELDS ENCLOSED BY 选项相同。对于 CSV 输入，这与使用 --fields-optionally-enclosed-by 相同
（支持所有基于 MySQL 8.0 的 NDB 版本）
--fields-escaped-by=char
与 LOAD DATA 语句的 FIELDS ESCAPED BY 选项相同
（支持所有基于 MySQL 8.0 的 NDB 版本）
--fields-optionally-enclosed-by=char
与 FIELDS OPTIONALLY ENCLOSED BY LOAD DATA 语句的选项相同
（支持所有基于 MySQL 8.0 的 NDB 版本）
--fields-terminated-by=char
与 LOAD DATA 语句的 FIELDS TERMINATED BY 选项相同
（支持所有基于 MySQL 8.0 的 NDB 版本）
--help,
-?
显示帮助文本并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--idlesleep=#
睡眠等待更多事情的毫秒数
（支持所有基于 MySQL 8.0 的 NDB 版本）
--idlespin=#
idlesleep 前重试次数
（支持所有基于 MySQL 8.0 的 NDB 版本）
--ignore-lines=#
忽略输入文件中的前 # 行。用于跳过非数据头
（支持所有基于 MySQL 8.0 的 NDB 版本）
--input-type=name
输入类型：随机或 csv
（支持所有基于 MySQL 8.0 的 NDB 版本）
--input-workers=#
处理输入的线程数。如果 --input-type 为 csv，则必须为 2 或更多
（支持所有基于 MySQL 8.0 的 NDB 版本）
--keep-state
状态文件（非空 *.rej 文件除外）通常在作业完成时删除。使用此选项会导致保留所有状态文件
（支持所有基于 MySQL 8.0 的 NDB 版本）
--lines-terminated-by=char
与 LOAD DATA 语句的 LINES TERMINATED BY 选项相同
（支持所有基于 MySQL 8.0 的 NDB 版本）
--login-path=path
从登录文件中读取给定路径
（支持所有基于 MySQL 8.0 的 NDB 版本）
--max-rows=#
仅导入此数量的输入数据行；默认为 0，即导入所有行
（支持所有基于 MySQL 8.0 的 NDB 版本）
--missing-ai-column='name'
表示要导入的 CSV 文件中缺少自动增量值。
添加：NDB 8.0.30
--monitor=#
如果发生变化（状态、拒绝的行、临时错误），定期打印正在运行的作业的状态。值 0 禁用。值 1 打印看到的任何变化。较高的值会以指数方式减少状态打印，达到某个预定义的限制
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
（支持所有基于 MySQL 8.0 的 NDB 版本）
--no-asynch
在单个事务中分批运行数据库操作
（支持所有基于 MySQL 8.0 的 NDB 版本）
--no-defaults
不要从登录文件以外的任何选项文件中读取默认选项
（支持所有基于 MySQL 8.0 的 NDB 版本）
--no-hint
告诉事务协调器在选择数据节点时不要使用分布键提示
（支持所有基于 MySQL 8.0 的 NDB 版本）
--opbatch=#
数据库执行批处理是一组发送到 NDB 内核的事务和操作。此选项限制数据库执行批处理中的 NDB 操作（包括 blob 操作）。因此它也限制了异步事务的数量。值 0 无效
（支持所有基于 MySQL 8.0 的 NDB 版本）
--opbytes=#
限制执行批次中的字节数（默认 0 = 无限制）
（支持所有基于 MySQL 8.0 的 NDB 版本）
--output-type=name
输出类型：默认为ndb，null用于测试
（支持所有基于 MySQL 8.0 的 NDB 版本）
--output-workers=#
处理输出或中继数据库操作的线程数
（支持所有基于 MySQL 8.0 的 NDB 版本）
--pagesize=#
将 I/O 缓冲区对齐到给定大小
（支持所有基于 MySQL 8.0 的 NDB 版本）
--pagecnt=#
I/O 缓冲区的大小是页面大小的倍数。CSV 输入工作者分配双倍大小的缓冲区
（支持所有基于 MySQL 8.0 的 NDB 版本）
--polltimeout=#
完成的异步事务的每次轮询超时；轮询一直持续到所有轮询完成或发生错误
（支持所有基于 MySQL 8.0 的 NDB 版本）
--print-defaults
打印程序参数列表并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--rejects=#
限制数据加载中拒绝的行数（具有永久错误的行）。默认值为 0，这意味着任何被拒绝的行都会导致致命错误。超出限制的行也添加到 *.rej
（支持所有基于 MySQL 8.0 的 NDB 版本）
--resume
如果作业中止（临时错误、用户中断），则继续处理尚未处理的行
（支持所有基于 MySQL 8.0 的 NDB 版本）
--rowbatch=#
限制行队列中的行数（默认 0 = 无限制）；如果 --input-type 是随机的，则必须是 1 或更多
（支持所有基于 MySQL 8.0 的 NDB 版本）
--rowbytes=#
限制行队列中的字节数（0 = 无限制）
（支持所有基于 MySQL 8.0 的 NDB 版本）
--state-dir=path
在哪里写状态文件；当前目录是默认的
（支持所有基于 MySQL 8.0 的 NDB 版本）
--stats
将与性能相关的选项和内部统计信息保存在 *.sto 和 *.stt 文件中。即使未使用 --keep-state，这些文件也会在成功完成时保留
（支持所有基于 MySQL 8.0 的 NDB 版本）
--table=name,
-t
name
导入数据的目标名称；默认是输入文件的基本名称
添加：NDB 8.0.28
--tempdelay=#
临时错误之间休眠的毫秒数
（支持所有基于 MySQL 8.0 的 NDB 版本）
--temperrors=#
每个执行批次，由于临时错误导致事务失败的次数；0 表示任何临时错误都是致命的。此类错误不会导致将任何行写入 .rej 文件
（支持所有基于 MySQL 8.0 的 NDB 版本）
--usage,
-?
显示帮助文本并退出；与 --help 相同
（支持所有基于 MySQL 8.0 的 NDB 版本）
--verbose[=#],
-v
[#]
启用详细输出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--version,
-V
显示版本信息并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--abort-on-error
命令行格式
--abort-on-error
发生任何致命错误时转储核心；仅用于调试。
--ai-increment=#
命令行格式
--ai-increment=#
类型
整数
默认值
1
最小值
1
最大值
4294967295
对于有隐藏主键的表，指定自增增量，就像
auto_increment_increment
MySQL Server中的系统变量一样。
--ai-offset=#
命令行格式
--ai-offset=#
类型
整数
默认值
1
最小值
1
最大值
4294967295
对于隐藏主键的表，指定自增偏移量。类似于
auto_increment_offset
系统变量。
--ai-prefetch-sz=#
命令行格式
--ai-prefetch-sz=#
类型
整数
默认值
1024
最小值
1
最大值
4294967295
对于具有隐藏主键的表，指定预取的自动增量值的数量。行为类似于
ndb_autoincrement_prefetch_sz
MySQL 服务器中的系统变量。
--character-sets-dir
命令行格式
--character-sets-dir=path
包含字符集的目录。
--connections=#
命令行格式
--connections=#
类型
整数
默认值
1
最小值
1
最大值
4294967295
要创建的集群连接数。
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
--continue
命令行格式
--continue
当一个作业失败时，继续下一个作业。
--core-file
命令行格式
--core-file
写入核心文件出错；在调试中使用。
--csvopt=string
命令行格式
--csvopt=opts
类型
细绳
默认值
[none]
提供设置典型 CSV 导入选项的快捷方式。此选项的参数是由以下一个或多个参数组成的字符串：
c: 以逗号结尾的字段
d: 使用默认值，除非被另一个参数覆盖
n: 行终止于
\n
q：可选地用双引号字符 ( ")
括起来的字段
r: 行终止于
\r
在 NDB 8.0.28 及更高版本中，处理此选项参数中使用的参数顺序，以便最右边的参数始终优先于已在同一参数值中使用的任何潜在冲突参数。这也适用于给定参数的任何重复实例。在 NDB 8.0.28 之前，参数的顺序没有区别，除了当同时指定n和时r，最后出现（最右边）的那个是实际生效的参数。
此选项用于在难以传输转义符或引号的情况下进行测试。
--db-workers=#
命令行格式
--db-workers=#
类型
整数
默认值
4
最小值
1
最大值
4294967295
每个数据节点执行数据库操作的线程数。
--defaults-file
命令行格式
--defaults-file=path
类型
细绳
默认值
[none]
仅从给定文件中读取默认选项。
--defaults-extra-file
命令行格式
--defaults-extra-file=path
类型
细绳
默认值
[none]
读取全局文件后读取给定文件。
--defaults-group-suffix
命令行格式
--defaults-group-suffix=string
类型
细绳
默认值
[none]
还可以阅读带有 concat(group, suffix) 的组。
--errins-type=name
命令行格式
--errins-type=name
类型
枚举
默认值
[none]
有效值
stopjobstopallsighupsigintlist
错误插入类型；用作值以获得所有可能的值list。
name此选项仅用于测试目的。
--errins-delay=#
命令行格式
--errins-delay=#
类型
整数
默认值
1000
最小值
0
最大值
4294967295
单元
小姐
以毫秒为单位的错误插入延迟；添加了随机变化。此选项仅用于测试目的。
--fields-enclosed-by=char
命令行格式
--fields-enclosed-by=char
类型
细绳
默认值
[none]
这与FIELDS ENCLOSED
BY选项对LOAD
DATA语句的作用相同，指定要解释为引用字段值的字符。对于 CSV 输入，这与
--fields-optionally-enclosed-by.
--fields-escaped-by=name
命令行格式
--fields-escaped-by=char
类型
细绳
默认值
\
FIELDS ESCAPED BY以与 SQL
LOAD DATA语句
的选项相同的方式指定转义字符
。
--fields-optionally-enclosed-by=char
命令行格式
--fields-optionally-enclosed-by=char
类型
细绳
默认值
[none]
这与FIELDS OPTIONALLY
ENCLOSED BY选项对
LOAD DATA语句的作用相同，指定要解释为可选的引用字段值的字符。对于 CSV 输入，这与
--fields-enclosed-by.
--fields-terminated-by=char
命令行格式
--fields-terminated-by=char
类型
细绳
默认值
\t
这与FIELDS TERMINATED
BY选项对LOAD
DATA语句的作用相同，指定要解释为字段分隔符的字符。
--help
命令行格式
--help
显示帮助文本并退出。
--idlesleep=#
命令行格式
--idlesleep=#
类型
整数
默认值
1
最小值
1
最大值
4294967295
单元
小姐
等待更多工作执行的休眠毫秒数。
--idlespin=#
命令行格式
--idlespin=#
类型
整数
默认值
0
最小值
0
最大值
4294967295
睡觉前重试的次数。
--ignore-lines=#
命令行格式
--ignore-lines=#
类型
整数
默认值
0
最小值
0
最大值
4294967295
导致 ndb_import 忽略
#输入文件的第一行。这可以用来跳过不包含任何数据的文件头。
--input-type=name
命令行格式
--input-type=name
类型
枚举
默认值
csv
有效值
randomcsv
设置输入类型。默认是
csv; random仅用于测试目的。.
--input-workers=#
命令行格式
--input-workers=#
类型
整数
默认值
4
最小值
1
最大值
4294967295
设置处理输入的线程数。
--keep-state
命令行格式
--keep-state
默认情况下，ndb_import*.rej在完成作业时删除所有状态文件（非空文件除外）。指定此选项（也不需要参数）以强制程序改为保留所有状态文件。
--lines-terminated-by=name
命令行格式
--lines-terminated-by=char
类型
细绳
默认值
\n
这与LINES TERMINATED
BY选项对LOAD
DATA语句的作用相同，指定要解释为行尾的字符。
--log-level=#
命令行格式
--log-level=#
类型
整数
默认值
0
最小值
0
最大值
2
在给定级别执行内部日志记录。此选项主要供内部和开发使用。
仅在 NDB 的调试版本中，可以使用此选项将日志记录级别设置为最大值 4。
--login-path
命令行格式
--login-path=path
类型
细绳
默认值
[none]
从登录文件中读取给定路径。
--max-rows=#
命令行格式
--max-rows=#
类型
整数
默认值
0
最小值
0
最大值
4294967295
单元
字节
仅导入此数量的输入数据行；默认值为 0，即导入所有行。
--missing-ai-column
命令行格式
--missing-ai-column='name'
介绍
8.0.30-ndb-8.0.30
类型
布尔值
默认值
FALSE
导入单个表或多个表时可以使用此选项。使用时，它表示正在导入的 CSV 文件不包含
AUTO_INCREMENT列的任何值，并且
ndb_import应该提供它们；如果使用该选项并且该AUTO_INCREMENT
列包含任何值，则导入操作无法继续。
--monitor=#
命令行格式
--monitor=#
类型
整数
默认值
2
最小值
0
最大值
4294967295
单元
字节
如果发生变化（状态、拒绝的行、临时错误），定期打印正在运行的作业的状态。设置为 0 以禁用此报告。设置为 1 打印看到的任何更改。较高的值会降低此状态报告的频率。
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
为交易节点的选择启用优化。默认启用；用于
--skip-ndb-optimized-node-selection禁用。
--no-asynch
命令行格式
--no-asynch
在单个事务中分批运行数据库操作。
--no-defaults
命令行格式
--no-defaults
不要从登录文件以外的任何选项文件中读取默认选项。
--no-hint
命令行格式
--no-hint
不要使用分发键提示来选择数据节点。
--opbatch=#
命令行格式
--opbatch=#
类型
整数
默认值
256
最小值
1
最大值
4294967295
单元
字节
对每个执行批次的操作数（包括 blob 操作）设置限制，从而限制异步事务的数量。
--opbytes=#
命令行格式
--opbytes=#
类型
整数
默认值
0
最小值
0
最大值
4294967295
单元
字节
对每个执行批处理的字节数设置限制。使用 0 表示没有限制。
--output-type=name
命令行格式
--output-type=name
类型
枚举
默认值
ndb
有效值
null
设置输出类型。ndb是默认值。
null仅用于测试。
--output-workers=#
命令行格式
--output-workers=#
类型
整数
默认值
2
最小值
1
最大值
4294967295
设置处理输出或中继数据库操作的线程数。
--pagesize=#
命令行格式
--pagesize=#
类型
整数
默认值
4096
最小值
1
最大值
4294967295
单元
字节
将 I/O 缓冲区对齐到给定的大小。
--pagecnt=#
命令行格式
--pagecnt=#
类型
整数
默认值
64
最小值
1
最大值
4294967295
将 I/O 缓冲区的大小设置为页面大小的倍数。CSV 输入工作者分配大小加倍的缓冲区。
--polltimeout=#
命令行格式
--polltimeout=#
类型
整数
默认值
1000
最小值
1
最大值
4294967295
单元
小姐
为完成的异步事务设置每次轮询超时；轮询一直持续到所有轮询完成，或者直到发生错误。
--print-defaults
命令行格式
--print-defaults
打印程序参数列表并退出。
--rejects=#
命令行格式
--rejects=#
类型
整数
默认值
0
最小值
0
最大值
4294967295
限制数据加载中被拒绝的行（具有永久错误的行）的数量。默认值为 0，这意味着任何被拒绝的行都会导致致命错误。任何导致超出限制的行都将添加到
.rej文件中。
此选项施加的限制在当前运行期间有效。为此，
重新启动的运行
--resume被视为
“新”运行。
--resume
命令行格式
--resume
如果作业中止（由于临时数据库错误或被用户中断），则继续处理任何尚未处理的行。
--rowbatch=#
命令行格式
--rowbatch=#
类型
整数
默认值
0
最小值
0
最大值
4294967295
单元
行
对每个行队列的行数设置限制。使用 0 表示没有限制。
--rowbytes=#
命令行格式
--rowbytes=#
类型
整数
默认值
262144
最小值
0
最大值
4294967295
单元
字节
对每个行队列的字节数设置限制。使用 0 表示没有限制。
--stats
命令行格式
--stats
将与性能相关的选项信息和其他内部统计信息保存在名为
*.sto和的文件中*.stt。这些文件总是在成功完成时保留（即使--keep-state没有指定）。
--state-dir=name
命令行格式
--state-dir=path
类型
细绳
默认值
.
将程序运行产生的状态文件（ tbl_name.map、
tbl_name.rej、
tbl_name.res和
）
写入何处；tbl_name.stt默认是当前目录。
--table=name
命令行格式
--table=name
介绍
8.0.28-ndb-8.0.28
类型
细绳
默认值
[input file base name]
默认情况下，ndb_import尝试将数据导入到一个表中，该表的名称是从中读取数据的 CSV 文件的基本名称。--table从 NDB 8.0.28 开始，您可以通过使用选项（缩写形式-t）
指定它来覆盖表名的选择。
--tempdelay=#
命令行格式
--tempdelay=#
类型
整数
默认值
10
最小值
0
最大值
4294967295
单元
小姐
在临时错误之间休眠的毫秒数。
--temperrors=#
命令行格式
--temperrors=#
类型
整数
默认值
0
最小值
0
最大值
4294967295
每个执行批次，事务因临时错误而失败的次数。默认值为 0，这意味着任何临时错误都是致命错误。临时错误不会导致向.rej
文件中添加任何行。
--verbose,
-v
命令行格式
--verbose[=#]
类型
布尔值
默认值
false
启用详细输出。
--usage
命令行格式
--usage
显示帮助文本并退出；一样
--help。
--version
命令行格式
--version
显示版本信息并退出。
与 一样LOAD DATA，字段和行格式的选项与用于创建 CSV 文件的选项非常匹配，无论这是使用
SELECT INTO ...
OUTFILE还是通过其他方式完成的。没有等效于LOAD DATA
语句STARTING WITH选项。
© Mysql 中文网
