# dblink_exec

dblink_exec
版本：
纠错本页面
搜索
目录导航
❮
❯
dblink_execdblink_exec — 在远程数据库中执行命令大纲
dblink_exec(text connname, text sql [, bool fail_on_error]) returns text
dblink_exec(text connstr, text sql [, bool fail_on_error]) returns text
dblink_exec(text sql [, bool fail_on_error]) returns text
描述
dblink_exec在一个远程数据库中执行一个命令（也就是，任何不返回行的 SQL 语句）。
当给定两个text参数时，第一个被首先作为一个持久连接的名称进行查找；如果找到，该命令会在该连接上执行。如果没有找到，第一个参数被视作一个用于dblink_connect的连接信息字符串，并且被指出的连接只是在这个命令的持续期间建立。
参数connname
要使用的连接名；忽略这个参数将使用未命名连接。
connstr
如之前为dblink_connect所描述的连接信息字符串。
sql
你希望在远程数据库中执行的 SQL 命令，例如insert into foo values(0, 'a', '{"a0","b0","c0"}')。
fail_on_error
如果为真（忽略时的默认值），那么在连接的远端抛出的一个错误也会导致本地抛出一个错误。如果为假，远程错误只在本地被报告为一个 NOTICE，并且该函数的返回值被设置为ERROR。
返回值
返回状态，可能是命令的状态字符串或ERROR。
示例
SELECT dblink_connect('dbname=dblink_test_standby');
dblink_connect
----------------
OK
(1 row)
SELECT dblink_exec('insert into foo values(21, ''z'', ''{"a0","b0","c0"}'');');
dblink_exec
-----------------
INSERT 943366 1
(1 row)
SELECT dblink_connect('myconn', 'dbname=regression');
dblink_connect
----------------
OK
(1 row)
SELECT dblink_exec('myconn', 'insert into foo values(21, ''z'', ''{"a0","b0","c0"}'');');
dblink_exec
------------------
INSERT 6432584 1
(1 row)
SELECT dblink_exec('myconn', 'insert into pg_class values (''foo'')',false);
NOTICE:  sql error
DETAIL:  ERROR:  null value in column "relnamespace" violates not-null constraint
dblink_exec
-------------
ERROR
(1 row)
上一页 上一级 下一页dblink 起始页 dblink_open
