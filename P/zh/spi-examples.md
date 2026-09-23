# 45.6. 示例

45.6. 示例
版本：
纠错本页面
搜索
目录导航
❮
❯
45.6. 示例 #
这一节包含了 SPI 用法的一个非常简单的例子。C函数
execq用一个 SQL 命令作为其第一个参数
并且用一个行计数作为第二个参数，使用
SPI_exec执行该命令并且返回被该命令
处理过的行的数量。你可以在源代码树的
src/test/regress/regress.c和
spi模块中找到 SPI 的更复杂的例子。
#include "postgres.h"
#include "executor/spi.h"
#include "utils/builtins.h"
PG_MODULE_MAGIC;
PG_FUNCTION_INFO_V1(execq);
Datum
execq(PG_FUNCTION_ARGS)
{
char *command;
int cnt;
int ret;
uint64 proc;
/* 把给定的文本对象转换成一个 C 字符串 */
command = text_to_cstring(PG_GETARG_TEXT_PP(0));
cnt = PG_GETARG_INT32(1);
SPI_connect();
ret = SPI_exec(command, cnt);
proc = SPI_processed;
/*
* 如果取出了一些行，通过 elog(INFO) 打印它们。
*/
if (ret > 0 && SPI_tuptable != NULL)
{
SPITupleTable *tuptable = SPI_tuptable;
TupleDesc tupdesc = tuptable->tupdesc;
char buf[8192];
uint64 j;
for (j = 0; j < tuptable->numvals; j++)
{
HeapTuple tuple = tuptable->vals[j];
int i;
for (i = 1, buf[0] = 0; i <= tupdesc->natts; i++)
snprintf(buf + strlen(buf), sizeof(buf) - strlen(buf), " %s%s",
SPI_getvalue(tuple, tupdesc, i),
(i == tupdesc->natts) ? " " : " |");
elog(INFO, "EXECQ: %s", buf);
}
}
SPI_finish();
pfree(command);
PG_RETURN_INT64(proc);
}
在把该函数编译到一个共享库中（详见第 36.10.5 节）之后，这样声明该函数：
CREATE FUNCTION execq(text, integer) RETURNS int8
AS 'filename'
LANGUAGE C STRICT;
这是一个示例会话：
=> SELECT execq('CREATE TABLE a (x integer)', 0);
execq
-------
0
(1 row)
=> INSERT INTO a VALUES (execq('INSERT INTO a VALUES (0)', 0));
INSERT 0 1
=> SELECT execq('SELECT * FROM a', 0);
INFO:  EXECQ:  0    -- 由execq插入
INFO:  EXECQ:  1    -- 由execq返回并由上层INSERT插入
execq
-------
2
(1 row)
=> SELECT execq('INSERT INTO a SELECT x + 2 FROM a RETURNING *', 1);
INFO:  EXECQ:  2    -- 0 + 2，然后根据计数停止执行
execq
-------
1
(1 row)
=> SELECT execq('SELECT * FROM a', 10);
INFO:  EXECQ:  0
INFO:  EXECQ:  1
INFO:  EXECQ:  2
execq
-------
3              -- 10是最大值，3是实际行数
(1 row)
=> SELECT execq('INSERT INTO a SELECT x + 10 FROM a', 1);
execq
-------
3              -- 所有行已处理；计数不会停止，因为没有返回值
(1 row)
=> SELECT * FROM a;
x
----
0
1
2
10
11
12
(6 rows)
=> DELETE FROM a;
DELETE 6
=> INSERT INTO a VALUES (execq('SELECT * FROM a', 0) + 1);
INSERT 0 1
=> SELECT * FROM a;
x
---
1                  -- 0（a中没有行）+ 1
(1 row)
=> INSERT INTO a VALUES (execq('SELECT * FROM a', 0) + 1);
INFO:  EXECQ:  1
INSERT 0 1
=> SELECT * FROM a;
x
---
1
2                  -- 1（a中有一行）+ 1
(2 rows)
-- 这演示了数据更改可见性规则。
-- execq被调用两次，每次看到不同数量的行：
=> INSERT INTO a SELECT execq('SELECT * FROM a', 0) * x FROM a;
INFO:  EXECQ:  1    -- 第一个execq的结果
INFO:  EXECQ:  2
INFO:  EXECQ:  1    -- 第二个execq的结果
INFO:  EXECQ:  2
INFO:  EXECQ:  2
INSERT 0 2
=> SELECT * FROM a;
x
---
1
2
2                  -- 2行 * 1（第一行中的x）
6                  -- 3行（2 + 1刚插入）* 2（第二行中的x）
(4 rows)
上一页 上一级 下一页45.5. 数据变更的可见性 起始页 第 46 章 后台工作进程
