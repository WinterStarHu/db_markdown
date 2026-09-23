# F.3. auto_explain — 记录慢查询的执行计划

F.3. auto_explain — 记录慢查询的执行计划
版本：
纠错本页面
搜索
目录导航
❮
❯
F.3. auto_explain — 记录慢查询的执行计划 #F.3.1. 配置参数F.3.2. 示例F.3.3. 作者
auto_explain模块提供了一种方式来自动记录慢语句的执行计划，而不需要
手工运行EXPLAIN。这在大型应用中追踪未被优化的查询时有用。
该模块没有提供 SQL 可访问的函数。要使用它，简单地将它载入服务器。你可以把它载入到一个单独的
会话：
LOAD 'auto_explain';
（你必须作为超级用户来这样做）。更典型的用法是通过在postgresql.conf的session_preload_libraries或shared_preload_libraries参数中包括auto_explain将它预先
载入到某些或所有会话中。然后你就可以追踪那些出乎意料地慢的查询，而不管它们何时发生。当然为
此会付出一些额外的负荷作为代价。
F.3.1. 配置参数 #
有几个配置参数用来控制auto_explain的行为。注意默认行为是什么也不做，因此如果你想要任何结果就必须至少设置auto_explain.log_min_duration。
auto_explain.log_min_duration (integer)
#
auto_explain.log_min_duration是最小语句执行时间（以毫秒计），这将导致语句的计划被记录。这个参数设置为0时将记录所有计划，设置为-1（默认值）时禁用记录计划。例如，如果你将它设置为250ms，则所有运行时间等于或超过 250ms 的语句将被记录。只有超级用户能够改变这个设置。
auto_explain.log_parameter_max_length (integer)
#
auto_explain.log_parameter_max_length 控制查询参数值的
日志记录。值为-1（默认值）时，会完整记录参数值。
0会禁用参数值的日志记录。大于零的值会将每个参数值
截断为指定的字节数。只有超级用户可以更改此设置。
auto_explain.log_analyze (boolean)
#
auto_explain.log_analyze 导致 EXPLAIN ANALYZE
输出，而不仅仅是 EXPLAIN 输出，在执行计划被记录时打印。
默认情况下这个参数是关闭的。只有超级用户可以更改此设置。
注意
当这个参数开启时，对所有被执行的语句将引起对每个计划节点的计时，
不管它们是否运行得足够长以至于被记录。这可能对性能有极度负面的影响。
关闭 auto_explain.log_timing 可以减轻性能成本，
但会获得更少的信息。
auto_explain.log_buffers (boolean)
#
auto_explain.log_buffers 控制在执行计划被记录时是否打印
缓冲区使用统计信息；它等效于 EXPLAIN 的 BUFFERS 选项。
除非 auto_explain.log_analyze 被启用，否则这个参数没有效果。
默认情况下这个参数是关闭的。只有超级用户可以更改此设置。
auto_explain.log_wal (boolean)
#
auto_explain.log_wal 控制当执行计划被记录时是否打印WAL使用情况统计信息; 它相当于WAL 选项的EXPLAIN。
除非启用了auto_explain.log_analyze，否则这个参数不生效。
这个参数默认是关闭状态。只有超级用户能够改变这个设置。
auto_explain.log_timing (boolean)
#
auto_explain.log_timing 控制当一个执行计划被记录时是否打印每个结点上的计时信息；它等效于EXPLAIN的TIMING选项。重复读取
系统时钟的开销在某些系统上可能会显著地拖慢查询，因此当只需要实际行计数而非确切时间时，关闭
这个参数将会很有帮助。只有当auto_explain.log_analyze也被启用
时这个参数才有效。这个参数默认情况下是打开的。只有超级用户能够改变这个设置。
auto_explain.log_triggers (boolean)
#
auto_explain.log_triggers 会导致当一个执行计划被记录时触发器执行统计信息被包括在内。
只有当auto_explain.log_analyze也被启用时这个参数才有效。这个参数默认情况下是关闭的。只有超级用户能够改变这个设置。
auto_explain.log_verbose (boolean)
#
auto_explain.log_verbose 控制当一个执行计划被记录时是否打印很长的详细信息；它等效于EXPLAIN的VERBOSE选项。这个参数默认情况下是关闭的。只有超级用户能够改变这个设置。
auto_explain.log_settings (boolean)
#
auto_explain.log_settings 控制执行计划被日志记录时是否打印关于已修改的配置选项的信息。输出中仅包含影响查询计划的选项，其值与内置默认值不同。该参数默认关闭。仅超级用户可修改该设置。
auto_explain.log_format (enum)
#
auto_explain.log_format 选择要使用的 EXPLAIN 输出格式。允许的值是 text、xml、json 和 yaml。默认是 text。只有超级用户可以改变这个设置。
auto_explain.log_level (enum)
#
auto_explain.log_level 选择日志的级别，在此级别上，auto_explain 会记录查询计划。有效值为 DEBUG5、DEBUG4、DEBUG3、DEBUG2、DEBUG1、INFO、NOTICE、WARNING 和 LOG。缺省为 LOG。仅超级用户可修改该设置。
auto_explain.log_nested_statements (boolean)
#
auto_explain.log_nested_statements 导致嵌套语句（在一个函数内执行的语句）会被考虑在记录范围之内。当它被关闭时，只有顶层查询计划被记录。该参数默认情况下是关闭的。只有超级用户可以改变这个设置。
auto_explain.sample_rate (real)
#
auto_explain.sample_rate会让 auto_explain
只解释每个会话中的一部分语句。默认值为 1，表示解释所有的查询。在嵌套
语句的情况下，要么所有语句都被解释，要么一个也不被解释。只有超级用户
能够更改这个设置。
在普通用法中，这些参数都在postgresql.conf中设置，不过超级用户可以在他们自己的会话中随时修改这些参数。典型的用法可能是：
# postgresql.conf
session_preload_libraries = 'auto_explain'
auto_explain.log_min_duration = '3s'
F.3.2. 示例 #
postgres=# LOAD 'auto_explain';
postgres=# SET auto_explain.log_min_duration = 0;
postgres=# SET auto_explain.log_analyze = true;
postgres=# SELECT count(*)
FROM pg_class, pg_index
WHERE oid = indrelid AND indisunique;
这可能会产生这样的日志输出：
LOG:  duration: 3.651 ms  plan:
Query Text: SELECT count(*)
FROM pg_class, pg_index
WHERE oid = indrelid AND indisunique;
Aggregate  (cost=16.79..16.80 rows=1 width=0) (actual time=3.626..3.627 rows=1.00 loops=1)
->  Hash Join  (cost=4.17..16.55 rows=92 width=0) (actual time=3.349..3.594 rows=92.00 loops=1)
Hash Cond: (pg_class.oid = pg_index.indrelid)
->  Seq Scan on pg_class  (cost=0.00..9.55 rows=255 width=4) (actual time=0.016..0.140 rows=255.00 loops=1)
->  Hash  (cost=3.02..3.02 rows=92 width=4) (actual time=3.238..3.238 rows=92.00 loops=1)
Buckets: 1024  Batches: 1  Memory Usage: 4kB
->  Seq Scan on pg_index  (cost=0.00..3.02 rows=92 width=4) (actual time=0.008..3.187 rows=92.00 loops=1)
Filter: indisunique
F.3.3. 作者 #
Takahiro Itagaki <itagaki.takahiro@oss.ntt.co.jp>
上一页 上一级 下一页F.2. auth_delay — 认证失败时的暂停 起始页 F.4. basebackup_to_shell — 示例 "shell" pg_basebackup 模块
