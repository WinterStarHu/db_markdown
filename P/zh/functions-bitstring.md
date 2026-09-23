# 9.6. 位串函数和操作符

9.6. 位串函数和操作符
版本：
纠错本页面
搜索
目录导航
❮
❯
9.6. 位串函数和操作符 #
本节描述用于检查和操作位串的函数和操作符，也就是操作类型为bit和bit varying的值的函数和操作符。
(虽然这些表中只提到了bit类型，但bit varying类型的值可以互换使用。)
位字符串支持表 9.1中显示的常用比较操作符，就像表 9.14中显示的操作符。
表 9.14. 位串操作符
操作符
描述
示例
bit || bit
→ bit
连接
B'10001' || B'011'
→ 10001011
bit & bit
→ bit
按位与（输入的长度必须相等）
B'10001' & B'01101'
→ 00001
bit | bit
→ bit
按位或（输入的长度必须相等）
B'10001' | B'01101'
→ 11101
bit # bit
→ bit
按位异或（输入的长度必须相等）
B'10001' # B'01101'
→ 11100
~ bit
→ bit
按位求反
~ B'10001'
→ 01110
bit << integer
→ bit
按位左移（字符串长度被保留）
B'10001' << 3
→ 01000
bit >> integer
→ bit
按位右移（字符串长度被保留）
B'10001' >> 2
→ 00100
一些可用于二进制字符串的函数也可用于位字符串，如表 9.15中所示。
表 9.15. 位字符串函数
函数
描述
示例
bit_count ( bit )
→ bigint
返回位字符串中设置的位数（也被称为“popcount”）。
bit_count(B'10111')
→ 4
bit_length ( bit )
→ integer
返回位字符串中的位数。
bit_length(B'10111')
→ 5
length ( bit )
→ integer
返回位字符串中的位数。
length(B'10111')
→ 5
octet_length ( bit )
→ integer
返回位字符串中的字节数。
octet_length(B'1011111011')
→ 2
overlay ( bits bit PLACING newsubstring bit FROM start integer [ FOR count integer ] )
→ bit
替换bits中从start位开始的子字符串，并将其扩展count位，
用newsubstring替换。如果省略count，则默认为newsubstring的长度。
overlay(B'01010101010101010' placing B'11111' from 2 for 3)
→ 0111110101010101010
position ( substring bit IN bits bit )
→ integer
返回指定substring在bits中的第一个起始索引，如果不存在则返回0。
position(B'010' in B'000001101011')
→ 8
substring ( bits bit [ FROM start integer ] [ FOR count integer ] )
→ bit
如果指定了start，则提取从start位开始的bits的子字符串；
如果指定了count，则在count位之后停止。start和count至少提供一个。
substring(B'110010111111' from 3 for 2)
→ 00
get_bit ( bits bit,
n integer )
→ integer
从位字符串中提取第n位；第一个（最左）位为第0位。
get_bit(B'101010101010101010', 6)
→ 1
set_bit ( bits bit,
n integer,
newvalue integer )
→ bit
将位字符串中的第n位设置为newvalue；第一个（最左）位是第0位。
set_bit(B'101010101010101010', 6, 0)
→ 101010001010101010
另外，我们可以在整数和bit之间来回转换。
将一个整数转换为bit(n)会复制最右边的n位。
将一个整数转换为比整数本身更宽的位字符串宽度将在左边进行符号扩展。一些例子：
44::bit(10)                    0000101100
44::bit(3)                     100
cast(-44 as bit(12))           111111010100
'1110'::bit(4)::integer        14
请注意，如果只是转换为“bit”，意思是转换成bit(1)，因此只会转换整数的最低有效位。
上一页 上一级 下一页9.5. 二进制字符串函数和操作符 起始页 9.7. 模式匹配
