# 23.2.4 NDB Cluster 中的新功能_MySQL 8.0 参考手册

23.2.4 NDB Cluster 中的新功能_MySQL 8.0 参考手册
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
23.2.1 NDB Cluster 核心概念1
23.2.2 NDB Cluster 节点、节点组、片段副本和分区1
23.2.3 NDB Cluster 硬件、软件和网络要求1
23.2.4 NDB Cluster 中的新功能1
23.2.5 NDB 8.0 中添加、弃用或删除的选项、变量和参数1
23.2.6 使用 InnoDB 的 MySQL 服务器与 NDB Cluster 比较1
23.2.7 NDB Cluster 的已知限制1
23.3 NDB Cluster 安装
23.4 NDB Cluster的配置
23.5 NDB 集群程序
23.6 NDB Cluster的管理
23.7 NDB 集群复制
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.2 NDB Cluster 概述  /
23.2.4 NDB Cluster 中的新功能
23.2.4 NDB Cluster 中的新功能
与早期版本系列相比，以下部分描述了 MySQL NDB Cluster 8.0 到 8.0.32 中 NDB Cluster 实现的变化。NDB Cluster 8.0 从 NDB 8.0.19 开始作为一般可用性 (GA) 版本提供。NDB Cluster 7.6 和 7.5 是之前的 GA 版本，在生产中仍然受支持；有关 NDB Cluster 7.6 的信息，请参阅 NDB Cluster 7.6
中的新增功能。有关 NDB Cluster 7.5 的类似信息，请参阅
What is New in NDB Cluster 7.5。NDB Cluster 7.4 和 7.3 是以前的 GA 版本，在生产中仍然支持，尽管我们建议新的生产部署使用 NDB Cluster 8.0；参见
MySQL NDB Cluster 7.3 和 NDB Cluster 7.4.
NDB Cluster 8.0 中的新功能
NDB Cluster 8.0 中的主要变化和新特性可能会引起人们的兴趣，如下表所示：
兼容性增强。 NDB与其他 MySQL 存储引擎相比，
以下更改减少了长期存在的非本质行为差异：
与 MySQL 服务器并行开发。
从这个版本开始，MySQL NDB Cluster 正在与标准 MySQL 8.0 服务器并行开发，采用新的统一发布模型，具有以下特性：
NDB 8.0 是在 MySQL 8.0 源代码树中开发、构建和发布的。
NDB Cluster 8.0 版本的编号方案遵循 MySQL 8.0 的方案。
构建带有NDB
支持的源附加到mysql-cluster返回的版本字符串，如下所示：
-V$> mysql -V
mysql  Ver 8.0.32-cluster for Linux on x86_64 (Source distribution)
NDB二进制文件继续显示 MySQL 服务器版本和
NDB引擎版本，如下所示：
$> ndb_mgm -V
MySQL distrib mysql-8.0.32 ndb-8.0.32, for Linux (x86_64)
在 MySQL Cluster NDB 8.0 中，这两个版本号始终相同。
要使用 NDB Cluster 支持构建 MySQL 源，请使用 CMake 选项-DWITH_NDB
（NDB 8.0.31 及更高版本；对于早期版本，请
-DWITH_NDBCLUSTER改用）。
平台支持说明。
NDB 8.0 对平台支持做了如下改动：
NDBCLUSTER不再支持 32 位平台。从 NDB 8.0.21 开始，NDB 构建过程会检查系统架构，如果不是 64 位平台则中止。
现在可以NDB
从源代码构建 64 位ARMCPU。目前，这种支持仅限于源代码，我们不为此平台提供任何预编译的二进制文件。
数据库和表名称。
NDB 8.0 取消了以前对数据库和表的标识符的 63 字节限制。这些标识符现在最多可以使用 64 个字节，就像使用其他 MySQL 存储引擎的此类对象一样。请参阅
第 23.2.7.11 节，“NDB Cluster 8.0 中已解决的先前 NDB Cluster 问题”。
为外键生成的名称。
NDB现在使用模式
命名内部生成的外键。这类似于
.
tbl_name_fk_NInnoDB
模式和元数据分发和同步。
NDB 8.0 利用 MySQL 数据字典将模式信息分发到加入集群的 SQL 节点，并在现有 SQL 节点之间同步新模式更改。以下列表描述了与此集成工作相关的各个增强功能：
架构分布增强。
处理模式操作并跟踪其进度的NDB模式分发协调器已在 NDB 8.0 中得到扩展，以确保模式操作期间使用的资源在其结束时被释放。以前，其中一些工作是由模式分发客户端完成的；由于客户端并不总是拥有所有需要的状态信息，这已被更改，当客户端决定在完成之前放弃模式操作并且没有通知协调器时，这可能导致资源泄漏。
为帮助解决此问题，架构操作超时检测已从架构分发客户端移至协调器，从而为协调器提供了清理架构操作期间使用的任何资源的机会。协调器现在定期检查正在进行的模式操作是否超时，并在检测到超时时将尚未完成给定模式操作的参与者标记为失败。每当发生模式操作超时时，它还会提供适当的警告。（应该注意的是，在检测到这样的超时后，模式操作本身会继续。
作为这项工作的附加部分，一个新的
mysqld选项
--ndb-schema-dist-timeout
可以设置等待模式操作被标记为超时的时间长度。
磁盘数据文件分布。
NDB Cluster 8.0.14，使用 MySQL 数据字典来确保磁盘数据文件和相关结构（如表空间和日志文件组）在所有连接的 SQL 节点之间正确分布。
表空间对象的模式同步。
当 MySQL 服务器作为 SQL 节点连接到 NDB 集群时，它会根据字典中找到的信息检查其数据NDB
字典。
以前，NDB连接新 SQL 节点时唯一同步的对象是数据库和表；MySQL NDB Cluster 8.0 还实现了磁盘数据对象的模式同步，包括表空间和日志文件组。除其他好处外，这消除了 MySQL 数据字典与本机备份和还原后的字典不匹配的可能性，在本
NDB机备份和还原中，表空间和日志文件组被还原到NDB
字典，而不是 MySQL 服务器的数据字典。
也不再可能发出
CREATE TABLE引用不存在的表空间的语句。这样的声明现在失败并出现错误。
数据库 DDL 同步增强。 为 NDB 8.0 所做的工作确保新加入（或重新加入）的 SQL 节点与现有 SQL 节点上的数据库的同步现在可以正确使用数据字典，以便可能错过
的任何数据库级操作（CREATE DATABASE、
ALTER DATABASE或
）DROP DATABASE当它连接（或重新连接）到集群时，这个 SQL 节点现在正确地复制了它。
作为启动时执行的模式同步过程的一部分，SQL 节点现在将集群数据节点上的所有数据库与其自己的数据字典中的数据库进行比较，如果发现 SQL 节点的数据字典中缺少其中任何一个，则 SQL Node 通过执行
CREATE DATABASE语句在本地安装它。这样创建的数据库使用默认的 MySQL 服务器数据库属性（例如由
character_set_database
和确定的属性collation_database），这些属性在执行语句时在此 SQL 节点上有效。
NDB 元数据更改检测和同步。
NDB 8.0 使用 MySQL 数据字典实现了一种新机制，用于检测数据对象（例如表、表空间和日志文件组）的元数据更新。这是使用线程完成的，
NDB元数据更改监视器线程在后台运行，并定期检查NDB
字典和 MySQL 数据字典之间的不一致。
默认情况下，监视器每 60 秒执行一次元数据检查。可以通过设置
ndb_metadata_check_interval
系统变量的值来调整轮询间隔；ndb_metadata_check可以通过将系统变量设置为 来完全禁用轮询
OFF。状态变量
Ndb_metadata_detected_count
显示自上次启动mysqld
以来检测到不一致的次数。
NDB确保NDB
元数据更改监控线程在启动后的操作期间提交的数据库、表、日志文件组和表空间对象被自动检查不匹配并由NDB
binlog 线程同步。
NDB 8.0 增加了两个与自动同步相关的状态变量：
Ndb_metadata_synced_count
显示自动同步的对象数量；
Ndb_metadata_excluded_count
指示同步失败的对象数（在 NDB 8.0.22 之前，此变量名为
Ndb_metadata_blacklist_size）。此外，您可以通过检查集群日志来了解哪些对象已被同步。
将
ndb_metadata_sync系统变量设置为覆盖为
和true所做的任何设置
，导致更改监视器线程开始连续的元数据更改检测。
ndb_metadata_check_intervalndb_metadata_check
在 NDB 8.0.22 及更高版本中，设置
ndb_metadata_sync为
true清除之前同步失败的对象列表，这意味着不再需要发现单个表或通过将 SQL 节点重新连接到集群来重新触发同步。此外，将此变量设置为
false清除等待重试的对象列表。
从 NDB 8.0.21 开始，添加到 MySQL Performance Schema 的两个新表提供了比从日志消息或状态变量中获得的有关自动同步当前状态的更多详细信息。这些表列在这里：
ndb_sync_pending_objects：包含有关在
NDB字典和 MySQL 数据字典之间检测到不匹配（并且尚未从自动同步中排除）的数据库对象的信息。
ndb_sync_excluded_objects: 包含因字典与MySQL数据字典
NDB
无法同步而被排除的数据库对象
信息，需要人工干预。NDB
其中一个表中的一行提供了数据库对象的父模式、名称和类型。对象类型包括模式、表空间、日志文件组和表。（如果对象是日志文件组或表空间，则父模式为NULL。）此外，该
ndb_sync_excluded_objects
表还显示了排除对象的原因。
这些表仅在
NDBCLUSTER启用存储引擎支持时存在。有关这些表的更多信息，请参阅
第 27.12.12 节，“Performance Schema NDB Cluster Tables”。
NDB 表额外元数据的更改。
表的额外元数据属性NDB
用于存储来自 MySQL 数据字典的序列化元数据，而不是像以前版本那样存储表的二进制表示。（这是一个.frm文件，不再被 MySQL 服务器使用——请参阅
第 14 章，MySQL 数据字典。）作为支持此更改的工作的一部分，表的额外元数据的可用大小已增加。这意味着NDB在 NDB Cluster 8.0 中创建的表与以前的 NDB Cluster 版本不兼容。之前版本中创建的表可以与 NDB 8.0 一起使用，但之后无法通过早期版本打开。
可以使用 NDB API 方法
getExtraMetadata()
和
setExtraMetadata().
有关更多信息，请参阅
第 23.3.7 节，“升级和降级 NDB Cluster”。
使用 .frm 文件即时升级表。
在 NDB 7.6 及更早版本中创建的表包含压缩.frm
文件形式的元数据，MySQL 8.0 不再支持该格式。为了方便在线升级到 NDB 8.0，
NDB执行此元数据的即时转换并将其写入 MySQL 服务器的数据字典，这使得 NDB Cluster 8.0 中的
mysqld可以使用该表，而不会阻止后续使用该表以前版本的
NDB软件。
重要的
一旦在 NDB 8.0 中修改了表的结构，其元数据将使用数据字典存储，NDB 7.6 及更早版本将无法再访问它。
此增强功能还可以将
NDB使用早期版本制作的备份还原到运行 NDB 8.0（或更高版本）的集群。
元数据一致性检查错误记录。
作为之前在 NDB 8.0 中完成的工作的一部分，元数据检查作为NDBNDB 字典中表的表示与其在 MySQL 数据字典中对应表之间自动同步的一部分执行，包括表的名称、存储引擎和内部 ID。从 NDB 8.0.23 开始，检查的属性范围扩大到包括以下数据对象的属性：
列
索引
外键
此外，元数据属性中任何不匹配的详细信息现在都会写入 MySQL 服务器错误日志。根据差异是在表级别还是在列、索引或外键级别发现，用于错误日志消息的格式略有不同。表级属性不匹配导致的日志错误的格式如下所示，其中
property是属性名称，
ndb_value是存储在 NDB 字典中的属性值，
mysqld_value是存储在 MySQL 数据字典中的属性值：
Diff in 'property' detected, 'ndb_value' != 'mysqld_value'
对于列、索引、外键的属性不匹配，格式如下，其中
obj_type是
、 或
之一，
column是对象的名称：
indexforeign keyobj_nameDiff in obj_type 'obj_name.property' detected, 'ndb_value' != 'mysqld_value'NDB当表安装在
充当 NDB Cluster 中的 SQL 节点的任何mysqld的数据字典中时，将在表
的自动同步期间执行元数据检查。如果mysqld是调试编译的，则无论何时
CREATE TABLE执行语句，以及何时NDB打开表，都会进行检查。
用户权限与 NDB_STORED_USER 同步。
NDB 8.0 中提供了一种在 SQL 节点之间共享和同步用户、角色和权限的新机制，使用NDB_STORED_USER
权限。不再支持
在 NDB 7.6 及更早版本中实现的分布式权限（请参阅
使用共享授权表的分布式权限）。
一旦在 SQL 节点上创建了用户帐户，用户及其权限就可以存储在NDB集群中的所有 SQL 节点中，并通过发出
GRANT如下语句在集群中的所有 SQL 节点之间共享：
GRANT NDB_STORED_USER ON *.* TO 'jon'@'localhost';
NDB_STORED_USER始终具有全局范围，必须使用ON *.*. 诸如
mysql.session@localhost或
之类的系统保留帐户mysql.infoschema@localhost不能被分配此权限。
角色也可以通过发出适当的GRANT NDB_STORED_USER
语句在 SQL 节点之间共享。将这样的角色分配给用户不会导致用户被共享；该NDB_STORED_USER
特权必须明确授予每个用户。
NDB_STORED_USER一旦所有 SQL 节点加入给定的 NDB Cluster，具有 及其特权
的用户或角色就会与所有 SQL 节点共享。可以从任何连接的 SQL 节点进行此类更改，但推荐的做法是仅从指定的 SQL 节点进行更改，因为影响不同 SQL 节点权限的语句的执行顺序不能保证在所有 SQL 上都相同节点。
在 NDB 8.0.27 之前，对用户或角色权限的更改会立即与所有连接的 SQL 节点同步。从MySQL 8.0.27开始，一个SQL节点在更新权限时会带一个全局读锁，这样可以避免多个SQL节点并发修改造成死锁。
对升级的影响。
由于 MySQL 服务器权限系统的更改（请参阅第 6.2.3 节，“授予表”），使用NDB存储引擎的权限表在 NDB 8.0 中无法正常运行。保留在 NDB 7.6 或更早版本中创建的此类权限表是安全的，但没有必要，但它们不再用于访问控制。在 NDB 8.0 中，
充当 SQL 节点并检测此类表的mysqldNDB向 MySQL 服务器日志写入警告，并创建
InnoDB自身本地的影子表；这样的影子表是在连接到集群的每个 MySQL 服务器上创建的。从 NDB 7.6 或更早版本执行升级时，
一旦升级了所有充当 SQL 节点的 MySQL 服务器，
NDB就可以使用
ndb_drop_table安全地删除使用的特权表（请参阅第 23.3.7 节，“升级和降级 NDB Cluster”）。
ndb_restore实用程序的
--restore-privilege-tables
选项已弃用，但在 NDB 8.0 中继续得到尊重，并且仍可用于将从以前版本的 NDB Cluster 获取的备份中存在的分布式特权表还原到运行 NDB 8.0 的集群。这些表的处理方式如前一段所述。
共享用户和授权存储在
ndb_sql_metadata表中，
ndb_restore默认情况下不会在 NDB 8.0 中恢复；您可以指定
--include-stored-grants
使它这样做的选项。
有关更多信息，请参阅第 23.6.13 节，“权限同步和 NDB_STORED_USER”。
INFORMATION_SCHEMA 更改。
表中有关磁盘数据文件的信息显示进行了以下更改
INFORMATION_SCHEMA.FILES：
表空间和日志文件组不再显示在FILES表中。（这些构造实际上不是文件。）
每个数据文件现在由表中的一行表示
FILES。每个撤消日志文件现在在该表中也仅由一行表示。（以前，每个数据节点上的每个文件的每个副本都显示一行。）
此外，INFORMATION_SCHEMA表现在填充了 MySQL 集群表的表空间统计信息。（漏洞#27167728）
ndb_perror 的错误信息。 perror
的弃用--ndb选项
已被删除。相反，使用
ndb_perror从错误代码中获取错误消息信息。（错误#81704、错误#81705、错误#23523926、错误#23523957）
NDB条件下推增强功能。
以前，条件下推仅限于引用条件被推送到的同一表中的列值的谓词项。在 NDB 8.0 中，删除了此限制，以便查询计划中较早的表中的列值也可以从推送条件中引用。NDB 8.0 支持连接比较列表达式，以及同一表中列之间的比较。要比较的列和列表达式必须是完全相同的类型；这意味着只要应用这些属性，它们也必须具有相同的符号、长度、字符集、精度和比例。在 NDB 8.0.27 之前，被推送的条件不能成为推送连接的一部分，
下推条件的较大部分允许数据节点过滤掉更多行，从而减少mysqld在连接处理期间必须处理的行数。这些增强的另一个好处是过滤可以在 LDM 线程中并行执行，而不是在 SQL 节点上的单个 mysqld 进程中；这有可能显着提高查询性能。
正在比较的列值之间的类型兼容性的现有规则继续适用（请参阅
第 8.2.1.5 节，“引擎条件下推优化”）。
外连接和半连接的下推。
NDB 8.0.20 中完成的工作允许将许多外连接和半连接，而不仅仅是那些使用主键或唯一键查找的外连接和半连接，向下推送到数据节点（请参阅
第 8.2.1.5 节，“引擎条件下推优化”）。
使用现在可以推送的扫描的外部连接包括满足以下条件的那些：
没有未提出的条件
在同一个连接嵌套或它所依赖的上层连接嵌套中的其他表上没有未推送的条件
同一个连接嵌套中的所有其他表，或者它所依赖的上层连接嵌套中的所有其他表，也被推送
现在可以推送使用索引扫描的半连接，如果它满足刚刚针对推送的外部连接指出的条件，并且它使用该firstMatch策略（请参阅
第 8.2.2.1 节，“使用半连接转换优化 IN 和 EXISTS 子查询谓词”）。
NDB 8.0.21 中进行了这些额外的改进：
MySQL 优化器通过转换NOT EXISTS和
NOT IN查询生成的反连接（请参阅
第 8.2.2.1 节，“使用半连接转换优化 IN 和 EXISTS 子查询谓词”）可以通过 向下推送到数据节点NDB。
这可以在表上没有未推送的条件时完成，并且查询满足要向下推送外部连接所必须满足的任何其他条件。
NDB在尝试从它所附加的表中检索任何行之前，尝试识别和评估非依赖标量子查询。当它可以这样做时，获得的值将用作推送条件的一部分，而不是使用提供该值的子查询。
从 NDB 8.0.27 开始，作为推送查询的一部分推送的条件现在可以引用同一推送查询中祖先表中的列，但须满足以下条件：
推送的
条件
可能包括
任何比较运算符
、、、、、
<和
。
<=>>==<>
比较的值必须属于同一类型，包括长度、精度和小数位数。
NULL处理是根据 ISO SQL 标准规定的比较语义进行的；NULL
与returns的任何比较NULL。
考虑使用此处显示的语句创建的表：
CREATE TABLE t (
x INT PRIMARY KEY,
y INT
) ENGINE=NDB;
现在可以使用引擎条件下推优化的查询SELECT
* FROM t AS m JOIN t AS n ON m.x >= n.y来下推条件列y。
当无法推送连接时，
EXPLAIN应提供原因或原因。
有关详细信息，请参阅第 8.2.1.5 节“引擎条件下推优化”。
作为这项工作的一部分， NDB API 方法
branch_col_eq_param()、
branch_col_ne_param()、
branch_col_lt_param()、
branch_col_le_param()、
branch_col_gt_param()和
branch_col_ge_param()
被添加到 NDB 8.0.27 中。这些
NdbInterpretedCode可用于将列值与参数值进行比较。
此外，
NdbScanFilter::cmp_param()也在 NDB 8.0.27 中添加，使得定义列值和参数值之间的比较以用于执行扫描成为可能。
增加最大行大小。
NDB 8.0 将表中可存储的最大字节数NDBCLUSTER从 14000 字节增加到 30000 字节。
ABLOB或
TEXT列继续使用此总数的 264 个字节，和以前一样。
表的固定宽度列的最大偏移量为
NDB8188 字节；这也与以前的版本没有变化。
有关更多信息，请参阅
第 23.2.7.5 节，“与 NDB Cluster 中的数据库对象相关的限制”。
ndb_mgm SHOW 命令和单用户模式。
在 NDB 8.0 中，当集群处于单用户模式时，管理客户端
SHOW命令的输出指示在该模式生效时哪个 API 或 SQL 节点具有独占访问权限。
在线列重命名。 NDB现在可以在线重命名表
的列，使用ALGORITHM=INPLACE. 有关更多信息，请参阅
第 23.6.12 节，“在 NDB Cluster 中使用 ALTER TABLE 进行在线操作”。
改进了 ndb_mgmd 启动时间。
NDB 8.0 中管理节点守护进程的启动时间已通过以下方式显着改进：
由于用
ndb_mgmd哈希表替换了以前用于处理来自配置数据的节点属性的列表数据结构，管理服务器的整体启动时间减少了 6 倍或更多。
此外，在
hosts集群配置文件中使用管理服务器文件中不存在的数据和 SQL 节点主机名的情况下，ndb_mgmd启动时间最多可比以前缩短 20 倍。
NDB API 增强功能。
NdbScanFilter::cmp()和几种比较方法
NdbInterpretedCode现在可用于比较表列值。受影响的NdbInterpretedCode方法在此处列出：
branch_col_eq()
branch_col_ge()
branch_col_gt()
branch_col_le()
branch_col_lt()
branch_col_ne()
对于刚刚列出的所有方法，要比较的表列值大多是完全匹配的类型，包括长度、精度、符号、比例、字符集和排序规则（如适用）。
有关详细信息，请参阅各个 API 方法的说明。
离线多线程索引构建。
现在可以指定一组核心用于 I/O 线程执行离线多线程构建有序索引，而不是正常的 I/O 任务，如文件 I/O、压缩或解压缩。
“离线”在此上下文中是指在未写入父表时执行的有序索引的构建；这种构建发生在
NDB集群执行节点或系统重启时，或者作为使用
ndb_restore
--rebuild-indexes从备份恢复集群的一部分。
此外，离线索引构建工作的默认行为被修改为使用
ndbmtd可用的所有内核，而不是将其自身限制为为 I/O 线程保留的内核。这样做可以改善重启和恢复时间以及性能、可用​​性和用户体验。
此增强功能的实现方式如下：
默认值
BuildIndexThreads
从 0 更改为 128。这意味着离线有序索引构建现在默认是多线程的。
的默认值
TwoPassInitialNodeRestartCopy
从更改false为
true。这意味着初始节点重启首先将所有数据从“活”
节点复制到正在启动的节点——不创建任何索引——离线构建有序索引，然后再次将其数据与活节点同步，即同步两次和在两次同步之间离线构建索引。这会导致初始节点重启的行为更像节点的正常重启，并减少构建索引所需的时间。
idxbld为配置参数定义了
一个新的线程类型 ( ) ThreadConfig
，以允许将离线索引构建线程锁定到特定的 CPU。
此外，现在通过这两个标准
NDB区分可访问的线程类型
：ThreadConfig
该线程是否为执行线程。main, ldm,
recv, rep,
tc, 和类型send的线程是执行线程；线程类型io、
watchdog和idxbld
不是。
给定任务的线程分配是永久的还是临时的。idxbld目前，除永久性之外的
所有线程类型
。
有关其他信息，请参阅手册中指示参数的说明。（错误#25835748，错误#26928111）
logbuffers表备份进程信息。
在执行 NDB 备份时，该
表现在ndbinfo.logbuffers显示有关每个数据节点上备份进程的缓冲区使用情况的信息。这被实现为反映除了
REDO和之外的两种新日志类型的行DD-UNDO。其中一行的日志类型为
BACKUP-DATA，它显示备份期间用于将片段复制到备份文件的数据缓冲区量。另一行的日志类型为
BACKUP-LOG，它显示备份期间用于记录备份开始后所做更改的日志缓冲区的数量。这些
log_type行中的每一行都显示在
logbuffers集群中每个数据节点的表。具有这两种日志类型的行仅在当前正在进行 NDB 备份时才会出现在表中。（缺陷号 25822988）
Windows 上的 ndbinfo.processes 表。 RESTART在 Windows 平台上用于生成和重新启动mysqld
的监视进程的进程 ID现在在
processes表中显示为
angel_pid.
字符串哈希改进。
在 NDB 8.0 之前，所有字符串散列都是基于首先将字符串转换为规范化形式，然后对生成的二进制图像进行 MD5 散列。这可能会导致一些性能问题，原因如下：
规范化的字符串总是用空格填充到它的全长。对于 a VARCHAR，这通常涉及添加比原始字符串中的字符更多的空格。
字符串库未针对此空格填充进行优化，这在某些用例中增加了相当大的开销。
字符集之间的填充语义各不相同，其中一些字符集没有填充到它们的全长。
即使没有空格填充，转换后的字符串也会变得非常大；一些 Unicode 9.0 归类可以将单个代码点转换为 100 个字节或更多的字符数据。
随后的 MD5 散列主要由空格填充组成，效率不是特别高，可能会因刷新 L1 缓存的重要部分而导致额外的性能损失。
排序规则提供自己的哈希函数，它直接对字符串进行哈希处理，而无需先创建规范化字符串。此外，对于 Unicode 9.0 排序规则，计算哈希时没有填充。NDB现在，每当对标识为使用 Unicode 9.0 排序规则的字符串进行哈希处理时，都会利用此内置函数。
由于对于其他排序规则，存在在转换后的字符串上进行散列分区的现有数据库，因此
NDB继续采用以前的方法对使用这些的字符串进行散列，以保持兼容性。（错误#89590、错误#89604、错误#89609、错误#27515000、错误#27523758、错误#27522732）
重置主更改。
因为 MySQL 服务器现在
RESET MASTER使用全局读锁执行，所以与 NDB Cluster 一起使用时此语句的行为在以下两个方面发生了变化：
不再保证是同步的；也就是说，现在有可能
RESET MASTER在二进制日志轮转之后才记录紧接在发出之前的读取。
它现在以完全相同的方式运行，无论语句是在写入二进制日志的同一个 SQL 节点上发出的，还是在同一集群中的不同 SQL 节点上发出的。
笔记
SHOW BINLOG EVENTS、
和大多数数据定义语句继续以同步方式运行
FLUSH LOGS，就像它们在以前的
版本中所做的那样。NDB
ndb_restore 选项用法。 调用ndb_restore时
现在都需要
--nodeid和
选项。
--backupidndb_log_bin 默认值。
NDB 8.0 将
ndb_log_bin系统变量的默认值从更改TRUE为FALSE。
动态事务资源分配。
事务协调器中的资源分配现在使用动态内存池执行。这意味着资源分配由数据节点配置参数（例如
MaxDMLOperationsPerTransaction,
MaxNoOfConcurrentIndexOperations,
MaxNoOfConcurrentOperations,
MaxNoOfConcurrentScans,
MaxNoOfConcurrentTransactions,
MaxNoOfFiredTriggers,
MaxNoOfLocalScans, 和
TransactionBufferMemory
）确定可以限制这些资源的数量，以免超过可用资源总量。
作为这项工作的一部分，
DBTC已添加了几个控制交易资源的新数据节点参数，在此处列出：
ReservedConcurrentIndexOperations
ReservedConcurrentOperations
ReservedConcurrentScans
ReservedConcurrentTransactions
ReservedFiredTriggers
ReservedLocalScans
ReservedTransactionBufferMemory.
有关详细信息，请参阅刚刚列出的参数的说明。
每个数据节点使用多个 LDM 进行备份。
NDB现在可以使用多个本地数据管理器 (LDM) 在单个数据节点上以并行方式执行备份。（以前，备份是跨数据节点并行完成的，但在数据节点进程中始终是串行的。） ndb_mgmSTART BACKUP客户端中的命令不需要特殊语法
来启用此功能，但所有数据节点必须使用多个 LDM。这意味着数据节点必须运行
ndbmtd ( ndbd是单线程的，因此总是只有一个 LDM）并且在进行备份之前必须将它们配置为使用多个 LDM；MaxNoOfExecutionThreads
您可以通过为多线程数据节点配置参数之一或选择适当的设置来完成此操作
ThreadConfig。
使用多个 LDM 的备份会在目录下创建子目录，每个 LDM 一个
。ndb_restore现在自动检测这些子目录，如果它们存在，则尝试并行恢复备份；有关详细信息，请参阅
第 23.5.23.3 节，“从并行备份中恢复”。（单线程备份像以前版本的一样恢复。）也可以
通过修改通常的恢复过程，使用以前版本的 NDB Cluster 中
的ndb_restore二进制文件恢复并行备份；第 23.5.23.3.2 节，“串行恢复并行备份”BACKUP/BACKUP-backup_id/NDB, 提供有关如何执行此操作的信息。
您可以通过将集群全局配置文件 ( )
部分中EnableMultithreadedBackup
所有数据节点
的数据节点参数设置为 0 来强制创建单线程备份
。[ndbd default]config.ini二进制配置文件增强功能。
NDB 8.0 为管理服务器的二进制配置文件使用了一种新格式。以前，集群配置文件中最多可以出现 16381 个部分；现在最大段数是4G。这旨在支持集群中比此更改之前可能的节点数量更多的节点。
升级到新格式是相对无缝的，应该很少需要手动干预，因为管理服务器继续能够毫无问题地读取旧格式。从 NDB 8.0 降级到旧版本的 NDB Cluster 软件需要手动删除任何二进制配置文件，或者，使用该
--initial选项启动旧的管理服务器二进制文件。
有关更多信息，请参阅
第 23.3.7 节，“升级和降级 NDB Cluster”。
增加数据节点的数量。
NDB 8.0 将每个集群支持的最大数据节点数增加到 144 个（以前是 48 个）。数据节点现在可以使用 1 到 144（含）范围内的节点 ID。
以前，管理节点的推荐节点 ID 为 49 和 50。这些仍然支持管理节点，但这样使用它们会将数据节点的最大数量限制为 142；因此，现在建议将节点 ID 145 和 146 用于管理节点。
作为这项工作的一部分，用于数据节点的格式
sysfile已更新到版本 2。该文件记录了每个节点的最后一个全局检查点索引、重启状态和节点组成员身份等信息（请参阅
NDB Cluster 数据节点文件系统目录）。
RedoCommitOverCommitCounter 和 RedoOverCommitLimit 更改。 RedoOverCommitCounter
由于将它们设置为 0 的语义不明确，每个数据节点配置参数的
最小值
RedoOverCommitLimit
已增加到 1。
ndb_autoincrement_prefetch_sz 更改。
服务器系统变量的默认值
ndb_autoincrement_prefetch_sz
增加到 512。
参数最大值和默认值的变化。
NDB 8.0 对配置参数最大值和默认值进行了以下更改：
的最大值
DataMemory增加到 16 TB。
的最大值
DiskPageBufferMemory
也增加到 16 TB。
的默认值
StringMemory增加到 25%。
默认值
LcpScanProgressTimeout
增加到 180 秒。
磁盘数据检查点改进。
NDB Cluster 8.0 提供了许多新的增强功能，有助于在使用固态驱动器等非易失性存储设备和此类设备的 NVMe 规范时减少磁盘数据表和表空间检查点的延迟。这些改进包括以下列表中的改进：
避免突发检查点磁盘写入
当重做日志或撤消日志变满时，加速磁盘数据表空间的检查点
必要时平衡磁盘检查点和内存检查点
保护磁盘设备免于过载以帮助确保高负载下的低延迟
作为这项工作的一部分，添加了两个数据节点配置参数。
MaxDiskDataLatency
对磁盘访问允许的延迟程度设置上限，并导致事务中止花费的时间超过此时间长度。
DiskDataUsingSameDisk
通过提高可以执行此类表空间的检查点的速率，可以利用在单独磁盘上容纳磁盘数据表空间的优势。
此外，
ndbinfo数据库中的三个新表提供了有关磁盘数据性能的信息：
该diskstat表报告了过去一秒内对磁盘数据表空间的写入情况
该diskstats_1sec表报告了过去 20 秒中每一秒对磁盘数据表空间的写入情况
该
pgman_time_track_stats
表报告了与磁盘数据表空间相关的磁盘操作延迟
内存分配和TransactionMemory。 TransactionMemory
作为合并事务和本地数据管理器 (LDM) 内存工作的一部分，
新
参数简化了事务的数据节点内存分配。此参数旨在替换几个已弃用的旧事务内存参数。
现在可以通过此处列出的三种方式中的任何一种来设置事务内存：
几个配置参数与
TransactionMemory. 如果设置了其中任何一个，
TransactionMemory则无法设置（请参阅
与 TransactionMemory 不兼容的参数），并且数据节点的事务内存被确定为 NDB 8.0 之前的版本。
笔记
尝试TransactionMemory
同时在文件中设置这些参数中的任何一个都会
config.ini阻止管理服务器启动。
如果TransactionMemory已设置，则此值用于确定事务内存。
TransactionMemory如果还设置了上一项中提到的任何不兼容参数，则无法设置。
如果不兼容的参数均未设置且
TransactionMemory也未设置，则事务内存由 设置NDB。
有关详细信息，请参阅 的说明
TransactionMemory以及
第 23.4.3.13 节，“数据节点内存管理”。
支持额外的片段副本。
NDB 8.0 将生产中支持的最大片段副本数从两个增加到四个。（之前可以设置
NoOfReplicas为 3 或 4，但官方不支持，也未在测试中验证。）
分片还原。
从 NDB 8.0.20 开始，可以将备份分成大致相等的部分（切片）并使用为
ndb_restore实现的两个新选项并行恢复这些切片：
--num-slices
确定应将备份划分为的片数。
--slice-id提供要由ndb_restore的当前实例恢复的切片的 ID 。
这使得使用
ndb_restore的多个实例并行恢复备份的子集成为可能，从而可能减少执行恢复操作所需的时间。
有关详细信息，请参阅
ndb_restore
--num-slices选项的说明。
从启用的任何片段副本中读取。 NDB默认情况下，所有表
都启用从任何​​片段副本读取
。这意味着
ndb_read_backup系统变量的默认值现在是 ON，并且
在创建新
表时NDB_TABLE注释选项
的值为 1。启用从任何​​片段副本读取可显着提高从表读取的性能，同时对写入的影响最小。
READ_BACKUPNDBNDB
有关详细信息，请参阅
ndb_read_backup系统变量的说明和
第 13.1.20.12 节，“设置 NDB 注释选项”。
ndb_blob_tool 增强功能。
从 NDB 8.0.20 开始，
ndb_blob_tool实用程序可以检测存在内联部分的缺失 blob 部分，并将其替换为长度正确的占位符 blob 部分（由空格字符组成）。要检查是否缺少 blob 部分，请使用
--check-missing此程序的选项。要用占位符替换任何缺失的 blob 部分，请使用该
--add-missing选项。
有关更多信息，请参阅
第 23.5.6 节，“ndb_blob_tool - 检查和修复导航台集群表的 BLOB 和 TEXT 列”。
ndbinfo 版本控制。
NDB8.0.20 及更高版本支持ndbinfo表的版本控制，并在内部维护其表的当前定义。启动时，NDB将其支持
ndbinfo的版本与存储在数据字典中的版本进行比较。如果版本不同，则
NDB删除所有旧
ndbinfo表并使用当前定义重新创建它们。
支持 Fedora Linux。
从 NDB 8.0.20 开始，Fedora Linux 是 NDB Cluster Community 版本的受支持平台，可以使用 Oracle 为此目的提供的 RPM 进行安装。这些可以从
NDB Cluster 下载页面获得。
NDB 程序 - NDBT 依赖项删除。 NDB许多实用程序对库
的依赖性NDBT已被删除。该库内部用于开发，正常使用不需要；它包含在这些程序中可能会在测试时导致不必要的问题。
此处列出了受影响的程序，以及
NDB删除了依赖项的版本：
ndb_restore
ndb_delete_all
ndb_show_tables (NDB 8.0.20)
ndb_waiter (NDB 8.0.20)
此更改对用户的主要影响是这些程序在运行完成后不再打印。依赖于此类行为的应用程序应更新以反映升级到指定版本时的更改。
NDBT_ProgramExit -
status外键和字母大小写。
NDB使用定义它们的大小写存储外键的名称。以前，当系统变量的值
设置为 0 时，它会对使用的外键名称和其他 SQL 语句与存储的名称lower_case_table_names
进行区分大小写的比较
。SELECT从 NDB 8.0.20 开始，这种比较现在始终以不区分大小写的方式执行，而不管
lower_case_table_names.
多个转运体。
NDB 8.0.20 引入了对多个传输器的支持，以处理数据节点对之间的节点到节点通信。这有助于提高集群中每个节点组的更新操作率，并有助于避免系统施加的约束或其他对使用单个套接字的节点间通信的限制。
默认情况下，NDB现在使用基于本地数据管理 (LDM) 线程数或事务协调器 (TC) 线程数的传输器数，以较大者为准。默认情况下，传输器的数量等于该数量的一半。虽然默认值对于大多数工作负载都应该表现良好，但可以通过设置
NodeGroupTransporters
数据节点配置参数（也在 NDB 8.0.20 中引入）来调整每个节点组使用的传输器数量，最大数量LDM 线程数或 TC 线程数。将其设置为 0 会导致传输器的数量与 LDM 线程的数量相同。
ndb_restore：主键架构更改。
NDB 8.0.21（及更高版本）
在使用选项运行时
使用ndb_restoreNDB还原本机备份
时支持源表和目标表的不同主键定义
。支持增加和减少构成原始主键的列数。
--allow-pk-changes
当使用一个或多个附加列扩展主键时，添加的任何列都必须定义为NOT
NULL，并且在进行备份期间不得更改任何此类列中的值。因为一些应用程序在更新它时将所有列值设置在一行中，无论所有值是否实际更改，这都可能导致恢复操作失败，即使要添加到主键的列中的值没有更改。--ignore-extended-pk-updates
您可以使用也在 NDB 8.0.21 中添加的选项覆盖此行为
；在这种情况下，您必须确保没有更改此类值。
可以从表的主键中删除一列，无论该列是否仍然是表的一部分。
有关详细信息，请参阅
ndb_restore--allow-pk-changes选项的描述。
使用 ndb_restore 合并备份。
在某些情况下，可能需要将最初存储在 NDB Cluster 的不同实例中的数据（全部使用相同的模式）合并到单个目标 NDB Cluster 中。现在支持使用在
ndb_mgm客户端中创建的备份（请参阅
第 23.6.8.2 节，“使用 NDB Cluster Management Client 创建备份”）并使用NDB_restore恢复它们，使用--remap-column
NDB 8.0.21 中添加的选项以及
--restore-data（以及可能根据需要或期望的其他兼容选项）。--remap-column可用于处理主键值和唯一键值在源集群之间重叠的情况，并且它们在目标集群中不重叠是必要的，以及保留表之间的其他关系，例如外键。
--remap-column将具有格式 的字符串作为其参数
，其中、
和
分别是数据库、表和列
的名称，是重映射函数的名称，并且
是 的一个或多个参数
。没有默认值。仅
支持作为函数名称，作为将列值从备份插入目标表时应用于列值的整数偏移量。此列必须是以下之一
或
db.tbl.col:fn:argsdbtblcolfnargsfnoffsetargsINTBIGINT; 偏移值的允许范围与该类型的有符号版本相同（如果需要，这允许偏移为负）。
新选项可以在ndb_restore的同一次调用中多次使用，这样您就可以将同一个表、不同表或两者的多个列重新映射到新值。选项的所有实例的偏移值不必相同。
此外
，还从 NDB 8.0.21 开始
为ndb_desc提供了两个新选项：
--auto-inc（缩写形式
-a）：如果表有
AUTO_INCREMENT列，则在输出中包含下一个自动增量值。
--context（缩写形式
-x）：提供有关表的额外信息，包括架构、数据库名称、表名称和内部 ID。
有关更多信息和示例，请参阅
--remap-column选项的说明。
发送线程改进。
从 NDB 8.0.20 开始，每个发送线程现在处理发送到传输器子集的发送，每个块线程现在只协助一个发送线程，从而产生更多发送线程，从而获得更好的性能和数据节点可扩展性。
使用 SpinMethod 的自适应自旋控制。
一个简单的界面，用于在支持它的平台上设置自适应 CPU 自旋，使用
SpinMethod数据节点参数。此参数（在 NDB 8.0.20 中添加，功能从 NDB 8.0.24 开始）有四个设置，分别用于静态旋转、基于成本的自适应旋转、延迟优化的自适应旋转和针对数据库机器优化的自适应旋转，每个线程有自己的CPU。这些设置中的每一个都会导致数据节点为一个或多个旋转参数使用一组预定值，这些参数可以根据给定的场景启用自适应旋转、设置旋转时间和设置旋转开销，从而避免直接设置这些参数的需要对于常见用例。
为了微调自旋行为，也可以直接设置这些和其他自旋参数，使用现有的
SchedulerSpinTimer
数据节点配置参数以及
ndb_mgmDUMP客户端中的以下命令
：
DUMP 104000
(SetSchedulerSpinTimerAll)：设置所有线程的自旋时间
DUMP 104001
(SetSchedulerSpinTimerThread)：设置指定线程的自旋时间
DUMP 104002
(SetAllowedSpinOverhead)：将自旋开销设置为允许获得 1 个延迟单位的 CPU 时间单位数
DUMP 104003
(SetSpintimePerCall)：设置呼叫旋转的时间
DUMP 104004
(EnableAdaptiveSpinning)：启用或禁用自适应旋转
NDB 8.0.20 还添加了一个新的 TCP 配置参数
TcpSpinTime，用于设置给定 TCP 连接的自旋时间。
ndb_top工具也得到了增强，可以提供每个线程的自旋时间信息
。
有关其他信息，请参阅
SpinMethod参数说明、列出的DUMP命令和
第 23.5.29 节，“ndb_top — 查看 NDB 线程的 CPU 使用信息”。
磁盘数据和集群重启。
从 NDB 8.0.21 开始，集群的初始重启会强制删除所有磁盘数据对象，例如表空间和日志文件组，包括与这些对象关联的任何数据文件和撤消日志文件。
有关更多信息，请参阅第 23.6.11 节，“NDB Cluster 磁盘数据表”。
磁盘数据范围分配。
从 NDB 8.0.20 开始，数据文件中的范围分配在给定表空间使用的所有数据文件之间以循环方式完成。这有望在多个存储设备用于磁盘数据存储的情况下改善数据分布。
有关更多信息，请参阅
第 23.6.11.1 节，“NDB Cluster 磁盘数据对象”。
--ndb-log-fail-terminate 选项。
从 NDB 8.0.21 开始，您可以在 SQL 节点无法完全记录所有行事件时终止它。这可以通过使用
选项
启动mysqld来完成。--ndb-log-fail-terminateAllowUnresolvedHostNames 参数。
默认情况下，管理节点在无法解析全局配置文件中存在的主机名时拒绝启动，这在某些环境（例如 Kubernetes）中可能会出现问题。从 NDB 8.0.22 开始，可以通过在集群全局配置文件（文件）的部分中设置AllowUnresolvedHostNames
来覆盖此行为
。这样做会导致此类错误被视为警告，并允许ndb_mgmd继续启动
true[tcp
default]config.iniBlob 写入性能增强。
NDB 8.0.22 实现了一些改进，通过减少 SQL 或其他命令之间所需的往返次数，在同一行中修改多个 blob 列时，或者在同一语句中修改包含 blob 列的多行时，可以更有效地进行批处理应用这些修改时的 API 节点和数据节点。因此可以提高许多INSERT、
UPDATE和
语句的性能。DELETE此处列出了此类语句的示例，其中
包含一个或多个 Blob 列
table的
表：NDB
INSERT INTO table
VALUES ROW(1, blob_value1,
blob_value2, ...)，即插入包含一个或多个 Blob 列的行
INSERT INTO table
VALUES ROW(1, blob_value1),
ROW(2, blob_value2), ROW(3,
blob_value3), ...，即插入包含一个或多个 Blob 列的多行
UPDATE table SET
blob_column1 =
blob_value1,
blob_column2 =
blob_value2, ...
UPDATE table SET
blob_column =
blob_value WHERE
primary_key_column in
(value_list)，其中主键列不是 Blob 类型
DELETE FROM table
WHERE primary_key_column =
value，其中主键列不是 Blob 类型
DELETE FROM table
WHERE primary_key_column IN
(value_list)，其中主键列不是 Blob 类型
其他 SQL 语句也可能受益于这些改进。这些包括
LOAD DATA
INFILE和
CREATE
TABLE ... SELECT ...。此外，
where
在执行语句之前
使用存储引擎，也可能执行得更高效。ALTER TABLE
table ENGINE = NDBtableNDB
此增强功能适用于影响 MySQL 类型BLOB、
MEDIUMBLOB、
LONGBLOB、
TEXT、
MEDIUMTEXT和
的列的语句LONGTEXT。TINYBLOB仅更新或
列（或两种类型）的语句TINYTEXT不受此工作的影响，并且不应预期其性能会发生变化。
一些 SQL 语句的性能并没有因为这个增强而显着提高，因为它们需要扫描表 Blob 列，这打乱了批处理。此类陈述包括此处列出的类型：
SELECT FROM
table [WHERE
key_column IN
(blob_value_list)]，其中通过匹配使用 Blob 类型的主键或唯一键列来选择行
UPDATE table SET
blob_column =
blob_value WHERE
condition，使用
condition不依赖于唯一值的 a
DELETE FROM table
WHERE conditioncondition使用不依赖于唯一值的 a
删除包含一个或多个 Blob 列的行
ALTER TABLE在执行语句之前已经使用存储引擎的表上的
复制语句NDB
，并且其行在语句执行之前或之后（或两者）包含一个或多个 Blob 列
为了最大程度地利用此改进，您可能希望增加
用于mysqld--ndb-batch-size和
--ndb-blob-write-batch-bytes
选项的值，以最大程度地减少修改 blob 所需的往返次数。对于复制，还建议您启用
系统变量，这样可以最大限度地减少副本集群应用纪元事务所需的往返次数。
slave_allow_batching
笔记
从 NDB 8.0.30 开始，您还应该使用
ndb_replica_batch_size
instead of --ndb-batch-size, and
ndb_replica_blob_write_batch_bytes
rather than --ndb-blob-write-batch-bytes。有关更多信息，请参阅这些变量的描述以及
第 23.7.5 节，“为复制准备 NDB Cluster”。
Node.js 更新。
从 NDB 8.0.22 开始，NDB
Node.js 的适配器是使用版本 12.18.3 构建的，现在仅支持该版本（或更高版本的 Node.js）。
加密备份。
NDB 8.0.22 增加了对使用 AES-256-CBC 加密的备份文件的支持；这是为了防止从未经授权方访问的备份中恢复数据。加密后，备份数据受用户提供的密码保护。!密码可以是除,
', ",
$, %,
\, 和之外的可打印 ASCII 字符范围内的最多 256 个字符组成的任何字符串^。用于加密任何给定 NDB Cluster 备份的密码的保留必须由用户或应用程序执行；
NDB不保存密码。密码可以为空，但不建议这样做。
在进行 NDB Cluster 备份时，您可以使用
管理客户端命令对其进行加密。MGM API 的用户还可以通过调用来启动加密备份
。
ENCRYPT
PASSWORD=passwordSTART
BACKUPndb_mgm_start_backup4()您可以使用在 8.0.22版本中添加到 NDB Cluster 发行版中的ndbxfrm实用程序
来加密现有备份文件
；该程序也可用于解密加密的备份文件。此外，当
配置参数设置为 1
时， ndbxfrm可以使用与 NDB Cluster 用于创建备份的相同方法压缩备份文件和解压缩压缩备份文件
。CompressedBackup
要从加密备份中恢复，请使用
带有选项
和
的ndb_restore。这两个选项都是必需的，以及在未加密的情况下恢复相同备份所需的任何其他选项。
ndb_print_backup_file和
ndbxfrm也可以分别使用和
读取加密文件。
--decrypt--backup-password-P
password--decrypt-password=password
在提供密码和加密或解密选项的所有情况下，都必须引用密码；您可以使用单引号或双引号来分隔密码。
从 NDB 8.0.24 开始，NDB
此处列出的几个程序也支持从标准输入输入密码，类似于使用选项与mysql--password客户端交互登录时的操作方式（不包括命令行中的密码） :
对于ndb_restore和
ndb_print_backup_file，该
--backup-password-from-stdin
选项允许以安全方式输入密码，类似于mysql
客户端--password
选项的输入方式。对于ndb_restore，将选项与选项一起使用
--decrypt；对于
ndb_print_backup_file，使用选项代替-P选项。
对于ndb_mgm选项
, 与从系统 shell 启动集群备份
--backup-password-from-stdin一起被支持
。--execute "START BACKUP
[options]"
两个ndbxfrm选项，
--encrypt-password-from-stdin
和
--decrypt-password-from-stdin，在使用该程序加密或解密备份文件时会导致类似的行为。
有关详细信息，请参阅刚刚列出的程序的说明。
从 NDB 8.0.22 开始，也可以通过
在集群全局配置文件RequireEncryptedBackup=1
的[ndbd default]部分中设置来强制备份加密。完成后，
ndb_mgm客户端拒绝任何执行未加密备份的尝试。
从 NDB 8.0.24 开始，您可以使
ndb_mgm在创建备份时使用加密，方法是使用
--encrypt-backup. 在这种情况下，如果未提供密码，则在调用时会提示用户输入密码
START BACKUP。
支持 IPv6。
从 NDB 8.0.22 开始，支持 IPv6 寻址连接到管理和数据节点；这包括管理节点和数据节点与 SQL 节点之间的连接。配置集群时，您可以使用数字 IPv6 地址、解析为 IPv6 地址的主机名或两者。
要使 IPv6 寻址正常工作，集群部署的运行平台和网络必须支持 IPv6。与使用 IPv4 寻址时一样，主机名到 IPv6 地址的解析必须由操作平台提供。
IPv4 寻址继续受
NDB. 不建议同时使用 IPv4 和 IPv6 地址，但可以在以下情况下使用：
当管理节点配置了 IPv6 并且数据节点配置了
config.ini文件中的 IPv4 地址时：如果
--bind-address不与mgmd 一起使用，则此方法有效，并且数据节点启动时
--ndb-connectstring设置为管理节点的 IPv4 地址。
当管理节点配置有 IPv4 并且数据节点配置有 IPv6 地址时
config.ini：与其他情况类似，如果
--bind-address没有传递给mgmd并且数据节点启动时
--ndb-connectstring设置为管理节点的 IPv6 地址，则此方法有效。
这些情况之所以有效，是因为ndb_mgmd默认情况下不绑定到任何 IP 地址。
要从NDB
不支持 IPv6 寻址的版本升级到支持 IPv6 寻址的版本，前提是网络支持 IPv4 和 IPv6，首先执行软件升级；完成此操作后，您可以使用 IPv6 地址更新
config.ini文件中使用的 IPv4 地址。此后，要使配置更改生效并使集群开始使用 IPv6 地址，必须执行集群的系统重启。
自动安装程序弃用和删除。
MySQL NDB Cluster Auto-Installer 基于 Web 的安装工具 ( ndb_setup.py ) 在 NDB 8.0.22 中已弃用，并在 NDB 8.0.23 及更高版本中被删除。它不再受支持。
ndbmemcache 弃用和删除。
ndbmemcache不再受支持。
ndbmemcache在 NDB 8.0.22 中已弃用，并在 NDB 8.0.23 中删除。
ndbinfo backup_id 表。
NDB 8.0.24
在信息数据库中添加了一个backup_id表
。ndbinfo这旨在替代通过使用
ndb_select_all转储内部SYSTAB_0表的内容来获取此信息，这种方法容易出错并且执行时间过长。
START BACKUP该表只有一列和一行，其中包含使用管理客户端命令
获取的集群的最新备份的 ID
。如果找不到该集群的备份，该表将包含一个列值为 的行0。
表分区增强功能。
NDB 8.0.23 引入了一种处理表分区和碎片的新方法，它可以独立于重做日志部分的数量来确定给定数据节点的本地数据管理器 (LDM) 的数量。这意味着 LDM 的数量现在可以高度可变。
NDB当
ClassicFragmentation
数据节点配置参数（也在 NDB 8.0.23 中实现）设置为时，可以使用此方法false；在这种情况下，不再使用 LDM 的数量来确定为每个数据节点的表创建多少个分区，以及
PartitionsPerNode
参数（也在 NDB 8.0.23 中引入）决定了这个数字，它也用于计算用于表的片段数。
当ClassicFragmentation有其默认值true时，则使用传统的使用 LDM 数量的方法来确定一个表应具有的分片数量。
有关详细信息，请参阅
多线程配置参数 (ndbmtd)中先前引用的新参数的描述。
术语更新。
为了与 MySQL 8.0.21 和 NDB 8.0.21 中开始的工作保持一致，NDB 8.0.23 实现了许多术语更改，如下所列：
系统变量
ndb_slave_conflict_role
现已弃用。它被替换为
ndb_conflict_role。
许多NDB状态变量已弃用。下表显示了这些变量及其替换：
表 23.1 弃用的 NDB 状态变量及其替换
弃用的变量
替代品
Ndb_api_adaptive_send_deferred_count_slave
Ndb_api_adaptive_send_deferred_count_replica
Ndb_api_adaptive_send_forced_count_slave
Ndb_api_adaptive_send_forced_count_replica
Ndb_api_adaptive_send_unforced_count_slave
Ndb_api_adaptive_send_unforced_count_replica
Ndb_api_bytes_received_count_slave
Ndb_api_bytes_received_count_replica
Ndb_api_bytes_sent_count_slave
Ndb_api_bytes_sent_count_replica
Ndb_api_pk_op_count_slave
Ndb_api_pk_op_count_replica
Ndb_api_pruned_scan_count_slave
Ndb_api_pruned_scan_count_replica
Ndb_api_range_scan_count_slave
Ndb_api_range_scan_count_replica
Ndb_api_read_row_count_slave
Ndb_api_read_row_count_replica
Ndb_api_scan_batch_count_slave
Ndb_api_scan_batch_count_replica
Ndb_api_table_scan_count_slave
Ndb_api_table_scan_count_replica
Ndb_api_trans_abort_count_slave
Ndb_api_trans_abort_count_replica
Ndb_api_trans_close_count_slave
Ndb_api_trans_close_count_replica
Ndb_api_trans_commit_count_slave
Ndb_api_trans_commit_count_replica
Ndb_api_trans_local_read_row_count_slave
Ndb_api_trans_local_read_row_count_replica
Ndb_api_trans_start_count_slave
Ndb_api_trans_start_count_replica
Ndb_api_uk_op_count_slave
Ndb_api_uk_op_count_replica
Ndb_api_wait_exec_complete_count_slave
Ndb_api_wait_exec_complete_count_replica
Ndb_api_wait_meta_request_count_slave
Ndb_api_wait_meta_request_count_replica
Ndb_api_wait_nanos_count_slave
Ndb_api_wait_nanos_count_replica
Ndb_api_wait_scan_result_count_slave
Ndb_api_wait_scan_result_count_replica
Ndb_slave_max_replicated_epoch
Ndb_replica_max_replicated_epoch
已弃用的状态变量继续显示在 的输出中SHOW STATUS，但应尽快更新应用程序以不再依赖它们，因为不能保证它们在未来版本系列中的可用性。
表列中
先前显示
的值ADD_TABLE_MASTER和
值
已弃用。它们分别被值和
替换。
ADD_TABLE_SLAVEtab_copy_statusndbinfo
ndbinfo.table_distribution_statusADD_TABLE_COORDINATORADD_TABLE_PARTICIPANT--help某些
NDB客户端和实用程序（例如
ndb_restore ）
的输出已被修改。
线程配置增强。
从 NDB 8.0.23 开始，
ThreadConfig
参数的可配置性已通过两种新的线程类型进行了扩展，在此处列出：
query：查询线程（仅）适用于
READ COMMITTED查询。查询线程也充当恢复线程。查询线程数必须是 LDM 线程数的 0、1、2 或 3 倍。0（默认值，除非使用
ThreadConfig，或
AutomaticThreadConfig
已启用）导致 LDM 的行为与 NDB 8.0.23 之前的行为相同。
recover：恢复线程从本地检查点检索数据。这样指定的恢复线程永远不会充当查询线程。
也可以
通过以下两种方式之一
组合现有线程main和线程：rep
通过将这些参数之一设置为 0 进入单个线程。完成此操作后，生成的组合线程将与表main_rep
中的名称一起显示ndbinfo.threads
。
通过将和
都设置为 0，并设置
为 1 来与recv线程
一起使用。在这种情况下，组合线程被命名为。
ldmtcrecvmain_rep_recv
此外，增加了一些现有线程类型的最大数量。此处列出了新的最大值，包括查询线程和恢复线程的最大值：
低密度脂蛋白：332
查询：332
恢复：332
TC：128
接收：64
发送：64
主要：2
其他线程类型的最大值保持不变。
此外，作为与此任务相关的工作的结果，
NDB现在在使用超过 32 个块线程时使用互斥锁来保护作业缓冲区。虽然这会导致性能略有下降（在大多数情况下为 1% 到 2%），但它也会显着减少非常大的配置所需的内存量。例如，在 NDB 8.0.23 之前使用 2 GB 作业缓冲区内存的 64 线程设置在 NDB 8.0.23 及更高版本中应该只需要大约 1 GB。在我们的测试中，这导致在执行非常复杂的查询时整体提高了 5%。
有关详细信息，请参阅
ThreadConfig
参数说明和
ndbinfo.threads表格。
ThreadConfig 线程计数变化。
作为在 NDB 8.0.30 中完成的工作的结果，在这个和后续的 NDB Cluster 版本中，设置的值ThreadConfig
需要在
值字符串中显式地包括main、
rep、recv和
。此外，
必须为每个不使用的线程类型（ 、 或 ）显式设置
，复制线程 ( ) 的设置也需要为
.
ldmThreadConfigcount=0mainrepldmcount=1repcount=1main
这些更改可能会对使用此参数的 NDB 集群的升级产生重大影响；有关更多信息，请参阅
第 23.3.7 节，“升级和降级 NDB Cluster”。
ndbmtd 线程自动配置。
从 NDB 8.0.23 开始，可以使用ndbmtd配置参数
为多线程数据节点自动配置线程AutomaticThreadConfig。当此参数设置为 1 时NDB，根据应用程序可用的处理器数量，为所有线程支持的线程类型（包括
上一项中描述的新线程类型）query自动设置线程分配。recover如果系统不限制处理器的数量，您可以根据需要通过设置
NumCPUs（也在 NDB 8.0.23 中添加）。否则，自动线程配置最多可容纳 1024 个 CPU。
无论为ThreadConfig
或
MaxNoOfExecutionThreads
中设置的任何值如何，都会发生自动线程配置config.ini；这意味着无需设置这些参数中的任何一个。
此外，NDB 8.0.23 实现了许多新的
ndbinfo信息数据库表，提供有关硬件和 CPU 可用性的信息，以及NDB
数据节点的 CPU 使用情况。这些表列在这里：
cpudata
cpudata_1sec
cpudata_20sec
cpudata_50ms
cpuinfo
hwinfo
其中一些表在 NDB Cluster 支持的每个平台上都不可用；有关详细信息，请参阅它们的单独描述。
NDB 数据库对象的分层视图。
该dict_obj_tree表在 NDB 8.0.24 中添加到ndbinfo信息数据库中，可以提供许多数据库对象的分层和树状视图NDB，包括以下内容：
表和相关索引
表空间和相关数据文件
日志文件组和关联的撤消日志文件
有关更多信息和示例，请参阅
第 23.6.16.25 节，“ndbinfo dict_obj_tree 表”。
索引统计增强功能。
NDB 8.0.24 在索引统计计算方面实现了以下改进：
索引统计信息以前仅从一个片段中收集；这已更改，以便将此外推扩展到其他片段。
用于非常小的表的算法，例如丢弃结果的行很少的表，已经得到改进，因此对此类表的估计应该比以前更准确。
从 NDB 8.0.27 开始，索引统计表默认自动创建和更新，
IndexStatAutoCreate
并且
IndexStatAutoUpdate
都默认为1（启用）而不是
0（禁用），不再需要运行ANALYZE TABLE更新统计信息。
有关其他信息，请参阅
第 23.6.15 节，“NDB API 统计计数器和变量”。
还原操作期间 NULL 和 NOT NULL 之间的转换。
从 NDB 8.0.26 开始，ndb_restoreNULL可以使用此处列出的选项支持按原样
NOT NULL和反向
恢复列：
要将NULL列恢复为
NOT NULL，请使用该
--lossy-conversions
选项。
最初声明为的列NULL
不得包含任何NULL行；如果是这样，ndb_restore退出并出错。
要将NOT NULL列恢复为
NULL，请使用该
--promote-attributes
选项。
有关详细信息，请参阅指示的
ndb_restore选项的描述。
NdbScanFilter 的符合 SQL 的 NULL 比较模式。
传统上，在进行涉及 的比较时
NULL，
NdbScanFilter将
NULL视为等于NULL
（因此认为NULL == NULL是
TRUE）。这与 SQL 标准指定的不同，后者要求与
NULLreturn进行任何比较NULL，包括NULL == NULL.
以前，NDB API 应用程序不可能覆盖此行为；从 NDB 8.0.26 开始，您可以通过
NdbScanFilter::setSqlCmpSemantics()
在创建扫描过滤器之前调用来实现。（因此，此方法始终作为类方法调用，而不是作为实例方法调用。）这样做会导致创建下一个对象，以便对实例生命周期内执行的所有比较操作NdbScanFilter
使用符合 SQL 的
比较。您必须为每个应该使用 SQL 兼容比较的对象
NULL调用该方法
。NdbScanFilter
有关详细信息，请参阅
NdbScanFilter::setSqlCmpSemantics()。
弃用 NDB API .FRM 文件方法。
MySQL 8.0 和 NDB 8.0 不再使用
.FRM文件来存储表元数据。出于这个原因，从
NDB 8.0.27 开始， NDB API 方法getFrmData()、
getFrmLength()和
已弃用，并在未来的版本中删除。setFrm()对于读取和写入表元数据，请改用
getExtraMetadata()
and
setExtraMetadata()
。
首选 IPv4 或 IPv6 寻址。
NDB 8.0.26 添加
PreferIPVersion
配置参数，该参数控制 DNS 解析的寻址首选项。IPv4 ( PreferIPVersion=4) 是默认值。因为 NDB 中的配置检索要求此首选项对于所有 TCP 连接都是相同的，所以您应该只在[tcp
default]集群全局配置 ( config.ini) 文件的部分中设置它。
有关更多信息，请参阅第 23.4.3.10 节，“NDB Cluster TCP/IP 连接”。
记录增强功能。
以前，NDB Cluster 数据节点和管理节点日志的分析可能会受到以下事实的阻碍，即不同的日志消息使用不同的格式，并且并非所有日志消息都包含时间戳。这些问题的部分原因是日志记录是由许多不同的机制执行的，例如函数
printf、fprintf、
ndbout和ndbout_c、运算符的重载<<等。
我们通过标准化机制来解决这些问题，该
EventLogger机制已经存在于 中NDB，并且每条日志消息都以YYYY-MM-DD
HH:MM:SS格式的时间戳开头。
有关 NDB Cluster 事件日志和
日志消息格式
的更多信息，
请参阅第 23.6.3 节，“NDB Cluster 中生成的事件报告” 。EventLogger复制 ALTER TABLE 改进。
从 NDB 8.0.27 开始，
表ALTER TABLE上
的复制NDB会比较执行复制前后源表的片段提交计数。这允许执行此语句的 SQL 节点确定是否有任何并发​​的写入活动到正在更改的表；如果是，则 SQL 节点可以终止操作。
当检测到对正在更改的表进行并发写入时，该ALTER TABLE语句将被拒绝，并显示在复制 ALTER TABLE 期间检测到对源表中数据的更改错误。更改中止以避免不一致
( ER_TABLE_DEF_CHANGED)。停止更改操作，而不是允许它继续进行并发写入，可以帮助防止静默数据丢失或损坏。
ndbinfo index_stats 表。
NDB 8.0.28 增加了该
index_stats表，该表提供了 NDB 索引统计的基本信息。它主要用于内部测试，但作为ndb_index_stat的补充可能有用。
ndb_import --table 选项。
在 NDB 8.0.28 之前，ndb_import总是将从 CSV 文件中读取的数据导入到一个表中，该表的名称来源于正在读取的文件的名称。NDB 8.0.28 为该程序添加了一个--table
选项（简称：）-t来直接指定目标表的名称，并覆盖以前的行为。
ndb_import
的默认行为仍然是使用输入文件的基本名称作为目标表的名称。
ndb_import --missing-ai-column 选项。
从 NDB 8.0.29 开始，ndb_importAUTO_INCREMENT可以使用该
--missing-ai-column
版本中引入的选项从包含列空值的 CSV 文件导入数据。该选项可用于包含此类列的一个或多个表。
为了使此选项起作用，
AUTO_INCREMENTCSV 文件中的列不得包含任何值。否则，导入操作无法继续。
ndb_import 和空行。
ndb_import始终拒绝传入 CSV 文件中遇到的任何空行。NDB 8.0.30 添加了对将空行导入单个列的支持，前提是可以将空值转换为列值。
ndb_restore --with-apply-status 选项。 从 NDB 8.0.29 开始，可以使用ndb_restore和该
版本中添加的选项从备份
中恢复
ndb_apply_status表
。要使用此选项，您还必须
在调用ndb_restore时使用。
NDB--with-apply-status--restore-data
--with-apply-status恢复表的所有行，
但具有;ndb_apply_status的行除外 server_id = 0要恢复此行，请使用--restore-epoch. 有关更多信息，请参阅
ndb_apply_status 表，作为--with-apply-status
选项的描述。
SQL 访问缺少索引的表。
在 NDB 8.0.29 之前，当用户查询尝试打开
NDB索引缺失或损坏的表时，MySQL 服务器会引发NDB错误
4243（未找到索引）。当违反约束或丢失数据导致无法恢复NDB表上的索引时，可能会出现这种情况，并且
使用ndb_restore
--disable-indexes来恢复没有索引的数据。
从 NDB 8.0.29 开始，
NDB如果查询不使用任何缺少的索引，则针对缺少索引的表的 SQL 查询会成功。否则，查询将被拒绝
ER_NOT_KEYFILE。在这种情况下，您可以使用
ALTER TABLE
... ALTER INDEX ... INVISIBLE适当的 SQL 语句阻止 MySQL 优化器尝试使用索引，或删除索引（然后可能重新创建它）。
NDB API List::clear() 方法。
NDB APIDictionary
方法
listEvents()、
listIndexes()和
listObjects()
每个都需要引用一个
List空对象。List以前，由于这个原因，使用这些方法中的任何一种重用现有的都是有问题的。NDB 8.0.29 通过实施一种
clear()从列表中删除所有数据的方法使这更容易。
作为这项工作的一部分，List类析构函数现在会List::clear()在从列表中删除任何元素或属性之前调用。
ndbinfo 中的 NDB 字典表。
NDB 8.0.29 在
ndbinfo数据库中引入了几个新表，提供
NdbDictionary了以前需要使用ndb_desc、
ndb_select_all和其他
NDB实用程序的信息。
其中两个表实际上是视图。该
hash_maps表提供了有关 ; 使用的哈希映射的信息NDB；该files表显示有关用于在磁盘上存储数据的文件的信息（请参阅
第 23.6.11 节，“NDB Cluster 磁盘数据表”）。
ndbinfoNDB 8.0.29 中添加
的其余六个表是基表。这些表没有隐藏，也没有使用前缀命名ndb$。此处列出了这些表，并对每个表中表示的对象进行了描述：
blobs: 用于存储
BLOB和
TEXT列
的可变大小部分的 Blob 表
dictionary_columns：NDB表格
的列
dictionary_tables：
NDB表
events: NDB API 中的事件订阅
foreign_keysNDB：表
上的外键
index_columnsNDB：表
上的索引
NDB 8.0.29 还对
ndbinfo存储引擎的主键实现进行了更改，以提高与
NdbDictionary.
ndbcluster 插件和性能模式。
从 NDB 8.0.29 开始，ndbcluster插件线程显示在性能模式
threads和
setup_threads表中，从而可以获取有关这些线程性能的信息。performance_schema此处列出了表中
公开的三个线程
：
ndb_binlog：二进制日志记录线程
ndb_index_stat: 索引统计线程
ndb_metadata：元数据线程
有关更多信息和示例，
请参阅ndbcluster 插件线程。memory/ndbcluster/Thd_ndb::batch_mem_root
在 NDB 8.0.30 及更高版本中，事务批处理内存使用情况在性能模式
memory_summary_by_thread_by_event_name
和setup_instruments表中
是可见
的。您可以使用此信息来查看事务正在使用多少内存。有关其他信息，请参阅
事务内存使用情况。
可配置的 blob 内联大小。
从 NDB 8.0.30 开始，可以将 blob 列的内联大小设置为
CREATE TABLEor
的一部分ALTER TABLE。NDB Cluster 支持的最大内联大小为 29980 字节。
有关其他信息和示例，请参阅
NDB_COLUMN 选项以及字符串类型存储要求。
replica_allow_batching 默认启用。
副本写入批处理极大地提高了 NDB Cluster 复制性能，特别是在复制 blob 类型列（TEXT，，
BLOB和
JSON）时，因此通常应该在使用 NDB Cluster 复制时启用。出于这个原因，从 NDB 8.0.30 开始，
replica_allow_batching
默认启用系统变量，并将其设置为
OFF引发警告。
冲突解决插入操作支持。
在 NDB 8.0.30 之前，只有两种策略可用于解决更新和删除操作的主键冲突，实现为函数
NDB$MAX()和
NDB$MAX_DELETE_WIN(). 这些都不会对写入操作产生任何影响，除了与先前写入具有相同主键的写入操作总是被拒绝，并且仅当不存在具有相同主键的操作时才被接受和应用。NDB 8.0.30 引入了两个新的冲突解决函数
NDB$MAX_INS()
和
NDB$MAX_DEL_WIN_INS()
处理插入操作之间的主键冲突。这些函数按如下方式处理冲突写入：
如果没有冲突的写，应用这个（这和 一样NDB$MAX()）。
否则，应用“最大时间戳获胜”
冲突解决，如下所示：
如果传入写入的时间戳大于冲突写入的时间戳，则应用传入操作。
如果传入写入的时间戳
不大于，则拒绝传入写入操作。
对于冲突的更新和删除操作，
NDB$MAX_INS()行为与
NDB$MAX()
一样，并且NDB$MAX_DEL_WIN_INS()行为方式与
NDB$MAX_DELETE_WIN().
此增强功能支持在处理冲突的复制写入操作时配置冲突检测，以便
INSERT幂等地应用具有较高时间戳列值的复制，而
INSERT拒绝具有较低时间戳列值的复制。
与其他冲突解决功能一样，可以选择将被拒绝的操作记录在异常表中；被拒绝的操作会增加一个计数器（
“最大时间戳获胜”和
“
相同时间戳获胜”Ndb_conflict_fn_max的
状态变量）。
Ndb_conflict_fn_old
有关更多信息，请参阅新冲突解决功能的描述，以及
第 23.7.11 节，“NDB 集群复制冲突解决”。
复制应用程序批量大小控制。
以前，写入副本 NDB Cluster 时
--ndb-batch-size使用的批大小由 控制，用于将 blob 数据写入副本的批大小由 确定
ndb-blob-write-batch-bytes。这种安排的一个问题是副本使用这些变量的全局值，这意味着为副本更改其中任何一个也会影响所有其他会话使用的值。此外，不可能为副本专有的这些值设置不同的默认值，副本最好具有比其他会话更高的默认值。
NDB 8.0.30 添加了两个特定于副本应用程序的新系统变量。
ndb_replica_batch_size现在控制用于副本应用程序的批量大小，
ndb_replica_blob_write_batch_bytes
变量现在确定用于在副本上执行批量 blob 写入的 blob 写入批量大小。
此更改应使用默认设置改进 MySQL NDB Cluster Replication 的行为，并允许用户在不影响用户线程的情况下微调 NDB 复制性能，例如执行 SQL 查询处理的线程。
有关详细信息，请参阅新变量的说明。另见
第 23.7.5 节，“准备 NDB Cluster 进行复制”。
二进制日志事务压缩。
NDB 8.0.31 添加了对使用带有压缩的压缩事务​​的二进制日志的支持ZSTD。要启用此功能，请
ndb_log_transaction_compression
将此版本中引入的系统变量设置为
ON. 所使用的压缩级别可以使用
ndb_log_transaction_compression_level_zstd
系统变量来控制，该变量也在该版本中添加；默认压缩级别为 3。
虽然
binlog_transaction_compression
和
binlog_transaction_compression_level_zstd
服务器系统变量对表的二进制日志记录没有影响
NDB，但启动
mysqld会
--binlog-transaction-compression=ON导致
ndb_log_transaction_compression自动启用。SET
@@global.ndb_log_transaction_compression=OFF您可以在服务器启动完成后
使用 MySQL 客户端会话禁用它。
有关详细信息，请参阅描述
ndb_log_transaction_compression
以及
第 5.4.4.5 节“二进制日志事务压缩”。
构建选项的更改。
NDB 8.0.31 对用于构建 MySQL Cluster 的 CMake 选项进行了以下更改。
该WITH_NDBCLUSTER选项已弃用并被
WITH_PLUGIN_NDBCLUSTER删除。
要从源代码构建 MySQL 集群，请使用新添加的
WITH_NDB选项。
WITH_NDBCLUSTER_STORAGE_ENGINE
继续得到支持，但大多数构建不再需要。
有关更多信息，
请参阅用于编译 NDB Cluster 的 CMake 选项。文件系统加密。
透明数据加密 (TDE) 通过对静态数据（即持久保存到磁盘NDB的所有NDB表数据和日志文件）进行加密来提供保护。这是为了防止在获得对 NDB Cluster 数据文件（如表空间文件或日志）的未授权访问后恢复数据。
NDBFS加密由数据节点上
的 NDB 文件系统层 ( ) 透明地实现；数据在从文件读取和写入文件时进行加密和解密，NDBFS内部客​​户端块照常对文件进行操作。
NDBFS可以直接从用户提供的密码透明地加密文件，但是出于效率、可用性、安全性和灵活性的原因，将单个文件的加密和解密与用户提供的密码分离可能是有利的。请参阅
第 23.6.14.2 节，“NDB 文件系统加密实现”。
TDE 使用两种类型的密钥。密钥用于加密存储在磁盘上的实际数据和日志文件（包括 LCP、重做、撤消和表空间文件）。然后使用主密钥来加密密钥。
数据节点配置参数从
EncryptedFileSystem
NDB 8.0.29 开始可用，当设置为 时1，会对存储表数据的文件强制加密。这包括 LCP 数据文件、重做日志文件、表空间文件和撤消日志文件。
还需要在启动或重新启动时为每个数据节点提供密码，使用选项之一
--filesystem-password或
--filesystem-password-from-stdin。请参阅第 23.6.14.1 节，“NDB 文件系统加密设置和使用”。此密码使用相同的格式并受与用于加密NDB
备份的密码相同的约束（有关详细信息，请参阅
ndb_restore
--backup-password选项的描述）。
只有使用NDB存储引擎的表才能通过此功能进行加密；参见
第 23.6.14.3 节，“NDB 文件系统加密限制”。其他表，例如用于NDB模式分发、复制和二进制日志记录的表，通常使用
InnoDB; 参见
第 15.13 节，“InnoDB 静态数据加密”。有关二进制日志文件加密的信息，请参阅
第 17.3.2 节，“加密二进制日志文件和中继日志文件”。
进程生成或使用的文件NDB（例如操作系统日志、崩溃日志和核心转储）未加密。被用户使用NDB但不包含任何用户表数据的文件也未加密；这些包括 LCP 控制文件、模式文件和系统文件（请参阅
NDB Cluster 数据节点文件系统）。管理服务器配置缓存也未加密。
此外，NDB 8.0.31 添加了一个新的实用程序
ndb_secretsfile_readerS0.sysfile ，用于从机密文件 ( )
中提取密钥信息。
此增强功能建立在 NDB 8.0.22 中完成的工作之上，以实现加密NDB备份。有关加密备份的更多信息，请参阅
RequireEncryptedBackup
配置参数的说明以及
第 23.6.8.2 节，“使用 NDB Cluster Management Client 创建备份”。
删除不需要的程序选项。 NDB Cluster 8.0.31 中删除了 NDB 实用程序和其他从未实现的程序
的许多“垃圾”命令行选项。此处列出了已删除的选项和程序：
--ndb-optimized-node-selection:
ndbd， ndbmtd，
ndb_mgm，
ndb_delete_all，
ndb_desc，
ndb_drop_index，
ndb_drop_table，
ndb_show_table，
ndb_blob_tool，
ndb_config，
ndb_index_stat，
ndb_move_data，
ndbinfo_select_all，
ndb_select_count
--character-sets-dir:
ndb_mgm， ndb_mgmd，
ndb_config，
ndb_delete_all，
ndb_desc，
ndb_drop_index，
ndb_drop_table，
ndb_show_table，
ndb_blob_tool，
ndb_config，
ndb_index_stat，
ndb_move_data，
ndbinfo_select_all，
ndb_select_count，
ndb_waiter
--core-file:
ndb_mgm， ndb_mgmd，
ndb_config，
ndb_delete_all，
ndb_desc，
ndb_drop_index，
ndb_drop_table，
ndb_show_table，
ndb_blob_tool，
ndb_config，
ndb_index_stat，
ndb_move_data，
ndbinfo_select_all，
ndb_select_count，
ndb_waiter
--connect-retries和
--connect-retry-delay：
ndb_mgmd
--ndb-nodeid:
ndb_config
有关更多信息，请参阅第 23.5 节，“NDB 集群程序”
中的相关程序和选项说明。
读取配置缓存文件。
从 NDB 8.0.32 开始，可以
使用该
版本
中引入的ndb_config选项
读取由ndb_mgmd创建的二进制配置缓存文件。这可以简化确定给定配置文件中的设置是否已应用于集群的过程，或者在
文件因某种原因损坏或丢失后从二进制缓存中恢复设置的过程。
--config-binary-fileconfig.ini
有关更多信息和示例，请参阅第 23.5.7 节，“ndb_config - 提取 NDB Cluster 配置信息”中对此选项的描述。
MySQL Cluster Manager 1.4.8 还提供了对 NDB Cluster 8.0 的实验性支持。MySQL Cluster Manager 有一个高级命令行界面，可以简化许多复杂的 NDB Cluster 管理任务。有关详细信息，请参阅
MySQL Cluster Manager 1.4.8 用户手册。
© Mysql 中文网
