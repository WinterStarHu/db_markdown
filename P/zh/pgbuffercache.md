# F.25. pg_buffercache — 检查PostgreSQL 缓冲区缓存状态

F.25. pg_buffercache — 检查PostgreSQL 缓冲区缓存状态
版本：
纠错本页面
搜索
目录导航
❮
❯
F.25. pg_buffercache — 检查PostgreSQL
缓冲区缓存状态 #F.25.1. pg_buffercache 视图F.25.2. The pg_buffercache_numa 视图F.25.3. pg_buffercache_summary() 函数F.25.4. pg_buffercache_usage_counts() 函数F.25.5. pg_buffercache_evict() 函数F.25.6. pg_buffercache_evict_relation() 函数F.25.7. pg_buffercache_evict_all() 函数F.25.8. 样例输出F.25.9. 作者
pg_buffercache模块提供了一种实时检查共享缓冲区缓存中
发生情况的方法。它还提供了一种低级方式来驱逐其中的数据，用于测试目的。
该模块提供了 pg_buffercache_pages()
函数（封装在 pg_buffercache 视图中），
pg_buffercache_numa_pages() 函数（封装在
pg_buffercache_numa 视图中），
pg_buffercache_summary() 函数，
pg_buffercache_usage_counts() 函数，
pg_buffercache_evict() 函数，
pg_buffercache_evict_relation() 函数和
pg_buffercache_evict_all() 函数。
pg_buffercache_pages()函数返回一组记录，每行描述一个共享缓冲区
条目的状态。pg_buffercache视图封装了该函数以便于使用。
pg_buffercache_numa_pages() 函数提供了
NUMA 节点映射，用于共享缓冲区条目。
该信息不是 pg_buffercache_pages() 本身的一部分，
因为检索速度较慢。
pg_buffercache_numa 视图封装了该函数以便于使用。
pg_buffercache_summary() 函数返回一行摘要，概述共享缓冲区缓存的状态。
pg_buffercache_usage_counts() 函数返回一组记录，每行描述具有
给定使用计数的缓冲区数量。
默认情况下，上述函数的使用仅限于超级用户和具有pg_monitor角色权限的角色。
访问权限可以通过GRANT授予其他用户。
pg_buffercache_evict()函数允许根据缓冲区标识符将块从缓冲池中驱逐。
该函数的使用仅限于超级用户。
pg_buffercache_evict_relation() 函数允许根据
关系标识符将关系中的所有未固定共享缓冲区从缓冲池中驱逐。
该函数的使用仅限于超级用户。
pg_buffercache_evict_all() 函数允许将缓冲池中的所有
未固定共享缓冲区驱逐。该函数的使用仅限于超级用户。
F.25.1. pg_buffercache 视图 #
视图显示的列的定义如表 F.14所示。
表 F.14. pg_buffercache 列
列类型
描述
bufferid integer
ID，在范围 1..shared_buffers中
relfilenode oid
(references pg_class.relfilenode)
关系的文件节点编号
reltablespace oid
(references pg_tablespace.oid)
关系的表空间 OID
reldatabase oid
(references pg_database.oid)
关系的数据库 OID
relforknumber smallint
关系内的分叉数；见common/relpath.h
relblocknumber bigint
关系内的页面编号
isdirty boolean
页面是否为脏？
usagecount smallint
Clock-sweep 访问计数
pinning_backends integer
对这个缓冲区加 pin 的后端数量
共享缓存中的每一个缓冲区都有一行。没有使用的缓冲区的行中只有bufferid为非空。共享的系统目录被显示为属于数据库零。
因为缓存是所有数据库共享的，通常会有不属于当前数据库的关系的页面。这意味着对于一些行在pg_class中可能不会有匹配的连接行，或者甚至有错误的连接。如果你试图与pg_class连接，将连接限制于reldatabase等于当前数据库的 OID 或零的行是一个好主意。
由于缓冲区管理器锁不会用于复制视图将显示的缓冲区状态数据，因此访问pg_buffercache视图对正常缓冲区活动的影响较小，但它不会在所有缓冲区中提供一致的结果集。但是，我们确保每个缓冲区的信息是自洽的。
F.25.2. The pg_buffercache_numa 视图 #
视图所暴露的列的定义见 表 F.15。
表 F.15. pg_buffercache_numa 列
列类型
描述
bufferid integer
ID，在范围 1..shared_buffers中
os_page_num bigint
此缓冲区的操作系统内存页面数量
numa_node int
NUMA 节点的 ID
由于每个页面的 NUMA 节点 ID 查询需要将内存页面调入内存，
因此第一次执行此函数可能会耗费显著的时间。在所有情况下（无论是否为第一次执行），
检索此信息都是昂贵的，不建议以高频率查询该视图。
警告
在确定 NUMA 节点时，视图会访问共享内存段的所有内存页面。
如果共享内存尚未分配，这将强制分配共享内存，
并且内存可能会在单个 NUMA 节点中分配（具体取决于系统配置）。
F.25.3. pg_buffercache_summary() 函数 #
函数所显示列的定义如表 F.16中所示。
表 F.16. pg_buffercache_summary() 输出列
列类型
描述
buffers_used int4
使用的共享缓冲区数量
buffers_unused int4
未使用的共享缓冲区数量
buffers_dirty int4
脏共享缓冲区的数量
buffers_pinned int4
被固定的共享缓冲区数量
usagecount_avg float8
已使用共享缓冲区的平均使用计数
pg_buffercache_summary() 函数返回一行摘要，概述所有共享缓冲区的状态。
类似且更详细的信息由 pg_buffercache 视图提供，但
pg_buffercache_summary() 的开销显著更低。
与 pg_buffercache 视图类似，
pg_buffercache_summary() 不会获取缓冲区管理器锁。
因此，并发活动可能会导致结果出现轻微的不准确。
F.25.4. pg_buffercache_usage_counts() 函数 #
函数所暴露的列的定义如
表 F.17中所示。
表 F.17. pg_buffercache_usage_counts() 输出列
列类型
描述
usage_count int4
可能的缓冲区使用计数
buffers int4
使用计数的缓冲区数量
dirty int4
使用计数的脏缓冲区数量
pinned int4
使用计数的固定缓冲区数量
pg_buffercache_usage_counts() 函数返回一组行，总结了所有共享缓冲区的
状态，并按可能的使用计数值进行聚合。类似且更详细的信息由
pg_buffercache 视图提供，但
pg_buffercache_usage_counts() 显著更便宜。
与pg_buffercache视图类似，
pg_buffercache_usage_counts()不会获取缓冲区管理器锁。
因此，并发活动可能会导致结果中出现轻微的不准确。
F.25.5. pg_buffercache_evict() 函数 #
pg_buffercache_evict() 函数接受一个缓冲区标识符，
如 bufferid 列所示。它返回有关缓冲区是否被驱逐和刷新
的信息。buffer_evicted 列在成功时为 true，如果缓冲区无效、无法驱逐（因为它被固定），
或在尝试写出后再次变脏，则为 false。buffer_flushed 列在缓冲区被刷新时为 true。
这并不一定意味着缓冲区是由我们刷新，可能是由其他人刷新。返回时结果立即过时，
因为缓冲区可能由于并发活动而随时变得有效。该函数仅用于开发者测试。
F.25.6. pg_buffercache_evict_relation() 函数 #
pg_buffercache_evict_relation() 函数与 pg_buffercache_evict()
函数非常相似。不同之处在于 pg_buffercache_evict_relation() 接受一个关系标识符，
而不是缓冲区标识符。它尝试驱逐该关系中所有分支的所有缓冲区。
它返回被驱逐的缓冲区数量、已刷新缓冲区数量和无法驱逐的缓冲区数量。
已刷新缓冲区不一定是由我们刷新，可能是由其他人刷新。返回时结果立即过时，
因为缓冲区可能由于并发活动而立即被重新读取。该函数仅用于开发者测试。
F.25.7. pg_buffercache_evict_all() 函数 #
pg_buffercache_evict_all() 函数与 pg_buffercache_evict()
函数非常相似。不同之处在于 pg_buffercache_evict_all() 函数
不接受参数；相反，它尝试驱逐缓冲池中的所有缓冲区。它返回被驱逐的缓冲区数量、
已刷新缓冲区数量和无法驱逐的缓冲区数量。已刷新缓冲区不一定是由我们刷新，
可能是由其他人刷新。返回时结果立即过时，因为缓冲区可能由于并发活动而立即被重新读取。
该函数仅用于开发者测试。
F.25.8. 样例输出 #
regression=# SELECT n.nspname, c.relname, count(*) AS buffers
FROM pg_buffercache b JOIN pg_class c
ON b.relfilenode = pg_relation_filenode(c.oid) AND
b.reldatabase IN (0, (SELECT oid FROM pg_database
WHERE datname = current_database()))
JOIN pg_namespace n ON n.oid = c.relnamespace
GROUP BY n.nspname, c.relname
ORDER BY 3 DESC
LIMIT 10;
nspname   |        relname         | buffers
------------+------------------------+---------
public     | delete_test_table      |     593
public     | delete_test_table_pkey |     494
pg_catalog | pg_attribute           |     472
public     | quad_poly_tbl          |     353
public     | tenk2                  |     349
public     | tenk1                  |     349
public     | gin_test_idx           |     306
pg_catalog | pg_largeobject         |     206
public     | gin_test_tbl           |     188
public     | spgist_text_tbl        |     182
(10 rows)
regression=# SELECT * FROM pg_buffercache_summary();
buffers_used | buffers_unused | buffers_dirty | buffers_pinned | usagecount_avg
--------------+----------------+---------------+----------------+----------------
248 |        2096904 |            39 |              0 |       3.141129
(1 row)
regression=# SELECT * FROM pg_buffercache_usage_counts();
usage_count | buffers | dirty | pinned
-------------+---------+-------+--------
0 |   14650 |     0 |      0
1 |    1436 |   671 |      0
2 |     102 |    88 |      0
3 |      23 |    21 |      0
4 |       9 |     7 |      0
5 |     164 |   106 |      0
(6 rows)
F.25.9. 作者 #
Mark Kirkwood <markir@paradise.net.nz>
设计建议：Neil Conway <neilc@samurai.com>
调试建议：Tom Lane <tgl@sss.pgh.pa.us>
上一页 上一级 下一页F.24. passwordcheck — 验证密码强度 起始页 F.26. pgcrypto — 加密函数
