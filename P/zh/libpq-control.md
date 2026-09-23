# 32.11. 控制函数

32.11. 控制函数
版本：
纠错本页面
搜索
目录导航
❮
❯
32.11. 控制函数 #
这些函数控制libpq行为的各种细节。
PQclientEncoding #
返回客户端编码。
int PQclientEncoding(const PGconn *conn);
请注意，它返回的是编码 ID，而不是一个符号字符串，如EUC_JP。如果不成功，它会返回 -1。要把一个编码 ID 转换为一个编码名称，可以用：
char *pg_encoding_to_char(int encoding_id);
PQsetClientEncoding #
设置客户端编码。
int PQsetClientEncoding(PGconn *conn, const char *encoding);
conn是一个到服务器的连接，而encoding是你想使用的编码。
如果函数成功地设置编码，则返回 0，否则返回 -1。这个连接的当前编码可以使用PQclientEncoding确定。
PQsetErrorVerbosity #
决定
PQerrorMessage
和 PQresultErrorMessage返回的消息的详细程度。
typedef enum
{
PQERRORS_TERSE,
PQERRORS_DEFAULT,
PQERRORS_VERBOSE,
PQERRORS_SQLSTATE
} PGVerbosity;
PGVerbosity PQsetErrorVerbosity(PGconn *conn, PGVerbosity verbosity);
PQsetErrorVerbosity设置详细程度模式，并返回该连接的前一个设置。
在TERSE模式下，返回的消息只包括严重性、主要文本以及位置；这些通常放在一个单一行中。
DEFAULT模式生成的消息包括上面的信息加上任何细节、提示或者上下文字段（这些可能跨越多行）。
VERBOSE模式包括所有可用的字段。修改详细程度模式不会影响来自已有PGresult对象中的可用消息。
只有随后创建的PGresult对象才受到影响。
SQLSTATE模式仅包括错误严重性和SQLSTATE错误代码，如果其中之一是可用的（如果没有，输出类似于TERSE模式）。
更改详细程度设置不会影响已存在的PGresult对象的可用消息，只会影响随后创建的对象。
（如果想要用不同的详细程度打印之前的错误，请见PQresultVerboseErrorMessage）
PQsetErrorContextVisibility #
决定如何处理
PQerrorMessage
和 PQresultErrorMessage返回的消息中的CONTEXT字段。
typedef enum
{
PQSHOW_CONTEXT_NEVER,
PQSHOW_CONTEXT_ERRORS,
PQSHOW_CONTEXT_ALWAYS
} PGContextVisibility;
PGContextVisibility PQsetErrorContextVisibility(PGconn *conn, PGContextVisibility show_context);
PQsetErrorContextVisibility设置上下文显示模式，返回该连接的前一个设置。这个模式控制消息中是否包括CONTEXT字段。
NEVER模式不会包括CONTEXT，而ALWAYS则始终包括它（如果可用）。在ERRORS模式（默认）中，仅在错误消息中包括CONTEXT字段，而在通知和警告消息中不会包括。
（但是，如果详细程度设置为TERSE或SQLSTATE，则无论上下文显示模式如何，都会省略CONTEXT字段。）
更改这个模式不会影响从已经存在的PGresult对象中得到的消息，只会影响后续创建的PGresult对象。
（如果想要用不同的显示模式打印之前的错误，请见PQresultVerboseErrorMessage。）
PQtrace #
启用对客户端/服务器通信的跟踪，把跟踪信息输出到一个调试文件流中。
void PQtrace(PGconn *conn, FILE *stream);
每行包括：一个可选的时间戳，一个方向指示器（F表示从客户端到服务器的消息或B表示从服务器到客户端的消息），消息长度、消息类型和消息内容。
非消息内容字段（时间戳、方向、长度和消息类型）由一个制表符分隔。
消息内容用空格分隔。
协议字符串用双引号括起来，而用作数据值的字符串用单引号括起来。
不可打印的字符被打印为十六进制转义。
更多消息类型特定的详情可以在第 54.7 节中找到。
注意
在 Windows 上，如果libpq库和应用使用了不同的标志编译，那么这个函数调用会导致应用崩溃，因为FILE指针的内部表示是不一样的。特别是多线程/单线程、发布/调试以及静态/动态标志应该是库和所有使用该库的应用都一致。
PQsetTraceFlags #
控制客户端/服务器通信的跟踪行为。
void PQsetTraceFlags(PGconn *conn, int flags);
flags包含描述跟踪的操作模式的标志位。
如果flags包含PQTRACE_SUPPRESS_TIMESTAMPS，则在打印每条消息时不包括时间戳。
如果flags包含PQTRACE_REGRESS_MODE，那么在打印每个消息时将修改一些字段，例如对象 OIDs，以使输出在测试框架中更方便地使用。
这个函数必须在调用PQtrace之后调用。
PQuntrace #
禁用PQtrace启动的跟踪。
void PQuntrace(PGconn *conn);
上一页 上一级 下一页32.10. COPY命令相关的函数 起始页 32.12. 杂项函数
