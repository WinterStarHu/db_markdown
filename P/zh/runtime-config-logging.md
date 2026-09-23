# 19.8. 错误报告和日志

19.8. 错误报告和日志
版本：
纠错本页面
搜索
目录导航
❮
❯
19.8. 错误报告和日志 #19.8.1. 日志记录位置19.8.2. 何时记录日志19.8.3. 记录什么到日志19.8.4. 使用 CSV 格式的日志输出19.8.5. 使用JSON格式的日志输出19.8.6. 进程标题19.8.1. 日志记录位置 #log_destination (string)
#
PostgreSQL 支持多种记录服务器消息的方法，包括
stderr，csvlog，
jsonlog 和
syslog。在 Windows 上，
eventlog 也受支持。将此参数设置为以逗号分隔的所需日志目的地列表。默认情况下仅记录到
stderr。
此参数只能在 postgresql.conf
文件或服务器命令行中设置。
如果 csvlog 包含在 log_destination 中，
日志条目将以 “逗号分隔值” (CSV) 格式输出，
这对于将日志加载到程序中非常方便。
有关详细信息，请参见 第 19.8.4 节。
logging_collector 必须启用以生成
CSV 格式的日志输出。
如果 jsonlog 包含在
log_destination 中，日志条目将以
JSON 格式输出，这对于将日志加载到程序中非常方便。
有关详细信息，请参见 第 19.8.5 节。
logging_collector 必须启用以生成
JSON 格式的日志输出。
当包含 stderr、csvlog 或 jsonlog 时，
文件 current_logfiles 会被创建，记录日志收集器当前使用的日志文件位置和相关的日志目的地。
这提供了一种方便的方式来查找实例当前使用的日志。以下是该文件内容的示例：
stderr log/postgresql.log
csvlog log/postgresql.csv
jsonlog log/postgresql.json
当由于轮换而创建新的日志文件时，以及重新加载 log_destination 时，current_logfiles 会被重新创建。
当 log_destination 中不包含 stderr、csvlog 或 jsonlog，
以及日志收集器被禁用时，它会被移除。
注意
在大多数 Unix 系统上，你将需要修改系统的syslog守护进程的配置来使用log_destination的syslog选项。PostgreSQL可以在syslog设施LOCAL0到LOCAL7中记录（见syslog_facility），但是大部分平台上的默认syslog配置会丢弃所有这种消息。你将需要增加这样的内容：
local0.*    /var/log/postgresql
到syslog守护进程的配置文件来让它工作。
在 Windows 上，当你使用log_destination的eventlog选项时，你应该在操作系统中注册一个事件源及其库，这样 Windows 事件查看器能够清楚地显示事件日志消息。详见第 18.12 节。
logging_collector (boolean)
#
这个参数启用日志收集器，它是一个捕捉被发送到stderr的日志消息的后台进程，并且它会将这些消息重定向到日志文件中。这种方法比记录到syslog通常更有用，因为某些类型的消息不会在syslog输出中出现（一个常见的例子是动态链接器错误消息；另一个例子是由archive_command等脚本产生的错误消息）。这个参数只能在服务器启动时设置。
注意
也可以不使用日志收集器而把日志记录到stderr，日志消息将只会去到服务器的stderr被定向到的位置。不过，那种方法只适合于低日志量，因为它没有提供方便的方式来轮转日志文件。还有，在某些不使用日志收集器的平台上可能会导致丢失或者混淆日志输出，因为多个进程并发写入同一个日志文件时会覆盖彼此的输出。
注意
日志收集器被设计成从来不会丢失消息。这意味着在极高的负载下，如果服务器进程试图在收集器已经落后时发送更多的日志消息，那么它会被阻塞。相反，syslog倾向于在无法写入消息时丢掉消息，这意味着在这样的情况下它可能会无法记录某些消息，但是它不会阻塞系统的其他部分。
log_directory (string)
#
当logging_collector被启用时，这个参数决定日志文件将被在哪个目录下创建。它可以被指定为一个绝对路径，也可以被指定为一个相对于集群数据目录的相对路径。这个参数只能在postgresql.conf文件中或在服务器命令行上设置。
默认是log。
log_filename (string)
#
当logging_collector被启用时，这个参数设置被创建的日志文件的文件名。
该值被视为一种strftime模式，因此%转义可以被用来指定时间变化的文件名。 (注意如果有
任何时区依赖的%转义，计算将在由log_timezone指定的时区中完成。)
被支持的%转义和开放组织的strftime
说明中列举的类似。
注意系统的strftime不会被直接使用，因此平台相关（非标准）的扩展无法工作。
默认是postgresql-%Y-%m-%d_%H%M%S.log。
如果你不使用转义来指定一个文件名，你应该计划使用一个日志轮转工具来避免最终填满整个磁盘。在 8.4 发行之前，如果不存在%转义，PostgreSQL将追加新日志文件创建时间的纪元，但是现在已经不再这样做了。
如果在log_destination中启用了 CSV 格式输出，.csv将会被追加到时间戳日志文件名中来创建 CSV 格式输出。
(如果log_filename以.log结尾，该后缀会被替换。)
如果在log_destination中启用了 JSON 格式输出，.json将会被追加到时间戳日志文件名中来创建 JSON 格式输出。
(如果log_filename以.log结尾，该后缀会被替换。)
这个参数只能在postgresql.conf文件中或通过服务器命令行进行设置。
log_file_mode (integer)
#
在 Unix 系统上，当logging_collector被启用时，这个参数设置日志文件的权限。 (在微软 Windows 上这个参数将被忽略。)
这个参数值应当是一个数字形式的模式，它可以被chmod和umask系统调用接受。 (要使用通常的八进制格式，该数字必须以一个0（零）开始。)
默认的权限是0600，表示只有服务器拥有者才能读取或写入日志文件。其他常用的设置是0640，它允许拥有者的组成员读取文件。不过要注意你需要修改log_directory为将文件存储在表空间数据目录之外的某个位置，才能利用这个设置。在任何情况下，让日志文件变成任何人都可读是不明智的，因为日志文件中可能包含敏感数据。
这个参数只能在postgresql.conf文件中或通过服务器命令行进行设置。
log_rotation_age (integer)
#
当logging_collector被启用时，这个参数决定使用一个单个日志文件的最大时间量，之后将创建一个新的日志文件。
如果指定值时没有单位，则以分钟为单位。默认为24小时。
将这个参数设置为零将禁用基于时间的新日志文件创建。这个参数只能在postgresql.conf文件中或在服务器命令行上设置。
log_rotation_size (integer)
#
当logging_collector被启用时，这个参数决定一个个体日志文件的最大尺寸。
当这些数据量被发送到一个日志文件后，将创建一个新的日志文件。
如果指定值的时候没有单位，则以千字节为单位。默认值是10兆字节。设置为零时将禁用基于大小创建新的日志文件。
这个参数只能在postgresql.conf文件中或在服务器命令行上设置。
log_truncate_on_rotation (boolean)
#
当logging_collector被启用时，这个参数将导致PostgreSQL截断（覆盖而不是追加）任何已有的同名日志文件。不过，截断只在一个新文件由于基于时间的轮转被打开时发生，在服务器启动或基于尺寸的轮转时不会发生。如果被关闭，在所有情况下以前存在的文件将被追加。例如，使用这个设置和一个类似postgresql-%H.log的log_filename将导致产生24个每小时的日志文件，并且循环地覆盖它们。这个参数只能在postgresql.conf文件中或在服务器命令行上设置。
示例：保留7天的日志，每天一个日志文件，命名为server_log.Mon，server_log.Tue，等等，并自动用本周的日志覆盖上周的日志，将log_filename设置为server_log.%a，将log_truncate_on_rotation设置为on，将log_rotation_age设置为1440。
示例：要保留24小时的日志，每个小时一个日志文件，但如果日志文件大小超过1GB，则更早轮转，设置log_filename为server_log.%H%M，将log_truncate_on_rotation设置为on，将log_rotation_age设置为60，并将log_rotation_size设置为1000000。在log_filename中包括%M允许任何尺寸驱动的轮转选择一个不同于每个小时的初始文件名的新文件名。
syslog_facility (enum)
#
当启用了向syslog记录时，这个参数决定要使用的syslog“设施”。你可以在LOCAL0、LOCAL1、LOCAL2、LOCAL3、LOCAL4、LOCAL5、LOCAL6、LOCAL7中选择，默认值是LOCAL0。还请参阅系统的syslog守护进程的文档。这个参数只能在postgresql.conf文件中或在服务器命令行上设置。
syslog_ident (string)
#
当启用了向syslog记录时，这个参数决定用来标识PostgreSQL消息的程序名。默认值是postgres。这个参数只能在postgresql.conf文件中或在服务器命令行上设置。
syslog_sequence_numbers (boolean)
#
当日志被记录到syslog并且这个设置为on（默认）时，每一个消息会被加上一个增长的序号作为前缀（例如[2]）。这种行为避开了很多syslog实现默认采用的“---- 上一个消息重复 N 次 ----”形式。在现代syslog实现中，抑制重复消息是可以配置的（例如$RepeatedMsgReduction在rsyslog中），因此这个参数可能不是必需的。此外，如果你真的想抑制重复消息，你可以把这个参数设置为off。
这个参数只能在postgresql.conf文件或服务器命令行上设置。
syslog_split_messages (boolean)
#
当启用把日志记录到syslog时，这个参数决定消息如何送达 syslog。当设置为 on（默认）时，消息会被分成行，并且长的行也会被划分以便能够放到 1024 字节中，这是传统 syslog 实现一种典型的尺寸限制。当设置为 off 时，PostgreSQL 服务器日志消息会被原样送达 syslog 服务，而处理可能的大体量消息的任务由 syslog 服务负责。
如果 syslog 最终被记录到一个文本文件中，那么两种设置的效果是一样的，但最好设置为 on，因为大部分 syslog 实现要么不能处理大型消息，要么需要做特殊的配置以处理它们。但是如果 syslog 最终写入到某种其他媒介，有必要让消息保持逻辑上的整体性（也更加有用）。
这个参数只能在postgresql.conf文件中或通过服务器命令行进行设置。
event_source (string)
#
当启用记录到事件日志时，此参数决定用于识别PostgreSQL消息的程序名称。默认值为PostgreSQL。此参数只能在服务器启动时设置。
19.8.2. 何时记录日志 #log_min_messages (enum)
#
控制将哪些消息级别写入服务器日志。
有效值为DEBUG5，DEBUG4，
DEBUG3，DEBUG2，DEBUG1，
INFO，NOTICE，WARNING，
ERROR，LOG，FATAL，和
PANIC。每个级别包括其后的所有级别。
级别越高，发送到日志的消息越少。默认值为WARNING。
请注意，在client_min_messages中，LOG的排名不同。
只有超级用户和具有适当SET权限的用户才能更改此设置。
log_min_error_statement (enum)
#
控制在服务器日志中记录哪些导致错误条件的SQL语句。当前的SQL语句将包含在任何指定
严重性级别
或更高消息的日志条目中。
有效值为DEBUG5、
DEBUG4、DEBUG3、
DEBUG2、DEBUG1、
INFO、NOTICE、
WARNING、ERROR、
LOG、
FATAL和PANIC。
默认值为ERROR，这意味着导致错误、日志消息、致命错误或紧急情况的语句将被记录。
要有效地关闭记录失败的语句，
将此参数设置为PANIC。
只有超级用户和具有适当SET权限的用户才能更改此设置。
log_min_duration_statement (integer)
#
记录每个已完成语句的持续时间，如果语句运行时间至少达到指定时间。
例如，如果将其设置为250ms，那么所有运行时间为250ms或更长的SQL语句将被记录。
启用此参数可帮助跟踪应用程序中的未优化查询。
如果未指定单位，则将其视为毫秒。
将此值设置为零将打印所有语句持续时间。
-1（默认值）禁用记录语句持续时间。
只有超级用户和具有适当SET权限的用户才能更改此设置。
这会覆盖log_min_duration_sample，意味着持续时间超过此设置的查询不进行抽样，并且始终被记录。
对于使用扩展查询协议的客户端，解析、绑定和执行步骤的持续时间将被独立记录。
注意
当把这个选项和log_statement一起使用时，已经被log_statement记录的语句文本不会在持续时间日志消息中重复。如果你没有使用syslog，我们推荐你使用log_line_prefix记录 PID 或会话 ID，这样你可以使用进程 ID 或会话 ID 把语句消息链接到后来的持续时间消息。
log_min_duration_sample (integer)
#
允许对运行时间至少达到指定时间的已完成语句进行采样。这会产生与
log_min_duration_statement相同类型的日志条目，
但仅针对已执行语句的子集，采样率由log_statement_sample_rate控制。
例如，如果将其设置为100ms，那么运行时间达到100ms或更长的所有
SQL语句都将被考虑进行采样。启用此参数在流量过高无法记录所有查询时很有帮助。
如果未指定单位，则将其视为毫秒。
将其设置为零会对所有语句持续时间进行采样。
-1（默认值）禁用语句持续时间的采样。
只有超级用户和具有适当SET权限的用户才能更改此设置。
此设置的优先级低于 log_min_duration_statement，意味着持续时间超过 log_min_duration_statement 的语句不被采样，并且始终被记录。
log_min_duration_statement的其他注释也适用于此设置。
log_statement_sample_rate (floating point)
#
确定持续时间超过log_min_duration_sample的语句的比例将被记录。
采样是随机的，例如0.5表示统计上有一半的机会任何给定的语句将被记录。
默认值为1.0，表示记录所有采样的语句。
将此设置为零将禁用采样语句持续时间记录，与将log_min_duration_sample设置为-1相同。
只有超级用户和具有适当SET权限的用户才能更改此设置。
log_transaction_sample_rate (floating point)
#
设置所有语句都被记录的事务的比例，除了其他原因记录的语句。它适用于每个新事务，无论其语句的持续时间如何。
采样是随机的，例如0.1表示任何给定事务被记录的统计概率是十分之一。
log_transaction_sample_rate可以帮助构建事务样本。
默认值为0，表示不记录任何额外事务的语句。将其设置为1会记录所有事务的所有语句。
只有超级用户和具有适当SET权限的用户才能更改此设置。
注意
就像所有的语句日志选项一样，这个选项可能会增加大量开销。
log_startup_progress_interval (integer)
#
设置启动过程在长时间运行的操作仍在进行时记录消息的时间间隔，
以及该操作进一步进展消息之间的间隔时间。默认值为10秒。
设置为0会禁用该功能。如果未指定单位，
则将其视为毫秒。此设置分别应用于每个操作。
此参数只能在postgresql.conf文件或服务器命令行中设置。
例如，如果同步数据目录需要25秒，然后重置未记录的关系需要8秒，如果此设置的默认值为10秒，
那么在数据目录同步进行了10秒后，将记录一条消息，再在进行了20秒后记录一条消息，
但对于重置未记录的关系不会记录任何消息。
表 19.2解释了PostgreSQL所使用的消息严重级别。如果日志输出被发送到syslog或Windows的eventlog，严重级别会按照表中所示进行转换。
表 19.2. 消息严重级别严重性用法syslogeventlogDEBUG1 .. DEBUG5为开发者提供逐渐更详细的信息。DEBUGINFORMATIONINFO提供用户隐式要求的信息，例如来自VACUUM VERBOSE的输出。INFOINFORMATIONNOTICE提供可能对用户有用的信息，例如长标识符截断的通知。NOTICEINFORMATIONWARNING提供可能出现的问题的警告，例如在一个事务块外COMMIT。NOTICEWARNINGERROR报告一个导致当前命令中止的错误。WARNINGERRORLOG报告管理员可能感兴趣的信息，例如检查点活动。INFOINFORMATIONFATAL报告一个导致当前会话中止的错误。ERRERRORPANIC报告一个导致所有数据库会话中止的错误。CRITERROR19.8.3. 记录什么到日志 #注意
你选择记录的内容可能会影响安全性；请参见第 24.3 节。
application_name (string)
#
application_name可以是少于NAMEDATALEN字符
（在标准构建中为64个字符）的任意字符串。通常由应用程序在连接到服务器时设置。
该名称将显示在pg_stat_activity视图中，并包含在CSV日志条目中。
它还可以通过log_line_prefix参数包含在常规日志条目中。
application_name值中只能使用可打印的ASCII字符。
其他字符将被替换为C风格的十六进制转义。
debug_print_parse (boolean)
debug_print_rewritten (boolean)
debug_print_plan (boolean)
#
这些参数启用发出各种调试输出。当设置时，会打印生成的解析树、查询重写输出或执行的每个查询的执行计划。
这些信息是在LOG消息级别发出，因此默认情况下它们会出现在服务器日志中，但不会发送给客户端。
你可以通过调整client_min_messages和/或log_min_messages来改变这种情况。
这些参数默认是关闭的。
debug_pretty_print (boolean)
#
当被设置时，debug_pretty_print会缩进由debug_print_parse、
debug_print_rewritten或
debug_print_plan产生的输出。这将导致比关闭参数时使用的“紧凑”格式可读性更强但更长的输出。它默认是开启的。
log_autovacuum_min_duration (integer)
#
每次由自动清理执行的操作都会被记录，如果运行时间至少达到指定时间。将此设置为零会记录所有自动清理操作。
-1会禁用记录自动清理操作。如果未指定单位，则将其视为毫秒。
例如，如果将其设置为250ms，则所有运行时间为250ms或更长的自动清理和分析都将被记录。
此外，当此参数设置为任何值而不是-1时，如果由于冲突的锁定或同时删除的关系而跳过自动清理操作，则会记录消息。
默认值为10min。启用此参数可帮助跟踪自动清理活动。
此参数只能在postgresql.conf文件或服务器命令行中设置；但可以通过更改表存储参数来覆盖对单个表的设置。
log_checkpoints (boolean)
#
导致检查点和重启点在服务器日志中记录。日志消息中包括一些统计信息，
包括写入的缓冲区数量和写入它们所花费的时间。此参数只能在
postgresql.conf文件或服务器命令行中设置。默认值为开启。
log_connections (string)
#
记录每个与服务器的连接的某些方面。
默认值为空字符串''，这会
禁用所有连接日志记录。可以单独指定以下选项或以逗号分隔的列表形式指定：
表 19.3. 日志连接选项名称描述receipt记录连接的接收情况。authentication
记录用于识别用户的身份验证方法所使用的原始身份。
在大多数情况下，身份字符串与 PostgreSQL 用户名匹配，
但某些第三方身份验证方法可能会在服务器存储之前更改
原始用户标识符。无论此设置的值如何，失败的
身份验证始终会被记录。
authorization
记录授权成功完成的情况。此时
连接已建立，但后端尚未完全设置。日志消息包括授权的
用户名以及数据库名称和应用程序名称（如果适用）。
setup_durations
记录建立连接和设置后端所花费的时间，直到连接准备好执行其第一个
查询。日志消息包括三个持续时间：总的
设置持续时间（从主进程接受
传入连接开始，到连接准备好
查询结束）、创建新后端所需的时间，以及
身份验证用户所需的时间。
all
一个方便的别名，相当于指定所有选项。如果在其他
选项的列表中指定 all，则所有连接方面都会被记录。
断开连接日志记录由 log_disconnections 单独控制。
为了向后兼容，on、
off、true、
false、yes、
no、1 和 0
仍然被支持。正值相当于指定
receipt、authentication 和
authorization 选项。
只有超级用户和具有适当 SET
权限的用户才能在会话开始时更改此参数，
并且在会话中无法更改。
注意
某些客户端程序（例如psql）在要求密码时会尝试连接两次，因此重复的“connection received”消息并不一定表示一个错误。
log_disconnections (boolean)
#
导致会话终止被记录。日志输出提供类似于log_connections的信息，以及会话的持续时间。
只有超级用户和具有适当SET权限的用户可以在会话开始时更改此参数，而且在会话中根本无法更改。
默认值为off。
log_duration (boolean)
#
记录每个已完成语句的持续时间。
默认值为off。
只有超级用户和具有适当SET权限的用户才能更改此设置。
对于使用扩展查询协议的客户端，解析、绑定和执行步骤的持续时间将被独立记录。
注意
启用log_duration和设置log_min_duration_statement为零之间的区别是，超过log_min_duration_statement强制查询的文本被记录，但这个选项不会。因此，如果log_duration为on并且log_min_duration_statement有正值，所有持续时间都将被记录，但是只有超过阈值的语句才会被记录查询文本。这种行为有助于在高负载安装中收集统计信息。
log_error_verbosity (enum)
#
控制在服务器日志中记录的每条消息的详细程度。有效值为TERSE，
DEFAULT和VERBOSE，每个值都会添加更多字段到显示的消息中。
TERSE不包括DETAIL，HINT，
QUERY和CONTEXT错误信息的记录。
VERBOSE输出包括SQLSTATE错误代码
（另请参见附录 A）以及生成错误的源代码文件名、函数名和行号。
只有超级用户和具有适当SET权限的用户才能更改此设置。
log_hostname (boolean)
#
默认情况下，连接日志消息只显示连接主机的 IP 地址。打开这个参数将导致也记录主机名。注意根据你的主机名解析设置，这可能会导致不可忽视的性能损失。这个参数只能在postgresql.conf文件中或在服务器命令行上设置。
log_line_prefix (string)
#
这是一个printf风格的字符串，它在每个日志行的开头输出。
%字符开始“转义序列”，它将被按照下文描述的替换成状态信息。
未识别的转义被忽略。其他字符被直接复制到日志行。某些转义只被会话进程识别并且被主服务器进程等后台进程当作空。
通过指定一个在%之后和该选项之前的数字可以让状态信息左对齐或右对齐。
负值将导致在右边用空格填充状态信息以达到最小宽度，而正值则在左边填充。填充对于日志文件的人类可读性大有帮助。
这个参数只能在postgresql.conf文件中或在服务器命令行上设置。默认值是'%m [%p] '，它记录时间戳和进程ID。
转义效果会话专用%a应用程序名称是%u用户名是%d数据库名称是%r远程主机名或 IP 地址，以及远程端口是%h远程主机名或 IP 地址是%L本地地址（客户端连接到的服务器上的 IP 地址）是%b后端类型否%p进程 ID否%P并行组领导者的进程 ID，如果该进程是一个并行查询工作者no%t无毫秒的时间戳否%m带毫秒的时间戳否%n带毫秒的时间戳（作为 Unix 纪元）no%i命令标签：会话当前命令的类型是%eSQLSTATE 错误代码否%c会话 ID：见下文否%l对每个会话或进程的日志行号，从 1 开始否%s进程开始的时间戳否%v虚拟事务ID（procNumber/localXID）；参见
第 67.1 节否%x事务ID（如果未分配则为0）；请参阅
第 67.1 节否%q不产生输出，但是告诉非会话进程在字符串的这一点停止；会话进程忽略否%Q当前查询的查询标识符。
查询标识符默认是不计算的，所以这个字段将是零，除非compute_query_id
参数被激活或者配置了计算查询标识符的第三方模块。是%%纯文字 %否
后端类型对应视图 pg_stat_activity中的backend_type列。
但是其他类型可能会出现在日志中而不显示在该视图中。
%c转义打印一个准唯一的会话标识符，它由两个 4 字节的十六进制数（不带前导零）组成，以点号分隔。
这些数字是进程启动时间和进程 ID，因此%c也可以被用作节省打印这些项的空间方式。
例如，要从pg_stat_activity生成会话标识符，使用这个查询：
SELECT to_hex(trunc(EXTRACT(EPOCH FROM backend_start))::integer) || '.' ||
to_hex(pid)
FROM pg_stat_activity;
提示
如果你为log_line_prefix设置了非空值，你通常应该让它的最后一个字符是空格，这样用以提供和日志行的剩余部分的视觉区别。也可以使用标点符号。
提示
Syslog产生自己的时间戳和进程 ID 信息，因此如果你记录到syslog你可能不希望包括那些转义。
提示
在包括仅在会话（后端）上下文中可用的信息（如用户名或数据库名）时，%q转义很有用。例如：
log_line_prefix = '%m [%p] %q%u@%d/%a '
注意
对于log_statement输出的行，%Q总是报告零标识符，
因为log_statement在标识符能被计算之前生成输出，包括无效语句对于标识符无法计算的情况。
log_lock_waits (boolean)
#
控制当会话等待时间超过deadlock_timeout以获取锁时是否生成日志消息。
这对于确定锁等待是否导致性能不佳很有用。默认值为off。
只有超级用户和具有适当SET特权的用户才能更改此设置。
log_lock_failures (boolean)
#
控制在锁获取失败时是否生成详细的日志消息。
这对于分析锁失败的原因非常有用。
目前，仅支持由于 SELECT NOWAIT 导致的锁失败。
默认值为 off。只有超级用户和
具有适当 SET 权限的用户
才能更改此设置。
log_recovery_conflict_waits (boolean)
#
控制启动过程等待时间超过 deadlock_timeout
针对恢复冲突时是否产生日志消息。
这对于确定恢复冲突是否会阻止恢复应用 WAL
非常有用。
默认为 off。这个参数只能在
postgresql.conf 文件中或服务器
命令行中设置。
log_parameter_max_length (integer)
#
如果大于零，则记录在非错误语句日志消息中的每个绑定参数值都会被截断为指定的字节数。
零表示禁用非错误语句日志中绑定参数的记录。
-1（默认值）允许完整记录绑定参数。
如果未指定单位，则默认为字节。
只有超级用户和具有适当 SET
权限的用户才能更改此设置。
此设置仅影响作为结果打印的日志消息 log_statement,
log_duration, 和相关的设置。
该设置的非零值会增加一些开销，特别是当参数以二进制形式发送时，
因为需要转换为文本。
log_parameter_max_length_on_error (integer)
#
如果大于零，则错误消息中报告的每个绑定参数值都将裁剪为这么多字节。
零（默认值）禁止在错误消息中包含绑定参数。-1允许打印完整绑定参数。
如果指定此值时没有单位，则将其作为字节。
该设置的非零值会增加开销，因为PostgreSQL需要在每条语句的开始处将参数值的文本表示存储在内存中，无论最终是否会发生错误。
当绑定参数以二进制形式发送时，开销比以文本形式发送时更大，因为前者需要数据转换，而后者只需要复制字符串。
log_statement (enum)
#
控制哪些 SQL 语句被记录。有效值是
none（关闭）、ddl、mod和
all（所有语句）。ddl记录所有数据定义语句，例如CREATE、ALTER和
DROP语句。mod记录所有ddl语句，外加数据修改语句例如INSERT,
UPDATE、DELETE、TRUNCATE,
和COPY FROM。
如果PREPARE、EXECUTE和
EXPLAIN ANALYZE包含合适类型的命令，它们也会被记录。对于使用扩展查询协议的客户端，当收到一个执行消息时会产生日志并且会包括绑定参数的值（任何内嵌的单引号会被双写）。
默认值为none。
只有超级用户和具有适当SET权限的用户才能更改此设置。
注意
即使使用log_statement = all设置，包含简单语法错误的语句也不会被记录。
这是因为只有在完成基本语法解析并确定了语句类型之后才会发出日志消息。在扩展查询协议的情况下，在执行阶段之前（即在解析分析或规划期间）出错的语句也不会被记录。
将log_min_error_statement设置为ERROR（或更低）来记录这种语句。
记录的语句可能会透露敏感数据，甚至包含明文密码。
log_replication_commands (boolean)
#
导致每个复制命令和walsender进程的复制槽获取/释放
被记录在服务器日志中。有关复制命令的更多信息，请参见
第 54.4 节。默认值为off。
只有超级用户和具有相应SET权限的用户才能更改此设置。
log_temp_files (integer)
#
控制临时文件名称和大小的日志记录。
临时文件可以用于排序、哈希和临时查询结果。
如果通过此设置启用，则在每个临时文件被删除时，
会记录一条日志条目，其中指定文件大小（以字节为单位）。
值为零时记录所有临时文件信息，而正值仅记录大小
大于或等于指定数据量的文件。
如果此值未指定单位，则默认为千字节。
默认设置为 -1，这会禁用此类日志记录。
只有超级用户和具有适当SET
权限的用户可以更改此设置。
log_timezone (string)
#
设置在服务器日志中写入的时间戳的时区。
与TimeZone不同，这个值是集簇范围的，
因此所有会话将报告一致的时间戳。
内建默认值是GMT，但是通常会被在postgresql.conf中覆盖。
initdb将安装一个对应于其系统环境的设置。
详见第 8.5.3 节。这个参数只能在postgresql.conf
文件中或在服务器命令行上设置。
19.8.4. 使用 CSV 格式的日志输出 #
在log_destination列表中包括csvlog提供了一种便捷方式将日志文件导入到一个数据库表。这个选项发出逗号分隔值（CSV）格式的日志行，包括这些列：
带毫秒的时间戳、
用户名、
数据库名、
进程 ID、
客户端主机:端口号、
会话 ID、
每个会话的行号、
命令标签、
会话开始时间、
虚拟事务 ID、
普通事务 ID、
错误严重性、
SQLSTATE 代码、
错误消息、
错误消息详情、
提示、
导致错误的内部查询（如果有）、
错误位置所在的字符计数、
错误上下文、
导致错误的用户查询（如果有且被log_min_error_statement启用）、
错误位置所在的字符计数、
在 PostgreSQL 源代码中错误的位置（如果log_error_verbosity被设置为verbose）以及应用名，后端类型，并行组领导者的进程 ID 和查询 ID。
下面是一个定义用来存储 CSV 格式日志输出的样表：
CREATE TABLE postgres_log
(
log_time timestamp(3) with time zone,
user_name text,
database_name text,
process_id integer,
connection_from text,
session_id text,
session_line_num bigint,
command_tag text,
session_start_time timestamp with time zone,
virtual_transaction_id text,
transaction_id bigint,
error_severity text,
sql_state_code text,
message text,
detail text,
hint text,
internal_query text,
internal_query_pos integer,
context text,
query text,
query_pos integer,
location text,
application_name text,
backend_type text,
leader_pid integer,
query_id bigint,
PRIMARY KEY (session_id, session_line_num)
);
使用COPY FROM命令将一个日志文件导入到这个表中：
COPY postgres_log FROM '/full/path/to/logfile.csv' WITH csv;
也可以作为外部表访问该文件，使用提供的 file_fdw 模块。
你可以做一些事情来简化导入 CSV 日志文件：
设置log_filename和log_rotation_age为你的日志文件提供一种一致的、可预测的命名方案。这让你预测文件名会是怎样以及知道什么时候一个个体日志文件完成并且因此准备好被导入。
将log_rotation_size设置为 0 来禁用基于尺寸的日志轮转，因为它使得日志文件名难以预测。
将log_truncate_on_rotation设置为on，这样在同一个文件中旧日志数据不会与新数据混杂。
上述表定义包括一个主键声明。这有助于避免意外地两次导入相同的信息。COPY命令一次提交所有它导入的数据，因此任何错误将导致整个导入失败。如果你导入一个部分完成的日志文件并且稍后当它完全完成后再次导入，主键冲突将导致导入失败。请等到日志完成且被关闭之后再导入。这个过程也可以避免意外地导入部分完成的行，这种行也将导致COPY失败。
19.8.5. 使用JSON格式的日志输出 #
包括jsonlog在log_destination列表中提供了一种方便的方式将日志文件导入到许多不同的程序中。此选项以JSON格式发出日志行。
字段值为null的字符串字段将被排除在输出之外。
未来可能会添加其他字段。处理jsonlog输出的用户应忽略未知字段。
每个日志行都被序列化为一个JSON对象，其中包含一组键和它们对应的值，如表 19.4中所示。
表 19.4. JSON日志条目的键和值键名类型描述timestampstring带毫秒的时间戳userstring用户名dbnamestring数据库名称pidnumber进程 IDremote_hoststring客户端主机remote_portnumber客户端端口session_idstring会话 IDline_numnumber每个会话的行号psstring当前 ps 显示session_startstring会话开始时间vxidstring虚拟事务IDtxidstring常规事务IDerror_severitystring错误严重性state_codestringSQLSTATE代码messagestring错误消息detailstring错误消息详细信息hintstring错误消息提示internal_querystring导致错误的内部查询internal_positionnumber内部查询的游标索引contextstring错误上下文statementstring客户端提供的查询字符串cursor_positionnumber查询字符串中的游标索引func_namestring错误位置的函数名称file_namestring错误位置的文件名file_line_numnumber错误位置的文件行号application_namestring客户端应用程序名称backend_typestring后端类型leader_pidnumber活动并行工作进程的领导者进程IDquery_idnumber查询ID19.8.6. 进程标题 #
这些设置控制服务器进程的进程标题如何被修改。进程标题通常可以用ps或者 Windows 上的进程资源管理器等程序来查看。详见第 27.1 节。
cluster_name (string)
#
设置一个名称，用于标识此数据库集群（实例）以用于各种目的。集群名称会
出现在此集群中所有服务器进程的进程标题中。此外，它是备用连接的默认应
用程序名称（请参见synchronous_standby_names）。
名称可以是任何少于NAMEDATALEN字符的字符串（标准构建中为64个字符）。
cluster_name值中只能使用可打印的ASCII字符。
其他字符将被替换为C风格的十六进制转义。
如果此参数设置为空字符串''（这是默认值），则不会显示名称。
此参数只能在服务器启动时设置。
update_process_title (boolean)
#
每次服务器接收到新的SQL命令时，都可以更新进程标题。
在大多数平台上，默认情况下此设置为on，但在Windows上默认为off，
因为该平台更新进程标题的开销较大。
只有超级用户和具有适当SET权限的用户才能更改此设置。
上一页 上一级 下一页19.7. 查询规划 起始页 19.9. 运行时统计
