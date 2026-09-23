# DBMS_SCHEDULER

`DBMS_SCHEDULER` 包提供一组调度相关的函数与过程，可在任何 PL/SQL 程序中调用。

本章包含以下主题：
- 已弃用的子程序
- 安全模型
- 规则与限制
- 操作说明
- 数据结构
- DBMS_SCHEDULER 子程序汇总

参见：
《Oracle Database Administrator's Guide》中关于如何使用 `DBMS_SCHEDULER` 的更多信息。

### DBMS_SCHEDULER 已弃用的子程序

Oracle 建议在新应用中不要使用已弃用的子程序。对已弃用特性的支持仅为向后兼容。

以下子程序自 Oracle Database 12c Release 1（12.1）起已弃用：
- CREATE_JOB 类（CREATE_JOB_CLASS）相关（注：原文列为 CREATE_CREDENTIAL、DROP_CREDENTIAL，见下）
- CREATE_CREDENTIAL Procedure
- DROP_CREDENTIAL Procedure

### DBMS_SCHEDULER 安全模型

`DBMS_SCHEDULER` 包**忽略**通过角色授予的、对调度器对象（如作业、链）的权限。对象权限必须**直接**授予用户。

### DBMS_SCHEDULER 规则与限制

使用 `DBMS_SCHEDULER` 包时适用以下规则：

- 只有 SYS 能对 SYS schema 中的对象执行操作。

- 若干过程接受以逗号分隔的对象名列表。若提供一个名称列表，调度器会在第一个返回错误的对象处停止执行该列表，因此不会对列表中剩余对象执行任务。例如 `DBMS_SCHEDULER.STOP_JOB ('job1, job2, job3, sys.jobclass1, sys.jobclass2, sys.jobclass3')`；若 job3 无法停止，则其后的 jobclass1、jobclass2、jobclass3 也无法停止；job3 之前的 job1、job2 会被停止。
- 对不存在的对象执行操作会返回一个 PL/SQL 异常，说明对象不存在。

### DBMS_SCHEDULER 操作说明

调度器使用一套丰富的**日历语法（calendaring syntax）**，让你定义重复调度，例如"每周二和周五下午 4 点"或"每月第二个周三"。该日历语法用于多个包子程序的 `repeat_interval` 参数中的日历表达式。对一个日历表达式求值会得到一组离散时间戳。

日历语法示例参见《Oracle Database Administrator's Guide》。

#### 日历语法

本节先给出日历语法的定义，再描述语法的各部分。在日历语法中，`*` 表示 0 次或多次。

```
repeat_interval = regular_schedule | combined_schedule
regular_schedule = frequency_clause
[";" interval_clause] [";" bymonth_clause] [";" byweekno_clause]
[";" byyearday_clause] [";" bydate_clause] [";" bymonthday_clause]
[";" byday_clause] [";" byhour_clause] [";" byminute_clause]
[";" bysecond_clause] [";" bysetpos_clause] [";" include_clause]
[";" exclude_clause] [";" intersect_clause][";" periods_clause]
[";" byperiod_clause]

frequency_clause = "FREQ" "=" ( predefined_frequency | user_defined_frequency )
predefined_frequency = "YEARLY" | "MONTHLY" | "WEEKLY" | "DAILY" |
   "HOURLY" | "MINUTELY" | "SECONDLY"
user_defined_frequency = named_schedule
interval_clause = "INTERVAL" "=" intervalnum
   intervalnum = 1 到 99
bymonth_clause = "BYMONTH" "=" monthlist
   monthlist = month ( "," month)*
   month = numeric_month | char_month
   numeric_month = 1 | 2 | 3 ... 12
   char_month = "JAN" | "FEB" | "MAR" | "APR" | "MAY" | "JUN" |
   "JUL" | "AUG" | "SEP" | "OCT" | "NOV" | "DEC"
byweekno_clause = "BYWEEKNO" "=" weeknumber_list
   weeknumber_list = weeknumber ( "," weeknumber)*
   weeknumber = [minus] weekno
   weekno = 1 到 53
byyearday_clause = "BYYEARDAY" "=" yearday_list
   yearday_list = yearday ( "," yearday)*
   yearday = [minus] yeardaynum
   yeardaynum = 1 到 366
bydate_clause = "BYDATE" "=" date_list
   date_list = date ( "," date)*
   date = [YYYY]MMDD [ offset | span ]
bymonthday_clause = "BYMONTHDAY" "=" monthday_list
   monthday_list = monthday ( "," monthday)*
   monthday = [minus] monthdaynum
   monthdaynum = 1 到 31
byday_clause = "BYDAY" "=" byday_list
   byday_list = byday ( "," byday)*
   byday = [weekdaynum] day
   weekdaynum = [minus] daynum
   daynum = 1 到 53   /* 频率为 YEARLY 时 */
   daynum = 1 到 5    /* 频率为 MONTHLY 时 */
   day = "MON" | "TUE" | "WED" | "THU" | "FRI" | "SAT" | "SUN"
BYTIME clause:  BYTIME=[hour_minute_second_list|minute_second_list]
   hour_minute_second_list: hh24mmss, .., hh24mmss
   minute_second_list: mmss, .. mmss
byhour_clause = "BYHOUR" "=" hour_list
   hour_list = hour ( "," hour)*
   hour = 0 到 23
byminute_clause = "BYMINUTE" "=" minute_list
   minute_list = minute ( "," minute)*
   minute = 0 到 59
bysecond_clause = "BYSECOND" "=" second_list
   second_list = second ( "," second)*
   second = 0 到 59
bysetpos_clause = "BYSETPOS" "=" setpos_list
   setpos_list = setpos ("," setpos)*
   setpos = [minus] setpos_num
   setpos_num = 1 到 9999
include_clause = "INCLUDE" "=" schedule_list
exclude_clause = "EXCLUDE" "=" schedule_list
intersect_clause = "INTERSECT" "=" schedule_list
schedule_list = schedule_clause ("," schedule_clause)*
schedule_clause = named_schedule [ offset ]
named_schedule = [schema "."] schedule
periods_clause = "PERIODS" "=" periodnum
byperiod_clause = "BYPERIOD" "=" period_list
period_list = periodnum ("," periodnum)*
periodnum = 1 到 100
offset = ("+" | "-") ["OFFSET:"] duration_val
span = ("+" | "-" | "^") "SPAN:" duration_val
duration_val = dur_weeks | dur_days
dur_weeks = numofweeks "W"
dur_days = numofdays "D"
numofweeks = 1 到 53
numofdays = 1 到 376
minus = "-"
combined_schedule = schedule_list
```

表 159-1 `repeat_interval` 的取值

| 名称 | 说明 |
|---|---|
| FREQ | 指定重复类型，必须指定。预定义频率值为 YEARLY、MONTHLY、WEEKLY、DAILY、HOURLY、MINUTELY、SECONDLY；也可指定一个已存在的调度作为用户自定义频率。 |
| INTERVAL | 指定一个正整数，表示重复的间隔数。默认为 1（对 SECONDLY 即每秒、对 DAILY 即每天，以此类推）。最大值 99。 |
| BYMONTH | 指定作业在哪个月或哪几个月执行。可用数字（1=一月、3=三月）或三字母缩写（FEB=二月、JUL=七月）。 |
| BYWEEKNO | 以数字指定一年中的第几周。遵循 ISO-8601（周从周一到周日；一年的第一周是主要落在公历年内的那一周，等价于包含该年第一个周四的周、或包含 1 月 4 日的周）。ISO-8601 周号为 1 到 52 或 53；第 1 周的部分可能在上一个日历年、第 52 周的部分可能在下一个日历年；若某年有第 53 周，则其部分必在下一个日历年。例：1998 年的 ISO 第 1 周始于 1997-12-29 周一；最后一个 ISO 周（第 53 周）止于 1999-01-03 周日。BYWEEKNO 仅对 YEARLY 有效。无效示例：`FREQ=YEARLY; BYWEEKNO=1; BYMONTH=12` 与 `FREQ=YEARLY;BYWEEKNO=53;BYMONTH=1`。 |
| BYYEARDAY | 以数字指定一年中的第几天。有效值 1–366。如 69 表示 3 月 10 日（1 月 31 天 + 2 月 28 天 + 10 天）。69 在平年对应 3 月 10 日，闰年对应 3 月 9 日。-2 不论闰年与否都对应 12 月 30 日。 |
| BYDATE | 指定日期列表，每个日期形如 `[YYYY]MMDD`。可用 SPAN 修饰符生成连续日期，用 OFFSET 修饰符调整某日期。简单示例：`BYDATE=0115,0315,0615,0915,1215,20060115`。SPAN 示例等价于 `BYDATE=0110,0111,0112,0113,0114`（从 1/10 起共 5 天）：`BYDATE=0110+SPAN:5D`。SPAN 前"+"表示从给定日期起跨 N 天；"-"表示到给定日期止；"^"表示以给定日期为中心跨 N 天/周（N 为偶数时上调到下一个奇数）。OFFSET 通过加减 N 天/周调整给定日期。`BYDATE=0205-OFFSET:2W` 等价于 `BYDATE=0205-14D`（OFFSET: 关键字可选），也等价于 `BYDATE=0122`。 |
| BYMONTHDAY | 以数字指定一月中的第几天。有效值 1–31。如 10 表示当月第 10 天。可用"-"从月末倒数：`BYMONTHDAY=-1` 表示当月最后一天，`-2` 表示倒数第二天。 |
| BYDAY | 以 MON、TUE 等形式指定周几。带数字时，YEARLY 频率下可指定一年的第 26 个周五，MONTHLY 频率下可指定当月第 4 个周四。带"-"可表示倒数：如 `-1 FRI` 是当月最后一个周五。 |
| BYHOUR | 指定作业运行的时。有效值 0–23。如 10 表示上午 10 点。 |
| BYMINUTE | 指定作业运行的分。有效值 0–59。如 45 表示过 45 分。 |
| BYSECOND | 指定作业运行的秒。有效值 0–59。如 30 表示过 30 秒。 |
| BYSETPOS | 在整个日历表达式求值后得到的时间戳列表中，按位置选取一个或多个项。适用于"每月最后一个工作日"这类需求：与其用其它 BY 子句表达，不如让表达式求值得到当月每个工作日的列表，再用 BYSETPOS 选最后一项。假设工作日为周一至周五，语法为 `FREQ=MONTHLY; BYDAY=MON,TUE,WED,THU,FRI; BYSETPOS=-1`。有效值 1–9999。负数从列表末尾选（-1 为最后一项，-2 为倒数第二项），正数从开头选。BYSETPOS 总是最后求值，仅支持 MONTHLY 与 YEARLY 频率，且每个频率周期对时间戳列表应用一次。如频率为 MONTHLY 时，调度器先确定当月所有有效时间戳、排序、再应用 BYSETPOS，然后进入下一个月重复。假设起始日为 2004-06-10，上例求值为 Jun 30、Jul 30、Aug 31、Sep 30、Oct 29…… |
| INCLUDE | 在日历表达式中包含一个或多个命名调度：每个被包含命名调度所定义的时间戳集合被加入表达式结果。若同一时间戳既由被包含调度贡献、又由表达式本身贡献，结果集中只出现一次。命名调度须由 CREATE_SCHEDULE 过程定义。该子句只作用于整天，故不能与 BYHOUR、BYMINUTE、BYSECOND 同用。 |
| EXCLUDE | 从日历表达式中排除一个或多个命名调度：每个被排除命名调度所定义的时间戳集合从结果中移除。命名调度须由 CREATE_SCHEDULE 定义。只作用于整天，不能与 BYHOUR/BYMINUTE/BYSECOND 同用。 |
| INTERSECT | 指定日历表达式结果与一个或多个命名调度时间戳集合的交集：只有同时出现在表达式结果和某命名调度中的时间戳才纳入结果。例：命名调度 last_sat 表示每月最后一个周六；2005 年中月末恰为周六的只有 4 月与 12 月。命名调度 end_qtr 表示 2005 年每季末：3/31、6/30、9/30、12/31。`FREQ=MONTHLY; BYMONTHDAY=-1; INTERSECT=last_sat,end_qtr` 得到 3/31、4/30、6/30、9/30、12/31（即月末且为周六或季末）。该子句只作用于整天，不能与 BYHOUR/BYMINUTE/BYSECOND 同用。 |
| PERIODS | 标识构成一个用户自定义频率周期的段数。用于定义用户自定义频率的调度的 repeat_interval 中。当主调度的 repeat_interval 含 BYPERIOD 子句时为必填。例定义财年季：`FREQ=YEARLY;BYDATE=0301,0601,0901,1201;PERIODS=4`。 |
| BYPERIOD | 从用户自定义频率中选取若干段。如主调度引用了上例定义财季的用户自定义频率调度，则 `BYPERIOD=2,4` 选取第 2、4 财季。 |

#### 组合调度

组合调度有两种方式：
- 使用组合调度表达式，即一组单个调度的列表。例如为所有公司假日创建一个调度，提供一个单个调度的列表，每个调度定义一个假日。调度器对每个单个调度求值，返回各调度时间戳的并集。

  - INCLUDE 子句产生、但落入主调度跳过时段的时间戳会被忽略。主调度因 INTERVAL、BYPERIOD 子句或（freq=monthly 时）BYMONTH 子句跳过时段时即如此。
  - INCLUDE 子句加入的日期遵循主调度的小时/分/秒执行模式。

  - 存在 INCLUDE 子句时，不从起始日期取任何日期相关的默认值（但可取时间相关默认值，见后文"起始日期与重复间隔"）。如 `FREQ=MONTHLY;INCLUDE=HOLIDAY` 只在假日执行，而不取起始日期中的月/日默认值。

示例：

```
BEGIN
dbms_scheduler.create_schedule('embed_sched', repeat_interval =>
  'FREQ=YEARLY;BYDATE=0130,0220,0725');
dbms_scheduler.create_schedule('main_sched', repeat_interval =>
  'FREQ=MONTHLY;INTERVAL=2;BYMONTHDAY=15;BYHOUR=9,17;INCLUDE=embed_sched');
END;
/
```

上例中 1/30、2/20、7/25 被加入主调度。但调度器不加入落入 INTERVAL 子句跳过月份的日期：若主调度起始日为 2005-01-01，则 2/20 不被加入。被加入的日期上，嵌入调度遵循主调度的执行模式：1/30 与 7/25 在上午 9 点与下午 5 点执行作业。若嵌入调度本身没有起始日，则继承主调度的起始日。

#### 用户自定义频率

除使用 `DAILY`、`WEEKLY`、`MONTHLY` 等预定义频率外，你还可创建自己的频率：创建一个返回每个周期起始日的调度。例如下面 `repeat_interval` 用于名为 `fiscal_year` 的调度，定义财年各季起始：

```
FREQ=YEARLY;BYDATE=0301,0601,0901,1201;PERIODS=4
```

要返回每季最后一个周三，可创建一个调度（"主调度"），以 `fiscal_year` 调度作为用户自定义频率：

```
FREQ=fiscal_year;BYDAY=-1WED
```

用户自定义频率中的各段长度不必相等。主调度中 `BYSETPOS` 子句与带序号的周几会按每段大小重新计算。要在指定段中选日期，须在主调度中使用 `BYPERIOD` 子句；为此，作为用户自定义频率的调度必须含 `PERIODS` 子句并恰当设置起始日。该调度返回的第一个日期作为第 1 段起点。

再举例，假设工作日为周一至周五，要取财年第 2、4 季的最后一个工作日，主调度的 `repeat_interval` 为：

```
FREQ=fiscal_year;BYDAY=MON,TUE,WED,THU,FRI;BYPERIOD=2,4;BYSETPOS=-1
```

#### 起始日期与重复间隔

调度器从作业或调度的起始日中取出日期与时间，作为默认值并入 `repeat_interval`。例如频率为 yearly、且 repeat_interval 中无 `BYMONTH`/`BYMONTHDAY`，则作业运行的月、日从起始日取。类似地，频率为 monthly 且无 `BYMONTHDAY` 时，运行的日从起始日取。若有 `BYHOUR`/`BYMINUTE`/`BYSECOND`，其默认值也从起始日取（未显式指定时使用）。注意：若存在 `INCLUDE`/`EXCLUDE`/`INTERSECT` 子句，则不从起始日取日期相关默认值，但仍可取时间相关默认值。示例：

```
start_date:      4/15/05 9:00:00
repeat_interval: freq=yearly
```
内部展开为：
```
freq=yearly;bymonth=4;bymonthday=15;byhour=9;byminute=0;bysecond=0
```
即 04/15/05 9:00:00、04/15/06 9:00:00、04/15/07 9:00:00 …… 执行。

再设调度 `S1` 的 `repeat_interval` 为 `FREQ=YEARLY;BYDATE=0701`：
```
start_date:      01/20/05 9:00:00
repeat_interval: freq=yearly;include=S1
```
内部展开为：
```
freq=yearly;byhour=9;byminute=0;bysecond=0;include=S1
```
因存在 INCLUDE 子句，不从起始日取日期信息；但取时间信息，故在 07/01/05 9:00、07/01/06 9:00、07/01/08 9:00 …… 执行。

#### 一般规则

使用日历表达式时注意：
- 对于常规调度（非组合调度），日历字符串必须以频率子句开头；其余子句可选、顺序任意。
- 所有子句以分号分隔，每个子句最多出现一次（INCLUDE/EXCLUDE/INTERSECT 除外）。
- 语法元素间允许空格，字符串大小写不敏感。
- 某 BY 子句的取值列表无需排序。
- 当现有 BY 子句不足以确定下一个日期时，从起始日取。如 `FREQ=YEARLY` 起始日 02/15/2003 变为 `FREQ=YEARLY;BYMONTH=FEB;BYMONTHDAY=15`（每年 2 月 15 日）；`FREQ=YEARLY;BYMONTH=JAN,JUL` 起始日 01/21/2003 变为 `FREQ=YEARLY;BYMONTH=JAN,JUL;BYMONTHDAY=21`（每年 1 月 21 日与 7 月 21 日）。
- BYWEEKNO 子句仅当频率为 YEARLY 时允许，不能与其它频率同用。存在时返回该周号内的所有天；若要限定为周内特定天，需加 BYDAY。如 `FREQ=YEARLY;BYWEEKNO=2` 起始日 01/01/2003 返回 01/06–01/12 等。注意使用 BYWEEKNO 时返回的日期可能不属于当前年。如返回 2004 年日期、日历串为 `FREQ=YEARLY;BYWEEKNO=1,53` 时返回 12/29/03–01/04/04 与 12/27/04–01/02/05 等。
- 对取值范围不一致的 BY 子句，可在数值前加"-"从末尾倒数。如 `BYMONTHDAY=31` 不会给出每月最后一天（并非每月都有 31 天）；而 `BYMONTHDAY=-1` 给出当月最后一天。此特性不支持固定范围的 BY 子句（BYMONTH、BYHOUR、BYMINUTE、BYSECOND）。
- BYDAY 子句的基本值是周几。频率为 YEARLY 或 MONTHLY 时，可在周几前加正/负数：YEARLY 时 `BYDAY=40MON` 表示一年第 40 个周一；MONTHLY 时 `BYDAY=-2SAT` 表示当月倒数第二个周六。其它频率不支持周几前加数字；YEARLY 时数字范围为 -53…-1、1…53，MONTHLY 时为 -5…-1、1…5。周几前无数时表示该频率下该周几的所有出现。
- 一周第一天是周一。
- 频率小于 daily 的重复作业跨夏令时调整时严格遵循其频率。如作业每 3 小时重复，时钟从凌晨 1 点拨到 2 点，上次运行在午夜，则下次调度时间为凌晨 4 点（保持后续运行间隔为 3 小时）。时钟回拨时同理。频率为 daily 或更大的重复作业不如此：如某每日作业在午夜执行，时钟前拨或回拨后仍在午夜执行。当此类 daily（或更大频率）作业的执行时间恰落入时钟前拨窗口时，作业在该窗口末执行。
- 日历语法不允许指定时区；调度器从 `start_date` 参数取时区。若作业须遵循夏令时调整，必须为 `start_date` 的时区指定区域名。如纽约设为 `US/Eastern` 可自动应用夏令时；若设为绝对偏移如 `-5:00`，则不遵循夏令时，半年内作业执行时间偏差一小时。
  - 可用 `ALTER SESSION` 语句（如 `ALTER SESSION SET time_zone = 'Asia/Shanghai';`）或设置 ORA_SDTZ 环境变量。
  - 若会话时区为绝对偏移而非区域名，调度器使用 DEFAULT_TIMEZONE 调度器属性的值（见 SET_SCHEDULER_ATTRIBUTE 过程）。
  - 若 DEFAULT_TIMEZONE 为 NULL，调度器在作业或窗口启用时使用 systimestamp 的时区。

#### BYSETPOS 子句规则

- BYSETPOS 子句最后求值，在所有其它 BY 子句及 INCLUDE/EXCLUDE/INTERSECT 子句求值之后。
```
FREQ=MONTHLY;INTERVAL=3;BYDAY=MON,TUE,WED,THU,FRI;BYSETPOS=-2
```
- INTERVAL 子句不改变 BYSETPOS 应用的时段大小。如频率 monthly、interval=3 时，BYSETPOS 应用的时间戳列表由一个月生成（非一季），INTERVAL 仅导致跳月。但仍可选每季倒数第二个工作日（前提是起始日设在正确月份）。上例返回每月倒数第二个工作日，每季重复一次。
```
FREQ=MONTHLY;BYDAY=MON,TUE,FRI;BYSETPOS=1,3
```
- 为结果一致，BYSETPOS 应用的集合从频率周期起点确定，与求值时机无关。无论 01/01/2004 还是 01/15/2004 求值，表达式都求值为周五 01/02/2004 与周二 01/06/2004；区别仅在于 01/15 求值时调度器发现一月已无匹配（时间戳已过）而进入下月二月。

#### BYDATE 子句规则

- 若 BYDATE 中日期无可选的年份分量，则每年这些日期都运行。
```
freq=daily;byhour=8,13,18;byminute=0;bysecond=0;bydate=0502,0922
```
- 所含日期上的作业执行时间由日历表达式中 BY 子句推导。如 repeat_interval 如上，则 05/02 与 09/22 的执行时间为早 8 点、下午 1 点、下午 6 点。

#### EXCLUDE 子句规则

被排除的不含时间分量的日期为 24 小时区间，落在被排除日期上的所有时间戳都被移除。下例中 `jan_fifteen` 是解析为单日 01/15 的命名调度：
```
freq=monthly;bymonthday=15,30;byhour=8,13,18;byminute=0;bysecond=0;
     exclude=jan_fifteenth
```
此例中 01/15 当天的三次作业实例都被移除。

#### OFFSET 规则

可对单个命名调度加正偏移以调整其日期。如要让 `JOB2` 在 `JOB1` 每次出现后恰好 15 天执行，给 `JOB1` 的调度加 `+OFFSET:15D`：
```
BEGIN
dbms_scheduler.create_schedule('job2_schedule', repeat_interval =>
  'job1_schedule+OFFSET:15D');
END;
/
```
注意：命名调度不支持负偏移。

#### 示例 159-1 综合示例

本例演示用户自定义频率、span、offset、BYSETPOS 与 INCLUDE 子句的用法（OFFSET 子句中 OFFSET: 关键字可选）。

零售业多家公司共享同一财年：财年起始最接近 2 月 1 日的周日，后续各季起始恰好相隔 13 周。零售业财年调度可定义为：
```
begin
 dbms_scheduler.create_schedule('year_start', repeat_interval=>
       'FREQ=YEARLY;BYDATE=0201^SPAN:1W;BYDAY=SUN');
 dbms_scheduler.create_schedule('retail_fiscal_year',
        to_timestamp_tz('15-JAN-2005 12:00:00','DD-MON-YYYY HH24:MI:SS'),
         'year_start,year_start+13w,year_start+26w,year_start+39w;periods=4');
end;
/
```
以下调度可用于在零售业第 2、4 季的第 5 个休息日执行作业（假设周六、周日为休息日，且已有 `holiday` 调度覆盖其余休息日）：
```
begin
 dbms_scheduler.create_schedule('fifth_day_off', repeat_interval=>
  'FREQ=retail_fiscal_year;BYDAY=SAT,SUN;INCLUDE=holiday;
    BYPERIOD=2,4;BYSETPOS=5');
end;
/
```

### DBMS_SCHEDULER 数据结构

`DBMS_SCHEDULER` 包定义了 `OBJECT` 类型与 `TABLE` 类型。

OBJECT 类型
- JOBARG Object Type
- JOB_DEFINITION Object Type
- JOBATTR Object Type
- SCHEDULER$_STEP_TYPE Object Type
- SCHEDULER$_EVENT_INFO Object Type
- SCHEDULER_FILEWATCHER_RESULT Object Type
- SCHEDULER_FILEWATCHER_REQUEST Object Type

TABLE 类型
- JOBARG_ARRAY Table Type
- JOB_DEFINITION_ARRAY Table Type
- JOBATTR_ARRAY Table Type
- SCHEDULER$_STEP_TYPE_LIST Table Type


---

#### CREATE_PROGRAM Procedure

此过程创建一个程序（program）。

语法：

```
DBMS_SCHEDULER.CREATE_PROGRAM (
   program_name             IN VARCHAR2,
   program_type             IN VARCHAR2,
   program_action           IN VARCHAR2,
   number_of_arguments      IN PLS_INTEGER DEFAULT 0,
   enabled                  IN BOOLEAN DEFAULT FALSE,
   comments                 IN VARCHAR2 DEFAULT NULL);
```

参数（表 159-31 CREATE_PROGRAM Procedure Parameters）：

| 参数 | 说明 |
|---|---|
| program_name | 赋予该程序的名称。名称在 SQL 命名空间内必须唯一（例如不能与某 schema 中的表同名）。未指定名称会报错。 |
| program_type | 指定所创建程序的类型，未指定会报错。支持的取值：'PLSQL_BLOCK'——程序为 PL/SQL 块，此时作业/程序参数不支持，参数个数必须为 0；'STORED_PROCEDURE'——程序为 PL/SQL 或 Java 存储过程，或外部 C 子程序，仅支持过程（不支持有返回值的函数），不支持带 INOUT/OUT 参数的 PL/SQL 过程；'EXECUTABLE'——作业在数据库外用外部可执行文件运行（任何可从操作系统命令行执行的程序），不支持 AnyData 参数；'EXTERNAL_SCRIPT'——作业为外部脚本，使用运行作业机器的命令 shell（Windows 为 cmd.exe，UNIX 系为 sh，除非脚本首行用 `#!` 指定其它解释器）；'SQL_SCRIPT'——程序为 SQL*Plus 脚本，使用该程序的作业须指向含有效操作系统用户名/口令的凭据，脚本由 SQL*Plus 可执行文件运行；作业可指向含数据库凭据的连接凭据，若有则运行脚本前用它连接数据库（用连接凭据时须用 set_attribute 设置 Connect_Credential_Name 属性；若无则须在脚本中包含显式 SQL*Plus connect 语句并提供有效数据库用户/口令）；'BACKUP_SCRIPT'——程序为 RMAN 备份脚本，脚本执行目标命令前先运行一条使用口令或 OS 认证的 connect 语句，调度器用当前 Oracle home 的 RMAN 可执行文件运行脚本，缺失则报错。 |
| program_action | 指定程序的动作，未指定会报错。可能动作：PL/SQL 块——动作为执行 PL/SQL 代码，块须以分号结尾（如 `my_proc();` 或 `BEGIN my_proc(); END;` 或 `DECLARE arg pls_integer:=10; BEGIN my_proc2(arg); END;`），调度器会把 job_action 包在自己的块中（`DECLARE ... BEGIN job_action END;`）以声明内部调度器变量；可在 PL/SQL 代码中使用除 event_message 外的任何调度器元数据属性（用属性名作 PL/SQL 标识符，调度器赋值），匿名块还可用变量名 job_name、job_owner、job_start、window_start、window_end 访问特殊调度器元数据（见 DEFINE_METADATA_ARGUMENT）；存储过程——动作为存储过程名，过程所在 schema 与作业不同时须指定 schema，需大小写敏感时用双引号括起 schema 名与过程名（如 `program_action=>'"Schema"."Procedure"'`）；可执行文件——动作为外部可执行文件名（含全路径，不含命令行参数），以 `?` 开头时替换为本地作业的 Oracle home 或远程作业的调度器代理 home，含 `@` 且为本地作业时替换为当前 Oracle 实例的 SID；外部脚本——动作为操作系统脚本路径或内联脚本，脚本须存在于每台运行该程序的机器上，可调用 SQL*Plus/RMAN 可执行文件（无需全路径，前提是各机器默认位置有），作业参数只能为字符串或可转为字符串者，按位置传入；SQL 脚本——动作为 SQL*Plus 脚本路径或内联脚本，参数同上，若为命名参数还会绑定到 SQL*Plus 会话的命名变量；备份脚本——动作为 RMAN 脚本路径或内联脚本，参数同上。 |
| number_of_arguments | 程序接受的参数个数，未指定默认 0，最多 255。program_type 为 PLSQL_BLOCK 时忽略此参数。 |
| enabled | 是否创建为已启用。设为 TRUE 时做有效性检查并通过则创建为 ENABLED；默认 FALSE（未启用），也可之后调用 ENABLE 过程启用。 |
| comments | 关于此程序的注释，默认 NULL。 |

使用说明：
要在自己的 schema 中创建程序，需要 `CREATE JOB` 权限；拥有 `CREATE ANY JOB` 权限者可在任意 schema 创建。程序默认以禁用状态创建（除非 enabled 参数为 TRUE），启用前不能被作业执行。他人要使用你的程序须有 `EXECUTE` 权限，故创建程序后须授予 `EXECUTE` 权限。

参见："DEFINE_PROGRAM_ARGUMENT Procedure"。

---

#### CREATE_SCHEDULE Procedure

此过程创建一个调度（schedule）。

语法：

```
DBMS_SCHEDULER.CREATE_SCHEDULE (
   schedule_name          IN VARCHAR2,
   start_date             IN TIMESTAMP WITH TIMEZONE DEFAULT NULL,
   repeat_interval        IN VARCHAR2,
   end_date               IN TIMESTAMP WITH TIMEZONE DEFAULT NULL,
   comments               IN VARCHAR2 DEFAULT NULL);
```

参数（表 159-33）：

| 参数 | 说明 |
|---|---|
| schedule_name | 赋予该调度的名称，在 SQL 命名空间内唯一（不能与某 schema 中表同名），未指定会报错。 |
| start_date | 调度生效的第一个日期与时间。对重复调度，start_date 是参考日期——调度起始不一定是 start_date，而取决于 repeat_interval；start_date 用于确定调度的第一个实例。若 start_date 在过去且未指定 repeat_interval，则调度无效。对重复作业或窗口，未指定 start_date 时可从 repeat_interval 推导。start_date 为 null 时用作业/窗口启用时的日期。start_date 与 repeat_interval 不能同时为 null。 |
| repeat_interval | 调度重复的频率，用日历语法表达（见"日历语法"）。命名调度不允许用 PL/SQL 表达式作为重复间隔。 |
| end_date | 此日期时间之后作业不再运行、窗口不再打开。无 end_date 的非重复调度永久有效。end_date 须晚于 start_date，否则创建调度时报错。 |
| comments | 关于调度的可选注释，默认 NULL。 |

使用说明：
在自己 schema 创建调度需 `CREATE JOB` 权限，在他人 schema 创建（用 `schema.schedule_name`）需 `CREATE ANY JOB` 权限。调度创建后可被其他用户使用，并以对 PUBLIC 的访问创建，因此无需显式授权。

---

#### DEFINE_PROGRAM_ARGUMENT Procedure

此过程为程序参数定义名称或默认值。若程序参数未定义默认值，引用该程序的作业须提供参数值（作业也可覆盖默认值）。此过程有重载。

语法：

定义不带默认值的程序参数：
```
PROCEDURE define_program_argument(
   program_name            IN VARCHAR2,
   argument_position       IN PLS_INTEGER,
   argument_name           IN VARCHAR2 DEFAULT NULL,
   argument_type           IN VARCHAR2,
   out_argument            IN BOOLEAN DEFAULT FALSE);
```
定义带默认值的程序参数：
```
PROCEDURE define_program_argument(
   program_name            IN VARCHAR2,
   argument_position       IN PLS_INTEGER,
   argument_name           IN VARCHAR2 DEFAULT NULL,
   argument_type           IN VARCHAR2,
   default_value           IN VARCHAR2,
   out_argument            IN BOOLEAN DEFAULT FALSE);
```

参数（表 159-41）：

| 参数 | 说明 |
|---|---|
| program_name | 要修改的程序名，该程序必须存在。 |
| argument_position | 参数传给可执行文件时的位置。参数编号从 1 到程序的 number_of_arguments。必须唯一，会替换该位置已定义的参数。 |
| argument_name | 赋予参数的名称，可选但指定时须在该程序内唯一。赋名后可被其它包子程序使用（含 SET_JOB_ARGUMENT_VALUE）。 |
| argument_type | 所定义参数的数据类型。调度器不校验也不使用它，由程序用户决定赋值时使用。允许任意有效 SQL 数据类型。 |
| default_value | 作业未指定时赋予参数的默认值。 |
| out_argument | 保留供将来使用，必须设为 FALSE。 |

使用说明：
程序启用前，从 1 到 number_of_arguments 的所有参数都须已定义。若某参数未用此过程定义默认值，则作业中必须定义其值。定义程序参数要求你是程序属主或对其有 `ALTER` 权限，或拥有 `CREATE ANY JOB` 权限。`DEFINE_PROGRAM_ARGUMENT` 仅支持 SQL 类型参数，故布尔等非 SQL 类型的值不能作为程序/作业参数。

参见：DEFINE_ANYDATA_ARGUMENT、SET_JOB_ARGUMENT_VALUE。

---

#### DISABLE Procedure

此过程禁用程序、作业、链、窗口、数据库目标、外部目标、文件监视器或组。对象被禁用时其 `enabled` 属性设为 FALSE。

语法：

```
DBMS_SCHEDULER.DISABLE (
   name              IN VARCHAR2,
   force             IN BOOLEAN DEFAULT FALSE,
   commit_semantics  IN VARCHAR2 DEFAULT 'STOP_ON_FIRST_ERROR');
```

参数（表 159-42）：

| 参数 | 说明 |
|---|---|
| name | 被禁用对象名，可为逗号分隔列表。指定作业类名时该类下所有作业被禁用（作业类本身不禁用）。指定组名时组被禁用，组成员的启用状态不受影响。 |
| force | 为 TRUE 时即使有其它对象依赖也禁用。详见使用说明。 |
| commit_semantics | 提交语义，支持：STOP_ON_FIRST_ERROR（默认）——遇第一个错误即返回，之前成功的禁用操作已提交；TRANSACTIONAL——遇第一个错误返回，此前所有操作回滚，仅禁用作业或作业列表时支持，且 force=TRUE 时不支持；ABSORB_ERRORS——尽量吸收错误并禁用其余作业，提交所有成功的禁用操作，出错时可查 SCHEDULER_BATCH_ERRORS 视图，仅禁用作业/作业列表时支持。 |

使用说明：
窗口名前须加 `SYS`。禁用已禁用的对象不报错。`force` 选项意在指出依赖，不改动被依赖对象。对窗口或 WINDOW 类型组执行 DISABLE 须有 `MANAGE SCHEDULER` 权限。除 SYS schema 外可在任意 schema 使用 DISABLE。

作业：禁用作业意味着虽有元数据但不运行，作业协调器不再拾取处理；作业在队列中的 state 改为 disabled。force=FALSE 且作业正在运行则报错；force=TRUE 则禁用但允许当前运行实例完成。多目标作业不能在特定目标禁用子作业，但可禁用目标。

程序：禁用后状态改为 disabled，虽有元数据但指向它的作业不能运行。force=FALSE 时程序须未被任何作业引用，否则报错；force=TRUE 时指向它的作业不禁用，但运行时会因程序无效而失败。正在运行、指向该程序的作业不受影响、可继续。程序禁用不影响其相关参数。

文件监视器：force=FALSE 时须未被任何作业引用，否则报错；强制禁用则依赖它的作业被禁用。

窗口：禁用后窗口不再打开但元数据仍在，可重新启用。force=FALSE 时窗口须未打开且未被作业引用，否则报错；force=TRUE 时禁用打开中的窗口会成功但不会关闭它，仅阻止其未来打开直到重新启用。窗口禁用时以其为调度的作业不会被禁用。

窗口组：禁用 WINDOW 类型组后，以该窗口组为调度的作业（运行中除外）在成员窗口打开时不再运行；但以组中某成员窗口为调度的作业仍运行。组元数据仍在可重新启用，注意组成员窗口仍会打开。force=FALSE 时组中成员须无打开或被作业引用，否则报错；force=TRUE 时组被禁用，打开的窗口不关闭不禁用、允许运行至结束，以该组为调度的作业不禁用。

作业链：禁用链后元数据仍在但指向它的作业不能运行，便于安全改动链而不至于运行不完整定义的链。force=FALSE 时链须未被作业引用，否则报错；force=TRUE 时指向它的作业不禁用但运行时失败。正在运行、指向该链的作业不受影响、可完成。

数据库目标：禁用时——多目标作业运行时跳过该目标；若某作业所有目标都被禁用，调度器尝试运行时报错；*_SCHEDULER_JOB_DESTS 中引用该数据库目标的作业的 REFS_ENABLED 列设为 FALSE。

外部目标：禁用时——依赖它的数据库目标保持启用，但调度器运行引用该外部目标的数据库目标的作业时报错；所有引用该外部目标的外部作业、以及数据库目标依赖该外部目标的所有数据库作业，在 *_SCHEDULER_JOB_DESTS 中 REFS_ENABLED 设为 FALSE。

组：禁用外部目标组或数据库目标组时，调度器运行以该组为目标名的作业时报错。

---

#### DROP_JOB Procedure

此过程删除一个或多个作业，或删除一个或多个作业类中的全部作业。删除作业也会删除该作业设置的所有参数值。

语法：

```
DBMS_SCHEDULER.DROP_JOB (
   job_name                IN VARCHAR2,
   force                   IN BOOLEAN DEFAULT FALSE,
   defer                   IN BOOLEAN DEFAULT FALSE,
   commit_semantics        IN VARCHAR2 DEFAULT 'STOP_ON_FIRST_ERROR');
```

参数（表 159-52）：

| 参数 | 说明 |
|---|---|
| job_name | 作业名或作业类名，可为逗号分隔列表。作业类须指定 SYS schema。指定作业类名时删除该类中所有作业（作业类本身不删）。 |
| force | 为 TRUE 时调度器先尝试停止运行中的作业实例（以 force=false 调 STOP_JOB），再删除作业。 |
| defer | 为 TRUE 时调度器允许运行中作业完成后再删除。 |
| commit_semantics | 提交语义：STOP_ON_FIRST_ERROR（默认）——遇第一个错误返回，之前成功的删除已提交；TRANSACTIONAL——遇第一个错误返回并回滚此前操作，force=TRUE 时不支持；ABSORB_ERRORS——尽量吸收错误删除其余作业并提交所有成功删除，出错可查 SCHEDULER_BATCH_ERRORS。job_name 列表含作业类时仅允许 STOP_ON_FIRST_ERROR。 |

使用说明：
force 与 defer 都为 FALSE 且调用时作业正在运行，删除该作业失败；整个 DROP_JOB 调用是否失败取决于 commit_semantics。force 与 defer 同时为 TRUE 报错。删除作业要求你是作业属主、或对其有 `ALTER` 对象权限、或拥有 `CREATE ANY JOB` 系统权限。

---

#### DROP_PROGRAM Procedure

此过程删除一个程序。删除程序时其相关参数也一并删除。

语法：

```
DBMS_SCHEDULER.DROP_PROGRAM (
   program_name            IN VARCHAR2,
   force                   IN BOOLEAN DEFAULT FALSE);
```

参数（表 159-54）：

| 参数 | 说明 |
|---|---|
| program_name | 要删除的程序名，可为逗号分隔列表。 |
| force | 为 FALSE 时程序须未被任何作业引用，否则报错；为 TRUE 时引用该程序的所有作业在程序删除前先被禁用，正在运行、指向该程序的作业不受影响、可继续。 |

使用说明：
删除程序要求你是程序属主、或对其有 `ALTER` 权限、或拥有 `CREATE ANY JOB` 权限。

---

#### ENABLE Procedure

此过程启用程序、作业、链、窗口、数据库目标、外部目标、文件监视器或组。对象启用时 `enabled` 属性设为 TRUE。作业、链、程序默认创建为禁用；数据库目标、外部目标、文件监视器、窗口、组默认创建为启用。若作业原被禁用，启用后调度器按其调度自动运行。启用被禁用的作业还会重置 `*_SCHEDULER_JOBS` 视图中的 RUN_COUNT、FAILURE_COUNT、RETRY_COUNT。启用前做有效性检查，失败则不启用并返回相应错误。对象已启用时此过程不报错。

语法：

```
DBMS_SCHEDULER.ENABLE (
   name              IN VARCHAR2,
   commit_semantics  IN VARCHAR2 DEFAULT 'STOP_ON_FIRST_ERROR');
```

参数（表 159-59）：

| 参数 | 说明 |
|---|---|
| name | 被启用的调度器对象名，可为逗号分隔列表。指定作业类名时该类下所有作业被启用；指定组名时组被启用，组成员启用状态不受影响。 |
| commit_semantics | 提交语义：STOP_ON_FIRST_ERROR（默认）——遇第一个错误返回，之前成功的启用已提交；TRANSACTIONAL——遇第一个错误返回并回滚此前操作，仅启用作业/作业列表时支持；ABSORB_ERRORS——尽量吸收错误并启用其余作业，提交所有成功启用，出错可查 SCHEDULER_BATCH_ERRORS，仅启用作业/作业列表时支持。 |

使用说明：
窗口名前须加 `SYS`。对窗口或 WINDOW 类型组执行 ENABLE 须有 `MANAGE SCHEDULER` 权限。对 EXECUTABLE 类型作业（或指向 EXECUTABLE 程序的作业），作业属主须有 `CREATE EXTERNAL JOB` 系统权限才能启用/运行。启用文件监视器时，文件监视器属主须对指定凭据有 `EXECUTE` 权限。除 SYS schema 外可在任意 schema 使用 ENABLE。

---

#### RUN_JOB Procedure

此过程立即运行作业。作业已启用时调度器自动运行，无需调用 RUN_JOB；RUN_JOB 用于在正常调度之外运行作业。

语法：

```
DBMS_SCHEDULER.RUN_JOB (
   job_name                IN VARCHAR2,
   use_current_session     IN BOOLEAN DEFAULT TRUE);
```

参数（表 159-79）：

| 参数 | 说明 |
|---|---|
| job_name | 作业名或逗号分隔列表，每项为已存在作业名（可前缀 schema 名加点）。指定多目标作业时在所有目标运行，此时 use_current_session 须为 FALSE。 |
| use_current_session | 作业运行是否在与调用过程相同的会话中进行。作业总是以作业属主身份、在属主 schema 运行，除非指定了凭据则用凭据中用户运行。为 TRUE 时：可在命令行测试作业并看到错误；*_scheduler_jobs 的 state/run_count/last_start_date/last_run_duration/failure_count 不更新；RUN_JOB 可与正常调度的作业并行运行。为 FALSE 时：须查作业日志找错误；*_scheduler_jobs 相关字段都更新；若正常调度的作业正在运行则 RUN_JOB 失败。对指定了目标/目标组、或指向 detached 属性为 TRUE 的链/程序的作业，use_current_session 必须为 FALSE。 |

使用说明：
作业不必已启用。禁用作业运行前做有效性检查：指向有效作业类；作业属主对作业类有 EXECUTE 权限；引用的程序/链存在且属主有权执行；所有参数值已设（或有默认）；外部作业的属主有 CREATE EXTERNAL JOB 权限。

use_current_session 为 TRUE 不允许用于：destination_name 属性指定目标/目标组的作业、链作业、使用 detached 程序的作业。

use_current_session=TRUE 时 RUN_JOB 阻塞至作业完成，执行中错误作为错误返回给 RUN_JOB，不更新作业状态、不出现在 *_SCHEDULER_RUNNING_JOBS。use_current_session=FALSE 时 RUN_JOB 立即返回，作业由协调器拾取并交作业从属执行，须查视图与日志获知结果。多个用户会话可在 use_current_session=TRUE 时同时各自 RUN_JOB。RUN_JOB 要求你拥有该作业或对其有 `ALTER` 权限，或拥有 `CREATE ANY JOB` 权限。

示例：
```
BEGIN
  DBMS_SCHEDULER.RUN_JOB(
    JOB_NAME            => 'EODJOB, DSS.ETLJOB',
    USE_CURRENT_SESSION => FALSE);
END;
```

---

#### SET_JOB_ARGUMENT_VALUE Procedure

此过程设置作业参数的值。它会覆盖对应程序或存储过程参数的默认值。参数可按位置或按名指定，按名指定仅当：作业指向已保存的程序对象，且参数已由 DEFINE_PROGRAM_ARGUMENT 或 DEFINE_METADATA_ARGUMENT 赋名。调度器任何时刻都不做参数类型检查。此过程有重载。

语法：

按位置设置：
```
DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE (
   job_name                IN VARCHAR2,
   argument_position       IN PLS_INTEGER,
   argument_value          IN VARCHAR2);
```
按名设置：
```
DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE (
   job_name                IN VARCHAR2,
   argument_name           IN VARCHAR2,
   argument_value          IN VARCHAR2);
```

参数（表 159-98）：

| 参数 | 说明 |
|---|---|
| job_name | 要修改的作业名。 |
| argument_name | 所设程序参数的名。 |
| argument_position | 所设程序参数的位置。 |
| argument_value | 为程序参数设置的新值。设置非 VARCHAR 值须用 SET_JOB_ANYDATA_VALUE 过程。 |

使用说明：
要求你是作业属主或对其有 `ALTER` 权限，或拥有 `CREATE ANY JOB` 权限。仅支持 SQL 类型参数，布尔等非 SQL 类型不支持。可用于设置轻量级作业参数，但仅当参数类型为 VARCHAR2。

参见：SET_JOB_ANYDATA_VALUE、DEFINE_PROGRAM_ARGUMENT。

---

#### STOP_JOB Procedure

此过程停止正在运行的作业或某作业类中的所有作业。停止后，一次性作业的 state 设为 STOPPED，重复作业的 state 设为 SCHEDULED 或 COMPLETED（取决于下次运行是否已调度）。指向链的作业被停止时，运行中链的所有运行步骤被停止。多目标作业时，数据库尝试在所有目标停止该作业。对外部作业，STOP_JOB 仅停止由作业动作直接启动的外部进程，不停止外部作业的子进程。对 RAC 环境中的 in-memory full 作业，STOP_JOB 用作业定义的 instance_id 属性确定在哪个实例停止（属性为 null 则所有实例）。

语法：
```
DBMS_SCHEDULER.STOP_JOB (
   job_name         IN VARCHAR2
   force            IN BOOLEAN DEFAULT FALSE
   commit_semantics IN VARCHAR2 DEFAULT 'STOP_ON_FIRST_ERROR');
```

参数（表 159-102）：

| 参数 | 说明 |
|---|---|
| job_name | 要停止的作业名，可为逗号分隔列表，每项可为：作业名（可前缀 schema 加点）；作业目标 ID（*_SCHEDULER_JOB_DESTS 的 JOB_DEST_ID 列所得，代表作业+凭据+目标的唯一组合）；作业类（须前缀 SYS schema 加点，指定时该类所有作业被停止）。指定以目标组为 destination_name 的作业时，所有目标上所有作业实例被停止。 |
| force | 为 FALSE 时调度器尝试用中断机制优雅停止（让从属进程拿回控制以更新队列为 stopped），失败则报错；为 TRUE 时调度器立即终止作业从属，建议仅在 force=FALSE 失败后再用 force=TRUE，使用 force 选项须有 MANAGE SCHEDULER 系统权限。 |
| commit_semantics | 提交语义：STOP_ON_FIRST_ERROR（默认）——遇第一个错误返回并提交之前成功的停止；ABSORB_ERRORS——尽量吸收错误停止其余作业并提交所有成功停止，仅当 job_name 列表不含作业类时可用，出错可查 SCHEDULER_BATCH_ERRORS。 |

使用说明：
不带 force 的 STOP_JOB 要求你是作业属主或对其有 `ALTER` 权限，或拥有 `CREATE ANY JOB` 或 `MANAGE SCHEDULER` 权限。带 force 的 STOP_JOB 要求有 `MANAGE SCHEDULER` 权限。

示例：
```
BEGIN
  DBMS_SCHEDULER.STOP_JOB('DSS.ETLJOB, 984, 1223, SYS.ETL_JOBCLASS');
END;
```

---

#### EVALUATE_CALENDAR_STRING Procedure

可用调度器日历语法定义作业、窗口或调度的重复间隔。此过程对日历表达式求值，告诉你作业或窗口的下一次执行日期时间。便于在不实际调度作业/窗口的情况下测试日历串定义是否正确。通过把一次调用返回的 next_run_date 作为下次调用的 return_date_after 参数，可获取重复间隔的多个步骤。日历语法见"操作说明"。

语法：
```
DBMS_SCHEDULER.EVALUATE_CALENDAR_STRING (
   calendar_string    IN  VARCHAR2,
   start_date         IN  TIMESTAMP WITH TIME ZONE,
   return_date_after  IN  TIMESTAMP WITH TIME ZONE,
   next_run_date      OUT TIMESTAMP WITH TIME ZONE);
```

参数（表 159-61）：

| 参数 | 说明 |
|---|---|
| calendar_string | 要求值的日历表达式，须为"操作说明"中所述日历语法。 |
| start_date | 重复间隔生效的日期时间，也可用于填充日历串中缺失的特定项，可为 NULL。 |
| return_date_after | 帮助调度器从 start_date 与日历串确定的所有可能匹配（所有有效执行日期）中决定返回哪一个。传 NULL 时调度器自动填入 systimestamp。 |
| next_run_date | 在 return_date_after 值之后、与日历串和 start_date 匹配的第一个时间戳。 |

示例：以下代码片段可用于确定给定日历串下作业将运行的下五个日期。
```
SET SERVEROUTPUT ON;
ALTER SESSION set NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';

DECLARE
start_date        TIMESTAMP;
return_date_after TIMESTAMP;
next_run_date     TIMESTAMP;
BEGIN
start_date :=
  to_timestamp_tz('01-JAN-2003 10:00:00','DD-MON-YYYY HH24:MI:SS');
return_date_after := start_date;
FOR i IN 1..5 LOOP
  DBMS_SCHEDULER.EVALUATE_CALENDAR_STRING(
    'FREQ=DAILY;BYHOUR=9;BYMINUTE=30;BYDAY=MON,TUE,WED,THU,FRI',
    start_date, return_date_after, next_run_date);
DBMS_OUTPUT.PUT_LINE('next_run_date: ' || next_run_date);
return_date_after := next_run_date;
END LOOP;
END;
/
```
输出：
```
next_run_date: 02-JAN-03 09.30.00.000000 AM
next_run_date: 03-JAN-03 09.30.00.000000 AM
next_run_date: 06-JAN-03 09.30.00.000000 AM
next_run_date: 07-JAN-03 09.30.00.000000 AM
next_run_date: 08-JAN-03 09.30.00.000000 AM
PL/SQL procedure successfully completed.
```

使用说明：无需特定调度器权限。

---

#### CREATE_JOB Procedure

此过程创建单个作业。若通过把 `enabled` 属性设为 TRUE 创建为已启用，调度器会按其调度自动运行作业；若创建为禁用，则作业直到用 SET_ATTRIBUTE 启用后才运行。此过程有重载，各语法形式的功能随语法声明给出。

语法：

（1）单次调用创建作业，不使用已存在的程序或调度：
```
DBMS_SCHEDULER.CREATE_JOB (
   job_name             IN VARCHAR2,
   job_type             IN VARCHAR2,
   job_action           IN VARCHAR2,
   number_of_arguments  IN PLS_INTEGER              DEFAULT 0,
   start_date           IN TIMESTAMP WITH TIME ZONE DEFAULT NULL,
   repeat_interval      IN VARCHAR2                 DEFAULT NULL,
   end_date             IN TIMESTAMP WITH TIME ZONE DEFAULT NULL,
   job_class            IN VARCHAR2                 DEFAULT 'DEFAULT_JOB_CLASS',
   enabled              IN BOOLEAN                  DEFAULT FALSE,
   auto_drop            IN BOOLEAN                  DEFAULT TRUE,
   comments             IN VARCHAR2                 DEFAULT NULL,
   credential_name      IN VARCHAR2                 DEFAULT NULL,
   destination_name     IN VARCHAR2                 DEFAULT NULL);
```
（2）使用命名调度对象与命名程序对象：
```
DBMS_SCHEDULER.CREATE_JOB (
   job_name                IN VARCHAR2,
   program_name            IN VARCHAR2,
   schedule_name           IN VARCHAR2,
   job_class               IN VARCHAR2              DEFAULT 'DEFAULT_JOB_CLASS',
   enabled                 IN BOOLEAN               DEFAULT FALSE,
   auto_drop               IN BOOLEAN               DEFAULT TRUE,
   comments                IN VARCHAR2              DEFAULT NULL,
   job_style               IN VARCHAR2              DEFAULT 'REGULAR',
   credential_name         IN VARCHAR2              DEFAULT NULL,
   destination_name        IN VARCHAR2              DEFAULT NULL);
```
（3）使用命名程序对象 + 内联调度：
```
DBMS_SCHEDULER.CREATE_JOB (
   job_name             IN VARCHAR2,
   program_name         IN VARCHAR2,
   start_date           IN TIMESTAMP WITH TIME ZONE DEFAULT NULL,
   repeat_interval      IN VARCHAR2                 DEFAULT NULL,
   end_date             IN TIMESTAMP WITH TIME ZONE DEFAULT NULL,
   job_class            IN VARCHAR2                 DEFAULT 'DEFAULT_JOB_CLASS',
   enabled              IN BOOLEAN                  DEFAULT FALSE,
   auto_drop            IN BOOLEAN                  DEFAULT TRUE,
   comments             IN VARCHAR2                 DEFAULT NULL,
   job_style            IN VARCHAR2                 DEFAULT 'REGULAR',
   credential_name      IN VARCHAR2                 DEFAULT NULL,
   destination_name     IN VARCHAR2                 DEFAULT NULL);
```
（4）使用命名调度对象 + 内联程序：
```
DBMS_SCHEDULER.CREATE_JOB (
   job_name                IN VARCHAR2,
   schedule_name           IN VARCHAR2,
   job_type                IN VARCHAR2,
   job_action              IN VARCHAR2,
   number_of_arguments     IN PLS_INTEGER       DEFAULT 0,
   job_class               IN VARCHAR2          DEFAULT 'DEFAULT_JOB_CLASS',
   enabled                 IN BOOLEAN           DEFAULT FALSE,
   auto_drop               IN BOOLEAN           DEFAULT TRUE,
   comments                IN VARCHAR2          DEFAULT NULL,
   credential_name         IN VARCHAR2          DEFAULT NULL,
   destination_name        IN VARCHAR2          DEFAULT NULL);
```
（5）使用内联程序 + 事件：
```
DBMS_SCHEDULER.CREATE_JOB (
   job_name                IN VARCHAR2,
   job_type                IN VARCHAR2,
   job_action              IN VARCHAR2,
   number_of_arguments     IN PLS_INTEGER       DEFAULT 0,
   start_date              IN TIMESTAMP WITH TIME ZONE DEFAULT NULL,
   event_condition         IN VARCHAR2          DEFAULT NULL,
   queue_spec              IN VARCHAR2,
   end_date                IN TIMESTAMP WITH TIME ZONE DEFAULT NULL,
   job_class               IN VARCHAR2          DEFAULT 'DEFAULT_JOB_CLASS',
   enabled                 IN BOOLEAN           DEFAULT FALSE,
   auto_drop               IN BOOLEAN           DEFAULT TRUE,
   comments                IN VARCHAR2          DEFAULT NULL,
   credential_name         IN VARCHAR2          DEFAULT NULL,
   destination_name        IN VARCHAR2          DEFAULT NULL);
```
（6）使用命名程序对象 + 事件：
```
DBMS_SCHEDULER.CREATE_JOB (
   job_name                IN VARCHAR2,
   program_name            IN VARCHAR2,
   start_date              IN TIMESTAMP WITH TIME ZONE,
   event_condition         IN VARCHAR2,
   queue_spec              IN VARCHAR2,
   end_date                IN TIMESTAMP WITH TIME ZONE,
   job_class               IN VARCHAR2          DEFAULT 'DEFAULT_JOB_CLASS',
   enabled                 IN BOOLEAN           DEFAULT FALSE,
   auto_drop               IN BOOLEAN           DEFAULT TRUE,
   comments                IN VARCHAR2          DEFAULT NULL,
   job_style               IN VARCHAR2          DEFAULT 'REGULAR',
   credential_name         IN VARCHAR2          DEFAULT NULL,
   destination_name        IN VARCHAR2          DEFAULT NULL);
```

参数（表 159-28 CREATE_JOB Procedure Parameters）：

| 参数 | 说明 |
|---|---|
| job_name | 赋予作业的名称，在 SQL 命名空间内唯一（不能与某 schema 中表同名）。作业如在其它 schema 须加 schema 名限定。未指定会报错。若想由调度器生成名称，可用 GENERATE_JOB_NAME 过程生成名称再用于 CREATE_JOB（它从序列生成数字作为作业名，可加字符串前缀，作业名即该字符串+序列数字，见"GENERATE_JOB_NAME Function"）。 |
| job_type | 指定所创建作业类型，未指定报错（详见下一行 job_action）。取值：'PLSQL_BLOCK'——作业为匿名 PL/SQL 块，不支持参数，number_of_arguments 必须为 0；'STORED_PROCEDURE'——作业为 PL/SQL 或 Java 存储过程或外部 C 子程序，仅支持过程、不支持有返回值的函数；'EXECUTABLE'——作业在数据库外用外部可执行文件运行（任何可从命令行执行者），不支持 AnyData 参数，作业属主须有 CREATE EXTERNAL JOB 系统权限才能启用/运行；'CHAIN'——作业为链，不支持参数，number_of_arguments 须为 0；'EXTERNAL_SCRIPT'——作业为外部脚本，用运行作业机器的命令 shell（Windows=cmd.exe，UNIX=sh，除非首行 `#!` 指定）；'SQL_SCRIPT'——作业为 SQL*Plus 脚本，作业须指向含有效 OS 用户名/口令的凭据，由 SQL*Plus 可执行文件运行；可指向含数据库凭据的连接凭据（若有则运行脚本前用它连接数据库；用连接凭据须用 set_attribute 设 Connect_Credential_Name；无则须在脚本中含显式 SQL*Plus connect 语句并提供有效数据库用户/口令），作业属主须有 CREATE EXTERNAL JOB 权限；'BACKUP_SCRIPT'——作业为 RMAN 备份脚本，脚本执行目标命令前先运行用口令或 OS 认证的 connect 语句，作业指向含有效 OS 用户名/口令的凭据，RMAN 会话在该 OS 用户下运行，调度器用当前 Oracle home 的 RMAN 可执行文件运行脚本（缺失报错），作业属主须有 CREATE EXTERNAL JOB 权限。 |
| job_action | 指定作业动作，内联程序未指定会在创建时报错。作业动作在自治事务中执行，适用所有自治事务指南与限制（如自治事务中不允许 online DDL，故不能用于作业动作）。可能动作：PL/SQL 块——动作为执行 PL/SQL 代码，块须以分号结尾（如 `my_proc();`/`BEGIN my_proc(); END;`/`DECLARE arg pls_integer:=10; BEGIN my_proc2(arg); END;`），调度器把 job_action 包在自己块中（`DECLARE ... BEGIN job_action END;`）以声明内部变量；可在代码中用除 event_message 外的任何调度器元数据属性（属性名作标识符，调度器赋值，见 Table 159-40）；存储过程——动作为存储过程名，过程在其它 schema 须指定 schema，大小写敏感时用双引号括起（`job_action=>'"Schema"."Procedure"'`），STORED_PROCEDURE 类型不支持带 INOUT/OUT 参数的 PL/SQL 过程作 job_action；可执行文件——动作为外部可执行文件名（含全路径，不含命令行参数），以 `?` 开头时替换为本地作业 Oracle home 或远程作业调度器代理 home，含 `@` 且本地作业时替换为当前实例 SID，注意不支持 shell 脚本语法、只支持可执行文件名与路径；链——动作为调度器链对象名，链在其它 schema 须指定 schema；外部脚本——job_action 为 OS 脚本路径或内联脚本，路径须存在于每台运行机器上，可调用 SQL*Plus/RMAN（无需全路径），参数只能为字符串或可转字符串者、按位置传入，作业须指向含有效 OS 用户名/口令的凭据；SQL 脚本——job_action 为 SQL*Plus 脚本路径或内联脚本，参数同上，命名参数还会绑定到 SQL*Plus 会话命名变量；备份脚本——job_action 为 RMAN 脚本路径或内联脚本，参数同上。 |
| number_of_arguments | 作业期望的参数个数，范围 0–255，默认 0。 |
| program_name | 与该作业关联的程序名。程序类型为 EXECUTABLE 时作业属主须有 CREATE EXTERNAL JOB 系统权限才能启用/运行。 |
| start_date | 作业计划首次开始的日期时间。start_date 与 repeat_interval 都为 null 时作业在启用后尽快运行。对用日历表达式指定重复间隔的重复作业，start_date 作参考日期，作业首次运行为当前日期时间起（含）日历表达式的第一个匹配。系统过载时调度器不能保证精确时间执行。 |
| event_condition | 基于事件源队列表列的条件表达式，须为高级队列（AQ）规则语法。消息载荷为对象类型时可在表达式中包含用户数据属性，对象属性前须加 `tab.user_data`。规则详见 DBMS_AQADM.ADD_SUBSCRIBER。 |
| queue_spec | 指定以下之一： enqueue 此作业启动事件的源队列——安全队列时 queue_spec 为 `queue_name, agent name` 对，非安全队列只需队列名；未提供全限定队列名则认为在作业属主 schema 中，安全队列的 agent 名须属于当前订阅该队列的有效 agent。或一个文件监视器名（见《Administrator's Guide》）。 |
| repeat_interval | 作业重复频率，可用日历或 PL/SQL 表达式。表达式求值以确定下次运行时间。未指定则作业在指定 start_date 只运行一次。见"日历语法"。 |
| schedule_name | 与该作业关联的调度、窗口或窗口组名。 |
| job_class | 该作业关联的作业类。 |
| end_date | 作业过期、不再运行的日期时间。超过后若 auto_drop 为 TRUE 则作业被删除；若 auto_drop 为 FALSE 则作业被禁用且 STATE 设为 COMPLETED。未指定则永久重复，除非设了 max_runs 或 max_failures（达到时停止）。end_date 须晚于 start_date，否则报错；二者相同则作业不执行且不报错。 |
| comments | 关于作业的注释，默认 NULL。 |
| job_style | 所创建作业样式，取值：'REGULAR'（默认，常规作业）；'LIGHTWEIGHT'（轻量级作业，仅当作业引用程序对象时允许，适用于频繁运行的短作业，特定场景有小幅性能提升）；'IN_MEMORY_RUNTIME'（内存中运行时作业，基于轻量级结构、规则限制相同，但保留内存缓存以最小化运行前后磁盘访问、进一步提升性能）；'IN_MEMORY_FULL'（内存中完整作业，须有程序、不能有调度或重复间隔，启用时自动运行、运行后丢弃，所有信息在内存、不落盘，实例重启即丢失，用于须以最低开销立即执行的动作）。 |
| credential_name | 作业默认凭据，仅适用于远程数据库作业、远程外部作业、本地外部作业、脚本作业及处理文件到达事件的事件作业，凭据必须存在。本地数据库作业须为 NULL。仅本地外部作业：此属性为 NULL（默认）时选用首选（默认）凭据（见《Administrator's Guide》）。参见 CREATE_CREDENTIAL。 |
| destination_name | 作业的数据库目标或外部目标，仅用于远程数据库作业与远程外部作业；本地数据库或本地外部（可执行）作业须为 NULL。可为单个目标名或 'EXTERNAL_DEST'/'DB_DEST' 类型组名。单个目标或组须已存在：数据库目标须由 CREATE_DATABASE_DESTINATION 创建；外部目标由向本地数据库注册远程调度器代理时隐式创建；组则每个成员须存在、作业在组中所有目标上运行（见 CREATE_GROUP）。destination_name 不能引用目标组当：作业类型为 'CHAIN'；作业样式为 'LIGHTWEIGHT'/'IN_MEMORY_RUNTIME'/'IN_MEMORY_FULL'。若 CREATE_JOB 的 credential_name 参数为 NULL，每个目标前须带凭据，格式 `credential.destination`，凭据须已存在；若提供 credential_name 则作为未带凭据目标的默认凭据。可查 *_SCHEDULER_DB_DESTS、ALL_SCHEDULER_EXTERNAL_DESTS、*_SCHEDULER_GROUP_MEMBERS。注：destination 作业属性在 11gR2 已弃用，由 destination_name 取代。 |
| enabled | 是否创建为已启用（TRUE/FALSE），默认 FALSE 即创建为禁用。禁用作业意味着元数据已捕获、作为数据库对象存在，但调度器忽略它、协调器不拾取；要运行须启用——置此参数为 TRUE 或用 ENABLE 过程。 |
| auto_drop | 为 TRUE 时作业完成或被自动禁用后自动删除。作业完成指：end_date（或调度 end_date）已过（注意以窗口为调度的作业窗口关闭时不视为窗口结束、不自动删除）；已运行 max_runs 次（max_runs 须用 SET_ATTRIBUTE 设）；非重复作业且已运行一次。作业失败 max_failures 次时被禁用（max_failures 亦用 SET_ATTRIBUTE 设）。为 FALSE 时不删除、元数据保留至显式 DROP_JOB。默认 TRUE。 |

使用说明：
作业默认创建为禁用，须显式启用才活动、调度。启用前确保所有程序参数（若有）已定义——在程序对象中定义默认值或随作业提供值。初始化参数 `JOB_QUEUE_PROCESSES` 指定作业执行可创建的最大进程数；自 11gR2 起对 `DBMS_SCHEDULER` 作业生效，设为 0 则禁用 `DBMS_SCHEDULER` 作业。在自己 schema 创建作业需 `CREATE JOB` 权限；`CREATE ANY JOB` 可在任意 schema 创建；作业在其它 schema 须加 schema 名限定。EXECUTABLE 类型作业（或指向 EXECUTABLE 程序）的属主须有 `CREATE EXTERNAL JOB` 系统权限。作业关联特定类或程序需对其有 `EXECUTE` 权限。并非所有作业属性都可用 CREATE_JOB 设，部分须创建后设（如作业参数用 SET_JOB_ARGUMENT_VALUE/SET_JOB_ANYDATA_VALUE，job_priority、max_runs 等用 SET_ATTRIBUTE）。高效创建多作业用 CREATE_JOBS。注意：事件作业对每个匹配事件条件的事件运行一次，但作业正在运行期间发生的事件被忽略——事件被消费但不触发再次运行。

---

#### SET_ATTRIBUTE Procedure

此过程修改调度器对象的某个属性。有重载，可接受多种类型的值。要把属性设为 `NULL` 用 `SET_ATTRIBUTE_NULL` 过程。可设的属性取决于被改对象。除对象名外，所有对象属性都可改。

语法：
```
DBMS_SCHEDULER.SET_ATTRIBUTE (
   name           IN VARCHAR2,
   attribute      IN VARCHAR2,
   value          IN {BOOLEAN|DATE|TIMESTAMP|
                        TIMESTAMP WITH TIME ZONE|TIMESTAMP WITH LOCAL TIME ZONE|
                        INTERVAL DAY TO SECOND});
DBMS_SCHEDULER.SET_ATTRIBUTE (
   name           IN VARCHAR2,
   attribute      IN VARCHAR2,
   value          IN VARCHAR2,
   value2         IN VARCHAR2 DEFAULT NULL);
```

参数（表 159-81）：

| 参数 | 说明 |
|---|---|
| name | 对象名。 |
| attribute | 见表 159-83 至 159-93。 |
| value | 为属性设的新值，不能为 NULL（设 NULL 用 SET_ATTRIBUTE_NULL）。 |
| value2 | 可选第二个值。多数属性仅一个值，部分可有两个。 |

表 159-82 是调度器对象类型及其属性表的目录，这些对象类型可用调度器数据字典视图查看（见《Administrator's Guide》）。

表 159-82 调度器对象类型的属性表

| 调度器对象类型 | 属性表 |
|---|---|
| Job | 159-83 |
| Program | 159-85 |
| Schedule | 159-86 |
| File Watcher | 159-87 |
| Job Class | 159-88 |
| Window | 159-89 |
| Chain | 159-90 |
| Database Destination | 159-91 |
| External Destination | 159-92 |
| Group | 159-93 |
| Credential | 159-94 |
| Resource | 159-95 |

使用说明：
若对象被改且原为启用状态，调度器先禁用它、再改、再重新启用；重新启用过程中出错则不重新启用并报错。若对象被改且原为禁用状态，改后仍禁用。对窗口、WINDOW 类型组或作业类执行 SET_ATTRIBUTE 须有 `MANAGE SCHEDULER` 权限；否则须是对象属主或对其有 `ALTER` 权限或拥有 `CREATE ANY JOB` 权限。

作业：调用 SET_ATTRIBUTE 时若作业有运行中实例，不受影响，改动仅影响后续运行。作业运行时改调度属性（schedule_name、start_date、end_date、repeat_interval），下次运行用新调度属性。运行时改程序属性（program_name、job_action、job_type、number_of_arguments），下次运行生效。运行时改作业参数值，下次运行生效。授予作业的 `ALTER` 权限允许用户改除程序属性（program_name、job_type、job_action、program_action、number_of_arguments）外的所有属性，且不允许用 PL/SQL 表达式指定作业调度。Oracle 建议不要改动数据库自动创建的作业（作业视图中 SYSTEM 列为 TRUE 者）。

程序：若当前运行中作业使用了被改的程序，它们继续用改动前的程序定义；下次执行时用新定义。调度：改调度不影响使用它的运行中作业和已打开窗口，改动在下次作业运行/窗口打开时生效。文件监视器：改文件监视器不影响当前由文件到达事件启动的运行中事件作业；本地系统上，新属性在下次文件监视器检查文件到达时生效（默认每 10 分钟），远程系统可能有额外延迟。作业类：除默认作业类外都可改，改作业类须有 `MANAGE SCHEDULER` 权限；改动不影响类中运行中作业，仅对未开始运行的作业生效，作业类名前须加 `SYS`。窗口：改窗口不影响活动窗口，改动下次打开时生效；无当前资源计划时，带指定资源计划的窗口打开时资源管理器以该计划激活；窗口名前须加 `SYS`。

**作业属性值**（表 159-83，详见 CREATE_JOB/CREATE_JOBS）：

| 名称 | 说明 |
|---|---|
| allow_runs_in_restricted_mode | 为 TRUE 时允许作业在数据库受限模式下运行（前提是作业属主允许在此模式登录）。默认 FALSE。 |
| auto_drop | 为 TRUE 时作业完成或被自动禁用后自动删除。完成指：end_date（或调度 end_date）已过；已运行 max_runs 次（max_runs 用 SET_ATTRIBUTE 设）；非重复作业且已运行一次。失败 max_failures 次时自动禁用（max_failures 用 SET_ATTRIBUTE 设）。为 FALSE 时不删除，元数据保留至显式 DROP_JOB。默认 TRUE。 |
| comments | 可选注释。 |
| connect_credential_name | 可指向数据库凭据。对 SQL*Plus/备份脚本作业，凭据用于运行脚本前连接数据库；其它作业类型忽略。作业属主须对该凭据有 EXECUTE 权限否则作业失败。推荐用此属性，使口令安全存于数据库凭据而非明文出现在作业/程序动作/脚本中。 |
| credential_name | 远程数据库作业、远程外部作业、本地外部作业或处理文件到达事件的事件作业所用的凭据对象名。仅本地外部作业：为 NULL（默认）时选用首选（默认）凭据（见《Administrator's Guide》）。 |
| database_role | 用于 Data Guard 环境。设为 'PRIMARY' 则仅数据库为主库时运行；'LOGICAL STANDBY' 则仅逻辑备库时运行。主库时默认 'PRIMARY'，逻辑备库时默认 'LOGICAL STANDBY'。注意：要让作业在某主机所有数据库角色下运行，须在该主机创建两份作业，一份 'PRIMARY'、一份 'LOGICAL STANDBY'。 |
| destination | 11gR2 已弃用，改用 destination_name。指定远程外部作业运行主机，设为主机名或 IP，可选加端口，格式 `hostname:port`。默认 NULL。 |
| destination_name | 作业的数据库目标或外部目标，仅用于远程数据库/远程外部作业；本地数据库或本地外部作业须为 NULL。详见表 159-28。 |
| end_date | 作业过期、不再运行的日期时间。超过后 auto_drop 为 TRUE 则删除；为 FALSE 则禁用且 STATE=COMPLETED。未指定则永久重复，除非 max_runs/max_failures 达到。须晚于 start_date，否则报错；二者相同则不执行且不报错。 |
| event_spec | 取两个值：value 为事件条件，value2 为队列规范。详见 CREATE_JOB 的 event_condition、queue_spec。 |
| follow_default_timezone | 为 TRUE 且作业 start_date 为 null 时，default_timezone 调度器属性改变后调度器重算下次运行日期时间以符合新时区（如原 02:00 则新时区也 02:00）。start_date 非 null 时运行日期时间由 start_date 时区决定。为 FALSE 时不重算（旧时区比新早 3 小时则原 02:00 在新时区变 05:00）。夏冬切换不改默认时区名。 |
| instance_id | 仅 RAC 环境有效，指示作业在哪个实例运行。 |
| instance_stickiness | 仅 RAC 环境用，默认 TRUE。TRUE 时作业在负载最轻实例启动，之后尽量在同一实例运行；该实例宕机或长时间过载则在另一实例运行；运行间隔大时忽略此属性、按非粘性处理。FALSE 时每次在首个可用实例运行。非 RAC 无用。 |
| job_action | 作业执行的动作，取决于 job_type（如 STORED_PROCEDURE 时为存储过程名）。 |
| job_class | 作业关联的类。 |
| job_priority | 作业相对同类作业的优先级。同类多个作业同时计划执行时由它决定协调器拾取顺序，取值 1–5，1 最先。创建时未指定默认 3。 |
| job_type | 作业类型，取值：'PLSQL_BLOCK'、'STORED_PROCEDURE'、'EXECUTABLE'、'CHAIN'、'EXTERNAL_SCRIPT'、'SQL_SCRIPT'、'BACKUP_SCRIPT'。设了它则 program_name 须为 NULL。 |
| job_weight | 11gR2 已弃用，勿改默认值 1。并行执行的作业权重。 |
| logging_level | 记日志多少：LOGGING_OFF（默认，不记录，但作业类日志级别优先、可能仍记录）；LOGGING_FAILED_RUNS（只记失败及原因，作业类级别更高则优先）；LOGGING_RUNS（对该类每个作业所有运行写详细日志）；LOGGING_FULL（除每次运行外还记录对作业的所有操作：create、enable、disable、alter、stop 等）。 |
| max_failures | 作业连续失败多少次后自动禁用，禁用后不再执行且 STATE=BROKEN。取值 1–1,000,000，默认 NULL（不论失败多少次都启动新实例）。 |
| max_run_duration | 作业允许运行的最长时间（INTERVAL DAY TO SECOND）。设非零非 NULL 且作业运行超过则触发 JOB_OVER_MAX_DUR 事件，由事件处理器决定是否让其继续。 |
| max_runs | 作业连续计划运行的最大次数。达到后作业禁用、state=COMPLETED。取值 1–1,000,000，默认 NULL（永久重复或至 end_date/max_failures）。 |
| number_of_arguments | 内联程序的参数个数。设了它则 program_name 须为 NULL。 |
| parallel_instances | 布尔，仅事件作业可设。FALSE（默认）时若事件发生而处理该事件的事件作业正在运行则新事件被忽略；TRUE 时为每个事件实例启动一个作业实例，每个为轻量级作业故可并行，各轻量级作业从父作业定义取属性（动作、最大运行时长等），完成后丢弃。同时运行的轻量级作业数无显式上限（受系统资源限制），不在 *_SCHEDULER_JOBS 但在 *_SCHEDULER_RUNNING_JOBS 中，名同父作业、自动生成子名区分。 |
| program_name | 作业所用程序对象名。设了它则 job_action、job_type、number_of_arguments 须为 NULL。 |
| raise_events | 告诉调度器在作业执行各阶段引发哪些事件，是位向量，可设以下位（各有包常量对应）：job_started=1、job_succeeded=2、job_failed=4、job_broken=8、job_completed=16、job_stopped=32、job_sch_lim_reached=64、job_disabled=128、job_chain_stalled=256、job_all_events=511、job_run_completed=job_succeeded+job_failed+job_stopped。详见表 159-84。 |
| repeat_interval | 返回下次运行日期时间的 PL/SQL 函数，或日历语法表达式。设了它则 schedule_name 须为 NULL。见"日历语法"。 |
| restartable | 作业失败能否重启，默认 FALSE。TRUE 时若作业运行中失败则从头重启；链作业为 TRUE 时应用失败后链从头重启，为 FALSE 或数据库失败时从最后运行步骤重启（该步骤的 restart_on_recovery 决定重启或标为停止；标为停止则链评估规则继续）。注意设 TRUE 可能导致数据不一致（如作业中已提交数据）。出错重试不计为常规运行，run/failure 计数在作业成功或六次重试全失败后才递增。调度器据此属性决定应用错误与数据库故障后是否重试，最多重试六次（第一次等 1 秒，之后每次乘 10）。六次重试全失败则 run、failure 计数各 +1；任一次重试成功则 run 计数 +1。停止重试条件：某次重试成功；六次重试全失败；下次重试将晚于下次常规调度运行（重复作业下次常规运行后不再重试）。 |
| schedule_limit | 重载系统下作业不一定按时启动。此属性让你在启动延迟超过指定间隔时不启动作业，取值 1 分钟到 99 天。如某作业应 12:00 启动、schedule_limit=60 分钟，则 13:00 前未启动则不运行。未指定则在有资源时尽快后续运行。默认 NULL（可在计划时间后任意时间运行）。因该属性跳过的计划运行不计入运行/失败次数，作业日志有记录。 |
| schedule_name | 用作作业调度的调度、窗口或 WINDOW 类型组名。设了它则 end_date、start_date、repeat_interval 须为 NULL。 |
| start_date | 作业起始或计划起始的原始日期时间。设了它则 schedule_name 须为 NULL。 |
| stop_on_window_close | 仅当作业调度为窗口或窗口组时适用。TRUE 表示关联窗口关闭时作业应停止（用 force=FALSE 的 stop_job 停）。默认 FALSE（不设则窗口关闭后作业继续；注意虽继续但资源分配可能因关窗换资源计划而变）。 |
| store_output | 布尔。TRUE 时对已记日志的运行，所有作业输出与错误消息存入 *_JOB_RUN_DETAILS。FALSE 则不存。新作业默认 TRUE。 |

表 159-84 调度器引发的事件类型（raise_events 属性取值）：

| 事件类型 | 说明 |
|---|---|
| job_all_events | 非事件，是启用所有事件的便捷常量。 |
| job_broken | 作业被禁用并转为 BROKEN 状态（超过 max_failures）。 |
| job_chain_stalled | 运行链的作业处于 CHAIN_STALLED：无步骤运行或计划运行且 evaluation_interval 为 NULL 时链停滞，须人工干预才推进。 |
| job_completed | 作业因达 max_runs 或 end_date 而完成。 |
| job_disabled | 作业被调度器或 SET_ATTRIBUTE 禁用。 |
| job_failed | 作业因错误或异常终止而失败。 |
| job_over_max_dur | 作业超过 max_run_duration 指定最大运行时长（此事件无需用 raise_events 启用，始终启用）。 |
| job_run_completed | 作业运行失败、成功或被停止。 |
| job_sch_lim_reached | 达到 schedule_limit：启动延迟超过 schedule_limit 故未启动。 |
| job_started | 作业启动。 |
| job_stopped | 作业被 STOP_JOB 停止。 |
| job_succeeded | 作业成功完成。 |

**程序属性值**（表 159-85，详见 CREATE_PROGRAM）：

| 名称 | 说明 |
|---|---|
| comments | 可选注释，描述程序功能或用法。 |
| detached | TRUE 则为 detached 程序（见《Administrator's Guide》）。 |
| number_of_arguments | 程序调用的存储过程或可执行文件所需参数个数。 |
| program_action | 程序执行的动作，取决于 program_type（如 STORED_PROCEDURE 时为存储过程名）。 |
| program_type | 程序类型，须为 'PLSQL_BLOCK'、'STORED_PROCEDURE'、'EXECUTABLE' 之一。 |

**调度属性值**（表 159-86，详见 CREATE_SCHEDULE）：

| 名称 | 说明 |
|---|---|
| comments | 可选注释。 |
| end_date | 调度不再指定日期的截止日期时间。 |
| event_spec | 取两个值：value 为事件条件，value2 为队列规范（见 CREATE_JOB 的 event_condition、queue_spec）。 |
| repeat_interval | 用日历语法指定调度重复频率。见"日历语法"。 |
| start_date | 日历语法用的起始/参考日期时间。 |

**文件监视器属性值**（表 159-87）：

| 参数 | 说明 |
|---|---|
| destination | 文件预期到达的远程主机名或 IP；NULL 则为主机。 |
| directory_path | 文件预期到达的目录；路径首部单个通配符 '?' 表示 Oracle home 路径（如 '?/rdbms/log' 表示 Oracle home 下 rdbms/log 子目录）。 |
| file_name | 要查找的文件名。允许两个通配符：'?' 单字符、'*' 零或多个字符。不能为 NULL。 |
| credential_name | 有效凭据对象名，文件监视器用它向主机 OS 认证以访问被监视文件；属主须对该凭据有 EXECUTE 权限。不能为 NULL。 |
| min_file_size | 文件被视为找到前的最小字节数，默认 0。 |
| steady_state_duration | 文件须保持不变的最小时间间隔后才视为找到；NULL 用内部值，下限 10 秒。 |
| comments | 可选注释。 |

**作业类属性值**（表 159-88，详见 CREATE_JOB_CLASS）：

| 名称 | 说明 |
|---|---|
| comments | 关于作业类的可选注释。 |
| log_history | 该类作业日志条目保留天数，范围 0–1,000,000；0 不保留历史；NULL 则由 log_history 调度器属性（SET_SCHEDULER_ATTRIBUTE 设）决定。 |
| logging_level | 记日志多少：LOGGING_OFF（此类所有作业不记录）；LOGGING_FAILED_RUNS（只记失败及原因）；LOGGING_RUNS（对此类每个作业所有运行写详细日志，默认）；LOGGING_FULL（除每次运行外还记录对作业的所有操作：create/enable/disable/alter/stop 等）。 |
| resource_consumer_group | 作业类关联的资源使用者组，类中所有作业在该组下运行（见《Administrator's Guide》）。 |
| service | 作业类中作业有亲和性的数据库服务。若同时设 resource_consumer_group 与 service 且 service 映射到某资源使用者组，则 resource_consumer_group 优先。 |

**窗口属性值**（表 159-89，详见 CREATE_WINDOW）：

| 名称 | 说明 |
|---|---|
| comments | 关于窗口的可选注释。 |
| duration | 窗口持续时间。 |
| end_date | 窗口不再打开的日期。设了它则 schedule_name 须为 NULL。 |
| repeat_interval | 用日历语法指定调度重复频率，不允许 PL/SQL 日期函数。设了它则 schedule_name 须为 NULL。见"日历语法"。 |
| resource_plan | 与窗口关联的资源计划。窗口打开时系统切换到该计划，关闭时恢复原计划；若某资源计划以 force 选项激活则不切换。仅一个资源计划可与窗口关联，可为 NULL 或空串。NULL 时窗口打开期间保持当时生效的资源计划；空串时窗口期间禁用资源管理器。 |
| schedule_name | 窗口所用调度名。设了它则 start_date、end_date、repeat_interval 须为 NULL。 |
| start_date | 窗口计划下次打开的日期时间。设了它则 schedule_name 须为 NULL。 |
| window_priority | 窗口优先级，'LOW'（默认）或 'HIGH'。 |

**链属性值**（表 159-90，详见 CREATE_CHAIN）：

| 名称 | 说明 |
|---|---|
| comments | 描述链用途的可选注释。 |
| evaluation_interval | 非 NULL 时除正常评估时机（作业启动、步骤完成、事件步骤事件到达）外，按此间隔额外评估链。仅当链规则用 SQL 语法且条件含调度器不可控元素时使用（额外间隔耗 CPU）；多数链正常评估时机已足够。 |
| rule_set_name | 正常情况不传入规则集，调度器自动创建规则集与空评估上下文，用 DEFINE_CHAIN_RULE 加规则、DROP_CHAIN_RULE 删规则。高级用户可创建描述链依赖的规则集传入以获更大灵活性（条件可引用外部变量、表可通过评估上下文暴露）。传入须确保为链规则集格式（如所有步骤须列为评估上下文变量）。不传则规则集形如 SCHED_RULESET${N}、评估上下文形如 SCHED_EVCTX${N}。 |

**数据库目标属性值**（表 159-91，详见 CREATE_DATABASE_DESTINATION）：

| 名称 | 说明 |
|---|---|
| agent | 用于连接远程数据库的外部目标（agent 目标）名，可从 ALL_SCHEDULER_EXTERNAL_DESTS 获取。 |
| connect_info | 标识要连接远程数据库的 TNS 连接描述符，或 tnsnames.ora 中解析为该描述符的网络服务名（别名）。对应 CREATE_DATABASE_DESTINATION 的 tns_name 参数。 |
| enabled | TRUE 则数据库目标已启用。 |
| comments | 关于数据库目标的可选注释。 |

**外部目标属性值**（表 159-92，外部目标仅由向本地数据库注册远程调度器代理时隐式创建）：

| 名称 | 说明 |
|---|---|
| hostname | （仅 GET_ATTRIBUTE）调度器代理所在机器的全限定主机名（含域）或 IP。 |
| port | （仅 GET_ATTRIBUTE）代理监听的 TCP 端口。 |
| ip_address | （仅 GET_ATTRIBUTE）代理所在主机 IP。 |
| enabled | TRUE 则外部目标已启用。 |
| comments | 关于外部目标的可选注释。 |

**组属性值**（表 159-93，详见 CREATE_GROUP）：

| 名称 | 说明 |
|---|---|
| group_type | （仅 GET_ATTRIBUTE）组类型（WINDOW、DB_DEST、EXTERNAL_DEST）。 |
| member_name | 逗号分隔的成员列表，替换现有列表；要在现有列表上加成员用 ADD_GROUP_MEMBER。对应 CREATE_GROUP 的 member 参数。 |
| enabled | TRUE 则组已启用。 |
| comments | 关于组的可选注释。 |
| number_of_members | （仅 GET_ATTRIBUTE）组成员数。 |

**凭据属性值**（表 159-94，自 12.1 起对 SET_ATTRIBUTE/GET_ATTRIBUTE 已弃用，建议用 DBMS_CREDENTIAL 包的 UPDATE_CREDENTIAL 的 attribute 参数）：

| 名称 | 说明 |
|---|---|
| username | 登录主机 OS 或远程 Oracle 数据库的用户名，最大 64。 |
| password | 该用户名的口令，最大 128。 |
| comments | 凭据描述，最大 240。 |
| windows_domain | Windows 远程可执行目标时该用户所属域，最大 64。 |
| database_role | 用作登录远程数据库运行远程数据库作业的系统权限，取值 SYSDBA、SYSOPER。 |

**资源属性值**（表 159-95）：

| 名称 | 说明 |
|---|---|
| resource_name | 资源名。 |
| units | 作业或程序使用的该资源单元数。 |
| status | 资源状态：ENFORCE_CONSTRAINTS（默认，强制执行资源限制，达最大单元数后不再启动使用该资源的作业）；IGNORE_CONSTRAINTS（忽略该资源任何约束）；BLOCKED_ALL_JOBS（不允许有该资源约束的任何作业运行，视为永久阻塞直到切换到另两种状态）。 |
| constraint_level | 约束级别：JOB_LEVEL 或 PROGRAM_LEVEL。对不兼容项，JOB_LEVEL 时成员须为作业，PROGRAM_LEVEL 时成员须为程序。 |
| comments | 关于资源的描述性注释。 |

---

> 以上为 `DBMS_SCHEDULER` 包精译部分（概述 + 高级包/调度相关核心过程：CREATE_JOB、CREATE_PROGRAM、CREATE_SCHEDULE、DEFINE_PROGRAM_ARGUMENT、DISABLE、DROP_JOB、DROP_PROGRAM、ENABLE、RUN_JOB、SET_ATTRIBUTE、SET_JOB_ARGUMENT_VALUE、STOP_JOB、EVALUATE_CALENDAR_STRING）。其余过程后续按需补译。
