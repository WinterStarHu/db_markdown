# 38.3. 一个完整的事件触发器示例

38.3. 一个完整的事件触发器示例
版本：
纠错本页面
搜索
目录导航
❮
❯
38.3. 一个完整的事件触发器示例 #
这里是一个用 C 编写的事件触发器函数的简单例子（用过程语言编写的触发器
例子可以在过程语言的文档中找到）。
函数noddl在每一次被调用时抛出一个异常。
事件触发器定义把该函数和
ddl_command_start事件关联在了一起。其效果就是所有
DDL 命令（除第 38.1 节中提到的例外）都
被阻止运行。
这是触发器函数的源代码：
#include "postgres.h"
#include "commands/event_trigger.h"
#include "fmgr.h"
PG_MODULE_MAGIC;
PG_FUNCTION_INFO_V1(noddl);
Datum
noddl(PG_FUNCTION_ARGS)
{
EventTriggerData *trigdata;
if (!CALLED_AS_EVENT_TRIGGER(fcinfo))  /* internal error */
elog(ERROR, "not fired by event trigger manager");
trigdata = (EventTriggerData *) fcinfo->context;
ereport(ERROR,
(errcode(ERRCODE_INSUFFICIENT_PRIVILEGE),
errmsg("command \"%s\" denied",
GetCommandTagName(trigdata->tag))));
PG_RETURN_NULL();
}
在编译了源代码（见第 36.10.5 节）后，
声明函数和触发器：
CREATE FUNCTION noddl() RETURNS event_trigger
AS 'noddl' LANGUAGE C;
CREATE EVENT TRIGGER noddl ON ddl_command_start
EXECUTE FUNCTION noddl();
现在你可以测试该触发器的操作：
=# \dy
List of event triggers
Name  |       Event       | Owner | Enabled | Function | Tags
-------+-------------------+-------+---------+----------+------
noddl | ddl_command_start | dim   | enabled | noddl    |
(1 row)
=# CREATE TABLE foo(id serial);
ERROR:  command "CREATE TABLE" denied
在这种情况下，为了在需要时能运行某些 DDL 命令，你必须删除该事件触发器
或者禁用它。只在一个事务期间禁用该触发器会比较方便：
BEGIN;
ALTER EVENT TRIGGER noddl DISABLE;
CREATE TABLE foo (id serial);
ALTER EVENT TRIGGER noddl ENABLE;
COMMIT;
（回忆一下，事件触发器本身上的 DDL 命令不受事件触发器影响）。
上一页 上一级 下一页38.2. 用 C 编写事件触发器函数 起始页 38.4. 一个表重写事件触发器示例
