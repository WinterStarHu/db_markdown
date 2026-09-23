# 9.26. 集合返回函数

9.26. 集合返回函数
版本：
纠错本页面
搜索
目录导航
❮
❯
9.26. 集合返回函数 #
本节描述那些可能返回多于一行的函数。目前这个类中被使用最广泛的是级数生成函数，如表 9.69和表 9.70所述。其他更特殊的集合返回函数在本手册的其他地方描述。
组合多个集合返回函数的方法可见第 7.2.1.4 节。
表 9.69. 系列生成函数
函数
描述
generate_series ( start integer, stop integer [, step integer ] )
→ setof integer
generate_series ( start bigint, stop bigint [, step bigint ] )
→ setof bigint
generate_series ( start numeric, stop numeric [, step numeric ] )
→ setof numeric
从 start 到 stop 生成一系列的值，步长为 step。 step 默认为 1。
generate_series ( start timestamp, stop timestamp, step interval )
→ setof timestamp
generate_series ( start timestamp with time zone, stop timestamp with time zone, step interval [, timezone text ] )
→ setof timestamp with time zone
生成从 start 到 stop 的一系列值，步长为 step。在支持时区的形式中，白天时间和夏令时调整是根据 timezone 参数指定的时区计算的，如果省略该参数，则使用当前的 TimeZone 设置。
当 step 为正时，如果 start 大于 stop，则返回零行。相反，当 step 为负时，如果 start 小于 stop，则返回零行。如果任何输入为 NULL，也会返回零行。若 step 为零，则会报错。以下是一些示例：
SELECT * FROM generate_series(2,4);
generate_series
-----------------
2
3
4
(3 rows)
SELECT * FROM generate_series(5,1,-2);
generate_series
-----------------
5
3
1
(3 rows)
SELECT * FROM generate_series(4,3);
generate_series
-----------------
(0 rows)
SELECT generate_series(1.1, 4, 1.3);
generate_series
-----------------
1.1
2.4
3.7
(3 rows)
-- 此示例依赖于日期加整数运算符：
SELECT current_date + s.a AS dates FROM generate_series(0,14,7) AS s(a);
dates
------------
2004-02-05
2004-02-12
2004-02-19
(3 rows)
SELECT * FROM generate_series('2008-03-01 00:00'::timestamp,
'2008-03-04 12:00', '10 hours');
generate_series
---------------------
2008-03-01 00:00:00
2008-03-01 10:00:00
2008-03-01 20:00:00
2008-03-02 06:00:00
2008-03-02 16:00:00
2008-03-03 02:00:00
2008-03-03 12:00:00
2008-03-03 22:00:00
2008-03-04 08:00:00
(9 rows)
-- 此示例假设时区设置为UTC；注意夏令时的转换：
SELECT * FROM generate_series('2001-10-22 00:00 -04:00'::timestamptz,
'2001-11-01 00:00 -05:00'::timestamptz,
'1 day'::interval, 'America/New_York');
generate_series
------------------------
2001-10-22 04:00:00+00
2001-10-23 04:00:00+00
2001-10-24 04:00:00+00
2001-10-25 04:00:00+00
2001-10-26 04:00:00+00
2001-10-27 04:00:00+00
2001-10-28 04:00:00+00
2001-10-29 05:00:00+00
2001-10-30 05:00:00+00
2001-10-31 05:00:00+00
2001-11-01 05:00:00+00
(11 rows)
表 9.70. 下标生成函数
函数
描述
generate_subscripts ( array anyarray, dim integer )
→ setof integer
生成一个包含给定数组第 dim 维度的有效下标的序列。
generate_subscripts ( array anyarray, dim integer,  reverse boolean )
→ setof integer
生成一个包含给定数组第 dim 维度的有效下标的序列。当 reverse 为真时，以相反的顺序返回序列。
generate_subscripts 是一个快捷函数，它为给定数组的指定维度生成一组合法的下标。对于不具有请求维度的数组返回零行，对于任何输入为 NULL 的数组也返回零行。下面是一些例子：
-- basic usage:
SELECT generate_subscripts('{NULL,1,NULL,2}'::int[], 1) AS s;
s
---
1
2
3
4
(4 rows)
-- presenting an array, the subscript and the subscripted
-- value requires a subquery:
SELECT * FROM arrays;
a
--------------------
{-1,-2}
{100,200,300}
(2 rows)
SELECT a AS array, s AS subscript, a[s] AS value
FROM (SELECT generate_subscripts(a, 1) AS s, a FROM arrays) foo;
array     | subscript | value
---------------+-----------+-------
{-1,-2}       |         1 |    -1
{-1,-2}       |         2 |    -2
{100,200,300} |         1 |   100
{100,200,300} |         2 |   200
{100,200,300} |         3 |   300
(5 rows)
-- unnest a 2D array:
CREATE OR REPLACE FUNCTION unnest2(anyarray)
RETURNS SETOF anyelement AS $$
select $1[i][j]
from generate_subscripts($1,1) g1(i),
generate_subscripts($1,2) g2(j);
$$ LANGUAGE sql IMMUTABLE;
CREATE FUNCTION
SELECT * FROM unnest2(ARRAY[[1,2],[3,4]]);
unnest2
---------
1
2
3
4
(4 rows)
当FROM子句中的函数以WITH ORDINALITY作为后缀时，将在函数的输出列上附加一个bigint列，该列从1开始，函数输出的每一行加1。
这在 unnest()等集合返回函数的情况下最有用。
-- set returning function WITH ORDINALITY:
SELECT * FROM pg_ls_dir('.') WITH ORDINALITY AS t(ls,n);
ls        | n
-----------------+----
pg_serial       |  1
pg_twophase     |  2
postmaster.opts |  3
pg_notify       |  4
postgresql.conf |  5
pg_tblspc       |  6
logfile         |  7
base            |  8
postmaster.pid  |  9
pg_ident.conf   | 10
global          | 11
pg_xact         | 12
pg_snapshots    | 13
pg_multixact    | 14
PG_VERSION      | 15
pg_wal          | 16
pg_hba.conf     | 17
pg_stat_tmp     | 18
pg_subtrans     | 19
(19 rows)
上一页 上一级 下一页9.25. 行和数组比较 起始页 9.27. 系统信息函数和运算符
