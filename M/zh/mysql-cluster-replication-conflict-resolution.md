# 23.7.11 NDB Cluster 复制冲突解决_MySQL 8.0 参考手册

23.7.11 NDB Cluster 复制冲突解决_MySQL 8.0 参考手册
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
23.7.11 NDB Cluster 复制冲突解决
23.7.11 NDB Cluster 复制冲突解决
要求源列控件冲突解决控制冲突解决函数冲突解决例外表冲突检测状态变量例子
当使用涉及多个源（包括循环复制）的复制设置时，不同的源可能会尝试使用不同的数据更新副本上的同一行。NDB Cluster Replication 中的冲突解决提供了一种解决此类冲突的方法，方法是允许使用用户定义的解决方案列来确定是否应在副​​本上应用给定源的更新。
NDB Cluster 支持的某些类型的冲突解决（NDB$OLD()，，NDB$MAX()和
NDB$MAX_DELETE_WIN()；另外，在 NDB 8.0.30 及更高版本中，NDB$MAX_INS()和
NDB$MAX_DEL_WIN_INS()）将此用户定义的列实现为“时间戳”列（尽管其类型不能是TIMESTAMP，如本节后面所述）部分）。这些类型的冲突解决总是逐行应用，而不是事务处理。基于时代的冲突解决功能
NDB$EPOCH()和
NDB$EPOCH_TRANS()比较时代被复制的顺序（因此这些功能是事务性的）。当发生冲突时，可以使用不同的方法来比较副本上的解析列值，如本节后面所述；使用的方法可以设置为作用于单个表、数据库或服务器，或者使用模式匹配作用于一组一个或多个表。有关在表的、
和
列中使用模式匹配的信息，请参阅
使用通配符匹配。
dbtable_nameserver_idmysql.ndb_replication
您还应该记住，应用程序有责任确保解析列正确填充相关值，以便解析函数可以在确定是否应用更新时做出适当的选择。
要求
必须在源和副本上为解决冲突做准备。以下列表描述了这些任务：
在写入二进制日志的源上，您必须确定发送哪些列（所有列或仅那些已更新的列）。这是通过应用mysqld启动选项
（在本节后面描述）或通过在表中放置适当的条目（参见
ndb_replication 表--ndb-log-updated-only）
在一个或多个特定表上
为整个 MySQL 服务器完成的。
mysql.ndb_replication
笔记
如果您正在复制具有非常大的列（例如TEXT或
BLOB列）的表，
--ndb-log-updated-only也可以用于减小二进制日志的大小并避免由于超过
max_allowed_packet.
有关此问题的更多信息，
请参阅
第 17.5.1.20 节，“复制和 max_allowed_pa​​cket” 。
在副本上，您必须确定要应用哪种类型的冲突解决方案（“最新时间戳胜出”、
“相同时间戳胜出”、“主要胜出”、“主要胜出，完成事务”或无）。这是使用
mysql.ndb_replication系统表完成的，并适用于一个或多个特定表（请参阅
ndb_replication 表）。
NDB Cluster 还支持读取冲突检测，即检测一个集群中给定行的读取与另一个集群中同一行的更新或删除之间的冲突。ndb_log_exclusive_reads
这需要通过在副本上设置等于 1 来获得独占读锁
。冲突读取读取的所有行都记录在异常表中。有关详细信息，请参阅
读取冲突检测和解决。
在 NDB 8.0.30 之前，NDB应用
WRITE_ROW事件严格作为插入，要求没有任何这样的行；也就是说，如果行已经存在，传入的写入总是被拒绝。（当使用
NDB$MAX_INS()or
以外的任何冲突解决函数时，情况仍然如此NDB$MAX_DEL_WIN_INS()。）
从 NDB 8.0.30 开始，当使用
NDB$MAX_INS()or
时NDB$MAX_DEL_WIN_INS()，
NDB可以幂等地应用
WRITE_ROW事件，当传入行尚不存在时将此类事件映射到插入，如果存在则映射到更新。
当使用函数NDB$OLD()、
NDB$MAX()和
NDB$MAX_DELETE_WIN()用于基于时间戳的冲突解决（以及NDB$MAX_INS()
和NDB$MAX_DEL_WIN_INS()，从 NDB 8.0.30 开始），我们通常将用于确定更新的列称为“时间戳”列。但是，该列的数据类型是 never
TIMESTAMP；相反，它的数据类型应该是INT
( INTEGER) 或
BIGINT. “
时间戳”列
也应该是
UNSIGNED和。NOT NULL
本节后面讨论的NDB$EPOCH()和
NDB$EPOCH_TRANS()函数通过比较应用在主 NDB Cluster 和辅助 NDB Cluster 上的复制时期的相对顺序来工作，并且不使用时间戳。
源列控件
我们可以根据“之前”
和“之后”图像来查看更新操作，即应用更新之前和之后的表状态。通常，当更新一个带有主键的表时，“之前”
的图像并不是很重要；然而，当我们需要在每次更新的基础上确定是否在副本上使用更新的值时，我们需要确保两个图像都写入源的二进制日志。这是通过
mysqld--ndb-log-update-as-write的选项完成的，如本节后面所述。
重要的
是记录完整的行还是只记录更新的列是在 MySQL 服务器启动时决定的，并且不能在线更改；您必须重新启动
mysqld或使用不同的日志记录选项启动新的
mysqld实例。
冲突解决控制
通常在可能发生冲突的服务器上启用冲突解决。与记录方法选择一样，它由表中的条目启用
mysql.ndb_replication。
NBT_UPDATED_ONLY_MINIMALand
NBT_UPDATED_FULL_MINIMAL可以与
NDB$EPOCH(), NDB$EPOCH2(), 和一起使用NDB$EPOCH_TRANS()，因为它们不需要不是主键的列的“之前”值。需要旧值（例如NDB$MAX()和
NDB$OLD()）的冲突解决算法无法正确处理这些
binlog_type值。
冲突解决函数
本节提供有关可用于 NDB 复制冲突检测和解决的功能的详细信息。
新开发银行$OLD()新开发银行$MAX()NDB$MAX_DELETE_WIN()导航台 $MAX_INS()NDB$MAX_DEL_WIN_INS()NDB$EPOCH()NDB$EPOCH_TRANS()NDB$EPOCH2()NDB$EPOCH2_TRANS()
新开发银行$OLD()
如果column_name源和副本上的值相同，则应用更新；否则，更新不会应用于副本，并且会向日志中写入异常。以下伪代码说明了这一点：
if (source_old_column_value == replica_current_column_value)
apply_update();
else
log_exception();
该函数可用于“同值取胜”的
冲突解决。这种类型的冲突解决可确保不会将更新应用到来自错误来源的副本。
重要的
此函数使用源的“之前”
图像中的列值。
新开发银行$MAX()
对于更新或删除操作，如果来自源的给定行的
“时间戳”列值高于副本上的值，则应用它；否则它不会应用于副本。以下伪代码说明了这一点：
if (source_new_column_value > replica_current_column_value)
apply_update();
此函数可用于“最大时间戳获胜”冲突解决。这种类型的冲突解决可确保在发生冲突时，最近更新的行的版本是持续存在的版本。
这个函数对写操作之间的冲突没有影响，除了总是拒绝与前一个写操作具有相同主键的写操作；仅当不存在使用相同主键的写操作时才接受和应用它。从 NDB 8.0.30 开始，您可以使用
NDB$MAX_INS()
来处理写入之间的冲突解决。
重要的
此函数使用来源的“后”
图像中的列值。
NDB$MAX_DELETE_WIN()
这是NDB$MAX(). 由于没有可用于删除操作的时间戳，删除使用NDB$MAX()实际上被处理为NDB$OLD，但对于某些用例，这不是最佳选择。对于NDB$MAX_DELETE_WIN()，如果添加或更新来自源的现有行的给定行的
“时间戳”列值高于副本上的值，则应用它。但是，删除操作被视为始终具有较高的值。以下伪代码说明了这一点：
if ( (source_new_column_value > replica_current_column_value)
||
operation.type == "delete")
apply_update();
该函数可用于“最大时间戳，删除胜出”冲突解决。这种类型的冲突解决确保在发生冲突时，被删除或（否则）最近更新的行的版本是持续存在的版本。
笔记
与 一样NDB$MAX()，源的“后”图像中的列值是此函数使用的值。
导航台 $MAX_INS()
此函数支持解决冲突的写操作。此类冲突由
“ NDB$MAX_INS() ”处理，如下所示：
如果没有冲突的写，应用这个（这和 一样NDB$MAX()）。
否则，应用“最大时间戳获胜”
冲突解决，如下所示：
如果传入写入的时间戳大于冲突写入的时间戳，则应用传入操作。
如果传入写入的时间戳
不大于，则拒绝传入写入操作。
在处理插入操作时，
NDB$MAX_INS()比较来自源和副本的时间戳，如以下伪代码所示：
if (source_new_column_value > replica_current_column_value)
apply_insert();
else
log_exception();
对于更新操作，将来自源的更新时间戳列值与副本的时间戳列值进行比较，如下所示：
if (source_new_column_value > replica_current_column_value)
apply_update();
else
log_exception();
这与 执行的相同
NDB$MAX()。
对于删除操作，处理也与执行的相同NDB$MAX()（因此与 相同
NDB$OLD()），并且是这样完成的：
if (source_new_column_value == replica_current_column_value)
apply_delete();
else
log_exception();
NDB$MAX_INS()在 NDB 8.0.30 中添加。
NDB$MAX_DEL_WIN_INS()
该函数提供了对冲突写操作的解决方案，以及类似.delete wins的
解决方案
NDB$MAX_DELETE_WIN()。写冲突由
NDB$MAX_DEL_WIN_INS()如下所示处理：
如果没有冲突的写，应用这个（这和 一样NDB$MAX_DELETE_WIN()）。
否则，应用“最大时间戳获胜”
冲突解决，如下所示：
如果传入写入的时间戳大于冲突写入的时间戳，则应用传入操作。
如果传入写入的时间戳
不大于，则拒绝传入写入操作。
由 执行的插入操作的处理
NDB$MAX_DEL_WIN_INS()可以用伪代码表示，如下所示：
if (source_new_column_value > replica_current_column_value)
apply_insert();
else
log_exception();
对于更新操作，将源的更新时间戳列值与副本的时间戳列值进行比较，如下所示（再次使用伪代码）：
if (source_new_column_value > replica_current_column_value)
apply_update();
else
log_exception();
删除是使用“删除总是获胜”
策略（与 相同NDB$MAX_DELETE_WIN()）处理的；aDELETE始终在不考虑任何时间戳值的情况下应用，如以下伪代码所示：
if (operation.type == "delete")
apply_delete();
对于更新和删除操作之间的冲突，此函数的行为与
NDB$MAX_DELETE_WIN().
NDB$MAX_DEL_WIN_INS()在 NDB 8.0.30 中添加。
NDB$EPOCH()
该NDB$EPOCH()函数跟踪复制时期在副本集群上应用的顺序，相对于在副本上发起的更改。此相对顺序用于确定源自副本的更改是否与源自本地的任何更改并发，并因此可能发生冲突。
的描述中的大部分内容
NDB$EPOCH()也适用于
NDB$EPOCH_TRANS(). 任何例外情况都会在文中注明。
NDB$EPOCH()是不对称的，在双向复制配置（有时称为“主动-主动”
复制）中的一个 NDB Cluster 上运行。我们在这里将其运行的集群称为主要集群，将另一个集群称为次要集群。primary 上的副本负责检测和处理冲突，而 secondary 上的副本不参与任何冲突检测或处理。
当主节点上的副本检测到冲突时，它会将事件注入到自己的二进制日志中以补偿这些冲突；这确保了辅助 NDB Cluster 最终会与主集群重新对齐，从而防止主集群和辅助集群发生分歧。这种补偿和重新调整机制要求主 NDB Cluster 始终赢得与次级的任何冲突 - 也就是说，在发生冲突时始终使用主的更改而不是次要的更改。这个“主要总是获胜”
的规则具有以下含义：
更改数据的操作一旦在主数据库上提交，就会完全持久化，并且不会通过冲突检测和解决来撤消或回滚。
从主读取的数据是完全一致的。对主（本地或从副本）提交的任何更改以后都不会恢复。
如果主服务器确定它们存在冲突，则更改辅助服务器上的数据的操作稍后可能会被恢复。
在辅助节点上读取的各个行始终是自洽的，每一行始终反映辅助节点提交的状态或主节点提交的状态。
在给定的单个时间点，在辅助节点上读取的行集可能不一定是一致的。对于
NDB$EPOCH_TRANS()，这是一个瞬态；对于NDB$EPOCH()，它可以是一个持久状态。
假设一段足够长的时间没有任何冲突，辅助 NDB Cluster 上的所有数据（最终）将与主数据保持一致。
NDB$EPOCH()并且
NDB$EPOCH_TRANS()不需要任何用户架构修改或应用程序更改来提供冲突检测。但是，必须仔细考虑所使用的模式和所使用的访问模式，以验证整个系统的行为是否在指定的限制内。
每个NDB$EPOCH()和
NDB$EPOCH_TRANS()函数都可以有一个可选参数；这是用于表示纪元的低 32 位的位数，应设置为不小于此处显示的计算值：
CEIL( LOG2( TimeBetweenGlobalCheckpoints / TimeBetweenEpochs ), 1)
对于这些配置参数的默认值（分别为 2000 和 100 毫秒），这给出了 5 位的值，因此默认值 (6) 应该足够了，除非其他值用于
TimeBetweenGlobalCheckpoints、
TimeBetweenEpochs或两者。太小的值会导致误报，而太大的值会导致数据库中过多的空间浪费。
将冲突行的条目插入到相关的异常表中，前提是这些表是根据本节其他地方描述的相同异常表模式规则定义的（请参阅
NDB$EPOCH()NDB
$ OLD()）。在创建要使用它的数据表之前，您必须创建任何异常表。
NDB$EPOCH_TRANS()
与本节中讨论的其他冲突检测功能一样NDB$EPOCH()，
NDB$EPOCH_TRANS()通过在表中包含相关条目来激活mysql.ndb_replication
（请参阅ndb_replication 表）。在这种情况下，主要和次要 NDB Clusters 的角色完全由
mysql.ndb_replicationtable 条目确定。
由于 和 使用的冲突检测算法
NDB$EPOCH()是
不对称的，因此您必须
对主副本和辅助副本
NDB$EPOCH_TRANS()的条目使用不同的值。server_id
仅操作之间的冲突DELETE不足以触发使用
NDB$EPOCH()or
的冲突NDB$EPOCH_TRANS()，并且历元内的相对位置无关紧要。
NDB$EPOCH() 的限制
NDB$EPOCH()用于执行冲突检测
时，当前适用以下限制
：
使用 NDB Cluster 纪元边界检测冲突，粒度与
TimeBetweenEpochs
（默认值：100 毫秒）成比例。最小冲突窗口是两个集群上对相同数据的并发更新始终报告冲突的最短时间。这始终是一个非零时间长度，并且大致与 成正比2 * (latency + queueing +
TimeBetweenEpochs)。这意味着——假设默认值
TimeBetweenEpochs
并忽略集群之间的任何延迟（以及任何排队延迟）——最小冲突窗口大小约为 200 毫秒。在查看预期应用程序时应考虑这个最小窗口
“种族”模式。
NDB$EPOCH()使用and
NDB$EPOCH_TRANS()函数
的表需要额外的存储空间
；每行需要 1 到 32 位额外空间，具体取决于传递给函数的值。
删除操作之间的冲突可能会导致主要和次要之间出现分歧。当同时在两个集群上删除一行时，可以检测到冲突，但不会记录冲突，因为该行已被删除。这意味着在传播任何后续重新对齐操作期间不会检测到进一步的冲突，这可能导致发散。
删除应该在外部序列化，或者只路由到一个集群。或者，一个单独的行应该用这样的删除和跟随它们的任何插入进行事务更新，以便可以跨行删除跟踪冲突。这可能需要更改应用程序。
在使用或
用于冲突检测
时，目前仅支持
双向
“主动-主动”配置中的两个 NDB 集群。NDB$EPOCH()NDB$EPOCH_TRANS()当前不支持
具有BLOBor
列的表or
。
TEXTNDB$EPOCH()NDB$EPOCH_TRANS()
NDB$EPOCH_TRANS()
NDB$EPOCH_TRANS()扩展
NDB$EPOCH()功能。使用“ primary wins all ”规则（请参阅
NDB$EPOCH() ）以相同的方式检测和处理冲突，但有一个额外的条件，即在发生冲突的同一事务中更新的任何其他行也被视为在冲突。换句话说，where
NDB$EPOCH()重新对齐次级上的各个冲突行，NDB$EPOCH_TRANS()
重新对齐冲突的事务。
此外，任何可检测到依赖于冲突事务的事务也被视为冲突，这些依赖性由辅助集群的二进制日志的内容确定。由于二进制日志仅包含数据修改操作（插入、更新和删除），因此仅使用重叠的数据修改来确定事务之间的依赖关系。
NDB$EPOCH_TRANS()受与 相同的条件和限制NDB$EPOCH()，此外还要求所有事务 ID 都记录在辅助的二进制日志中（
--ndb-log-transaction-id选项），这会增加可变开销（每行最多 13 个字节）。已弃用的
log_bin_use_v1_row_events
系统变量，默认为OFF，不得设置为ONwith
NDB$EPOCH_TRANS()。
参见NDB$EPOCH()。
NDB$EPOCH2()
该NDB$EPOCH2()功能类似于
NDB$EPOCH()，不同之处在于它
NDB$EPOCH2()提供了双向复制拓扑的删除-删除处理。ndb_slave_conflict_role在这种情况下，通过将系统变量设置为每个源上的适当值（通常 , 各一个PRIMARY）
，将主要角色和次要角色分配给两个源
SECONDARY。完成此操作后，次级所做的修改将由初级反映回次级，然后有条件地应用它们。
NDB$EPOCH2_TRANS()
NDB$EPOCH2_TRANS()扩展
NDB$EPOCH2()功能。以相同的方式检测和处理冲突，并将主要和次要角色分配给复制集群，但额外的条件是在发生冲突的同一事务中更新的任何其他行也被视为冲突。也就是说，NDB$EPOCH2()重新对齐辅助节点上的各个冲突行，同时
NDB$EPOCH_TRANS()重新对齐冲突的事务。
在哪里NDB$EPOCH()和
NDB$EPOCH_TRANS()使用每行指定的元数据，每个最后修改的时期，来确定在主节点上来自辅助节点的传入复制行更改是否与本地提交的更改并发；并发更改被认为是冲突的，随后的异常表更新和次要的重新对齐。当在主数据库上删除一行时会出现问题，因此不再有任何最后修改的纪元可用于确定是否有任何复制操作冲突，这意味着不会检测到冲突的删除操作。这可能会导致分歧，例如一个集群上的删除与另一个集群上的删除和插入并发；
NDB$EPOCH()和
NDB$EPOCH_TRANS()。
NDB$EPOCH2()通过忽略任何删除-删除冲突，并避免任何潜在的结果分歧，绕过了刚刚描述的问题——在 PRIMARY 上存储有关已删除行的信息。这是通过将任何成功应用于辅助节点并从辅助节点复制的操作反映回辅助节点来实现的。在它返回到辅助节点时，它可用于在辅助节点上重新应用操作，该操作已被源自主节点的操作删除。
使用 时NDB$EPOCH2()，您应该记住，辅助应用从主应用删除，删除新行，直到它被反射操作恢复。理论上，后续在 secondary 上的 insert 或 update 会与 primary 上的 delete 发生冲突，但在这种情况下，我们选择忽略这一点，让 secondary
“获胜”，为了防止集群之间的分歧。换句话说，删除后，primary 不会检测到冲突，而是立即采用 secondary 的后续更改。正因为如此，次要状态在进入最终（稳定）状态时可以重新访问多个先前提交的状态，并且其中一些可能是可见的。
您还应该知道，将所有操作从辅助设备反映回主设备会增加主设备的日志二进制日志的大小，以及对带宽、CPU 使用率和磁盘 I/O 的需求。
次要应用反射操作取决于次要目标行的状态。Ndb_conflict_reflected_op_prepare_count
可以通过检查和
Ndb_conflict_reflected_op_discard_count
状态变量来跟踪反映的更改是否应用于次级
。应用的更改次数就是这两个值之间的差值（注意
Ndb_conflict_reflected_op_prepare_count始终大于或等于
Ndb_conflict_reflected_op_discard_count）。
当且仅当以下两个条件都为真时，才会应用事件：
该行的存在——即它是否存在——取决于事件的类型。对于删除和更新操作，该行必须已经存在。对于插入操作，该行不得存在
。
该行最后一次被主修改。修改可能是通过执行反射操作完成的。
如果这两个条件都不满足，则反射操作将被次级丢弃。
冲突解决例外表
要使用NDB$OLD()冲突解决功能，还需要为每个要使用这种冲突解决的表创建一个例外表NDB。使用NDB$EPOCH()or
时也是如此NDB$EPOCH_TRANS()。该表的名称是要对其应用冲突解决的表的名称，并$EX附加了字符串。（例如，如果原始表
mytable的名称为 ，则对应的异常表名称应为mytable$EX。）创建异常表的语法如下所示：
CREATE TABLE original_table$EX  (
[NDB$]server_id INT UNSIGNED,
[NDB$]source_server_id INT UNSIGNED,
[NDB$]source_epoch BIGINT UNSIGNED,
[NDB$]count INT UNSIGNED,
[NDB$OP_TYPE ENUM('WRITE_ROW','UPDATE_ROW', 'DELETE_ROW',
'REFRESH_ROW', 'READ_ROW') NOT NULL,]
[NDB$CFT_CAUSE ENUM('ROW_DOES_NOT_EXIST', 'ROW_ALREADY_EXISTS',
'DATA_IN_CONFLICT', 'TRANS_IN_CONFLICT') NOT NULL,]
[NDB$ORIG_TRANSID BIGINT UNSIGNED NOT NULL,]
original_table_pk_columns,
[orig_table_column|orig_table_column$OLD|orig_table_column$NEW,]
[additional_columns,]
PRIMARY KEY([NDB$]server_id, [NDB$]source_server_id, [NDB$]source_epoch, [NDB$]count)
) ENGINE=NDB;
前四列是必需的。前四列名称和与原表主键列匹配的列名称不重要；但是，出于清晰和一致性的原因，我们建议您对server_id、
source_server_id、
source_epoch和count
列使用此处显示的名称，并且对与原始表的主键中的列匹配的列使用与原始表中相同的名称。
如果例外表使用一个或多个可选列
NDB$OP_TYPE、
NDB$CFT_CAUSE或
NDB$ORIG_TRANSID在本节后面讨论，则每个必需的列也必须使用前缀 命名NDB$。如果需要，您可以使用NDB$前缀来命名所需的列，即使您没有定义任何可选列，但在这种情况下，所有四个必需的列都必须使用前缀来命名。
在这些列之后，构成原始表主键的列应按照它们用于定义原始表主键的顺序进行复制。与原始表的主键列重复的列的数据类型应与原始列的数据类型相同（或大于）。可以使用主键列的子集。
异常表必须使用
NDB存储引擎。NDB$OLD()（与例外表一起
使用的示例将在本节后面显示。）
可以选择在复制的主键列之后定义其他列，但不能在它们之前；任何此类额外的列都不能NOT NULL。NDB Cluster 支持三个额外的、预定义的可选列
NDB$OP_TYPE、
NDB$CFT_CAUSE和
NDB$ORIG_TRANSID，它们将在接下来的几段中进行描述。
NDB$OP_TYPE：此列可用于获取导致冲突的操作类型。如果您使用此列，请按此处所示定义它：
NDB$OP_TYPE ENUM('WRITE_ROW', 'UPDATE_ROW', 'DELETE_ROW',
'REFRESH_ROW', 'READ_ROW') NOT NULL
、WRITE_ROW和操作类型表示用户启动的操作UPDATE_ROW。
操作是在补偿事务中由冲突解决生成的操作，这些事务从检测到冲突的集群发送回原始集群。
操作是用排他行锁定义的用户启动的读取跟踪操作。
DELETE_ROWREFRESH_ROWREAD_ROW
NDB$CFT_CAUSE：您可以定义一个可选列NDB$CFT_CAUSE，它提供已注册冲突的原因。此列（如果使用）的定义如下所示：
NDB$CFT_CAUSE ENUM('ROW_DOES_NOT_EXIST', 'ROW_ALREADY_EXISTS',
'DATA_IN_CONFLICT', 'TRANS_IN_CONFLICT') NOT NULL
ROW_DOES_NOT_EXIST可以报​​告为原因UPDATE_ROW和
WRITE_ROW操作；
ROW_ALREADY_EXISTS可以报​​告
WRITE_ROW事件。
DATA_IN_CONFLICT当基于行的冲突函数检测到冲突时报告；
TRANS_IN_CONFLICT当事务冲突函数拒绝属于完整事务的所有操作时报告。
NDB$ORIG_TRANSID：该
NDB$ORIG_TRANSID列（如果使用）包含原始交易的 ID。此列应定义如下：
NDB$ORIG_TRANSID BIGINT UNSIGNED NOT NULL
NDB$ORIG_TRANSID是由 生成的 64 位值NDB。该值可用于关联属于来自相同或不同异常表的相同冲突事务的多个异常表条目。
不属于原始表主键的其他引用列可以命名为
colname$OLD或
colname$NEW。
colname$OLD
在更新和删除操作中引用旧值——即包含DELETE_ROW事件的操作。
colname$NEW可用于在插入和更新操作中引用新值——换句话说，操作使用
WRITE_ROW事件、
UPDATE_ROW事件或两种类型的事件。如果冲突操作没有为不是主键的给定引用列提供值，则异常表行包含NULL，或者为该列定义的默认值。
重要的
表是在建立复制数据表时读取的，所以在创建复制表之前mysql.ndb_replication，必须先插入复制表对应的行。
mysql.ndb_replication
冲突检测状态变量
几个状态变量可用于监控冲突​​检测。您可以从系统状态变量
NDB$EPOCH()的当前值查看自上次从该副本重新启动以来
发现有多少行发生冲突。Ndb_conflict_fn_epoch
Ndb_conflict_fn_epoch_trans
提供由 发现的直接冲突的行数NDB$EPOCH_TRANS()。
Ndb_conflict_fn_epoch2和
分别显示和
Ndb_conflict_fn_epoch2_trans
发现的冲突行数
。实际重新对齐的行数，包括那些由于与其他冲突行属于同一事务或依赖于相同事务而受到影响的行数，由 给出
。
NDB$EPOCH2()NDB$EPOCH2_TRANS()Ndb_conflict_trans_row_reject_count
另一个服务器状态变量
提供了
自上次
启动mysqld以来由于“最大时间戳获胜”Ndb_conflict_fn_max冲突解决而未在当前 SQL 节点上应用行的次数的计数。
提供已应用
基于结果的冲突解决方案的次数计数。Ndb_conflict_fn_max_del_winNDB$MAX_DELETE_WIN()
NDB 8.0.30 及更高版本提供
Ndb_conflict_fn_max_ins跟踪“更大的时间戳获胜”处理已应用于写操作的次数（使用NDB$MAX_INS()）；应用“相同时间戳获胜”处理写入
的次数（由 实现NDB$MAX_DEL_WIN_INS()）由状态变量提供
Ndb_conflict_fn_max_del_win_ins。
自上次重新启动给
定mysqld以来，由于“相同时间戳获胜”冲突解决
而未应用行的次数
由全局状态变量给出。除了递增之外
，未使用的行的主键被插入到
异常表中，如本节其他地方所述。
Ndb_conflict_fn_oldNdb_conflict_fn_old
另见第 23.4.3.9.3 节，“NDB Cluster 状态变量”。
例子
以下示例假设您已经有一个工作的 NDB Cluster 复制设置，如
第 23.7.5 节，“为复制准备 NDB Cluster”和
第 23.7.6 节，“启动 NDB Cluster 复制（单个复制通道）”中所述。
NDB$MAX() 示例。
假设您希望在表上启用“最大时间戳获胜”冲突解决
test.t1，使用列
mycol作为“时间戳”。这可以使用以下步骤完成：
确保您已经使用 启动
源
mysqld--ndb-log-update-as-write=OFF。
在源上，执行此
INSERT语句：
INSERT INTO mysql.ndb_replication
VALUES ('test', 't1', 0, NULL, 'NDB$MAX(mycol)');
笔记
如果该ndb_replication表尚不存在，则必须创建它。请参阅
ndb_replication 表。
向列中插入 0server_id表示访问此表的所有 SQL 节点都应使用冲突解决。如果只想对特定的mysqld使用冲突解决，请使用实际的服务器 ID。
插入NULL列
binlog_type与插入 0 ( ) 具有相同的效果NBT_DEFAULT；使用服务器默认值。
创建test.t1表：
CREATE TABLE test.t1 (
columns
mycol INT UNSIGNED,
columns
) ENGINE=NDB;
现在，当对该表执行更新时，将应用冲突解决方案，并将具有最大值的行的版本mycol写入副本。
笔记
应使用
( ) 等
其他binlog_type选项
来控制使用表而不是使用命令行选项在源上的日志记录。
NBT_UPDATED_ONLY_USE_UPDATE6ndb_replication
NDB$OLD() 示例。
假设NDB正在复制一个表，例如此处定义的表，并且您希望
为该表的更新
启用“相同的时间戳获胜”冲突解决方案：CREATE TABLE test.t2  (
a INT UNSIGNED NOT NULL,
b CHAR(25) NOT NULL,
columns,
mycol INT UNSIGNED NOT NULL,
columns,
PRIMARY KEY pk (a, b)
)   ENGINE=NDB;
需要按照所示顺序执行以下步骤：
首先，在创建
之前test.t2，您必须在表中插入一行
mysql.ndb_replication
，如下所示：
INSERT INTO mysql.ndb_replication
VALUES ('test', 't2', 0, 0, 'NDB$OLD(mycol)');binlog_type
该列的
可能值已在本节前面显示；在这种情况下，我们使用0指定使用服务器默认日志记录行为。该值
'NDB$OLD(mycol)'应插入conflict_fn列中。
为 .创建适当的异常表
test.t2。此处显示的表创建语句包括所有必需的列；必须在这些列之后和表的主键定义之前声明任何其他列。
CREATE TABLE test.t2$EX  (
server_id INT UNSIGNED,
source_server_id INT UNSIGNED,
source_epoch BIGINT UNSIGNED,
count INT UNSIGNED,
a INT UNSIGNED NOT NULL,
b CHAR(25) NOT NULL,
[additional_columns,]
PRIMARY KEY(server_id, source_server_id, source_epoch, count)
)   ENGINE=NDB;
我们可以包含额外的列，以获取有关给定冲突的类型、原因和原始事务 ID 的信息。我们也不需要为原始表中的所有主键列提供匹配列。这意味着您可以像这样创建例外表：
CREATE TABLE test.t2$EX  (
NDB$server_id INT UNSIGNED,
NDB$source_server_id INT UNSIGNED,
NDB$source_epoch BIGINT UNSIGNED,
NDB$count INT UNSIGNED,
a INT UNSIGNED NOT NULL,
NDB$OP_TYPE ENUM('WRITE_ROW','UPDATE_ROW', 'DELETE_ROW',
'REFRESH_ROW', 'READ_ROW') NOT NULL,
NDB$CFT_CAUSE ENUM('ROW_DOES_NOT_EXIST', 'ROW_ALREADY_EXISTS',
'DATA_IN_CONFLICT', 'TRANS_IN_CONFLICT') NOT NULL,
NDB$ORIG_TRANSID BIGINT UNSIGNED NOT NULL,
[additional_columns,]
PRIMARY KEY(NDB$server_id, NDB$source_server_id, NDB$source_epoch, NDB$count)
)   ENGINE=NDB;
笔记
四个必需的列需要前缀，因为我们在表定义
NDB$中至少包括了列NDB$OP_TYPE、
NDB$CFT_CAUSE或
之一。NDB$ORIG_TRANSID
test.t2如前所示
创建表。
对于您希望使用 执行冲突解决的每个表，都必须遵循这些步骤
NDB$OLD()。对于每个这样的表，在 中必须有一个对应的行mysql.ndb_replication，并且在与被复制的表相同的数据库中必须有一个异常表。
阅读冲突检测和解决。
NDB Cluster 还支持读取操作的跟踪，这使得在循环复制设置中可以管理一个集群中给定行的读取与另一个集群中同一行的更新或删除之间的冲突。此示例使用employee和
department表来模拟一个场景，在该场景中，员工从源集群（我们在下文中称为集群
A）上的一个部门转移到另一个部门，而副本集群（在下文中称为
B）更新员工前任的员工数量交错事务中的部门。
数据表是使用以下 SQL 语句创建的：
# Employee table
CREATE TABLE employee (
id INT PRIMARY KEY,
name VARCHAR(2000),
dept INT NOT NULL
)   ENGINE=NDB;
# Department table
CREATE TABLE department (
id INT PRIMARY KEY,
name VARCHAR(2000),
members INT
)   ENGINE=NDB;
两个表的内容包括以下
SELECT语句的（部分）输出中显示的行：
mysql> SELECT id, name, dept FROM employee;
+---------------+------+
| id   | name   | dept |
+------+--------+------+
...
| 998  |  Mike  | 3    |
| 999  |  Joe   | 3    |
| 1000 |  Mary  | 3    |
...
+------+--------+------+
mysql> SELECT id, name, members FROM department;
+-----+-------------+---------+
| id  | name        | members |
+-----+-------------+---------+
...
| 3   | Old project | 24      |
...
+-----+-------------+---------+
我们假设我们已经在使用一个异常表，其中包括四个必需的列（这些列用于该表的主键）、操作类型和原因的可选列，以及使用 SQL 语句创建的原始表的主键列显示在这里：
CREATE TABLE employee$EX  (
NDB$server_id INT UNSIGNED,
NDB$source_server_id INT UNSIGNED,
NDB$source_epoch BIGINT UNSIGNED,
NDB$count INT UNSIGNED,
NDB$OP_TYPE ENUM( 'WRITE_ROW','UPDATE_ROW', 'DELETE_ROW',
'REFRESH_ROW','READ_ROW') NOT NULL,
NDB$CFT_CAUSE ENUM( 'ROW_DOES_NOT_EXIST',
'ROW_ALREADY_EXISTS',
'DATA_IN_CONFLICT',
'TRANS_IN_CONFLICT') NOT NULL,
id INT NOT NULL,
PRIMARY KEY(NDB$server_id, NDB$source_server_id, NDB$source_epoch, NDB$count)
)   ENGINE=NDB;
假设在两个集群上同时发生了两个事务。在集群A上，我们创建一个新部门，然后使用以下 SQL 语句将员工编号 999 移动到该部门：
BEGIN;
INSERT INTO department VALUES (4, "New project", 1);
UPDATE employee SET dept = 4 WHERE id = 999;
COMMIT;
同时，在集群B上，另一个事务从 读取employee，如下所示：
BEGIN;
SELECT name FROM employee WHERE id = 999;
UPDATE department SET members = members - 1  WHERE id = 3;
commit;
冲突事务通常不会被冲突解决机制检测到，因为冲突发生在读取 ( SELECT) 和更新操作之间。您可以通过在副本集群上执行来规避此问题
。以这种方式获取独占读锁会导致在源上读取的任何行都被标记为需要在副本集群上解决冲突。如果我们在记录这些事务之前以这种方式启用独占读取，那么集群
B上的读取将被跟踪并发送到集群
A进行解析；随后检测到员工行上的冲突，并中止
集群B上的事务。SET
ndb_log_exclusive_reads
= 1
冲突在异常表（在集群
A上）中注册为READ_ROW
操作（请参阅
冲突解决异常表，了解操作类型的说明），如下所示：
mysql> SELECT id, NDB$OP_TYPE, NDB$CFT_CAUSE FROM employee$EX;
+-------+-------------+-------------------+
| id    | NDB$OP_TYPE | NDB$CFT_CAUSE     |
+-------+-------------+-------------------+
...
| 999   | READ_ROW    | TRANS_IN_CONFLICT |
+-------+-------------+-------------------+
在读取操作中找到的任何现有行都会被标记。这意味着由同一冲突产生的多行可能会记录在异常表中，如检查集群A上的更新
与同时事务中从同一表读取集群B
上的多行之间的冲突所产生的影响所示。在集群A上执行的事务如下所示：
BEGIN;
INSERT INTO department VALUES (4, "New project", 0);
UPDATE employee SET dept = 4 WHERE dept = 3;
SELECT COUNT(*) INTO @count FROM employee WHERE dept = 4;
UPDATE department SET members = @count WHERE id = 4;
COMMIT;
同时，包含此处所示语句的事务在集群B上运行：
SET ndb_log_exclusive_reads = 1;  # Must be set if not already enabled
...
BEGIN;
SELECT COUNT(*) INTO @count FROM employee WHERE dept = 3 FOR UPDATE;
UPDATE department SET members = @count WHERE id = 3;
COMMIT;WHERE在这种情况下，将读取与第二个事务中的条件
匹配的所有三行
SELECT，并因此在异常表中进行标记，如下所示：
mysql> SELECT id, NDB$OP_TYPE, NDB$CFT_CAUSE FROM employee$EX;
+-------+-------------+-------------------+
| id    | NDB$OP_TYPE | NDB$CFT_CAUSE     |
+-------+-------------+-------------------+
...
| 998   | READ_ROW    | TRANS_IN_CONFLICT |
| 999   | READ_ROW    | TRANS_IN_CONFLICT |
| 1000  | READ_ROW    | TRANS_IN_CONFLICT |
...
+-------+-------------+-------------------+
读取跟踪仅在现有行的基础上执行。基于给定条件的读取跟踪只会与找到的任何行发生冲突，而不会与插入到交错事务中的任何行发生冲突。这类似于在 NDB Cluster 的单个实例中执行排他行锁定的方式。
插入冲突检测和解决示例（NDB 8.0.30 及更高版本）。
以下示例说明了 NDB 8.0.30 中添加的插入冲突检测功能的使用。我们假设我们正在复制数据库中的两个表t1和
，并且我们希望对for和
for
使用插入冲突检测
。这两个数据表直到稍后的设置过程才被创建。
t2testNDB$MAX_INS()t1NDB$MAX_DEL_WIN_INS()t2
设置插入冲突解决方案类似于设置其他冲突检测和解决算法，如前面的示例所示。如果
mysql.ndb_replication用于配置二进制日志记录和冲突解决的表尚不存在，则首先需要创建它，如下所示：
CREATE TABLE mysql.ndb_replication (
db VARBINARY(63),
table_name VARBINARY(63),
server_id INT UNSIGNED,
binlog_type INT UNSIGNED,
conflict_fn VARBINARY(128),
PRIMARY KEY USING HASH (db, table_name, server_id)
) ENGINE=NDB
PARTITION BY KEY(db,table_name);
该ndb_replication表以每个表为基础；也就是说，我们需要为每个要建立的表插入一行，包含表信息、一个binlog_type值、要使用的冲突解决函数和时间戳列的名称（X），如下所示：
INSERT INTO mysql.ndb_replication VALUES ("test", "t1", 0, 7, "NDB$MAX_INS(X)");
INSERT INTO mysql.ndb_replication VALUES ("test", "t2", 0, 7, "NDB$MAX_DEL_WIN_INS(X)");
这里我们将 binlog_type 设置为
NBT_FULL_USE_UPDATE( 7)，这意味着总是记录完整的行。有关其他可能的值，
请参阅
ndb_replication Table 。
您还可以创建一个例外表
，该表与NDB要使用冲突解决的每个表相对应。异常表记录了给定表的冲突解决函数拒绝的所有行。用于表的复制冲突检测的异常表
t1，t2可以使用以下两条 SQL 语句创建：
CREATE TABLE `t1$EX` (
NDB$server_id INT UNSIGNED,
NDB$master_server_id INT UNSIGNED,
NDB$master_epoch BIGINT UNSIGNED,
NDB$count INT UNSIGNED,
NDB$OP_TYPE ENUM('WRITE_ROW', 'UPDATE_ROW', 'DELETE_ROW',
'REFRESH_ROW', 'READ_ROW') NOT NULL,
NDB$CFT_CAUSE ENUM('ROW_DOES_NOT_EXIST', 'ROW_ALREADY_EXISTS',
'DATA_IN_CONFLICT', 'TRANS_IN_CONFLICT') NOT NULL,
a INT NOT NULL,
PRIMARY KEY(NDB$server_id, NDB$master_server_id,
NDB$master_epoch, NDB$count)
) ENGINE=NDB;
CREATE TABLE `t2$EX` (
NDB$server_id INT UNSIGNED,
NDB$master_server_id INT UNSIGNED,
NDB$master_epoch BIGINT UNSIGNED,
NDB$count INT UNSIGNED,
NDB$OP_TYPE ENUM('WRITE_ROW', 'UPDATE_ROW', 'DELETE_ROW',
'REFRESH_ROW', 'READ_ROW') NOT NULL,
NDB$CFT_CAUSE ENUM( 'ROW_DOES_NOT_EXIST', 'ROW_ALREADY_EXISTS',
'DATA_IN_CONFLICT', 'TRANS_IN_CONFLICT') NOT NULL,
a INT NOT NULL,
PRIMARY KEY(NDB$server_id, NDB$master_server_id,
NDB$master_epoch, NDB$count)
) ENGINE=NDB;
最后，在创建了刚刚显示的异常表之后，您可以使用以下两条SQL语句来创建要复制并受冲突解决控制的数据表：
CREATE TABLE t1 (
a INT PRIMARY KEY,
b VARCHAR(32),
X INT UNSIGNED
) ENGINE=NDB;
CREATE TABLE t2 (
a INT PRIMARY KEY,
b VARCHAR(32),
X INT UNSIGNED
) ENGINE=NDB;
对于每个表，该X列用作时间戳列。
一旦在源上创建，就会被复制，t1并且
t2可以假定在源和副本上都存在。在此示例的其余部分，我们使用mysqlS>来指示
连接到源
的mysqlmysqlR>客户端，并指示
在副本上运行
的mysql客户端。
首先，我们在源上的表中各插入一行，如下所示：
mysqlS> INSERT INTO t1 VALUES (1, 'Initial X=1', 1);
Query OK, 1 row affected (0.01 sec)
mysqlS> INSERT INTO t2 VALUES (1, 'Initial X=1', 1);
Query OK, 1 row affected (0.01 sec)
我们可以确定这两行在没有引起任何冲突的情况下被复制，因为在
INSERT源上发出语句之前副本上的表不包含任何行。我们可以通过从副本上的表中进行选择来验证这一点，如下所示：
mysqlR> TABLE t1 ORDER BY a;
+---+-------------+------+
| a | b           | X    |
+---+-------------+------+
| 1 | Initial X=1 |    1 |
+---+-------------+------+
1 row in set (0.00 sec)
mysqlR> TABLE t2 ORDER BY a;
+---+-------------+------+
| a | b           | X    |
+---+-------------+------+
| 1 | Initial X=1 |    1 |
+---+-------------+------+
1 row in set (0.00 sec)
接下来，我们将新行插入到副本上的表中，如下所示：
mysqlR> INSERT INTO t1 VALUES (2, 'Replica X=2', 2);
Query OK, 1 row affected (0.01 sec)
mysqlR> INSERT INTO t2 VALUES (2, 'Replica X=2', 2);
Query OK, 1 row affected (0.01 sec)
现在我们使用此处显示的语句将冲突行插入到源上具有更大 timestamp ( X) 列值的表中：
mysqlS> INSERT INTO t1 VALUES (2, 'Source X=20', 20);
Query OK, 1 row affected (0.01 sec)
mysqlS> INSERT INTO t2 VALUES (2, 'Source X=20', 20);
Query OK, 1 row affected (0.01 sec)
现在我们通过从副本上的两个表中（再次）选择来观察结果，如下所示：
mysqlR> TABLE t1 ORDER BY a;
+---+-------------+-------+
| a | b           | X     |
+---+-------------+-------+
| 1 | Initial X=1 |    1  |
+---+-------------+-------+
| 2 | Source X=20 |   20  |
+---+-------------+-------+
2 rows in set (0.00 sec)
mysqlR> TABLE t2 ORDER BY a;
+---+-------------+-------+
| a | b           | X     |
+---+-------------+-------+
| 1 | Initial X=1 |    1  |
+---+-------------+-------+
| 1 | Source X=20 |   20  |
+---+-------------+-------+
2 rows in set (0.00 sec)
在源上插入的行具有比副本上冲突行中的时间戳更大的行，这些行已替换了那些行。在副本上，我们接下来插入两个新行，它们不与t1or
中的任何现有行冲突t2，如下所示：
mysqlR> INSERT INTO t1 VALUES (3, 'Slave X=30', 30);
Query OK, 1 row affected (0.01 sec)
mysqlR> INSERT INTO t2 VALUES (3, 'Slave X=30', 30);
Query OK, 1 row affected (0.01 sec)
在源上插入更多具有相同主键值 ( 3) 的行会像以前一样带来冲突，但是这次我们使用的时间戳列的值小于副本上冲突行中同一列中的值。
mysqlS> INSERT INTO t1 VALUES (3, 'Source X=3', 3);
Query OK, 1 row affected (0.01 sec)
mysqlS> INSERT INTO t2 VALUES (3, 'Source X=3', 3);
Query OK, 1 row affected (0.01 sec)
我们通过查询表可以看到，来自源的两次插入都被副本拒绝，并且之前插入到副本的行没有被覆盖，如副本上的mysql客户端所示：
mysqlR> TABLE t1 ORDER BY a;
+---+--------------+-------+
| a | b            | X     |
+---+--------------+-------+
| 1 |  Initial X=1 |    1  |
+---+--------------+-------+
| 2 |  Source X=20 |   20  |
+---+--------------+-------+
| 3 | Replica X=30 |   30  |
+---+--------------+-------+
3 rows in set (0.00 sec)
mysqlR> TABLE t2 ORDER BY a;
+---+--------------+-------+
| a | b            | X     |
+---+--------------+-------+
| 1 |  Initial X=1 |    1  |
+---+--------------+-------+
| 2 |  Source X=20 |   20  |
+---+--------------+-------+
| 3 | Replica X=30 |   30  |
+---+--------------+-------+
3 rows in set (0.00 sec)
您可以在异常表中查看有关被拒绝的行的信息，如下所示：
mysqlR> SELECT  NDB$server_id, NDB$master_server_id, NDB$count,
>         NDB$OP_TYPE, NDB$CFT_CAUSE, a
> FROM t1$EX
> ORDER BY NDB$count\G
*************************** 1. row ***************************
NDB$server_id       : 2
NDB$master_server_id: 1
NDB$count           : 1
NDB$OP_TYPE         : WRITE_ROW
NDB$CFT_CAUSE       : DATA_IN_CONFLICT
a                   : 3
1 row in set (0.00 sec)
mysqlR> SELECT  NDB$server_id, NDB$master_server_id, NDB$count,
>         NDB$OP_TYPE, NDB$CFT_CAUSE, a
> FROM t2$EX
> ORDER BY NDB$count\G
*************************** 1. row ***************************
NDB$server_id       : 2
NDB$master_server_id: 1
NDB$count           : 1
NDB$OP_TYPE         : WRITE_ROW
NDB$CFT_CAUSE       : DATA_IN_CONFLICT
a                   : 3
1 row in set (0.00 sec)
正如我们之前看到的，插入到源上的其他行没有被副本拒绝，只有那些具有比副本上冲突的行更小的时间戳值的行。
© Mysql 中文网
