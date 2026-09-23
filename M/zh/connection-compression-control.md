# 4.2.8 连接压缩控制_MySQL 8.0 参考手册

4.2.8 连接压缩控制_MySQL 8.0 参考手册
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
4.1 MySQL程序概述
4.2 使用 MySQL 程序
4.2.1 调用MySQL程序1
4.2.2 指定程序选项1
4.2.3 连接服务器的命令选项1
4.2.4 使用命令选项连接到 MySQL 服务器1
4.2.5 使用类似 URI 的字符串或键值对连接到服务器1
4.2.6 使用 DNS SRV 记录连接到服务器1
4.2.7 连接传输协议1
4.2.8 连接压缩控制1
4.2.9 设置环境变量1
4.3 服务器和服务器启动程序
4.4 安装相关程序
4.5 客户端程序
4.6 管理和实用程序
4.7 程序开发实用程序
4.8 杂项程序
4.9 环境变量
4.10 MySQL 中的 Unix 信号处理
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.2 使用 MySQL 程序  /
4.2.8 连接压缩控制
4.2.8 连接压缩控制
与服务器的连接可以对客户端和服务器之间的流量使用压缩，以减少通过连接发送的字节数。默认情况下，连接是未压缩的，但如果服务器和客户端就相互允许的压缩算法达成一致，则可以进行压缩。
压缩连接源自客户端，但会影响客户端和服务器端的 CPU 负载，因为双方都执行压缩和解压缩操作。因为启用压缩会降低性能，所以它的好处主要出现在网络带宽较低、网络传输时间占压缩和解压缩操作成本的主要部分以及结果集很大的情况下。
本节描述可用的压缩控制配置参数和可用于监视压缩使用的信息源。它适用于经典的 MySQL 协议连接。
压缩控制适用于客户端程序和参与源/副本复制或组复制的服务器与服务器的连接。压缩控制不适用于FEDERATED表的连接。在下面的讨论中，“客户端连接”是从支持压缩的任何来源到服务器的连接的简写，除非上下文指示特定的连接类型。
笔记
与 MySQL 服务器实例的 X 协议连接支持来自 MySQL 8.0.19 的压缩，但 X 协议连接的压缩独立于此处描述的经典 MySQL 协议连接的压缩运行，并且单独控制。有关 X 协议连接压缩的信息，请参阅
第 20.5.5 节，“使用 X 插件进行连接压缩”。
配置连接压缩配置传统连接压缩监控连接压缩
配置连接压缩
从 MySQL 8.0.18 开始，这些配置参数可用于控制连接压缩：
protocol_compression_algorithms
系统变量配置服务器允许传入连接的压缩算法
。
和
命令行选项为这些客户端程序配置允许的压缩算法和压缩级别--compression-algorithms
：mysql、
mysqladmin、
mysqlbinlog、
mysqlcheck、mysqldump、
mysqlimport、
mysqlpump、mysqlshow、
mysqlslap、
mysqltest和
mysql_upgrade。MySQL Shell 在其 8.0.20 版本中也提供了这些命令行选项。
--zstd-compression-levelzstd
该函数的MYSQL_OPT_COMPRESSION_ALGORITHMS和
MYSQL_OPT_ZSTD_COMPRESSION_LEVEL选项为使用 MySQL C API 的客户端程序
mysql_options()
配置允许的压缩算法和
压缩级别。zstd
语句
的MASTER_COMPRESSION_ALGORITHMS和
MASTER_ZSTD_COMPRESSION_LEVEL选项为参与源/副本复制的副本服务器配置允许的压缩算法和压缩级别。从 MySQL 8.0.23 开始，使用语句和选项
and
代替。
CHANGE MASTER TOzstdCHANGE
REPLICATION SOURCE TOSOURCE_COMPRESSION_ALGORITHMSSOURCE_ZSTD_COMPRESSION_LEVEL
当
新成员加入组并连接到捐赠者时
，group_replication_recovery_compression_algorithms
和
group_replication_recovery_zstd_compression_level
系统变量为组复制恢复连接配置允许的压缩算法和压缩级别。zstd
启用指定压缩算法的配置参数是字符串值的，并采用一个或多个以逗号分隔的压缩算法名称的列表，以任意顺序，从以下项目中选择（不区分大小写）：
zlib：允许使用
zlib压缩算法的连接。
zstd: 允许使用
zstd压缩算法 (zstd 1.3) 的连接。
uncompressed：允许未压缩的连接。
笔记
因为uncompressed是一个可能配置也可能不配置的算法名称，所以可以将 MySQL 配置为不允许未压缩的连接。
例子：
要配置服务器允许传入连接的压缩算法，请设置
protocol_compression_algorithms
系统变量。默认情况下，服务器允许所有可用的算法。要在启动时显式配置该设置，请在服务器
my.cnf文件中使用以下行：
[mysqld]
protocol_compression_algorithms=zlib,zstd,uncompressedprotocol_compression_algorithms
要在运行时将系统变量
设置并保持
为该值，请使用以下语句：SET PERSIST protocol_compression_algorithms='zlib,zstd,uncompressed';
SET
PERSIST为正在运行的 MySQL 实例设置一个值。它还会保存该值，使其在随后的服务器重新启动时继续使用。要更改正在运行的 MySQL 实例的值而不使其延续到后续重新启动，请使用GLOBAL
关键字而不是PERSIST. 请参阅
第 13.7.6.1 节，“变量赋值的 SET 语法”。
要仅允许使用
zstd压缩的传入连接，请在启动时像这样配置服务器：
[mysqld]
protocol_compression_algorithms=zstd
或者，在运行时进行更改：
SET PERSIST protocol_compression_algorithms='zstd';
要允许mysql客户端启动
zlib或uncompressed
连接，请像这样调用它：
mysql --compression-algorithms=zlib,uncompressedzlib要将副本配置为使用or connections
连接到源
，zstd
连接的压缩级别为 7
zstd，请使用
CHANGE REPLICATION SOURCE TO
语句（来自 MySQL 8.0.23）或CHANGE
MASTER TO语句（MySQL 8.0.23 之前）：
CHANGE REPLICATION SOURCE TO
SOURCE_COMPRESSION_ALGORITHMS = 'zlib,zstd',
SOURCE_ZSTD_COMPRESSION_LEVEL = 7;
这假设replica_compressed_protocol
or
slave_compressed_protocol
系统变量被禁用，原因在
配置传统连接压缩中描述。
为了成功建立连接，连接的双方必须就相互允许的压缩算法达成一致。算法协商过程尝试使用
zlib，然后zstd，然后
uncompressed。如果双方找不到共同的算法，则连接尝试失败。
因为双方必须就压缩算法达成一致，并且因为uncompressed是不一定允许的算法值，所以不一定会回退到未压缩的连接。例如，如果服务器配置为 permitzstd而客户端配置为 permit
zlib,uncompressed，则客户端根本无法连接。在这种情况下，双方没有共同的算法，因此连接尝试失败。
启用指定
zstd压缩级别的配置参数采用从 1 到 22 的整数值，值越大表示压缩级别越高。默认zstd压缩级别为 3。压缩级别设置对不使用zstd压缩的连接没有影响。
可配置的zstd压缩级别支持在较少网络流量和较高 CPU 负载与较多网络流量和较低 CPU 负载之间进行选择。较高的压缩级别可减少网络拥塞，但额外的 CPU 负载可能会降低服务器性能。
配置传统连接压缩
在 MySQL 8.0.18 之前，这些配置参数可用于控制连接压缩：
客户端程序支持
--compress命令行选项来指定对服务器连接使用压缩。
对于使用 MySQL C API 的程序，启用该
功能的MYSQL_OPT_COMPRESS选项
mysql_options()指定对服务器连接使用压缩。
对于源/副本复制，启用系统变量
replica_compressed_protocol
（从 MySQL 8.0.26 开始）或
slave_compressed_protocol
（在 MySQL 8.0.26 之前）指定对与源的副本连接使用压缩。
在每种情况下，当指定使用压缩时，zlib如果双方都允许，连接将使用压缩算法，否则回退到未压缩的连接。
从 MySQL 8.0.18 开始，刚刚描述的压缩参数成为遗留参数，因为引入了额外的压缩参数以更好地控制连接压缩，如
配置连接压缩中所述。一个例外是 MySQL Shell，它的
--compress命令行选项保持最新，并且可以用于请求压缩而无需选择压缩算法。有关 MySQL Shell 的连接压缩控制的信息，请参阅
使用压缩连接。
遗留压缩参数与新参数交互，它们的语义变化如下：
legacy
--compress选项的含义取决于是否
--compression-algorithms指定：
--compression-algorithms
不指定时，
相当于
--compress指定客户端算法集
zlib,uncompressed.
指定时
--compression-algorithms
，--compress
相当于指定一个算法集，
zlib而完整的客户端算法集是zlib
加上 指定
的算法的并集--compression-algorithms。例如，对于
--compress和
--compression-algorithms=zlib,zstd，允许的算法集是zlib
plus zlib,zstd；也就是说，
zlib,zstd。对于
--compress和
--compression-algorithms=zstd,uncompressed，允许的算法集是zlib
plus zstd,uncompressed；也就是说，
zlib,zstd,uncompressed。
MYSQL_OPT_COMPRESS遗留选项和
C API 函数
的MYSQL_OPT_COMPRESSION_ALGORITHMS选项
之间会发生相同类型的交互
。mysql_options()
如果启用了
replica_compressed_protocol
or
系统变量，则
如果源和副本都允许该算法slave_compressed_protocol
，则它优先于
MASTER_COMPRESSION_ALGORITHMS并且与源的连接使用压缩。zlib如果
replica_compressed_protocol
或
slave_compressed_protocol
被禁用，则
MASTER_COMPRESSION_ALGORITHMS应用的值。
笔记
从 MySQL 8.0.18 开始，旧的压缩控制参数已被弃用；希望在未来的 MySQL 版本中将其删除。
监控连接压缩
Compressionstatus 变量是ONor表示
当前OFF连接是否使用压缩。
mysql客户端\status
命令显示一行，说明
是否Protocol:
Compressed为当前连接启用了压缩。如果该行不存在，则连接未压缩。
从 8.0.14 开始，MySQL Shell\status
命令显示Compression:一行内容Disabled或Enabled
指示连接是否被压缩。
从 MySQL 8.0.18 开始，这些额外的信息来源可用于监控连接压缩：
要监视用于客户端连接的压缩，请使用Compression_algorithm
和Compression_level
状态变量。对于当前连接，它们的值分别表示压缩算法和压缩级别。
要确定服务器配置为允许传入连接的压缩算法，请检查
protocol_compression_algorithms
系统变量。
对于源/副本复制连接，配置的压缩算法和压缩级别可从多个源获得：
Performance Schema
replication_connection_configuration
表有COMPRESSION_ALGORITHMS和
ZSTD_COMPRESSION_LEVEL列。
系统mysql.slave_master_info表有
Master_compression_algorithms和
Master_zstd_compression_level
列。如果该master.info文件存在，它也包含这些值的行。
© Mysql 中文网
