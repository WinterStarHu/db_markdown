# CREATE TYPE

CREATE TYPE
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE TYPECREATE TYPE — 定义一个新的数据类型大纲
CREATE TYPE name AS
( [ attribute_name data_type [ COLLATE collation ] [, ... ] ] )
CREATE TYPE name AS ENUM
( [ 'label' [, ... ] ] )
CREATE TYPE name AS RANGE (
SUBTYPE = subtype
[ , SUBTYPE_OPCLASS = subtype_operator_class ]
[ , COLLATION = collation ]
[ , CANONICAL = canonical_function ]
[ , SUBTYPE_DIFF = subtype_diff_function ]
[ , MULTIRANGE_TYPE_NAME = multirange_type_name ]
)
CREATE TYPE name (
INPUT = input_function,
OUTPUT = output_function
[ , RECEIVE = receive_function ]
[ , SEND = send_function ]
[ , TYPMOD_IN = type_modifier_input_function ]
[ , TYPMOD_OUT = type_modifier_output_function ]
[ , ANALYZE = analyze_function ]
[ , SUBSCRIPT = subscript_function ]
[ , INTERNALLENGTH = { internallength | VARIABLE } ]
[ , PASSEDBYVALUE ]
[ , ALIGNMENT = alignment ]
[ , STORAGE = storage ]
[ , LIKE = like_type ]
[ , CATEGORY = category ]
[ , PREFERRED = preferred ]
[ , DEFAULT = default ]
[ , ELEMENT = element ]
[ , DELIMITER = delimiter ]
[ , COLLATABLE = collatable ]
)
CREATE TYPE name
描述
CREATE TYPE在当前数据库中注册一种新的
数据类型。定义数据类型的用户将成为它的拥有者。
如果给定一个模式名，那么该类型将被创建在指定的模式中。否则它会被
创建在当前模式中。类型名称必须与同一个模式中任何现有的类型或者域
相区别（因为表具有相关的数据类型，类型名称也必须与同一个模式中任
何现有表的名字不同）。
如上面的语法所示，有五种形式的CREATE TYPE。
它们分别创建组合类型、枚举类型、
范围类型、基础类型或者
shell 类型。下文将依次讨论前四种形式。shell 类型仅仅
是一种用于后面要定义的类型的占位符，通过发出一个不带除类型名之外其
他参数的CREATE TYPE命令可以创建这种类型。
在创建范围类型和基础类型时，需要 shell 类型作为一种向前引用。
组合类型
第一种形式的CREATE TYPE创建组合类型。
组合类型由一个属性名和数据类型的列表指定。如果属性的数据类型是可
排序的，也可以指定该属性的排序规则。组合类型本质上和表的行类型相
同，但是如果只想定义一种类型，使用CREATE TYPE避免了创建一个实际的表。单
独的组合类型也是很有用的，例如可以作为函数的参数或者返回类型。
为了能够创建组合类型，必须拥有在其所有属性类型上的
USAGE特权。
枚举类型
如第 8.7 节中所述，第二种形式的CREATE TYPE创建枚举类型。
枚举类型需要一个带引号的标签构成的列表，每一个标签长度必须不超过NAMEDATALEN字节（在标准的PostgreSQL编译中是64字节）。
可以创建具有零个标签的枚举类型，但是在使用ALTER TYPE添加至少一个标签之前，不能使用这种类型来保存值。
范围类型
如第 8.17 节中所述，第三种形式的
CREATE TYPE创建范围类型。
范围类型的subtype可以
是任何带有一个相关的b-tree操作符类（用来决定该范围类型值的顺序）的类型。
通常，子类型的默认b-tree操作符类被用来决定顺序。要使用一种非默认操作符
类，可以用subtype_opclass指定它
的名字。如果子类型是可排序的并且希望在该范围的顺序中使用一种非默认的
排序规则，可以用collation选项来指定。
可选的canonical函数
必须接受一个所定义的范围类型的参数，并且返回同样类型的一个值。在适
用时，它被用来把范围值转换成一种规范的形式。更多信息请见第 8.17.8 节。创建一个
canonical函数有点棘
手，因为必须在声明范围类型之前定义它。要这样做，必须首先创建一种
shell类型，它是一种没有属性只有名称和拥有者的占位符类型。这可以通过
发出不带额外参数的命令CREATE TYPE
name来完成。然后可以使用该shell类型作为
参数和结果来声明该函数，并且最终用同样的名称来声明范围类型。这会自动
用一种合法的范围类型替换shell类型项。
可选的subtype_diff函数
必须接受两个subtype类型
的值作为参数，并且返回一个double precision值表示两个给定
值之间的差别。虽然这是可选的，但是提供这个函数会让该范围类型列上 GiST 索
引效率更高。详见第 8.17.8 节。
可选的multirange_type_name参数指定相应的多范围类型的名称。
如未指定，这个名称将自动选择。
如果范围类型名称包含子字符串range，则通过将范围类型名称中的range子字符串替换为multirange，构成多范围类型名称。
否则，通过在范围类型名称后附加_multirange后缀来构成多范围类型名称。
基本类型
第四种形式的CREATE TYPE创建一种新的
基本类型（标量类型）。为了创建一种新的基本类型，你必须是一个超级
用户（做这种限制的原因是一种错误的类型定义可能让服务器混淆甚至
崩溃）。
参数可以以任意顺序出现（而不仅是按照上面所示的顺序），并且大部分
是可选的。在定义类型前，必须注册两个或更多函数（使用
CREATE FUNCTION）。支持函数
input_function和
output_function
是必需的，而函数
receive_function、
send_function、
type_modifier_input_function、
type_modifier_output_function和
analyze_function、以及
subscript_function
是可选的。通常来说这些函数必须是用 C 或者其他低层语言编写的。
input_function将
类型的外部文本表示转换为该类型定义的操作符和函数所使用的内部
表达。
output_function
执行反向的转换。输入函数可以被声明为有一个cstring
类型的参数，或者有三个类型分别为cstring、
oid、integer的参数。第一个参数是
以 C 字符串存在的输入文本，第二个参数是该类型自身的 OID（对于
数组类型则是其元素类型的 OID），第三个参数是目标列的
typmod（如果知道，不知道则将传递 -1）。输入函数必须
返回一个该数据类型本身的值。通常，一个输入函数应该被声明为 STRICT。
如果不是这样，在读到一个 NULL 输入值时，调用它时第一个参数会是
NULL。在这种情况下，该函数必须仍然返回 NULL，除非它发生了错误。
（这种情况主要是想支持域输入函数，它们可能需要拒绝 NULL 输入。）
输出函数必须被声明为有一个新数据类型的参数。输出函数必须返回类型
cstring。对于 NULL 值不会调用输出函数。
可选的receive_function
将类型的外部二进制表示转换为内部表示。如果没有提供这个函数，
该类型不能参与到二进制输入中。二进制表示应该选择为转换为内部形式代价低，
同时具有合理的可移植性。（例如，标准的整数数据类型使用网络字节序作为外
部二进制表示，而内部表示是机器本地的字节序。）接收函数应该执行
足够的检查以确保该值是有效的。
接收函数可以被声明为有一个internal类型的参数，或者有三个类型分别为
internal、oid、integer的参数。
第一个参数是一个指向StringInfo缓冲区的
指针，其中保存着接收到的字节串；可选参数与文本输入函数相同。
接收函数必须返回一个该数据类型本身的值。通常，一个接收函数应该被声明为 STRICT。
如果不是这样，在读到一个 NULL 输入值时，调用它时第一个参数会是
NULL。在这种情况下，该函数必须仍然返回 NULL，除非它发生了错误。
（这种情况主要是想支持域接收函数，它们可能需要拒绝 NULL 输入。）
类似地，可选的send_function将
内部表示转换为外部二进制表示。如果没有提供这个函数，该类型将不能参与到二进制输出中。
发送函数必须被声明为有一个新数据类型的参数。
发送函数必须返回类型bytea。对于 NULL 值不会调用发送函数。
到这里你应该在疑惑输入和输出函数是如何能被声明为具有新类型的
结果或参数的？因为必须在创建新类型之前创建这两个函数。这个问题
的答案是，新类型应该首先被定义为一种shell type，
它是一种占位符类型，除了名称和拥有者之外它没有其他属性。这可以
通过不带额外参数的命令CREATE TYPE
name做到。然后用 C 写的 I/O 函数可以
被定义为引用这种 shell type。最后，用带有完整定义的
CREATE TYPE把该 shell type 替换为一个完全的、合
法的类型定义，之后新类型就可以正常使用了。
如果该类型支持修饰符（附加在类型声明上的可选约束，例如
char(5)或者numeric(30,2)），则需要可选的
type_modifier_input_function
以及type_modifier_output_function。
PostgreSQL允许用户定义的类型有一个或者
多个简单常量或者标识符作为修饰符。不过，为了存储在系统目录中，该信息必须
能被打包到一个非负整数值中。所声明的修饰符会被以cstring数组的形式
传递给
type_modifier_input_function。
它必须检查该值的合法性（如果值错误就抛出一个错误），如果值正确，要返回
一个非负integer值，它将被存储在“typmod”列中。如果
类型没有
type_modifier_input_function
则类型修饰符将被拒绝。
type_modifier_output_function
把内部的整数 typmod 值转换回正确的形式用于用户显示。它必须返回一个
cstring值，该值就是追加到类型名称后的字符串。例如
numeric的函数可能会返回(30,2)。如果默认的显示格式
就是只把存储的 typmod 整数值放在圆括号内，则允许省略
type_modifier_output_function。
可选的analyze_function
为该数据类型的列执行与类型相关的统计信息收集。默认情况下，如果
该类型有一个默认的 B-树操作符类，ANALYZE将尝试用
类型的“equals”和“less-than”操作符来收集统计信息。
这种行为对于非标量类型并不合适，因此可以通过指定一个自定义分析函数来
覆盖这种行为。分析函数必须被声明为有一个类型为internal的参
数，并且返回一个boolean结果。分析函数的详细 API 请见
src/include/commands/vacuum.h。
可选的subscript_function允许在SQL命令中对数据类型进行下标。
指定此函数不会导致该类型被认为是“true”数组类型；例如，它不会是ARRAY[]结构的结果类型的候选者。
但是，如果对该类型的值下标是从中提取的数据的自然符号，那么可以编写subscript_function来定义它的含义。
下标函数必须被声明为接受单个类型internal的参数，
并返回一个internal结果，它是一个实现下标的方法（函数）结构的指针。
下标函数的详细API体现在src/include/nodes/subscripting.h中。
阅读src/backend/utils/adt/arraysubs.c中的数组实现可能也很有用，或者阅读contrib/hstore/hstore_subs.c中的简单代码。
更多信息见下面的Array Types。
虽然只有 I/O 函数和其他为该类型创建的函数才知道新类型的内部表示的细节，
但是内部表示的一些属性必须被向
PostgreSQL声明。其中最重要的是
internallength。基本数据
类型可以是定长的（这种情况下
internallength是一个正
整数）或者是变长的（把
internallength设置为
VARIABLE，在内部通过把typlen设置为 -1 表示）。
所有变长类型的内部表示都必须以一个 4 字节整数开始，它给出了这个值的总
长度（注意如第 66.2 节中所述，长度域常常是被编码
过的，直接访问它是不明智的）。
可选的标志PASSEDBYVALUE表示这种数据类型的值需要
被传值而不是传引用。传值的类型必须是定长的，并且它们的内部表示不能超
过Datum类型（某些机器上是 4 字节，其他机器上是 8 字节）的
尺寸。
alignment参数指定数据
类型的存储对齐要求。允许的值等同于以 1、2、4 或 8 字节边界对齐。注意
变长类型的alignment参数必须至少为 4，因为它们需要包含一个
int4作为它们的第一个组成部分。
storage参数允许
为变长数据类型选择存储策略（对定长类型只允许
plain）。plain指定该类型的数
据将总是被存储在线内并且不会被压缩。extended
指定系统将首先尝试压缩一个长的数据值，并且将在数据仍然太长的情
况下把值移出主表行。external允许值被移出主表，
但是系统将不会尝试对它进行压缩。main允许压缩，
但是不鼓励把值移出主表（如果没有其他办法让行的大小变得合适，具有
这种存储策略的数据项仍将被移出主表，但比起
extended以及external项来，
这种存储策略的数据项会被优先考虑保留在主表中）。
如第 66.2 节和第 36.13.1 节
所述，除plain之外所有的
storage值都暗示
该数据类型的函数能处理被TOAST 过的值。指定的值
仅仅是决定一种可 TOAST 数据类型的列的默认 TOAST 存储策略，用户
可以使用ALTER TABLE SET STORAGE为列选取其他策略。
like_type参数提供
了另一种方法来指定一种数据类型的基本表达属性：从某种现有的类型中
拷贝。internallength、
passedbyvalue、
alignment和
storage的值会从指
定的类型中复制而来（也可以通过在LIKE子句中指定这些属
性的值来覆盖复制过来的值，不过通常并不这么做）。当新类型的低层
实现是以一种现有的类型为“载体”时，用这种方式指定表达特别有用。
category和
preferred参数可以被用来
帮助控制在模糊情况下应用哪一种隐式转换。每一种数据类型都属于一个用
单个 ASCII 字符命名的分类，并且每一种类型可以是其所属分类中的
“首选”。当有助于解决重载函数或操作符时，解析器将优先
转换到首选类型（但是只能从同类的其他类型转换）。更多细节请见
第 10 章。对于没有隐式转换到任意其他类型或者
从任意其他类型转换的类型，让这些设置保持默认即可。不过，对于一组
具有隐式转换的相关类型，把它们都标记为属于同一个类别并且选择一种
或两种“最常用”的类型作为该类别的首选通常是很有用的。在
把一种用户定义的类型增加到一个现有的内建类别（例如数字或者字符串
类型）中时，
category参数特别
有用。不过，也可以创建新的全部是用户定义类型的类别。对这样的类别，
可选择除大写字母之外的任何 ASCII 字符。
如果用户希望该数据类型的列被默认为某种非空值，可以指定一个默认值。
默认值可以用DEFAULT关键词指定（这样一个默认值
可以被附加到一个特定列的显式DEFAULT子句覆盖）。
要指定一种类型是固定长度数组类型，用ELEMENT关键词指定该数组元素的类型。
例如，要定义一个 4 字节整数的数组（int4），应指定ELEMENT = int4。
更多有关数组类型的细节请见下文Array Types。
要指定在这种类型数组的外部表达中分隔值的定界符，可以把delimiter设置为一个特定字符。默认
的定界符是逗号（,）。注意定界符是与数组元素类型相
关的，而不是数组类型本身相关。
如果可选的布尔参数
collatable为真，这种
类型的列定义和表达式可能通过使用COLLATE子句携带
有排序规则信息。在该类型上操作的函数的实现负责真正利用这些信息，仅
把类型标记为可排序的并不会让它们自动地去使用这类信息。
数组类型
只要一种用户定义的类型被创建，PostgreSQL会自动地创建一种相关的数组类型，其名称由元素类型的名称前面加上一个下划线组成，并且如果长度超过NAMEDATALEN字节会自动地被截断。
（如果这样生成的名称与一种现有类型的名称冲突，该过程将会重复直到找到一个不冲突的名字）。
这种隐式创建的数组类型是变长的并且使用内建的输入和输出函数（array_in以及array_out）。
此外, 这种类型是系统用于构建诸如用户定义类型之上的ARRAY[]。
该数组类型会追随其元素类型的拥有者或所在模式的任何更改，并且在元素类型被删除时也被删除。
如果系统会自动地创建正确的数组类型，你可能会很合情合理地问为什么会有一个ELEMENT选项。
使用ELEMENT主要有用的情况是：当你在创建一种定长类型，它正好在内部是一个多个相同东西的数组，并且除了计划给该类型提供的整体操作之外，你想要允许用下标来直接访问这些东西。
例如，类型point被表示为两个浮点数，可以使用point[0]以及point[1]来访问它们。
注意，这种功能只适用于内部形式正好是一个相同定长域序列的定长类型。
由于历史原因（即很明显是错的，但现在改已经太晚了），定长数组类型的下标是从零开始的，而不是像变长数组那样。
指定SUBSCRIPT选项允许数据类型被下标，即使系统没有将其视为数组类型。
刚才描述的固定长度数组的行为实际上是由SUBSCRIPT处理函数raw_array_subscript_handler实现的，
如果为固定长度类型指定ELEMENT，而没有另外写入SUBSCRIPT，则会自动使用。
当指定一个自定义SUBSCRIPT函数时，不必要指定ELEMENT，除非SUBSCRIPT处理函数需要参考typelem来查找返回了什么。
注意指定ELEMENT会导致系统假定新类型包含，或者在某种形式上实际上依赖于该元素类型；例如，如果存在依赖类型的列，更改元素类型的属性是不允许的。
参数name
要创建的类型的名称（可以被模式限定）。
attribute_name
组合类型的一个属性（列）的名称。
data_type
要成为组合类型的一列的现有数据类型的名称。
collation
要关联到组合类型的一列或者范围类型的现有排序规则的名称。
label
一个字符串文字，表示与枚举类型的一个值相关的文本标签。
subtype
范围类型的元素类型的名称，范围类型表示的范围属于该元素类型。
subtype_operator_class
用于子类型的 B 树操作符类的名称。
canonical_function
范围类型的规范化函数的名称。
subtype_diff_function
用于子类型的差异函数的名称。
multirange_type_name
相应多范围类型的名称。
input_function
将数据从类型的外部文本形式转换为其内部形式的函数名。
output_function
将数据从类型的内部形式转换为其外部文本形式的函数名。
receive_function
将数据从类型的外部二进制形式转换为其内部形式的函数名。
send_function
将数据从类型的内部形式转换为外部二进制形式的函数名。
type_modifier_input_function
将类型的修饰符数组转换为内部形式的函数名。
type_modifier_output_function
将类型的修饰符的内部形式转换为外部文本形式的函数名。
analyze_function
为该数据类型执行统计分析的函数名。
subscript_function
函数的名称，该函数定义如何对数据类型的值进行下标。
internallength
一个数字常量，它指定新类型的内部表示的字节长度。默认的假设是
它是变长的。
alignment
该数据类型的存储对齐需求。如果被指定，它必须是
char、int2、
int4或double。默认是
int4。
storage
该数据类型的存储策略。如果被指定，必须是
plain、external、
extended或main；
默认是plain。
like_type
与新类型具有相同表示的现有数据类型的名称。会从这个类型中复制
internallength、
passedbyvalue、
alignment以及
storage的值（
除非在这个CREATE TYPE命令的其他地方用显式说
明覆盖）。
category
这种类型的分类码（一个 ASCII 字符）。 默认是
“用户定义类型”的'U'。其他标准分类码可见
表 52.65。为了创建自定义分类，
你也可以选择其他 ASCII 字符。
preferred
如果这种类型是其类型分类中的优先类型则为真，否则为假。默认
为假。在一个现有类型分类中创建一种新的优先类型要非常小心，
因为这可能会导致行为上令人惊讶的改变。
default
数据类型的默认值。如果被省略，默认值是 null。
element
被创建的类型是一个数组，这指定了数组元素的类型。
delimiter
在由这种类型组成的数组中值之间的分隔符。
collatable
如果这个类型的操作可以使用排序规则信息，则为真。默认为假。
注释
由于一旦数据类型被创建，对该数据类型的使用就没有限制，创建一种基本类型
或者范围类型就等同于在类型定义中提到的函数上授予公共执行权限。对于在类
型定义中有用的函数来说这通常不是问题。但是如果设计一种类型时要求在转换
到外部形式或者从外部形式转换时使用“秘密”信息，你就应该三思而
后行。
在PostgreSQL版本 8.3 之前，自动生成的
数组类型的名称总是正好为元素类型的名称外加一个前置的下划线字符（
_）。因此类型名称的长度限制比其他名称还要少一个字符。
虽然现在这仍然是通常情况，但如果名称达到最大长度或者与其他下划线开头
的用户类型名称冲突，数组类型的名称也可以不同于这种规则。因此依靠这种
习惯编写代码现在已经不适用了。现在，可以使用
pg_type.typarray来定位与给定类型相关
的数组类型。
建议避免使用以下划线开始的类型名和表名。虽然服务器会改变生成的数组
类型名称以避免与用户给定的名称冲突，仍然有混淆的风险，特别是对旧的
客户端软件来说，它们可能会假定以下划线开始的类型名总是表示数组。
在PostgreSQL 版本 8.2 之前，
shell-type 的创建语法
CREATE TYPE name不存在。创建
一种新基本类型的方法是先创建它的输入函数。在这种方法中，
PostgreSQL 将首先把新数据类型的名
称看做是输入函数的返回类型。在这种情况下 shell type 会被隐式地创建，
并且能在剩余的 I/O 函数的定义中引用。这种方法现在仍然有效，但是已经
被弃用并且可能会在未来的某个发行中被禁止。还有，为了避免由于函数定
义中的打字错误导致 shell type 弄乱系统目录，当输入函数用 C 编写时，
将只能用这种方法创建一种 shell type。
在PostgreSQL 16及更高版本中，
基础类型的输入函数最好通过新的errsave()/
ereturn()机制返回“软”错误，
而不是像以前的版本那样抛出ereport()异常。
有关更多信息，请参阅src/backend/utils/fmgr/README。
示例
这个例子创建了一种组合类型并且将其用在了一个函数定义中：
CREATE TYPE compfoo AS (f1 int, f2 text);
CREATE FUNCTION getfoo() RETURNS SETOF compfoo AS $$
SELECT fooid, fooname FROM foo
$$ LANGUAGE SQL;
这个例子创建了一个枚举类型并将其用在一个表定义中：
CREATE TYPE bug_status AS ENUM ('new', 'open', 'closed');
CREATE TABLE bug (
id serial,
description text,
status bug_status
);
这个例子创建了一个范围类型：
CREATE TYPE float8_range AS RANGE (subtype = float8, subtype_diff = float8mi);
这个例子创建了基本数据类型box然后将它用在一个表定义中：
CREATE TYPE box;
CREATE FUNCTION my_box_in_function(cstring) RETURNS box AS ... ;
CREATE FUNCTION my_box_out_function(box) RETURNS cstring AS ... ;
CREATE TYPE box (
INTERNALLENGTH = 16,
INPUT = my_box_in_function,
OUTPUT = my_box_out_function
);
CREATE TABLE myboxes (
id integer,
description box
);
如果box的内部结构是四个
float4元素的一个数组，我们可能会使用：
CREATE TYPE box (
INTERNALLENGTH = 16,
INPUT = my_box_in_function,
OUTPUT = my_box_out_function,
ELEMENT = float4
);
这将允许用下标来访问一个 box 值的组件编号。否则该类型的行为和
前面的一样。
这个例子创建了一个大对象类型并将它用在一个表定义中：
CREATE TYPE bigobj (
INPUT = lo_filein, OUTPUT = lo_fileout,
INTERNALLENGTH = VARIABLE
);
CREATE TABLE big_objs (
id integer,
obj bigobj
);
更多例子（包括配套的输入和输出函数）请见第 36.13 节。
兼容性
创建组合类型的第一种形式的CREATE TYPE命令
符合SQL标准。其他的形式都是
PostgreSQL扩展。SQL
标准中的CREATE TYPE语句也定义了其他
PostgreSQL中没有实现的形式。
创建一种具有零个属性的组合类型的能力是一种
PostgreSQL对标准的背离（类似于
CREATE TABLE中相同的情况）。
另见ALTER TYPE, CREATE DOMAIN, CREATE FUNCTION, DROP TYPE上一页 上一级 下一页CREATE TRIGGER 起始页 CREATE USER
