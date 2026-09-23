# 37.4. 一个完整的触发器示例

37.4. 一个完整的触发器示例
版本：
纠错本页面
搜索
目录导航
❮
❯
37.4. 一个完整的触发器示例 #
这里有一个用 C 编写的触发器函数的非常简单的例子（用过程语言编写的触发器的例子可以在过程语言的文档中找到）。
如果该命令试图向列x中插入一个空值，函数trigf报告表ttest中的行数并且跳过实际的操作（这样该触发器会作为一个非空约束但不会中止事务）。
首先，表定义：
CREATE TABLE ttest (
x integer
);
这是触发器函数的源代码：
#include "postgres.h"
#include "fmgr.h"
#include "executor/spi.h"       /* this is what you need to work with SPI */
#include "commands/trigger.h"   /* ... triggers ... */
#include "utils/rel.h"          /* ... and relations */
PG_MODULE_MAGIC;
PG_FUNCTION_INFO_V1(trigf);
Datum
trigf(PG_FUNCTION_ARGS)
{
TriggerData *trigdata = (TriggerData *) fcinfo->context;
TupleDesc   tupdesc;
HeapTuple   rettuple;
char       *when;
bool        checknull = false;
bool        isnull;
int         ret, i;
/* 确保它确实是作为触发器调用的 */
if (!CALLED_AS_TRIGGER(fcinfo))
elog(ERROR, "trigf: not called by trigger manager");
/* 返回给执行器的元组 */
if (TRIGGER_FIRED_BY_UPDATE(trigdata->tg_event))
rettuple = trigdata->tg_newtuple;
else
rettuple = trigdata->tg_trigtuple;
/* 检查 NULL 值 */
if (!TRIGGER_FIRED_BY_DELETE(trigdata->tg_event)
&& TRIGGER_FIRED_BEFORE(trigdata->tg_event))
checknull = true;
if (TRIGGER_FIRED_BEFORE(trigdata->tg_event))
when = "before";
else
when = "after ";
tupdesc = trigdata->tg_relation->rd_att;
/* 连接到 SPI 管理器 */
SPI_connect();
/* 获取表中的行数 */
ret = SPI_exec("SELECT count(*) FROM ttest", 0);
if (ret < 0)
elog(ERROR, "trigf (fired %s): SPI_exec returned %d", when, ret);
/* count(*) 返回 int8，因此要小心转换 */
i = DatumGetInt64(SPI_getbinval(SPI_tuptable->vals[0],
SPI_tuptable->tupdesc,
1,
&isnull));
elog (INFO, "trigf (fired %s): there are %d rows in ttest", when, i);
SPI_finish();
if (checknull)
{
SPI_getbinval(rettuple, tupdesc, 1, &isnull);
if (isnull)
rettuple = NULL;
}
return PointerGetDatum(rettuple);
}
在你编译了该源代码（见第 36.10.5 节）之后，声明该函数和触发器：
CREATE FUNCTION trigf() RETURNS trigger
AS 'filename'
LANGUAGE C;
CREATE TRIGGER tbefore BEFORE INSERT OR UPDATE OR DELETE ON ttest
FOR EACH ROW EXECUTE FUNCTION trigf();
CREATE TRIGGER tafter AFTER INSERT OR UPDATE OR DELETE ON ttest
FOR EACH ROW EXECUTE FUNCTION trigf();
现在你可以测试该触发器的操作：
=> INSERT INTO ttest VALUES (NULL);
INFO:  trigf (fired before): there are 0 rows in ttest
INSERT 0 0
-- Insertion skipped and AFTER trigger is not fired
=> SELECT * FROM ttest;
x
----
(0 rows)
=> INSERT INTO ttest VALUES (1);
INFO:  trigf (fired before): there are 0 rows in ttest
INFO:  trigf (fired after ): there are 1 rows in ttest
^^^^^^^^
remember what we said about visibility.
INSERT 167793 1
vac=> SELECT * FROM ttest;
x
----
1
(1 row)
=> INSERT INTO ttest SELECT x * 2 FROM ttest;
INFO:  trigf (fired before): there are 1 rows in ttest
INFO:  trigf (fired after ): there are 2 rows in ttest
^^^^^^
remember what we said about visibility.
INSERT 167794 1
=> SELECT * FROM ttest;
x
----
1
2
(2 rows)
=> UPDATE ttest SET x = NULL WHERE x = 2;
INFO:  trigf (fired before): there are 2 rows in ttest
UPDATE 0
=> UPDATE ttest SET x = 4 WHERE x = 2;
INFO:  trigf (fired before): there are 2 rows in ttest
INFO:  trigf (fired after ): there are 2 rows in ttest
UPDATE 1
vac=> SELECT * FROM ttest;
x
----
1
4
(2 rows)
=> DELETE FROM ttest;
INFO:  trigf (fired before): there are 2 rows in ttest
INFO:  trigf (fired before): there are 1 rows in ttest
INFO:  trigf (fired after ): there are 0 rows in ttest
INFO:  trigf (fired after ): there are 0 rows in ttest
^^^^^^
remember what we said about visibility.
DELETE 2
=> SELECT * FROM ttest;
x
----
(0 rows)
在src/test/regress/regress.c和spi中有更多复杂的例子。
上一页 上一级 下一页37.3. 用 C 编写触发器函数 起始页 第 38 章 事件触发器
