# 15.20.8 InnoDB memcached 插件内部_MySQL 8.0 参考手册

15.20.8 InnoDB memcached 插件内部_MySQL 8.0 参考手册
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
15.20.8 InnoDB memcached 插件内部
15.20.8 InnoDB memcached 插件内部
用于 InnoDB memcached 插件的 InnoDB API
InnoDB memcached
引擎通过API访问
，InnoDB大部分
InnoDB都是直接从embedded InnoDB.
API 函数作为回调函数InnoDB传递给
InnoDB memcached引擎。InnoDBAPI 函数InnoDB直接访问表，除了
TRUNCATE TABLE.
memcached命令是通过InnoDB memcached API 实现的。下表概述了memcached
命令如何映射到 DML 或 DDL 操作。
表 15.27 memcached 命令和关联的 DML 或 DDL 操作
memcached 命令
DML 或 DDL 操作
get
读/取命令
set
搜索后跟一个INSERT或
UPDATE（取决于键是否存在）
add
搜索后跟一个INSERT或
UPDATE
replace
搜索后跟UPDATE
append
搜索后跟UPDATE（将数据附加到结果之前UPDATE）
prepend
搜索后跟UPDATE（将数据添加到结果之前UPDATE）
incr
搜索后跟UPDATE
decr
搜索后跟UPDATE
delete
搜索后跟DELETE
flush_all
TRUNCATE TABLE(DDL)
InnoDB memcached 插件配置表
本节描述
daemon_memcached插件使用的配置表。表
cache_policies、
config_options表、
containers表是由
数据库innodb_memcached_config.sql中的配置脚本创建的innodb_memcache。
mysql> USE innodb_memcache;
Database changed
mysql> SHOW TABLES;
+---------------------------+
| Tables_in_innodb_memcache |
+---------------------------+
| cache_policies            |
| config_options            |
| containers                |
+---------------------------+
cache_policies 表
该cache_policies表定义了InnoDB
memcached安装的缓存策略。您可以在单个缓存策略中为get、
set、delete和
操作指定单独的策略。flush所有操作的默认设置为
innodb_only。
innodb_only：
InnoDB用作数据存储。
cache_only: 使用
memcached引擎作为数据存储。
caching：同时使用
InnoDB和
memcached引擎作为数据存储。在这种情况下，如果memcached在内存中找不到键，它会在
InnoDB表中搜索该值。
disable: 禁用缓存。
表 15.28 cache_policies 列
柱子
描述
policy_name
缓存策略的名称。默认缓存策略名称是
cache_policy.
get_policy
获取操作的缓存策略。有效值为
innodb_only、
cache_only、caching或disabled。默认设置为
innodb_only。
set_policy
集合操作的缓存策略。有效值为
innodb_only、
cache_only、caching或disabled。默认设置为
innodb_only。
delete_policy
删除操作的缓存策略。有效值为
innodb_only、
cache_only、caching或disabled。默认设置为
innodb_only。
flush_policy
刷新操作的缓存策略。有效值为
innodb_only、
cache_only、caching或disabled。默认设置为
innodb_only。
配置选项表
该config_options表存储
可在运行时使用 SQL 更改的与memcached相关的设置。支持的配置选项是separator和
table_map_delimiter。
表 15.29 config_options 列
柱子
描述
Name
memcached相关配置选项的名称。该
config_options表支持以下配置选项：
separator: 当有多个value_columns
定义时，用于将长字符串的值分隔成单独的值。默认情况下，
separator是一个
|字符。例如，如果您将列定义col1, col2为值，并将列定义|为分隔符，则可以发出以下
memcached命令分别将值插入到col1和
col2中：
set keyx 10 0 19
valuecolx|valuecoly
valuecol1x存储在
col1并
valuecoly存储在
col2.
table_map_delimiter：当您使用@@键名中的表示法访问特定表中的键时，分隔模式名称和表名的字符。例如，@@t1.some_key和
@@t2.some_key具有相同的键值，但存储在不同的表中。
Value
分配给memcached相关配置选项的值。
容器表
该containers表是三个配置表中最重要的一个。每个InnoDB
用于存储memcached值的表都必须在表中有一个条目containers。该条目提供InnoDB
表列和容器表列之间的映射，这是
memcached使用
InnoDB表所必需的。
该containers表包含该表的默认条目，该条目test.demo_test由innodb_memcached_config.sql
配置脚本创建。要将
daemon_memcached插件与您自己的
InnoDB表一起使用，您必须在表中创建一个条目
containers。
表 15.30 容器列
柱子
描述
name
为容器指定的名称。如果未使用
表示法InnoDB按名称请求表，
插件将使用值为
. 如果没有这样的条目，则表中的第一个条目（按字母顺序
（升序）排序）确定默认
表。@@daemon_memcachedInnoDBcontainers.namedefaultcontainersnameInnoDB
db_schema
InnoDB表所在的数据库的名称。这是一个必需的值。
db_table
存储memcached值的InnoDB表
的名称。这是一个必需的值。
key_columns
表中包含内存缓存操作InnoDB的查找键值的列。这是一个必需的值。
value_columns
存储数据的InnoDB表列（一个或多个）
。memcached可以使用表中指定的分隔符来指定多个列
innodb_memcached.config_options。默认情况下，分隔符是管道字符 ( “ | ” )。要指定多个列，请使用定义的分隔符分隔它们。例如：
col1|col2|col3。这是一个必需的值。
flags
InnoDB用作
memcached标志（与主值一起存储和检索的用户定义的数值）的表列。如果memcached值映射到多个列，则标志值可以用作某些操作（例如
incr, prepend）
的列说明符，以便在指定列上执行操作。例如，你将a映射
到三个
表列，只想对其中一个列进行自增操作，则使用
column来指定列。如果您不使用value_columnsInnoDBflagsflags列，设置一个值0表示它未被使用。
cas_column
存储比较和交换 (cas) 值的InnoDB表列。该cas_column值与memcached将请求散列到不同服务器并将数据缓存在内存中的方式有​​关。因为InnoDB
memcached插件与单个memcached守护进程紧密集成，内存缓存机制由 MySQL 和
InnoDB 缓冲池处理，所以很少需要此专栏。如果您不使用此列，请设置一个值0以指示它未被使用。
expire_time_column
存储过期值的InnoDB表列。该expire_time_column值与memcached将请求散列到不同服务器并将数据缓存在内存中的方式有​​关。因为InnoDB
memcached插件与单个memcached守护进程紧密集成，内存缓存机制由 MySQL 和
InnoDB 缓冲池处理，所以很少需要此专栏。如果您不使用此列，请设置一个值0以指示该列未被使用。最大过期时间定义为INT_MAX32或 2147483647 秒（约 68 年）。
unique_idx_name_on_key
键列上的索引名称。它必须是唯一索引。它可以是主键或
二级索引。最好使用表的主键
InnoDB。使用主键可以避免使用二级索引时执行的查找。您不能
为memcached查找
创建覆盖索引；如果您尝试在键和值列上定义复合二级索引，则会返回错误。InnoDB
容器表列约束
db_schema您必须为、
db_name、key_columns和
value_columns提供
一个值unique_idx_name_on_key。指定
0, flags,
cas_column以及
expire_time_column它们是否未使用。否则可能会导致您的设置失败。
key_columns： memcached键的最大限制为
250 个字符，这是由memcached强制执行的。映射的键必须是非 NullCHAR或
VARCHAR类型。
value_columns: 必须映射到
CHAR、
VARCHAR或
BLOB列。没有长度限制，值可以为 NULL。
cas_column：该cas
值为 64 位整数。它必须映射到
BIGINT至少 8 个字节的 a。如果您不使用此列，请设置一个值
0以指示它未被使用。
expiration_time_column: 必须映射到
INTEGER至少 4 个字节。过期时间定义为 Unix 时间的 32 位整数（自 1970 年 1 月 1 日以来的秒数，作为 32 位值），或从当前时间开始的秒数。对于后者，秒数不得超过60*60*24*30（30天的秒数）。如果客户端发送的数字较大，则服务器认为它是一个真正的 Unix 时间值，而不是与当前时间的偏移量。如果您不使用此列，请设置一个值
0以指示它未被使用。
flags: 必须映射到
INTEGER至少 32 位的一个，并且可以为 NULL。如果您不使用此列，请设置一个值0以指示它未被使用。
在插件加载时执行预检查以强制执行列约束。如果发现不匹配，则不会加载插件。
多值列映射
在插件初始化期间，当使用表中定义的信息配置InnoDB
memcached时，将针对映射表验证中containers定义的每个映射列
。如果映射了多个表列，则会进行检查以确保每个列都存在并且是正确的类型。
containers.value_columnsInnoDBInnoDB
在运行时，对于memcached插入操作，如果分隔值的数量多于映射列的数量，则只采用映射值的数量。例如，如果有六个映射列，并提供了七个分隔值，则仅采用前六个分隔值。第七个分隔值将被忽略。
如果分隔值比映射列少，未填充的列将设置为 NULL。如果未填充的列不能设置为 NULL，插入操作将失败。
如果表的列多于映射值，则额外的列不会影响结果。
demo_test 示例表
配置脚本在数据库中innodb_memcached_config.sql
创建一个demo_test
表test，可用于在安装后立即验证InnoDB memcached
插件安装。
配置脚本还在表中为
表innodb_memcached_config.sql
创建一个条目
。
demo_testinnodb_memcache.containersmysql> SELECT * FROM innodb_memcache.containers\G
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
© Mysql 中文网
