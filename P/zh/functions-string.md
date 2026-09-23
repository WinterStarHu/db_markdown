# 9.4. 字符串函数和操作符

9.4. 字符串函数和操作符
版本：
纠错本页面
搜索
目录导航
❮
❯
9.4. 字符串函数和操作符 #9.4.1. format
本节描述了用于检查和操作字符串值的函数和操作符。
在这个环境中的字符串包括所有类型character、character varying和text的值。
除非特别说明，这些函数和操作符声明为接受并返回text类型。
它们将互换接受character varying参数。
在应用函数或操作符之前character类型的值将被转换为text，结果删除character值中的任何末尾空格。
SQL定义了一些字符串函数，它们使用关键字，而不是逗号来分隔参数。详情请见表 9.9，PostgreSQL也提供了这些函数使用正常函数调用语法的版本（见表 9.10）。
注意
字符串连接操作符（||）将接受非字符串输入，只要至少一个输入是字符串类型，如表 9.9所示。
对于其他情况，向text插入一个显式强制，可以用于接受非字符串输入。
表 9.9. SQL字符串函数和操作符
函数/操作符
描述
示例
text || text
→ text
连接两个字符串。
'Post' || 'greSQL'
→ PostgreSQL
text || anynonarray
→ text
anynonarray || text
→ text
将非字符串输入转换为文本，然后将两个字符串连接在一起。
（非字符串输入不能为数组类型，因为这将在||
操作符的数组中造成歧义。如果你想连接一个数组的文本等价，
请显式地将其转换为text。）
'Value: ' || 42
→ Value: 42
btrim ( string text
[, characters text ] )
→ text
从string的开头或结尾删除最长的只包含characters（默认是一个空格）的字符串。
btrim('xyxtrimyyx', 'xyz')
→ trim
text IS [NOT] [form] NORMALIZED
→ boolean
检查字符串是否在指定的 Unicode 规范化形式中。
可选的form关键词指定形式：NFC（默认），NFD，
NFKC或NFKD。只有在服务器编码为UTF8时，才能使用此表达式。
请注意，使用这个表达式检查规范化通常比规范化可能已经规范化的字符串要快。
U&'\0061\0308bc' IS NFD NORMALIZED
→ t
bit_length ( text )
→ integer
返回字符串中的位数（8倍于octet_length）。
bit_length('jose')
→ 32
char_length ( text )
→ integer
character_length ( text )
→ integer
返回字符串中的字符数。
char_length('josé')
→ 4
lower ( text )
→ text
将字符串转换为全小写，遵循数据库的区域设置规则。
lower('TOM')
→ tom
lpad ( string text,
length integer
[, fill text ] )
→ text
将string扩展为长度length，通过前置字符fill（默认空格）。
如果string已经超过length，那么它将被截断（在右侧）。
lpad('hi', 5, 'xy')
→ xyxhi
ltrim ( string text
[, characters text ] )
→ text
从string开始删除包含characters（默认空格）中仅包含字符的最长字符串。
ltrim('zzzytest', 'xyz')
→ test
normalize ( text
[, form ] )
→ text
将字符串转换为指定的 Unicode
规范化形式。可选的 form 关键字
指定形式：NFC（默认），
NFD，NFKC，或
NFKD。此函数只能在服务器编码为
UTF8 时使用。
normalize(U&'\0061\0308bc', NFC)
→ U&'\00E4bc'
octet_length ( text )
→ integer
返回字符串的字节数。
octet_length('josé')
→ 5 (if server encoding is UTF8)
octet_length ( character )
→ integer
返回字符串中的字节数。由于此版本的函数直接接受character类型，它不会剥离尾随空格。
octet_length('abc '::character(4))
→ 4
overlay ( string text PLACING newsubstring text FROM start integer [ FOR count integer ] )
→ text
替换string从start字符开始的子串，并用newsubstring扩展到count字符。
如果省略了count，则默认为newsubstring的长度。
overlay('Txxxxas' placing 'hom' from 2 for 4)
→ Thomas
position ( substring text IN string text )
→ integer
返回string中指定的substring的第一个起始索引，如果不存在则返回零。
position('om' in 'Thomas')
→ 3
rpad ( string text,
length integer
[, fill text ] )
→ text
扩展 string 到长度 length，通过追加fill 字符（默认为空格）。
如果string 已经比 length 长，则截断它。
rpad('hi', 5, 'xy')
→ hixyx
rtrim ( string text
[, characters text ] )
→ text
从string末尾删除仅包含characters（默认为空格）的最长字符串。
rtrim('testxxzx', 'xyz')
→ test
substring ( string text [ FROM start integer ] [ FOR count integer ] )
→ text
如果已指定，提取string从start字符开始的子串，
并且在count字符后停止。提供至少一个start
和count中的至少一个。
substring('Thomas' from 2 for 3)
→ hom
substring('Thomas' from 3)
→ omas
substring('Thomas' for 2)
→ Th
substring ( string text FROM pattern text )
→ text
提取匹配POSIX正则表达式的第一个子字符串；参见
第 9.7.3 节。
substring('Thomas' from '...$')
→ mas
substring ( string text SIMILAR pattern text ESCAPE escape text )
→ text
substring ( string text FROM pattern text FOR escape text )
→ text
提取匹配 SQL 正则表达式的第一个子串；参见 第 9.7.2 节。
第一种形式自SQL:2003以来被指定，第二种形式仅在SQL:1999中，并应被视为废弃的。
substring('Thomas' similar '%#"o_a#"_' escape '#')
→ oma
trim ( [ LEADING | TRAILING | BOTH ]
[ characters text ] FROM
string text )
→ text
从string的开始、末端或两端（默认为BOTH）移除仅包含characters（默认为空格）字符的最长字符串。
trim(both 'xyz' from 'yxTomxx')
→ Tom
trim ( [ LEADING | TRAILING | BOTH ] [ FROM ]
string text [,
characters text ] )
→ text
这是一个非标准的trim()语法。
trim(both from 'yxTomxx', 'xyz')
→ Tom
unicode_assigned ( text )
→ boolean
如果字符串中的所有字符都被分配了Unicode码点，则返回true；
否则返回false。此函数仅在服务器编码为
UTF8时可用。
upper ( text )
→ text
根据数据库的区域设置规则，将字符串转换为所有大写。
upper('tom')
→ TOM
额外的字符串操作函数和运算符可用，并在表 9.10中列出。
（其中一些用于内部实现表 9.9中列出的SQL标准字符串函数。）
还有模式匹配运算符，这些在第 9.7 节中描述，以及用于全文搜索的运算符，这些在第 12 章中描述。
表 9.10. 其他字符串函数和运算符
函数/操作符
描述
示例
text ^@ text
→ boolean
如果第一个字符串以第二个字符串开头，则返回true（等同于starts_with()函数）。
'alphabet' ^@ 'alph'
→ t
ascii ( text )
→ integer
返回参数的第一个字符的数字代码。在UTF8编码中，返回该字符的Unicode代码点。
在其他多字节编码中，该参数必须是一个ASCII字符。
ascii('x')
→ 120
chr ( integer )
→ text
返回给定代码的字符。在UTF8编码中，该参数被视作一个Unicode代码点。在其他多字节编码中，该参数必须指定一个ASCII字符。chr(0)字符不被允许，因为文本数据类型不能存储这种字符。
chr(65)
→ A
concat ( val1 "any"
[, val2 "any" [, ...] ] )
→ text
连接所有参数的文本表示。
NULL参数将被忽略。
concat('abcde', 2, NULL, 22)
→ abcde222
concat_ws ( sep text,
val1 "any"
[, val2 "any" [, ...] ] )
→ text
连接除第一个参数外的所有参数，并使用分隔符。第一个
参数用作分隔符字符串，且不应为 NULL。
其他 NULL 参数将被忽略。
concat_ws(',', 'abcde', 2, NULL, 22)
→ abcde,2,22
format ( formatstr text
[, formatarg "any" [, ...] ] )
→ text
根据格式字符串格式化参数；
参见 第 9.4.1 节。
此函数类似于 C 函数 sprintf。
format('Hello %s, %1$s', 'World')
→ Hello World, World
initcap ( text )
→ text
将每个单词的第一个字母转换为大写，其余字母转换为小写。单词是由字母数字字符分隔的字母数字字符序列。
initcap('hi THOMAS')
→ Hi Thomas
casefold ( text )
→ text
根据排序规则对输入字符串进行大小写折叠。
大小写折叠类似于大小写转换，但大小写折叠的目的是
方便字符串的大小写不敏感匹配，而大小写转换的目的是
转换为特定的大小写形式。此函数只能在服务器编码为
UTF8 时使用。
通常，大小写折叠只是转换为小写，但根据排序规则可能
会有例外。例如，一些字符有多个小写变体，或折叠为大写。
大小写折叠可能会改变字符串的长度。例如，在
PG_UNICODE_FAST 排序规则中，ß
(U+00DF) 折叠为 ss。
casefold 可用于 Unicode 默认无大小写
匹配。它并不总是保留输入字符串的规范化形式（参见
normalize）。
libc 提供者不支持大小写折叠，因此
casefold 与 lower 相同。
left ( string text,
n integer )
→ text
返回字符串中的前 n 个字符，
或当 n 为负时，返回除最后 |n| 个字符外的所有字符。
left('abcde', 2)
→ ab
length ( text )
→ integer
返回字符串中的字符数。
length('jose')
→ 4
md5 ( text )
→ text
计算参数的 MD5 哈希，结果以十六进制形式写入。
md5('abc')
→ 900150983cd24fb0​d6963f7d28e17f72
parse_ident ( qualified_identifier text
[, strict_mode boolean DEFAULT true ] )
→ text[]
将 qualified_identifier 拆分为标识符数组，
并移除单个标识符的任何引号。默认情况下，最后一个标识符
后的额外字符被视为错误；但如果第二个参数为
false，则这些额外字符将被忽略。
（这种行为对于解析函数等对象的名称很有用。）请注意，
此函数不会截断超长标识符。如果您想要截断，可以将
结果转换为 name[]。
parse_ident('"SomeSchema".someTable')
→ {SomeSchema,sometable}
pg_client_encoding ( )
→ name
返回当前客户端编码名称。
pg_client_encoding()
→ UTF8
quote_ident ( text )
→ text
返回适合引用的给定字符串，作为SQL语句字符串中的标识符。
只有在必要的情况下才添加引号（例如，如果字符串包含
非标识符字符或将被大小写折叠）。
嵌入的引号被适当地加双引号。
参见 例 41.1。
quote_ident('Foo bar')
→ "Foo bar"
quote_literal ( text )
→ text
返回在SQL语句字符串中适当引用的给定字符串，用作字符串文字使用。
嵌入式单引号和反斜线适当的翻倍。
请注意，quote_literal返回null
输入；如果这个参数可能为空，quote_nullable通常更合适。
参见 例 41.1。
quote_literal(E'O\'Reilly')
→ 'O''Reilly'
quote_literal ( anyelement )
→ text
将给定的值转换为文本，然后将其作为字面量引用。
嵌入的单引号和反斜杠被适当地翻倍。
quote_literal(42.5)
→ '42.5'
quote_nullable ( text )
→ text
返回在SQL语句字符串中适当引用的给定字符串文字；或者，如果参数为null，则返回NULL。
嵌入的单引号和反斜杠被适当地翻倍。
参见 例 41.1。
quote_nullable(NULL)
→ NULL
quote_nullable ( anyelement )
→ text
将给定值转换为文本，然后将其作为字面量引用；或者，如果参数为null，则返回NULL。
嵌入的单引号和反斜杠被适当地翻倍。
quote_nullable(42.5)
→ '42.5'
regexp_count ( string text, pattern text
[, start integer
[, flags text ] ] )
→ integer
返回 POSIX 正则表达式 pattern 在
string 中匹配的次数；参见
第 9.7.3 节。
regexp_count('123456789012', '\d\d\d', 2)
→ 3
regexp_instr ( string text, pattern text
[, start integer
[, N integer
[, endoption integer
[, flags text
[, subexpr integer ] ] ] ] ] )
→ integer
返回 string 中 POSIX 正则表达式 pattern
的第 N 次匹配的位置，如果没有匹配则返回零；请参见
第 9.7.3 节。
regexp_instr('ABCDEF', 'c(.)(..)', 1, 1, 0, 'i')
→ 3
regexp_instr('ABCDEF', 'c(.)(..)', 1, 1, 0, 'i', 2)
→ 5
regexp_like ( string text, pattern text
[, flags text ] )
→ boolean
检查 POSIX 正则表达式 pattern 是否在 string 中匹配；请参见
第 9.7.3 节。
regexp_like('Hello World', 'world$', 'i')
→ t
regexp_match ( string text, pattern text [, flags text ] )
→ text[]
返回 string 中 POSIX 正则表达式 pattern 的第一个匹配的子字符串；请参见
第 9.7.3 节。
regexp_match('foobarbequebaz', '(bar)(beque)')
→ {bar,beque}
regexp_matches ( string text, pattern text [, flags text ] )
→ setof text[]
返回 string 中 POSIX 正则表达式 pattern 的第一个匹配的子字符串，或者如果使用了 g 标志，则返回所有匹配的子字符串；请参见
第 9.7.3 节。
regexp_matches('foobarbequebaz', 'ba.', 'g')
→
{bar}
{baz}
regexp_replace ( string text, pattern text, replacement text
[, flags text ] )
→ text
替换与 POSIX 正则表达式 pattern 的第一个匹配的子字符串，如果使用了 g 标志，则替换所有匹配；请参见
第 9.7.3 节。
regexp_replace('Thomas', '.[mN]a.', 'M')
→ ThM
regexp_replace ( string text, pattern text, replacement text,
start integer
[, N integer
[, flags text ] ] )
→ text
替换与 POSIX 正则表达式 N 次匹配的子字符串，如果 N 为零，则替换所有匹配，搜索从 string 的第 start 个字符开始。如果省略 N，则默认为 1。请参见
第 9.7.3 节。
regexp_replace('Thomas', '.', 'X', 3, 2)
→ ThoXas
regexp_replace(string=>'hello world', pattern=>'l', replacement=>'XX', start=>1, "N"=>2)
→ helXXo world
regexp_split_to_array ( string text, pattern text [, flags text ] )
→ text[]
使用 POSIX 正则表达式作为分隔符拆分 string，生成结果数组；请参见
第 9.7.3 节。
regexp_split_to_array('hello world', '\s+')
→ {hello,world}
regexp_split_to_table ( string text, pattern text [, flags text ] )
→ setof text
使用 POSIX 正则表达式作为分隔符拆分 string，生成结果集；请参见
第 9.7.3 节。
regexp_split_to_table('hello world', '\s+')
→
hello
world
regexp_substr ( string text, pattern text
[, start integer
[, N integer
[, flags text
[, subexpr integer ] ] ] ] )
→ text
返回 string 中与 POSIX 正则表达式 pattern 的第 N 次出现匹配的子字符串，如果没有匹配则返回 NULL；请参见
第 9.7.3 节。
regexp_substr('ABCDEF', 'c(.)(..)', 1, 1, 'i')
→ CDEF
regexp_substr('ABCDEF', 'c(.)(..)', 1, 1, 'i', 2)
→ EF
repeat ( string text, number integer )
→ text
重复string指定number次。
repeat('Pg', 4)
→ PgPgPgPg
replace ( string text,
from text,
to text )
→ text
将string中所有from的子串替换为to的子串。
replace('abcdefabcdef', 'cd', 'XX')
→ abXXefabXXef
reverse ( text )
→ text
颠倒字符串中字符的顺序。
reverse('abcde')
→ edcba
right ( string text,
n integer )
→ text
返回字符串中的最后n个字符，或者在n为负时，返回除了前面|n|个字符之外的所有字符。
right('abcde', 2)
→ de
split_part ( string text,
delimiter text,
n integer )
→ text
在string中按delimiter出现的位置拆分，并返回第n个字段（从1开始计数），或者当n为负数时，返回|n|个倒数第字段。
split_part('abc~@~def~@~ghi', '~@~', 2)
→ def
split_part('abc,def,ghi,jkl', ',', -2)
→ ghi
starts_with ( string text, prefix text )
→ boolean
如果string以prefix开始，则返回真。
starts_with('alphabet', 'alph')
→ t
string_to_array ( string text, delimiter text [, null_string text ] )
→ text[]
将string按delimiter分割，并将结果字段形成text数组。
如果delimiter是NULL，则string中的每个字符将成为数组中的一个单独元素。
如果delimiter是空字符串，则string被视为单个字段。
如果提供了null_string且不是NULL，则匹配该字符串的字段将被NULL替换。
另请参见array_to_string。
string_to_array('xx~~yy~~zz', '~~', 'yy')
→ {xx,NULL,zz}
string_to_table ( string text, delimiter text [, null_string text ] )
→ setof text
将string按delimiter分割，并将结果字段作为text行的集合返回。
如果delimiter为NULL，则string中的每个字符将成为结果的单独一行。
如果delimiter为空字符串，则将string视为单个字段。
如果提供了null_string，并且不是NULL，则匹配该字符串的字段将被NULL替换。
string_to_table('xx~^~yy~^~zz', '~^~', 'yy')
→
xx
NULL
zz
strpos ( string text, substring text )
→ integer
返回在string中指定的substring的第一个起始索引，如果不存在则为零。
（与position(substring in
string)相同，但是请注意反转的参数顺序。）
strpos('high', 'ig')
→ 2
substr ( string text, start integer [, count integer ] )
→ text
提取string从start字符开始的子字符串，并扩展count字符，如果指定了的话。
（与substring(string
from start
for count)相同。）
substr('alphabet', 3)
→ phabet
substr('alphabet', 3, 2)
→ ph
to_ascii ( string text )
→ text
to_ascii ( string text,
encoding name )
→ text
to_ascii ( string text,
encoding integer )
→ text
将string从另一个编码转换为ASCII，该编码可按名称或编号标识。
如果encoding被省略，则假定数据库编码（这在实践中是唯一有用的案例）。
转换主要包括去掉重音。
转换仅支持来自LATIN1、LATIN2、
LATIN9和WIN1250的编码。
（请参见unaccent模块以获取另一种更灵活的解决方案。）
to_ascii('Karél')
→ Karel
to_bin ( integer )
→ text
to_bin ( bigint )
→ text
将数字转换为其等效的二进制补码表示形式。
to_bin(2147483647)
→ 1111111111111111111111111111111
to_bin(-1234)
→ 11111111111111111111101100101110
to_hex ( integer )
→ text
to_hex ( bigint )
→ text
将数字转换为其等效的二进制补码十六进制表示形式。
to_hex(2147483647)
→ 7fffffff
to_hex(-1234)
→ fffffb2e
to_oct ( integer )
→ text
to_oct ( bigint )
→ text
将数字转换为其等效的二进制补码八进制表示形式。
to_oct(2147483647)
→ 17777777777
to_oct(-1234)
→ 37777775456
translate ( string text,
from text,
to text )
→ text
将string中与from集合中匹配的每个字符替换为to集合中相应的字符。
如果from长于to，from中出现的额外字符被删除。
translate('12345', '143', 'ax')
→ a2x5
unistr ( text )
→ text
计算参数中的转义Unicode字符。
Unicode字符可以被指定为\XXXX（4个十六进制数字）、\+XXXXXX（6个十六进制数字）、\uXXXX（4个十六进制数字）或\UXXXXXXXX（8个十六进制数字）。
要指定反斜杠，请写入两个反斜杠。
所有其他字符都是按字面意义的。
如果服务器编码不是UTF-8，由这些转义序列之一标识的Unicode编码点将被转换为实际的服务器编码；如果不可能，则会报告错误。
这个函数提供了一个（非标准的）替代到Unicode转义的字符串常量（参见第 4.1.2.3 节）。
unistr('d\0061t\+000061')
→ data
unistr('d\u0061t\U00000061')
→ data
concat、concat_ws和format函数是可变的，因此可以把要串接或格式化的值作为一个标记了VARIADIC关键字的数组进行传递（见第 36.5.6 节）。
数组的元素被当作函数的独立普通参数一样处理。如果可变数组参数为 NULL，concat和concat_ws返回 NULL，但format把 NULL 当作一个零元素数组。
还可以参阅第 9.21 节中的string_agg，以及表 9.13中的字符串和bytea类型之间转换的功能。
9.4.1. format #
函数format根据一个格式字符串产生格式化的输出，其形式类似于 C 函数sprintf。
format(formatstr text [, formatarg "any" [, ...] ])
formatstr 是一个格式字符串，指定结果的格式。格式字符串中的文本直接复制到结果中，除非使用了 格式说明符。格式说明符作为占位符，定义后续函数参数的格式和插入方式。每个 formatarg 参数根据其数据类型的常规输出规则转换为文本，然后根据格式说明符格式化并插入到结果字符串中。
格式说明符由一个%字符开始并且有这样的形式
%[position][flags][width]type
其中的各组件域是：
position（可选）
一个形式为n$的字符串，其中n是要打印的参数的索引。索引 1 表示formatstr之后的第一个参数。如果position被忽略，默认会使用序列中的下一个参数。
flags（可选）
控制格式说明符的输出如何被格式化的附加选项。当前唯一支持的标志是一个负号（-），它将导致格式说明符的输出会被左对齐。除非width域也被指定，否则这个域不会产生任何效果。
width（可选）
指定用于显示格式说明符输出的最小字符数。输出将被在左部或右部（取决于-标志）用空格填充以保证充满该宽度。太小的宽度设置不会导致输出被截断，但是会被简单地忽略。宽度可以使用下列形式之一指定：一个正整数；一个星号（*）表示使用下一个函数参数作为宽度；或者一个形式为*n$的字符串表示使用第n个函数参数作为宽度。
如果宽度来自于一个函数参数，则参数在被格式说明符的值使用之前就被消耗掉了。如果宽度参数是负值，结果会在长度为abs(width)的域中被左对齐（如果-标志被指定）。
type（必需）
格式转换的类型，用于产生格式说明符的输出。支持下面的类型：
s将参数值格式化为一个简单字符串。一个空值被视为一个空字符串。
I将参数值视作 SQL 标识符，并在必要时用双引号包围它。如果参数为空，将会是一个错误（等效于quote_ident）。
L将参数值引用为 SQL 文字。一个空值将被显示为不带引号的字符串NULL（等效于quote_nullable）。
除了以上所述的格式说明符之外，要输出一个文字形式的%字符，可以使用特殊序列%%。
下面有一些基本的格式转换的例子：
SELECT format('Hello %s', 'World');
结果：Hello World
SELECT format('Testing %s, %s, %s, %%', 'one', 'two', 'three');
结果：Testing one, two, three, %
SELECT format('INSERT INTO %I VALUES(%L)', 'Foo bar', E'O\'Reilly');
结果：INSERT INTO "Foo bar" VALUES('O''Reilly')
SELECT format('INSERT INTO %I VALUES(%L)', 'locations', 'C:\Program Files');
结果：INSERT INTO locations VALUES(E'C:\\Program Files')
下面是使用width字段和-标志的例子：
SELECT format('|%10s|', 'foo');
结果：|       foo|
SELECT format('|%-10s|', 'foo');
结果：|foo       |
SELECT format('|%*s|', 10, 'foo');
结果：|       foo|
SELECT format('|%*s|', -10, 'foo');
结果：|foo       |
SELECT format('|%-*s|', 10, 'foo');
结果：|foo       |
SELECT format('|%-*s|', -10, 'foo');
结果：|foo       |
这些例子展示了position字段的用法：
SELECT format('Testing %3$s, %2$s, %1$s', 'one', 'two', 'three');
结果：Testing three, two, one
SELECT format('|%*2$s|', 'foo', 10, 'bar');
结果：|       bar|
SELECT format('|%1$*2$s|', 'foo', 10, 'bar');
结果：|       foo|
不同于标准的 C 函数sprintf，PostgreSQL的format函数允许将带有或者不带有position字段的格式说明符混合在同一个格式字符串中。一个不带有position字段的格式说明符总是使用最后一个被消耗的参数的下一个参数。另外，format函数不要求所有函数参数都被用在格式字符串中。例如：
SELECT format('Testing %3$s, %2$s, %s', 'one', 'two', 'three');
结果：Testing three, two, three
对于安全地构造动态 SQL 语句，%I和%L格式说明符特别有用。参见例 41.1。
上一页 上一级 下一页9.3. 数学函数和运算符 起始页 9.5. 二进制字符串函数和操作符
