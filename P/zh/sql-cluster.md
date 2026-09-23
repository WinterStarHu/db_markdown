# CLUSTER

CLUSTER
版本：
纠错本页面
搜索
目录导航
❮
❯
CLUSTERCLUSTER — 根据索引聚簇一个表大纲
CLUSTER [ ( option [, ...] ) ] [ table_name [ USING index_name ] ]
其中 option 可以是：
VERBOSE [ boolean ]
描述
CLUSTER指示PostgreSQL
基于index_name
所指定的索引来聚簇
table_name
所指定的表。该索引必须已经定义在
table_name上。
当一个表被聚簇时，会基于索引信息对它进行物理上的排序。聚簇是一种
一次性的操作：当表后续被更新时，更改没有被聚簇。也就是说，不会尝
试根据新行或被更新行的索引顺序来存储它们（如果想这样做，可以周
期性地通过发出该命令重新聚簇。还有，把表的
fillfactor存储参数设置为小于 100% 有助于在更
新期间保持聚簇顺序，因为如果空间足够会把被更新行保留在同一个页面
中）。
当一个表被聚簇时，PostgreSQL
会记住它是按照哪个索引聚簇的。形式
CLUSTER table_name
会使用前面所用的同一个索引对表重新聚簇。你也可以使用
CLUSTER或者ALTER TABLE
的SET WITHOUT CLUSTER形式把索引设置为可用于
未来的聚簇操作，或者清除任何之前的设置。
CLUSTER 不带
table_name 参数时，会重新聚簇当前数据库中调用用户有权限的所有先前已聚簇的表。
这种形式的 CLUSTER 不能在事务块内执行。
当一个表被集簇时，会在其上要求一个ACCESS
EXCLUSIVE锁。这会阻止任何其他数据库操作（包括读和写）
在CLUSTER结束前在该表上操作。
参数table_name
一个表的名称（可能是模式限定的）。
index_name
一个索引的名称。
VERBOSE
在 INFO 级别打印每个表被集簇时的进度报告。
boolean
指定打开还是关闭选定的选项。你可以输入TRUE、
ON或1启用该选项，
或者输入FALSE、OFF或0禁用它。
也可以省略这个boolean值，
在这种情况下，假设其值为TRUE。
注意事项
要对表进行集簇，必须拥有该表的MAINTAIN权限。
在随机访问一个表中的行时，表中数据的实际顺序是无关紧要的。
不过，如果你想要更多地访问其中一些数据，并且有一个索引把它
们分组在一起，使用CLUSTER就会带
来好处。如果你从一个表中要求一个范围的被索引值或者多行都匹
配的一个单一值，CLUSTER就会有所
帮助，因为一旦该索引标识出了第一个匹配行所在的表页，所有其
他匹配行很可能就在同一个表页中，并且因此节省了磁盘访问并且
提高了查询速度。
CLUSTER可以使用指定索引上的一次索引扫描
或者遵循排序的一次顺序扫描（如果索引是 b-tree）对表重新排序。
它将会基于规划器代价参数以及可用的统计信息来选择较快的方法。
当CLUSTER正在运行时，search_path会暂时更改为pg_catalog,
pg_temp。
在使用索引扫描时，会创建该表的一份临时拷贝，其中包含按索引顺序
排列的表数据。该表上每一个索引的临时拷贝也会被创建。因此，在磁
盘上需要至少等于表大小加上索引大小的空闲空间。
在使用顺序扫描以及排序时，也会创建一个临时排序文件，因此临时空
间需求的峰值也就是表大小的两倍外加索引大小。这种方法通常比索引
扫描方法更快，但是如果磁盘空间需求是不能接受的，你可以通过临时
地把enable_sort设置为off来禁
用这种选择。
建议在聚簇前把maintenance_work_mem设
置为一个合理比较大的值（但是不能超过你可以用于
CLUSTER操作的 RAM 容量）。
因为规划器会记录有关表顺序的统计信息，建议在新近被聚簇的表上
运行ANALYZE。否则，规划器可能会产生很差
的查询计划。
因为CLUSTER会记住哪些索引被聚簇，
我们可以第一次手动聚簇想要聚簇的表，然后设置一个定期运行的维护
脚本，其中执行不带任何参数的CLUSTER，这样那些
表就会被周期性地重新聚簇。
运行CLUSTER的每个后端将在
pg_stat_progress_cluster视图中报告其进度。
有关详细信息，请参见第 27.4.2 节。
对分区表进行聚类会使用指定分区索引的分区对其每个分区进行聚类。
对分区表进行聚类时，索引不能被省略。CLUSTER在分区表上
不能在事务块内执行。
示例
基于索引employees_ind聚簇表
employees：
CLUSTER employees USING employees_ind;
使用之前用过的同一个索引聚簇employees表：
CLUSTER employees;
对数据库中以前被聚簇过的所有表进行聚簇：
CLUSTER;
兼容性
在 SQL 标准中没有CLUSTER语句。
以下语法在 PostgreSQL 17 之前使用，且仍然支持：
CLUSTER [ VERBOSE ] [ table_name [ USING index_name ] ]
以下语法在 PostgreSQL 8.3 之前使用，且仍然支持：
CLUSTER index_name ON table_name
另见clusterdb, 第 27.4.2 节上一页 上一级 下一页CLOSE 起始页 COMMENT
