# 9.5. 二进制字符串函数和操作符

9.5. 二进制字符串函数和操作符
版本：
纠错本页面
搜索
目录导航
❮
❯
9.5. 二进制字符串函数和操作符 #
本节描述那些检查和操作二进制字符串的函数和操作符，这是类型bytea的值。
其中许多函数在用途和语法上都与上一节中描述的文本字符串函数等效。
SQL定义了一些使用关键字而不是逗号来分割参数的字符串函数。详情请见表 9.11。PostgreSQL也提供了这些函数使用常规函数调用语法的版本（参阅表 9.12）。
表 9.11. SQL 二进制字符串函数和操作符
函数/操作符
描述
示例
bytea || bytea
→ bytea
连接两个二进制字符串。
'\x123456'::bytea || '\x789a00bcde'::bytea
→ \x123456789a00bcde
bit_length ( bytea )
→ integer
返回二进制字符串中的位数 (8 倍于 octet_length)。
bit_length('\x123456'::bytea)
→ 24
btrim ( bytes bytea,
bytesremoved bytea )
→ bytea
从 bytes 的开头和结尾移除仅包含
bytesremoved 中出现的字节的最长字符串。
btrim('\x1234567890'::bytea, '\x9012'::bytea)
→ \x345678
ltrim ( bytes bytea,
bytesremoved bytea )
→ bytea
从 bytes 的开头移除出现在 bytesremoved 中的只包含字节的最长字符串。
ltrim('\x1234567890'::bytea, '\x9012'::bytea)
→ \x34567890
octet_length ( bytea )
→ integer
返回二进制字符串中的字节数。
octet_length('\x123456'::bytea)
→ 3
overlay ( bytes bytea PLACING newsubstring bytea FROM start integer [ FOR count integer ] )
→ bytea
将 bytes 的子字符串替换为 newsubstring，该子字符串从 start 字节开始，并以 count 字节扩展。
如果忽略了 count，则默认为 newsubstring 的长度。
overlay('\x1234567890'::bytea placing '\002\003'::bytea from 2 for 3)
→ \x12020390
position ( substring bytea IN bytes bytea )
→ integer
返回bytes中指定的substring的第一个起始索引，如果不存在，则为零。
position('\x5678'::bytea in '\x1234567890'::bytea)
→ 3
rtrim ( bytes bytea,
bytesremoved bytea )
→ bytea
从bytes结尾移除出现在bytesremoved中的只包含字节的最长字符串。
rtrim('\x1234567890'::bytea, '\x9012'::bytea)
→ \x12345678
substring ( bytes bytea [ FROM start integer ] [ FOR count integer ] )
→ bytea
提取bytes从start字节开始的子字符串，如果指定了，并且在count字节之后停止，如果指定了的话。
至少提供start和count中的一个。
substring('\x1234567890'::bytea from 3 for 2)
→ \x5678
trim ( [ LEADING | TRAILING | BOTH ]
bytesremoved bytea FROM
bytes bytea )
→ bytea
删除bytesremoved中只包含字节的最长字符串，从bytes的开始、结束，或两端(BOTH 为默认的)。
trim('\x9012'::bytea from '\x1234567890'::bytea)
→ \x345678
trim ( [ LEADING | TRAILING | BOTH ] [ FROM ]
bytes bytea,
bytesremoved bytea )
→ bytea
这是trim()的非标准语法。
trim(both from '\x1234567890'::bytea, '\x9012'::bytea)
→ \x345678
还有一些二进制串处理函数可以使用，在表 9.12列出。 其中有一些是在内部使用，用于实现表 9.11列出的SQL标准串函数。
表 9.12. 其他二进制串函数
函数
描述
例子
bit_count ( bytes bytea )
→ bigint
返回二进制字符串中设置的位数（也被称为
“popcount”）。
bit_count('\x1234567890'::bytea)
→ 15
crc32 ( bytea )
→ bigint
计算二进制字符串的 CRC-32 值。
crc32('abc'::bytea)
→ 891568578
crc32c ( bytea )
→ bigint
计算二进制字符串的 CRC-32C 值。
crc32c('abc'::bytea)
→ 910901175
get_bit ( bytes bytea,
n bigint )
→ integer
从二进制字符串中提取 n'th 位。
get_bit('\x1234567890'::bytea, 30)
→ 1
get_byte ( bytes bytea,
n integer )
→ integer
从二进制字符串中提取 n'th 字节。
get_byte('\x1234567890'::bytea, 4)
→ 144
length ( bytea )
→ integer
返回二进制字符串中的字节数。
length('\x1234567890'::bytea)
→ 5
length ( bytes bytea,
encoding name )
→ integer
返回二进制字符串中的字符数，假设它是给定 encoding 中的文本。
length('jose'::bytea, 'UTF8')
→ 4
md5 ( bytea )
→ text
计算二进制字符串的 MD5 hash，结果以十六进制形式写入。
md5('Th\000omas'::bytea)
→ 8ab2d3c9689aaf18​b4958c334c82d8b1
reverse ( bytea )
→ bytea
反转二进制字符串中字节的顺序。
reverse('\xabcd'::bytea)
→ \xcdab
set_bit ( bytes bytea,
n bigint,
newvalue integer )
→ bytea
设置二进制字符串中的n'th位为newvalue。
set_bit('\x1234567890'::bytea, 30, 0)
→ \x1234563890
set_byte ( bytes bytea,
n integer,
newvalue integer )
→ bytea
设置二进制字符串中的 n'th 字节为 newvalue。
set_byte('\x1234567890'::bytea, 4, 64)
→ \x1234567840
sha224 ( bytea )
→ bytea
计算二进制字符串的 SHA-224 hash。
sha224('abc'::bytea)
→ \x23097d223405d8228642a477bda2​55b32aadbce4bda0b3f7e36c9da7
sha256 ( bytea )
→ bytea
计算二进制字符串的 SHA-256 hash。
sha256('abc'::bytea)
→ \xba7816bf8f01cfea414140de5dae2223​b00361a396177a9cb410ff61f20015ad
sha384 ( bytea )
→ bytea
计算二进制字符串的 SHA-384 hash。
sha384('abc'::bytea)
→ \xcb00753f45a35e8bb5a03d699ac65007​272c32ab0eded1631a8b605a43ff5bed​8086072ba1e7cc2358baeca134c825a7
sha512 ( bytea )
→ bytea
计算二进制字符串的 SHA-512 hash。
sha512('abc'::bytea)
→ \xddaf35a193617abacc417349ae204131​12e6fa4e89a97ea20a9eeee64b55d39a​2192992a274fc1a836ba3c23a3feebbd​454d4423643ce80e2a9ac94fa54ca49f
substr ( bytes bytea, start integer [, count integer ] )
→ bytea
从start字节开始提取bytes的子字符串，并扩展为count字节，如果这是指定的。
(与 substring(bytes 从 start 到 count) 相同.)
substr('\x1234567890'::bytea, 3, 2)
→ \x5678
函数get_byte和set_byte把一个二进制串中的一个字节计数为字节 0。
函数get_bit和set_bit在每一个字节中从右边起计数位；
例如位 0 是第一个字节的最低有效位，而位 15 是第二个字节的最高有效位。
由于历史原因，函数md5返回的是一个十六进制编码的text值，而SHA-2函数返回类型bytea。
可以使用函数encode和decode在两者之间转换。
例如encode(sha256('abc'),'hex')可以得到一个十六进制编码的文本表示，或者decode(md5('abc'), 'hex')得到一个bytea值。
用于在不同字符集(编码)之间转换字符串的函数，以及用于以文本形式表示任意二进制数据的函数，在表 9.13中显示。
对于这些函数，类型为text的参数或结果表示为数据库的默认编码，而类型为bytea的参数或结果表示为由另一个参数命名的编码。
表 9.13. Text/Binary String Conversion Functions
函数
描述
示例
convert ( bytes bytea,
src_encoding name,
dest_encoding name )
→ bytea
将表示编码src_encoding的文本的二进制字符串转换为编码dest_encoding的二进制字符串
(适用的转换请参阅第 23.3.4 节 )。
convert('text_in_utf8', 'UTF8', 'LATIN1')
→ \x746578745f696e5f75746638
convert_from ( bytes bytea,
src_encoding name )
→ text
将表示编码src_encoding的文本的二进制字符串转换为数据库编码中的text。
(适用的转换请参阅 第 23.3.4 节 )。
convert_from('text_in_utf8', 'UTF8')
→ text_in_utf8
convert_to ( string text,
dest_encoding name )
→ bytea
将text字符串(数据库编码)转换为编码dest_encoding中编码的二进制字符串。
(适用的转换请参阅 第 23.3.4 节 )。
convert_to('some_text', 'UTF8')
→ \x736f6d655f74657874
encode ( bytes bytea,
format text )
→ text
将二进制数据编码成文本表示；支持的format值为：
base64,
escape,
hex.
encode('123\000\001', 'base64')
→ MTIzAAE=
decode ( string text,
format text )
→ bytea
从文本表示中解码二进制数据；支持的format值与encode相同。
decode('MTIzAAE=', 'base64')
→ \x3132330001
encode和decode函数支持以下文本格式：
base64
#
base64格式是RFC
2045第6.8节中描述的。根据RFC，编码行在76个字符处换行。
然而，与MIME CRLF换行符不同，结尾只使用换行符。
decode函数会忽略回车、换行、空格和制表符。
否则，当decode提供无效的base64数据时，包括尾部填充不正确时，会引发错误。
escape
#
escape格式将零字节和高位设置的字节转换为八进制转义序列
(\nnn)，并将反斜杠加倍。
其他字节值会直接表示。如果反斜杠后面不是第二个反斜杠或三个八进制数字，则decode函数会引发错误；
它会接受其他字节值不变。
hex
#
hex格式将每4位数据表示为一个十六进制数字，0到f，
先写入每个字节的高阶数字。 encode函数以小写输出a-f十六进制数字。
因为数据的最小单位是8位，所以encode总是返回偶数个字符。
decode函数接受a-f字符的大小写。
当decode提供无效的十六进制数据时，包括提供奇数个字符时，会引发错误。
此外，可以将整数值转换为 bytea 类型，反之亦然。
将整数转换为 bytea 会生成 2、4 或 8 字节，具体取决于
整数类型的宽度。结果是整数的二进制补码表示，最高有效字节在前。
一些示例：
1234::smallint::bytea          \x04d2
cast(1234 as bytea)            \x000004d2
cast(-1234 as bytea)           \xfffffb2e
'\x8000'::bytea::smallint      -32768
'\x8000'::bytea::integer       32768
将 bytea 转换为整数时，如果 bytea 的长度超过
整数类型的宽度，将会引发错误。
参见第 9.21 节中的聚集函数string_agg以及第 33.4 节中的大对象函数。
上一页 上一级 下一页9.4. 字符串函数和操作符 起始页 9.6. 位串函数和操作符
