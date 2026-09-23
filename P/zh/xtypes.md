# 36.13. 用户定义的类型

36.13. 用户定义的类型
版本：
纠错本页面
搜索
目录导航
❮
❯
36.13. 用户定义的类型 #36.13.1. TOAST 考量
如第 36.2 节中所述，
PostgreSQL能够被扩展成支持新的数据类型。这一节描述了如何定义新的基本类型，它们是被定义在SQL语言层面之下的数据类型。创建一种新的基本类型要求使用低层语言（通常是C）实现在该类型上操作的函数。
这一节中的例子可以在源代码src/tutorial目录下的complex.sql和complex.c中找到。运行这些例子的指令可以在该目录的README文件中找到。
一种用户定义的类型必须总是具有输入和输出函数。这些函数决定该类型如何出现在字符串中（用于用户输入和对用户的输出）以及如何在内存中组织该类型。输入函数采用一个空终止的字符串作为它的参数并返回该类型的内部（内存）表示。输出函数采用该类型的内部表示作为参数并返回一个空终止的字符串。如果我们想要对该类型做更多事情而不是只存储它，我们必须提供为我们想要的任何操作提供额外的实现函数。
假设我们想要定义一种类型complex，它表示复数。一种在内存中表示复数的自然方法是下面的C结构：
typedef struct Complex {
double      x;
double      y;
} Complex;
我们将需要让它成为一种传引用类型，因为它太大而无法放入一个单一的Datum值中。
至于该类型的外部字符串表示，我们选择了一种字符串形式的(x,y)。
输入和输出函数通常并不难编写，特别是输出函数。但是在定义类型的外部字符串表示时，记住你必须最终为该表示编写一个完整并且健壮的解析器作为你的输入函数。例如：
PG_FUNCTION_INFO_V1(complex_in);
Datum
complex_in(PG_FUNCTION_ARGS)
{
char       *str = PG_GETARG_CSTRING(0);
double      x,
y;
Complex    *result;
if (sscanf(str, " ( %lf , %lf )", &x, &y) != 2)
ereport(ERROR,
(errcode(ERRCODE_INVALID_TEXT_REPRESENTATION),
errmsg("invalid input syntax for type %s: \"%s\"",
"complex", str)));
result = (Complex *) palloc(sizeof(Complex));
result->x = x;
result->y = y;
PG_RETURN_POINTER(result);
}
输出函数可以简单地写作：
PG_FUNCTION_INFO_V1(complex_out);
Datum
complex_out(PG_FUNCTION_ARGS)
{
Complex    *complex = (Complex *) PG_GETARG_POINTER(0);
char       *result;
result = psprintf("(%g,%g)", complex->x, complex->y);
PG_RETURN_CSTRING(result);
}
你应当让输入和输出函数互为彼此的逆函数。如果不这样做，当你需要把数据转储到一个文件并且以后将它重新读入时会遇到很严重的问题。在涉及到浮点数时这是一个特别常见的问题。
可选地，一种用户定义的类型可以提供二进制输入和输出例程。二进制 I/O 通常比文本 I/O 更快但是可移植性更差。与文本 I/O 一样，定义准确的外部二进制表示是你需要负责的工作。大部分的内建数据类型都尝试提供一种不依赖机器的二进制表示。对于complex，我们的工作将建立在为类型float8提供的二进制 I/O 转换器上：
PG_FUNCTION_INFO_V1(complex_recv);
Datum
complex_recv(PG_FUNCTION_ARGS)
{
StringInfo  buf = (StringInfo) PG_GETARG_POINTER(0);
Complex    *result;
result = (Complex *) palloc(sizeof(Complex));
result->x = pq_getmsgfloat8(buf);
result->y = pq_getmsgfloat8(buf);
PG_RETURN_POINTER(result);
}
PG_FUNCTION_INFO_V1(complex_send);
Datum
complex_send(PG_FUNCTION_ARGS)
{
Complex    *complex = (Complex *) PG_GETARG_POINTER(0);
StringInfoData buf;
pq_begintypsend(&buf);
pq_sendfloat8(&buf, complex->x);
pq_sendfloat8(&buf, complex->y);
PG_RETURN_BYTEA_P(pq_endtypsend(&buf));
}
一旦我们编写了 I/O 函数并且把它们编译到了一个共享库中，我们就可以在 SQL 中定义complex类型。首先我们把它声明为一种 shell 类型：
CREATE TYPE complex;
这个语句的作用是为要定义的类型创建了一个占位符，这样允许我们在定义其 I/O 函数时引用该类型。现在我们可以定义 I/O 函数：
CREATE FUNCTION complex_in(cstring)
RETURNS complex
AS 'filename'
LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION complex_out(complex)
RETURNS cstring
AS 'filename'
LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION complex_recv(internal)
RETURNS complex
AS 'filename'
LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION complex_send(complex)
RETURNS bytea
AS 'filename'
LANGUAGE C IMMUTABLE STRICT;
最后，我们可以提供该数据类型的完整定义：
CREATE TYPE complex (
internallength = 16,
input = complex_in,
output = complex_out,
receive = complex_recv,
send = complex_send,
alignment = double
);
在定义了一种新的基本类型后，
PostgreSQL会自动提供对这种类型的数组支持。数组类型通常具有和基本类型相同的名称以及一个前置的下划线字符（_）。
一旦数据类型存在，我们就能够声明额外的函数来提供在该数据类型上有用的操作。然后可以在函数之上定义操作符，并且如果需要，可以创建操作符类来支持对该数据类型进行索引。这些额外的内容会在下面的小节中讨论。
如果数据类型的内部表示是可变长的，则内部表示必须遵循可变长数据的标准布局：头四个字节必须是一个char[4]域，它从来不会被直接访问（通常被称为vl_len_）。你必须使用SET_VARSIZE()宏在这个域中存储整个数据的尺寸（包括长度域本身），并且使用VARSIZE()来检索它（这些宏之所以存在，是因为长度域可能会根据平台来进行解码）。
更多细节请见CREATE TYPE命令的描述。
36.13.1. TOAST 考量 #
如果你的数据类型值的尺寸（内部形式）是可变的，更适合让该数据类型变成可
TOAST的（见第 66.2 节）。即便值总是很小不会被压缩或者存储在外部，你也应该
这样做，因为TOAST也能通过减少头部负荷来为小数据减少空间。
为了支持TOAST存储，在该数据类型上操作的 C 函数必须总是要使用PG_DETOAST_DATUM解包任何交给它们的被 TOAST 过的值（习惯上这些细节都通过定义类型相关的GETARG_DATATYPE_P宏隐藏起来）。然后，在运行CREATE TYPE命令时，指定内部长度为variable并且选择某个不是plain的适当的存储选项。
如果数据对齐无关紧要（不管是为一个特定函数或者因为数据类型指定了字节对齐），那么有可能避免PG_DETOAST_DATUM的一些开销。你可以转而使用PG_DETOAST_DATUM_PACKED（习惯上通过定义一个GETARG_DATATYPE_PP宏隐藏）并且使用宏VARSIZE_ANY_EXHDR以及VARDATA_ANY来访问一个可能包装过的数据。此外，即使数据类型定义指定了一种对齐方式，这些宏返回的数据也不是对齐过的。如果对齐对你很重要，你必须使用常规的PG_DETOAST_DATUM接口。
注意
老的代码经常声明vl_len_为一个int32域而不是char[4]。只要结构定义含有其他具有至少int32对齐的域，这就是 OK 的。但是在使用可能未对齐的数据时，使用这样一种结构定义就是危险的，编译器可能会把它当作一个授权来假定数据实际上已经被对齐，在对于对齐很严格的架构上会导致核心转储。
TOAST支持带来的另一个特性是能够拥有一种
扩展内存中数据表达，它比存储在磁盘上的格式使用起来更方便。
常规的或者“扁平的” varlena 存储格式最终只是一堆字节，它不能包含
指针，因为它可能会被复制到内存中的其他位置。对于复杂数据类型，扁平格式使
用起来可能代价更高，因此PostgreSQL提供了一种方式把
扁平格式“扩展”成更适合计算的一种表达，然后在该数据类型的函数之
间传递这种在内存中的格式。
要使用扩展存储，数据类型必须遵循src/include/utils/expandeddatum.h
中给定的规则定义一种扩展的格式，并且提供函数把扁平的 varlena 值“扩展”
到该格式以及从该格式“扁平化”回常规的 varlena 表达。然后确保所有该
数据类型的 C 函数都能接受这两种表达（可能通过一接收到其中一种就立刻
转换成另一种来做到）。这不要求一次性修改所有该数据类型的现有函数，
因为标准的PG_DETOAST_DATUM宏可以把扩展输入转换
成常规扁平格式。因此，现有的用于扁平 varlena 格式的函数仍然能够用于
扩展输入（虽然效率略低）。它不需要被转换，直到需要提高性能。
C 函数知道如何处理扩展表示通常分为两类：只能处理扩展格式的，以及
能同时处理扩展或扁平 varlena 输入的。前者更容易编写，但是可能总体效率
较低，因为由单个函数将一种扁平输入转换为扩展的形式的开销可能会超过在
扩展格式上操作所节省的开销。当只需要处理扩展格式时，可以把扁平输入到
扩展形式的转换隐藏在一个参数获取宏中，这样该函数就显得不比处理传统
varlena 输入的函数更复杂了。要处理两种类型的输入，需要编写一个参数获取
函数来反 TOAST 外部、短头部以及压缩的 varlena 输入，但不需要处理扩展
输入。这样一个函数可以被定义为返回一个指向由扁平 varlena 格式和扩展
格式组成的联合的指针。调用者可以使用
VARATT_IS_EXPANDED_HEADER()宏来判断它们接收到的
是哪种格式。
TOAST机制不仅允许把常规 varlena 值同扩展值区分开来，
还能区分指向扩展值的“read-write”和“read-only”
指针。只需要检查扩展值或者只会以安全的并且非语义可见的方式更改扩展
值的 C 函数不需要关心它们收到的是哪种类型的指针。如果收到一个读写
指针，要为输入值产生一个修改版本的 C 函数将被允许就地修改该扩展输入
值，但是如果它们收到的是一个只读指针则不能修改，在这种情况下它们不
得不先复制该值产生一个用于修改的新值。构建了新扩展值的 C 函数应该总
是返回一个指向该值的读写指针。还有，如果一个就地修改读写扩展值的 C
函数中途失败，它应该负责让该值处于一种正常的状态。
有关使用扩展值的例子，请见标准数组基础结构，特别是
src/backend/utils/adt/array_expanded.c。
上一页 上一级 下一页36.12. 用户定义的聚合 起始页 36.14. 用户定义的操作符
