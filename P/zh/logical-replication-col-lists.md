# 29.5. 列列表

29.5. 列列表
版本：
纠错本页面
搜索
目录导航
❮
❯
29.5. 列列表 #29.5.1. 示例
每个发布可以选择性地指定每个表的哪些列被复制给订阅者。订阅者端的表必须至少包含所有发布的列。
如果未指定列列表，则发布者上的所有列都会被复制。
有关语法详细信息，请参见CREATE PUBLICATION。
列的选择可以基于行为或性能原因。然而，不要依赖此功能来确保安全性：
恶意订阅者可以从未明确发布的列中获取数据。如果安全性是一个考虑因素，
可以在发布者端应用保护措施。
如果未指定列列表，则稍后添加到表中的任何列都会自动复制。这意味着，拥有一个
列表列出所有列与完全没有列列表并不相同。
列表中只能包含简单的列引用。列表中列的顺序不会被保留。
生成的列也可以在列列表中指定。这允许
生成的列被发布，无论发布参数
publish_generated_columns。有关详细信息，请参见
第 29.6 节。
当发布也发布
FOR TABLES IN SCHEMA
时，不支持指定列列表。
对于分区表，发布参数
publish_via_partition_root
决定使用哪个列列表。如果 publish_via_partition_root
为 true，则使用根分区表的列列表。否则，如果
publish_via_partition_root 为 false（默认值），
则使用每个分区的列列表。
如果一个publication发布UPDATE或DELETE操作，
任何列列表必须包括表的复制标识列（参见REPLICA IDENTITY）。
如果一个publication只发布INSERT操作，那么列列表可以省略复制标识列。
列表对TRUNCATE命令没有影响。
在初始数据同步期间，仅复制已发布的列。
但是，如果订阅者来自于 15 之前的版本，
则在初始数据同步期间会复制表中的所有列，
忽略任何列列表。如果订阅者来自于 18 之前的版本，
则初始表同步不会复制生成的列，即使它们在发布者中被定义。
警告：合并来自多个发布的列列表
目前不支持包含多个发布的订阅，其中同一表已使用不同列列表发布。
CREATE SUBSCRIPTION 禁止创建这种订阅，但在创建订阅后，
仍然可以通过在发布端添加或更改列列表来进入该情况。
这意味着更改已经订阅的发布上的表格列列表可能会导致订阅方出现错误。
如果订阅受到此问题的影响，恢复复制的唯一方法是调整发布端的某个列列表，
使它们全部匹配；然后要么重新创建订阅，要么使用
ALTER SUBSCRIPTION ... DROP PUBLICATION来移除其中一个有问题的发布
并重新添加它。
29.5.1. 示例 #
创建一个表 t1，以便在以下示例中使用。
/* pub # */ CREATE TABLE t1(id int, a text, b text, c text, d text, e text, PRIMARY KEY(id));
创建一个发布 p1。为表 t1 定义一个列列表，以减少将被复制的列数。请注意，列列表中列名的顺序并不重要。
/* pub # */ CREATE PUBLICATION p1 FOR TABLE t1 (id, b, a, d);
psql 可用于显示每个发布的列列表（如果已定义）。
/* pub # */ \dRp+
Publication p1
Owner   | All tables | Inserts | Updates | Deletes | Truncates | Generated columns | Via root
----------+------------+---------+---------+---------+-----------+-------------------+----------
postgres | f          | t       | t       | t       | t         | none              | f
Tables:
"public.t1" (id, a, b, d)
psql 可用于显示每个表的列列表（如果已定义）。
/* pub # */ \d t1
Table "public.t1"
Column |  Type   | Collation | Nullable | Default
--------+---------+-----------+----------+---------
id     | integer |           | not null |
a      | text    |           |          |
b      | text    |           |          |
c      | text    |           |          |
d      | text    |           |          |
e      | text    |           |          |
Indexes:
"t1_pkey" PRIMARY KEY, btree (id)
Publications:
"p1" (id, a, b, d)
在订阅者节点上，创建一个表 t1，该表现在只需要发布者表 t1 上的一部分列，并且还创建订阅 s1，以订阅发布 p1。
/* sub # */ CREATE TABLE t1(id int, b text, a text, d text, PRIMARY KEY(id));
/* sub # */ CREATE SUBSCRIPTION s1
/* sub - */ CONNECTION 'host=localhost dbname=test_pub application_name=s1'
/* sub - */ PUBLICATION p1;
在发布者节点上，向表 t1 插入一些行。
/* pub # */ INSERT INTO t1 VALUES(1, 'a-1', 'b-1', 'c-1', 'd-1', 'e-1');
/* pub # */ INSERT INTO t1 VALUES(2, 'a-2', 'b-2', 'c-2', 'd-2', 'e-2');
/* pub # */ INSERT INTO t1 VALUES(3, 'a-3', 'b-3', 'c-3', 'd-3', 'e-3');
/* pub # */ SELECT * FROM t1 ORDER BY id;
id |  a  |  b  |  c  |  d  |  e
----+-----+-----+-----+-----+-----
1 | a-1 | b-1 | c-1 | d-1 | e-1
2 | a-2 | b-2 | c-2 | d-2 | e-2
3 | a-3 | b-3 | c-3 | d-3 | e-3
(3 rows)
仅发布 p1 的列列表中的数据被复制。
/* sub # */ SELECT * FROM t1 ORDER BY id;
id |  b  |  a  |  d
----+-----+-----+-----
1 | b-1 | a-1 | d-1
2 | b-2 | a-2 | d-2
3 | b-3 | a-3 | d-3
(3 rows)
上一页 上一级 下一页29.4. 行过滤器 起始页 29.6. 生成列复制
