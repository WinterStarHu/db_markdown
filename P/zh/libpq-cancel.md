# 32.7. 取消进行中的查询

32.7. 取消进行中的查询
版本：
纠错本页面
搜索
目录导航
❮
❯
32.7. 取消进行中的查询 #32.7.1. 发送取消请求的函数32.7.2. 发送取消请求的过时函数32.7.1. 发送取消请求的函数 #PQcancelCreate #
准备一个连接，通过该连接可以发送取消请求。
PGcancelConn *PQcancelCreate(PGconn *conn);
PQcancelCreate 创建一个
PGcancelConn
对象，但它不会立即开始通过此连接发送取消请求。可以使用
PQcancelBlocking 以阻塞方式通过此连接发送取消请求，
也可以使用 PQcancelStart 以非阻塞方式发送。
返回值可以传递给 PQcancelStatus 来检查
PGcancelConn 对象是否创建成功。
PGcancelConn 对象是一个不透明结构，
应用程序不应直接访问。此 PGcancelConn 对象
可用于以线程安全的方式取消原始连接上正在运行的查询。
取消请求的连接设置时会重用原始客户端的许多连接参数。重要的是，若原始连接
需要加密连接和/或验证目标主机（使用sslmode或
gssencmode），则取消请求的连接也会满足这些相同的要求。
但任何仅在认证期间或认证后使用的连接选项都会被忽略，因为取消请求不需要
认证，并且在提交取消请求后连接会立即关闭。
注意，当PQcancelCreate返回非空指针时，您必须在使用完毕后调用
PQcancelFinish，以释放该结构及其相关的内存块。即使取消请求失败
或被放弃，也必须执行此操作。
PQcancelBlocking #
请求服务器以阻塞方式放弃当前命令的处理。
int PQcancelBlocking(PGcancelConn *cancelConn);
请求是通过给定的PGcancelConn发出的，
该连接需要使用PQcancelCreate创建。
PQcancelBlocking的返回值为1表示取消请求已成功
发送，返回0表示未成功。如果未成功，可以使用
PQcancelErrorMessage
获取错误信息。
成功发送取消请求并不保证该请求会产生任何效果。如果取消成功，
被取消的命令将提前终止并返回错误结果。如果取消失败（例如，因为
服务器已经完成了命令的处理），则不会有任何可见的结果。
PQcancelStartPQcancelPoll #
请求服务器以非阻塞方式放弃当前命令的处理。
int PQcancelStart(PGcancelConn *cancelConn);
PostgresPollingStatusType PQcancelPoll(PGcancelConn *cancelConn);
请求是通过给定的PGcancelConn发起的，
该连接需要使用PQcancelCreate创建。
PQcancelStart的返回值为1表示取消请求已启动，
返回0表示未能启动。如果未成功，可以使用
PQcancelErrorMessage
检索错误信息。
如果PQcancelStart成功，下一步是轮询libpq，
以便它可以继续取消连接序列。使用PQcancelSocket
获取数据库连接所用套接字的描述符。（注意：不要假设套接字在
PQcancelPoll调用之间保持不变。）循环如下：
如果PQcancelPoll(cancelConn)上次返回
PGRES_POLLING_READING，则等待套接字准备好读取（由
select()、poll()或类似系统函数指示）。
然后再次调用PQcancelPoll(cancelConn)。
相反，如果PQcancelPoll(cancelConn)上次返回
PGRES_POLLING_WRITING，则等待套接字准备好写入，
然后再次调用PQcancelPoll(cancelConn)。
在第一次迭代时，即尚未调用
PQcancelPoll(cancelConn)时，行为应当如同上次返回
PGRES_POLLING_WRITING。继续此循环，直到
PQcancelPoll(cancelConn)返回
PGRES_POLLING_FAILED，表示连接过程失败，或返回
PGRES_POLLING_OK，表示取消请求已成功发送。
成功发送取消请求并不保证该请求会产生任何效果。如果取消成功，
被取消的命令将提前终止并返回错误结果。如果取消失败（例如，因为
服务器已经完成了命令的处理），则不会有任何可见的结果。
在连接的任何时候，可以通过调用 PQcancelStatus 来检查连接的状态。
如果此调用返回 CONNECTION_BAD，则取消过程失败；如果调用返回
CONNECTION_OK，则取消请求已成功发送。
这两种状态都可以通过上述 PQcancelPoll 的返回值检测到。
在异步连接过程中，可能还会出现其他状态（仅在此期间）。
这些状态指示连接过程的当前阶段，并可能对用户提供反馈有用。
这些状态包括：
CONNECTION_ALLOCATED #
等待调用 PQcancelStart 或
PQcancelBlocking 来实际打开
套接字。这是调用 PQcancelCreate
或 PQcancelReset 后的连接状态。
此时尚未与服务器建立连接。要实际开始
发送取消请求，请使用 PQcancelStart 或
PQcancelBlocking。
CONNECTION_STARTED #
等待建立连接。
CONNECTION_MADE #
连接正常；等待发送。
CONNECTION_AWAITING_RESPONSE #
等待来自服务器的响应。
CONNECTION_SSL_STARTUP #
正在协商 SSL 加密。
CONNECTION_GSS_STARTUP #
正在协商 GSS 加密。
请注意，尽管这些常量将保持不变（以保持兼容性），但应用程序不应依赖于这些状态以特定顺序出现，或根本出现，或状态始终是这些文档中列出的值之一。应用程序可能会这样做：
switch(PQcancelStatus(conn))
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
当使用PQcancelPoll时，connect_timeout连接参数会被忽略；
应用程序需要自行决定是否已经超出允许的时间。否则，PQcancelStart后
跟随一个PQcancelPoll循环，相当于PQcancelBlocking。
PQcancelStatus #
返回取消连接的状态。
ConnStatusType PQcancelStatus(const PGcancelConn *cancelConn);
状态可以是多个值之一。然而，只有三个值在异步取消过程中之外可见：
CONNECTION_ALLOCATED，
CONNECTION_OK 和
CONNECTION_BAD。成功创建的 PGcancelConn 的初始状态是 CONNECTION_ALLOCATED。
成功发送的取消请求状态为 CONNECTION_OK。取消尝试失败的状态为
CONNECTION_BAD。OK 状态将保持不变，直到调用 PQcancelFinish 或
PQcancelReset。
请参阅关于可能返回的其他状态代码的 PQcancelStart 条目。
成功发送取消请求并不保证该请求会产生任何效果。如果取消成功，
被取消的命令将提前终止并返回错误结果。如果取消失败（例如，因为
服务器已经完成了命令的处理），则不会有任何可见的结果。
PQcancelSocket #
获取取消连接套接字到服务器的文件描述符编号。
int PQcancelSocket(const PGcancelConn *cancelConn);
有效的描述符将大于或等于0；结果为-1表示当前没有打开的服务器连接。
调用本节中任何函数可能会导致此情况发生变化，
这些函数作用于 PGcancelConn（除了
PQcancelErrorMessage
和 PQcancelSocket 本身）。
PQcancelErrorMessage
#
返回最近一次对取消连接操作生成的错误信息。
char *PQcancelErrorMessage(const PGcancelConn *cancelconn);
几乎所有接受libpq中
PGcancelConn参数的函数在失败时都会为
PQcancelErrorMessage
设置一条消息。
注意，根据libpq的约定，
非空的
PQcancelErrorMessage
结果可能包含多行，
并且会包含一个结尾换行符。调用者不应直接释放该结果。
当关联的PGcancelConn句柄传递给
PQcancelFinish时，结果将被释放。
不应期望结果字符串在对PGcancelConn结构的操作中保持不变。
PQcancelFinish #
关闭取消连接（如果尚未完成发送取消请求）。同时释放由
PGcancelConn对象使用的内存。
void PQcancelFinish(PGcancelConn *cancelConn);
注意，即使取消尝试失败（如PQcancelStatus所示），
应用程序仍应调用PQcancelFinish释放PGcancelConn
对象使用的内存。调用PQcancelFinish后，不能再次使用
PGcancelConn指针。
PQcancelReset #
重置PGcancelConn，使其可以重新用于新的取消连接。
void PQcancelReset(PGcancelConn *cancelConn);
如果当前正在使用PGcancelConn发送取消请求，则此连接将被关闭。
然后它会准备PGcancelConn对象，以便可以用来发送新的取消请求。
这可以用来为一个PGcancelConn创建一个
PGconn，并在原始PGconn的整个生命周期内
多次重用它。
32.7.2. 发送取消请求的过时函数 #
这些函数代表了发送取消请求的较旧方法。虽然它们仍然有效，但由于未以加密方式发送取消请求，
即使原始连接指定了sslmode或gssencmode要求加密，
因此这些较旧的方法不推荐在新代码中使用，建议将现有代码更改为使用新函数。
PQgetCancel #
创建一个数据结构，包含使用PQcancel取消命令所需的信息。
PGcancel *PQgetCancel(PGconn *conn);
PQgetCancel 创建一个
PGcancel
对象，给定一个 PGconn 连接对象。
如果给定的 conn 是 NULL 或无效连接，
它将返回 NULL。
PGcancel 对象是一个不透明的结构，
不应由应用程序直接访问；它只能传递给 PQcancel
或 PQfreeCancel。
PQfreeCancel #
释放由PQgetCancel创建的数据结构。
void PQfreeCancel(PGcancel *cancel);
PQfreeCancel释放先前由PQgetCancel创建的数据对象。
PQcancel #
PQcancel 是一个已弃用且不安全的
PQcancelBlocking 变体，但它可以在信号处理程序中安全使用。
int PQcancel(PGcancel *cancel, char *errbuf, int errbufsize);
PQcancel 仅因向后兼容性原因而存在。应改用
PQcancelBlocking。PQcancel 唯一的优点是，
如果 errbuf 是信号处理程序中的局部变量，
它可以安全地从信号处理程序中调用。然而，这通常被认为不足以抵消该函数存在的安全问题。
PGcancel对象在PQcancel方面是只读的，
因此它也可以从与操作PGconn对象的线程分离的线程中调用。
如果取消请求成功发送，PQcancel的返回值为1，失败则为0。
如果失败，errbuf将被填充为一条解释性错误信息。
errbuf必须是一个大小为errbufsize的字符数组
（推荐大小为256字节）。
PQrequestCancel #
PQrequestCancel 是一个已弃用且不安全的
PQcancelBlocking 的变体。
int PQrequestCancel(PGconn *conn);
PQrequestCancel 仅因向后兼容性原因而存在。
应该使用 PQcancelBlocking 代替。
使用 PQrequestCancel 相较于
PQcancelBlocking 并无优势。
请求服务器放弃当前命令的处理。它直接作用于PGconn对象，
失败时将错误消息存储在PGconn对象中（可以通过
PQerrorMessage
检索）。
尽管功能相同，但这种方法在多线程程序或信号处理程序中不安全，因为可能会覆盖PGconn的错误消息，
从而破坏当前连接上正在进行的操作。
上一页 上一级 下一页32.6. 分块检索查询结果 起始页 32.8. 快速路径接口
