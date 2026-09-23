# 19.4. 资源消耗

19.4. 资源消耗
版本：
纠错本页面
搜索
目录导航
❮
❯
19.4. 资源消耗 #19.4.1. 内存19.4.2. 磁盘19.4.3. 内核资源使用19.4.4. 后台写入器19.4.5. I/O19.4.6. 工作进程19.4.1. 内存 #shared_buffers (integer)
#
设置数据库服务器将使用的共享内存缓冲区量。默认通常是 128 兆字节（128MB），但是如果你的内核设置不支持（在initdb时决定），那么可能会更少。
这个设置必须至少为 128 千字节。不过为了更好的性能，通常会使用明显高于最小值的设置。
如果指定值时没有单位，则以块为单位，即BLCKSZ字节，通常为8kB。(BLCKSZ 的非默认值改变最小值。)
此参数只能在服务器启动时设置。
如果有一个专用的 1GB 或更多内存的数据库服务器，一个合理的shared_buffers开始值是系统内存的 25%。即使更大的shared_buffers设置在某些工作负载中也有效，但因为PostgreSQL同样依赖操作系统的缓存，将shared_buffers设置为超过 40% 的RAM不太可能比一个小的值工作得更好。为了将写入大量新数据或更改数据的过程分散在更长的时间段内，shared_buffers更大的设置通常要求对max_wal_size也做相应增加。
如果系统内存小于 1GB，一个较小的 RAM 百分比是合适的，这样可以为操作系统留下足够的空间。
huge_pages (enum)
#
控制是否请求主共享内存区域的巨大页面。有效值为 try
（默认值）、on 和 off。
此参数只能在服务器启动时设置。将 huge_pages 设置为
try，服务器将尝试请求巨大页面，但如果失败则回退到默认值。
将其设置为 on，请求巨大页面失败将阻止服务器启动。
将其设置为 off，则不会请求巨大页面。巨大页面的实际状态由
服务器变量 huge_pages_status 指示。
当前，只有 Linux 和 Windows 上支持这个设置。在其他系统上这个参数被设置为 try 时，它会被忽略。
在 Linux 中，它只在 shared_memory_type 设置为 mmap（默认）的时候被支持。
巨型页面的使用会导致更小的页面表以及花费在内存管理上的 CPU 时间更少，从而提高性能。更多有关 Linux 上使用巨型页面的细节请见 第 18.4.5 节。
巨型页在 Windows 上被称为大页面。
要使用大页面，需要为运行 PostgreSQL 的 Windows 用户账号分配 “Lock pages in memory” 的用户权限。
可以使用 Windows 的组策略工具（gpedit.msc）来分配用户权限 “Lock pages in memory”。
为了在命令窗口以单进程（而不是 Windows 服务）的方式启动数据库服务器，命令窗口必须以管理员身份运行或者禁用用户访问控制（UAC）。
当 UAC 被启用时，普通的命令窗口会在启动时收回用户权限 “Lock pages in memory”。
注意这种设置仅影响主共享内存区域。Linux、FreeBSD 以及 Illumos 之类的操作系统也能为普通内存分配自动使用巨型页（也被称为 “超级” 页或者 “大” 页面），而不需要来自 PostgreSQL 的显式请求。在 Linux 上，这被称为 “transparent huge pages”（THP，透明巨型页）。已知这种特性对某些 Linux 版本上的某些用户会导致 PostgreSQL 的性能退化，因此当前并不鼓励使用它（与 huge_pages 的显式使用不同）。
huge_page_size (integer)
#
控制巨型页的大小，当它们通过 huge_pages 时。
默认为零 (0)。
当设置为 0 时，将使用系统默认的巨型页大小。
这个参数只能在服务器启动时设置。
一些现代64位服务器体系结构上常用的有效页尺寸包括：
2MB 和 1GB (Intel and AMD),
16MB 和 16GB (IBM POWER),
还有 64kB, 2MB,32MB 和 1GB (ARM).
关于使用和支持的更多信息，参见第 18.4.5 节。
非默认设置当前仅在Linux上支持。
temp_buffers (integer)
#
为每个数据库会话设置用于临时缓冲区的最大内存。这些是仅用于访问临时表的会话本地缓冲。
如果指定值时没有单位，则以块为单位，即BLCKSZ字节，通常为8kB。
默认为8兆字节 (8MB)。(如果BLCKSZ不是8kB,则默认值按比例缩放。)
这个设置可以在独立的会话内部被改变，但是只有在会话第一次使用临时表之前才能改变；在会话中随后企图改变该值是无效的。
一个会话将按照temp_buffers给出的限制根据需要分配临时缓冲区。如果在一个并不需要大量临时缓冲区的会话里设置一个大的数值，其开销只是一个缓冲区描述符，或者说temp_buffers每增加一则增加大概 64 字节。不过，如果一个缓冲区被实际使用，那么它就会额外消耗 8192 字节（或者BLCKSZ字节）。
max_prepared_transactions (integer)
#
设置可以同时处于“prepared”状态的事务的最大数目（见PREPARE TRANSACTION）。把这个参数设置为零（这是默认设置）将禁用预备事务特性。这个参数只能在服务器启动时设置。
如果你不打算使用预备事务，可以把这个参数设置为零来防止意外创建预备事务。如果你正在使用预备事务，你将希望把max_prepared_transactions至少设置为max_connections一样大，因此每一个会话可以有一个预备事务待处理。
当运行一个备用服务器时，你必须设置这个参数等于或大于主服务器上的参数。
否则，备用服务器上将不允许查询。
work_mem (integer)
#
设置查询操作（如排序或哈希表）在写入临时磁盘文件之前可使用的基本最大内存量。
如果未指定单位，则将其视为千字节。默认值为四兆字节（4MB）。
请注意，复杂查询可能同时执行多个排序和哈希操作，
每个操作通常允许在开始将数据写入临时文件之前使用此值指定的内存量。
此外，可能有多个正在运行的会话同时执行此类操作。
因此，使用的总内存量可能是work_mem值的多倍；
在选择值时必须牢记这一事实。排序操作用于ORDER BY、DISTINCT和合并连接。
哈希表用于哈希连接、基于哈希的聚合、记忆节点和IN子查询的基于哈希的处理。
基于哈希的操作通常比等效的基于排序的操作更加敏感于内存可用性。
哈希表的内存限制是通过将work_mem乘以
hash_mem_multiplier来计算的。这使得
基于哈希的操作可以使用超过通常的work_mem基本
量的内存。
hash_mem_multiplier (floating point)
#
用于计算哈希操作可以使用的最大内存量。最终限制由将work_mem乘以hash_mem_multiplier确定。
默认值为2.0，这使得基于哈希的操作使用通常work_mem基础量的两倍。
考虑在查询操作频繁溢出的环境中增加hash_mem_multiplier，
特别是当简单增加work_mem导致内存压力时（内存压力通常表现为间歇性的内存不足错误）。
默认设置为2.0通常在混合工作负载中有效。在已将work_mem增加到40MB或更高的环境中，
可以考虑将设置调高至2.0-8.0或更高。
maintenance_work_mem (integer)
#
指定在维护性操作（例如VACUUM、CREATE INDEX和ALTER TABLE ADD FOREIGN KEY）中使用的最大内存量。
如果指定值时没有单位，则以千字节为单位，其默认值是64兆字节（64MB）。因为在一个数据库会话中，一个时刻只有一个这样的操作可以被执行，并且一个数据库安装通常不会有太多这样的操作并发执行，把这个数值设置得比work_mem大很多是安全的。更大的设置可以改进清理和恢复数据库转储的性能。
注意当自动清理运行时，可能会分配最多达这个内存的autovacuum_max_workers倍，因此要小心不要把该默认值设置得太高。
通过独立地设置autovacuum_work_mem可能会对控制这种情况有所帮助。
autovacuum_work_mem (integer)
#
指定每个自动清理工作者进程能使用的最大内存量。
如果指定值时没有单位，则以千字节为单位。
其默认值为-1，表示转而使用maintenance_work_mem的值。
当运行在其他上下文环境中时，这个设置对VACUUM的行为没有影响。
这个参数只能在postgresql.conf中或者服务器命令行上设置。
vacuum_buffer_usage_limit (integer)
#
指定由缓冲区访问策略
用于VACUUM和ANALYZE命令的大小。设置为
0时，操作可以使用任意数量的shared_buffers。
否则，有效大小范围是从128 kB到16 GB。如果指定的大小
超过了shared_buffers大小的1/8，则该大小会被静默限制为该值。
默认值是2MB。如果该值未指定单位，则默认以千字节计。该参数可以
随时设置。传递BUFFER_USAGE_LIMIT选项时，可以为VACUUM
和ANALYZE覆盖该设置。较高的设置可以让VACUUM和
ANALYZE运行更快，但设置过大可能导致太多其他有用页面从共享缓冲区中被
驱逐。
logical_decoding_work_mem (integer)
#
指定逻辑解码要使用的最大内存量，在将某些解码的更改写入本地磁盘之前。
这将限制逻辑流复制连接使用的内存量。它默认为64兆字节（64MB）。
由于每个复制连接仅使用此大小的单个缓冲区，并且安装通常不会同时具有多个此类连接（受max_wal_senders的限制），因此将此值设置得明显高于work_mem是安全的，从而减少写入磁盘的解码更改数量。
commit_timestamp_buffers (integer)
#
指定用于缓存pg_commit_ts内容的内存量（参见
表 66.1）。
如果该值未指定单位，则视为块数，即BLCKSZ字节，通常为8kB。
默认值为0，表示请求
shared_buffers/512，最多1024块，但不少于16块。
此参数只能在服务器启动时设置。
multixact_member_buffers (integer)
#
指定用于缓存pg_multixact/members内容的共享内存大小（参见
表 66.1）。
如果该值未指定单位，则视为块数，即BLCKSZ字节，通常为8kB。
默认值为32。
此参数只能在服务器启动时设置。
multixact_offset_buffers (integer)
#
指定用于缓存pg_multixact/offsets内容的共享内存大小（参见
表 66.1）。
如果该值未指定单位，则视为块数，即BLCKSZ字节，通常为8kB。
默认值为16。
此参数只能在服务器启动时设置。
notify_buffers (integer)
#
指定用于缓存pg_notify内容的共享内存大小（参见
表 66.1）。
如果该值未指定单位，则视为块数，即BLCKSZ字节，通常为8kB。
默认值为16。
此参数只能在服务器启动时设置。
serializable_buffers (integer)
#
指定用于缓存pg_serial内容的共享内存大小（参见
表 66.1）。
如果该值未指定单位，则视为块数，即BLCKSZ字节，通常为8kB。
默认值为32。
该参数只能在服务器启动时设置。
subtransaction_buffers (integer)
#
指定用于缓存pg_subtrans内容的共享内存大小（参见
表 66.1）。
如果该值未指定单位，则视为块数，即BLCKSZ字节，通常为8kB。
默认值为0，表示请求shared_buffers/512，最多1024块，
但不少于16块。
该参数只能在服务器启动时设置。
transaction_buffers (integer)
#
指定用于缓存pg_xact内容的共享内存大小（参见
表 66.1）。
如果该值未指定单位，则视为块数，即BLCKSZ字节，通常为8kB。
默认值为0，表示请求shared_buffers/512，最多1024块，
但不少于16块。
该参数只能在服务器启动时设置。
max_stack_depth (integer)
#
指定服务器执行栈的最大安全深度。此参数的理想设置是由内核强制执行的实际栈大小限制
（如由ulimit -s或本地等效设置），减去大约一兆字节的安全边界。
需要安全边界是因为服务器中并非每个例程都检查栈深度，而只在关键的潜在递归例程中检查。
如果未指定单位，则将其视为千字节。默认设置为两兆字节（2MB），
这是保守且不太可能引起崩溃的小值。但是，这可能太小，无法执行复杂函数。
只有超级用户和具有适当SET特权的用户才能更改此设置。
把max_stack_depth参数设置得高于实际的内核限制将意味着一个失控的递归函数可能会导致一个独立的后端进程崩溃。 在PostgreSQL能够检测内核限制的平台上， 服务器将不允许把这个参数设置为一个不安全的值。不过，并非所有平台都能提供该信息，所以我们还是建议在选择值时要小心。
shared_memory_type (enum)
#
指定服务器应使用的共享内存实现，用于保存
PostgreSQL 的共享缓冲区和其他共享数据的主共享内存区域。
可能的值为 mmap（用于使用 mmap 分配的匿名共享内存），
sysv（用于通过 shmget 分配的 System V 共享内存）
和 windows（用于 Windows 共享内存）。并非所有值在所有平台上都受支持；
第一个受支持的选项是该平台的默认值。使用 sysv 选项（在任何平台上都不是默认值）
通常不被推荐，因为它通常需要非默认的内核设置以允许大分配（请参见 第 18.4.1 节）。
此参数只能在服务器启动时设置。
dynamic_shared_memory_type (enum)
#
指定服务器应使用的动态共享内存实现。可能的值为
posix（用于使用 shm_open 分配的 POSIX 共享内存），
sysv（用于通过 shmget 分配的 System V 共享内存），
windows（用于 Windows 共享内存），
和 mmap（用于模拟使用存储在数据目录中的内存映射文件的共享内存）。
并非所有值在所有平台上都受支持；第一个受支持的选项通常是该平台的默认值。
使用 mmap 选项（在任何平台上都不是默认值）通常不被推荐，
因为操作系统可能会反复将修改过的页面写回磁盘，从而增加系统 I/O 负载；
但是，当 pg_dynshmem 目录存储在 RAM 磁盘上时，或者当其他共享内存设施不可用时，
它可能对调试有用。
此参数只能在服务器启动时设置。
min_dynamic_shared_memory (integer)
#
指定在服务器启动时将要分配给并行查询使用的内存容量。
当此内存区域不够用或被并发查询耗尽时，新的并行查询尝试使用dynamic_shared_memory_type配置的方法从操作系统临时分配额外的共享内存，由于内存管理开销该方法可能慢一些。
在启动时由min_dynamic_shared_memory分配的内存受到操作系统上所支持的huge_pages设置的影响，并且在自动管理的操作系统上更可能从较大的页面中受益。
默认值是0(无)。
该参数只能在服务器启动时设置。
19.4.2. 磁盘 #temp_file_limit (integer)
#
指定进程可以用于临时文件（如排序和哈希临时文件）或保留游标的存储文件的最大磁盘空间。
尝试超过此限制的事务将被取消。
如果未指定单位，则将其视为千字节。
-1（默认值）表示没有限制。
只有超级用户和具有适当SET权限的用户才能更改此设置。
这个设置约束着一个给定PostgreSQL进程在任何瞬间所使用的所有临时文件的总空间。
应该注意的是，与在查询执行中在幕后使用的临时文件相反，显式临时表所用的磁盘空间不被这个设置所限制。
file_copy_method (enum)
#
指定用于复制文件的方法。
可能的值为 COPY（默认）和
CLONE（如果操作支持可用）。
此参数影响：
CREATE DATABASE ... STRATEGY=FILE_COPY
ALTER DATABASE ... SET TABLESPACE ...
CLONE 使用 copy_file_range()
（Linux, FreeBSD）或 copyfile
（macOS）系统调用，给内核提供了共享磁盘块或在某些文件系统上将工作推向更低层的机会。
file_extend_method (enum)
#
指定在批量操作（如 COPY）期间用于扩展数据文件的方法。
第一个可用选项被用作默认值，具体取决于操作系统：
posix_fallocate （Unix）使用标准的 POSIX
接口来分配磁盘空间，但在某些系统上缺失。
如果它存在但底层文件系统不支持它，
此选项将默默回退到 write_zeros。
当前版本的 BTRFS 已知在使用此选项时禁用压缩。
在具有该功能的系统上，这是默认值。
write_zeros 通过写入零字节块来扩展文件。
在没有 posix_fallocate 功能的系统上，这是默认值。
当数据文件扩展 8 个块或更少时，总是使用 write_zeros 方法。
max_notify_queue_pages (integer)
#
指定 NOTIFY / LISTEN 队列的最大分配页面数。
默认值为 1048576。对于 8 KB 页面，它允许消耗
多达 8 GB 的磁盘空间。
此参数只能在服务器启动时设置。
19.4.3. 内核资源使用 #max_files_per_process (integer)
#
设置每个服务器子进程允许同时打开的最大文件数；
在 postmaster 中已经打开的文件不计入此限制。默认值为一
千个文件。
如果内核正在强制执行安全的每进程限制，您无需担心此设置。
但在某些平台上（尤其是大多数 BSD 系统），内核将
允许单个进程打开比系统实际支持的更多文件，如果多个进程都尝试打开
那么多文件。如果您发现出现 “打开的文件过多” 的错误，请尝试减少此设置。
此参数只能在服务器启动时设置。
19.4.4. 后台写入器 #
有一个独立的服务器进程，叫做后台写入器，它的功能就是发出写“脏”（新的或修改过的）共享缓冲区的命令。
当干净的共享缓冲区数量出现不足时，后台写入器写入一些脏缓冲区到文件系统，并标记为干净。
不过，后台写入器确实会增加 I/O 的总负荷，因为虽然在每个检查点间隔中一个重复弄脏的页面可能只会写出一次，但在同一个间隔中后台写入器可能会把它写出好几次。
在这一小节讨论的参数可以用于调节本地需求的行为。
bgwriter_delay (integer)
#
指定后台写入器活动轮之间的延迟时间。每轮写入器会对一定数量的脏缓冲区
（可通过以下参数控制）执行写操作。然后它会休眠bgwriter_delay指定的时间，
并重复此过程。当缓冲池中没有脏缓冲区时，无论bgwriter_delay的值如何，
它都会进入更长时间的休眠。如果该值未指定单位，则视为毫秒。默认值为200毫秒
（200ms）。请注意，在某些系统上，休眠延迟的有效分辨率为10毫秒；
将bgwriter_delay设置为非10的倍数的值，可能与设置为下一个更高的10的倍数
具有相同的效果。此参数只能在postgresql.conf文件中或服务器命令行上设置。
bgwriter_lru_maxpages (integer)
#
在每个轮次中，不超过这么多个缓冲区将被后台写入器写出。把这个参数设置为零可禁用后台写入（注意被一个独立、专用辅助进程管理的检查点不受影响）。默认值是100个缓冲区。
这个参数只能在postgresql.conf文件中或在服务器命令行上设置。
bgwriter_lru_multiplier (floating point)
#
每一轮次要写的脏缓冲区的数目基于最近几个轮次中服务器进程需要的新缓冲区的数目。最近所需的平均值乘以bgwriter_lru_multiplier可以估算下一轮次中将会需要的缓冲区数目。脏缓冲区将被写出直到有足够多的干净可重用的缓冲区（然而，每一轮次中写出的缓冲区数不超过bgwriter_lru_maxpages）。因此，设置为1.0表示一种“刚刚好的”策略，这种策略会写出正好符合预测值的数目的缓冲区。更大的值可以为需求高峰提供某种缓冲，而更小的值则需要服务器进程来处理一些写出操作。默认值是2.0。这个参数只能在postgresql.conf文件中或在服务器命令行上设置。
bgwriter_flush_after (integer)
#
只要后台写入的数据超过这个数量，尝试强制 OS 把这些写发送到底层存储上。这样做将限制内核页缓存中脏数据的量，降低了在检查点末尾发出一个 fsync 时或者 OS 在后台大批量写回数据时卡住的可能性。
那常常会导致大幅度减少事务延迟，但是也有一些情况（特别是负载超过shared_buffers但小于 OS 的页面缓存）的性能会降低。这种设置可能会在某些平台上没有效果。
如果指定值时没有单位，则以块为单位，即为BLCKSZ 字节，通常为8kB。合法的范围在0（禁用强制写回）和2MB之间。Linux 上的默认值是512kB，其他平台上是0（如果BLCKSZ不是8kB，则默认值和最大值会按比例缩放至这个值）。这个参数只能在postgresql.conf文件中或者服务器命令行上设置。
较小的bgwriter_lru_maxpages和bgwriter_lru_multiplier可以降低由后台写入器造成的额外 I/O 开销。但更可能的是，服务器进程将必须自己发出写入操作，这会延迟交互式查询。
19.4.5. I/O #backend_flush_after (integer)
#
当单个后端写入数据的量超过这个数量时，尝试强制操作系统发送这些写入到底层存储。
这样做将限制内核的页面缓存中的脏数据量，降低在检查点末尾发出fsync时暂停的可能性，或者当操作系统在后台大批量的写回数据时。
通常的结果会大大减少事务延迟，但也有一些情况，特别是当工作负载大于shared_buffers，但小于操作系统的页面缓存时，性能可能会下降。
此设置在某些平台上可能无效。
如果指定此值时没有单位，则将其作为块，即BLCKSZ字节，通常为8kB。
有效范围在0，禁止强制回写，和2MB之间。
默认值是0，即没有强制回写。
(如果BLCKSZ不是8kB，则最大值按其比例缩放。)
effective_io_concurrency (integer)
#
设置 PostgreSQL 期望可以同时执行的并发存储 I/O 操作的数量。
提高此值将增加任何单个 PostgreSQL
会话尝试并行发起的 I/O 操作数量。允许的范围是
1 到 1000，或
0 以禁用异步 I/O 请求的发出。
默认值为 16。
较高的值将对高延迟存储产生最大影响，
在这些存储上，查询会经历明显的 I/O 停滞，并且在
具有高 IOPs 的设备上。过高的值可能会增加系统上所有查询的 I/O 延迟。
在支持预取建议的系统上，
effective_io_concurrency 还控制预取距离。
通过设置同名的表空间参数，可以覆盖特定表的此值（见 ALTER TABLESPACE）。
maintenance_io_concurrency (integer)
#
与effective_io_concurrency相似，但用于维护工作，
该工作是代表许多客户端会话完成的。
默认值为 16。可以通过设置同名的表空间
参数来覆盖特定表中的此值（参见 ALTER TABLESPACE）。
io_max_combine_limit (integer)
#
控制合并 I/O 操作中的最大 I/O 大小，并默默限制用户可设置的
参数 io_combine_limit。此参数只能在服务器启动时设置。
如果未指定单位，则视为块，即 BLCKSZ 字节，通常为 8kB。
最大可能大小取决于操作系统和块大小，但在 Unix 上通常为 1MB，
在 Windows 上通常为 128kB。默认值为 128kB。
io_combine_limit (integer)
#
控制合并 I/O 操作中的最大 I/O 大小。如果设置的值高于
io_max_combine_limit 参数，则将默默使用较低的值，
因此可能需要同时提高这两个值以增加 I/O 大小。
如果未指定单位，则视为块，即 BLCKSZ 字节，通常为 8kB。
最大可能大小取决于操作系统和块大小，但在 Unix 上通常为 1MB，
在 Windows 上通常为 128kB。默认值为 128kB。
io_max_concurrency (integer)
#
控制一个进程可以同时执行的最大 I/O 操作数量。
-1 的默认设置基于 shared_buffers
和最大进程数量（max_connections、autovacuum_worker_slots、max_worker_processes 和 max_wal_senders），但不超过
64。
此参数只能在服务器启动时设置。
io_method (enum)
#
选择执行异步 I/O 的方法。
可能的值有：
worker（使用工作进程执行异步 I/O）
io_uring（使用 io_uring 执行异步 I/O，需使用
--with-liburing /
-Dliburing 构建）
sync（同步执行异步可用的 I/O）
默认值为 worker。
此参数只能在服务器启动时设置。
io_workers (integer)
#
选择要使用的 I/O 工作进程数量。默认值为 3。此参数只能在
postgresql.conf 文件或服务器命令行中设置。
仅在 io_method 设置为
worker 时有效。
19.4.6. 工作进程 #max_worker_processes (integer)
#
设置集群可以支持的最大后台进程数。此参数只能在服务器启动时设置。
默认值为 8。
在运行一个后备服务器时，你必须把这个参数设置为等于或高于主服务器上的值。
否则，后备服务器上将不允许查询。
在更改这个值时，考虑也对 max_parallel_workers、max_parallel_maintenance_workers 以及 max_parallel_workers_per_gather 进行调整。
max_parallel_workers_per_gather (integer)
#
设置单个Gather或Gather Merge节点能够开始的工作者的最大数量。并行工作者会从max_worker_processes建立的进程池中取得，数量由max_parallel_workers限制。注意所要求的工作者数量在运行时可能实际无法被满足。如果这种情况发生，该计划将会以比预期更少的工作者运行，这可能会不太高效。默认值是2。将这个值设置为0将禁用并行查询执行。
注意并行查询可能消耗比非并行查询更多的资源，因为每个工作者进程是一个完全独立的进程，它对系统产生的影响大致和一个额外的用户会话相同。在为这个设置选择值时，以及配置其他控制资源利用的设置（例如work_mem）时，应该把这个因素考虑在内。work_mem之类的资源限制会被独立地应用于每个工作者，这意味着所有进程的总资源利用可能会比单个进程时高得多。例如，一个使用4个工作者的并行查询使用的CPU时间、内存、I/O带宽可能是不使用工作者时的5倍之多。
并行查询的更多信息请见第 15 章。
max_parallel_maintenance_workers (integer)
#
设置单个实用命令可以启动的最大并行工作进程数。当前，支持使用并行工作进程的实用命令有CREATE INDEX在构建B-tree、GIN或BRIN索引时，以及VACUUM（不带FULL选项）。并行工作进程来自于由max_worker_processes建立的进程池，受max_parallel_workers限制。请注意，请求的工作进程数量在运行时可能并不可用。如果发生这种情况，实用操作将以少于预期的工作进程数运行。默认值为2。将此值设置为0将禁用实用命令使用并行工作进程。
注意并行工具性命令不应该消耗比同等数量非并行操作更多的内存。这种策略与并行查询不同，并行查询的资源限制通常是应用在每个工作者进程上。并行工具性命令把资源限制maintenance_work_mem当作对整个工具性命令的限制，而不管其中用到了多少个并行工作者进程。不过，并行工具性命令实际上可能仍会消耗更多的CPU资源和I/O带宽。
max_parallel_workers (integer)
#
设置集群支持的最大并行操作工作进程数。默认值为8。增加或减少此值时，
还应考虑调整max_parallel_maintenance_workers和
max_parallel_workers_per_gather。
另外，请注意，如果此值设置高于max_worker_processes，
则不会生效，因为并行工作进程是从该设置建立的工作进程池中分配的。
parallel_leader_participation (boolean)
#
允许leader进程在Gather 和 Gather Merge节点下执行查询计划，而不是等待worker进程。
默认值是on。
设置该值为off可以降低workers因为leader读取元组的速度不够快而被阻塞的可能性，但在第一个元组生成之前需要leader进程等待worker进程启动。
leader能帮助或阻碍性能的程度取决于计划类型，workers的数量和查询持续时间。
上一页 上一级 下一页19.3. 连接与认证 起始页 19.5. 预写日志
