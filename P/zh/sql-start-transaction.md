# START TRANSACTION

START TRANSACTION
版本：
纠错本页面
搜索
目录导航
❮
❯
START TRANSACTIONSTART TRANSACTION — 开始一个事务块大纲
START TRANSACTION [ transaction_mode [, ...] ]
其中 transaction_mode 是下列之一：
ISOLATION LEVEL { SERIALIZABLE | REPEATABLE READ | READ COMMITTED | READ UNCOMMITTED }
READ WRITE | READ ONLY
[ NOT ] DEFERRABLE
描述
这个命令开始一个新的事务块。如果指定了隔离级别、读写模式
或者可延迟模式，新的事务将会具有这些特性，就像执行了
SET TRANSACTION一样。这和
BEGIN命令一样。
参数
有关这些参数在此语句中的含义，请参阅
SET TRANSACTION。
兼容性
在标准中，没有必要发出START TRANSACTION
来开始一个事务块：任何 SQL 命令会隐式地开始一个块。
PostgreSQL的行为可以被视作
在每个命令之后隐式地发出一个没有跟随在
START TRANSACTION（
或者BEGIN）之后的
COMMIT，并且因此通常被称作
“自动提交”。为了方便，其他关系型数据库系统也可能会
提供自动提交特性。
DEFERRABLE
transaction_mode
是一种PostgreSQL语言扩展。
SQL 标准要求在连续的transaction_modes之间有逗号，
但是由于历史原因PostgreSQL允许
省略逗号。
另见SET TRANSACTION的兼容性小节。
另见BEGIN, COMMIT, ROLLBACK, SAVEPOINT, SET TRANSACTION上一页 上一级 下一页SHOW 起始页 TRUNCATE
