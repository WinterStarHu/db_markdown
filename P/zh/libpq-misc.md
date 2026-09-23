# 32.12. 杂项函数

32.12. 杂项函数
版本：
纠错本页面
搜索
目录导航
❮
❯
32.12. 杂项函数 #
一如往常，总有一些函数不适合放在任何地方。
PQfreemem #
释放libpq分配的内存。
void PQfreemem(void *ptr);
释放libpq分配的内存，尤其是PQescapeByteaConn,
PQescapeBytea,
PQunescapeBytea,
和PQnotifies分配的内存。
特别重要的是，在微软 Windows 上使用这个函数，而不是free()。
这是因为只有在 DLL 和应用的多线程/单线程、发布/调试以及静态/动态
标志相同时，才能在一个 DLL 中分配内存并在应用中释放它。
在非微软 Windows 平台上，这个函数与标准库函数free()相同。
PQconninfoFree #
释放由PQconndefaults或
PQconninfoParse分配的数据结构。
void PQconninfoFree(PQconninfoOption *connOptions);
如果参数是NULL指针，则不执行任何操作。
一个简单的PQfreemem不会满足这个要求，因为数组包含对子字符串的引用。
PQencryptPasswordConn #
准备一个PostgreSQL密码的加密形式。
char *PQencryptPasswordConn(PGconn *conn, const char *passwd, const char *user, const char *algorithm);
这个函数旨在用于那些希望发送类似于ALTER USER joe PASSWORD
'pwd'命令的客户端应用。不在这样一个命令中发送原始的明文密码是一个好习惯，因为它可能被暴露在命令日志、活动显示等等中。相反，在发送之前使用这个函数可以将密码转换为加密的形式。
passwd和user参数是明文密码以及用户的SQL名称。
algorithm指定用来加密密码的加密算法。
当前支持的算法是md5和scram-sha-256（on和off也被接受作为md5的别名，用于与较老的服务器版本兼容）。
注意，对scram-sha-256的支持是在PostgreSQL版本10中引入的，并且在老的服务器版本上无法工作。
如果algorithm是NULL，这个函数将向服务器查询password_encryption设置的当前值。
这种行为可能会阻塞当前事务，并且当前事务被中止或者连接正忙于执行另一个查询时会失败。
如果希望为服务器使用默认的算法但避免阻塞，应在调用PQencryptPasswordConn之前查询你自己的password_encryption，并且将该值作为algorithm传入。
返回值是一个由malloc分配的字符串。调用者可以假设该字符串不含有需要转义的任何特殊字符。
在处理完它之后，用PQfreemem释放结果。发生错误时，返回的是NULL，并且适当的消息会被存储在连接对象中。
PQchangePassword #
更改PostgreSQL密码。
PGresult *PQchangePassword(PGconn *conn, const char *user, const char *passwd);
该函数使用PQencryptPasswordConn
来构建并执行命令ALTER USER ... PASSWORD
'...'，从而更改用户的密码。它存在的原因与
PQencryptPasswordConn相同，但更方便，
因为它既构建又执行该命令。
PQencryptPasswordConn的算法参数传入
NULL，因此加密是根据服务器的
password_encryption设置进行的。
其中user和passwd参数分别是目标用户的SQL名称，
以及新的明文密码。
返回一个PGresult指针，代表
ALTER USER命令的结果，或者如果例程在发出任何命令之前失败，则返回空指针。
应调用PQresultStatus函数检查返回值是否有错误（包括空指针的值，
在这种情况下它将返回PGRES_FATAL_ERROR）。使用
PQerrorMessage
获取有关此类错误的更多信息。
PQencryptPassword #
准备一个PostgreSQL口令的md5加密形式。
char *PQencryptPassword(const char *passwd, const char *user);
PQencryptPassword是PQencryptPasswordConn的一个较老的已废弃版本。其差别是PQencryptPassword不要求一个连接对象，并且总是用md5作为加密算法。
PQmakeEmptyPGresult #
用给定的状态，构造一个空PGresult对象。
PGresult *PQmakeEmptyPGresult(PGconn *conn, ExecStatusType status);
这是libpq内部用于分配并初始化一个空PGresult对象的函数。
如果不能分配内存，那么这个函数返回NULL。
它也是可以对外使用的，因为一些应用认为它可以用于产生结果对象（特别是带有错误状态的对象）本身。
如果conn非空，并且status表示一个错误，那么指定连接的当前错误消息会被复制到PGresult中。
如果conn非空，那么连接中的任何已注册事件过程也会被复制到PGresult中（它们不会获得PGEVT_RESULTCREATE调用，但会看到PQfireResultCreateEvents）。
注意在该对象上最终应该调用PQclear，正如对libpq本身返回的PGresult对象所作的那样。
PQfireResultCreateEvents #
为每一个在PGresult对象中注册的事件过程触发一个PGEVT_RESULTCREATE事件（见第 32.14 节）。成功时返回非零，如果任何事件过程失败则返回零。
int PQfireResultCreateEvents(PGconn *conn, PGresult *res);
conn参数被传送给事件过程，但不会被直接使用。如果事件过程不使用它，则可以为NULL。
已经接收到这个对象的PGEVT_RESULTCREATE或PGEVT_RESULTCOPY事件的事件过程不会被再次触发。
这个函数与PQmakeEmptyPGresult分开的主要原因是在调用事件过程之前创建一个PGresult并填充它常常是合适的。
PQcopyResult #
为一个PGresult对象创建一个拷贝。这个拷贝不会以任何方式链接到源结果，并且当该拷贝不再需要时，必须调用PQclear进行清理。如果函数失败，返回NULL。
PGresult *PQcopyResult(const PGresult *src, int flags);
这不是为了制作一个精确的副本。返回的结果总是放在PGRES_TUPLES_OK状态中，并且不复制源中的任何错误消息。（但是会复制命令状态字符串。）flags参数确定要复制的其他内容。它是几个标志的按位或。PG_COPYRES_ATTRS指定复制源结果的属性（列定义）。PG_COPYRES_TUPLES指定复制源结果的元组。（这也意味着复制属性。）PG_COPYRES_NOTICEHOOKS指定复制源结果的通知钩子。PG_COPYRES_EVENTS指定复制源结果的事件。（但不复制与源相关的任何实例数据。）事件程序接收PGEVT_RESULTCOPY事件。
PQsetResultAttrs #
设置PGresult对象的属性。
int PQsetResultAttrs(PGresult *res, int numAttributes, PGresAttDesc *attDescs);
提供的attDescs被复制到结果中。如果attDescs指针为NULL或numAttributes小于1，那么请求将被忽略并且函数成功。如果res已经包含属性，那么函数会失败。如果函数失败，返回值是0。如果函数成功，返回值是非0。
PQsetvalue #
设置一个PGresult对象的元组字段值。
int PQsetvalue(PGresult *res, int tup_num, int field_num, char *value, int len);
这个函数将自动按需增加结果的内置元组数组。但是，tup_num参数必须小于等于PQntuples，意味着这个函数对元组数组一次只能增加一个元组。但已存在的任意元组中的任意字段可以以任意顺序进行修改。如果field_num的一个值已经存在，它会被覆盖。如果len是-1，或value是NULL，该字段值会被设置为一个SQL空值。value会被复制到结果的私有存储中，因此函数返回后就不再需要了。如果函数失败，返回值是0。如果函数成功，返回值是非0。
PQresultAlloc #
为一个PGresult对象分配附属存储。
void *PQresultAlloc(PGresult *res, size_t nBytes);
当res被清除时，这个函数分配的内存也会被释放。如果函数失败，返回值是NULL。结果被保证为按照数据的任意类型充分地对齐，正如malloc所作的。
PQresultMemorySize #
检索为PGresult对象分配的字节数。
size_t PQresultMemorySize(const PGresult *res);
此值是与malloc请求相关的所有内存的总和，关联对象为
PGresult，即所有将由PQclear
释放的内存。此信息对于管理内存消耗非常有用。
PQlibVersion #
返回正在使用的 libpq 的版本。
int PQlibVersion(void);
在运行时，这个函数的结果可以用来判断在当前已加载的 libpq 版本中特定的功能是否可用。
例如，这个函数可以用来判断哪些连接选项可以用于PQconnectdb。
结果通过将库的主版本号乘以10000再加上次版本号形成。例如，版本10.1将返回100001，而版本11.0将返回110000。
在主版本10之前，PostgreSQL采用一种由三个部分组成的版本号，其中前两部分共同表示主版本。
对于那些版本，PQlibVersion为每个部分使用两个数字，例如版本9.1.5将返回90105，而版本9.2.0将返回90200。
因此，出于判断特性兼容性的目的，应用应该将PQlibVersion的结果除以100而不是10000来判断逻辑的主版本号。
在所有的发行系列中，只有最后两个数字在次版本（问题修正版本）之间不同。
注意
这个函数出现于PostgreSQL版本 9.1，因此它不能被用来在早期的版本中检测所需的功能，因为调用它将会创建一个对版本9.1或更高版本的链接依赖。
PQgetCurrentTimeUSec #
获取当前时间，以自Unix纪元以来的微秒数表示（即，time_t乘以一百万）。
pg_usec_time_t PQgetCurrentTimeUSec(void);
这主要用于计算与PQsocketPoll一起使用的超时值。
上一页 上一级 下一页32.11. 控制函数 起始页 32.13. 通知处理
