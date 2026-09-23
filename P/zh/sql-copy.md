# COPY

COPY
版本：
纠错本页面
搜索
目录导航
❮
❯
COPYCOPY — 在文件和表之间复制数据大纲
COPY table_name [ ( column_name [, ...] ) ]
FROM { 'filename' | PROGRAM 'command' | STDIN }
[ [ WITH ] ( option [, ...] ) ]
[ WHERE condition ]
COPY { table_name [ ( column_name [, ...] ) ] | ( query ) }
TO { 'filename' | PROGRAM 'command' | STDOUT }
[ [ WITH ] ( option [, ...] ) ]
其中 option 可以是以下之一：
FORMAT format_name
FREEZE [ boolean ]
DELIMITER 'delimiter_character'
NULL 'null_string'
DEFAULT 'default_string'
HEADER [ boolean | MATCH ]
QUOTE 'quote_character'
ESCAPE 'escape_character'
FORCE_QUOTE { ( column_name [, ...] ) | * }
FORCE_NOT_NULL { ( column_name [, ...] ) | * }
FORCE_NULL { ( column_name [, ...] ) | * }
ON_ERROR error_action
REJECT_LIMIT maxerror
ENCODING 'encoding_name'
LOG_VERBOSITY verbosity
描述
COPY在
PostgreSQL表和标准文件系统文件之间
移动数据。COPY TO把一个表的内容复制
到一个文件，而COPY FROM
则从一个文件复制数据到一个表（把数据追加到表中原有数
据）。COPY TO也能复制一个
SELECT查询的结果。
如果指定了一个列列表，COPY TO将只把指定列的数据复制到文件。对于COPY FROM，文件中的每个字段将按顺序插入到指定列中。COPY FROM命令的列列表中没有指定的表列则会采纳其默认值。
带一个文件名的COPY指示
PostgreSQL服务器直接从一个文件读取
或者写入到一个文件。该文件必须是
PostgreSQL用户（运行服务器的用户 ID）
可访问的并且应该以服务器的视角来指定其名称。当指定了
PROGRAM时，服务器执行给定的命令并且从该程序的标准
输出读取或者写入到该程序的标准输入。该程序必须以服务器的视角指定，并且
必须是PostgreSQL用户可执行的。在指定
STDIN或者STDOUT时，数据会通过客
户端和服务器之间的连接传输。
运行COPY的每个后端将在
pg_stat_progress_copy视图中报告其进度。
有关详细信息，请参见第 27.4.3 节。
默认情况下，COPY在处理过程中遇到错误时会失败。
对于希望尽最大努力加载整个文件的用例，可以使用ON_ERROR子句来指定其他行为。
参数table_name
一个现有表的名称（可以是模式限定的）。
column_name
可选的要被复制的列列表。如果没有指定列列表，则该表的所有列除了生成的列都会被复制。
query
一个SELECT、
VALUES、
INSERT、
UPDATE、
DELETE或
MERGE命令，其结果将被复制。
注意，查询必须用括号括起来。
对于 INSERT、UPDATE、
DELETE 和 MERGE 查询，必须提供一个
RETURNING 子句，且目标关系不能有条件规则，也不能有
ALSO 规则，或者展开为多条语句的
INSTEAD 规则。
filename
输入或输出文件的路径名。一个输入文件的名称可以是一个绝对或相对路径，
但一个输出文件的名称必须是绝对路径。Windows 用户可能需要使用一个
E''字符串并且双写路径名称中使用的任何反斜线。
PROGRAM
一个要执行的命令。在COPY FROM中，输入
将从该命令的标准输出读取，而在COPY TO中，输出会
写入到该命令的标准输入。
请注意，该命令是由 shell 调用的，因此如果需要传递来自不可信来源的任何参数，
必须小心剥离或转义可能对 shell 有特殊含义的任何特殊字符。出于安全原因，
最好使用固定的命令字符串，或者至少避免在其中包含任何用户输入。
STDIN
指定输入来自客户端应用程序。
STDOUT
指定输出发送到客户端应用程序。
boolean
指定选中的选项是应该被打开还是关闭。可以写TRUE、
ON或1来启用选项，写
FALSE、OFF或0禁用它。
boolean值也可以被省略，
那样会假定为TRUE。
FORMAT
选择要读取或写入的数据格式：
text，
csv（逗号分隔值），
或 binary。
默认格式为 text。
有关详细信息，请参见下面的 File Formats。
FREEZE
请求复制已经冻结的行数据，就像运行 VACUUM FREEZE 命令后那样。
这被视为初始数据加载的性能选项。
只有在加载的表在当前子事务中被创建或截断，并且没有打开的游标
且此事务没有持有较旧的快照时，行才会被冻结。
目前无法对分区表或外部表执行 COPY FREEZE。
此选项仅在 COPY FROM 中允许使用。
请注意，一旦数据成功加载，所有其他会话将立即能够看到这些数据。
这违反了 MVCC 可见性的正常规则，用户应意识到这可能引发的潜在问题。
DELIMITER
指定分隔文件每行中各列的字符。文本格式中默认是一个制表符，
而CSV格式中默认是一个逗号。这必须是一个单一
的单字节字符。使用binary格式时不允许这个选项。
NULL
指定表示一个空值的字符串。文本格式中默认是
\N（反斜线-N），CSV格式中默认
是一个未加引用的空串。在你不想区分空值和空串的情况下，即使在文本
格式中你也可能更喜欢空串。使用binary格式时不允许这
个选项。
注意
在使用COPY FROM时，任何匹配
这个字符串的数据项将被存储为空值，因此你应该确定你使用的是和
COPY TO时相同的字符串。
DEFAULT
指定表示默认值的字符串。每次在输入文件中找到该字符串时，
将使用对应列的默认值。
此选项仅在COPY FROM中允许，并且仅在不使用
binary格式时允许。
HEADER
指定文件包含一个带有文件中每列名称的标题行。在输出时，第一行包含表中的列名。
在输入时，当此选项设置为true（或等效的布尔值）时，第一行将被丢弃。
如果此选项设置为MATCH，则标题行中的列数和名称必须与表的实际列名按顺序匹配；否则将引发错误。
当使用binary格式时，不允许使用此选项。
MATCH选项仅对COPY FROM命令有效。
QUOTE
指定一个数据值被引用时使用的引用字符。默认是双引号。
这必须是一个单一的单字节字符。只有使用
CSV格式时才允许这个选项。
ESCAPE
指定应该出现在一个匹配QUOTE值的数据字符之前
的字符。默认和QUOTE值一样（这样如果引用字符
出现在数据中，它会被双写）。这必须是一个单一的单字节字符。
只有使用CSV格式时才允许这个选项。
FORCE_QUOTE
强制必须对每个指定列中的所有非NULL值使用引用。
NULL输出不会被引用。如果指定了*，
所有列的非NULL值都将被引用。只有在
COPY TO中使用CSV格式时才允许
这个选项。
FORCE_NOT_NULL
不要将指定列的值与空字符串进行匹配。默认情况下，当空字符串为空时，
这意味着空值将被读取为零长度字符串，而不是空值，即使它们没有被引号括起。
如果指定了*，该选项将应用于所有列。此选项仅允许在
COPY FROM中使用，并且仅在使用CSV格式时有效。
FORCE_NULL
将指定列的值与空字符串进行匹配，即使该值被引用过，如果匹配成功则将值设置为
NULL。在默认情况下，当空字符串为空时，这会将被引用的空字符串转换为NULL。
如果指定了*，该选项将应用于所有列。
该选项仅允许在COPY FROM中使用，并且仅在使用CSV格式时有效。
ON_ERROR
指定在将列的输入值转换为其数据类型时遇到错误时的处理方式。
一个 error_action 值为
stop 意味着命令失败，而
ignore 意味着丢弃输入行并继续处理下一行。
默认值是 stop。
ignore 选项仅适用于 COPY FROM，
且 FORMAT 为 text 或 csv 时有效。
如果至少丢弃了一行，则在 COPY FROM 结束时会发出包含被忽略行数的
NOTICE 消息。当 LOG_VERBOSITY 选项设置为
verbose 时，会为每个丢弃的行发出包含输入文件行和输入
转换失败的列名的 NOTICE 消息。
当设置为 silent 时，不会发出有关被忽略行的消息。
REJECT_LIMIT
指定在将列的输入值转换为其数据类型时容忍的最大错误数，当 ON_ERROR 设置为
ignore 时。
如果输入导致的错误数超过指定值，则 COPY
命令失败，即使 ON_ERROR 设置为 ignore。
此子句必须与 ON_ERROR=ignore 一起使用，
且 maxerror 必须为正 bigint。
如果未指定，ON_ERROR=ignore 允许无限数量的错误，
这意味着 COPY 将跳过所有错误数据。
ENCODING
指定文件以encoding_name编码。如果省略
这个选项，将使用当前的客户端编码。详见下文的注解。
LOG_VERBOSITY
指定 COPY 命令发出的消息量：default、verbose 或
silent。
如果指定了 verbose，则在处理过程中会发出额外的消息。
silent 会抑制详细和默认消息。
这目前用于COPY FROM命令中，当ON_ERROR选项设置为
ignore时。
WHERE
WHERE子句是可选的，其一般形式是：
WHERE condition
其中condition是计算结果为boolean类型的任意表达式。任何不满足此条件的行都不会插入到表中。在用实际的行值替换任何变量引用时，如果该行返回 true，则该行满足条件。
目前，在WHERE表达式中不允许使用子查询，并且值的计算不会看到COPY本身所做的任何更改（当表达式包含对VOLATILE函数的调用时，这一点很重要）。
输出
在成功完成时，一个COPY命令会返回一个形为
COPY count
的命令标签。
count是被复制
的行数。
注意
如果命令不是COPY ... TO STDOUT或者等效的
psql元命令\copy ... to stdout，
psql将只打印这个命令标签。这是为了防止弄混
命令标签和刚刚打印的数据。
备注
COPY TO可以与普通表和填充的物化视图一起使用。
例如，
COPY table
TO复制与
SELECT * FROM ONLY table相同的行。
但是，它不直接支持其他关系类型，
如分区表、继承子表或视图。
要从这些关系中复制所有行，请使用 COPY (SELECT * FROM
table) TO。
COPY FROM可以被用于普通表、外部表、分区表或者具有INSTEAD OF INSERT触发器的视图。
你必须拥有被COPY TO读取的表上的选择特权，
以及被COPY FROM插入的表上的插入特权。
拥有在命令中列出的列上的特权就可以了。
如果对表启用了行级安全性，相关的SELECT策略将应用于COPY
table TO语句。当前，有行级安全性的表不支持COPY FROM。不过可以使用等效的INSERT语句。
COPY命令中提到的文件会被服务器（而不是
客户端应用）直接读取或写入。因此它们必须位于数据库服务器（不是客户
端）的机器上或者是数据库服务器可以访问的。它们必须是
PostgreSQL用户（运行服务器的用户
ID）可访问的并且是可读或者可写的。类似地，用PROGRAM
指定的命令也会由服务器（不是客户端应用）直接执行，它也必须是
PostgreSQL用户可以执行的。
只允许数据库超级用户或者授予了角色pg_read_server_files、
pg_write_server_files及pg_execute_server_program
之一的用户COPY一个文件或者命令，
因为它允许读取或者写入服务器有特权访问的任何文件或者运行服务器有特权访问的程序。
不要把COPY和
psql指令
\copy
弄混。\copy会调用
COPY FROM STDIN或者COPY TO
STDOUT，然后读取/存储一个
psql客户端可访问的文件中的数据。
因此，在使用\copy时，文件的可访
问性和访问权利取决于客户端而不是服务器。
我们推荐在COPY中使用的文件名总是
指定为一个绝对路径。在COPY TO的
情况下服务器会强制这一点，但是对于
COPY FROM你可以选择从一个用相对
路径指定的文件中读取。该路径将根据服务器进程（而不是客户端）
的工作目录（通常是集簇的数据目录）解释。
用PROGRAM执行一个命令可能会受到操作系统
的访问控制机制（如 SELinux）的限制。
COPY FROM将调用目标表上的任何触发器
和检查约束。但是它不会调用规则。
对于标识列，COPY FROM命令将总是写上输入数据中提供的列值，这和INSERT的选项OVERRIDING SYSTEM VALUE的行为一样。
COPY输入和输出受到
DateStyle的影响。为了确保到其他
可能使用非默认DateStyle设置的
PostgreSQL安装的可移植性，在使用
COPY TO前应该把
DateStyle设置为ISO。避免转储
IntervalStyle设置为
sql_standard的数据也是一个好主意，因为负的区间值可能会
被具有不同IntervalStyle设置的服务器解释错误。
即使数据会被服务器直接从一个文件读取或者写入一个文件而不通过
客户端，输入数据也会被根据ENCODING选项或者当前
客户端编码解释，并且输出数据会被根据ENCODING或
者当前客户端编码进行编码。
COPY FROM 命令在执行过程中会将输入行物理插入到表中。
如果命令失败，这些行将处于已删除状态；这些行不可见，但仍会占用磁盘空间。
如果在大量复制操作进行到一半时发生失败，可能会浪费相当多的磁盘空间。
应使用 VACUUM 来回收浪费的空间。
FORCE_NULL和FORCE_NOT_NULL可以同时
用在同一列上。这会导致把已被引用的空字符串转换为空值并且把未引用的空值
字符串转换为空字符串。
文件格式文本格式
在使用text格式时，读取或写入的是一个文本文件，
其中每一行就是表中的一行。一行中的列被定界字符分隔。列值
本身是由输出函数产生的或者是可被输入函数接受的属于每个属性
数据类型的字符串。在为空值的列的位置使用指定的空字符串。如果
输入文件的任何行包含比预期更多或者更少的列，
COPY FROM将会抛出一个错误。
数据结束可以用仅包含反斜杠和句点的行表示 (\.)。
在从文件读取时，不需要结束数据标记，因为文件结束
完全可以满足这个要求；在这种情况下，此规定仅用于向后兼容。
然而，psql 使用 \. 来终止 COPY FROM
STDIN 操作（即，在 SQL 脚本中读取
行内 COPY 数据）。在这种情况下，该规则是必要的，以便能够在
脚本结束之前结束操作。
反斜线字符（\）可以被用在
COPY数据中来引用被用作行或者列定界符的
字符。特别地，如果下列字符作为一个列值的一部分出现，它们
必须被前置一个反斜线：反斜线本身、新行、回车以及
当前的定界符字符。
COPY TO会不加任何反斜线返回指定的空值串。
相反，COPY FROM会在移除反斜线之前把输入
与空值串相匹配。因此，一个空值串（例如\N）不会与实
际的数据值\N（它会被表示为\\N）搞混。
COPY FROM识别下列特殊的反斜线序列：
序列表示\b退格 (ASCII 8)\f换页 (ASCII 12)\n新行 (ASCII 10)\r回车 (ASCII 13)\t制表 (ASCII 9)\v纵向制表 (ASCII 11)\digits反斜线后跟一到三个八进制数字表示该数字代码对应的字节\xdigits反斜线加x后跟一到两个十六进制数字表示该数字代码对应的字节
当前，COPY TO不会发出一个八进制或十六进制位
反斜线序列，但是它确实把上面列出的其他序列用于那些控制字符。
任何上述表格中没有提到的其他反斜线字符将被当作表示其本身。不过，要注意
增加不必要的反斜线，因为那可能意外地产生一个匹配数据结束标记（
\.）或者空值串（默认是\N）的字符串。这些字符串
将在完成任何其他反斜线处理之前被识别。
强烈建议产生COPY数据的应用把数据新行和回车分别
转换为\n和\r序列。当前可以把一个数据回车表示为
一个反斜线和回车，把一个数据新行表示为一个反斜线和新行。不过，未来的发行
可能不会接受这些表示。如果在不同的机器之间（例如从 Unix 到 Windows）
传输COPY文件，它们也很容易受到破坏。
所有反斜线序列都在编码转换后进行解释。
用八进制和十六进制数字反斜线序列指定的字节必须在数据库编码中形成有效字符。
COPY TO将用一个 Unix 风格的新行（
“\n”）终止每一行。运行在 Microsoft Windows
上的服务器则会输出回车/新行（“\r\n”），不过只对
COPY到一个服务器文件这样做。为了做到跨平台一致，
COPY TO STDOUT总是发送“\n”而
不管服务器平台是什么。COPY FROM能够处理以
新行、回车或者回车/新行结尾的行。为了减少由作为数据的未加反斜线的新行
或者回车带来的风险，如果输入中的行结束并不完全相似，
COPY FROM将会抱怨。
CSV 格式
此格式选项用于导入和导出许多其他程序（如电子表格）使用的逗号分隔值 (CSV) 文件格式。
它产生并识别常见的 CSV 转义机制，而不是使用 PostgreSQL 的标准文本格式所使用的转义规则。
每个记录中的值用 DELIMITER 字符分隔。如果值包含
定界符字符、QUOTE 字符、NULL 字符串、
一个回车或者换行字符，那么整个值会被加上 QUOTE 字符
作为前缀或者后缀，并且在该值内 QUOTE 字符或者
ESCAPE 字符的任何一次出现之前放上转义字符。在输出
指定列中非 NULL 值时，还可以使用
FORCE_QUOTE 来强制加上引用。
CSV 格式没有标准方式来区分 NULL 值和空字符串。
PostgreSQL 的 COPY 用引用来处理
这种区分工作。NULL 被按照 NULL 参数字符串输出
并且不会被引用，而匹配 NULL 参数字符串的非 NULL
值会被加上引用。例如，使用默认设置时，NULL 被写作一个未
被引用的空字符串，而一个空字符串数据值会被写成带双引号（""）。
值的读取遵循类似的规则。你可以用 FORCE_NOT_NULL 来防止
对指定列的 NULL 输入比较。你还可以使用
FORCE_NULL 把带引用的空值字符串数据值转换成 NULL。
由于反斜杠在 CSV 格式中不是特殊字符，因此在读取 CSV
数据时，文本模式下使用的结束数据标记 (\.) 通常不会被视为特殊。
例外情况是，psql 将在包含仅有 \. 的行中终止
COPY FROM STDIN 操作（即，在 SQL 脚本中读取
行内 COPY 数据），无论它是文本模式还是 CSV 模式。
注意
PostgreSQL 版本在 v18 之前始终将未加引号的 \. 识别为结束数据标记，
即使在从单独的文件读取时也是如此。为了与旧版本兼容，COPY TO
将在单独一行时对 \. 进行引号处理，尽管这已不再必要。
注意
在 CSV 格式中，所有字符都是有意义的。一个被空白或者其他
非 DELIMITER 字符围绕的引用值将包括那些字符。在导入
来自用空白填充 CSV 行到固定长度的系统的数据时，这可能
会导致错误。如果出现这种情况，在导入数据到
PostgreSQL 之前，你可能需要预处理该
CSV 文件以移除拖尾的空白。
注意
CSV 格式将识别并生成带有引号的 CSV 文件，这些文件的值中
包含嵌入的回车和换行符。因此，这些文件不像文本格式文件那样严格地
每个表行对应一行。
注意
许多程序会生成奇怪且有时令人费解的 CSV 文件，因此这种文件格式
更像是一种约定而非标准。因此，您可能会遇到一些无法通过此机制导入的文件，
并且 COPY 可能会生成其他程序无法处理的文件。
二进制格式
binary格式选项导致所有数据被以二进制格式
而不是文本格式存储/读取。它比文本和CSV格式要
快一些，但是二进制格式文件在不同的机器架构和
PostgreSQL版本之间的可移
植性要差些。此外，二进制格式与数据类型非常相关。例如不能从
一个smallint列中输出二进制数据并且把它读入到一个
integer列中，虽然这样做在文本格式中是可行的。
binary文件格式由一个文件头、零个或者更多个包含
行数据的元组以及一个文件尾构成。头部和数据都以网络字节序表示。
注意
7.4 之前的PostgreSQL发行
使用一种不同的二进制文件格式。
文件头
文件头由 15 字节的固定域构成，后面跟着一个变长的头部扩展区。
固定域有：
签名
11-字节的序列PGCOPY\n\377\r\n\0 — 注意
零字节是签名的一个必要的部分（该签名是为了能容易地发现文件被
非 8 位干净传输所破坏。这个签名将被行尾翻译过
滤器、删除零字节、删除高位或者奇偶修改等改变）。
标志域
32-位整数位掩码，用以表示该文件格式的重要方面。位被编号为
从 0 （LSB）到 31（MSB）。
注意这个域以网络字节序存放（最高有效位在前），所有该文件格式
中使用的整数域都是这样。16-31 位被保留用来表示严重的文件格式
问题， 读取者如果在这个范围内发现预期之外的被设置位，它应该
中止。0-15 位被保留用来表示向后兼容的格式问题，读取者应该简单
地略过这个范围内任何预期之外的被设置位。当前只定义了一个标志
位，其他位必须为零：
位 16
如果为 1，表示数据中包含 OID；如果为 0，则不包含。PostgreSQL不再支持Oid系统列，但是格式仍然包含该指示符。
头部扩展区长度
32-位整数，表示头部剩余部分的以字节计的长度，不包括其本身。
当前，这个长度为零，并且其后就紧跟着第一个元组。未来对该
格式的更改可能会允许在头部中表示额外的数据。如果读取者不知
道要对头部扩展区数据做什么，可以安静地跳过它。
头部扩展区域被预期包含一个能自我识别的块的序列。
该标志域并不想告诉读取者扩展数据是什么。详细的
头部扩展内容的设计留给后来的发行去做。
这种设计允许向后兼容的头部增加（增加头部扩展块或者设置低位标志位）以及
非向后兼容的更改（设置高位标志位来表示这类更改并且在需要时向扩展区域
中增加支持数据）。
元组
每一个元组由一个表示元组中字段数量的 16 位整数计数开始（当前，一个表中
的所有元组都应该具有相同的计数，但是这可能不会总是为真）。然后是元组
中的每一个字段，它是一个 32 位的长度字，后面则跟随着这么多个字节的字段
数据（长度字不包括其本身，并且可以是零）。作为一种特殊情况，-1 表示一个
NULL 字段值。在 NULL 情况下，后面不会跟随值字节。
在字段之间没有对齐填充或者任何其他额外的数据。
当前，一个二进制格式文件中的所有数据值都被假设为二进制格式（格式代码一）。
可以预见未来的扩展可能会增加一个允许独立指定各列的格式代码的头部字段。
要为实际的元组数据决定合适的二进制格式，你应该参考
PostgreSQL源码，特别是用于各列
数据类型的*send和*recv函数（通常可
以在源码的src/backend/utils/adt/目录中找到
这些函数）。
如果文件中包含 OID，OID 字段会紧跟在字段计数字之后。它是一个普通字段，
不过它没有被包含在字段计数中。注意PostgreSQL当前版本不支持oid系统列。
文件尾
文件尾由一个包含 -1 的 16 位整数字组成。这很容易与一个
元组的字段计数字区分开。
如果一个字段计数词既不是 -1 也不是期望的列数，读取者应该报告错误。
这提供了一种针对某种数据不同步的额外检查。
示例
下面的例子使用竖线（|）作为字段定界符把一个表复制到客户端：
COPY country TO STDOUT (DELIMITER '|');
从一个文件中复制数据到country表：
COPY country FROM '/usr1/proj/bray/sql/country_data';
只把名称以 'A' 开头的国家复制到一个文件：
COPY (SELECT * FROM country WHERE country_name LIKE 'A%') TO '/usr1/proj/bray/sql/a_list_countries.copy';
要复制到一个压缩文件中，你可以用管道把输出导入一个外部压缩程序：
COPY country TO PROGRAM 'gzip > /usr1/proj/bray/sql/country_data.gz';
这里是一个适合于从STDIN复制到表中的数据：
AF      AFGHANISTAN
AL      ALBANIA
DZ      ALGERIA
ZM      ZAMBIA
ZW      ZIMBABWE
注意每一行上的空白实际是一个制表符。
下面是用二进制格式输出的相同数据。该数据是用 Unix 工具
od -c过滤后显示的。该表具有三列，
第一列类型是char(2)，第二列类型是text，
第三列类型是integer。所有行在第三列都是空值。
0000000   P   G   C   O   P   Y  \n 377  \r  \n  \0  \0  \0  \0  \0  \0
0000020  \0  \0  \0  \0 003  \0  \0  \0 002   A   F  \0  \0  \0 013   A
0000040   F   G   H   A   N   I   S   T   A   N 377 377 377 377  \0 003
0000060  \0  \0  \0 002   A   L  \0  \0  \0 007   A   L   B   A   N   I
0000100   A 377 377 377 377  \0 003  \0  \0  \0 002   D   Z  \0  \0  \0
0000120 007   A   L   G   E   R   I   A 377 377 377 377  \0 003  \0  \0
0000140  \0 002   Z   M  \0  \0  \0 006   Z   A   M   B   I   A 377 377
0000160 377 377  \0 003  \0  \0  \0 002   Z   W  \0  \0  \0  \b   Z   I
0000200   M   B   A   B   W   E 377 377 377 377 377 377
兼容性
SQL 标准中没有COPY语句。
下列语法用于PostgreSQL 9.0 之前的版本，
并且仍然被支持：
COPY table_name [ ( column_name [, ...] ) ]
FROM { 'filename' | STDIN }
[ [ WITH ]
[ BINARY ]
[ DELIMITER [ AS ] 'delimiter_character' ]
[ NULL [ AS ] 'null_string' ]
[ CSV [ HEADER ]
[ QUOTE [ AS ] 'quote_character' ]
[ ESCAPE [ AS ] 'escape_character' ]
[ FORCE NOT NULL column_name [, ...] ] ] ]
COPY { table_name [ ( column_name [, ...] ) ] | ( query ) }
TO { 'filename' | STDOUT }
[ [ WITH ]
[ BINARY ]
[ DELIMITER [ AS ] 'delimiter_character' ]
[ NULL [ AS ] 'null_string' ]
[ CSV [ HEADER ]
[ QUOTE [ AS ] 'quote_character' ]
[ ESCAPE [ AS ] 'escape_character' ]
[ FORCE QUOTE { column_name [, ...] | * } ] ] ]
注意在这种语法中，BINARY和CSV被视作独立的关键词，
而不是FORMAT选项的参数。
下列语法用于PostgreSQL 7.3 之前的版本，
并且仍然被支持：
COPY [ BINARY ] table_name
FROM { 'filename' | STDIN }
[ [USING] DELIMITERS 'delimiter_character' ]
[ WITH NULL AS 'null_string' ]
COPY [ BINARY ] table_name
TO { 'filename' | STDOUT }
[ [USING] DELIMITERS 'delimiter_character' ]
[ WITH NULL AS 'null_string' ]
另见第 27.4.3 节上一页 上一级 下一页COMMIT PREPARED 起始页 CREATE ACCESS METHOD
