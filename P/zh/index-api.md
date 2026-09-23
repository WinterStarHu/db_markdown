# 63.1. 索引的基本 API 结构

63.1. 索引的基本 API 结构
版本：
纠错本页面
搜索
目录导航
❮
❯
63.1. 索引的基本 API 结构 #
每一个索引访问方法都由pg_am系统目录中的一行所描述。pg_am项为该索引访问方法指定了名称和一个处理器函数。这些项可以用CREATE ACCESS METHOD和DROP ACCESS METHOD SQL命令创建和删除。
一个索引访问方法的处理器函数必须被声明为接受单一的类型为internal类型的参数并且返回伪类型index_am_handler。该参数是一个无用值，它只是被用来防止从 SQL 命令直接调用处理器函数。该函数的结果必须是一个已经 palloc 过的IndexAmRoutine类型结构，它包含核心代码使用该索引访问方法所需的所有信息。IndexAmRoutine结构（也被称为访问方法的API 结构）中的域指定了该访问方法的各种固定性质，例如它是否支持多列索引。更重要的是，它包含用于该访问方法的支持函数的指针，这些函数会完成真正访问索引的工作。这些支持函数是纯 C 函数，并且在 SQL 层面不可见也不可调用。支持函数在第 63.2 节中介绍。
结构 IndexAmRoutine 定义如下：
typedef struct IndexAmRoutine
{
NodeTag     type;
/*
* 我们可以通过多少种策略（运算符）遍历/搜索此 AM 的总数。
* 如果 AM 没有固定的策略分配，则为零。
*/
uint16      amstrategies;
/* 此 AM 使用的支持函数的总数 */
uint16      amsupport;
/* opclass 选项支持函数编号或 0 */
uint16      amoptsprocnum;
/* AM 是否支持按索引列的值排序？ */
bool        amcanorder;
/* AM 是否支持按运算符对索引列的结果排序？ */
bool        amcanorderbyop;
/* AM 是否支持使用与哈希 AM 一致的 API 进行哈希？ */
bool        amcanhash;
/* opfamily 中的运算符是否具有一致的相等语义？ */
bool        amconsistentequality;
/* opfamily 中的运算符是否具有一致的排序语义？ */
bool        amconsistentordering;
/* AM 是否支持向后扫描？ */
bool        amcanbackward;
/* AM 是否支持 UNIQUE 索引？ */
bool        amcanunique;
/* AM 是否支持多列索引？ */
bool        amcanmulticol;
/* AM 是否要求扫描在第一个索引列上有约束？ */
bool        amoptionalkey;
/* AM 是否处理 ScalarArrayOpExpr 资格？ */
bool        amsearcharray;
/* AM 是否处理 IS NULL/IS NOT NULL 资格？ */
bool        amsearchnulls;
/* 索引存储数据类型是否可以与列数据类型不同？ */
bool        amstorage;
/* 这种类型的索引是否可以聚集？ */
bool        amclusterable;
/* AM 是否处理谓词锁？ */
bool        ampredlocks;
/* AM 是否支持并行扫描？ */
bool        amcanparallel;
/* AM 是否支持并行构建？ */
bool        amcanbuildparallel;
/* AM 是否支持包含在 INCLUDE 子句中的列？ */
bool        amcaninclude;
/* AM 是否使用 maintenance_work_mem？ */
bool        amusemaintenanceworkmem;
/* AM 是否总结元组，至少在一个摘要中总结块中的所有元组 */
bool        amsummarizing;
/* 并行 VACUUM 标志的 OR */
uint8       amparallelvacuumoptions;
/* 存储在索引中的数据类型，或如果是可变则为 InvalidOid */
Oid         amkeytype;
/* 接口函数 */
ambuild_function ambuild;
ambuildempty_function ambuildempty;
aminsert_function aminsert;
aminsertcleanup_function aminsertcleanup;   /* 可以为 NULL */
ambulkdelete_function ambulkdelete;
amvacuumcleanup_function amvacuumcleanup;
amcanreturn_function amcanreturn;   /* 可以为 NULL */
amcostestimate_function amcostestimate;
amgettreeheight_function amgettreeheight;   /* 可以为 NULL */
amoptions_function amoptions;
amproperty_function amproperty;     /* 可以为 NULL */
ambuildphasename_function ambuildphasename;   /* 可以为 NULL */
amvalidate_function amvalidate;
amadjustmembers_function amadjustmembers; /* 可以为 NULL */
ambeginscan_function ambeginscan;
amrescan_function amrescan;
amgettuple_function amgettuple;     /* 可以为 NULL */
amgetbitmap_function amgetbitmap;   /* 可以为 NULL */
amendscan_function amendscan;
ammarkpos_function ammarkpos;       /* 可以为 NULL */
amrestrpos_function amrestrpos;     /* 可以为 NULL */
/* 支持并行索引扫描的接口函数 */
amestimateparallelscan_function amestimateparallelscan;    /* 可以为 NULL */
aminitparallelscan_function aminitparallelscan;    /* 可以为 NULL */
amparallelrescan_function amparallelrescan;    /* 可以为 NULL */
/* 支持规划的接口函数 */
amtranslate_strategy_function amtranslatestrategy;  /* 可以为 NULL */
amtranslate_cmptype_function amtranslatecmptype;    /* 可以为 NULL */
} IndexAmRoutine;
要想真正有用，一个索引访问方法还必须有一个或多个定义在pg_opfamily、
pg_opclass、
pg_amop和
pg_amproc中的操作符族和操作符类。这些项允许规划器判断哪种查询条件适用于这个索引访问方法的索引。操作符族和类在第 36.16 节中描述，它是阅读本章所需的前导材料。
一个独立的索引是由一个pg_class项定义的，该项描述索引为一个物理关系。还要加上一个pg_index项来显示索引的逻辑内容 — 也就是说，它所拥有的索引列集以及这些列的语义是被相关操作符类刻画的。索引列（键值）可以是底层表的简单列，也可以是该表行上的表达式。索引访问方法通常不关心索引的键值来自哪里（它总是操作预计算过的键值），但是它会对pg_index中的操作符类信息很感兴趣。所有这些目录项都可以被当作关系数据结构的一部分访问，这个数据结构会被传递给索引上的所有操作。
IndexAmRoutine的一些标志字段具有不明显的含义。关于
amcanunique的要求在第 63.5 节中有讨论。
amcanmulticol标志表示访问方法支持多键列索引，
而amoptionalkey表示它允许在第一个索引列没有
可索引限制条件的情况下进行扫描。当amcanmulticol为假时，
amoptionalkey本质上表示访问方法是否支持无任何限制条件的
全索引扫描。支持多索引列的访问方法必须支持省略第一个索引列之后
任意或所有列限制条件的扫描；但它们可以要求第一个索引列必须有某些限制条件，
这通过将amoptionalkey设置为假来表示。
一个索引AM可能将amoptionalkey设置为假的原因之一是
它不索引空值。由于大多数可索引操作符是严格的，因此不能对空输入返回真，
初看起来不存储空值的索引条目是合理的：索引扫描无论如何都不会返回它们。
然而，当索引扫描对某个索引列没有限制条件时，这个论点就不成立。
实际上，这意味着具有amoptionalkey为真的索引必须索引空值，
因为规划器可能决定使用这样的索引且不带任何扫描键。相关的限制是，
支持多索引列的索引访问方法必须支持对第一个索引列之后的列索引空值，
因为规划器会假设该索引可用于不限制这些列的查询。
例如，考虑一个索引(a,b)和查询WHERE a = 4。
系统会假设该索引可用于扫描满足a = 4的行，
如果索引省略了b为空的行，则这是错误的。
但是，省略第一个索引列为空的行是允许的。
一个索引访问方法如果索引空值，也可以设置amsearchnulls，
表示它支持将IS NULL和IS NOT NULL作为搜索条件。
amcaninclude标志指示此访问方法是否支持 “included”列，这些列可以包含除键列之外的其他列（不处理它们）。上一段中的要求仅适用于关键列。除其他外，amcanmulticol=false
和 amcaninclude=true组合是实用的。这表明可以有包含列，而只有一个键列。此外，amoptionalkey独立地，包含列必须可以为空。
amsummarizing标志指示访问方法是否对索引元组进行汇总，
汇总的粒度至少为每块。
不指向单个元组，而是指向块范围的访问方法（如BRIN），
可能允许HOT优化继续。这不适用于索引谓词中引用的属性，
更新此类属性总是会禁用HOT。
上一页 上一级 下一页第 63 章 索引访问方法接口定义 起始页 63.2. 索引访问方法函数
