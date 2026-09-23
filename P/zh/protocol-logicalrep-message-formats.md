# 54.9. 逻辑复制消息格式

54.9. 逻辑复制消息格式
版本：
纠错本页面
搜索
目录导航
❮
❯
54.9. 逻辑复制消息格式 #
本节描述了每个逻辑复制消息的详细格式。这些消息要么由复制槽SQL接口返回，要么由walsender发送。
对于walsender，它们被封装在复制协议WAL消息中，如第 54.4 节所述，
并且通常遵循与物理复制相同的消息流程。
Begin #Byte1('B')
将消息标识为开始消息。
Int64 (XLogRecPtr)
事务的最终LSN。
Int64 (TimestampTz)
事务的提交时间戳。该值是自PostgreSQL纪元（2000-01-01）以来的微秒数。
Int32 (TransactionId)
事务的Xid。
Message #Byte1('M')
将消息标识为逻辑解码消息。
Int32 (TransactionId)
事务的Xid（仅适用于流式事务）。
该字段自协议版本2起可用。
Int8
标志; 逻辑解码消息是事务性的时为1，非事务性的时为0。
Int64 (XLogRecPtr)
逻辑解码消息的LSN。
String
逻辑解码消息的前缀。
Int32
内容的长度。
Byten
逻辑解码消息的内容。
Commit #Byte1('C')
标识消息为提交消息。
Int8(0)
标志；目前未使用。
Int64 (XLogRecPtr)
提交的LSN。
Int64 (XLogRecPtr)
事务的结束LSN。
Int64 (TimestampTz)
事务的提交时间戳。该值是自PostgreSQL纪元（2000-01-01）以来的微秒数。
Origin #Byte1('O')
将消息标识为源消息。
Int64 (XLogRecPtr)
原始服务器上提交的事务日志序列号（LSN）。
String
原点的名称。
请注意，在单个事务中可能存在多个原点消息。
Relation #Byte1('R')
标识消息为关系消息。
Int32 (TransactionId)
事务的Xid（仅在流式事务中存在）。
该字段自协议版本2起可用。
Int32 (Oid)
关系的OID。
String
命名空间（pg_catalog表示为空字符串）。
String
关系名称。
Int8
关系的复制标识设置（与relreplident在pg_class中相同）。
Int16
列数。
接下来，对于每个包含在出版物中的列，将出现以下消息部分：
Int8
列的标志。目前可以是0表示没有标志，或者是1表示将该列标记为键的一部分。
String
列的名称。
Int32 (Oid)
列数据类型的OID。
Int32
列的类型修饰符 (atttypmod)。
Type #Byte1('Y')
将消息标识为类型消息。
Int32 (TransactionId)
事务的Xid（仅适用于流式事务）。
该字段自协议版本2起可用。
Int32 (Oid)
数据类型的OID。
String
命名空间（pg_catalog为空字符串）。
String
数据类型的名称。
Insert #Byte1('I')
标识消息为插入消息。
Int32 (TransactionId)
事务的Xid（仅适用于流式事务）。
该字段自协议版本2起可用。
Int32 (Oid)
与关系消息中ID对应的关系的OID。
Byte1('N')
标识以下TupleData消息为新元组。
TupleData
TupleData消息部分，表示新元组的内容。
Update #Byte1('U')
标识消息为更新消息。
Int32 (TransactionId)
事务的Xid（仅适用于流式事务）。
该字段自协议版本2起可用。
Int32 (Oid)
与关系消息中ID对应的关系的OID。
Byte1('K')
标识以下TupleData子消息为键。
此字段是可选的，仅在更新更改了属于REPLICA IDENTITY索引的任何列的数据时才存在。
Byte1('O')
标识以下TupleData子消息为旧元组。
此字段是可选的，仅在发生更新的表中REPLICA IDENTITY设置为FULL时才存在。
TupleData
TupleData消息部分表示旧元组或主键的内容。仅在先前的'O'或'K'部分存在时才存在。
Byte1('N')
标识以下TupleData消息为新元组。
TupleData
TupleData消息部分表示新元组的内容。
更新消息可能包含一个'K'消息部分，也可能包含一个'O'消息部分，或者两者都不包含，但绝不会同时包含两者。
Delete #Byte1('D')
标识消息为删除消息。
Int32 (TransactionId)
事务的Xid（仅在流式事务中存在）。
该字段自协议版本2起可用。
Int32 (Oid)
与关系消息中ID对应的关系的OID。
Byte1('K')
标识以下TupleData子消息为键。
如果发生删除操作的表使用索引作为REPLICA IDENTITY，则此字段存在。
Byte1('O')
标识以下TupleData消息为旧元组。
如果发生删除操作的表的REPLICA IDENTITY设置为FULL，则此字段存在。
TupleData
TupleData消息部分，表示旧元组或主键的内容，取决于前一个字段。
删除消息可能包含一个'K'消息部分或一个'O'消息部分，但绝不会同时包含两者。
Truncate #Byte1('T')
将消息标识为截断消息。
Int32 (TransactionId)
事务的Xid（仅适用于流式事务）。
该字段自协议版本2起可用。
Int32
关系数量
Int8
选项位用于TRUNCATE：
1表示CASCADE，2表示RESTART IDENTITY
Int32 (Oid)
与关系消息中ID对应的关系的OID。该字段对每个关系都重复。
以下消息（Stream Start、Stream Stop、Stream Commit和
Stream Abort）自协议版本2起可用。
Stream Start #Byte1('S')
标识消息为流开始消息。
Int32 (TransactionId)
事务的Xid。
Int8
值为1表示这是该XID的第一个流段，值为0表示其他任何流段。
Stream Stop #Byte1('E')
标识消息为流停止消息。
Stream Commit #Byte1('c')
将消息标识为流提交消息。
Int32 (TransactionId)
事务的Xid。
Int8(0)
标志；目前未使用。
Int64 (XLogRecPtr)
提交的LSN。
Int64 (XLogRecPtr)
事务的结束LSN。
Int64 (TimestampTz)
事务的提交时间戳。该值是自PostgreSQL纪元（2000-01-01）以来的微秒数。
Stream Abort #Byte1('A')
将消息标识为流中止消息。
Int32 (TransactionId)
事务的Xid。
Int32 (TransactionId)
子事务的Xid（对于顶层事务，将与事务的xid相同）。
Int64 (XLogRecPtr)
中止操作的 LSN，仅在流式传输设置为并行时存在。
此字段自协议版本 4 起可用。
Int64 (TimestampTz)
事务的中止时间戳，仅在流式传输设置为并行时存在。该值为自 PostgreSQL 纪元（2000-01-01）以来的微秒数。
此字段自协议版本 4 起可用。
以下消息（Begin Prepare，Prepare，Commit Prepared，Rollback Prepared，Stream Prepare）自协议版本3起可用。
Begin Prepare #Byte1('b')
标识消息为准备事务消息的开始。
Int64 (XLogRecPtr)
准备的LSN。
Int64 (XLogRecPtr)
准备事务的结束LSN。
Int64 (TimestampTz)
准备事务的时间戳。该值是自PostgreSQL纪元（2000-01-01）以来的微秒数。
Int32 (TransactionId)
事务的Xid。
String
准备事务的用户定义的GID。
Prepare #Byte1('P')
标识消息为准备好的事务消息。
Int8(0)
标志; 目前未使用。
Int64 (XLogRecPtr)
准备的LSN。
Int64 (XLogRecPtr)
准备事务的结束LSN。
Int64 (TimestampTz)
准备事务的时间戳。该值是自PostgreSQL纪元（2000-01-01）以来的微秒数。
Int32 (TransactionId)
事务的Xid。
String
准备事务的用户定义的GID。
Commit Prepared #Byte1('K')
标识消息为准备事务提交的消息。
Int8(0)
标志；目前未使用。
Int64 (XLogRecPtr)
准备事务提交的LSN。
Int64 (XLogRecPtr)
准备事务提交的结束LSN。
Int64 (TimestampTz)
事务的提交时间戳。该值是自PostgreSQL纪元（2000-01-01）以来的微秒数。
Int32 (TransactionId)
事务的Xid。
String
准备事务的用户定义的GID。
Rollback Prepared #Byte1('r')
标识消息为准备事务回滚的消息。
Int8(0)
标志；目前未使用。
Int64（XLogRecPtr）
准备事务的结束LSN。
Int64（XLogRecPtr）
回滚准备事务的结束LSN。
Int64 (TimestampTz)
准备事务的时间戳。该值是自PostgreSQL纪元（2000-01-01）以来的微秒数。
Int64 (TimestampTz)
事务的回滚时间戳。该值是自PostgreSQL纪元（2000-01-01）以来的微秒数。
Int32 (TransactionId)
事务的Xid。
String
准备事务的用户定义的GID。
Stream Prepare #Byte1('p')
标识消息为流准备事务消息。
Int8(0)
标志；目前未使用。
Int64 (XLogRecPtr)
准备的LSN。
Int64 (XLogRecPtr)
准备事务的结束LSN。
Int64 (TimestampTz)
准备事务的时间戳。该值是自PostgreSQL纪元（2000-01-01）以来的微秒数。
Int32 (TransactionId)
事务的Xid。
String
准备事务的用户定义的GID。
以上消息部分由上述消息共享。
TupleData #Int16
列数。
接下来，对于每个已发布的列，将出现以下子消息之一：
Byte1('n')
标识数据为 NULL 值。
或
Byte1('u')
标识未更改的 TOAST 值（实际值未发送）。
或
Byte1('t')
标识数据为文本格式值。
或
Byte1('b')
标识数据为二进制格式值。
Int32
列值的长度。
Byten
列的值，可以是二进制格式或文本格式。
（如前面的格式字节所指定）。
n 是上述长度。
上一页 上一级 下一页54.8. 错误和通知消息字段 起始页 54.10. 自协议 2.0 以来的变化总结
