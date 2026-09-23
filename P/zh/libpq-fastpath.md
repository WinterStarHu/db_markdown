# 32.8. 快速路径接口

32.8. 快速路径接口
版本：
纠错本页面
搜索
目录导航
❮
❯
32.8. 快速路径接口 #
PostgreSQL提供一种快速路径接口来向服务器发送简单的函数调用。
提示
这个接口在某种程度上已被废弃，因为我们可以通过创建一个定义该函数调用的预备语句来达到类似更强大的功能。然后，用参数和结果的二进制传输执行该语句，从而取代快速函数调用。
函数PQfn请求通过快速路径接口执行服务器函数。
PGresult *PQfn(PGconn *conn,
int fnid,
int *result_buf,
int *result_len,
int result_is_int,
const PQArgBlock *args,
int nargs);
typedef struct
{
int len;
int isint;
union
{
int *ptr;
int integer;
} u;
} PQArgBlock;
fnid参数是要被执行的函数的 OID。args和nargs定义了要传递给函数的参数；它们必须匹配已声明的函数参数列表。当一个参数结构的isint域为真时，u.integer值被以指定长度（必须是 2 或 4 字节）整数的形式发送给服务器；这时候会发生恰当的字节交换。当isint为假时，*u.ptr中指定数量的字节将不做任何处理被发送出去；这些数据必须是服务器预期的用于该函数参数数据类型的二进制传输的格式（由于历史原因u.ptr被声明为类型int *，其实把它考虑成void *会更好）。result_buf是放置该函数返回值的缓冲区。调用者必须已经分配了足够的空间来存储返回值（这里没有检查！）。实际的结果长度将被放在result_len指向的整数中返回。如果预期结果是 2 或 4 字节整数，把result_is_int设为 1；否则设为 0。把result_is_int设为 1 导致libpq在必要时对值进行交换字节，这样它就作为对客户端机器正确的int值被传输，注意对任一种允许的结果大小都会传递一个 4 字节到*result_buf。当result_is_int是 0 时，服务器发送的二进制格式字节将不做修改直接返回（在这种情况下，把result_buf考虑为类型void *更好）。
PQfn总是返回一个有效的PGresult指针，包括状态PGRES_COMMAND_OK表示成功或者PGRES_FATAL_ERROR在出现问题时。
在使用结果之前应该检查结果状态。
当结果不再使用时，调用者有义务使用PQclear释放PGresult。
要传递NULL参数到函数，将参数结构的len字段设置为-1；isint和u字段就不相关了。
如果函数返回NULL，*result_len被设置为-1，并且*result_buf不修改。
注意在使用此接口时，无法处理集合值结果。
此外，函数必须是一个普通函数，而不是聚合、窗口函数或过程。
上一页 上一级 下一页32.7. 取消进行中的查询 起始页 32.9. 异步通知
