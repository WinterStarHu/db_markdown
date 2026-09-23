# E.4. 发布 18

E.4. 发布 18
版本：
纠错本页面
搜索
目录导航
❮
❯
E.4. 发布 18 #E.4.1. 概述E.4.2. 迁移到版本 18E.4.3. 变更E.4.4. 致谢发布日期：. 2025-09-25E.4.1. 概述 #
PostgreSQL 18 包含许多新特性
和增强功能，包括：
一个异步 I/O (AIO) 子系统，可以提高顺序扫描、位图堆扫描、
清理和其他操作的性能。
pg_upgrade
现在保留优化器统计信息。
支持“跳过扫描”查找，允许在更多情况下使用
多列 B-tree 索引。
uuidv7()
函数用于生成时间戳排序的
UUIDs。
虚拟
生成列
在读取操作期间计算其值。这现在是
生成列的默认设置。
OAuth 认证 支持。
OLD 和 NEW 支持
RETURNING 子句
在 INSERT, UPDATE,
DELETE, 和 MERGE 命令中。
时间约束，或范围约束，用于
主键,
唯一, 和
外键
约束。
上述项目和其他新特性在
PostgreSQL 18 中的详细说明
在下面的章节中。
E.4.2. 迁移到版本 18 #
需要使用pg_dumpall进行转储/恢复，或者使用
pg_upgrade或逻辑复制来迁移数据，以从任何先前版本迁移。
有关迁移到新主要版本的一般信息，请参阅第 18.6 节。
版本 18 包含一些可能影响与
以前版本兼容性的更改。请注意以下不兼容性：
更改 initdb 默认以启用数据校验和
(Greg Sabino Mullane)
§
可以使用新的 initdb 选项
--no-data-checksums 禁用校验和。pg_upgrade
需要匹配的集群校验和设置，因此这个新选项可以
用于升级不带校验和的旧集群。
更改时区缩写处理 (Tom Lane)
§
系统现在将优先考虑当前会话的时区
缩写，然后再检查服务器变量
timezone_abbreviations。之前
timezone_abbreviations 是首先检查的。
弃用 MD5 密码
认证 (Nathan Bossart)
§
对 MD5 密码的支持将在未来的主要
版本发布中移除。CREATE ROLE 和 ALTER ROLE 在设置 MD5 密码时现在会发出弃用警告。
通过将 md5_password_warnings 参数设置为
off 可以禁用这些警告。
更改 VACUUM 和 ANALYZE
以处理父级的继承子项 (Michael Harris)
§
之前的行为可以通过使用新的
ONLY 选项来实现。
防止 COPY FROM
在读取 CSV 文件时将 \. 视为
文件结束标记 (Daniel Vérité, Tom Lane)
§
§
psql 在从 STDIN 读取
CSV 文件时仍将 \. 视为
文件结束标记。连接到 PostgreSQL 18
服务器的旧版 psql 客户端可能会遇到
\copy
问题。此版本还强制要求 \. 必须单独出现在一行上。
不允许无日志分区表 (Michael Paquier)
§
之前 ALTER TABLE SET
[UN]LOGGED 没有任何作用，创建无日志分区表
并不会导致其子表也变为无日志。
作为在触发器事件排队时处于活动状态的角色执行 AFTER
触发器 (Laurenz Albe)
§
之前此类触发器是在触发器执行时处于活动状态的角色下运行
(例如，在 COMMIT 时)。这在角色在排队时间
和事务提交之间发生变化的情况下是重要的。
移除 GRANT/REVOKE 中
对规则权限的非功能性支持 (Fujii Masao)
§
自 PostgreSQL 8.2 以来，这些功能一直没有
功能。
移除列 pg_backend_memory_contexts.parent
(Melih Mutlu)
§
由于添加了 pg_backend_memory_contexts.path
，这不再需要。
将 pg_backend_memory_contexts.level
和 pg_log_backend_memory_contexts()
更改为从 1 开始 (Melih Mutlu, Atsushi Torikoshi, David Rowley,
Fujii Masao)
§
§
§
之前这些是从 0 开始的。
更改 全文搜索 以使用集群的默认
排序提供程序来读取配置文件和字典，而不是始终使用 libc
(Peter Eisentraut)
§
默认使用非 libc 排序提供程序的集群 (例如，ICU，
内置) 对于由 LC_CTYPE 处理的字符，其行为可能与 libc 不同，
可能会观察到某些全文搜索函数的行为变化，以及 pg_trgm 扩展。
在使用 pg_upgrade 升级此类集群时，建议在升级后
重新索引与全文搜索和 pg_trgm 相关的所有索引。
E.4.3. 变更 #
在这里您将找到关于 PostgreSQL 18
与之前主要版本之间变化的详细说明。
E.4.3.1. 服务器 #E.4.3.1.1. 优化器 #
自动移除一些不必要的表自连接（Andrey Lepikhov,
Alexander Kuzmenkov, Alexander Korotkov, Alena Rybakina）
§
此优化可以通过服务器变量 enable_self_join_elimination 禁用。
将一些 IN (VALUES
...) 转换为 x = ANY ... 以获得
更好的优化器统计信息（Alena Rybakina, Andrei Lepikhov）
§
允许将 OR 子句
转换为数组，以加快索引处理速度（Alexander Korotkov,
Andrey Lepikhov）
§
加快 INTERSECT,
EXCEPT, 窗口聚合 和 视图列别名 的处理速度（Tom Lane,
David Rowley）
§
§
§
§
允许 SELECT
DISTINCT 的键在内部重新排序以避免排序
（Richard Guo）
§
此优化可以通过 enable_distinct_reordering 禁用。
忽略与其他列功能依赖的 GROUP BY
列（Zhang Mingli, Jian He, David Rowley）
§
如果 GROUP BY 子句包含唯一索引的所有列，以及同一表的其他列，
则这些其他列是多余的，可以从分组中删除。这对于非延迟主键已经成立。
允许一些 HAVING 子句
在 GROUPING
SETS 上被推送到 WHERE 子句
（Richard Guo）
§
§
§
§
这允许更早的行过滤。此版本还修复了一些以前返回
不正确结果的 GROUPING SETS 查询。
改进 generate_series()
的行估算，使用 numeric
和 timestamp
值（David Rowley, Song Jinzhou）
§
§
允许优化器使用 Right Semi Join 计划
（Richard Guo）
§
半连接用于需要查找是否至少有一个匹配的情况。
允许合并连接使用 增量排序
（Richard Guo）
§
提高访问多个分区的查询的规划效率
（Ashutosh Bapat, Yuya Watari, David Rowley）
§
§
允许在更多情况下使用 分区连接，
并减少其内存使用（Richard Guo, Tom Lane, Ashutosh Bapat）
§
§
改进分区查询的成本估算（Nikita Malakhov,
Andrei Lepikhov）
§
改进 SQL-语言
函数 的计划缓存（Alexander Pyhalov, Tom Lane）
§
§
改进对禁用优化器特性的处理（Robert Haas）
§
E.4.3.1.2. 索引 #
允许跳过扫描 btree 索引
（Peter Geoghegan）
§
§
这允许在更多情况下使用多列 btree 索引，例如当
第一个或早期索引列没有限制（或存在非等值限制），
并且后续索引列有用的限制时。
允许非-btree 唯一索引用作分区键和在物化视图中
（Mark Dilger）
§
§
索引类型仍然必须支持等值比较。
允许 GIN 索引
以并行方式创建（Tomas Vondra, Matthias van de Meent）
§
允许对值进行排序，以加速范围类型 GiST 和 btree
索引的构建（Bernd Helmle）
§
E.4.3.1.3. 通用性能 #
添加异步 I/O 子系统（Andres Freund, Thomas Munro,
Nazir Bilal Yavuz, Melanie Plageman）
§
§
§
§
§
§
§
§
§
§
§
此功能允许后端排队多个读取请求，
这使得顺序扫描、位图堆扫描、清理等操作更高效。
这由服务器变量 io_method 启用，
并添加了服务器变量 io_combine_limit 和 io_max_combine_limit 来控制它。
这还启用了 effective_io_concurrency
和 maintenance_io_concurrency
的值大于零，适用于不支持 fadvise() 的系统。
新的系统视图 pg_aios
显示用于异步 I/O 的文件句柄。
改进访问多个关系的查询的锁定性能
（Tomas Vondra）
§
提高哈希连接和
GROUP BY
的性能并减少内存使用
（David Rowley, Jeff Davis）
§
§
§
§
§
这也改善了 EXCEPT 使用的哈希集合操作
和子计划值的哈希查找。
允许正常的 VACUUM 冻结一些页面，即使它们是
全可见的（Melanie Plageman）
§
§
这减少了后续全关系
冻结的开销。可以通过服务器变量和每个表设置
vacuum_max_eager_freeze_failure_rate 控制
这一点。之前，VACUUM 从未处理全可见页面，直到需要冻结。
添加服务器变量 vacuum_truncate 以控制
在 VACUUM 期间的文件截断
（Nathan Bossart, Gurjeet Singh）
§
已经存在一个具有相同名称和行为的存储级参数。
将服务器变量 effective_io_concurrency 和 maintenance_io_concurrency 的默认值增加到 16
（Melanie Plageman）
§
§
这更准确地反映了现代硬件。
E.4.3.1.4. 监控 #
增加服务器变量 log_connections 的日志记录粒度
（Melanie Plageman）
§
这个服务器变量之前仅为布尔值，仍然
支持。
添加 log_connections 选项以报告
连接阶段的持续时间（Melanie Plageman）
§
添加 log_line_prefix 转义
%L 以输出客户端 IP
地址（Greg Sabino Mullane）
§
添加服务器变量 log_lock_failures 以记录
锁获取失败（Yuki Seino, Fujii Masao）
§
§
具体来说，它报告 SELECT
... NOWAIT 锁失败。
修改 pg_stat_all_tables
及其变体，以报告在 VACUUM, ANALYZE 及其
自动 变体中花费的时间
（Sami Imseih）
§
新列包括 total_vacuum_time、
total_autovacuum_time、
total_analyze_time 和
total_autoanalyze_time。
向 VACUUM 和 ANALYZE 添加延迟时间报告（Bertrand Drouvot, Nathan Bossart）
§
§
该信息出现在服务器日志中，系统视图 pg_stat_progress_vacuum
和 pg_stat_progress_analyze，
以及在 VERBOSE 模式下 VACUUM 和 ANALYZE 的输出中；必须通过服务器变量 track_cost_delay_timing 启用跟踪。
向 ANALYZE VERBOSE 添加 WAL、CPU 和平均
读取统计信息输出（Anthonin Bonnefoy）
§
§
向 VACUUM/ANALYZE (VERBOSE) 和 autovacuum 日志输出添加完整的 WAL 缓冲区计数（Bertrand Drouvot）
§
添加每个后端的 I/O 统计信息报告（Bertrand Drouvot）
§
§
统计信息通过 pg_stat_get_backend_io() 访问。
每个后端的 I/O 统计信息可以通过 pg_stat_reset_backend_stats() 清除。
向 pg_stat_io
列添加报告 I/O 活动的字节数（Nazir Bilal Yavuz）
§
新列包括 read_bytes、
write_bytes 和
extend_bytes。
op_bytes 列，始终等于
BLCKSZ，
已被移除。
向 pg_stat_io 添加 WAL I/O 活动行（Nazir Bilal Yavuz, Bertrand
Drouvot, Michael Paquier）
§
§
§
这包括 WAL 接收器活动和等待
此类写入的事件。
更改服务器变量 track_wal_io_timing
以控制在 pg_stat_io 中跟踪 WAL 时间
而不是在 pg_stat_wal
（Bertrand Drouvot）
§
从 pg_stat_wal 中移除读取/同步列（Bertrand Drouvot）
§
§
这移除了列 wal_write、
wal_sync、
wal_write_time 和
wal_sync_time。
添加函数 pg_stat_get_backend_wal()
以返回每个后端的 WAL 统计信息（Bertrand
Drouvot）
§
每个后端的 WAL
统计信息可以通过 pg_stat_reset_backend_stats()
清除。
添加函数 pg_ls_summariesdir()
以专门列出 PGDATA/pg_wal/summaries
的内容（Yushi Ogiwara）
§
添加列 pg_stat_checkpointer.num_done
以报告已完成的检查点数量（Anton A. Melnikov）
§
列 num_timed 和
num_requested 统计已完成和
跳过的检查点数量。
添加列
pg_stat_checkpointer.slru_written
以报告已写入的 SLRU 缓冲区数量（Nitin Jadhav）
§
此外，修改检查点服务器日志消息以报告单独的
共享缓冲区和 SLRU 缓冲区值。
向 pg_stat_database
添加列以报告并行工作者活动（Benoit Lobréau）
§
新列为
parallel_workers_to_launch 和
parallel_workers_launched。
使 查询 ID 的计算
仅考虑第一个和最后一个常量（Dmitry
Dolgov, Sami Imseih）
§
§
§
颠倒顺序由 pg_stat_statements 使用。
调整查询 ID 计算，以将使用相同关系名称的查询分组在一起（Michael Paquier, Sami Imseih）
§
即使不同模式中的表具有不同的列名，这也是正确的。
添加列 pg_backend_memory_contexts.type
以报告内存上下文的类型（David Rowley）
§
添加列
pg_backend_memory_contexts.path
以显示内存上下文的父级（Melih Mutlu）
§
E.4.3.1.5. 权限 #
添加函数 pg_get_acl()
以检索数据库访问控制详细信息（Joel Jacobson）
§
§
添加函数 has_largeobject_privilege()
来检查大对象权限（Yugo Nagata）
§
允许 ALTER DEFAULT PRIVILEGES 定义
大对象默认权限 (Takatsuka Haruka, Yugo Nagata,
Laurenz Albe)
§
添加预定义角色 pg_signal_autovacuum_worker
(Kirill Reshke)
§
这允许向 autovacuum 工作进程发送信号。
E.4.3.1.6. 服务器配置 #
添加对 OAuth 认证方法 的支持
(Jacob Champion, Daniel Gustafsson, Thomas Munro)
§
这为 pg_hba.conf
添加了一个 oauth 认证方法，libpq OAuth 选项，一个服务器变量 oauth_validator_libraries 用于加载
令牌验证库，以及一个配置标志 --with-libcurl
用于添加所需的编译时库。
添加服务器变量 ssl_tls13_ciphers 以允许
指定多个以冒号分隔的 TLSv1.3 密码套件
(Erica Zhang, Daniel Gustafsson)
§
更改服务器变量 ssl_groups 的默认值
以包括椭圆曲线 X25519 (Daniel Gustafsson, Jacob Champion)
§
将服务器变量 ssl_ecdh_curve 重命名为 ssl_groups 并允许指定多个以冒号分隔的
ECDH 曲线 (Erica Zhang,
Daniel Gustafsson)
§
之前的名称仍然有效。
将 取消请求键 设置为 256 位
(Heikki Linnakangas, Jelte Fennema-Nio)
§
§
这只有在服务器和客户端支持在此版本中引入的
3.2 版本的 wire 协议时才可能。
添加服务器变量 autovacuum_worker_slots
以指定最大后台工作进程数量 (Nathan Bossart)
§
设置此变量后，autovacuum_max_workers
可以在运行时调整到此最大值，而无需重启服务器。
允许指定固定数量的死元组，以触发一个 autovacuum
(Nathan Bossart, Frédéric Yhuel)
§
服务器变量是 autovacuum_vacuum_max_threshold。百分比仍然用于触发。
更改服务器变量 max_files_per_process
以限制仅由后端打开的文件（Andres Freund）
§
之前由主进程打开的文件也计入此限制。
添加服务器变量 num_os_semaphores 以报告所需的信号量数量（Nathan Bossart）
§
这对于操作系统配置非常有用。
添加服务器变量 extension_control_path 以指定扩展控制文件的位置（Peter Eisentraut,
Matheus Alcantara）
§
§
E.4.3.1.7. 流复制与恢复 #
允许使用服务器变量 idle_replication_slot_timeout 自动使非活动的复制槽失效
（Nisha Moond, Bharath Rupireddy）
§
添加服务器变量 max_active_replication_origins 以控制最大活动复制源（Euler Taveira）
§
这之前是由 max_replication_slots 控制的，但这个新设置允许在需要更少槽的情况下
有更高的源计数。
E.4.3.1.8. 逻辑复制 #
允许 生成列 进行逻辑复制（Shubham Khanna, Vignesh C,
Zhijie Hou, Shlok Kyal, Peter Smith）
§
§
§
§
如果发布指定了列列表，则所有指定的列，包括生成列和非生成列，都会被发布。
如果没有指定列列表，发布选项 publish_generated_columns 控制是否发布生成列。
之前生成列没有被复制，订阅者必须在可能的情况下计算这些值；这对于缺乏此能力的非PostgreSQL 订阅者特别有用。
将默认的 CREATE SUBSCRIPTION 流选项从 off 更改为 parallel
（Vignesh C）
§
允许 ALTER SUBSCRIPTION 更改复制槽的两阶段提交行为（Hayato Kuroda, Ajin
Cherian, Amit Kapila, Zhijie Hou）
§
§
在应用逻辑复制更改时记录 冲突（Zhijie Hou, Nisha Moond）
§
§
§
§
§
还在 pg_stat_subscription_stats 的新列中报告。
E.4.3.2. 实用命令 #
允许 生成列 为虚拟，并将其设为默认（Peter
Eisentraut, Jian He, Richard Guo, Dean Rasheed）
§
§
§
虚拟生成列在读取列时生成其值，而不是在写入时。写入行为仍然可以通过 STORED 选项进行指定。
在 DML 查询中为 RETURNING 添加 OLD/NEW 支持（Dean Rasheed）
§
之前 RETURNING 仅返回 INSERT 和 UPDATE 的新值，以及 DELETE 的旧值；MERGE 将返回执行的内部查询的适当值。
这种新语法允许 RETURNING 列表在 INSERT/UPDATE/DELETE/MERGE 中通过使用特殊别名 old 和 new 显式返回旧值和新值。这些别名可以重命名以避免标识符冲突。
允许像现有本地表一样创建外部表（Zhang Mingli）
§
语法为 CREATE FOREIGN TABLE ... LIKE。
允许 LIKE 与 非确定性排序 一起使用（Peter Eisentraut）
§
允许使用非确定性排序的文本位置搜索函数（Peter Eisentraut）
§
这些以前会生成错误。
添加内置排序提供者 PG_UNICODE_FAST（Jeff Davis）
§
此区域设置支持大小写映射，但按代码点顺序排序，而不是自然语言顺序。
允许 VACUUM 和 ANALYZE 处理分区表而不处理其子表（Michael Harris）
§
这可以通过新的 ONLY 选项启用。这是有用的，因为 autovacuum 不处理分区表，只处理其子表。
添加函数以修改每个关系和每列的优化器统计信息（Corey Huinker）
§
§
§
这些函数是 pg_restore_relation_stats()、pg_restore_attribute_stats()、pg_clear_relation_stats() 和 pg_clear_attribute_stats()。
添加服务器变量 file_copy_method 以控制
文件复制方法 (Nazir Bilal Yavuz)
§
这控制 CREATE DATABASE
... STRATEGY=FILE_COPY 和 ALTER DATABASE ... SET
TABLESPACE 是否使用文件复制或克隆。
E.4.3.2.1. 约束 #
允许指定不重叠的 主键、
唯一 和
外键
约束 (Paul A. Jungwirth)
§
§
这通过 WITHOUT OVERLAPS 为
PRIMARY KEY 和 UNIQUE 指定，通过
PERIOD 为外键，均适用于最后指定的列。
允许 CHECK
和 外键 约束被指定为 NOT
ENFORCED (Amul Sul)
§
§
这还添加了列 pg_constraint.conenforced。
要求 主/外键
关系使用确定性排序规则或相同的非确定性排序规则 (Peter Eisentraut)
§
如果不满足这些要求，pg_dump 的恢复也会失败，
该方法也被 pg_upgrade 使用；
必须进行模式更改以使这些升级方法成功。
将列 NOT
NULL 规范存储在 pg_constraint
(Álvaro Herrera, Bernd Helmle)
§
§
这允许为 NOT NULL 约束指定名称。
这还将 NOT NULL 约束添加到外部表，并将 NOT NULL 继承控制添加到本地表。
允许 ALTER TABLE 设置 NOT
VALID 属性的 NOT NULL 约束
(Rushabh Lathia, Jian He)
§
允许修改 NOT NULL 约束的继承性 (Suraj Kharage, Álvaro Herrera)
§
§
语法为 ALTER TABLE
... ALTER CONSTRAINT ... [NO] INHERIT。
允许在分区表上使用 NOT VALID 外键约束 (Amul Sul)
§
允许在分区表上删除
约束 仅 (Álvaro Herrera)
§
之前错误地禁止了这一操作。
E.4.3.2.2. COPY #
添加REJECT_LIMIT以控制COPY FROM
可以忽略的无效行数 (Atsushi Torikoshi)
§
当ON_ERROR = 'ignore'时可用。
允许COPY TO从已填充的物化视图中复制行
(Jian He)
§
添加COPY LOG_VERBOSITY级别
silent以抑制被忽略行的日志输出
(Atsushi Torikoshi)
§
这个新级别在on_error = 'ignore'时抑制被丢弃的输入行的输出。
不允许在外部表上使用COPY FREEZE (Nathan
Bossart)
§
之前，COPY可以工作，但FREEZE被忽略，因此禁止此命令。
E.4.3.2.3. EXPLAIN #
自动将BUFFERS输出包含在EXPLAIN ANALYZE中
(Guillaume Lelarge, David Rowley)
§
将完整的WAL缓冲区计数添加到EXPLAIN
(WAL)输出中 (Bertrand Drouvot)
§
在EXPLAIN ANALYZE中，报告每个索引扫描节点使用的索引查找次数
(Peter Geoghegan)
§
修改EXPLAIN以输出分数行计数
(Ibrar Ahmed, Ilia Evdokimov, Robert Haas)
§
§
将内存和磁盘使用详情添加到Material、
Window Aggregate和公共表表达式节点的EXPLAIN输出中
(David Rowley, Tatsuo Ishii)
§
§
§
§
将窗口函数参数的详细信息添加到EXPLAIN输出中
(Tom Lane)
§
将Parallel Bitmap Heap Scan工作线程缓存
统计信息添加到EXPLAIN ANALYZE中
(David Geier, Heikki Linnakangas, Donghang Lin, Alena Rybakina, David Rowley)
§
在EXPLAIN ANALYZE输出中指示禁用的节点
(Robert Haas, David Rowley, Laurenz Albe)
§
§
§
E.4.3.3. 数据类型 #
改进 Unicode
完全大小写映射和转换（Jeff Davis）
§
§
这增加了进行条件和标题大小写映射的能力，
并将单个字符的大小写映射到多个字符。
允许 jsonb
null 值被转换为标量类型为
NULL（Tom Lane）
§
之前这样的转换会产生错误。
向 json{b}_strip_nulls
添加可选参数，以允许移除 null 数组元素（Florents Tselai）
§
添加函数 array_sort()
用于对数组的第一维进行排序（Junwang Zhao, Jian He）
§
添加函数 array_reverse()
用于反转数组的第一维（Aleksander Alekseev）
§
添加函数 reverse()
用于反转 bytea 字节（Aleksander Alekseev）
§
允许在整数类型和 bytea 之间进行转换（Aleksander
Alekseev）
§
整数值以 bytea 的二进制补码形式存储。
更新 Unicode 数据至 Unicode 16.0.0（Peter
Eisentraut）
§
为爱沙尼亚语添加全文搜索 词干提取
（Tom Lane）
§
改进 XML
错误代码，使其更接近 SQL 标准
（Tom Lane）
§
这些错误通过 SQLSTATE
报告。
E.4.3.4. 函数 #
添加函数 casefold()
以允许更复杂的大小写不敏感匹配 (Jeff Davis)
§
这允许更准确的比较，即，一个字符可以有多个
大写或小写等价物，或者大写或小写转换会改变字符的数量。
允许 MIN()/MAX()
在数组和复合类型上进行聚合 (Aleksander Alekseev,
Marat Buharov)
§
§
向 EXTRACT()
添加 WEEK 选项 (Tom Lane)
§
改进负值的输出 EXTRACT(QUARTER ...) (Tom Lane)
§
向 to_number()
添加罗马数字支持 (Hunaid Sohail)
§
通过 RN 模式访问此功能。
添加 UUID
版本 7 生成函数 uuidv7()
(Andrey Borodin)
§
此 UUID 值是
时间上可排序的。函数别名 uuidv4()
已添加以显式生成版本 4 UUIDs。
添加函数 crc32()
和 crc32c()
以计算 CRC 值 (Aleksander Alekseev)
§
添加数学函数 gamma()
和 lgamma()
(Dean Rasheed)
§
允许在 PL/pgSQL 中使用
=> 语法作为命名游标参数 (Pavel Stehule)
§
我们之前只接受 :=。
允许 regexp_match[es]()/regexp_like()/regexp_replace()/regexp_count()/regexp_instr()/regexp_substr()/regexp_split_to_table()/regexp_split_to_array()
使用命名参数 (Jian He)
§
E.4.3.5. Libpq #
添加函数 PQfullProtocolVersion()
以报告完整的协议版本号，包括次要版本号（Jacob
Champion, Jelte Fennema-Nio）
§
添加 libpq 连接 参数
和 环境变量 以
指定连接的最小和最大可接受协议版本（Jelte Fennema-Nio）
§
§
向客户端报告 search_path 的更改
（Alexander Kukushkin, Jelte Fennema-Nio, Tomas Vondra）
§
§
添加 PQtrace() 输出
以支持所有消息类型，包括身份验证（Jelte Fennema-Nio）
§
§
§
§
§
添加 libpq 连接参数 sslkeylogfile
用于转储 SSL 密钥材料（Abhishek Chanda,
Daniel Gustafsson）
§
这对于调试非常有用。
修改一些 libpq 函数签名以使用
int64_t（Thomas Munro）
§
这些之前使用 pg_int64，现在已被弃用。
E.4.3.6. psql #
允许 psql 解析、绑定和关闭
命名的预处理语句（Anthonin Bonnefoy, Michael Paquier）
§
§
这通过新命令 \parse,
\bind_named,
和 \close_prepared 实现。
添加 psql 反斜杠命令以允许
发出管道查询（Anthonin Bonnefoy）
§
§
§
新命令为 \startpipeline,
\syncpipeline, \sendpipeline,
\endpipeline, \flushrequest,
\flush, 和 \getresults。
允许将管道状态添加到 psql
提示符，并添加相关状态变量（Anthonin Bonnefoy）
§
新的提示字符是 %P，新的 psql
变量是 PIPELINE_SYNC_COUNT,
PIPELINE_COMMAND_COUNT,
和 PIPELINE_RESULT_COUNT。
允许将连接服务名称添加到
psql 提示符中，或通过
psql 变量访问它（Michael Banck）
§
添加 psql 选项以在
所有列表命令中使用扩展模式（Dean Rasheed）
§
添加反斜杠后缀 x 启用此功能。
更改 psql 的 \conninfo 以使用表格格式
并包含更多信息（Álvaro Herrera, Maiquel Grassi,
Hunaid Sohail）
§
将函数的泄漏指示器添加到 psql 的 \df+、
\do+、\dAo+ 和
\dC+ 输出中（Yugo Nagata）
§
在 \dP+
中添加分区关系的访问方法详细信息（Justin Pryzby）
§
将 default_version
添加到 psql \dx
扩展输出中（Magnus Hagander）
§
添加 psql 变量 WATCH_INTERVAL 以设置默认的 \watch
等待时间（Daniel Gustafsson）
§
E.4.3.7. 服务器应用 #
更改 initdb 的默认设置以启用校验和
（Greg Sabino Mullane）
§
§
新的 initdb 选项
--no-data-checksums 禁用校验和。
添加 initdb 选项
--no-sync-data-files 以避免同步堆/索引
文件（Nathan Bossart）
§
initdb 选项 --no-sync
仍然可用以避免同步任何文件。
添加 vacuumdb 选项
--missing-stats-only 仅计算缺失的
优化器统计信息（Corey Huinker, Nathan Bossart）
§
§
此选项只能由超级用户运行，并且只能
与选项 --analyze-only 和
--analyze-in-stages 一起使用。
添加 pg_combinebackup 选项
-k/--link 以启用硬链接
（Israel Barth Rubio, Robert Haas）
§
只有某些文件可以进行硬链接。如果备份将独立使用，则不应使用此功能。
允许 pg_verifybackup 验证 tar 格式的备份（Amul Sul）
§
如果 pg_rewind's --source-server
指定了数据库名称，则在 --write-recovery-conf 输出中使用它（Masahiko Sawada）
§
添加 pg_resetwal 选项 --char-signedness 以更改默认的 char 符号性（Masahiko Sawada）
§
E.4.3.7.1. pg_dump/pg_dumpall/pg_restore #
添加 pg_dump 选项 --statistics（Jeff Davis）
§
§
添加 pg_dump 和 pg_dumpall 选项 --sequence-data 以转储通常会被排除的序列数据（Nathan Bossart）
§
§
添加 pg_dump, pg_dumpall,
和 pg_restore 选项
--statistics-only, --no-statistics,
--no-data, 和 --no-schema
（Corey Huinker, Jeff Davis）
§
添加选项 --no-policies 以禁用 pg_dump,
pg_dumpall, pg_restore 中的行级安全策略处理
（Nikolay Samokhvalov）
§
这对于迁移到具有不同策略的系统非常有用。
E.4.3.7.2. pg_upgrade #
允许 pg_upgrade 保留优化器统计信息（Corey Huinker, Jeff Davis, Nathan Bossart）
§
§
§
§
扩展统计信息不会被保留。还添加 pg_upgrade 选项
--no-statistics 以禁用统计信息的保留。
允许 pg_upgrade 并行处理数据库检查（Nathan Bossart）
§
§
§
§
§
§
§
§
§
§
§
这由现有的 --jobs 选项控制。
添加 pg_upgrade 选项 --swap 以交换目录而不是复制、克隆或链接文件（Nathan Bossart）
§
这种模式可能是最快的。
添加 pg_upgrade 选项
--set-char-signedness 以设置新集群的默认
char 符号性（Masahiko Sawada）
§
§
这是为了处理预先 PostgreSQL 18 集群的默认
CPU 符号性与新集群不匹配的情况。
E.4.3.7.3. 逻辑复制应用程序 #
添加 pg_createsubscriber 选项
--all 为所有数据库创建逻辑副本
（Shubham Khanna）
§
添加 pg_createsubscriber 选项
--clean 以移除发布（Shubham Khanna）
§
§
添加 pg_createsubscriber 选项
--enable-two-phase 以启用预处理事务
（Shubham Khanna）
§
添加 pg_recvlogical 选项
--enable-failover 以指定故障转移槽（Hayato Kuroda）
§
还添加选项 --enable-two-phase 作为
--two-phase 的同义词，并弃用后者。
允许 pg_recvlogical
--drop-slot 在没有
--dbname 的情况下工作（Hayato Kuroda）
§
E.4.3.8. 源代码 #
分离 注入点 的加载和运行
（Michael Paquier, Heikki Linnakangas）
§
§
现在可以通过 INJECTION_POINT_LOAD()
创建注入点，但不能运行，且可以通过 INJECTION_POINT_CACHED()
运行这些注入点。
支持注入点中的运行时参数（Michael Paquier）
§
允许使用 IS_INJECTION_POINT_ATTACHED()
的内联注入点测试代码（Heikki Linnakangas）
§
改善使用 JSON 字符串处理长
的性能，采用 SIMD（单指令多数据）（David
Rowley）
§
使用 x86 AVX-512 指令加速 CRC32C 计算
（Raghuveer Devulapalli, Paul Amonson）
§
为 popcount（整数位计数）添加 ARM Neon 和
SVE CPU 内置函数（Chiranmoy
Bhattacharya, Devanga Susmitha, Rama Malladi）
§
§
提高数字乘法和除法的速度（Joel
Jacobson, Dean Rasheed）
§
§
§
§
添加配置选项 --with-libnuma
以启用 NUMA 感知（Jakub Wartak, Bertrand
Drouvot）
§
§
§
函数 pg_numa_available()
报告 NUMA 感知，以及系统视图 pg_shmem_allocations_numa
和 pg_buffercache_numa
报告共享内存在 NUMA 节点之间的分布。
向 TOAST 表添加
到 pg_index
以允许非常大的表达式索引（Nathan Bossart）
§
移除列 pg_attribute.attcacheoff
（David Rowley）
§
向 pg_class.relallfrozen
添加列（Melanie Plageman）
§
向索引访问方法 API 添加 amgettreeheight,
amconsistentequality 和
amconsistentordering（Mark Dilger）
§
§
添加 GiST 支持函数 stratnum()
（Paul A. Jungwirth）
§
记录 char 的默认 CPU 符号性
在 pg_controldata
（Masahiko Sawada）
§
在 PL/Python 中添加对 Python "有限 API" 的支持（Peter Eisentraut）
§
§
这有助于防止由于 Python 3.x 版本不匹配而导致的问题。
将支持的最低 Python
版本更改为 3.6.8（Jacob Champion）
§
移除对低于 1.1.1 的 OpenSSL 版本的支持（Daniel Gustafsson）
§
§
如果启用了 LLVM，则需要版本 14
或更高版本（Thomas Munro）
§
添加宏 PG_MODULE_MAGIC_EXT
以允许扩展报告其名称和版本（Andrei Lepikhov）
§
此信息可以通过新函数 pg_get_loaded_modules()
访问。
文档说明 SPI_connect()/SPI_connect_ext()
始终返回成功 (SPI_OK_CONNECT)（Stepan
Neretin）
§
错误始终通过 ereport() 报告。
添加关于 API 和 ABI
兼容性的 文档部分 (David Wheeler, Peter Eisentraut)
§
移除 Meson 在 Windows 上的实验性标记 (Aleksander Alekseev)
§
移除配置选项 --disable-spinlocks 和
--disable-atomics (Thomas Munro)
§
§
现在需要 32 位原子操作。
移除对 HPPA/PA-RISC 架构的支持
(Tom Lane)
§
E.4.3.9. 附加模块 #
添加扩展 pg_logicalinspect 以检查逻辑快照 (Bertrand Drouvot)
§
添加扩展 pg_overexplain，该扩展向 EXPLAIN
输出添加调试细节 (Robert Haas)
§
向 postgres_fdw_get_connections()
添加输出列 (Hayato Kuroda, Sagar Dilip Shedge)
§
§
§
§
新输出列 used_in_xact 指示
外部数据包装器是否被当前事务使用，
closed 指示它是否已关闭，
user_name 指示用户名，以及
remote_backend_pid 指示远程
后端进程标识符。
允许从客户端传递 SCRAM
认证到 postgres_fdw 服务器 (Matheus Alcantara, Peter Eisentraut)
§
这避免了将 postgres_fdw
身份验证信息存储在数据库中，并通过 postgres_fdw
use_scram_passthrough
连接选项启用。 libpq 使用新的连接参数
scram_client_key 和 scram_server_key。
允许从客户端传递 SCRAM 身份验证到
dblink 服务器 (Matheus Alcantara)
§
向 file_fdw 添加 on_error 和
log_verbosity 选项 (Atsushi Torikoshi)
§
这些控制 file_fdw 如何处理和
报告无效的文件行。
添加 reject_limit 以控制 file_fdw
可以忽略的无效行数 (Atsushi Torikoshi)
§
当 ON_ERROR = 'ignore' 时激活。
向 passwordcheck 添加可配置变量
min_password_length (Emanuele Musella, Maurizio Boriani)
§
这控制最小密码长度。
让 pgbench 在每个脚本报告中报告失败、重试或跳过的事务数量
(Yugo Nagata)
§
添加 isn 服务器变量 weak
以控制无效校验位的接受 (Viktor Holmberg)
§
这之前仅由函数 isn_weak()
控制。
允许对值进行排序以加速 btree_gist
索引构建 (Bernd Helmle, Andrey Borodin)
§
添加 amcheck 检查函数 gin_index_check()
以验证 GIN 索引 (Grigory Kryachko, Heikki
Linnakangas, Andrey Borodin)
§
添加函数 pg_buffercache_evict_relation()
和 pg_buffercache_evict_all()
以驱逐未固定的共享缓冲区 (Nazir Bilal Yavuz)
§
现有函数 pg_buffercache_evict()
现在返回缓冲区刷新状态。
允许扩展安装自定义 EXPLAIN
选项 (Robert Haas, Sami Imseih)
§
§
§
允许扩展使用服务器的累积统计信息
API (Michael Paquier)
§
§
E.4.3.9.1. pg_stat_statements #
允许 CREATE TABLE AS
和 DECLARE 的查询被
pg_stat_statements 跟踪 (Anthonin Bonnefoy)
§
现在它们也被分配了查询 ID。
允许在 pg_stat_statements 中对 SET 值进行参数化 (Greg Sabino Mullane,
Michael Paquier)
§
这减少了由于不同常量的 SET 语句造成的膨胀。
添加 pg_stat_statements
列以报告并行活动 (Guillaume Lelarge)
§
新列为
parallel_workers_to_launch 和
parallel_workers_launched。
添加
pg_stat_statements.wal_buffers_full
以报告满的 WAL 缓冲区 (Bertrand Drouvot)
§
E.4.3.9.2. pgcrypto #
添加 pgcrypto 算法 sha256crypt
和 sha512crypt
(Bernd Helmle)
§
添加 CFB 模式
到 pgcrypto 加密和解密
(Umar Hayat)
§
添加函数 fips_mode()
以报告服务器的 FIPS 模式 (Daniel
Gustafsson)
§
添加 pgcrypto 服务器变量 builtin_crypto_enabled
以允许禁用内置的非 FIPS 模式
加密函数 (Daniel Gustafsson, Joe Conway)
§
这对于保证 FIPS 模式行为非常有用。
E.4.4. 致谢 #
以下个人（按字母顺序）作为补丁作者、提交者、审阅者、测试者或问题报告者为此版本的贡献者。
Abhishek ChandaAdam GuoAdam RauchAidar ImamovAjin CherianAlastair TurnerAlec CozensAleksander AlekseevAlena RybakinaAlex FriedmanAlex RichmanAlexander AlehinAlexander BorisovAlexander KorotkovAlexander KozhemyakinAlexander KukushkinAlexander KuzmenkovAlexander KuznetsovAlexander LakhinAlexander PyhalovAlexandra WangAlexey DvoichenkovAlexey MakhmutovAlexey ShishkinAli AkbarÁlvaro HerreraÁlvaro MongilAmit KapilaAmit LangoteAmul SulAndreas KarlssonAndreas ScherbaumAndreas UlbrichAndrei LepikhovAndres FreundAndrewAndrew BilleAndrew DunstanAndrew JacksonAndrew KaneAndrew WatkinsAndrey BorodinAndrey ChudnovskyAndrey RachitskiyAndrey RudometovAndy AlsupAndy FanAnthonin BonnefoyAnthony HsuAnthony LeungAnton MelnikovAnton VoloshinAntonin HouskaAntti LampinenArseniy MukhinArtur ZakirovArun ThirupathiAshutosh BapatAsphatorAtsushi TorikoshiAvi WeinbergAya IwataAyush TiwariAyush VatsaBastien RoucarièsBen Peachey HigdonBenoit LobréauBernd HelmleBernd ReißBernhard WiedemannBertrand DrouvotBertrand MamasamBharath RupireddyBogdan GrigorenkoBoyu YangBraulio Fdo GonzalezBruce MomjianBykov IvanCameron VogtCary HuangCédric VillemainCees van ZeelandChangAo ChenChao LiChapman FlackCharles SamborskiChengwen WuChengxi SunChiranmoy BhattacharyaChris GoochChristian CharukiewiczChristoph BergChristophe CourtoisChristopher InokuchiClemens RuckCorey HuinkerCraig MilhiserCrisp LeeDagfinn Ilmari MannsåkerDaniel ElishakovDaniel GustafssonDaniel VéritéDaniel WestermannDaniele VarrazzoDaniil DavydovDaria ShaninaDave CramerDave PageDavid BenjaminDavid ChristensenDavid FiedlerDavid G. JohnstonDavid GeierDavid RowleyDavid SteeleDavid WheelerDavid ZhangDavinder SinghDean RasheedDevanga SusmithaDevrim GündüzDian FayDilip KumarDimitrios ApostolouDipesh DhameliyaDmitrii BondarDmitry DolgovDmitry KovalDmitry KovalenkoDmitry YurichevDominique DevienneDonghang LinDorjpalam BatbaatarDrew CallahanDuncan SandsDwayne TowellDzmitry JachnikEgor ChindyaskinEgor RogovEmanuel IonescuEmanuele MusellaEmre HasegeliEric CyrErica ZhangErik NordströmErik RijkersErik WienholdErki EessaarEthan MertzEtienne LAFARGEEtsuro FujitaEuler TaveiraEvan SiEvgeniy GorbanevFabio R. SluzalaFabrízio de Royes MelloFeike SteenbergenFeliphe PozzerFelixFire EmeraldFlorents TselaiFrancesco DegrassiFrank StreitzigFrédéric YhuelFredrik WidlertGabriele BartoliniGavin PanellaGeoff WinklessGeorge MacKerronGilles DaroldGrant GryczanGreg BurdGreg Sabino MullaneGreg StarkGrigory KryachkoGuillaume LelargeGunnar MorlingGunnar WagnerGurjeet SinghHaifang WangHajime MatsunagaHamid AkhtarHannu KrosingHari Krishna SunderHaruka TakatsukaHayato KurodaHeikki LinnakangasHironobu SuzukiHolger JakobsHubert LubaczewskiHugo DuboisHugo ZhangHunaid SohailHywel CarverIan BarwickIbrar AhmedIgor GnatyukIgor KorotIlia EvdokimovIlya GladyshevIlyasov IanImran ZaheerIsaac MorlandIsrael Barth RubioIvan KushJacob BrazealJacob ChampionJaime CasanovaJakob EggerJakub WartakJames ColemanJames HunterJan BehrensJapin LiJason SmithJayesh DehankarJeevan ChalkeJeff DavisJehan-Guillaume de RorthaisJelte Fennema-NioJian HeJianghua YangJiao ShuntianJim JonesJim NasbyJingtang ZhangJingzhou FuJoe ConwayJoel JacobsonJohn HutchinsJohn NaylorJonathan KatzJorge SolórzanoJosé VillanovaJosef ŠimánekJoseph KoshakowJulien RouhaudJunwang ZhaoJustin PryzbyKaido VaiklaKaimehKarina LitskevichKarthik SKartyshov IvanKashif ZeeshanKeisuke KurodaKevin Hale BoyesKevin K BijuKirill ReshkeKirill ZdornyyKoen De GrooteKoichi SuzukiKoki NakamuraKonstantin KnizhnikKouhei SutouKuntal GhoshKyotaro HoriguchiLakshmi Narayana VelayudamLars KanisLaurence ParryLaurenz AlbeLele GaifaxLi YongLilian OntowheeLingbin MengLuboslav ŠpilákLuca VallisaLukas FittlMaciek SakrejdaMagnus HaganderMahendra Singh ThalorMahendrakar SrinivasaraoMaiquel GrassiMaksim KorotkovMaksim MelnikovMan ZengMarat BuharovMarc BalmerMarco NenciariniMarcos PegoraroMarina PolyakovaMark CallaghanMark DilgerMarlene BrandstaetterMarlene ReitererMartin RakhmanovMasahiko SawadaMasahiro IkedaMasao FujiiMason MackamanMat AryeMatheus AlcantaraMats KindahlMatthew Gabeler-LeeMatthew KimMatthew SterrettMatthew WoodcraftMatthias van de MeentMatthieu DenaisMaurizio BorianiMax JohnsonMax MaddenMaxim BogukMaxim OrlovMaximilian ChrzanMelanie PlagemanMelih MutluMert AlevMichael BanckMichael BondarenkoMichael ChristofidesMichael GuissineMichael HarrisMichaël PaquierMichail NikolaevMichal KleczekMichel PelletierMikaël GourlaouenMikhail GribkovMikhail KotMilosz ChmuraMuralikrishna BandaruMurat EfendiogluMutaamba MaashaNaeem AkhterNat MakarevitchNathan BossartNavneet KumarNazir Bilal YavuzNeil ConwayNiccolò FeiNick DaviesNicolas MausNiek BrasaNikhil RajNikitaNikita KalininNikita MalakhovNikolay SamokhvalovNikolay ShaplovNisha MoondNitin JadhavNitin MotianiNoah MischNoboru SaitoNoriyoshi ShinodaOle Peder BrandtzægOleg SibiryakovOleg TselebrovskiyOlleg SamoylovOnder KalaciOndrej NavratilPatrick StählinPaul AmonsonPaul JungwirthPaul RamseyPavel BorisovPavel LuzanovPavel NekrasovPavel StehulePeter EisentrautPeter GeogheganPeter MitterePeter SmithPhil EatonPhilipp SalvisbergPhilippe BeaudoinPierre GiraudPixian ShiPolina BunginaPrzemyslaw SztochQuynh TranRafia SabihRaghuveer DevulapalliRahila SyedRama MalladiRan BenitaRanier VilelaRenan Alves FonsecaRichard GuoRichard NeillRintaro IkedaRobert HaasRobert TreatRobins TharakanRoman ZharkovRonald CruzRonan DunklauRui ZhaoRushabh LathiaRustam AllakovRyo KanbayashiRyohei TakahashiRyotaKSagar Dilip ShedgeSalvatore DipietroSam GabrielssonSam JamesSameer KumarSami ImseihSamuel ThibaultSatyanarayana NarlapuramSebastian SkalackiSenglee ChoiSergei KornilovSergey BelyashovSergey DudoladovSergey ProkhorenkoSergey SargsyanSergey SolovievSergey TatarintsevShaik Mohammad MujeebShawn McCoyShenhao WangShihao ZhongShinya KatoShlok KyalShubham KhannaShveta MalikSimon RiggsSmolkin GrigorySofia KopikovaSong HongyuSong JinzhouSoumyadeep ChakrabortySravan KumarSrinath ReddyStan HuStepan NeretinStephen FewerStephen FrostSteve ChavezSteven NiuSuraj KharageSven KlemmTakamichi OsumiTakeshi IderihaTatsuo IshiiTed YuTelsTender WangTeodor SigaevThom BrownThomas BaehlerThomas KrennwallnerThomas MunroTim WoodTimur MagomedovTobias WendorffTodd CookTofig AlievTom LaneTomas VondraTomasz RybakTomasz SzypowskiTorsten FoertschToshi HaradaTristan PartinTriveni NUmar HayatVallimaharajan GVasya BoytsovVictor YegorovVignesh CViktor HolmbergVinícius AbrahãoVinod SridharanVirender SinglaVitaly DavydovVladlen PopolitovVladyslav NebozhynWalid IbrahimWebbo HanWenhui QiuWill MortensenWill StoreyWolfgang WaltherXin ZhangXing GuoXuneng ZhouYan ChengpenYang LeiYaroslav SaburovYaroslav SyrytsiaYasir HussainYasuo HondaYogesh SharmaYonghao LeeYoran HelingYu LiangYugo NagataYuhang QiuYuki SeinoYura SokolovYurii RashkovskiiYushi OgiwaraYusuke SugieYuta KatsuragiYuto SasakiYuuki FujiiYuya WatariZane DuffieldZeyuan HuZhang MingliZhihong YuZhijie HouZsolt Parragi上一页 上一级 下一页E.3. 版本 18.1 起始页 E.5. 先前版本
