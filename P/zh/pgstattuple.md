# F.33. pgstattuple — 获取元组级别的统计信息

F.33. pgstattuple — 获取元组级别的统计信息
版本：
纠错本页面
搜索
目录导航
❮
❯
F.33. pgstattuple — 获取元组级别的统计信息 #F.33.1. 函数F.33.2. 作者
pgstattuple模块提供多种函数来获取元组级别的统计信息。
由于这些函数返回详细的页面级信息，因此默认访问权限是受限制的。 默认情况下，只有角色pg_stat_scan_tables具有EXECUTE特权。 超级用户当然可以绕过这个限制。扩展程序安装后，用户可以发送GRANT命令来更改函数的权限以允许其他用户执行它们。但是，最好将这些用户添加到pg_stat_scan_tables角色。
F.33.1. 函数 #
pgstattuple(regclass) returns record
pgstattuple返回一个关系的物理长度、“死亡”元组的百分比以及其他信息。这可以帮助用户决定是否需要清理。参数是目标关系的名称（可以有选择地用模式限定）或者 OID。例如：
test=> SELECT * FROM pgstattuple('pg_catalog.pg_proc');
-[ RECORD 1 ]------+-------
table_len          | 458752
tuple_count        | 1470
tuple_len          | 438896
tuple_percent      | 95.67
dead_tuple_count   | 11
dead_tuple_len     | 3157
dead_tuple_percent | 0.69
free_space         | 8932
free_percent       | 1.95
表 F.24中描述了输出列。
表 F.24. pgstattuple 输出列列类型描述table_lenbigint物理关系长度（以字节计）tuple_countbigint存活元组的数量tuple_lenbigint存活元组的总长度（以字节计）tuple_percentfloat8存活元组的百分比dead_tuple_countbigint死亡元组的数量dead_tuple_lenbigint死亡元组的总长度（以字节计）dead_tuple_percentfloat8死亡元组的百分比free_spacebigint空闲空间总量（以字节计）free_percentfloat8空闲空间的百分比注意
table_len将总是比tuple_len、
dead_tuple_len和free_space的和要大。
不同之处在于固定的页面开销，每页指向元组的指针表和填充以确保元组正确对齐。
pgstattuple只要求在关系上的一个读锁。因此结果不能反映一个即时快照，并发更新将影响结果。
如果HeapTupleSatisfiesDirty返回假，pgstattuple就判定一个元组是“死的”。
pgstattuple(text) returns record
与pgstattuple(regclass)相同，只不过通过TEXT指定目标关系。这个函数只是为了向后兼容而保留，在未来的发布中将会被废除。
pgstatindex(regclass) returns record
pgstatindex返回一个记录显示有关一个B-树索引的信息。例如：
test=> SELECT * FROM pgstatindex('pg_cast_oid_index');
-[ RECORD 1 ]------+------
version            | 2
tree_level         | 0
index_size         | 16384
root_block_no      | 1
internal_pages     | 0
leaf_pages         | 1
empty_pages        | 0
deleted_pages      | 0
avg_leaf_density   | 54.27
leaf_fragmentation | 0
输出列是：
列类型描述versionintegerB-树版本号tree_levelinteger根页的树层次index_sizebigint以字节计的索引总尺寸root_block_nobigint根页的位置（如果没有则为零）internal_pagesbigint数量的“内部”（上层）页面leaf_pagesbigint叶子页的数量empty_pagesbigint空页的数量deleted_pagesbigint删除页的数量avg_leaf_densityfloat8叶子页的平均密度leaf_fragmentationfloat8叶子页碎片
报告的index_size通常对应于internal_pages + leaf_pages + empty_pages + deleted_pages加一，因为它还包括索引的元页。
对于pgstattuple，结果是一页一页累计的，并且不要期望结果会表示整个索引的一个即时快照。
pgstatindex(text) returns record
与pgstatindex(regclass)相同，只不过通过TEXT指定目标索引。这个函数只是为了向后兼容而保留，在未来的某个发布中将会被废除。
pgstatginindex(regclass) 返回 record
pgstatginindex返回一个记录显示有关一个GIN索引的信息。例如：
test=> SELECT * FROM pgstatginindex('test_gin_index');
-[ RECORD 1 ]--+--
version        | 1
pending_pages  | 0
pending_tuples | 0
输出列是：
列类型描述versionintegerGIN版本号pending_pagesinteger待处理列表中的页面数pending_tuplesbigint待处理列表中的元组数
pgstathashindex(regclass) returns record
pgstathashindex返回一个显示HASH索引信息的记录。例如：
test=> select * from pgstathashindex('con_hash_index');
-[ RECORD 1 ]--+-----------------
version        | 4
bucket_pages   | 33081
overflow_pages | 0
bitmap_pages   | 1
unused_pages   | 32455
live_items     | 10204006
dead_items     | 0
free_percent   | 61.8005949100872
输出字段是：
字段类型描述versionintegerHASH版本号bucket_pagesbigint存储桶页面的数量overflow_pagesbigint溢出页面的数量bitmap_pagesbigint位图页面的数量unused_pagesbigint未使用页面的数量live_itemsbigint活元组的数量dead_tuplesbigint死元组的数量free_percentfloat自由空间的百分比
pg_relpages(regclass) returns bigint
pg_relpages返回关系中的页面数。
pg_relpages(text) returns bigint
与pg_relpages(regclass)相同，只不过用TEXT来指定目标关系。这个函数只是为了向后兼容而保留，在未来的某个发布中将会被废除。
pgstattuple_approx(regclass) returns record
pgstattuple_approx是pgstattuple的一个更快速的替代品，它返回近似的结果。参数是目标关系的OID或者名称。例如：
test=> SELECT * FROM pgstattuple_approx('pg_catalog.pg_proc'::regclass);
-[ RECORD 1 ]--------+-------
table_len            | 573440
scanned_percent      | 2
approx_tuple_count   | 2740
approx_tuple_len     | 561210
approx_tuple_percent | 97.87
dead_tuple_count     | 0
dead_tuple_len       | 0
dead_tuple_percent   | 0
approx_free_space    | 11996
approx_free_percent  | 2.09
输出列在表 F.25中描述。
鉴于pgstattuple总是执行全表扫描并且返回存活和死亡元组的准确计数、尺寸和空闲空间，pgstattuple_approx尝试避免全表扫描并且返回死亡元组的准确统计信息，以及存活元组和空闲空间的近似数量及尺寸。
这个函数通过根据可见性映射跳过只包含可见元组的页面来实现这一目的（如果一个页面对应的 VM 位被设置，那么就假定它不含有死亡元组）。对于这样的页面，它会从空闲空间映射中得到空闲空间值，并且假定该页面上的剩余空间由存活元组占据。
对于不能被跳过的页面，它会扫描每个元组，在合适的计数器中记录它的存在以及尺寸，并且统计该页面上的空闲空间。最后，它会基于已扫描的页面和元组数量来估计存活元组的总数（采用与 VACUUM 估计 pg_class.reltuples 时相同的方法）。
表 F.25. pgstattuple_approx 输出列列类型描述table_lenbigint以字节计的物理关系长度（准确）scanned_percentfloat8已扫描表的百分比approx_tuple_countbigint存活元组的数量（估计）approx_tuple_lenbigint以字节计的存活元组总长度（估计）approx_tuple_percentfloat8存活元组的百分比dead_tuple_countbigint死亡元组的数量（准确）dead_tuple_lenbigint以字节计的死亡元组总长度（准确）dead_tuple_percentfloat8死亡元组的百分比approx_free_spacebigint以字节计的总空闲空间（估计）approx_free_percentfloat8空闲空间的百分比
在上述输出中，空闲空间数字可能不完全匹配pgstattuple的输出，这是因为空闲空间映射会给出一个准确的数字，但不能保证是准确到字节。
F.33.2. 作者 #
Tatsuo Ishii, Satoshi Nagayasu 和 Abhijit Menon-Sen
上一页 上一级 下一页F.32. pg_stat_statements — 跟踪 SQL 规划和执行的统计信息 起始页 F.34. pg_surgery — 对关系数据执行低级操作
