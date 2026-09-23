# F.23. pageinspect — 数据库页面的低级检查

F.23. pageinspect — 数据库页面的低级检查
版本：
纠错本页面
搜索
目录导航
❮
❯
F.23. pageinspect — 数据库页面的低级检查 #F.23.1. 通用函数F.23.2. Heap FunctionsF.23.3. B树函数F.23.4. BRIN函数F.23.5. GIN函数F.23.6. GiST 函数F.23.7. Hash 函数
pageinspect模块提供函数让你从低层次观察数据库页面的内容，这对于调试目的很有用。所有这些函数只能被超级用户使用。
F.23.1. 通用函数 #
get_raw_page(relname text, fork text, blkno bigint) returns bytea
get_raw_page读取指定块的命名关系并将其作为bytea值返回。这允许获取块的单个时间一致副本。
fork应为'main'表示主数据分支，'fsm'表示
自由空间图，'vm'表示
可见性图，或'init'表示初始化分支。
get_raw_page(relname text, blkno bigint) returns bytea
一个简写版的get_raw_page，用于读取主分支。等效于get_raw_page(relname, 'main', blkno)
page_header(page bytea) returns record
page_header显示所有PostgreSQL堆和索引页面的公共字段。
用get_raw_page获得的一个页面映像应该作为参数传递。例如：
test=# SELECT * FROM page_header(get_raw_page('pg_class', 0));
lsn    | checksum | flags  | lower | upper | special | pagesize | version | prune_xid
-----------+----------+--------+-------+-------+---------+----------+---------+-----------
0/24A1B50 |        0 |      1 |   232 |   368 |    8192 |     8192 |       4 |         0
返回的列对应于PageHeaderData结构中的字段。详见src/include/storage/bufpage.h。
checksum字段是存储在页面中的校验和，
如果页面以某种方式损坏，则可能不正确。
如果此实例禁用了数据校验和，则存储的值是无意义的。
page_checksum(page bytea, blkno bigint) returns smallint
page_checksum为页面计算校验和，就像它位于给定块上一样。
应该将get_raw_page得到的页面映像作为参数传入。例如：
test=# SELECT page_checksum(get_raw_page('pg_class', 0), 0);
page_checksum
---------------
13443
注意校验和取决于块号，因此应该将匹配的块号传入（除非在做调试）。
用这个函数计算的校验和可以与函数page_header的结果字段checksum进行比较。如果为这个实例启用了数据校验和，则两个值应该相等。
fsm_page_contents(page bytea) returns text
fsm_page_contents显示了FSM页面的内部节点结构。例如：
test=# SELECT fsm_page_contents(get_raw_page('pg_class', 'fsm', 0));
输出是一个多行字符串，每行代表页面内二叉树中的一个节点。只打印那些不为零的节点。
所谓的“next”指针，指向下一个要从页面返回的插槽，也会被打印。
查看src/backend/storage/freespace/README以获取有关FSM页面结构的更多信息。
F.23.2. Heap Functions #
heap_page_items(page bytea) returns setof record
heap_page_items显示一个堆页面上所有的行指针。
对那些使用中的行指针，元组头部和元组原始数据也会被显示。
不管元组对于拷贝原始页面时的 MVCC 快照是否可见，它们都会被显示。
用get_raw_page获得的一个堆页面映像应该作为参数传递。例如：
test=# SELECT * FROM heap_page_items(get_raw_page('pg_class', 0));
返回的字段解释可见src/include/storage/itemid.h和src/include/access/htup_details.h。
heap_tuple_infomask_flags函数可用于为堆元组解包t_infomask
和t_infomask2的标志位。
tuple_data_split(rel_oid oid, t_data bytea, t_infomask integer, t_infomask2 integer, t_bits text [, do_detoast bool]) returns bytea[]
tuple_data_split以与后端内部相同的方式将元组数据拆解成属性。
test=# SELECT tuple_data_split('pg_class'::regclass, t_data, t_infomask, t_infomask2, t_bits) FROM heap_page_items(get_raw_page('pg_class', 0));
应该用与heap_page_items的返回属性相同的参数来调用这个函数。
如果do_detoast是true，则根据需要将属性解除TOAST。默认值为false。
heap_page_item_attrs(page bytea, rel_oid regclass [, do_detoast bool]) returns setof record
heap_page_item_attrs等效于
heap_page_items，不过它会把元组原始数据
返回为属性的数组，如果do_detoast为真（
默认为false），这些属性会被解除TOAST。
应该把用get_raw_page得到的一个堆页面映像
作为参数传入。例如：
test=# SELECT * FROM heap_page_item_attrs(get_raw_page('pg_class', 0), 'pg_class'::regclass);
heap_tuple_infomask_flags(t_infomask integer, t_infomask2 integer) returns record
heap_tuple_infomask_flags将heap_page_items返回的
t_infomask和t_infomask2解码为一组由标志
名称组成的人类可读数组，一列用于所有标志，一列用于组合标志。 例如：
test=# SELECT t_ctid, raw_flags, combined_flags
FROM heap_page_items(get_raw_page('pg_class', 0)),
LATERAL heap_tuple_infomask_flags(t_infomask, t_infomask2)
WHERE t_infomask IS NOT NULL OR t_infomask2 IS NOT NULL;
应该使用与heap_page_items的返回属性相同的参数调用此函数。
为考虑多个原始位值的源级宏显示组合标志，例如HEAP_XMIN_FROZEN。
有关返回的标志名称的说明，请参阅src/include/access/htup_details.h。
F.23.3. B树函数 #
bt_metap(relname text) returns record
bt_metap返回关于一个B树索引元页的信息。例如：
test=# SELECT * FROM bt_metap('pg_cast_oid_index');
-[ RECORD 1 ]-------------------+----------
magic                     | 340322
version                   | 4
root                      | 1
level                     | 0
fastroot                  | 1
fastlevel                 | 0
last_cleanup_num_delpages | 0
last_cleanup_num_tuples   | 230
allequalimage             | f
bt_page_stats(relname text, blkno bigint) returns record
bt_page_stats返回关于B树索引数据页的摘要信息。例如：
test=# SELECT * FROM bt_page_stats('pg_cast_oid_index', 1);
-[ RECORD 1 ]-+-----
blkno         | 1
type          | l
live_items    | 224
dead_items    | 0
avg_item_size | 16
page_size     | 8192
free_size     | 3668
btpo_prev     | 0
btpo_next     | 0
btpo_level    | 0
btpo_flags    | 3
bt_multi_page_stats(relname text, blkno bigint, blk_count bigint) returns setof record
bt_multi_page_stats 返回与 bt_page_stats
相同的信息，但会对从 blkno 开始并延续
blk_count 页的范围内的每一页进行统计。
如果 blk_count 为负数，则会报告从
blkno 到索引末尾的所有页面。例如：
test=# SELECT * FROM bt_multi_page_stats('pg_proc_oid_index', 5, 2);
-[ RECORD 1 ]-+-----
blkno         | 5
type          | l
live_items    | 367
dead_items    | 0
avg_item_size | 16
page_size     | 8192
free_size     | 808
btpo_prev     | 4
btpo_next     | 6
btpo_level    | 0
btpo_flags    | 1
-[ RECORD 2 ]-+-----
blkno         | 6
type          | l
live_items    | 367
dead_items    | 0
avg_item_size | 16
page_size     | 8192
free_size     | 808
btpo_prev     | 5
btpo_next     | 7
btpo_level    | 0
btpo_flags    | 1
bt_page_items(relname text, blkno bigint) returns setof record
bt_page_items返回关于 B-树索引页面上所有项的详细信息。例如：
test=# SELECT itemoffset, ctid, itemlen, nulls, vars, data, dead, htid, tids[0:2] AS some_tids
FROM bt_page_items('tenk2_hundred', 5);
itemoffset |   ctid    | itemlen | nulls | vars |          data           | dead |  htid  |      some_tids
------------+-----------+---------+-------+------+-------------------------+------+--------+---------------------
1 | (16,1)    |      16 | f     | f    | 30 00 00 00 00 00 00 00 |      |        |
2 | (16,8292) |     616 | f     | f    | 24 00 00 00 00 00 00 00 | f    | (1,6)  | {"(1,6)","(10,22)"}
3 | (16,8292) |     616 | f     | f    | 25 00 00 00 00 00 00 00 | f    | (1,18) | {"(1,18)","(4,22)"}
4 | (16,8292) |     616 | f     | f    | 26 00 00 00 00 00 00 00 | f    | (4,18) | {"(4,18)","(6,17)"}
5 | (16,8292) |     616 | f     | f    | 27 00 00 00 00 00 00 00 | f    | (1,2)  | {"(1,2)","(1,19)"}
6 | (16,8292) |     616 | f     | f    | 28 00 00 00 00 00 00 00 | f    | (2,24) | {"(2,24)","(4,11)"}
7 | (16,8292) |     616 | f     | f    | 29 00 00 00 00 00 00 00 | f    | (2,17) | {"(2,17)","(11,2)"}
8 | (16,8292) |     616 | f     | f    | 2a 00 00 00 00 00 00 00 | f    | (0,25) | {"(0,25)","(3,20)"}
9 | (16,8292) |     616 | f     | f    | 2b 00 00 00 00 00 00 00 | f    | (0,10) | {"(0,10)","(0,14)"}
10 | (16,8292) |     616 | f     | f    | 2c 00 00 00 00 00 00 00 | f    | (1,3)  | {"(1,3)","(3,9)"}
11 | (16,8292) |     616 | f     | f    | 2d 00 00 00 00 00 00 00 | f    | (6,28) | {"(6,28)","(11,1)"}
12 | (16,8292) |     616 | f     | f    | 2e 00 00 00 00 00 00 00 | f    | (0,27) | {"(0,27)","(1,13)"}
13 | (16,8292) |     616 | f     | f    | 2f 00 00 00 00 00 00 00 | f    | (4,17) | {"(4,17)","(4,21)"}
(13 rows)
这是一个 B 树的叶子页面。指向该表的所有元组恰好是发布列表元组（所有这些元组总共存储 100 个 6 字节 TID）。在itemoffset编号 1 处还有一个“high key”元组。ctid用于存储本示例中每个元组的编码信息，尽管叶页元组通常将堆 TID 直接存储在ctid字段中。tids是存储为发布列表的 TID 列表。
在内部页面（未显示）中，ctid的块号部分是一个“downlink”，它是索引本身中另一个页面的块号。ctid的偏移部分（第二个数字）存储有关元组的编码信息，例如存在的列数（后缀截断可能已删除不需要的后缀列）。截断的列被视为具有值“minus infinity”。
htid显示元组的堆 TID，无论底层元组表示如何。该值可能与ctid匹配，或者可以从发布列表元组和来自内部页面的元组所使用的替代表示中解码。内部页面中的元组通常会截断实现级别的堆 TID 列，这表示为 NULLhtid值。
注意在任何非最右页面（页面的btpo_next字段中有非零值）上的第一个项是该页的“high key”，表示它的data作为该页面上所有项的一个上界存在，而它的ctid字段不指向另一个块。此外，在内部页面上，第一个真正的数据项（第一个不是高键的项）可靠地将每一列都截断了，在其data字段中没有留下任何实际值。不过，这样一个项确实在其ctid字段中有有效的向下链接。
有关 B 树索引结构的更多详细信息，请参阅第 65.1.4.1 节。有关重复数据删除和发布列表的更多详细信息，请参阅第 65.1.4.3 节。
bt_page_items(page bytea) returns setof record
还可以把一个页面以bytea值的形式传递给bt_page_items。应该将get_raw_page得到的页面映像作为参数传入。因此，上一个例子可以被重写成这样：
test=# SELECT itemoffset, ctid, itemlen, nulls, vars, data, dead, htid, tids[0:2] AS some_tids
FROM bt_page_items(get_raw_page('tenk2_hundred', 5));
itemoffset |   ctid    | itemlen | nulls | vars |          data           | dead |  htid  |      some_tids
------------+-----------+---------+-------+------+-------------------------+------+--------+---------------------
1 | (16,1)    |      16 | f     | f    | 30 00 00 00 00 00 00 00 |      |        |
2 | (16,8292) |     616 | f     | f    | 24 00 00 00 00 00 00 00 | f    | (1,6)  | {"(1,6)","(10,22)"}
3 | (16,8292) |     616 | f     | f    | 25 00 00 00 00 00 00 00 | f    | (1,18) | {"(1,18)","(4,22)"}
4 | (16,8292) |     616 | f     | f    | 26 00 00 00 00 00 00 00 | f    | (4,18) | {"(4,18)","(6,17)"}
5 | (16,8292) |     616 | f     | f    | 27 00 00 00 00 00 00 00 | f    | (1,2)  | {"(1,2)","(1,19)"}
6 | (16,8292) |     616 | f     | f    | 28 00 00 00 00 00 00 00 | f    | (2,24) | {"(2,24)","(4,11)"}
7 | (16,8292) |     616 | f     | f    | 29 00 00 00 00 00 00 00 | f    | (2,17) | {"(2,17)","(11,2)"}
8 | (16,8292) |     616 | f     | f    | 2a 00 00 00 00 00 00 00 | f    | (0,25) | {"(0,25)","(3,20)"}
9 | (16,8292) |     616 | f     | f    | 2b 00 00 00 00 00 00 00 | f    | (0,10) | {"(0,10)","(0,14)"}
10 | (16,8292) |     616 | f     | f    | 2c 00 00 00 00 00 00 00 | f    | (1,3)  | {"(1,3)","(3,9)"}
11 | (16,8292) |     616 | f     | f    | 2d 00 00 00 00 00 00 00 | f    | (6,28) | {"(6,28)","(11,1)"}
12 | (16,8292) |     616 | f     | f    | 2e 00 00 00 00 00 00 00 | f    | (0,27) | {"(0,27)","(1,13)"}
13 | (16,8292) |     616 | f     | f    | 2f 00 00 00 00 00 00 00 | f    | (4,17) | {"(4,17)","(4,21)"}
(13 rows)
所有其他细节和前一项中的解释相同。
F.23.4. BRIN函数 #
brin_page_type(page bytea) returns text
brin_page_type返回给定BRIN索引页的页面类型，如果页面不是有效的BRIN页面，则抛出错误。例如:
test=# SELECT brin_page_type(get_raw_page('brinidx', 0));
brin_page_type
----------------
meta
brin_metapage_info(page bytea) returns record
brin_metapage_info返回有关BRIN索引元页面的各种信息。例如：
test=# SELECT * FROM brin_metapage_info(get_raw_page('brinidx', 0));
magic    | version | pagesperrange | lastrevmappage
------------+---------+---------------+----------------
0xA8109CFA |       1 |             4 |              2
brin_revmap_data(page bytea) returns setof tid
brin_revmap_data返回BRIN索引范围映射页中的元组标识符列表。
例如:
test=# SELECT * FROM brin_revmap_data(get_raw_page('brinidx', 2)) LIMIT 5;
pages
---------
(6,137)
(6,138)
(6,139)
(6,140)
(6,141)
brin_page_items(page bytea, index oid) returns setof record
brin_page_items 返回存储在
BRIN 数据页中的数据。例如：
test=# SELECT * FROM brin_page_items(get_raw_page('brinidx', 5),
'brinidx')
ORDER BY blknum, attnum LIMIT 6;
itemoffset | blknum | attnum | allnulls | hasnulls | placeholder | empty |    value
------------+--------+--------+----------+----------+-------------+-------+--------------
137 |      0 |      1 | t        | f        | f           | f     |
137 |      0 |      2 | f        | f        | f           | f     | {1 .. 88}
138 |      4 |      1 | t        | f        | f           | f     |
138 |      4 |      2 | f        | f        | f           | f     | {89 .. 176}
139 |      8 |      1 | t        | f        | f           | f     |
139 |      8 |      2 | f        | f        | f           | f     | {177 .. 264}
返回的列对应于
BrinMemTuple 和 BrinValues 结构中的字段。
详情请参见 src/include/access/brin_tuple.h。
F.23.5. GIN函数 #
gin_metapage_info(page bytea) returns record
gin_metapage_info 返回有关一个
GIN 索引元页的信息。例如：
test=# SELECT * FROM gin_metapage_info(get_raw_page('gin_index', 0));
-[ RECORD 1 ]----+-----------
pending_head     | 4294967295
pending_tail     | 4294967295
tail_free_size   | 0
n_pending_pages  | 0
n_pending_tuples | 0
n_total_pages    | 7
n_entry_pages    | 6
n_data_pages     | 0
n_entries        | 693
version          | 2
gin_page_opaque_info(page bytea) returns record
gin_page_opaque_info 返回有关一个
GIN 索引不透明区域的信息，如页面类型等。例如：
test=# SELECT * FROM gin_page_opaque_info(get_raw_page('gin_index', 2));
rightlink | maxoff |         flags
-----------+--------+------------------------
5 |      0 | {data,leaf,compressed}
(1 row)
gin_leafpage_items(page bytea) returns setof record
gin_leafpage_items 返回有关存储在压缩的GIN叶子页中的数据的信息。例如：
test=# SELECT first_tid, nbytes, tids[0:5] AS some_tids
FROM gin_leafpage_items(get_raw_page('gin_test_idx', 2));
first_tid | nbytes |                        some_tids
-----------+--------+----------------------------------------------------------
(8,41)    |    244 | {"(8,41)","(8,43)","(8,44)","(8,45)","(8,46)"}
(10,45)   |    248 | {"(10,45)","(10,46)","(10,47)","(10,48)","(10,49)"}
(12,52)   |    248 | {"(12,52)","(12,53)","(12,54)","(12,55)","(12,56)"}
(14,59)   |    320 | {"(14,59)","(14,60)","(14,61)","(14,62)","(14,63)"}
(167,16)  |    376 | {"(167,16)","(167,17)","(167,18)","(167,19)","(167,20)"}
(170,30)  |    376 | {"(170,30)","(170,31)","(170,32)","(170,33)","(170,34)"}
(173,44)  |    197 | {"(173,44)","(173,45)","(173,46)","(173,47)","(173,48)"}
(7 rows)
F.23.6. GiST 函数 #
gist_page_opaque_info(page bytea) returns record
gist_page_opaque_info 返回来自
GiST 索引页的不透明区域的信息，例如 NSN、
rightlink 和页类型。
例如：
test=# SELECT * FROM gist_page_opaque_info(get_raw_page('test_gist_idx', 2));
lsn | nsn | rightlink | flags
-----+-----+-----------+--------
0/1 | 0/0 |         1 | {leaf}
(1 row)
gist_page_items(page bytea, index_oid regclass) returns setof record
gist_page_items 返回有关存储在
GiST 索引页中的数据的信息。例如：
test=# SELECT * FROM gist_page_items(get_raw_page('test_gist_idx', 0), 'test_gist_idx');
itemoffset |   ctid    | itemlen | dead |             keys
------------+-----------+---------+------+-------------------------------
1 | (1,65535) |      40 | f    | (p)=("(185,185),(1,1)")
2 | (2,65535) |      40 | f    | (p)=("(370,370),(186,186)")
3 | (3,65535) |      40 | f    | (p)=("(555,555),(371,371)")
4 | (4,65535) |      40 | f    | (p)=("(740,740),(556,556)")
5 | (5,65535) |      40 | f    | (p)=("(870,870),(741,741)")
6 | (6,65535) |      40 | f    | (p)=("(1000,1000),(871,871)")
(6 rows)
gist_page_items_bytea(page bytea) returns setof record
与 gist_page_items 相同，但将关键数据作为原始 bytea blob 返回。
由于它不尝试解码关键字，因此不需要知道涉及的索引是哪个。例如：
test=# SELECT * FROM gist_page_items_bytea(get_raw_page('test_gist_idx', 0));
itemoffset |   ctid    | itemlen | dead |                                      key_data
------------+-----------+---------+------+-----------------------------------------​-------------------------------------------
1 | (1,65535) |      40 | f    | \x00000100ffff28000000000000c0644000000000​00c06440000000000000f03f000000000000f03f
2 | (2,65535) |      40 | f    | \x00000200ffff28000000000000c0744000000000​00c074400000000000e064400000000000e06440
3 | (3,65535) |      40 | f    | \x00000300ffff28000000000000207f4000000000​00207f400000000000d074400000000000d07440
4 | (4,65535) |      40 | f    | \x00000400ffff28000000000000c0844000000000​00c084400000000000307f400000000000307f40
5 | (5,65535) |      40 | f    | \x00000500ffff28000000000000f0894000000000​00f089400000000000c884400000000000c88440
6 | (6,65535) |      40 | f    | \x00000600ffff28000000000000208f4000000000​00208f400000000000f889400000000000f88940
7 | (7,65535) |      40 | f    | \x00000700ffff28000000000000408f4000000000​00408f400000000000288f400000000000288f40
(7 rows)
F.23.7. Hash 函数 #
hash_page_type(page bytea) returns text
hash_page_type 返回给定 HASH 索引页的页面类型。例如：
test=# SELECT hash_page_type(get_raw_page('con_hash_index', 0));
hash_page_type
----------------
metapage
hash_page_stats(page bytea) returns setof record
hash_page_stats 返回有关一个 HASH 索引的桶页或者溢出页的信息。例如：
test=# SELECT * FROM hash_page_stats(get_raw_page('con_hash_index', 1));
-[ RECORD 1 ]---+-----------
live_items      | 407
dead_items      | 0
page_size       | 8192
free_size       | 8
hasho_prevblkno | 4096
hasho_nextblkno | 8474
hasho_bucket    | 0
hasho_flag      | 66
hasho_page_id   | 65408
hash_page_items(page bytea) returns setof record
hash_page_items 返回有关存储在 HASH 索引页的桶或溢出页中的数据的信息。例如：
test=# SELECT * FROM hash_page_items(get_raw_page('con_hash_index', 1)) LIMIT 5;
itemoffset |   ctid    |    data
------------+-----------+------------
1 | (899,77)  | 1053474816
2 | (897,29)  | 1053474816
3 | (894,207) | 1053474816
4 | (892,159) | 1053474816
5 | (890,111) | 1053474816
hash_bitmap_info(index oid, blkno bigint) returns record
hash_bitmap_info 显示 HASH 索引的特定溢出页的位图页中位的状态。例如：
test=# SELECT * FROM hash_bitmap_info('con_hash_index', 2052);
bitmapblkno | bitmapbit | bitstatus
-------------+-----------+-----------
65 |         3 | t
hash_metapage_info(page bytea) returns record
hash_metapage_info返回存储在HASH索引的元页中的信息。例如：
test=# SELECT magic, version, ntuples, ffactor, bsize, bmsize, bmshift,
test-#     maxbucket, highmask, lowmask, ovflpoint, firstfree, nmaps, procid,
test-#     regexp_replace(spares::text, '(,0)*}', '}') as spares,
test-#     regexp_replace(mapp::text, '(,0)*}', '}') as mapp
test-# FROM hash_metapage_info(get_raw_page('con_hash_index', 0));
-[ RECORD 1 ]-------------------------------------------------​------------------------------
magic     | 105121344
version   | 4
ntuples   | 500500
ffactor   | 40
bsize     | 8152
bmsize    | 4096
bmshift   | 15
maxbucket | 12512
highmask  | 16383
lowmask   | 8191
ovflpoint | 28
firstfree | 1204
nmaps     | 1
procid    | 450
spares    | {0,0,0,0,0,0,1,1,1,1,1,1,1,1,3,4,4,4,45,55,58,59,​508,567,628,704,1193,1202,1204}
mapp      | {65}
上一页 上一级 下一页F.22. ltree — 层次树状数据类型 起始页 F.24. passwordcheck — 验证密码强度
