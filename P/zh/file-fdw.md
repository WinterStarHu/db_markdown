# F.15. file_fdw — 访问服务器文件系统中的数据文件

F.15. file_fdw — 访问服务器文件系统中的数据文件
版本：
纠错本页面
搜索
目录导航
❮
❯
F.15. file_fdw — 访问服务器文件系统中的数据文件 #
file_fdw模块提供外部数据包装器file_fdw，
它可以用来访问服务器文件系统中的数据文件，或者在服务器上执行程序并读取它们的输出。
数据文件或程序输出必须是能够被COPY FROM读取的格式，
详见COPY。当前只能读取数据文件。
用这个包装器创建的外部表可以有下列选项：
filename
指定要读取的文件。相对路径是相对于数据目录。
必须指定filename或program，
但不能同时指定两个。
program
指定要执行的命令。该命令的标准输出将被读取，
就像使用COPY FROM PROGRAM一样。必须指定program
或filename，但不能同时指定两个。
format
指定数据的格式，和COPY的FORMAT选项相同。
header
指定数据是否具有头部行，和COPY的HEADER选项相同。
delimiter
指定数据的定界符字符，和COPY的DELIMITER选项相同。
quote
指定数据的引用字符，和COPY的QUOTE选项相同。
escape
指定数据的转义字符，和COPY的ESCAPE选项相同。
null
指定数据的空字符串，和COPY的NULL选项相同。
default
指定表示默认值的字符串，
和COPY的DEFAULT选项相同。
encoding
指定数据的编码，和COPY的ENCODING选项相同。
on_error
指定在遇到将列的输入值转换为其数据类型时发生错误时的行为，
和COPY的ON_ERROR选项相同。
reject_limit
指定在将列的输入值转换为其数据类型时容忍的最大错误数量，
和COPY的REJECT_LIMIT选项相同。
log_verbosity
指定 file_fdw 发出的消息数量，
与 COPY 的 LOG_VERBOSITY 选项相同。
注意虽然 COPY 允许诸如 HEADER 的选项
不用一个相应的值指定，但是外部表选项语法要求在所有情况下都出现一个值。
要激活通常写入没有值的 COPY 选项，你可以传递值 TRUE，
因为所有这些选项都是布尔值。
使用这个包装器创建的外部表的一列可以具有下列选项：
force_not_null
这是一个布尔选项。如果为真，它指定该列的值不应该与空字符串匹配（也就是表级别的 null 选项）。
这和把该列放在 COPY 的 FORCE_NOT_NULL 选项中具有相同的效果。
force_null
这是一个布尔选项。如果为真，它指定匹配空字符串的列值会被返回为 NULL，
即使该值被引号引用。如果没有这个选项，只有匹配空字符串的未被引用的值会被返回为
NULL。这和在 COPY 的 FORCE_NULL
选项中列出该列有同样的效果。
COPY 的 FORCE_QUOTE 选项当前不被 file_fdw 支持。
这些选项只能为一个外部表及其列指定，而不能在 file_fdw 外部数据包装器的选项中指定，
也不能在使用该包装器的服务器或者用户映射的选项中指定。
出于安全原因，改变表级别的选项要求超级用户特权或
具有角色 pg_read_server_files（使用文件名）或
角色 pg_execute_server_program（使用程序）的权限：
只有特定用户能够控制读取哪个文件或者运行哪个程序。
原则上普通用户可以被允许改变其他选项，但是当前还不支持这样做。
当指定program选项时，请记住，选项字符串是通过shell执行的。
如果想传递任何参数到来自不受信任的源的命令，
必须小心去掉或转义任何对shell来说可能有特殊含义的字符。出于安全原因，最好使用固定的命令字符串，
或者至少避免传递任何用户输入。
对于一个使用file_fdw的外部表，EXPLAIN显示要读取的文件名或要运行的程序。对于文件来说，除非指定COSTS OFF，否则文件大小（以字节计）也会被显示。
例 F.1. 为 PostgreSQL CSV 日志创建外部表
file_fdw的一个明显用途是将PostgreSQL活动日志作为可查询的表提供。要做到这一点，首先你必须写日志到一个CSV文件,这里我们将其称为pglog.csv。首先，将file_fdw安装为一个扩展：
CREATE EXTENSION file_fdw;
然后创建一个外部服务器：
CREATE SERVER pglog FOREIGN DATA WRAPPER file_fdw;
现在你已经准备好创建外部数据表。使用CREATE FOREIGN TABLE命令，你将需要为该表定义列、CSV 文件名以及格式：
CREATE FOREIGN TABLE pglog (
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
query_id bigint
) SERVER pglog
OPTIONS ( filename 'log/pglog.csv', format 'csv' );
就是这样了 — 现在你可以直接查询你的日志了。当然，在生产中你需要定义一些方法来处理日志轮转。
例 F.2. 在列上设置选项创建外部表
要为列设置 force_null 选项，请使用
OPTIONS 关键字。
CREATE FOREIGN TABLE films (
code char(5) NOT NULL,
title text NOT NULL,
rating text OPTIONS (force_null 'true')
) SERVER film_server
OPTIONS ( filename 'films/db.csv', format 'csv' );
上一页 上一级 下一页F.14. earthdistance — 计算大圆距离 起始页 F.16. fuzzystrmatch — 确定字符串相似性和距离
