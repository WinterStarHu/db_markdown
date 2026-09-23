# F.32. pg_stat_statements — 跟踪 SQL 规划和执行的统计信息

F.32. pg_stat_statements — 跟踪 SQL 规划和执行的统计信息
版本：
纠错本页面
搜索
目录导航
❮
❯
F.32. pg_stat_statements — 跟踪 SQL 规划和执行的统计信息 #F.32.1. The pg_stat_statements视图F.32.2. pg_stat_statements_info 视图F.32.3. 函数F.32.4. 配置参数F.32.5. 示例输出F.32.6. 作者
pg_stat_statements模块提供了一种跟踪服务器执行的所有 SQL 语句的计划和执行统计信息的方法。
该模块必须通过在postgresql.conf的shared_preload_libraries中增加pg_stat_statements来载入，因为它需要额外的共享内存。这意味着增加或移除该模块需要一次服务器重启。此外，必须启用查询标识符计算才能使模块处于活动状态。如果compute_query_id参数设置为auto或on，或者如果加载了计算查询标识符的第三方模块，则会自动完成此操作。
当pg_stat_statements激活时，它会跟踪该服务器的所有数据库的统计信息。该模块提供了一个视图pg_stat_statements以及函数pg_stat_statements_reset和pg_stat_statements用于访问和操纵这些统计信息。这些视图和函数不是全局可用的，但是可以用CREATE EXTENSION pg_stat_statements为特定数据库启用它们。
F.32.1. The pg_stat_statements视图 #
由该模块收集的统计信息可以通过一个名为pg_stat_statements的视图使用。这个视图的每一行都包含一个单独的数据库 ID、用户 ID 和查询 ID 以及它是否是顶级语句（最多到该模块可以追踪的可区分语句的数量）的组合。该视图的列如表 F.22中所示。
表 F.22. pg_stat_statements列
列类型
描述
userid oid
(references pg_authid.oid)
执行该语句的用户的OID
dbid oid
(references pg_database.oid)
在其中执行该语句的数据库的OID
toplevel bool
如果查询作为顶级语句执行则为真（pg_stat_statements.track设置为top时始终为真）
queryid bigint
用于识别相同规范化查询的哈希码。
query text
代表性语句的文本
plans bigint
计划语句的次数（如果启用了pg_stat_statements.track_planning，否则为零）
total_plan_time double precision
计划语句所花费的总时间，以毫秒为单位（如果启用了pg_stat_statements.track_planning，否则为零）
min_plan_time double precision
规划语句所花费的最短时间，单位为毫秒。如果pg_stat_statements.track_planning
被禁用，或者使用带有minmax_only参数设置为true的
pg_stat_statements_reset函数重置计数器后从未进行过规划，
该字段将为零。
max_plan_time double precision
规划语句所花费的最长时间，单位为毫秒。如果pg_stat_statements.track_planning
被禁用，或者使用带有minmax_only参数且设置为
true的pg_stat_statements_reset函数重置了计数器，
并且从未进行过规划，则该字段为零。
mean_plan_time double precision
规划语句所花费的平均时间，以毫秒为单位（如果启用了pg_stat_statements.track_planning，否则为零）
stddev_plan_time double precision
规划语句花费的时间的总体标准偏差，以毫秒为单位（如果启用了pg_stat_statements.track_planning，否则为零）
calls bigint
语句被执行的次数
total_exec_time double precision
执行语句所花费的总时间，以毫秒为单位
min_exec_time double precision
执行该语句所花费的最短时间，单位为毫秒，直到通过
pg_stat_statements_reset函数执行重置后，
并且minmax_only参数设置为true，
该字段才会显示非零值
max_exec_time double precision
执行该语句所花费的最长时间，单位为毫秒，直到通过
pg_stat_statements_reset函数执行重置后，
并且minmax_only参数设置为
true，该字段才会被首次赋值，之前为零
mean_exec_time double precision
执行语句的平均时间，以毫秒为单位
stddev_exec_time double precision
执行语句花费的时间的总体标准偏差，以毫秒为单位
rows bigint
语句检索或影响的总行数
shared_blks_hit bigint
语句的共享块缓存命中总数
shared_blks_read bigint
语句读取的共享块总数
shared_blks_dirtied bigint
被语句弄脏的共享块总数
shared_blks_written bigint
语句写入的共享块总数
local_blks_hit bigint
语句的本地块缓存命中总数
local_blks_read bigint
语句读取的本地块总数
local_blks_dirtied bigint
语句弄脏的本地块总数
local_blks_written bigint
语句写入的本地块总数
temp_blks_read bigint
语句读取的临时块总数
temp_blks_written bigint
语句写入的临时块总数
shared_blk_read_time double precision
语句读取共享块所花费的总时间，单位为毫秒
（如果启用了track_io_timing，否则为零）
shared_blk_write_time double precision
语句写入共享块所花费的总时间，单位为毫秒
（如果启用了track_io_timing，否则为零）
local_blk_read_time double precision
语句读取本地块所花费的总时间，单位为毫秒
（如果启用了track_io_timing，否则为零）
local_blk_write_time double precision
语句用于写入本地块的总时间，单位为毫秒
（如果启用了track_io_timing，否则为零）
temp_blk_read_time double precision
语句读取临时文件块的总时间，以毫秒为单位
（如果启用了track_io_timing，否则为零）
temp_blk_write_time double precision
语句写入临时文件块所花费的总时间，单位为毫秒
（如果启用了track_io_timing，否则为零）
wal_records bigint
语句生成的 WAL 记录总数
wal_fpi bigint
语句生成的 WAL 整页图像总数
wal_bytes numeric
语句生成的 WAL 总量（以字节为单位）
wal_buffers_full bigint
WAL 缓冲区变满的次数
jit_functions bigint
语句 JIT 编译的函数总数
jit_generation_time double precision
语句生成 JIT 代码所花费的总时间，以毫秒为单位
jit_inlining_count bigint
函数已内联的次数
jit_inlining_time double precision
语句在内联函数上花费的总时间，以毫秒为单位
jit_optimization_count bigint
语句已优化的次数
jit_optimization_time double precision
语句在优化过程中花费的总时间，以毫秒为单位
jit_emission_count bigint
代码已发出的次数
jit_emission_time double precision
语句在发出代码时花费的总时间，以毫秒为单位
jit_deform_count bigint
语句 JIT 编译的元组变形函数总数
jit_deform_time double precision
语句在JIT编译元组变形函数上花费的总时间，单位为毫秒
parallel_workers_to_launch bigint
计划启动的并行工作进程数量
parallel_workers_launched bigint
实际启动的并行工作进程数量
stats_since timestamp with time zone
该语句开始收集统计信息的时间
minmax_stats_since timestamp with time zone
该语句开始收集最小/最大统计信息的时间（字段
min_plan_time、
max_plan_time、
min_exec_time和
max_exec_time）
出于安全原因，只有超级用户和具有pg_read_all_stats角色特权的角色才被允许查看其他用户执行的查询的SQL文本和queryid。
其他用户可以查看统计信息，但是如果视图已经安装在他们的数据库中。
可计划的查询（即SELECT、INSERT、
UPDATE、DELETE和MERGE）
以及实用命令会根据内部哈希计算的结果，将具有相同查询结构的命令
合并为一个pg_stat_statements条目。通常，
如果两个查询在语义上等价，除了查询中出现的字面常量值不同之外，
它们会被视为相同。
注意
以下有关常量替换和queryid的详细信息仅适用于compute_query_id启用的情况。如果您使用外部模块来计算queryid，您应该参考该外部模块的文档以获取详细信息。
当为了把一个查询与其他查询匹配，常数值会被忽略，
在pg_stat_statements显示中它会被一个参数符号，
比如$1所替换。查询文本的剩余部分就是具有与该pg_stat_statements项相关的特定queryid哈希值的第一个查询的文本。
可以对其应用规范化的查询可能会在pg_stat_statements
中观察到常量值，特别是在条目释放率较高时。为了减少这种情况发生的可能性，
可以考虑增加pg_stat_statements.max的值。
下面在第 F.32.2 节中讨论的
pg_stat_statements_info视图提供了关于条目释放的统计信息。
在某些情况下，文本明显不同的查询可能会合并为一个
单一的 pg_stat_statements 条目；如上所述，
这在语义上等价的查询中是预期会发生的。
此外，如果查询之间唯一的区别是常量列表中的元素数量，
列表将被压缩为单个元素，但会显示为带有注释的列表指示符：
=# SELECT pg_stat_statements_reset();
=# SELECT * FROM test WHERE a IN (1, 2, 3, 4, 5, 6, 7);
=# SELECT * FROM test WHERE a IN (1, 2, 3, 4, 5, 6, 7, 8);
=# SELECT query, calls FROM pg_stat_statements
WHERE query LIKE 'SELECT%';
-[ RECORD 1 ]------------------------------
query | SELECT * FROM test WHERE a IN ($1 /*, ... */)
calls | 2
除了这些情况外，还有小概率的哈希冲突
导致无关的查询合并为一个条目。
（然而，这不会发生在属于不同用户或数据库的查询之间。）
由于queryid哈希值是根据查询被解析和分析后的表达计算的，对立的情况也可能存在：如果具有相同文本的查询由于因素（如不同的search_path设置）而具有不同的含义，它们就可能作为不同的项存在。
pg_stat_statements 的使用者可能希望使用
queryid（也许与
dbid 和 userid 结合使用）作为
每个条目的更稳定和可靠的标识符，而不是其查询文本。
然而，重要的是要理解，queryid 哈希
值的稳定性仅有有限的保证。由于标识符是从
解析后分析树派生的，其值是多个因素的函数，
包括在此表示中出现的内部对象标识符。
这有一些反直觉的影响。例如，
pg_stat_statements 将认为两个表面上相同的
查询是不同的，如果它们引用了例如在两个查询执行之间
被删除并重新创建的函数。
相反，如果在查询执行之间删除并重新创建了一个表，
两个表面上相同的查询可能会被视为相同。然而，如果
对于其他相似的查询，表的别名不同，这些查询将被视为
不同。
哈希过程对机器架构和平台的其他方面的差异也很敏感。
此外，不能安全地假设 queryid
在 PostgreSQL 的主要版本之间是稳定的。
基于物理WAL重放参与复制的两个服务器可以预期在相同查询中具有相同的queryid值。
然而，逻辑复制方案并不承诺保持副本在所有相关细节上完全相同，因此queryid将不是
用于在一组逻辑副本中累积成本的有用标识符。如果有疑问，建议进行直接测试。
通常可以假定queryid值在PostgreSQL的
小版本发布之间是稳定的，前提是实例在相同的机器架构上运行，并且目录元数据细节匹配。
兼容性只会在最后一种情况下在小版本之间被破坏。
代表性查询文本中用于替换常量的参数符号从原始查询文本中最高的
$n参数之后的下一个数字开始，
如果没有则为$1。值得注意的是，在某些情况下，
可能存在影响编号的隐藏参数符号。例如，PL/pgSQL
使用隐藏参数符号将函数局部变量的值插入到查询中，以便像
SELECT i + 1 INTO j的PL/pgSQL
语句将具有像SELECT i + $2这样的代表性文本。
有代表性的查询文本被保存在一个外部磁盘文件中，并且不会消耗共享内存。
因此，即便是很长的查询文本也能被成功地存储下来。不过，如果累积了很多
长的查询文本，该外部文件也会增长到很大。作为一种恢复方法，如果这样的
情况发生，pg_stat_statements可能会选择丢弃这些查询文本，
于是pg_stat_statements视图中的所有现有项将会显示空的
query域，不过与每个queryid相关联的
统计信息会被保留下来。如果发生这种情况，可以考虑减小
pg_stat_statements.max来防止复发。
plans和calls并不总是匹配的，
因为计划和执行统计信息在它们各自的结束阶段更新，并且仅适用于成功的操作。
例如，如果一条语句计划成功但在执行阶段失败，则只会更新其计划统计信息。
如果因为使用了缓存计划而跳过计划，则只会更新其执行统计信息。
F.32.2. pg_stat_statements_info 视图 #
通过视图pg_stat_statements_info来生成和记录pg_stat_statements 本身模块的统计信息。这个视图只有一行数据，视图列显示在 表 F.23中。
表 F.23. pg_stat_statements_info 列
列类型
描述
dealloc bigint
由于观察到比pg_stat_statements.max更多的不同语句，关于最少执行语句的pg_stat_statements条目被删除的总次数。
stats_reset timestamp with time zone
pg_stat_statements视图中所有统计信息上次重置的时间。
F.32.3. 函数 #
pg_stat_statements_reset(userid Oid, dbid Oid, queryid
bigint, minmax_only boolean) returns timestamp with time zone
pg_stat_statements_reset 丢弃到目前为止由
pg_stat_statements 收集的统计信息，这些统计信息对应于指定的
userid、dbid 和
queryid。如果未指定任何参数，则对每个参数使用默认值
0（无效），并重置与其他参数匹配的统计信息。如果未指定任何参数或所有指定的参数均为
0（无效），则会丢弃所有统计信息。
如果 pg_stat_statements 视图中的所有统计信息都被丢弃，
还会重置 pg_stat_statements_info 视图中的统计信息。
当 minmax_only 为 true 时，
仅重置最小和最大规划及执行时间的值（即
min_plan_time、max_plan_time、
min_exec_time 和 max_exec_time 字段）。
minmax_only 参数的默认值为 false。
最近一次执行最小/最大重置的时间显示在
minmax_stats_since 字段中，位于
pg_stat_statements 视图。
此函数返回重置的时间。该时间保存到
stats_reset 字段中，位于
pg_stat_statements_info 视图，或者如果实际执行了相应的重置，
则保存到 minmax_stats_since 字段中，位于
pg_stat_statements 视图。
默认情况下，此函数只能由超级用户执行。
可以使用 GRANT 授予其他用户访问权限。
pg_stat_statements(showtext boolean) returns setof record
pg_stat_statements视图按照一个也叫
pg_stat_statements的函数来定义。客户端可以直接调用
pg_stat_statements函数，并且通过指定
showtext := false来忽略查询文本（即，对应于视图的
query列的OUT参数将返回空值）。
这个特性是为了支持不想重复接收长度不定的查询文本的外部工具而设计的。
这类工具可以转而自行缓存第一个观察到的查询文本，因为这就是
pg_stat_statements自己所做的全部工作，并且只在需要的
时候检索查询文本。因为服务器会把查询文本存储在一个文件中，这种方法可
以降低重复检查pg_stat_statements数据的
物理 I/O。
F.32.4. 配置参数 #
pg_stat_statements.max (integer)
pg_stat_statements.max是由该模块跟踪的语句的最大数目（即pg_stat_statements视图中行的最大数量）。如果观察到的可区分的语句超过这个数量，最少被执行的语句的信息将会被丢弃。可以在pg_stat_statements_info视图中看到此类信息被丢弃的次数。默认值为5000。这个参数只能在服务器启动时设置。
pg_stat_statements.track (enum)
pg_stat_statements.track控制哪些语句会被该模块计数。指定top可以跟踪顶层语句（那些直接由客户端发出的语句），指定all还可以跟踪嵌套的语句（例如在函数中调用的语句），指定none可以禁用语句统计信息收集。默认值是top。
只有超级用户可以更改这个设置。
pg_stat_statements.track_utility (boolean)
pg_stat_statements.track_utility控制模块是否跟踪实用命令。
实用命令是除了SELECT、INSERT、
UPDATE、DELETE和MERGE之外的所有命令。
默认值为on。
只有超级用户可以更改此设置。
pg_stat_statements.track_planning (boolean)
pg_stat_statements.track_planning控制模块是否跟踪计划操作和持续时间。
启用此参数可能会导致明显的性能损失，尤其是当具有相同查询结构的 SQL 语句由许多竞争更新少数pg_stat_statements条目的并发连接执行时。
默认值为off。只有超级用户才能更改此设置。
pg_stat_statements.save (boolean)
pg_stat_statements.save指定是否在服务器关闭之后还保存语句统计信息。如果被设置为off，那么关闭后不保存统计信息并且在服务器启动时也不会重新载入统计信息。默认值为on。这个参数只能在postgresql.conf文件中或者在服务器命令行上设置。
该模块要求与pg_stat_statements.max成比例的额外共享内存。注意只要该模块被加载就会消耗这么多的内存，即便pg_stat_statements.track被设置为none。
这些参数必须在postgresql.conf中设置。典型的用法可能是：
# postgresql.conf
shared_preload_libraries = 'pg_stat_statements'
compute_query_id = on
pg_stat_statements.max = 10000
pg_stat_statements.track = all
F.32.5. 示例输出 #
bench=# SELECT pg_stat_statements_reset();
$ pgbench -i bench
$ pgbench -c10 -t300 bench
bench=# \x
bench=# SELECT query, calls, total_exec_time, rows, 100.0 * shared_blks_hit /
nullif(shared_blks_hit + shared_blks_read, 0) AS hit_percent
FROM pg_stat_statements ORDER BY total_exec_time DESC LIMIT 5;
-[ RECORD 1 ]---+--------------------------------------------------​------------------
query           | UPDATE pgbench_branches SET bbalance = bbalance + $1 WHERE bid = $2
calls           | 3000
total_exec_time | 25565.855387
rows            | 3000
hit_percent     | 100.0000000000000000
-[ RECORD 2 ]---+--------------------------------------------------​------------------
query           | UPDATE pgbench_tellers SET tbalance = tbalance + $1 WHERE tid = $2
calls           | 3000
total_exec_time | 20756.669379
rows            | 3000
hit_percent     | 100.0000000000000000
-[ RECORD 3 ]---+--------------------------------------------------​------------------
query           | copy pgbench_accounts from stdin
calls           | 1
total_exec_time | 291.865911
rows            | 100000
hit_percent     | 100.0000000000000000
-[ RECORD 4 ]---+--------------------------------------------------​------------------
query           | UPDATE pgbench_accounts SET abalance = abalance + $1 WHERE aid = $2
calls           | 3000
total_exec_time | 271.232977
rows            | 3000
hit_percent     | 98.8454011741682975
-[ RECORD 5 ]---+--------------------------------------------------​------------------
query           | alter table pgbench_accounts add primary key (aid)
calls           | 1
total_exec_time | 160.588563
rows            | 0
hit_percent     | 100.0000000000000000
bench=# SELECT pg_stat_statements_reset(0,0,s.queryid) FROM pg_stat_statements AS s
WHERE s.query = 'UPDATE pgbench_branches SET bbalance = bbalance + $1 WHERE bid = $2';
bench=# SELECT query, calls, total_exec_time, rows, 100.0 * shared_blks_hit /
nullif(shared_blks_hit + shared_blks_read, 0) AS hit_percent
FROM pg_stat_statements ORDER BY total_exec_time DESC LIMIT 5;
-[ RECORD 1 ]---+--------------------------------------------------​------------------
query           | UPDATE pgbench_tellers SET tbalance = tbalance + $1 WHERE tid = $2
calls           | 3000
total_exec_time | 20756.669379
rows            | 3000
hit_percent     | 100.0000000000000000
-[ RECORD 2 ]---+--------------------------------------------------​------------------
query           | copy pgbench_accounts from stdin
calls           | 1
total_exec_time | 291.865911
rows            | 100000
hit_percent     | 100.0000000000000000
-[ RECORD 3 ]---+--------------------------------------------------​------------------
query           | UPDATE pgbench_accounts SET abalance = abalance + $1 WHERE aid = $2
calls           | 3000
total_exec_time | 271.232977
rows            | 3000
hit_percent     | 98.8454011741682975
-[ RECORD 4 ]---+--------------------------------------------------​------------------
query           | alter table pgbench_accounts add primary key (aid)
calls           | 1
total_exec_time | 160.588563
rows            | 0
hit_percent     | 100.0000000000000000
-[ RECORD 5 ]---+--------------------------------------------------​------------------
query           | vacuum analyze pgbench_accounts
calls           | 1
total_exec_time | 136.448116
rows            | 0
hit_percent     | 99.9201915403032721
bench=# SELECT pg_stat_statements_reset(0,0,0);
bench=# SELECT query, calls, total_exec_time, rows, 100.0 * shared_blks_hit /
nullif(shared_blks_hit + shared_blks_read, 0) AS hit_percent
FROM pg_stat_statements ORDER BY total_exec_time DESC LIMIT 5;
-[ RECORD 1 ]---+--------------------------------------------------​---------------------------
query           | SELECT pg_stat_statements_reset(0,0,0)
calls           | 1
total_exec_time | 0.189497
rows            | 1
hit_percent     |
-[ RECORD 2 ]---+--------------------------------------------------​---------------------------
query           | SELECT query, calls, total_exec_time, rows, $1 * shared_blks_hit /          +
|                nullif(shared_blks_hit + shared_blks_read, $2) AS hit_percent+
|           FROM pg_stat_statements ORDER BY total_exec_time DESC LIMIT $3
calls           | 0
total_exec_time | 0
rows            | 0
hit_percent     |
F.32.6. 作者 #
Takahiro Itagaki <itagaki.takahiro@oss.ntt.co.jp>。Peter Geoghegan <peter@2ndquadrant.com>为其加入了查询正规化的功能。
上一页 上一级 下一页F.31. pgrowlocks — 显示表的行锁定信息 起始页 F.33. pgstattuple — 获取元组级别的统计信息
