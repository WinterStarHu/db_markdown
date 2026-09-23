# 32.3. 命令执行函数

32.3. 命令执行函数
版本：
纠错本页面
搜索
目录导航
❮
❯
32.3. 命令执行函数 #32.3.1. 主要函数32.3.2. 检索查询结果信息32.3.3. 检索其他结果信息32.3.4. 用于包含在 SQL 命令中的转义字符串
一旦到一个数据库服务器的连接被成功建立，这里描述的函数可以用来执行
SQL 查询和命令。
32.3.1. 主要函数 #
PQexec #
提交一个命令给服务器并且等待结果。
PGresult *PQexec(PGconn *conn, const char *command);
返回一个PGresult指针或者可能是一个空指针。
除了内存不足的情况或者由于严重错误无法将命令发送给服务器之外，一般都会返回一个非空指针。
PQresultStatus函数应当被调用来检查返回值是否代表错误（包括空指针的值，它会返回PGRES_FATAL_ERROR）。
用
PQerrorMessage
可得到关于那些错误的详细信息。
命令字符串可以包括多个 SQL 命令（用分号分隔）。
在一次PQexec调用中被发送的多个查询会在一个事务中处理，除非其中有显式的BEGIN/COMMIT命令将该查询字符串划分成多个事务（服务器如何处理多查询字符串的更多细节请参考第 54.2.2.1 节）。
但是注意，返回的PGresult结构只描述该字符串中被执行的最后一个命令的结果。
如果一个命令失败，该字符串的处理会在它那里停止并且返回的PGresult会描述错误情况。
PQexecParams #
提交一个命令给服务器并且等待结果，它可以在 SQL 命令文本之外独立地传递参数。
PGresult *PQexecParams(PGconn *conn,
const char *command,
int nParams,
const Oid *paramTypes,
const char * const *paramValues,
const int *paramLengths,
const int *paramFormats,
int resultFormat);
PQexecParams与PQexec相似，但是提供了额外的功能：参数值可以与命令字符串分开指定，并且可以以文本或二进制格式请求查询结果。
该函数的参数是：
conn
要在其中发送命令的连接对象。
command
要执行的 SQL 命令字符串。如果使用了参数，它们在该命令字符串中被引用为$1、$2等。
nParams
提供的参数数量。它是数组paramTypes[]、paramValues[]、paramLengths[]和paramFormats[]的长度（当nParams为零时，数组指针可以是NULL）。
paramTypes[]
通过 OID 指定要赋予给参数符号的数据类型。如果paramTypes为NULL或者该数组中任何特定元素为零，服务器会用对待未知类型文字串的方式为参数符号推测一种数据类型。
paramValues[]
指定参数的实际值。这个数组中的一个空指针表示对应的参数为空，否则该指针指向一个以零终止的文本字符串（用于文本格式）或者以服务器所期待格式的二进制数据（用于二进制格式）。
paramLengths[]
指定二进制格式参数的实际数据长度。它对空参数和文本格式参数被忽略。当没有二进制参数时，该数组指针可以为空。
paramFormats[]
指定参数是否为文本（在参数相应的数组项中放一个零）或二进制（在参数相应的数组项中放一个一）。如果该数组指针为空，那么所有参数都会被假定为文本串。
以二进制格式传递的值要求后端所期待的内部表示形式的知识。例如，整数必须以网络字节序被传递。传递numeric值要求关于服务器存储格式的知识，正如src/backend/utils/adt/numeric.c::numeric_send()以及src/backend/utils/adt/numeric.c::numeric_recv()中所实现的。
resultFormat
指定零来得到文本格式的结果，或者指定一来得到二进制格式的结果（目前没有规定要求以不同格式得到不同的结果列，尽管在底层协议中这是可以实现的）。
PQexecParams相对于PQexec的主要优点是参数值可以从命令字符串中分离，因此避免了冗长的书写、容易发生错误的引用以及转义。
和PQexec不同，PQexecParams至多允许在给定字符串中出现一个 SQL 命令（其中可以有分号，但是不能有超过一个非空命令）。这是底层协议的一个限制，但是有助于抵抗 SQL 注入攻击。
提示
通过 OID 指定参数类型很繁琐，特别是如果你不愿意将特定的 OID 值硬编码到你的程序中时。不过，即使服务器本身也无法确定参数的类型，或者选择了一种与你想要的不同的类型，你也可以避免这样做。在 SQL 命令文本中，附加一个显式类型转换给参数符号来表示你将发送什么样的数据类型。例如：
SELECT * FROM mytable WHERE x = $1::bigint;
这强制参数$1被当作bigint，而默认情况下它将被赋予与x相同的类型。当以二进制格式发送参数值时，我们强烈推荐以这种方式或通过指定一个数字类型的 OID 来强制参数类型决定。因为二进制格式比文本格式具有更少的冗余，因此服务器将不会有更多机会为你检测一个类型匹配错误。
PQprepare #
提交请求以使用给定参数创建一个预处理语句，并等待完成。
PGresult *PQprepare(PGconn *conn,
const char *stmtName,
const char *query,
int nParams,
const Oid *paramTypes);
PQprepare 创建一个预处理语句，以便稍后使用 PQexecPrepared
执行。此功能允许命令被重复执行，而无需每次都进行解析和规划；详见 PREPARE。
该函数从 query 字符串创建一个名为 stmtName 的预处理语句，
该字符串必须包含单个 SQL 命令。stmtName 可以是 "" 来创建一个无名语句，
在这种情况下，任何预先存在的无名语句都会被自动替换；否则，如果当前会话中已定义该语句名，则会报错。
如果使用了参数，则在查询中以 $1、$2 等形式引用它们。
nParams 是预先指定类型的参数数量，类型存储在数组 paramTypes[] 中。
（当 nParams 为零时，数组指针可以是 NULL。）paramTypes[]
通过 OID 指定分配给参数符号的数据类型。如果 paramTypes 是 NULL，
或数组中的某个元素为零，服务器会以未类型化的字面字符串方式为参数符号分配数据类型。
此外，查询可以使用编号高于 nParams 的参数符号；这些符号的数据类型也会被推断。
（参见 PQdescribePrepared 了解如何查询推断的数据类型。）
与 PQexec 类似，结果通常是一个 PGresult 对象，
其内容指示服务器端的成功或失败。空结果表示内存不足或无法发送命令。
使用
PQerrorMessage
获取有关此类错误的更多信息。
用于 PQexecPrepared 的预处理语句也可以通过执行 SQL PREPARE
语句来创建。
PQexecPrepared #
发送一个请求来执行一个带有给定参数的预处理语句，并等待结果。
PGresult *PQexecPrepared(PGconn *conn,
const char *stmtName,
int nParams,
const char * const *paramValues,
const int *paramLengths,
const int *paramFormats,
int resultFormat);
PQexecPrepared类似于PQexecParams，
但要执行的命令是通过指定先前准备好的语句来指定，而不是提供查询字符串。
此功能允许重复使用的命令只被解析和计划一次，而不是每次执行时都要进行。
该语句必须在当前会话中先前准备好。
参数与PQexecParams相同，只是给出了预处理语句的名称而不是查询字符串，
并且paramTypes[]参数不存在（因为在创建预处理语句时已确定了参数类型）。
PQdescribePrepared #
提交请求以获取有关指定预处理语句的信息，并等待完成。
PGresult *PQdescribePrepared(PGconn *conn, const char *stmtName);
PQdescribePrepared允许应用程序获取关于先前准备的语句的信息。
stmtName可以是""或NULL来引用
未命名的语句，否则必须是现有准备好的语句的名称。成功时，返回一个
状态为PGRES_COMMAND_OK的PGresult。
函数PQnparams和
PQparamtype可以应用于此
PGresult以获取有关准备语句参数的信息，
函数PQnfields、PQfname、
PQftype等提供有关语句的结果列（如果有）的信息。
PQdescribePortal #
提交请求以获取有关指定门户的信息，并等待完成。
PGresult *PQdescribePortal(PGconn *conn, const char *portalName);
PQdescribePortal允许应用程序获取有关先前创建的门户的信息。
(libpq不直接提供对门户的访问，但您可以使用此函数检查使用DECLARE CURSOR SQL命令创建的游标的属性。)
portalName可以是""或NULL来引用未命名的门户，
否则必须是现有门户的名称。成功时，将返回一个带有状态PGRES_COMMAND_OK的PGresult。
函数PQnfields、PQfname、PQftype等可应用于
PGresult，以获取有关门户的结果列（如果有）的信息。
PQclosePrepared #
提交请求以关闭指定的预处理语句，并等待完成。
PGresult *PQclosePrepared(PGconn *conn, const char *stmtName);
PQclosePrepared 允许应用程序关闭先前准备好的语句。关闭语句会释放服务器上
与其相关的所有资源，并允许重新使用其名称。
stmtName 可以是 "" 或
NULL，用于引用未命名的语句。如果不存在该名称的语句，
也没关系，在这种情况下操作不会执行任何操作。成功时，会返回一个
PGresult，其状态为 PGRES_COMMAND_OK。
PQclosePortal #
提交请求以关闭指定的门户，并等待完成。
PGresult *PQclosePortal(PGconn *conn, const char *portalName);
PQclosePortal 允许应用程序触发关闭先前创建的门户。
关闭门户会释放服务器上所有相关资源，并允许重用其名称。
(libpq 不提供对门户的直接访问，但您可以使用此函数关闭
通过 DECLARE CURSOR SQL 命令创建的游标。)
portalName 可以是 "" 或
NULL，用于引用未命名的门户。如果不存在具有此名称的门户，
也没关系，在这种情况下操作不会执行任何操作。成功时，将返回状态为
PGRES_COMMAND_OK 的 PGresult。
PGresult
结构封装了服务器返回的结果。
libpq 应用程序开发人员应该小心维护
PGresult 抽象。使用下面的访问器函数来获取
PGresult 的内容。避免直接引用
PGresult 结构的字段，因为它们在未来可能会发生变化。
PQresultStatus #
返回命令的结果状态。
ExecStatusType PQresultStatus(const PGresult *res);
PQresultStatus 可以返回以下值之一：
PGRES_EMPTY_QUERY #
发送到服务器的字符串是空的。
PGRES_COMMAND_OK #
成功完成一个不返回数据的命令。
PGRES_TUPLES_OK #
成功完成返回数据的命令（例如SELECT或SHOW）。
PGRES_COPY_OUT #
从服务器复制数据传输已开始。
PGRES_COPY_IN #
开始进行复制到服务器的数据传输。
PGRES_BAD_RESPONSE #
服务器的响应无法理解。
PGRES_NONFATAL_ERROR #
发生了一个非致命错误（通知或警告）。
PGRES_FATAL_ERROR #
发生了致命错误。
PGRES_COPY_BOTH #
开始进行数据传输（从服务器复制到服务器）。此功能目前仅用于流式复制，
因此在普通应用程序中不应出现此状态。
PGRES_SINGLE_TUPLE #
PGresult包含当前命令的单个结果元组。
仅当查询选择了单行模式时才会出现此状态
（请参阅第 32.6 节）。
PGRES_TUPLES_CHUNK #
PGresult包含当前命令的多个结果元组。
该状态仅在查询选择了分块模式时出现
（参见第 32.6 节）。
元组数量不会超过传递给
PQsetChunkedRowsMode的限制。
PGRES_PIPELINE_SYNC #
PGresult表示流水线模式中的一个同步点，由
PQpipelineSync或
PQsendPipelineSync请求。
该状态仅在选择流水线模式时出现。
PGRES_PIPELINE_ABORTED #
PGresult表示接收到服务器错误的管道。
必须重复调用PQgetResult，每次调用都会返回此状态码，
直到当前管道结束，此时它将返回PGRES_PIPELINE_SYNC，
然后就可以恢复正常处理。
如果结果状态是PGRES_TUPLES_OK、
PGRES_SINGLE_TUPLE或
PGRES_TUPLES_CHUNK，则下面描述的函数可用于检索查询返回的行。
注意，即使SELECT命令检索到零行，仍然显示
PGRES_TUPLES_OK。
PGRES_COMMAND_OK用于永远不会返回行的命令（如
INSERT或UPDATE，且没有
RETURNING子句等）。
PGRES_EMPTY_QUERY的响应可能表示客户端软件中的一个错误。
状态PGRES_NONFATAL_ERROR的结果永远不会直接由
PQexec或其他查询执行函数返回；此类结果
会被传递给通知处理器（参见第 32.13 节）。
PQresStatus #
将由PQresultStatus返回的枚举类型转换为描述状态代码的
字符串常量。调用者不应释放结果。
char *PQresStatus(ExecStatusType status);
PQresultErrorMessage #
返回与命令相关的错误消息，如果没有错误，则返回一个空字符串。
char *PQresultErrorMessage(const PGresult *res);
如果存在错误，返回的字符串将包含一个尾随的换行符。调用者不应直接
释放结果。当关联的PGresult句柄被传递给
PQclear时，它将被释放。
紧接着调用PQexec或
PQgetResult之后，
连接上的
PQerrorMessage
将返回与
结果上的PQresultErrorMessage相同的字符串。
然而，一个PGresult会保留其错误信息直到被销毁，
而连接的错误信息会在后续操作完成时发生变化。
当您想了解与特定PGresult相关的状态时，
请使用PQresultErrorMessage；
当您想了解连接上最新操作的状态时，
请使用
PQerrorMessage
。
PQresultVerboseErrorMessage #
返回与PGresult对象相关的错误消息的重新格式化版本。
char *PQresultVerboseErrorMessage(const PGresult *res,
PGVerbosity verbosity,
PGContextVisibility show_context);
在某些情况下，客户端可能希望获取先前报告的错误的更详细版本。
PQresultVerboseErrorMessage通过计算在生成给定
的PGresult时，如果连接的指定详细设置生效，
PQresultErrorMessage将会生成的消息来满足这一需求。
如果PGresult不是错误结果，则会报告
“PGresult 不是错误结果”。返回的字符串包括一个尾随换行符。
与大多数其他用于从PGresult中提取数据的函数不同，
此函数的结果是一个新分配的字符串。调用者必须在字符串不再需要时，
使用PQfreemem()释放它。
如果内存不足，可能会返回NULL。
PQresultErrorField #
返回错误报告的单个字段。
char *PQresultErrorField(const PGresult *res, int fieldcode);
fieldcode 是一个错误字段标识符；请参阅下面列出的符号。
如果 PGresult 不是错误或警告结果，或者不包含指定字段，
则返回 NULL。字段值通常不会包含尾随换行符。
调用者不应直接释放结果。当关联的
PGresult 句柄被传递给
PQclear 时，它将被释放。
以下字段代码可用：
PG_DIAG_SEVERITY #
严重性；字段内容为ERROR、FATAL或
PANIC（在错误消息中），或者WARNING、
NOTICE、DEBUG、INFO或
LOG（在通知消息中），或者是这些之一的本地化翻译。始终存在。
PG_DIAG_SEVERITY_NONLOCALIZED #
严重性；字段内容为ERROR、
FATAL或PANIC（在错误消息中），
或WARNING、NOTICE、
DEBUG、INFO或LOG
（在通知消息中）。这与PG_DIAG_SEVERITY字段完全相同，
只是内容从未被本地化。此字段仅出现在由
PostgreSQL 9.6及更高版本生成的报告中。
PG_DIAG_SQLSTATE #
错误的SQLSTATE代码。SQLSTATE代码标识发生的错误类型；前端应用程序可以
使用它来执行特定操作（例如错误处理）以响应特定的数据库错误。
有关可能的SQLSTATE代码的列表，请参见附录 A。此字段不可本地化，并且始终存在。
PG_DIAG_MESSAGE_PRIMARY #
主要的人类可读错误信息（通常为一行）。始终存在。
PG_DIAG_MESSAGE_DETAIL #
详情：一个可选的次要错误信息，提供有关问题的更多
细节。可能会占用多行。
PG_DIAG_MESSAGE_HINT #
提示：关于如何解决问题的可选建议。
这与细节不同，因为它提供建议（可能不合适），而不是硬性事实。
可能会占用多行。
PG_DIAG_STATEMENT_POSITION #
包含一个十进制整数的字符串，表示错误光标位置，作为原始语句字符串
的索引。第一个字符的索引为1，位置以字符而非字节为单位测量。
PG_DIAG_INTERNAL_POSITION #
这与PG_DIAG_STATEMENT_POSITION字段的定义相同，但当光标位置
指向一个内部生成的命令而不是客户端提交的命令时使用。每当此字段出现时，
PG_DIAG_INTERNAL_QUERY字段也会始终出现。
PG_DIAG_INTERNAL_QUERY #
内部生成的命令失败的文本。例如，这可能是由PL/pgSQL函数发出的
SQL查询。
PG_DIAG_CONTEXT #
指示错误发生的上下文。目前，这包括活动过程语言函数和内部生成查询的调用堆栈回溯。
跟踪信息每行一个条目，最近的条目在最前面。
PG_DIAG_SCHEMA_NAME #
如果错误与特定的数据库对象相关，则包含该对象的模式名称（如果有）。
PG_DIAG_TABLE_NAME #
如果错误与特定表相关，则为该表的名称。（请参阅模式名称字段以获取
表的模式名称。）
PG_DIAG_COLUMN_NAME #
如果错误与特定的表列相关，则为列的名称。（请参阅模式和表名字段以
确定表。）
PG_DIAG_DATATYPE_NAME #
如果错误与特定数据类型相关，则为该数据类型的名称。（请参阅模式名称字段以获取
数据类型的模式名称。）
PG_DIAG_CONSTRAINT_NAME #
如果错误与特定约束相关，则为约束的名称。请参阅上面列出的字段，
以获取相关的表或域。（在此情况下，索引被视为约束，即使它们不是
使用约束语法创建的。）
PG_DIAG_SOURCE_FILE #
错误报告所在源代码位置的文件名。
PG_DIAG_SOURCE_LINE #
错误报告所在源代码位置的行号。
PG_DIAG_SOURCE_FUNCTION #
报告错误的源代码函数名称。
注意
架构名称、表名称、列名称、数据类型名称和约束名称字段仅适用于有限
类型的错误；请参见附录 A。不要假设这些
字段中的任何一个的存在就能保证另一个字段的存在。核心错误来源遵循
上述的相互关系，但用户定义的函数可能以其他方式使用这些字段。同样，
不要假设这些字段表示当前数据库中的现有对象。
客户端负责格式化显示的信息以满足其需求；特别是，它应该根据需要
换行。错误消息字段中出现的换行符应被视为段落分隔符，而不是
换行符。
由libpq内部生成的错误将具有严重性和主要消息，
但通常没有其他字段。
请注意，错误字段仅可从PGresult对象中获取，
而不能从PGconn对象中获取；没有
PQerrorField函数。
PQclear #
释放与PGresult相关联的存储。每个命令结果在不再需要时，
都应该通过PQclear释放。
void PQclear(PGresult *res);
如果参数是NULL指针，则不执行任何操作。
您可以保留一个PGresult对象，只要您需要它；它不会在您发
出新命令时消失，甚至在您关闭连接时也不会消失。要删除它，您必须调用
PQclear。未能这样做将导致您的应用程序中出现内存泄漏。
32.3.2. 检索查询结果信息 #
这些函数用于从表示成功查询结果的
PGresult对象中提取信息（即状态为
PGRES_TUPLES_OK、
PGRES_SINGLE_TUPLE或
PGRES_TUPLES_CHUNK的对象）。
它们也可用于从成功的Describe操作中提取信息：Describe的结果
拥有与实际执行查询相同的所有列信息，但行数为零。对于其他状态值的对象，
这些函数将表现得好像结果有零行零列。
PQntuples #
返回查询结果中的行（元组）数（注意，PGresult对象被限制为不超过INT_MAX行，因此一个int结果就足够了）。
int PQntuples(const PGresult *res);
PQnfields #
返回查询结果中每一行的列（字段）数。
int PQnfields(const PGresult *res);
PQfname #
返回与给定列号相关联的列名。列号从 0 开始。调用者不应该直接释放该结果。它将在相关的PGresult句柄被传递给PQclear之后被释放。
char *PQfname(const PGresult *res,
int column_number);
如果列号超出范围，将返回NULL。
PQfnumber #
返回与给定列名相关联的列号。
int PQfnumber(const PGresult *res,
const char *column_name);
如果给定的名字不匹配任何列，将返回 -1。
给定的名称被视作一个 SQL 命令中的一个标识符，也就是说，除非被双引号引用，它是小写形式的。例如，给定一个 SQL 命令：
SELECT 1 AS FOO, 2 AS "BAR";
我们将得到结果：
PQfname(res, 0)              foo
PQfname(res, 1)              BAR
PQfnumber(res, "FOO")        0
PQfnumber(res, "foo")        0
PQfnumber(res, "BAR")        -1
PQfnumber(res, "\"BAR\"")    1
PQftable #
返回给定列从中取出的表的 OID。列号从 0 开始。
Oid PQftable(const PGresult *res,
int column_number);
如果列号超出范围，或者指定的列不是对一个表列的简单引用时，返回InvalidOid。
你可以查询系统表pg_class来确定究竟是哪个表被引用。
当你包括libpq头文件，类型Oid以及常数InvalidOid将被定义。它们将都是某种整数类型。
PQftablecol #
返回构成指定查询结果列的列（在其表中）的列号。查询结果列号从0开始，但是表列具有非零编号。
int PQftablecol(const PGresult *res,
int column_number);
如果列号超出范围，或者指定的列不是对一个表列的简单引用时，返回零。
PQfformat #
返回指示给定列格式的格式编码。列号从0开始。
int PQfformat(const PGresult *res,
int column_number);
格式代码零指示文本数据表示，而格式代码一指示二进制表示。（其他代码被保留用于未来的定义。）
PQftype #
返回与给定列号相关联的数据类型。返回的整数是该类型的内部 OID 号。列号从 0 开始。
Oid PQftype(const PGresult *res,
int column_number);
你可以查询系统表pg_type来获取多个数据类型的名称和属性。内置数据类型的OID在catalog/pg_type_d.h文件中定义，该文件位于PostgreSQL安装的include目录下。
PQfmod #
返回与给定列号相关联的列的修饰符类型。列号从 0 开始。
int PQfmod(const PGresult *res,
int column_number);
修饰符值的解释是与类型相关的，它们通常指示精度或大小限制。值 -1 被用来指示“没有信息可用”。大多数数据类型不使用修饰符，在这种情况下值总是 -1。
PQfsize #
返回与给定列号相关联的列的大小（以字节为单位）。列号从 0 开始。
int PQfsize(const PGresult *res,
int column_number);
PQfsize返回在一个数据库行中为这个列分配的空间，换句话说是服务器对该数据类型的内部表示的大小（因此，它对客户端并不是真正非常有用）。一个负值指示该数据类型是变长的。
PQbinaryTuples #
如果PGresult包含二进制数据，返回 1。如果包含的是文本数据，返回 0。
int PQbinaryTuples(const PGresult *res);
这个函数已经被废弃（除了与COPY一起使用），因为一个单一PGresult可以在某些列中包含文本数据而在另一些列中包含二进制数据。
PQfformat是更优选。只有结果的所有列是二进制（格式 1）时PQbinaryTuples才返回 1。
PQgetvalue #
返回一个PGresult的一行的单一字段值。行和列号从 0 开始。调用者不应该直接释放该结果。
它将在相关的PGresult句柄被传递给PQclear之后被释放。
char *PQgetvalue(const PGresult *res,
int row_number,
int column_number);
对于文本格式的数据，PQgetvalue返回的值是该字段值的一种空值结束的字符串表示。对于二进制格式的数据，该值是由该数据类型的typsend和typreceive函数决定的二进制表示（在这种情况下该值实际上也跟随着一个零字节，但是这通常没有用处，因为该值很可能包含嵌入的空）。
如果该字段值为空，则返回一个空字符串。关于区分空值和空字符串值请见PQgetisnull。
PQgetvalue返回的指针指向作为PGresult结构一部分的存储。我们不应该修改它指向的数据，并且如果要在超过PGresult结构本身的生命周期之外使用它，我们必须显式地把该数据拷贝到其他存储中。
PQgetisnull #
测试一个字段是否为空值。行号和列号从 0 开始。
int PQgetisnull(const PGresult *res,
int row_number,
int column_number);
如果该字段为空，这个函数返回 1。如果它包含一个非空值，则返回 0（注意PQgetvalue将为一个空字段返回一个空串，不是一个空指针）。
PQgetlength #
返回一个字段值的真实长度，以字节计。行号和列号从 0 开始。
int PQgetlength(const PGresult *res,
int row_number,
int column_number);
这是特定数据值的真实数据长度，也就是PQgetvalue指向的对象的大小。
对于文本数据格式，这和strlen()相同。对于二进制格式这是基本信息。
注意我们不应该依赖于PQfsize来获取真实的数据长度。
PQnparams #
返回一个预备语句的参数数量。
int PQnparams(const PGresult *res);
此函数仅在检查PQdescribePrepared的结果时有用。
对于其他类型的结果，它将返回零。
PQparamtype #
返回所指示的语句参数的数据类型。参数号从 0 开始。
Oid PQparamtype(const PGresult *res, int param_number);
此函数仅在检查PQdescribePrepared的结果时有用。
对于其他类型的结果，它将返回零。
PQprint #
将所有的行打印到指定的输出流，以及有选择地将列名打印到指定的输出流。
void PQprint(FILE *fout,      /* 输出流 */
const PGresult *res,
const PQprintOpt *po);
typedef struct
{
pqbool  header;      /* 打印输出域标题和行计数 */
pqbool  align;       /* 填充对齐域 */
pqbool  standard;    /* 旧的格式 */
pqbool  html3;       /* 输出 HTML 表格 */
pqbool  expanded;    /* 扩展表格 */
pqbool  pager;       /* 如果必要为输出使用页 */
char    *fieldSep;   /* 域分隔符 */
char    *tableOpt;   /* 用于 HTML 表格元素的属性 */
char    *caption;    /* HTML 表格标题 */
char    **fieldName; /* 替换域名称的空终止数组 */
} PQprintOpt;
这个函数以前被psql用来打印查询结果，但是现在不是这样了。注意它假定所有的数据都是文本格式。
32.3.3. 检索其他结果信息 #
这些函数用于从PGresult对象中提取其他信息。
PQcmdStatus #
返回来自于产生PGresult的 SQL 命令的命令状态标签。
char *PQcmdStatus(PGresult *res);
通常这就是该命令的名称，但它可能包括额外数据，例如已处理的行数。调用者
不应直接释放该结果。它将在相关的PGresult句柄被传递给
PQclear时被释放。
PQcmdTuples #
返回受该 SQL 命令影响的行数。
char *PQcmdTuples(PGresult *res);
该函数返回一个字符串，其中包含由生成PGresult的SQL语句影响的行数。
该函数只能在执行SELECT、CREATE TABLE AS、
INSERT、UPDATE、DELETE、
MERGE、MOVE、FETCH或COPY语句，
或包含INSERT、UPDATE、DELETE或MERGE语句的预处理查询的EXECUTE之后使用。
如果生成PGresult的命令是其他任何命令，PQcmdTuples将返回一个空字符串。
调用者不应直接释放返回值。当关联的PGresult句柄传递给PQclear时，它将被释放。
PQoidValue #
如果该SQL命令是一个正好将一行插入到具有 OIDs 的表的INSERT，或者是一个包含合适INSERT语句的预备查询的EXECUTE，这个函数返回被插入行的 OID。否则，这个函数返回InvalidOid。如果被INSERT语句影响的表不包含 OIDs，这个函数也将返回InvalidOid。
Oid PQoidValue(const PGresult *res);
PQoidStatus #
这个函数已经被PQoidValue取代，并且不是线程安全的。它返回包含被插入行的 OID 的一个字符串，而PQoidValue返回 OID 值。
char *PQoidStatus(const PGresult *res);
32.3.4. 用于包含在 SQL 命令中的转义字符串 #PQescapeLiteral #
char *PQescapeLiteral(PGconn *conn, const char *str, size_t length);
为了让一个字符串能用在 SQL 命令中，PQescapeLiteral可对它进行转义。
当在 SQL 命令中插入一个数据值作为文字常量时，这个函数很有用。一些字符（例如引号和反斜线）必须被转义以防止它们被 SQL 解析器解释成特殊的意思。
PQescapeLiteral执行这种操作。
PQescapeLiteral返回一个str参数的已被转义版本，该版本被放在用malloc()分配的内存中。
当该结果不再被需要时，这个内存应该用PQfreemem()释放。
一个终止的零字节不是必须的，并且不应该被计入length（如果在length字节被处理之前找到一个终止字节，PQescapeLiteral会停止在零，该行为更像strncpy）。
返回字符串中的所有特殊字符都被替换掉，这样它们能被PostgreSQL字符串解析器正确地处理。
还会加上一个终止零字节。包括在结果字符串中的PostgreSQL字符串必须用单引号包围。
发生错误时，PQescapeLiteral返回NULL并且一个合适的消息会被存储在conn对象中。
提示
在处理从一个非可信源接收到的字符串时，做正确的转义特别重要。否则就会有安全性风险：你容易受到“SQL 注入”攻击，其中可能会有预期之外的 SQL 语句被喂给你的数据库。
注意，当一个数据值被作为PQexecParams或其兄弟例程中的一个独立参数传递时，没有必要做转义而且做转义也不正确。
PQescapeIdentifier #
char *PQescapeIdentifier(PGconn *conn, const char *str, size_t length);
PQescapeIdentifier转义一个要用作 SQL 标识符的字符串，例如表名、列名或函数名。当一个用户提供的标识符可能包含被 SQL 解析器解释为标识符一部分的特殊字符时，或者当该标识符可能包含大小写形式应该被保留的大写字符时，这个函数很有用。
PQescapeIdentifier返回一个str参数的已被转义为 SQL 标识符的版本，该版本被放在用malloc()分配的内存中。
当该结果不再被需要时，这个内存应该用PQfreemem()释放。
一个终止的零字节不是必须的，并且不应该被计入length。（如果在length字节被处理之前找到一个终止字节，PQescapeIdentifier会停止在零；该行为更像strncpy。）
返回串中的所有特殊字符都被替换掉，这样它们能被作为一个 SQL 标识符正确地处理。还会加上一个终止零字节。返回串也将被双引号包围。
发生错误时，PQescapeIdentifier返回NULL并且一个合适的消息会被存储在conn对象中。
提示
与字符串字面量一样，要阻止 SQL 注入攻击，当从一个不可信的来源接收到 SQL 标识符时，它们必须被转义。
PQescapeStringConn #
size_t PQescapeStringConn(PGconn *conn,
char *to, const char *from, size_t length,
int *error);
PQescapeStringConn转义字符串字面量，它很像PQescapeLiteral。
与PQescapeLiteral不一样的是，调用者负责提供一个合适尺寸的缓冲区。
此外，PQescapeStringConn不产生必须包围PostgreSQL字符串的单引号；
它们应该在结果要插入的 SQL 命令中提供。参数from指向要被转义的串的第一个字符，并且length参数给出了这个串中的字节数。
一个终止的零字节不是必须的，并且不应该被计入length。（如果在length字节被处理之前找到一个终止字节，PQescapeStringConn会停止在零；该行为更像strncpy。）
to应当指向一个缓冲区，它能够保持至少比length值的两倍还要多至少一个字节，否则该行为是未定义的。
如果to和from串重叠，行为也是未定义的。
如果error参数不是NULL，那么成功时*error被设置为零，错误时设置为非零。
当前唯一可能的错误情况涉及源串中非法的多字节编码。错误时仍然会产生输出串，但是可以预期服务器将认为它是畸形的并且拒绝它。
在发生错误时，一个合适的消息被存储在conn对象中，不管error是不是NULL。
PQescapeStringConn返回写到to的字节数，不包括终止的零字节。
PQescapeString #
PQescapeString是一个较旧的被弃用版本的
PQescapeStringConn。
size_t PQescapeString (char *to, const char *from, size_t length);
PQescapeStringConn和PQescapeString之间的唯一区别是
PQescapeString不接受PGconn
或error参数。
正因为如此，它不能基于连接属性（例如字符编码）调整它的行为，因此
它可能给出错误的结果。此外，它没有方法
报告错误情况。
PQescapeString可以在一次只使用一个PostgreSQL连接的客户端程序中安全地使用（在这种情况下它可以“在幕后”找出它需要知道的东西）。
在其他环境中它是一个安全隐患，应该用PQescapeStringConn来替代。
PQescapeByteaConn #
把要用于一个 SQL 命令的二进制数据用类型bytea转义。和PQescapeStringConn一样，只有在将数据直接插入到一个 SQL 命令字符串时才使用它。
unsigned char *PQescapeByteaConn(PGconn *conn,
const unsigned char *from,
size_t from_length,
size_t *to_length);
当某些字节值被用作一个SQL语句中的bytea文字的一部分时，它们必须被转义。
PQescapeByteaConn使用十六进制编码或反斜线转义来转义字节。详见第 8.4 节以获取更多信息。
from参数指向要被转义的字符串的第一个字节，from_length参数给出这个二进制字符串中的字节数（一个终止的零字节既不是必需的也不被计算）。to_length参数指向一个将保存生成的已转义字符串长度的变量。这个结果字符串长度包括结果的终止零字节。
PQescapeByteaConn返回一个from参数的已被转义为二进制串的版本，该版本被放在用malloc()分配的内存中。
当该结果不再被需要时，这个内存应该用PQfreemem()释放。
返回串中的所有特殊字符都被替换掉，这样它们能被PostgreSQL的字符串解析器以及bytea输入函数正确地处理。
还会加上一个终止零字节。不是结果串的一部分的PostgreSQL字符串必须被单引号包围。
在发生错误时，将返回一个空指针，并且一个合适的错误消息被存储在conn对象中。当前，唯一可能的错误是没有足够的内存用于结果串。
PQescapeBytea #
PQescapeBytea是一个更老的被废弃的PQescapeByteaConn版本。
unsigned char *PQescapeBytea(const unsigned char *from,
size_t from_length,
size_t *to_length);
与PQescapeByteaConn的唯一区别是PQescapeBytea不用一个PGconn参数。
正因为这样，PQescapeBytea只能在一次只使用一个PostgreSQL连接的客户端程序中安全地使用（在这种情况下它可以“在幕后”找出它需要知道的东西）。
如果在有多个数据库连接的程序中使用，它可能给出错误的结果（在那种情况下使用PQescapeByteaConn）。
PQunescapeBytea #
将二进制数据的一个字符串表示转换成二进制数据 — 它是PQescapeBytea的逆向函数。当检索文本格式的bytea数据时，需要这个函数，但检索二进制格式时则不需要它。
unsigned char *PQunescapeBytea(const unsigned char *from, size_t *to_length);
from参数指向一个字符串，例如PQgetvalue被应用到一个bytea列上所返回的。
PQunescapeBytea把这个字符串表示转换成它的二进制表示。
它返回一个指向用malloc()分配的缓冲区的指针，在错误时返回NULL，并且把缓冲区的尺寸放在to_length中。
当结果不再需要时，它必须使用PQfreemem释放。
这种转换并不完全是PQescapeBytea的逆函数，因为当从PQgetvalue接收到字符串时，我们并不能期待它被“转义”。特别地这意味着不需要考虑字符串引用，并且因此也不需要一个PGconn参数。
上一页 上一级 下一页32.2. 连接状态函数 起始页 32.4. 异步命令处理
