# 2.10.3 测试服务器_MySQL 8.0 参考手册

2.10.3 测试服务器_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.3 在 Microsoft Windows 上安装 MySQL  / 2.3.6 Windows 安装后程序  /
2.10.3 测试服务器
2.10.3 测试服务器
初始化数据目录并启动服务器后，执行一些简单的测试以确保它能够令人满意地工作。本节假定您的当前位置是 MySQL 安装目录，并且它有一个
bin包含此处使用的 MySQL 程序的子目录。如果不是这样，请相应地调整命令路径名称。
或者，将该bin目录添加到您的
PATH环境变量设置中。这使你的 shell（命令解释器）能够正确地找到 MySQL 程序，这样你就可以通过只输入它的名字而不是它的路径名来运行一个程序。请参阅第 4.2.9 节，“设置环境变量”。
使用mysqladmin验证服务器是否正在运行。以下命令提供了简单的测试来检查服务器是否启动并响应连接：
$> bin/mysqladmin version
$> bin/mysqladmin variables
如果您无法连接到服务器，请指定一个-u
root选项以连接为root。如果您已经为该root帐户分配了密码，您还需要-p在命令行中指定并在出现提示时输入密码。例如：
$> bin/mysqladmin -u root -p version
Enter password: (enter root password here)mysqladmin version
的输出根据您的平台和 MySQL 版本略有不同，但应该与此处显示的类似：
$> bin/mysqladmin version
mysqladmin  Ver 14.12 Distrib 8.0.31, for pc-linux-gnu on i686
...
Server version          8.0.31
Protocol version        10
Connection              Localhost via UNIX socket
UNIX socket             /var/lib/mysql/mysql.sock
Uptime:                 14 days 5 hours 5 min 21 sec
Threads: 1  Questions: 366  Slow queries: 0
Opens: 0  Flush tables: 1  Open tables: 19
Queries per second avg: 0.000
要查看您还可以使用mysqladmin--help做什么，请使用该
选项
调用它。
验证您是否可以关闭服务器（
如果帐户已经有密码
，请包括一个-p选项）：root$> bin/mysqladmin -u root shutdown
验证您是否可以再次启动服务器。通过使用
mysqld_safe或直接调用
mysqld来执行此操作。例如：
$> bin/mysqld_safe --user=mysql &
如果mysqld_safe失败，请参阅
第 2.10.2.1 节，“解决启动 MySQL 服务器的问题”。
运行一些简单的测试来验证您是否可以从服务器检索信息。输出应与此处显示的类似。
使用mysqlshow查看存在哪些数据库：
$> bin/mysqlshow
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
如果指定数据库名称，mysqlshow
将显示数据库中的表列表：
$> bin/mysqlshow mysql
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
使用mysql程序从模式中的表中选择信息mysql：
$> bin/mysql -e "SELECT User, Host, plugin FROM mysql.user" mysql
+------+-----------+-----------------------+
| User | Host      | plugin                |
+------+-----------+-----------------------+
| root | localhost | caching_sha2_password |
+------+-----------+-----------------------+
此时，您的服务器正在运行，您可以访问它。如果您还没有为初始帐户分配密码，要加强安全性，请按照
第 2.10.4 节，“保护初始 MySQL 帐户”中的说明进行操作。
有关mysql、
mysqladmin和mysqlshow的更多信息，请参阅第 4.5.1 节“mysql — MySQL 命令行客户端”、第 4.5.2 节“mysqladmin — MySQL 服务器管理程序”和
第 4.5.7 节“ mysqlshow — 显示数据库、表和列信息”。
© Mysql 中文网
