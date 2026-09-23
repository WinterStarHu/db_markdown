# 39.3. 物化视图

39.3. 物化视图
版本：
纠错本页面
搜索
目录导航
❮
❯
39.3. 物化视图 #
PostgreSQL中的物化视图像视图一样使用了规则系统，但是以一种类表的形式保留了结果。在物化视图：
CREATE MATERIALIZED VIEW mymatview AS SELECT * FROM mytab;
和视图：
CREATE TABLE mymatview AS SELECT * FROM mytab;
之间的主要区别是物化视图不能直接被更新，并且用于创建物化视图的查询的存储方式和视图查询的存储方式完全相同，因此要为物化视图生成新鲜的数据：
REFRESH MATERIALIZED VIEW mymatview;
有关一个PostgreSQL系统目录中的物化视图的信息和一个表或视图的信息完全相同。因此对于解析器，一个物化视图就是一个关系，就像一个表或一个视图。当一个物化视图被一个查询引用时，数据直接从物化视图中返回，如同表一样；规则只被用来填充物化视图。
访问物化视图中存储的数据通常比直接访问基础表或通过视图访问要快得多，
但数据并不总是最新的；有时候也不需要当前数据。
考虑一个记录销售的表：
CREATE TABLE invoice (
invoice_no    integer        PRIMARY KEY,
seller_no     integer,       -- 销售人员的ID
invoice_date  date,          -- 销售日期
invoice_amt   numeric(13,2)  -- 销售金额
);
如果人们想要快速绘制历史销售数据的图表，他们可能想要进行汇总，
并且可能不关心当前日期的不完整数据：
CREATE MATERIALIZED VIEW sales_summary AS
SELECT
seller_no,
invoice_date,
sum(invoice_amt)::numeric(13,2) as sales_amt
FROM invoice
WHERE invoice_date < CURRENT_DATE
GROUP BY
seller_no,
invoice_date;
CREATE UNIQUE INDEX sales_summary_seller
ON sales_summary (seller_no, invoice_date);
这个物化视图可能对为销售人员创建的仪表板中显示图表很有用。
可以安排一个作业每晚使用以下SQL语句更新统计信息：
REFRESH MATERIALIZED VIEW sales_summary;
物化视图的另一种使用是允许通过一个外部数据包装器对来
自一个远程系统的数据进行更快的访问。下面有一个使用
file_fdw的简单例子，但是由于本地系
统上可以使用高速缓存，因此比起访问一个远程系统的性
能差异可能会比这里所展示的更大。注意我们也利用了
在物化视图上放置索引的能力，而file_fdw
不支持索引；这种优势可能不适用于其他种类的外部数据访问。
设置：
CREATE EXTENSION file_fdw;
CREATE SERVER local_file FOREIGN DATA WRAPPER file_fdw;
CREATE FOREIGN TABLE words (word text NOT NULL)
SERVER local_file
OPTIONS (filename '/usr/share/dict/words');
CREATE MATERIALIZED VIEW wrd AS SELECT * FROM words;
CREATE UNIQUE INDEX wrd_word ON wrd (word);
CREATE EXTENSION pg_trgm;
CREATE INDEX wrd_trgm ON wrd USING gist (word gist_trgm_ops);
VACUUM ANALYZE wrd;
现在让我们检查一个单词的拼写。直接使用 file_fdw：
SELECT count(*) FROM words WHERE word = 'caterpiler';
count
-------
0
(1 row)
使用 EXPLAIN ANALYZE，我们可以看到：
Aggregate  (cost=21763.99..21764.00 rows=1 width=0) (actual time=188.180..188.181 rows=1.00 loops=1)
->  Foreign Scan on words  (cost=0.00..21761.41 rows=1032 width=0) (actual time=188.177..188.177 rows=0.00 loops=1)
Filter: (word = 'caterpiler'::text)
Rows Removed by Filter: 479829
Foreign File: /usr/share/dict/words
Foreign File Size: 4953699
Planning time: 0.118 ms
Execution time: 188.273 ms
如果使用物化视图，查询会快得多：
Aggregate  (cost=4.44..4.45 rows=1 width=0) (actual time=0.042..0.042 rows=1.00 loops=1)
->  Index Only Scan using wrd_word on wrd  (cost=0.42..4.44 rows=1 width=0) (actual time=0.039..0.039 rows=0.00 loops=1)
Index Cond: (word = 'caterpiler'::text)
Heap Fetches: 0
Index Searches: 1
Planning time: 0.164 ms
Execution time: 0.117 ms
无论哪种方式，这个单词拼写都是错误的，所以让我们看看我们可能想要的内容。再次使用 file_fdw 和 pg_trgm：
SELECT word FROM words ORDER BY word <-> 'caterpiler' LIMIT 10;
word
---------------
cater
caterpillar
Caterpillar
caterpillars
caterpillar's
Caterpillar's
caterer
caterer's
caters
catered
(10 rows)
Limit  (cost=11583.61..11583.64 rows=10 width=32) (actual time=1431.591..1431.594 rows=10.00 loops=1)
->  Sort  (cost=11583.61..11804.76 rows=88459 width=32) (actual time=1431.589..1431.591 rows=10.00 loops=1)
Sort Key: ((word <-> 'caterpiler'::text))
Sort Method: top-N heapsort  Memory: 25kB
->  Foreign Scan on words  (cost=0.00..9672.05 rows=88459 width=32) (actual time=0.057..1286.455 rows=479829.00 loops=1)
Foreign File: /usr/share/dict/words
Foreign File Size: 4953699
Planning time: 0.128 ms
Execution time: 1431.679 ms
使用物化视图：
Limit  (cost=0.29..1.06 rows=10 width=10) (actual time=187.222..188.257 rows=10.00 loops=1)
->  Index Scan using wrd_trgm on wrd  (cost=0.29..37020.87 rows=479829 width=10) (actual time=187.219..188.252 rows=10.00 loops=1)
Order By: (word <-> 'caterpiler'::text)
Index Searches: 1
Planning time: 0.196 ms
Execution time: 198.640 ms
如果您能容忍定期将远程数据更新到本地数据库，性能提升可能会非常显著。
上一页 上一级 下一页39.2. 视图和规则系统 起始页 39.4. 在INSERT、UPDATE和DELETE上的规则
