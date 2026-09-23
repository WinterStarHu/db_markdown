# 9.9. 日期/时间函数和操作符

9.9. 日期/时间函数和操作符
版本：
纠错本页面
搜索
目录导航
❮
❯
9.9. 日期/时间函数和操作符 #9.9.1. EXTRACT, date_part9.9.2. date_trunc9.9.3. date_bin9.9.4. AT TIME ZONE 和 AT LOCAL9.9.5. 当前日期/时间9.9.6. 延迟执行
表 9.33展示了可用于处理日期/时间值的函数，其细节在随后的小节中描述。表 9.32演示了基本算术操作符（+、*等）的行为。与格式化相关的函数，可以参考第 9.8 节。你应该很熟悉第 8.5 节中的日期/时间数据类型的背景知识。
此外，表 9.1中显示的常用比较操作符也适用于日期/时间类型。日期和时间戳（带或不带时区）都是可比较的，而时间（带或不带时区）和间隔只能与相同数据类型的其他值进行比较。当将不带时区的时间戳与带时区的时间戳进行比较时，前者的值假定是在TimeZone配置参数指定的时区中给出的，并被转换到UTC，以便与后者的值进行比较（其已经在内部用UTC）。类似地，日期值会被假定表示TimeZone区域中的午夜，当它与时间戳进行比较时。
所有下文描述的接受time或timestamp输入的函数和操作符实际上都有两种变体：一种接收time with time zone或timestamp with time zone，另外一种接受time without time zone或者timestamp without time zone。为了简化，这些变种没有被独立地展示。此外，+和*操作符都是可交换的操作符对（例如，date + integer和integer + date）；我们只显示每一对中的一个。
表 9.32. 日期/时间运算符
运算符
描述
示例
date + integer
→ date
给日期加上天数
date '2001-09-28' + 7
→ 2001-10-05
date + interval
→ timestamp
为日期添加时间间隔
date '2001-09-28' + interval '1 hour'
→ 2001-09-28 01:00:00
date + time
→ timestamp
在日期中添加一天中的时间
date '2001-09-28' + time '03:00'
→ 2001-09-28 03:00:00
interval + interval
→ interval
添加时间间隔
interval '1 day' + interval '1 hour'
→ 1 day 01:00:00
timestamp + interval
→ timestamp
在时间戳中添加一个时间间隔
timestamp '2001-09-28 01:00' + interval '23 hours'
→ 2001-09-29 00:00:00
time + interval
→ time
为时间添加时间间隔
time '01:00' + interval '3 hours'
→ 04:00:00
- interval
→ interval
取否一个时间间隔
- interval '23 hours'
→ -23:00:00
date - date
→ integer
减去日期，生成经过的天数
date '2001-10-01' - date '2001-09-28'
→ 3
date - integer
→ date
从日期中减去天数
date '2001-10-01' - 7
→ 2001-09-24
date - interval
→ timestamp
从日期中减去时间间隔
date '2001-09-28' - interval '1 hour'
→ 2001-09-27 23:00:00
time - time
→ interval
减去时间
time '05:00' - time '03:00'
→ 02:00:00
time - interval
→ time
从时间中减去时间间隔
time '05:00' - interval '2 hours'
→ 03:00:00
timestamp - interval
→ timestamp
从时间戳中减去时间间隔
timestamp '2001-09-28 23:00' - interval '23 hours'
→ 2001-09-28 00:00:00
interval - interval
→ interval
减去时间间隔
interval '1 day' - interval '1 hour'
→ 1 day -01:00:00
timestamp - timestamp
→ interval
减去时间戳（将24小时间隔转换为天数，类似于justify_hours()）
timestamp '2001-09-29 03:00' - timestamp '2001-07-27 12:00'
→ 63 days 15:00:00
interval * double precision
→ interval
将时间间隔乘以标量
interval '1 second' * 900
→ 00:15:00
interval '1 day' * 21
→ 21 days
interval '1 hour' * 3.5
→ 03:30:00
interval / double precision
→ interval
用时间间隔除以标量
interval '1 hour' / 1.5
→ 00:40:00
表 9.33. 日期/时间函数
函数
描述
示例
age ( timestamp, timestamp )
→ interval
减去参数，生成一个使用年和月，而不是只用天的“符号化”结果
age(timestamp '2001-04-10', timestamp '1957-06-13')
→ 43 years 9 mons 27 days
age ( timestamp )
→ interval
从 current_date 减去参数（在午夜）
age(timestamp '1957-06-13')
→ 62 years 6 mons 10 days
clock_timestamp ( )
→ timestamp with time zone
当前日期和时间（在语句执行期间变化）；参见第 9.9.5 节
clock_timestamp()
→ 2019-12-23 14:39:53.662522-05
current_date
→ date
当前日期；参见 第 9.9.5 节
current_date
→ 2019-12-23
current_time
→ time with time zone
一天中的当前时间；参见 第 9.9.5 节
current_time
→ 14:39:53.662522-05
current_time ( integer )
→ time with time zone
一天中的当前时间；有限精度；参见 第 9.9.5 节
current_time(2)
→ 14:39:53.66-05
current_timestamp
→ timestamp with time zone
当前日期和时间 (当前事务的开始)；参见 第 9.9.5 节
current_timestamp
→ 2019-12-23 14:39:53.662522-05
current_timestamp ( integer )
→ timestamp with time zone
当前日期和时间 (当前事务的开始)；有限精度；参见 第 9.9.5 节
current_timestamp(0)
→ 2019-12-23 14:39:53-05
date_add ( timestamp with time zone, interval [, text ] )
→ timestamp with time zone
添加一个 interval 到一个 timestamp with time
zone，根据第三个参数指定的时区名称，或者如果省略则根据当前
TimeZone 设置，计算一天中的时间和夏令时调整。
带有两个参数的形式等价于 timestamp with time zone
+ interval 运算符。
date_add('2021-10-31 00:00:00+02'::timestamptz, '1 day'::interval, 'Europe/Warsaw')
→ 2021-10-31 23:00:00+00
date_bin ( interval, timestamp, timestamp )
→ timestamp
将输入按指定间隔进行分箱，与指定原点对齐；参见 第 9.9.3 节
date_bin('15 minutes', timestamp '2001-02-16 20:38:40', timestamp '2001-02-16 20:05:00')
→ 2001-02-16 20:35:00
date_part ( text, timestamp )
→ double precision
获取时间戳字段（等同于 extract）；参见 第 9.9.1 节
date_part('hour', timestamp '2001-02-16 20:38:40')
→ 20
date_part ( text, interval )
→ double precision
获取时间间隔子字段（等同于 extract）；参见 第 9.9.1 节
date_part('month', interval '2 years 3 months')
→ 3
date_subtract ( timestamp with time zone, interval [, text ] )
→ timestamp with time zone
从一个timestamp with time zone中减去一个interval，根据第三个参数
指定的时区名称，或者如果省略则根据当前的TimeZone设置，计算
一天中的时间和夏令时调整。带有两个参数的形式等价于timestamp with time zone
-interval运算符。
date_subtract('2021-11-01 00:00:00+01'::timestamptz, '1 day'::interval, 'Europe/Warsaw')
→ 2021-10-30 22:00:00+00
date_trunc ( text, timestamp )
→ timestamp
截断到指定的精度；参见 第 9.9.2 节
date_trunc('hour', timestamp '2001-02-16 20:38:40')
→ 2001-02-16 20:00:00
date_trunc ( text, timestamp with time zone, text )
→ timestamp with time zone
在规定的时区中截断到指定的精度；参见 第 9.9.2 节
date_trunc('day', timestamptz '2001-02-16 20:38:40+00', 'Australia/Sydney')
→ 2001-02-16 13:00:00+00
date_trunc ( text, interval )
→ interval
截断到指定的精度；参见 第 9.9.2 节
date_trunc('hour', interval '2 days 3 hours 40 minutes')
→ 2 days 03:00:00
extract ( field from timestamp )
→ numeric
获取时间戳子字段；参见 第 9.9.1 节
extract(hour from timestamp '2001-02-16 20:38:40')
→ 20
extract ( field from interval )
→ numeric
获取时间间隔子字段；参见 第 9.9.1 节
extract(month from interval '2 years 3 months')
→ 3
isfinite ( date )
→ boolean
测试有限日期（不是+/-无限）
isfinite(date '2001-02-16')
→ true
isfinite ( timestamp )
→ boolean
测试有限时间戳（不是 +/- 无穷大）
isfinite(timestamp 'infinity')
→ false
isfinite ( interval )
→ boolean
测试有限区间（不是 +/- 无穷大）
isfinite(interval '4 hours')
→ true
justify_days ( interval )
→ interval
调整间隔，将 30 天的时间段转换为月份
justify_days(interval '1 year 65 days')
→ 1 year 2 mons 5 days
justify_hours ( interval )
→ interval
调整间隔，将 24 小时时间段转换为天数
justify_hours(interval '50 hours 10 minutes')
→ 2 days 02:10:00
justify_interval ( interval )
→ interval
使用 justify_days 和 justify_hours 调整时间间隔，并进行额外的符号调整
justify_interval(interval '1 mon -1 hour')
→ 29 days 23:00:00
localtime
→ time
一天中当前时间；参见 第 9.9.5 节
localtime
→ 14:39:53.662522
localtime ( integer )
→ time
一天中的当前时间，有限精度；参见 第 9.9.5 节
localtime(0)
→ 14:39:53
localtimestamp
→ timestamp
当前日期和时间（当前事务的开始）；参见 第 9.9.5 节
localtimestamp
→ 2019-12-23 14:39:53.662522
localtimestamp ( integer )
→ timestamp
当前日期和时间（当前事务的开始），具有有限精度；
参见 第 9.9.5 节
localtimestamp(2)
→ 2019-12-23 14:39:53.66
make_date ( year int,
month int,
day int )
→ date
从年、月和日字段创建日期（负数年份表示公元前）
make_date(2013, 7, 15)
→ 2013-07-15
make_interval ( [ years int
[, months int
[, weeks int
[, days int
[, hours int
[, mins int
[, secs double precision
]]]]]]] )
→ interval
从年、月、周、日、小时、分钟和秒字段创建时间间隔，每个字段默认为0
make_interval(days => 10)
→ 10 days
make_time ( hour int,
min int,
sec double precision )
→ time
从小时、分钟和秒字段创建时间
make_time(8, 15, 23.5)
→ 08:15:23.5
make_timestamp ( year int,
month int,
day int,
hour int,
min int,
sec double precision )
→ timestamp
从年、月、日、小时、分钟和秒字段创建时间戳（负数年份表示公元前）
make_timestamp(2013, 7, 15, 8, 15, 23.5)
→ 2013-07-15 08:15:23.5
make_timestamptz ( year int,
month int,
day int,
hour int,
min int,
sec double precision
[, timezone text ] )
→ timestamp with time zone
从年、月、日、小时、分钟和秒字段结合时区创建时间戳（负数年份表示公元前）。
如果没有指定timezone，则使用当前时区；示例假设会话时区为Europe/London
make_timestamptz(2013, 7, 15, 8, 15, 23.5)
→ 2013-07-15 08:15:23.5+01
make_timestamptz(2013, 7, 15, 8, 15, 23.5, 'America/New_York')
→ 2013-07-15 13:15:23.5+01
now ( )
→ timestamp with time zone
当前日期和时间（当前事务的开始）；
参见 第 9.9.5 节
now()
→ 2019-12-23 14:39:53.662522-05
statement_timestamp ( )
→ timestamp with time zone
当前日期和时间（当前语句的开始）；
参见 第 9.9.5 节
statement_timestamp()
→ 2019-12-23 14:39:53.662522-05
timeofday ( )
→ text
当前的日期和时间
（类似 clock_timestamp, 但是作为 text 字符串）；参见 第 9.9.5 节
timeofday()
→ Mon Dec 23 14:39:53.662522 2019 EST
transaction_timestamp ( )
→ timestamp with time zone
当前日期和时间（当前事务的开始）；参见 第 9.9.5 节
transaction_timestamp()
→ 2019-12-23 14:39:53.662522-05
to_timestamp ( double precision )
→ timestamp with time zone
将Unix纪元（自1970-01-01 00:00:00+00以来的秒数）转换为
带时区的时间戳
to_timestamp(1284352323)
→ 2010-09-13 04:32:03+00
除了这些函数以外，还支持 SQL 操作符OVERLAPS：
(start1, end1) OVERLAPS (start2, end2)
(start1, length1) OVERLAPS (start2, length2)
这个表达式在两个时间段（用它们的端点定义）重叠时返回真，不重叠时返回假。端点
可以用一对日期、时间或时间戳来指定；或者用一个日期、时间或时间戳后面跟一个间隔来指定。
当提供一对值时，起点或终点都可以写在前面；OVERLAPS会自动将较早的值作为起点。
每个时间段被认为表示半开区间start <=
time < end，除非
start和end相等，这种情况下它
表示那个单一的时间点。这意味着例如两个只有一个端点相同的时间段不重叠。
SELECT (DATE '2001-02-16', DATE '2001-12-21') OVERLAPS
(DATE '2001-10-30', DATE '2002-10-30');
Result: true
SELECT (DATE '2001-02-16', INTERVAL '100 days') OVERLAPS
(DATE '2001-10-30', DATE '2002-10-30');
Result: false
SELECT (DATE '2001-10-29', DATE '2001-10-30') OVERLAPS
(DATE '2001-10-30', DATE '2001-10-31');
Result: false
SELECT (DATE '2001-10-30', DATE '2001-10-30') OVERLAPS
(DATE '2001-10-30', DATE '2001-10-31');
Result: true
当将一个interval值添加到（或从中减去一个interval值）一个
timestamp或timestamp with time zone值时，会依次处理
interval值的月份、天数和微秒字段。首先，非零的月份字段会将时间戳的
日期前进或减少指定的月份数，保持月份中的日期不变，除非它超出了新月份的
末尾，在这种情况下会使用该月份的最后一天。（例如，3月31日加1个月变成
4月30日，但3月31日加2个月变成5月31日。）然后，天数字段会将时间戳的日期
前进或减少指定的天数。在这两个步骤中，本地的时间保持不变。最后，如果
微秒字段非零，则会直接加上或减去。
在对timestamp with time zone值进行算术运算时，如果所在的时区识别
夏令时，这意味着添加或减去（例如）interval '1 day'的结果
不一定与添加或减去interval '24 hours'的结果相同。
例如，当会话时区设置为America/Denver时：
SELECT timestamp with time zone '2005-04-02 12:00:00-07' + interval '1 day';
结果: 2005-04-03 12:00:00-06
SELECT timestamp with time zone '2005-04-02 12:00:00-07' + interval '24 hours';
结果: 2005-04-03 13:00:00-06
这是因为在2005-04-03 02:00:00时，由于时区
America/Denver的夏令时变化，跳过了一个小时。
注意months字段返回的age可能存在歧义，因为不同的月份有不同的天数。 PostgreSQL的方法是当计算部分月数时，采用两个日期中较早的月份。例如：age('2004-06-01', '2004-04-30')使用4月份得到1 mon 1 day，而用5月份时会得到1 mon 2 days，因为5月有31天，而4月只有30天。
日期和时间戳的减法也可能会很复杂。执行减法的一种概念上很简单的方法是，使用
EXTRACT(EPOCH FROM ...)把每个值都转换成秒数，然后执行减法，
这样会得到两个值之间的秒数。这种方法将会适应每个月中天数、
时区改变和夏令时调整。使用“-”操作符的日期或时间
戳减法会返回值之间的天数（24小时）以及时/分/秒，也会做同样的调整。
age函数会返回年、月、日以及时/分/秒，执行按域的减法，然后对
负值域进行调整。下面的查询展示了这些方法的不同。例子中的结果由
timezone = 'US/Eastern'产生，这使得两个使用的日期之间存在着夏令
时的变化：
SELECT EXTRACT(EPOCH FROM timestamptz '2013-07-01 12:00:00') -
EXTRACT(EPOCH FROM timestamptz '2013-03-01 12:00:00');
Result: 10537200.000000
SELECT (EXTRACT(EPOCH FROM timestamptz '2013-07-01 12:00:00') -
EXTRACT(EPOCH FROM timestamptz '2013-03-01 12:00:00'))
/ 60 / 60 / 24;
Result: 121.9583333333333333
SELECT timestamptz '2013-07-01 12:00:00' - timestamptz '2013-03-01 12:00:00';
Result: 121 days 23:00:00
SELECT age(timestamptz '2013-07-01 12:00:00', timestamptz '2013-03-01 12:00:00');
Result: 4 mons
9.9.1. EXTRACT, date_part #
EXTRACT(field FROM source)
extract函数从日期/时间值中检索子字段，例如年份或小时。
source必须是timestamp、date、time或interval类型的值表达式。
（时间戳和时间可以带有或不带有时区。）
field是一个标识符或字符串，用于选择从源值中提取哪个字段。
并非每种输入数据类型都适用于所有字段；例如，无法从date中提取小于一天的字段，而无法从time中提取一天或更长时间的字段。
extract函数返回numeric类型的值。
以下是有效的字段名称：
century
世纪；对于interval值，年份字段除以100
SELECT EXTRACT(CENTURY FROM TIMESTAMP '2000-12-16 12:21:13');
Result: 20
SELECT EXTRACT(CENTURY FROM TIMESTAMP '2001-02-16 20:38:40');
Result: 21
SELECT EXTRACT(CENTURY FROM DATE '0001-01-01 AD');
Result: 1
SELECT EXTRACT(CENTURY FROM DATE '0001-12-31 BC');
Result: -1
SELECT EXTRACT(CENTURY FROM INTERVAL '2001 years');
Result: 20
day
月份的日期（1–31）；对于interval值，表示天数
SELECT EXTRACT(DAY FROM TIMESTAMP '2001-02-16 20:38:40');
Result: 16
SELECT EXTRACT(DAY FROM INTERVAL '40 days 1 minute');
Result: 40
decade
年字段除以10
SELECT EXTRACT(DECADE FROM TIMESTAMP '2001-02-16 20:38:40');
Result: 200
dow
一周的日子从星期天（0）到星期六（6）
SELECT EXTRACT(DOW FROM TIMESTAMP '2001-02-16 20:38:40');
Result: 5
请注意extract函数的星期几编号与to_char(..., 'D')函数不同。
doy
一年中的日子（1–365/366）
SELECT EXTRACT(DOY FROM TIMESTAMP '2001-02-16 20:38:40');
Result: 47
epoch
对于timestamp with time zone值，自1970-01-01 00:00:00 UTC以来的秒数（负值表示该时间戳之前的时间）；
对于date和timestamp值，自1970-01-01 00:00:00以来的名义秒数，不考虑时区或夏令时规则；
对于interval值，间隔中的总秒数
SELECT EXTRACT(EPOCH FROM TIMESTAMP WITH TIME ZONE '2001-02-16 20:38:40.12-08');
Result: 982384720.120000
SELECT EXTRACT(EPOCH FROM TIMESTAMP '2001-02-16 20:38:40.12');
Result: 982355920.120000
SELECT EXTRACT(EPOCH FROM INTERVAL '5 days 3 hours');
Result: 442800.000000
您可以使用to_timestamp将一个epoch值转换回timestamp with time zone：
SELECT to_timestamp(982384720.12);
Result: 2001-02-17 04:38:40.12+00
注意，将to_timestamp应用于从date或timestamp值中提取的epoch可能会产生误导性的结果：
结果将有效地假定原始值是以UTC时间给出的，这可能并非事实。
hour
小时字段（时间戳中为0–23，在间隔中不受限制）
SELECT EXTRACT(HOUR FROM TIMESTAMP '2001-02-16 20:38:40');
Result: 20
isodow
一周的日子从星期一（1）到星期日（7）
SELECT EXTRACT(ISODOW FROM TIMESTAMP '2001-02-18 20:38:40');
Result: 7
这与dow相同，除了星期日。这匹配ISO 8601的星期几编号。
isoyear
日期所在的ISO 8601周编号年份
SELECT EXTRACT(ISOYEAR FROM DATE '2006-01-01');
Result: 2005
SELECT EXTRACT(ISOYEAR FROM DATE '2006-01-02');
Result: 2006
每个ISO 8601周编号年从包含1月4日的星期一开始，因此在一月初或十二月底，ISO年可能与格里高利年不同。
有关更多信息，请参见week字段。
julian
与日期或时间戳对应的儒略日。非当地午夜的时间戳会导致小数值。
更多信息请参见第 B.7 节。
SELECT EXTRACT(JULIAN FROM DATE '2006-01-01');
Result: 2453737
SELECT EXTRACT(JULIAN FROM TIMESTAMP '2006-01-01 12:00');
Result: 2453737.50000000000000000000
microseconds
秒字段，包括小数部分，乘以1 000 000；注意这包括完整的秒数
SELECT EXTRACT(MICROSECONDS FROM TIME '17:12:28.5');
Result: 28500000
millennium
千年；对于interval值，年份字段除以1000
SELECT EXTRACT(MILLENNIUM FROM TIMESTAMP '2001-02-16 20:38:40');
Result: 3
SELECT EXTRACT(MILLENNIUM FROM INTERVAL '2001 years');
Result: 2
20世纪的年份在第二个千年。第三个千年从2001年1月1日开始。
milliseconds
秒字段，包括小数部分，乘以1000。请注意，这包括完整的秒数。
SELECT EXTRACT(MILLISECONDS FROM TIME '17:12:28.5');
Result: 28500.000
minute
分钟字段（0–59）
SELECT EXTRACT(MINUTE FROM TIMESTAMP '2001-02-16 20:38:40');
Result: 38
month
月份在一年中的编号（1–12）；对于interval值，月份模12的余数（0–11）
SELECT EXTRACT(MONTH FROM TIMESTAMP '2001-02-16 20:38:40');
Result: 2
SELECT EXTRACT(MONTH FROM INTERVAL '2 years 3 months');
Result: 3
SELECT EXTRACT(MONTH FROM INTERVAL '2 years 13 months');
Result: 1
quarter
年的季度（1–4）；对于 interval 值，月份字段除以 3
加 1
SELECT EXTRACT(QUARTER FROM TIMESTAMP '2001-02-16 20:38:40');
Result: 1
SELECT EXTRACT(QUARTER FROM INTERVAL '1 year 6 months');
Result: 3
second
秒字段，包括任何分数秒
SELECT EXTRACT(SECOND FROM TIMESTAMP '2001-02-16 20:38:40');
Result: 40.000000
SELECT EXTRACT(SECOND FROM TIME '17:12:28.5');
Result: 28.500000
timezone
与UTC的时区偏移量，以秒为单位。正值对应于UTC东部的时区，负值对应于UTC西部的时区。
（从技术上讲，PostgreSQL不使用UTC，因为不处理闰秒。）
timezone_hour
时区偏移的小时组件
timezone_minute
时区偏移的分钟组件
week
一年中ISO 8601周编号的周数。根据定义，ISO周从周一开始，
一年的第一周包含该年的1月4日。换句话说，一年的第一个星期四在该年的第1周。
在ISO周编号系统中，早年1月的日期可能属于前一年的第52周或第53周，而
晚年12月的日期可能属于下一年的第一周。例如，2005-01-01
属于2004年的第53周，2006-01-01 属于2005年的第52周，
而2012-12-31 属于2013年的第一周。建议同时使用
isoyear 字段和week以获得一致的结果。
对于 interval 值，周字段仅仅是
整数天数除以7的结果。
SELECT EXTRACT(WEEK FROM TIMESTAMP '2001-02-16 20:38:40');
Result: 7
SELECT EXTRACT(WEEK FROM INTERVAL '13 days 24 hours');
Result: 1
year
年份字段。请记住，没有0 AD，所以要小心地从AD年中减去BC年。
SELECT EXTRACT(YEAR FROM TIMESTAMP '2001-02-16 20:38:40');
Result: 2001
当处理interval值时，extract函数会生成与间隔输出函数使用的解释相匹配的字段值。
如果从非规范化的间隔表示开始，可能会产生令人惊讶的结果，例如：
SELECT INTERVAL '80 minutes';
结果: 01:20:00
SELECT EXTRACT(MINUTES FROM INTERVAL '80 minutes');
结果: 20
注意
当输入值为+/-Infinity时，extract对于单调递增字段返回
+/-Infinity（epoch、julian、year、isoyear、
decade、century和millennium，
针对timestamp输入；epoch、hour、
day、year、decade、
century和millennium，针对interval输入）。
对于其他字段，返回NULL。PostgreSQL 9.6之前的版本
对所有无限输入情况均返回零。
extract函数主要的用途是做计算性处理。对于用于显示的日期/时间值格式化，参阅第 9.8 节。
在传统的Ingres上建模的date_part函数等价于SQL标准函数extract：
date_part('field', source)
请注意这里的field参数必须是一个字符串值，而不是一个名字。
有效的date_part字段名和extract相同。
由于历史原因，date_part函数返回double precision类型的值。
这可能导致在某些使用中损失精度。
建议使用extract替代。
SELECT date_part('day', TIMESTAMP '2001-02-16 20:38:40');
Result: 16
SELECT date_part('hour', INTERVAL '4 hours 3 minutes');
Result: 4
9.9.2. date_trunc #
date_trunc函数在概念上和用于数字的trunc函数类似。
date_trunc(field, source [, time_zone ])
source 是类型为
timestamp、timestamp with time zone 或
interval 的值表达式。
（类型为 date 和
time 的值会自动转换为 timestamp 或
interval，分别。）
field 选择要截断输入值的精度。
返回值同样是类型为 timestamp、timestamp with time zone 或
interval，并且所有比所选字段重要性低的字段都被设置为零（或对于天和月设置为一）。
field的有效值是：
microsecondsmillisecondssecondminutehourdayweekmonthquarteryeardecadecenturymillennium
当输入值的类型为timestamp with time zone时，截断是针对特定时区进行的；例如，截断为day，产生的值是该时区的午夜。默认情况下，截断是根据当前的TimeZone设置进行的，但可以提供可选的time_zone参数以指定不同的时区。时区名称可以以第 8.5.3 节中描述的任何方式指定。
当处理timestamp without time zone或interval输入时，不能指定时区。这些总是按表面值来处理。
例子（假设本地时区是America/New_York）：
SELECT date_trunc('hour', TIMESTAMP '2001-02-16 20:38:40');
结果：2001-02-16 20:00:00
SELECT date_trunc('year', TIMESTAMP '2001-02-16 20:38:40');
结果：2001-01-01 00:00:00
SELECT date_trunc('day', TIMESTAMP WITH TIME ZONE '2001-02-16 20:38:40+00');
结果：2001-02-16 00:00:00-05
SELECT date_trunc('day', TIMESTAMP WITH TIME ZONE '2001-02-16 20:38:40+00', 'Australia/Sydney');
结果：2001-02-16 08:00:00-05
SELECT date_trunc('hour', INTERVAL '3 days 02:47:33');
结果：3 days 02:00:00
9.9.3. date_bin #
函数date_bin “bins”输入时间戳到指定的间隔(stride)与指定的原点对齐。
date_bin(stride, source, origin)
source是timestamp或timestamp with time zone类型的值表达式。（类型date的值会自动转换为timestamp。）stride是interval类型的值表达式。返回值同样是timestamp或timestamp with time zone类型，并且它标记着放置source的bin的开始。
例子:
SELECT date_bin('15 minutes', TIMESTAMP '2020-02-11 15:44:17', TIMESTAMP '2001-01-01');
结果: 2020-02-11 15:30:00
SELECT date_bin('15 minutes', TIMESTAMP '2020-02-11 15:44:17', TIMESTAMP '2001-01-01 00:02:30');
结果: 2020-02-11 15:32:30
在完整单位（1分钟，1小时，等等）的情况下，它给出与类似 date_trunc 调用相同的结果，但不同的地方是 date_bin 可以截断到任意间隔。
stride 时间间隔必须大于零，并且不能包含月或更大的单位。
9.9.4. AT TIME ZONE 和 AT LOCAL #
AT TIME ZONE 操作符将时间戳 without 时区转换为时间戳 with 时区，或者反之，并将 time with time zone 值转换为不同的时区。表 9.34 展示了它的变体。
表 9.34. AT TIME ZONE 和 AT LOCAL 变体
操作符
描述
示例
timestamp without time zone AT TIME ZONE zone
→ timestamp with time zone
将给定的时间戳without时区转换为时间戳with时区，假设给定的值在指定的时区内。
timestamp '2001-02-16 20:38:40' at time zone 'America/Denver'
→ 2001-02-17 03:38:40+00
timestamp without time zone AT LOCAL
→ timestamp with time zone
将给定的时间戳without时区转换为时间戳with会话的TimeZone值作为时区。
timestamp '2001-02-16 20:38:40' at local
→ 2001-02-17 03:38:40+00
timestamp with time zone AT TIME ZONE zone
→ timestamp without time zone
将给定的时间戳with时区转换为时间戳without时区，因为时间将出现在该时区中。
timestamp with time zone '2001-02-16 20:38:40-05' at time zone 'America/Denver'
→ 2001-02-16 18:38:40
timestamp with time zone AT LOCAL
→ timestamp without time zone
将给定的时间戳with时区转换为时间戳without时区，时间表现为会话的TimeZone值作为时区的时间。
timestamp with time zone '2001-02-16 20:38:40-05' at local
→ 2001-02-16 18:38:40
time with time zone AT TIME ZONE zone
→ time with time zone
将给定的时间with时区转换为新的时区。由于没有提供日期，这将使用指定目的区域的当前活动UTC偏移量。
time with time zone '05:34:17-05' at time zone 'UTC'
→ 10:34:17+00
time with time zone AT LOCAL
→ time with time zone
将给定的时间with时区转换为新的时区。由于未提供日期，因此使用会话的TimeZone值当前活动的UTC偏移量。
假设会话的TimeZone设置为UTC：
time with time zone '05:34:17-05' at local
→ 10:34:17+00
在这些表达式里，所需的时区zone可以指定为文本值（例如，'America/Los_Angeles'）或者一个间隔（例如，INTERVAL '-08:00'）。
在文本情况下，可用的时区名称可以用第 8.5.3 节中描述的任何方式指定。
时间区间只适用于与UTC有固定偏移量的区域，因此在实践中并不常见。
语法 AT LOCAL 可用作 AT TIME ZONE local 的简写，
其中 local 是会话的 TimeZone 值。
示例（假设当前 TimeZone 设置为
America/Los_Angeles）：
SELECT TIMESTAMP '2001-02-16 20:38:40' AT TIME ZONE 'America/Denver';
结果: 2001-02-16 19:38:40-08
SELECT TIMESTAMP WITH TIME ZONE '2001-02-16 20:38:40-05' AT TIME ZONE 'America/Denver';
结果: 2001-02-16 18:38:40
SELECT TIMESTAMP '2001-02-16 20:38:40' AT TIME ZONE 'Asia/Tokyo' AT TIME ZONE 'America/Chicago';
结果: 2001-02-16 05:38:40
SELECT TIMESTAMP WITH TIME ZONE '2001-02-16 20:38:40-05' AT LOCAL;
结果: 2001-02-16 17:38:40
SELECT TIMESTAMP WITH TIME ZONE '2001-02-16 20:38:40-05' AT TIME ZONE '+05';
结果: 2001-02-16 20:38:40
SELECT TIME WITH TIME ZONE '20:38:40-05' AT LOCAL;
结果: 17:38:40
第一个示例为缺少时区的值添加了时区，并
使用当前 TimeZone 设置显示该值。第二个示例将
带时区的时间戳值转换为指定的时区，并返回不带时区的值。
这允许存储和显示与当前 TimeZone 设置不同的值。
第三个示例将东京时间转换为芝加哥时间。第四个示例将带时区的时间戳值
转换为当前由 TimeZone 设置指定的时区，并返回不带时区的值。
第五个示例演示了 POSIX 风格的时区规范中的符号与
ISO-8601 日期时间文字中的符号具有相反的含义，如在
第 8.5.3 节 和 附录 B 中所述。
第六个示例是一个警示故事。由于输入值没有
关联的日期，因此转换是使用会话的当前日期进行的。
因此，这个静态示例可能会根据查看的时间显示错误的结果，
因为 'America/Los_Angeles' 观察夏令时。
函数timezone(zone, timestamp)等效于 SQL 兼容的结构timestamp AT TIME ZONE zone。
该函数 timezone(zone,
time) 等同于符合 SQL 标准的构造
time AT TIME ZONE
zone。
该函数 timezone(timestamp)
等同于符合 SQL 标准的结构 timestamp
AT LOCAL。
该函数 timezone(time)
等同于符合 SQL 标准的结构 time
AT LOCAL。
9.9.5. 当前日期/时间 #
PostgreSQL提供了许多返回当前日期和时间的函数。这些 SQL 标准的函数全部都按照当前事务的开始时刻返回值：
CURRENT_DATE
CURRENT_TIME
CURRENT_TIMESTAMP
CURRENT_TIME(precision)
CURRENT_TIMESTAMP(precision)
LOCALTIME
LOCALTIMESTAMP
LOCALTIME(precision)
LOCALTIMESTAMP(precision)
CURRENT_TIME和CURRENT_TIMESTAMP传递带有时区的值；LOCALTIME和LOCALTIMESTAMP传递的值不带时区。
CURRENT_TIME、CURRENT_TIMESTAMP、LOCALTIME和LOCALTIMESTAMP可以有选择地接受一个精度参数，该精度导致结果的秒域被四舍五入为指定小数位。如果没有精度参数，结果将被给予所能得到的全部精度。
一些示例:
SELECT CURRENT_TIME;
结果: 14:39:53.662522-05
SELECT CURRENT_DATE;
结果: 2019-12-23
SELECT CURRENT_TIMESTAMP;
结果: 2019-12-23 14:39:53.662522-05
SELECT CURRENT_TIMESTAMP(2);
结果: 2019-12-23 14:39:53.66-05
SELECT LOCALTIMESTAMP;
结果: 2019-12-23 14:39:53.662522
因为这些函数返回当前事务的开始时刻，所以它们的值在事务运行的整个期间内都不改变。我们认为这是一个特性：目的是为了允许一个事务在“当前”时间上有一致的概念，这样在同一个事务里的多个修改可以保持同样的时间戳。
注意
许多其他数据库系统可能会更频繁地推进这些值。
PostgreSQL还提供了返回当前语句的开始时间以及
调用该函数时的实际当前时间的函数。这些非 SQL 标准的函数列表如下：
transaction_timestamp()
statement_timestamp()
clock_timestamp()
timeofday()
now()
transaction_timestamp() 等同于
CURRENT_TIMESTAMP，但命名上更清晰地反映
它返回的内容。
statement_timestamp() 返回当前
语句的开始时间（更具体地说，是从客户端接收最新命令
消息的时间）。
statement_timestamp() 和 transaction_timestamp()
在事务的第一个语句期间返回相同的值，但在后续语句期间可能
会有所不同。
clock_timestamp() 返回实际的当前时间，
因此其值甚至在单个 SQL 语句内也会发生变化。
timeofday() 是一个历史性的
PostgreSQL 函数。像
clock_timestamp() 一样，它返回实际的当前时间，
但以格式化的 text 字符串而不是 timestamp
with time zone 值的形式返回。
now() 是传统的 PostgreSQL
等同于 transaction_timestamp()。
所有日期/时间类型还接受特殊的文字值now，用于指定当前的日期和时间（重申，被解释为当前事务的开始时刻）。 因此，下面三个都返回相同的结果：
SELECT CURRENT_TIMESTAMP;
SELECT now();
SELECT TIMESTAMP 'now';  -- 但请参阅下面的提示
提示
当指定以后要计算的值时，不要使用第三种形式，例如在表列的DEFAULT子句中。
系统将在分析这个常量的时候把now转换为一个timestamp， 这样需要默认值时就会得到创建表的时间！而前两种形式要到实际使用默认值的时候才被计算， 因为它们是函数调用。因此它们可以给出每次插入行的时刻。
（参见 第 8.5.1.4 节。）
9.9.6. 延迟执行 #
下面的这些函数可以用于让服务器进程延时执行：
pg_sleep ( double precision )
pg_sleep_for ( interval )
pg_sleep_until ( timestamp with time zone )
pg_sleep使当前会话的进程休眠，直到过去给定的秒数。可以指定几分之一秒的延迟。
pg_sleep_for是一个方便的函数，允许将休眠时间指定为时间间隔。
pg_sleep_until是一个方便的函数，用于需要特定的唤醒时间。例如：
SELECT pg_sleep(1.5);
SELECT pg_sleep_for('5 minutes');
SELECT pg_sleep_until('tomorrow 03:00');
注意
有效的休眠时间间隔精度是平台相关的，通常 0.01 秒是通用值。休眠延迟将至少持续指
定的时长，也有可能由于服务器负荷而比指定的时间长。特别地，
pg_sleep_until并不保证能刚好在指定的时刻被唤醒，但它不会
在比指定时刻早的时候醒来。
警告
请确保在调用pg_sleep或者其变体时，你的会话没有持有不必要
的锁。否则其他会话可能必须等待你的休眠会话，因而减慢整个系统速度。
上一页 上一级 下一页9.8. 数据类型格式化函数 起始页 9.10. 枚举支持函数
