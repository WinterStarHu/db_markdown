# F.6. bloom — bloom过滤器索引访问方法

F.6. bloom — bloom过滤器索引访问方法
版本：
纠错本页面
搜索
目录导航
❮
❯
F.6. bloom — bloom过滤器索引访问方法 #F.6.1. 参数F.6.2. 示例F.6.3. 操作符类接口F.6.4. 限制F.6.5. 作者
bloom提供了一种基于布隆过滤器的索引访问方法。
布隆过滤器是一种空间高效的数据结构，它被用来测试一个元素是否为一个集合的成员。在索引访问方法的情况下，它可以通过尺寸在索引创建时决定的签名来快速地排除不匹配的元组。
签名是被索引属性的一种有损表达，并且因此容易报告伪阳性，也就是说对于一个不在集合中的元素有可能报告该元素在集合中。因此索引搜索结果必须使用来自堆项的实际属性值进行再次检查。较大的签名可以降低伪阳性的几率并且减少无用的堆访问的次数，但是这显然会让索引更大且扫描起来更慢。
当表具有很多属性并且查询可能会测试其中任意组合时，这种类型的索引最有用。传统的 btree 索引比布隆索引更快，但是需要很多 btree 索引来支持所有可能的查询，而对于布隆索引来说只需要一个就可以。不过要注意 bloom 索引只支持等值查询，而 btree 索引还能执行不等和范围搜索。
F.6.1. 参数 #
bloom索引在其WITH子句中接受下列参数：
length
每个签名（索引项）的长度位数，它会被四舍五入到最近的16的倍数。默认是80位，最大是4096位。
col1 — col32
为每个索引列生成的位数。每个参数的名字表示它所控制的索引列的编号。默认是2位，最大是4095位。没有实际使用的索引列的参数会被忽略。
F.6.2. 示例 #
这是一个创建布鲁姆索引的示例：
CREATE INDEX bloomidx ON tbloom USING bloom (i1,i2,i3)
WITH (length=80, col1=2, col2=2, col3=4);
该索引是用长度为80位的签名创建的，其中属性i1和i2被映射为2位，属性i3被映射为4位。我们可以省略length、col1和col2的说明，因为它们都有默认值。
这里是布鲁姆索引定义和使用的更完整的示例，其中还与等效的btree索引进行了比较。布鲁姆索引比btree索引小得多，并且性能更好。
=# CREATE TABLE tbloom AS
SELECT
(random() * 1000000)::int as i1,
(random() * 1000000)::int as i2,
(random() * 1000000)::int as i3,
(random() * 1000000)::int as i4,
(random() * 1000000)::int as i5,
(random() * 1000000)::int as i6
FROM
generate_series(1,10000000);
SELECT 10000000
对这张大表进行顺序扫描需要很长时间：
=# EXPLAIN ANALYZE SELECT * FROM tbloom WHERE i2 = 898732 AND i5 = 123451;
QUERY PLAN
-------------------------------------------------------------------​-----------------------------------
Seq Scan on tbloom  (cost=0.00..213744.00 rows=250 width=24) (actual time=357.059..357.059 rows=0.00 loops=1)
Filter: ((i2 = 898732) AND (i5 = 123451))
Rows Removed by Filter: 10000000
Buffers: shared hit=63744
Planning Time: 0.346 ms
Execution Time: 357.076 ms
(6 rows)
即使定义了 btree 索引，结果仍然会是顺序扫描：
=# CREATE INDEX btreeidx ON tbloom (i1, i2, i3, i4, i5, i6);
CREATE INDEX
=# SELECT pg_size_pretty(pg_relation_size('btreeidx'));
pg_size_pretty
----------------
386 MB
(1 row)
=# EXPLAIN ANALYZE SELECT * FROM tbloom WHERE i2 = 898732 AND i5 = 123451;
QUERY PLAN
-------------------------------------------------------------------​-----------------------------------
Seq Scan on tbloom  (cost=0.00..213744.00 rows=2 width=24) (actual time=351.016..351.017 rows=0.00 loops=1)
Filter: ((i2 = 898732) AND (i5 = 123451))
Rows Removed by Filter: 10000000
Buffers: shared hit=63744
Planning Time: 0.138 ms
Execution Time: 351.035 ms
(6 rows)
在表上定义 bloom 索引比 btree 更适合处理这类搜索：
=# CREATE INDEX bloomidx ON tbloom USING bloom (i1, i2, i3, i4, i5, i6);
CREATE INDEX
=# SELECT pg_size_pretty(pg_relation_size('bloomidx'));
pg_size_pretty
----------------
153 MB
(1 row)
=# EXPLAIN ANALYZE SELECT * FROM tbloom WHERE i2 = 898732 AND i5 = 123451;
QUERY PLAN
-------------------------------------------------------------------​--------------------------------------------------
Bitmap Heap Scan on tbloom  (cost=1792.00..1799.69 rows=2 width=24) (actual time=22.605..22.606 rows=0.00 loops=1)
Recheck Cond: ((i2 = 898732) AND (i5 = 123451))
Rows Removed by Index Recheck: 2300
Heap Blocks: exact=2256
Buffers: shared hit=21864
->  Bitmap Index Scan on bloomidx  (cost=0.00..178436.00 rows=1 width=0) (actual time=20.005..20.005 rows=2300.00 loops=1)
Index Cond: ((i2 = 898732) AND (i5 = 123451))
Index Searches: 1
Buffers: shared hit=19608
Planning Time: 0.099 ms
Execution Time: 22.632 ms
(11 rows)
btree 搜索的主要问题是，当搜索条件不约束前导索引列时，btree 效率低下。
更好的 btree 策略是为每列创建单独的索引，规划器将选择如下方案：
=# CREATE INDEX btreeidx1 ON tbloom (i1);
CREATE INDEX
=# CREATE INDEX btreeidx2 ON tbloom (i2);
CREATE INDEX
=# CREATE INDEX btreeidx3 ON tbloom (i3);
CREATE INDEX
=# CREATE INDEX btreeidx4 ON tbloom (i4);
CREATE INDEX
=# CREATE INDEX btreeidx5 ON tbloom (i5);
CREATE INDEX
=# CREATE INDEX btreeidx6 ON tbloom (i6);
CREATE INDEX
=# EXPLAIN ANALYZE SELECT * FROM tbloom WHERE i2 = 898732 AND i5 = 123451;
QUERY PLAN
-------------------------------------------------------------------​--------------------------------------------------------
Bitmap Heap Scan on tbloom  (cost=9.29..13.30 rows=1 width=24) (actual time=0.032..0.033 rows=0.00 loops=1)
Recheck Cond: ((i5 = 123451) AND (i2 = 898732))
Buffers: shared read=6
->  BitmapAnd  (cost=9.29..9.29 rows=1 width=0) (actual time=0.047..0.047 rows=0.00 loops=1)
Buffers: shared hit=6
->  Bitmap Index Scan on btreeidx5  (cost=0.00..4.52 rows=11 width=0) (actual time=0.026..0.026 rows=7.00 loops=1)
Index Cond: (i5 = 123451)
Index Searches: 1
Buffers: shared hit=3
->  Bitmap Index Scan on btreeidx2  (cost=0.00..4.52 rows=11 width=0) (actual time=0.007..0.007 rows=8.00 loops=1)
Index Cond: (i2 = 898732)
Index Searches: 1
Buffers: shared hit=3
Planning Time: 0.264 ms
Execution Time: 0.047 ms
(15 rows)
虽然此查询比使用任何一个单索引都要快得多，但索引大小的代价不可忽视。
每个单列 btree 索引占用 88.5 MB，因此所需总空间为 531 MB，
是 bloom 索引所用空间的三倍多。
F.6.3. 操作符类接口 #
用于布鲁姆索引的操作符类只要一个用于被索引数据类型的哈希函数以及一个用于搜索的等值操作符。这个例子展示了用于text数据类型的操作符类定义：
CREATE OPERATOR CLASS text_ops
DEFAULT FOR TYPE text USING bloom AS
OPERATOR    1   =(text, text),
FUNCTION    1   hashtext(text);
F.6.4. 限制 #
在模块中只包括了用于int4和text的操作符类。
搜索只支持=操作符。但是未来可以为带合并和交集操作的数组增加支持。
bloom访问方法不支持UNIQUE索引。
bloom访问方法不支持对NULL值的搜索。
F.6.5. 作者 #
Teodor Sigaev <teodor@postgrespro.ru>,
Postgres Professional, Moscow, Russia
Alexander Korotkov <a.korotkov@postgrespro.ru>,
Postgres Professional, Moscow, Russia
Oleg Bartunov <obartunov@postgrespro.ru>,
Postgres Professional, Moscow, Russia
上一页 上一级 下一页F.5. basic_archive — 一个示例WAL归档模块 起始页 F.7. btree_gin — 具有B-tree行为的GIN操作符类
