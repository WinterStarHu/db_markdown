# F.29. pg_overexplain — 允许 EXPLAIN 输出更多细节

F.29. pg_overexplain — 允许 EXPLAIN 输出更多细节
版本：
纠错本页面
搜索
目录导航
❮
❯
F.29. pg_overexplain — 允许 EXPLAIN 输出更多细节 #F.29.1. EXPLAIN (DEBUG)F.29.2. EXPLAIN (RANGE_TABLE)F.29.3. 作者
pg_overexplain 模块扩展了 EXPLAIN
，提供新的选项以生成额外的输出。它主要用于
辅助调试和开发规划器，而不是用于一般用途。由于该模块显示了规划器数据
结构的内部细节，因此可能需要参考源代码以理解
输出。此外，输出可能会在这些数据结构发生变化时（以及
经常）发生变化。
要使用它，只需将其加载到服务器中。您可以将其加载到
单个会话中：
LOAD 'pg_overexplain';
您还可以通过在
session_preload_libraries 或
shared_preload_libraries 中包含
pg_overexplain 来预加载到某些或所有会话中，
在 postgresql.conf 中进行配置。
F.29.1. EXPLAIN (DEBUG) #
DEBUG 选项显示来自
计划树的杂项信息，这些信息通常不会显示，因为它不被认为
是一般用户所关心的。对于每个单独的计划节点，它将显示
以下字段。有关这些字段的更多文档，请参见
Plan 在
nodes/plannodes.h 中。
禁用节点。正常的 EXPLAIN
通过检查节点的禁用节点计数是否大于
基础节点的计数总和来确定一个节点是否被禁用。此选项显示原始计数器值。
并行安全。指示计划树节点是否可以安全地出现在
Gather 或
Gather Merge 节点下，无论它是否
实际上位于这样的节点下。
计划节点 ID。一个内部 ID 号码，对于计划树中的每个节点应该是
唯一的。它用于协调并行查询活动。
extParam 和 allParam。关于哪些编号参数影响此计划节点或其子节点的信息。在
文本模式下，仅当这些字段为非空集合时才会显示。
每个查询一次，DEBUG 选项将显示
以下字段。有关更多细节，请参见
PlannedStmt 在
nodes/plannodes.h 中。
命令类型。例如，select
或 update。
标志。一个以逗号分隔的布尔结构成员名称列表，
来自 PlannedStmt，这些成员被设置为
true。它涵盖以下结构成员：
hasReturning、hasModifyingCTE、
canSetTag、transientPlan、
dependsOnRole、parallelModeNeeded。
需要重绕的子计划。可能需要由执行器重绕的子计划的整数 ID。
关系 OID。此计划所依赖的关系的 OID。
执行器参数类型。每个执行器参数的类型 OID
（例如，当选择嵌套循环并使用参数将值传递给内部索引扫描时）。
不包括用户提供给预处理语句的参数。
解析位置。在提供给规划器的查询字符串中
此查询文本可以找到的位置。在某些上下文中可能为
未知。否则，可能为某个整数
NNN 到结束或某些整数
NNN 为 MMM 字节。
F.29.2. EXPLAIN (RANGE_TABLE) #
RANGE_TABLE 选项显示来自计划树的信息，
特别是关于查询的范围表。范围表条目大致对应于
查询的 FROM 子句中出现的项，但有许多例外。
例如，被证明不必要的子查询可能会完全从范围表中删除，
而继承扩展会为在查询中未直接命名的子表添加范围表条目。
范围表条目通常通过范围表索引（RTI）在查询计划中引用。
引用一个或多个 RTI 的计划节点将相应标记，
使用以下字段之一： 扫描 RTI、名义 RTI、
排除关系 RTI、附加 RTIs。
此外，整个查询可能维护所需的范围表索引列表，
用于各种目的。这些列表将在每个查询中显示一次，
适当地标记为 不可修剪的 RTIs 或
结果 RTIs。在文本模式下，只有在它们是非空集合时，
这些字段才会显示。
最后，但最重要的是，RANGE_TABLE 选项
将显示查询整个范围表的转储。每个范围表条目
都标记有适当的范围表索引、范围表条目的类型
（例如，relation、subquery或 join），
后面跟着各种范围表条目字段的内容，这些字段通常不属于
EXPLAIN 输出。一些字段仅在某些类型的范围表条目中显示。
例如，Eref 对所有类型的范围表条目都显示，
但 CTE Name 仅对类型为 cte 的范围表条目显示。
有关范围表条目的更多信息，请参见 RangeTblEntry
在 nodes/parsenodes.h 中的定义。
F.29.3. 作者 #
Robert Haas <rhaas@postgresql.org>
上一页 上一级 下一页F.28. pg_logicalinspect — 逻辑解码组件检查 起始页 F.30. pg_prewarm — 将关系数据预加载到缓冲区缓存中
