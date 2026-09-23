# 9.17. 序列操作函数

9.17. 序列操作函数
版本：
纠错本页面
搜索
目录导航
❮
❯
9.17. 序列操作函数 #
本节描述对sequence
objects进行操作的函数，也称为序列生成器或序列。
序列对象是使用CREATE SEQUENCE创建的特殊单行表。
序列对象通常用于为表中的行生成唯一标识符。在表 9.55中列出的序列函数，提供了简单的、多用户安全方法，用于从序列对象中获取连续的序列值。
表 9.55. 序列函数
Function
描述
nextval ( regclass )
→ bigint
将序列对象推进到下一个值并返回该值。这是原子操作：即使多个会话并发地执行nextval，每个会话也会安全地接收到不同的序列值。
如果序列对象是用默认参数创建的，则连续的nextval调用将返回以1开始的连续值。
其他行为可以通过在CREATE SEQUENCE命令中使用适当的参数获得。
这个函数需要USAGE
或UPDATE特权在序列上。
setval ( regclass, bigint [, boolean ] )
→ bigint
设置序列对象的当前值，以及可选的它的is_called标志。
双参数形式将序列的last_value字段设置为指定的值，并将其is_called字段设置为true，意味着下一个nextval将在返回值之前推进序列。
currval将报告的值也设置为指定的值。在三参数形式中，is_called可以设置为true
或false。true与双参数形式具有相同的效果。如果设置为false，下一个nextval
将返回指定的值，序列推进从下面的nextval开始。
而且，currval报告的值在这种情况下不会改变。例如，
SELECT setval('myseq', 42);           Next nextval will return 43
SELECT setval('myseq', 42, true);     Same as above
SELECT setval('myseq', 42, false);    Next nextval will return 42
setval返回的结果就是它的第二个参数的值。
这个函数在序列上需要UPDATE特权。
currval ( regclass )
→ bigint
返回nextval在当前会话中为该序列最近获取的值。(如果在这个会话中没有为这个序列调用nextval会报告错误。)
因为它返回的是一个会话本地值，所以它给出了一个可预测的答案，即自当前会话以来，其他会话是否执行了nextval。
这个函数需要序列上的USAGE 或 SELECT特权。
lastval ()
→ bigint
返回nextval在当前会话中最近返回的值。这个函数与currval相同，不同之处在于它没有使用序列名作为参数，而是引用当前会话中nextval最近应用到的序列。
如果在当前会话中还没有调用nextval，那么调用lastval是一个错误。
该函数在最后使用的序列上需要USAGE或SELECT特权。
小心
为了避免阻塞从相同序列获取数字的并发事务，nextval获得的值如果调用事务后续中止，就不会被重新使用。
这意味着事务中止或数据库崩溃可能导致分配值序列中的间隙。这也可能发生在没有事务中止的情况下。
例如，带有ON CONFLICT子句的INSERT将计算要插入的元组，包括执行任何必需的nextval调用，
然后才检测到可能导致其遵循ON CONFLICT规则的任何冲突。
因此，PostgreSQL序列对象不能用于获取“无间隙”序列。
同样，setval函数所做的序列状态更改立即对其他事务可见，
并且如果调用事务回滚，则不会被撤消。
如果在包含nextval或setval调用的事务提交之前，
数据库集群崩溃，那么序列状态更改可能尚未传递到持久存储，
因此在集群重新启动后，无法确定序列是保持其原始状态还是更新状态。
对于数据库内部使用序列而言，这是无害的，因为未提交事务的其他影响也不会可见。
但是，如果您希望将序列值用于持久性的数据库外部用途，请确保在这样做之前已经提交了nextval调用。
序列函数所要操作的序列由regclass参数指定，该参数只是pg_class系统目录中序列的OID。
你不必手工查找OID，不过，因为regclass数据类型的输入转换器将为你完成这项工作。
详见第 8.19 节
上一页 上一级 下一页9.16. JSON 函数和操作符 起始页 9.18. 条件表达式
