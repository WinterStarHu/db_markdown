# dblink_open

dblink_open
版本：
纠错本页面
搜索
目录导航
❮
❯
dblink_opendblink_open — 在远程数据库中打开游标大纲
dblink_open(text cursorname, text sql [, bool fail_on_error]) returns text
dblink_open(text connname, text cursorname, text sql [, bool fail_on_error]) returns text
描述
dblink_open()在一个远程数据库中打开一个游标。该游标可以随后使用dblink_fetch()和dblink_close()进行操纵。
参数connname
要使用的连接名；忽略这个参数将使用未命名连接。
cursorname
要赋予这个游标的名称。
sql
你希望在远程数据库中执行的SELECT语句，例如select * from pg_class。
fail_on_error
如果为真（忽略时的默认值），那么在连接的远端抛出的一个错误也会导致本地抛出一个错误。如果为假，远程错误只在本地被报告为一个 NOTICE，并且该函数的返回值被设置为ERROR。
返回值
返回状态，OK或ERROR。
注释
因为一个游标只能在一个事务中持续，如果远端还没有在一个事务中，dblink_open会在远端开始一个显式事务块（BEGIN）。当匹配的dblink_close被执行时，这个事务将再次被关闭。注意如果你使用dblink_exec在dblink_open和dblink_close之间改变数据，并且接着发生了一个错误或者你在dblink_close之前使用了dblink_disconnect，你的更改将被丢失，因为事务将被中止。
示例
SELECT dblink_connect('dbname=postgres options=-csearch_path=');
dblink_connect
----------------
OK
(1 row)
SELECT dblink_open('foo', 'select proname, prosrc from pg_proc');
dblink_open
-------------
OK
(1 row)
上一页 上一级 下一页dblink_exec 起始页 dblink_fetch
