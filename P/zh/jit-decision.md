# 30.2. 什么时候会用JIT？

30.2. 什么时候会用JIT？
版本：
纠错本页面
搜索
目录导航
❮
❯
30.2. 什么时候会用JIT？ #
JIT编译主要可以让长时间运行的CPU密集型查询受益。对于短查询，执行JIT编译增加的开销常常比它节省的时间还要多。
为了判断是否应该使用JIT编译，会用到一个查询的总的估计代价（见第 69 章和第 19.7.2 节）。查询的估计代价将与jit_above_cost的设置进行比较。如果代价更高，JIT编译将被执行。然后需要两个进一步的决定。首先，如果估计代价超过jit_inline_above_cost的设置，该查询中使用的短函数和操作符都将被内联。其次，如果估计代价超过jit_optimize_above_cost的设置，会应用昂贵的优化来改进产生的代码。这些选项中的每一种都会增加JIT编译的开销，但是可以显著降低查询执行时间。
这些基于代价的决定将在规划时做出，而不是在执行时做出。这意味着，在使用预备语句并且使用了一个一般性的计划时（见PREPARE），配置参数的值实际上是在预备时控制这些决定，而不是由执行时的设置来决定。
注意
如果jit被设置为off，或者没有JIT实现可用（例如因为服务器没有用--with-llvm编译），即便基于上述原则能带来很大的好处，JIT也不会被执行。把jit设置成off对规划时和执行时都有影响。
EXPLAIN 可用于查看是否使用了 JIT。作为示例，这里是一个未使用 JIT 的查询：
=# EXPLAIN ANALYZE SELECT SUM(relpages) FROM pg_class;
QUERY PLAN
-------------------------------------------------------------------​------------------------------------------
Aggregate  (cost=16.27..16.29 rows=1 width=8) (actual time=0.303..0.303 rows=1.00 loops=1)
Buffers: shared hit=14
->  Seq Scan on pg_class  (cost=0.00..15.42 rows=342 width=4) (actual time=0.017..0.111 rows=356.00 loops=1)
Buffers: shared hit=14
Planning Time: 0.116 ms
Execution Time: 0.365 ms
鉴于计划的成本，未使用 JIT 是完全合理的；JIT 的成本将大于潜在的节省。调整成本限制将导致使用 JIT：
=# SET jit_above_cost = 10;
SET
=# EXPLAIN ANALYZE SELECT SUM(relpages) FROM pg_class;
QUERY PLAN
-------------------------------------------------------------------​------------------------------------------
Aggregate  (cost=16.27..16.29 rows=1 width=8) (actual time=6.049..6.049 rows=1.00 loops=1)
Buffers: shared hit=14
->  Seq Scan on pg_class  (cost=0.00..15.42 rows=342 width=4) (actual time=0.019..0.052 rows=356.00 loops=1)
Buffers: shared hit=14
Planning Time: 0.133 ms
JIT:
Functions: 3
Options: Inlining false, Optimization false, Expressions true, Deforming true
Timing: Generation 1.259 ms (Deform 0.000 ms), Inlining 0.000 ms, Optimization 0.797 ms, Emission 5.048 ms, Total 7.104 ms
Execution Time: 7.416 ms
如此可见，使用了 JIT，但未使用内联和昂贵的优化。如果 jit_inline_above_cost 或 jit_optimize_above_cost 也降低，则情况将会改变。
上一页 上一级 下一页30.1. 什么是JIT编译？ 起始页 30.3. 配置
