# 5.1.9 使用系统变量_MySQL 8.0 参考手册

5.1.9 使用系统变量_MySQL 8.0 参考手册
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
5.1 MySQL 服务器
5.1.1 配置服务器1
5.1.2 服务器配置默认值1
5.1.3 服务器配置验证1
5.1.4 服务器选项、系统变量、状态变量参考1
5.1.5 服务器系统变量引用1
5.1.6 服务器状态变量参考1
5.1.7 服务器命令选项1
5.1.8 服务器系统变量1
5.1.9 使用系统变量1
5.1.9.1 系统变量权限
5.1.9.2 动态系统变量
5.1.9.3 持久化系统变量
5.1.9.4 不可持久和持久受限的系统变量
5.1.9.5 结构化系统变量
5.1.10 服务器状态变量1
5.1.11 服务器 SQL 模式1
5.1.12 连接管理1
5.1.13 IPv6 支持1
5.1.14 网络命名空间支持1
5.1.15 MySQL 服务器时区支持1
5.1.16 资源组1
5.1.17 服务器端帮助支持1
5.1.18 服务器跟踪客户端会话状态1
5.1.19 服务器关机流程1
5.2 MySQL数据目录
5.3 mysql系统架构
5.4 MySQL 服务器日志
5.5 MySQL组件
5.6 MySQL 服务器插件
5.7 MySQL 服务器可加载函数
5.8 在一台机器上运行多个MySQL实例
5.9 调试 MySQL
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
MySQL 8.0 参考手册  / 第 5 章 MySQL 服务器管理  / 5.1 MySQL 服务器  /
5.1.9 使用系统变量
5.1.9 使用系统变量
5.1.9.1 系统变量权限5.1.9.2 动态系统变量5.1.9.3 持久化系统变量5.1.9.4 不可持久和持久受限的系统变量5.1.9.5 结构化系统变量
MySQL 服务器维护许多配置其操作的系统变量。第 5.1.8 节，“服务器系统变量”，描述了这些变量的含义。每个系统变量都有一个默认值。可以在服务器启动时使用命令行或选项文件中的选项设置系统变量。其中大部分可以在服务器运行时通过
SET
语句动态更改，这使您无需停止并重新启动服务器即可修改服务器的操作。您还可以在表达式中使用系统变量值。
许多系统变量是内置的。系统变量也可以通过服务器插件或组件安装：
由服务器插件实现的系统变量在安装插件时公开，并且名称以插件名称开头。例如，audit_log
插件实现了一个名为
audit_log_policy.
组件实现的系统变量在安装组件时公开，并且名称以特定于组件的前缀开头。例如，
log_filter_dragnet错误日志过滤组件实现了一个名为 的系统变量
log_error_filter_rules，全名是
dragnet.log_error_filter_rules。要引用此变量，请使用全名。
系统变量存在两个范围。全局变量影响服务器的整体运行。会话变量影响其对单个客户端连接的操作。给定的系统变量可以同时具有全局值和会话值。全局和会话系统变量的关系如下：
服务器启动时，它会将每个全局变量初始化为其默认值。这些默认值可以通过命令行或选项文件中指定的选项进行更改。（请参阅
第 4.2.2 节，“指定程序选项”。）
服务器还为每个连接的客户端维护一组会话变量。客户端的会话变量在连接时使用相应全局变量的当前值进行初始化。例如，客户端的 SQL 模式由会话
sql_mode值控制，在客户端连接到全局值的值时初始化该会话sql_mode值。
对于一些系统变量，session值不是从对应的全局值初始化的；如果是这样，则在变量描述中指出。
通过使用命令行或选项文件中的选项，可以在服务器启动时全局设置系统变量值。启动时，系统变量的语法与命令选项的语法相同，因此在变量名称中，破折号和下划线可以互换使用。例如，
--general_log=ON和
--general-log=ON是等价的。
当您使用启动选项设置一个采用数值的变量时，该值可以带有后缀
K、M或
G（大写或小写）以指示乘数 1024、1024 2或 1024 3；即，分别以千字节、兆字节或千兆字节为单位。从 MySQL 8.0.14 开始，后缀也可以是T,P和
E来表示 1024 4、1024 5
或 1024 6的乘数。因此，以下命令以 256 KB 的排序缓冲区大小和 1 GB 的最大数据包大小启动服务器：
mysqld --sort-buffer-size=256K --max-allowed-packet=1G
在选项文件中，这些变量设置如下：
[mysqld]
sort_buffer_size=256K
max_allowed_packet=1G
后缀字母的大小写无关紧要；
256Kand256k是等价的，就像1Gand
一样1g。
要限制系统变量可以在运行时使用语句设置的
最大值，请
在服务器启动时SET
使用表单的选项指定此最大值
。例如，要防止 的值
在运行时增加到超过 32MB，请使用选项
.
--maximum-var_name=valuesort_buffer_size--maximum-sort-buffer-size=32M
许多系统变量是动态的，可以在运行时使用
SET
语句进行更改。有关列表，请参阅
第 5.1.9.2 节，“动态系统变量”。要使用 更改系统变量
SET，请按名称引用它，可选地在前面加上修饰符。在运行时，系统变量名称必须使用下划线而不是破折号书写。以下示例简要说明了此语法：
设置全局系统变量：
SET GLOBAL max_connections = 1000;
SET @@GLOBAL.max_connections = 1000;
将全局系统变量持久化到
mysqld-auto.cnf文件（并设置运行时值）：
SET PERSIST max_connections = 1000;
SET @@PERSIST.max_connections = 1000;
将全局系统变量持久化到
mysqld-auto.cnf文件（不设置运行时值）：
SET PERSIST_ONLY back_log = 1000;
SET @@PERSIST_ONLY.back_log = 1000;
设置会话系统变量：
SET SESSION sql_mode = 'TRADITIONAL';
SET @@SESSION.sql_mode = 'TRADITIONAL';
SET @@sql_mode = 'TRADITIONAL';
有关
SET
语法的完整详细信息，请参阅第 13.7.6.1 节，“变量赋值的 SET 语法”。有关设置和持久化系统变量的权限要求的描述，请参阅第 5.1.9.1 节，“系统变量权限”
在服务器启动时设置变量时可以使用用于指定值乘数的后缀，但不能SET
在运行时设置值。另一方面，
SET您可以使用表达式为变量赋值，这在服务器启动时设置变量时是不正确的。例如，以下第一行在服务器启动时是合法的，但第二行不是：
$> mysql --max_allowed_packet=16M
$> mysql --max_allowed_packet=16*1024*1024
相反，下面的第二行在运行时是合法的，但第一行不是：
mysql> SET GLOBAL max_allowed_packet=16M;
mysql> SET GLOBAL max_allowed_packet=16*1024*1024;
要显示系统变量名称和值，请使用以下
SHOW VARIABLES语句：
mysql> SHOW VARIABLES;
+---------------------------------+-----------------------------------+
| Variable_name                   | Value                             |
+---------------------------------+-----------------------------------+
| auto_increment_increment        | 1                                 |
| auto_increment_offset           | 1                                 |
| automatic_sp_privileges         | ON                                |
| back_log                        | 151                               |
| basedir                         | /home/mysql/                      |
| binlog_cache_size               | 32768                             |
| bulk_insert_buffer_size         | 8388608                           |
| character_set_client            | utf8mb4                           |
| character_set_connection        | utf8mb4                           |
| character_set_database          | utf8mb4                           |
| character_set_filesystem        | binary                            |
| character_set_results           | utf8mb4                           |
| character_set_server            | utf8mb4                           |
| character_set_system            | utf8mb3                           |
| character_sets_dir              | /home/mysql/share/charsets/       |
| check_proxy_users               | OFF                               |
| collation_connection            | utf8mb4_0900_ai_ci                |
| collation_database              | utf8mb4_0900_ai_ci                |
| collation_server                | utf8mb4_0900_ai_ci                |
...
| innodb_autoextend_increment     | 8                                 |
| innodb_buffer_pool_size         | 8388608                           |
| innodb_commit_concurrency       | 0                                 |
| innodb_concurrency_tickets      | 500                               |
| innodb_data_file_path           | ibdata1:10M:autoextend            |
| innodb_data_home_dir            |                                   |
...
| version                         | 8.0.31                            |
| version_comment                 | Source distribution               |
| version_compile_machine         | x86_64                            |
| version_compile_os              | Linux                             |
| version_compile_zlib            | 1.2.12                            |
| wait_timeout                    | 28800                             |
+---------------------------------+-----------------------------------+
对于LIKE子句，该语句仅显示那些与模式匹配的变量。要获取特定的变量名称，请使用LIKE
如下所示的子句：
SHOW VARIABLES LIKE 'max_join_size';
SHOW SESSION VARIABLES LIKE 'max_join_size';
要获取名称与模式匹配的变量列表，请
在子句
中使用%通配符
：LIKESHOW VARIABLES LIKE '%size%';
SHOW GLOBAL VARIABLES LIKE '%size%';
通配符可以用在要匹配的模式中的任何位置。严格来说，因为_是匹配任意单个字符的通配符，所以应该将其转义为\_字面匹配。实际上，这很少是必要的。
对于SHOW VARIABLES，如果您既不指定GLOBAL也不指定SESSION，则 MySQL 返回SESSION值。
GLOBAL在设置 -only 变量而不是在检索它们时需要关键字
的原因GLOBAL是为了防止将来出现问题：
如果SESSION要删除的变量与某个变量同名，则GLOBAL具有足以修改全局变量的特权的客户端可能会意外更改该GLOBAL
变量，而不仅仅是SESSION
其自己会话的变量。
如果SESSION要添加与变量同名的GLOBAL变量，则打算更改GLOBAL
变量的客户端可能会发现只更改了自己的SESSION
变量。
© Mysql 中文网
