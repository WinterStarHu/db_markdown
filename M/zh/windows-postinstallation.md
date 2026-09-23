# 2.3.6 Windows 安装后程序_MySQL 8.0 参考手册

2.3.6 Windows 安装后程序_MySQL 8.0 参考手册
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
2.1 一般安装指南
2.2 使用通用二进制文件在 Unix/Linux 上安装 MySQL
2.3 在 Microsoft Windows 上安装 MySQL
2.3.1 MySQL 在Microsoft Windows 上的安装布局1
2.3.2 选择安装包1
2.3.3 Windows 版 MySQL 安装程序1
2.3.4 使用 noinstall ZIP 存档在 Microsoft Windows 上安装 MySQL1
2.3.5 Microsoft Windows MySQL 服务器安装故障排除1
2.3.6 Windows 安装后程序1
2.10.1 初始化数据目录
2.10.2 启动服务器
2.10.3 测试服务器
2.10.4 保护初始 MySQL 帐户
2.10.5 自动启动和停止MySQL
2.3.7 Windows 平台限制1
2.4 在 macOS 上安装 MySQL
2.5 在 Linux 上安装 MySQL
2.6 使用坚不可摧的Linux网络（ULN）安装MySQL
2.7 在 Solaris 上安装 MySQL
2.8 在 FreeBSD 上安装 MySQL
2.9 从源码安装MySQL
2.10 安装后设置和测试
2.11 升级MySQL
2.12 降级MySQL
2.13 Perl 安装注意事项
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
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.3 在 Microsoft Windows 上安装 MySQL  /
2.3.6 Windows 安装后程序
2.3.6 Windows 安装后程序
现有的 GUI 工具可以执行本节中描述的大部分任务，包括：
MySQL Installer：用于安装和升级 MySQL 产品。
MySQL Workbench：管理 MySQL 服务器和编辑 SQL 语句。
如有必要，初始化数据目录并创建 MySQL 授权表。MySQL Installer 执行的 Windows 安装操作会自动初始化数据目录。对于从 ZIP 存档包安装，请按照第 2.10.1 节“初始化数据目录”中所述初始化数据目录。
关于密码，如果您使用MySQL Installer安装MySQL，您可能已经为初始
root帐户分配了密码。（参见
第 2.3.3 节，“Windows 的 MySQL 安装程序”。）否则，请使用
第 2.10.4 节，“保护初始 MySQL 帐户”中给出的密码分配过程。
在分配密码之前，您可能想尝试运行一些客户端程序以确保您可以连接到服务器并且它运行正常。确保服务器正在运行（请参阅第 2.3.4.5 节，“首次启动服务器”）。您还可以设置在 Windows 启动时自动运行的 MySQL 服务（请参阅第 2.3.4.8 节，“将 MySQL 作为 Windows 服务启动”）。
这些说明假定您的当前位置是 MySQL 安装目录，并且它有一个bin
包含此处使用的 MySQL 程序的子目录。如果不是这样，请相应地调整命令路径名称。
如果您使用 MySQL 安装程序安装 MySQL（请参阅
第 2.3.3 节，“Windows 的 MySQL 安装程序”），默认安装目录是C:\Program Files\MySQL\MySQL Server
8.0：
C:\> cd "C:\Program Files\MySQL\MySQL Server 8.0"
从 ZIP 存档安装的常见安装位置是C:\mysql：
C:\> cd C:\mysql
或者，将该bin目录添加到您的
PATH环境变量设置中。这使你的命令解释器能够正确地找到 MySQL 程序，这样你就可以通过只输入程序的名称而不是它的路径名来运行程序。请参阅第 2.3.4.7 节，“为 MySQL 工具自定义 PATH”。
在服务器运行的情况下，发出以下命令以验证您是否可以从服务器检索信息。输出应与此处显示的类似。
使用mysqlshow查看存在哪些数据库：
C:\> bin\mysqlshow
+--------------------+
|     Databases      |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
已安装数据库的列表可能会有所不同，但始终至少包括mysql和
information_schema.
如果不存在正确的 MySQL 帐户，则上述命令（以及用于其他 MySQL 程序的命令，例如mysql）可能不起作用。例如，程序可能因错误而失败，或者您可能无法查看所有数据库。如果您使用 MySQL Installer 安装 MySQL，root则会使用您提供的密码自动创建用户。在这种情况下，您应该使用-u root和
-p选项。（如果您已经保护了初始 MySQL 帐户，则必须使用这些选项。）使用
-p，客户端程序会提示输入
root密码。例如：
C:\> bin\mysqlshow -u root -p
Enter password: (enter root password here)
+--------------------+
|     Databases      |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
如果指定数据库名称，mysqlshow
将显示数据库中的表列表：
C:\> bin\mysqlshow mysql
Database: mysql
+---------------------------+
|          Tables           |
+---------------------------+
| columns_priv              |
| component                 |
| db                        |
| default_roles             |
| engine_cost               |
| func                      |
| general_log               |
| global_grants             |
| gtid_executed             |
| help_category             |
| help_keyword              |
| help_relation             |
| help_topic                |
| innodb_index_stats        |
| innodb_table_stats        |
| ndb_binlog_index          |
| password_history          |
| plugin                    |
| procs_priv                |
| proxies_priv              |
| role_edges                |
| server_cost               |
| servers                   |
| slave_master_info         |
| slave_relay_log_info      |
| slave_worker_info         |
| slow_log                  |
| tables_priv               |
| time_zone                 |
| time_zone_leap_second     |
| time_zone_name            |
| time_zone_transition      |
| time_zone_transition_type |
| user                      |
+---------------------------+
使用mysql程序从mysql数据库中的一个表中选择信息：
C:\> bin\mysql -e "SELECT User, Host, plugin FROM mysql.user" mysql
+------+-----------+-----------------------+
| User | Host      | plugin                |
+------+-----------+-----------------------+
| root | localhost | caching_sha2_password |
+------+-----------+-----------------------+
有关mysql和
mysqlshow的更多信息，请参阅第 4.5.1 节“mysql — MySQL 命令行客户端”和
第 4.5.7 节“mysqlshow —显示数据库、表和列信息”。
© Mysql 中文网
