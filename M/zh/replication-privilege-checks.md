# 17.3.3 复制权限检查_MySQL 8.0 参考手册

17.3.3 复制权限检查_MySQL 8.0 参考手册
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
17.1 配置复制
17.2 复制实现
17.3 复制安全
17.3.1 设置复制以使用加密连接1
17.3.2 加密二进制日志文件和中继日志文件1
17.3.3 复制权限检查1
17.3.3.1 复制 PRIVILEGE_CHECKS_USER 帐户的权限
17.3.3.2 组复制通道的权限检查
17.3.3.3 从失败的复制权限检查中恢复
17.4 复制解决方案
17.5 复制注意事项和技巧
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
MySQL 8.0 参考手册  / 第十七章复制  / 17.3 复制安全  /
17.3.3 复制权限检查
17.3.3 复制权限检查
17.3.3.1 复制 PRIVILEGE_CHECKS_USER 帐户的权限17.3.3.2 组复制通道的权限检查17.3.3.3 从失败的复制权限检查中恢复
默认情况下，当已被另一台服务器接受的事务应用于副本或组成员时，MySQL 复制（包括组复制）不会执行权限检查。从 MySQL 8.0.18 开始，您可以创建一个具有适当权限的用户帐户来应用通常在通道上复制的事务，并
使用语句（来自 MySQL 8.0.23）或
将其指定PRIVILEGE_CHECKS_USER为复制应用程序的帐户语句（MySQL 8.0.23 之前）。MySQL 然后根据用户帐户的权限检查每个事务，以验证您是否已授权该通道的操作。管理员也可以安全地使用该帐户来应用或重新应用来自
CHANGE
REPLICATION SOURCE TOCHANGE MASTER TOmysqlbinlog输出，例如从通道上的复制错误中恢复。
帐户的使用PRIVILEGE_CHECKS_USER有助于保护复制通道，防止未经授权或意外使用特权或不需要的操作。该
PRIVILEGE_CHECKS_USER帐户在以下情况下提供了额外的安全层：
您正在组织网络上的服务器实例与另一个网络上的服务器实例（例如云服务提供商提供的实例）之间进行复制。
您希望将多个内部部署或异地部署作为单独的单元进行管理，而不授予一个管理员帐户对所有部署的权限。
您希望拥有一个管理员帐户，使管理员能够仅执行与复制通道及其复制的数据库直接相关的操作，而不是在服务器实例上拥有广泛的权限。
您可以通过将这些选项中的一个或两个添加到CHANGE REPLICATION SOURCE
TO|来提高应用特权检查的复制通道的安全性。为频道
CHANGE MASTER TO
指定帐户时的语句
：PRIVILEGE_CHECKS_USER
该REQUIRE_ROW_FORMAT选项（可从 MySQL 8.0.19 获得）使复制通道仅接受基于行的复制事件。REQUIRE_ROW_FORMAT设置后，您必须在源服务器上使用基于行的二进制日志记录 ( )
binlog_format=ROW。在 MySQL 8.0.18 中，
REQUIRE_ROW_FORMAT不可用，但仍然强烈建议使用基于行的二进制日志记录来保护复制通道。使用基于语句的二进制日志记录，帐户可能需要一些管理员级别的权限才能PRIVILEGE_CHECKS_USER
成功执行事务。
该REQUIRE_TABLE_PRIMARY_KEY_CHECK选项（可从 MySQL 8.0.20 获得）使复制通道使用其自己的主键检查策略。设置
ON意味着总是需要主键，设置OFF意味着永远不需要主键。默认设置，
使用从每个事务的源复制的值设置系统变量STREAM的会话值
。sql_require_primary_key什么时候
PRIVILEGE_CHECKS_USER设置，设置
REQUIRE_TABLE_PRIMARY_KEY_CHECK为
ON或者OFF意味着用户帐户不需要会话管理级别的权限来设置受限的会话变量，这些变量需要更改
sql_require_primary_key. 它还规范了不同源的跨复制通道的行为。
您授予REPLICATION_APPLIER
权限使用户帐户能够显示为
PRIVILEGE_CHECKS_USER复制应用程序线程，并执行
BINLOGmysqlbinlog 使用的内部使用语句。帐户的用户名和主机名
PRIVILEGE_CHECKS_USER必须遵循第 6.2.4 节“指定帐户名”中描述的语法，并且用户不能是匿名用户（用户名为空）或
CURRENT_USER. 要创建新帐户，请使用
CREATE USER。要授予此帐户REPLICATION_APPLIER权限，请使用该GRANT语句。例如，创建一个用户帐户priv_repl，它可以由管理员从任何主机上手动使用example.com域，并且需要加密连接，请发出以下语句：
mysql> SET sql_log_bin = 0;
mysql> CREATE USER 'priv_repl'@'%.example.com' IDENTIFIED BY 'password' REQUIRE SSL;
mysql> GRANT REPLICATION_APPLIER ON *.* TO 'priv_repl'@'%.example.com';
mysql> SET sql_log_bin = 1;
使用这些SET sql_log_bin语句是为了不将帐户管理语句添加到二进制日志并发送到复制通道（请参阅
第 13.4.1.3 节，“SET sql_log_bin 语句”）。
重要的
caching_sha2_password身份验证插件是从 MySQL 8.0 创建的新用户的默认设置（有关详细信息，请参阅
第6.4.1.2 节，“缓存 SHA-2 可插入身份验证”）。要使用通过此插件进行身份验证的用户帐户连接到服务器，您必须按照
第 17.3.1 节“设置复制以使用加密连接”中所述设置加密连接，或者启用未加密连接以支持密码交换使用 RSA 密钥对。
设置用户帐户后，使用
GRANT语句授予额外的权限，使用户帐户能够进行您希望应用程序线程执行的数据库更改，例如更新服务器上保存的特定表。这些相同的权限使管理员能够在需要在复制通道上手动执行任何这些事务时使用该帐户。如果尝试执行未授予适当权限的意外操作，则该操作将被禁止，并且复制应用程序线程会因错误而停止。
第 17.3.3.1 节，“复制 PRIVILEGE_CHECKS_USER 帐户的权限”说明帐户需要哪些额外权限。例如，要授予priv_repl用户帐户
向 中的表INSERT添加行的权限
，请发出以下语句：
custdb1mysql> GRANT INSERT ON db1.cust TO 'priv_repl'@'%.example.com';PRIVILEGE_CHECKS_USER您使用CHANGE
REPLICATION SOURCE TO语句（来自 MySQL 8.0.23）或
语句（MySQL 8.0.23 之前）为复制通道
分配帐户CHANGE MASTER TO。如果复制正在运行，
请在
语句之前和
之后发出STOP
REPLICA（或在 MySQL 8.0.22
STOP SLAVE之前） 。强烈建议在
设置时使用基于行的二进制日志记录，从 MySQL 8.0.19 开始，您可以使用语句设置
来强制执行此操作。
CHANGE MASTER TOSTART
REPLICAPRIVILEGE_CHECKS_USERREQUIRE_ROW_FORMAT
当您重新启动复制通道时，将从那时起应用对动态特权的检查。但是，在您重新加载授权表之前，静态全局权限在应用程序的上下文中不会处于活动状态，因为这些权限不会因连接的客户端而改变。要激活静态权限，请执行刷新权限操作。这可以通过发出
FLUSH PRIVILEGES语句或执行mysqladmin flush-privileges或
mysqladmin reload命令来完成。
例如，要
channel_1在 MySQL 8.0.23 及更高版本中对正在运行的副本上的通道启动权限检查，请发出以下语句：
mysql> STOP REPLICA FOR CHANNEL 'channel_1';
mysql> CHANGE REPLICATION SOURCE TO
>    PRIVILEGE_CHECKS_USER = 'priv_repl'@'%.example.com',
>    REQUIRE_ROW_FORMAT = 1 FOR CHANNEL 'channel_1';
mysql> FLUSH PRIVILEGES;
mysql> START REPLICA FOR CHANNEL 'channel_1';
在 MySQL 8.0.23 之前，您可以使用此处显示的语句：
mysql> STOP SLAVE FOR CHANNEL 'channel_1';
mysql> CHANGE MASTER TO
>    PRIVILEGE_CHECKS_USER = 'priv_repl'@'%.example.com',
>    REQUIRE_ROW_FORMAT = 1 FOR CHANNEL 'channel_1';
mysql> FLUSH PRIVILEGES;
mysql> START SLAVE FOR CHANNEL 'channel_1';
如果您未指定通道且不存在其他通道，则该语句将应用于默认通道。通道帐户的用户名和主机名PRIVILEGE_CHECKS_USER显示在 Performance Schema
replication_applier_configuration
表中，它们在其中被正确转义，因此可以将它们直接复制到 SQL 语句中以执行单个事务。
在 MySQL 8.0.31 及更高版本中，如果您正在使用
Rewriter插件，则应授予
PRIVILEGE_CHECKS_USER用户帐户
SKIP_QUERY_REWRITE权限。这可以防止该用户发布的语句被重写。有关详细信息，请参阅
第 5.6.4 节，“重写器查询重写插件”。
当REQUIRE_ROW_FORMAT为复制通道设置时，复制应用程序不会创建或删除临时表，因此不会设置
pseudo_thread_id会话系统变量。它不执行LOAD DATA INFILE
指令，因此不会尝试文件操作来访问或删除与数据加载相关的临时文件（记录为
Format_description_log_event）。它不执行INTVAR、RAND和
USER_VAR事件，这些事件用于为基于语句的复制重现客户端的连接状态。（一个例外是USER_VAR与执行的 DDL 查询关联的事件。）它不执行 DML 事务中记录的任何语句。如果复制应用程序在尝试排队或应用事务时检测到任何这些类型的事件，则不会应用该事件，并且复制会因错误而停止。
REQUIRE_ROW_FORMAT无论是否设置
PRIVILEGE_CHECKS_USER帐户，
您都可以设置复制通道。即使没有特权检查，设置此选项时实施的限制也会增加复制通道的安全性。您还可以--require-row-format在使用mysqlbinlog时指定选项，以在mysqlbinlog输出
中强制执行基于行的复制事件。安全上下文。
默认情况下，当使用指定为 的用户帐户启动复制应用程序线程时
PRIVILEGE_CHECKS_USER，将使用默认角色或所有角色创建安全上下文（如果
activate_all_roles_on_login设置为 ）ON。
您可以使用角色为用作PRIVILEGE_CHECKS_USER
帐户的帐户提供通用权限集，如以下示例所示。在这里，不是像前面的示例那样
INSERT将表的权限
直接授予用户帐户，而是将此权限与权限一起
授予角色。然后使用该角色将权限集授予两个用户帐户，这两个帐户现在都可以用作
帐户：
db1.custpriv_repl_roleREPLICATION_APPLIERPRIVILEGE_CHECKS_USERmysql> SET sql_log_bin = 0;
mysql> CREATE USER 'priv_repa'@'%.example.com'
IDENTIFIED BY 'password'
REQUIRE SSL;
mysql> CREATE USER 'priv_repb'@'%.example.com'
IDENTIFIED BY 'password'
REQUIRE SSL;
mysql> CREATE ROLE 'priv_repl_role';
mysql> GRANT REPLICATION_APPLIER TO 'priv_repl_role';
mysql> GRANT INSERT ON db1.cust TO 'priv_repl_role';
mysql> GRANT 'priv_repl_role' TO
'priv_repa'@'%.example.com',
'priv_repb'@'%.example.com';
mysql> SET DEFAULT ROLE 'priv_repl_role' TO
'priv_repa'@'%.example.com',
'priv_repb'@'%.example.com';
mysql> SET sql_log_bin = 1;
请注意，replication applier线程在创建安全上下文时，会检查
PRIVILEGE_CHECKS_USER账户的权限，但不会进行密码验证，也不会进行与账户管理相关的检查，例如检查账户是否被锁定。创建的安全上下文在复制应用程序线程的生命周期内保持不变。
局限性。
仅在 MySQL 8.0.18 中，如果副本mysqld
在发出
RESET
REPLICA语句后立即重新启动（由于服务器意外退出或故意重新启动），
表PRIVILEGE_CHECKS_USER中保存的帐户设置将mysql.slave_relay_log_info
丢失，必须重新指定。当您在该版本中使用权限检查时，请始终验证它们在重新启动后是否就位，并在需要时重新指定它们。从 MySQL 8.0.19 开始，PRIVILEGE_CHECKS_USER帐户设置在这种情况下被保留，因此从表中检索并重新应用到通道。
© Mysql 中文网
