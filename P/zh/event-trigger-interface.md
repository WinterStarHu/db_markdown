# 38.2. 用 C 编写事件触发器函数

38.2. 用 C 编写事件触发器函数
版本：
纠错本页面
搜索
目录导航
❮
❯
38.2. 用 C 编写事件触发器函数 #
这一节描述了事件触发器函数接口的低层细节。只有在用 C 编写事件
触发器函数时才需要用到这里的信息。如果使用更高层的语言，那么
这些细节已经被处理好了。在大部分情况下都应该优先考虑使用过程
语言来编写你的事件触发器。每一种过程语言的文档都解释了如何用
它编写事件触发器。
事件触发器函数必须使用“版本 1”的函数管理器接口。
当一个函数被事件触发器管理器调用时，向它传递的并不是普通参数，
而是一个指向EventTriggerData结构的
“context”指针。C 函数可以通过执行以下宏来检查它是否
被事件触发器管理器调用：
CALLED_AS_EVENT_TRIGGER(fcinfo)
这个宏会被扩展为：
((fcinfo)->context != NULL && IsA((fcinfo)->context, EventTriggerData))
如果这个宏返回真，那么就可以安全地把
fcinfo->context造型为类型EventTriggerData
*并且使用所指向的EventTriggerData结构。
函数不能修改
EventTriggerData结构以及它指向的任何内容。
struct EventTriggerData 定义在
commands/event_trigger.h：
typedef struct EventTriggerData
{
NodeTag     type;
const char *event;      /* event name */
Node       *parsetree;  /* parse tree */
CommandTag  tag;        /* command tag */
} EventTriggerData;
其成员定义如下：
type
始终为 T_EventTriggerData。
event
描述函数被调用的事件，可能是 "login"、
"ddl_command_start"、"ddl_command_end"、
"sql_drop"、"table_rewrite" 中的一个。
详见 第 38.1 节 了解这些事件的含义。
parsetree
指向命令解析树的指针。详情请查看 PostgreSQL 源代码。解析树结构
可能会在无通知的情况下发生变化。
tag
与事件触发器运行的事件相关联的命令标签，例如
"CREATE FUNCTION"。
一个事件触发器函数必须返回一个NULL指针（
不是一个 SQL 空值，也就是不要把
isNull设置为 true）。
上一页 上一级 下一页38.1. 事件触发器行为总览 起始页 38.3. 一个完整的事件触发器示例
