# dblink_close

dblink_close
版本：
纠错本页面
搜索
目录导航
❮
❯
dblink_closedblink_close — 关闭远程数据库中的游标大纲
dblink_close(text cursorname [, bool fail_on_error]) returns text
dblink_close(text connname, text cursorname [, bool fail_on_error]) returns text
描述
dblink_close关闭一个之前由dblink_open打开的游标。
参数connname
要使用的连接名；忽略这个参数将使用未命名连接。
cursorname
要关闭的游标名。
fail_on_error
如果为真（忽略时的默认值），那么在连接的远端抛出的一个错误也会导致本地抛出一个错误。如果为假，远程错误只在本地被报告为一个 NOTICE，并且该函数的返回值被设置为ERROR。
返回值
返回状态，OK或ERROR。
注意事项
如果dblink_open开始了一个显式事务块，并且这是这个连接中最后一个保持打开的游标，dblink_close将发出匹配的COMMIT。
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
SELECT dblink_close('foo');
dblink_close
--------------
OK
(1 row)
上一页 上一级 下一页dblink_fetch 起始页 dblink_get_connections
