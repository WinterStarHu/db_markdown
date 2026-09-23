# 27.12.9 性能模式连接属性表_MySQL 8.0 参考手册

27.12.9 性能模式连接属性表_MySQL 8.0 参考手册
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
第24章分区
第25章存储对象
第 26 章 INFORMATION_SCHEMA 表
第 27 章 MySQL 性能模式
27.1 性能模式快速入门
27.2 性能模式构建配置
27.3 性能模式启动配置
27.4 性能模式运行时配置
27.5 性能模式查询
27.6 性能模式工具命名约定
27.7 性能模式状态监控
27.8 性能模式原子和分子事件
27.9 当前和历史事件的性能模式表
27.10 性能模式语句摘要和采样
27.11 性能模式总表特征
27.12 性能模式表描述
27.12.1 性能模式表参考1
27.12.2 性能模式设置表1
27.12.3 性能模式实例表1
27.12.4 性能模式等待事件表1
27.12.5 性能模式阶段事件表1
27.12.6 性能模式语句事件表1
27.12.7 性能模式事务表1
27.12.8 性能模式连接表1
27.12.9 性能模式连接属性表1
27.12.9.1 session_account_connect_attrs 表
27.12.9.2 session_connect_attrs 表
27.12.10 性能模式用户定义的变量表1
27.12.11 性能模式复制表1
27.12.12 Performance Schema NDB 集群表1
27.12.13 性能模式锁表1
27.12.14 性能模式系统变量表1
27.12.15 性能模式状态变量表1
27.12.16 性能模式线程池表1
27.12.17 性能模式防火墙表1
27.12.18 性能模式密钥环表1
27.12.19 性能模式克隆表1
27.12.20 性能模式汇总表1
27.12.21 性能模式杂表1
27.13 性能模式选项和变量引用
27.14 性能模式命令选项
27.15 性能模式系统变量
27.16 性能模式状态变量
27.17性能模式内存分配模型
27.18 性能模式和插件
27.19 使用性能模式诊断问题
27.20 性能模式的限制
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 27 章 MySQL 性能模式  / 27.12 性能模式表描述  /
27.12.9 性能模式连接属性表
27.12.9 性能模式连接属性表
27.12.9.1 session_account_connect_attrs 表27.12.9.2 session_connect_attrs 表
连接属性是应用程序可以在连接时传递给服务器的键值对。对于基于
libmysqlclient客户端库实现的 C API 的应用程序，
mysql_options()和
mysql_options4()函数定义了连接属性集。其他 MySQL 连接器可能会提供自己的属性定义方法。
这些性能模式表公开属性信息：
session_account_connect_attrs：当前会话的连接属性，以及与会话帐户关联的其他会话
session_connect_attrs：所有会话的连接属性
此外，写入审计日志的连接事件可能包括连接属性。请参阅
第 6.4.5.4 节，“审计日志文件格式”。
以下划线 ( ) 开头的属性名称_保留供内部使用，不应由应用程序创建。此约定允许 MySQL 引入新属性而不会与应用程序属性冲突，并使应用程序能够定义自己的属性而不会与内部属性冲突。
可用的连接属性连接属性限制
可用的连接属性
给定连接中可见的连接属性集因平台、用于建立连接的 MySQL 连接器或客户端程序等因素而异。
客户端库设置这些libmysqlclient属性：
_client_name：客户端名称（libmysql对于客户端库）。
_client_version: 客户端库版本。
_os：操作系统（例如
Linux，，Win64）。
_pid：客户端进程ID。
_platform：机器平台（例如，x86_64）。
_thread：客户端线程 ID（仅限 Windows）。
其他 MySQL 连接器可能会定义自己的连接属性。
MySQL Connector/C++ 8.0.16 及更高版本为使用 X DevAPI 或 X DevAPI for C 的应用程序定义了这些属性：
_client_license：连接器许可证（例如GPL-2.0）。
_client_name: 连接器名称 ( mysql-connector-cpp)。
_client_version: 连接器版本。
_os：操作系统（例如
Linux，，Win64）。
_pid：客户端进程ID。
_platform：机器平台（例如，x86_64）。
_source_host：运行客户端的机器的主机名。
_thread：客户端线程 ID（仅限 Windows）。
MySQL Connector/J 定义了这些属性：
_client_name: 客户名称
_client_version: 客户端库版本
_os：操作系统（例如
Linux，，Win64）
_client_license：连接器许可证类型
_platform：机器平台（例如，x86_64）
_runtime_vendor：Java 运行时环境 (JRE) 供应商
_runtime_version: Java 运行时环境 (JRE) 版本
MySQL Connector/NET 定义了这些属性：
_client_version: 客户端库版本。
_os：操作系统（例如
Linux，，Win64）。
_pid：客户端进程ID。
_platform：机器平台（例如，x86_64）。
_program_name: 客户端名称。
_thread：客户端线程 ID（仅限 Windows）。
Connector/Python 8.0.17 及更高版本的实现定义了这些属性；一些值和属性取决于连接器/Python 实现（纯 Python 或 c-ext）：
_client_license：连接器的许可证类型；GPL-2.0或
Commercial。（仅限纯蟒蛇）
_client_name：设置为
mysql-connector-python（纯python）或
libmysql（c-ext）
_client_version：连接器版本（纯 python）或 mysqlclient 库版本（c-ext）。
_os：带有连接器的操作系统（例如Linux，，
Win64）。
_pid：源机器上的进程标识符（例如，26955）
_platform：机器平台（例如，x86_64）。
_source_host：连接器所连接的机器的主机名。
_connector_version：连接器版本（例如，8.0.31）（仅限 c-ext）。
_connector_license：连接器的许可证类型；GPL-2.0或
Commercial（仅限 c-ext）。
_connector_name：始终设置为
mysql-connector-python（仅限 c-ext）。
PHP 定义的属性取决于它的编译方式：
编译使用libmysqlclient：标准libmysqlclient属性，如前所述。
编译使用mysqlnd: 只有
_client_name属性，值为
mysqlnd.
许多 MySQL 客户端程序设置一个program_name
属性，其值等于客户端名称。例如，
mysqladmin和mysqldump分别
设置program_name为
mysqladmin和mysqldump。MySQL Shell 设置program_name
为mysqlsh.
一些 MySQL 客户端程序定义了额外的属性：
mysql（从 MySQL 8.0.17 开始）：
os_user：运行程序的操作系统用户的名称。在 Unix 和类 Unix 系统以及 Windows 上可用。
os_sudouser:
SUDO_USER环境变量的值。在 Unix 和类 Unix 系统上可用。
不发送值为空的
mysql连接属性。
mysql二进制日志：
_client_role:
binary_log_listener
副本连接：
program_name:
mysqld
_client_role:
binary_log_listener
_client_replication_channel_name：频道名称。
FEDERATED存储引擎连接：
program_name:
mysqld
_client_role:
federated_storage
连接属性限制
从客户端传输到服务器的连接属性数据量有限制：
客户端在连接时间之前强加的固定限制。
服务器在连接时强加的固定限制。
性能模式在连接时强加的可配置限制。
对于使用 C API 启动的连接，
libmysqlclient库对客户端连接属性数据的总大小施加了 64KB 的限制：调用会
mysql_options()导致超过此限制的情况会产生
CR_INVALID_PARAMETER_NO错误。其他 MySQL 连接器可能会对可以传输到服务器的连接属性数据量施加自己的客户端限制。
在服务器端，对连接属性数据进行这些大小检查：
服务器对其接受的连接属性数据的总大小施加了 64KB 的限制。如果客户端尝试发送超过 64KB 的属性数据，服务器将拒绝连接。否则，服务器认为属性缓冲区有效并在
Performance_schema_session_connect_attrs_longest_seen
状态变量中跟踪最长此类缓冲区的大小。
performance_schema_session_connect_attrs_size
对于已接受的连接，性能模式根据系统变量
的值检查聚合属性大小
。如果属性大小超过此值，则会发生以下操作：
性能模式截断属性数据并递增
Performance_schema_session_connect_attrs_lost
状态变量，该变量指示发生属性截断的连接数。
log_error_verbosity
如果系统变量大于 1
，Performance Schema 会向错误日志写入一条消息
：Connection attributes of length N were truncated
(N bytes lost)
for connection N, user user_name@host_name
(as user_name), auth: {yes|no}
警告消息中的信息旨在帮助 DBA 识别发生属性截断的客户端。
如果_truncated属性缓冲区有足够的空间，则向会话属性添加一个属性，其值指示丢失了多少字节。这使性能模式能够在连接属性表中公开每个连接的截断信息。无需检查错误日志即可检查此信息。
© Mysql 中文网
