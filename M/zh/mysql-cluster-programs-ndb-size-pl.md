# 23.5.28 ndb_size.pl — NDBCLUSTER 大小需求估计器_MySQL 8.0 参考手册

23.5.28 ndb_size.pl — NDBCLUSTER 大小需求估计器_MySQL 8.0 参考手册
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
23.5.28 ndb_size.pl — NDBCLUSTER 大小需求估计器
23.5.28 ndb_size.pl — NDBCLUSTER 大小需求估计器
这是一个 Perl 脚本，可用于估算 MySQL 数据库转换为使用NDBCLUSTER
存储引擎时所需的空间量。与本节中讨论的其他实用程序不同，它不需要访问 NDB Cluster（事实上，没有理由这样做）。但是，它确实需要访问待测数据库所在的MySQL服务器。
要求
正在运行的 MySQL 服务器。服务器实例不必为 NDB Cluster 提供支持。
Perl 的工作安装。
该DBI模块，如果它还不是您的 Perl 安装的一部分，可以从 CPAN 获得。（许多 Linux 和其他操作系统发行版都为这个库提供了自己的包。）
具有必要权限的 MySQL 用户帐户。如果您不想使用现有帐户，那么使用创建一个帐户（要检查的数据库的名称在哪里）就足够了
。
GRANT USAGE ON
db_name.*db_name
ndb_size.pl也可以在 MySQL 源代码中找到storage/ndb/tools。
下表显示了
可以与ndb_size.pl一起使用的选项。表后有其他说明。
表 23.49 与程序 ndb_size.pl 一起使用的命令行选项
格式
描述
添加、弃用或删除
--database=string
要检查的一个或多个数据库；逗号分隔的列表；默认为 ALL（使用在服务器上找到的所有数据库）
（支持所有基于 MySQL 8.0 的 NDB 版本）
--hostname=string
以 host[:port] 格式指定主机和可选端口
（支持所有基于 MySQL 8.0 的 NDB 版本）
--socket=path
指定要连接的套接字
（支持所有基于 MySQL 8.0 的 NDB 版本）
--user=string
指定 MySQL 用户名
（支持所有基于 MySQL 8.0 的 NDB 版本）
--password=password
指定 MySQL 用户密码
（支持所有基于 MySQL 8.0 的 NDB 版本）
--format=string
设置输出格式（文本或 HTML）
（支持所有基于 MySQL 8.0 的 NDB 版本）
--excludetables=list
跳过逗号分隔列表中的任何表格
（支持所有基于 MySQL 8.0 的 NDB 版本）
--excludedbs=list
跳过以逗号分隔的列表中的任何数据库
（支持所有基于 MySQL 8.0 的 NDB 版本）
--savequeries=path
将数据库中的所有查询保存到指定的文件中
（支持所有基于 MySQL 8.0 的 NDB 版本）
--loadqueries=path
从指定文件加载所有查询；没有连接到数据库
（支持所有基于 MySQL 8.0 的 NDB 版本）
--real_table_name=string
指定表来处理唯一索引大小计算
（支持所有基于 MySQL 8.0 的 NDB 版本）
用法
perl ndb_size.pl [--database={db_name|ALL}] [--hostname=host[:port]] [--socket=socket] \
[--user=user] [--password=password]  \
[--help|-h] [--format={html|text}] \
[--loadqueries=file_name] [--savequeries=file_name]
默认情况下，此实用程序会尝试分析服务器上的所有数据库。--database您可以使用该选项指定单个数据库
；ALL默认行为可以通过使用数据库的名称来明确。您还可以通过使用--excludedbs带有要跳过的数据库名称的逗号分隔列表的选项来排除一个或多个数据库。--excludetables同样，您可以通过在可选选项后面列出它们的名称（以逗号分隔）来跳过特定的表。可以使用--hostname;指定主机名 默认为localhost. 除了主机之外，您还可以使用
host:port
格式指定端口值--hostname. 默认端口号为3306，如果需要，也可以指定socket；默认为/var/lib/mysql.sock. 一个MySQL用户名和密码可以指定相应的选项显示。也可以使用--format选项控制输出格式；这可以采用值html或
中的任何一个text，text作为默认值。此处显示了文本输出的示例：
$> ndb_size.pl --database=test --socket=/tmp/mysql.sock
ndb_size.pl report for database: 'test' (1 tables)
--------------------------------------------------
Connected to: DBI:mysql:host=localhost;mysql_socket=/tmp/mysql.sock
Including information for versions: 4.1, 5.0, 5.1
test.t1
-------
DataMemory for Columns (* means varsized DataMemory):
Column Name            Type  Varsized   Key  4.1  5.0   5.1
HIDDEN_NDB_PKEY          bigint             PRI    8    8     8
c2     varchar(50)         Y         52   52    4*
c1         int(11)                    4    4     4
--   --    --
Fixed Size Columns DM/Row                              64   64    12
Varsize Columns DM/Row                               0    0     4
DataMemory for Indexes:
Index Name                 Type        4.1        5.0        5.1
PRIMARY                BTREE         16         16         16
--         --         --
Total Index DM/Row                  16         16         16
IndexMemory for Indexes:
Index Name        4.1        5.0        5.1
PRIMARY         33         16         16
--         --         --
Indexes IM/Row         33         16         16
Summary (for THIS table):
4.1        5.0        5.1
Fixed Overhead DM/Row         12         12         16
NULL Bytes/Row          4          4          4
DataMemory/Row         96         96         48
(Includes overhead, bitmap and indexes)
Varsize Overhead DM/Row          0          0          8
Varsize NULL Bytes/Row          0          0          4
Avg Varside DM/Row          0          0         16
No. Rows          0          0          0
Rows/32kb DM Page        340        340        680
Fixedsize DataMemory (KB)          0          0          0
Rows/32kb Varsize DM Page          0          0       2040
Varsize DataMemory (KB)          0          0          0
Rows/8kb IM Page        248        512        512
IndexMemory (KB)          0          0          0
Parameter Minimum Requirements
------------------------------
* indicates greater than default
Parameter     Default        4.1         5.0         5.1
DataMemory (KB)       81920          0           0           0
NoOfOrderedIndexes         128          1           1           1
NoOfTables         128          1           1           1
IndexMemory (KB)       18432          0           0           0
NoOfUniqueHashIndexes          64          0           0           0
NoOfAttributes        1000          3           3           3
NoOfTriggers         768          5           5           5
出于调试目的，包含此脚本运行的查询的 Perl 数组可以从指定的文件中读取使用可以保存到文件中--savequeries；可以使用指定包含要在脚本执行期间读取的此类数组的文件--loadqueries。这些选项都没有默认值。
要生成 HTML 格式的输出，请使用该
--format选项并将输出重定向到文件，如下所示：
$> ndb_size.pl --database=test --socket=/tmp/mysql.sock --format=html > ndb_size.html
（没有重定向，输出被发送到
stdout。）
此脚本的输出包括以下信息：
DataMemory、
IndexMemory、
MaxNoOfTables、
MaxNoOfAttributes、
MaxNoOfOrderedIndexes和配置参数
的最小值
MaxNoOfTriggers
需要容纳所分析的表。
数据库中定义的所有表、属性、有序索引和唯一哈希索引的内存要求。
IndexMemory每个表和
DataMemory表行所需
的和。
© Mysql 中文网
