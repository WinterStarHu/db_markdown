# 33.3. 客户端接口

33.3. 客户端接口
版本：
纠错本页面
搜索
目录导航
❮
❯
33.3. 客户端接口 #33.3.1. 创建大型对象33.3.2. 导入大型对象33.3.3. 导出大型对象33.3.4. 打开一个现有的大型对象33.3.5. 向大对象写入数据33.3.6. 从大对象读取数据33.3.7. 在大对象中查找33.3.8. 获取大对象的查找位置33.3.9. 截断大对象33.3.10. 关闭大对象描述符33.3.11. 移除大对象
本节描述PostgreSQL的libpq客户端接口为访问大对象所提供的功能。PostgreSQL的大对象接口按照Unix文件系统的接口建模，也有相似的open、read、write、lseek等。
所有使用这些函数的大对象操作必须在SQL事务块内进行，
因为大对象文件描述符仅在事务期间有效。写操作，包括
lo_open使用INV_WRITE模式，
在只读事务中是不允许的。
在执行任何一个这种函数期间如果发生错误，该函数将会返回一个其他的不可能值，典型的是0或-1。
一个关于该错误的消息也会被保存在连接对象中，可以通过
PQerrorMessage
检索到。
使用这些函数的客户端应用应该包括头文件libpq/libpq-fs.h并链接libpq库。
当libpq连接处于管道模式时，客户端应用程序不能使用这些函数。
33.3.1. 创建大型对象 #
函数
Oid lo_create(PGconn *conn, Oid lobjId);
创建一个新的大型对象。要分配的OID可以由lobjId指定；
如果是这样，如果该OID已经用于某个大型对象，则会失败。如果lobjId
是InvalidOid（零），那么lo_create会分配一个未使用的OID。
返回值是分配给新大型对象的OID，或者在失败时为InvalidOid（零）。
一个例子：
inv_oid = lo_create(conn, desired_oid);
旧函数
Oid lo_creat(PGconn *conn, int mode);
也创建一个新的大型对象，总是分配一个未使用的OID。
返回值是分配给新大型对象的OID，或在失败时为InvalidOid（零）。
在PostgreSQL的8.1版本及以后的发布中，
mode参数被忽略，
因此lo_creat与带有零秒参数的lo_create完全等效。
然而，除非您需要与早于8.1版本的服务器一起工作，否则几乎没有理由使用lo_creat。
要与这样一个旧服务器一起工作，您必须使用lo_creat而不是lo_create，
并且必须将mode设置为INV_READ、INV_WRITE，
或INV_READ|INV_WRITE中的一个。
(这些符号常量在头文件libpq/libpq-fs.h中定义。)
一个例子：
inv_oid = lo_creat(conn, INV_READ|INV_WRITE);
33.3.2. 导入大型对象 #
要将一个操作系统文件导入成一个大型对象，调用：
Oid lo_import(PGconn *conn, const char *filename);
filename指定了要导入为大型对象的操作系统文件名。返回值是分配给新大型对象的OID或InvalidOid（0）表示发生错误。注意该文件是被客户端接口库而不是服务器所读取，因此它必须存在于客户端文件系统中并且对于客户端应用是可读的。
函数
Oid lo_import_with_oid(PGconn *conn, const char *filename, Oid lobjId);
也可以导入一个新大型对象。分配给新大型对象的OID可以用lobjId指定，如果这样做，该OID已经被某个大型对象使用时会产生错误。如果lobjId是InvalidOid（0），则lo_import_with_oid会分配一个未使用的OID（这和lo_import的行为相同）。返回值是分配给新大型对象的OID或InvalidOid（0）表示发生错误。
lo_import_with_oid在PostgreSQL 8.4中是新的，并且在内部使用了lo_create（在8.1中也是新的）；如果该函数在8.0或更早版本上运行，它将失败并返回InvalidOid。
33.3.3. 导出大型对象 #
要把一个大型对象导出到一个操作系统文件，调用：
int lo_export(PGconn *conn, Oid lobjId, const char *filename);
lobjId参数指定要导出的大型对象的OID，filename参数指定操作系统文件名。注意该文件是被客户端接口库而不是服务器写入。成功返回1，错误返回-1。
33.3.4. 打开一个现有的大型对象 #
要打开一个现有的大对象进行读写，调用：
int lo_open(PGconn *conn, Oid lobjId, int mode);
lobjId参数指定要打开的大对象的OID。mode位控制着打开对象是为了只读（INV_READ）、只写（INV_WRITE）或者读写（这些符号常量定义在头文件libpq/libpq-fs.h中）。lo_open返回一个（非负）大对象描述符以便后面用于lo_read、lo_write、lo_lseek、lo_lseek64、lo_tell、lo_tell64、lo_truncate、lo_truncate64以及lo_close。该描述符只在当前事务期间有效。如果打开错误将会返回-1。
服务器目前并不区分模式INV_WRITE和INV_READ |INV_WRITE：在两种情况中都允许从描述符读取。但是在这些模式和单独的INV_READ之间有明显的区别：使用INV_READ我们不能向描述符写入，从中读取的数据则反映了该大对象在活动事务快照时刻的内容（该快照在lo_open被执行时创建），而不管之后被该事务或其他事务写入的内容。从一个以INV_WRITE模式打开的描述符读取的数据反映了所有其他已提交事务以及当前事务所作的写入。这与普通SQL命令 SELECT的REPEATABLE READ和READ COMMITTED事务模式之间的区别相似。
如果大对象的SELECT特权不可用，或者如果在指定了INV_WRITE时UPDATE特权不可用，则lo_open将会失败（在PostgreSQL 11之前，这些特权的检查是在使用该描述符的第一次实际读取或写入时进行）。这些特权检查可以用lo_compat_privileges运行时参数禁用。
一个例子：
inv_fd = lo_open(conn, inv_oid, INV_READ|INV_WRITE);
33.3.5. 向大对象写入数据 #
函数
int lo_write(PGconn *conn, int fd, const char *buf, size_t len);
从buf（大小必须是 len）中写出len字节到大对象描述符fd。参数fd必须是已经由前面的lo_open返回的大对象描述符。函数将返回实际写入的字节数（在当前的实现中，除非出错，返回的字节数总是等于len）。在出错时，返回值为-1。
尽管参数len被声明为类型size_t，该函数会拒绝超过INT_MAX的长度值。在实际中，被传送的数据最好是每块最多几兆字节。
33.3.6. 从大对象读取数据 #
函数
int lo_read(PGconn *conn, int fd, char *buf, size_t len);
从大对象描述符fd中读取最多len字节到buf （大小必须是len）中。参数fd必须是已经由前面的lo_open返回的大对象描述符。实际读出的字节数将被返回；如果先到达了大对象的末尾，返回值可能会小于len。出错时返回值为-1。
尽管参数len被声明为类型size_t，该函数会拒绝超过INT_MAX的长度值。在实际中，传送的数据最好是每块最多几兆字节。
33.3.7. 在大对象中查找 #
要改变一个大对象描述符的当前读或写位置，调用：
int lo_lseek(PGconn *conn, int fd, int offset, int whence);
该函数将大对象描述符fd的当前位置指针移动到由offset指定的新位置。whence的可用值是SEEK_SET（从对象开头定位）、SEEK_CUR（从当前位置定位）以及SEEK_END（从对象末尾定位）。返回值是新位置的指针，或者是-1表示出错。
处理可能超过2GB大小的大对象时，请改用
int64_t lo_lseek64(PGconn *conn, int fd, int64_t offset, int whence);
此函数的行为与lo_lseek相同，但它可以接受大于2GB的offset值和/或返回大于2GB的结果。
请注意，如果新位置指针大于2GB，lo_lseek将失败。
lo_lseek64是从PostgreSQL 9.3开始增加的新函数。如果该函数在一个旧服务器版本上执行，将会失败并返回-1。
33.3.8. 获取大对象的查找位置 #
要得到一个大对象描述符的当前读或写位置，调用：
int lo_tell(PGconn *conn, int fd);
如果出现错误，返回值是-1。
处理可能超过 2GB 大小的大对象时，请改用
int64_t lo_tell64(PGconn *conn, int fd);
此函数的行为与 lo_tell 相同，但它可以返回大于 2GB 的结果。
请注意，如果当前的读/写位置大于 2GB，lo_tell 将失败。
lo_tell64是从PostgreSQL 9.3开始新增的函数。如果该函数在旧服务器版本上运行，将会失败并返回-1。
33.3.9. 截断大对象 #
要将一个大对象截断成一个给定长度，调用：
int lo_truncate(PGconn *conn, int fd, size_t len);
该函数将大对象描述符fd截断为长度len。参数fd必须是已经由前面的lo_open返回的大对象描述符。如果len超过了大对象的当前长度，大对象将会被使用空字节（'\0'）扩展到指定长度。成功时lo_truncate返回0，失败时返回值为-1。
描述fd的读/写位置不变。
尽管参数len被声明为类型size_t，lo_truncate会拒绝超过INT_MAX的长度值。
处理可能超过 2GB 大小的大对象时，请改用
int lo_truncate64(PGconn *conn, int fd, int64_t len);
此函数的行为与 lo_truncate 相同，但它可以接受超过 2GB 的 len 值。
lo_truncate是从PostgreSQL 8.3开始新增的函数，如果该函数在旧服务器版本上运行，它将失败并返回-1。
lo_truncate64是从PostgreSQL 9.3开始的新函数，如果该函数运行在一个旧服务器版本上，它将失败并返回-1。
33.3.10. 关闭大对象描述符 #
要关闭一个大对象描述符，调用：
int lo_close(PGconn *conn, int fd);
其中fd是由lo_open返回的大对象描述符。成功时，lo_close返回0，失败时返回-1。
在事务末尾仍然保持打开的任何大对象描述符都会自动关闭。
33.3.11. 移除大对象 #
要从数据库中移除一个大对象，调用：
int lo_unlink(PGconn *conn, Oid lobjId);
lobjId参数指定要移除的大对象的OID。成功时返回1，失败时返回-1。
上一页 上一级 下一页33.2. 实现特性 起始页 33.4. 服务器端函数
