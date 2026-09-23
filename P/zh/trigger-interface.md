# 37.3. 用 C 编写触发器函数

37.3. 用 C 编写触发器函数
版本：
纠错本页面
搜索
目录导航
❮
❯
37.3. 用 C 编写触发器函数 #
这一节描述了一个触发器函数的接口的低层细节。只有用 C 编写触发器函数时才需要这些信息。如果你使用一种更高层的语言，那么这些细节就不需要你来处理。在大部分情况下，你应该优先考虑使用一种过程语言。每一种过程语言的文档阐述了如何使用那种语言编写一个触发器。
触发器函数必须使用“版本 1”函数管理器接口。
当一个函数被触发器管理器调用时，不会给它传递任何常规的参数，但是会有一个“context”指针传递给它，该指针指向一个TriggerData结构。C 函数可以通过执行一个宏来检查它们是否是从触发器管理器被调用：
CALLED_AS_TRIGGER(fcinfo)
它会展开成为：
((fcinfo)->context != NULL && IsA((fcinfo)->context, TriggerData))
如果这返回真，那么将fcinfo->context转换为类型TriggerData
*并且利用所指向的TriggerData结构就是安全的。该函数不能修改该TriggerData结构或者它指向的任何数据。
struct TriggerData 在
commands/trigger.h 中定义：
typedef struct TriggerData
{
NodeTag          type;
TriggerEvent     tg_event;
Relation         tg_relation;
HeapTuple        tg_trigtuple;
HeapTuple        tg_newtuple;
Trigger         *tg_trigger;
TupleTableSlot  *tg_trigslot;
TupleTableSlot  *tg_newslot;
Tuplestorestate *tg_oldtable;
Tuplestorestate *tg_newtable;
const Bitmapset *tg_updatedcols;
} TriggerData;
成员定义如下：
type
始终是T_TriggerData。
tg_event
描述调用函数的事件。您可以使用以下宏来检查tg_event：
TRIGGER_FIRED_BEFORE(tg_event)
如果触发器在操作之前触发，则返回true。
TRIGGER_FIRED_AFTER(tg_event)
如果触发器在操作之后触发，则返回true。
TRIGGER_FIRED_INSTEAD(tg_event)
如果触发器代替操作触发，则返回true。
TRIGGER_FIRED_FOR_ROW(tg_event)
如果触发器为行级事件触发，则返回true。
TRIGGER_FIRED_FOR_STATEMENT(tg_event)
如果触发器为语句级事件触发，则返回true。
TRIGGER_FIRED_BY_INSERT(tg_event)
如果触发器由INSERT命令触发，则返回true。
TRIGGER_FIRED_BY_UPDATE(tg_event)
如果触发器由UPDATE命令触发，则返回true。
TRIGGER_FIRED_BY_DELETE(tg_event)
如果触发器由DELETE命令触发，则返回true。
TRIGGER_FIRED_BY_TRUNCATE(tg_event)
如果触发器由TRUNCATE命令触发，则返回true。
tg_relation
指向描述触发器触发的关系的结构的指针。
查看utils/rel.h以获取有关此结构的详细信息。
最有趣的是tg_relation->rd_att（关系元组的描述符）
和tg_relation->rd_rel->relname（关系名称；
类型不是char*，而是NameData；
如果需要名称的副本，请使用SPI_getrelname(tg_relation)获取char*）。
tg_trigtuple
触发器触发的行的指针。这是被插入、更新或删除的行。如果这个触发器是为INSERT或
DELETE而触发的，那么如果您不想用不同的行替换该行（在INSERT的情况下）或跳过操作，则应该从函数中返回这个值。
对于外部表的触发器，这里的系统列的值是未指定的。
tg_newtuple
如果触发器是为UPDATE而触发的，则指向行的新版本；如果是为INSERT或DELETE而触发的，则为NULL。
如果事件是UPDATE，并且您不想用不同的行替换此行或跳过操作，则必须从函数中返回此值。对于外部表的触发器，此处的系统列值是未指定的。
tg_trigger
指向在utils/reltrigger.h中定义的Trigger类型的结构体指针：
typedef struct Trigger
{
Oid         tgoid;
char       *tgname;
Oid         tgfoid;
int16       tgtype;
char        tgenabled;
bool        tgisinternal;
bool        tgisclone;
Oid         tgconstrrelid;
Oid         tgconstrindid;
Oid         tgconstraint;
bool        tgdeferrable;
bool        tginitdeferred;
int16       tgnargs;
int16       tgnattr;
int16      *tgattr;
char      **tgargs;
char       *tgqual;
char       *tgoldtable;
char       *tgnewtable;
} Trigger;
其中tgname是触发器的名称，
tgnargs是tgargs中参数的数量，
tgargs是指向CREATE
TRIGGER语句中指定参数的指针数组。其他成员仅供内部使用。
tg_trigslot
包含tg_trigtuple的槽，
或者如果没有这样的元组，则为NULL指针。
tg_newslot
包含tg_newtuple的槽，
或者如果没有这样的元组，则为NULL指针。
tg_oldtable
指向一个类型为Tuplestorestate的结构体，
包含零个或多个以tg_relation指定格式的行，
或者一个NULL指针，如果没有OLD TABLE过渡关系。
tg_newtable
指向一个类型为Tuplestorestate的结构体，
其中包含零个或多个以tg_relation指定格式的行，
或者一个NULL指针，如果没有NEW TABLE过渡关系。
tg_updatedcols
对于UPDATE触发器，一个位图集，指示被触发命令更新的列。
通用触发器函数可以使用它来优化操作，因为它不必处理未更改的列。
例如，要确定具有属性编号为attnum（从1开始）的列是否是此位图集合的成员，
调用bms_is_member(attnum -
FirstLowInvalidHeapAttributeNumber,
trigdata->tg_updatedcols))。
对于其他触发器，这将是NULL。
为了允许通过SPI发出的查询引用过渡表，请参考SPI_register_trigger_data。
一个触发器函数必须返回一个HeapTuple指针或一个NULL指针（不是一个 SQL 空值，也就是不会设置isNull为真）。如果你不希望修改正在被操作的行，要小心地根据情况返回tg_trigtuple或tg_newtuple。
上一页 上一级 下一页37.2. 数据改变的可见性 起始页 37.4. 一个完整的触发器示例
