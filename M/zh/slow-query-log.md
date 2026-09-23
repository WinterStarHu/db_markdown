# 5.4.5 慢查询日志_MySQL 8.0 参考手册

5.4.5 慢查询日志_MySQL 8.0 参考手册
Skip to Main Content
Documentation
MySQL手册
MySQL企业版
工作台
InnoDB集群
MySQL NDB集群
连接器
Section Menu:
Documentation Home
MySQL 8.0 参考手册
前言和法律声明
第一章 一般信息
第 2 章安装和升级 MySQL
第 3 章教程
第 4 章 MySQL 程序
第 5 章 MySQL 服务器管理
5.1 MySQL 服务器
5.2 MySQL数据目录
5.3 mysql系统架构
5.4 MySQL 服务器日志
5.4.1 选择通用查询日志和慢查询日志输出目的地1
5.4.2 错误日志1
5.4.3 一般查询日志1
5.4.4 二进制日志1
5.4.5 慢查询日志1
5.4.6 服务器日志维护1
5.5 MySQL组件
5.6 MySQL 服务器插件
5.7 MySQL 服务器可加载函数
5.8 在一台机器上运行多个MySQL实例
5.9 调试 MySQL
第 6 章 安全
第 7 章备份与恢复
第8章优化
第9章语言结构
第 10 章字符集、排序规则、Unicode
第 11 章数据类型
第 12 章函数和运算符
第 13 章 SQL 语句
第14章MySQL数据字典
第 15 章 InnoDB 存储引擎
第 16 章替代存储引擎
第十七章复制
第十八章 组复制
第十九章MySQL Shell
第 20 章使用 MySQL 作为文档存储
第21章InnoDB Cluster
第 22 章 InnoDB 副本集
第 23 章 MySQL NDB Cluster 8.0
第24章分区
第25章存储对象
第 26 章 INFORMATION_SCHEMA 表
第 27 章 MySQL 性能模式
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 5 章 MySQL 服务器管理  / 5.4 MySQL 服务器日志  /
5.4.5 慢查询日志
5.4.5 慢查询日志
慢速查询日志由执行时间超过
long_query_time几秒并且至少
min_examined_row_limit需要检查行的 SQL 语句组成。慢速查询日志可用于查找需要很长时间执行的查询，因此是优化的候选者。但是，检查长而慢的查询日志可能是一项耗时的任务。为了使这更容易，您可以使用
mysqldumpslow命令来处理慢速查询日志文件并汇总其内容。请参阅
第 4.6.10 节，“mysqldumpslow — 总结慢速查询日志文件”。
获取初始锁的时间不计入执行时间。mysqld在执行完并释放所有锁后将语句写入慢速查询日志，因此日志顺序可能与执行顺序不同。
慢查询日志参数慢查询日志内容
慢查询日志参数
的最小值和默认值
long_query_time分别为 0 和 10。该值可以指定为微秒级的分辨率。
默认情况下，不记录管理语句，也不记录不使用索引进行查找的查询。可以使用
log_slow_admin_statements和
更改此行为log_queries_not_using_indexes，如后所述。
默认情况下，慢查询日志是关闭的。要显式指定初始慢查询日志状态，请使用
--slow_query_log[={0|1}]. 在没有参数或参数为 1 的情况下，
--slow_query_log启用日志。如果参数为 0，此选项将禁用日志。要指定日志文件名，请使用
. 要指定日志目标，请使用
系统变量（如第 5.4.1 节“选择一般查询日志和慢速查询日志输出目标”中所述）。
--slow_query_log_file=file_namelog_output
笔记
如果指定TABLE日志目的地，请参阅日志表和“打开的文件太多”错误。
如果您没有为慢查询日志文件指定名称，则默认名称为
host_name-slow.log. 服务器在数据目录中创建文件，除非给出绝对路径名来指定不同的目录。
要在运行时禁用或启用慢速查询日志或更改日志文件名，请使用全局
变量slow_query_log和
slow_query_log_file系统变量。设置slow_query_log
为 0 以禁用日志或设置为 1 以启用它。设置
slow_query_log_file以指定日志文件的名称。如果日志文件已经打开，则关闭它并打开新文件。
如果您使用该--log-short-format
选项，服务器将较少的信息写入慢速查询日志。
要在慢速查询日志中包含慢速管理语句，请启用
log_slow_admin_statements
系统变量。行政报表包括
ALTER TABLE、
ANALYZE TABLE、
CHECK TABLE、
CREATE INDEX、
DROP INDEX、
OPTIMIZE TABLE和
REPAIR TABLE。
要在写入慢速查询日志的语句中包含不使用索引进行行查找的查询，请启用
log_queries_not_using_indexes
系统变量。（即使启用了该变量，服务器也不会记录由于表少于两行而无法从索引的存在中受益的查询。）
当记录不使用索引的查询时，慢速查询日志可能会快速增长。log_throttle_queries_not_using_indexes
可以通过设置系统变量来限制这些查询的速率
。默认情况下，此变量为 0，表示没有限制。正值对不使用索引的查询的记录施加每分钟限制。第一个这样的查询会打开一个 60 秒的窗口，服务器会在该窗口内记录达到给定限制的查询，然后抑制其他查询。如果窗口结束时有被抑制的查询，服务器会记录一个摘要，指示有多少以及在这些查询中花费的总时间。当服务器记录下一个不使用索引的查询时，下一个 60 秒窗口开始。
服务器按以下顺序使用控制参数来确定是否将查询写入慢查询日志：
查询必须不是管理语句，或者
log_slow_admin_statements
必须启用。
查询必须至少花费
long_query_time几秒钟，或者
log_queries_not_using_indexes
必须启用并且查询不使用索引进行行查找。
查询必须至少检查了
min_examined_row_limit
行。
根据设置不得抑制查询
log_throttle_queries_not_using_indexes
。
log_timestamps系统变量控制写入慢速查询日志文件（以及一般查询日志文件和错误日志）的消息中时间戳的时区
。它不会影响写入日志表的一般查询日志和慢速查询日志消息的时区，但是可以使用CONVERT_TZ()或通过设置会话time_zone
系统变量从这些表中检索的行从本地系统时区转换为任何所需的时区。
默认情况下，副本不会将复制的查询写入慢查询日志。要更改此设置，请启用系统变量
log_slow_replica_statements
（从 MySQL 8.0.26 开始）或
log_slow_slave_statements
（在 MySQL 8.0.26 之前）。请注意，如果使用基于行的复制 ( binlog_format=ROW)，则这些系统变量无效。只有在二进制日志中以语句格式记录查询时，查询才会添加到副本的慢查询日志中，即
binlog_format=STATEMENT设置为 when 时，或者binlog_format=MIXED设置为 statement 格式时记录语句。设置时以行格式记录的慢速查询
binlog_format=MIXED，或记录时
binlog_format=ROW已设置，不会添加到副本的慢查询日志中，即使
log_slow_replica_statements或
log_slow_slave_statements已启用。
慢查询日志内容
启用慢速查询日志后，服务器会将输出写入
log_output系统变量指定的任何目标。如果启用日志，服务器将打开日志文件并将启动消息写入其中。FILE但是，除非选择了日志目标，否则不会进一步将查询记录到文件中。如果目标是
NONE，即使启用了慢速查询日志，服务器也不会写入任何查询。FILE如果未选择为输出目标，
则设置日志文件名对日志记录没有影响。
如果启用慢速查询日志并将FILE其选为输出目标，则写入日志的每个语句前面都有一行，该行以
#字符开头并包含以下字段（所有字段都在一行中）：
Query_time:
duration
以秒为单位的语句执行时间。
Lock_time:
duration
获取锁的时间，单位秒。
Rows_sent: N
发送到客户端的行数。
Rows_examined:
服务器层检查的行数（不计算存储引擎内部的任何处理）。
启用log_slow_extra
系统变量（自 MySQL 8.0.14 起可用）会导致服务器将以下额外字段写入FILE
输出，除了刚刚列出的那些（TABLE输出不受影响）。一些字段描述引用状态变量名称。有关详细信息，请参阅状态变量描述。但是，在慢速查询日志中，计数器是每个语句的值，而不是每个会话的累积值。
Thread_id: ID
语句线程标识符。
Errno:
error_number
语句错误号，如果没有发生错误则为 0。
Killed: N
如果语句被终止，错误编号指示原因，或者如果语句正常终止则为 0。
Bytes_received:
N
语句的Bytes_received值。
Bytes_sent: N
语句的Bytes_sent值。
Read_first: N
语句的Handler_read_first
值。
Read_last: N
语句的Handler_read_last
值。
Read_key: N
语句的Handler_read_key值。
Read_next: N
语句的Handler_read_next
值。
Read_prev: N
语句的Handler_read_prev
值。
Read_rnd: N
语句的Handler_read_rnd值。
Read_rnd_next:
N
语句的Handler_read_rnd_next
值。
Sort_merge_passes:
N
语句的Sort_merge_passes
值。
Sort_range_count:
N
语句的Sort_range值。
Sort_rows: N
语句的Sort_rows值。
Sort_scan_count:
N
语句的Sort_scan值。
Created_tmp_disk_tables:
N
语句的
Created_tmp_disk_tables
值。
Created_tmp_tables:
N
语句的Created_tmp_tables
值。
Start:
timestamp
语句执行开始时间。
End: timestamp
语句执行结束时间。
给定的慢速查询日志文件可能包含带有和不带有通过启用添加的额外字段的混合行
log_slow_extra。日志文件分析器可以通过字段数判断一行是否包含额外的字段。
写入慢速查询日志文件的每条语句前面都有一条SET
包含时间戳的语句。从 MySQL 8.0.14 开始，时间戳表示慢速语句开始执行的时间。在 8.0.14 之前，时间戳表示记录慢速语句的时间（发生在语句完成执行之后）。
写入慢速查询日志的语句中的密码由服务器重写，不会以纯文本形式出现。请参阅第 6.1.2.3 节，“密码和日志记录”。
从 MySQL 8.0.29 开始，无法解析的语句（例如，由于语法错误）不会写入慢查询日志。
© Mysql 中文网
