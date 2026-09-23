# BEGIN

BEGIN
版本：
纠错本页面
搜索
目录导航
❮
❯
BEGINBEGIN — 启动一个事务块大纲
BEGIN [ WORK | TRANSACTION ] [ transaction_mode [, ...] ]
其中 transaction_mode 是以下之一：
ISOLATION LEVEL { SERIALIZABLE | REPEATABLE READ | READ COMMITTED | READ UNCOMMITTED }
READ WRITE | READ ONLY
[ NOT ] DEFERRABLE
描述
BEGIN启动一个事务块，也就是说所有
BEGIN命令之后的所有语句将被在一个
事务中执行，直到给出一个显式的COMMIT
或者ROLLBACK。
默认情况下（没有BEGIN），
PostgreSQL在
“自动提交”模式中执行事务，也就是说每个语句都
在自己的事务中执行并且在语句结束时隐式地执行一次提交（如果执
行成功，否则会完成一次回滚）。
在一个事务块内的语句会执行得更快，因为事务的开始/提交也要求可观
的 CPU 和磁盘活动。在进行多个相关更改时，在一个事务内执行多个语
句也有助于保证一致性：在所有相关更新还没有完成之前，其他会话将不
能看到中间状态。
如果指定了隔离级别、读/写模式或者延迟模式，新事务也会有那些特性，
就像执行了SET TRANSACTION一样。
参数WORKTRANSACTION
可选的关键字。它们没有效果。
这个语句其他参数的含义请参考
SET TRANSACTION。
注释
START TRANSACTION具有和BEGIN
相同的功能。
使用COMMIT或者
ROLLBACK来终止一个事务块。
在已经在一个事务块中时发出BEGIN将惹出一个警告
消息。事务状态不会受到影响。要在一个事务块中嵌套事务，可以使用保
存点（见SAVEPOINT）。
由于向后兼容的原因，连续的
transaction_modes
之间的逗号可以省略。
示例
开始一个事务块：
BEGIN;
兼容性
BEGIN是一种
PostgreSQL语言扩展。它等效于
SQL 标准的命令START TRANSACTION，其参考页
包含额外的兼容性信息。
DEFERRABLE
transaction_mode
是一种PostgreSQL语言扩展。
附带地，BEGIN关键字被用于嵌入式 SQL 中的一种
不同目的。在移植数据库应用时，我们建议小心对待事务语义。
另见COMMIT, ROLLBACK, START TRANSACTION, SAVEPOINT上一页 上一级 下一页ANALYZE 起始页 CALL
