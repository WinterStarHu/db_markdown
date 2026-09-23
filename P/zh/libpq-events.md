# 32.14. 事件系统

32.14. 事件系统
版本：
纠错本页面
搜索
目录导航
❮
❯
32.14. 事件系统 #32.14.1. 事件类型32.14.2. 事件回调过程32.14.3. 事件支持函数32.14.4. 事件示例
libpq的事件系统被设计为通知已注册的事件处理器它感兴趣的libpq事件，例如PGconn以及PGresult对象的创建和销毁。一种主要的使用情况是这允许应用将自己的数据与一个PGconn或者PGresult关联在一起，并且确保那些数据在适当的时候被释放。
每个注册的事件处理程序都与两个数据相关联，libpq仅将其视为不透明的void *指针。
有一个透传指针，当事件处理程序与PGconn注册时，应用程序提供。
透传指针在PGconn及其生成的所有PGresult的生命周期内永远不会更改；
因此，如果使用，它必须指向长期存在的数据。
此外，还有一个实例数据指针，在每个PGconn和PGresult中一开始都是NULL。
可以使用PQinstanceData、PQsetInstanceData、
PQresultInstanceData和PQresultSetInstanceData函数来操作此指针。
请注意，与透传指针不同，PGconn的实例数据不会自动继承到从中创建的PGresult。
libpq不知道透传和实例数据指针指向的内容（如果有的话），也永远不会尝试释放它们 —— 这是事件处理程序的责任。
32.14.1. 事件类型 #
枚举PGEventId命名了事件系统处理的事件类型。它的所有值的名称都以PGEVT开始。对于每一种事件类型，都有一个相应的事件信息结构用来承载传递给事件处理器的参数。事件类型是：
PGEVT_REGISTER #
注册事件发生在调用 PQregisterEventProc 时。这是初始化事件过程可能需要的任何 instanceData 的理想时机。每个连接的每个事件处理程序只会触发一个注册事件。如果事件过程失败（返回零），则注册被取消。
typedef struct
{
PGconn *conn;
} PGEventRegister;
当接收到 PGEVT_REGISTER 事件时，evtInfo 指针应被转换为 PGEventRegister *。该结构包含一个 PGconn，其状态应为 CONNECTION_OK；如果在获得良好的 PGconn 后立即调用 PQregisterEventProc，则可以保证这一点。当返回失败代码时，必须执行所有清理，因为不会发送 PGEVT_CONNDESTROY 事件。
PGEVT_CONNRESET #
连接重置事件在完成PQreset或PQresetPoll后触发。
在这两种情况下，只有在重置成功时才会触发事件。
在PostgreSQL v15及更高版本中，事件过程的返回值将被忽略。
然而，在早期版本中，重要的是返回成功（非零），否则连接将被中止。
typedef struct
{
PGconn *conn;
} PGEventConnReset;
当接收到PGEVT_CONNRESET事件时，evtInfo指针应转换为PGEventConnReset *。
尽管包含的PGconn刚刚被重置，但所有事件数据仍保持不变。
此事件应用于重置/重新加载/重新查询任何相关的instanceData。
请注意，即使事件过程未能处理PGEVT_CONNRESET，当连接关闭时仍会收到PGEVT_CONNDESTROY事件。
PGEVT_CONNDESTROY #
为了响应PQfinish，连接销毁事件会被触发。由于 libpq 没有能力管理事件数据，事件过程有责任正确地清理它的事件数据。清理失败将会导致内存泄露。
typedef struct
{
PGconn *conn;
} PGEventConnDestroy;
当接收到一个PGEVT_CONNDESTROY事件时，evtInfo指针应该被转换为PGEventConnDestroy *。
这个事件在PQfinish执行任何其他清理之前被触发。
该事件过程的返回值被忽略，因为没有办法指示一个来自PQfinish的失败。还有，一个事件过程失败不该中断对不需要的内存的清理。
PGEVT_RESULTCREATE #
结果创建事件是响应任何生成结果的查询执行函数而触发的，包括
PQgetResult。此事件只会在结果成功创建后触发。
typedef struct
{
PGconn *conn;
PGresult *result;
} PGEventResultCreate;
当接收到PGEVT_RESULTCREATE事件时，
应将evtInfo指针转换为
PGEventResultCreate *。
conn是用于生成结果的连接。
这是初始化需要与结果关联的任何instanceData的理想位置。
如果事件过程失败（返回零），那么该事件过程将在结果的剩余生命周期内被忽略；
也就是说，它将不会接收到针对此结果或从中复制的结果的
PGEVT_RESULTCOPY或PGEVT_RESULTDESTROY事件。
PGEVT_RESULTCOPY #
结果复制事件是响应于PQcopyResult而触发的。此事件仅在复制完成后触发。
只有成功处理源结果的PGEVT_RESULTCREATE或PGEVT_RESULTCOPY事件的事件过程才会接收PGEVT_RESULTCOPY事件。
typedef struct
{
const PGresult *src;
PGresult *dest;
} PGEventResultCopy;
当接收到PGEVT_RESULTCOPY事件时，evtInfo指针应转换为PGEventResultCopy *。
src结果是被复制的内容，而dest结果是复制的目标。此事件可用于提供instanceData的深度复制，因为PQcopyResult无法做到这一点。
如果事件过程失败（返回零），该事件过程将在新结果的剩余生命周期内被忽略；也就是说，它将不会接收PGEVT_RESULTCOPY或PGEVT_RESULTDESTROY事件，无论是针对该结果还是针对从中复制的结果。
PGEVT_RESULTDESTROY #
为了响应PQclear，结果销毁事件会被触发。由于libpq没有能力管理事件数据，事件过程有责任正确地清理它的事件数据。清理失败将会导致内存泄露。
typedef struct
{
PGresult *result;
} PGEventResultDestroy;
当接收到一个PGEVT_RESULTDESTROY事件时，evtInfo指针应该被转换为PGEventResultDestroy *。
这个事件在PQclear执行任何其他清理之前被触发。该事件过程的返回值被忽略，因为没有办法指示来自PQclear的失败。
另外，一个事件过程失败不应中断不需要的内存的清理过程。
32.14.2. 事件回调过程 #PGEventProc #
PGEventProc是一个指向事件过程的 typedef，也就是从libpq接收事件的用户回调函数。一个事件过程的原型必须是
int eventproc(PGEventId evtId, void *evtInfo, void *passThrough)
evtId参数指示发生了哪一个PGEVT事件。
evtInfo指针必须被转换为合适的结构类型才能获得关于事件的进一步信息。
当事件过程已被注册时，passThrough参数是提供给PQregisterEventProc的指针。
如果成功，该函数应该返回非零值，失败则返回零。
在任何一个PGconn中，一个特定事件过程只能被注册一次。这是因为该过程的地址被用作查找键来标识相关的实例数据。
小心
在Windows上，函数能够有两个不同的地址：一个对DLL之外可见而另一个对DLL之内可见。我们应当小心只有其中之一会被用于libpq的事件过程函数，否则将会产生混淆。编写代码的最简单规则是将所有的事件过程声明为static。如果过程的地址必须对它自己的源代码文件之外可见，提供一个单独的函数来返回该地址。
32.14.3. 事件支持函数 #PQregisterEventProc #
为 libpq 注册一个事件回调过程。
int PQregisterEventProc(PGconn *conn, PGEventProc proc,
const char *name, void *passThrough);
在每一个你想要接收事件的PGconn上必须注册一个事件过程。除了内存之外，没有限制说一个连接上能注册多少个事件过程。如果该函数成功，它会返回一个非零值。如果它失败，则会返回零。
当一个 libpq 事件被触发时，proc参数将被调用。它的内存地址也被用来查找instanceData。name参数被用来在错误消息中引用该事件过程。这个值不能是NULL或一个零长度串。名字串被复制到PGconn中，因此传递进来的东西不需要长期存在。当一个事件发生时，passThrough指针被传递给proc。这个参数可以是NULL。
PQsetInstanceData #
设置连接conn的用于过程proc的instanceData为data。它在成功时返回非零值，失败时返回零（只有proc没有被正确地注册在conn中，才可能会失败）。
int PQsetInstanceData(PGconn *conn, PGEventProc proc, void *data);
PQinstanceData #
返回连接conn的与过程proc相关的instanceData，如果没有则返回NULL。
void *PQinstanceData(const PGconn *conn, PGEventProc proc);
PQresultSetInstanceData #
把结果的instanceData用于proc设置为data。成功返回非零，失败返回零（只有proc没有被正确地注册在结果中，才可能会失败）。
int PQresultSetInstanceData(PGresult *res, PGEventProc proc, void *data);
请注意，data表示的任何存储都不会由PQresultMemorySize考虑，除非使用PQresultAlloc分配。
（这样做是值得推荐的，因为它消除了在销毁结果时显式释放此类存储的需要。）
PQresultInstanceData #
返回结果的instanceData与proc相关，若没有则返回NULL。
void *PQresultInstanceData(const PGresult *res, PGEventProc proc);
32.14.4. 事件示例 #
这里是一个管理与 libpq 连接和结果相关的私有数据的示例框架。
/* required header for libpq events (note: includes libpq-fe.h) */
#include <libpq-events.h>
/* The instanceData */
typedef struct
{
int n;
char *str;
} mydata;
/* PGEventProc */
static int myEventProc(PGEventId evtId, void *evtInfo, void *passThrough);
int
main(void)
{
mydata *data;
PGresult *res;
PGconn *conn =
PQconnectdb("dbname=postgres options=-csearch_path=");
if (PQstatus(conn) != CONNECTION_OK)
{
/* PQerrorMessage's result includes a trailing newline */
fprintf(stderr, "%s", PQerrorMessage(conn));
PQfinish(conn);
return 1;
}
/* called once on any connection that should receive events.
* Sends a PGEVT_REGISTER to myEventProc.
*/
if (!PQregisterEventProc(conn, myEventProc, "mydata_proc", NULL))
{
fprintf(stderr, "Cannot register PGEventProc\n");
PQfinish(conn);
return 1;
}
/* conn instanceData is available */
data = PQinstanceData(conn, myEventProc);
/* Sends a PGEVT_RESULTCREATE to myEventProc */
res = PQexec(conn, "SELECT 1 + 1");
/* result instanceData is available */
data = PQresultInstanceData(res, myEventProc);
/* If PG_COPYRES_EVENTS is used, sends a PGEVT_RESULTCOPY to myEventProc */
res_copy = PQcopyResult(res, PG_COPYRES_TUPLES | PG_COPYRES_EVENTS);
/* result instanceData is available if PG_COPYRES_EVENTS was
* used during the PQcopyResult call.
*/
data = PQresultInstanceData(res_copy, myEventProc);
/* Both clears send a PGEVT_RESULTDESTROY to myEventProc */
PQclear(res);
PQclear(res_copy);
/* Sends a PGEVT_CONNDESTROY to myEventProc */
PQfinish(conn);
return 0;
}
static int
myEventProc(PGEventId evtId, void *evtInfo, void *passThrough)
{
switch (evtId)
{
case PGEVT_REGISTER:
{
PGEventRegister *e = (PGEventRegister *)evtInfo;
mydata *data = get_mydata(e->conn);
/* associate app specific data with connection */
PQsetInstanceData(e->conn, myEventProc, data);
break;
}
case PGEVT_CONNRESET:
{
PGEventConnReset *e = (PGEventConnReset *)evtInfo;
mydata *data = PQinstanceData(e->conn, myEventProc);
if (data)
memset(data, 0, sizeof(mydata));
break;
}
case PGEVT_CONNDESTROY:
{
PGEventConnDestroy *e = (PGEventConnDestroy *)evtInfo;
mydata *data = PQinstanceData(e->conn, myEventProc);
/* free instance data because the conn is being destroyed */
if (data)
free_mydata(data);
break;
}
case PGEVT_RESULTCREATE:
{
PGEventResultCreate *e = (PGEventResultCreate *)evtInfo;
mydata *conn_data = PQinstanceData(e->conn, myEventProc);
mydata *res_data = dup_mydata(conn_data);
/* associate app specific data with result (copy it from conn) */
PQresultSetInstanceData(e->result, myEventProc, res_data);
break;
}
case PGEVT_RESULTCOPY:
{
PGEventResultCopy *e = (PGEventResultCopy *)evtInfo;
mydata *src_data = PQresultInstanceData(e->src, myEventProc);
mydata *dest_data = dup_mydata(src_data);
/* associate app specific data with result (copy it from a result) */
PQresultSetInstanceData(e->dest, myEventProc, dest_data);
break;
}
case PGEVT_RESULTDESTROY:
{
PGEventResultDestroy *e = (PGEventResultDestroy *)evtInfo;
mydata *data = PQresultInstanceData(e->result, myEventProc);
/* free instance data because the result is being destroyed */
if (data)
free_mydata(data);
break;
}
/* unknown event ID, just return true. */
default:
break;
}
return true; /* event processing succeeded */
}
上一页 上一级 下一页32.13. 通知处理 起始页 32.15. 环境变量
