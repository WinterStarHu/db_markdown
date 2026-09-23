# 19.9. 运行时统计

19.9. 运行时统计
版本：
纠错本页面
搜索
目录导航
❮
❯
19.9. 运行时统计 #19.9.1. 累积查询和索引统计19.9.2. 统计监控19.9.1. 累积查询和索引统计 #
这些参数控制服务器范围内的累积统计系统。
启用后，收集的数据可以通过pg_stat和pg_statio
系列系统视图进行访问。有关更多信息，请参阅第 27 章。
track_activities (boolean)
#
启用对每个会话当前执行命令的信息收集，包括其标识符和命令开始执行的时间。
此参数默认为开启状态。请注意，即使启用了此信息，只有超级用户、具有
pg_read_all_stats角色特权的角色和拥有被报告会话的用户
（包括属于他们具有特权的角色的会话）才能看到此信息，因此不应构成安全风险。
只有超级用户和具有适当SET特权的用户才能更改此设置。
track_activity_query_size (integer)
#
为每个活动会话指定存储当前执行命令的文本所保留的内存量，它们被用于pg_stat_activity.query字段。
如果指定值时没有单位，则以字节为单位。默认值是1024字节。这个参数只能在服务器启动时被设置。
track_counts (boolean)
#
启用对数据库活动的统计信息收集。
此参数默认为开启，因为自动清理守护进程需要收集的信息。
只有超级用户和具有适当SET权限的用户才能更改此设置。
track_cost_delay_timing (boolean)
#
启用基于成本的VACUUM延迟的计时（参见
第 19.10.2 节）。此参数
默认关闭，因为它会重复查询操作系统以获取
当前时间，这可能会在某些平台上造成显著的开销。
您可以使用pg_test_timing工具来
测量系统上计时的开销。基于成本的VACUUM延迟
计时信息显示在
pg_stat_progress_vacuum，
pg_stat_progress_analyze，
在使用VACUUM和
ANALYZE时的输出中
当使用VERBOSE选项时，以及在
设置了log_autovacuum_min_duration时
由autovacuum进行的自动VACUUM和自动分析。
只有超级用户和具有适当SET
权限的用户才能更改此设置。
track_io_timing (boolean)
#
启用数据库I/O等待的计时。此参数默认关闭，
因为它会重复查询操作系统以获取
当前时间，这可能会在某些平台上造成显著的开销。
您可以使用pg_test_timing工具来
测量系统上计时的开销。
I/O计时信息显示在
pg_stat_database，
pg_stat_io（如果object
不是wal），在
pg_stat_get_backend_io()函数的输出中（如果
object 不是wal），在
使用BUFFERS选项时的EXPLAIN输出中，
在使用VERBOSE选项时的VACUUM输出中，
由autovacuum进行的自动VACUUM和自动分析，
当设置了log_autovacuum_min_duration时，以及
由pg_stat_statements。
只有超级用户和具有适当SET
权限的用户才能更改此设置。
track_wal_io_timing (boolean)
#
启用 WAL I/O 等待的计时。此参数默认关闭，
因为它会重复查询操作系统以获取当前时间，
这可能会在某些平台上造成显著的开销。
您可以使用 pg_test_timing 工具来
测量系统上计时的开销。
I/O 计时信息显示在
pg_stat_io 中
对于 object wal，以及在
pg_stat_get_backend_io() 函数的输出中
对于 object wal。
只有超级用户和具有适当 SET
权限的用户才能更改此设置。
track_functions (enum)
#
启用函数调用次数和时间的跟踪。指定pl以仅跟踪过程语言函数，
all以同时跟踪 SQL 和 C 语言函数。默认值为none，
即禁用函数统计跟踪。只有超级用户和具有适当 SET
权限的用户才能更改此设置。
注意
SQL 语言函数简单到足以被“内联”到调用查询中，将不会被跟踪，
而不管这个设置。
stats_fetch_consistency (enum)
#
确定在事务中多次访问累积统计信息时的行为。当设置为
none时，每次访问都会重新从共享内存中获取计数器。
当设置为cache时，对对象的统计信息的第一次访问会将这些统计信息缓存，
直到事务结束，除非调用pg_stat_clear_snapshot()。
当设置为snapshot时，第一次访问统计信息会缓存当前数据库中所有可访问的统计信息，
直到事务结束，除非调用pg_stat_clear_snapshot()。
在事务中更改此参数会丢弃统计快照。默认值为cache。
注意
none 最适合监控系统。如果值只被访问一次，它是最有效的。
cache 确保重复访问产生相同的值，这对涉及自连接的查询很重要。
snapshot 在交互式检查统计信息时可能很有用，但开销较高，
特别是存在许多数据库对象时。
19.9.2. 统计监控 #compute_query_id (enum)
#
启用查询标识符的内核计算。
查询标识符可以在 pg_stat_activity
视图中显示，使用 EXPLAIN，或者如果通过
log_line_prefix 参数进行配置，则可以在日志中发出。
pg_stat_statements 扩展还需要计算查询标识符。
请注意，如果内核查询标识符计算方法不可接受，也可以使用外部模块。
在这种情况下，必须始终禁用内核计算。
有效值为 off（始终禁用），
on（始终启用），auto，
允许诸如 pg_stat_statements 这样的模块
自动启用它，并且 regress 具有与
auto 相同的效果，只是查询标识符不会显示在
EXPLAIN 输出中，以便促进自动回归测试。
默认值为 auto。
注意
为确保仅计算和显示一个查询标识符，如果已经计算了查询标识符，计算查询标识符的扩展应抛出错误。
log_statement_stats (boolean)
log_parser_stats (boolean)
log_planner_stats (boolean)
log_executor_stats (boolean)
#
对于每个查询，将各自模块的性能统计输出到服务器日志中。这是一个简单的性能分析工具，类似于Unix getrusage()操作系统功能。
log_statement_stats报告总语句统计，而其他选项报告每个模块的统计信息。
log_statement_stats不能与任何单独模块选项一起启用。所有这些选项默认情况下都是禁用的。
只有超级用户和具有适当SET权限的用户才能更改这些设置。
上一页 上一级 下一页19.8. 错误报告和日志 起始页 19.10. 清理
