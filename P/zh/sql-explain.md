# EXPLAIN

EXPLAIN
版本：
纠错本页面
搜索
目录导航
❮
❯
EXPLAINEXPLAIN — 显示一个语句的执行计划大纲
EXPLAIN [ ( option [, ...] ) ] statement
其中 option 可以是以下之一：
ANALYZE [ boolean ]
VERBOSE [ boolean ]
COSTS [ boolean ]
SETTINGS [ boolean ]
GENERIC_PLAN [ boolean ]
BUFFERS [ boolean ]
SERIALIZE [ { NONE | TEXT | BINARY } ]
WAL [ boolean ]
TIMING [ boolean ]
SUMMARY [ boolean ]
MEMORY [ boolean ]
FORMAT { TEXT | XML | JSON | YAML }
描述
这个命令显示PostgreSQL计划器为提供的语句所生成的执行计划。该执行计划会显示将怎样扫描语句中引用的表 — 普通的顺序扫描、索引扫描等等 — 以及在引用多个表时使用何种连接算法来把来自每个输入表的行连接在一起。
显示中最重要的部分是估计出的语句执行代价，它是计划器对于该语句要运行多久的猜测（以任意的代价单位度量，但是习惯上表示取磁盘页面的次数）。事实上会显示两个数字：在第一行能被返回前的启动代价，以及返回所有行的总代价。对于大部分查询来说总代价是最重要的，但是在一些情景中（如EXISTS中的子查询），计划器将选择更小的启动代价来代替最小的总代价（因为执行器将在得到一行后停止）。此外，如果你用一个LIMIT子句限制返回行的数量，计划器会在终端代价之间做出适当的插值来估计到底哪个计划是真正代价最低的。
ANALYZE选项导致该语句被实际执行，而不仅仅是被计划。然后实际的运行时间统计会被显示出来，包括在每个计划节点上花费的总时间（以毫秒计）以及它实际返回的行数。这对观察计划器的估计是否与实际相近很有用。
重要
要记住，当使用ANALYZE选项时，语句实际上会被执行。虽然EXPLAIN会丢弃SELECT返回的任何输出，但语句的其他副作用会像往常一样发生。如果您希望在INSERT、UPDATE、DELETE、MERGE、CREATE TABLE AS或EXECUTE语句上使用EXPLAIN ANALYZE而不让该命令影响您的数据，请使用以下方法：
BEGIN;
EXPLAIN ANALYZE ...;
ROLLBACK;
参数ANALYZE
执行命令并显示实际的运行时间和其他统计信息。这个参数默认被设置为FALSE。
VERBOSE
显示关于计划的额外信息。特别是：计划树中每个节点的输出列列表、模式限定的表和函数名、总是把表达式中的变量标上它们的范围表别名，以及总是打印统计信息被显示的每个触发器的名称。查询标识符也会被显示，如果已经被计算，详请参见compute_query_id。这个参数默认被设置为FALSE。
COSTS
包括每个计划节点的估计启动和总代价，以及估计的行数和每行的宽度。这个参数默认被设置为TRUE。
SETTINGS
包括有关配置参数的信息。具体来说，包括影响查询计划的选项，其值与内置默认值不同。此参数默认为FALSE。
GENERIC_PLAN
允许语句包含类似$1的参数占位符，并生成一个不依赖于这些参数值的通用计划。有关于通用计划和支持参数的语句类型的详细信息，请参见PREPARE。此参数不能与ANALYZE一起使用。默认值为FALSE。
BUFFERS
包含关于缓冲区使用的信息。具体来说，包含命中、读取、修改和写入的共享块数量，
命中、读取、修改和写入的本地块数量，读取和写入的临时块数量，以及
如果 track_io_timing 被启用，读取和写入数据文件块、本地块和临时文件块所花费的时间（以毫秒为单位）。
命中 意味着由于在需要时已在缓存中找到块而避免了读取。
共享块包含常规表和索引的数据；
本地块包含临时表和索引的数据；
而临时块包含在排序、哈希、物化计划节点和类似情况下使用的短期工作数据。
修改 的块数量表示此查询更改的先前未修改块的数量；
而 写入 的块数量表示在查询处理期间被此后端从缓存中驱逐的先前已修改块的数量。
显示给上层节点的块数量包括所有子节点使用的块数量。在文本格式中，仅打印非零值。
当使用 ANALYZE 时，缓冲区信息会自动包含。
SERIALIZE
包含有关查询输出数据序列化成本的信息，即将其转换为文本或二进制格式以发送给客户端。
如果数据类型的输出函数开销较大，或者必须从外部存储中获取TOAST值，这可能是查询常规执行所需时间的重要部分。
EXPLAIN的默认行为SERIALIZE NONE不会执行这些转换。
如果指定了SERIALIZE TEXT或SERIALIZE BINARY，则会执行相应的转换，并测量所花费的时间（除非指定了TIMING OFF）。
如果还指定了BUFFERS选项，则转换过程中涉及的任何缓冲区访问也会被计数。
但无论如何，EXPLAIN都不会将结果数据实际发送给客户端，因此无法通过这种方式调查网络传输成本。
只有在同时启用ANALYZE时，才可以启用序列化。
如果SERIALIZE后面没有参数，则默认假定为TEXT。
WAL
包含关于 WAL 记录生成的信息。具体来说，包含记录数量、完整页面图像（fpi）数量、
生成的 WAL 字节数和 WAL 缓冲区变满的次数。在文本格式中，仅打印非零值。
此参数仅在 ANALYZE 也启用时可用。默认值为 FALSE。
TIMING
在输出中包括实际启动时间以及在每个节点中花费的时间。反复读取系统时钟的负荷在某些系统上会显著地拖慢查询，因此在只需要实际的行计数而不是实际时间时，把这个参数设置为FALSE可能会有用。即便用这个选项关闭节点层的计时，整个语句的运行时间也总是会被度量。只有当ANALYZE也被启用时，这个参数才能使用。它的默认值被设置为TRUE。
SUMMARY
在查询计划之后包含摘要信息（例如，总计的时间信息）。当使用ANALYZE
时默认包含摘要信息，但默认情况下不包含摘要信息，但可以使用此选项启用摘要信息。
使用EXPLAIN EXECUTE中的计划时间包括从缓存中获取计划所需的时间
以及重新计划所需的时间（如有必要）。
MEMORY
包含查询规划阶段的内存消耗信息。具体来说，包含规划器内存结构使用的精确存储量，
以及考虑分配开销的总内存。
该参数默认为FALSE。
FORMAT
指定输出格式，可以是 TEXT、XML、JSON 或者 YAML。非文本输出包含和文本输出格式相同的信息，但是更容易被程序解析。这个参数默认被设置为TEXT。
boolean
指定被选中的选项是否应该被打开或关闭。可以写TRUE、ON或1来启用选项，写FALSE、OFF或0禁用它。boolean值也能被忽略，在这种情况下会假定值为TRUE。
statement
任何SELECT，INSERT，UPDATE，
DELETE，MERGE，
VALUES，EXECUTE，
DECLARE，CREATE TABLE AS，或
CREATE MATERIALIZED VIEW AS语句，您希望查看其执行计划。
输出
这个命令的结果是为statement选中的计划的文本描述，可能还标注了执行统计信息。
第 14.1 节描述了所提供的信息。
注意
为了允许PostgreSQL查询计划器在优化查询时能做出合理的知情决策，查询中用到的所有表的pg_statistic数据应该保持最新。
通常这个工作会由autovacuum daemon负责自动完成。
但是如果一个表最近在内容上有大量的改变，我们可能需要做一次手动的ANALYZE而不是等待autovacuum捕捉这些改变。
为了度量执行计划中每个节点的运行时成本，当前的EXPLAIN ANALYZE实现为查询执行增加了性能分析开销。
这样，在一个查询上运行EXPLAIN ANALYZE有时候比正常执行该查询要慢很多。
开销的量取决于该查询的性质，以及使用的平台。最坏的情况会发生在那些自身执行时间很短的节点上，以及在那些具有相对较慢的获取时间的操作系统调用的机器上。
示例
有一个具有单个integer列和10000行的表，要显示在其上的一个简单查询的计划：
EXPLAIN SELECT * FROM foo;
QUERY PLAN
---------------------------------------------------------
Seq Scan on foo  (cost=0.00..155.00 rows=10000 width=4)
(1 row)
这里有同样一个查询的 JSON 输出格式：
EXPLAIN (FORMAT JSON) SELECT * FROM foo;
QUERY PLAN
--------------------------------
[                             +
{                           +
"Plan": {                 +
"Node Type": "Seq Scan",+
"Relation Name": "foo", +
"Alias": "foo",         +
"Startup Cost": 0.00,   +
"Total Cost": 155.00,   +
"Plan Rows": 10000,     +
"Plan Width": 4         +
}                         +
}                           +
]
(1 row)
如果有一个索引，并且我们使用了一个带有可索引WHERE条件的查询，EXPLAIN可能会显示一个不同的计划：
EXPLAIN SELECT * FROM foo WHERE i = 4;
QUERY PLAN
--------------------------------------------------------------
Index Scan using fi on foo  (cost=0.00..5.98 rows=1 width=4)
Index Cond: (i = 4)
(2 rows)
这里是相同的查询，但是以YAML格式呈现：
EXPLAIN (FORMAT YAML) SELECT * FROM foo WHERE i='4';
QUERY PLAN
-------------------------------
- Plan:                      +
Node Type: "Index Scan"  +
Scan Direction: "Forward"+
Index Name: "fi"         +
Relation Name: "foo"     +
Alias: "foo"             +
Startup Cost: 0.00       +
Total Cost: 5.98         +
Plan Rows: 1             +
Plan Width: 4            +
Index Cond: "(i = 4)"
(1 row)
XML格式留给读者作为练习。
这里是去掉了代价估计的同样一个计划：
EXPLAIN (COSTS FALSE) SELECT * FROM foo WHERE i = 4;
QUERY PLAN
----------------------------
Index Scan using fi on foo
Index Cond: (i = 4)
(2 rows)
这里是一个使用聚合函数的查询的查询计划例子：
EXPLAIN SELECT sum(i) FROM foo WHERE i < 10;
QUERY PLAN
-------------------------------------------------------------------
Aggregate  (cost=23.93..23.93 rows=1 width=4)
->  Index Scan using fi on foo  (cost=0.00..23.92 rows=6 width=4)
Index Cond: (i < 10)
(3 rows)
这是使用 EXPLAIN EXECUTE 显示准备查询的执行计划的示例：
PREPARE query(int, int) AS SELECT sum(bar) FROM test
WHERE id > $1 AND id < $2
GROUP BY foo;
EXPLAIN ANALYZE EXECUTE query(100, 200);
QUERY PLAN
-------------------------------------------------------------------
HashAggregate  (cost=10.77..10.87 rows=10 width=12) (actual time=0.043..0.044 rows=10.00 loops=1)
Group Key: foo
Batches: 1  Memory Usage: 24kB
Buffers: shared hit=4
->  Index Scan using test_pkey on test  (cost=0.29..10.27 rows=99 width=8) (actual time=0.009..0.025 rows=99.00 loops=1)
Index Cond: ((id > 100) AND (id < 200))
Index Searches: 1
Buffers: shared hit=4
Planning Time: 0.244 ms
Execution Time: 0.073 ms
(10 rows)
当然，这里显示的有关数字取决于表涉及到的实际内容。还要注意这些数字甚至选中的查询策略，可能在PostgreSQL的不同版本之间变化，因为计划器可能被改进。此外，ANALYZE命令使用随机采样来估计数据统计。因此，在一次新的ANALYZE运行之后，代价估计可能会改变，即便是表中数据的实际分布没有改变也是如此。
请注意，前面的示例展示了一个“自定义”计划，
针对EXECUTE中给定的特定参数值。
我们可能还希望查看参数化查询的通用计划，这可以通过
GENERIC_PLAN实现：
EXPLAIN (GENERIC_PLAN)
SELECT sum(bar) FROM test
WHERE id > $1 AND id < $2
GROUP BY foo;
QUERY PLAN
-------------------------------------------------------------------
HashAggregate  (cost=26.79..26.89 rows=10 width=12)
Group Key: foo
->  Index Scan using test_pkey on test  (cost=0.29..24.29 rows=500 width=8)
Index Cond: ((id > $1) AND (id < $2))
(4 rows)
在这种情况下，解析器正确推断出$1
和$2应该与id具有相同的数据类型，
因此PREPARE中缺乏参数类型信息并不是问题。
在其他情况下，可能需要显式指定参数符号的类型，这可以通过
对它们进行类型转换来实现，例如：
EXPLAIN (GENERIC_PLAN)
SELECT sum(bar) FROM test
WHERE id > $1::integer AND id < $2::integer
GROUP BY foo;
兼容性
在 SQL 标准中没有定义 EXPLAIN 语句。
以下语法用于 PostgreSQL 9.0 版本之前，且仍然支持：
EXPLAIN [ ANALYZE ] [ VERBOSE ] statement
请注意，在此语法中，选项必须按所示顺序准确指定。
另请参阅ANALYZE上一页 上一级 下一页EXECUTE 起始页 FETCH
