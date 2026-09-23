# 54.4. 流复制协议

54.4. 流复制协议
版本：
纠错本页面
搜索
目录导航
❮
❯
54.4. 流复制协议 #
要启动流复制，前端在启动消息中发送replication参数。布尔值true
（或on、yes、1）告诉后端进入物理复制
walsender模式，在此模式下，可以发出一小组下面显示的复制命令，而不是SQL语句。
将database作为replication参数的值传递给后端，
指示其进入逻辑复制walsender模式，连接到dbname参数中指定的数据库。
在逻辑复制walsender模式下，可以发出如下所示的复制命令以及普通的SQL命令。
在物理复制或逻辑复制的walsender模式下，只能使用简单查询协议。
为了测试复制命令，您可以通过psql或任何其他使用连接字符串包含replication选项的libpq工具建立复制连接，
例如：
psql "dbname=postgres replication=database" -c "IDENTIFY_SYSTEM;"
然而，更常用的是使用pg_receivewal（用于物理复制）或pg_recvlogical（用于逻辑复制）。
复制命令在服务器日志中记录，当启用log_replication_commands时。
复制模式中接受的命令包括：
IDENTIFY_SYSTEM
#
请求服务器进行身份识别。服务器回复一个包含四个字段的单行结果集：
systemid (text)
唯一的系统标识符，用于标识集群。这可以用来检查用于初始化备用节点的基本备份是否来自同一集群。
timeline (int8)
当前时间线ID。也可用于检查备用是否与主服务器一致。
xlogpos (text)
当前WAL刷新位置。获取写前日志中的已知位置，可用于开始流式传输。
dbname (text)
连接到数据库或null。
SHOW name
#
请求服务器发送运行时参数的当前设置。这类似于SQL命令SHOW。
name
一个运行时参数的名称。可用参数在第 19 章中有文档记录。
TIMELINE_HISTORY tli
#
请求服务器发送时间线历史文件以获取时间线tli。服务器回复一行结果集，包含两个字段。虽然这些字段被标记为text，但它们实际上返回原始字节，没有编码转换：
filename (text)
时间线历史文件的文件名，例如，00000002.history。
content (text)
时间线历史文件的内容。
CREATE_REPLICATION_SLOT slot_name [ TEMPORARY ] { PHYSICAL | LOGICAL output_plugin } [ ( option [, ...] ) ]
#
创建一个物理或逻辑复制槽。有关复制槽的更多信息，请参见 第 26.2.6 节。
slot_name
要创建的槽的名称。必须是有效的复制槽名称（参见 第 26.2.6.1 节）。
output_plugin
用于逻辑解码的输出插件的名称（参见 第 47.6 节）。
TEMPORARY
指定此复制槽为临时槽。临时槽不会保存到磁盘，并且在错误或会话结束时会自动删除。
支持以下选项：TWO_PHASE [ boolean ]
如果为真，则此逻辑复制插槽支持两阶段提交的解码。使用此选项，与两阶段提交相关的命令，如
PREPARE TRANSACTION，COMMIT PREPARED
和ROLLBACK PREPARED将被解码和传输。
事务将在PREPARE TRANSACTION时解码和传输。
默认值为假。
RESERVE_WAL [ boolean ]
如果为真，则此物理复制插槽立即保留WAL。
否则，WAL仅在从流复制客户端连接时保留。
默认值为假。
SNAPSHOT { 'export' | 'use' | 'nothing' }
决定在逻辑插槽初始化期间如何处理创建的快照。'export'，
这是默认选项，将导出快照供其他会话使用。此选项不能在事务内使用。
'use'将为执行命令的当前事务使用快照。此选项必须在事务中使用，
并且CREATE_REPLICATION_SLOT必须是在该事务中运行的第一个命令。
最后，'nothing'将像往常一样仅用于逻辑解码使用快照，但不会执行其他操作。
FAILOVER [ boolean ]
如果为真，则该槽被启用以同步到备用节点，以便在故障切换后可以恢复逻辑复制。
默认值为假。
在响应此命令时，服务器将发送一个包含以下字段的单行结果集：
slot_name (text)
新创建的复制槽的名称。
consistent_point (text)
复制槽变得一致的WAL位置。这是流复制可以从该复制槽开始的最早位置。
snapshot_name (text)
命令导出的快照的标识符。快照有效，直到在此连接上执行新命令或关闭复制连接。如果创建的槽是物理槽，则为Null。
output_plugin (text)
新创建的复制槽使用的输出插件的名称。如果创建的槽是物理槽，则为Null。
CREATE_REPLICATION_SLOT slot_name [ TEMPORARY ] { PHYSICAL [ RESERVE_WAL ] | LOGICAL output_plugin [ EXPORT_SNAPSHOT | NOEXPORT_SNAPSHOT | USE_SNAPSHOT | TWO_PHASE ] }
#
为了与旧版本兼容，仍支持CREATE_REPLICATION_SLOT命令的这种
替代语法。
ALTER_REPLICATION_SLOT slot_name ( option [, ...] )
#
更改复制槽的定义。请参见第 26.2.6 节了解更多关于
复制槽的信息。此命令当前仅支持逻辑复制槽。
slot_name
要修改的槽名称。必须是有效的复制槽名称（参见
第 26.2.6.1 节）。
支持以下选项：TWO_PHASE [ boolean ]
如果为真，则此逻辑复制槽支持两阶段提交的解码。使用此选项，与两阶段提交相关的命令，如
PREPARE TRANSACTION、COMMIT PREPARED
和 ROLLBACK PREPARED 将被解码并传输。
事务将在 PREPARE TRANSACTION 时解码并传输。
FAILOVER [ boolean ]
如果为真，则该槽被启用以同步到备用节点，
以便在故障切换后可以恢复逻辑复制。
READ_REPLICATION_SLOT slot_name
#
读取与复制槽相关的一些信息。如果复制槽不存在，则返回一个包含NULL值的元组。
此命令当前仅支持物理复制槽。
在响应此命令时，服务器将返回一个包含以下字段的单行结果集：
slot_type (text)
复制槽的类型，可以是physical或NULL。
restart_lsn (text)
复制槽的restart_lsn。
restart_tli (int8)
与restart_lsn相关联的时间线ID，遵循当前时间线历史。
START_REPLICATION [ SLOT slot_name ] [ PHYSICAL ] XXX/XXX [ TIMELINE tli ]
#
指示服务器开始流式传输WAL，从WAL位置XXX/XXX开始。
如果指定了TIMELINE选项，则流式传输将从时间线tli开始；
否则，将选择服务器当前的时间线。如果请求的WAL部分已经被回收，服务器可能会回复错误。
成功时，服务器将用CopyBothResponse消息回复，然后开始向前端流式传输WAL。
如果通过slot_name提供了插槽的名称，
那么在复制过程中将更新该名称，以便服务器知道哪些WAL段，
以及如果hot_standby_feedback打开了哪些事务，
仍然被备用服务器需要。
如果客户端请求的时间线不是最新的，但是是服务器历史的一部分，服务器将从请求的起始点开始流式传输该时间线上的所有WAL，直到服务器切换到另一个时间线的点为止。如果客户端请求在旧时间线的结束时进行流式传输，服务器将完全跳过COPY模式。
在不是最新时间线上流式传输完所有WAL之后，服务器将通过退出COPY模式来结束流式传输。当客户端也通过退出COPY模式来确认时，服务器将发送一个包含一行两列的结果集，指示此服务器历史中的下一个时间线。第一列是下一个时间线的ID（类型为int8），第二列是发生切换的WAL位置（类型为text）。通常，切换位置是流式传输的WAL的末尾，但也有一些特殊情况，服务器可以发送一些尚未自行重放的旧时间线的WAL，然后再升级。最后，服务器发送两个CommandComplete消息（一个结束CopyData，另一个结束START_REPLICATION本身），并准备接受新命令。
WAL 数据作为一系列 CopyData 消息发送；参见 第 54.6 节 和 第 54.7 节 了解详情。（这允许其他信息混合发送；特别是服务器在开始
流式传输后如果遇到故障，可以发送 ErrorResponse 消息。）服务器发送给客户端的每个 CopyData 消息的
有效载荷包含以下格式之一的消息：
XLogData (B) #Byte1('w')
将消息标识为WAL数据。
Int64
这条消息中WAL数据的起始点。
Int64
服务器上当前的WAL结束位置。
Int64
传输时服务器的系统时钟，以2000-01-01午夜以来的微秒计算。
Byten
WAL数据流的一个部分。
单个 WAL 记录绝不会拆分为两个 XLogData 消息。
当 WAL 记录跨越 WAL 页面边界，并因此已使用连续记录进行拆分时，它可以在页面边界处进行拆分。
换句话说，第一个主 WAL 记录及其连续记录可以在不同的 XLogData 消息中发送。
Primary keepalive message (B) #Byte1('k')
将消息标识为发送者保持活动状态。
Int64
服务器上当前的 WAL 结束位置。
Int64
传输时服务器的系统时钟，以2000-01-01午夜以来的微秒计算。
Byte1
1 表示客户端应尽快回复此消息，以避免超时断开连接。0
否则。
接收进程可以随时向发送方发送回复，使用以下一种消息格式（也可以在
CopyData消息的有效负载中）：
Standby status update (F) #Byte1('r')
标识消息为接收者状态更新。
Int64
最后一个 WAL 字节的位置 + 1，已接收并写入备用服务器的磁盘中。
Int64
备用数据库中刷新到磁盘的最后一个 WAL 字节 + 1 的位置。
Int64
在备用机中应用的最后一个 WAL 字节的位置 + 1。
Int64
客户端在传输时的系统时钟，以自 2000-01-01 午夜以来的微秒计算。
Byte1
如果为1，则客户端请求服务器立即回复此消息。这可用于 ping 服务器，以测试连接是否仍然正常。
Hot standby feedback message (F) #Byte1('h')
标识消息为热备份反馈消息。
Int64
客户端在传输时的系统时钟，以2000-01-01午夜以来的微秒计算。
Int32
备用服务器当前的全局 xmin，不包括任何复制槽中的
catalog_xmin。如果此值和下面的
catalog_xmin均为0，则视为通知该连接上将不再发送
热备反馈。后续非零消息可能会重新启动反馈机制。
Int32
备用节点上全局xmin事务ID的纪元。
Int32
备用服务器上任何复制槽的最低catalog_xmin。
如果备用服务器上不存在catalog_xmin或热备用反馈被禁用，
则设置为0。
Int32
备用服务器上catalog_xmin xid的纪元。
START_REPLICATION SLOT slot_name LOGICAL XXX/XXX [ ( option_name [ option_value ] [, ...] ) ] #
指示服务器开始为逻辑复制启动WAL流，从WAL位置XXX/XXX或插槽的confirmed_flush_lsn（参见第 53.20 节）开始，以较大者为准。这种行为使客户端更容易避免在没有数据需要处理时更新其本地LSN状态。但是，从请求的LSN开始可能无法捕获某些类型的客户端错误；因此，客户端可能希望在发出START_REPLICATION之前检查confirmed_flush_lsn是否符合其期望。
服务器可以回复错误，例如如果槽不存在。成功时，服务器会响应一个CopyBothResponse
消息，然后开始向前端流式传输WAL。
CopyBothResponse 消息中的消息采用了与START_REPLICATION ... PHYSICAL
文档中记录的相同格式，包括两个 CommandComplete 消息。
与所选插槽关联的输出插件用于处理流式输出。
SLOT slot_name
要流更改的插槽的名称。此参数是必需的，并且必须对应于使用CREATE_REPLICATION_SLOT在LOGICAL模式下创建的现有逻辑复制插槽。
XXX/XXX
开始流式传输的WAL位置。
option_name
传递给插槽逻辑解码输出插件的选项名称。请参阅第 54.5 节，
了解标准（pgoutput）插件接受的选项。
option_value
指定选项相关的可选值，以字符串常量的形式表示。
DROP_REPLICATION_SLOT slot_name [ WAIT ]
#
删除复制槽，释放任何保留的服务器端资源。
slot_name
要删除的槽名称。
WAIT
这个选项会导致命令在槽位活跃时等待，直到它变为非活跃状态，而不是默认行为抛出错误。
UPLOAD_MANIFEST
#
上传备份清单，为执行增量备份做准备。
BASE_BACKUP [ ( option [, ...] ) ]
#
指示服务器开始流式传输基本备份。
在备份开始之前，系统将自动进入备份模式，并在备份完成后退出备份模式。
接受以下选项：
LABEL 'label'
设置备份的标签。如果未指定，则将使用base backup作为备份标签。
标签的引用规则与打开standard_conforming_strings的标准SQL字符串相同。
TARGET 'target'
告诉服务器备份数据发送的位置。如果目标是client，这是默认值，备份数据将发送到客户端。
如果是server，备份数据将写入到由TARGET_DETAIL选项指定的服务器路径。
如果是blackhole，备份数据不会发送到任何地方；它会被简单地丢弃。
server目标需要超级用户权限或被授予pg_write_server_files角色。
TARGET_DETAIL 'detail'
提供有关备份目标的额外信息。
目前，此选项仅在备份目标为server时才能使用。它指定了备份应写入的服务器目录。
PROGRESS [ boolean ]
如果设置为true，则请求生成进度报告所需的信息。这将在每个表空间的头部发送一个近似大小，
可用于计算流的进度。这是通过在传输开始之前先枚举所有文件大小来计算的，
可能会对性能产生负面影响。特别是，在流式传输数据之前可能需要更长的时间。
由于备份期间数据库文件可能会发生变化，因此大小仅为近似值，
在近似值和实际文件发送之间可能会增长或缩小。默认值为false。
CHECKPOINT { 'fast' | 'spread' }
设置在基本备份开始时执行的检查点类型。默认值为spread。
WAL [ boolean ]
如果设置为true，则在备份中包含必要的WAL段。这将包括在开始和停止备份之间的所有文件在基本目录tar文件的pg_wal目录中。默认值为false。
WAIT [ boolean ]
如果设置为true，备份将等待直到最后一个所需的WAL段被归档，或者在未启用
WAL归档时发出警告。如果为false，备份既不会等待也不会警告，客户端需要
自行确保所需的日志可用。默认值为true。
COMPRESSION 'method'
指示服务器使用指定的方法压缩备份。目前支持的方法有gzip、
lz4和zstd。
COMPRESSION_DETAIL detail
指定所选压缩方法的详细信息。这应该仅与COMPRESSION
选项一起使用。如果值是一个整数，则表示压缩级别。否则，它应该是一个
逗号分隔的项目列表，每个项目的形式为keyword
或keyword=value。目前，支持的关键字有
level、long和workers。
level关键字设置压缩级别。
对于gzip，压缩级别应该是一个介于1和9之间的整数
（默认为Z_DEFAULT_COMPRESSION或-1），
对于lz4，压缩级别应该是介于1和12之间的整数
（默认为0用于快速压缩模式），
对于zstd，压缩级别应该是介于ZSTD_minCLevel()
（通常为-131072）和ZSTD_maxCLevel()
（通常为22）之间，
（默认为ZSTD_CLEVEL_DEFAULT或3）。
long关键字启用了长距离匹配模式，以提高压缩比，
但代价是更高的内存使用。长距离模式仅支持
zstd。
workers关键字设置应该用于并行压缩的线程数。并行压缩仅支持zstd。
MAX_RATE rate
限制（节流）每单位时间从服务器传输到客户端的最大数据量。预期的单位是每秒千字节。
如果指定了此选项，则该值必须等于零，或者必须在32 kB到1 GB（含）的范围内。
如果传递零或未指定该选项，则不对传输施加任何限制。
TABLESPACE_MAP [ boolean ]
如果为true，则在名为tablespace_map的文件中包含目录pg_tblspc中存在的符号链接的信息。
表空间映射文件包括目录pg_tblspc/中每个符号链接的名称及该符号链接的完整路径。默认值为false。
VERIFY_CHECKSUMS [ boolean ]
如果为true，则在进行基本备份时验证校验和（如果已启用）。如果为false，则跳过此步骤。默认值为true。
MANIFEST manifest_option
当指定此选项的值为yes或force-encode时，
将创建一个备份清单并随备份一起发送。该清单是备份中每个文件的列表，
除了可能包含的任何WAL文件。它还存储每个文件的大小、最后修改时间，
以及可选的校验和。
值为force-encode会强制对所有文件名进行十六进制编码；
否则，仅对文件名为非UTF8八位序列的文件执行此类型的编码。
force-encode主要用于测试目的，以确保读取备份清单的客户端
能够处理这种情况。为了与之前的版本兼容，默认值为MANIFEST 'no'。
MANIFEST_CHECKSUMS checksum_algorithm
指定应用于备份清单中包含的每个文件的校验和算法。
目前，可用的算法有NONE、CRC32C、
SHA224、SHA256、
SHA384和SHA512。
默认值为CRC32C。
INCREMENTAL
请求增量备份。必须在使用此选项运行基础备份之前执行
UPLOAD_MANIFEST命令。
当备份开始时，服务器将首先发送两个普通的结果集，然后是一个或多个CopyOutResponse结果。
第一个普通结果集包含备份的起始位置，在一个包含两列的单行中。第一列包含以XLogRecPtr格式给出的起始位置，第二列包含相应的时间线ID。
第二个普通结果集中的每个表空间都有一行。
这一行中的字段是:
spcoid (oid)
表空间的OID，如果是基本目录则为null。
spclocation (text)
表空间目录的完整路径，如果是基本目录则为null。
size (int8)
表空间的大致大小，以千字节（1024字节）为单位，如果已请求进度报告；否则为null。
在第二个常规结果集之后，将发送一个CopyOutResponse。
每个CopyData消息的有效负载将包含以下格式之一的消息：
new archive (B)Byte1('n')
标识消息表示新存档的开始。主数据目录将有一个存档，每个额外的表空间将有一个存档；
每个存档将使用tar格式（遵循“ustar interchange format”中指定的
POSIX 1003.1-2008标准）。
String
该存档的文件名。
String
对于主数据目录，使用空字符串。对于其他表空间，使用从创建此存档的目录的完整路径。
manifest (B)Byte1('m')
标识消息表示备份清单的开始。
archive or manifest data (B)Byte1('d')
标识消息包含存档或清单数据。
Byten
数据字节。
progress report (B)Byte1('p')
标识消息为进度报告。
Int64
已完成处理的来自当前表空间的字节数。
在发送了CopyOutResponse或所有这些响应之后，将发送最终的普通结果集，其中包含备份的WAL结束位置，格式与起始位置相同。
数据目录和每个表空间的tar归档将包含目录中的所有文件，无论它们是PostgreSQL文件还是添加到同一目录的其他文件。唯一排除的文件是：
postmaster.pid
postmaster.opts
pg_internal.init（在多个目录中找到）
PostgreSQL服务器运行期间创建的各种临时文件和目录，例如以pgsql_tmp开头的任何文件或目录以及临时关系。
未记录的关系，除了需要在恢复时重新创建（空的）未记录的关系的init fork。
pg_wal，包括子目录。如果备份包含WAL文件，则将包含pg_wal的合成版本，但它只包含备份工作所需的文件，而不包含其余内容。
pg_dynshmem，pg_notify，
pg_replslot，pg_serial，
pg_snapshots，pg_stat_tmp和
pg_subtrans将作为空目录复制（即使它们是符号链接）。
除了常规文件和目录之外的文件，如符号链接（除了上述列出的目录之外的符号链接）以及特殊设备和操作系统文件，将被跳过。（pg_tblspc中的符号链接将被保留。）
如果服务器上的底层文件系统支持，将设置所有者、组和文件模式。
在上述所有命令中，指定类型为boolean的参数时，
value部分可以省略，
这等同于指定TRUE。
上一页 上一级 下一页54.3. SASL 认证 起始页 54.5. 逻辑流复制协议
