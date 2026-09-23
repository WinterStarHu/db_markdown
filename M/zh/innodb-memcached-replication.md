# 15.20.7 InnoDB memcached 插件和复制_MySQL 8.0 参考手册

15.20.7 InnoDB memcached 插件和复制_MySQL 8.0 参考手册
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
15.20.7 InnoDB memcached 插件和复制
15.20.7 InnoDB memcached 插件和复制
由于该daemon_memcached插件支持 MySQL二进制日志，可以通过memcached接口复制源服务器进行备份，平衡密集读取工作负载和高可用性。二进制日志记录支持
所有memcached命令。
您不需要daemon_memcached
在副本服务器上设置插件。此配置的主要优点是增加了源上的写入吞吐量。复制机制的速度不受影响。
daemon_memcached以下部分展示了在将插件与 MySQL 复制结合
使用时如何使用二进制日志功能。假定您已完成第 15.20.3 节“设置 InnoDB memcached 插件”中描述的设置。
启用 InnoDB memcached 二进制日志
要将daemon_memcached插件与 MySQL二进制日志一起使用，请在源服务器上启用
innodb_api_enable_binlog
配置选项。此选项只能在服务器启动时设置。--log-bin您还必须使用该选项在源服务器上启用 MySQL 二进制日志
。您可以将这些选项添加到 MySQL 配置文件或
mysqld命令行中。
mysqld ... --log-bin -–innodb_api_enable_binlog=1
配置源服务器和副本服务器，如
第 17.1.2 节“设置基于二进制日志文件位置的复制”中所述。
使用mysqldump创建源数据快照，并将快照同步到副本服务器。
source $> mysqldump --all-databases --lock-all-tables > dbdump.db
replica $> mysql < dbdump.db
在源服务器上，发出SHOW MASTER
STATUS以获取源二进制日志坐标。
mysql> SHOW MASTER STATUS;
在副本服务器上，使用CHANGE
REPLICATION SOURCE TO语句（来自 MySQL 8.0.23）或CHANGE MASTER TO
语句（MySQL 8.0.23 之前）使用源二进制日志坐标设置副本服务器。
mysql> CHANGE MASTER TO
MASTER_HOST='localhost',
MASTER_USER='root',
MASTER_PASSWORD='',
MASTER_PORT = 13000,
MASTER_LOG_FILE='0.000001,
MASTER_LOG_POS=114;
Or from MySQL 8.0.23:
mysql> CHANGE REPLICATION SOURCE TO
SOURCE_HOST='localhost',
SOURCE_USER='root',
SOURCE_PASSWORD='',
SOURCE_PORT = 13000,
SOURCE_LOG_FILE='0.000001,
SOURCE_LOG_POS=114;
启动副本。
mysql> START SLAVE;
Or from MySQL 8.0.22:
mysql> START REPLICA;
如果错误日志打印类似于以下内容的输出，则副本已准备好进行复制。
2013-09-24T13:04:38.639684Z 49 [Note] Replication I/O thread: connected to
source 'root@localhost:13000', replication started in log '0.000001'
at position 114
测试 InnoDB memcached 复制配置
此示例演示如何
使用memcached
和 telnet 插入、更新和删除数据来测试InnoDB memcached
复制配置。MySQL 客户端用于验证源服务器和副本服务器上的结果。
该示例使用该demo_test表，该表是
在插件innodb_memcached_config.sql初始设置期间由配置脚本
创建的。daemon_memcached该
demo_test表包含一个示例记录。
使用set命令插入一条记录，key为test1，flag值为
10，过期值为
0，cas值为1，值为
t1。
telnet 127.0.0.1 11211
Trying 127.0.0.1...
Connected to 127.0.0.1.
Escape character is '^]'.
set test1 10 0 1
t1
STORED
在源服务器上，检查记录是否已插入到demo_test表中。假设该
demo_test表之前没有被修改过，应该有两条记录。示例记录的键为AA，而您刚刚插入的记录的键为test1。列
c1映射到键，列映射到
c2值，
列映射到c3标志值，
列映射到c4cas值，
列映射到c5过期时间。到期时间设置为 0，因为它未被使用。
mysql> SELECT * FROM test.demo_test;
+-------+--------------+------+------+------+
| c1    | c2           | c3   | c4   | c5   |
+-------+--------------+------+------+------+
| AA    | HELLO, HELLO |    8 |    0 |    0 |
| test1 | t1           |   10 |    1 |    0 |
+-------+--------------+------+------+------+
检查以验证相同的记录是否已复制到副本服务器。
mysql> SELECT * FROM test.demo_test;
+-------+--------------+------+------+------+
| c1    | c2           | c3   | c4   | c5   |
+-------+--------------+------+------+------+
| AA    | HELLO, HELLO |    8 |    0 |    0 |
| test1 | t1           |   10 |    1 |    0 |
+-------+--------------+------+------+------+
使用set命令将键更新为值new。
telnet 127.0.0.1 11211
Trying 127.0.0.1...
Connected to 127.0.0.1.
Escape character is '^]'.
set test1 10 0 2
new
STORED
更新被复制到副本服务器（注意cas值也被更新）。
mysql> SELECT * FROM test.demo_test;
+-------+--------------+------+------+------+
| c1    | c2           | c3   | c4   | c5   |
+-------+--------------+------+------+------+
| AA    | HELLO, HELLO |    8 |    0 |    0 |
| test1 | new          |   10 |    2 |    0 |
+-------+--------------+------+------+------+test1使用
delete命令
删除记录。telnet 127.0.0.1 11211
Trying 127.0.0.1...
Connected to 127.0.0.1.
Escape character is '^]'.
delete test1
DELETED
当delete操作复制到副本时，副本test1上的记录也被删除。
mysql> SELECT * FROM test.demo_test;
+----+--------------+------+------+------+
| c1 | c2           | c3   | c4   | c5   |
+----+--------------+------+------+------+
| AA | HELLO, HELLO |    8 |    0 |    0 |
+----+--------------+------+------+------+flush_all使用命令
从表中删除所有行
。telnet 127.0.0.1 11211
Trying 127.0.0.1...
Connected to 127.0.0.1.
Escape character is '^]'.
flush_all
OKmysql> SELECT * FROM test.demo_test;
Empty set (0.00 sec)
Telnet 到源服务器并输入两条新记录。
telnet 127.0.0.1 11211
Trying 127.0.0.1...
Connected to 127.0.0.1.
Escape character is '^]'
set test2 10 0 4
again
STORED
set test3 10 0 5
again1
STORED
确认这两条记录已复制到副本服务器。
mysql> SELECT * FROM test.demo_test;
+-------+--------------+------+------+------+
| c1    | c2           | c3   | c4   | c5   |
+-------+--------------+------+------+------+
| test2 | again        |   10 |    4 |    0 |
| test3 | again1       |   10 |    5 |    0 |
+-------+--------------+------+------+------+flush_all使用命令
从表中删除所有行
。telnet 127.0.0.1 11211
Trying 127.0.0.1...
Connected to 127.0.0.1.
Escape character is '^]'.
flush_all
OK
检查以确保该flush_all
操作已复制到副本服务器上。
mysql> SELECT * FROM test.demo_test;
Empty set (0.00 sec)
InnoDB memcached 二进制日志注释
二进制日志格式：
大多数memcached操作都映射到
DML语句（类似于插入、删除、更新）。由于 MySQL 服务器没有实际处理 SQL 语句，因此所有
memcached命令（除了
flush_all）都使用基于行的复制 (RBR) 日志记录，它独立于任何服务器
binlog_format设置。
memcached
flush_all命令映射到
TRUNCATE TABLEMySQL 5.7 及更早版本中
的命令。由于
DDL命令只能使用基于语句的日志记录，因此flush_all
通过发送
TRUNCATE TABLE语句来复制命令。在 MySQL 8.0 及更高版本中，flush_all映射到DELETE但仍通过发送TRUNCATE TABLE
语句进行复制。
交易：
事务
的概念
通常不是memcached
应用程序的一部分。出于性能考虑，
daemon_memcached_r_batch_size
用于
daemon_memcached_w_batch_size
控制读写事务的批量大小。这些设置不影响复制。成功完成后，基础InnoDB
表上的每个 SQL 操作都会被复制。
的默认值为
daemon_memcached_w_batch_size
，1这意味着每个
memcached写操作都会立即提交。此默认设置会产生一定量的性能开销，以避免源服务器和副本服务器上可见的数据不一致。复制的记录总是在副本服务器上立即可用。如果设置
daemon_memcached_w_batch_size
的值大于，则通过memcached1插入或更新的记录不会立即在源服务器上可见；要在提交之前查看源服务器上的记录，请发出.
SET
TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
© Mysql 中文网
