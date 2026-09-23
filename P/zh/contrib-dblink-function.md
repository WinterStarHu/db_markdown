# dblink

dblink
版本：
纠错本页面
搜索
目录导航
❮
❯
dblinkdblink — 在远程数据库中执行查询大纲
dblink(text connname, text sql [, bool fail_on_error]) returns setof record
dblink(text connstr, text sql [, bool fail_on_error]) returns setof record
dblink(text sql [, bool fail_on_error]) returns setof record
描述
dblink在一个远程数据库中执行一个查询（通常是一个SELECT，但是也可以是任意返回行的 SQL 语句）。
当给定两个text参数时，第一个被首先作为一个持久连接的名称进行查找；如果找到，该命令会在该连接上被执行。如果没有找到，第一个参数被视作一个用于dblink_connect的连接信息字符串，并且所指的连接只是在这个命令的持续期间被建立。
参数connname
要使用的连接名；忽略这个参数将使用未命名连接。
connstr
如之前为dblink_connect所描述的连接信息字符串。
sql
你希望在远程数据库中执行的 SQL 查询，例如select * from foo。
fail_on_error
如果为真（忽略时的默认值），那么在连接的远端抛出的一个错误也会导致本地抛出一个错误。如果为假，远程错误只在本地被报告为一个 NOTICE，并且该函数不返回行。
返回值
该函数返回查询产生的行。因为dblink能与任何查询一起使用，它被声明为返回record，而不是指定任何特定的列集合。这意味着你必须指定在调用的查询中所期待的列集合 — 否则PostgreSQL将不知道会得到什么。这里是一个例子：
SELECT *
FROM dblink('dbname=mydb options=-csearch_path=',
'select proname, prosrc from pg_proc')
AS t1(proname name, prosrc text)
WHERE proname LIKE 'bytea%';
FROM子句的“alias”部分必须指定函数将返回的列名及类型（在一个别名中指定列名实际上是标准 SQL 语法，但是指定列类型是一种PostgreSQL扩展）。这允许系统在尝试执行该函数之前就理解*将展开成什么，以及WHERE子句中的proname指的是什么。在运行时，如果来自远程数据库的实际查询结果和FROM子句中显示的列数不同，将会抛出一个错误。不过，列名不需要匹配，并且dblink并不坚持精确地匹配类型。只要被返回的数据字符串是FROM子句中声明的列类型的合法输入，它就将会成功。
注释
一种将预定义查询用于dblink的方便方法是创建一个视图。这允许列类型信息被埋藏在该视图中，而不是在每一个查询中都拼写出来。例如：
CREATE VIEW myremote_pg_proc AS
SELECT *
FROM dblink('dbname=postgres options=-csearch_path=',
'select proname, prosrc from pg_proc')
AS t1(proname name, prosrc text);
SELECT * FROM myremote_pg_proc WHERE proname LIKE 'bytea%';
示例
SELECT * FROM dblink('dbname=postgres options=-csearch_path=',
'select proname, prosrc from pg_proc')
AS t1(proname name, prosrc text) WHERE proname LIKE 'bytea%';
proname   |   prosrc
------------+------------
byteacat   | byteacat
byteaeq    | byteaeq
bytealt    | bytealt
byteale    | byteale
byteagt    | byteagt
byteage    | byteage
byteane    | byteane
byteacmp   | byteacmp
bytealike  | bytealike
byteanlike | byteanlike
byteain    | byteain
byteaout   | byteaout
(12 rows)
SELECT dblink_connect('dbname=postgres options=-csearch_path=');
dblink_connect
----------------
OK
(1 row)
SELECT * FROM dblink('select proname, prosrc from pg_proc')
AS t1(proname name, prosrc text) WHERE proname LIKE 'bytea%';
proname   |   prosrc
------------+------------
byteacat   | byteacat
byteaeq    | byteaeq
bytealt    | bytealt
byteale    | byteale
byteagt    | byteagt
byteage    | byteage
byteane    | byteane
byteacmp   | byteacmp
bytealike  | bytealike
byteanlike | byteanlike
byteain    | byteain
byteaout   | byteaout
(12 rows)
SELECT dblink_connect('myconn', 'dbname=regression options=-csearch_path=');
dblink_connect
----------------
OK
(1 row)
SELECT * FROM dblink('myconn', 'select proname, prosrc from pg_proc')
AS t1(proname name, prosrc text) WHERE proname LIKE 'bytea%';
proname   |   prosrc
------------+------------
bytearecv  | bytearecv
byteasend  | byteasend
byteale    | byteale
byteagt    | byteagt
byteage    | byteage
byteane    | byteane
byteacmp   | byteacmp
bytealike  | bytealike
byteanlike | byteanlike
byteacat   | byteacat
byteaeq    | byteaeq
bytealt    | bytealt
byteain    | byteain
byteaout   | byteaout
(14 rows)
上一页 上一级 下一页dblink_disconnect 起始页 dblink_exec
