# 15.20.3 设置 InnoDB memcached 插件_MySQL 8.0 参考手册

15.20.3 设置 InnoDB memcached 插件_MySQL 8.0 参考手册
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
15.1 InnoDB简介
15.2 InnoDB 和 ACID 模型
15.3 InnoDB 多版本
15.4 InnoDB架构
15.5 InnoDB 内存结构
15.6 InnoDB 磁盘结构
15.7 InnoDB 锁定和事务模型
15.8 InnoDB配置
15.9 InnoDB 表和页压缩
15.10 InnoDB 行格式
15.11 InnoDB磁盘I/O和文件空间管理
15.12 InnoDB和在线DDL
15.13 InnoDB静态数据加密
15.14 InnoDB 启动选项和系统变量
15.15 InnoDB INFORMATION_SCHEMA 表
15.16 InnoDB 与 MySQL 性能模式的集成
15.17 InnoDB 监视器
15.18 InnoDB备份与恢复
15.19 InnoDB和MySQL复制
15.20 InnoDB 内存缓存插件
15.20.1 InnoDB memcached 插件的好处1
15.20.2 InnoDB 内存缓存架构1
15.20.3 设置 InnoDB memcached 插件1
15.20.4 InnoDB memcached 多获取和范围查询支持1
15.20.5 InnoDB memcached 插件的安全注意事项1
15.20.6 为 InnoDB memcached 插件编写应用程序1
15.20.7 InnoDB memcached 插件和复制1
15.20.8 InnoDB memcached 插件内部1
15.20.9 InnoDB memcached 插件故障排除1
15.21 InnoDB 故障排除
15.22 InnoDB 限制
15.23 InnoDB 限制和限制
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.20 InnoDB 内存缓存插件  /
15.20.3 设置 InnoDB memcached 插件
15.20.3 设置 InnoDB memcached 插件
本节介绍如何在 MySQL 服务器上设置
daemon_memcached插件。因为memcached守护进程与 MySQL 服务器紧密集成以避免网络流量并最大限度地减少延迟，所以您在使用此功能的每个 MySQL 实例上执行此过程。
笔记
在设置daemon_memcached
插件之前，请参阅第 15.20.5 节，“InnoDB memcached 插件的安全注意事项”以了解防止未经授权访问所需的安全程序。
先决条件
该daemon_memcached插件仅在 Linux、Solaris 和 macOS 平台上受支持。不支持其他操作系统。
从源代码构建 MySQL 时，必须使用
-DWITH_INNODB_MEMCACHED=ON. plugin_dir此构建选项在运行插件所需的 MySQL 插件目录 ( ) 中生成两个共享库daemon_memcached
：
libmemcached.so: MySQL 的
memcached守护进程插件。
innodb_engine.so：
memcachedInnoDB的API 插件
。
libevent必须安装。
如果您没有从源代码构建 MySQL，则该
libevent库不会包含在您的安装中。使用适用于您的操作系统的安装方法来安装libevent
1.4.12 或更高版本。例如，根据操作系统，您可以使用apt-get、
yum或port
install。例如，在 Ubuntu Linux 上，使用：
sudo apt-get install libevent-dev
如果您从源代码版本安装 MySQL，
libevent则 1.4.12 与软件包捆绑在一起，位于 MySQL 源代码目录的顶层。如果您使用的是捆绑版本
libevent，则无需任何操作。如果要使用 的本地系统版本
libevent，则必须将-DWITH_LIBEVENT构建选项设置为system或
来构建 MySQL yes。
安装和配置 InnoDB memcached 插件
配置daemon_memcached插件，使其可以InnoDB通过运行innodb_memcached_config.sql
配置脚本与表交互，该脚本位于
MYSQL_HOME/share. 此脚本安装innodb_memcache
具有三个必需表（cache_policies、
config_options和
containers）的数据库。它还
在数据库
中安装demo_test示例表
。testmysql> source MYSQL_HOME/share/innodb_memcached_config.sql
运行innodb_memcached_config.sql
脚本是一次性操作。如果您稍后卸载并重新安装
daemon_memcached插件，这些表将保留在原位。
mysql> USE innodb_memcache;
mysql> SHOW TABLES;
+---------------------------+
| Tables_in_innodb_memcache |
+---------------------------+
| cache_policies            |
| config_options            |
| containers                |
+---------------------------+
mysql> USE test;
mysql> SHOW TABLES;
+----------------+
| Tables_in_test |
+----------------+
| demo_test      |
+----------------+
在这些表中，
innodb_memcache.containers表是最重要的。表中的条目提供到表列containers
的映射。与插件一起使用的InnoDB每个InnoDB表
都需要在表中有一个条目。
daemon_memcachedcontainers
该innodb_memcached_config.sql脚本在表中插入单个条目，为containers
表提供映射
demo_test。它还将单行数据插入demo_test表中。此数据允许您在安装完成后立即验证安装。
mysql> SELECT * FROM innodb_memcache.containers\G
*************************** 1. row ***************************
name: aaa
db_schema: test
db_table: demo_test
key_columns: c1
value_columns: c2
flags: c3
cas_column: c4
expire_time_column: c5
unique_idx_name_on_key: PRIMARY
mysql> SELECT * FROM test.demo_test;
+----+------------------+------+------+------+
| c1 | c2               | c3   | c4   | c5   |
+----+------------------+------+------+------+
| AA | HELLO, HELLO     |    8 |    0 |    0 |
+----+------------------+------+------+------+
有关
innodb_memcache表和
demo_test示例表的更多信息，请参阅
第 15.20.8 节，“InnoDB memcached 插件内部”。
通过运行以下语句
激活daemon_memcached插件：INSTALL PLUGINmysql> INSTALL PLUGIN daemon_memcached soname "libmemcached.so";
安装插件后，每次重新启动 MySQL 服务器时都会自动激活它。
验证 InnoDB 和 memcached 设置
要验证daemon_memcached插件设置，请使用telnet会话发出
memcached命令。默认情况下，
memcached守护程序侦听端口 11211。
从test.demo_test
表中检索数据。表中单行数据
demo_test的键值为
AA。
telnet localhost 11211
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
get AA
VALUE AA 8 12
HELLO, HELLO
END
使用set命令插入数据。
set BB 10 0 16
GOODBYE, GOODBYE
STORED
在哪里：
set是存储值的命令
BB是关键
10是操作的标志；被memcached忽略，但可以被客户端用来指示任何类型的信息；指定0是否未使用
0是过期时间（TTL）；指定0是否未使用
16是提供的值块的长度（以字节为单位）
GOODBYE, GOODBYE是存储的值
test.demo_test通过连接MySQL服务器并查询表
，验证插入的数据是否存储在MySQL
中。mysql> SELECT * FROM test.demo_test;
+----+------------------+------+------+------+
| c1 | c2               | c3   | c4   | c5   |
+----+------------------+------+------+------+
| AA | HELLO, HELLO     |    8 |    0 |    0 |
| BB | GOODBYE, GOODBYE |   10 |    1 |    0 |
+----+------------------+------+------+------+
返回到 telnet 会话并检索您之前使用 key 插入的数据BB。
get BB
VALUE BB 10 16
GOODBYE, GOODBYE
END
quit
如果关闭 MySQL 服务器，这也会关闭集成的memcached服务器，进一步尝试访问memcached数据将失败并出现连接错误。通常，memcached数据此时也会消失，您需要应用程序逻辑在memcached重新启动
时将数据加载回内存
。但是，
InnoDB memcached插件会为您自动执行此过程。
当您重新启动 MySQL 时，get操作将再次返回您存储在较早的
memcached会话中的键值对。当请求一个键并且关联的值不在内存缓存中时，会自动从 MySQL
test.demo_test表中查询该值。
创建新表和列映射
此示例显示如何
使用插件
设置您自己的InnoDB表格
。daemon_memcached
创建一个InnoDB表。该表必须有一个带有唯一索引的键列。city 表的键列是city_id，定义为主键。该表还必须包含
flags、cas和
expiry值的列。可能有一个或多个值列。该city表具有三个值列 ( name,
state, country)。
笔记
只要将有效的映射添加到
innodb_memcache.containers表中，就没有关于列名的特殊要求。
mysql> CREATE TABLE city (
city_id VARCHAR(32),
name VARCHAR(1024),
state VARCHAR(1024),
country VARCHAR(1024),
flags INT,
cas BIGINT UNSIGNED,
expiry INT,
primary key(city_id)
) ENGINE=InnoDB;
向表中添加一个条目，
innodb_memcache.containers以便daemon_memcached插件知道如何访问该InnoDB表。该条目必须满足innodb_memcache.containers
表定义。有关每个字段的说明，请参阅
第 15.20.8 节，“InnoDB memcached 插件内部”。
mysql> DESCRIBE innodb_memcache.containers;
+------------------------+--------------+------+-----+---------+-------+
| Field                  | Type         | Null | Key | Default | Extra |
+------------------------+--------------+------+-----+---------+-------+
| name                   | varchar(50)  | NO   | PRI | NULL    |       |
| db_schema              | varchar(250) | NO   |     | NULL    |       |
| db_table               | varchar(250) | NO   |     | NULL    |       |
| key_columns            | varchar(250) | NO   |     | NULL    |       |
| value_columns          | varchar(250) | YES  |     | NULL    |       |
| flags                  | varchar(250) | NO   |     | 0       |       |
| cas_column             | varchar(250) | YES  |     | NULL    |       |
| expire_time_column     | varchar(250) | YES  |     | NULL    |       |
| unique_idx_name_on_key | varchar(250) | NO   |     | NULL    |       |
+------------------------+--------------+------+-----+---------+-------+
city 表的innodb_memcache.containers表条目定义为：
mysql> INSERT INTO `innodb_memcache`.`containers` (
`name`, `db_schema`, `db_table`, `key_columns`, `value_columns`,
`flags`, `cas_column`, `expire_time_column`, `unique_idx_name_on_key`)
VALUES ('default', 'test', 'city', 'city_id', 'name|state|country',
'flags','cas','expiry','PRIMARY');
default为
containers.name列指定以将表配置为与插件
一起使用city的默认
InnoDB表
。daemon_memcached
多个InnoDB表列 ( name, state,
country)
containers.value_columns使用
“ | ”分隔符。
表的flags、
cas_column和
expire_time_column字段
在使用插件innodb_memcache.containers的应用程序中通常不重要
。但是，每个都需要daemon_memcached一个指定的表列。InnoDB插入数据时，
0如果未使用，请指定这些列。
更新
innodb_memcache.containers表后，重新启动daemon_memcache插件以应用更改。
mysql> UNINSTALL PLUGIN daemon_memcached;
mysql> INSTALL PLUGIN daemon_memcached soname "libmemcached.so";使用 telnet，使用memcached命令
将数据插入city
表中。
settelnet localhost 11211
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
set B 0 0 22
BANGALORE|BANGALORE|IN
STORED
使用 MySQL，查询test.city表以验证您插入的数据是否已存储。
mysql> SELECT * FROM test.city;
+---------+-----------+-----------+---------+-------+------+--------+
| city_id | name      | state     | country | flags | cas  | expiry |
+---------+-----------+-----------+---------+-------+------+--------+
| B       | BANGALORE | BANGALORE | IN      |     0 |    3 |      0 |
+---------+-----------+-----------+---------+-------+------+--------+
使用 MySQL，将附加数据插入
test.city表中。
mysql> INSERT INTO city VALUES ('C','CHENNAI','TAMIL NADU','IN', 0, 0 ,0);
mysql> INSERT INTO city VALUES ('D','DELHI','DELHI','IN', 0, 0, 0);
mysql> INSERT INTO city VALUES ('H','HYDERABAD','TELANGANA','IN', 0, 0, 0);
mysql> INSERT INTO city VALUES ('M','MUMBAI','MAHARASHTRA','IN', 0, 0, 0);
笔记
如果未使用，建议您
0为flags、
cas_column和
expire_time_column字段指定一个值。
使用 telnet，发出memcached
get命令以检索您使用 MySQL 插入的数据。
get H
VALUE H 0 22
HYDERABAD|TELANGANA|IN
END
配置 InnoDB memcached 插件
传统memcached的配置选项可以在 MySQL 配置文件或
mysqld启动字符串中指定，编码在
daemon_memcached_option
配置参数的参数中。memcached
配置选项在加载插件时生效，每次启动 MySQL 服务器时都会发生。
例如，要使memcached侦听端口 11222 而不是默认端口 11211，请指定
-p11222为
daemon_memcached_option
配置选项的参数：
mysqld .... --daemon_memcached_option="-p11222"
其他memcached选项可以在
daemon_memcached_option字符串中编码。例如，您可以指定选项以减少最大同时连接数、更改键值对的最大内存大小或为错误日志启用调试消息等。
还有特定于
daemon_memcached插件的配置选项。这些包括：
daemon_memcached_engine_lib_name：指定实现
InnoDB memcached
插件的共享库。默认设置为
innodb_engine.so。
daemon_memcached_engine_lib_path：包含实现InnoDB
memcached插件的共享库的目录路径。默认为NULL，代表插件目录。
daemon_memcached_r_batch_size：定义读取操作的批量提交大小 ( get)。它指定
发生提交之前的memcached读取操作
数。
默认情况下设置为 1，以便每个
请求访问表中最近提交
的数据，无论数据是通过memcached还是通过 SQL 更新的。当该值大于 1 时，读取操作的计数器会随着每次调用而递增。调用重置读取和写入计数器
。
daemon_memcached_r_batch_sizegetInnoDBgetflush_all
daemon_memcached_w_batch_size：定义写入操作的批量提交大小（set、replace、
append、prepend、
incr、decr等）。
daemon_memcached_w_batch_size
默认情况下设置为 1，以便在发生中断时不会丢失未提交的数据，并且使基础表上的 SQL 查询访问最新数据。当该值大于 1 时，写入操作的计数器会针对每个add、
set、incr、
decr和delete调用递增。flush_all调用重置读取和写入计数器
。
默认情况下，您不需要修改
daemon_memcached_engine_lib_name
or
daemon_memcached_engine_lib_path。例如，如果您想为 memcached 使用不同的存储引擎（例如 NDB memcached 引擎），则可以配置
这些选项。
daemon_memcached插件配置参数可以在 MySQL 配置文件或mysqld启动字符串中指定。daemon_memcached它们在您加载插件
时生效。
更改daemon_memcached
插件配置时，重新加载插件以应用更改。为此，请发出以下语句：
mysql> UNINSTALL PLUGIN daemon_memcached;
mysql> INSTALL PLUGIN daemon_memcached soname "libmemcached.so";
重新启动插件时，将保留配置设置、所需的表和数据。
有关启用和禁用插件的其他信息，请参阅第 5.6.1 节，“安装和卸载插件”。
© Mysql 中文网
