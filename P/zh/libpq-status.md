# 32.2. 连接状态函数

32.2. 连接状态函数
版本：
纠错本页面
搜索
目录导航
❮
❯
32.2. 连接状态函数 #
这些函数可以用来询问一个已有数据库连接对象的状态。
提示
libpq 应用程序员应该小心地维护 PGconn 抽象。
使用下面描述的访问函数来获取 PGconn 的内容。
不推荐使用 libpq-int.h 引用内部的 PGconn 字段，
因为它们可能在未来发生变化。
下列函数返回一个连接所建立的参数值。这些值在连接的生命周期中是固定的。
如果使用的是多主机连接字符串，如果使用同一个 PGconn 对象建立新连接，
PQhost, PQport, 和 PQpass 可能会改变。
其他值在 PGconn 对象的一生中都是固定的。
PQdb #
返回该连接的数据库名。
char *PQdb(const PGconn *conn);
PQuser #
返回该连接的用户名。
char *PQuser(const PGconn *conn);
PQpass #
返回该连接的口令。
char *PQpass(const PGconn *conn);
PQpass 将返回连接参数中指定的口令，
如果连接参数中没有口令并且能从 口令文件 中得到口令，
则它将返回得到的口令。在后一种情况中，
如果连接参数中指定了多个主机，在连接被建立之前都不能依赖 PQpass 的结果。
连接的状态可以用函数 PQstatus 检查。
PQhost #
返回活跃连接的服务器主机名。可能是主机名、IP 地址或者一个目录路径（如果通过 Unix 套接字连接，路径的情况很容易区分，因为路径总是一个绝对路径，以 / 开始）。
char *PQhost(const PGconn *conn);
如果连接参数同时指定了 host 和 hostaddr，
则 PQhost 将返回 host 信息。
如果仅指定了 hostaddr，则返回它。
如果在连接参数中指定了多个主机，PQhost 返回实际连接到的主机。
PQhost 返回 NULL 如果 conn 参数是 NULL。
否则，如果有一个错误产生主机信息（或许是连接没有被完全建立或者有什么错误），它会返回一个空字符串。
如果在连接参数中指定了多个主机，则在连接建立之前都不能依赖于 PQhost 的结果。
连接的状态可以用函数 PQstatus 检查。
PQhostaddr #
返回活动连接的服务器 IP 地址。这可以是主机名解析出的地址，也可以是通过 hostaddr 参数提供的 IP 地址。
char *PQhostaddr(const PGconn *conn);
PQhostaddr 返回 NULL 如果 conn 参数是 NULL。
否则，如果生成主机信息时出现错误（如果连接尚未完全建立或出现错误），则返回一个空字符串。
PQport #
返回活跃连接的端口。
char *PQport(const PGconn *conn);
如果在连接参数中指定了多个端口，PQport 返回实际连接到的端口。
PQport 返回 NULL 如果 conn 参数是 NULL。
否则，如果有一个错误产生端口信息（或许是连接没有被完全建立或者有什么错误），它会返回一个空字符串。
如果在连接参数中指定了多个端口，则在连接建立之前都不能依赖于 PQport 的结果。
连接的状态可以用函数 PQstatus 检查。
PQtty #
这个函数不再做任何事，但是它保持了向后兼容。
这个函数总是返回一个空字符串，或者 NULL，如果 conn 为 NULL。
char *PQtty(const PGconn *conn);
PQoptions #
返回被传递给连接请求的命令行选项。
char *PQoptions(const PGconn *conn);
以下函数返回的状态数据可能会随着对PGconn对象的操作
而发生变化。
PQstatus #
返回连接的状态。
ConnStatusType PQstatus(const PGconn *conn);
状态可以是多个值之一。然而，只有两个值在异步连接过程中之外可见：
CONNECTION_OK 和
CONNECTION_BAD。与数据库的良好连接状态为
CONNECTION_OK。连接尝试失败的状态由
CONNECTION_BAD 指示。通常，OK 状态将保持不变，直到
PQfinish，但通信故障可能导致状态
提前更改为 CONNECTION_BAD。在这种情况下，应用程序可以尝试通过调用
PQreset 来恢复。
请参阅PQconnectStartParams、PQconnectStart
和PQconnectPoll，了解可能返回的其他状态代码。
PQtransactionStatus #
返回服务器当前的事务内状态。
PGTransactionStatusType PQtransactionStatus(const PGconn *conn);
状态可以是PQTRANS_IDLE（当前空闲），
PQTRANS_ACTIVE（命令正在进行中），
PQTRANS_INTRANS（空闲，处于有效的事务块中），
或PQTRANS_INERROR（空闲，处于失败的事务块中）。
如果连接状态不良，则会报告PQTRANS_UNKNOWN。
仅当查询已发送到服务器但尚未完成时，才会报告PQTRANS_ACTIVE。
PQparameterStatus #
查询服务器当前参数设置。
const char *PQparameterStatus(const PGconn *conn, const char *paramName);
某些参数值会在连接启动时或其值发生变化时由服务器自动报告。
PQparameterStatus 可用于查询这些设置。
如果已知参数，它将返回参数的当前值；如果参数未知，则返回
NULL。
当前版本报告的参数包括：
application_namescram_iterationsclient_encodingsearch_pathDateStyleserver_encodingdefault_transaction_read_onlyserver_versionin_hot_standbysession_authorizationinteger_datetimesstandard_conforming_stringsIntervalStyleTimeZoneis_superuser
（default_transaction_read_only 和
in_hot_standby 在 14 之前的版本中未报告；
scram_iterations 在 16 之前的版本中未报告；
search_path 在 18 之前的版本中未报告。）
请注意，server_version，
server_encoding 和
integer_datetimes
在启动后无法更改。
如果没有报告standard_conforming_strings的值，
应用程序可以假定它是off，也就是说，反斜杠在字符串
字面量中被视为转义字符。此外，可以将此参数的存在视为接受
转义字符串语法（E'...'）的一个标志。
尽管返回的指针被声明为const，但实际上它指向与
PGconn结构相关的可变存储。假设指针在查询之间
保持有效是不明智的。
PQfullProtocolVersion #
查询正在使用的前端/后端协议。
int PQfullProtocolVersion(const PGconn *conn);
应用程序可能希望使用此函数来确定某些功能是否被支持。结果是通过将服务器的主版本号乘以 10000 并加上次版本号来形成的。例如，版本 3.2 将返回 30002，版本 4.0 将返回 40000。如果连接不良，则返回零。3.0 协议由 PostgreSQL 服务器版本 7.4 及以上支持。
连接启动完成后，协议版本不会改变，但在理论上，它可能在连接重置期间发生变化。
PQprotocolVersion #
查询前端/后端协议的主版本。
int PQprotocolVersion(const PGconn *conn);
与 PQfullProtocolVersion 不同，此函数仅返回正在使用的主协议版本，但它支持更广泛的 libpq 版本，直到 7.4。目前，可能的值为 3（3.0 协议）或零（连接不良）。在发布版本 14.0 之前，libpq 还可以返回 2（2.0 协议）。
PQserverVersion #
返回一个表示服务器版本的整数。
int PQserverVersion(const PGconn *conn);
应用程序可能会使用此函数来确定它们所连接的数据库服务器的版本。
结果是通过将服务器的主版本号乘以10000并加上次版本号来形成的。
例如，版本10.1将返回为100001，而版本11.0将返回为110000。
如果连接有问题，则返回零。
在主版本10之前，PostgreSQL使用三部分版本号，其中前两部分
共同表示主版本号。对于这些版本，PQserverVersion使用每部分
两位数字；例如，版本9.1.5将返回为90105，而版本9.2.0将返回为90200。
因此，为了确定功能兼容性，应用程序应将
PQserverVersion 的结果除以100而不是10000，
以确定逻辑上的主版本号。在所有发布系列中，只有最后两位数字在
次要版本（错误修复版本）之间有所不同。
PQerrorMessage
#
返回最近一次对连接操作产生的错误信息。
char *PQerrorMessage(const PGconn *conn);
几乎所有libpq函数在失败时都会为
PQerrorMessage
设置一条消息。请注意，
根据libpq的约定，非空的
PQerrorMessage
结果可能由多行组成，
并且会包含一个结尾的换行符。调用者不应直接释放该结果。
当关联的PGconn句柄被传递给
PQfinish时，它将被释放。结果字符串
不应期望在对PGconn结构的操作之间保持不变。
PQsocket #
获取到服务器连接套接字的文件描述符编号。有效的描述符将大于或等于0；
返回值为-1表示当前没有打开的服务器连接。（这在正常操作期间不会
改变，但可能在连接设置或重置期间发生变化。）
int PQsocket(const PGconn *conn);
PQbackendPID #
返回处理此连接的后端进程的进程ID (PID)。
int PQbackendPID(const PGconn *conn);
后端PID对于调试目的和与NOTIFY
消息（其中包括通知后端进程的PID）的比较非常有用。
请注意，PID属于在数据库服务器主机上执行的进程，
而不是本地主机上的进程！
PQconnectionNeedsPassword #
如果连接认证方法需要密码但没有可用密码，则返回 true (1)。
如果不需要，则返回 false (0)。
int PQconnectionNeedsPassword(const PGconn *conn);
此函数可在连接尝试失败后使用，以决定是否提示用户输入密码。
PQconnectionUsedPassword #
如果连接认证方法使用了密码，则返回 true (1)。如果没有使用密码，则返回
false (0)。
int PQconnectionUsedPassword(const PGconn *conn);
此函数可在连接尝试失败或成功后使用，以检测服务器是否要求密码。
PQconnectionUsedGSSAPI #
如果连接认证方法使用了 GSSAPI，则返回 true (1)。如果没有，则返回 false (0)。
int PQconnectionUsedGSSAPI(const PGconn *conn);
此函数可用于检测连接是否通过 GSSAPI 进行身份验证。
以下函数返回与 SSL 相关的信息。这些信息通常在建立连接后不会更改。
PQsslInUse #
返回 true (1) 如果连接使用 SSL，false (0) 如果不使用。
int PQsslInUse(const PGconn *conn);
PQsslAttribute #
返回与连接相关的 SSL 信息。
const char *PQsslAttribute(const PGconn *conn, const char *attribute_name);
可用属性列表因使用的 SSL 库和连接类型而异。如果连接不使用 SSL 或指定的属性名称对于所使用的库未定义，则返回 NULL。
以下属性通常可用：
library
正在使用的 SSL 实现名称。（目前仅实现了
"OpenSSL"）
protocol
正在使用的 SSL/TLS 版本。常见值有
"TLSv1"、"TLSv1.1"
和 "TLSv1.2"，但如果使用了其他协议，
实现可能返回其他字符串。
key_bits
加密算法使用的密钥位数。
cipher
使用的密码套件的简称，例如
"DHE-RSA-DES-CBC3-SHA"。名称因 SSL 实现而异。
compression
如果使用了 SSL 压缩，则返回 "on"，否则返回 "off"。
alpn
由 TLS 应用层协议协商（ALPN）扩展选择的应用协议。libpq 仅支持
postgresql 协议，因此主要用于检查服务器是否支持 ALPN。
如果未使用 ALPN，则为空字符串。
作为一个特例，可以在没有连接的情况下通过将 NULL 作为 conn 参数来查询 library 属性。
结果将是默认的 SSL 库名称，或者如果 libpq 在没有任何 SSL 支持的情况下编译，则为 NULL。
（在 PostgreSQL 版本 15 之前，将 NULL 作为 conn 参数传递总是导致 NULL。
需要区分这种情况的新旧实现的客户端程序可以检查 LIBPQ_HAS_SSL_LIBRARY_DETECTION 特征宏。）
PQsslAttributeNames #
返回一个SSL属性名称数组，可用于PQsslAttribute()。
该数组以NULL指针结尾。
const char * const * PQsslAttributeNames(const PGconn *conn);
如果conn为NULL，则返回默认SSL库可用的属性，或者如果
libpq在编译时没有任何SSL支持，则返回一个空列表。
如果conn不为NULL，则返回用于连接的SSL库可用的属性，
或者如果连接未加密，则返回一个空列表。
PQsslStruct #
返回一个指向描述连接的SSL实现特定对象的指针。如果连接未加密或SSL实现不提供连接的请求对象类型，则返回NULL。
void *PQsslStruct(const PGconn *conn, const char *struct_name);
可用的结构体取决于正在使用的SSL实现。
对于OpenSSL，有一个结构体，
可以通过名称OpenSSL获得，
并返回一个指向OpenSSL的SSL结构体的指针。
要使用这个函数，可以使用以下代码：
#include <libpq-fe.h>
#include <openssl/ssl.h>
...
SSL *ssl;
dbconn = PQconnectdb(...);
...
ssl = PQsslStruct(dbconn, "OpenSSL");
if (ssl)
{
/* 使用OpenSSL函数访问ssl */
}
这个结构可用于验证加密级别，检查服务器证书等。请参考OpenSSL
文档以获取有关此结构的信息。
PQgetssl #
返回在连接中使用的SSL结构，如果未使用SSL，则返回NULL。
void *PQgetssl(const PGconn *conn);
这个函数等同于PQsslStruct(conn, "OpenSSL")。不应该在新应用程序中使用，
因为返回的结构特定于OpenSSL，如果使用另一个SSL实现，
则不可用。要检查连接是否使用SSL，请调用PQsslInUse，
要获取有关连接的更多详细信息，请使用PQsslAttribute。
上一页 上一级 下一页32.1. 数据库连接控制函数 起始页 32.3. 命令执行函数
