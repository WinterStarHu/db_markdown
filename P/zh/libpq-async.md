# 32.4. 异步命令处理

32.4. 异步命令处理
版本：
纠错本页面
搜索
目录导航
❮
❯
32.4. 异步命令处理 #
PQexec函数对于在普通的同步应用中提交命令是足以胜任的。不过，它的一些缺点可能对某些用户很重要：
PQexec会等待命令完成。该应用可能有其他的工作要做（例如维护用户界面），这时它将不希望阻塞等待回应。
因为客户端应用的执行在它等待结果时会被挂起，对于应用来说很难决定要不要尝试取消正在进行的命令（这可以在一个信号处理器中完成，但别无他法）。
PQexec只能返回一个PGresult结构。
如果提交的命令串包含多个SQL命令，除了最后一个PGresult之外都会被PQexec丢弃。
PQexec总是收集命令的整个结果，把它缓存在一个单一的PGresult中。虽然这简化了应用的错误处理逻辑，它对于包含很多行的结果并不现实。
不喜欢这些限制的应用程序可以改用构建PQexec的底层函数：
PQsendQuery和PQgetResult。
还有
PQsendQueryParams,
PQsendPrepare,
PQsendQueryPrepared,
PQsendDescribePrepared,
PQsendDescribePortal,
PQsendClosePrepared和
PQsendClosePortal,
它们可以与PQgetResult一起使用，以实现
PQexecParams,
PQprepare,
PQexecPrepared,
PQdescribePrepared,
PQdescribePortal,
PQclosePrepared和
PQclosePortal
的功能。
PQsendQuery #
提交一个命令到服务器，而不等待结果。
如果成功发送命令，则返回1，如果失败则返回0（在这种情况下，使用
PQerrorMessage
获取更多关于失败的信息）。
int PQsendQuery(PGconn *conn, const char *command);
成功调用PQsendQuery后，调用一次或多次PQgetResult来获取结果。
在PQgetResult返回空指针，表示命令执行完成之前，无法再次调用PQsendQuery（在同一连接上）。
在管道模式下，此函数被禁止使用。
PQsendQueryParams #
提交一个命令和单独的参数到服务器，而不等待结果。
int PQsendQueryParams(PGconn *conn,
const char *command,
int nParams,
const Oid *paramTypes,
const char * const *paramValues,
const int *paramLengths,
const int *paramFormats,
int resultFormat);
这相当于PQsendQuery，不同之处在于查询参数可以单独指定，而不是与查询字符串一起指定。
函数的参数处理方式与PQexecParams完全相同。与PQexecParams一样，它在查询字符串中只允许一个命令。
PQsendPrepare #
发送一个请求来创建一个带有给定参数的预处理语句，而不等待完成。
int PQsendPrepare(PGconn *conn,
const char *stmtName,
const char *query,
int nParams,
const Oid *paramTypes);
这是PQprepare的异步版本：如果能够分派请求，则返回1，否则返回0。
成功调用后，调用PQgetResult来确定服务器是否成功创建了预处理语句。
该函数的参数处理方式与PQprepare完全相同。
PQsendQueryPrepared #
发送一个请求来执行一个准备好的语句，带有给定的参数，而不等待结果。
int PQsendQueryPrepared(PGconn *conn,
const char *stmtName,
int nParams,
const char * const *paramValues,
const int *paramLengths,
const int *paramFormats,
int resultFormat);
这类似于PQsendQueryParams，但要执行的命令是通过指定一个之前准备好的语句的名称来指定，而不是提供一个查询字符串。
函数的参数处理方式与PQexecPrepared完全相同。
PQsendDescribePrepared #
提交请求以获取关于指定预处理语句的信息，而无需等待完成。
int PQsendDescribePrepared(PGconn *conn, const char *stmtName);
这是PQdescribePrepared的异步版本：
如果能够发送请求，则返回1，否则返回0。
成功调用后，调用PQgetResult来获取结果。
函数的参数处理方式与PQdescribePrepared相同。
PQsendDescribePortal #
提交请求以获取有关指定门户的信息，而无需等待完成。
int PQsendDescribePortal(PGconn *conn, const char *portalName);
这是PQdescribePortal的异步版本：
如果能够发送请求，则返回1，否则返回0。
成功调用后，调用PQgetResult以获取结果。
该函数的参数处理方式与PQdescribePortal相同。
PQsendClosePrepared #
提交请求以关闭指定的预处理语句，而无需等待完成。
int PQsendClosePrepared(PGconn *conn, const char *stmtName);
这是PQclosePrepared的异步版本：
如果能够发送请求，则返回1，否则返回0。
成功调用后，调用PQgetResult以获取结果。
该函数的参数处理方式与PQclosePrepared相同。
PQsendClosePortal #
提交请求以关闭指定的门户，而无需等待完成。
int PQsendClosePortal(PGconn *conn, const char *portalName);
这是PQclosePortal的异步版本：
如果能够发送请求，则返回1，否则返回0。
成功调用后，调用PQgetResult以获取结果。
该函数的参数处理方式与PQclosePortal相同。
PQgetResult #
等待来自先前
PQsendQuery,
PQsendQueryParams,
PQsendPrepare,
PQsendQueryPrepared,
PQsendDescribePrepared,
PQsendDescribePortal,
PQsendClosePrepared,
PQsendClosePortal,
PQsendPipelineSync, 或
PQpipelineSync
调用的下一个结果，并返回该结果。
当命令完成且不再有更多结果时，返回空指针。
PGresult *PQgetResult(PGconn *conn);
必须重复调用PQgetResult直到返回空指针，表示命令已完成。
（如果在没有活动命令时调用，
PQgetResult将立即返回空指针。）每个非空结果从
PQgetResult应该使用先前描述的相同PGresult访问器函数进行处理。
完成后不要忘记使用PQclear释放每个结果对象。请注意，
PQgetResult仅在有命令处于活动状态且必要的响应数据尚未被
PQconsumeInput
读取时才会阻塞。
在管道模式下，PQgetResult将正常返回，除非发生错误；
对于在导致错误的查询之后发送的任何后续查询，直到（并不包括）下一个
同步点，将返回类型为PGRES_PIPELINE_ABORTED的特殊结果，
并在其后返回一个空指针。
当到达管道同步点时，将返回类型为PGRES_PIPELINE_SYNC
的结果。
同步点之后的下一个查询的结果会立即返回（也就是说，在同步点之后不会
返回空指针）。
注意
即使PQresultStatus指示发生了致命错误，也应该调用PQgetResult直到它返回空指针，
以便libpq完全处理错误信息。
使用PQsendQuery和PQgetResult解决了PQexec的一个问题：如果一个命令字符串包含多个SQL命令，这些命令的结果可以被单独获得。（顺便说一句：这样就允许一种简单的重叠处理形式，客户端可以处理一个命令的结果，而同时服务器可以继续处理同一命令字符串中后面的查询。）
另一个常用的功能是通过PQsendQuery和PQgetResult
实现一次只获取有限行数的大型查询结果。相关内容请参见
第 32.6 节。
就其本身而言，调用PQgetResult将仍会导致客户端阻塞，直到服务器完成下一个SQL命令。可以通过正确使用两个函数来避免这种情况：
PQconsumeInput
#
如果有来自服务器的输入可用，则使用之。
int PQconsumeInput(PGconn *conn);
PQconsumeInput
通常返回1，表示“没有错误”，而返回0表示有某种麻烦发生（此时可以用
PQerrorMessage
）。注意该结果并不表明是否真正收集了任何输入数据。在调用PQconsumeInput
之后，应用可以检查PQisBusy和/或PQnotifies来看看它们的状态是否改变。
即使应用还不准备处理一个结果或通知，PQconsumeInput
也可以被调用。
这个函数将读取可用的数据并且把它保存在一个缓冲区中，从而导致一个select()的读准备好指示消失。
因此应用可以使用PQconsumeInput
立即清除select()条件，并且在空闲时再检查结果。
PQisBusy #
如果一个命令繁忙则返回1，也就是说PQgetResult会阻塞等待输入。返回0表示可以调用PQgetResult而不用担心阻塞。
int PQisBusy(PGconn *conn);
PQisBusy本身将不会尝试从服务器读取数据，因此必须先调用PQconsumeInput
，否则繁忙状态将永远不会结束。
一个使用这些函数的典型应用将有一个主循环，在主循环中会使用select()或poll()等待所有它必须响应的情况。
其中之一将是来自服务器的输入可用，对select()来说意味着可读的数据在PQsocket标识的文件描述符上。
当主循环检测到输入准备好时，它将调用PQconsumeInput
读取输入。
然后它可以调用PQisBusy，如果PQisBusy返回假（0）则接着调用PQgetResult。
它还可以调用PQnotifies检测NOTIFY消息（见第 32.9 节）。
使用PQsendQuery/PQgetResult的客户端也可以尝试取消服务器仍在处理的命令；参见第 32.7 节。但无论PQcancelBlocking的返回值如何，应用程序必须继续使用PQgetResult进行正常的结果读取序列。成功取消将使命令比原本更早终止。
通过使用上面描述的函数，可以避免在等待来自数据库服务器的输入时阻塞。
然而，应用程序仍然可能会在等待向服务器发送输出时阻塞。
这在发送非常长的SQL命令或数据值时可能会发生，尽管这相对不常见。
（如果应用程序通过COPY IN发送数据，则更有可能发生。）
为了防止这种可能性并实现完全非阻塞的数据库操作，可以使用以下附加函数。
PQsetnonblocking #
设置连接的非阻塞状态。
int PQsetnonblocking(PGconn *conn, int arg);
如果arg为1，则将连接状态设置为非阻塞，如果
arg为0，则设置为阻塞。如果成功返回0，出错返回-1。
在非阻塞状态下，成功调用PQsendQuery、
PQputline、PQputnbytes、
PQputCopyData和PQendcopy不会阻塞；
它们的更改将存储在本地输出缓冲区中，直到刷新为止。
不成功的调用将返回错误，必须重试。
请注意，PQexec不遵守非阻塞模式；如果调用它，它将以阻塞方式执行。
PQisnonblocking #
返回数据库连接的阻塞状态。
int PQisnonblocking(const PGconn *conn);
如果连接设置为非阻塞模式，则返回1，如果为阻塞，则返回0。
PQflush #
尝试将任何排队的输出数据刷新到服务器。如果成功（或发送队列为空），则返回0；
如果由于某种原因失败，则返回-1；如果尚未能够发送发送队列中的所有数据（只有在连接为非阻塞时才会发生此情况），
则返回1。
int PQflush(PGconn *conn);
在一个非阻塞连接上发送任何命令或者数据之后，要调用PQflush。
如果它返回1，就要等待套接字变成读准备好或写准备好。如果它变为写准备好，应再次调用PQflush。
如果它变为读准备好，则应先调用PQconsumeInput
，然后再调用PQflush。
一直重复直到PQflush返回0。（有必要检查读准备好并且用PQconsumeInput
耗尽输入，因为服务器可能阻塞给我们发送数据的尝试，例如NOTICE消息，并且在我们读它的数据之前它都不会读我们的数据。）
一旦PQflush返回0，应等待套接字变成读准备好并且接着按照上文所述读取响应。
上一页 上一级 下一页32.3. 命令执行函数 起始页 32.5. 管道模式
