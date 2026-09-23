# CREATE SUBSCRIPTION

CREATE SUBSCRIPTION
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE SUBSCRIPTIONCREATE SUBSCRIPTION — 定义一个新的订阅大纲
CREATE SUBSCRIPTION subscription_name
CONNECTION 'conninfo'
PUBLICATION publication_name [, ...]
[ WITH ( subscription_parameter [= value] [, ... ] ) ]
描述
CREATE SUBSCRIPTION 添加一个新的逻辑复制订阅。创建订阅的用户
成为该订阅的所有者。订阅名称必须与当前数据库中任何现有订阅的名称不同。
订阅表示与发布者的复制连接。因此，除了在本地目录中添加定义外，该命令通常会在发布者上创建一个复制槽。
逻辑复制工作者将在运行此命令的事务提交时开始为新订阅复制数据，除非订阅最初被禁用。
要能够创建订阅，您必须拥有pg_create_subscription角色的权限，
以及当前数据库上的CREATE权限。
关于订阅和逻辑复制的更多信息，请参见
第 29.2 节和
第 29 章。
参数subscription_name #
新订阅的名称。
CONNECTION 'conninfo' #
定义如何连接到发布者数据库的libpq连接字符串。有关详细信息，请参见第 32.1.1 节。
PUBLICATION publication_name [, ...] #
要订阅的发布者上的发布名称。
WITH ( subscription_parameter [= value] [, ... ] ) #
本条款指定了订阅的可选参数。
以下参数控制订阅创建期间发生的操作：
connect (boolean) #
指定CREATE SUBSCRIPTION命令是否应当连接到发布者。默认值是
true。将此设置为false将强制
create_slot、enabled和
copy_data的值为false。
（不能将connect设置为false，同时将
create_slot、enabled或
copy_data设置为true。）
由于当此选项为false时不会建立连接，因此不会订阅任何表。
要启动复制，您必须手动创建复制槽，必要时启用故障转移，启用订阅，
并刷新订阅。详见
第 29.2.3 节
了解示例。
create_slot (boolean) #
指定命令是否应在发布者上创建复制槽。默认值是true。
如果设置为false，则您需要以其他方式负责创建发布者的槽。
参见第 29.2.3 节
了解示例。
enabled (boolean) #
指定订阅是应当主动复制，还是仅设置但尚未启动。默认值是
true。
slot_name (string) #
要使用的发布者复制槽的名称。默认情况下，复制槽名称使用订阅的名称。
将 slot_name 设置为 NONE 表示不会有与订阅相关联的复制槽。
这样的订阅还必须将 enabled 和 create_slot 都设置为
false。当您稍后将手动创建复制槽时，请使用此选项。请参见
第 29.2.3 节
了解示例。
当将 slot_name 设置为有效名称并将
create_slot 设置为 false 时，
指定槽的 failover 属性值可能与订阅中
指定的对应 failover 参数不同。始终确保
槽属性 failover 与订阅的对应参数匹配，
反之亦然。否则，发布者上的槽可能会与这些订阅选项
所述的行为不同：例如，即使订阅的 failover
选项被禁用，发布者上的槽也可能与备用同步，或者即使
订阅的 failover 选项被启用，槽也可能
被禁用以进行同步。
以下参数控制订阅创建后其复制行为：
binary (boolean) #
指定订阅是否请求发布者以二进制格式（而不是文本格式）发送数据。默认值为
false。任何初始表同步副本（参见copy_data）
也使用相同的格式。二进制格式可能比文本格式更快，但在不同的机器架构和
PostgreSQL版本之间的可移植性较差。二进制格式对数据
类型非常具体；例如，它不允许从smallint列复制到
integer列，即使在文本格式下这可以正常工作。即使启用了此选项，
只有具有二进制发送和接收函数的数据类型才会以二进制方式传输。请注意，
初始同步要求所有数据类型都具有二进制发送和接收函数，否则同步将失败
（参见CREATE TYPE以了解更多关于发送/接收函数的信息）。
在进行跨版本复制时，可能出现这样的情况：发布者对某种数据类型有二进制发送功能，但订阅者缺乏该类型的二进制接收功能。
在这种情况下，数据传输将失败，且binary选项无法使用。
如果发布者是PostgreSQL 16版本之前的版本，
那么即使binary = true，任何初始表同步也将使用文本格式。
copy_data (boolean) #
指定在复制开始时是否复制正在订阅的发布中的预先存在的数据。
默认值为true。
如果发布包含WHERE子句，它将影响复制的数据。请参考
Notes获取详细信息。
请参阅Notes了解
copy_data = true如何与
origin参数交互的详细信息。
streaming (enum) #
指定是否启用此订阅的进行中事务的流式传输。
默认值为 parallel，这意味着传入的更改
直接通过可用的并行应用工作线程应用。如果没有可用的
并行应用工作线程来处理流式事务，则更改将写入临时
文件，并在事务提交后应用。请注意，如果并行应用工作
线程发生错误，远程事务的完成 LSN 可能不会在服务器
日志中报告。
小心
当发布者和订阅者的模式不同时，存在死锁的风险，
尽管这种情况很少见。应用工作线程能够自动重试
这些事务。
如果设置为on，传入的更改将被写入临时文件，
并且只有在发布者提交事务并由订阅者接收后才会应用。
如果设置为 off，则所有事务将在发布者
上完全解码，然后作为整体发送给订阅者。
synchronous_commit (enum) #
此参数的值将覆盖此订阅的应用工作进程中的
synchronous_commit设置。默认值为
off。
使用 off 对于逻辑复制是安全的：
如果订阅者由于缺少同步而丢失事务，则数据将再次从发布者发送。
在进行同步逻辑复制时，可能需要使用不同的设置。逻辑复制工作者会向发布者报告写入和刷新的位置，
在使用同步复制时，发布者将等待实际的刷新。这意味着当订阅用于同步复制时，将订阅者的
synchronous_commit设置为 off 可能会增加发布者上
COMMIT的延迟。在这种情况下，将 synchronous_commit
设置为 local 或更高可能是有利的。
two_phase (boolean) #
指定是否为此订阅启用两阶段提交。默认值为 false。
当启用两阶段提交时，准备好的事务会在 PREPARE
TRANSACTION 时发送给订阅者，
并在订阅者上也作为两阶段事务处理。否则，准备好的事务只有在提交时才会发送给
订阅者，然后由订阅者立即处理。
两阶段提交的实现要求复制已成功完成初始表同步阶段。因此，即使为订阅启用了two_phase，
内部的两阶段状态仍会暂时保持“挂起”，直到初始化阶段完成。
参见列subtwophasestate的pg_subscription，
以了解实际的两阶段状态。
disable_on_error (boolean) #
指定是否应在发布者进行数据复制期间，如果订阅工作者检测到任何错误，则自动禁用订阅。默认值为
false。
password_required (boolean) #
如果设置为true，则由于此订阅建立的与发布者的连接
必须使用密码认证，并且密码必须作为连接字符串的一部分指定。当订阅
由超级用户拥有时，此设置将被忽略。默认值为true。
只有超级用户可以将此值设置为false。
run_as_owner (boolean) #
如果为 true，所有复制操作都将以订阅者的身份执行。如果为 false，
复制工作者将在每个表上以该表的所有者身份执行操作。后一种配置通常
更加安全；详情请参见
第 29.11 节。
默认值为 false。
origin (string) #
指定订阅是否会请求发布者仅发送没有来源的更改，或者无论来源如何都发送
更改。将origin设置为none表示订阅会请求
发布者仅发送没有来源的更改。将origin设置为any
表示发布者会发送无论来源如何的更改。默认值是any。
请参阅Notes了解
copy_data = true如何与
origin参数交互的详细信息。
failover (boolean) #
指定与订阅关联的复制槽是否启用同步到备用节点，以便在故障切换后
可以从新的主节点恢复逻辑复制。默认值是false。
当指定类型为boolean的参数时，
=value
部分可以省略，这等同于指定TRUE。
备注
有关如何在订阅和发布实例之间配置访问控制的详细信息，请参见
第 29.11 节。
创建复制槽时（默认行为），CREATE
SUBSCRIPTION不能在事务块内部执行。
创建一个连接到同一数据库集群的订阅（例如，在同一集群中的数据库之间
进行复制或在同一数据库内进行复制）只有在复制槽未作为同一命令的一部分
创建时才会成功。否则，CREATE SUBSCRIPTION 调用将会挂起。
为了使其正常工作，请单独创建复制槽（使用函数
pg_create_logical_replication_slot，插件名称为
pgoutput），并使用参数
create_slot = false 创建订阅。请参阅
第 29.2.3 节
以获取示例。这是一个实现限制，可能会在未来的版本中解除。
如果发布中的任何表具有 WHERE 子句，则
对于 expression
计算为 false 或 NULL 的行
将不会被发布。如果订阅有多个发布，其中同一表以
不同的 WHERE 子句发布，则如果满足任何
表达式（指代该发布操作），则该行将被发布。在不同的
WHERE 子句的情况下，如果其中一个发布
没有 WHERE 子句（指代该发布操作），
或该发布声明为
FOR ALL TABLES
或 FOR TABLES IN SCHEMA，
则无论其他表达式的定义如何，行始终会被发布。如果订阅者
是 PostgreSQL 15 之前的版本，
则在初始数据同步阶段会忽略任何行过滤。在这种情况下，
用户可能需要考虑删除任何与后续过滤不兼容的初始复制
数据。因为初始数据同步在复制现有表数据时不考虑发布
publish
参数，所以可能会复制一些在使用 DML 时不会被复制的行。
请参见 第 29.2.2 节 以获取示例。
具有多个发布的订阅，其中同一表以不同的列列表发布，不受支持。
我们允许指定不存在的发布，以便用户稍后添加。这意味着
pg_subscription
可以有不存在的发布。
当使用订阅参数组合copy_data = true和
origin = NONE时，初始同步表数据直接从发布者复制，
这意味着无法得知这些数据的真正来源。如果发布者也有订阅，那么复制的
表数据可能来自更上游的来源。此场景会被检测到，并向用户记录一条
WARNING，但该警告仅是潜在问题的提示；用户有责任进行必要的检查，
以确保复制的数据来源确实符合预期。
要查找哪些表可能包含非本地来源（由于发布者上创建的其他订阅），请尝试此SQL查询：
# substitute <pub-names> below with your publication name(s) to be queried
SELECT DISTINCT PT.schemaname, PT.tablename
FROM pg_publication_tables PT
JOIN pg_class C ON (C.relname = PT.tablename)
JOIN pg_namespace N ON (N.nspname = PT.schemaname),
pg_subscription_rel PS
WHERE C.relnamespace = N.oid AND
(PS.srrelid = C.oid OR
C.oid IN (SELECT relid FROM pg_partition_ancestors(PS.srrelid) UNION
SELECT relid FROM pg_partition_tree(PS.srrelid))) AND
PT.pubname IN (<pub-names>);
示例
创建一个到远程服务器的订阅，复制发布mypublication和
insert_only中的表，并在提交时立即开始复制：
CREATE SUBSCRIPTION mysub
CONNECTION 'host=192.168.1.50 port=5432 user=foo dbname=foodb'
PUBLICATION mypublication, insert_only;
创建一个到远程服务器的订阅，复制insert_only发布中的表，
并且不开始复制直到稍后启用。
CREATE SUBSCRIPTION mysub
CONNECTION 'host=192.168.1.50 port=5432 user=foo dbname=foodb'
PUBLICATION insert_only
WITH (enabled = false);
兼容性
CREATE SUBSCRIPTION是一个PostgreSQL
扩展。
另见ALTER SUBSCRIPTION, DROP SUBSCRIPTION, CREATE PUBLICATION, ALTER PUBLICATION上一页 上一级 下一页CREATE STATISTICS 起始页 CREATE TABLE
