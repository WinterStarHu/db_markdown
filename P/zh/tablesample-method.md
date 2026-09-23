# 第 59 章 编写一种表采样方法

第 59 章 编写一种表采样方法
版本：
纠错本页面
搜索
目录导航
❮
❯
第 59 章 编写一种表采样方法目录59.1. 采样方法支持函数
PostgreSQL的TABLESAMPLE子句实现支持
在 SQL 标准要求的BERNOULLI和SYSTEM方法之外
自定义表采样方法。采样方法决定了使用TABLESAMPLE子句时
表的哪些行会被选择。
在 SQL 层上，一种表采样方法被表达为一个 SQL 函数（通常用 C 实现），
其签名是：
method_name(internal) RETURNS tsm_handler
函数的名称是出现在TABLESAMPLE子句中的同一个方法名称。
internal参数是不起作用的（总是值为零），它仅仅是为了阻止
直接从 SQL 命令中调用该函数。函数的结果必须是一个 palloc 的
TsmRoutine结构，它包含了该采样方法的支持函数的指针。
这些支持函数是纯 C 函数并且对于 SQL 层面不可见也不可调用。支持函数见
第 59.1 节。
除了函数指针之外，TsmRoutine结构必须提供这些额外的域：
List *parameterTypes
这是一个 OID 列表，它包含了使用这种采样方法时TABLESAMPLE
子句接受的参数的数据类型 OID。例如，对于内建方法，这个列表只包含一个值
为FLOAT4OID的项，它表示采样的百分数。自定义采样方法可以有
更多或不同的参数。
bool repeatable_across_queries
如果为true，当每次查询时给出相同的参数和
REPEATABLE种子值且表内容没有改变时，采样方法可以在
连续的查询中给出相同的采样。当这个域为false时，不能把
REPEATABLE子句用于这种采样方法。
bool repeatable_across_scans
如果为true，这种采样方法在同一个查询的连续扫描中给出
相同的采样（假定参数、种子值和快照都不变）。当这个域为
false时，规划器将不会选择要求扫描被采样表多于一次的计划，
因为那会导致不一致的查询输出。
TsmRoutine结构类型被声明在
src/include/access/tsmapi.h中，需要更多细节可以参考该文件。
在尝试编写自己的采样方法时，包括在标准发布中的表采样方法是很好的参考。内建
采样方法的源代码树可见src/backend/access/tablesample子目录，
在contrib子目录中可以找到额外的方法。
上一页 上一级 下一页58.5. 外部数据包装器中的行锁定 起始页 59.1. 采样方法支持函数
