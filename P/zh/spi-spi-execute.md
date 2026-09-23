# SPI_execute

SPI_execute
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_executeSPI_execute — 执行一个命令大纲
int SPI_execute(const char * command, bool read_only, long count)
描述
SPI_execute执行指定的 SQL 命令以获得count行。如果read_only为true，该命令必须是只读的，并且执行开销也会有所降低。
只能从一个已连接的 C 函数中调用这个函数。
如果count为零，那么该命令会为其所适用的所有行执行。如果count大于零，那么会检索不超过count行，当到达该计数时执行会停止，这很像为查询增加一个LIMIT子句。例如：
SPI_execute("SELECT * FROM foo", true, 5);
会从表中检索至多 5 行。注意这样一个限制只有当命令真正返回行时才有效。例如：
SPI_execute("INSERT INTO foo SELECT * FROM bar", false, 5);
插入所有来自于bar的行，而忽略count参数。不过，通过
SPI_execute("INSERT INTO foo SELECT * FROM bar RETURNING *", false, 5);
将插入至多 5 行，因为在第五个RETURNING结果行被检索到后执行就会停止。
你可以在一个字符串中传递多个命令，SPI_execute会返回最后一个被执行的命令的结果。
count限制单独适用于每一个命令（即便只有最后一个结果会被实际返回）。该限制
不适用于由规则产生的任何隐藏命令。
当read_only是false时，
SPI_execute增加命令计数器并且在执行字符串中每一个命令之前
计算一个新的快照。如果当前事务隔离级别是SERIALIZABLE或REPEATABLE READ，
该快照并不会实际改变。但是在READ COMMITTED模式中，快照更新允许每个命令看到来自其他会话中新近已提交事务
的结果。当命令正在修改数据库时，这对一致性行为非常重要。
当read_only是true时，
SPI_execute不更新快照或者命令计数器，并且它只允许纯
SELECT命令出现在命令字符串中。这些命令被使用之前为周围查询
建立的快照来执行。这种执行模式要比读/写模式更快，因为消除了每个命令的开销。
它也允许建立真正稳定的函数：因为连续执行将会使用同一个快照，因此结果不会有改变。
在一个使用 SPI 的单一函数中混合只读和读写命令通常是不明智的，
这样可能会导致非常令人困惑的行为，因为只读查询将看不到任何
由读写查询完成的数据库更新结果。
实际执行（最后）命令的行数通过全局变量SPI_processed返回。
如果函数的返回值是SPI_OK_SELECT、SPI_OK_INSERT_RETURNING、
SPI_OK_DELETE_RETURNING、SPI_OK_UPDATE_RETURNING或
SPI_OK_MERGE_RETURNING，则可以使用全局指针
SPITupleTable *SPI_tuptable访问结果行。一些实用命令（例如
EXPLAIN）也返回行集，在这些情况下SPI_tuptable
也会包含结果。一些实用命令（COPY、CREATE TABLE AS）
不返回行集，因此SPI_tuptable为 NULL，但它们仍然返回处理的行数，
该行数存储在SPI_processed中。
结构SPITupleTable被定义为：
typedef struct SPITupleTable
{
/* Public members */
TupleDesc   tupdesc;        /* tuple descriptor */
HeapTuple  *vals;           /* array of tuples */
uint64      numvals;        /* number of valid tuples */
/* Private members, not intended for external callers */
uint64      alloced;        /* allocated length of vals array */
MemoryContext tuptabcxt;    /* memory context of result table */
slist_node  next;           /* link for internal bookkeeping */
SubTransactionId subid;     /* subxact in which tuptable was created */
} SPITupleTable;
SPI 调用者可以使用字段tupdesc、vals和numvals；其余字段是内部的。vals是一个指向行的指针数组。行数由numvals给出（由于某些历史原因，这个计数也在SPI_processed中返回）。tupdesc是一个行描述符，您可以将其传递给处理行的SPI函数。
SPI_finish释放在当前的C函数中已分配的所有SPITupleTable。如果您已经用完了一个结果表，您可以通过调用SPI_freetuptable提早释放它。
参数const char * command
包含要执行的命令的字符串
bool read_onlytrue表示只读执行long count
要返回的最大行数，或者用0表示没有限制
返回值
如果命令执行成功，则将返回以下（非负）值之一：
SPI_OK_SELECT
如果执行了SELECT（但不是SELECT
INTO）
SPI_OK_SELINTO
如果执行了SELECT INTO
SPI_OK_INSERT
如果执行了INSERT
SPI_OK_DELETE
如果执行了DELETE
SPI_OK_UPDATE
如果执行了UPDATE
SPI_OK_MERGE
如果执行了MERGE
SPI_OK_INSERT_RETURNING
如果执行了INSERT RETURNING
SPI_OK_DELETE_RETURNING
如果执行了DELETE RETURNING
SPI_OK_UPDATE_RETURNING
如果执行了UPDATE RETURNING
SPI_OK_MERGE_RETURNING
如果执行了MERGE RETURNING
SPI_OK_UTILITY
如果执行了实用命令（例如，CREATE TABLE）
SPI_OK_REWRITTEN
如果命令被重写成另一种命令（例如，UPDATE变成了
INSERT），由规则完成。
发生错误时，将会返回下列负值之一：
SPI_ERROR_ARGUMENT
如果command为NULL或者count小于 0
SPI_ERROR_COPY
如果尝试COPY TO stdout或者COPY FROM stdin
SPI_ERROR_TRANSACTION
如果尝试了一个事务操纵命令（
BEGIN、
COMMIT、
ROLLBACK、
SAVEPOINT、
PREPARE TRANSACTION、
COMMIT PREPARED、
ROLLBACK PREPARED或者任何变体）
SPI_ERROR_OPUNKNOWN
如果命令类型未知（不应该发生）
SPI_ERROR_UNCONNECTED
如果从未连接的C函数中调用
注释
所有 SPI 查询执行函数都会设置SPI_processed和SPI_tuptable（只是指针，
而不是结构的内容）。如果你需要在以后访问SPI_execute或另一个查询执行函数的结果表，
请将这两个全局变量保存到本地的C函数变量中。
上一页 上一级 下一页SPI_finish 起始页 SPI_exec
