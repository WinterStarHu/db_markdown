# 14.1. 使用EXPLAIN

14.1. 使用EXPLAIN
版本：
纠错本页面
搜索
目录导航
❮
❯
14.1. 使用EXPLAIN #14.1.1. EXPLAIN 基础14.1.2. EXPLAIN ANALYZE14.1.3. 注意事项
PostgreSQL为每个收到查询产生一个查询计划。 选择正确的计划来匹配查询结构和数据的属性对于好的性能来说绝对是最关键的，因此系统包含了一个复杂的规划器来尝试选择好的计划。 你可以使用EXPLAIN命令察看规划器为任何查询生成的查询计划。 阅读查询计划是一门艺术，它要求一些经验来掌握，但是本节只试图覆盖一些基础。
本节中的示例来自回归测试数据库，经过一次
VACUUM ANALYZE，使用的是 v18 开发源代码。
如果您自己尝试这些示例，应该能够获得类似的结果，
但您的估算成本和行数可能会略有不同，因为
ANALYZE 的统计信息是随机样本而不是精确值，
并且成本本质上在某种程度上依赖于平台。
这些例子使用EXPLAIN的默认“text”输出格式，这种格式紧凑并且便于人类阅读。如果你想把EXPLAIN的输出交给一个程序做进一步分析，你应该使用它的某种机器可读的输出格式（XML、JSON 或 YAML）。
14.1.1. EXPLAIN 基础 #
查询计划的结构是一个计划节点的树。最底层的节点是扫描节点：它们从表中返回未经处理的行。 不同的表访问方法有不同的扫描节点类型：顺序扫描、索引扫描、位图索引扫描。 也还有不是表的行来源，例如VALUES子句和FROM中返回集合的函数，它们有自己的节点类型。如果查询需要连接、聚合、排序，或者在未经处理的行上的其他操作，那么就会在扫描节点之上有其他额外的节点来执行这些操作。 并且，做这些操作通常都有多种方法，因此在这些位置也有可能出现不同的节点类型。 EXPLAIN给计划树中每个节点都输出一行，显示基本的节点类型和计划器为该计划节点的执行所做的开销估计。 第一行（最上层的节点）是对该计划的总执行开销的估计；计划器试图最小化的就是这个数字。
这里是一个简单的示例，仅用于展示输出的样子：
EXPLAIN SELECT * FROM tenk1;
QUERY PLAN
-------------------------------------------------------------
Seq Scan on tenk1  (cost=0.00..445.00 rows=10000 width=244)
由于这个查询没有WHERE子句，它必须扫描表中的所有行，因此计划器只能选择使用一个简单的顺序扫描计划。被包含在圆括号中的数字是（从左至右）：
估计的启动开销。在输出阶段可以开始之前消耗的时间，例如在一个排序节点里执行排序的时间。
估计的总开销。这个估计值基于的假设是计划节点会被运行到完成，即所有可用的行都被检索。不过实际上一个节点的父节点可能很快停止读所有可用的行（见下面的LIMIT例子）。
这个计划节点输出行数的估计值。同样，也假定该节点能运行到完成。
预计这个计划节点输出的行平均宽度（以字节计算）。
开销是用规划器的开销参数（参见第 19.7.2 节）所决定的任意单位来衡量的。传统上以取磁盘页面为单位来度量开销；也就是seq_page_cost将被按照习惯设为1.0，其他开销参数将相对于它来设置。本节的例子都假定这些参数使用默认值。
理解一个上层节点的代价包含其所有子节点的代价是很重要的。同时也要明白，代价仅反映规划器关心的内容。特别是，代价不考虑将输出值转换为文本形式或传输给客户端所花费的时间，这些可能是实际耗时中的重要因素；但规划器忽略这些代价，因为它无法通过改变计划来影响它们。（我们相信每个正确的计划都会输出相同的行集。）
行数值有一些小技巧，因为它不是计划节点处理或扫描过的行数，而是该节点发出的行数。这通常比被扫描的行数少一些，因为有些被扫描的行会被应用于此节点上的任意WHERE子句条件过滤掉。理想中顶层的行估计会接近于查询实际返回、更新、删除的行数。
返回到我们的示例：
EXPLAIN SELECT * FROM tenk1;
QUERY PLAN
-------------------------------------------------------------
Seq Scan on tenk1  (cost=0.00..445.00 rows=10000 width=244)
这些数字的推导非常直接。如果你执行：
SELECT relpages, reltuples FROM pg_class WHERE relname = 'tenk1';
你会发现tenk1有345个磁盘页和10000行。估算的成本计算公式为（磁盘页读取数 *
seq_page_cost) + (扫描行数 *
cpu_tuple_cost）。默认情况下，
seq_page_cost为1.0，cpu_tuple_cost为0.01，
因此估算成本为(345 * 1.0) + (10000 * 0.01) = 445。
现在让我们修改查询，添加一个WHERE条件：
EXPLAIN SELECT * FROM tenk1 WHERE unique1 < 7000;
QUERY PLAN
------------------------------------------------------------
Seq Scan on tenk1  (cost=0.00..470.00 rows=7000 width=244)
Filter: (unique1 < 7000)
注意，EXPLAIN输出显示WHERE
子句作为附加到Seq Scan计划节点的“过滤器”条件。
这意味着计划节点会对它扫描的每一行检查该条件，并且只输出
通过条件的行。
输出行数的估计因为WHERE子句而减少了。
然而，扫描仍然需要访问所有10000行，所以成本并没有降低；
实际上它略有上升（确切地说是增加了10000 * cpu_operator_cost），以反映检查WHERE
条件所花费的额外CPU时间。
该查询实际选择的行数是7000，但rows估计值只是近似的。
如果你尝试重复这个实验，估计值可能会略有不同；此外，每次执行
ANALYZE命令后，估计值可能会变化，因为
ANALYZE产生的统计信息是从表的随机样本中获取的。
现在，让我们使条件更加严格：
EXPLAIN SELECT * FROM tenk1 WHERE unique1 < 100;
QUERY PLAN
-------------------------------------------------------------------
Bitmap Heap Scan on tenk1  (cost=5.06..224.98 rows=100 width=244)
Recheck Cond: (unique1 < 100)
->  Bitmap Index Scan on tenk1_unique1  (cost=0.00..5.04 rows=100 width=0)
Index Cond: (unique1 < 100)
这里规划器决定使用一个两步计划：子计划节点访问索引以查找符合索引条件的行的位置，
然后上层计划节点实际从表中获取这些行。单独获取行比顺序读取要昂贵得多，
但因为不必访问表的所有页面，这仍然比顺序扫描便宜。
（使用两级计划的原因是上层计划节点在读取之前将索引识别的行位置排序为物理顺序，
以最小化单独获取的成本。节点名称中提到的“bitmap”就是执行排序的机制。）
现在让我们在WHERE子句中添加另一个条件：
EXPLAIN SELECT * FROM tenk1 WHERE unique1 < 100 AND stringu1 = 'xxx';
QUERY PLAN
-------------------------------------------------------------------
Bitmap Heap Scan on tenk1  (cost=5.04..225.20 rows=1 width=244)
Recheck Cond: (unique1 < 100)
Filter: (stringu1 = 'xxx'::name)
->  Bitmap Index Scan on tenk1_unique1  (cost=0.00..5.04 rows=100 width=0)
Index Cond: (unique1 < 100)
添加的条件stringu1 = 'xxx'减少了输出行数的估计，但成本没有降低，
因为我们仍然必须访问相同的一组行。这是因为stringu1子句不能作为索引条件
应用，因为该索引仅针对unique1列。相反，它作为对使用索引检索的行的过滤器
应用。因此，成本实际上略有上升，以反映这额外的检查。
在某些情况下规划器将更倾向于一个“simple”索引扫描计划：
EXPLAIN SELECT * FROM tenk1 WHERE unique1 = 42;
QUERY PLAN
-------------------------------------------------------------------
Index Scan using tenk1_unique1 on tenk1  (cost=0.29..8.30 rows=1 width=244)
Index Cond: (unique1 = 42)
在这类计划中，表行被按照索引顺序取得，这使得读取它们开销更高，但是其中有一些是对行位置排序的额外开销。
你很多时候将在只取得一个单一行的查询中看到这种计划类型。
它也经常被用于拥有匹配索引顺序的ORDER BY子句的查询中，
因为那样就不需要额外的排序步骤来满足ORDER BY。在此示例中，添加
ORDER BY unique1将使用相同的计划，因为索引已经隐式提供了请求的排序。
规划器可能通过多种方式实现一个ORDER BY子句。上述示例表明，
这样的排序子句可以隐式实现。规划器也可以添加一个显式的
Sort步骤：
EXPLAIN SELECT * FROM tenk1 ORDER BY unique1;
QUERY PLAN
-------------------------------------------------------------------
Sort  (cost=1109.39..1134.39 rows=10000 width=244)
Sort Key: unique1
->  Seq Scan on tenk1  (cost=0.00..445.00 rows=10000 width=244)
如果计划的一部分保证了所需排序键前缀的顺序，那么规划器可能会改为使用
一个Incremental Sort步骤：
EXPLAIN SELECT * FROM tenk1 ORDER BY hundred, ten LIMIT 100;
QUERY PLAN
-------------------------------------------------------------------
Limit  (cost=19.35..39.49 rows=100 width=244)
->  Incremental Sort  (cost=19.35..2033.39 rows=10000 width=244)
Sort Key: hundred, ten
Presorted Key: hundred
->  Index Scan using tenk1_hundred on tenk1  (cost=0.29..1574.20 rows=10000 width=244)
与常规排序相比，增量排序允许在整个结果集排序完成之前返回元组，这特别
使得带有LIMIT查询的优化成为可能。它还可能减少内存使用
以及排序溢写到磁盘的可能性，但代价是将结果集拆分成多个排序批次所带来的
额外开销。
如果在WHERE中引用的多个列上有单独的索引，规划器可能会选择使用这些索引的AND或OR组合：
EXPLAIN SELECT * FROM tenk1 WHERE unique1 < 100 AND unique2 > 9000;
QUERY PLAN
-------------------------------------------------------------------​------------------
Bitmap Heap Scan on tenk1  (cost=25.07..60.11 rows=10 width=244)
Recheck Cond: ((unique1 < 100) AND (unique2 > 9000))
->  BitmapAnd  (cost=25.07..25.07 rows=10 width=0)
->  Bitmap Index Scan on tenk1_unique1  (cost=0.00..5.04 rows=100 width=0)
Index Cond: (unique1 < 100)
->  Bitmap Index Scan on tenk1_unique2  (cost=0.00..19.78 rows=999 width=0)
Index Cond: (unique2 > 9000)
但这需要访问两个索引，因此与仅使用一个索引并将另一个条件视为过滤条件相比，不一定是优势。
如果你改变涉及的范围，你会看到计划相应地发生变化。
下面是一个展示 LIMIT 效果的示例：
EXPLAIN SELECT * FROM tenk1 WHERE unique1 < 100 AND unique2 > 9000 LIMIT 2;
QUERY PLAN
-------------------------------------------------------------------​------------------
Limit  (cost=0.29..14.28 rows=2 width=244)
->  Index Scan using tenk1_unique2 on tenk1  (cost=0.29..70.27 rows=10 width=244)
Index Cond: (unique2 > 9000)
Filter: (unique1 < 100)
这是和上面相同的查询，但是我们增加了一个LIMIT这样不是所有的行都需要被检索，并且规划器改变了它的决定。注意索引扫描节点的总开销和行计数显示出好像它会被运行到完成。但是，限制节点在检索到这些行的五分之一后就会停止，因此它的总开销只是索引扫描节点的五分之一，并且这是查询的实际估计开销。之所以用这个计划而不是在之前的计划上增加一个限制节点是因为限制无法避免在位图扫描上花费启动开销，因此总开销会是超过那种方法（25个单位）的某个值。
让我们尝试连接两个表，使用我们一直在讨论的列：
EXPLAIN SELECT *
FROM tenk1 t1, tenk2 t2
WHERE t1.unique1 < 10 AND t1.unique2 = t2.unique2;
QUERY PLAN
-------------------------------------------------------------------​-------------------
Nested Loop  (cost=4.65..118.50 rows=10 width=488)
->  Bitmap Heap Scan on tenk1 t1  (cost=4.36..39.38 rows=10 width=244)
Recheck Cond: (unique1 < 10)
->  Bitmap Index Scan on tenk1_unique1  (cost=0.00..4.36 rows=10 width=0)
Index Cond: (unique1 < 10)
->  Index Scan using tenk2_unique2 on tenk2 t2  (cost=0.29..7.90 rows=1 width=244)
Index Cond: (unique2 = t1.unique2)
在此计划中，我们有一个嵌套循环连接节点，其输入或子节点是两个表扫描。节点摘要行的缩进
反映了计划树的结构。连接的第一个，或“外部”子节点是一个类似于之前看到的位图扫描。
它的成本和行数与我们从SELECT ... WHERE unique1 < 10中得到的相同，
因为我们在该节点应用了WHERE子句unique1 < 10。
t1.unique2 = t2.unique2子句尚不相关，因此不会影响外部扫描的行数。
嵌套循环连接节点将针对从外部子节点获得的每一行运行其第二个，或“内部”子节点一次。
当前外部行的列值可以插入到内部扫描中；这里，外部行的t1.unique2值是可用的，
因此我们得到的计划和成本类似于上面看到的简单SELECT ... WHERE t2.unique2 = constant情况。
（估计成本实际上比上面看到的略低，这是由于在对t2进行重复索引扫描时预期发生的缓存。）
循环节点的成本随后基于外部扫描的成本，加上每个外部行一次的内部扫描（10 * 7.90），
以及一些用于连接处理的CPU时间来设定。
在这个例子中，连接的输出行数与两个扫描的行数乘积相同，但这并非在所有情况下都成立，
因为可能存在额外的WHERE子句同时涉及两个表，因此只能在连接点应用，
不能应用于任一输入扫描。下面是一个例子：
EXPLAIN SELECT *
FROM tenk1 t1, tenk2 t2
WHERE t1.unique1 < 10 AND t2.unique2 < 10 AND t1.hundred < t2.hundred;
QUERY PLAN
-------------------------------------------------------------------​--------------------------
Nested Loop  (cost=4.65..49.36 rows=33 width=488)
Join Filter: (t1.hundred < t2.hundred)
->  Bitmap Heap Scan on tenk1 t1  (cost=4.36..39.38 rows=10 width=244)
Recheck Cond: (unique1 < 10)
->  Bitmap Index Scan on tenk1_unique1  (cost=0.00..4.36 rows=10 width=0)
Index Cond: (unique1 < 10)
->  Materialize  (cost=0.29..8.51 rows=10 width=244)
->  Index Scan using tenk2_unique2 on tenk2 t2  (cost=0.29..8.46 rows=10 width=244)
Index Cond: (unique2 < 10)
条件t1.hundred < t2.hundred无法在tenk2_unique2索引中
测试，因此它在连接节点处应用。这减少了连接节点的估计输出行数，但不改变任一输入扫描。
注意这里规划器选择了“物化”连接的 inner 关系，方法是在它的上方放了一个物化计划节点。这意味着t2索引扫描将只被做一次，即使嵌套循环连接节点需要读取其数据十次（每个来自 outer 关系的行都要读一次）。物化节点在读取数据时将它保存在内存中，然后在每一次后续执行时从内存返回数据。
在处理外连接时，你可能会看到连接计划节点同时附加有“连接过滤器”和普通“过滤器”条件。连接过滤器条件来自于外连接的ON子句，因此一个无法通过连接过滤器条件的行也能够作为一个空值扩展的行被发出。但是一个普通过滤器条件被应用在外连接条件之后并且因此无条件移除行。在一个内连接中这两种过滤器类型没有语义区别。
如果我们稍微改变查询的选择性，可能会得到一个非常不同的连接计划：
EXPLAIN SELECT *
FROM tenk1 t1, tenk2 t2
WHERE t1.unique1 < 100 AND t1.unique2 = t2.unique2;
QUERY PLAN
-------------------------------------------------------------------​-----------------------
Hash Join  (cost=226.23..709.73 rows=100 width=488)
Hash Cond: (t2.unique2 = t1.unique2)
->  Seq Scan on tenk2 t2  (cost=0.00..445.00 rows=10000 width=244)
->  Hash  (cost=224.98..224.98 rows=100 width=244)
->  Bitmap Heap Scan on tenk1 t1  (cost=5.06..224.98 rows=100 width=244)
Recheck Cond: (unique1 < 100)
->  Bitmap Index Scan on tenk1_unique1  (cost=0.00..5.04 rows=100 width=0)
Index Cond: (unique1 < 100)
这里规划器选择了使用一个哈希连接，在其中一个表的行被放入一个内存哈希表，在这之后其他表被扫描并且为每一行查找哈希表来寻找匹配。同样要注意缩进是如何反映计划结构的：tenk1上的位图扫描是哈希节点的输入，哈希节点会构造哈希表。然后哈希表会返回给哈希连接节点，哈希连接节点将从它的外层子计划读取行，并为每一个行搜索哈希表。
另一种可能的连接类型是合并连接，示例如下：
EXPLAIN SELECT *
FROM tenk1 t1, onek t2
WHERE t1.unique1 < 100 AND t1.unique2 = t2.unique2;
QUERY PLAN
-------------------------------------------------------------------​-----------------------
Merge Join  (cost=0.56..233.49 rows=10 width=488)
Merge Cond: (t1.unique2 = t2.unique2)
->  Index Scan using tenk1_unique2 on tenk1 t1  (cost=0.29..643.28 rows=100 width=244)
Filter: (unique1 < 100)
->  Index Scan using onek_unique2 on onek t2  (cost=0.28..166.28 rows=1000 width=244)
合并连接要求其输入数据在连接键上已排序。在此示例中，每个输入都通过使用索引扫描按正确顺序访问行来排序；但也可以使用顺序扫描和排序。（顺序扫描和排序通常在排序大量行时优于索引扫描，因为索引扫描需要非顺序的磁盘访问。）
一种看待变体计划的方法是强制规划器忽略它认为最便宜的任何策略，使用第 19.7.1 节中描述的启用/禁用标志。
（这是一个粗糙的工具，但很有用。另见第 14.3 节。）
例如，如果我们不确定合并连接是否是前面示例中最好的连接类型，我们可以尝试
SET enable_mergejoin = off;
EXPLAIN SELECT *
FROM tenk1 t1, onek t2
WHERE t1.unique1 < 100 AND t1.unique2 = t2.unique2;
QUERY PLAN
-------------------------------------------------------------------​-----------------------
Hash Join  (cost=226.23..344.08 rows=10 width=488)
Hash Cond: (t2.unique2 = t1.unique2)
->  Seq Scan on onek t2  (cost=0.00..114.00 rows=1000 width=244)
->  Hash  (cost=224.98..224.98 rows=100 width=244)
->  Bitmap Heap Scan on tenk1 t1  (cost=5.06..224.98 rows=100 width=244)
Recheck Cond: (unique1 < 100)
->  Bitmap Index Scan on tenk1_unique1  (cost=0.00..5.04 rows=100 width=0)
Index Cond: (unique1 < 100)
这表明规划器认为哈希连接在这种情况下的成本比合并连接高出近50%。
当然，下一个问题是它是否正确。
我们可以使用EXPLAIN ANALYZE来调查，如下面所述。
使用启用/禁用标志来禁用计划节点类型时，许多标志仅仅是劝阻使用相应的计划节点，并不完全禁止规划器使用该计划节点类型。这是出于设计考虑，以便规划器仍然能够为给定查询形成一个计划。当生成的计划包含一个禁用节点时，EXPLAIN 输出将指明这一事实。
SET enable_seqscan = off;
EXPLAIN SELECT * FROM unit;
QUERY PLAN
-------------------------------------------------------------------
Seq Scan on unit  (cost=0.00..21.30 rows=1130 width=44)
Disabled: true
因为 unit 表没有索引，所以没有其他方法可以读取表数据，因此顺序扫描是查询规划器唯一可用的选项。
一些查询计划涉及子计划，它们源自原始查询中的子SELECT。这类查询有时可以转换为普通的连接计划，但当无法转换时，我们会得到如下计划：
EXPLAIN VERBOSE SELECT unique1
FROM tenk1 t
WHERE t.ten < ALL (SELECT o.ten FROM onek o WHERE o.four = t.four);
QUERY PLAN
-------------------------------------------------------------------​------
Seq Scan on public.tenk1 t  (cost=0.00..586095.00 rows=5000 width=4)
Output: t.unique1
Filter: (ALL (t.ten < (SubPlan 1).col1))
SubPlan 1
->  Seq Scan on public.onek o  (cost=0.00..116.50 rows=250 width=4)
Output: o.ten
Filter: (o.four = t.four)
这个相当人为的例子用来说明几点：外层计划级别的值可以传递到子计划（这里，t.four 被传递下去），且子查询的结果可供外层计划使用。那些结果值由EXPLAIN以类似(subplan_name).colN的标记显示，指的是子SELECT的第N个输出列。
在上面的示例中，ALL操作符会对外部查询的每一行重新运行
子计划（这也是估算成本较高的原因）。有些查询可以使用哈希子计划
来避免这种情况：
EXPLAIN SELECT *
FROM tenk1 t
WHERE t.unique1 NOT IN (SELECT o.unique1 FROM onek o);
QUERY PLAN
-------------------------------------------------------------------​-------------------------
Seq Scan on tenk1 t  (cost=61.77..531.77 rows=5000 width=244)
Filter: (NOT (ANY (unique1 = (hashed SubPlan 1).col1)))
SubPlan 1
->  Index Only Scan using onek_unique1 on onek o  (cost=0.28..59.27 rows=1000 width=4)
(4 rows)
这里，子计划只运行一次，其输出被加载到内存中的哈希表中，随后由外部的
ANY操作符进行探测。这要求子SELECT不能引用
外部查询的任何变量，并且ANY的比较操作符必须适合哈希处理。
如果除了不引用外层查询的任何变量之外，子-SELECT不能返回多于一行，
它也可以被实现为一个initplan：
EXPLAIN VERBOSE SELECT unique1
FROM tenk1 t1 WHERE t1.ten = (SELECT (random() * 10)::integer);
QUERY PLAN
------------------------------------------------------------​--------
Seq Scan on public.tenk1 t1  (cost=0.02..470.02 rows=1000 width=4)
Output: t1.unique1
Filter: (t1.ten = (InitPlan 1).col1)
InitPlan 1
->  Result  (cost=0.00..0.02 rows=1 width=4)
Output: ((random() * '10'::double precision))::integer
一个initplan在外层计划的每次执行中只运行一次，其结果会被保存以便在外层计划的后续行中重用。
因此在这个例子中，random()只被计算一次，所有的t1.ten的值都
与同一个随机选择的整数进行比较。这与没有子-SELECT结构时的情况大不相同。
14.1.2. EXPLAIN ANALYZE #
可以通过使用 EXPLAIN 的 ANALYZE 选项来检查
规划器估算的准确性。使用此选项时，
EXPLAIN 实际执行查询，然后显示
每个计划节点内累积的真实行数和真实运行时间，
以及普通 EXPLAIN 显示的相同估算值。
例如，我们可能会得到如下结果：
EXPLAIN ANALYZE SELECT *
FROM tenk1 t1, tenk2 t2
WHERE t1.unique1 < 10 AND t1.unique2 = t2.unique2;
QUERY PLAN
-------------------------------------------------------------------​--------------------------------------------------------------
Nested Loop  (cost=4.65..118.50 rows=10 width=488) (actual time=0.017..0.051 rows=10.00 loops=1)
Buffers: shared hit=36 read=6
->  Bitmap Heap Scan on tenk1 t1  (cost=4.36..39.38 rows=10 width=244) (actual time=0.009..0.017 rows=10.00 loops=1)
Recheck Cond: (unique1 < 10)
Heap Blocks: exact=10
Buffers: shared hit=3 read=5 written=4
->  Bitmap Index Scan on tenk1_unique1  (cost=0.00..4.36 rows=10 width=0) (actual time=0.004..0.004 rows=10.00 loops=1)
Index Cond: (unique1 < 10)
Index Searches: 1
Buffers: shared hit=2
->  Index Scan using tenk2_unique2 on tenk2 t2  (cost=0.29..7.90 rows=1 width=244) (actual time=0.003..0.003 rows=1.00 loops=10)
Index Cond: (unique2 = t1.unique2)
Index Searches: 10
Buffers: shared hit=24 read=6
Planning:
Buffers: shared hit=15 dirtied=9
Planning Time: 0.485 ms
Execution Time: 0.073 ms
请注意，“实际时间” 值以毫秒为单位，
而 成本 估算以任意单位表示；
因此它们不太可能完全匹配。
通常最重要的是查看估算的行数是否与实际情况相当接近。
在这个例子中，所有的估算都是准确的，但在实际中这相当不寻常。
在某些查询计划中，子计划节点可能会被执行多次。例如，上述嵌套循环计划中，
内部索引扫描将针对外部的每一行执行一次。在这种情况下，loops值
报告节点的总执行次数，显示的实际时间和行数值是每次执行的平均值。这样做是为了
使数字与成本估算的显示方式相匹配。将该值乘以loops即可获得
节点实际花费的总时间。在上述示例中，我们总共花费了0.030毫秒执行tenk2上的索引扫描。
在某些情况下，EXPLAIN ANALYZE 显示的执行
统计信息超出了计划节点的执行时间和行数。
例如，排序和哈希节点提供额外的信息：
EXPLAIN ANALYZE SELECT *
FROM tenk1 t1, tenk2 t2
WHERE t1.unique1 < 100 AND t1.unique2 = t2.unique2 ORDER BY t1.fivethous;
QUERY PLAN
-------------------------------------------------------------------​-------------------------------------------------------------------​------
Sort  (cost=713.05..713.30 rows=100 width=488) (actual time=2.995..3.002 rows=100.00 loops=1)
Sort Key: t1.fivethous
Sort Method: quicksort  Memory: 74kB
Buffers: shared hit=440
->  Hash Join  (cost=226.23..709.73 rows=100 width=488) (actual time=0.515..2.920 rows=100.00 loops=1)
Hash Cond: (t2.unique2 = t1.unique2)
Buffers: shared hit=437
->  Seq Scan on tenk2 t2  (cost=0.00..445.00 rows=10000 width=244) (actual time=0.026..1.790 rows=10000.00 loops=1)
Buffers: shared hit=345
->  Hash  (cost=224.98..224.98 rows=100 width=244) (actual time=0.476..0.477 rows=100.00 loops=1)
Buckets: 1024  Batches: 1  Memory Usage: 35kB
Buffers: shared hit=92
->  Bitmap Heap Scan on tenk1 t1  (cost=5.06..224.98 rows=100 width=244) (actual time=0.030..0.450 rows=100.00 loops=1)
Recheck Cond: (unique1 < 100)
Heap Blocks: exact=90
Buffers: shared hit=92
->  Bitmap Index Scan on tenk1_unique1  (cost=0.00..5.04 rows=100 width=0) (actual time=0.013..0.013 rows=100.00 loops=1)
Index Cond: (unique1 < 100)
Index Searches: 1
Buffers: shared hit=2
Planning:
Buffers: shared hit=12
Planning Time: 0.187 ms
Execution Time: 3.036 ms
排序节点显示了使用的排序方法（特别是排序是在内存中还是在磁盘上）以及所需的内存或磁盘空间。
哈希节点显示哈希桶和批次的数量，以及哈希表使用的峰值内存量。
（如果批次数量超过一个，则还会涉及磁盘空间使用，但这没有显示。）
索引扫描节点（以及位图索引扫描和仅索引扫描节点）
显示一个 “索引搜索” 行，报告在
所有 节点执行/循环 中的搜索总数：
EXPLAIN ANALYZE SELECT * FROM tenk1 WHERE thousand IN (1, 500, 700, 999);
QUERY PLAN
-------------------------------------------------------------------​---------------------------------------------------------------
Bitmap Heap Scan on tenk1  (cost=9.45..73.44 rows=40 width=244) (actual time=0.012..0.028 rows=40.00 loops=1)
Recheck Cond: (thousand = ANY ('{1,500,700,999}'::integer[]))
Heap Blocks: exact=39
Buffers: shared hit=47
->  Bitmap Index Scan on tenk1_thous_tenthous  (cost=0.00..9.44 rows=40 width=0) (actual time=0.009..0.009 rows=40.00 loops=1)
Index Cond: (thousand = ANY ('{1,500,700,999}'::integer[]))
Index Searches: 4
Buffers: shared hit=8
Planning Time: 0.029 ms
Execution Time: 0.034 ms
在这里我们看到一个位图索引扫描节点需要 4 次单独的索引
搜索。扫描必须从
tenk1_thous_tenthous 索引根页面对谓词的
IN 结构中的每个 integer 值进行一次搜索。
然而，索引搜索的数量通常不会与查询谓词有如此简单的对应关系：
EXPLAIN ANALYZE SELECT * FROM tenk1 WHERE thousand IN (1, 2, 3, 4);
QUERY PLAN
-------------------------------------------------------------------​---------------------------------------------------------------
Bitmap Heap Scan on tenk1  (cost=9.45..73.44 rows=40 width=244) (actual time=0.009..0.019 rows=40.00 loops=1)
Recheck Cond: (thousand = ANY ('{1,2,3,4}'::integer[]))
Heap Blocks: exact=38
Buffers: shared hit=40
->  Bitmap Index Scan on tenk1_thous_tenthous  (cost=0.00..9.44 rows=40 width=0) (actual time=0.005..0.005 rows=40.00 loops=1)
Index Cond: (thousand = ANY ('{1,2,3,4}'::integer[]))
Index Searches: 1
Buffers: shared hit=2
Planning Time: 0.029 ms
Execution Time: 0.026 ms
这个变体的 IN 查询只执行了 1 次索引
搜索。与原始查询相比，它在遍历索引时花费的时间更少，因为它的
IN 结构使用了相邻存储的索引元组的值，
在同一个 tenk1_thous_tenthous 索引叶页面上。
“索引搜索” 行在应用 跳过扫描 优化的 B-tree 索引
扫描中也很有用，以更有效地遍历索引：
EXPLAIN ANALYZE SELECT four, unique1 FROM tenk1 WHERE four BETWEEN 1 AND 3 AND unique1 = 42;
QUERY PLAN
-------------------------------------------------------------------​---------------------------------------------------------------
Index Only Scan using tenk1_four_unique1_idx on tenk1  (cost=0.29..6.90 rows=1 width=8) (actual time=0.006..0.007 rows=1.00 loops=1)
Index Cond: ((four >= 1) AND (four <= 3) AND (unique1 = 42))
Heap Fetches: 0
Index Searches: 3
Buffers: shared hit=7
Planning Time: 0.029 ms
Execution Time: 0.012 ms
在这里我们看到一个使用
tenk1_four_unique1_idx 的仅索引扫描节点，
这是一个多列索引，包含 tenk1 表的
four 和 unique1 列。
扫描执行了 3 次搜索，每次读取一个索引叶页面：
“four = 1 AND unique1 = 42”,
“four = 2 AND unique1 = 42” 和
“four = 3 AND unique1 = 42”。这个索引
通常是跳过扫描的良好目标，因为正如在
第 11.3 节 中讨论的那样，
它的首列（four 列）仅包含 4 个不同的值，
而其第二/最后一列（unique1 列）包含许多不同的值。
另一种额外信息是通过过滤条件移除的行数：
EXPLAIN ANALYZE SELECT * FROM tenk1 WHERE ten < 7;
QUERY PLAN
-------------------------------------------------------------------​--------------------------------------
Seq Scan on tenk1  (cost=0.00..470.00 rows=7000 width=244) (actual time=0.030..1.995 rows=7000.00 loops=1)
Filter: (ten < 7)
Rows Removed by Filter: 3000
Buffers: shared hit=345
Planning Time: 0.102 ms
Execution Time: 2.145 ms
这些计数对于在连接节点应用的过滤条件特别有价值。
“移除的行” 行仅在至少有一行被扫描或在连接节点的情况下
被过滤条件拒绝时出现。
与过滤条件类似的情况发生在 “损失” 索引扫描中。
例如，考虑这个搜索包含特定点的多边形：
EXPLAIN ANALYZE SELECT * FROM polygon_tbl WHERE f1 @> polygon '(0.5,2.0)';
QUERY PLAN
-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-​-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-
Seq Scan on polygon_tbl  (cost=0.00..1.09 rows=1 width=85) (actual time=0.023..0.023 rows=0.00 loops=1)
Filter: (f1 @> '((0.5,2))'::polygon)
Rows Removed by Filter: 7
Buffers: shared hit=1
Planning Time: 0.039 ms
Execution Time: 0.033 ms
规划器认为（非常正确）这个示例表太小，不值得进行索引扫描，
因此我们有一个普通的顺序扫描，其中所有行都被过滤条件拒绝。
但是如果我们强制使用索引扫描，我们会看到：
SET enable_seqscan TO off;
EXPLAIN ANALYZE SELECT * FROM polygon_tbl WHERE f1 @> polygon '(0.5,2.0)';
QUERY PLAN
-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-​-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-
Index Scan using gpolygonind on polygon_tbl  (cost=0.13..8.15 rows=1 width=85) (actual time=0.074..0.074 rows=0.00 loops=1)
Index Cond: (f1 @> '((0.5,2))'::polygon)
Rows Removed by Index Recheck: 1
Index Searches: 1
Buffers: shared hit=1
Planning Time: 0.039 ms
Execution Time: 0.098 ms
在这里我们可以看到索引返回了一个候选行，
然后被索引条件的重新检查拒绝。这是因为 GiST 索引在多边形包含测试中是 “损失” 的：
它实际上返回与目标重叠的多边形的行，然后我们必须对这些行进行精确的包含测试。
EXPLAIN 有一个 BUFFERS 选项，
提供有关在给定查询的规划和执行过程中执行的 I/O 操作的额外细节。
显示的缓冲区编号显示了给定节点及其所有子节点的非重复缓冲区命中、读取、脏写和写入的计数。
ANALYZE 选项隐式启用 BUFFERS 选项。
如果不希望这样，可以显式禁用 BUFFERS：
EXPLAIN (ANALYZE, BUFFERS OFF) SELECT * FROM tenk1 WHERE unique1 < 100 AND unique2 > 9000;
QUERY PLAN
-------------------------------------------------------------------​--------------------------------------------------------------
Bitmap Heap Scan on tenk1  (cost=25.07..60.11 rows=10 width=244) (actual time=0.105..0.114 rows=10.00 loops=1)
Recheck Cond: ((unique1 < 100) AND (unique2 > 9000))
Heap Blocks: exact=10
->  BitmapAnd  (cost=25.07..25.07 rows=10 width=0) (actual time=0.100..0.101 rows=0.00 loops=1)
->  Bitmap Index Scan on tenk1_unique1  (cost=0.00..5.04 rows=100 width=0) (actual time=0.027..0.027 rows=100.00 loops=1)
Index Cond: (unique1 < 100)
Index Searches: 1
->  Bitmap Index Scan on tenk1_unique2  (cost=0.00..19.78 rows=999 width=0) (actual time=0.070..0.070 rows=999.00 loops=1)
Index Cond: (unique2 > 9000)
Index Searches: 1
Planning Time: 0.162 ms
Execution Time: 0.143 ms
请记住，因为 EXPLAIN ANALYZE 实际上
运行查询，因此任何副作用将照常发生，即使
查询可能输出的任何结果也会被丢弃，以便打印
EXPLAIN 数据。如果您想分析一个
修改数据的查询而不更改您的表，您可以
在之后回滚该命令，例如：
BEGIN;
EXPLAIN ANALYZE UPDATE tenk1 SET hundred = hundred + 1 WHERE unique1 < 100;
QUERY PLAN
-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-​-−-−-−-−-−-−-−-−-−-−-
Update on tenk1  (cost=5.06..225.23 rows=0 width=0) (actual time=1.634..1.635 rows=0.00 loops=1)
->  Bitmap Heap Scan on tenk1  (cost=5.06..225.23 rows=100 width=10) (actual time=0.065..0.141 rows=100.00 loops=1)
Recheck Cond: (unique1 < 100)
Heap Blocks: exact=90
Buffers: shared hit=4 read=2
->  Bitmap Index Scan on tenk1_unique1  (cost=0.00..5.04 rows=100 width=0) (actual time=0.031..0.031 rows=100.00 loops=1)
Index Cond: (unique1 < 100)
Index Searches: 1
Buffers: shared read=2
Planning Time: 0.151 ms
Execution Time: 1.856 ms
ROLLBACK;
如本例所示，当查询是INSERT、UPDATE、
DELETE或MERGE命令时，应用表更改的实际工作
是由顶层的Insert、Update、Delete或Merge计划节点完成的。在这个节点下面的计划节点
执行定位旧行和/或计算新数据的工作。因此，在上面，我们看到了已经看过的相同类型的
位图表扫描，其输出被传递给一个存储更新行的Update节点。值得注意的是，虽然修改数据
的节点可能需要相当长的运行时间（这里，它占用了大部分时间），但规划器目前不会为此
工作添加任何成本估算。这是因为要执行的工作对于每个正确的查询计划都是相同的，
因此它不会影响规划决策。
当一个 UPDATE、DELETE 或
MERGE 命令影响一个分区表或继承层次结构时，
输出可能如下所示：
EXPLAIN UPDATE gtest_parent SET f1 = CURRENT_DATE WHERE f2 = 101;
QUERY PLAN
-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-−-​-−-−-−-−-−-−-−-−-−-−-
Update on gtest_parent  (cost=0.00..3.06 rows=0 width=0)
Update on gtest_child gtest_parent_1
Update on gtest_child2 gtest_parent_2
Update on gtest_child3 gtest_parent_3
->  Append  (cost=0.00..3.06 rows=3 width=14)
->  Seq Scan on gtest_child gtest_parent_1  (cost=0.00..1.01 rows=1 width=14)
Filter: (f2 = 101)
->  Seq Scan on gtest_child2 gtest_parent_2  (cost=0.00..1.01 rows=1 width=14)
Filter: (f2 = 101)
->  Seq Scan on gtest_child3 gtest_parent_3  (cost=0.00..1.01 rows=1 width=14)
Filter: (f2 = 101)
在此示例中，Update 节点需要考虑三个子表，但不包括最初提到的分区表
（因为它从不存储任何数据）。因此，有三个输入扫描子计划，每个表一个。
为了清晰起见，Update 节点被注释以显示将被更新的具体目标表，顺序与相应的
子计划相同。
EXPLAIN ANALYZE显示的
Planning time是从一个已解析的查询生成查询计划并进行优化
所花费的时间，其中不包括解析和重写。
EXPLAIN ANALYZE显示的Execution time包括执行器的启动和关闭时间，以及运行被触发的任何触发器的时间，但是它不包括解析、重写或规划的时间。如果有花在执行BEFORE执行器的时间，它将被包括在相关的插入、更新或删除结点的时间内；但是用来执行AFTER 触发器的时间没有被计算，因为AFTER触发器是在整个计划完成后被触发的。在每个触发器（BEFORE或AFTER）也被独立地显示。注意延迟约束触发器将不会被执行，直到事务结束，并且因此根本不会被EXPLAIN ANALYZE考虑。
顶层节点显示的时间不包括将查询的输出数据转换为可显示形式或发送给客户端所需的任何时间。
虽然EXPLAIN ANALYZE永远不会将数据发送给客户端，但可以通过指定SERIALIZE选项，
告诉它将查询的输出数据转换为可显示形式并测量所需时间。该时间将单独显示，
并且也包含在总的Execution time中。
14.1.3. 注意事项 #
由EXPLAIN ANALYZE测量的运行时间与同一查询的正常执行时间存在两种显著的偏差。
首先，由于没有输出行传送给客户端，网络传输成本未被计入。除非指定了SERIALIZE，否则
也不包括I/O转换成本。其次，EXPLAIN ANALYZE增加的测量开销可能很大，尤其是在
具有较慢gettimeofday()操作系统调用的机器上。您可以使用pg_test_timing
工具来测量系统上的计时开销。
EXPLAIN结果不应该被外推到与你实际测试的非常不同的情况。例如，一个很小的表上的结果不能被假定成适合大型表。规划器的开销估计不是线性的，并且因此它可能为一个更大或更小的表选择一个不同的计划。一个极端例子是，在一个只占据一个磁盘页面的表上，你将几乎总是得到一个顺序扫描计划，而不管索引是否可用。规划器认识到它在任何情况下都将采用一次磁盘页面读取来处理该表，因此用额外的页面读取去查看一个索引是没有价值的（我们已经在前面的polygon_tbl例子中见过）。
在某些情况下，实际值和估算值可能不会很好匹配，
但实际上并没有什么问题。一个这样的情况发生在
计划节点执行被 LIMIT 或类似效果提前停止时。
例如，在我们之前使用的 LIMIT 查询中，
EXPLAIN ANALYZE SELECT * FROM tenk1 WHERE unique1 < 100 AND unique2 > 9000 LIMIT 2;
QUERY PLAN
-------------------------------------------------------------------​------------------------------------------------------------
Limit  (cost=0.29..14.33 rows=2 width=244) (actual time=0.051..0.071 rows=2.00 loops=1)
Buffers: shared hit=16
->  Index Scan using tenk1_unique2 on tenk1  (cost=0.29..70.50 rows=10 width=244) (actual time=0.051..0.070 rows=2.00 loops=1)
Index Cond: (unique2 > 9000)
Filter: (unique1 < 100)
Rows Removed by Filter: 287
Index Searches: 1
Buffers: shared hit=16
Planning Time: 0.077 ms
Execution Time: 0.086 ms
索引扫描节点的估算成本和行数显示为
好像它已运行到完成。但实际上，Limit 节点在获取两行后停止
请求行，因此实际行数仅为 2，运行时间也少于成本估算所暗示的时间。
这不是估算错误，只是估算值和真实值显示方式的差异。
归并连接也有测量伪影，可能会让不知情的人感到困惑。
如果一个归并连接用尽了一个输入并且其中的下一个键值大于另一个输入中的最后一个键值，它将停止读取该输入；
在这种情况下，不会有更多的匹配，因此不需要扫描第一个输入的其余部分。这会导致不读取一个子节点的所有内容，其结果就像在LIMIT中所提到的。另外，如果外部（第一个）子节点包含带有重复键值的行，内部（第二个）子节点会被倒退并且被重新扫描以匹配那个键值。EXPLAIN ANALYZE会将相同内部行的重复发出统计为真实的额外行。当有很多外部重复时，内部子计划节点所报告的实际行计数可能显著大于实际在内部关系中的行数。
由于实现的限制，BitmapAnd 和 BitmapOr 节点总是报告它们的实际行计数为零。
通常，EXPLAIN将显示规划器生成的每个计划节点。
但是，在某些情况下，执行器可以不执行某些节点，因为根据规划时不可用的参数值能确定这些节点无法产生任何行。
（当前，这仅会在扫描分区表的Append或MergeAppend节点的子节点中发生。）
发生这种情况时，将从EXPLAIN输出中省略这些计划节点，并显示Subplans Removed：N的标识。
上一页 上一级 下一页第 14 章 性能提示 起始页 14.2. 规划器使用的统计信息
