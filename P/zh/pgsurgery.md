# F.34. pg_surgery — 对关系数据执行低级操作

F.34. pg_surgery — 对关系数据执行低级操作
版本：
纠错本页面
搜索
目录导航
❮
❯
F.34. pg_surgery — 对关系数据执行低级操作 #F.34.1. 函数F.34.2. 作者
pg_surgery模块提供了各种函数来对损坏的表进行修复。 这些函数在设计上是不安全的，使用它们可能会损坏（或进一步损坏）您的数据库。 例如，这些函数可以很容易地用于使表与其自己的索引不一致，导致 UNIQUE 或 FOREIGN KEY 约束违规，甚至使读取时将导致数据库服务器崩溃的元组可见。 应非常谨慎地使用它们，并且仅作为最后的手段。
F.34.1. 函数 #
heap_force_kill(regclass, tid[]) returns void
heap_force_kill标记“已使用”的行指针为“无效”，而不检查元组。
此函数的预期用途是强制删除其他方式无法访问的元组。例如：
test=> select * from t1 where ctid = '(0, 1)';
ERROR:  could not access status of transaction 4007513275
DETAIL:  Could not open file "pg_xact/0EED": No such file or directory.
test=# select heap_force_kill('t1'::regclass, ARRAY['(0, 1)']::tid[]);
heap_force_kill
-----------------
(1 row)
test=# select * from t1 where ctid = '(0, 1)';
(0 rows)
heap_force_freeze(regclass, tid[]) returns void
heap_force_freeze标记元组为冻结状态，而不检查元组数据。该函数的预期用途是使无法访问的元组变得可访问，因为可见性信息损坏，或者由于可见性信息损坏而阻止表成功进行清理。例如：
test=> vacuum t1;
ERROR:  found xmin 507 from before relfrozenxid 515
CONTEXT:  while scanning block 0 of relation "public.t1"
test=# select ctid from t1 where xmin = 507;
ctid
-------
(0,3)
(1 row)
test=# select heap_force_freeze('t1'::regclass, ARRAY['(0, 3)']::tid[]);
heap_force_freeze
-------------------
(1 row)
test=# select ctid from t1 where xmin = 2;
ctid
-------
(0,3)
(1 row)
F.34.2. 作者 #
Ashutosh Sharma <ashu.coek88@gmail.com>
上一页 上一级 下一页F.33. pgstattuple — 获取元组级别的统计信息 起始页 F.35. pg_trgm —
使用三元组匹配支持文本相似性
