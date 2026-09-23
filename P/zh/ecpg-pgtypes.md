# 34.6. pgtypes 库

34.6. pgtypes 库
版本：
纠错本页面
搜索
目录导航
❮
❯
34.6. pgtypes 库 #34.6.1. 字符串34.6.2. numeric 类型34.6.3. 日期类型34.6.4. 时间戳类型34.6.5. 区间类型34.6.6. 十进制类型34.6.7. pgtypeslib 的 errno 值34.6.8. pgtypeslib 的特殊常量
pgtypes 库将PostgreSQL数据库类型映射到 C 中等价的类型以便在 C 程序中使用。它还提供在 C 中对这些类型进行基本计算的函数，即不依赖PostgreSQL服务器进行计算。请看下面的例子：
EXEC SQL BEGIN DECLARE SECTION;
date date1;
timestamp ts1, tsout;
interval iv1;
char *out;
EXEC SQL END DECLARE SECTION;
PGTYPESdate_today(&date1);
EXEC SQL SELECT started, duration INTO :ts1, :iv1 FROM datetbl WHERE d=:date1;
PGTYPEStimestamp_add_interval(&ts1, &iv1, &tsout);
out = PGTYPEStimestamp_to_asc(&tsout);
printf("Started + duration: %s\n", out);
PGTYPESchar_free(out);
34.6.1. 字符串 #
PGTYPESnumeric_to_asc之类的一些函数返回一个新分配的字符串的指针。这些结果应该用PGTYPESchar_free而不是free释放（这只在Windows上很重要，因为Windows上的内存分配和释放有时候需要由同一个库完成）。
34.6.2. numeric 类型 #
numeric 类型用来完成对任意精度的计算。PostgreSQL服务器中等效的类型请见第 8.1 节。因为要用于任意精度，这种变量需要能够动态地扩展和收缩。这也是为什么你只能用PGTYPESnumeric_new和PGTYPESnumeric_free函数在堆上创建 numeric 变量。decimal 类型与 numeric 类型相似但是在精度上有限制，decimal 类型可以在堆上创建也可以在栈上创建。
以下函数可用于处理数值类型：
PGTYPESnumeric_new #
请求一个指向新分配的数值变量的指针。
numeric *PGTYPESnumeric_new(void);
PGTYPESnumeric_free #
释放一个数值类型，释放其所有内存。
void PGTYPESnumeric_free(numeric *var);
PGTYPESnumeric_from_asc #
从字符串表示中解析一个数值类型。
numeric *PGTYPESnumeric_from_asc(char *str, char **endptr);
有效的格式例如：
-2、
.794、
+3.44、
592.49E07 或
-32.84e-4。
如果值能够成功解析，将返回一个有效的指针，
否则返回NULL指针。目前，ECPG总是解析完整的字符串，
因此它目前不支持将第一个无效字符的地址存储在
*endptr中。您可以安全地将
endptr设置为NULL。
PGTYPESnumeric_to_asc #
返回一个由malloc分配的字符串指针，该字符串包含数值类型
num的字符串表示形式。
char *PGTYPESnumeric_to_asc(numeric *num, int dscale);
数值将以dscale个小数位打印，如果需要，将应用四舍五入。
结果必须使用PGTYPESchar_free()释放。
PGTYPESnumeric_add #
将两个数值变量相加并存储到第三个变量中。
int PGTYPESnumeric_add(numeric *var1, numeric *var2, numeric *result);
该函数将变量var1和var2相加，
并存储到结果变量result中。
如果成功，函数返回0；如果出错，返回-1。
PGTYPESnumeric_sub #
减去两个数值变量，并将结果返回到第三个变量中。
int PGTYPESnumeric_sub(numeric *var1, numeric *var2, numeric *result);
该函数将变量var2从变量var1中减去。
操作的结果存储在变量result中。
函数成功时返回0，出错时返回-1。
PGTYPESnumeric_mul #
将两个数值变量相乘，并将结果返回到第三个变量中。
int PGTYPESnumeric_mul(numeric *var1, numeric *var2, numeric *result);
该函数将变量var1和var2相乘。
操作的结果存储在变量result中。
函数成功时返回0，出错时返回-1。
PGTYPESnumeric_div #
将两个数值变量相除，并将结果存储在第三个变量中。
int PGTYPESnumeric_div(numeric *var1, numeric *var2, numeric *result);
该函数将变量var1除以var2。
操作的结果存储在变量result中。
函数成功时返回0，出错时返回-1。
PGTYPESnumeric_cmp #
比较两个数值变量。
int PGTYPESnumeric_cmp(numeric *var1, numeric *var2)
此函数用于比较两个数值变量。如果发生错误，
INT_MAX将被返回。成功时，函数返回以下三种可能结果之一：
1，如果var1大于var2
-1，如果var1小于var2
0，如果var1和var2相等
PGTYPESnumeric_from_int #
将一个int变量转换为一个numeric变量。
int PGTYPESnumeric_from_int(signed int int_val, numeric *var);
此函数接受一个类型为signed int的变量，并将其存储在numeric变量
var中。成功时返回0，失败时返回-1。
PGTYPESnumeric_from_long #
将一个长整型变量转换为一个数值变量。
int PGTYPESnumeric_from_long(signed long int long_val, numeric *var);
此函数接受一个类型为signed long int的变量，并将其存储在数值变量
var中。成功时返回0，失败时返回-1。
PGTYPESnumeric_copy #
将一个数值变量复制到另一个变量中。
int PGTYPESnumeric_copy(numeric *src, numeric *dst);
此函数将src指向的变量的值复制到dst
指向的变量中。如果成功返回0，如果发生错误则返回-1。
PGTYPESnumeric_from_double #
将一个double类型的变量转换为一个数值。
int  PGTYPESnumeric_from_double(double d, numeric *dst);
此函数接受一个double类型的变量，并将结果存储在
dst指向的变量中。成功时返回0，发生错误时返回-1。
PGTYPESnumeric_to_double #
将一个数值类型的变量转换为双精度类型。
int PGTYPESnumeric_to_double(numeric *nv, double *dp)
该函数将nv指向的变量中的数值转换为dp指向的双精度变量。
如果成功，返回0；如果发生错误（包括溢出），返回-1。在溢出情况下，全局变量
errno还会被设置为PGTYPES_NUM_OVERFLOW。
PGTYPESnumeric_to_int #
将一个数值类型的变量转换为整数。
int PGTYPESnumeric_to_int(numeric *nv, int *ip);
该函数将nv指向的变量中的数值转换为ip
指向的整数变量。如果成功，返回0；如果发生错误（包括溢出），返回-1。
在溢出情况下，全局变量errno还会被设置为
PGTYPES_NUM_OVERFLOW。
PGTYPESnumeric_to_long #
将类型为 numeric 的变量转换为 long。
int PGTYPESnumeric_to_long(numeric *nv, long *lp);
该函数将 nv 指向的变量中的 numeric 值转换为
lp 指向的 long 整数变量。成功时返回 0，发生错误时
返回 -1，包括溢出和下溢。溢出时，全局变量 errno 会被
设置为 PGTYPES_NUM_OVERFLOW，下溢时 errno
会被设置为 PGTYPES_NUM_UNDERFLOW。
PGTYPESnumeric_to_decimal #
将一个数值类型的变量转换为十进制。
int PGTYPESnumeric_to_decimal(numeric *src, decimal *dst);
该函数将 src 指向的变量中的数值转换为
dst 指向的十进制变量。如果成功返回 0，如果发生错误（包括溢出）
则返回 -1。在溢出情况下，全局变量 errno 将被设置为
PGTYPES_NUM_OVERFLOW。
PGTYPESnumeric_from_decimal #
将一种 decimal 类型的变量转换为 numeric 类型。
int PGTYPESnumeric_from_decimal(decimal *src, numeric *dst);
该函数将 src 指向的变量中的 decimal 值转换为
dst 指向的 numeric 变量。如果成功，返回 0；如果发生错误，
返回 -1。由于 decimal 类型是 numeric 类型的有限版本实现，因此在此转换中
不会发生溢出。
34.6.3. 日期类型 #
C 中的日期类型允许你的程序处理 SQL 日期类型的数据。PostgreSQL服务器的等效类型可见 第 8.5 节。
下列函数可以被用于日期类型：
PGTYPESdate_from_timestamp #
从一个时间戳中抽取日期部分。
date PGTYPESdate_from_timestamp(timestamp dt);
该函数接收一个时间戳作为它的唯一参数并且从这个时间戳返回抽取的日期部分。
PGTYPESdate_from_asc #
从日期的文本表达解析一个日期。
date PGTYPESdate_from_asc(char *str, char **endptr);
该函数接收一个 C 的字符串 str 以及一个指向 C 字符串的指针 endptr。当前 ECPG 总是解析完整的字符串并且因此当前不支持将第一个非法字符的地址存储在 *endptr 中。你可以安全地把 endptr 设置为 NULL。
注意该函数总是假定格式按照 MDY 格式化并且当前在 ECPG 中没有变体可以改变这种格式。
表 34.2 展示了所有允许的输入格式。
表 34.2. PGTYPESdate_from_asc 的合法输入格式输入结果January 8, 1999January 8, 19991999-01-08January 8, 19991/8/1999January 8, 19991/18/1999January 18, 199901/02/03February 1, 20031999-Jan-08January 8, 1999Jan-08-1999January 8, 199908-Jan-1999January 8, 199999-Jan-08January 8, 199908-Jan-99January 8, 199908-Jan-06January 8, 2006Jan-08-99January 8, 199919990108ISO 8601; January 8, 1999990108ISO 8601; January 8, 19991999.008年以及积日J2451187儒略日January 8, 99 BC公元前 99 年PGTYPESdate_to_asc #
返回一个日期变量的文本表达。
char *PGTYPESdate_to_asc(date dDate);
该函数接收日期 dDate 作为它的唯一参数。它将以形式 1999-01-18 输出该日期，即以 YYYY-MM-DD 格式输出。结果必须用 PGTYPESchar_free() 释放。
PGTYPESdate_julmdy #
从一个日期类型变量中抽取日、月和年的值。
void PGTYPESdate_julmdy(date d, int *mdy);
该函数接收日期 d 以及一个指向有 3 个整数值的数组 mdy 的指针。变量名就表明了顺序：mdy[0] 将被设置为包含月份，mdy[1] 将被设置为日的值，而 mdy[2] 将包含年。
PGTYPESdate_mdyjul #
从一个由 3 个整数构成的数组创建一个日期值，3 个整数分别指定日、月和年。
void PGTYPESdate_mdyjul(int *mdy, date *jdate);
这个函数接收 3 个整数（mdy）组成的数组作为其第一个参数，其第二个参数是一个指向日期类型变量的指针，它被用来保存操作的结果。
PGTYPESdate_dayofweek #
为一个日期值返回表示它是星期几的数字。
int PGTYPESdate_dayofweek(date d);
这个函数接收日期变量 d 作为它唯一的参数并且返回一个整数说明这个日期是星期几。
0 - 星期日
1 - 星期一
2 - 星期二
3 - 星期三
4 - 星期四
5 - 星期五
6 - 星期六
PGTYPESdate_today #
得到当前日期。
void PGTYPESdate_today(date *d);
该函数接收一个指向一个日期变量（d）的指针并且把该参数设置为当前日期。
PGTYPESdate_fmt_asc #
使用一个格式掩码将一个日期类型的变量转换成它的文本表达。
int PGTYPESdate_fmt_asc(date dDate, char *fmtstring, char *outbuf);
该函数接收要转换的日期（dDate）、格式掩码（fmtstring）以及将要保存日期的文本表达的字符串（outbuf）。
成功时，返回 0；如果发生错误，则返回一个负值。
下面是你可以使用的域指示符：
dd - 一个月中的第几天。
mm - 一年中的第几个月。
yy - 两位数的年份。
yyyy - 四位数的年份。
ddd - 星期几的名称（简写）。
mmm - 月份的名称（简写）。
所有其他字符会被原封不动地复制到输出字符串中。
表 34.3 指出了一些可能的格式。这将给你一些线索如何使用这个函数。所有输出都是基于同一个日期：1959 年 11 月 23 日。
表 34.3. PGTYPESdate_fmt_asc 的合法输入格式格式结果mmddyy112359ddmmyy231159yymmdd591123yy/mm/dd59/11/23yy mm dd59 11 23yy.mm.dd59.11.23.mm.yyyy.dd..11.1959.23.mmm. dd, yyyyNov. 23, 1959mmm dd yyyyNov 23 1959yyyy dd mm1959 23 11ddd, mmm. dd, yyyyMon, Nov. 23, 1959(ddd) mmm. dd, yyyy(Mon) Nov. 23, 1959PGTYPESdate_defmt_asc #
使用一个格式掩码把一个 C 的 char* 字符串转换成一个日期类型的值。
int PGTYPESdate_defmt_asc(date *d, char *fmt, char *str);
该函数接收一个用来保存操作结果的指向日期值的指针（d）、用于解析日期的格式掩码（fmt）以及包含日期文本表达的 C char* 字符串（str）。该函数期望文本表达匹配格式掩码。不过你不需要字符串和格式掩码的一一映射。该函数只分析相继顺序并且查找表示年份位置的文字 yy 或者 yyyy、表示月份位置的 mm 以及表示日位置的 dd。
表 34.4 给出了一些可能的格式。这将给你一些线索如何使用这个函数。
表 34.4. rdefmtdate 的合法输入格式格式字符串结果ddmmyy21-2-541954-02-21ddmmyy2-12-541954-12-02ddmmyy201119541954-11-20ddmmyy1304641964-04-13mmm.dd.yyyyMAR-12-19671967-03-12yy/mm/dd1954, February 3rd1954-02-03mmm.dd.yyyy0412691969-04-12yy/mm/dd在 2525 年的七月二十八日，人类还将存在2525-07-28dd-mm-yy也是 2525 年七月的二十八日2525-07-28mmm.dd.yyyy9/14/581958-09-14yy/mm/dd47/03/291947-03-29mmm.dd.yyyyoct 28 19751975-10-28mmddyyNov 14th, 19851985-11-14
34.6.4. 时间戳类型 #
C 中的时间戳类型允许你的程序处理 SQL 时间戳类型的数据。PostgreSQL服务器的等效类型可见 第 8.5 节。
下列函数可用于处理时间戳类型：
PGTYPEStimestamp_from_asc #
从其文本表示中解析时间戳为时间戳变量。
timestamp PGTYPEStimestamp_from_asc(char *str, char **endptr);
该函数接收要解析的字符串（str）和一个指向C char*的指针（endptr）。
目前，ECPG总是解析完整的字符串，因此目前不支持存储第一个无效字符的地址在*endptr中。
您可以安全地将endptr设置为NULL。
该函数在成功时返回解析后的时间戳。发生错误时，返回PGTYPESInvalidTimestamp，
并将errno设置为PGTYPES_TS_BAD_TIMESTAMP。
有关此值的重要说明，请参见PGTYPESInvalidTimestamp。
通常，输入字符串可以包含允许的日期规范、空白字符和允许的时间规范的任意组合。请注意，ECPG不支持时区。它可以解析时区，但不像PostgreSQL服务器那样应用任何计算。时区标识符会被静默丢弃。
表 34.5包含了一些输入字符串的示例。
表 34.5. PGTYPEStimestamp_from_asc的有效输入格式输入结果1999-01-08 04:05:061999-01-08 04:05:06January 8 04:05:06 1999 PST1999-01-08 04:05:061999-Jan-08 04:05:06.789-81999-01-08 04:05:06.789 (time zone specifier ignored)J2451187 04:05-08:001999-01-08 04:05:00 (time zone specifier ignored)PGTYPEStimestamp_to_asc #
将日期转换为C char*字符串。
char *PGTYPEStimestamp_to_asc(timestamp tstamp);
该函数接收时间戳tstamp作为其唯一参数，并返回一个包含时间戳文本表示的已分配字符串。
结果必须使用PGTYPESchar_free()释放。
PGTYPEStimestamp_current #
检索当前时间戳。
void PGTYPEStimestamp_current(timestamp *ts);
该函数检索当前时间戳，并将其保存到ts指向的时间戳变量中。
PGTYPEStimestamp_fmt_asc #
将时间戳变量转换为C char*，使用格式掩码。
int PGTYPEStimestamp_fmt_asc(timestamp *ts, char *output, int str_len, char *fmtstr);
该函数接收一个指向要转换的时间戳的指针作为第一个参数（ts），
一个指向输出缓冲区的指针（output），已为输出缓冲区分配的最大长度
（str_len），以及用于转换的格式掩码（fmtstr）。
当成功时，该函数返回0，如果发生错误则返回负值。
您可以使用以下格式说明符来格式化掩码。格式说明符与libc中的strftime函数中使用的相同。任何非格式说明符都将被复制到输出缓冲区中。
%A - 被替换为完整星期几的国家表示形式。
%a - 被替换为缩写的星期几名称的国家表示形式。
%B - 被替换为完整月份名称的国家表示形式。
%b - 被替换为缩写月份的国家表示形式。
%C - 被(year / 100)替换为十进制数；单个数字前面加零。
%c - 被时间和日期的国家表示形式替换。
%D - 等同于
%m/%d/%y。
%d - 被月份的日期替换为十进制数字（01–31）。
%E* %O* -  POSIX 本地化扩展。序列
%Ec
%EC
%Ex
%EX
%Ey
%EY
%Od
%Oe
%OH
%OI
%Om
%OM
%OS
%Ou
%OU
%OV
%Ow
%OW
%Oy
应该提供替代表示。
另外%OB用于表示替代的月份名称（单独使用，不包括日期）。
%e - 被一个十进制数字（1–31）替换；单个数字前面有一个空格。
%F - 等同于%Y-%m-%d。
%G - 被一个包含世纪的十进制数字年份替换。这个年份是包含大部分周的那一年（以周一作为一周的第一天）。
%g - 被替换为与%G相同的年份，但作为一个没有世纪的十进制数
(00–99)。
%H - 被小时（24小时制）替换为十进制数（00–23）。
%h - 与%b相同。
%I - 被小时（12小时制）替换为十进制数（01–12）。
%j - 被一年中的日期替换为十进制数（001–366）。
%k - 被小时（24小时制）表示为十进制数（0–23）；单个数字前面有一个空格。
%l - 被小时（12小时制）替换为十进制数（1–12）；单个数字前面有一个空格。
%M - 被分钟替换为十进制数（00–59）。
%m - 被替换为月份的十进制数（01–12）。
%n - 被换行符替换。
%O* - 与%E*相同。
%p - 被适当地替换为“ante meridiem”或“post meridiem”的国家表示形式。
%R - 等同于%H:%M。
%r - 等同于%I:%M:%S %p。
%S - 被替换为第二个作为十进制数（00–60）。
%s - 被替换为自纪元时以来的秒数，UTC。
%T - 等同于 %H:%M:%S
%t - 被替换为一个制表符。
%U - 被一年中的周数替换（以周日作为一周的第一天），表示为十进制数（00–53）。
%u - 被星期几（以星期一作为一周的第一天）替换为十进制数（1–7）。
%V - 被一年中的周数替换（以星期一作为一周的第一天），
表示为十进制数（01–53）。如果包含1月1日的那一周在新年有四天或更多天，
那么它是第1周；否则它是上一年的最后一周，下一周是第1周。
%v - 等同于
%e-%b-%Y。
%W - 被一年中的周数替换（以星期一作为一周的第一天），表示为十进制数（00–53）。
%w - 被星期几替换（星期日作为一周的第一天）作为十进制数（0–6）。
%X - 被时间的国家表示替换。
%x - 被日期的国家表示替换。
%Y - 被年份替换，包括世纪，以十进制数表示。
%y - 被年份替换，不包括世纪，以十进制数表示（00–99）。
%Z - 被时区名称替换。
%z - 被UTC时间偏移替换；前导加号表示UTC东部，减号表示UTC西部，后跟两位数字的小时和分钟，它们之间没有分隔符（RFC 822日期头的常见形式）。
%+ - 被日期和时间的国家表示替换。
%-* - GNU libc扩展。在执行数字输出时不进行任何填充。
$_* - GNU libc扩展。明确指定填充空间。
%0* - GNU libc扩展。显式指定零进行填充。
%% - 被%替换。
PGTYPEStimestamp_sub #
从一个时间戳减去另一个时间戳，并将结果保存在一个间隔类型的变量中。
int PGTYPEStimestamp_sub(timestamp *ts1, timestamp *ts2, interval *iv);
该函数将从时间戳变量ts1指向的时间戳变量中减去时间戳变量ts2指向的时间戳变量，并将结果存储在间隔变量iv指向的变量中。
当成功时，该函数返回0，如果发生错误则返回负值。
PGTYPEStimestamp_defmt_asc #
通过使用格式掩码从其文本表示中解析时间戳值。
int PGTYPEStimestamp_defmt_asc(char *str, char *fmt, timestamp *d);
该函数接收时间戳的文本表示，存储在变量str中，以及要在变量fmt中使用的格式掩码。结果将存储在d指向的变量中。
如果格式掩码fmt为NULL，则函数将回退到默认的格式掩码，即%Y-%m-%d %H:%M:%S。
这是与PGTYPEStimestamp_fmt_asc相反的函数。请参阅那里的文档，以了解可能的格式掩码条目。
PGTYPEStimestamp_add_interval #
向时间戳变量添加一个间隔变量。
int PGTYPEStimestamp_add_interval(timestamp *tin, interval *span, timestamp *tout);
该函数接收一个指向时间戳变量tin的指针和一个指向间隔变量span的指针。
它将间隔添加到时间戳中，并将结果时间戳保存在tout指向的变量中。
成功时，该函数返回0，如果发生错误则返回负值。
PGTYPEStimestamp_sub_interval #
从时间戳变量中减去一个间隔变量。
int PGTYPEStimestamp_sub_interval(timestamp *tin, interval *span, timestamp *tout);
该函数从span指向的间隔变量中减去tin指向的时间戳变量，并将结果保存到tout指向的变量中。
成功时，该函数返回0，如果发生错误则返回负值。
34.6.5. 区间类型 #
C中的区间类型允许你的程序处理SQL区间类型的数据。PostgreSQL服务器的等效类型可见第 8.5 节。
下列函数可以用于区间类型：
PGTYPESinterval_new #
返回一个指向新分配的区间变量的指针。
interval *PGTYPESinterval_new(void);
PGTYPESinterval_free #
释放先前分配的区间变量的内存。
void PGTYPESinterval_free(interval *intvl);
PGTYPESinterval_from_asc #
从文本表达解析一个区间。
interval *PGTYPESinterval_from_asc(char *str, char **endptr);
该函数解析输入字符串str并返回一个已分配的区间变量的指针。目前ECPG总是解析整个字符串，因此当前不支持将第一个非法字符的地址存储在*endptr中。你可以安全地将endptr设置为NULL。
PGTYPESinterval_to_asc #
将一个区间类型的变量转换成它的文本表达。
char *PGTYPESinterval_to_asc(interval *span);
该函数将span指向的区间变量转换成一个C char*。输出看起来像这个例子：
@ 1 day 12 hours 59 mins 10 secs。结果必须用PGTYPESchar_free()释放。
PGTYPESinterval_copy #
复制一个区间类型的变量。
int PGTYPESinterval_copy(interval *intvlsrc, interval *intvldest);
该函数将intvlsrc指向的区间变量复制到intvldest指向的区间变量。注意你需要先为目标变量分配好内存。
34.6.6. 十进制类型 #
十进制类型和数值类型相似。不过，它被限制为最大精度是 30 个有效位。与数值类型只能在堆上创建相反，十进制类型既可以在栈上也可以在堆上创建（使用函数PGTYPESdecimal_new 和PGTYPESdecimal_free）。在第 34.15 节中描述的Informix兼容模式中有很多其他函数可以处理十进制类型。
以下函数可用于处理十进制类型，并且不仅包含在
libcompat库中。
PGTYPESdecimal_new #
请求一个指向新分配的十进制变量的指针。
decimal *PGTYPESdecimal_new(void);
PGTYPESdecimal_free #
释放一个十进制类型，释放其所有内存。
void PGTYPESdecimal_free(decimal *var);
34.6.7. pgtypeslib 的 errno 值 #
PGTYPES_NUM_BAD_NUMERIC #
一个参数应该包含一个数值变量（或指向一个数值变量），但实际上它的内存表示是无效的。
PGTYPES_NUM_OVERFLOW #
发生了溢出。由于数值类型可以处理几乎任意的精度，将数值变量转换为其他
类型可能会导致溢出。
PGTYPES_NUM_UNDERFLOW #
发生了下溢。由于数值类型可以处理几乎任意的精度，将数值变量转换为其他
类型可能会导致下溢。
PGTYPES_NUM_DIVIDE_ZERO #
已尝试进行除以零的操作。
PGTYPES_DATE_BAD_DATE #
一个无效的日期字符串被传递给
PGTYPESdate_from_asc 函数。
PGTYPES_DATE_ERR_EARGS #
向PGTYPESdate_defmt_asc函数传递了无效的参数。
PGTYPES_DATE_ERR_ENOSHORTDATE #
在输入字符串中发现了一个无效的标记，
由PGTYPESdate_defmt_asc函数检测到。
PGTYPES_INTVL_BAD_INTERVAL #
一个无效的时间间隔字符串被传递给
PGTYPESinterval_from_asc 函数，或者一个
无效的时间间隔值被传递给
PGTYPESinterval_to_asc 函数。
PGTYPES_DATE_ERR_ENOTDMY #
在PGTYPESdate_defmt_asc函数中，日/月/年的分配存在不匹配。
PGTYPES_DATE_BAD_DAY #
在PGTYPESdate_defmt_asc函数中发现了一个无效的日期值。
PGTYPES_DATE_BAD_MONTH #
在PGTYPESdate_defmt_asc函数中发现了一个无效的月份值。
PGTYPES_TS_BAD_TIMESTAMP #
一个无效的时间戳字符串被传递给
PGTYPEStimestamp_from_asc函数，
或者一个无效的时间戳值被传递给
PGTYPEStimestamp_to_asc函数。
PGTYPES_TS_ERR_EINFTIME #
在无法处理的上下文中遇到了一个无限的时间戳值。
34.6.8. pgtypeslib 的特殊常量 #
PGTYPESInvalidTimestamp #
表示一个非法时间戳的时间戳类型值。在解析错误时，函数PGTYPEStimestamp_from_asc会返回这个值。注意由于timestamp数据类型的内部表示，PGTYPESInvalidTimestamp同时也是一个有效的时间戳。它被设置为1899-12-31 23:59:59。为了检测到错误，确认你的应用在每次调用PGTYPEStimestamp_from_asc后不仅仅测试PGTYPESInvalidTimestamp，还应该测试errno != 0。
上一页 上一级 下一页34.5. 动态 SQL 起始页 34.7. 使用描述符区域
