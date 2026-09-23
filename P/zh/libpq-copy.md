# 32.10. COPY命令相关的函数

32.10. COPY命令相关的函数
版本：
纠错本页面
搜索
目录导航
❮
❯
32.10. COPY命令相关的函数 #32.10.1. 用于发送COPY数据的函数32.10.2. 用于接收COPY数据的函数32.10.3. 用于COPY的废弃函数
PostgreSQL中的COPY命令有用于libpq的对网络连接读出或者写入的选项。这一节描述的函数允许应用通过提供或者消耗已拷贝的数据来充分利用这个功能。
整个处理是应用首先通过PQexec或者一个等效的函数发出SQL COPY命令。
对这个命令的响应（如果命令无误）将是一个状态代码是PGRES_COPY_OUT或者PGRES_COPY_IN（取决于指定的拷贝方向）的PGresult对象。
应用然后就应该使用这一节的函数接收或者传送数据行。在数据传输结束之后，另外一个PGresult对象会被返回以表明传输的成功或者失败。
它的状态将是：PGRES_COMMAND_OK表示成功，PGRES_FATAL_ERROR表示发生了一些问题。
此时我们可以通过PQexec发出进一步的SQL命令（在COPY操作的处理过程中，不能用同一个连接执行其他SQL命令）。
如果一个COPY命令是通过PQexec在一个可能包含额外命令的字符串中发出的，那么应用在完成COPY序列之后必须继续用PQgetResult获取结果。
只有在PQgetResult返回NULL时，我们才能确信PQexec的命令字符串已经处理完毕，并且可以安全地发出更多命令。
这一节的函数应该只在从PQexec或PQgetResult获得了PGRES_COPY_OUT或PGRES_COPY_IN结果状态后执行。
一个PGresult对象具有这些状态值之一，携带有关COPY操作开始的一些附加数据。
可以使用与查询结果相关的函数来获取这些附加数据：
PQnfields #
返回要复制的列（字段）的数量。
PQbinaryTuples #
0表示整体复制格式为文本（行由换行符分隔，列由分隔符分隔等）。1表示整体复制格式为二进制。
有关更多信息，请参见COPY。
PQfformat #
返回与复制操作的每列关联的格式代码（0表示文本，1表示二进制）。
当整体复制格式为文本时，每列的格式代码始终为零，但二进制格式可以支持文本和二进制列。
（但是，截至当前COPY的实现，只有二进制列出现在二进制复制中；
因此，每列格式目前始终与整体格式匹配。）
32.10.1. 用于发送COPY数据的函数 #
这些函数用于在COPY FROM STDIN期间发送数据。如果在连接不是COPY_IN状态时调用它们，会失败。
PQputCopyData #
在COPY_IN状态中向服务器发送数据。
int PQputCopyData(PGconn *conn,
const char *buffer,
int nbytes);
传输指定buffer中长度为nbytes的COPY数据到服务器。
如果数据被放在队列中，结果是1；如果因为缓冲区满而无法被放在队列中（只可能发生在连接是非阻塞模式时），那么结果是零；如果发生错误，结果为-1（如果返回值为-1，那么使用
PQerrorMessage
检索细节。如果值是零，那么等待写准备好然后重试）。
应用可以把COPY数据流划分成任意方便的大小放到缓冲区中。在发送时，缓冲区载荷的边界没有什么语义。数据流的内容必须匹配COPY命令预期的数据格式；详见COPY。
PQputCopyEnd #
在COPY_IN状态中向服务器发送数据结束的指示。
int PQputCopyEnd(PGconn *conn,
const char *errormsg);
如果errormsg是NULL，则成功结束COPY_IN操作。如果errormsg不是NULL则COPY被强制失败，errormsg指向的字符串是错误消息。（不过，我们不应假定这个准确的错误信息将会从服务器传回，因为服务器可能已经因为其自身原因导致COPY失败。）
如果终止消息被发送，则结果为 1；在非阻塞模式中，结果为 1 也可能只表示终止消息被成功地放在了发送队列中（在非阻塞模式中，要确认数据确实被发送出去，你应该接着等待写准备好并且调用PQflush，重复这些直到返回零）。零表示该函数由于缓冲区满而无法将该终止消息放在队列中，这只会发生在非阻塞模式中（在这种情况下，等待写准备好并且再次尝试PQputCopyEnd调用）。如果发生系统错误，则返回 -1，可以使用
PQerrorMessage
检索详情。
在成功调用PQputCopyEnd之后，调用PQgetResult获取COPY命令的最终结果状态。我们可以用平常的方法来等待这个结果可用。然后返回到正常的操作。
32.10.2. 用于接收COPY数据的函数 #
这些函数用于在COPY TO STDOUT的过程中接收数据。如果连接不在COPY_OUT状态，那么调用它们将会失败。
PQgetCopyData #
在COPY_OUT状态下从服务器接收数据。
int PQgetCopyData(PGconn *conn,
char **buffer,
int async);
在一个COPY期间尝试从服务器获取另外一行数据。数据总是以每次一个数据行的方式被返回；如果只有一个部分行可用，那么它不会被返回。
成功返回一个数据行涉及到分配一块内存来保存该数据。buffer参数必须为非NULL。
*buffer被设置为指向分配到的内存的指针，或者是在没有返回缓冲区的情况下指向NULL。
一个非NULL的结果缓冲区在不需要时必须用PQfreemem释放。
在成功返回一行之后，返回的值就是该数据行里数据的字节数（将是大于零）。
被返回的字符串总是空终止的，虽然这可能只是对文本COPY有用。
一个零结果表示该COPY仍然在处理中，但是还没有可用的行（只在async为真时才可能）。
一个 -1 结果表示COPY已经完成。-2 结果表示发生了错误（参考
PQerrorMessage
获取原因）。
当async为真时（非零），PQgetCopyData将不会阻塞等待输入；
如果COPY仍在处理过程中并且没有可用的完整行，那么它将返回零
（在这种情况下等待读准备好，然后在再次调用PQgetCopyData之前，调用PQconsumeInput
）。
当async为假（零）时，PQgetCopyData将阻塞，直到数据可用或者操作完成。
在PQgetCopyData返回 -1 之后，调用PQgetResult获取COPY命令的最后结果状态。
我们可以用平常的方法来等待这个结果可用。然后返回到正常的操作。
32.10.3. 用于COPY的废弃函数 #
这些函数代表了以前的处理COPY的方法。尽管它们还能用，但是现在已经被废弃，因为它们的错误处理很糟糕、检测结束数据的方法也不方便，并且缺少对二进制或非阻塞传输的支持。
PQgetline #
读取一个以新行终止的字符行（由服务器传输）到一个长度为length的字符串缓冲区。
int PQgetline(PGconn *conn,
char *buffer,
int length);
这个函数拷贝最多length-1个字符到该缓冲区中，并且把终止的新行转换成一个零字节。
PQgetline在输入结束时返回EOF，如果整行都被读取则返回0，如果缓冲区填满了而还没有遇到结束的新行则返回1。
注意，应用必须检查是否一个新行包含两个字符\.，这表明服务器已经完成了COPY命令的结果发送。如果应用可能收到超过length-1字符长的行，我们就应该确保正确识别\.行（例如，不要把一个长数据行的结束当作一个终止行）。
PQgetlineAsync #
不阻塞地读取一行COPY数据（由服务器传输）到一个缓冲区中。
int PQgetlineAsync(PGconn *conn,
char *buffer,
int bufsize);
这个函数类似于PQgetline，但是可以被用于那些必须异步读取COPY数据的应用，也就是不阻塞的应用。
在发出了COPY命令并得到了PGRES_COPY_OUT响应之后，
应用应该调用PQconsumeInput
和PQgetlineAsync直到检测到结束数据的信号。
不像PQgetline，这个函数负责检测结束数据。
在每次调用时，如果libpq的输入缓冲区中有一个完整的数据行可用，PQgetlineAsync都将返回数据。
否则，在剩余行到达之前不会返回数据。如果识别到拷贝数据结束的标志，此函数返回 -1；如果没有可用数据则返回 0；
或者是给出一个正数表示被返回的字节数。如果返回 -1，调用者下一步必须调用PQendcopy，然后回到正常处理。
返回的数据将不超过一个数据行的范围。如果可能，每次将返回一个完整行。但如果调用者提供的缓冲区太小不足以容下服务器发送的行，那么将返回部分行。对于文本数据，这可以通过测试返回的最后一个字节是否\n来检测（在二进制COPY中， 需要对COPY数据格式进行实际的分析，以便做相同的判断）。返回的字符串不是空结尾的（如果你想增加一个终止空，确保传递一个比实际可用空间少一字节的bufsize）。
PQputline #
向服务器发送一个空终止的字符串。如果 OK 则返回 0；如果不能发送字符串则返回EOF。
int PQputline(PGconn *conn,
const char *string);
一系列PQputline调用发送的COPY数据流和PQgetlineAsync返回的数据具有相同的格式，
只是应用不需要每次PQputline调用中发送刚好一个数据行；在每次调用中发送多行或者部分行都是可以的。
注意
在 PostgreSQL 协议 3.0 之前，应用程序必须显式发送两个字符
\. 作为最后一行，以指示服务器它已完成发送 COPY 数据。虽然这仍然有效，但已被弃用，\. 的特殊含义预计将在未来的版本中被移除。（在 CSV 模式下，它已经会出现异常行为。）在发送实际数据后，调用 PQendcopy 就可以。
PQputnbytes #
向服务器发送一个非空终止的字符串。如果 OK 则返回 0，如果不能发送字符串则返回EOF。
int PQputnbytes(PGconn *conn,
const char *buffer,
int nbytes);
这个函数类似PQputline，除了数据缓冲区不需要是空终止，因为要发送的字节数是直接指定的。在发送二进制数据时使用这个函数。
PQendcopy #
与服务器同步。
int PQendcopy(PGconn *conn);
这个函数等待服务器完成拷贝。当最后一个字符串已经用PQputline发送给服务器时或者当最后一个字符串已经用PQgetline从服务器接收到时，就会发出这个函数。
这个函数必须被发出，否则服务器将会和客户端“不同步”。从这个函数返回后，服务器就已经准备好接收下一个 SQL 命令了。函数成功完成时返回值为 0，否则返回非零值（如果返回值为非零值，用
PQerrorMessage
检索详情）。
在使用PQgetResult时，应用应该通过反复调用PQgetline并且在看到终止行后调用PQendcopy来响应PGRES_COPY_OUT结果。
然后它应该返回到PQgetResult循环直到PQgetResult返回一个空指针。
类似地，PGRES_COPY_IN结果会用一系列PQputline加上之后的PQendcopy来处理，然后返回到PQgetResult循环。
这样的安排将保证嵌入到一系列SQL命令中的COPY命令将被正确执行。
旧的应用很可能会通过PQexec提交一个COPY命令并且假定事务在PQendcopy之后完成。
只有在COPY是命令字符串中唯一的SQL命令时才能正确工作。
上一页 上一级 下一页32.9. 异步通知 起始页 32.11. 控制函数
