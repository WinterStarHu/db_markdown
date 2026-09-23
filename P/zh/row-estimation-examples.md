# 69.1. 行估计示例

69.1. 行估计示例
版本：
纠错本页面
搜索
目录导航
❮
❯
69.1. 行估计示例 #
下面显示的示例使用了PostgreSQL回归测试数据库中的表。还要注意，由于ANALYZE在生成统计信息时使用随机抽样，因此在每次新的ANALYZE之后，结果会略有变化。
让我们从一个很简单的查询开始：
EXPLAIN SELECT * FROM tenk1;
QUERY PLAN
-------------------------------------------------------------
Seq Scan on tenk1  (cost=0.00..458.00 rows=10000 width=244)
规划器如何判断tenk1的势在第 14.2 节中介绍，但为了完整还会在这里重复介绍。行数或页数是从pg_class中查出来的：
SELECT relpages, reltuples FROM pg_class WHERE relname = 'tenk1';
relpages | reltuples
----------+-----------
358 |     10000
这些数字是在表上的最后一次VACUUM或ANALYZE以来的当前值。之后，规划器取出该表中实际的当前页数（这个操作的开销很小，不需要扫描全表）。如果与relpages不同，则对reltuples进行相应的缩放以得到一个当前的行数估计。在上面的例子中，relpages的值是最新的，因此行估计与reltuples相同。
换一个在WHERE子句中带有范围条件的例子：
EXPLAIN SELECT * FROM tenk1 WHERE unique1 < 1000;
QUERY PLAN
-------------------------------------------------------------------
Bitmap Heap Scan on tenk1  (cost=24.06..394.64 rows=1007 width=244)
Recheck Cond: (unique1 < 1000)
->  Bitmap Index Scan on tenk1_unique1  (cost=0.00..23.80 rows=1007 width=0)
Index Cond: (unique1 < 1000)
规划器检查WHERE子句条件，并在pg_operator中查找<操作符的选择度函数。这被保持在oprrest列中，并且在这个例子中的项是scalarltsel。scalarltsel函数从pg_statistic为unique1检索直方图。对于手工查询来说，查看更简单的pg_stats视图会更方便：
SELECT histogram_bounds FROM pg_stats
WHERE tablename='tenk1' AND attname='unique1';
histogram_bounds
------------------------------------------------------
{0,993,1997,3050,4040,5036,5957,7057,8029,9016,9995}
然后，把直方图里面被“< 1000”占据的部分找出来。这就是选择度。直方图把范围分隔成等频的桶，所以我们要做的只是把我们的值所在的桶找出来，然后计数其中的部分以及所有该值之前的部分。值1000很明显在第二个桶（993–1997）中。假设每个桶中的值是线性分布，那么就可以计算出选择度：
selectivity = (1 + (1000 - bucket[2].min)/(bucket[2].max - bucket[2].min))/num_buckets
= (1 + (1000 - 993)/(1997 - 993))/10
= 0.100697
也就是一整个桶加上第二个桶的线性部分，除以桶数。那么估计的行数现在可以用选择度乘以tenk1的势来计算：
rows = rel_cardinality * selectivity
= 10000 * 0.100697
= 1007  (rounding off)
然后让我们考虑一个在WHERE子句有等于条件的例子：
EXPLAIN SELECT * FROM tenk1 WHERE stringu1 = 'CRAAAA';
QUERY PLAN
----------------------------------------------------------
Seq Scan on tenk1  (cost=0.00..483.00 rows=30 width=244)
Filter: (stringu1 = 'CRAAAA'::name)
规划器还是检查WHERE子句条件，并为=查找选择度函数（这次是eqsel）。对于等值估计而言，直方图是没用的；相反，最常见值（MCV）列表可以用来决定选择度。让我们来看一下 MCV，以及一些额外的后面用得上的列：
SELECT null_frac, n_distinct, most_common_vals, most_common_freqs FROM pg_stats
WHERE tablename='tenk1' AND attname='stringu1';
null_frac         | 0
n_distinct        | 676
most_common_vals  | {EJAAAA,BBAAAA,CRAAAA,FCAAAA,FEAAAA,GSAAAA,​JOAAAA,MCAAAA,NAAAAA,WGAAAA}
most_common_freqs | {0.00333333,0.003,0.003,0.003,0.003,0.003,​0.003,0.003,0.003,0.003}
因为CRAAAA出现在 MCV 列表中，那么选择度只是最常见频度（MCF）列表中的一个对应项：
selectivity = mcf[3]
= 0.003
像之前一样，行数的估计只是和前面一样用tenk1的势乘以选择度：
rows = 10000 * 0.003
= 30
现在考虑相同的查询，但使用一个不在MCV列表中的常量：
EXPLAIN SELECT * FROM tenk1 WHERE stringu1 = 'xxx';
QUERY PLAN
----------------------------------------------------------
Seq Scan on tenk1  (cost=0.00..483.00 rows=15 width=244)
Filter: (stringu1 = 'xxx'::name)
这是一个完全不同的问题：如何估计当值不在
MCV列表中的选择性。方法是利用该值不在列表中的事实，
结合对所有MCV频率的了解：
selectivity = (1 - sum(mcv_freqs))/(num_distinct - num_mcv)
= (1 - (0.00333333 + 0.003 + 0.003 + 0.003 + 0.003 + 0.003 +
0.003 + 0.003 + 0.003 + 0.003))/(676 - 10)
= 0.0014559
也就是说，将所有MCV的频率相加并从1中减去，
然后除以其他不同值的数量。这相当于假设列中不属于
任何MCV的部分在所有其他不同值之间均匀分布。注意，这里没有空值，
因此我们不需要担心这些（否则我们还需要从分子中减去空值的比例）。
然后按通常方式计算估计的行数：
rows = 10000 * 0.0014559
= 15  (四舍五入)
之前带有unique1 < 1000的例子是scalarltsel实际工作的过度简化。 现在我们已经看过了使用 MCV 的例子，可以增加一些具体细节了。 这个例子到目前为止是正确的，因为unique1是一个唯一列，它没有 MCV（显然， 没有一个值能比其他值更通用）。对一个非唯一列而言，通常会有直方图和 MCV 列表， 并且直方图不包括由 MCV 表示的那部分列。之所以这样做是因为可以得到更精确的估计。在这种情况下，scalarltsel直接应用条件（如“< 1000”）到 MCV 列表中的每个值，并且把那些条件判断为真的 MCV 的频度加起来。这对表中是 MCV 的那一部分给出了准确的选择度估计。然后以上述同样的方式使用直方图估计表中不是 MCV 的那部分的选择度，并且组合这两个数字来估计总的选择度。例如，考虑：
EXPLAIN SELECT * FROM tenk1 WHERE stringu1 < 'IAAAAA';
QUERY PLAN
------------------------------------------------------------
Seq Scan on tenk1  (cost=0.00..483.00 rows=3077 width=244)
Filter: (stringu1 < 'IAAAAA'::name)
我们已看到stringu1的 MCV 信息，这里是它的直方图：
SELECT histogram_bounds FROM pg_stats
WHERE tablename='tenk1' AND attname='stringu1';
histogram_bounds
-------------------------------------------------------------------​-------------
{AAAAAA,CQAAAA,FRAAAA,IBAAAA,KRAAAA,NFAAAA,PSAAAA,SGAAAA,VAAAAA,​XLAAAA,ZZAAAA}
检查 MCV 列表，我们发现前 6 项满足条件stringu1 < 'IAAAAA'，而最后 4 项不满足， 所以 MCV 部分的选择度是：
selectivity = sum(relevant mvfs)
= 0.00333333 + 0.003 + 0.003 + 0.003 + 0.003 + 0.003
= 0.01833333
累加所有的 MCF 也告诉我们由 MCV 表示的群体中的比例是 0.03033333，并且因此由直方图表示的 比例是 0.96966667（同样，没有空值，否则我们在这里必须排除它们）。我们可以看到值IAAAAA差不多落在第三个直方图桶的结尾。通过使用一些关于不同字符频率的相当漂亮的假设，规划器对小于IAAAAA的直方图群体部分得到估计值 0.298387。我们然后组合 MCV 和非 MCV 群体的估计：
selectivity = mcv_selectivity + histogram_selectivity * histogram_fraction
= 0.01833333 + 0.298387 * 0.96966667
= 0.307669
rows        = 10000 * 0.307669
= 3077  (rounding off)
在这个特别的例子中，来自 MCV 列表的纠正相当小，因为列分布实际上很平坦（统计显示这些特殊值比其它值更常见的原因大部分是由于抽样误差）。 在更典型的情况下某些值显著地比其它的更常见，这种复杂的处理过程有助于提高准确度，因为那些最常见值的选择度可以被准确地找到。
现在考虑一个WHERE子句中带有多个条件的情况：
EXPLAIN SELECT * FROM tenk1 WHERE unique1 < 1000 AND stringu1 = 'xxx';
QUERY PLAN
-------------------------------------------------------------------​-------------
Bitmap Heap Scan on tenk1  (cost=23.80..396.91 rows=1 width=244)
Recheck Cond: (unique1 < 1000)
Filter: (stringu1 = 'xxx'::name)
->  Bitmap Index Scan on tenk1_unique1  (cost=0.00..23.80 rows=1007 width=0)
Index Cond: (unique1 < 1000)
规划器假定这两个条件是独立的，因此子句各自的选择度可以被乘在一起：
selectivity = selectivity(unique1 < 1000) * selectivity(stringu1 = 'xxx')
= 0.100697 * 0.0014559
= 0.0001466
rows        = 10000 * 0.0001466
= 1  (rounding off)
需要注意的是，从位图索引扫描中返回的估计行数只反映和索引一起使用的条件； 这一点很重要，因为它会影响后续取堆元组的代价估计。
最后我们将检查一个涉及连接的查询：
EXPLAIN SELECT * FROM tenk1 t1, tenk2 t2
WHERE t1.unique1 < 50 AND t1.unique2 = t2.unique2;
QUERY PLAN
-------------------------------------------------------------------​-------------------
Nested Loop  (cost=4.64..456.23 rows=50 width=488)
->  Bitmap Heap Scan on tenk1 t1  (cost=4.64..142.17 rows=50 width=244)
Recheck Cond: (unique1 < 50)
->  Bitmap Index Scan on tenk1_unique1  (cost=0.00..4.63 rows=50 width=0)
Index Cond: (unique1 < 50)
->  Index Scan using tenk2_unique2 on tenk2 t2  (cost=0.00..6.27 rows=1 width=244)
Index Cond: (unique2 = t1.unique2)
对 tenk1 的限制，
unique1 < 50，
在嵌套循环连接之前被评估。
这与前面的范围示例处理方式类似。这次值50落入了
unique1 直方图的第一个桶：
selectivity = (0 + (50 - bucket[1].min)/(bucket[1].max - bucket[1].min))/num_buckets
= (0 + (50 - 0)/(993 - 0))/10
= 0.005035
rows        = 10000 * 0.005035
= 50  (rounding off)
连接的限制是 t2.unique2 = t1.unique2。
操作符就是我们熟悉的 =，不过选择性函数是
从 oprjoin 列的
pg_operator 中获得的，函数名是 eqjoinsel。
eqjoinsel 查询了
tenk2 和 tenk1 的统计信息：
SELECT tablename, null_frac,n_distinct, most_common_vals FROM pg_stats
WHERE tablename IN ('tenk1', 'tenk2') AND attname='unique2';
tablename  | null_frac | n_distinct | most_common_vals
-----------+-----------+------------+------------------
tenk1     |         0 |         -1 |
tenk2     |         0 |         -1 |
在这种情况下，unique2 没有 MCV 信息，
并且所有值似乎都是唯一的（n_distinct = -1），因此我们使用一个依赖于两个关系的行数估计
（num_rows，未显示，但“tenk”）以及列的空值比例（两者均为零）的算法：
selectivity = (1 - null_frac1) * (1 - null_frac2) / max(num_rows1, num_rows2)
= (1 - 0) * (1 - 0) / max(10000, 10000)
= 0.0001
这就是说，对每个关系用1减去空值比例，
然后除以较大关系的行数（该值在非唯一情况下会被缩放）。
连接可能产生的行数通过两个输入的笛卡尔积基数乘以选择性计算得出：
rows = (outer_cardinality * inner_cardinality) * selectivity
= (50 * 10000) * 0.0001
= 50
如果有两列的 MCV 列表，eqjoinsel将使用 MCV 列表的直接比较来决定在由 MCV 表示的列群体部分中的连接选择度。群体剩下部分的估计遵循这里展示的相同方法。
需要注意的是，我们把inner_cardinality显示为 10000，也就是未修改的tenk2尺寸。它可能出现于EXPLAIN输出检查，连接行的估计来自 50 * 1，即由 outer 行数乘以由tenk2上每个 inner 索引扫描的估计行数。但是这不是那种情况： 连接关系尺寸的估计在任何特定的连接计划被考虑之前进行。如果一切顺利，那么两种方式估计的连接尺寸将产生 大概同样的答案，但是由于舍入误差和其它因素它们有时差别显著。
如果对更进一步的细节感兴趣，一个表的尺寸（在任何WHERE子句之前）的估计在src/backend/optimizer/util/plancat.c中完成。子句选择度的一般逻辑在src/backend/optimizer/path/clausesel.c中。操作符相关的选择度函数大部分可以在src/backend/utils/adt/selfuncs.c中找到。
上一页 上一级 下一页第 69 章 规划器如何使用统计信息 起始页 69.2. 多元统计示例
