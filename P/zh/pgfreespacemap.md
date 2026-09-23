# F.27. pg_freespacemap — 检查空闲空间映射

F.27. pg_freespacemap — 检查空闲空间映射
版本：
纠错本页面
搜索
目录导航
❮
❯
F.27. pg_freespacemap — 检查空闲空间映射 #F.27.1. 函数F.27.2. 样本输出F.27.3. 作者
pg_freespacemap模块提供了一种检查空闲空间映射(FSM)的方法。
它提供了一个名为pg_freespace的函数，或者更准确地说，提供了两个重载函数。
这些函数显示了给定页面或关系中所有页面记录在空闲空间映射中的值。
默认情况下，使用受限于超级用户和具有pg_stat_scan_tables角色特权的角色。
可以使用GRANT授予其他用户访问权限。
F.27.1. 函数 #
pg_freespace(rel regclass IN, blkno bigint IN) returns int2
返回由blkno指定的关系页面上根据FSM的空闲空间量。
pg_freespace(rel regclass IN, blkno OUT bigint, avail OUT int2)
显示关系每个页面上的空闲空间量，根据FSM。返回一组
(blkno bigint, avail int2)
元组，每个页面一个元组。
存储在空闲空间映射中的值不准确。它们被四舍五入到BLCKSZ的1/256（对于默认的BLCKSZ是32字节），并且在元组被插入和更新时它们不会被实时更新。
对于索引，跟踪的是完全未使用的页面，而不是页面内的空闲空间。
因此，这些值没有实际意义，只表示页面是被使用还是空闲。
F.27.2. 样本输出 #
postgres=# SELECT * FROM pg_freespace('foo');
blkno | avail
-------+-------
0 |     0
1 |     0
2 |     0
3 |    32
4 |   704
5 |   704
6 |   704
7 |  1216
8 |   704
9 |   704
10 |   704
11 |   704
12 |   704
13 |   704
14 |   704
15 |   704
16 |   704
17 |   704
18 |   704
19 |  3648
(20 rows)
postgres=# SELECT * FROM pg_freespace('foo', 7);
pg_freespace
--------------
1216
(1 row)
F.27.3. 作者 #
原始版本由Mark Kirkwood <markir@paradise.net.nz>撰写。
在版本8.4中重新编写，以适应Heikki Linnakangas <heikki@enterprisedb.com>的新FSM实现。
上一页 上一级 下一页F.26. pgcrypto — 加密函数 起始页 F.28. pg_logicalinspect — 逻辑解码组件检查
