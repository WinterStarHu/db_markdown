# 32.1. 数据库连接控制函数

32.1. 数据库连接控制函数
版本：
纠错本页面
搜索
目录导航
❮
❯
32.1. 数据库连接控制函数 #32.1.1. 连接字符串32.1.2. 参数关键字
以下函数用于建立与PostgreSQL后端服务器的连接。
一个应用程序可以同时打开多个后端连接。（这样做的一个原因是访问多个数据库。）
每个连接由一个PGconn表示。
对象，该对象是通过函数PQconnectdb、
PQconnectdbParams或PQsetdbLogin获得的。
请注意，这些函数总是返回一个非空对象指针，除非内存不足，甚至无法分配
PGconn对象。应调用PQstatus函数
检查返回值，以确认连接成功，然后才能通过连接对象发送查询。
警告
如果不受信任的用户可以访问未采用
安全模式使用模式的数据库，
则应在每个会话开始时从search_path中移除公开可写的模式。
可以将参数关键字options设置为值
-csearch_path=。或者，可以在连接后执行
PQexec(conn, "SELECT
pg_catalog.set_config('search_path', '', false)")。
这一考虑并非特定于libpq；它适用于执行任意SQL命令的所有接口。
警告
在 Unix 系统中，使用打开的 libpq 连接进行进程分叉可能导致不可预测的结果，
因为父进程和子进程共享相同的套接字和操作系统资源。因此，不推荐这样使用，
尽管从子进程执行 exec 来加载新的可执行文件是安全的。
PQconnectdbParams #
建立与数据库服务器的新连接。
PGconn *PQconnectdbParams(const char * const *keywords,
const char * const *values,
int expand_dbname);
该函数使用来自两个以NULL结尾的数组的参数打开一个新的数据库连接。
第一个，keywords，定义为字符串数组，每个元素都是一个关键字。
第二个，values，为每个关键字提供对应的值。与下面的
PQsetdbLogin 不同，参数集可以扩展而无需更改函数签名，
因此建议新应用程序编程使用此函数（或其非阻塞对应函数
PQconnectStartParams 和 PQconnectPoll）。
当前认可的参数关键字列在
第 32.1.2 节中。
传入的数组可以为空，以使用所有默认参数，或者可以包含一个或多个参数设置。它们的长度必须匹配。
处理将在NULL条目首次出现时停止，
该条目位于keywords数组中。
此外，如果与非NULLkeywords条目相关联的
values条目是NULL或空字符串，
则该条目将被忽略，处理将继续进行下一对数组条目。
当 expand_dbname 非零时，会检查第一个 dbname
关键字的值，判断它是否是一个 连接字符串。如果是，它会被
“展开”为从字符串中提取的各个连接参数。该值被视为连接字符串，
而不仅仅是数据库名称，如果它包含等号 (=) 或以 URI
方案标识符开头。（有关连接字符串格式的更多细节，请参见 第 32.1.1 节。）
只有第一个出现的 dbname 会以这种方式处理；任何后续的
dbname 参数都作为普通数据库名称处理。
通常参数数组从头到尾依次处理。如果任何关键字重复，使用最后一个（且不为
NULL或空）的值。此规则特别适用于连接字符串中出现的关键字
与keywords数组中关键字冲突的情况。因此，程序员可以确定数组
条目是否可以被连接字符串中的值覆盖，或被其覆盖。出现在扩展的
dbname条目前的数组条目可以被连接字符串字段覆盖，
而这些字段又会被出现在dbname之后的数组条目覆盖（但
前提是这些条目提供非空值）。
处理完所有数组条目和任何展开的连接字符串后，任何未设置的连接参数都会被填充为默认值。
如果未设置参数对应的环境变量（参见 第 32.15 节）已设置，则使用其值。
如果环境变量也未设置，则使用该参数的内置默认值。
PQconnectdb #
建立与数据库服务器的新连接。
PGconn *PQconnectdb(const char *conninfo);
此函数使用从字符串conninfo中获取的参数打开一个新的数据库连接。
传入的字符串可以为空，以使用所有默认参数，或者它可以包含一个或多个由空白分隔的参数设置，
也可以包含一个URI。
详情请参见第 32.1.1 节。
PQsetdbLogin #
建立与数据库服务器的新连接。
PGconn *PQsetdbLogin(const char *pghost,
const char *pgport,
const char *pgoptions,
const char *pgtty,
const char *dbName,
const char *login,
const char *pwd);
这是具有固定参数集的PQconnectdb的前身。它具有相同的功能，
只是缺失的参数将始终采用默认值。对于任何需要使用默认值的固定参数，请写入
NULL或空字符串。
如果dbName包含一个=符号或具有有效的连接URI前缀，
则它被视为一个conninfo字符串，处理方式与传递给PQconnectdb
完全相同，剩余的参数随后按照PQconnectdbParams中指定的方式应用。
pgtty 不再使用，传入的任何值都会被忽略。
PQsetdb #
建立与数据库服务器的新连接。
PGconn *PQsetdb(char *pghost,
char *pgport,
char *pgoptions,
char *pgtty,
char *dbName);
这是一个宏，它调用PQsetdbLogin，并为login和
pwd参数传入空指针。该宏是为了向后兼容非常旧的程序而提供的。
PQconnectStartParamsPQconnectStartPQconnectPoll #
以非阻塞方式连接到数据库服务器。
PGconn *PQconnectStartParams(const char * const *keywords,
const char * const *values,
int expand_dbname);
PGconn *PQconnectStart(const char *conninfo);
PostgresPollingStatusType PQconnectPoll(PGconn *conn);
这三个函数用于打开与数据库服务器的连接，使得应用程序的执行线程在进行远程I/O时不会被阻塞。
这种方法的关键在于，等待I/O完成的操作可以发生在应用程序的主循环中，而不是在
PQconnectdbParams 或 PQconnectdb 内部，
因此应用程序可以与其他活动并行管理此操作。
使用 PQconnectStartParams，数据库连接是通过从
keywords 和 values 数组中获取的参数建立的，
并由 expand_dbname 控制，如上文针对 PQconnectdbParams
所述。
使用PQconnectStart，数据库连接是通过从字符串conninfo中获取的参数建立的，
如上文针对PQconnectdb所述。
只要满足一定的限制，PQconnectStartParams、PQconnectStart
和PQconnectPoll都不会阻塞：
必须正确使用hostaddr参数以防止发起DNS查询。有关该参数的详细
说明，请参阅第 32.1.2 节中的文档。
如果调用了PQtrace，请确保用于跟踪的流对象不会阻塞。
必须确保套接字处于适当状态后再调用PQconnectPoll，具体说明
如下所述。
要开始一个非阻塞连接请求，调用 PQconnectStart 或
PQconnectStartParams。如果结果为 null，则
libpq 无法分配一个新的 PGconn
结构。否则，会返回一个有效的 PGconn 指针（尽管
还不代表与数据库的有效连接）。接下来调用 PQstatus(conn)。
如果结果是 CONNECTION_BAD，则连接尝试已失败，通常是因为
连接参数无效。
如果PQconnectStart或PQconnectStartParams
成功，下一阶段是轮询libpq，以便它能继续连接序列。
使用PQsocket(conn)获取数据库连接所用套接字的描述符。
（注意：不要假设套接字在PQconnectPoll调用之间保持不变。）
循环如下：如果PQconnectPoll(conn)上次返回
PGRES_POLLING_READING，则等待套接字准备好读取（由
select()、poll()或类似系统函数指示）。
注意，如果系统支持，PQsocketPoll可以通过封装
select(2)或poll(2)的设置来减少样板代码。
然后再次调用PQconnectPoll(conn)。
反之，如果PQconnectPoll(conn)上次返回
PGRES_POLLING_WRITING，则等待套接字准备好写入，然后再次调用
PQconnectPoll(conn)。
在第一次迭代时，即尚未调用PQconnectPoll时，
按照上次返回PGRES_POLLING_WRITING的方式处理。
持续循环直到PQconnectPoll(conn)返回
PGRES_POLLING_FAILED，表示连接过程失败，或
PGRES_POLLING_OK，表示连接成功建立。
在连接的任何时候，可以通过调用 PQstatus 检查连接的状态。
如果此调用返回 CONNECTION_BAD，则连接过程失败；如果调用返回 CONNECTION_OK，
则连接已准备好。这两种状态都可以通过上面描述的 PQconnectPoll 的返回值检测到。
在异步连接过程中，可能还会出现其他状态。这些状态指示连接过程的当前阶段，并可能对用户提供反馈有用。
这些状态包括：
CONNECTION_STARTED #
等待建立连接。
CONNECTION_MADE #
连接正常；等待发送。
CONNECTION_AWAITING_RESPONSE #
等待服务器的响应。
CONNECTION_AUTH_OK #
收到身份验证；等待后端启动完成。
CONNECTION_SSL_STARTUP #
正在协商 SSL 加密。
CONNECTION_GSS_STARTUP #
正在协商 GSS 加密。
CONNECTION_CHECK_WRITABLE #
检查连接是否能够处理写事务。
CONNECTION_CHECK_STANDBY #
检查连接是否指向处于备用模式的服务器。
CONNECTION_CONSUME #
消耗连接上的任何剩余响应消息。
请注意，尽管这些常量将保持不变（以保持兼容性），但应用程序不应依赖于这些状态以特定顺序出现，或根本出现，或状态始终是这些文档值之一。应用程序可能会这样做：
switch(PQstatus(conn))
{
case CONNECTION_STARTED:
feedback = "连接中...";
break;
case CONNECTION_MADE:
feedback = "已连接到服务器...";
break;
.
.
.
default:
feedback = "连接中...";
}
当使用PQconnectPoll时，connect_timeout连接参数会被忽略；
由应用程序负责判断是否已经经过了过长的时间。否则，PQconnectStart后跟
一个PQconnectPoll循环等同于PQconnectdb。
注意，当 PQconnectStart 或 PQconnectStartParams
返回非空指针时，您必须在使用完成后调用 PQfinish，
以释放该结构及其相关的内存块。即使连接尝试失败或被放弃，也必须执行此操作。
PQsocketPoll #
轮询通过 PQsocket 获取的连接底层套接字描述符。
此函数的主要用途是迭代文档中描述的连接序列
PQconnectStartParams。
typedef int64_t pg_usec_time_t;
int PQsocketPoll(int sock, int forRead, int forWrite,
pg_usec_time_t end_time);
该函数执行文件描述符的轮询操作，可选择设置超时时间。
如果forRead非零，函数将在套接字准备好
读取时终止。如果forWrite非零，函数将在套接字
准备好写入时终止。
超时由 end_time 指定，该参数是停止等待的时间，以自 Unix 纪元以来的微秒数表示（即 time_t 乘以 100 万）。
如果 end_time 为 -1，则超时为无限。如果 end_time 为 0（或实际上，任何早于现在的时间），则超时为立即（无阻塞）。
可以通过将所需的微秒数加到 PQgetCurrentTimeUSec 的结果来方便地计算超时值。
请注意，底层系统调用的精度可能低于微秒，因此实际延迟可能不精确。
如果满足指定条件，函数返回一个大于0的值；如果发生超时，
则返回0；如果发生错误，则返回-1。错误信息
可以通过检查errno(3)值来获取。如果forRead
和forWrite都为零，函数将立即返回超时指示。
PQsocketPoll 是使用 poll(2) 或 select(2)
实现的，具体取决于平台。请参阅 POLLIN 和 POLLOUT 来自
poll(2)，或来自 select(2) 的 readfds 和
writefds，以获取更多信息。
PQconndefaults #
返回默认的连接选项。
PQconninfoOption *PQconndefaults(void);
typedef struct
{
char   *keyword;   /* 选项的关键字 */
char   *envvar;    /* 备用的环境变量名称 */
char   *compiled;  /* 备用的编译时默认值 */
char   *val;       /* 选项的当前值，或NULL */
char   *label;     /* 连接对话框中字段的标签 */
char   *dispchar;  /* 指示如何在连接对话框中显示此字段。值为：
""        按原样显示输入的值
"*"       密码字段 - 隐藏值
"D"       调试选项 - 默认不显示 */
int     dispsize;  /* 对话框中字段的字符大小 */
} PQconninfoOption;
返回一个连接选项数组。该数组可用于确定所有可能的
PQconnectdb 选项及其当前默认值。返回值指向一个
PQconninfoOption 结构体数组，数组以一个
条目结束，该条目的 keyword 指针为空。
如果内存无法分配，则返回空指针。请注意，当前默认值（
val 字段）将依赖于环境变量和其他上下文。
缺失或无效的服务文件将被静默忽略。调用者必须将连接选项数据视为只读。
处理完选项数组后，通过传递给PQconninfoFree释放它。
如果不这样做，每次调用PQconndefaults时都会泄漏少量内存。
PQconninfo #
返回由活动连接使用的连接选项。
PQconninfoOption *PQconninfo(PGconn *conn);
返回一个连接选项数组。该数组可用于确定所有可能的
PQconnectdb 选项以及用于连接服务器的值。
返回值指向一个 PQconninfoOption 结构体数组，
该数组以一个 keyword 指针为空的条目结束。
上述关于 PQconndefaults 的所有说明也适用于
PQconninfo 的结果。
PQconninfoParse #
返回从提供的连接字符串解析出的连接选项。
PQconninfoOption *PQconninfoParse(const char *conninfo, char **errmsg);
解析连接字符串并返回结果选项数组；如果连接字符串有问题，则返回
NULL。此函数可用于提取提供的连接字符串中的
PQconnectdb 选项。返回值指向一个
PQconninfoOption 结构体数组，该数组以一个
keyword 指针为空的条目结束。
所有合法的选项都会出现在结果数组中，但连接字符串中未出现的任何选项的
PQconninfoOption将其val设置为
NULL；默认值不会被插入。
如果 errmsg 不是 NULL，那么在成功时 *errmsg 会被设置为
NULL，否则会被设置为一个由 malloc 分配的错误字符串来解释
问题。（也有可能 *errmsg 被设置为
NULL 并且函数返回 NULL；
这表示内存不足的情况。）
处理完选项数组后，通过传递给PQconninfoFree来释放它。
如果不这样做，每次调用PQconninfoParse时都会泄漏一些内存。
相反，如果发生错误且errmsg不是NULL，
请确保使用PQfreemem释放错误字符串。
PQfinish #
关闭与服务器的连接。同时释放PGconn对象使用的内存。
void PQfinish(PGconn *conn);
注意，即使服务器连接尝试失败（如PQstatus所示），应用程序也应调用
PQfinish释放PGconn对象所使用的内存。
在调用PQfinish之后，PGconn指针不得再次使用。
PQreset #
重置与服务器的通信通道。
void PQreset(PGconn *conn);
此函数将关闭与服务器的连接，并尝试使用之前所有相同的参数
建立一个新的连接。如果工作连接丢失，这可能对错误恢复很有用。
PQresetStartPQresetPoll #
以非阻塞方式重置与服务器的通信通道。
int PQresetStart(PGconn *conn);
PostgresPollingStatusType PQresetPoll(PGconn *conn);
这些函数将关闭与服务器的连接，并尝试使用之前使用的所有相同参数
建立一个新的连接。如果工作连接丢失，这对于错误恢复非常有用。它们与
PQreset（上文）不同，后者是阻塞方式，这些函数以非阻塞
方式工作。这些函数与PQconnectStartParams、PQconnectStart
和PQconnectPoll存在相同的限制。
要启动连接重置，请调用
PQresetStart。如果返回0，表示重置失败。
如果返回1，则使用PQresetPoll轮询重置，方法与使用
PQconnectPoll创建连接完全相同。
PQpingParams #
PQpingParams 报告服务器的状态。它接受与
PQconnectdbParams 相同的连接参数，如上所述。
获取服务器状态时不必提供正确的用户名、密码或数据库名；
但是，如果提供了错误的值，服务器将记录一次连接失败的尝试。
PGPing PQpingParams(const char * const *keywords,
const char * const *values,
int expand_dbname);
该函数返回以下值之一：
PQPING_OK #
服务器正在运行，且似乎正在接受连接。
PQPING_REJECT #
服务器正在运行，但处于不允许连接的状态（启动、关闭或崩溃恢复）。
PQPING_NO_RESPONSE #
无法联系服务器。这可能表示服务器未运行，或者连接参数有误
（例如端口号错误），或者存在网络连接问题（例如防火墙阻止连接请求）。
PQPING_NO_ATTEMPT #
未尝试联系服务器，因为提供的参数显然不正确，或存在客户端问题
（例如内存不足）。
PQping #
PQping 报告服务器的状态。它接受与上述
PQconnectdb 相同的连接参数。获取服务器状态时，
无需提供正确的用户名、密码或数据库名；但是，如果提供了错误的值，
服务器将记录一次连接失败的尝试。
PGPing PQping(const char *conninfo);
返回值与 PQpingParams 相同。
PQsetSSLKeyPassHook_OpenSSL #
PQsetSSLKeyPassHook_OpenSSL 允许应用程序覆盖
libpq的默认
处理加密客户端证书密钥文件，使用
sslpassword或交互式提示。
void PQsetSSLKeyPassHook_OpenSSL(PQsslKeyPassHook_OpenSSL_type hook);
应用程序传递一个回调函数指针，函数签名为：
int callback_fn(char *buf, int size, PGconn *conn);
libpq随后将调用该回调函数，
代替其默认的
PQdefaultSSLKeyPassHook_OpenSSL处理程序。
回调函数应确定密钥的密码并复制到大小为
size的结果缓冲区buf中。
buf中的字符串必须以空字符结尾。回调函数必须返回
存储在buf中的密码长度，不包括空字符。
失败时，回调函数应设置buf[0] = '\0'并返回0。
详情请参见libpq源码中的
PQdefaultSSLKeyPassHook_OpenSSL示例。
如果用户指定了一个明确的密钥位置，回调被调用时，其路径将位于
conn->sslkey中。如果使用的是默认密钥路径，则此处为空。
对于作为引擎指定符的密钥，是否使用OpenSSL密码
回调或定义自己的处理方式，由引擎实现决定。
应用程序回调可以选择将未处理的情况委托给
PQdefaultSSLKeyPassHook_OpenSSL，
或者先调用它，如果返回0则尝试其他方法，或者完全覆盖它。
回调不得通过异常、longjmp(...)等方式跳出正常的流程控制。
它必须正常返回。
PQgetSSLKeyPassHook_OpenSSL #
PQgetSSLKeyPassHook_OpenSSL 返回当前客户端证书密钥密码钩子，
或者如果未设置则返回NULL。
PQsslKeyPassHook_OpenSSL_type PQgetSSLKeyPassHook_OpenSSL(void);
32.1.1. 连接字符串 #
几个libpq函数解析用户指定的字符串以获取连接参数。
这些字符串有两种被接受的格式：普通的关键字/值字符串和URI。URI通常遵循
RFC
3986，除了允许多主机连接字符串，如下面进一步描述的那样。
32.1.1.1. 关键字/值连接字符串 #
在关键字/值格式中，每一个参数设置的形式都是关键字 = 值，在设置之间有空白。
设置的等号周围的空白是可选的。
要写一个空值或一个包含空白的值，将它用单引号包围，例如关键字 = 'a value'。
值里面的单引号和反斜线必须用一个反斜线转义，即\'和\\。
例子：
host=localhost port=5432 dbname=mydb connect_timeout=10
能被识别的参数关键字在第 32.1.2 节中列出。
32.1.1.2. 连接 URIs #
一个连接URI的一般形式是：
postgresql://[userspec@][hostspec][/dbname][?paramspec]
其中 userspec 是：
user[:password]
且 hostspec 是：
[host][:port][,...]
且 paramspec 是：
name=value[&...]
URI模式标志符可以是postgresql://或postgres://。
每一个剩下的URI部分都是可选的。
下列例子展示了合法的URI语法：
postgresql://
postgresql://localhost
postgresql://localhost:5433
postgresql://localhost/mydb
postgresql://user@localhost
postgresql://user:secret@localhost
postgresql://other@localhost/otherdb?connect_timeout=10&application_name=myapp
postgresql://host1:123,host2:456/somedb?target_session_attrs=any&application_name=myapp
通常出现在URI的层次部分的值，也能够以命名参数的方式给出。例如：
postgresql:///mydb?host=localhost&port=5433
全部的命名参数必须匹配第 32.1.2 节中列出的关键词，除了与JDBC连接URI兼容之外，ssl=true的实例转换为sslmode=require。
连接URI需要使用百分号编码
对其进行编码，如果其中包含具有特殊含义的符号。这里是一个示例，其中等号(=)被替换为
%3D，空格字符被替换为
%20：
postgresql://user@localhost:5433/mydb?options=-c%20synchronous_commit%3Doff
主机部分可能是主机名或一个 IP 地址。要指定一个 IPv6 地址，将它封闭在方括号中：
postgresql://[2001:db8::1234]/database
主机组件会被按照参数host对应的描述来解释。
特别地，如果主机部分是空或看起来像一个绝对路径名称，将使用一个 Unix 域套接字连接，否则将启动一个 TCP/IP 连接。
不过要注意，斜线是 URI 层次部分中的一个保留字符。
因此，要指定一个非标准的 Unix 域套接字目录，要么忽略 URI 中的主机部分并且指定该主机为一个命名参数，要么在 URI 的主机部分用百分号编码路径：
postgresql:///dbname?host=/var/lib/postgresql
postgresql://%2Fvar%2Flib%2Fpostgresql/dbname
可以在一个URI中指定多个主机，每一个都有一个可选的端口。
一个形式为postgresql://host1:port1,host2:port2,host3:port3/的URI等效于host=host1,host2,host3 port=port1,port2,port3形式的连接字符串。
如下所述，每一个主机都将被尝试，直到成功地建立一个连接。
32.1.1.3. 指定多个主机 #
可以指定多个要连接的主机，这样它们会按给定的顺序被尝试。
在键/值格式中，host、hostaddr和port选项都接受逗号分隔的值列表。
在指定的每一个选项中都必须给出相同数量的元素，这样第一个hostaddr对应于第一个主机名，第二个hostaddr对应于第二个主机名，以此类推。
不过，如果仅指定一个port，它将被应用于所有的主机。
在连接URI格式中，在URI的host部分我们可以列出多个由逗号分隔的host:port对。
不管是哪一种格式，单一的主机名可以被翻译成多个网络地址。常见的例子是一个主机同时具有 IPv4 和
IPv6 地址。
当多个主机被指定时，或者单个主机名被翻译成多个地址时，所有的主机和地址都将按照顺序被尝试，直至遇到一个成功的。如果没有主机可以到达，则连接失败。如果成功地建立一个连接，但是认证失败，列表中剩下的主机将不会被尝试。
如果使用了口令文件，可以为不同的主机使用不同的口令。所有其他连接选项对列表中的每一台主机都是相同的；例如，不能为不同的主机指定不同的用户名。
32.1.2. 参数关键字 #
目前被识别的参数关键字包括:
host #
要连接的主机名称。 如果主机名称看起来像一个绝对路径名，
它表示使用 Unix 域通信而不是 TCP/IP 通信；该值是存储套接字文件的目录名称。
（在 Unix 上，绝对路径名以斜杠开头。在 Windows 上，也会识别以驱动器字母开头的路径。）如果主机名称以
@ 开头，则将其视为抽象命名空间中的 Unix 域套接字（目前在 Linux 和 Windows 上支持）。
当未指定 host 或其为空时，默认行为是连接到
位于 /tmp
（或在构建 PostgreSQL 时指定的套接字目录）。在 Windows 上，
默认是连接到 localhost。
也可以接受一个逗号分隔的主机名列表，此时列表中的每个主机名将按顺序尝试；
列表中的空项将选择上述默认行为。详细信息请参见 第 32.1.1.3 节。
hostaddr #
要连接的主机的数字 IP 地址。这应该是标准的 IPv4 地址格式，例如，172.28.40.9。
如果您的机器支持 IPv6，也可以使用这些地址。当为此参数指定非空字符串时，总是使用 TCP/IP 通信。
如果未指定此参数，则将查找 host 的值以查找相应的 IP 地址 — 或者，如果 host 指定了 IP 地址，则将直接使用该值。
使用hostaddr允许应用程序避免主机名查找，这在有时间限制的应用程序中可能很重要。
但是，对于GSSAPI或SSPI身份验证方法以及verify-full SSL证书验证，需要主机名。
使用以下规则：
如果指定了host而没有指定hostaddr，则会发生主机名查找。
（当使用PQconnectPoll时，查找发生在PQconnectPoll首次考虑此主机名时，
并且可能导致PQconnectPoll阻塞一段时间。）
如果指定了hostaddr而没有指定host，
则hostaddr的值给出服务器的网络地址。
如果身份验证方法需要主机名，则连接尝试将失败。
如果同时指定了host和hostaddr，
则hostaddr的值给出服务器的网络地址。
除非身份验证方法需要，否则host的值将被忽略，
在这种情况下，它将用作主机名。
请注意，如果host不是网络地址hostaddr上服务器的名称，
则身份验证可能会失败。
此外，当同时指定host和hostaddr时，
host用于在密码文件中标识连接（请参阅第 32.16 节）。
也可以接受一个逗号分隔的hostaddr值列表，此时将按顺序尝试列表中的每个主机。
列表中的空项会导致使用相应的主机名，如果主机名也为空，则使用默认主机名。详见
第 32.1.1.3 节。
如果没有主机名或主机地址，
libpq将使用本地Unix域套接字进行连接；
在Windows上，它将尝试连接到localhost。
port #
连接到服务器主机的端口号，或者Unix域连接的套接字文件名扩展。
如果在host或hostaddr参数中给出了多个主机，
则此参数可以指定与主机列表长度相同的逗号分隔的端口列表，或者可以指定用于所有主机的单个端口号。
空字符串，或逗号分隔列表中的空项，指定了在构建PostgreSQL时建立的默认端口号。
dbname #
数据库名称。默认为与用户名相同。在某些情况下，该值会被检查是否为扩展格式；
有关更多详细信息，请参阅第 32.1.1 节。
user #
PostgreSQL用户连接的用户名。
默认为运行应用程序的操作系统用户名相同。
password #
如果服务器要求密码验证，则使用密码。
passfile #
指定用于存储密码的文件名（参见第 32.16 节）。
默认为~/.pgpass，或在Microsoft Windows上为%APPDATA%\postgresql\pgpass.conf。
（如果此文件不存在，则不会报告错误。）
require_auth #
指定客户端要求服务器使用的身份验证方法。如果服务器未使用所需的
方法对客户端进行身份验证，或者身份验证握手未由服务器完全完成，
则连接将失败。还可以提供一个以逗号分隔的方法列表，服务器必须
恰好使用其中一种方法才能使连接成功。默认情况下，接受任何身份
验证方法，服务器可以完全跳过身份验证。
可以通过添加!前缀来否定方法，此时服务器
不得尝试列出的方法；任何其他方法都被接受，
并且服务器可以完全不对客户端进行身份验证。如果提供了逗号分隔的
列表，服务器不得尝试任何列出的被否定的方法。
否定形式和非否定形式不能在同一设置中组合使用。
作为一个特殊情况，none方法要求服务器不使用身份验证挑战。
（它也可以被否定，以要求某种形式的身份验证。）
可以指定以下方法：
password
服务器必须请求明文密码身份验证。
md5
服务器必须请求 MD5 哈希密码身份验证。
警告
对 MD5 加密密码的支持已被弃用，并将在未来的
PostgreSQL 版本中移除。有关迁移到其他密码类型的详细信息，请参阅
第 20.5 节。
gss
服务器必须通过 GSSAPI 请求 Kerberos 握手或建立一个
GSS 加密通道（另见 gssencmode）。
sspi
服务器必须请求 Windows SSPI 身份验证。
scram-sha-256
服务器必须成功完成与客户端的 SCRAM-SHA-256 身份验证交换。
oauth
服务器必须请求客户端的 OAuth 令牌。
none
服务器不得提示客户端进行身份验证交换。（这并不禁止通过 TLS 进行客户端证书身份验证，也不禁止通过其加密传输进行 GSS 身份验证。）
channel_binding #
这个选项控制客户端对通道绑定的使用。设置为require表示连接必须使用通道绑定，
prefer表示客户端将在可用时选择通道绑定，
而disable则阻止使用通道绑定。默认情况下，
如果PostgreSQL是使用SSL支持编译的，则默认为prefer;
否则默认为disable。
Channel binding是服务器向客户端进行身份验证的一种方法。它仅在使用PostgreSQL 11或更高版本服务器，并使用SCRAM身份验证方法的SSL连接中受支持。
connect_timeout #
连接时等待的最长时间，单位为秒（写成十进制整数，例如
10）。零、负数或未指定表示无限等待。
此超时分别适用于每个主机名或IP地址。
例如，如果指定了两个主机且connect_timeout
为5，则每个主机如果在5秒内未建立连接将超时，因此等待连接的总时间
可能长达10秒。
client_encoding #
这将为此连接设置client_encoding配置参数。除了对应服务器选项接受的值外，
您还可以使用auto来从客户端的当前区域设置（Unix系统上的LC_CTYPE环境变量）确定正确的编码。
options #
指定连接开始时发送给服务器的命令行选项。例如，将此设置为
-c geqo=off或--geqo=off会将会话的
geqo参数值设置为off。此字符串中的空格
被视为分隔命令行参数，除非用反斜杠(\)转义；
写\\表示字面上的反斜杠。有关可用选项的详细讨论，
请参阅第 19 章。
application_name #
指定application_name配置参数的值。
fallback_application_name #
指定application_name配置参数的回退值。
如果没有通过连接参数或PGAPPNAME环境变量为application_name指定值，
则将使用此值。在通用实用程序中指定回退名称很有用，该程序希望设置默认应用程序名称，
但允许用户覆盖它。
keepalives #
控制是否使用客户端TCP保持活动。默认值为1，表示开启，但如果不想要保持活动，可以将其更改为0，表示关闭。
对于通过Unix域套接字进行的连接，此参数将被忽略。
keepalives_idle #
控制在多少秒的不活动后，TCP应向服务器发送保持活动消息。值为零使用系统默认值。
对通过Unix域套接字进行的连接或禁用保持活动的连接，此参数将被忽略。
仅在支持TCP_KEEPIDLE或等效套接字选项的系统以及Windows上支持；
在其他系统上，它没有任何效果。
keepalives_interval #
控制在服务器未确认的情况下重新传输TCP保持活动消息的秒数。值为零时使用系统默认值。
此参数在通过Unix域套接字进行连接或禁用保持活动时将被忽略。
仅在支持TCP_KEEPINTVL或等效套接字选项的系统和Windows上支持；
在其他系统上，此参数无效。
keepalives_count #
控制在客户端与服务器之间连接被视为断开之前可以丢失的TCP keepalive数量。
值为零时使用系统默认值。对通过Unix域套接字建立的连接或禁用keepalives的连接，此参数将被忽略。
仅在支持TCP_KEEPCNT或等效套接字选项的系统上受支持；
在其他系统上，此参数无效。
tcp_user_timeout #
控制在连接强制关闭之前，传输数据可以保持未被确认的毫秒数。
值为零时使用系统默认值。此参数对通过Unix域套接字进行的连接无效。
仅在支持TCP_USER_TIMEOUT的系统上受支持；在其他系统上，它没有效果。
replication #
这个选项确定连接是否应该使用复制协议而不是正常协议。这就是PostgreSQL复制连接以及诸如
pg_basebackup这样的工具在内部使用的方式，但也可以被第三方应用程序使用。
要了解复制协议的描述，请参考第 54.4 节。
支持以下值（不区分大小写）：
true, on,
yes, 1
连接进入物理复制模式。
database
连接进入逻辑复制模式，连接到dbname参数中指定的数据库。
false, off,
no, 0
连接是常规连接，这是默认行为。
在物理或逻辑复制模式下，只能使用简单查询协议。
gssencmode #
这个选项确定是否以及如何优先与服务器协商安全的GSS TCP/IP连接。有三种模式：
disable
仅尝试非GSSAPI加密连接
prefer (默认)
如果存在GSSAPI凭据（即在凭据缓存中），首先尝试
GSSAPI加密连接；如果失败或没有凭据，则尝试
非GSSAPI加密连接。这是在编译PostgreSQL时使用GSSAPI支持时的默认设置。
require
仅尝试GSSAPI加密连接
gssencmode在Unix域套接字通信中被忽略。如果PostgreSQL没有编译GSSAPI支持，
使用require选项将导致错误，而prefer将被接受，但libpq实际上不会尝试
进行GSSAPI加密连接。
sslmode #
这个选项确定是否以及以何种优先级与服务器协商安全的SSL TCP/IP连接。有六种模式：
disable
仅尝试非SSL连接
allow
首先尝试非SSL连接；如果失败，则尝试SSL连接
prefer (默认)
首先尝试SSL连接；如果失败，则尝试非SSL连接
require
仅尝试SSL连接。如果存在根CA文件，则验证证书的方式与指定了verify-ca时相同
verify-ca
仅尝试SSL连接，并验证服务器证书是否由受信任的证书颁发机构（CA）颁发
verify-full
仅尝试SSL连接，验证服务器证书是否由受信任的CA颁发，并且请求的服务器主机名与证书中的匹配
详细了解这些选项如何工作，请参阅第 32.19 节。
sslmode被忽略用于Unix域套接字通信。
如果PostgreSQL没有SSL支持编译，
使用选项require、verify-ca或
verify-full会导致错误，而选项allow和prefer
将被接受，但libpq实际上不会尝试建立SSL
连接。
注意，如果可以使用GSSAPI加密，
将优先使用它，而不是SSL
加密，无论sslmode的值如何。
要在具有可用GSSAPI
基础设施（例如Kerberos服务器）的环境中强制使用
SSL加密，还需将
gssencmode设置为disable。
requiressl #
此选项已被sslmode设置所取代。
如果设置为1，则需要与服务器建立SSL连接（这相当于sslmode
require）。libpq将拒绝连接，如果服务器不接受
SSL连接。如果设置为0（默认值），
libpq将与服务器协商连接类型（相当于sslmode
prefer）。此选项仅在PostgreSQL编译时启用SSL支持。
sslnegotiation #
该选项控制如果使用SSL时，如何与服务器协商SSL加密。在默认的
postgres模式下，客户端首先询问服务器是否支持SSL。
在direct模式下，客户端在建立TCP/IP连接后直接开始
标准的SSL握手。传统的PostgreSQL协议协商
对不同服务器配置最为灵活。如果已知服务器支持直接的SSL
连接，则后者减少了一次往返，降低了连接延迟，同时也允许使用协议无关的
SSL网络工具。直接SSL选项是在PostgreSQL版本17中引入的。
postgres
执行PostgreSQL协议协商。
如果未提供该选项，则这是默认行为。
direct
在建立 TCP/IP 连接后直接开始 SSL 握手。这仅在
sslmode=require 或更高的情况下允许，因为较弱的设置可能导致在服务器不支持直接 SSL 握手时意外回退到明文身份验证。
sslcompression #
如果设置为1，通过SSL连接发送的数据将被压缩。如果设置为0，将禁用压缩。默认值为0。
如果进行非SSL连接，则忽略此参数。
SSL压缩现在被认为是不安全的，不再推荐使用。  OpenSSL 1.1.0默认禁用压缩，
许多操作系统发行版在之前的版本中也禁用了它，因此如果服务器不接受压缩，设置此参数为on
将不会有任何效果。 PostgreSQL 14在后端完全禁用了压缩。
如果安全性不是主要考虑因素，压缩可以提高吞吐量，如果网络是瓶颈的话。禁用压缩可以提高响应时间和吞吐量，如果CPU性能是限制因素。
sslcert #
这个参数指定客户端SSL证书的文件名，替换默认的
~/.postgresql/postgresql.crt。
如果没有建立SSL连接，则此参数将被忽略。
sslkey #
这个参数指定了用于客户端证书的密钥的位置。它可以指定一个文件名，该文件名将被用来替代默认的
~/.postgresql/postgresql.key，或者它可以指定一个从外部“引擎”
（引擎是OpenSSL可加载模块）获取的密钥。外部引擎规范应该包括一个由冒号分隔的引擎名称和
一个引擎特定的密钥标识符。如果没有进行SSL连接，则此参数将被忽略。
sslkeylogfile #
此参数指定 libpq 将在此 SSL 上下文中记录的密钥位置。这对于调试
PostgreSQL 协议交互或使用网络检查工具（如
Wireshark）的客户端连接非常有用。如果未建立 SSL 连接，或者使用 LibreSSL
（LibreSSL 不支持密钥记录），则此参数将被忽略。密钥使用 NSS
格式记录。
警告
密钥记录将暴露密钥日志文件中的潜在敏感信息。密钥日志文件应像处理 sslkey 文件一样小心处理。
sslpassword #
这个参数指定了在sslkey中指定的密钥的密码，允许客户端证书私钥在磁盘上以加密形式存储，即使交互式密码输入不方便。
使用任何非空值指定此参数将抑制 Enter PEM pass phrase:
提示，该提示是 OpenSSL 在提供加密客户端证书密钥时默认发出的。
如果密钥未加密，则忽略此参数。该参数对由OpenSSL引擎指定的密钥没有影响，除非引擎使用OpenSSL密码回调机制进行提示。
没有与此选项等效的环境变量，也没有在.pgpass中查找它的功能。它可以在服务文件连接定义中使用。
使用更复杂功能的用户应考虑使用OpenSSL引擎和类似PKCS#11或USB加密卸载设备的工具。
sslcertmode #
此选项决定是否可以向服务器发送客户端证书，以及服务器是否必须请求
一个证书。有三种模式：
disable
客户端证书永远不会被发送，即使有可用的证书（默认位置或通过
sslcert提供）。
allow（默认）
如果服务器请求并且客户端有证书可发送，则可以发送证书。
require
服务器必须请求证书。如果客户端未发送证书且
服务器仍然成功验证了客户端，则连接将失败。
注意
sslcertmode=require 并不会增加任何额外的安全性，
因为无法保证服务器正确验证证书；PostgreSQL 服务器通常会向客户端
请求 TLS 证书，无论它们是否进行验证。该选项在排查更复杂的 TLS
配置问题时可能会有用。
sslrootcert #
这个参数指定一个包含 SSL 证书颁发机构（CA）证书的文件名。
如果文件存在，服务器的证书将被验证是否由这些机构之一签名。
默认值是 ~/.postgresql/root.crt。
特殊值 system 也可以被指定，在这种情况下，将加载 SSL 实现中的受信任 CA 根证书。
这些根证书的具体位置因 SSL 实现和平台而异。特别是对于 OpenSSL，
这些位置还可以通过 SSL_CERT_DIR 和 SSL_CERT_FILE 环境变量进一步修改。
注意
当使用 sslrootcert=system 时，默认的
sslmode 会更改为 verify-full，
任何更弱的设置都会导致错误。在大多数情况下，任何人都可以轻松
获取由系统信任的证书用于他们控制的主机名，这使得
verify-ca 及所有更弱的模式变得无用。
魔法 system 值将优先于具有相同名称的本地证书文件。
如果由于某种原因您发现自己处于这种情况，请使用替代路径，例如
sslrootcert=./system。
sslcrl #
此参数指定 SSL 服务器证书吊销列表（CRL）的文件名。如果此文件存在，
则在尝试验证服务器证书时，列在此文件中的证书将被拒绝。如果
sslcrl 或
sslcrldir 都未设置，则此设置将被视为
~/.postgresql/root.crl。
sslcrldir #
这个参数指定 SSL 服务器证书吊销列表（CRL）的目录名称。如果存在该目录中的文件中列出的证书，
在尝试验证服务器证书时将被拒绝。
目录需要使用 OpenSSL 命令
openssl rehash 或 c_rehash 进行准备。详细信息请参阅其文档。
sslcrl和sslcrldir可以一起指定。
sslsni #
如果设置为1（默认值），libpq会在启用SSL的连接上设置TLS扩展“Server Name Indication”（SNI）。
通过将此参数设置为0，可以关闭此功能。
SSL-aware代理可以使用服务器名称指示来路由连接，而无需解密SSL流。 （注意，
除非代理了解PostgreSQL协议握手，否则这需要将sslnegotiation
设置为direct。）
但是，SNI使目标主机名以明文形式出现在网络流量中，因此在某些情况下
可能是不希望的。
requirepeer #
这个参数指定了服务器的操作系统用户名，例如requirepeer=postgres。
在建立Unix域套接字连接时，如果设置了这个参数，客户端会在连接开始时检查服务器进程是否在指定的用户下运行；
如果不是，则连接会因错误而中止。
这个参数可用于提供类似于在TCP/IP连接上使用SSL证书的服务器身份验证。
（请注意，如果Unix域套接字位于/tmp或其他公共可写位置，
任何用户都可以在那里启动一个服务器监听。使用这个参数来确保您连接到由受信任用户运行的服务器。）
此选项仅在实现了peer身份验证方法的平台上受支持；请参见第 20.9 节。
ssl_min_protocol_version #
这个参数指定连接允许的最低SSL/TLS协议版本。有效值为TLSv1，
TLSv1.1，TLSv1.2和
TLSv1.3。支持的协议取决于所使用的
OpenSSL版本，旧版本不支持最现代的协议版本。
如果未指定，默认值为TLSv1.2，符合本文撰写时的行业最佳实践。
ssl_max_protocol_version #
这个参数指定连接允许的最大SSL/TLS协议版本。有效值为TLSv1，
TLSv1.1，TLSv1.2和
TLSv1.3。支持的协议取决于使用的OpenSSL
版本，旧版本不支持最新的协议版本。如果未设置，将忽略此参数，并且连接将使用后端定义的最大限制，
如果设置。设置最大协议版本主要用于测试或者某些组件无法使用较新协议时。
min_protocol_version #
指定允许连接的最低协议版本。默认情况下允许任何版本的
PostgreSQL协议，当前意味着3.0。如果服务器
不支持至少此协议版本，则连接将被关闭。
当前支持的值为
3.0、3.2，
和 latest。latest 值等同于所使用的 libpq
版本支持的最新协议版本，目前为 3.2。
max_protocol_version #
指定请求服务器的协议版本。默认情况下使用 3.0 版本的
PostgreSQL 协议，除非连接字符串指定依赖于更高协议版本的特性，
在这种情况下使用 libpq 支持的最新版本。如果服务器不支持客户端请求的协议版本，
则连接将自动降级到服务器支持的较低次要协议版本。在连接尝试完成后，您可以使用 PQfullProtocolVersion
查找协商的确切协议版本。
当前支持的值为
3.0、3.2，
和 latest。latest 值等同于所使用的 libpq
版本支持的最新协议版本，目前为 3.2。
krbsrvname #
用于使用 GSSAPI 进行身份验证时要使用的 Kerberos 服务名称。
这必须与服务器配置中指定的 Kerberos 身份验证服务名称匹配，才能成功进行身份验证。
（另请参见 第 20.6 节。）
默认值通常为 postgres，
但在构建 PostgreSQL 时可以通过
--with-krb-srvnam 选项进行更改
configure。
在大多数环境中，通常不需要更改此参数。
一些 Kerberos 实现可能需要不同的服务名称，
例如 Microsoft Active Directory 需要服务名称为大写（POSTGRES）。
gsslib #
用于 GSSAPI 身份验证的 GSS 库。
目前，除了包含 GSSAPI 和 SSPI 支持的 Windows 构建之外，这将被忽略。
在这种情况下，将其设置为 gssapi，以使 libpq 使用 GSSAPI 库进行身份验证，而不是默认的 SSPI。
gssdelegation #
将（委派）GSS 凭据转发到服务器。默认值是 0，这意味着凭据
不会被转发到服务器。将其设置为 1，以便在可能的情况下转发
凭据。
scram_client_key #
base64 编码的 SCRAM 客户端密钥。这可以被外部数据包装器或类似中间件用于启用透传 SCRAM
身份验证。有关此类实现，请参见 第 F.38.1.10 节。它并不打算由用户或
客户端应用程序直接指定。
scram_server_key #
base64 编码的 SCRAM 服务器密钥。这可以被外部数据包装器或类似中间件用于启用透传 SCRAM
身份验证。有关此类实现，请参见 第 F.38.1.10 节。它并不打算由用户或
客户端应用程序直接指定。
service #
用于额外参数的服务名称。它指定了pg_service.conf中保存额外连接参数的服务名称。
这允许应用程序只指定一个服务名称，以便可以集中维护连接参数。参见第 32.17 节。
target_session_attrs #
这个选项确定会话是否必须具有某些属性才能被接受。通常与多个主机名结合使用，
以选择在几个主机中选择第一个可接受的替代方案。有六种模式：
any（默认）
任何成功的连接都是可接受的
read-write
会话必须默认接受读写事务（即，服务器不能处于热备模式，
并且default_transaction_read_only参数必须为off）
read-only
会话默认不接受读写事务（相反）
primary
服务器不能处于热备模式
standby
服务器必须处于热备模式
prefer-standby
首先尝试找到一个热备服务器，但如果列出的主机中没有一个是热备服务器，
则再次尝试any模式
load_balance_hosts #
控制客户端尝试连接可用主机和地址的顺序。一旦连接尝试成功，
将不会尝试其他主机和地址。此参数通常与多个主机名或返回多个
IP 的 DNS 记录结合使用。此参数可以与
target_session_attrs
结合使用，例如，仅在备用服务器之间进行负载均衡。一旦成功
连接，后续在返回的连接上执行的查询都将发送到同一台服务器。
当前有两种模式：
disable（默认）
不在主机之间进行负载均衡。主机按照提供的顺序尝试，地址
按照从 DNS 或主机文件接收的顺序尝试。
random
主机和地址以随机顺序尝试。此值主要在同时打开多个连接时
有用，可能来自不同的机器。通过这种方式，可以在多个
PostgreSQL 服务器之间进行负载均衡。
由于随机负载均衡的随机性，它几乎不会导致完全均匀的分布，
但从统计上看会非常接近。这里一个重要的方面是该算法使用了
两个级别的随机选择：首先，主机将以随机顺序解析。然后，在
解析下一个主机之前，当前主机的所有解析地址将以随机顺序
尝试。这种行为在某些情况下可能会极大地偏向某些节点的连接
数，例如当某些主机解析出的地址比其他主机多时。但这种偏向
也可以被有意利用，例如通过在主机字符串中多次提供较大服务器
的主机名来增加其获得的连接数。
使用此值时，建议同时为
connect_timeout 配置一个合理的值。
因为这样，如果用于负载均衡的某个节点没有响应，将尝试新的
节点。
oauth_issuer #
如果服务器请求连接的 OAuth 令牌，则联系受信任颁发者的 HTTPS URL。
此参数对于所有 OAuth 连接都是必需的；它应与
issuer 设置完全匹配
服务器的 HBA 配置。
作为标准身份验证握手的一部分，libpq
将向服务器请求 发现文档： 一个提供一组 OAuth 配置参数的 URL。
服务器必须提供一个直接由 oauth_issuer 组件构建的 URL，
并且该值必须与发现文档中声明的颁发者标识符完全匹配，否则连接将失败。
这是为了防止对 OAuth 客户端的一类
"混淆攻击"。
您还可以显式将 oauth_issuer 设置为用于 OAuth 发现的
/.well-known/ URI。在这种情况下，如果服务器请求不同的 URL，
则连接将失败，但 自定义 OAuth 流
可能能够通过使用先前缓存的令牌来加速标准握手。
（在这种情况下，建议同时设置 oauth_scope，
因为客户端将没有机会向服务器请求正确的范围设置，
而令牌的默认范围可能不足以建立连接。）
libpq 当前支持以下知名端点：
/.well-known/openid-configuration/.well-known/oauth-authorization-server
警告
在 OAuth 连接握手期间，颁发者具有高度特权。作为经验法则，
如果您不信任某个 URL 的操作员来处理对您服务器的访问，
或直接冒充您，则该 URL 不应被信任为 oauth_issuer。
oauth_client_id #
OAuth 2.0 客户端标识符，由授权服务器颁发。
如果 PostgreSQL 服务器
请求 OAuth 令牌 以进行连接
（并且如果没有安装 自定义 OAuth 钩子 来提供一个），
则必须设置此参数；否则，连接将失败。
oauth_client_secret #
客户端密码（如果有）在联系 OAuth 授权服务器时使用。
此参数是否必需由 OAuth 提供者决定；
"公共" 客户端通常不使用密钥，而 "机密" 客户端通常会使用。
oauth_scope #
发送到授权服务器的访问请求的范围，
以（可能为空的）空格分隔的 OAuth 范围标识符列表指定。
此参数是可选的，旨在用于高级用法。
通常，客户端将从 PostgreSQL 服务器获取适当的范围设置。
如果使用此参数，则服务器请求的范围列表将被忽略。
这可以防止不太可信的服务器向最终用户请求不适当的访问范围。
然而，如果客户端的范围设置不包含服务器所需的范围，
服务器可能会拒绝发出的令牌，连接将失败。
空范围列表的含义取决于提供者。OAuth 授权服务器可能选择发出带有 "默认范围" 的令牌，
无论那是什么，或者可能完全拒绝令牌请求。
上一页 上一级 下一页第 32 章 libpq — C 库 起始页 32.2. 连接状态函数
