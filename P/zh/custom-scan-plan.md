# 60.2. 创建自定义扫描计划

60.2. 创建自定义扫描计划
版本：
纠错本页面
搜索
目录导航
❮
❯
60.2. 创建自定义扫描计划 #60.2.1. 自定义扫描计划回调
以一棵已完成的计划树表示的自定义扫描使用下面的结构：
typedef struct CustomScan
{
Scan      scan;
uint32    flags;
List     *custom_plans;
List     *custom_exprs;
List     *custom_private;
List     *custom_scan_tlist;
Bitmapset *custom_relids;
const CustomScanMethods *methods;
} CustomScan;
scan必须和任何其他扫描一样被初始化，包括估计代价、目标列表、条件等等。flags是一个位掩码，它的含义和CustomPath中的一样。custom_plans可以用来存储子Plan节点。custom_exprs应该被用来存储需要由setrefs.c和subselect.c修整的表达式树，而custom_private应该被用来存储其他只由自定义扫描提供者本身使用的私有数据。在扫描一个基本关系时，custom_scan_tlist可以为 NIL，表示该自定义扫描返回符合该基本关系行类型的扫描元组。否则，它是一个描述实际扫描元组的目标列表。对于连接必须提供custom_scan_tlist。如果自定义扫描提供者能够计算某些非-Var 表达式，也应该提供这个域的值。custom_relids会被核心代码设置成这个扫描节点要处理的关系的集合（范围表索引）。当这个扫描被放在一个连接上时是一种例外，那时其中只有一个成员。methods必须指向一个实现了所需自定义扫描方法的对象（通常是静态分配的），将进一步在下文详细介绍。
当一个CustomScan扫描单个关系时，scan.scanrelid必须是被扫描的表的范围表索引。当它替代的是一个连接时，scan.scanrelid应该为零。
计划树必须能够被使用copyObject复制，因此所有存储在“custom”域中的数据必须由该函数能处理的节点构成。更进一步，自定义扫描提供者不能把CustomScan结构本身替换成包含CustomScan的更大的结构（就好像CustomPath或者CustomScanState）。
60.2.1. 自定义扫描计划回调 #
Node *(*CreateCustomScanState) (CustomScan *cscan);
为这个CustomScan分配一个CustomScanState。实际的分配常常会比一个普通CustomScanState所要求的空间要大，因为很多提供者希望把它嵌入在一个更大的结构中作为第一个域。返回的值必须有节点标签并且设置好了合适的methods，不过在这个阶段其他域应该被设置为零。在ExecInitCustomScan执行基本的初始化之后，将调用BeginCustomScan回调函数来让自定义扫描提供者有机会做其他需要干的事情。
上一页 上一级 下一页60.1. 创建自定义扫描路径 起始页 60.3. 执行自定义扫描
