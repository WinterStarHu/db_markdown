# 47.6. 逻辑解码输出插件

47.6. 逻辑解码输出插件
版本：
纠错本页面
搜索
目录导航
❮
❯
47.6. 逻辑解码输出插件 #47.6.1. 初始化函数47.6.2. 能力47.6.3. 输出模式47.6.4. 输出插件回调47.6.5. 输出生成函数
可以在 PostgreSQL 源码树的
contrib/test_decoding
子目录中找到一个输出插件的例子。
47.6.1. 初始化函数 #
输出插件通过动态加载一个共享库来加载，该共享库的名称以输出插件的名称
作为库的基本名称。使用正常的库搜索路径来定位库。为了提供所需的输出插件
回调并表明该库实际上是一个输出插件，它需要提供一个名为
_PG_output_plugin_init的函数。此函数接收一个结构体，
该结构体需要填充用于各个操作的回调函数指针。
typedef struct OutputPluginCallbacks
{
LogicalDecodeStartupCB startup_cb;
LogicalDecodeBeginCB begin_cb;
LogicalDecodeChangeCB change_cb;
LogicalDecodeTruncateCB truncate_cb;
LogicalDecodeCommitCB commit_cb;
LogicalDecodeMessageCB message_cb;
LogicalDecodeFilterByOriginCB filter_by_origin_cb;
LogicalDecodeShutdownCB shutdown_cb;
LogicalDecodeFilterPrepareCB filter_prepare_cb;
LogicalDecodeBeginPrepareCB begin_prepare_cb;
LogicalDecodePrepareCB prepare_cb;
LogicalDecodeCommitPreparedCB commit_prepared_cb;
LogicalDecodeRollbackPreparedCB rollback_prepared_cb;
LogicalDecodeStreamStartCB stream_start_cb;
LogicalDecodeStreamStopCB stream_stop_cb;
LogicalDecodeStreamAbortCB stream_abort_cb;
LogicalDecodeStreamPrepareCB stream_prepare_cb;
LogicalDecodeStreamCommitCB stream_commit_cb;
LogicalDecodeStreamChangeCB stream_change_cb;
LogicalDecodeStreamMessageCB stream_message_cb;
LogicalDecodeStreamTruncateCB stream_truncate_cb;
} OutputPluginCallbacks;
typedef void (*LogicalOutputPluginInit) (struct OutputPluginCallbacks *cb);
begin_cb、change_cb和
commit_cb回调是必需的，而startup_cb、
truncate_cb、message_cb、
filter_by_origin_cb和shutdown_cb
是可选的。如果truncate_cb未设置，但需要解码
TRUNCATE操作，则该操作将被忽略。
输出插件还可以定义函数以支持大型、进行中事务的流式传输。
stream_start_cb、stream_stop_cb、
stream_abort_cb、stream_commit_cb 和
stream_change_cb 是必需的，而 stream_message_cb
和 stream_truncate_cb 是可选的。如果输出插件还支持两阶段提交，
则 stream_prepare_cb 也是必需的。
输出插件还可以定义支持两阶段提交的函数，这允许在
PREPARE TRANSACTION上解码操作。
需要提供begin_prepare_cb、
prepare_cb、commit_prepared_cb
和rollback_prepared_cb回调，而
filter_prepare_cb是可选的。
如果输出插件还支持大型进行中事务的流式传输，
则stream_prepare_cb也是必需的。
47.6.2. 能力 #
要解码、格式化并且输出更改，输出插件可以使用大部分后端的标准功能，包括调用
输出函数。只要访问的关系是initdb在
pg_catalog模式中创建的或者被使用
ALTER TABLE user_catalog_table SET (user_catalog_table = true);
CREATE TABLE another_catalog_table(data text) WITH (user_catalog_table = true);
注意要访问输出插件中的用户目录表或常规系统目录表，只能通过systable_* 扫描 APIs完成。
通过heap_* 扫描 APIs访问将出错。
此外，任何导致事务 ID 分配的动作都被禁止。
其中包括写表、执行 DDL 更改以及调用pg_current_xact_id()。
47.6.3. 输出模式 #
输出插件回调可以以近乎任意格式向消费者传递数据。对于某些用例，例如通过 SQL
查看更改，以可能包含任何数据的数据类型（例如bytea）返回数据
可能会很麻烦。如果输出插件只输出服务器编码的文本数据，它可以在
启动回调中通过把OutputPluginOptions.output_type设
置为OUTPUT_PLUGIN_TEXTUAL_OUTPUT替代
OUTPUT_PLUGIN_BINARY_OUTPUT来声明这一点。在这种情况下，
所有的数据必须是服务器的编码，这样一个text数据就能包含它。在
启用了断言的编译中会检查这一点。
47.6.4. 输出插件回调 #
一个输出插件需要提供一些回调，它通过它们得到有关更改发生的通知。
并发事务以提交顺序被解码，并且只有属于特定事务的更改会在 begin和commit回调之间被解码。
被显式或隐式回滚的事务不会被解码。
成功的保存点被折叠到包含它们的事务中，并且保持它们在该事务中被执行的顺序。
如果提供了解码它们所需要的输出插件回调，那么使用PREPARE TRANSACTION为两阶段提交准备的事务也将被解码。
有可能通过ROLLBACK PREPARED命令并发地中止正在解码的当前准备好的事务。
在这种情况下，该事务的逻辑解码也将被中止。
一旦检测到中止并且调用prepare_cb回调，就会跳过此事务的所有更改。
因此即使在并发中止的情况下，也会向输出插件提供足够的信息，以便一旦解码后它可以正确应对ROLLBACK PREPARED。
注意
只有已经被安全地刷入磁盘的事务将会被解码。当
synchronous_commit被设置为off
时，这会导致一个COMMIT在随后的
pg_logical_slot_get_changes()中不会立即被解码。
47.6.4.1. 启动回调 #
只要一个复制槽被创建或者被要求流式传送更改，可选的
startup_cb回调就会被调用，不管有多少更改准备输出。
typedef void (*LogicalDecodeStartupCB) (struct LogicalDecodingContext *ctx,
OutputPluginOptions *options,
bool is_init);
当复制槽被创建时，is_init参数将为真，否则为假。
options指向一个输出插件可以设置的选项
的结构：
typedef struct OutputPluginOptions
{
OutputPluginOutputType output_type;
bool        receive_rewrites;
} OutputPluginOptions;
output_type必须被设置为
OUTPUT_PLUGIN_TEXTUAL_OUTPUT
或OUTPUT_PLUGIN_BINARY_OUTPUT。另见
第 47.6.3 节。如果receive_rewrites为真，还将为在某些DDL操作期间的堆重写造成的更改调用输出插件。这些是处理DDL复制的插件感兴趣的事情，但是它们要求特殊的处理。
启动回调应该验证出现在
ctx->output_plugin_options中的选项。如果输出插件
需要有一个状态，它可以使用
ctx->output_plugin_private来存储之。
47.6.4.2. 关闭回调 #
只要一个之前活跃的复制槽不再使用，就会调用可选的
shutdown_cb回调，它可以被用来释放输出插件
私有的资源。该槽并不一定需要被删除，只要其中的流被停止就可以。
typedef void (*LogicalDecodeShutdownCB) (struct LogicalDecodingContext *ctx);
47.6.4.3. 事务开始回调 #
只要一个已提交事务的开始动作被解码，就会调用必须提供的
begin_cb回调。被中止的事务及其内容不会被解码。
typedef void (*LogicalDecodeBeginCB) (struct LogicalDecodingContext *ctx,
ReorderBufferTXN *txn);
txn参数包含有关该事务的元信息，例如该
事务被提交的时间戳以及该事务的XID。
47.6.4.4. 事务结束回调 #
只要一个已提交事务的提交动作被解码，就会调用必须提供的
commit_cb回调。在此之前，如果有任何被修改
的行，将为所有被修改的行调用change_cb回调。
typedef void (*LogicalDecodeCommitCB) (struct LogicalDecodingContext *ctx,
ReorderBufferTXN *txn,
XLogRecPtr commit_lsn);
47.6.4.5. 变更回调 #
对于一个事务中的每一个行修改，都将调用必须提供的change_cb回调，这种修改可能是一个INSERT、UPDATE或者DELETE。
即使原始命令一次修改了多行，该回调也会为其中的每一行调用一次。
change_cb回调可以访问系统或用户目录表，以帮助输出行修改细节的过程。
在解码一个准备好的(但仍未提交)事务或解码一个未提交的事务的情况下，这个更改回调也可能由于同时回滚这一相同事务而出错。
在这种情况下，对这个中止事务的逻辑解码被优雅地停止。
typedef void (*LogicalDecodeChangeCB) (struct LogicalDecodingContext *ctx,
ReorderBufferTXN *txn,
Relation relation,
ReorderBufferChange *change);
ctx和txn参数与
begin_cb和commit_cb
回调具有相同的内容，但是额外多出一个关系描述符
relation指向该行所属的关系以及一个结构
change描述被传入的行修改。
注意
只有没有被标记为“未记录”（见
UNLOGGED）并且非临时（见
TEMPORARY or TEMP）的用户定义表中的
更改才能用逻辑解码抽取。
47.6.4.6. 截断回调 #
可选的truncate_cb回调函数会在
TRUNCATE命令时被调用。
typedef void (*LogicalDecodeTruncateCB) (struct LogicalDecodingContext *ctx,
ReorderBufferTXN *txn,
int nrelations,
Relation relations[],
ReorderBufferChange *change);
参数与change_cb回调函数类似。然而，由于
TRUNCATE操作需要对通过外键连接的表一起执行，
此回调函数接收的是一个关系数组，而不是单个关系。
有关详细信息，请参阅TRUNCATE语句的描述。
47.6.4.7. 源过滤器回调 #
可选的filter_by_origin_cb回调被用来
决定从origin_id重放的数据是否是
输出插件感兴趣的数据。
typedef bool (*LogicalDecodeFilterByOriginCB) (struct LogicalDecodingContext *ctx,
RepOriginId origin_id);
ctx参数具有和其他回调相同的内容。
对这个回调只有复制源的信息可用。要标志传进来的节点上发生的
更改是无关的，返回true，这会导致这些更改被过滤掉；否则返回false。
对于被过滤掉的事务和更改将不会调用其他回调。
在实现级联或者多向复制方案时，这个回调可以派上用场。用源头
过滤允许阻止在这样的设置下来回地复制同样的更改。虽然事务和
更改也携带了有关源头的信息，通过这个回调过滤明显更有效。
47.6.4.8. 通用消息回调 #
可选的message_cb回调在每次解码逻辑解码消息时被调用。
typedef void (*LogicalDecodeMessageCB) (struct LogicalDecodingContext *ctx,
ReorderBufferTXN *txn,
XLogRecPtr message_lsn,
bool transactional,
const char *prefix,
Size message_size,
const char *message);
txn参数包含有关事务的元信息，例如提交时的时间戳和
其XID。请注意，当消息是非事务性的且在记录消息的事务中尚未分配XID时，它可以为NULL。
lsn是消息的WAL位置。
transactional表示消息是作为事务发送的还是不是。
类似于更改回调，在解码准备好的（但尚未提交的）事务或解码未提交的事务时，
此消息回调也可能由于同一事务的同时回滚而出错。在这种情况下，逻辑解码此
被中止的事务将优雅地停止。
prefix是任意的以NULL结尾的前缀，可用于识别当前插件的有趣消息。
最后，message参数包含实际的message_size大小的消息。
应该格外小心确保输出插件用于标识感兴趣消息的前缀是唯一的。建议使用扩展或输出插件本身的名称。
47.6.4.9. 准备过滤器回调 #
可选的filter_prepare_cb回调被调用，以决定作为当前
两阶段提交事务一部分的数据是否考虑在这个准备阶段进行解码，还是以后在
COMMIT PREPARED时作为常规的一阶段事务。
要表示要跳过解码，返回true;否则是false。
如果回调没有被定义，则假定false(也就是说，没有过滤，
所有使用两阶段提交的事务也在两个阶段进行解码)。
typedef bool (*LogicalDecodeFilterPrepareCB) (struct LogicalDecodingContext *ctx,
TransactionId xid,
const char *gid);
ctx参数与其他回调具有相同的内容。
参数xid和gid提供了两种不同的方式以标识事务。
后面的COMMIT PREPARED或ROLLBACK PREPARED携带这两个标识符，提供了输出插件可用的选项。
每个事务可以多次调用回调来解码，并且在每次它被调用时，必须为给定的xid和gid对提供相同的静态答案。
47.6.4.10. 事务开始准备回调 #
必需的begin_prepare_cb回调函数在已解码准备事务的开始时被调用。
gid字段是txn参数的一部分，可以在此回调函数中使用，
以检查插件是否已经接收到此PREPARE，在这种情况下，它可以出错或跳过事务的其余更改。
typedef void (*LogicalDecodeBeginPrepareCB) (struct LogicalDecodingContext *ctx,
ReorderBufferTXN *txn);
47.6.4.11. 事务准备回调 #
所需的prepare_cb回调被调用，当为两阶段提交准备的事务被解码的时候。
如果有任何修改的行，那么所有修改行的change_cb回调将在这之前被调用。
gid字段，是txn参数的一部分，可以在这个回调中使用。
typedef void (*LogicalDecodePrepareCB) (struct LogicalDecodingContext *ctx,
ReorderBufferTXN *txn,
XLogRecPtr prepare_lsn);
47.6.4.12. 事务提交准备回调 #
所需的commit_prepared_cb回调被调用，当事务COMMIT PREPARED被解码时。
gid字段，是txn参数的一部分，可以在这个回调中使用。
typedef void (*LogicalDecodeCommitPreparedCB) (struct LogicalDecodingContext *ctx,
ReorderBufferTXN *txn,
XLogRecPtr commit_lsn);
47.6.4.13. 事务回滚准备回调 #
所需的rollback_prepared_cb回调被调用，当事务ROLLBACK PREPARED被解码时。
gid字段，是txn参数的一部分，可以在这个回调中使用。
参数prepare_end_lsn和prepare_time可用于检查插件是否已经收到这个PREPARE TRANSACTION，在这种情况下，它可以应用回滚，否则，它可以跳过回滚操作。
单独的gid是不够的，因为下游节点可以有一个具有相同标识符的准备事务。
typedef void (*LogicalDecodeRollbackPreparedCB) (struct LogicalDecodingContext *ctx,
ReorderBufferTXN *txn,
XLogRecPtr prepare_end_lsn,
TimestampTz prepare_time);
47.6.4.14. 流开始回调 #
必需的stream_start_cb回调在从正在进行的事务中打开
一块流式更改时被调用。
typedef void (*LogicalDecodeStreamStartCB) (struct LogicalDecodingContext *ctx,
ReorderBufferTXN *txn);
47.6.4.15. 流停止回调 #
必需的stream_stop_cb回调在关闭正在进行的事务中
的流式更改块时被调用。
typedef void (*LogicalDecodeStreamStopCB) (struct LogicalDecodingContext *ctx,
ReorderBufferTXN *txn);
47.6.4.16. 流中止回调 #
必需的stream_abort_cb回调被调用以中止先前流式传输的事务。
typedef void (*LogicalDecodeStreamAbortCB) (struct LogicalDecodingContext *ctx,
ReorderBufferTXN *txn,
XLogRecPtr abort_lsn);
47.6.4.17. 流准备回调 #
stream_prepare_cb回调被调用以准备一个之前流式传输的事务，
作为两阶段提交的一部分。当输出插件同时支持大型进行中事务的流式传输和
两阶段提交时，此回调是必需的。
typedef void (*LogicalDecodeStreamPrepareCB) (struct LogicalDecodingContext *ctx,
ReorderBufferTXN *txn,
XLogRecPtr prepare_lsn);
47.6.4.18. 流提交回调 #
必需的stream_commit_cb回调被调用以提交之前流式传输的事务。
typedef void (*LogicalDecodeStreamCommitCB) (struct LogicalDecodingContext *ctx,
ReorderBufferTXN *txn,
XLogRecPtr commit_lsn);
47.6.4.19. 流更改回调 #
必需的stream_change_cb回调函数在发送一块流式更改中的更改时被调用
（由stream_start_cb和stream_stop_cb调用划定）。
实际的更改不会显示，因为事务可能会在稍后的时间点中止，
我们不会为已中止的事务解码更改。
typedef void (*LogicalDecodeStreamChangeCB) (struct LogicalDecodingContext *ctx,
ReorderBufferTXN *txn,
Relation relation,
ReorderBufferChange *change);
47.6.4.20. 流消息回调 #
可选的stream_message_cb回调在发送流式更改块中的通用消息时
被调用（由stream_start_cb和stream_stop_cb
调用标记）。事务性消息的消息内容不会显示，因为事务可能会在稍后的时间点
中止，我们不会解码已中止事务的更改。
typedef void (*LogicalDecodeStreamMessageCB) (struct LogicalDecodingContext *ctx,
ReorderBufferTXN *txn,
XLogRecPtr message_lsn,
bool transactional,
const char *prefix,
Size message_size,
const char *message);
47.6.4.21. 流截断回调 #
可选的stream_truncate_cb回调函数会在一个流式更改块中
（由stream_start_cb和stream_stop_cb
调用标记）为TRUNCATE命令调用。
typedef void (*LogicalDecodeStreamTruncateCB) (struct LogicalDecodingContext *ctx,
ReorderBufferTXN *txn,
int nrelations,
Relation relations[],
ReorderBufferChange *change);
参数类似于stream_change_cb回调。然而，由于通过外键连接
的表上的TRUNCATE操作需要一起执行，此回调接收一个关系
数组，而不是单个关系。有关详细信息，请参阅TRUNCATE
语句的描述。
47.6.5. 输出生成函数 #
在begin_cb、commit_cb或者
change_cb回调中，为了实际产生输出，
输出插件可以把数据写入到ctx->out中的
StringInfo输出缓冲区中。在写入输出缓冲区之前，必须先
调用OutputPluginPrepareWrite(ctx, last_write)，在完
成写入到缓冲区后，必须调用
OutputPluginWrite(ctx, last_write)来执行写入。
last_write指出一次特定的写入是否为该回调的最后
一次写入。
下面的例子展示了如何把数据输出给一个输出插件的消费者：
OutputPluginPrepareWrite(ctx, true);
appendStringInfo(ctx->out, "BEGIN %u", txn->xid);
OutputPluginWrite(ctx, true);
上一页 上一级 下一页47.5. 与逻辑解码相关的系统目录 起始页 47.7. 逻辑解码输出写入器
