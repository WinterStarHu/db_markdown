# 23.7.3 NDB Cluster 复制中的已知问题_MySQL 8.0 参考手册

23.7.3 NDB Cluster 复制中的已知问题_MySQL 8.0 参考手册
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
23.1 一般信息
23.2 NDB Cluster 概述
23.3 NDB Cluster 安装
23.4 NDB Cluster的配置
23.5 NDB 集群程序
23.6 NDB Cluster的管理
23.7 NDB 集群复制
23.7.1 NDB Cluster 复制：缩写和符号1
23.7.2 NDB Cluster 复制的一般要求1
23.7.3 NDB Cluster 复制中的已知问题1
23.7.4 NDB Cluster 复制模式和表1
23.7.5 准备 NDB Cluster 进行复制1
23.7.6 启动 NDB Cluster 复制（单复制通道）1
23.7.7 使用两个复制通道进行 NDB Cluster 复制1
23.7.8 使用 NDB Cluster 复制实现故障转移1
23.7.9 使用 NDB Cluster 复制的 NDB Cluster 备份1
23.7.10 NDB Cluster 复制：双向和循环复制1
23.7.11 NDB Cluster 复制冲突解决1
23.8 NDB Cluster 发行说明
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.7 NDB 集群复制  /
23.7.3 NDB Cluster 复制中的已知问题
23.7.3 NDB Cluster 复制中的已知问题
本节讨论使用 NDB Cluster 进行复制时的已知问题或问题。
源和副本之间的连接丢失。
连接丢失可能发生在源集群 SQL 节点和副本集群 SQL 节点之间，或者源 SQL 节点和源集群的数据节点之间。在后一种情况下，这不仅是由于物理连接丢失（例如，网络电缆断开）造成的，而且是由于数据节点事件缓冲区溢出造成的；如果 SQL 节点响应太慢，它可能会被集群丢弃（这在一定程度上可以通过调整
MaxBufferedEpochs和
TimeBetweenEpochs
配置参数来控制）。如果出现这种情况，完全有可能将新数据插入到源集群中，而没有记录在源 SQL 节点的二进制日志中. 因此，为了保证高可用性，维护一个备份复制通道，监控主复制通道，并在必要时故障转移到辅助复制通道以保持副本集群与源同步是非常重要的。NDB Cluster 并非设计用于自行执行此类监视；为此，需要一个外部应用程序。
源 SQL 节点在连接或重新连接到源集群时
发出“ gap ”事件。（间隙事件是一种“事件事件”，它表示发生的事件会影响数据库的内容，但不能轻易表示为一组更改。事件的示例包括服务器故障、数据库重新同步、某些软件更新和一些硬件更改。）当副本遇到复制日志中的间隙时，它会停止并显示一条错误消息。此消息在
SHOW REPLICA STATUS（在 NDB 8.0.22 之前，使用SHOW SLAVE STATUS)，并表示 SQL 线程已因复制流中注册的事件而停止，需要手动干预。有关在这种情况下如何操作的更多信息，
请参阅
第 23.7.8 节，“使用 NDB Cluster 复制实现故障转移” 。
重要的
由于 NDB Cluster 本身并没有设计用于监控复制状态或提供故障转移，如果高可用性是副本服务器或集群的需求，那么您必须设置多个复制线路，
在主复制线路上监控源mysqld ，并且如有必要，准备故障转移到辅助线路。这必须手动完成，或者可能通过第三方应用程序完成。有关实现此类设置的信息，请参阅
第 23.7.7 节，“为 NDB Cluster 复制使用两个复制通道”和
第 23.7.8 节，“使用 NDB Cluster 复制实现故障转移”。
如果您要从独立的 MySQL 服务器复制到 NDB Cluster，一个通道通常就足够了。
循环复制。
NDB Cluster Replication 支持循环复制，如下一个示例所示。复制设置涉及编号为 1、2 和 3 的三个 NDB 集群，其中集群 1 作为集群 2 的复制源，集群 2 作为集群 3 的源，集群 3 作为集群 1 的源，因此完成圆圈。每个 NDB Cluster 有两个 SQL 节点，SQL 节点 A 和 B 属于 Cluster 1，SQL 节点 C 和 D 属于 Cluster 2，SQL 节点 E 和 F 属于 Cluster 3。
只要满足以下条件，就支持使用这些集群的循环复制：
所有源集群和副本集群上的 SQL 节点都是相同的。
所有充当源和副本的 SQL 节点都以启用系统变量
log_replica_updates（NDB 8.0.26 及更高版本）或
log_slave_updates（在 NDB 8.0.26 之前）启动。
这种类型的循环复制设置如下图所示：
图 23.11 将所有源作为副本的 NDB Cluster 循环复制
在这个场景中，Cluster 1 中的 SQL 节点 A 复制到 Cluster 2 中的 SQL 节点 C；SQL节点C复制到Cluster 3中的SQL节点E；SQL节点E复制到SQL节点A。换句话说，复制线（图中弯曲箭头所示）直接连接所有作为源和副本的SQL节点。
还应该可以设置循环复制，其中并非所有源 SQL 节点也是副本，如下所示：
图 23.12 NDB Cluster 循环复制，其中并非所有源都是副本
在这种情况下，每个集群中的不同 SQL 节点用作源和副本。但是，您不得log_replica_updates在启用或
log_slave_updates系统变量
的情况下启动任何 SQL 节点
。NDB Cluster 的这种循环复制方案，其中复制线（再次由图中的弯曲箭头指示）是不连续的，应该是可能的，但应该注意的是，它尚未经过彻底测试，因此必须仍然被认为是实验性的。
笔记
NDB存储引擎使用
幂等执行模式，它可以抑制重复键和其他破坏 NDB Cluster 循环复制的错误。这相当于将系统变量的全局值设置为
replica_exec_modeor
slave_exec_mode，
IDEMPOTENT尽管这在 NDB Cluster 复制中不是必需的，因为 NDB Cluster 自动设置此变量并忽略任何显式设置它的尝试。
NDB Cluster 复制和主键。
在节点故障的
NDB情况下，由于在这种情况下可能会插入重复的行，因此在复制没有主键的表时仍然会发生错误。出于这个原因，强烈建议所有NDB被复制的表都具有显式主键。
NDB Cluster 复制和唯一键。
在旧版本的 NDB Cluster 中，更新表的唯一键列值的操作NDB在复制时可能会导致重复键错误。NDB通过将唯一键检查推迟到执行所有表行更新之后，
解决了表之间复制的这个问题
。
目前只有
NDB. 因此，仍然不支持
从NDB不同的存储引擎（例如
InnoDB或
）复制时更新唯一键。MyISAM
在不延迟检查唯一键更新的情况下进行复制时遇到的问题可以使用
NDB诸如 之类的表
来说明t，在源上创建和填充（并传输到不支持延迟唯一键更新的副本），如下所示：
CREATE TABLE t (
p INT PRIMARY KEY,
c INT,
UNIQUE KEY u (c)
)   ENGINE NDB;
INSERT INTO t
VALUES (1,1), (2,2), (3,3), (4,4), (5,5);
以下UPDATE语句在
t源上成功，因为受影响的行按照选项确定的顺序处理，
ORDER BY在整个表上执行：
UPDATE t SET c = c - 1 ORDER BY p;
同一语句因副本上的重复键错误或其他约束违规而失败，因为行更新的排序是一次对一个分区执行的，而不是对整个表执行的。
笔记
每个NDB表在创建时都按键隐式分区。有关更多信息，请参阅
第 24.2.5 节，“KEY 分区”。
不支持 GTID。
使用全局事务 ID 的复制与存储引擎不兼容，NDB因此不受支持。启用 GTID 可能会导致 NDB Cluster Replication 失败。
不支持多线程副本。
NDB Cluster 不支持多线程副本。这是因为副本可能无法将发生在一个数据库中的事务与发生在另一个数据库中的事务分开（如果它们是在同一时期内写入的）。此外，由于需要更新
表（请参阅
第 23.7.4 节，“NDB 集群复制模式和表”） ，NDB存储引擎处理的每个事务至少涉及两个数据库——目标数据库和系统数据库。这反过来又打破了事务特定于给定数据库的多线程要求。
mysqlmysql.ndb_apply_status
在 NDB 8.0.26 之前，设置与多线程副本相关的任何系统变量，例如
replica_parallel_workersor
slave_parallel_workers，和
replica_checkpoint_groupor
slave_checkpoint_group（或等效的mysqld启动选项）被完全忽略，并且没有效果。
在 NDB 8.0.27 及更高版本中，
replica_parallel_workers必须设置为 0。如果在启动时设置为任何其他值，NDB请将其更改为 0，并将消息写入mysqld
服务器日志文件。
使用 --initial 重新启动。
使用该选项重新启动集群
--initial会导致 GCI 和纪元编号的序列从 重新开始
0。（这通常适用于 NDB Cluster，并且不限于涉及 Cluster 的复制场景。）在这种情况下，应该重新启动复制中涉及的 MySQL 服务器。在此之后，您应该使用
RESET MASTERand
RESET REPLICA（在 NDB 8.0.22 之前，使用RESET SLAVE）语句分别清除无效
ndb_binlog_index和
ndb_apply_status表。
从导航台复制到其他存储引擎。 NDB
考虑到此处列出的限制，可以将源上的表
复制到副本上使用不同存储引擎的表：
不支持多源和循环​​复制（源和副本上的表必须使用
NDB存储引擎才能工作）。
使用不对副本上的表执行二进制日志记录的存储引擎需要特殊处理。
对副本上的表使用非事务性存储引擎也需要特殊处理。
源mysqld必须以
--ndb-log-update-as-write=0或
开头--ndb-log-update-as-write=OFF。
接下来的几段提供了有关刚才描述的每个问题的附加信息。
将导航台复制到其他存储引擎时不支持多个源。
对于从不同存储引擎的复制，NDB两个数据库之间的关系必须是一对一的。这意味着 NDB Cluster 和其他存储引擎之间不支持双向或循环复制。
NDB此外，在不同的存储引擎
之间进行复制时，不可能配置多个复制通道
。（一个 NDB Cluster 数据库可以同时复制到多个 NDB Cluster 数据库。）如果源使用
NDB表，仍然可以有多个 MySQL 服务器维护所有更改的二进制日志，但是对于副本更改源（故障转移)，必须在副本上明确定义新的源副本关系。
将导航台表复制到不执行二进制日志记录的存储引擎。
如果您尝试从 NDB Cluster 复制到使用不处理其自己的二进制日志记录的存储引擎的副本，则复制过程中止并出现错误
Binary logging not possible ... Statement cannot be written atomically since more than one engine涉及并且至少有一个引擎是自记录的（错误
1595）。可以通过以下方式之一解决此问题：
关闭副本上的二进制日志记录。
这可以通过设置来完成
sql_log_bin = 0。
更改用于 mysql.ndb_apply_status 表的存储引擎。
使该表使用不处理其自身二进制日志记录的引擎也可以消除冲突。这可以通过
ALTER TABLE
mysql.ndb_apply_status ENGINE=MyISAM在副本上发布诸如此类的语句来完成。在副本上使用存储引擎以外的存储引擎时这样做是安全NDB的，因为您无需担心保持多个副本同步。
过滤掉对副本上的 mysql.ndb_apply_status 表的更改。
这可以通过使用 启动副本来完成
--replicate-ignore-table=mysql.ndb_apply_status。如果您需要复制忽略其他表，您可能希望使用适当的
--replicate-wild-ignore-table
选项。
重要的
从一个 NDB Cluster 复制到另一个时，您不应禁用复制或二进制日志记录mysql.ndb_apply_status或更改用于此表的存储引擎。有关详细信息，请参阅
复制和二进制日志过滤规则以及 NDB Clusters 之间的复制。
从导航台复制到非事务性存储引擎。
从复制NDB到非事务性存储引擎（例如 ）时
，您可能会在复制语句MyISAM时遇到不必要的重复键错误
。INSERT ...
ON DUPLICATE KEY UPDATE您可以通过使用 来抑制这些
--ndb-log-update-as-write=0，这会强制将更新记录为写入，而不是更新。
复制和二进制日志过滤规则与 NDB 集群之间的复制。
如果您使用任何选项
--replicate-do-*、
--replicate-ignore-*、
--binlog-do-db或
--binlog-ignore-db来过滤正在复制的数据库或表，则必须注意不要阻止复制或二进制日志记录
mysql.ndb_apply_status，这是 NDB 集群之间的复制正常运行所必需的。特别是，您必须牢记以下几点：
使用
（没有其他或
选项）意味着
只复制数据库中的表
。在这种情况下，您还应该使用
、
或
来确保在副本上填充它。
--replicate-do-db=db_name--replicate-do-*--replicate-ignore-*db_name--replicate-do-db=mysql--binlog-do-db=mysql--replicate-do-table=mysql.ndb_apply_statusmysql.ndb_apply_status
使用
（没有其他
选项）意味着只将对数据库中表的更改写入二进制日志。在这种情况下，您还应该使用
、
或
来确保在副本上填充它。
--binlog-do-db=db_name--binlog-do-dbdb_name--replicate-do-db=mysql--binlog-do-db=mysql--replicate-do-table=mysql.ndb_apply_statusmysql.ndb_apply_status
使用
--replicate-ignore-db=mysql
意味着mysql数据库中没有表被复制。在这种情况下，您还应该使用
--replicate-do-table=mysql.ndb_apply_status
以确保mysql.ndb_apply_status被复制。
使用--binlog-ignore-db=mysql
意味着
mysql数据库中表的更改不会写入二进制日志。在这种情况下，您还应该使用
--replicate-do-table=mysql.ndb_apply_status
以确保mysql.ndb_apply_status被复制。
您还应该记住，每个复制规则都需要以下内容：
它自己的--replicate-do-*或
--replicate-ignore-*选项，并且不能在单个复制过滤选项中表示多个规则。有关这些规则的信息，请参阅
第 17.1.6 节，“复制和二进制日志记录选项和变量”。
它自己的--binlog-do-db或
--binlog-ignore-db选项，并且不能在单个二进制日志过滤选项中表示多个规则。有关这些规则的信息，请参阅
第 5.4.4 节，“二进制日志”。
如果您正在将 NDB Cluster 复制到使用除 以外的存储引擎的副本，NDB那么前面给出的注意事项可能不适用，如本节其他地方所讨论的那样。
NDB 集群复制和 IPv6。
从 NDB 8.0.22 开始，所有类型的 NDB Cluster 节点都支持 IPv6；这包括管理节点、数据节点和 API 或 SQL 节点。
在 NDB 8.0.22 之前，NDB API 和 MGM API（以及数据节点和管理节点）不支持 IPv6，尽管 MySQL 服务器（包括在 NDB Cluster 中充当 SQL 节点的服务器）可以使用 IPv6 联系其他 MySQL 服务器. 在 8.0.22 之前的 NDB Cluster 版本中，您可以使用 IPv6 在集群之间进行复制，以连接充当源和副本的 SQL 节点，如下图中的虚线箭头所示：
图 23.13 使用 IPv6 连接的 SQL 节点之间的复制
在 NDB 8.0.22 之前，所有源自 NDB Cluster 的连接
——在上图中用实线箭头表示——必须使用 IPv4。换句话说，所有 NDB Cluster 数据节点、管理服务器和管理客户端都必须可以使用 IPv4 相互访问。此外，SQL 节点必须使用 IPv4 与集群通信。在 NDB 8.0.22 及更高版本中，这些限制不再适用；此外，任何使用 NDB 和 MGM API 编写的应用程序都可以在假设纯 IPv6 环境的情况下编写和部署。
属性提升和降级。
NDB Cluster 复制包括对属性提升和降级的支持。后者的实现区分有损和无损类型转换，它们在副本上的使用可以通过设置系统变量的全局值
replica_type_conversions（NDB 8.0.26 及更高版本）或
slave_type_conversions（NDB 8.0.26 之前）来控制.
有关 NDB Cluster 中属性提升和降级的更多信息，请参阅
基于行的复制：属性提升和降级。
NDB, 不像InnoDB
or MyISAM，不会将对虚拟列的更改写入二进制日志；但是，这对 NDB Cluster 复制或NDB与其他存储引擎之间的复制没有不利影响。记录对存储的生成列的更改。
© Mysql 中文网
