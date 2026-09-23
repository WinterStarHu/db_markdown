# 34.4. 使用主变量

34.4. 使用主变量
版本：
纠错本页面
搜索
目录导航
❮
❯
34.4. 使用主变量 #34.4.1. 概述34.4.2. 声明节34.4.3. 检索查询结果34.4.4. 类型映射34.4.5. 处理非原始 SQL 数据类型34.4.6. 指示符
在第 34.3 节中，你了解了如何从一个嵌入式 SQL 程序执行 SQL 语句。某些那种语句只使用固定值并且没有提供方法来插入用户提供的值到语句中或者让程序处理查询返回的值。那种语句在实际应用中其实没有什么用处。这一节详细解释了如何使用一种简单的机制（主变量）在 C 程序和嵌入式 SQL 语句之间传递数据。在一个嵌入式 SQL 程序中，我们认为 SQL 语句是 C 程序代码中的客人，而 C 代码是主语言。因此 C 程序的变量被称为主变量。
另一种在 PostgreSQL 后端和 ECPG 应用之间交换值的方式是使用 SQL 描述符，它在第 34.7 节中介绍。
34.4.1. 概述 #
在嵌入式 SQL 中进行 C 程序和 SQL 语句之间的数据传递特别简单。我们不需要让程序把数据粘贴到语句中（这会导致很多复杂性，例如正确地引用值），我们可以简单地在 SQL 语句中写 C 变量的名称，只要在它前面放上一个冒号。例如：
EXEC SQL INSERT INTO sometable VALUES (:v1, 'foo', :v2);
这个语句引用了两个 C 变量（名为v1和v2）并且还使用了一个常规的 SQL 字符串字面量，以说明你没有被限制于使用某一种数据。
这种在 SQL 语句中插入 C 变量的风格可以用在 SQL 语句中任何应该出现值表达式的地方。
34.4.2. 声明节 #
要从程序传递数据给数据库（例如作为一个查询的参数）或者从数据库传数据回程序，用于包含这些数据的 C 变量必须在特别标记的节中被声明，这样嵌入式 SQL 预处理器才会注意到它们。
这个节开始于：
EXEC SQL BEGIN DECLARE SECTION;
并且结束于：
EXEC SQL END DECLARE SECTION;
在这两行之间，必须是正常的 C 变量声明，例如：
int   x = 4;
char  foo[16], bar[16];
如你所见，你可以选择为变量赋一个初始值。变量的作用域由定义它的节在程序中的位置决定。你也可以使用下面的语法声明变量，这种语法将会隐式地创建一个声明节：
EXEC SQL int i = 4;
你可以在一个程序中放置任意数量的声明节。
这些声明也会作为正常的 C 变量被重复在输出文件中，因此无需再次声明它们。不准备在 SQL 命令中使用的变量可以正常地在这些特殊节之外声明。
一个结构或联合的定义也必须被列在一个DECLARE节中。否则预处理器无法处理这些类型，因为它不知道它们的定义。
34.4.3. 检索查询结果 #
现在你应该能够把程序产生的数据传递到一个 SQL 命令中了。但是怎么检索一个查询的结果呢？为此，嵌入式 SQL 提供了常规命令SELECT和FETCH的特殊变体。这些命令有一个特殊的INTO子句，它指定被检索到的值要被存储在哪些主变量中。SELECT被用于只返回单行的查询，而FETCH被用于使用一个游标返回多行的查询。
这里是一个例子：
/*
* assume this table:
* CREATE TABLE test1 (a int, b varchar(50));
*/
EXEC SQL BEGIN DECLARE SECTION;
int v1;
VARCHAR v2;
EXEC SQL END DECLARE SECTION;
...
EXEC SQL SELECT a, b INTO :v1, :v2 FROM test;
那么INTO子句出现在选择列表和FROM子句之间。选择列表中的元素数量必须和INTO后面列表（也被称为目标列表）的元素数量相等。
这里有一个使用命令FETCH的例子：
EXEC SQL BEGIN DECLARE SECTION;
int v1;
VARCHAR v2;
EXEC SQL END DECLARE SECTION;
...
EXEC SQL DECLARE foo CURSOR FOR SELECT a, b FROM test;
...
do
{
...
EXEC SQL FETCH NEXT FROM foo INTO :v1, :v2;
...
} while (...);
这里INTO子句出现在所有正常子句的后面。
34.4.4. 类型映射 #
当 ECPG 应用在 PostgreSQL 服务器和 C 应用之间交换值时（例如从服务器检索查询结果时或者用输入参数执行 SQL 语句时），值需要在 PostgreSQL 数据类型和主语言变量类型（具体来说是 C 语言数据类型）之间转换。ECPG 的要点之一就是它会在大多数情况下自动处理这种转换。
在这方面有两类数据类型：一些简单 PostgreSQL 数据类型（例如integer和text）可以被应用直接读取和写入。其他 PostgreSQL 数据类型（例如timestamp和numeric）只能通过特殊库函数访问，见第 34.4.4.2 节。
表 34.1展示了哪种 PostgreSQL 数据类型对应于哪一种 C 数据类型。当你希望发送或接收一种给定 PostgreSQL 数据类型的值时，你应该在声明节中声明一个具有相应 C 数据类型的 C 变量。
表 34.1. 在 PostgreSQL 数据类型和 C 变量类型之间映射PostgreSQL 数据类型主机变量类型smallintshortintegerintbigintlong long intdecimaldecimal[a]numericnumeric[a]realfloatdouble precisiondoublesmallserialshortserialintbigseriallong long intoidunsigned intcharacter(n), varchar(n), textchar[n+1], VARCHAR[n+1]namechar[NAMEDATALEN]timestamptimestamp[a]intervalinterval[a]datedate[a]booleanbool[b]byteachar *, bytea[n][a] 这种类型只能通过特殊的库函数访问，见第 34.4.4.2 节。[b] 如果不是本地类型，则声明在ecpglib.h中34.4.4.1. 处理字符字符串 #
要处理 SQL 字符串数据类型，例如varchar和text，有两种可能的方式来声明主机变量。
一种方式是使用char[]，一个char数组，这是在 C 中处理字符数据最常见的方式。
EXEC SQL BEGIN DECLARE SECTION;
char str[50];
EXEC SQL END DECLARE SECTION;
注意你必须自己照看长度。如果你把这个主变量用作一个查询的目标变量并且该查询返回超过 49 个字符的字符串，那么将会发生缓冲区溢出。
另一种方式是使用VARCHAR类型，它是 ECPG 提供的一种特殊类型。在一个VARCHAR类型数组上的定义会被转变成一个命名的struct。这样一个声明：
VARCHAR var[180];
会被转变成：
struct varchar_var { int len; char arr[180]; } var;
成员arr容纳包含一个终止零字节的字符串。因此，要在一个VARCHAR主变量中存储一个字符串，该主变量必须被声明为具有包括零字节终止符的长度。成员len保存存储在arr中的字符串的长度，不包括终止零字节。当一个主变量被用作一个查询的输入时，如果strlen(arr)和len不同，将使用短的那一个。
VARCHAR可以被写成大写或小写形式，但是不能混合大小写。
char和VARCHAR主变量也可以保存其他 SQL 类型的值，它们将被存储为字符串形式。
34.4.4.2. 访问特殊数据类型 #
ECPG 包含一些特殊类型，帮助你容易地与来自 PostgreSQL 服务器的一些特殊数据类型交互。特别地，它已经实现了对于numeric、decimal、date、timestamp以及interval类型的支持。这些数据类型无法有效地被映射到原始的主变量类型（例如int、long long int或者char[]），因为它们有一种复杂的内部结构。应用通过声明特殊类型的主变量以及使用 pgtypes 库中的函数来处理这些类型。pgtypes 库（在第 34.6 节中详细描述）包含了处理这些类型的基本函数，这样你不需要仅仅为了给一个时间戳增加一个时段而发送一个查询给 SQL 服务器。
下面的小节描述了这些特殊数据类型。关于 pgtypes 库函数的更多细节，请参考第 34.6 节。
34.4.4.2.1. timestamp, date #
这里有一种在 ECPG 主应用中处理 timestamp 变量的模式。
首先，程序必须包括用于 timestamp 类型的头文件：
#include <pgtypes_timestamp.h>
接着，在声明节中声明一个主变量为类型 timestamp：
EXEC SQL BEGIN DECLARE SECTION;
timestamp ts;
EXEC SQL END DECLARE SECTION;
并且在读入一个值到该主变量中之后，使用 pgtypes 库函数处理它。在下面的例子中，timestamp 值被 PGTYPEStimestamp_to_asc() 函数转变成文本（ASCII）形式：
EXEC SQL SELECT now()::timestamp INTO :ts;
printf("ts = %s\n", PGTYPEStimestamp_to_asc(ts));
这个例子将展示像下面形式的一些结果：
ts = 2010-06-27 18:03:56.949343
另外，DATE 类型可以用相同的方式处理。程序必须包括 pgtypes_date.h，声明一个主变量为日期类型并且将一个 DATE 值使用 PGTYPESdate_to_asc() 函数转变成一种文本形式。关于 pgtypes 库函数的更多细节，请参考 第 34.6 节。
34.4.4.2.2. interval #
对 interval 类型的处理也类似于 timestamp 和 date 类型。不过，必须显式为一个 interval 类型分配内存。换句话说，该变量的内存空间必须在堆内存中分配，而不是在栈内存中分配。
这里是一个例子程序：
#include <stdio.h>
#include <stdlib.h>
#include <pgtypes_interval.h>
int
main(void)
{
EXEC SQL BEGIN DECLARE SECTION;
interval *in;
EXEC SQL END DECLARE SECTION;
EXEC SQL CONNECT TO testdb;
EXEC SQL SELECT pg_catalog.set_config('search_path', '', false); EXEC SQL COMMIT;
in = PGTYPESinterval_new();
EXEC SQL SELECT '1 min'::interval INTO :in;
printf("interval = %s\n", PGTYPESinterval_to_asc(in));
PGTYPESinterval_free(in);
EXEC SQL COMMIT;
EXEC SQL DISCONNECT ALL;
return 0;
}
34.4.4.2.3. numeric, decimal #
numeric和decimal类型的处理类似于interval类型：需要定义一个指针、在堆上分配一些内存空间并且使用 pgtypes 库函数访问该变量。关于 pgtypes 库函数的更多细节，请参考第 34.6 节。
pgtypes 库没有特别为decimal类型提供函数。一个应用必须使用一个 pgtypes 库函数把它转变成numeric变量以便进一步处理。
这里是一个处理numeric和decimal类型变量的例子程序。
#include <stdio.h>
#include <stdlib.h>
#include <pgtypes_numeric.h>
EXEC SQL WHENEVER SQLERROR STOP;
int
main(void)
{
EXEC SQL BEGIN DECLARE SECTION;
numeric *num;
numeric *num2;
decimal *dec;
EXEC SQL END DECLARE SECTION;
EXEC SQL CONNECT TO testdb;
EXEC SQL SELECT pg_catalog.set_config('search_path', '', false); EXEC SQL COMMIT;
num = PGTYPESnumeric_new();
dec = PGTYPESdecimal_new();
EXEC SQL SELECT 12.345::numeric(4,2), 23.456::decimal(4,2) INTO :num, :dec;
printf("numeric = %s\n", PGTYPESnumeric_to_asc(num, 0));
printf("numeric = %s\n", PGTYPESnumeric_to_asc(num, 1));
printf("numeric = %s\n", PGTYPESnumeric_to_asc(num, 2));
/* 将一个decimal转变成numeric以显示一个decimal值。 */
num2 = PGTYPESnumeric_new();
PGTYPESnumeric_from_decimal(dec, num2);
printf("decimal = %s\n", PGTYPESnumeric_to_asc(num2, 0));
printf("decimal = %s\n", PGTYPESnumeric_to_asc(num2, 1));
printf("decimal = %s\n", PGTYPESnumeric_to_asc(num2, 2));
PGTYPESnumeric_free(num2);
PGTYPESdecimal_free(dec);
PGTYPESnumeric_free(num);
EXEC SQL COMMIT;
EXEC SQL DISCONNECT ALL;
return 0;
}
34.4.4.2.4. bytea #
bytea类型的处理与VARCHAR相似。
类型bytea的数组上的定义被转换为每个变量的命名结构。声明类似于：
bytea var[180];
is converted into:
struct bytea_var { int len; char arr[180]; } var;
成员 arr 承载二进制格式数据。
不像VARCHAR，它还可以作为数据的一部分处理 '\0' 。
数据往/来转换为十六进制格式，并通过 ecpglib 发送/接收。
注意
bytea 变量只有在 bytea_output 被设置为 hex时才能够使用。
34.4.4.3. 非简单类型的主变量 #
你也可以把数组、typedef、结构和指针用作主变量。
34.4.4.3.1. 数组 #
将数组用作主变量有两种情况。第一种如第 34.4.4.1 节所述，是一种将一些文本字符串存储在char[]或VARCHAR[]中的方法。第二种是不用游标从查询结果中检索多行。如果没有数组，要处理由多行组成的查询结果，我们需要使用游标以及FETCH命令。但是使用数组主变量，多个行可以被一次接收。该数组的长度必须被定义成足以容纳所有的行，否则很可能会发生缓冲区溢出。
下面的例子扫描pg_database系统表并且显示所有可用数据库的 OID 和名称：
int
main(void)
{
EXEC SQL BEGIN DECLARE SECTION;
int dbid[8];
char dbname[8][16];
int i;
EXEC SQL END DECLARE SECTION;
memset(dbname, 0, sizeof(char)* 16 * 8);
memset(dbid, 0, sizeof(int) * 8);
EXEC SQL CONNECT TO testdb;
EXEC SQL SELECT pg_catalog.set_config('search_path', '', false); EXEC SQL COMMIT;
/* 一次检索多行到数组中。 */
EXEC SQL SELECT oid,datname INTO :dbid, :dbname FROM pg_database;
for (i = 0; i < 8; i++)
printf("oid=%d, dbname=%s\n", dbid[i], dbname[i]);
EXEC SQL COMMIT;
EXEC SQL DISCONNECT ALL;
return 0;
}
这个例子显示下面的结果（确切的值取决于本地环境）。
oid=1, dbname=template1
oid=11510, dbname=template0
oid=11511, dbname=postgres
oid=313780, dbname=testdb
oid=0, dbname=
oid=0, dbname=
oid=0, dbname=
34.4.4.3.2. 结构 #
一个成员名称匹配查询结果列名的结构可以被用来一次检索多列。该结构使得我们能够在一个单一主变量中处理多列值。
下面的例子从pg_database系统表以及使用pg_database_size()函数检索可用数据库的 OID、名称和大小。在这个例子中，一个成员名匹配SELECT结果的每一列的结构变量dbinfo_t被用来检索结果行，而不需要把多个主变量放在FETCH语句中。
EXEC SQL BEGIN DECLARE SECTION;
typedef struct
{
int oid;
char datname[65];
long long int size;
} dbinfo_t;
dbinfo_t dbval;
EXEC SQL END DECLARE SECTION;
memset(&dbval, 0, sizeof(dbinfo_t));
EXEC SQL DECLARE cur1 CURSOR FOR SELECT oid, datname, pg_database_size(oid) AS size FROM pg_database;
EXEC SQL OPEN cur1;
/* 在达到结果集末尾时，跳出 while 循环 */
EXEC SQL WHENEVER NOT FOUND DO BREAK;
while (1)
{
/* 将多列取到一个结构中。 */
EXEC SQL FETCH FROM cur1 INTO :dbval;
/* 打印该结构的成员。 */
printf("oid=%d, datname=%s, size=%lld\n", dbval.oid, dbval.datname, dbval.size);
}
EXEC SQL CLOSE cur1;
这个例子会显示下列结果（确切的值取决于本地环境）。
oid=1, datname=template1, size=4324580
oid=11510, datname=template0, size=4243460
oid=11511, datname=postgres, size=4324580
oid=313780, datname=testdb, size=8183012
结构主变量将列尽数“吸收”成结构的域。额外的列可以被分配给其他主变量。例如，上面的程序也可以使用结构外部的size变量重新构造：
EXEC SQL BEGIN DECLARE SECTION;
typedef struct
{
int oid;
char datname[65];
} dbinfo_t;
dbinfo_t dbval;
long long int size;
EXEC SQL END DECLARE SECTION;
memset(&dbval, 0, sizeof(dbinfo_t));
EXEC SQL DECLARE cur1 CURSOR FOR SELECT oid, datname, pg_database_size(oid) AS size FROM pg_database;
EXEC SQL OPEN cur1;
/* 当达到结果集末尾时，跳出 while 循环 */
EXEC SQL WHENEVER NOT FOUND DO BREAK;
while (1)
{
/* 将多列取到一个结构中。 */
EXEC SQL FETCH FROM cur1 INTO :dbval, :size;
/* 打印该结构的成员。 */
printf("oid=%d, datname=%s, size=%lld\n", dbval.oid, dbval.datname, size);
}
EXEC SQL CLOSE cur1;
34.4.4.3.3. Typedefs #
使用typedef关键字将新类型映射到已存在的类型。
EXEC SQL BEGIN DECLARE SECTION;
typedef char mychartype[40];
typedef long serial_t;
EXEC SQL END DECLARE SECTION;
请注意，您也可以使用：
EXEC SQL TYPE serial_t IS long;
这种声明不需要成为声明部分的一部分；也就是说，您也可以像普通的C语句一样编写typedef。
你声明为typedef的任何词都不能在同一程序中后续的
EXEC SQL命令中用作SQL关键字。例如，下面这样写是
不行的：
EXEC SQL BEGIN DECLARE SECTION;
typedef int start;
EXEC SQL END DECLARE SECTION;
...
EXEC SQL START TRANSACTION;
ECPG会对START
TRANSACTION报告语法错误，因为它不再将START识别为
SQL关键字，只识别为typedef。
（如果你遇到这种冲突，且重命名typedef不太现实，可以使用
动态SQL来编写SQL命令。）
注意
在PostgreSQL v16之前的版本中，使用SQL关键字作为
typedef名称可能会导致与typedef本身的使用相关的语法错误，而不是将名称用作
SQL关键字。新的行为在重新编译现有的ECPG应用程序时，更不容易
引发问题，尤其是在新的PostgreSQL版本中引入的新关键字。
34.4.4.3.4. Pointers #
你可以声明最常见类型的指针。不过注意，你不能使用指针作为不带自动分配内存的查询的目标变量。关于自动分配内存的详情请参考第 34.7 节。
EXEC SQL BEGIN DECLARE SECTION;
int   *intp;
char **charp;
EXEC SQL END DECLARE SECTION;
34.4.5. 处理非原始 SQL 数据类型 #
这一节包含关于如何处理 ECPG 应用中非标量以及用户定义的 SQL 级别数据类型。注意这和
上一节中描述的非原始类型主变量的处理有所不同。
34.4.5.1. 数组 #
ECPG 中不直接支持 SQL 级别的多维数组。一维 SQL 数组可以被映射到 C 数组主机变量，反之
亦然。不过，在创建一个语句时，ecpg 并不知道列的类型，因此它无法检查一个 C 数组是否是一个
SQL 数组的输入。在处理一个 SQL 语句的输出时，ecpg 有必要的信息并且进而检查是否两者都是
数组。
如果一个查询个别地访问一个数组的元素，那么这可以避免使用 ECPG 中的数组。然后，应该使用一个能被映射到该元素类型的主变量。例如，如果一个列类型是integer数组，可以使用一个类型int的主变量。还有如果元素类型是varchar或text，可以使用一个类型char[]或VARCHAR[]的主变量。
这里是一个例子。假定有下面的表：
CREATE TABLE t3 (
ii integer[]
);
testdb=> SELECT * FROM t3;
ii
-------------
{1,2,3,4,5}
(1 row)
下面的例子程序检索数组的第四个元素并且把它存储到一个类型为int的主变量中：
EXEC SQL BEGIN DECLARE SECTION;
int ii;
EXEC SQL END DECLARE SECTION;
EXEC SQL DECLARE cur1 CURSOR FOR SELECT ii[4] FROM t3;
EXEC SQL OPEN cur1;
EXEC SQL WHENEVER NOT FOUND DO BREAK;
while (1)
{
EXEC SQL FETCH FROM cur1 INTO :ii ;
printf("ii=%d\n", ii);
}
EXEC SQL CLOSE cur1;
这个例子会显示下面的结果：
ii=4
要把多个数组元素映射到一个数组类型主变量中的多个元素，数组列的每一个元素以及主变量数组的每一个元素都必须被单独管理，例如：
EXEC SQL BEGIN DECLARE SECTION;
int ii_a[8];
EXEC SQL END DECLARE SECTION;
EXEC SQL DECLARE cur1 CURSOR FOR SELECT ii[1], ii[2], ii[3], ii[4] FROM t3;
EXEC SQL OPEN cur1;
EXEC SQL WHENEVER NOT FOUND DO BREAK;
while (1)
{
EXEC SQL FETCH FROM cur1 INTO :ii_a[0], :ii_a[1], :ii_a[2], :ii_a[3];
...
}
注意
EXEC SQL BEGIN DECLARE SECTION;
int ii_a[8];
EXEC SQL END DECLARE SECTION;
EXEC SQL DECLARE cur1 CURSOR FOR SELECT ii FROM t3;
EXEC SQL OPEN cur1;
EXEC SQL WHENEVER NOT FOUND DO BREAK;
while (1)
{
/* 错误 */
EXEC SQL FETCH FROM cur1 INTO :ii_a;
...
}
在这种情况下不会正确工作，因为你无法把一个数组类型列直接映射到一个数组主变量。
另一种变通方案是在类型char[]或VARCHAR[]的主变量中存储数组的外部字符串表示。关于这种表示的详情请见第 8.15.2 节。注意这意味着该数组无法作为一个主程序中的数组被自然地访问（没有进一步处理解析文本表示）。
34.4.5.2. 组合类型 #
ECPG 中并不直接支持组合类型，但是有一种可能的简单变通方案。可用的变通方案和上述用于数组的方案相似：要么单独访问每一个属性，要么使用外部字符串表示。
对于下列例子，假定有下面的类型和表：
CREATE TYPE comp_t AS (intval integer, textval varchar(32));
CREATE TABLE t4 (compval comp_t);
INSERT INTO t4 VALUES ( (256, 'PostgreSQL') );
最显而易见的解决方案是单独访问每一个属性。下面的程序通过单独选择类型comp_t的每一个属性从例子表中检索数据：
EXEC SQL BEGIN DECLARE SECTION;
int intval;
varchar textval[33];
EXEC SQL END DECLARE SECTION;
/* 将组合类型列的每一个元素放在 SELECT 列表中。 */
EXEC SQL DECLARE cur1 CURSOR FOR SELECT (compval).intval, (compval).textval FROM t4;
EXEC SQL OPEN cur1;
EXEC SQL WHENEVER NOT FOUND DO BREAK;
while (1)
{
/* 将组合类型列的每一个元素取到主变量中。 */
EXEC SQL FETCH FROM cur1 INTO :intval, :textval;
printf("intval=%d, textval=%s\n", intval, textval.arr);
}
EXEC SQL CLOSE cur1;
为了增强这个例子，在FETCH命令中存储值的主变量可以被集中在一个结构中。结构形式的主变量的详情可见第 34.4.4.3.2 节。要切换到结构形式，该例子可以被改成下面的样子。两个主变量intval和textval变成comp_t结构的成员，并且该结构在FETCH命令中指定。
EXEC SQL BEGIN DECLARE SECTION;
typedef struct
{
int intval;
varchar textval[33];
} comp_t;
comp_t compval;
EXEC SQL END DECLARE SECTION;
/* 将组合类型列的每一个元素放在 SELECT 列表中。 */
EXEC SQL DECLARE cur1 CURSOR FOR SELECT (compval).intval, (compval).textval FROM t4;
EXEC SQL OPEN cur1;
EXEC SQL WHENEVER NOT FOUND DO BREAK;
while (1)
{
/* 将 SELECT 列表中的所有值放入一个结构。 */
EXEC SQL FETCH FROM cur1 INTO :compval;
printf("intval=%d, textval=%s\n", compval.intval, compval.textval.arr);
}
EXEC SQL CLOSE cur1;
尽管在FETCH命令中使用了一个结构，SELECT子句中的属性名还是要一个一个指定。可以通过使用一个*来要求该组合类型值的所有属性来改进。
...
EXEC SQL DECLARE cur1 CURSOR FOR SELECT (compval).* FROM t4;
EXEC SQL OPEN cur1;
EXEC SQL WHENEVER NOT FOUND DO BREAK;
while (1)
{
/* 将 SELECT 列表中的所有值放入一个结构。 */
EXEC SQL FETCH FROM cur1 INTO :compval;
printf("intval=%d, textval=%s\n", compval.intval, compval.textval.arr);
}
...
通过这种方法，即便 ECPG 不理解组合类型本身，组合类型也能够几乎无缝地被映射到结构。
最后，也可以在类型char[]或VARCHAR[]的主变量中把组合类型值存储成它们的外部字符串表示。但是如果使用那种方法，就不太可能从主程序中访问该值的各个字段了。
34.4.5.3. 用户定义的基础类型 #
ECPG 并不直接支持新的用户定义的基本类型。你可以使用外部字符串表达以及类型char[]或VARCHAR[]的主变量，并且这种方案事实上对很多类型都是合适和足够的。
这是一个使用数据类型 complex 的示例，来自 第 36.13 节 中的示例。该类型的外部字符串表示为 (%f,%f)，在 第 36.13 节 中的函数 complex_in() 和 complex_out() 中定义。以下示例将复数类型值 (1,1) 和 (3,3) 插入到列 a 和 b 中，然后从表中选择它们。
EXEC SQL BEGIN DECLARE SECTION;
varchar a[64];
varchar b[64];
EXEC SQL END DECLARE SECTION;
EXEC SQL INSERT INTO test_complex VALUES ('(1,1)', '(3,3)');
EXEC SQL DECLARE cur1 CURSOR FOR SELECT a, b FROM test_complex;
EXEC SQL OPEN cur1;
EXEC SQL WHENEVER NOT FOUND DO BREAK;
while (1)
{
EXEC SQL FETCH FROM cur1 INTO :a, :b;
printf("a=%s, b=%s\n", a.arr, b.arr);
}
EXEC SQL CLOSE cur1;
该示例显示以下结果：
a=(1,1), b=(3,3)
另一种变通方案是避免在 ECPG 中直接使用用户定义的类型，而是创建一个在用户定义的类型和 ECPG 能处理的简单类型之间转换的函数或者类型转换。不过要注意，在类型系统中引入类型转换（特别是隐式转换）要非常小心。
例如，
CREATE FUNCTION create_complex(r double, i double) RETURNS complex
LANGUAGE SQL
IMMUTABLE
AS $$ SELECT $1 * complex '(1,0)' + $2 * complex '(0,1)' $$;
在这个定义之后，下面的语句
EXEC SQL BEGIN DECLARE SECTION;
double a, b, c, d;
EXEC SQL END DECLARE SECTION;
a = 1;
b = 2;
c = 3;
d = 4;
EXEC SQL INSERT INTO test_complex VALUES (create_complex(:a, :b), create_complex(:c, :d));
具有和
EXEC SQL INSERT INTO test_complex VALUES ('(1,2)', '(3,4)');
相同的效果。
34.4.6. 指示符 #
上面的示例不处理空值。实际上，如果从数据库中获取空值，检索示例将引发错误。
要能够将空值传递给数据库或从数据库中检索空值，需要在包含数据的每个主机变量后附加第二个主机变量规范。
这第二个主机变量称为指示器，其中包含一个标志，指示数据是否为空，如果是，则忽略实际主机变量的值。
这里是一个正确处理检索空值的示例：
EXEC SQL BEGIN DECLARE SECTION;
VARCHAR val;
int val_ind;
EXEC SQL END DECLARE SECTION:
...
EXEC SQL SELECT b INTO :val, :val_ind FROM test1;
指示变量val_ind如果值不为空，则为零，如果值为空，则为负数。
（请参见第 34.16 节以启用特定于Oracle的行为。）
指示器有另一种功能：如果指示器值为正，它表示值不为空，但是当它被存储在主机变量中时已被截断。
如果参数-r no_indicator被传递给预处理器ecpg，它会工作在“无指示符”模式。在无指示符模式中，如果没有指定指示符变量，对于字符串类型空值被标志（在输入和输出上）为空串，对于整数类型空值被标志为类型的最低可能值（例如，int的是INT_MIN）。
上一页 上一级 下一页34.3. 运行 SQL 命令 起始页 34.5. 动态 SQL
