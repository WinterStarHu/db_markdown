# 15.20.9 InnoDB memcached 插件故障排除_MySQL 8.0 参考手册

15.20.9 InnoDB memcached 插件故障排除_MySQL 8.0 参考手册
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
15.20.9 InnoDB memcached 插件故障排除
15.20.9 InnoDB memcached 插件故障排除
InnoDB 本节介绍您在使用memcached插件
时可能遇到的问题。
如果您在 MySQL 错误日志中遇到以下错误，则服务器可能无法启动：
未能为打开的文件设置 rlimit。尝试以 root 身份运行或请求较小的 maxconns 值。
错误消息来自memcached
守护进程。一种解决方案是提高操作系统对打开文件数的限制。检查和增加打开文件限制的命令因操作系统而异。此示例显示了适用于 Linux 和 macOS 的命令：
# Linux
$> ulimit -n
1024
$> ulimit -n 4096
$> ulimit -n
4096
# macOS
$> ulimit -n
256
$> ulimit -n 4096
$> ulimit -n
4096另一个解决方案是减少memcached
守护程序
允许的并发连接数。为此，请
在 MySQL 配置文件的配置参数中对-c
memcached选项
进行编码。daemon_memcached_option该
-c选项的默认值为 1024。
[mysqld]
...
loose-daemon_memcached_option='-c 64'
要解决
memcached守护程序无法存储或检索表数据的问题，请
在 MySQL 配置文件的配置参数中对memcached选项InnoDB进行编码
。检查 MySQL 错误日志以获取与
memcached操作相关的调试输出。
-vvv daemon_memcached_option[mysqld]
...
loose-daemon_memcached_option='-vvv'
如果指定用于保存memcached
值的列是错误的数据类型，例如数字类型而不是字符串类型，则尝试存储键值对会失败，并且没有特定的错误代码或消息。
如果插件导致 MySQL 服务器启动问题，您可以通过在 MySQL 配置文件中
的组下添加以下行来在故障排除
daemon_memcached时暂时禁用该
插件：daemon_memcached[mysqld]daemon_memcached=OFF
例如，如果您在运行配置脚本INSTALL
PLUGIN之前运行该语句
innodb_memcached_config.sql以设置必要的数据库和表，则服务器可能会意外退出并无法启动。如果您错误地配置了表中的条目，服务器也可能无法启动innodb_memcache.containers。
要为 MySQL 实例卸载memcached插件，请发出以下语句：
mysql> UNINSTALL PLUGIN daemon_memcached;
如果您在同一台机器上运行多个 MySQL 实例并且daemon_memcached每个实例都启用了插件，请使用
配置参数为每个插件
daemon_memcached_option
指定一个唯一的
memcached端口
。daemon_memcached
如果 SQL 语句找不到InnoDB
表或在表中找不到数据，但
memcachedInnoDB API 调用检索到预期的数据，则表中
可能缺少该表的条目
innodb_memcache.containers，或者您可能没有InnoDB
通过发出命令切换到正确的表aget或
set请求使用
符号。如果您更改表中的现有条目
而没有随后重新启动 MySQL 服务器，也可能会发生此问题。自由格式存储机制足够灵活，您可以请求存储或检索多列值，例如
@@table_idinnodb_memcache.containerscol1|col2|col3可能仍然有效，即使守护进程正在使用test.demo_test将值存储在单个列中的表。
当定义您自己的InnoDB表以与daemon_memcached插件一起使用时，表中的列定义为NOT
NULL，确保
NOT NULL在将表的记录插入表中时为列
提供值innodb_memcache.containers。如果记录的
INSERT语句
innodb_memcache.containers包含的分隔值少于映射列的数量，则未填充的列设置为NULL。尝试将NULL值插入NOT
NULL列会导致
INSERT失败，这可能只有在您重新初始化
daemon_memcached插件以将更改应用到innodb_memcache.containers表后才会变得明显。
如果表的cas_column和
expire_time_column字段
innodb_memcached.containers设置为NULL，则在尝试加载memcached
插件时返回以下错误：
InnoDB_Memcached: column 6 in the entry for config table 'containers' in
database 'innodb_memcache' has an invalid NULL value.memcached插件拒绝
在
和列NULL中使用。将这些列的值设置为未使用列时的值。
cas_columnexpire_time_column0
随着memcached键和值的长度增加，您可能会遇到大小和长度限制。
当键超过 250 字节时，
memcached操作会返回错误。目前这是
memcached中的固定限制。
InnoDB如果值超过 768 字节、3072 字节或
innodb_page_size值的一半，则可能会遇到表限制。如果您打算在值列上创建索引以使用 SQL 在该列上运行报告生成查询，则这些限制主要适用。有关详细信息，请参阅
第 15.22 节，“InnoDB 限制”。
键值组合的最大大小为 1 MB。
如果您在不同版本的 MySQL 服务器之间共享配置文件，则使用daemon_memcached插件的最新配置选项可能会导致旧 MySQL 版本启动错误。为避免兼容性问题，请使用loose带有选项名称的前缀。例如，使用
loose-daemon_memcached_option='-c 64'
而不是daemon_memcached_option='-c 64'。
没有限制或检查来验证字符集设置。memcached以字节为单位存储和检索键和值，因此对字符集不敏感。但是，您必须确保
memcached客户端和 MySQL 表使用相同的字符集。
memcached连接被阻止访问包含索引虚拟列的表。访问索引虚拟列需要回调到服务器，但memcached连接无权访问服务器代码。
© Mysql 中文网
