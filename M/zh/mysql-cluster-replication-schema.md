# 23.7.4 NDB Cluster 复制模式和表_MySQL 8.0 参考手册

23.7.4 NDB Cluster 复制模式和表_MySQL 8.0 参考手册
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
23.7.4 NDB Cluster 复制模式和表
23.7.4 NDB Cluster 复制模式和表
ndb_apply_status 表ndb_binlog_index 表ndb_replication 表
NDB Cluster 中的复制在每个 MySQL Server 实例上使用数据库中的许多专用表mysql作为正在复制的集群和副本中的 SQL 节点。无论副本是单个服务器还是集群，都是如此。
ndb_binlog_index和
ndb_apply_status表是在
mysql数据库中创建
的。用户不应明确复制它们。通常不需要用户干预来创建或维护这些表中的任何一个，因为它们都由NDB二进制日志 (binlog) 注入器线程维护。这使源
mysqldNDB进程更新为存储引擎执行的更改。二进制日志注入器
线程直接从
存储引擎接收事件。注入器负责捕获集群内的所有数据事件，并确保所有更改、插入或删除数据的事件都记录在
NDB NDBNDBndb_binlog_index桌子。副本 I/O（接收方）线程将事件从源的二进制日志传输到副本的中继日志。
该ndb_replication表必须手动创建。用户可以更新此表以按数据库或表执行过滤。有关详细信息，请参阅
ndb_replication 表。ndb_replication也用于 NDB Replication 冲突检测和解决，用于冲突解决控制；请参阅
冲突解决控制。
尽管ndb_binlog_index和
ndb_apply_status是自动创建和维护的，但建议检查这些表的存在性和完整性，作为准备 NDB Cluster 进行复制的初始步骤。mysql.ndb_binlog_index可以通过直接在源上查询表来查看二进制日志中记录的事件数据
。这也可以使用
SHOW BINLOG EVENTS源 SQL 节点或副本 SQL 节点上的语句来完成。（参见
第 13.7.7.2 节，“SHOW BINLOG EVENTS 语句”。）
您还可以从 的输出中获取有用的信息
SHOW ENGINE NDB
STATUS。
笔记
在
NDB表上执行模式更改时，应用程序应等到ALTER TABLE
语句在发出该语句的 MySQL 客户端连接中返回，然后再尝试使用表的更新定义。
ndb_apply_status 表
ndb_apply_status用于记录已从源复制到副本的操作。如果该ndb_apply_status表在副本上不存在，ndb_restore
会重新创建它。
与 的情况不同ndb_binlog_index，此表中的数据不特定于（副本）集群中的任何一个 SQL 节点，因此ndb_apply_status
可以使用NDBCLUSTER存储引擎，如下所示：
CREATE TABLE `ndb_apply_status` (
`server_id`   INT(10) UNSIGNED NOT NULL,
`epoch`       BIGINT(20) UNSIGNED NOT NULL,
`log_name`    VARCHAR(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
`start_pos`   BIGINT(20) UNSIGNED NOT NULL,
`end_pos`     BIGINT(20) UNSIGNED NOT NULL,
PRIMARY KEY (`server_id`) USING HASH
) ENGINE=NDBCLUSTER   DEFAULT CHARSET=latin1;
该ndb_apply_status表仅在副本上填充，这意味着在源上，该表从不包含任何行；因此，没有必要在那里分配任何
DataMemory东西
ndb_apply_status。
因为这个表是从来自源的数据填充的，所以应该允许复制；任何无意中阻止副本更新
ndb_apply_status或阻止源写入二进制日志的复制过滤或二进制日志过滤规则可能会阻止集群之间的复制正常运行。有关此类过滤规则引起的潜在问题的更多信息，请参阅
复制和二进制日志过滤规则以及 NDB 集群之间的复制。
可以删除此表，但不建议这样做。删除它会将所有 SQL 节点置于只读模式；在 NDB 8.0.24 及更高版本中，NDB检测到该表已被删除，并重新创建它，之后可以再次执行更新。删除并重新创建ndb_apply_status会在二进制日志中创建一个间隙事件；gap 事件导致副本 SQL 节点停止应用来自源的更改，直到复制通道重新启动。在 NDB 8.0.24 之前，在这种情况下有必要重新启动所有 SQL 节点以使它们退出只读模式，然后
ndb_apply_status手动重新创建。
0此表的epoch列中的 表示源自除 之外的存储引擎的事务NDB。
ndb_apply_status用于记录哪些纪元事务已被复制并从上游源应用到副本集群。此信息在在线备份中捕获NDB，但（按设计）它不会由ndb_restore恢复。在某些情况下，恢复此信息以用于新设置可能会有所帮助；从 NDB 8.0.29 开始，您可以通过
使用
选项调用ndb_restore来执行此操作。--with-apply-status有关详细信息，请参阅选项的描述。
ndb_binlog_index 表
NDB Cluster Replication 使用该
ndb_binlog_index表来存储二进制日志的索引数据。由于这张表是每个MySQL服务器本地的，不参与集群，所以使用
InnoDB存储引擎。这意味着它必须在
参与源集群的每个mysqld上单独创建。（二进制日志本身包含来自集群中所有 MySQL 服务器的更新。）该表定义如下：
CREATE TABLE `ndb_binlog_index` (
`Position` BIGINT(20) UNSIGNED NOT NULL,
`File` VARCHAR(255) NOT NULL,
`epoch` BIGINT(20) UNSIGNED NOT NULL,
`inserts` INT(10) UNSIGNED NOT NULL,
`updates` INT(10) UNSIGNED NOT NULL,
`deletes` INT(10) UNSIGNED NOT NULL,
`schemaops` INT(10) UNSIGNED NOT NULL,
`orig_server_id` INT(10) UNSIGNED NOT NULL,
`orig_epoch` BIGINT(20) UNSIGNED NOT NULL,
`gci` INT(10) UNSIGNED NOT NULL,
`next_position` bigint(20) unsigned NOT NULL,
`next_file` varchar(255) NOT NULL,
PRIMARY KEY (`epoch`,`orig_server_id`,`orig_epoch`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
笔记
如果您是从旧版本（NDB 7.5.2 之前）升级，请执行 MySQL 升级过程并确保通过使用该--upgrade=FORCE选项启动 MySQL 服务器来升级系统表。系统表升级导致
ALTER TABLE ...
ENGINE=INNODB对该表执行一条语句。MyISAM为了向后兼容，继续支持使用此表
的存储引擎。
ndb_binlog_index转换为InnoDB. 如果这成为一个问题，您可以通过InnoDB为此表使用一个表空间、将其更改ROW_FORMAT为
COMPRESSED或两者来节省空间。有关更多信息，请参阅第 13.1.21 节，“CREATE TABLESPACE 语句”和
第 13.1.20 节，“CREATE TABLE 语句”，以及
第 15.6.3 节，“表空间”。
表的大小ndb_binlog_index取决于每个二进制日志文件的纪元数和二进制日志文件的数量。每个二进制日志文件的纪元数通常取决于每个纪元生成的二进制日志量和二进制日志文件的大小，较小的纪元会导致每个文件的纪元数较多。您应该知道
ndb_binlog_index，即使
--ndb-log-empty-epochs选项为
OFF，空时期也会对表产生插入，这意味着每个文件的条目数取决于文件使用的时间长度；这种关系可以用此处显示的公式表示：
[number of epochs per file] = [time spent per file] / TimeBetweenEpochs
繁忙的 NDB Cluster 定期写入二进制日志，并且可能比安静的更快地旋转二进制日志文件。这意味着一个“安静”的NDB Cluster
--ndb-log-empty-epochs=ON实际上
ndb_binlog_index每个文件的行数比一个有大量活动的 NDB Cluster 多得多。
当mysqld以
--ndb-log-orig选项启动时，
orig_server_id和
orig_epoch列分别存储事件发起的服务器的 ID 和事件在发起服务器上发生的纪元，这在使用多个源的 NDB Cluster 复制设置中很有用. 该SELECT语句用于在多源设置中找到最接近副本上最高应用纪元的二进制日志位置（请参阅
第 23.7.10 节，“NDB 集群复制：双向和循环复制”) 使用这两列，它们没有索引。这可能会在尝试故障转移时导致性能问题，因为查询必须执行表扫描，尤其是当源已使用
--ndb-log-empty-epochs=ON. 您可以通过向这些列添加索引来缩短多源故障转移时间，如下所示：
ALTER TABLE mysql.ndb_binlog_index
ADD INDEX orig_lookup USING BTREE (orig_server_id, orig_epoch);
当从单个源复制到单个副本时，添加此索引没有任何好处，因为在这种情况下用于获取二进制日志位置的查询不使用
orig_server_idor
orig_epoch。
有关使用和
列
的更多信息，
请参阅第 23.7.8 节，“使用 NDB Cluster 复制实现故障转移” 。next_positionnext_file
下图显示了 NDB Cluster 复制源服务器、其二进制日志注入器线程和mysql.ndb_binlog_index表的关系。
图 23.14 复制源集群
ndb_replication 表
该ndb_replication表用于控制二进制日志记录和冲突解决，并以每个表为基础进行操作。此表中的每一行对应一个正在复制的表，确定如何记录对表的更改，如果指定了冲突解决函数，则确定如何解决该表的冲突。
与表不同ndb_apply_status，
ndb_replication该
ndb_replication表必须手动创建，使用此处显示的 SQL 语句：
CREATE TABLE mysql.ndb_replication  (
db VARBINARY(63),
table_name VARBINARY(63),
server_id INT UNSIGNED,
binlog_type INT UNSIGNED,
conflict_fn VARBINARY(128),
PRIMARY KEY USING HASH (db, table_name, server_id)
)   ENGINE=NDB
PARTITION BY KEY(db,table_name);
此处列出了此表的列，并附有说明：
db柱子
包含要复制的表的数据库的名称。
您可以使用其中一个或两个通配符
作为数据库名称的一部分_。%（请参阅
本节后面的
使用通配符匹配。）
table_name柱子
要复制的表的名称。
_表名可以包含通配符和
中的一个或两个
%。请参阅
本节后面的
使用通配符匹配。
server_id柱子
表所在的 MySQL 实例（SQL 节点）的唯一服务器 ID。
0此列中的 充当通配符，相当于%, 并匹配任何服务器 ID。（请参阅本节后面的
使用通配符匹配。）
binlog_type柱子
要使用的二进制日志记录类型。有关值和说明，请参阅文本。
conflict_fn柱子
要应用的冲突解决函数；NDB$OLD()、
NDB$MAX()、
NDB$MAX_DELETE_WIN()、
NDB$EPOCH()、
NDB$EPOCH_TRANS()、
NDB$EPOCH2()、
NDB$EPOCH2_TRANS (
) 之一；
NULL表示该表不使用冲突解决。NDB 8.0.30 及更高版本支持两个额外的冲突解决函数
NDB$MAX_INS()和
NDB$MAX_DEL_WIN_INS()。
有关这些功能及其在 NDB 复制冲突解决中的用途的更多信息，
请参阅冲突解决功能。
一些冲突解决函数 ( NDB$OLD(),
NDB$EPOCH(),
NDB$EPOCH_TRANS()) 需要使用一个或多个用户创建的异常表。请参阅
冲突解决例外表。
要使用 NDB 复制启用冲突解决，有必要使用有关应解决冲突的一个或多个 SQL 节点的控制信息创建并填充此表。根据要采用的冲突解决类型和方法，这可能是源服务器、副本服务器或两者都是服务器。在一个简单的源副本设置中，数据也可以在副本上本地更改，这通常是副本。在更复杂的复制方案中，例如双向复制，这通常是所有涉及的源。有关更多信息，请参阅
第 23.7.11 节，“NDB Cluster 复制冲突解决”。
该ndb_replication表允许在冲突解决范围之外对二进制日志记录进行表级控制，在这种情况下conflict_fn指定为NULL，而其余列值用于控制与通配符表达式匹配的给定表或一组表的二进制日志记录。通过为该binlog_type列设置适当的值，您可以使给定表或表的日志记录使用所需的二进制日志格式，或者完全禁用二进制日志记录。此列的可能值及其值和说明如下表所示：
表 23.70 binlog_type 值，以及值和描述
价值
描述
0
使用服务器默认值
1个
不要将此表记录到二进制日志中（效果与 相同
sql_log_bin = 0，但仅适用于一个或多个指定的表）
2个
仅记录更新的属性；将这些记录为WRITE_ROW
事件
3个
记录整行，即使没有更新（MySQL 服务器默认行为）
6个
使用更新的属性，即使值未更改
7
记录整行，即使没有更改任何值；将更新记录为
UPDATE_ROW事件
8个
记录更新为UPDATE_ROW；仅记录前映像中的主键列，仅记录后映像中的更新列（效果与 相同
--ndb-log-update-minimal，但仅适用于一个或多个指定表）
9
记录更新为UPDATE_ROW；仅记录前映像中的主键列，以及后映像中除主键列以外的所有列
笔记
binlog_type值 4 和 5 未使用，因此在刚刚显示的表格以及下一个表格中省略了。
几个值等效于mysqld日志记录选项、
和
binlog_type的各种组合，如下表所示：
--ndb-log-updated-only--ndb-log-update-as-write--ndb-log-update-minimal
表 23.71 binlog_type 值与 NDB 日志记录选项的等效组合
价值
--ndb-log-updated-only价值
--ndb-log-update-as-write价值
--ndb-log-update-minimal价值
0
--
--
--
1个
--
--
--
2个
上
上
离开
3个
离开
上
离开
6个
上
离开
离开
7
离开
离开
离开
8个
上
离开
上
9
离开
离开
上
ndb_replication通过使用适当
db的table_name、 和
binlog_type列值
将行插入表中，可以将二进制日志记录设置为不同表的不同格式
。设置二进制日志记录格式时应使用上表中显示的内部整数值。以下两个语句将二进制日志记录设置为记录表的完整行（值 3）test.a，以及仅记录表的更新（值 2）test.b：
# Table test.a: Log full rows
INSERT INTO mysql.ndb_replication VALUES("test", "a", 0, 3, NULL);
# Table test.b: log updates only
INSERT INTO mysql.ndb_replication VALUES("test", "b", 0, 2, NULL);
要禁用一个或多个表的日志记录，请使用 1 binlog_type，如下所示：
# Disable binary logging for table test.t1
INSERT INTO mysql.ndb_replication VALUES("test", "t1", 0, 1, NULL);
# Disable binary logging for any table in 'test' whose name begins with 't'
INSERT INTO mysql.ndb_replication VALUES("test", "t%", 0, 1, NULL);
禁用给定表的日志记录等同于设置
sql_log_bin = 0，只是它单独应用于一个或多个表。如果 SQL 节点未对给定表执行二进制日志记录，则不会向其发送这些表的行更改事件。这意味着它没有接收所有更改并丢弃一些更改，而是没有订阅这些更改。
出于多种原因，禁用日志记录可能很有用，包括此处列出的原因：
不通过网络发送更改通常可以节省带宽、缓冲和 CPU 资源。
不记录对更新非常频繁但值不大的表的更改非常适合临时数据（例如会话数据），这些数据在集群完全失败的情况下可能相对不重要。
使用会话变量（或sql_log_bin）和应用程序代码，还可以记录（或不记录）某些 SQL 语句或 SQL 语句类型；例如，在某些情况下可能不希望在一个或多个表上记录 DDL 语句。
出于性能原因，可以将复制流拆分为两个（或更多）二进制日志，需要将不同的数据库复制到不同的地方，为不同的数据库使用不同的二进制日志记录类型，等等。
与通配符匹配。
为了不需要
ndb_replication在复制设置中为数据库、表和 SQL 节点的每个组合在表中插入一行，NDB支持在此表的db、
table_name和
server_id列上进行通配符匹配。分别使用的数据库和表名，db并且
table_name可以包含以下一个或两个通配符：
_（下划线字符）：匹配零个或多个字符
%（百分号）：匹配单个字符
（这些通配符与 MySQL
LIKE运算符所支持的相同。）
该server_id列支持
0作为等效于
_（匹配任何内容）的通配符。这用于前面显示的示例中。
表中的给定行ndb_replication可以使用通配符来匹配任何数据库名称、表名称和服务器 ID 的任意组合。如果表中有多个潜在匹配，则选择最佳匹配，根据此处显示的表，其中W表示通配符匹配，E表示完全匹配，并且Quality列中的值越大，匹配越好：
表 23.72 mysql.ndb_replication 表中列的通配符和精确匹配的不同组合的权重
db
table_name
server_id
质量
W
W
W
1个
W
W
乙
2个
W
乙
W
3个
W
乙
乙
4个
乙
W
W
5个
乙
W
乙
6个
乙
乙
W
7
乙
乙
乙
8个
因此，数据库名称、表名称和服务器 ID 的完全匹配被认为是最好的（最强的），而最弱的（最差的）匹配是所有三列的通配符匹配。选择要应用的规则时，只考虑比赛的强度；行在表中出现的顺序对该确定没有影响。
记录完整或部分行。
有两种记录行的基本方法，由
mysqld--ndb-log-updated-only的选项设置决定：
记录完整的行（选项设置为ON）
仅记录已更新的列数据，即已设置值的列数据，而不管该值是否实际更改。这是默认行为（选项设置为OFF）。
通常只记录更新的列就足够了——而且效率更高；但是，如果您需要记录完整的行，您可以通过设置
--ndb-log-updated-only为
0或来实现OFF。
将更改的数据记录为更新。
MySQL 服务器
--ndb-log-update-as-write
选项的设置决定了是否使用“之前”图像执行日志记录。
因为更新和删除操作的冲突解决是在 MySQL 服务器的更新处理程序中完成的，所以有必要控制复制源执行的日志记录，以便更新是更新而不是写入；也就是说，更新被视为对现有行的更改而不是写入新行，即使这些更新替换了现有行。
该选项默认开启；换句话说，更新被视为写入。也就是说，更新默认情况下作为
write_row事件写入二进制日志中，而不是作为update_row事件。
要禁用该选项，请
使用
或
启动源mysqld。从 NDB 表复制到使用不同存储引擎的表时，您必须这样做；有关详细信息，请参阅
从 NDB 到其他存储引擎的复制和
从 NDB 到非事务性存储引擎的复制。
--ndb-log-update-as-write=0--ndb-log-update-as-write=OFF
重要的
（NDB 8.0.30 及更高版本：）为了使用NDB$MAX_INS()or
解决插入冲突NDB$MAX_DEL_WIN_INS()，SQL 节点（即mysqld进程）可以将源集群上的行更新记录为WRITE_ROW
事件，并
--ndb-log-update-as-write
启用幂等性和最佳大小选项。这适用于这些算法，因为它们都将
WRITE_ROW事件映射到插入或更新，具体取决于行是否已存在，并且所需的元数据（时间戳列的“后”图像）存在于“ WRITE_ROW ”事件中。
© Mysql 中文网
