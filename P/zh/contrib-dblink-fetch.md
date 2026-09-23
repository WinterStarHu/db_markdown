# dblink_fetch

dblink_fetch
版本：
纠错本页面
搜索
目录导航
❮
❯
dblink_fetchdblink_fetch — 从一个远程数据库中的打开的游标返回行大纲
dblink_fetch(text cursorname, int howmany [, bool fail_on_error]) returns setof record
dblink_fetch(text connname, text cursorname, int howmany [, bool fail_on_error]) returns setof record
描述
dblink_fetch从一个之前由dblink_open建立的游标中获取行。
参数connname
要使用的连接名；忽略这个参数将使用未命名连接。
cursorname
要从中获取数据的游标名。
howmany
要检索的最大行数。接下来howmany行将从当前游标位置开始向前获取。一旦游标到达末尾，将不会产生更多行。
fail_on_error
如果为真（忽略时的默认值），那么在连接的远端抛出的错误也会导致本地抛出错误。如果为假，远程错误只在本地被报告为一个 NOTICE，并且该函数不返回行。
返回值
该函数返回从游标中获取的行。要使用这个函数，你需要指定期望的列集合，如前面dblink中所讨论的。
注释
当FROM子句中指定的返回列的数量和远程游标返回的实际列数不匹配时，将抛出一个错误。在这个事件中，远程游标仍会被前进的行数与错误未发生时相同。对于远程FETCH完成之后在本地查询中发生的任何其他错误，情况也是一样。
示例
SELECT dblink_connect('dbname=postgres options=-csearch_path=');
dblink_connect
----------------
OK
(1 row)
SELECT dblink_open('foo', 'select proname, prosrc from pg_proc where proname like ''bytea%''');
dblink_open
-------------
OK
(1 row)
SELECT * FROM dblink_fetch('foo', 5) AS (funcname name, source text);
funcname |  source
----------+----------
byteacat | byteacat
byteacmp | byteacmp
byteaeq  | byteaeq
byteage  | byteage
byteagt  | byteagt
(5 rows)
SELECT * FROM dblink_fetch('foo', 5) AS (funcname name, source text);
funcname  |  source
-----------+-----------
byteain   | byteain
byteale   | byteale
bytealike | bytealike
bytealt   | bytealt
byteane   | byteane
(5 rows)
SELECT * FROM dblink_fetch('foo', 5) AS (funcname name, source text);
funcname  |   source
------------+------------
byteanlike | byteanlike
byteaout   | byteaout
(2 rows)
SELECT * FROM dblink_fetch('foo', 5) AS (funcname name, source text);
funcname | source
----------+--------
(0 rows)
上一页 上一级 下一页dblink_open 起始页 dblink_close
