# 59.1. 采样方法支持函数

59.1. 采样方法支持函数
版本：
纠错本页面
搜索
目录导航
❮
❯
59.1. 采样方法支持函数 #
TSM 处理器函数返回一个 palloc 的TsmRoutine结构，其中包含
了下文所述的支持函数的指针。大部分函数是必须的，但是有些是可选的（它们
的指针可以为 NULL）。
void
SampleScanGetSampleSize (PlannerInfo *root,
RelOptInfo *baserel,
List *paramexprs,
BlockNumber *pages,
double *tuples);
这个函数在规划期间被调用。它必须估计在一次采样扫描中会被读到的关系
页面数，以及将被该扫描所选择的元组数（例如，可以先估计采样分数，
乘上baserel->pages和baserel->tuples
数，并且把结果四舍五入为整数值）。paramexprs列表保存作为
TABLESAMPLE子句的参数的表达式。如果出于估计的目的需要
这些表达式的值，我们推荐使用estimate_expression_value()
来尝试将这些表达式变成常量。但是即便这些表达式不能被简化，该函数必须提供
估计的尺寸，并且即使出现不合法的值它也不应该失败（记住它们只是运行时值
的估计）。pages和tuples参数是输出。
void
InitSampleScan (SampleScanState *node,
int eflags);
为 SampleScan 计划节点的执行进行初始化。这会在执行器启动时被调用。
它应该执行处理启动所需的任何初始化工作。
SampleScanState节点已经被创建，但是它的
tsm_state域为 NULL。
InitSampleScan函数可以 palloc 任何采样方法需要的内部
状态数据，并且把它的一个指针存储在node->tsm_state
中。有关要扫描的表的信息可以通过SampleScanState
节点的其他域访问（但是要注意
node->ss.ss_currentScanDesc扫描描述符还没有被设置）。
eflags包含描述这个计划节点的执行器操作模式的标志位。
当(eflags & EXEC_FLAG_EXPLAIN_ONLY)为真时，该
扫描将不会被真正执行，因此这个函数应该只做最少的事情，让该节点状态对
EXPLAIN和EndSampleScan可用。
这个函数可以被省略（把指针设置为 NULL），在那种情况下
BeginSampleScan必须执行采样方法所需的所有初始化工作。
void
BeginSampleScan (SampleScanState *node,
Datum *params,
int nparams,
uint32 seed);
开始执行一次采样扫描。就在第一次尝试取得一个元组时就会调用这个函数，
如果该扫描需要被重启可能还要再次调用它。有关要扫描的表的信息可以通过
SampleScanState节点的其他域访问（但是要注意
node->ss.ss_currentScanDesc扫描描述符还没有被设置）。
长度为nparams的params数组包含在
TABLESAMPLE子句中提供的参数的值。这些参数的编号和类型
在采样方法的parameterTypes列表中指定，并且已经被
检查过不为空。seed包含用于在采样方法中生成任何随机数的
种子。如果给定了REPEATABLE值，种子将是该值的哈希。如果
没有指定REPEATABLE值，种子将是random()的
结果。
这个函数可能会调整域node->use_bulkread
以及node->use_pagemode。
如果node->use_bulkread为true（默认），
该扫描将使用一种鼓励重用缓冲区的缓冲区访问策略。如果该扫描只访问
该表的页面的一小部分，将这个域设置为false比较合理。
如果node->use_pagemode为true（默认），
那么对于每一个被访问的页面上的所有元组，该扫描将会在一趟中执行它们
的可见性检查。如果该扫描只选择每个被访问页面上的一小部分，将这个域
设置为false比较合理。这将导致执行较少次的元组可见性检查，
但是每一次都会代价更大，因为需要更多锁定。
如果采样方法被标记为repeatable_across_scans，在重
新扫描时，它必须能够选择和第一次扫描相同的元组集合，也就是说对
BeginSampleScan的一次新调用必须选择和之前相同的元组
（如果TABLESAMPLE参数和种子没有变化）。
BlockNumber
NextSampleBlock (SampleScanState *node, BlockNumber nblocks);
返回下一个要扫描的页面的块号，如果没有剩余的页面需要扫描则返回
InvalidBlockNumber。
这个函数可以被省略（设置指针为 NULL），在那种情况下核心代码将
执行整个关系的一次顺序扫描。这样一个扫描可以使用同步扫描，这样
采样方法不能假定每一次扫描都用同样的顺序访问关系页面。
OffsetNumber
NextSampleTuple (SampleScanState *node,
BlockNumber blockno,
OffsetNumber maxoffset);
返回指定页面上下一个要被采样的元组的偏移量，如果没有剩余元组需要被采样，
则返回InvalidOffsetNumber。maxoffset是页面上
使用的最大偏移量。
注意
NextSampleTuple没有被显式地告知范围
1 .. maxoffset中的哪些偏移量真正包含了合法的元组。这通常不
成问题，因为核心代码会忽略采样丢失或者不可见元组的请求。这不会导致采样
中的任何偏差。
不过，如果必要，该函数可以用node->donetuples来检查它返回的元组有多少是合法并且可见的。
注意
NextSampleTuple 不能假定
blockno是最近一次NextSampleBlock调用返回的
同一个页面号。它由之前某次NextSampleBlock调用所返回，
但是核心代码被允许在真正扫描页面之前调用NextSampleBlock，
以便支持预取。假定一旦一个给定页面的采样开始，连续的
NextSampleTuple调用都将引用同一个页面，直到返回
InvalidOffsetNumber。
void
EndSampleScan (SampleScanState *node);
结束扫描并释放资源。释放 palloc 过的内存通常并不重要，但是任何外部
可见的资源应该被清除。在没有这类资源存在的情况下，这个函数可以被
省略（设置指针为 NULL）。
上一页 上一级 下一页第 59 章 编写一种表采样方法 起始页 第 60 章 编写自定义扫描提供者
