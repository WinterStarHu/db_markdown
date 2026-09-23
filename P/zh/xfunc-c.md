# 36.10. C语言函数

36.10. C语言函数
版本：
纠错本页面
搜索
目录导航
❮
❯
36.10. C语言函数 #36.10.1. 动态载入36.10.2. Base Types in C-Language Functions36.10.3. 版本 1 的调用约定36.10.4. 编写代码36.10.5. 编译和链接动态加载的函数36.10.6. 服务器 API 和 ABI 稳定性指南36.10.7. 复合类型参数36.10.8. 返回行（组合类型）36.10.9. 返回集合36.10.10. 多态参数和返回类型36.10.11. 共享内存36.10.12. LWLocks36.10.13. 自定义等待事件36.10.14. 注入点36.10.15. 自定义累积统计36.10.16. 使用 C++ 进行可扩展性
用户定义的函数可以用 C 编写（或者可以与 C 兼容的语言，例如 C++）。
这类函数被编译成动态载入对象（也被称为共享库）并且由服务器在
需要时载入。动态载入是把“C语言”函数和
“内部”函数区分开的特性 — 两者真正的编码习惯
实际上是一样的（因此，标准的内部函数库是用户定义的 C 函数很好
的源代码实例）。
当前仅有一种调用约定被用于 C 函数（“版本 1”）。如下文所示，为函数编写一个PG_FUNCTION_INFO_V1()宏就能指示对该调用约定的支持。
36.10.1. 动态载入 #
在一个会话中第一次调用一个特定可载入对象文件中的用户定义函数时，
动态载入器会把那个对象文件载入到内存以便该函数被调用。因此用户
定义的 C 函数的CREATE FUNCTION必须
为该函数指定两块信息：可载入对象文件的名称，以及要在该对象文件中
调用的特定函数的 C 名称（链接符号）。如果没有显式指定 C 名称，则
它被假定为和 SQL 函数名相同。
下面的算法被用来基于CREATE FUNCTION
命令中给定的名称来定位共享对象文件：
如果名称是一个绝对路径，则载入给定的文件。
如果该名称以字符串$libdir开始，那么这一部分会被
PostgreSQL包的库目录名（在编译时确定）替换。
如果该名称不包含目录部分，会在配置变量
dynamic_library_path指定的路径中搜索该
文件。
否则（在该路径中没找到该文件，或者它包含一个非绝对目录），
动态载入器将尝试接受给定的名称，这大部分会导致失败（依赖
当前工作目录是不可靠的）。
如果这个序列不起作用，会把平台相关的共享库文件名扩展（通常是
.so）追加到给定的名称并且再次尝试上述
的过程。如果还是失败，则载入失败。
我们推荐相对于$libdir或者通过动态库路径来
定位共享库。如果升级版本时新的安装在一个不同的位置，则可以
简化升级过程。$libdir实际表示的目录可以用
命令pg_config --pkglibdir来找到。
用于运行PostgreSQL服务器的
用户 ID 必须能够通过要载入文件的路径。常见的错误是把文件或
更高层的目录变得对postgres用户
不可读或者不可执行。
在任何情况下，CREATE FUNCTION命令
中给定的文件名会被原封不动地记录在系统目录中，这样如果需要再次
载入该文件则会应用同样的过程。
注意
PostgreSQL不会自动编译 C 函数。在
从CREATE FUNCTION命令中引用对象文件
之前，它必须先被编译好。更多信息请见第 36.10.5 节。
为确保动态加载的对象文件不会加载到不兼容的服务器中，PostgreSQL 检查该文件是否包含适当内容的 “魔术块”。
这使得服务器能够检测明显的不兼容性，例如为不同主版本的
PostgreSQL 编译的代码。要包含魔术块，
请在一个（且仅一个）模块源文件中编写以下内容，在包含头文件 fmgr.h 之后：
PG_MODULE_MAGIC;
或
PG_MODULE_MAGIC_EXT(parameters);
PG_MODULE_MAGIC_EXT 变体允许指定有关模块的附加信息；目前，可以添加名称和/或版本字符串。
（未来可能允许更多字段。）
请写成如下形式：
PG_MODULE_MAGIC_EXT(
.name = "my_module_name",
.version = "1.2.3"
);
随后可以通过 pg_get_loaded_modules() 函数检查名称和版本。
版本字符串的含义不受 PostgreSQL 限制，但建议使用语义版本控制规则。
在被第一次使用后，动态加载的对象文件会留在内存中。在同一个会话中
对该文件的函数未来的调用将只会消耗很小的负荷进行符号表查找。如果需要
重新加载一个对象文件（例如重新编译以后），需要开始一个新的会话。
可选地，一个动态加载的文件可以包含一个初始化函数。如果文件包含一个名为
_PG_init的函数，该函数将在加载文件后立即被调用。
该函数不接收任何参数，应该返回void。目前没有办法卸载一个动态加载的文件。
36.10.2. Base Types in C-Language Functions #
要了解如何编写 C 语言函数，你需要了解
PostgreSQL如何在内部表示基本数据类型
以及如何与函数传递它们。在内部，
PostgreSQL把一个基本类型视为
“一块内存”。在类型上定义的用户定义函数说明了
PostgreSQL在该类型上操作的方式。也就是说，
PostgreSQL将只负责把数据存储到磁盘以及
从磁盘检索数据，而使用你的用户定义函数来输入、处理和输出该数据。
基本类型可以有三种内部格式之一：
传值，定长
传引用，定长
传引用，变长
传值类型在长度上只能是 1、2 或 4 字节（如果你的机器上
sizeof(Datum)是 8，则还有 8 字节）。你应当小心地
定义你的类型以便它们在所有的架构上都是相同的尺寸（字节）。例如，
long类型很危险，因为它在某些机器上是 4 字节但在
另外一些机器上是 8 字节，而int类型在大部分 Unix 机器
上都是 4 字节。在 Unix 机器上int4类型一种合理的实现
可能是：
/* 4 字节整数，传值 */
typedef int int4;
（实际的 PostgreSQL C 代码会把这种类型称为int32，因为
C 中的习惯是intXX
表示XX 位。注意
因此还有尺寸为 1 字节的 C 类型int8。SQL 类型
int8在 C 中被称为int64。另见
表 36.2）。
另一方面，任何尺寸的定长类型可以通过引用传递。例如，这里有一种
PostgreSQL类型的实现示例：
/* 16 字节结构，传引用 */
typedef struct
{
double  x, y;
} Point;
在PostgreSQL函数中传入或传出这种
类型时，只能使用指向这种类型的指针。要返回这样一种类型的值，用
palloc分配正确的内存量，然后填充分配好的内存，
并返回一个指向该内存的指针。（另外，如果只想返回与具有相同数据类型的
一个输入参数相同的值，可以跳过额外的palloc并返回
指向该输入值的指针。）
最后，所有变长类型也必须通过引用传递。所有变长类型必须用一个
正好 4 字节的不透明长度域开始，该域会由SET_VARSIZE
设置，绝不要直接设置该域！所有要存储在该类型中的数据必须在内存
中紧接着该长度域的后面存储。长度域包含该结构的总长度，也就是包括
长度域本身的尺寸。
另一个重点是要避免在数据类型值中留下未被初始化的位。例如，要注意
把可能存在于结构中的任何对齐填充字节置零。如果不这样做，你的数据
类型的逻辑等价常量可能会被规划器认为是不等的，进而导致低效的（不过
还是正确的）计划。
警告
绝不要修改通过引用传递的输入值的内容。如果这样做
很可能会破坏磁盘上的数据，因为给出的指针可能直接指向一个磁盘缓冲
区。这条规则唯一的例外在第 36.12 节中有解释。
例如，我们可以这样定义类型text：
typedef struct {
int32 length;
char data[FLEXIBLE_ARRAY_MEMBER];
} text;
[FLEXIBLE_ARRAY_MEMBER]记号表示数据部分的实际
长度不由该声明指定。
在操纵变长类型时，我们必须小心地分配正确数量的内存并且正确地
设置长度字段。例如，如果我们想在一个text结构
中存储 40 字节，我们可以使用这样的代码片段：
#include "postgres.h"
...
char buffer[40]; /* our source data */
...
text *destination = (text *) palloc(VARHDRSZ + 40);
SET_VARSIZE(destination, VARHDRSZ + 40);
memcpy(destination->data, buffer, 40);
...
VARHDRSZ和sizeof(int32)一样，
但是用宏VARHDRSZ来引用变长类型的开销的
尺寸被认为是比较好的风格。还有，长度字段必须
使用SET_VARSIZE宏来设置，而不是用
简单的赋值来设置。
表 36.2显示了许多内置SQL数据类型对应的C类型，
PostgreSQL的。“Defined In”列给出了
需要包含的头文件，以获取类型定义。（实际的定义可能位于所列文件
包含的其他文件中。建议用户坚持使用已定义的接口。）请注意，您应该
始终首先在服务器代码的任何源文件中包含postgres.h，
因为它声明了您将需要的许多内容，并且因为先包含其他头文件可能会
导致可移植性问题。
表 36.2. 内置 SQL 类型等效的 C 类型
SQL 类型
C 类型
定义文件
booleanboolpostgres.h（可能是编译器内建）boxBOX*utils/geo_decls.hbyteabytea*postgres.h"char"char（编译器内建）characterBpChar*postgres.hcidCommandIdpostgres.hdateDateADTutils/date.hfloat4 (real)float4postgres.hfloat8 (double precision)float8postgres.hint2 (smallint)int16postgres.hint4 (integer)int32postgres.hint8 (bigint)int64postgres.hintervalInterval*datatype/timestamp.hlsegLSEG*utils/geo_decls.hnameNamepostgres.hnumericNumericutils/numeric.hoidOidpostgres.hoidvectoroidvector*postgres.hpathPATH*utils/geo_decls.hpointPOINT*utils/geo_decls.hregprocRegProcedurepostgres.htexttext*postgres.htidItemPointerstorage/itemptr.htimeTimeADTutils/date.htime with time zoneTimeTzADTutils/date.htimestampTimestampdatatype/timestamp.htimestamp with time zoneTimestampTzdatatype/timestamp.hvarcharVarChar*postgres.hxidTransactionIdpostgres.h
现在我们已经复习了基本类型所有可能的结构，接下来可以展示一些
真实函数的例子。
36.10.3. 版本 1 的调用约定 #
版本-1 的调用规范依赖于宏来降低传参数和结果的复杂度。版本-1 函数的
C 声明总是：
Datum funcname(PG_FUNCTION_ARGS)
此外，宏调用：
PG_FUNCTION_INFO_V1(funcname);
必须出现在同一个源文件中（按惯例会正好写在该函数本身之前）。
这种宏调用不是internal语言函数所需要的，因为
PostgreSQL会假定所有内部函数都使用
版本-1 规范。不过，对于动态载入函数是必需的。
在版本-1 函数中，每一个实参都使用对应于该参数数据类型的PG_GETARG_xxx()宏取得。（在非严格的函数中，需要使用PG_ARGISNULL()对参数是否为空提前做检查；见下文。）结果要用对应于返回类型的PG_RETURN_xxx()宏返回。PG_GETARG_xxx()的参数是要取得的函数参数的编号，从零开始计。PG_RETURN_xxx()的参数是实际要返回的值。
要调用另一个版本-1 函数，可以使用
DirectFunctionCalln(func,
arg1, ..., argn)。这在您想要调用标准内部库中定义的函数时特别有用，使用与其 SQL 签名类似的接口。
这些便利函数和类似的函数可以在 fmgr.h 中找到。
DirectFunctionCalln 系列期望其第一个参数为 C 函数名称。
还有 OidFunctionCalln，它们接受目标函数的 OID，以及其他一些变体。
所有这些都期望函数的参数以 Datum 形式提供，并且同样返回 Datum。
请注意，在使用这些便利函数时，参数和结果都不允许为 NULL。
例如，要从 C 调用 starts_with(text, text) 函数，您可以在目录中搜索并发现
其 C 实现是 Datum text_starts_with(PG_FUNCTION_ARGS) 函数。通常，您会
使用 DirectFunctionCall2(text_starts_with, ...) 来调用这样的函数。
然而，starts_with(text, text) 需要排序信息，因此如果以那种方式调用，将会失败
并出现 “无法确定用于字符串比较的排序规则” 的错误。相反，您必须
使用 DirectFunctionCall2Coll(text_starts_with, ...) 并提供所需的排序规则，通常是从
PG_GET_COLLATION() 传递过来的，如下面的示例所示。
fmgr.h 还提供了宏，方便在 C 类型和
Datum 之间进行转换。例如，要将
Datum 转换为 text*，可以使用
DatumGetTextPP(X)。虽然某些类型有
名为 TypeGetDatum(X) 的宏用于反向
转换，但 text* 没有；使用通用宏
PointerGetDatum(X) 就足够了。
如果您的扩展定义了其他类型，通常也方便为您的类型
定义类似的宏。
这里是一些使用版本-1调用约定的例子：
#include "postgres.h"
#include <string.h>
#include "fmgr.h"
#include "utils/geo_decls.h"
#include "varatt.h"
PG_MODULE_MAGIC;
/* by value */
PG_FUNCTION_INFO_V1(add_one);
Datum
add_one(PG_FUNCTION_ARGS)
{
int32   arg = PG_GETARG_INT32(0);
PG_RETURN_INT32(arg + 1);
}
/* by reference, fixed length */
PG_FUNCTION_INFO_V1(add_one_float8);
Datum
add_one_float8(PG_FUNCTION_ARGS)
{
/* The macros for FLOAT8 hide its pass-by-reference nature. */
float8   arg = PG_GETARG_FLOAT8(0);
PG_RETURN_FLOAT8(arg + 1.0);
}
PG_FUNCTION_INFO_V1(makepoint);
Datum
makepoint(PG_FUNCTION_ARGS)
{
/* Here, the pass-by-reference nature of Point is not hidden. */
Point     *pointx = PG_GETARG_POINT_P(0);
Point     *pointy = PG_GETARG_POINT_P(1);
Point     *new_point = (Point *) palloc(sizeof(Point));
new_point->x = pointx->x;
new_point->y = pointy->y;
PG_RETURN_POINT_P(new_point);
}
/* by reference, variable length */
PG_FUNCTION_INFO_V1(copytext);
Datum
copytext(PG_FUNCTION_ARGS)
{
text     *t = PG_GETARG_TEXT_PP(0);
/*
* VARSIZE_ANY_EXHDR is the size of the struct in bytes, minus the
* VARHDRSZ or VARHDRSZ_SHORT of its header.  Construct the copy with a
* full-length header.
*/
text     *new_t = (text *) palloc(VARSIZE_ANY_EXHDR(t) + VARHDRSZ);
SET_VARSIZE(new_t, VARSIZE_ANY_EXHDR(t) + VARHDRSZ);
/*
* VARDATA is a pointer to the data region of the new struct.  The source
* could be a short datum, so retrieve its data through VARDATA_ANY.
*/
memcpy(VARDATA(new_t),          /* destination */
VARDATA_ANY(t),          /* source */
VARSIZE_ANY_EXHDR(t));   /* how many bytes */
PG_RETURN_TEXT_P(new_t);
}
PG_FUNCTION_INFO_V1(concat_text);
Datum
concat_text(PG_FUNCTION_ARGS)
{
text  *arg1 = PG_GETARG_TEXT_PP(0);
text  *arg2 = PG_GETARG_TEXT_PP(1);
int32 arg1_size = VARSIZE_ANY_EXHDR(arg1);
int32 arg2_size = VARSIZE_ANY_EXHDR(arg2);
int32 new_text_size = arg1_size + arg2_size + VARHDRSZ;
text *new_text = (text *) palloc(new_text_size);
SET_VARSIZE(new_text, new_text_size);
memcpy(VARDATA(new_text), VARDATA_ANY(arg1), arg1_size);
memcpy(VARDATA(new_text) + arg1_size, VARDATA_ANY(arg2), arg2_size);
PG_RETURN_TEXT_P(new_text);
}
/* A wrapper around starts_with(text, text) */
PG_FUNCTION_INFO_V1(t_starts_with);
Datum
t_starts_with(PG_FUNCTION_ARGS)
{
text       *t1 = PG_GETARG_TEXT_PP(0);
text       *t2 = PG_GETARG_TEXT_PP(1);
Oid         collid = PG_GET_COLLATION();
bool        result;
result = DatumGetBool(DirectFunctionCall2Coll(text_starts_with,
collid,
PointerGetDatum(t1),
PointerGetDatum(t2)));
PG_RETURN_BOOL(result);
}
假定上述代码已经准备在文件 funcs.c 中并且被编译成一个共享对象，我们可以用这样的命令在 PostgreSQL 中定义函数：
CREATE FUNCTION add_one(integer) RETURNS integer
AS 'DIRECTORY/funcs', 'add_one'
LANGUAGE C STRICT;
-- 注意 SQL 函数名称 "add_one" 的重载
CREATE FUNCTION add_one(double precision) RETURNS double precision
AS 'DIRECTORY/funcs', 'add_one_float8'
LANGUAGE C STRICT;
CREATE FUNCTION makepoint(point, point) RETURNS point
AS 'DIRECTORY/funcs', 'makepoint'
LANGUAGE C STRICT;
CREATE FUNCTION copytext(text) RETURNS text
AS 'DIRECTORY/funcs', 'copytext'
LANGUAGE C STRICT;
CREATE FUNCTION concat_text(text, text) RETURNS text
AS 'DIRECTORY/funcs', 'concat_text'
LANGUAGE C STRICT;
CREATE FUNCTION t_starts_with(text, text) RETURNS boolean
AS 'DIRECTORY/funcs', 't_starts_with'
LANGUAGE C STRICT;
这里，DIRECTORY 表示共享库文件的目录（例如 PostgreSQL 的教程目录，它包含这一节中用到的例子的代码）。（更好的风格是先把 DIRECTORY 放入搜索路径，在 AS 子句中只使用 'funcs'。在任何情况下，我们可以为一个共享库省略系统相关的扩展名，通常是 .so。）
注意我们已经把函数指定为 “strict”，这意味着如果有任何输入值为空，系统应该自动假定得到空结果。通过这种做法，我们避免在函数代码中检查空值输入。如果不这样做，我们必须使用 PG_ARGISNULL() 明确地检查空值输入。
宏PG_ARGISNULL(n)允许一个函数测试是否每一个输入为空（当然，只需要在没有声明为“strict”的函数中这样做）。和PG_GETARG_xxx()宏一样，输入参数也是从零开始计数。注意应该在验证了一个参数不是空之后才执行PG_GETARG_xxx()。要返回一个空结果，应执行PG_RETURN_NULL()，它对严格的以及非严格的函数都有用。
乍一看，与使用普通的C调用约定相比，版本 1 编码约定似乎只是毫无意义的愚民政策。
然而，它们确实允许我们处理NULLable 参数/返回值，以及“toasted”（压缩或离线）值。
在版本-1接口中提供的其他选项是PG_GETARG_xxx()宏的两个变种。其中的第一种是PG_GETARG_xxx_COPY()，它确保返回的指定参数的拷贝可以被安全地写入（通常的宏有时会返回一个指向表中物理存储的值，它不能被写入。使用PG_GETARG_xxx_COPY()宏可以保证得到一个可写的结果）。第二种变种是PG_GETARG_xxx_SLICE()宏有三个参数。第一个是函数参数的编号（如上文）。第二个和第三个是要被返回的段的偏移量和长度。偏移量从零开始计算，而负值的长度则表示要求返回该值的剩余部分。当大型值的存储类型为“external”时，这些宏提供了访问这些大型值的更有效的方法（列的存储类型可以使用ALTER TABLE tablename ALTER COLUMN colname SET STORAGE storagetype来指定。storagetype取plain、external、extended或者main）。
最后，版本-1 的函数调用规范可以返回集合结果（第 36.10.9 节）、实现触发器函数（第 37 章）和过程语言调用处理器（第 57 章）。更多细节
可见源代码发布中的src/backend/utils/fmgr/README。
36.10.4. 编写代码 #
在开始更高级的话题之前，我们应该讨论一下用于
PostgreSQL C 语言函数的编码规则。
虽然可以把不是 C 编写的函数载入到
PostgreSQL中，这通常是很困难的，
因为其他语言（例如 C++、FORTRAN 或者 Pascal）通常不会遵循和 C
相同的调用规范。也就是说，其他语言不会以同样的方式在函数之间传递
参数以及返回值。由于这个原因，我们会假定你的 C 语言函数确实是用 C
编写的。
编写和编译 C 函数的基本规则如下：
使用pg_config
--includedir-server
找出PostgreSQL服务器头文件安装在
系统的哪个位置。
编译并且链接你的代码（这样它就能被动态载入到
PostgreSQL中）总是
要求特殊的标志。对特定的操作系统的做法详见
第 36.10.5 节。
记住为你的共享库按第 36.10.1 节中所述
定义一个“magic block”。
在分配内存时，使用
PostgreSQL函数
palloc和 pfree，
而不是使用对应的 C 库函数
malloc和free。
在每个事务结束时会自动释放通过palloc
分配的内存，以免内存泄露。
总是要使用memset把你的结构中的字节置零（或者
最开始就用palloc0分配它们）。即使你对结构中的
每个域都赋值，也可能有对齐填充（结构中的空洞）包含着垃圾值。
如果不这样做，很难支持哈希索引或哈希连接，因为你必须选出数据
结构中有意义的位进行哈希计算。规划器有时也依赖于用按位相等来
比较常量，因此如果逻辑等价的值不是按位相等的会导致出现不想要
的规划结果。
大部分的内部PostgreSQL类型
都声明在postgres.h中，不过函数管理器
接口（PG_FUNCTION_ARGS等）在
fmgr.h中，因此你将需要包括至少这两个
文件。为了移植性，最好在包括任何其他系统或者用户头文件之前，
先包括postgres.h。包
括postgres.h也将会为你包括
elog.h和palloc.h。
对象文件中定义的符号名不能相互冲突或者与
PostgreSQL服务器可执行程序中
定义的符号冲突。如果出现有关于此的错误消息，你将必须重命名你的
函数或者变量。
36.10.5. 编译和链接动态加载的函数 #
在使用 C 编写的PostgreSQL扩展函数之前，必须以一种特殊的方式编译并链接它们，以便产生一个能被服务器动态加载的文件。简而言之，需要创建一个共享库。
超出本节所含内容之外的信息请参考你的操作系统文档，特别是 C 编译器（cc）和链接编辑器（ld）的手册页。另外，PostgreSQL源代码的contrib目录中包含了一些可以工作的例子。但是，如果你依靠这些例子，也会使你的模块依赖于PostgreSQL源代码的可用性。
创建共享库通常与链接可执行文件相似：首先源文件被编译成对象文件，然后对象文件被链接起来。对象文件需要被创建为位置无关代码（PIC），，这在概念上意味着当它们被可执行文件加载时，它们可以被放置在内存中的任意位置（用于可执行文件的对象文件通常不会以那种方式编译）。链接一个共享库的命令会包含特殊标志来把它与链接一个可执行文件区分开（至少在理论上 — 在某些系统上实际上很丑陋）。
在下列例子中，我们假定你的源代码在一个文件foo.c中，并且我们将创建一个共享库foo.so。除非特别注明，中间的对象文件将被称为foo.o。一个共享库能包含多于一个对象文件，但是我们在这里只使用一个。
FreeBSD
用于创建PIC的编译器标志是
-fPIC。要创建共享库，编译器标志是
-shared。
cc -fPIC -c foo.c
cc -shared -o foo.so foo.o
该方法适用于版本13.0及以上的
FreeBSD，较旧版本使用
gcc编译器。
Linux
创建PIC的编译器标志是-fPIC。创建一个共享库的编译器标志是-shared。一个完整的例子看起来像：
cc -fPIC -c foo.c
cc -shared -o foo.so foo.o
macOS
这里是一个例子。它假定安装了开发者工具。
cc -c foo.c
cc -bundle -flat_namespace -undefined suppress -o foo.so foo.o
NetBSD
创建PIC的编译器标志是-fPIC。对于ELF系统，带着标志-shared的编译器被用来链接共享库。在旧的非ELF系统上，ld -Bshareable会被使用。
gcc -fPIC -c foo.c
gcc -shared -o foo.so foo.o
OpenBSD
创建PIC的编译器标志是-fPIC。ld -Bshareable被用来链接共享库。
gcc -fPIC -c foo.c
ld -Bshareable -o foo.so foo.o
Solaris
创建PIC的编译器标志是-KPIC（用于 Sun 编译器）以及-fPIC（用于GCC）。要链接共享库，编译器选项对几种编译器都是-G或者是对GCC使用-shared。
cc -KPIC -c foo.c
cc -G -o foo.so foo.o
或
gcc -fPIC -c foo.c
gcc -G -o foo.so foo.o
提示
如果这对你来说太复杂，你应该考虑使用
GNU Libtool，它会用一个统一的接口隐藏平台差异。
结果的共享库文件接着就可以被载入到PostgreSQL。当把文件名指定给CREATE FUNCTION命令时，必须把共享库文件的名字给它，而不是中间的对象文件。注意系统的标准共享库扩展（通常是.so或者.sl）在CREATE FUNCTION命令中可以被忽略，并且通常为了最佳可移植性应该被忽略。
有关服务器期望在哪里寻找共享库文件，请参考第 36.10.1 节。
36.10.6. 服务器 API 和 ABI 稳定性指南 #
本节包含有关 PostgreSQL 服务器的
扩展和其他服务器插件的 API 和 ABI 稳定性的指南。
36.10.6.1. 概述 #
PostgreSQL 服务器包含多个
明确划分的 API，用于服务器插件，例如函数管理器
(fmgr，在本章中描述)，
SPI (第 45 章)
以及专门为扩展设计的各种钩子。这些接口经过精心
管理，以确保长期的稳定性和兼容性。然而，服务器中
的所有全局函数和变量实际上构成了公开可用的 API，
其中大多数并不是以可扩展性和长期稳定性为目标设计的。
因此，虽然利用这些接口是有效的，但越是偏离
既定路径，就越可能在某个时刻遇到 API 或 ABI
兼容性问题。鼓励扩展作者提供关于其需求的反馈，
以便随着时间的推移，随着新使用模式的出现，
某些接口可以被认为是更稳定的，或者可以添加新的、
设计更好的接口。
36.10.6.2. API 兼容性 #
API，即应用程序编程接口，是在编译时
使用的接口。
36.10.6.2.1. 主要版本 #
在 PostgreSQL 主要版本之间
没有 API 兼容性的承诺。因此，扩展代码
可能需要源代码更改才能与多个主要版本兼容。这通常可以
通过预处理器条件来管理，例如 #if PG_VERSION_NUM >= 160000。
使用超出明确划分的接口的复杂扩展通常需要为每个主要
服务器版本进行一些这样的更改。
36.10.6.2.2. 次要版本 #
PostgreSQL 努力避免在小版本中破坏服务器
API。一般来说，编译并在小版本中工作的扩展代码也应该能在同一
主版本的任何其他小版本中编译和工作，无论是过去的还是未来的。
当需要进行更改时，将会仔细管理，考虑到扩展的
需求。这些更改将在发布说明中进行沟通（附录 E）。
36.10.6.3. ABI 兼容性 #
ABI，即应用程序二进制接口，是在运行时使用的
接口。
36.10.6.3.1. 主要版本 #
不同主版本的服务器故意具有不兼容的 ABI。因此，使用服务器 API
的扩展必须为每个主版本重新编译。包含 PG_MODULE_MAGIC
（见 第 36.10.1 节）确保为一个主版本编译的代码
将被其他主版本拒绝。
36.10.6.3.2. 次要版本 #
PostgreSQL 努力避免在小版本中破坏服务器
ABI。一般来说，针对任何小版本编译的扩展应该能在同一主版本的
任何其他小版本中工作，无论是过去的还是未来的。
当需要进行更改时，PostgreSQL 将选择尽可能少侵入性的更改，
例如通过将新字段压缩到填充空间或将其附加到结构的末尾。这类更改
不应影响扩展，除非它们使用非常不寻常的代码模式。
然而，在少数情况下，即使是这样的非侵入性更改也可能不切实际或
不可能。在这种情况下，将会仔细管理更改，考虑到扩展的需求。这些
更改也将在发布说明中记录（附录 E）。
然而，请注意，服务器的许多部分并不是作为公开可用的 API 设计或
维护的（而且在大多数情况下，实际边界也没有明确定义）。如果出现
紧急需求，这些部分的更改自然会在考虑扩展代码时不如在明确定义
和广泛使用的接口中那么周到。
此外，在缺乏对这些更改的自动检测的情况下，这并不是一个保证，
但历史上这样的破坏性更改是极其罕见的。
36.10.7. 复合类型参数 #
组合类型没有像 C 结构那样的固定布局。组合类型的实例可能包含
空值域。此外，继承层次中的组合类型可能具有和同一继承层次中
其他成员不同的域。因此，
PostgreSQL 提供了函数接口
来访问 C 的组合类型的域。
假设我们想要写一个函数来回答查询：
SELECT name, c_overpaid(emp, 1500) AS overpaid
FROM emp
WHERE name = 'Bill' OR name = 'Sam';
如果使用版本-1的调用规范，我们可以定义
c_overpaid为：
#include "postgres.h"
#include "executor/executor.h"  /* 用于 GetAttributeByName() */
PG_MODULE_MAGIC;
PG_FUNCTION_INFO_V1(c_overpaid);
Datum
c_overpaid(PG_FUNCTION_ARGS)
{
HeapTupleHeader  t = PG_GETARG_HEAPTUPLEHEADER(0);
int32            limit = PG_GETARG_INT32(1);
bool isnull;
Datum salary;
salary = GetAttributeByName(t, "salary", &isnull);
if (isnull)
PG_RETURN_BOOL(false);
/* 另外，我们可能更想对空 salary 用 PG_RETURN_NULL() 。*/
PG_RETURN_BOOL(DatumGetInt32(salary) > limit);
}
GetAttributeByName 是
PostgreSQL 系统函数，
用于从指定的行中返回属性。它有三个参数：
一个类型为 HeapTupleHeader 的参数传递给
函数，所需属性的名称，以及一个返回参数，用于指示
属性是否为 null。GetAttributeByName 返回一个
Datum 值，您可以通过使用适当的
DatumGetXXX() 函数将其转换为正确的数据类型。
请注意，如果 null 标志被设置，返回值是无意义的；
在尝试对结果进行任何操作之前，请始终检查 null 标志。
也有GetAttributeByNum函数，它可以用目标属性
的列号而不是属性名来选择目标属性。
下面的命令声明 SQL 中的c_overpaid：
CREATE FUNCTION c_overpaid(emp, integer) RETURNS boolean
AS 'DIRECTORY/funcs', 'c_overpaid'
LANGUAGE C STRICT;
注意我们用了STRICT，这样我们不需要检查输入参数是否
为 NULL。
36.10.8. 返回行（组合类型） #
要从一个 C 语言函数中返回一个行或者组合类型值，你可以使用一种
特殊的 API，它提供的宏和函数隐藏了大部分的构建组合数据类型的
复杂性。要使用这种 API，源文件中必须包括：
#include "funcapi.h"
有两种方式可以构建一个组合数据值（以后就叫一个“元组”）：
可以从一个 Datum 值的数组构造，或者从一个 C 字符串（可被传递给该元组
各列的数据类型的输入转换函数）的数组构造。在两种情况下，都首先需要为
该元组的结构获得或者构造一个TupleDesc描述符。在处
理 Datum 时，需要把该TupleDesc传递给
BlessTupleDesc，接着为每一行调用
heap_form_tuple。在处理 C 字符串时，需要把该
TupleDesc传递给
TupleDescGetAttInMetadata，接着为每一行调用
BuildTupleFromCStrings。对于返回一个元组集合的函数，
这些设置步骤可以在第一次调用该函数时一次性完成。
有一些助手函数可以用来设置所需的TupleDesc。在大部分
返回组合值的函数中推荐的方式是调用：
TypeFuncClass get_call_result_type(FunctionCallInfo fcinfo,
Oid *resultTypeId,
TupleDesc *resultTupleDesc)
传递传给调用函数本身的同一个fcinfo结构（这当然要求使用的
是版本-1 的调用规范）。resultTypeId可以被指定为
NULL或者一个本地变量的地址以接收该函数的结果类型 OID。
resultTupleDesc应该是一个本地
TupleDesc变量的地址。检查结果是不是
TYPEFUNC_COMPOSITE，如果是则
resultTupleDesc已经被用所需的
TupleDesc填充（如果不是，你可以报告一个错误，并且
返回“function returning record called in context that
cannot accept type record”字样的消息）。
提示
get_call_result_type能够解析一个多态函数结果的实际类型，
因此不仅在返回组合类型的函数中，在返回标量多态结果的函数中它也是非常
有用的。resultTypeId输出主要用于返回多态标量的函数。
注意
get_call_result_type有一个兄弟
get_expr_result_type，它可以用来解析被表示为一棵表达式
树的函数调用的输出类型。在尝试确定来自函数外部的结果类型时可以用它。
也有一个get_func_result_type，当只有函数的 OID 可用时
可以用它。不过这些函数无法处理被声明为返回record的
函数，并且get_func_result_type无法解析多态类型，因此你
应该优先使用get_call_result_type。
比较老的，现在已经被废弃的获得TupleDesc的函数是：
TupleDesc RelationNameGetTupleDesc(const char *relname)
它可以为一个命名关系的行类型得到TupleDesc，
还有：
TupleDesc TypeGetTupleDesc(Oid typeoid, List *colaliases)
可以基于一个类型 OID 得到TupleDesc。这可以被用来
为一种基础或者组合类型获得TupleDesc。不过，对于
返回record的函数它不起作用，并且它无法解析多态类型。
一旦有了一个TupleDesc，如果计划处理 Datum，可以调用：
TupleDesc BlessTupleDesc(TupleDesc tupdesc)
如果计划处理 C 字符串，可以调用：
AttInMetadata *TupleDescGetAttInMetadata(TupleDesc tupdesc)
如果正在编写一个返回集合的函数，你可以把这些函数的结果保存在
FuncCallContext结构中 — 分别使用
tuple_desc或者attinmeta字段。
在处理 Datum 时，使用
HeapTuple heap_form_tuple(TupleDesc tupdesc, Datum *values, bool *isnull)
来用 Datum 形式的用户数据构建一个HeapTuple。
在处理 C 字符串时，使用
HeapTuple BuildTupleFromCStrings(AttInMetadata *attinmeta, char **values)
来用 C 字符串形式的用户数据构建一个HeapTuple。
values是一个 C 字符串数组，每一个元素是返回行
的一个属性。每一个 C 字符串应该是该属性数据类型的输入函数所期望
的格式。为了对一个属性返回空值，values数组中对
应的指针应该被设置为NULL。对于你返回的每一行都将
再次调用这个函数。
一旦已经构建了一个要从函数中返回的元组，它必须被转换成一个
Datum。使用
HeapTupleGetDatum(HeapTuple tuple)
可把一个HeapTuple转换成合法的 Datum。如果你
只想返回一行，那么这个Datum可以被直接返回，在一个
集合返回函数中它也可以被当做当前的返回值。
下一节中会有一个例子。
36.10.9. 返回集合 #
C 语言函数有两个返回集合（多行）的选项。在一种称为ValuePerCall
模式的方法中，一个集合返回函数被重复调用（每次传递相同的参数），并在每次调用时返回一个新行，
直到没有更多行要返回并且通过返回 NULL 来表示这一点。因此，集合返回函数 (SRF)
必须在调用之间保存足够的状态以记住它在做什么并在每次调用时返回正确的下一项。
在另一种称为Materialize模式的方法中，SRF 填充并返回一个包含其整个结果的 tuplestore 对象；
那么整个结果只发生一次调用，不需要调用间状态。
使用 ValuePerCall 模式时，重要的是要记住查询不能保证运行完成；
也就是说，由于诸如LIMIT之类的选项，
执行程序可能会在获取所有行之前停止调用 set-returning 函数。
这意味着在最后一次调用中执行清理活动是不安全的，因为这可能永远不会发生。
对于需要访问外部资源（例如文件描述符）的函数，建议使用 Materialize 模式。
本节的其余部分记录了一组使用 ValuePerCall 模式的 SRF 常用（尽管不是必须使用）的帮助程序宏。
有关 Materialize 模式的其他详细信息可以在src/backend/utils/fmgr/README中找到。
此外，PostgreSQL源代码分发中的contrib
模块包含许多使用 ValuePerCall 和 Materialize 模式的 SRF 示例。
要使用此处描述的 ValuePerCall 支持宏，请包含funcapi.h。
这些宏与结构FuncCallContext一起使用，该结构包含需要跨调用保存的状态。
在调用 SRF 中，fcinfo->flinfo->fn_extra用于在调用之间保存
指向FuncCallContext的指针。
宏在第一次使用时自动填充该字段，并期望在后续使用中找到相同的指针。
typedef struct FuncCallContext
{
/*
* Number of times we've been called before
*
* call_cntr is initialized to 0 for you by SRF_FIRSTCALL_INIT(), and
* incremented for you every time SRF_RETURN_NEXT() is called.
*/
uint64 call_cntr;
/*
* OPTIONAL maximum number of calls
*
* max_calls is here for convenience only and setting it is optional.
* If not set, you must provide alternative means to know when the
* function is done.
*/
uint64 max_calls;
/*
* OPTIONAL pointer to miscellaneous user-provided context information
*
* user_fctx is for use as a pointer to your own data to retain
* arbitrary context information between calls of your function.
*/
void *user_fctx;
/*
* OPTIONAL pointer to struct containing attribute type input metadata
*
* attinmeta is for use when returning tuples (i.e., composite data types)
* and is not used when returning base data types. It is only needed
* if you intend to use BuildTupleFromCStrings() to create the return
* tuple.
*/
AttInMetadata *attinmeta;
/*
* memory context used for structures that must live for multiple calls
*
* multi_call_memory_ctx is set by SRF_FIRSTCALL_INIT() for you, and used
* by SRF_RETURN_DONE() for cleanup. It is the most appropriate memory
* context for any memory that is to be reused across multiple calls
* of the SRF.
*/
MemoryContext multi_call_memory_ctx;
/*
* OPTIONAL pointer to struct containing tuple description
*
* tuple_desc is for use when returning tuples (i.e., composite data types)
* and is only needed if you are going to build the tuples with
* heap_form_tuple() rather than with BuildTupleFromCStrings().  Note that
* the TupleDesc pointer stored here should usually have been run through
* BlessTupleDesc() first.
*/
TupleDesc tuple_desc;
} FuncCallContext;
使用此基础结构的SRF将使用的宏是：
SRF_IS_FIRSTCALL()
来判断你的函数是否是第一次被调用。在第一次调用时（只能在第一次调用时）使用：
SRF_FIRSTCALL_INIT()
初始化FuncCallContext。在每次函数调用时，包含第一次，调用：
SRF_PERCALL_SETUP()
设置使用FuncCallContext。
如果您的函数有数据要在当前调用中返回，请使用：
SRF_RETURN_NEXT(funcctx, result)
把它返回给调用者（result必须是类型Datum，
可以是一个单一值或者按上文所述准备好的元组）。最后，当函数完成了
数据返回后，可使用：
SRF_RETURN_DONE(funcctx)
来清理并且结束SRF。
SRF被调用时的当前内存上下文被称作一个瞬时上下文，
在两次调用之间会清除它。这意味着你不必对用palloc
分配的所有东西调用pfree，它们将自动被释放。不过，
如果你想要分配任何需要在多次调用间都存在的数据结构，需要把它们
放在其他地方。对于任何需要在SRF结束运行之前都存
在的数据来说，multi_call_memory_ctx引用的内存
上下文是一个合适的位置。在大多数情况下，这意味着您应该在进行首次调用设置时切换到
multi_call_memory_ctx。
使用funcctx->user_fctx来保存指向任何此类交叉调用数据结构的指针。
（您在multi_call_memory_ctx中分配的数据将在查询结束时自动消失，
因此也无需手动释放该数据。）
警告
虽然函数的实参在多次调用之间保持不变，但如果在瞬时上下文中
反 TOAST 了参数（通常由
PG_GETARG_xxx
宏完成），那么被反 TOAST 的拷贝将在每次循环中被释放。相应地，
如果你把这些值的引用保存在user_fctx中，你也必
须在反 TOAST 之后把它们拷贝到
multi_call_memory_ctx中，或者确保你只在那个
上下文中反 TOAST 这些值。
一个完整的伪代码例子：
Datum
my_set_returning_function(PG_FUNCTION_ARGS)
{
FuncCallContext  *funcctx;
Datum             result;
further declarations as needed
if (SRF_IS_FIRSTCALL())
{
MemoryContext oldcontext;
funcctx = SRF_FIRSTCALL_INIT();
oldcontext = MemoryContextSwitchTo(funcctx->multi_call_memory_ctx);
/* 这里是一次性设置代码： */
user code
if returning composite
build TupleDesc, and perhaps AttInMetadata
endif returning composite
user code
MemoryContextSwitchTo(oldcontext);
}
/* 这里是每一次都要做的设置代码： */
user code
funcctx = SRF_PERCALL_SETUP();
user code
/* 这里只是一种测试是否执行完的方法： */
if (funcctx->call_cntr < funcctx->max_calls)
{
/* 这里返回另一个项： */
user code
obtain result Datum
SRF_RETURN_NEXT(funcctx, result);
}
else
{
/* 这里已经完成了项的返回，所以只报告事实。 */
/* （不要将清理代码放在这里。） */
SRF_RETURN_DONE(funcctx);
}
}
一个返回复合类型的简单SRF的完整示例如下：
PG_FUNCTION_INFO_V1(retcomposite);
Datum
retcomposite(PG_FUNCTION_ARGS)
{
FuncCallContext     *funcctx;
int                  call_cntr;
int                  max_calls;
TupleDesc            tupdesc;
AttInMetadata       *attinmeta;
/* 仅在函数的第一次调用时执行的操作 */
if (SRF_IS_FIRSTCALL())
{
MemoryContext   oldcontext;
/* 为跨调用持久性创建函数上下文 */
funcctx = SRF_FIRSTCALL_INIT();
/* 切换到适合多次函数调用的内存上下文 */
oldcontext = MemoryContextSwitchTo(funcctx->multi_call_memory_ctx);
/* 要返回的元组总数 */
funcctx->max_calls = PG_GETARG_INT32(0);
/* 为我们的结果类型构建一个元组描述符 */
if (get_call_result_type(fcinfo, NULL, &tupdesc) != TYPEFUNC_COMPOSITE)
ereport(ERROR,
(errcode(ERRCODE_FEATURE_NOT_SUPPORTED),
errmsg("function returning record called in context "
"that cannot accept type record")));
/*
* 生成后续从原始C字符串生成元组所需的属性元数据
*/
attinmeta = TupleDescGetAttInMetadata(tupdesc);
funcctx->attinmeta = attinmeta;
MemoryContextSwitchTo(oldcontext);
}
/* 每次函数调用时执行的操作 */
funcctx = SRF_PERCALL_SETUP();
call_cntr = funcctx->call_cntr;
max_calls = funcctx->max_calls;
attinmeta = funcctx->attinmeta;
if (call_cntr < max_calls)    /* 当还有更多要发送时执行 */
{
char       **values;
HeapTuple    tuple;
Datum        result;
/*
* 为构建返回的元组准备一个值数组。
* 这应该是一个由后续类型输入函数处理的C字符串数组。
*/
values = (char **) palloc(3 * sizeof(char *));
values[0] = (char *) palloc(16 * sizeof(char));
values[1] = (char *) palloc(16 * sizeof(char));
values[2] = (char *) palloc(16 * sizeof(char));
snprintf(values[0], 16, "%d", 1 * PG_GETARG_INT32(1));
snprintf(values[1], 16, "%d", 2 * PG_GETARG_INT32(1));
snprintf(values[2], 16, "%d", 3 * PG_GETARG_INT32(1));
/* 构建一个元组 */
tuple = BuildTupleFromCStrings(attinmeta, values);
/* 将元组转换为数据 */
result = HeapTupleGetDatum(tuple);
/* 清理（这实际上并不是必要的） */
pfree(values[0]);
pfree(values[1]);
pfree(values[2]);
pfree(values);
SRF_RETURN_NEXT(funcctx, result);
}
else    /* 当没有更多要发送时执行 */
{
SRF_RETURN_DONE(funcctx);
}
}
在SQL中声明此函数的一种方法是：
CREATE TYPE __retcomposite AS (f1 integer, f2 integer, f3 integer);
CREATE OR REPLACE FUNCTION retcomposite(integer, integer)
RETURNS SETOF __retcomposite
AS 'filename', 'retcomposite'
LANGUAGE C IMMUTABLE STRICT;
另一种方法是使用OUT参数：
CREATE OR REPLACE FUNCTION retcomposite(IN integer, IN integer,
OUT f1 integer, OUT f2 integer, OUT f3 integer)
RETURNS SETOF record
AS 'filename', 'retcomposite'
LANGUAGE C IMMUTABLE STRICT;
请注意，在这种方法中，函数的输出类型形式上是一个匿名record类型。
36.10.10. 多态参数和返回类型 #
可以声明 C 语言函数来接受和返回第 36.2.5 节中描述的多态类型。当函数参数或者返回
类型被定义为多态类型时，函数的编写者无法提前知道会用什么数据类型
调用该函数或者该函数需要返回什么数据类型。在fmgr.h
中提供了两种例程来允许版本-1 的 C 函数发现其参数的实际数据类型以及
它要返回的类型。这些例程被称为
get_fn_expr_rettype(FmgrInfo *flinfo)和
get_fn_expr_argtype(FmgrInfo *flinfo, int argnum)。它们
返回结果或者参数的类型的 OID，或者当该信息不可用时返回
InvalidOid。结构flinfo通常被当做
fcinfo->flinfo访问。参数argnum则是从零
开始计。get_call_result_type也可被用作
get_fn_expr_rettype的一种替代品。还有
get_fn_expr_variadic，它可以被用来找出 variadic 参数
是否已经被合并到了一个数组中。这主要用于
VARIADIC "any"函数，因为对于接收普通数组类型的
variadic 函数来说总是会发生这类合并。
例如，假设我们想要写一个接收一个任意类型元素并且返回一个该类型的一维
数组的函数：
PG_FUNCTION_INFO_V1(make_array);
Datum
make_array(PG_FUNCTION_ARGS)
{
ArrayType  *result;
Oid         element_type = get_fn_expr_argtype(fcinfo->flinfo, 0);
Datum       element;
bool        isnull;
int16       typlen;
bool        typbyval;
char        typalign;
int         ndims;
int         dims[MAXDIM];
int         lbs[MAXDIM];
if (!OidIsValid(element_type))
elog(ERROR, "could not determine data type of input");
/* 得到提供的元素，小心它为 NULL 的情况 */
isnull = PG_ARGISNULL(0);
if (isnull)
element = (Datum) 0;
else
element = PG_GETARG_DATUM(0);
/* 只有一个维度 */
ndims = 1;
/* 和一个元素 */
dims[0] = 1;
/* 且下界是 1 */
lbs[0] = 1;
/* 得到该元素类型所需的信息 */
get_typlenbyvalalign(element_type, &typlen, &typbyval, &typalign);
/* 现在构建数组 */
result = construct_md_array(&element, &isnull, ndims, dims, lbs,
element_type, typlen, typbyval, typalign);
PG_RETURN_ARRAYTYPE_P(result);
}
下面的命令在 SQL 中声明函数make_array：
CREATE FUNCTION make_array(anyelement) RETURNS anyarray
AS 'DIRECTORY/funcs', 'make_array'
LANGUAGE C IMMUTABLE;
有一种只对 C 语言函数可用的多态变体：它们可以被声明为接受类型为
"any"的参数（注意这种类型名必须用双引号引用，因为它也
是一个 SQL 保留字）。这和anyelement相似，不过它不约束
不同的"any"参数为同一种类型，它们也不会帮助确定函数的
结果类型。C 语言函数也能声明它的第一个参数为
VARIADIC "any"。这可以匹配一个或者多个任意类型的实参（
不需要是同一种类型）。这些参数不会像普通 variadic 函
数那样被收集到一个数组中，它们将被单独传递给该函数。使用这种特性时，
必须用PG_NARGS()宏以及上述方法来判断实参的个数和类
型。还有，这种函数的用户可能希望在他们的函数调用中使用
VARIADIC关键词，以期让该函数将数组元素作为单独的参数
对待。如果想要这样，在使用get_fn_expr_variadic检测被
标记为VARIADIC的实参之后，函数本身必须实现这种行为。
36.10.11. 共享内存 #36.10.11.1. 启动时请求共享内存 #
加载项可以在服务器启动时预留共享内存。为此，必须通过在
shared_preload_libraries中指定来预加载加载项的共享库。
共享库还应在其_PG_init函数中注册一个
shmem_request_hook。该
shmem_request_hook可以通过调用以下函数来预留共享内存：
void RequestAddinShmemSpace(Size size)
每个后端应通过调用以下函数获取指向预留共享内存的指针：
void *ShmemInitStruct(const char *name, Size size, bool *foundPtr)
如果此函数将foundPtr设置为
false，调用者应继续初始化预留共享内存的内容。
如果foundPtr被设置为true，则共享内存已由另一个后端初始化，
调用者无需进一步初始化。
为了避免竞争条件，每个后端在初始化其共享内存分配时应使用
LWLock AddinShmemInitLock，如下所示：
static mystruct *ptr = NULL;
bool        found;
LWLockAcquire(AddinShmemInitLock, LW_EXCLUSIVE);
ptr = ShmemInitStruct("my struct name", size, &found);
if (!found)
{
... initialize contents of shared memory ...
ptr->locks = GetNamedLWLockTranche("my tranche name");
}
LWLockRelease(AddinShmemInitLock);
shmem_startup_hook 提供了一个方便的初始化代码位置，
但并不严格要求所有此类代码都放在此钩子中。在 Windows（以及
其他定义了 EXEC_BACKEND 的地方），每个后端在附加
到共享内存后不久会执行注册的 shmem_startup_hook，
因此附加模块仍应在此钩子中获取 AddinShmemInitLock，
如上面的示例所示。在其他平台上，只有主进程执行 shmem_startup_hook，
每个后端自动继承指向共享内存的指针。
一个 shmem_request_hook 和 shmem_startup_hook 的示例
可以在 contrib/pg_stat_statements/pg_stat_statements.c 中找到，
位于 PostgreSQL 源代码树中。
36.10.11.2. 启动后请求共享内存 #
还有另一种更灵活的保留共享内存的方法，可以在服务器启动后并且在
shmem_request_hook之外进行。为此，每个将使用共享内存的
后端都应通过调用以下函数来获取指向共享内存的指针：
void *GetNamedDSMSegment(const char *name, size_t size,
void (*init_callback) (void *ptr),
bool *found)
如果指定名称的动态共享内存段尚不存在，该函数将分配它并使用提供的
init_callback回调函数进行初始化。如果该内存段已被
另一个后端分配并初始化，该函数则仅将现有的动态共享内存段附加到当前
后端。
与服务器启动时保留的共享内存不同，使用GetNamedDSMSegment
保留共享内存时，无需获取AddinShmemInitLock或采取其他措施
来避免竞争条件。此函数确保只有一个后端分配并初始化该段，
而所有其他后端都会收到指向已完全分配和初始化的段的指针。
GetNamedDSMSegment的完整使用示例可以在
src/test/modules/test_dsm_registry/test_dsm_registry.c
中找到，该文件位于PostgreSQL源代码树中。
36.10.12. LWLocks #36.10.12.1. 启动时请求 LWLocks #
加载项可以在服务器启动时预留 LWLocks。与服务器启动时预留的共享内存类似，
加载项的共享库必须通过在
shared_preload_libraries
中指定来预加载，并且共享库应在其
_PG_init 函数中注册一个
shmem_request_hook。该
shmem_request_hook 可以通过调用以下函数预留 LWLocks：
void RequestNamedLWLockTranche(const char *tranche_name, int num_lwlocks)
这确保了以 tranche_name 名称可用一个包含
num_lwlocks 个 LWLocks 的数组。可以通过调用以下函数获得该数组的指针：
LWLockPadded *GetNamedLWLockTranche(const char *tranche_name)
36.10.12.2. 启动后请求 LWLocks #
还有另一种更灵活的方法可以获取 LWLocks，这种方法可以在服务器启动后并且在
shmem_request_hook 之外完成。要做到这一点，首先通过调用以下函数分配一个
tranche_id：
int LWLockNewTrancheId(void)
接下来，初始化每个 LWLock，传入新的
tranche_id 作为参数：
void LWLockInitialize(LWLock *lock, int tranche_id)
类似于共享内存，每个后端应确保只有一个进程分配新的
tranche_id 并初始化每个新的 LWLock。实现这一点的一种方法是只在共享内存初始化代码中
独占持有 AddinShmemInitLock 时调用这些函数。如果使用
GetNamedDSMSegment，在 init_callback 回调函数中调用这些函数就可以避免竞争条件。
最后，每个使用 tranche_id 的后端都应通过调用以下函数将其与
tranche_name 关联：
void LWLockRegisterTranche(int tranche_id, const char *tranche_name)
LWLockNewTrancheId、LWLockInitialize 和
LWLockRegisterTranche 的完整使用示例可以在
contrib/pg_prewarm/autoprewarm.c 中找到，该文件位于
PostgreSQL 源码树中。
36.10.13. 自定义等待事件 #
加载项可以通过调用以下函数，在等待事件类型
Extension 下定义自定义等待事件：
uint32 WaitEventExtensionNew(const char *wait_event_name)
该等待事件与面向用户的自定义字符串相关联。
相关示例可见于 PostgreSQL 源代码树中的
src/test/modules/worker_spi。
自定义等待事件可以在
pg_stat_activity中查看：
=# SELECT wait_event_type, wait_event FROM pg_stat_activity
WHERE backend_type ~ 'worker_spi';
wait_event_type |  wait_event
-----------------+---------------
Extension       | WorkerSpiMain
(1 row)
36.10.14. 注入点 #
使用宏声明具有给定 name 的注入点：
INJECTION_POINT(name, arg);
服务器代码中已经在战略位置声明了一些注入点。在添加新的注入点后，
代码需要重新编译，以便该注入点在二进制文件中可用。用 C 语言编写的
附加模块可以使用相同的宏在自己的代码中声明注入点。注入点名称应使用
小写字母，术语之间用短横线分隔。arg 是在运行时传递给回调的
可选参数值。
执行注入点可能需要分配少量内存，这可能会失败。如果您需要在不允许动态分配的关键区域中有一个注入点，可以使用以下宏的两步方法：
INJECTION_POINT_LOAD(name);
INJECTION_POINT_CACHED(name, arg);
在进入关键区域之前，
调用 INJECTION_POINT_LOAD。它检查共享
内存状态，并在回调处于活动状态时将其加载到后端私有内存中。在关键区域内，使用
INJECTION_POINT_CACHED 来执行回调。
插件可以通过调用以下函数，将回调附加到已声明的注入点：
extern void InjectionPointAttach(const char *name,
const char *library,
const char *function,
const void *private_data,
int private_data_size);
name 是注入点的名称，当执行到该点时，将执行从
library 加载的 function。private_data
是一块私有数据区域，大小为 private_data_size，作为回调执行时的参数传入。
这是 InjectionPointCallback 的回调示例：
static void
custom_injection_callback(const char *name,
const void *private_data,
void *arg)
{
uint32 wait_event_info = WaitEventInjectionPointNew(name);
pgstat_report_wait_start(wait_event_info);
elog(NOTICE, "%s: executed custom callback", name);
pgstat_report_wait_end();
}
该回调以 NOTICE 的严重性向服务器错误日志打印消息，
但回调可以实现更复杂的逻辑。
定义在达到注入点时采取的操作的另一种方法是将测试代码与正常源
代码并排添加。如果操作例如依赖于不可访问的本地变量，这可能会很有用。
然后可以使用 IS_INJECTION_POINT_ATTACHED 宏
来检查是否附加了注入点，例如：
#ifdef USE_INJECTION_POINTS
if (IS_INJECTION_POINT_ATTACHED("before-foobar"))
{
/* 如果附加了注入点，则更改本地变量 */
local_var = 123;
/* 还执行回调 */
INJECTION_POINT_CACHED("before-foobar", NULL);
}
#endif
请注意，附加到注入点的回调不会由 IS_INJECTION_POINT_ATTACHED
宏执行。如果您想执行回调，必须像上面的示例一样调用
INJECTION_POINT_CACHED。
可以通过调用以下函数来选择性地分离注入点：
extern bool InjectionPointDetach(const char *name);
成功时返回true，否则返回false。
一个附加到注入点的回调在所有后端中都是可用的，包括在调用
InjectionPointAttach之后启动的后端。只要服务器
运行或直到使用InjectionPointDetach分离注入点，
它都会保持附加状态。
一个示例可以在PostgreSQL源代码树中的
src/test/modules/injection_points中找到。
启用注入点需要使用
--enable-injection-points 配合
configure 或者使用 -Dinjection_points=true
配合 Meson。
36.10.15. 自定义累积统计 #
用 C 语言编写的插件可以使用在
累积统计系统中注册的自定义类型。
首先，定义一个 PgStat_KindInfo，其中包含与注册的自定义类型相关的所有信息。例如：
static const PgStat_KindInfo custom_stats = {
.name = "custom_stats",
.fixed_amount = false,
.shared_size = sizeof(PgStatShared_Custom),
.shared_data_off = offsetof(PgStatShared_Custom, stats),
.shared_data_len = sizeof(((PgStatShared_Custom *) 0)->stats),
.pending_size = sizeof(PgStat_StatCustomEntry),
}
然后，每个需要使用此自定义类型的后端需要使用 pgstat_register_kind 和一个唯一 ID 来注册它，以存储与此类型的统计信息相关的条目：
extern PgStat_Kind pgstat_register_kind(PgStat_Kind kind,
const PgStat_KindInfo *kind_info);
在开发新扩展时，使用 PGSTAT_KIND_EXPERIMENTAL 作为
kind。当您准备将扩展发布给用户时，请在
自定义累积统计 页面上保留一个类型 ID。
PgStat_KindInfo 的 API 详细信息可以在
src/include/utils/pgstat_internal.h 中找到。
注册的统计信息类型与一个名称和一个在共享内存中跨服务器共享的唯一 ID 相关联。每个使用自定义统计信息类型的后端维护一个本地缓存，存储每个自定义 PgStat_KindInfo 的信息。
将实现自定义累积统计信息类型的扩展模块放置在 shared_preload_libraries 中，以便在 PostgreSQL 启动期间尽早加载。
有关如何注册和使用自定义统计信息的示例可以在
src/test/modules/injection_points 中找到。
36.10.16. 使用 C++ 进行可扩展性 #
尽管PostgreSQL后端是用 C 编写的，
只要遵循下面的指导方针也可以用 C++ 编写扩展：
所有被后端访问的函数必须对后端呈现一种 C 接口，然后这些 C 函数
调用 C++ 函数。例如，对后端访问的函数要求extern C
链接。对需要在后端和 C++ 代码之间作为指针传递的任何函数也要
这样做。
使用合适的释放方法释放内存。例如，大部分后端内存是通过
palloc()分配的，所以应使用pfree()
来释放。在这种情况中使用 C++ 的delete会失败。
防止异常传播到 C 代码中（在所有extern C函数的顶层
使用一个捕捉全部异常的块）。即使 C++ 代码不会显式地抛出任何
异常也需要这样做，因为类似内存不足等事件仍会抛出异常。任何异常
都必须被捕捉并且用适当的错误传回给 C 接口。如果可能，用
-fno-exceptions 来编译 C++ 以完全消灭异常。在这种
情况下，你必须在 C++ 代码中检查失败，例如检查new()
返回的 NULL。
如果从 C++ 代码调用后端函数，确定 C++ 调用栈值包含传统 C 风格
的数据结构（POD）。这是必要的，因为后端错误会
产生远距离的longjmp()，它无法正确的退回具有非
POD 对象的 C++ 调用栈。
总之，最好把 C++ 代码放在与后端交互的extern C函数之后，
并且避免异常、内存和调用栈泄露。
上一页 上一级 下一页36.9. 内部函数 起始页 36.11. 函数优化信息
