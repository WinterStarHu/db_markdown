# dblink_get_result

dblink_get_result
版本：
纠错本页面
搜索
目录导航
❮
❯
dblink_get_resultdblink_get_result — 获取一个异步查询结果大纲
dblink_get_result(text connname [, bool fail_on_error]) returns setof record
Description
dblink_get_result收集之前dblink_send_query发送的一个异步查询的结果。如果该查询还没有完成，dblink_get_result将等待直到它完成。
参数connname
要使用的连接名。
fail_on_error
如果为真（忽略时的默认值），那么在连接的远端抛出的一个错误也会导致本地抛出一个错误。如果为假，远程错误只在本地被报告为一个 NOTICE，并且该函数不返回行。
返回值
对于一个异步查询（也就是一个返回行的 SQL 语句），该函数返回查询产生的行。要使用这个函数，你将需要指定所期待的列集合，如前面为dblink所讨论的那样。
对于一个异步命令（也就是一个不返回行的 SQL 语句），该函数返回一个只有单个文本列的单行，其中包含了该命令的状态字符串。仍必须在调用的FROM子句中指定结果将具有一个单一文本列。
备注
如果dblink_send_query返回 1，这个函数就必须被调用。对每一个已发送的查询都必须调用一次这个函数，并且在连接再次可用之前还要多调用一次来得到一个空结果集。
当使用dblink_send_query和dblink_get_result时，在将结果集中的任何一行返回给本地查询处理器之前，dblink将取得整个远程查询结果。如果该查询返回大量的行，这可能会导致本地会话中短暂的内存膨胀。最好将这样的一个查询用dblink_open打开成一个游标，并且接着每次取得数量可管理的行。也可以使用简单的dblink()，它会避免缓冲大型结果集到磁盘上导致的内存膨胀。
示例
contrib_regression=# SELECT dblink_connect('dtest1', 'dbname=contrib_regression');
dblink_connect
----------------
OK
(1 row)
contrib_regression=# SELECT * FROM
contrib_regression-# dblink_send_query('dtest1', 'select * from foo where f1 < 3') AS t1;
t1
----
1
(1 row)
contrib_regression=# SELECT * FROM dblink_get_result('dtest1') AS t1(f1 int, f2 text, f3 text[]);
f1 | f2 |     f3
----+----+------------
0 | a  | {a0,b0,c0}
1 | b  | {a1,b1,c1}
2 | c  | {a2,b2,c2}
(3 rows)
contrib_regression=# SELECT * FROM dblink_get_result('dtest1') AS t1(f1 int, f2 text, f3 text[]);
f1 | f2 | f3
----+----+----
(0 rows)
contrib_regression=# SELECT * FROM
contrib_regression-# dblink_send_query('dtest1', 'select * from foo where f1 < 3; select * from foo where f1 > 6') AS t1;
t1
----
1
(1 row)
contrib_regression=# SELECT * FROM dblink_get_result('dtest1') AS t1(f1 int, f2 text, f3 text[]);
f1 | f2 |     f3
----+----+------------
0 | a  | {a0,b0,c0}
1 | b  | {a1,b1,c1}
2 | c  | {a2,b2,c2}
(3 rows)
contrib_regression=# SELECT * FROM dblink_get_result('dtest1') AS t1(f1 int, f2 text, f3 text[]);
f1 | f2 |      f3
----+----+---------------
7 | h  | {a7,b7,c7}
8 | i  | {a8,b8,c8}
9 | j  | {a9,b9,c9}
10 | k  | {a10,b10,c10}
(4 rows)
contrib_regression=# SELECT * FROM dblink_get_result('dtest1') AS t1(f1 int, f2 text, f3 text[]);
f1 | f2 | f3
----+----+----
(0 rows)
上一页 上一级 下一页dblink_get_notify 起始页 dblink_cancel_query
