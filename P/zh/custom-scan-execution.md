# 60.3. 执行自定义扫描

60.3. 执行自定义扫描
版本：
纠错本页面
搜索
目录导航
❮
❯
60.3. 执行自定义扫描 #60.3.1. 自定义扫描执行回调
在执行一个CustomScan时，它的执行状态由一个CustomScanState表示，其定义如下：
typedef struct CustomScanState
{
ScanState ss;
uint32    flags;
const CustomExecMethods *methods;
} CustomScanState;
ss和任何其他扫描状态一样被初始化，不过如果该扫描是用于连接而不是基本关系，则ss.ss_currentRelation会被留成 NULL。flags是一个位掩码，它的含义与CustomPath和CustomScan中的一样。methods必须指向一个实现了所需自定义扫描状态方法的对象（通常是静态分配的），将进一步在下文详细介绍。通常一个CustomScanState（不需要支持copyObject）实际将是一个较大的结构，上面的结构将嵌入在其中作为第一个成员。
60.3.1. 自定义扫描执行回调 #
void (*BeginCustomScan) (CustomScanState *node,
EState *estate,
int eflags);
完成所提供的CustomScanState的初始化。标准字段已经被ExecInitCustomScan初始化，但是任何私有字段应该在这里被初始化。
TupleTableSlot *(*ExecCustomScan) (CustomScanState *node);
取下一个扫描元组。如果还有任何元组剩余，它应该用当前扫描方向的下一个元组填充ps_ResultTupleSlot，并且接着返回该元组槽。如果没有，则返回NULL或一个空槽。
void (*EndCustomScan) (CustomScanState *node);
清除任何与CustomScanState相关的私有数据。这个方法是必需的，但是如果没有相关的数据或者相关数据将被自动清除，则它不需要做任何事情。
void (*ReScanCustomScan) (CustomScanState *node);
把当前扫描倒回到开始处，并准备重新扫描该关系。
void (*MarkPosCustomScan) (CustomScanState *node);
保存当前的扫描位置，这样可以在以后由RestrPosCustomScan回调函数恢复。这个回调函数是可选的，只有在CUSTOMPATH_SUPPORT_MARK_RESTORE标志被设置时才需要提供。
void (*RestrPosCustomScan) (CustomScanState *node);
恢复由MarkPosCustomScan回调函数保存的扫描位置。这个回调函数是可选的，只有在CUSTOMPATH_SUPPORT_MARK_RESTORE标志被设置时才需要提供。
Size (*EstimateDSMCustomScan) (CustomScanState *node,
ParallelContext *pcxt);
估计并行操作所需的动态共享内存的数量。这可能会比实际使用的量更大，但是绝不能更低。返回值的单位是字节。这个回调是可选的，只有在这个自定义扫描提供者支持并行执行时才必须提供这个回调。
void (*InitializeDSMCustomScan) (CustomScanState *node,
ParallelContext *pcxt,
void *coordinate);
初始化并行操作所需的动态共享内存。coordinate
指向一块大小等于EstimateDSMCustomScan
返回值的共享内存区域。这个回调是可选的，
只有在这个自定义扫描提供者支持并行执行时才必须提供这个回调。
void (*ReInitializeDSMCustomScan) (CustomScanState *node,
ParallelContext *pcxt,
void *coordinate);
当自定义扫描计划节点即将被重新扫描时，
重新初始化并行操作所需的动态共享内存。这个回调是可选的，
只有在这个自定义扫描提供者支持并行执行时才必须提供这个回调。
推荐的做法是，此回调仅重置共享状态，而ReScanCustomScan
回调仅重置本地状态。目前，该回调将在ReScanCustomScan
之前调用，但最好不要依赖该顺序。
void (*InitializeWorkerCustomScan) (CustomScanState *node,
shm_toc *toc,
void *coordinate);
基于InitializeDSMCustomScan期间通过领导者
设置的共享状态初始化并行工作者的本地状态。这个回调是可选的，
只有在这个自定义扫描提供者支持并行执行时才必须提供这个回调。
void (*ShutdownCustomScan) (CustomScanState *node);
预计节点将不会执行完成时释放资源。并不是在所有情况下都调用；
有时，EndCustomScan可能会在调用此函数之前调用。
由于并行查询使用的DSM段在调用此回调后即被销毁，
因此希望在DSM段消失之前采取某些操作的自定义扫描提供程序应实现此方法。
void (*ExplainCustomScan) (CustomScanState *node,
List *ancestors,
ExplainState *es);
为一个自定义扫描计划节点的EXPLAIN输出额外的信息。这个回调函数是可选的。即使没有这个回调函数，被存储在ScanState中的公共的数据（例如目标列表和扫描关系）也将被显示，但是该回调函数允许显示额外的信息（例如私有状态）。
上一页 上一级 下一页60.2. 创建自定义扫描计划 起始页 第 61 章 遗传查询优化器
