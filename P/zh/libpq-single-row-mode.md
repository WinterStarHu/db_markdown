# 32.6. 分块检索查询结果

32.6. 分块检索查询结果
版本：
纠错本页面
搜索
目录导航
❮
❯
32.6. 分块检索查询结果 #
通常，libpq 会收集一个 SQL 命令的整个结果并将其作为单个
PGresult 返回给应用程序。对于返回大量行的命令，这种方式可能
不适用。对于这种情况，应用程序可以使用 PQsendQuery 和
PQgetResult 以 单行模式 或
分块模式。在这些模式下，结果行会随着从服务器接收的顺序逐条返回给
应用程序，单行模式为一行一行返回，分块模式则是成组返回。
要进入这些模式之一，请在成功调用 PQsendQuery
（或其兄弟函数）后立即调用 PQsetSingleRowMode
或 PQsetChunkedRowsMode。此模式选择仅对当前执行的查询
有效。然后重复调用 PQgetResult，直到其返回 null，
如 第 32.4 节 中所述。如果查询返回任何行，它们将作为一个或多个
PGresult 对象返回，这些对象看起来像普通查询结果，
但单行模式的状态码为 PGRES_SINGLE_TUPLE，分块模式的状态码为
PGRES_TUPLES_CHUNK，而不是 PGRES_TUPLES_OK。
每个 PGRES_SINGLE_TUPLE 对象中恰好有一行结果，而
PGRES_TUPLES_CHUNK 对象包含至少一行，但不超过每块指定的行数。
在最后一行之后，或者如果查询返回零行，则返回一个状态为
PGRES_TUPLES_OK 的零行对象；这是没有更多行将到达的信号。
（但请注意，仍然需要继续调用 PQgetResult，直到其返回 null。）
所有这些 PGresult 对象将包含相同的行描述数据（列名、类型等），
就像查询的普通 PGresult 对象一样。每个对象应像往常一样使用
PQclear 释放。
使用流水线模式时，需要为流水线中的每个查询激活单行或分块模式，
然后才能使用PQgetResult检索该查询的结果。
详情请参见第 32.5 节。
PQsetSingleRowMode #
为当前正在执行的查询选择单行模式。
int PQsetSingleRowMode(PGconn *conn);
该函数只能在紧接着调用
PQsendQuery或其同级函数之后调用，
并且在对连接进行其他操作之前，如
PQconsumeInput
或
PQgetResult。如果在正确的时间调用，
该函数会激活当前查询的单行模式并返回1。否则模式保持不变，
函数返回0。无论如何，当前查询完成后，模式会恢复为正常。
PQsetChunkedRowsMode #
为当前正在执行的查询选择分块模式。
int PQsetChunkedRowsMode(PGconn *conn, int chunkSize);
该函数类似于
PQsetSingleRowMode，但它指定每个
PGresult最多检索
chunkSize行，而不一定只有一行。
该函数只能在紧接着调用
PQsendQuery或其同级函数之后调用，
并且在对连接进行其他操作之前，如
PQconsumeInput
或
PQgetResult。如果在正确的时间调用，
该函数会激活当前查询的分块模式并返回1。否则模式保持不变，
函数返回0。无论如何，当前查询完成后，模式会恢复为正常。
小心
在处理查询时，服务器可能会返回一些行，然后遇到错误，导致查询中止。通常，
libpq会丢弃这些行，只报告错误。但在单行或分块模式下，
可能已经有一些行被返回给应用程序。因此，应用程序将看到一些
PGRES_SINGLE_TUPLE或PGRES_TUPLES_CHUNK
PGresult对象，随后是一个PGRES_FATAL_ERROR对象。
为了保证正确的事务行为，应用程序必须设计成在查询最终失败时丢弃或撤销之前处理过的行。
上一页 上一级 下一页32.5. 管道模式 起始页 32.7. 取消进行中的查询
