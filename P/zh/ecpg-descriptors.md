# 34.7. 使用描述符区域

34.7. 使用描述符区域
版本：
纠错本页面
搜索
目录导航
❮
❯
34.7. 使用描述符区域 #34.7.1. 命名 SQL 描述符区域34.7.2. SQLDA 描述符区域
一个 SQL 描述符区域是一种处理SELECT、FETCH或DESCRIBE语句结果的高级方法。一个 SQL 描述符区域把一行数据及其元数据项组合到一个数据结构中。在执行动态 SQL 语句时（结果列的性质可能无法提前预知），元数据特别有用。PostgreSQL 提供两种方法来使用描述符区域：命名 SQL 描述符区域和 C 结构 SQLDA。
34.7.1. 命名 SQL 描述符区域 #
一个命名 SQL 描述符区域由一个头部以及一个或多个条目描述符区域构成，头部包含与整个描述符相关的信息，而条目描述符区域则描述结果行中的每一列。
在使用 SQL 描述符区域之前，需要先分配一个：
EXEC SQL ALLOCATE DESCRIPTOR identifier;
identifier 会作为该描述符区域的“变量名”。当不再需要该描述符时，应当释放它：
EXEC SQL DEALLOCATE DESCRIPTOR identifier;
要使用一个描述符区域，把它指定为INTO子句的存储目标，而不是列出主机变量：
EXEC SQL FETCH NEXT FROM mycursor INTO SQL DESCRIPTOR mydesc;
如果结果集为空，该描述符区域仍然会包含查询的元数据，即字段的名称。
对于还没有执行的预备查询，DESCRIBE可以用来获取其结果集的元数据：
EXEC SQL BEGIN DECLARE SECTION;
char *sql_stmt = "SELECT * FROM table1";
EXEC SQL END DECLARE SECTION;
EXEC SQL PREPARE stmt1 FROM :sql_stmt;
EXEC SQL DESCRIBE stmt1 INTO SQL DESCRIPTOR mydesc;
在 PostgreSQL 9.0 之前，SQL关键词是可选的，因此使用DESCRIPTOR和SQL DESCRIPTOR都会产生命名 SQL 描述符区域。现在该关键词是强制性的，省略SQL关键词会产生 SQLDA 描述符区域，见第 34.7.2 节。
在DESCRIBE和FETCH语句中，INTO和USING关键词的使用相似：它们产生结果集以及一个描述符区域中的元数据。
那么，如何从描述符区域中获取数据呢？您可以将描述符区域视为一个具有命名字段的结构。要从头部中检索字段的值并将其存储到主机变量中，请使用以下命令：
EXEC SQL GET DESCRIPTOR name :hostvar = field;
目前，仅定义了一个头字段：
COUNT，它表示存在多少个项目描述符区域（也就是说，结果中包含多少列）。主机变量需要是整数类型。要从项目描述符区域获取字段，请使用以下命令：
EXEC SQL GET DESCRIPTOR name VALUE num :hostvar = field;
num可以是一个字面整数或包含整数的主机变量。可能的字段有：
CARDINALITY（整数） #
结果集中行的数量
DATA #
实际数据项（因此，此字段的数据类型取决于查询）
DATETIME_INTERVAL_CODE（整数） #
当TYPE为9时，
DATETIME_INTERVAL_CODE的值为
1表示DATE，
2表示TIME，
3表示TIMESTAMP，
4表示TIME WITH TIME ZONE，或
5表示TIMESTAMP WITH TIME ZONE。
DATETIME_INTERVAL_PRECISION（整数） #
未实现
INDICATOR（整数） #
指示器（表示空值或值截断）
KEY_MEMBER（整数） #
未实现
LENGTH（整数） #
数据的长度（以字符为单位）
NAME（字符串） #
列的名称
NULLABLE (integer) #
未实现
OCTET_LENGTH (integer) #
数据的字符表示的长度（以字节为单位）
PRECISION (integer) #
精度（对于类型 numeric）
RETURNED_LENGTH (integer) #
数据的长度（以字符为单位）
RETURNED_OCTET_LENGTH (integer) #
数据的字符表示的长度（以字节为单位）
SCALE (integer) #
scale（对于类型numeric）
TYPE (integer) #
列数据类型的数值代码
在EXECUTE、DECLARE以及OPEN语句中，INTO和USING关键词的效果不同。也可以手工建立一个描述符区域来为一个查询或者游标提供输入参数，并且USING SQL DESCRIPTOR name是用来传递输入参数给参数化查询的方法。建立一个命名 SQL 描述符区域的语句如下：
EXEC SQL SET DESCRIPTOR name VALUE num field = :hostvar;
PostgreSQL 支持在一个FETCH语句中检索多于一个记录，并且在这种情况下把主变量假定为一个数组来存储数据。例如：
EXEC SQL BEGIN DECLARE SECTION;
int id[5];
EXEC SQL END DECLARE SECTION;
EXEC SQL FETCH 5 FROM mycursor INTO SQL DESCRIPTOR mydesc;
EXEC SQL GET DESCRIPTOR mydesc VALUE 1 :id = DATA;
34.7.2. SQLDA 描述符区域 #
SQLDA 描述符区域是一个 C 语言结构，它也能被用来获取一个查询的结果集和元数据。一个结构存储一个来自结果集的记录。
EXEC SQL include sqlda.h;
sqlda_t         *mysqlda;
EXEC SQL FETCH 3 FROM mycursor INTO DESCRIPTOR mysqlda;
注意SQL关键词被省略了。第 34.7.1 节中关于INTO和USING关键词用例的段落在一定条件下也适用于这里。在一个DESCRIBE语句中，如果使用了INTO关键词，则DESCRIPTOR关键词可以完全被省略：
EXEC SQL DESCRIBE prepared_statement INTO mysqlda;
使用 SQLDA 的程序的一般流程是：
准备一个查询，并为它声明一个游标。为结果行声明一个 SQLDA。为输入参数声明一个 SQLDA，并初始化它们（内存分配、参数设置）。用输入 SQLDA 打开一个游标。从游标中获取行，并把它们存储到一个输出 SQLDA。从输出 SQLDA 读取值到主变量中（必要时进行转换）。关闭游标。释放为输入 SQLDA 分配的内存区域。34.7.2.1. SQLDA 数据结构 #
SQLDA 使用三种数据结构类型：sqlda_t、sqlvar_t和struct sqlname。
提示
PostgreSQL 的 SQLDA 与 IBM DB2 Universal Database 中相似的数据结构，因此一些 DB2 的 SQLDA 的技术信息有助于更好地理解 PostgreSQL 的 SQLDA。
34.7.2.1.1. sqlda_t 结构 #
结构类型sqlda_t是实际 SQLDA 的类型。它保存一个记录。并且两个或更多个sqlda_t结构能够以desc_next域中的指针连接成一个链表，这样可以表示一个有序的行集合。因此，当两个或多个行被获取时，应用可以通过沿着每一个sqlda_t节点中的desc_next指针读取它们。
sqlda_t 的定义是:
struct sqlda_struct
{
char            sqldaid[8];
long            sqldabc;
short           sqln;
short           sqld;
struct sqlda_struct *desc_next;
struct sqlvar_struct sqlvar[1];
};
typedef struct sqlda_struct sqlda_t;
字段的含义是:
sqldaid #
它包含字面字符串 "SQLDA  "。
sqldabc #
它包含以字节为单位分配空间的大小。
sqln #
如果它通过 USING 关键字传递到
OPEN、DECLARE 或
EXECUTE 语句中，它包含参数化查询的输入参数数量。
如果它用作 SELECT、EXECUTE 或
FETCH 语句的输出，其值与
sqld 语句相同。
sqld #
它包含结果集中字段的数量。
desc_next #
如果查询返回多个记录，则会返回多个链接的 SQLDA 结构，
并且 desc_next 保存指向列表中下一个条目的指针。
sqlvar #
这是结果集中列的数组。
34.7.2.1.2. sqlvar_t 结构 #
结构类型sqlvar_t保存列值以及元数据，例如类型和长度。
该类型的定义是：
struct sqlvar_struct
{
short          sqltype;
short          sqllen;
char          *sqldata;
short         *sqlind;
struct sqlname sqlname;
};
typedef struct sqlvar_struct sqlvar_t;
字段的含义是：
sqltype #
包含字段的类型标识符。有关值，请参见enum ECPGttype
在ecpgtype.h中。
sqllen #
包含字段的二进制长度。例如，ECPGt_int为4字节。
sqldata #
指向数据。数据的格式在第 34.4.4 节
中描述。
sqlind #
指向空指示器。0表示非空，-1表示空。
sqlname #
字段的名称。
34.7.2.1.3. struct sqlname 结构 #
一个struct sqlname结构体保存了一个列名。它被用作
sqlvar_t结构体的一个成员。该结构体的定义是：
#define NAMEDATALEN 64
struct sqlname
{
short           length;
char            data[NAMEDATALEN];
};
各字段的含义是：
length #
包含字段名称的长度。
data #
包含实际的字段名称。
34.7.2.2. 使用一个 SQLDA 检索一个结果集 #
通过一个 SQLDA 检索一个查询结果集的一般步骤是：
声明一个sqlda_t结构来接收结果集。执行 FETCH/EXECUTE/DESCRIBE 命令来处理一个指定已声明 SQLDA 的查询。通过查看 sqln，这是 sqlda_t 结构的一个成员，来检查结果集中记录的数量。从 sqlvar[0]、sqlvar[1] 等 sqlda_t 结构的成员中获取每一列的值。沿着 desc_next 指针到达下一行（sqlda_t 结构），这是 sqlda_t 结构的一个成员。根据需要重复上述步骤。
这里是一个通过 SQLDA 检索结果集的例子。
首先，声明一个 sqlda_t 结构来接收结果集。
sqlda_t *sqlda1;
接下来，在命令中指定 SQLDA。这是一个 FETCH 命令的例子。
EXEC SQL FETCH NEXT FROM cur1 INTO DESCRIPTOR sqlda1;
运行一个循环顺着链表来检索行。
sqlda_t *cur_sqlda;
for (cur_sqlda = sqlda1;
cur_sqlda != NULL;
cur_sqlda = cur_sqlda->desc_next)
{
...
}
在循环内部，运行另一个循环来检索行中每一列的数据（sqlvar_t结构）。
for (i = 0; i < cur_sqlda->sqld; i++)
{
sqlvar_t v = cur_sqlda->sqlvar[i];
char *sqldata = v.sqldata;
short sqllen  = v.sqllen;
...
}
要得到一列的值，应检查sqltype的值，
这是sqlvar_t结构的一个成员。然后，根据列类型切换到一种合适的方法，从sqlvar域中复制数据到一个主变量。
char var_buf[1024];
switch (v.sqltype)
{
case ECPGt_char:
memset(&var_buf, 0, sizeof(var_buf));
memcpy(&var_buf, sqldata, (sizeof(var_buf) <= sqllen ? sizeof(var_buf) - 1 : sqllen));
break;
case ECPGt_int: /* integer */
memcpy(&intval, sqldata, sqllen);
snprintf(var_buf, sizeof(var_buf), "%d", intval);
break;
...
}
34.7.2.3. 使用 SQLDA 传递查询参数 #
使用 SQLDA 传递输入参数给预备查询的一般步骤是：
创建一个预备查询（预处理语句）。声明一个 sqlda_t 结构作为输入 SQLDA。为输入 SQLDA 分配内存区域（作为 sqlda_t 结构）。在分配的内存中设置（复制）输入值。打开一个游标并指定输入 SQLDA。
这里是一个例子。
首先，创建一个预处理语句。
EXEC SQL BEGIN DECLARE SECTION;
char query[1024] = "SELECT d.oid, * FROM pg_database d, pg_stat_database s WHERE d.oid = s.datid AND (d.datname = ? OR d.oid = ?)";
EXEC SQL END DECLARE SECTION;
EXEC SQL PREPARE stmt1 FROM :query;
接下来为一个 SQLDA 分配内存，并在sqln成员变量中设置输入参数的数量。当预处理查询要求两个或多个输入参数时，应用必须分配额外的内存空间，空间的大小为 (参数数目 - 1) * sizeof(sqlvar_t)。这里的例子展示了为两个输入参数分配内存空间。
sqlda_t *sqlda2;
sqlda2 = (sqlda_t *) malloc(sizeof(sqlda_t) + sizeof(sqlvar_t));
memset(sqlda2, 0, sizeof(sqlda_t) + sizeof(sqlvar_t));
sqlda2->sqln = 2; /* 输入变量的数目 */
内存分配之后，把参数值存储到sqlvar[]数组（当 SQLDA 在接收结果集时，这也是用来检索列值的数组）。在这个例子中，输入参数是"postgres"（字符串类型）和1（整数类型）。
sqlda2->sqlvar[0].sqltype = ECPGt_char;
sqlda2->sqlvar[0].sqldata = "postgres";
sqlda2->sqlvar[0].sqllen  = 8;
int intval = 1;
sqlda2->sqlvar[1].sqltype = ECPGt_int;
sqlda2->sqlvar[1].sqldata = (char *) &intval;
sqlda2->sqlvar[1].sqllen  = sizeof(intval);
通过打开一个游标并指定之前设置好的 SQLDA，输入参数被传递给预处理语句。
EXEC SQL OPEN cur1 USING DESCRIPTOR sqlda2;
最后，用完输入 SQLDA 后必须显式地释放已分配的内存空间，这与用于接收查询结果的 SQLDA 不同。
free(sqlda2);
34.7.2.4. 一个使用 SQLDA 的示例应用程序 #
这里是一个示例程序，它描述了如何按照输入参数的指定从系统目录中获取数据库的访问统计。
这个应用在数据库 OID 上连接两个系统表（pg_database 和 pg_stat_database），并且还获取和显示通过两个输入参数（一个数据库postgres和 OID 1）检索到的数据库统计。
首先，为输入和输出分别声明一个 SQLDA。
EXEC SQL include sqlda.h;
sqlda_t *sqlda1; /* 输出描述符 */
sqlda_t *sqlda2; /* 输入描述符  */
接下来，连接到数据库，准备一个语句并为预备语句声明一个游标。
int
main(void)
{
EXEC SQL BEGIN DECLARE SECTION;
char query[1024] = "SELECT d.oid,* FROM pg_database d, pg_stat_database s WHERE d.oid=s.datid AND ( d.datname=? OR d.oid=? )";
EXEC SQL END DECLARE SECTION;
EXEC SQL CONNECT TO testdb AS con1 USER testuser;
EXEC SQL SELECT pg_catalog.set_config('search_path', '', false); EXEC SQL COMMIT;
EXEC SQL PREPARE stmt1 FROM :query;
EXEC SQL DECLARE cur1 CURSOR FOR stmt1;
然后，为输入参数在输入 SQLDA 中放入一些值。为输入 SQLDA 分配内存，并在sqln中设置输入参数的数量。在sqlvar结构的sqltype、sqldata和sqllen中存入类型、值和值长度。
/* 为输入参数创建 SQLDA 结构。 */
sqlda2 = (sqlda_t *) malloc(sizeof(sqlda_t) + sizeof(sqlvar_t));
memset(sqlda2, 0, sizeof(sqlda_t) + sizeof(sqlvar_t));
sqlda2->sqln = 2; /* 输入变量的数量 */
sqlda2->sqlvar[0].sqltype = ECPGt_char;
sqlda2->sqlvar[0].sqldata = "postgres";
sqlda2->sqlvar[0].sqllen  = 8;
intval = 1;
sqlda2->sqlvar[1].sqltype = ECPGt_int;
sqlda2->sqlvar[1].sqldata = (char *)&intval;
sqlda2->sqlvar[1].sqllen  = sizeof(intval);
设置完输入 SQLDA 之后，用输入 SQLDA 打开一个游标。
/* 用输入参数打开一个游标。 */
EXEC SQL OPEN cur1 USING DESCRIPTOR sqlda2;
从打开的游标中取行到输出 SQLDA 中（通常，你需要在循环中反复调用FETCH来取出结果集中的所有行）。
while (1)
{
sqlda_t *cur_sqlda;
/* 分配描述符给游标  */
EXEC SQL FETCH NEXT FROM cur1 INTO DESCRIPTOR sqlda1;
再后，沿着sqlda_t结构的链表从 SQLDA 中检索取得的记录。
for (cur_sqlda = sqlda1 ;
cur_sqlda != NULL ;
cur_sqlda = cur_sqlda->desc_next)
{
...
读取第一个记录中的每一列。列的数量被存储在sqld中，第一列的实际数据被存储在sqlvar[0]中，两者都是sqlda_t结构的成员。
/* 打印一行中的每一列。 */
for (i = 0; i < sqlda1->sqld; i++)
{
sqlvar_t v = sqlda1->sqlvar[i];
char *sqldata = v.sqldata;
short sqllen  = v.sqllen;
strncpy(name_buf, v.sqlname.data, v.sqlname.length);
name_buf[v.sqlname.length] = '\0';
现在，列数据已经被存储在变量v中。把每个数据复制到主变量中，列的类型可以查看v.sqltype。
switch (v.sqltype) {
int intval;
double doubleval;
unsigned long long int longlongval;
case ECPGt_char:
memset(&var_buf, 0, sizeof(var_buf));
memcpy(&var_buf, sqldata, (sizeof(var_buf) <= sqllen ? sizeof(var_buf)-1 : sqllen));
break;
case ECPGt_int: /* 整数 */
memcpy(&intval, sqldata, sqllen);
snprintf(var_buf, sizeof(var_buf), "%d", intval);
break;
...
default:
...
}
printf("%s = %s (type: %d)\n", name_buf, var_buf, v.sqltype);
}
处理所有记录后关闭游标，并从数据库断开连接。
EXEC SQL CLOSE cur1;
EXEC SQL COMMIT;
EXEC SQL DISCONNECT ALL;
整个程序显示在例 34.1中。
例 34.1. 示例 SQLDA 程序
#include <stdlib.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
EXEC SQL include sqlda.h;
sqlda_t *sqlda1; /* 用于输出的描述符 */
sqlda_t *sqlda2; /* 用于输入的描述符 */
EXEC SQL WHENEVER NOT FOUND DO BREAK;
EXEC SQL WHENEVER SQLERROR STOP;
int
main(void)
{
EXEC SQL BEGIN DECLARE SECTION;
char query[1024] = "SELECT d.oid,* FROM pg_database d, pg_stat_database s WHERE d.oid=s.datid AND ( d.datname=? OR d.oid=? )";
int intval;
unsigned long long int longlongval;
EXEC SQL END DECLARE SECTION;
EXEC SQL CONNECT TO uptimedb AS con1 USER uptime;
EXEC SQL SELECT pg_catalog.set_config('search_path', '', false); EXEC SQL COMMIT;
EXEC SQL PREPARE stmt1 FROM :query;
EXEC SQL DECLARE cur1 CURSOR FOR stmt1;
/* 为一个输入参数创建一个 SQLDA 结构 */
sqlda2 = (sqlda_t *)malloc(sizeof(sqlda_t) + sizeof(sqlvar_t));
memset(sqlda2, 0, sizeof(sqlda_t) + sizeof(sqlvar_t));
sqlda2->sqln = 2; /* 输入变量的数量 */
sqlda2->sqlvar[0].sqltype = ECPGt_char;
sqlda2->sqlvar[0].sqldata = "postgres";
sqlda2->sqlvar[0].sqllen  = 8;
intval = 1;
sqlda2->sqlvar[1].sqltype = ECPGt_int;
sqlda2->sqlvar[1].sqldata = (char *) &intval;
sqlda2->sqlvar[1].sqllen  = sizeof(intval);
/* 用输入参数打开一个游标。 */
EXEC SQL OPEN cur1 USING DESCRIPTOR sqlda2;
while (1)
{
sqlda_t *cur_sqlda;
/* 给游标分配描述符  */
EXEC SQL FETCH NEXT FROM cur1 INTO DESCRIPTOR sqlda1;
for (cur_sqlda = sqlda1 ;
cur_sqlda != NULL ;
cur_sqlda = cur_sqlda->desc_next)
{
int i;
char name_buf[1024];
char var_buf[1024];
/* 打印一行中的每一列。 */
for (i=0 ; i<cur_sqlda->sqld ; i++)
{
sqlvar_t v = cur_sqlda->sqlvar[i];
char *sqldata = v.sqldata;
short sqllen  = v.sqllen;
strncpy(name_buf, v.sqlname.data, v.sqlname.length);
name_buf[v.sqlname.length] = '\0';
switch (v.sqltype)
{
case ECPGt_char:
memset(&var_buf, 0, sizeof(var_buf));
memcpy(&var_buf, sqldata, (sizeof(var_buf)<=sqllen ? sizeof(var_buf)-1 : sqllen) );
break;
case ECPGt_int: /* 整数 */
memcpy(&intval, sqldata, sqllen);
snprintf(var_buf, sizeof(var_buf), "%d", intval);
break;
case ECPGt_long_long: /* 大整数 */
memcpy(&longlongval, sqldata, sqllen);
snprintf(var_buf, sizeof(var_buf), "%lld", longlongval);
break;
default:
{
int i;
memset(var_buf, 0, sizeof(var_buf));
for (i = 0; i < sqllen; i++)
{
char tmpbuf[16];
snprintf(tmpbuf, sizeof(tmpbuf), "%02x ", (unsigned char) sqldata[i]);
strncat(var_buf, tmpbuf, sizeof(var_buf));
}
}
break;
}
printf("%s = %s (type: %d)\n", name_buf, var_buf, v.sqltype);
}
printf("\n");
}
}
EXEC SQL CLOSE cur1;
EXEC SQL COMMIT;
EXEC SQL DISCONNECT ALL;
return 0;
}
这个例子的输出应该看起来类似下面的结果（一些数字会变化）。
oid = 1 (type: 1)
datname = template1 (type: 1)
datdba = 10 (type: 1)
encoding = 0 (type: 5)
datistemplate = t (type: 1)
datallowconn = t (type: 1)
dathasloginevt = f (type: 1)
datconnlimit = -1 (type: 5)
datfrozenxid = 379 (type: 1)
dattablespace = 1663 (type: 1)
datconfig =  (type: 1)
datacl = {=c/uptime,uptime=CTc/uptime} (type: 1)
datid = 1 (type: 1)
datname = template1 (type: 1)
numbackends = 0 (type: 5)
xact_commit = 113606 (type: 9)
xact_rollback = 0 (type: 9)
blks_read = 130 (type: 9)
blks_hit = 7341714 (type: 9)
tup_returned = 38262679 (type: 9)
tup_fetched = 1836281 (type: 9)
tup_inserted = 0 (type: 9)
tup_updated = 0 (type: 9)
tup_deleted = 0 (type: 9)
oid = 11511 (type: 1)
datname = postgres (type: 1)
datdba = 10 (type: 1)
encoding = 0 (type: 5)
datistemplate = f (type: 1)
datallowconn = t (type: 1)
dathasloginevt = f (type: 1)
datconnlimit = -1 (type: 5)
datfrozenxid = 379 (type: 1)
dattablespace = 1663 (type: 1)
datconfig =  (type: 1)
datacl =  (type: 1)
datid = 11511 (type: 1)
datname = postgres (type: 1)
numbackends = 0 (type: 5)
xact_commit = 221069 (type: 9)
xact_rollback = 18 (type: 9)
blks_read = 1176 (type: 9)
blks_hit = 13943750 (type: 9)
tup_returned = 77410091 (type: 9)
tup_fetched = 3253694 (type: 9)
tup_inserted = 0 (type: 9)
tup_updated = 0 (type: 9)
tup_deleted = 0 (type: 9)
上一页 上一级 下一页34.6. pgtypes 库 起始页 34.8. 错误处理
