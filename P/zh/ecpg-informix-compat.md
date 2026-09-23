# 34.15. Informix 兼容模式

34.15. Informix 兼容模式
版本：
纠错本页面
搜索
目录导航
❮
❯
34.15. Informix 兼容模式 #34.15.1. 附加类型34.15.2. 附加的/缺少的嵌入式 SQL 语句34.15.3. Informix 兼容的 SQLDA 描述符区域34.15.4. 附加函数34.15.5. 附加常量
ecpg可以运行在一种所谓的Informix 兼容模式中。如果这种模式被激活，它的行为就好像它是一个用于Informix E/SQL 的Informix预编译器。一般而言，这将允许你使用美元符号替代EXEC SQL来引入嵌入式 SQL 命令：
$int j = 3;
$CONNECT TO :dbname;
$CREATE TABLE test(i INT PRIMARY KEY, j INT);
$INSERT INTO test(i, j) VALUES (7, :j);
$COMMIT;
注意
在$和下列之一的预处理器指令之间不能有任何空白：include、define、ifdef等。否则，预处理器将把记号解析成一个主变量。
有两种兼容性模式：INFORMIX、INFORMIX_SE
在链接使用这种兼容性模式的程序时，要记得链接上和 ECPG 一起发布的libcompat。
除了之前解释过的语法糖，Informix 兼容性模式从 E/SQL 中移植了一些用于输入、输出和数据转换的函数以及嵌入式 SQL 语句到 ECPG 中。
Informix 兼容模式与 ECPG 的 pgtypeslib 库密切相关。pgtypeslib 将 SQL 数据类型映射到 C 主机程序中的数据类型，
Informix 兼容模式的大多数附加功能允许您对这些 C 主机程序类型进行操作。但请注意，兼容性的范围是有限的。
它不会尝试复制 Informix 的行为；它允许您执行更多或更少相同的操作，并提供具有相同名称和相同基本行为的函数，
但如果您目前正在使用 Informix，它不是一个完全可替代的替代品。此外，一些数据类型是不同的。例如，
PostgreSQL 的日期时间和间隔类型不了解像 YEAR TO MINUTE 这样的范围，因此在 ECPG 中也找不到对其的支持。
34.15.1. 附加类型 #
用于存储右切边字符串数据的 Informix 特殊的 "string" 伪类型现在在 Informix 模式中不用typedef就能支持。事实上，在 Informix 模式中，ECPG 拒绝处理包含typedef sometype string;的源文件。
EXEC SQL BEGIN DECLARE SECTION;
string userid; /* 这个变量将包含修剪过的数据 */
EXEC SQL END DECLARE SECTION;
EXEC SQL FETCH MYCUR INTO :userid;
34.15.2. 附加的/缺少的嵌入式 SQL 语句 #
CLOSE DATABASE #
此语句关闭当前连接。实际上，这是 ECPG 的
DISCONNECT CURRENT 的同义词：
$CLOSE DATABASE;                /* 关闭当前连接 */
EXEC SQL CLOSE DATABASE;
FREE cursor_name #
由于 ECPG 的工作方式与 Informix 的 ESQL/C 不同（即哪些步骤是纯语法转换，
哪些步骤依赖于底层运行时库），ECPG 中没有 FREE cursor_name
语句。这是因为在 ECPG 中，DECLARE CURSOR 不会转换为对运行时库
的函数调用来使用游标名称。这意味着在 ECPG 运行时库中没有 SQL 游标的运行时记录，
只有在 PostgreSQL 服务器中才有。
FREE statement_name #
FREE statement_name 是
DEALLOCATE PREPARE statement_name 的同义词。
34.15.3. Informix 兼容的 SQLDA 描述符区域 #
Informix 兼容模式支持一种与第 34.7.2 节中所述不同的结构。如下：
struct sqlvar_compat
{
short   sqltype;
int     sqllen;
char   *sqldata;
short  *sqlind;
char   *sqlname;
char   *sqlformat;
short   sqlitype;
short   sqlilen;
char   *sqlidata;
int     sqlxid;
char   *sqltypename;
short   sqltypelen;
short   sqlownerlen;
short   sqlsourcetype;
char   *sqlownername;
int     sqlsourceid;
char   *sqlilongdata;
int     sqlflags;
void   *sqlreserved;
};
struct sqlda_compat
{
short  sqld;
struct sqlvar_compat *sqlvar;
char   desc_name[19];
short  desc_occ;
struct sqlda_compat *desc_next;
void  *reserved;
};
typedef struct sqlvar_compat    sqlvar_t;
typedef struct sqlda_compat     sqlda_t;
全局属性是：
sqld #
SQLDA 描述符中的字段数量。
sqlvar #
指向每个字段属性的指针。
desc_name #
未使用，填充为零字节。
desc_occ #
分配结构的大小。
desc_next #
指向下一个SQLDA结构的指针，如果结果集包含多于一条记录。
reserved #
未使用的指针，包含NULL。保留以保持与Informix的兼容性。
每个字段的属性如下，它们存储在sqlvar数组中：
sqltype #
字段的类型。常量在sqltypes.h中。
sqllen #
字段数据的长度。
sqldata #
指向字段数据的指针。该指针的类型为char *，它指向的数据
是二进制格式。示例：
int intval;
switch (sqldata->sqlvar[i].sqltype)
{
case SQLINTEGER:
intval = *(int *)sqldata->sqlvar[i].sqldata;
break;
...
}
sqlind #
指向NULL指示器的指针。如果由DESCRIBE或FETCH返回，则它始终是一个有效的指针。
如果作为EXECUTE ... USING sqlda;的输入使用，则NULL指针值表示
该字段的值为非NULL。否则，需要正确设置有效指针和sqlitype。
示例：
if (*(int2 *)sqldata->sqlvar[i].sqlind != 0)
printf("value is NULL\n");
sqlname #
字段的名称。以0结尾的字符串。
sqlformat #
在 Informix 中保留，字段的值为 PQfformat。
sqlitype #
NULL指示器数据的类型。从服务器返回数据时，它始终是SQLSMINT。
当SQLDA用于参数化查询时，数据将根据设置的类型进行处理。
sqlilen #
NULL指示器数据的长度。
sqlxid #
字段的扩展类型，结果来自PQftype。
sqltypenamesqltypelensqlownerlensqlsourcetypesqlownernamesqlsourceidsqlflagssqlreserved #
未使用。
sqlilongdata #
如果sqllen大于32kB，则等于sqldata。
示例:
EXEC SQL INCLUDE sqlda.h;
sqlda_t        *sqlda; /* This doesn't need to be under embedded DECLARE SECTION */
EXEC SQL BEGIN DECLARE SECTION;
char *prep_stmt = "select * from table1";
int i;
EXEC SQL END DECLARE SECTION;
...
EXEC SQL PREPARE mystmt FROM :prep_stmt;
EXEC SQL DESCRIBE mystmt INTO sqlda;
printf("# of fields: %d\n", sqlda->sqld);
for (i = 0; i < sqlda->sqld; i++)
printf("field %d: \"%s\"\n", sqlda->sqlvar[i]->sqlname);
EXEC SQL DECLARE mycursor CURSOR FOR mystmt;
EXEC SQL OPEN mycursor;
EXEC SQL WHENEVER NOT FOUND GOTO out;
while (1)
{
EXEC SQL FETCH mycursor USING sqlda;
}
EXEC SQL CLOSE mycursor;
free(sqlda); /* The main structure is all to be free(),
* sqlda and sqlda->sqlvar is in one allocated area */
For more information, see the sqlda.h header and the
src/interfaces/ecpg/test/compat_informix/sqlda.pgc regression test.
34.15.4. 附加函数 #
decadd #
添加两个十进制类型的值。
int decadd(decimal *arg1, decimal *arg2, decimal *sum);
该函数接收一个指向十进制类型第一个操作数的指针
(arg1)，一个指向十进制类型第二个操作数的指针
(arg2)，以及一个指向将包含和的十进制类型值的指针
(sum)。成功时，函数返回0。
溢出时返回ECPG_INFORMIX_NUM_OVERFLOW，
下溢时返回ECPG_INFORMIX_NUM_UNDERFLOW。
其他故障返回-1，并将errno设置为相应的errno编号。
deccmp #
比较两个十进制类型的变量。
int deccmp(decimal *arg1, decimal *arg2);
该函数接收第一个十进制值的指针
(arg1)，第二个十进制值的指针
(arg2)，并返回一个整数值，指示哪个值更大。
1，如果arg1指向的值大于arg2指向的值
-1，如果arg1指向的值小于arg2指向的值
0，如果arg1指向的值和arg2指向的值相等
deccopy #
复制一个十进制值。
void deccopy(decimal *src, decimal *target);
该函数接收应该被复制的十进制值的指针作为第一个参数（src），
并将目标类型为十进制的结构体的指针作为第二个参数（target）。
deccvasc #
将一个值从其ASCII表示转换为十进制类型。
int deccvasc(char *cp, int len, decimal *np);
该函数接收一个指向包含要转换的数字的字符串表示的指针（cp），
以及它的长度len。 np是一个指向保存操作结果的十进制值的指针。
例如，有效的格式包括：
-2,
.794,
+3.44,
592.49E07 或
-32.84e-4。
该函数成功返回0。如果发生溢出或下溢，则返回ECPG_INFORMIX_NUM_OVERFLOW或
ECPG_INFORMIX_NUM_UNDERFLOW。如果ASCII表示无法解析，
则返回ECPG_INFORMIX_BAD_NUMERIC，或者如果在解析指数时出现问题，则返回
ECPG_INFORMIX_BAD_EXPONENT。
deccvdbl #
将double类型的值转换为decimal类型的值。
int deccvdbl(double dbl, decimal *np);
该函数接收应该被转换的double类型变量作为其第一个参数（dbl）。
作为第二个参数（np），该函数接收一个指向应该保存操作结果的decimal变量的指针。
该函数在成功时返回0，在转换失败时返回负值。
deccvint #
将int类型的值转换为decimal类型的值。
int deccvint(int in, decimal *np);
该函数接收应该被转换的int类型变量作为其第一个参数（in）。
作为第二个参数（np），该函数接收一个指向应该保存操作结果的decimal变量的指针。
该函数在成功时返回0，在转换失败时返回负值。
deccvlong #
将类型为long的值转换为类型为decimal的值。
int deccvlong(long lng, decimal *np);
该函数接收应该被转换的类型为long的变量作为其第一个参数（lng）。
作为第二个参数（np），该函数接收一个指向应该保存操作结果的decimal变量的指针。
该函数在成功时返回0，在转换失败时返回负值。
decdiv #
将两个decimal类型的变量相除。
int decdiv(decimal *n1, decimal *n2, decimal *result);
该函数接收指向第一个（n1）和第二个（n2）操作数的变量的指针，
并计算n1/n2。 result是一个指向应该保存操作结果的变量的指针。
在成功时返回0，如果除法失败则返回负值。
如果发生溢出或下溢，则函数分别返回
ECPG_INFORMIX_NUM_OVERFLOW或
ECPG_INFORMIX_NUM_UNDERFLOW。如果尝试
除以零，则函数返回ECPG_INFORMIX_DIVIDE_ZERO。
decmul #
将两个decimal值相乘。
int decmul(decimal *n1, decimal *n2, decimal *result);
该函数接收指向第一个（n1）和第二个（n2）操作数的变量的指针，
并计算n1*n2。 result是一个指向应该保存操作结果的变量的指针。
在成功时返回0，如果乘法失败则返回负值。如果发生溢出或下溢，函数分别返回
ECPG_INFORMIX_NUM_OVERFLOW或
ECPG_INFORMIX_NUM_UNDERFLOW。
decsub #
从一个decimal值中减去另一个decimal值。
int decsub(decimal *n1, decimal *n2, decimal *result);
该函数接收指向第一个（n1）和第二个（n2）操作数的变量的指针，
并计算n1-n2。 result是一个指向应该保存操作结果的变量的指针。
在成功时返回0，如果减法失败则返回负值。如果发生溢出或下溢，函数分别返回
ECPG_INFORMIX_NUM_OVERFLOW或
ECPG_INFORMIX_NUM_UNDERFLOW。
dectoasc #
将decimal类型的变量转换为C char*字符串中的ASCII表示。
int dectoasc(decimal *np, char *cp, int len, int right)
该函数接收一个指向decimal类型变量的指针（np），将其转换为文本表示。
cp是一个应该保存操作结果的缓冲区。参数right指定输出中小数点右侧应包含的位数。
结果将四舍五入到这个小数位数。将right设置为-1表示应在输出中包含所有可用的小数位数。
如果输出缓冲区的长度，由len指示，不足以容纳包括尾随零字节在内的文本表示，
则结果中仅存储一个*字符，并返回-1。
该函数返回-1，如果缓冲区cp太小，或者返回ECPG_INFORMIX_OUT_OF_MEMORY，
如果内存耗尽。
dectodbl #
将类型为decimal的变量转换为double类型。
int dectodbl(decimal *np, double *dblp);
该函数接收一个指向要转换的decimal值的指针
(np)，以及一个指向应该保存操作结果的double变量的指针
(dblp)。
当成功时，返回0；如果转换失败，则返回负值。
dectoint #
将类型为decimal的变量转换为整数。
int dectoint(decimal *np, int *ip);
该函数接收一个指向要转换的decimal值的指针
(np)，以及一个指向应该保存操作结果的整数变量的指针
(ip)。
当成功时，返回0；如果转换失败，则返回负值。如果发生溢出，将返回ECPG_INFORMIX_NUM_OVERFLOW。
请注意，ECPG实现与Informix实现不同。
Informix将整数限制在-32767到32767的范围内，
而ECPG实现中的限制取决于架构（INT_MIN .. INT_MAX）。
dectolong #
将类型为decimal的变量转换为长整型。
int dectolong(decimal *np, long *lngp);
该函数接收一个指向要转换的decimal值的指针
(np)，以及一个指向应该保存操作结果的长整型变量的指针
(lngp)。
当成功时，返回0；如果转换失败，则返回负值。如果发生溢出，将返回ECPG_INFORMIX_NUM_OVERFLOW。
请注意，ECPG实现与Informix实现不同。
Informix将长整型限制在-2,147,483,647到2,147,483,647的范围内，
而ECPG实现中的限制取决于架构（-LONG_MAX .. LONG_MAX）。
rdatestr #
将日期转换为C char*字符串。
int rdatestr(date d, char *str);
该函数接收两个参数，第一个是要转换的日期（d），第二个是指向目标字符串的指针。
输出格式始终为yyyy-mm-dd，因此您需要为字符串分配至少11个字节（包括零字节终止符）。
该函数在成功时返回0，在错误时返回负值。
请注意，ECPG的实现与Informix的实现不同。在Informix中，
格式可以通过设置环境变量来影响。然而，在ECPG中，您无法更改输出格式。
rstrdate #
解析日期的文本表示。
int rstrdate(char *str, date *d);
该函数接收要转换的日期的文本表示（str）和指向类型为date的变量的指针
（d）。此函数不允许您指定格式掩码。它使用Informix的默认格式掩码，
即mm/dd/yyyy。在内部，此函数通过rdefmtdate实现。
因此，rstrdate不会更快，如果可以选择，应选择允许您显式指定格式掩码的
rdefmtdate。
该函数返回与rdefmtdate相同的值。
rtoday #
获取当前日期。
void rtoday(date *d);
该函数接收一个指向日期变量（d）的指针，将其设置为当前日期。
在内部，此函数使用PGTYPESdate_today函数。
rjulmdy #
从一个类型为date的变量中提取日、月和年的值。
int rjulmdy(date d, short mdy[3]);
该函数接收日期d和一个指向包含3个short整数值的数组mdy的指针。
变量名指示了顺序：mdy[0]将被设置为包含月份的数字，
mdy[1]将被设置为日期的值，mdy[2]将包含年份。
该函数目前总是返回0。
在内部，该函数使用PGTYPESdate_julmdy函数。
rdefmtdate #
使用格式掩码将字符字符串转换为日期类型的值。
int rdefmtdate(date *d, char *fmt, char *str);
该函数接收一个指向应该保存操作结果的日期值的指针（d），
用于解析日期的格式掩码（fmt）和包含日期文本表示的C char*字符串
（str）。文本表示应与格式掩码匹配。但是，您不需要将字符串
与格式掩码进行一一映射。该函数仅分析顺序，并查找表示年份位置的文字
yy或yyyy，表示月份位置的mm
和表示日期位置的dd。
该函数返回以下值:
0 - 函数成功终止。
ECPG_INFORMIX_ENOSHORTDATE - 日期不包含
日、月和年之间的分隔符。在这种情况下，输入
字符串必须恰好为6或8个字节长，但实际不是。
ECPG_INFORMIX_ENOTDMY - 格式字符串未正确指示
年、月和日的顺序。
ECPG_INFORMIX_BAD_DAY - 输入字符串不包含
有效的日。
ECPG_INFORMIX_BAD_MONTH - 输入字符串不包含
有效的月。
ECPG_INFORMIX_BAD_YEAR - 输入字符串不包含
有效的年。
在内部，此函数实现为使用PGTYPESdate_defmt_asc函数。请参阅那里的参考，了解示例输入表。
rfmtdate #
将日期类型的变量使用格式掩码转换为其文本表示形式。
int rfmtdate(date d, char *fmt, char *str);
该函数接收要转换的日期（d）、格式掩码（fmt）和将保存日期文本表示的字符串（str）。
成功时返回0，发生错误时返回负值。
在内部，此函数使用PGTYPESdate_fmt_asc函数，有关示例，请参阅那里的参考。
rmdyjul #
从一个包含3个短整数的数组创建一个日期值，这些整数指定了日期的日、月和年。
int rmdyjul(short mdy[3], date *d);
该函数接收一个包含3个短整数的数组（mdy）和一个指向应该保存操作结果的date类型变量的指针。
目前该函数始终返回0。
在内部，该函数实现为使用函数PGTYPESdate_mdyjul。
rdayofweek #
返回表示日期值的星期几的数字。
int rdayofweek(date d);
该函数接收日期变量d作为其唯一参数，并返回一个整数，表示该日期的星期几。
0 - 星期日
1 - 星期一
2 - 星期二
3 - 星期三
4 - 星期四
5 - 星期五
6 - 星期六
在内部，该函数实现为使用函数PGTYPESdate_dayofweek。
dtcurrent #
检索当前时间戳。
void dtcurrent(timestamp *ts);
该函数检索当前时间戳，并将其保存到ts指向的时间戳变量中。
dtcvasc #
将时间戳从其文本表示解析为时间戳变量。
int dtcvasc(char *str, timestamp *ts);
该函数接收要解析的字符串（str）和指向应该保存操作结果的时间戳变量的指针（ts）。
该函数在成功时返回0，在错误时返回负值。
在内部，此函数使用PGTYPEStimestamp_from_asc函数。请参阅那里的参考资料，了解包含示例输入的表格。
dtcvfmtasc #
从文本表示中使用格式掩码解析时间戳为时间戳变量。
dtcvfmtasc(char *inbuf, char *fmtstr, timestamp *dtvalue)
该函数接收要解析的字符串（inbuf）、要使用的格式掩码
（fmtstr）以及应该保存操作结果的时间戳变量的指针
（dtvalue）。
这个函数是通过PGTYPEStimestamp_defmt_asc函数实现的。请参阅那里的文档，了解可用的格式说明符列表。
该函数在成功时返回0，在错误时返回负值。
dtsub #
从一个时间戳减去另一个时间戳，并返回一个间隔类型的变量。
int dtsub(timestamp *ts1, timestamp *ts2, interval *iv);
该函数将从ts1指向的时间戳变量中减去ts2指向的时间戳变量，
并将结果存储在iv指向的间隔变量中。
当成功时，该函数返回0，如果发生错误则返回负值。
dttoasc #
将时间戳变量转换为C char*字符串。
int dttoasc(timestamp *ts, char *output);
该函数接收一个指向要转换的时间戳变量的指针
(ts)和应该保存操作结果的字符串
(output)。它根据SQL标准将ts转换为其
文本表示，格式为YYYY-MM-DD HH:MM:SS。
当成功时，该函数返回0，如果发生错误则返回负值。
dttofmtasc #
将时间戳变量转换为C char*，使用格式掩码。
int dttofmtasc(timestamp *ts, char *output, int str_len, char *fmtstr);
该函数接收一个指向要转换的时间戳的指针作为第一个参数（ts），
一个指向输出缓冲区的指针（output），
为输出缓冲区分配的最大长度（str_len），
以及用于转换的格式掩码（fmtstr）。
当成功时，该函数返回0，如果发生错误则返回负值。
在内部，此函数使用PGTYPEStimestamp_fmt_asc函数。请参阅那里的参考资料，了解可以使用哪些格式掩码说明符。
intoasc #
将一个区间变量转换为C char*字符串。
int intoasc(interval *i, char *str);
该函数接收一个指向要转换的区间变量的指针
(i)和应该保存操作结果的字符串
(str)。它根据SQL标准将i转换为其文本表示，
即YYYY-MM-DD HH:MM:SS。
当成功时，该函数返回0，如果发生错误则返回负值。
rfmtlong #
将长整型值使用格式掩码转换为其文本表示形式。
int rfmtlong(long lng_val, char *fmt, char *outbuf);
该函数接收长整型值lng_val，格式掩码fmt和指向输出缓冲区outbuf的指针。
它根据格式掩码将长整型值转换为其文本表示形式。
格式掩码可以由以下格式指定字符组成：
*（星号）- 如果此位置为空白，用星号填充。
&（和号）- 如果此位置为空白，用零填充。
# - 将前导零转换为空格。
< - 将数字左对齐在字符串中。
,（逗号）- 将四位或更多位数的数字分组为以逗号分隔的三位数组。
.（句点）- 此字符将整数部分与小数部分分隔开。
-（减号）- 如果数字是负值，则显示减号。
+（加号）- 如果数字是正值，则显示加号。
( - 这个字符替换负数前面的减号。减号不会显示。
) - 这个字符替换减号，并打印在负值后面。
$ - 货币符号。
rupshift #
将字符串转换为大写。
void rupshift(char *str);
该函数接收一个指向字符串的指针，并将每个小写字符转换为大写。
byleng #
返回字符串中字符的数量，不包括末尾的空格。
int byleng(char *str, int len);
该函数期望一个固定长度的字符串作为第一个参数
(str)，并将其长度作为第二个参数
(len)。它返回有效字符的数量，即不包括末尾空格的字符串长度。
ldchar #
将固定长度的字符串复制到以空字符结尾的字符串中。
void ldchar(char *src, int len, char *dest);
该函数接收要复制的固定长度字符串（src）、其长度（len）和指向目标内存的指针（dest）。
请注意，您需要为dest指向的字符串保留至少len+1字节。
该函数最多复制len字节到新位置（如果源字符串具有尾随空格，则会少一些），并添加空字符终止符。
rgetmsg #
int rgetmsg(int msgnum, char *s, int maxsize);
这个函数存在，但目前尚未实现！
rtypalign #
int rtypalign(int offset, int type);
这个函数存在，但目前尚未实现！
rtypmsize #
int rtypmsize(int type, int len);
这个函数存在，但目前尚未实现！
rtypwidth #
int rtypwidth(int sqltype, int sqllen);
这个函数存在，但目前尚未实现！
rsetnull #
将一个变量设置为NULL。
int rsetnull(int t, char *ptr);
该函数接收一个整数，表示变量的类型，以及一个指向变量本身的指针，该指针被转换为C中的char*指针。
下列类型存在：
CCHARTYPE - 用于char或char*类型的变量
CSHORTTYPE - 用于short int类型的变量
CINTTYPE - 用于int类型的变量
CBOOLTYPE - 用于boolean类型的变量
CFLOATTYPE - 用于float类型的变量
CLONGTYPE - 用于long类型的变量
CDOUBLETYPE - 用于double类型的变量
CDECIMALTYPE - 用于decimal类型的变量
CDATETYPE - 用于date类型的变量
CDTIMETYPE - 用于timestamp类型的变量
这是调用此函数的示例：
$char c[] = "abc       ";
$short s = 17;
$int i = -74874;
rsetnull(CCHARTYPE, (char *) c);
rsetnull(CSHORTTYPE, (char *) &s);
rsetnull(CINTTYPE, (char *) &i);
risnull #
测试变量是否为NULL。
int risnull(int t, char *ptr);
该函数接收要测试的变量类型（t）以及指向该变量的指针（ptr）。
请注意，后者需要转换为char*。查看函数rsetnull以获取可能的变量类型列表。
这是如何使用这个函数的示例：
$char c[] = "abc       ";
$short s = 17;
$int i = -74874;
risnull(CCHARTYPE, (char *) c);
risnull(CSHORTTYPE, (char *) &s);
risnull(CINTTYPE, (char *) &i);
34.15.5. 附加常量 #
请注意，这里的所有常量都描述错误，并且它们都被定义为表示负值。在不同常量
的描述中，您还可以找到这些常量在当前实现中所代表的值。然而，您不应该依赖
这个数字。不过，您可以依赖这样一个事实：它们都被定义为表示负值。
ECPG_INFORMIX_NUM_OVERFLOW #
如果在计算中发生溢出，函数将返回此值。在内部，它被定义为-1200
(Informix定义)。
ECPG_INFORMIX_NUM_UNDERFLOW #
如果计算中发生下溢，函数将返回此值。
在内部，它被定义为-1201（Informix定义）。
ECPG_INFORMIX_DIVIDE_ZERO #
如果观察到尝试除以零，函数将返回此值。在内部，它被定义为-1202
(Informix定义)。
ECPG_INFORMIX_BAD_YEAR #
如果在解析日期时发现年份值无效，函数将返回此值。在内部，它被定义为
-1204（Informix定义）。
ECPG_INFORMIX_BAD_MONTH #
如果在解析日期时发现月份的值无效，函数将返回此值。在内部，它被定义为
-1205（Informix定义）。
ECPG_INFORMIX_BAD_DAY #
如果在解析日期时发现了一个无效的日期值，函数将返回此值。在内部，它被定义为
-1206（Informix定义）。
ECPG_INFORMIX_ENOSHORTDATE #
如果解析例程需要一个短日期表示但未获得正确长度的日期字符串，
函数将返回此值。在内部，它被定义为-1209（Informix
定义）。
ECPG_INFORMIX_DATE_CONVERT #
如果在日期格式化期间发生错误，函数将返回此值。在内部，它被定义为-1210
（Informix定义）。
ECPG_INFORMIX_OUT_OF_MEMORY #
如果在操作期间内存耗尽，函数将返回此值。在内部，它被定义为-1211
（Informix定义）。
ECPG_INFORMIX_ENOTDMY #
如果解析例程应该获取格式掩码（例如mmddyy），但并未正确列出
所有字段，则函数将返回此值。在内部，它被定义为-1212（Informix
定义）。
ECPG_INFORMIX_BAD_NUMERIC #
函数返回此值的情况包括：如果解析例程无法解析数字值的文本表示，
因为它包含错误；或者如果例程无法完成涉及数字变量的计算，
因为至少有一个数字变量无效。在内部，它被定义为-1213（
Informix定义）。
ECPG_INFORMIX_BAD_EXPONENT #
如果解析程序无法解析指数，函数将返回此值。内部定义为-1216
(Informix定义)。
ECPG_INFORMIX_BAD_DATE #
如果解析程序无法解析日期，函数将返回此值。内部定义为-1218
(Informix定义)。
ECPG_INFORMIX_EXTRA_CHARS #
如果解析例程传递了无法解析的额外字符，函数将返回此值。
在内部，它被定义为-1264（Informix定义）。
上一页 上一级 下一页WHENEVER 起始页 34.16. Oracle 兼容模式
