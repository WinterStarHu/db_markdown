# 19.5. 预写日志

19.5. 预写日志
版本：
纠错本页面
搜索
目录导航
❮
❯
19.5. 预写日志 #19.5.1. 设置19.5.2. 检查点19.5.3. 归档19.5.4. 恢复19.5.5. 归档恢复19.5.6. 恢复目标19.5.7. WAL 汇总
参阅第 28.5 节获取调节这些设置的其他信息。
19.5.1. 设置 #wal_level (enum)
#
wal_level决定多少信息写入到 WAL 中。默认值是replica，它会写入足够的数据以支持WAL归档和复制，包括在后备服务器上运行只读查询。minimal会去掉除从崩溃或者立即关机中进行恢复所需的信息之外的所有记录。最后，logical会增加支持逻辑解码所需的信息。每个层次包括所有更低层次记录的信息。这个参数只能在服务器启动时设置。
minimal级别生成最少的WAL日志量。它不记录在创建或重写事务中对永久关系的行信息。
这可以使操作速度更快（参见第 14.4.7 节）。触发此优化的操作包括：
ALTER ... SET TABLESPACECLUSTERCREATE TABLEREFRESH MATERIALIZED VIEW
（不使用CONCURRENTLY）REINDEXTRUNCATE
然而，最小的WAL不包含足够的信息用于时点恢复，因此必须使用replica或更高级别来启用持续归档
（archive_mode）和流式二进制复制。
实际上，如果max_wal_senders不为零，服务器甚至不会以此模式启动。
请注意，将wal_level更改为minimal会使先前的基本备份无法用于时点恢复和备用服务器。
在logical级别上，记录与replica相同的信息，以及从WAL中提取逻辑变更集所需的信息。
使用logical级别会增加WAL的容量，特别是如果许多表被配置为REPLICA IDENTITY FULL，
并且执行了许多UPDATE和DELETE语句。
在 9.6 之前的版本中，这个参数也允许值archive和hot_standby。现在仍然接受这些值，但是它们会被映射到replica。
fsync (boolean)
#
如果打开这个参数，PostgreSQL服务器将尝试确保更新被物理地写入到磁盘，做法是发出fsync()系统调用或者使用多种等价的方法（见wal_sync_method）。这保证了数据库集簇在一次操作系统或者硬件崩溃后能恢复到一个一致的状态。
虽然关闭fsync常常可以得到性能上的收益，但当发生断电或系统崩溃时可能造成不可恢复的数据损坏。因此，只有在能很容易地从外部数据中重建整个数据库时才建议关闭fsync。
能安全关闭fsync的环境的例子包括从一个备份文件中初始加载一个新数据库集簇、使用一个数据库集簇来在数据库被删掉并重建之后处理一批数据，或者一个被经常重建并且不用于故障转移的只读数据库克隆。单独的高质量硬件不足以成为关闭fsync的理由。
当把fsync从关闭改成打开时，为了可靠的恢复，需要强制在内核中的所有被修改的缓冲区进入持久化存储。这可以在多个时机来完成：
在集簇被关闭时或在fsync打开时，通过运行initdb --sync-only、运行sync、卸载文件系统或重启服务器来实现。
在很多情况下，为不重要的事务关闭synchronous_commit可以提供很多关闭fsync的潜在性能收益，而不会有伴随的数据损坏风险。
fsync只能在postgresql.conf文件中或在服务器命令行上设置。如果你关闭这个参数，请也考虑关闭full_page_writes。
synchronous_commit (enum)
#
指定数据库服务器返回“success”指示给客户端之前，必须要完成多少WAL处理。
合法的值为remote_apply, on
(默认值), remote_write,local, 和 off。
如果synchronous_standby_names为空，则唯一有意义的设置为on 和 off ；
remote_apply，remote_write 和 local都提供与on相同的本地同步级别。
所有非off模式的本地行为都是等待WAL的本地刷新到磁盘。
在 off模式，无需等待，因此在向客户端报告成功和以后保证事务安全防止服务器崩溃之间可能会出现延迟。
当设置为off时，在向客户端报告成功和真正保证事务不会被服务器崩溃威胁之间会有延迟（最大的延迟是wal_writer_delay的三倍）。
不同于fsync，将这个参数设置为off不会产生数据库不一致性的风险：一个操作系统或数据库崩溃可能会造成一些最近据说已提交的事务丢失，但数据库状态是一致的，就像这些事务已经被干净地中止。
因此，当性能比完全确保事务的持久性更重要时，关闭synchronous_commit可以作为一个有效的代替手段。更多讨论见第 28.4 节。
如果synchronous_standby_names为非空，synchronous_commit也控制事务提交是否将等待它们的WAL记录在后备服务器上被处理。
当设置为 remote_apply 时，提交将等待，直到来自当前同步备用服务器的答复显示他们已收到事务的提交记录并应用了它，以便它变得对备用服务器上的查询可见，并写入备用服务器上的持久存储。
这将导致比以前的设置更大的提交延迟，因为它等待 WAL 重放(replay)。
当设置为on时，提交将等待，直到来自于当前同步的后备服务器的回复显示它们已经收到了事务的提交记录并将其刷入了磁盘。
这保证事务将不会被丢失，除非主服务器和所有同步后备都遭受到了数据库存储损坏的问题。
当这个参数被设置为remote_write时，提交将等待，直到来自当前的同步后备的回复指示它们已经收到了该事务的提交记录并且已经把该记录写到它们的文件系统，这种设置保证数据得以保存，在PostgreSQL的后备服务器实例崩溃时，但是不能保证后备服务器遭受操作系统级别崩溃时数据能被保持，因为数据不一定必须要在后备机上达到持久存储。
设置local会导致提交等待本地刷写到磁盘，而不是复制。在使用同步复制时这通常是不可取的，但是为了完整性提供了这个选项。
这个参数可以随时被修改；任何一个事务的行为由其提交时生效的设置决定。因此，可以同步提交一些事务，同时异步提交其他事务。例如，当默认是相反时，实现一个单一多语句事务的异步提交，在事务中发出SET LOCAL synchronous_commit TO OFF。
表 19.1 概括了 synchronous_commit 设置的能力。
表 19.1. synchronous_commit 模式synchronous_commit 设置本地持久化提交PG 崩溃后备机持久化提交OS 崩溃后备机持久化提交备机查询一致性remote_apply••••on••• remote_write••  local•   off    wal_sync_method (enum)
#
用来强制 WAL 更新到磁盘的方法。如果 fsync 关闭，
那么这个设置就不相关，因为 WAL 文件更新将根本不会被强制。
可能的值是：
open_datasync (用 open() 选项 O_DSYNC 写 WAL 文件)
fdatasync (在每次提交时调用 fdatasync())
fsync (在每次提交时调用 fsync())
fsync_writethrough (在每次提交时调用 fsync()，强制任何磁盘写缓存的直通写)
open_sync (用 open() 选项 O_SYNC 写 WAL 文件)
并非所有这些选项在所有平台上都可用。
默认值是上述列表中平台支持的第一个方法，
但在 Linux 和 FreeBSD 上，fdatasync 是默认值。
默认值不一定是理想的；可能需要更改此设置或系统配置的其他方面，
以创建一个崩溃安全的配置或实现最佳性能。
这些方面在 第 28.1 节 中进行了讨论。
此参数只能在 postgresql.conf 文件中或服务器命令行上设置。
full_page_writes (boolean)
#
当这个参数为开启时，PostgreSQL服务器在一个检查点之后的页面的第一次修改期间将每个页面的全部内容写到WAL中。这么做是因为在操作系统崩溃期间正在处理的一次页写入可能只有部分完成，从而导致在一个磁盘页面中混合有新旧数据。在崩溃后的恢复期间，通常存储在WAL中的行级改变数据不足以完全恢复这样一个页面。存储完整的页面映像可以保证页面被正确恢复，但代价是增加了必须被写入WAL的数据量（因为WAL重放总是从一个检查点开始，所以在检查点后每个页面的第一次改变时这样做就够了。因此，一种减小全页面写开销的方法是增加检查点间隔参数值）。
关闭这个参数会加快正常操作，但是在系统失败后可能导致不可恢复的数据损坏，或者静默的数据损坏。其风险类似于关闭fsync，但是风险较小，并且只有在可关闭fsync的情况下才应该关闭它。
关闭这个选项并不影响用于时间点恢复（PITR）的WAL归档使用（见第 25.3 节）。
这个参数只能在postgresql.conf文件中或在服务器命令行上设置。默认值是on。
wal_log_hints (boolean)
#
当这个参数为on时，PostgreSQL服务器在一个检查点之后页面被第一次修改期间将该磁盘页面的整个内容都写入WAL，即使对所谓的提示位做非关键修改也会这样做。
如果启用了数据校验和，提示位更新总是会被WAL记录并且这个设置会被忽略。你可以使用这个设置测试如果你的数据库启用了数据校验和，会有多少额外的WAL记录发生。
这个参数只能在服务器启动时设置。默认值是off。
wal_compression (enum)
#
此参数启用使用指定的压缩方法对 WAL 进行压缩。
启用后，PostgreSQL
服务器会压缩写入 WAL 的完整页面图像（例如，当
full_page_writes 打开时，在基础备份期间等）。
压缩的页面图像将在 WAL 重放期间解压缩。
支持的方法有 pglz、
lz4（如果 PostgreSQL
是使用 --with-lz4 编译的）和
zstd（如果 PostgreSQL
是使用 --with-zstd 编译的）。
默认值为 off。
只有超级用户和具有适当 SET
权限的用户可以更改此设置。
启用压缩可以减少 WAL 卷的大小，而不会增加不可恢复的数据损坏的风险，
但会增加在 WAL 记录期间进行压缩时的额外 CPU 消耗，以及在 WAL 重放期间进行解压缩时的成本。
wal_init_zero (boolean)
#
如果设置为on（默认值），此选项会导致新的 WAL 文件被零填充。
在某些文件系统上，这可确保在我们需要写入 WAL 记录之前分配空间。
但是，Copy-On-Write（COW）文件系统可能不会从此技术中受益，因此可以选择跳过不必要的工作。
如果设置为off，则在创建文件时仅写入最终字节，以便其具有预期大小。
wal_recycle (boolean)
#
如果设置为 on （默认值），此选项通过重命名来回收 WAL 文件，从而避免创建新文件。
在 COW 文件系统上，创建新文件可能更快，因此提供了禁用此行为的选项。
wal_buffers (integer)
#
用于还未写入磁盘的 WAL 数据的共享内存量。默认值 -1 选择等于
shared_buffers的 1/32 的尺寸（大约3%），但是不小于
64kB也不大于 WAL 段的尺寸，通常为 16MB。
如果自动的选择太大或太小，可以手工设置该值，但是任何小于
32kB的正值都将被当作 32kB。
如果指定值时没有单位，则以 WAL 块作为单位，即为
XLOG_BLCKSZ 字节，通常为 8kB。这个参数只能在服务器启动时设置。
在每次事务提交时，WAL 缓冲区的内容被写出到磁盘，因此极大的值不可能提供显著的收益。不过，把这个值设置为几个兆字节可以在一个繁忙的服务器（其中很多客户端会在同一时间提交）上提高写性能。由默认设置 -1 选择的自动调节将在大部分情况下得到合理的结果。
wal_writer_delay (integer)
#
指定 WAL 写入器刷新 WAL 的频率，以时间为单位。刷新 WAL 后，写入器会休眠
wal_writer_delay 指定的时间长度，除非被异步提交的事务提前
唤醒。如果上次刷新发生在不到 wal_writer_delay 之前，且自那时
以来产生的 WAL 少于 wal_writer_flush_after，则 WAL 仅写入操作
系统，而不刷新到磁盘。
如果该值未指定单位，则默认以毫秒为单位。默认值为 200 毫秒（200ms）。
注意，在某些系统上，休眠延迟的有效分辨率为 10 毫秒；将 wal_writer_delay
设置为非 10 的倍数的值，可能与设置为下一个更高的 10 的倍数的值效果相同。此参数只能
在 postgresql.conf 文件或服务器命令行中设置。
wal_writer_flush_after (integer)
#
指定 WAL 写入器刷写 WAL 的频繁程度，以卷为单位。
如果最近的刷写发生在 wal_writer_delay 之前，并且小于 wal_writer_flush_after 的 WAL 值产生之后，那么 WAL 只会被写入操作系统，而不会被刷写到磁盘。
如果 wal_writer_flush_after 被设置为 0，则 WAL 数据总是会被立即刷写。
如果指定值时没有单位，则以 WAL 块作为单位，即为 XLOG_BLCKSZ 字节，通常为 8kB。
默认是 1MB。这个参数只能在 postgresql.conf 文件中或者服务器命令行上设置。
wal_skip_threshold (integer)
#
当wal_level为minimal，并且在创建或重写永久关系之后提交事务时，此设置将确定如何保留新数据。
如果数据小于此设置，将其写入WAL日志；否则，使用受影响文件的fsync。
根据存储的属性，如果此类提交减慢了并发事务，提高或降低此值可能会有所帮助。
如果指定此值时没有单位，则视为千字节。默认为两兆字节（2MB）。
commit_delay (integer)
#
设置commit_delay会在执行WAL刷新之前添加时间延迟。
如果系统负载足够高，使得在给定时间间隔内有更多事务准备提交，
这可以通过允许更多事务通过单个WAL刷新来提高组提交吞吐量。
然而，这也会增加延迟，最多为每个WAL刷新的commit_delay。
因为如果没有其他事务准备提交，延迟就是浪费的，所以只有在至少有
commit_siblings其他事务活动时才会执行延迟，
当要启动刷新时，如果fsync被禁用，则不会执行延迟。
如果未指定单位，则将其视为微秒。
默认commit_delay为零（无延迟）。
只有超级用户和具有适当SET权限的用户才能更改此设置。
在PostgreSQL的9.3发布之前，commit_delay的行为不同并且效果更差：它只影响提交，而不是所有WAL刷写，并且即使在WAL刷写马上就要完成时也会等待一整个配置的延迟。从PostgreSQL 9.3中开始，第一个准备好刷写的进程会等待配置的间隔，而后续的进程只等到领导者完成刷写操作。
commit_siblings (integer)
#
在执行commit_delay延迟时，要求的并发活动事务的最小数目。大一些的值会导致在延迟间隔期间更可能有至少另外一个事务准备好提交。默认值是五个事务。
19.5.2. 检查点 #checkpoint_timeout (integer)
#
自动 WAL 检查点之间的最长时间。如果指定值时没有单位，则以秒为单位。
合理的范围在 30 秒到 1 天之间。默认是 5 分钟（5min）。增加这个参数的值会增加崩溃恢复所需的时间。这个参数只能在postgresql.conf文件中或在服务器命令行上设置。
checkpoint_completion_target (floating point)
#
指定检查点完成的目标，作为检查点之间总时间的一部分。
默认是 0.9，这将把检查点分布在几乎所有可用的时间间隔上，提供公平一致的 I/O 负载，同时也为检查点完成开销留下了一些时间。
减少此参数是不被推荐的，因为这会导致检查点完成得更快。
这会导致在检查点完成和下一个计划检查点之间的 I/O 比例更高。
这个参数只能在postgresql.conf文件中或在服务器命令行上设置。
checkpoint_flush_after (integer)
#
当执行检查点时写入的数据量超过此数量时，就尝试强制 OS 把这些写发送到底层存储。
这样做将会限制内核页面高速缓存中的脏数据数量，降低在检查点末尾发出fsync或者 OS 在后台大批量写回数据时被卡住的可能性。
这常常会导致大幅度降低事务延迟，但是也有一些情况（特别是负载超过shared_buffers但小于 OS 页面高速缓存）的性能可能会降低。
这种设置可能会在某些平台上没有效果。
如果指定值时没有单位，则以块为单位，即为BLCKSZ 字节，通常为 8kB。
合法的范围在0（禁用强制写回）和2MB之间。Linux 上的默认值是256kB，其他平台上是0（如果BLCKSZ不是 8kB，则默认值和最大值会按比例缩放到它）。这个参数只能在postgresql.conf文件中或在服务器命令行上设置。
checkpoint_warning (integer)
#
如果由于填充 WAL 段文件导致的检查点之间的间隔低于这个参数表示的时间量，那么就向服务器日志写一个消息（这表明应该增加max_wal_size的值）。
如果指定值时没有单位，则以秒为单位。默认值是 30 秒（30s）。零则关闭警告。如果checkpoint_timeout低于checkpoint_warning，则不会有警告产生。这个参数只能在postgresql.conf文件中或在服务器命令行上设置。
max_wal_size (integer)
#
在自动检查点期间允许WAL增长的最大大小。这是一个软限制；在特殊情况下，如重负载、失败的archive_command或archive_library，或高wal_keep_size设置下，WAL大小可能会超过max_wal_size。
如果未指定单位，则将其视为兆字节。默认值为1 GB。
增加此参数可能会增加崩溃恢复所需的时间。
此参数只能在postgresql.conf文件或服务器命令行中设置。
min_wal_size (integer)
#
只要WAL磁盘用量保持在这个设置之下，在检查点时旧的WAL文件总是
被回收以便未来使用，而不是直接被删除。这可以被用来确保有足够的
WAL空间被保留来应付WAL使用的高峰，例如运行大型的批处理任务。
如果指定值时没有单位，则以兆字节为单位。默认是80 MB。这个参数只能在postgresql.conf
或者服务器命令行中设置。
19.5.3. 归档 #archive_mode (enum)
#
当启用archive_mode时，完成的WAL段会通过设置
archive_command或
archive_library发送到归档存储。除了off，
要禁用，有两种模式：on和
always。在正常操作期间，这两种模式之间没有区别，但当设置为always时，
WAL归档程序在归档恢复或待机模式下也会被启用。在always模式下，从归档中恢复的所有文件
或通过流复制传输的文件将被再次归档。详细信息请参见
第 26.2.9 节。
archive_mode是一个独立的设置，不同于
archive_command和
archive_library，这样
archive_command和
archive_library可以在不离开
存档模式的情况下进行更改。
此参数只能在服务器启动时设置。
当wal_level设置为minimal时，
无法启用archive_mode。
archive_command (string)
#
本地 shell 命令被执行来归档一个完成的 WAL 文件段。字符串中的任何%p被替换成要归档的文件的路径名，而%f只被文件名替换（路径名是相对于服务器的工作目录，即集簇的数据目录）。如果要在命令里嵌入一个真正的%字符，可以使用%%。有一点很重要，该命令只在成功时返回一个零作为退出状态。更多信息请见第 25.3.1 节。
此参数只能在postgresql.conf文件中或服务器命令行上设置。仅当archive_mode在服务器启动时启用且archive_library设置为空字符串时才使用。如果同时设置了archive_command和archive_library，将会引发错误。如果archive_command是空字符串（默认值），而archive_mode已启用（且archive_library设置为空字符串），则WAL归档将暂时禁用，但服务器会继续累积WAL段文件，期望很快会提供一个命令。将archive_command设置为一个仅返回true的命令，例如/bin/true（在Windows上为REM），实际上会禁用归档，但也会破坏用于归档恢复所需的WAL文件链，因此仅应在不寻常的情况下使用。
archive_library (string)
#
用于归档已完成的 WAL 文件段的库。如果设置为空字符串（默认值），则启用通过 shell 进行归档，并使用archive_command。如果同时设置了archive_command和archive_library，将会引发错误。否则，将使用指定的共享库进行归档。当此参数更改时，WAL 归档进程会由 postmaster 重新启动。有关更多信息，请参见第 25.3.1 节和第 49 章。
此参数只能在postgresql.conf文件中或服务器命令行上设置。
archive_timeout (integer)
#
archive_command或archive_library仅在完成的 WAL 段中调用。因此，如果您的服务器生成的 WAL 流量较少（或者在这样做时有间歇期），在事务完成和安全记录到归档存储之间可能会有很长的延迟。为了限制未归档数据的年龄，您可以将archive_timeout设置为强制服务器定期切换到新的 WAL 段文件。当此参数大于零时，只要自上次段文件切换以来经过了这段时间，并且存在任何数据库活动，包括单个检查点（如果没有数据库活动，则跳过检查点），服务器将切换到新的段文件。请注意，由于强制切换而提前关闭的归档文件仍然与完全填满的文件长度相同。因此，使用非常短的archive_timeout是不明智的，它会使您的归档存储膨胀。通常，将archive_timeout设置为一分钟左右是合理的。如果您希望数据比这更快地从主服务器复制出来，您应该考虑使用流复制而不是归档。如果未指定单位，则将此值视为秒。此参数只能在postgresql.conf文件或服务器命令行中设置。
19.5.4. 恢复 #
本节描述了适用于一般恢复的设置，影响崩溃恢复、流复制和基于归档的复制。
recovery_prefetch (enum)
#
在恢复期间，是否尝试预取 WAL 中引用的尚未在缓冲池中的块。
有效值为 off、on 和
try（默认值）。设置
try 仅在操作系统提供发出
预读建议的支持时启用预取。
预取即将需要的块可以减少某些工作负载下恢复期间的 I/O 等待时间。
另请参阅 wal_decode_buffer_size 和
maintenance_io_concurrency 设置，限制预取活动。
wal_decode_buffer_size (integer)
#
服务器在 WAL 中查找要预取的块的最大前瞻限制。
如果此值未指定单位，则视为字节。
默认值为 512kB。
此参数只能在服务器启动时设置。
19.5.5. 归档恢复 #
本节描述了仅在恢复期间适用的设置。它们必须在您希望执行的任何后续恢复中重置。
“Recovery” 涵盖使用服务器作为备用服务器或用于执行目标恢复。
通常情况下，备用模式用于提供高可用性和/或读可扩展性，而目标恢复用于从数据丢失中恢复。
若要在备用模式下启动服务器，在数据目录中建立名为standby.signal的文件。
服务器将会进入恢复状态，并且在到达归档WAL末尾时不会停止恢复，但将保持尝试继续恢复，通过连接到primary_conninfo设置指定的发送服务器和/或用restore_command获取新的WAL分段。
对于这种模式，来自本节的参数和第 19.6.3 节 是值得关注的。
第 19.5.6 节 中的参数也会被应用，但通常在这种模式下没用。
要启动服务器为目标恢复模式，需在数据目录中建立名为recovery.signal的文件。
如果同时创建了standby.signal 和 recovery.signal 文件，则优先使用备用模式。
目标恢复模式在归档的WAL全部回放或到达recovery_target时结束。
在这种模式下，将使用来自本节和 第 19.5.6 节 的参数。
restore_command (string)
#
用于获取 WAL 文件系列的一个已归档段的本地 shell 命令。这个参数是归档恢复所必需的，但是对于流复制是可选的。
在该字符串中的任何%f会被替换为从归档中获得的文件的名字，并且任何%p会被在服务器上的复制目标路径名替换（该路径名是相对于当前工作目录的，即集簇的数据目录）。
任何%r会被包含上一个可用重启点的文件的名字所替换。
在那些必须被保留用于使得一次恢复变成可重启的文件中，这个文件是其中最早的一个，因此这个信息可以被用来把归档截断为支持从当前恢复重启所需的最小值。
%r通常只被温备配置（见第 26.2 节）所使用。要嵌入一个真正的%字符，需要写成%%。
很重要的一点是，该命令只有在成功时才返回一个为零的退出状态。
该命令将会被询问不存在于归档中的文件名，当这样被询问时它必须返回非零。例子：
restore_command = 'cp /mnt/server/archivedir/%f "%p"'
restore_command = 'copy "C:\\server\\archivedir\\%f" "%p"'  # Windows
一个例外是如果该命令被一个信号（不是SIGTERM，它是数据库服务器关闭的一部分）或者一个 shell 错误（例如命令未找到）终止，则恢复将会中止并且服务器将不会启动。
这个参数只能在postgresql.conf文件中或在服务器命令行上进行设置。
archive_cleanup_command (string)
#
这个可选参数指定了一个 shell 命令，它将在每一个重启点被执行。
archive_cleanup_command的目的是提供一种清除不再被备用服务器需要的旧的已归档 WAL 文件的机制。
任何%r会被替换为包含最后一个有效重启点的文件的名称。
那是使一次恢复变成可重启的所必须被保留的最早的文件，因此比%r更早的所有文件可以被安全地移除。
这个信息可以被用来把归档截断为支持从当前恢复重启所需的最小值。
对于单一备用配置，pg_archivecleanup模块常常被用在archive_cleanup_command中，例如：
archive_cleanup_command = 'pg_archivecleanup /mnt/server/archivedir %r'
但是注意，如果多个备用服务器正在从同一个归档目录中恢复，你将需要保证只有当任意服务器都不再需要 WAL 文件时才会删除它们。
archive_cleanup_command通常被用于一种温备用配置（见第 26.2 节）中。
要在该命令中嵌入一个真正的%字符，需要写成%%。
如果该命令返回一个非零退出状态，则将会写出一个警告日志消息。
一个例外是如果该命令被一个信号或者一个 shell 错误（例如命令未找到）终止，则会抛出一个致命错误。
这个参数只能在postgresql.conf文件中或在服务器命令行上进行设置。
recovery_end_command (string)
#
这个参数指定了一个将只在恢复末尾被执行一次的 shell 命令。这个参数是可选的。
recovery_end_command的目的是为复制或恢复之后的清除提供一种机制。
与archive_cleanup_command中相似，任何%r会被替换为包含最后一个有效重启点的文件的名称。
如果该命令返回一个非零退出状态，则一个警告日志消息将被写出，并且不管怎样该数据库将继续启动。
一个例外是如果该命令被一个信号或者 shell 错误（例如命令未找到）中止，该数据库将不会继续启动。
这个参数只能在postgresql.conf文件中或通过服务器命令行进行设置。
19.5.6. 恢复目标 #
默认情况下，恢复将会一直恢复到 WAL 日志的末尾。下面的参数可以用来指定一个更早的停止点。
在recovery_target、recovery_target_lsn、recovery_target_name、recovery_target_time和recovery_target_xid中，
最多只能使用一个，如果在配置文件中使用了多个，将会产生一个错误。这个参数只能在服务器启动时设置。
recovery_target = 'immediate'
#
这个参数指定恢复应该在达到一个一致状态后尽快结束，即尽早结束。在从一个在线备份中恢复时，这意味着备份结束的那个点。
在技术上，这是一个字符串参数，但是'immediate'是目前唯一允许的值。
recovery_target_name (string)
#
这个参数指定（pg_create_restore_point()所创建的）已命名的恢复点，恢复将进入该恢复点。
recovery_target_time (timestamp)
#
此参数指定恢复将执行的时间戳。
精确的停止点还受到
recovery_target_inclusive的影响。
此参数的值是一个被timestamp with time zone数据类型接受的相同格式的时间戳，
只不过你不能使用时区缩写（除非timezone_abbreviations变量在配置文件中已提前设置）。
首选样式是使用 UTC 的数字偏移量，或者你可以写一个完整时区名称，
例如 Europe/Helsinki 而不是 EEST。
recovery_target_xid (string)
#
此参数指定恢复将执行的事务 ID。记住虽然事务 ID 是在事务开始时顺序分配的，
但是事务可能以不同的数字顺序完成。
那些在指定事务之前（也可以包括该事务）提交的事务将被恢复。
精确的停止点也受到recovery_target_inclusive的影响。
recovery_target_lsn (pg_lsn)
#
此参数指定恢复将继续进行的预写日志位置的 LSN。
精确的停止点也受到 recovery_target_inclusive的影响。
使用系统数据类型pg_lsn解析此参数。
下列选项进一步指定恢复目标，并且影响到达目标时会发生什么：
recovery_target_inclusive (boolean)
#
指定是否仅在指定的恢复目标之后停止（on），或者仅在恢复目标之前停止（off）。
适用于recovery_target_lsn、recovery_target_time或recovery_target_xid被指定的情况。
这个设置分别控制事务是否有准确的目标WAL位置（LSN）、提交时间或事务ID将被包括在该恢复中。默认值为on。
recovery_target_timeline (string)
#
指定恢复到一个特定的时间线。该值可以是数字时间线ID或特殊值。
值current沿着与执行基本备份时相同的时间线恢复。
值latest将恢复到归档中能找到的最新时间线，这在备用服务器中很有用。latest是默认值。
要以十六进制指定时间线ID（例如，从WAL文件名或历史文件中提取），请在其前面加上
0x。例如，如果WAL文件名是
00000011000000A10000004F，那么时间线ID是
0x11（或十进制的17）。
你通常只需要在复杂的重恢复情况下设置这个参数，在这种情况下你需要返回到一个状态，该状态本身是在一次时间点恢复之后到达的。
相关讨论见第 25.3.6 节。
recovery_target_action (enum)
#
指定在达到恢复目标时服务器应该采取的动作。默认动作是pause，这表示恢复将被暂停。
promote表示恢复处理将结束并且服务器将开始接受连接。
最后，shutdown将在达到恢复目标后停止服务器。
使用pause设置的目的是：如果这个恢复目标是恢复最想要的位置，就允许对数据库执行查询。
暂停的状态可以使用pg_wal_replay_resume()（见表 9.99）继续，这会让恢复终结。
如果这个恢复目标不是想要的停止点，那么关闭服务器，将恢复目标设置改为一个稍后的目标并重启以继续恢复。
要让实例在想要的重放点那里准备好，shutdown设置可以派上用场。
该实例将仍能重放更多 WAL 记录（并且事实上将不得不重放自上次检查点以来的 WAL 记录，下次启动时）。
注意由于在recovery_target_action被设置为shutdown时，recovery.signal将不会被移除，
任何后续的启动都将会以立刻关闭为终结，除非该配置被改变或者recovery.signal文件被手动移除。
如果没有设置恢复目标，这个设置没有效果。
如果没有启用hot_standby，pause设置的动作将和shutdown一样。
如果在升级期间达到恢复目标，pause的设置将与promote的行为相同。
在任何情况下，如果已配置了恢复目标，但归档恢复在达到目标之前结束，则服务器将关闭，并出现致命错误。
19.5.7. WAL 汇总 #
这些设置控制WAL汇总，这是一个必须启用的功能，才能执行
增量备份。
summarize_wal（boolean）
#
启用WAL汇总进程。请注意，WAL汇总可以在主服务器或备用服务器上启用。
该参数只能在postgresql.conf文件中或服务器命令行上设置。
默认值为off。
如果将 wal_level 设置为 minimal，则无法使用
summarize_wal=on 启动服务器。如果在服务器启动后配置了
summarize_wal=on，且 wal_level=minimal，
则汇总器会运行，但会拒绝为任何使用 wal_level=minimal
生成的WAL生成汇总文件。
wal_summary_keep_time (integer)
#
配置WAL汇总器自动删除旧WAL汇总的时间间隔。文件时间戳用于确定哪些文件
足够旧而被删除。通常，您应将此值设置得比备份与依赖该备份的后续增量备份
之间可能经过的时间长一些。WAL汇总必须覆盖前一次备份与当前备份之间的整
个WAL记录范围；否则，增量备份将失败。如果此参数设置为零，WAL汇总将不会
被自动删除，但您可以安全地手动删除那些您知道未来增量备份不再需要的文件。
此参数只能在postgresql.conf文件中或服务器命令行上设置。
如果未指定单位，则默认以分钟为单位。默认值为10天。如果summarize_wal = off，
无论此参数值如何，现有的WAL汇总都不会被删除，因为WAL汇总器不会运行。
上一页 上一级 下一页19.4. 资源消耗 起始页 19.6. 复制
