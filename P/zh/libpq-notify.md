# 32.9. 异步通知

32.9. 异步通知
版本：
纠错本页面
搜索
目录导航
❮
❯
32.9. 异步通知 #
PostgreSQL通过LISTEN和NOTIFY命令提供了异步通知。一个客户端会话用LISTEN命令在一个特定的通知频道中注册它感兴趣的通知（也可以用UNLISTEN命令停止监听）。当任何会话执行一个带有特定频道名的NOTIFY命令时，所有正在监听该频道的会话会被异步通知。可以传递一个“载荷”字符串来与监听者沟通附加的数据。
libpq应用把LISTEN、UNLISTEN和NOTIFY命令作为普通的SQL命令提交。
随后通过调用PQnotifies.来检测NOTIFY消息的到达。
函数PQnotifies从来自服务器的未处理通知消息列表中返回下一个通知。如果没有待处理的通知则返回一个空指针。一旦PQnotifies返回一个通知，该通知会被认为已处理并且将被从通知列表中删除。
PGnotify *PQnotifies(PGconn *conn);
typedef struct pgNotify
{
char *relname;              /* notification channel name */
int  be_pid;                /* process ID of notifying server process */
char *extra;                /* notification payload string */
} PGnotify;
在处理完PQnotifies返回的PGnotify对象后，别忘了用PQfreemem把它释放。
释放PGnotify指针就足够了；relname和extra字段并不代表独立分配的内存（这些字段的名称是历史性的，尤其是频道名称与关系名称没有什么联系）。
例 32.2给出了一个示例程序，展示异步通知的使用。
PQnotifies实际上并不从服务器读取数据；它只是返回被另一个libpq函数之前吸收的消息。
在以前的libpq版本中，及时收到NOTIFY消息的唯一方法是持续地提交命令，即使是空命令也可以，并且在每次PQexec后检查PQnotifies。
虽然这个方法还能用，但是由于太过浪费处理能力已被废弃。
当你没有可用的命令提交时，一种更好的检查NOTIFY消息的方法是调用PQconsumeInput
，然后检查PQnotifies。
你可以使用select()来等待服务器数据到达，这样在无事可做时可以不浪费CPU能力（参考PQsocket来获得用于select()的文件描述符）。
注意不管是用PQsendQuery/PQgetResult提交命令还是简单地使用PQexec，这种方法都能正常工作。
不过，你应该记住在每次PQgetResult或PQexec之后检查PQnotifies，看看在命令的处理过程中是否有通知到达。
上一页 上一级 下一页32.8. 快速路径接口 起始页 32.10. COPY命令相关的函数
