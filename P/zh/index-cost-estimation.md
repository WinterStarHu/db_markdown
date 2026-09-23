# 63.6. 索引开销估计函数

63.6. 索引开销估计函数
版本：
纠错本页面
搜索
目录导航
❮
❯
63.6. 索引开销估计函数 #
amcostestimate函数被给定描述一个可能的索引扫描的信息，包括决定在索引中使用的 WHERE 和 ORDER BY 子句的列表。它必须返回访问该索引的开销估计以及 WHERE 子句的选择度（也就是说，在索引扫描期间将检索的行在父表中所占据的比例）。对于简单情况，几乎开销估计器的所有工作都可以通过调用优化器中的标准过程完成；有amcostestimate函数的目的是允许索引访问方法提供和索引类型相关的知识，这种情况下可以改进标准的估计。
每个amcostestimate函数的签名必须是：
void
amcostestimate (PlannerInfo *root,
IndexPath *path,
double loop_count,
Cost *indexStartupCost,
Cost *indexTotalCost,
Selectivity *indexSelectivity,
double *indexCorrelation,
double *indexPages);
前三个参数是输入参数：
root
规划器的有关正在被处理的查询的信息。
path
被考虑的索引访问路径。其中除了开销和选择度值之外的域都有效。
loop_count
应该被开销估计所考虑的索引扫描重复次数。当考虑用在一个嵌套循环连接中的参数化扫描时，这个参数通常会大于 1。注意代价估计应该仍然是对于一次扫描的，一个更大的loop_count意味着可能在多次扫描间允许一些缓冲效果比较合适。
后五个参数是传引用的输出参数：
*indexStartupCost
设置为索引启动处理的开销。
*indexTotalCost
设置为索引处理的总开销。
*indexSelectivity
设置为索引的选择度。
*indexCorrelation
设置为索引扫描顺序和底层表的顺序之间的相关性。
*indexPages
设置为索引叶子页的数量。
请注意开销估计函数必须用 C 编写，而不能用 SQL 或者任何可用的过程语言，因为它们必须访问规划器/优化器的内部数据结构。
索引访问开销应该采用被src/backend/optimizer/path/costsize.c使用的参数进行计算：一次顺序磁盘块获取的开销是seq_page_cost、一次非顺序获取的开销是random_page_cost，并且处理一个索引行的开销通常应该是cpu_index_tuple_cost。另外，在索引处理期间（尤其是索引条件本身的计算）调用的任何比较操作符都会耗费cpu_operator_cost倍数的开销。
访问开销应该包括所有与扫描索引本身相关的磁盘和 CPU 开销，但是不包括检索或者处理被索引标识出来的父表行的开销。
“启动开销”是整个扫描开销中的一部分：在能够开始取第一行之前必须花掉的开销。对于大多数索引这个开销是零，但那些启动开销很大的索引类型可能会将其设置为非零。
indexSelectivity应该设置为在索引扫描期间，父表行被检索的估计比例。在一个有损查询的情况下，这个值通常高于实际通过给定查询条件的行的比例。
indexCorrelation应该被设置为索引顺序和表顺序之间的相关性（范围从 -1.0 到 1.0）。这个数值被用于调整从父表中取出行的开销估计。
indexPages应该被设置为叶子页的数量。它会被用来估算并行索引扫描所需的工作者数量。
当loop_count大于一时，返回的数应该是该索引任何一次扫描的平均值。
开销估计
一个典型的开销估计器会像下面这样进行：
基于给出的条件情况，估计并返回父表行将被访问的比例。如果缺乏索引类型相关的知识，那么使用标准的优化器函数clauselist_selectivity()：
*indexSelectivity = clauselist_selectivity(root, path->indexquals,
path->indexinfo->rel->relid,
JOIN_INNER, NULL);
估计在扫描过程中将被访问的索引行数。对于许多索引类型，这个等于indexSelectivity乘以索引中的行数，但是可能更多（请注意，页面和行中的索引大小从path->indexinfo结构中获得）。
估计在扫描中将检索的索引页面数量。这个可能就是indexSelectivity乘以索引的总页面数。
计算索引访问开销。一个通用的估计器可能会：
/*
* Our generic assumption is that the index pages will be read
* sequentially, so they cost seq_page_cost each, not random_page_cost.
* Also, we charge for evaluation of the indexquals at each index row.
* All the costs are assumed to be paid incrementally during the scan.
*/
cost_qual_eval(&index_qual_cost, path->indexquals, root);
*indexStartupCost = index_qual_cost.startup;
*indexTotalCost = seq_page_cost * numIndexPages +
(cpu_index_tuple_cost + index_qual_cost.per_tuple) * numIndexTuples;
不过，上面没有考虑重复索引扫描间的索引读取的摊销。
估计索引的相关性。对于一个简单的单列有序索引，这个值可以从pg_statistic中检索。如果相关性未知，那么保守的估计是零（没有相关性）。
成本估计器函数的示例可以在src/backend/utils/adt/selfuncs.c中找到。
上一页 上一级 下一页63.5. 索引唯一性检查 起始页 第 64 章 扩展的预写日志
