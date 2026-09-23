# 69.2. 多元统计示例

69.2. 多元统计示例
版本：
纠错本页面
搜索
目录导航
❮
❯
69.2. 多元统计示例 #69.2.1. 函数依赖69.2.2. 多变量 N-不同计数69.2.3. MCV 列表69.2.1. 函数依赖 #
多元相关性可以用一个非常简单的数据集来演示 — 一个有两列的表，它们都包含相同的值：
CREATE TABLE t (a INT, b INT);
INSERT INTO t SELECT i % 100, i % 100 FROM generate_series(1, 10000) s(i);
ANALYZE t;
如第 14.2 节所述，规划人员可以使用从
pg_class获取的页面和行数来确定
t的基数：
SELECT relpages, reltuples FROM pg_class WHERE relname = 't';
relpages | reltuples
----------+-----------
45 |     10000
数据分布非常简单；每列中只有100个不同的值，均匀分布。
以下示例显示了在 WHERE
条件下对 a 列的估算结果：
EXPLAIN (ANALYZE, TIMING OFF, BUFFERS OFF) SELECT * FROM t WHERE a = 1;
QUERY PLAN
-------------------------------------------------------------------​------------
Seq Scan on t  (cost=0.00..170.00 rows=100 width=8) (actual rows=100.00 loops=1)
Filter: (a = 1)
Rows Removed by Filter: 9900
规划器检查条件并确定该子句的选择性为 1%。通过比较该估算值和实际
行数，我们可以看到估算非常准确（实际上是精确的，因为表非常小）。
将 WHERE 条件更改为使用 b 列时，
生成了一个相同的计划。但请观察如果我们在两个列上应用相同的
条件，并用 AND 组合它们时会发生什么：
EXPLAIN (ANALYZE, TIMING OFF, BUFFERS OFF) SELECT * FROM t WHERE a = 1 AND b = 1;
QUERY PLAN
-------------------------------------------------------------------​----------
Seq Scan on t  (cost=0.00..195.00 rows=1 width=8) (actual rows=100.00 loops=1)
Filter: ((a = 1) AND (b = 1))
Rows Removed by Filter: 9900
规划器分别估算每个条件的选择性，得出与上述相同的 1% 估算值。
然后它假设这些条件是独立的，因此它将它们的选择性相乘，
产生最终的选择性估算值仅为 0.01%。这是一个显著的低估，
因为实际符合条件的行数（100）高出两个数量级。
通过创建一个统计对象来解决此问题，该对象指示 ANALYZE
在这两列上计算功能依赖的多变量统计：
CREATE STATISTICS stts (dependencies) ON a, b FROM t;
ANALYZE t;
EXPLAIN (ANALYZE, TIMING OFF, BUFFERS OFF) SELECT * FROM t WHERE a = 1 AND b = 1;
QUERY PLAN
-------------------------------------------------------------------​------------
Seq Scan on t  (cost=0.00..195.00 rows=100 width=8) (actual rows=100.00 loops=1)
Filter: ((a = 1) AND (b = 1))
Rows Removed by Filter: 9900
69.2.2. 多变量 N-不同计数 #
在多个列的集合的基数估算中也会出现类似问题，例如通过
GROUP BY 子句生成的组数。当 GROUP BY
列出单个列时，n-distinct 估算（在 HashAggregate 节点返回的估算行数中可见）
非常准确：
EXPLAIN (ANALYZE, TIMING OFF, BUFFERS OFF) SELECT COUNT(*) FROM t GROUP BY a;
QUERY PLAN
-------------------------------------------------------------------​----------------------
HashAggregate  (cost=195.00..196.00 rows=100 width=12) (actual rows=100.00 loops=1)
Group Key: a
->  Seq Scan on t  (cost=0.00..145.00 rows=10000 width=4) (actual rows=10000.00 loops=1)
但是在没有多变量统计的情况下，查询中包含两个列的 GROUP BY
的组数估算，如以下示例所示，偏差了一个数量级：
EXPLAIN (ANALYZE, TIMING OFF, BUFFERS OFF) SELECT COUNT(*) FROM t GROUP BY a, b;
QUERY PLAN
-------------------------------------------------------------------​-------------------------
HashAggregate  (cost=220.00..230.00 rows=1000 width=16) (actual rows=100.00 loops=1)
Group Key: a, b
->  Seq Scan on t  (cost=0.00..145.00 rows=10000 width=8) (actual rows=10000.00 loops=1)
通过重新定义统计对象以包括两个列的 n-distinct 计数，估算得到了很大改善：
DROP STATISTICS stts;
CREATE STATISTICS stts (dependencies, ndistinct) ON a, b FROM t;
ANALYZE t;
EXPLAIN (ANALYZE, TIMING OFF, BUFFERS OFF) SELECT COUNT(*) FROM t GROUP BY a, b;
QUERY PLAN
-------------------------------------------------------------------​-------------------------
HashAggregate  (cost=220.00..221.00 rows=100 width=16) (actual rows=100.00 loops=1)
Group Key: a, b
->  Seq Scan on t  (cost=0.00..145.00 rows=10000 width=8) (actual rows=10000.00 loops=1)
69.2.3. MCV 列表 #
如 第 69.2.1 节中所述，函数依赖是非常廉价和高效的统计类型，但它们的主要限制是其全局特性（仅跟踪列级别的依赖项，而不是在单个列值之间）。
本节介绍MCV（最常见值）列表的多变量变体, 第 69.1 节 中描述的每列统计数据的简单扩展。
这些统计数据通过存储单独的值来解决这个限制，但是就构建ANALYZE中的统计数据、存储和规划时间而言，它的成本自然更高。
让我们再次查看来自 第 69.2.1 节
的查询，但这次在相同列集上创建了 MCV 列表（确保删除功能依赖，
以确保规划器使用新创建的统计信息）。
DROP STATISTICS stts;
CREATE STATISTICS stts2 (mcv) ON a, b FROM t;
ANALYZE t;
EXPLAIN (ANALYZE, TIMING OFF, BUFFERS OFF) SELECT * FROM t WHERE a = 1 AND b = 1;
QUERY PLAN
-------------------------------------------------------------------​------------
Seq Scan on t  (cost=0.00..195.00 rows=100 width=8) (actual rows=100.00 loops=1)
Filter: ((a = 1) AND (b = 1))
Rows Removed by Filter: 9900
估算与功能依赖一样准确，这主要得益于表相对较小且具有简单的分布，
具有较少的不同值。在查看第二个查询之前，该查询未能很好地处理功能依赖，
让我们先检查一下 MCV 列表。
检查MCV列表可以使用pg_mcv_list_items返回集函数。
SELECT m.* FROM pg_statistic_ext join pg_statistic_ext_data on (oid = stxoid),
pg_mcv_list_items(stxdmcv) m WHERE stxname = 'stts2';
index |  values  | nulls | frequency | base_frequency
-------+----------+-------+-----------+----------------
0 | {0, 0}   | {f,f} |      0.01 |         0.0001
1 | {1, 1}   | {f,f} |      0.01 |         0.0001
...
49 | {49, 49} | {f,f} |      0.01 |         0.0001
50 | {50, 50} | {f,f} |      0.01 |         0.0001
...
97 | {97, 97} | {f,f} |      0.01 |         0.0001
98 | {98, 98} | {f,f} |      0.01 |         0.0001
99 | {99, 99} | {f,f} |      0.01 |         0.0001
(100 rows)
这证实了这两列中有100个不同的组合，而且它们都是大致相等的（每个组合的频率为1%）。基础频率是从每列统计数据计算出的频率，就好像没有多列统计数据一样。如果任一列中有任何空值，这将在nulls列中标识出来。
在估计选择性时，规划器对MCV列表中的项目应用所有条件，然后对匹配项的频率求和。
详情请参阅src/backend/statistics/mcv.c中的mcv_clauselist_selectivity。
与功能依赖相比，MCV 列表有两个主要优势。首先，列表存储实际值，
使得能够决定哪些组合是兼容的。
EXPLAIN (ANALYZE, TIMING OFF, BUFFERS OFF) SELECT * FROM t WHERE a = 1 AND b = 10;
QUERY PLAN
-------------------------------------------------------------------​--------
Seq Scan on t  (cost=0.00..195.00 rows=1 width=8) (actual rows=0.00 loops=1)
Filter: ((a = 1) AND (b = 10))
Rows Removed by Filter: 10000
其次，MCV 列表处理更广泛的子句类型，不仅仅是像功能依赖那样的相等子句。
例如，考虑以下针对同一表的范围查询：
EXPLAIN (ANALYZE, TIMING OFF, BUFFERS OFF) SELECT * FROM t WHERE a <= 49 AND b > 49;
QUERY PLAN
-------------------------------------------------------------------​--------
Seq Scan on t  (cost=0.00..195.00 rows=1 width=8) (actual rows=0.00 loops=1)
Filter: ((a <= 49) AND (b > 49))
Rows Removed by Filter: 10000
上一页 上一级 下一页69.1. 行估计示例 起始页 69.3. 规划器统计和安全
