# F.31. pgrowlocks — 显示表的行锁定信息

F.31. pgrowlocks — 显示表的行锁定信息
版本：
纠错本页面
搜索
目录导航
❮
❯
F.31. pgrowlocks — 显示表的行锁定信息 #F.31.1. 概述F.31.2. 样例输出F.31.3. 作者
pgrowlocks模块提供了一个函数来显示指定表的行锁定信息。
默认情况下，使用受限于超级用户、具有pg_stat_scan_tables角色特权的角色，
以及对表具有SELECT权限的用户。
F.31.1. 概述 #
pgrowlocks(text) returns setof record
参数是一个表的名称。结果是一个记录集合，其中每一行对应表中一个被锁定的行。输出列如表 F.21所示。
表 F.21. pgrowlocks 输出列名称类型描述locked_rowtid被锁定行的元组 ID (TID)lockerxid锁的事务 ID，或者如果是多事务，则为多事务 ID；请参阅
第 67.1 节multiboolean如果持锁者是一个多事务，则为真xidsxid[]持锁者的事务 ID（如果是多事务则多于一个）modestext[]锁定多个事务时的锁模式（可多个），一个包含
For Key Share、For Share、
For No Key Update、No Key Update、
For Update、Update的数组。pidsinteger[]锁定后端的进程 ID（如果是多事务则多于一个）
pgrowlocks会为目标表加AccessShareLock并且一个一个读取每一行来收集行的锁定信息。这对于一个大表不是很快。注意：
如果一个表上持有一个ACCESS EXCLUSIVE锁，pgrowlocks将被阻塞。
pgrowlocks不保证能产生一个自我一致的快照。在它执行期间，有可能加上一个新行锁，也有可能有旧行锁被释放。
pgrowlocks不显示被锁定行的内容。如果你想同时查看行内容，你可以这样做：
SELECT * FROM accounts AS a, pgrowlocks('accounts') AS p
WHERE p.locked_row = a.ctid;
不过要注意，这样一个查询将非常低效。
F.31.2. 样例输出 #
=# SELECT * FROM pgrowlocks('t1');
locked_row | locker | multi | xids  |     modes      |  pids
------------+--------+-------+-------+----------------+--------
(0,1)      |    609 | f     | {609} | {"For Share"}  | {3161}
(0,2)      |    609 | f     | {609} | {"For Share"}  | {3161}
(0,3)      |    607 | f     | {607} | {"For Update"} | {3107}
(0,4)      |    607 | f     | {607} | {"For Update"} | {3107}
(4 rows)
F.31.3. 作者 #
Tatsuo Ishii
上一页 上一级 下一页F.30. pg_prewarm — 将关系数据预加载到缓冲区缓存中 起始页 F.32. pg_stat_statements — 跟踪 SQL 规划和执行的统计信息
