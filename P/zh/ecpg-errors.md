# 34.8. 错误处理

34.8. 错误处理
版本：
纠错本页面
搜索
目录导航
❮
❯
34.8. 错误处理 #34.8.1. 设置回调34.8.2. sqlca34.8.3. SQLSTATE 与 SQLCODE
这一节描述在一个嵌入式 SQL 程序中如何处理异常情况和警告。有两种非互斥的工具可以用于这个目的。
可以使用WHENEVER命令配置回调来处理警告和错误情况。
可以从sqlca变量中获得错误或警告的详细信息。
34.8.1. 设置回调 #
一种捕捉错误和警告的简单方法是设置一个特殊的动作，只要一个特定情况发生就执行该动作。通常是这样：
EXEC SQL WHENEVER condition action;
condition 可以是以下之一：
SQLERROR #
每当在执行SQL语句期间发生错误时，都会调用指定的操作。
SQLWARNING #
每当在执行SQL语句期间发生警告时，都会调用指定的操作。
NOT FOUND #
每当SQL语句检索或影响到零行时，都会调用指定的操作。
（此情况不是错误，但您可能希望特别处理它。）
action 可以是以下之一：
CONTINUE #
这实际上意味着忽略该条件。这是默认值。
GOTO labelGO TO label #
跳转到指定的标签（使用 C goto 语句）。
SQLPRINT #
打印一条消息到标准错误。这对于简单程序或原型开发期间很有用。
消息的详细信息无法配置。
STOP #
调用 exit(1)，这将终止程序。
DO BREAK #
执行 C 语句 break。这应该仅在循环或
switch 语句中使用。
DO CONTINUE #
执行 C 语句 continue。这应该仅在循环语句中
使用。如果执行，将导致控制流返回到循环的顶部。
CALL name (args)DO name (args) #
使用指定的参数调用指定的 C 函数。（此用法与
正常 PostgreSQL 语法中的 CALL 和
DO 的含义不同。）
SQL 标准仅提供了 CONTINUE 和
GOTO（以及 GO TO）操作。
这里有一个可能会用在简单程序中的例子。当一个警告发生时它打印一个简单消息，而发生一个错误时它会中止程序：
EXEC SQL WHENEVER SQLWARNING SQLPRINT;
EXEC SQL WHENEVER SQLERROR STOP;
语句EXEC SQL WHENEVER是 SQL 预处理器的一个指令，而不是一个 C 语句。不管 C 程序的控制流程如何，该语句设置的错误或警告动作适用于所有位于处理程序设置点之后的嵌入式 SQL 语句，除非在第一个EXEC SQL WHENEVER和导致情况的 SQL 语句之间为同一个情况设置了不同的动作。因此下面的两个 C 程序都不会得到预期的效果：
/*
* 错误
*/
int main(int argc, char *argv[])
{
...
if (verbose) {
EXEC SQL WHENEVER SQLWARNING SQLPRINT;
}
...
EXEC SQL SELECT ...;
...
}
/*
* 错误
*/
int main(int argc, char *argv[])
{
...
set_error_handler();
...
EXEC SQL SELECT ...;
...
}
static void set_error_handler(void)
{
EXEC SQL WHENEVER SQLERROR STOP;
}
34.8.2. sqlca #
为了更强大的错误处理，嵌入式 SQL 接口提供了一个名为sqlca（SQL 通信区域）的全局变量，它具有下面的结构：
struct
{
char sqlcaid[8];
long sqlabc;
long sqlcode;
struct
{
int sqlerrml;
char sqlerrmc[SQLERRMC_LEN];
} sqlerrm;
char sqlerrp[8];
long sqlerrd[6];
char sqlwarn[8];
char sqlstate[5];
} sqlca;
（在一个多线程程序中，每一个线程会自动得到它自己的sqlca副本。这和对于标准 C 全局变量errno的处理相似。）
sqlca覆盖了警告和错误。如果执行一个语句时发生了多个警告或错误，那么sqlca将只包含关于最后一个的信息。
如果在上一个SQL语句中没有产生错误，sqlca.sqlcode将为 0 并且sqlca.sqlstate将为"00000"。如果发生一个警告或错误，则sqlca.sqlcode将为负并且sqlca.sqlstate将不为"00000"。一个正的sqlca.sqlcode表示一种无害的情况，例如上一个查询返回零行。sqlcode和sqlstate是两种不同的错误代码模式，详见下文。
如果上一个 SQL 语句成功，那么sqlca.sqlerrd[1]包含被处理行的 OID（如果适用），并且sqlca.sqlerrd[2]包含被处理或被返回的行数（如果适用于该命令）。
在发生一个错误或警告的情况下，sqlca.sqlerrm.sqlerrmc将包含一个描述该错误的字符串。域sqlca.sqlerrm.sqlerrml包含存储在sqlca.sqlerrm.sqlerrmc中错误消息的长度（strlen()的结果，对于一个 C 程序员来说并不感兴趣）。注意一些消息可能太长不能适应定长的sqlerrmc数组，它们将被截断。
在发生一个警告的情况下，sqlca.sqlwarn[2]被设置为W（在所有其他情况中，它被设置为不同于W的东西）。如果sqlca.sqlwarn[1]被设置为W，那么一个值被存储在一个主变量中时会被截断。如果任意其他元素被设置为指示一个警告，sqlca.sqlwarn[0]会被设置为W。
域sqlcaid、
sqlabc,
sqlerrp以及
sqlerrd的剩余元素和
sqlwarn当前不包含有用的信息。
SQL 标准中没有定义sqlca结构，但是在一些其他的 SQL 数据库
系统中都有实现。在核心上这些定义都相似，但是如果你想要编写可移植的应用，
那么你应该仔细研究不同的实现。
这里有一个整合使用WHENEVER和sqlca的例子，
当一个错误发生时打印出sqlca的内容。在安装一个更“用户友好”
的错误处理器之前，这可能对调试或开发原型应用有用。
EXEC SQL WHENEVER SQLERROR CALL print_sqlca();
void
print_sqlca()
{
fprintf(stderr, "==== sqlca ====\n");
fprintf(stderr, "sqlcode: %ld\n", sqlca.sqlcode);
fprintf(stderr, "sqlerrm.sqlerrml: %d\n", sqlca.sqlerrm.sqlerrml);
fprintf(stderr, "sqlerrm.sqlerrmc: %s\n", sqlca.sqlerrm.sqlerrmc);
fprintf(stderr, "sqlerrd: %ld %ld %ld %ld %ld %ld\n", sqlca.sqlerrd[0],sqlca.sqlerrd[1],sqlca.sqlerrd[2],
sqlca.sqlerrd[3],sqlca.sqlerrd[4],sqlca.sqlerrd[5]);
fprintf(stderr, "sqlwarn: %d %d %d %d %d %d %d %d\n", sqlca.sqlwarn[0], sqlca.sqlwarn[1], sqlca.sqlwarn[2],
sqlca.sqlwarn[3], sqlca.sqlwarn[4], sqlca.sqlwarn[5],
sqlca.sqlwarn[6], sqlca.sqlwarn[7]);
fprintf(stderr, "sqlstate: %5s\n", sqlca.sqlstate);
fprintf(stderr, "===============\n");
}
结果看起来像（这里的错误是一个拼写错误的表名）：
==== sqlca ====
sqlcode: -400
sqlerrm.sqlerrml: 49
sqlerrm.sqlerrmc: relation "pg_databasep" does not exist on line 38
sqlerrd: 0 0 0 0 0 0
sqlwarn: 0 0 0 0 0 0 0 0
sqlstate: 42P01
===============
34.8.3. SQLSTATE 与 SQLCODE #
域sqlca.sqlstate以及sqlca.sqlcode是提供错误代码的两种不同模式。
两种都源自于 SQL 标准，但是在标准的 SQL-92 版本中SQLCODE已经被标记为弃用并且在后面的版本中被删除。
因此，强烈建议新应用使用SQLSTATE。
SQLSTATE是一个五字符数组。这五个字符包含数字或大写字母，它表示多种错误或警告情况的代码。
SQLSTATE具有一种层次模式：前两个字符表示情况的总体分类，后三个字符表示总体情况的子类。
代码00000表示一种成功的状态。SQL 标准中的大部分都有对应的SQLSTATE代码。
PostgreSQL服务器本地支持SQLSTATE错误代码，因此通过在所有应用中自始至终使用这种错误代码模式可以实现高度的一致性。
进一步的信息请见附录 A。
被弃用的错误代码模式SQLCODE是一个简单的整数。值为 0 表示成功，一个正值表示带附加信息的成功，一个负值表示一个错误。
SQL 标准只定义了正值 +100，它表示上一个命令返回或者影响了零行，并且没有特定的负值。
因此，这种模式只能实现很可怜的可移植性并且不具有层次性的代码分配。
历史上，PostgreSQL的嵌入式 SQL 处理器已经分配了一些特定的SQLCODE值供它使用，
它们的数字值和符号名称被列在下文。记住这些对其他 SQL 实现不是可移植的。
为了简化移植应用到SQLSTATE模式，对应的SQLSTATE也被列出。
不过，在两种模式之间没有一对一或者一对多的映射（事实上是多对多），
因此在每一种情况下你都应该参考附录 A中列出的全局SQLSTATE。
这些是分配的SQLCODE值：
0 (ECPG_NO_ERROR) #
表示没有错误。(SQLSTATE 00000)
100 (ECPG_NOT_FOUND) #
这是一个无害的情况，表明最后一条命令检索或处理了零行，或者您已到达
游标的末尾。(SQLSTATE 02000)
在循环中处理游标时，您可以使用以下代码作为检测何时中止循环的方式，
如下所示：
while (1)
{
EXEC SQL FETCH ... ;
if (sqlca.sqlcode == ECPG_NOT_FOUND)
break;
}
但是，WHENEVER NOT FOUND DO BREAK实际上在内部有效地
执行了这一操作，因此通常没有必要显式地写出这些代码。
-12 (ECPG_OUT_OF_MEMORY) #
表明您的虚拟内存已耗尽。数值定义为-ENOMEM。
（SQLSTATE YE001）
-200 (ECPG_UNSUPPORTED) #
表明预处理器生成了一些库无法识别的内容。可能是您正在运行
不兼容版本的预处理器和库。(SQLSTATE YE002)
-201 (ECPG_TOO_MANY_ARGUMENTS) #
这意味着指定的命令包含的主机变量比命令预期的要多。
（SQLSTATE 07001 或 07002）
-202 (ECPG_TOO_FEW_ARGUMENTS) #
这意味着指定的命令提供的主机变量比命令预期的要少。
（SQLSTATE 07001 或 07002）
-203 (ECPG_TOO_MANY_MATCHES) #
这意味着查询返回了多行结果，但语句只准备存储一行结果
（例如，因为指定的变量不是数组）。 （SQLSTATE 21000）
-204 (ECPG_INT_FORMAT) #
主机变量的类型是int，而数据库中的数据类型不同，并且包含一个无法解释为
int的值。库使用strtol()进行此转换。(SQLSTATE
42804)
-205 (ECPG_UINT_FORMAT) #
主机变量的类型是unsigned int，而数据库中的数据是不同的
类型，并且包含一个无法解释为unsigned int的值。库使用
strtoul()进行此转换。(SQLSTATE 42804)
-206 (ECPG_FLOAT_FORMAT) #
主机变量的类型是float，而数据库中的数据是另一种类型，
并且包含一个无法解释为float的值。库使用
strtod()进行此转换。(SQLSTATE 42804)
-207 (ECPG_NUMERIC_FORMAT) #
主机变量的类型是numeric，而数据库中的数据是另一种类型，
且包含的值无法解释为numeric值。(SQLSTATE 42804)
-208 (ECPG_INTERVAL_FORMAT) #
主机变量的类型是interval，而数据库中的数据是另一种类型，
并且包含一个无法解释为interval值的值。
（SQLSTATE 42804）
-209 (ECPG_DATE_FORMAT) #
主机变量的类型是date，而数据库中的数据是另一种类型，
并且包含一个无法解释为date值的值。
（SQLSTATE 42804）
-210 (ECPG_TIMESTAMP_FORMAT) #
主机变量的类型是timestamp，而数据库中的数据是另一种类型，
并且包含一个无法解释为timestamp值的值。
（SQLSTATE 42804）
-211 (ECPG_CONVERT_BOOL) #
这意味着主机变量的类型是bool，并且数据库中的数据既不是
't'也不是'f'。(SQLSTATE 42804)
-212 (ECPG_EMPTY) #
发送到PostgreSQL服务器的语句为空。
（这通常不会在嵌入式SQL程序中发生，因此可能指向一个内部错误。）
（SQLSTATE YE002）
-213 (ECPG_MISSING_INDICATOR) #
返回了一个空值，但未提供空指示变量。(SQLSTATE 22002)
-214 (ECPG_NO_ARRAY) #
在需要数组的地方使用了一个普通变量。(SQLSTATE 42804)
-215 (ECPG_DATA_NOT_ARRAY) #
数据库在需要数组值的地方返回了一个普通变量。(SQLSTATE 42804)
-216 (ECPG_ARRAY_INSERT) #
无法将该值插入到数组中。(SQLSTATE
42804)
-220 (ECPG_NO_CONN) #
程序尝试访问一个不存在的连接。
(SQLSTATE 08003)
-221 (ECPG_NOT_CONN) #
程序尝试访问一个存在但未打开的连接。（这是一个内部错误。）
（SQLSTATE YE002）
-230 (ECPG_INVALID_STMT) #
您尝试使用的语句尚未准备好。
(SQLSTATE 26000)
-239 (ECPG_INFORMIX_DUPLICATE_KEY) #
重复键错误，违反唯一约束（Informix兼容模式）。 (SQLSTATE 23505)
-240 (ECPG_UNKNOWN_DESCRIPTOR) #
未找到指定的描述符。您尝试使用的语句尚未准备好。(SQLSTATE 33000)
-241 (ECPG_INVALID_DESCRIPTOR_INDEX) #
指定的描述符索引超出了范围。(SQLSTATE 07009)
-242 (ECPG_UNKNOWN_DESCRIPTOR_ITEM) #
请求了一个无效的描述符项。（这是一个内部错误。）（SQLSTATE YE002）
-243 (ECPG_VAR_NOT_NUMERIC) #
在执行动态语句期间，数据库返回了一个数值，而主机变量不是数值。
（SQLSTATE 07006）
-244 (ECPG_VAR_NOT_CHAR) #
在执行动态语句期间，数据库返回了一个非数字值，而主机变量是数字类型。
（SQLSTATE 07006）
-284 (ECPG_INFORMIX_SUBSELECT_NOT_ONE) #
子查询的结果不是单行（Informix兼容模式）。 (SQLSTATE 21000)
-400 (ECPG_PGSQL) #
由PostgreSQL服务器引起的一些错误。
消息包含来自PostgreSQL服务器的错误信息。
-401 (ECPG_TRANS) #
PostgreSQL 服务器发出信号，表示我们无法启动、
提交或回滚事务。(SQLSTATE 08007)
-402 (ECPG_CONNECT) #
无法成功连接到数据库。(SQLSTATE 08001)
-403 (ECPG_DUPLICATE_KEY) #
重复键错误，违反唯一约束。(SQLSTATE 23505)
-404 (ECPG_SUBSELECT_NOT_ONE) #
子查询的结果不是单行。(SQLSTATE 21000)
-602 (ECPG_WARNING_UNKNOWN_PORTAL) #
指定了无效的游标名称。(SQLSTATE 34000)
-603 (ECPG_WARNING_IN_TRANSACTION) #
事务正在进行中。(SQLSTATE 25001)
-604 (ECPG_WARNING_NO_TRANSACTION) #
当前没有活动的（进行中的）事务。(SQLSTATE 25P01)
-605 (ECPG_WARNING_PORTAL_EXISTS) #
指定了一个已存在的游标名称。(SQLSTATE 42P03)
上一页 上一级 下一页34.7. 使用描述符区域 起始页 34.9. 预处理器指令
