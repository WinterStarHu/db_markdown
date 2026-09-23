# 32.13. 通知处理

32.13. 通知处理
版本：
纠错本页面
搜索
目录导航
❮
❯
32.13. 通知处理 #
服务器产生的通知和警告消息不会被查询执行函数返回，因为它们不代表查询失败。它们被传递给一个通知处理函数，并且在处理者返回后执行会继续正常进行。默认的处理函数会把消息打印在stderr上，但是应用可以通过提供它自己的处理函数来重载这种行为。
由于历史原因，通知处理有两个级别，称为通知接收器和通知处理器。通知接收器的默认行为是格式化通知并将一个字符串传递给通知处理器来打印。不过，如果一个应用选择提供自己的通知接收器，它通常会忽略通知处理器层并在通知接收器中完成所有工作。
函数PQsetNoticeReceiver
为一个连接对象设置或检查当前的通知接收器。
相似地，PQsetNoticeProcessor
设置或检查当前的通知处理器。
typedef void (*PQnoticeReceiver) (void *arg, const PGresult *res);
PQnoticeReceiver
PQsetNoticeReceiver(PGconn *conn,
PQnoticeReceiver proc,
void *arg);
typedef void (*PQnoticeProcessor) (void *arg, const char *message);
PQnoticeProcessor
PQsetNoticeProcessor(PGconn *conn,
PQnoticeProcessor proc,
void *arg);
这些函数中的每一个会返回之前的通知接收器或处理器函数指针，并设置新值。如果你提供了一个空函数指针，将不会采取任何动作，只会返回当前指针。
当接收到一个服务器产生的或者libpq内部产生的通知或警告消息，通知接收器函数会被调用。
它会以一种PGRES_NONFATAL_ERROR PGresult的形式传递该消息
（这允许接收器使用PQresultErrorField抽取个别的域，或者使用PQresultErrorMessage或者PQresultVerboseErrorMessage得到一个完整的预格式化的消息）。
被传递给PQsetNoticeReceiver的同一个空指针也被传递（必要时，这个指针可以用来访问应用相关的状态）。
默认的通知接收器会简单地抽取消息（使用PQresultErrorMessage）并将它传递给通知处理器。
通知处理器负责处理一个以文本形式给出的通知或警告消息。该消息的字符串文本（包括一个结尾的新行）被传递给通知处理器，外加一个同时被传递给PQsetNoticeProcessor的空指针（必要时，这个指针可以用来访问应用相关的状态）。
默认的通知处理器很简单：
static void
defaultNoticeProcessor(void *arg, const char *message)
{
fprintf(stderr, "%s", message);
}
一旦你设定了一个通知接收器或处理器，你应该期待只要PGconn对象或者从它构造出的PGresult对象存在，该函数就应该能被调用。
在一个PGresult创建时，PGconn的当前通知处理指针被复制到PGresult中，以备类似PQgetvalue的函数使用。
上一页 上一级 下一页32.12. 杂项函数 起始页 32.14. 事件系统
