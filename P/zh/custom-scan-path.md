# 60.1. 创建自定义扫描路径

60.1. 创建自定义扫描路径
版本：
纠错本页面
搜索
目录导航
❮
❯
60.1. 创建自定义扫描路径 #60.1.1. 自定义扫描路径回调
自定义扫描提供者通常会通过设置以下钩子来为基础关系添加路径，该钩子在核心代码为关系生成所有可用访问路径后调用（除了Gather和Gather Merge路径，这些路径在此调用之后生成，以便它们可以使用钩子添加的部分路径）：
typedef void (*set_rel_pathlist_hook_type) (PlannerInfo *root,
RelOptInfo *rel,
Index rti,
RangeTblEntry *rte);
extern PGDLLIMPORT set_rel_pathlist_hook_type set_rel_pathlist_hook;
虽然此钩子函数可用于检查、修改或移除核心系统生成的路径，但自定义扫描提供者通常限于生成CustomPath对象并使用add_path将其添加到rel，如果是部分路径，则使用add_partial_path。自定义扫描提供者负责初始化CustomPath对象，其声明如下：
typedef struct CustomPath
{
Path      path;
uint32    flags;
List     *custom_paths;
List     *custom_restrictinfo;
List     *custom_private;
const CustomPathMethods *methods;
} CustomPath;
path必须像其他路径一样初始化，包括行数估计、起始和总成本，以及该路径提供的排序顺序。flags是一个位掩码，指定扫描提供者是否支持某些可选功能。flags应该包含CUSTOMPATH_SUPPORT_BACKWARD_SCAN，如果自定义路径支持向后扫描，CUSTOMPATH_SUPPORT_MARK_RESTORE，如果支持标记和恢复，以及CUSTOMPATH_SUPPORT_PROJECTION，如果能执行投影。（如果未设置CUSTOMPATH_SUPPORT_PROJECTION，扫描节点只会被要求产生扫描关系的Vars；而如果设置了该标志，扫描节点必须能够对这些Vars计算标量表达式。）一个可选的custom_paths是一个Path节点列表，由该自定义路径节点使用；这些将由规划器转换为Plan节点。如下面所述，自定义路径也可以为连接关系创建。在这种情况下，custom_restrictinfo应该用于存储应用于自定义路径替代的连接的连接子句集合。否则应为NIL。custom_private可用于存储自定义路径的私有数据。私有数据应以nodeToString能处理的形式存储，以便调试程序尝试打印自定义路径时能正常工作。methods必须指向一个（通常是静态分配的）实现所需自定义路径方法的对象，具体细节如下。
一个自定义扫描提供者还能提供连接路径。就和基本关系一样，这样一条路径也应该产生和它将要替换的连接所产生的相同的输出。要做到这一点，连接提供程序应该设置下面的钩子函数，并且在该钩子函数里为连接关系创建CustomPath路径。
typedef void (*set_join_pathlist_hook_type) (PlannerInfo *root,
RelOptInfo *joinrel,
RelOptInfo *outerrel,
RelOptInfo *innerrel,
JoinType jointype,
JoinPathExtraData *extra);
extern PGDLLIMPORT set_join_pathlist_hook_type set_join_pathlist_hook;
对于同一个连接关系，这个钩子将被反复调用，因为要对不同的内外关系组合生成路径，所以如何最小化可能的重复工作是钩子函数的责任。
还要注意，应用于连接的连接子句集合，即作为extra->restrictlist传递的集合，
会根据内外关系的组合而变化。为joinrel生成的
CustomPath路径必须包含它使用的连接子句集合，
规划器将在将CustomPath路径转换为计划时使用该集合，
如果规划器选择它作为joinrel的最佳路径。
60.1.1. 自定义扫描路径回调 #
Plan *(*PlanCustomPath) (PlannerInfo *root,
RelOptInfo *rel,
CustomPath *best_path,
List *tlist,
List *clauses,
List *custom_plans);
将一条自定义路径转换为一个完成的计划。返回值通常将是一个CustomScan对象，回调函数必须负责分配并且初始化这个对象。详见第 60.2 节。
List *(*ReparameterizeCustomPathByChild) (PlannerInfo *root,
List *custom_private,
RelOptInfo *child_rel);
当将由给定子关系child_rel的最顶层父关系参数化的路径转换为由子关系参数化时，将调用此回调函数。
此回调函数用于重新参数化任何路径或转换保存在给定custom_private成员中的表达式节点，
该成员属于CustomPath。回调函数可以根据需要使用
reparameterize_path_by_child、
adjust_appendrel_attrs或
adjust_appendrel_attrs_multilevel。
上一页 上一级 下一页第 60 章 编写自定义扫描提供者 起始页 60.2. 创建自定义扫描计划
